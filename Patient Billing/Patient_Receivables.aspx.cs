using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
//using PatientBilllingDataSet_Panel_PayableTableAdapters;
using Microsoft.Reporting.WebForms;

public partial class Patient_Billing_Patient_Receivables : System.Web.UI.Page
{
    Double Amount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            start_date.Value = DateTime.Now;
            end_date.Value = DateTime.Now;
        }
    }
    protected void SearchEmployee_Click(object sender, EventArgs e)
    {
        LabelTotal.Text = "0";
        Amount = 0;
        GridViewPatient.Visible = true;
        ReportViewer1.Visible = false;
        showGrid();

    }
    protected void Show_Click(object sender, EventArgs e)
    {

        GridViewPatient.Visible = false;
        ReportViewer1.Visible = true;
        showReport();
        
    }


    public void showReport()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "usp_Patient_Receivable";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@start_date", start_date.Value);
            cmd.Parameters.AddWithValue("@end_date", end_date.Value);
            cmd.Parameters.AddWithValue("@party_id", DropDownList_Parties.SelectedValue);
            cmd.Parameters.AddWithValue("@EmpID", DropDownList1.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            //Encryption enc = new Encryption();
            //dt.Columns["Prefix"].ReadOnly = false;
            //dt.Columns["PFName"].ReadOnly = false;
            //dt.Columns["PMName"].ReadOnly = false;
            //dt.Columns["PLName"].ReadOnly = false;
            //dt.Columns["RegNo"].ReadOnly = false;

            //foreach (DataRow row in dt.Rows)
            //{
            //    if (row["PFName"].ToString() != "")
            //    {
            //        row["PFName"] = enc.Encrypt_Main(row["PFName"].ToString(), false);
            //        row["Prefix"] = row["Prefix"].ToString() + " " + row["PFName"].ToString(); 
            //    }
            //    if (row["PMName"].ToString() != "")
            //    {
            //        row["PMName"] = enc.Encrypt_Main(row["PMName"].ToString(), false);
            //        row["Prefix"] = row["Prefix"].ToString() + " " + row["PMName"].ToString();
            //    }
            //    if (row["PLName"].ToString() != "")
            //    {
            //        row["PLName"] = enc.Encrypt_Main(row["PLName"].ToString(), false);
            //        row["Prefix"] = row["Prefix"].ToString() + " " + row["PLName"].ToString();
            //    }
            //    row["RegNo"] = enc.Encrypt_Main(row["RegNo"].ToString(), false);

            //}




            // PatientBilllingDataSet_Panel_Payable ds = new PatientBilllingDataSet_Panel_Payable();


            //usp_Panel_Company_PayableTableAdapter daa = new usp_Panel_Company_PayableTableAdapter();
            //daa.Fill(ds.usp_Panel_Company_Payable,Convert.ToDateTime(start_date.Value),Convert.ToDateTime(end_date.Value),1);
            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet_Panel_Payable";//coordinates in your case.
            reportDataSource.Value = dt;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Patient_Receivable_Report.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
           // ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh(); 

            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("Patient_Receivable_Report.rdlc");
            //ReportViewer1.LocalReport.DataSources.Clear();

            //ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            //ReportViewer1.LocalReport.Refresh();



        }
        catch (Exception ex)
        {
        }
    }


    public void ReportData()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "usp_Patient_ReceivableReport";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@start_date", start_date.Value);
            cmd.Parameters.AddWithValue("@end_date", end_date.Value);
            cmd.Parameters.AddWithValue("@party_id", DropDownList_Parties.SelectedValue);
            //cmd.Parameters.AddWithValue("@party_id", 1);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportDataSource reportDataSource = new ReportDataSource();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet_Panel_Payable";//coordinates in your case.
            reportDataSource.Value = dt;
            ReportViewer2.LocalReport.ReportPath = Server.MapPath("Patient_Receivable_Report2.rdlc");
            ReportViewer2.LocalReport.DataSources.Clear();

            ReportViewer2.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer2.LocalReport.Refresh();

            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer2.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }
        catch (Exception ex)
        {
        }

    }
        

    public void showGrid()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "usp_Patient_Receivable";
            cmd.CommandType = CommandType.StoredProcedure;
            string dt1 = Convert.ToDateTime(start_date.Value).ToString("yyyy-MM-dd");
            string dt2 = Convert.ToDateTime(end_date.Value).ToString("yyyy-MM-dd");
            cmd.Parameters.AddWithValue("@start_date", dt1);
            cmd.Parameters.AddWithValue("@end_date", dt2);
            cmd.Parameters.AddWithValue("@party_id", DropDownList_Parties.SelectedValue);
            cmd.Parameters.AddWithValue("@EmpID", DropDownList1.SelectedValue);
            //cmd.Parameters.AddWithValue("@party_id",1);         
            conn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            
            da.Fill(dt);

            conn.Close(); 
            GridViewPatient.DataSource = dt;

            GridViewPatient.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }
    protected void GridViewPatient_PreRender(object sender, EventArgs e)
    {
        Double totalAmount = 0;
        Coma coma = new Coma();
        Label lblAmount = new Label();
        CheckBox CHK = new CheckBox();
        DropDownList DDL_Parties = new DropDownList();
        LinkButton btnUpdate = new LinkButton();
        if (GridViewPatient.Rows.Count > 0)
        {
            foreach (GridViewRow row in GridViewPatient.Rows)
            {
                DDL_Parties = (DropDownList)row.FindControl("DDL_Parties");
                btnUpdate = (LinkButton)row.FindControl("btnUpdate");
                CHK = (CheckBox)row.FindControl("CHK_Pay");
                if (CHK.Visible == false)
                {
                    DDL_Parties.Visible = false;
                    btnUpdate.Visible = false;
                }
                else
                {
                    lblAmount = (Label)row.FindControl("LabelAmount");
                    totalAmount = totalAmount + Convert.ToDouble(lblAmount.Text.ToString());
                    lblAmount.Text = coma.place_Coma(lblAmount.Text);
                }
            }

            Label lblTotal = (Label)GridViewPatient.FooterRow.FindControl("footerAmount");
            lblTotal.Text = coma.place_Coma(totalAmount.ToString());

        }
    }
    protected void CHK_PayAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox Ck = (CheckBox)sender;
        CheckBox C = new CheckBox();
        Label lblAmount = new Label();
        Coma coma = new Coma();
        if (Ck.Checked == true)
        {
            foreach (GridViewRow row in GridViewPatient.Rows)
            {
                C = (CheckBox)row.FindControl("CHK_Pay");
                if (C.Visible == false)
                {
                }
                else
                {
                    C.Checked = Ck.Checked;
                    lblAmount = (Label)row.FindControl("LabelAmount");
                    Amount = Amount + Convert.ToDouble(lblAmount.Text.ToString());
                }
            }
            LabelTotal.Text = coma.place_Coma(Amount.ToString());
            LabelGtotal.Visible = true;
            LabelTotal.Visible = true;
            
        }
        else
        {
            foreach (GridViewRow row in GridViewPatient.Rows)
            {
                C = (CheckBox)row.FindControl("CHK_Pay");
                C.Checked = Ck.Checked;
            }
            LabelTotal.Text = "0";
            Amount = 0;
            LabelGtotal.Visible = false;
            LabelTotal.Visible = false;   
        }
    }

    protected void CHK_Pay_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox Ck = (CheckBox)sender;
        GridViewRow row = (GridViewRow)Ck.NamingContainer;
        CheckBox C = (CheckBox)row.FindControl("CHK_Pay");
       
        TextBox txtAmount = new TextBox();
        Coma coma = new Coma();
        Amount = Convert.ToDouble(coma.Remove_Coma(LabelTotal.Text));
        if (C.Checked == true)
        {
            txtAmount = (TextBox)row.FindControl("txtReceivedAmount");
            Amount = Amount + Convert.ToDouble(txtAmount.Text.ToString());
        }
        else
        {
            txtAmount = (TextBox)row.FindControl("txtReceivedAmount");
            Amount = Amount - Convert.ToDouble(txtAmount.Text.ToString());
        }
        LabelTotal.Text = coma.place_Coma(Amount.ToString());
        LabelGtotal.Visible = true;
        LabelTotal.Visible = true;
        
    }

    protected void Btn_Ad_rec_Click(object sender, EventArgs e)
    {
        Amount = 0;
        LabelTotal.Text = "0";
        if (GridViewPatient.Rows.Count > 0)
        {
            CheckBox C = new CheckBox();
            HiddenField SPM = new HiddenField();
            HiddenField cashBookid = new HiddenField();
            HiddenField regNo = new HiddenField();
            HiddenField yearlyNo = new HiddenField();
            TextBox recAmount = new TextBox();
            foreach (GridViewRow row in GridViewPatient.Rows)
            {
                C = (CheckBox)row.FindControl("CHK_Pay");
                recAmount = (TextBox)row.FindControl("txtReceivedAmount");
                Label totalRec = (row.FindControl("LabelAmount") as Label);
                Label alreadyRec = (row.FindControl("lblAlreadyReceived") as Label);
                if(String.IsNullOrEmpty(recAmount.Text.Trim()))
                {
                    recAmount.Text="0";
                }
                if (C.Checked && Convert.ToDouble(recAmount.Text) > 0 && (Convert.ToDouble(recAmount.Text) <= (Convert.ToDouble(totalRec.Text) - Convert.ToDouble(alreadyRec.Text))))
                {
                    SPM = (HiddenField)row.FindControl("HFD_Spm_ID");
                    cashBookid = (HiddenField)row.FindControl("hdfCashBook_ID");
                    regNo = (HiddenField)row.FindControl("HiddenFieldRegNo");
                    yearlyNo = (HiddenField)row.FindControl("HiddenFieldYearlyNo");
                    Recieved_P(SPM.Value, cashBookid.Value, regNo.Value, yearlyNo.Value,Convert.ToDouble(recAmount.Text.Trim().Replace(",","")));
                }
            }
        }
        ReportData();
        showGrid();
       
    }

    public void Recieved_P(string Spm_ID,string cashbookid,string regNo,string yearlyNo,double recAmount)
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("uspInsertPatientReceiveable", conn);
            cmd.Connection = conn;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SPM_ID", Spm_ID);
            cmd.Parameters.AddWithValue("@Enter_By", Session["emp_id"].ToString());
            cmd.Parameters.AddWithValue("@Entry_Time", DateTime.Now);
            cmd.Parameters.AddWithValue("@CashBook_ID", cashbookid);
            cmd.Parameters.AddWithValue("@RegNo", regNo);
            cmd.Parameters.AddWithValue("@YearlyNo", yearlyNo);
            cmd.Parameters.AddWithValue("@ReceivedAmount", recAmount);
            cmd.Parameters.AddWithValue("@Dept_Id", Session["Dept_id"]);
            cmd.Parameters.AddWithValue("@SubDept_Id", Session["SubDeptID"]);
            cmd.Parameters.AddWithValue("@Shift", Session["ShiftId"]);

            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();


        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }
    protected void GridViewPatient_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Bind Care Of Doctor Dropdown
            DropDownList DDL_Parties = (e.Row.FindControl("DDL_Parties") as DropDownList);
            Label lblParty_ID = (e.Row.FindControl("lblParty_ID") as Label);
            Label totalRec = (e.Row.FindControl("LabelAmount") as Label);
            Label alreadyRec = (e.Row.FindControl("lblAlreadyReceived") as Label);
            TextBox nowReceived = (e.Row.FindControl("txtReceivedAmount") as TextBox);
            DDL_Parties.DataSource = GetData("select Party_Id,Party_Name from Parties where Party_Type_Id=3");
            DDL_Parties.DataTextField = "Party_Name";
            DDL_Parties.DataValueField = "Party_Id";
            DDL_Parties.DataBind();
            DDL_Parties.SelectedValue = lblParty_ID.Text;
            nowReceived.Attributes.Add("onkeyup", "CheckQuantityLimit('" + (Convert.ToDouble(totalRec.Text) - Convert.ToDouble(alreadyRec.Text)) + "','" + nowReceived.ClientID + "')");
        }
    }

    private DataSet GetData(string query)
    {
        string conString = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand(query);
        using (SqlConnection con = new SqlConnection(conString))
        {
            using (SqlDataAdapter sda = new SqlDataAdapter())
            {
                cmd.Connection = con;
                sda.SelectCommand = cmd;
                using (DataSet ds = new DataSet())
                {
                    sda.Fill(ds);
                    return ds;
                }
            }
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        LinkButton btnUpdate = sender as LinkButton;
        GridViewRow r = (GridViewRow)btnUpdate.NamingContainer;
        DropDownList DDL_Parties = (DropDownList)r.FindControl("DDL_Parties");
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection conn = new SqlConnection(conString);
        try
        {
            conn.Open();
            SqlCommand sc = new SqlCommand(@"Update Service_Payment_Main SET PartyId=@PartyID
			                                 WHERE SPM_ID=@SPMID", conn);
            sc.Parameters.AddWithValue("@SPMID", btnUpdate.ToolTip);
            sc.Parameters.AddWithValue("@PartyID", DDL_Parties.SelectedValue);
            sc.ExecuteNonQuery();
        }
        catch (Exception)
        {
        }
        finally
        {
            conn.Close();
        }
    }
    protected void btnRegNo_Click(object sender, System.EventArgs e)
    {
        LinkButton btnRegNo = sender as LinkButton; 
        GridViewRow row=(GridViewRow)btnRegNo.NamingContainer;
        HiddenField YearlyNo = (HiddenField)row.FindControl("HiddenFieldYearlyNo");
        HiddenField RegNo = (HiddenField)row.FindControl("HiddenFieldRegNo");
        Session["YearlyNo"] = YearlyNo.Value;
        Session["RegistrationNo"] = RegNo.Value;
        Response.Redirect("~/Patient Billing/patientServices.aspx?SPMID=" + btnRegNo.CommandArgument + "&db=1");
    }

    protected void txtReceivedAmount_TextChanged(object sender, EventArgs e)
    {
        //TextBox txtAmount = (TextBox)sender;

        //GridViewRow row = (GridViewRow)txtAmount.NamingContainer;
        //CheckBox C = (CheckBox)row.FindControl("CHK_Pay");

       
        //Coma coma = new Coma();
        //Amount = Convert.ToDouble(coma.Remove_Coma(LabelTotal.Text));
        //if (C.Checked == true)
        //{
        //    txtAmount = (TextBox)row.FindControl("txtReceivedAmount");
        //    Amount = Amount + Convert.ToDouble(txtAmount.Text.ToString());
        //}
        //else
        //{
        //    txtAmount = (TextBox)row.FindControl("txtReceivedAmount");
        //    Amount = Amount - Convert.ToDouble(txtAmount.Text.ToString());
        //}
        //LabelTotal.Text = coma.place_Coma(Amount.ToString());
        //LabelGtotal.Visible = true;
        //LabelTotal.Visible = true;
    }
}