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

public partial class Patient_Billing_DoctorWiseWisePatientDetail : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["PatientBillingConnectionString"].ConnectionString;
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            //txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
            LoadReport();
        }
    }
    
    protected void LoadReport()
    {
        SqlConnection con = new SqlConnection(RegconString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_getDoctorWisePatientDetail", con);
            cmd.CommandType = CommandType.StoredProcedure;
            string DNAme = Request.QueryString["DoctorName"];
            cmd.Parameters.AddWithValue("@DoctorName", DNAme);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/Patient Billing/DoctorWisePatientDetail.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {


        }
        finally
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