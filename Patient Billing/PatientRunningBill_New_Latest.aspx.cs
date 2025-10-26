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

public partial class Patient_Billing_PatientRunningBill_New_Latest : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["RegNo"] != null && Request.QueryString["YearlyNo"] != null)
            {
                ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
                LoadReport();
            }
        }
    }
    protected void LoadReport()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            //first data set code
            cmd = new SqlCommand("Patient_Data", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RegNo", Request.QueryString["RegNo"]);
            cmd.Parameters.AddWithValue("@Yearly_No", Request.QueryString["YearlyNo"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt1 = new DataTable();
            da.Fill(dt1);


            //second data set code

            cmd = new SqlCommand("PatientBill_DoctorServices_Running", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RegNo", Request.QueryString["RegNo"]);
            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
            da = new SqlDataAdapter(cmd);
            DataTable dt2 = new DataTable();
            da.Fill(dt2);

            cmd = new SqlCommand("usp_PatientAllAdvances", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
            da = new SqlDataAdapter(cmd);
            DataTable dt3 = new DataTable();
            da.Fill(dt3);



            cmd = new SqlCommand("PatientBill_RefundAmount_Running", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
            da = new SqlDataAdapter(cmd);
            DataTable dt4 = new DataTable();
            da.Fill(dt4);


            string reportPath = Server.MapPath("PatientRunningBill_New_Latest.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt1));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt2));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", dt3));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_RefundAmount", dt4));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

            //else
            //{
            ReportViewer1.Visible = true;
            //}

        }
        catch (Exception ex)
        {

            con.Close();
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
}