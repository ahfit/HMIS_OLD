using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class PharmacyItems_UpdateLog_Report: System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void btnReport_Click(object sender, EventArgs e)
    {
        ShowReport();
    }

    protected void ShowReport()
    {
        SqlConnection conn = new SqlConnection(conStr);
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParam = { new SqlParameter("@SDate", txtStartDate.Text),
                                        new SqlParameter("@EDate", txtEndDate.Text)};
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("usp_GetItemsUpdate_Log", "STOREConnectionString", sqlParam);
            ReportParameter[] repParams = new ReportParameter[2];
            string path = Server.MapPath("PharmacyItems_UpdateLog_Report.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            repParams[0] = new ReportParameter("Start_Date", txtStartDate.Text);
            repParams[1] = new ReportParameter("End_Date", txtEndDate.Text);
            ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch
        { }
        finally
        {

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