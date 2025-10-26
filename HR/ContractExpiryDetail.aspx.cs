using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;


public partial class HR_ContractExpiryDetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
           // RadioButtonList1.SelectedValue = "1";
            showReport();

    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
                   showReport();
                   
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        showReport();
    }
    private void showReport()
    {
        HR ds = new HR();
        HRTableAdapters.usp_ContractExpiryDetailTableAdapter da = new HRTableAdapters.usp_ContractExpiryDetailTableAdapter();
        da.Fill(ds.usp_ContractExpiryDetail,Convert.ToInt32(RadioButtonList1.SelectedValue));
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/HR/ContractExpiryDetail.rdlc");
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportDataSource repDs = new ReportDataSource();
        repDs.Name = "DataSet1";
        repDs.Value = ds.Tables["usp_ContractExpiryDetail"];
        ReportViewer1.LocalReport.DataSources.Add(repDs);
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
        {

        }
    }
}