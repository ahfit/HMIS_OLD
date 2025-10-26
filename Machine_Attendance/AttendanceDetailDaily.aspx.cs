using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Machine_Attendance_AttendanceDetailDaily : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DDL_Company.DataBind();
            GetSubDept();
            GetEmpBySubDept();
            WebDateChooser_Date.Value = DateTime.Now;
            ToDate.Value = DateTime.Now;
        }
    }
    private void ShowReport()
    {
        SqlCommand cmd = default(SqlCommand);
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspEmployeeAttendanceSummary", con);
            cmd.CommandType = CommandType.StoredProcedure;

            string dateFrom = Convert.ToDateTime(WebDateChooser_Date.Value).ToString("yyyy/MM/dd");
            string dateTo2 = Convert.ToDateTime(ToDate.Value).ToString("yyyy/MM/dd");


            cmd.Parameters.AddWithValue("@DateFrom", dateFrom);
            cmd.Parameters.AddWithValue("@DateTo", dateTo2);
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue);
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue);                     
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("AttendanceDetailDaily.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            //ReportParameter[] repParams = new ReportParameter[4];
            //repParams[0] = new ReportParameter("Hospital_Name", DDL_Company.SelectedItem.ToString());
            //repParams[1] = new ReportParameter("DeptName", DDL_Branch.SelectedItem.ToString());
            //repParams[2] = new ReportParameter("FromDate", HiddenField_Start_Date.Value.ToString());
            //repParams[3] = new ReportParameter("ToDate", HiddenField_end_Date.Value.ToString());
            ReportDataSource repDs = new ReportDataSource();
            //ReportViewer1.LocalReport.SetParameters(repParams);
            repDs.Name = "DataSet1";
            repDs.Value = dt;
            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }

            else
                ReportViewer1.Visible = true;
            con.Close();
        }
        catch (Exception ex)
        {
            con.Close();
        }

    }
    protected void GetSubDept()
    {
        DbManager objManager = new DbManager();
        SqlParameter[] sqlParams = new[] {
        new SqlParameter("@HospitalId", DDL_Company.SelectedValue),
        new SqlParameter("@EmpId", Session["Emp_ID"])
    };
        DDL_Branch.DataSource = objManager.ExecuteDataTable("GetEmployeeReportingAuthorityDept", "DutyRoaster", sqlParams);
        DDL_Branch.DataBind();
        DDL_Branch.Items.Insert(0, new ListItem("All", "0"));
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
    protected void GetEmpBySubDept()
    {
        DbManager objManager = new DbManager();
        SqlParameter[] sqlParams = new[] {
        new SqlParameter("@SubDeptId", DDL_Branch.SelectedValue)
    };
        DDL_Sold_By.DataSource = objManager.ExecuteDataTable("GetemployeeBySubDept", "Basic_Data_ConnectionString", sqlParams);
        DDL_Sold_By.DataBind();
        DDL_Sold_By.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void btn_Report_Click(object sender, EventArgs e)
    {
        ShowReport();
    }

    protected void DDL_Branch_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEmpBySubDept();
    }
}