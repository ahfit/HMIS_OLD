using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class RecordManagement_Receive_Patient_Record_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
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
        { }
        finally { }
    }

    protected void LoadReport()
    {
        try
        {
            SqlDataSource1.SelectParameters["Patient_Record_File_Id"].DefaultValue = Request.QueryString["File_ID"];
            DataView dv = SqlDataSource1.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;
            string reportPath = Server.MapPath("~/RecordManagement/Receive_Patient_Record_Report.rdlc");


            ReportViewer1.LocalReport.ReportPath = reportPath;


            foreach (DataRow dr in dt.Rows)
            {
                dr[0] = dr[0].ToString().Replace("&nbsp;", " ");
            }

            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/RecordManagement/ReceiveIssuedPatientRecords.aspx");
    }
}