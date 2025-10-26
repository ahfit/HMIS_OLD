using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class DashBoards_IPDServicesSummary : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!Page.IsPostBack)
        {
           
     
            WebDateChooser_SDate.Value = DateTime.Now.AddDays(-3).Date;
            WebDateChooser_EndDate.Value = DateTime.Now;
            
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



    protected void ShowReport()
    {

        //if (string.IsNullOrEmpty(txtRegno.Text.Trim()))
        //{
        //    txtRegno.Text = "%";
        //}


        conn.Open();

        SqlCommand cmd = new SqlCommand("usp_getIPDServicesSummary", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@startDate", WebDateChooser_SDate.Value);
        cmd.Parameters.AddWithValue("@endDate", WebDateChooser_EndDate.Value);
        cmd.Parameters.AddWithValue("@RegNo", txtRegno.Text);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();


        da.Fill(ds);


        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];

        DateTime startDate = Convert.ToDateTime(WebDateChooser_SDate.Value);
        DateTime EndDate = Convert.ToDateTime(WebDateChooser_EndDate.Value);
        ReportParameter[] para = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };


        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("IPDServicesSummary.rdlc");
        ReportViewer1.LocalReport.SetParameters(para);
        ReportViewer1.LocalReport.DataSources.Add(rds);

        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

      

        ReportViewer1.LocalReport.Refresh();
        conn.Close();


    }

   
    protected void btn_Report_Click(object sender, EventArgs e)
    {
        ShowReport();

    }
}