using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.IO;
using System.Text;
using System.Net;
using System.Net.Mail;
//using iTextSharp.text;
//using iTextSharp.text.pdf;
//using iTextSharp.text.html.simpleparser;


public partial class Payroll_EmailEmployeeSalarySlips : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    string _conString = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dropdownlist_Hospital.DataBind();
            DDL_Dept.DataBind();
            DDL_Emp.DataBind();
            GETEMAILDATATABLE();
            for (int count = 2010; count <= DateTime.Now.Year + 10; count++)
            {
                ddlYear.Items.Add(count.ToString());
            }


            DDL_Dept.DataBind();            
            ddlYear.DataBind();
            DDL_Emp.DataBind();
         
            ddlYear.SelectedValue = Convert.ToString(DateTime.Now.Year);
            ddlMonth.SelectedValue = Convert.ToString(DateTime.Now.Month);
        }




    }

    private void GETEMAILDATATABLE()
    {
        //try
        //{
        //    DataTable dummy = new DataTable();
        //    dummy.Columns.Add("EmployeeName");
        //    dummy.Columns.Add("SubDept_Name");
        //    dummy.Columns.Add("Designation_Name");
        //    dummy.Columns.Add("salary");
        //    dummy.Columns.Add("salarymonth");
        //    //dummy.Columns.Add("");
        //    //dummy.Columns.Add("");
        //    dummy.Rows.Add();

        //    SendPDFEmail(dummy);
        //}
        //catch (Exception ex)
        //{

        //    Response.Write(ex.Message);
        //}
    }

    protected void btn_Report_Click(object sender, EventArgs e)
    {
        showreport();



    }
    
    private void HideandShow()
    {
        
        ReportViewer1.Visible = false;
    }



    private void showreport()
    {
        lblMessage.Text = "";
        SqlConnection con = new SqlConnection(_conString);
        try
        {  con.Open();
            SqlCommand cmd = new SqlCommand("EmailEmployeeSalarySlips", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Hospital_Id", dropdownlist_Hospital.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept_Id", DDL_Dept.SelectedValue);
            cmd.Parameters.AddWithValue("@Emp_ID", DDL_Emp.SelectedValue);
            cmd.Parameters.AddWithValue("@SalaryMonth", ddlMonth.SelectedValue);
            cmd.Parameters.AddWithValue("@SalaryYear", ddlYear.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            da.Fill(ds);
            grdvemplyslaryslps.DataSource = ds;
            grdvemplyslaryslps.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
        }

    }

  
    protected void DDL_Dept_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Emp.DataBind();
    }
    protected void dropdownlist_Hospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Dept.DataBind();
    }

    private int counter = 0;
    protected void btnsendmail_Click(object sender, EventArgs e)
    {
        saveReport();
        sendEmail();
        if (counter > 0)
        {
            lblMessage.Text = "Salary Slips Emailed Successfully........";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        
    }


    private void saveReport()
    {
         Session.Add("month", ddlMonth.SelectedValue);
        Session.Add("year", ddlYear.SelectedValue);
        foreach (GridViewRow dgr in grdvemplyslaryslps.Rows)
        {
            CheckBox chkSelect = (CheckBox)dgr.FindControl("chkSelect");

            if (chkSelect.Checked == true)
            {
                HiddenField HfEmailAddress = (HiddenField)dgr.FindControl("HfEmailAddress");
                HiddenField HfReportAddress = (HiddenField)dgr.FindControl("HfReportName");
                HiddenField HfMonth = (HiddenField)dgr.FindControl("HfMonth");
                HiddenField HfYear = (HiddenField)dgr.FindControl("HfYear");
                HiddenField HfEmpId = (HiddenField)dgr.FindControl("HfEmpId");




                Salary_report ds = new Salary_report();

                Salary_reportTableAdapters.pro_select_emp_salaryTableAdapter da = new Salary_reportTableAdapters.pro_select_emp_salaryTableAdapter();
                Salary_reportTableAdapters.Loan_DetailTableAdapter da_loan = new Salary_reportTableAdapters.Loan_DetailTableAdapter();
                ds.Tables["Loan_Detail"].Clear();
                ds.Tables["pro_select_emp_salary"].Clear();
              
                //da.Fill(ds.Tables["pro_select_emp_salary"], "%", "%", HfEmpId.Value.ToString(), Session["month"].ToString(), Session["year"].ToString());


                //da.Fill(ds.Tables["pro_select_emp_salary"], "%", "%", Session["emp_id"], Session["month"], Session["year"]);
                //da.Fill(ds.Tables["pro_select_emp_salary"], "%", "%", HfEmpId.Value.ToString(), Session["month"].ToString(), Session["year"].ToString());

                //da_loan.Fill(ds.Tables["Loan_Detail"]);

           
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/PayRoll/Single_Salary_Rpt.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            repDs.Name = "DataSet1";
            //repDs.Value = ds.Tables["pro_select_emp_salary"];
            repDs.Value = getEmployeeSalaryData(Convert.ToInt32(HfEmpId.Value));
            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportDataSource repDs2 = new ReportDataSource();
            repDs2.Name = "DataSet2";
            repDs2.Value = ds.Tables["Loan_Detail"];
            ReportDataSource repDs3 = new ReportDataSource();
            repDs3.Name = "DataSet3";
            repDs3.Value = getSalaryDetail(Convert.ToInt32(HfEmpId.Value));

           


            ReportViewer1.LocalReport.DataSources.Add(repDs2);
            ReportViewer1.LocalReport.DataSources.Add(repDs3);

            ReportViewer1.LocalReport.DisplayName=HfReportAddress.Value;

            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            //Response.Write(HttpContext.Current.Server.MapPath("~/Payroll/Payslips"));
            string savePath = HttpContext.Current.Server.MapPath("~/Payroll/Payslips");
            byte[] Bytes = ReportViewer1.LocalReport.Render(format: "PDF", deviceInfo: "");

            using (FileStream stream = new FileStream(savePath + "\\" + HfReportAddress.Value + ".pdf", FileMode.Create))
            {
                stream.Write(Bytes, 0, Bytes.Length);
            }  
            }
        }
     
    }

    private void sendEmail()
    {
        counter = 0;
        foreach (GridViewRow dgr in grdvemplyslaryslps.Rows)
        {
            CheckBox chkSelect = (CheckBox)dgr.FindControl("chkSelect");

            if (chkSelect.Checked == true)
            {
                HiddenField HfEmailAddress = (HiddenField)dgr.FindControl("HfEmailAddress");
                HiddenField HfReportAddress = (HiddenField)dgr.FindControl("HfReportName");
                Response.Write(HfEmailAddress.Value);
                string emailSender = ConfigurationManager.AppSettings["username"].ToString();
                string emailSenderPassword = ConfigurationManager.AppSettings["password"].ToString();
                string emailSenderHost = ConfigurationManager.AppSettings["smtp"].ToString();
                int emailSenderPort = Convert.ToInt16(ConfigurationManager.AppSettings["portnumber"]);
                bool emailIsSSL = Convert.ToBoolean(ConfigurationManager.AppSettings["IsSSL"]);
                MailMessage mail = new MailMessage();
                SmtpClient SmtpServer = new SmtpClient("smtp.gmail.com");
                mail.From = new MailAddress(emailSender);
                mail.To.Add(HfEmailAddress.Value);

                //HfEmailAddress.Value = reader("email_Address").ToString();
                //HfReportAddress.Value = reader("Report_name").ToString();
                string CreateName = HfReportAddress.Value + ".pdf";
                //Response.Write(CreateName);
                string subject = "Salary Slip";
                mail.Subject = subject;


                string savePath = HttpContext.Current.Server.MapPath("~/Payroll/Payslips") + "\\" + CreateName;
                //mail.Attachments.Add(new Attachment(@"E:\HMIS (02-07-19)\App\Payroll\PaySlips\" + CreateName));
                //Response.Write(savePath);
                mail.Attachments.Add(new Attachment(savePath));
                SmtpServer.Port = 587;
                SmtpServer.Credentials = new NetworkCredential(emailSender, emailSenderPassword);
                SmtpServer.EnableSsl = true;

               SmtpServer.Send(mail);
               counter++;
            }
        }
    }
    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }
    }

    private DataTable getSalaryDetail(int EmpId)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_conString))
        {
            using (SqlCommand cmd = new SqlCommand("UspGetEmployeeSalaryDetail", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Emp_ID", EmpId);
                cmd.Parameters.AddWithValue("@month", Session["month"]);
            cmd.Parameters.AddWithValue("@year", Session["year"]);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }

    private DataTable getEmployeeSalaryData(int EmpId)
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_conString))
        {
            using (SqlCommand cmd = new SqlCommand("pro_select_emp_salary_Slip", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dept_ID", "%");
                cmd.Parameters.AddWithValue("@Designation_ID", "%");
                cmd.Parameters.AddWithValue("@Emp_ID", EmpId);
                cmd.Parameters.AddWithValue("@month", Session["month"]);
                cmd.Parameters.AddWithValue("@year", Session["year"]);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        return dt;
    }
    private void SendPDFEmail(DataTable dt)
    {
        //using (StringWriter sw = new StringWriter())
        //{
        //    using (HtmlTextWriter hw = new HtmlTextWriter(sw))
        //    {
        //        string companyName = "ASPSnippets";
        //        int orderNo = 2303;
        //        StringBuilder sb = new StringBuilder();
        //        sb.Append("<table width='100%' cellspacing='0' cellpadding='2'>");
        //        sb.Append("<tr><td align='center' style='background-color: #18B5F0' colspan = '2'><b>Order Sheet</b></td></tr>");
        //        sb.Append("<tr><td colspan = '2'></td></tr>");
        //        sb.Append("<tr><td><b>Order No:</b>");
        //        sb.Append(orderNo);
        //        sb.Append("</td><td><b>Date: </b>");
        //        sb.Append(DateTime.Now);
        //        sb.Append(" </td></tr>");
        //        sb.Append("<tr><td colspan = '2'><b>Company Name :</b> ");
        //        sb.Append(companyName);
        //        sb.Append("</td></tr>");
        //        sb.Append("</table>");
        //        sb.Append("<br />");
        //        sb.Append("<table border = '1'>");
        //        sb.Append("<tr>");
        //        foreach (DataColumn column in dt.Columns)
        //        {
        //            sb.Append("<th style = 'background-color: #D20B0C;color:#ffffff'>");
        //            sb.Append(column.ColumnName);
        //            sb.Append("</th>");
        //        }
        //        sb.Append("</tr>");
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            sb.Append("<tr>");
        //            foreach (DataColumn column in dt.Columns)
        //            {
        //                sb.Append("<td>");
        //                sb.Append(row[column]);
        //                sb.Append("</td>");
        //            }
        //            sb.Append("</tr>");
        //        }
        //        sb.Append("</table>");
        //        StringReader sr = new StringReader(sb.ToString());

        //        Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
        //        HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
        //        using (MemoryStream memoryStream = new MemoryStream())
        //        {
        //            PdfWriter writer = PdfWriter.GetInstance(pdfDoc, memoryStream);
        //            pdfDoc.Open();
        //            htmlparser.Parse(sr);
        //            pdfDoc.Close();
        //            byte[] bytes = memoryStream.ToArray();
        //            memoryStream.Close();

        //            MailMessage mm = new MailMessage("noumantariq377@gmail.com", "noumantariq377@gmail.com");
        //            mm.Subject = "Employee Salary Slip";
        //            mm.Body = "iTextSharp PDF Attachment";
        //            mm.Attachments.Add(new Attachment(new MemoryStream(bytes), "EmployeeSalarySlip.pdf"));
        //            mm.IsBodyHtml = true;
        //            SmtpClient smtp = new SmtpClient();
        //            smtp.Host = "smtp.gmail.com";
        //            smtp.EnableSsl = true;
        //            NetworkCredential NetworkCred = new NetworkCredential();
        //            NetworkCred.UserName = "noumantariq564@gmail.com";
        //            NetworkCred.Password = "<noumanayan34>";
        //            smtp.UseDefaultCredentials = true;
        //            smtp.Credentials = NetworkCred;
        //            smtp.Port = 587;
        //            smtp.Send(mm);
        //        }
        //    }
        //}
    }
}