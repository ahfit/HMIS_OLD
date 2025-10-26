using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Patient_Billing_RefundDetailsReport : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            startDateChooser.Value = DateTime.Now.AddDays(-1);
            HiddenField_StartDate.Value = startDateChooser.Value.ToString();
            endDateChooser.Value = DateTime.Now;
            HiddenField_EndDate.Value = endDateChooser.Value.ToString();

            LoadReport();

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
    protected void LoadReport()
    {
        
            SqlCommand cmd;
            SqlConnection con = new SqlConnection();
            try
            {
                HiddenField_StartDate.Value = startDateChooser.Value.ToString();
               
                HiddenField_EndDate.Value = endDateChooser.Value.ToString();

                con = new SqlConnection(conString);

                cmd = new SqlCommand("PatientRefundDetialsReportOverall", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
                cmd.Parameters.AddWithValue("@YearlyNo", txtYearlyNo.Text.Trim());
                cmd.Parameters.AddWithValue("@FromDate", HiddenField_StartDate.Value);
                cmd.Parameters.AddWithValue("@EndDate", HiddenField_EndDate.Value);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                con.Open();
                da.Fill(dt);
                con.Close();
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DataSet1";
                rds.Value = dt;
                ReportViewer1.LocalReport.DataSources.Clear();

                string reportPath = Server.MapPath("~/Patient Billing/RefundDetailsReport.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;
                ReportViewer1.LocalReport.DataSources.Add(rds);


                ReportParameter rp = new ReportParameter("FromDate", HiddenField_StartDate.Value.ToString());
                ReportParameter rp2 = new ReportParameter("EndDate", HiddenField_EndDate.Value.ToString());
               
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
                
                ReportViewer1.LocalReport.Refresh();

            }
            catch (Exception ex)
            {


            }
        }

    protected void Btn_Search_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
}

