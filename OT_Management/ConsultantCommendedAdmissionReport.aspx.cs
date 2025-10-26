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
public partial class OT_Management_PreOperationConsultantNotesReport : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            bindReport();
        }
    }
    protected void bindReport()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParam = { 
                                          new SqlParameter("@YearlyNo",Convert.ToString(Request.QueryString["YearlyNo"])),
                                          new SqlParameter("@RegNo",Convert.ToString(Request.QueryString["regno"]))
                                          
                                         
                                      };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("Select_ConsultantRecommendedReport", "TreatmentConnectionString", sqlParam);

            DbManager dbMgr1 = new DbManager();
            SqlParameter[] sqlParam1 = { 
                                          new SqlParameter("@YearlyNo",Convert.ToString(Request.QueryString["YearlyNo"])),
                                          new SqlParameter("@RegNo",Convert.ToString(Request.QueryString["regno"]))
                                          
                                         
                                      };
            DataTable dt1 = new DataTable();
            dt1 = dbMgr1.ExecuteDataTable("GetSelectedPackageDetail", "Basic_Data_ConnectionString", sqlParam1);

            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/OT_Management/PreOperationConsultantRecommendedNotesReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt1));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
            if ((Request.Browser.Browser == "Chrome"))
            {
                byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }
            else
            {
                ReportViewer1.Visible = true;
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
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

    protected void btnReport_Click(object sender, EventArgs e)
    {
        bindReport();
    }
}