using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class DashBoards_ServicesStrengthActivity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        if (!Page.IsPostBack)
        {
            wdcStartDate.Text = DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd");
            wdcEndDate.Value = DateTime.Now;
            ShowReport();
           
           
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        ShowReport();
    }
    protected void ShowReport()
    {
        sdsPatientCount.SelectParameters["Start_Date"].DefaultValue = wdcStartDate.Text;
            sdsPatientCount.SelectParameters["End_Date"].DefaultValue = wdcEndDate.Value.ToString();
           
            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;

            DateTime startDate = Convert.ToDateTime(wdcStartDate.Text);
            DateTime EndDate = Convert.ToDateTime(wdcEndDate.Value);
            ReportParameter[] para = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };


            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/ServicesStrengthActivity_Report.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.SetParameters(para);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            ReportViewer1.LocalReport.Refresh();
     }
   }