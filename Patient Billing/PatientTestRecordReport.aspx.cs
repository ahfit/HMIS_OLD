using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Patient_Billing_PatientCounterWiseDiscount : System.Web.UI.Page
{
    string BasicString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           
            startDateChooser.Value = DateTime.Now.AddDays(-7);
            endDateChooser.Value = DateTime.Now;
          
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
        SqlConnection con = new SqlConnection(BasicString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("GetAllPatientTestRecordDateWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@fromDate", startDateChooser.Value.ToString());
            cmd.Parameters.AddWithValue("@toDate", endDateChooser.Value.ToString());

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/Patient Billing/PatientTestRecordReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(rds);


            ReportParameter rp = new ReportParameter("ReportParameter1", startDateChooser.Value.ToString());
            ReportParameter rp2 = new ReportParameter("ReportParameter2", endDateChooser.Value.ToString());
       
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
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
    protected void btnReport_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
  
}