using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_PendingDemands : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {

            wdcFromDate.Value = DateTime.Now.AddMonths(-1);
            wdcToDate.Value = DateTime.Now;
        }

    }
    protected void lnkDemandId_Click(object sender, EventArgs e)
    {
        //LinkButton btnTemp = (LinkButton)sender;
        //GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        //HiddenField hdfCID = (HiddenField)gvRow.FindControl("hdfCompany_ID");
        ////Response.Redirect("Demand_Requisition_Report.aspx?RequsitionNo=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value);
        //String path = "IPOrderReport.aspx?QO_ID=" + btnTemp.CommandArgument + "&PID=" + hdfCID.Value;
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + path + "','_newtab');", true);
    }

    protected void btnSearchRequisition_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
    protected void ShowReport()
    {
        SqlConnection conn = new SqlConnection(conStr);
        try
        {
            DbManager dbMgr = new DbManager();

            DataTable dt = new DataTable();
            string path = null;

            SqlParameter[] sqlParam = {
                    
                    new SqlParameter("@fromdate",Convert.ToDateTime(wdcFromDate.Value).ToString("yyyy-MMMM-dd")),

                                      new SqlParameter("@todate",Convert.ToDateTime(wdcToDate.Value).ToString("yyyy-MMMM-dd")),

                                       };
            dt = dbMgr.ExecuteDataTable("PendingDemands", "STOREConnectionString", sqlParam);
            path = Server.MapPath("PendingDemands.rdlc");


            //ReportParameter[] repParams = new ReportParameter[2];

            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            //repParams[0] = new ReportParameter("Start_Date", "");
            //repParams[1] = new ReportParameter("End_Date", "");
            //ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
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