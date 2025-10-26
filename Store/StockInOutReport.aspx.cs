using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Store_StockInOutReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            ddlSubDepartment.DataBind();
            ddlSubDepartment.SelectedValue = Session["SubDeptid"].ToString();
            wdc_StartDate.Value = DateTime.Now.AddDays(-7);
            wdc_EndDate.Value = DateTime.Now;
            ViewReport();
        }

    }
    private void ViewReport()
    {
        sdsReportData.SelectParameters["startDate"].DefaultValue = wdc_StartDate.Value.ToString();
        sdsReportData.SelectParameters["endDate"].DefaultValue = wdc_EndDate.Value.ToString();
        DataView dv = sdsReportData.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dt = dv.Table;
        ReportViewer1.LocalReport.DataSources.Clear();
        string reportPath = Server.MapPath("~/Store/StockInOutReport.rdlc");
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        ReportViewer1.LocalReport.Refresh();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ViewReport();
    }
}