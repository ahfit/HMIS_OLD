using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
public partial class Duty_Rouster_Duty_Rouster_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
        if (!Page.IsPostBack)
        {
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

        DbManager dbMgr = new DbManager();
        SqlParameter[] para = {
	new SqlParameter("stDate", Request.QueryString["SDate"]),
	new SqlParameter("edDate", Request.QueryString["EDate"]),
	new SqlParameter("deptid", Request.QueryString["Dept"])
    ,new SqlParameter("subdeptid", Request.QueryString["SubDept"])
        ,new SqlParameter("empid", Request.QueryString["EmpId"])
        ,new SqlParameter("empdep", Request.QueryString["empdep"])
};
        DataSet ds = dbMgr.ExecuteDataSet("sp_SearchDuties1", "Basic_Data_ConnectionString", para);


        ReportViewer1.LocalReport.DataSources.Clear();
        string reportPath = Server.MapPath("~/Duty_Rouster/Duty_Rouster_Report.rdlc");
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables[0]));
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables[1]));
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();

    }
}
