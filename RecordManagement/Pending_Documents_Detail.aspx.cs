using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;

public partial class RecordManagement_Pending_Documents_Detail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_DateFrom.Value = DateTime.Now.AddMonths(-1);
            WebDateChooser_DateTo.Value = DateTime.Now;
            LoadData();
        }
    }
    protected void btnGrid_Click(object sender, EventArgs e)
    {
        LoadData();
    }
    protected void LoadData()
    {
        ReportViewer1.Visible = false;        
        GridView1.Visible = true;
        Sql_PendingDocumentDetail.SelectParameters["EmpID"].DefaultValue = ddlEmployeeName.SelectedValue;
        Sql_PendingDocumentDetail.SelectParameters["SubDeptId"].DefaultValue = ddlSubDeptName.SelectedValue;
        Sql_PendingDocumentDetail.SelectParameters["StartDate"].DefaultValue = WebDateChooser_DateFrom.Value.ToString();
        Sql_PendingDocumentDetail.SelectParameters["EndDate"].DefaultValue = WebDateChooser_DateTo.Value.ToString();
        GridView1.DataBind();
    }
    protected void LoadReport()
    {
        GridView1.Visible = false;
        ReportViewer1.Visible = true;
        Sql_PendingDocumentDetail.SelectParameters["EmpID"].DefaultValue = ddlEmployeeName.SelectedValue;
        Sql_PendingDocumentDetail.SelectParameters["SubDeptId"].DefaultValue = ddlSubDeptName.SelectedValue;
        Sql_PendingDocumentDetail.SelectParameters["StartDate"].DefaultValue = WebDateChooser_DateFrom.Value.ToString();
        Sql_PendingDocumentDetail.SelectParameters["EndDate"].DefaultValue = WebDateChooser_DateTo.Value.ToString();
        DataView dv = Sql_PendingDocumentDetail.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dt = dv.Table;
        string reportPath = Server.MapPath("~/RecordManagement/Pending_Documents_Report.rdlc");


        ReportViewer1.LocalReport.ReportPath = reportPath;


        foreach (DataRow dr in dt.Rows)
        {
            dr[0] = dr[0].ToString().Replace("&nbsp;", " ");
        }

        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();

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
        { }
        finally { }
    }
    protected void btnReport_Click(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.DataSources.Clear();
        LoadReport();
    }
}


