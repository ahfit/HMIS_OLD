using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;
using System.Data;

public partial class PayRoll_HeadFinalRpt : System.Web.UI.Page
{
    SqlConnection con = null;
    public PayRoll_HeadFinalRpt() 
    {
        if (con == null)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString);
        }
    }

    private void Open() 
    {
        if (con == null)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString);
            con.Open();
        }
        else
        {
            con.Open();
        }
    }

    private void Close() 
    {
        if (con !=null)
        {
            con.Close();
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
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
        { }
        finally { }
    }
    private void ShowReport()
    {
        try
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            PayRoll ds = new PayRoll();
            string reportPath = Server.MapPath("~/Payroll/HeadFinalRpt.rdlc");
            PayRollTableAdapters.usp_HeadFinalRptTableAdapter da = new PayRollTableAdapters.usp_HeadFinalRptTableAdapter();
            da.Fill(ds.usp_HeadFinalRpt, Convert.ToInt32(Request.QueryString["ApprovedID"]));
            
            DataTable dt = ds.Tables["usp_HeadFinalRpt"];

            ReportParameter[] repParams = new ReportParameter[3];
            repParams[0] = new ReportParameter("Head", Convert.ToString(dt.Rows[0]["Head_Name"]));
            repParams[1] = new ReportParameter("ForMonth", Convert.ToString(dt.Rows[0]["SalaryMonth1"]));
            repParams[2] = new ReportParameter("ForYear", Convert.ToString(dt.Rows[0]["SalaryYear"]));
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet.Copy());


            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables["usp_HeadFinalRpt"]));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

    }
}