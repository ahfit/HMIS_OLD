using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class Store_Returnable_GatePassReport : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowReport();
        }
    }
    
    protected void ShowReport()
    {
        try
        {
            if (Request.QueryString["Type"].ToString() == "Returnable")
            {

                SqlConnection conn = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand("usp_Select_ReturnableGatePass", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ReportDataSource reportDataSource = new ReportDataSource();
                ReportViewer1.LocalReport.DataSources.Clear();
                // Must match the DataSource in the RDLC

                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Returnable_GatePass_Report.rdlc");
                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
                ReportViewer1.LocalReport.Refresh();

                if (Request.Browser.Browser == "Chrome")
                {
                    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(bytes);
                    Response.End();
                }

                else
                    ReportViewer1.Visible = true;
            }
            else
            {

                SqlConnection conn = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand("usp_Select_ReturnableGatePass", conn);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", Request.QueryString["ID"].ToString());
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ReportDataSource reportDataSource = new ReportDataSource();
                ReportViewer1.LocalReport.DataSources.Clear();
                // Must match the DataSource in the RDLC

                ReportViewer1.LocalReport.ReportPath = Server.MapPath("NonReturnable_GatePass_Report.rdlc");
                ReportViewer1.LocalReport.DataSources.Clear();

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
                ReportViewer1.LocalReport.Refresh();

                if (Request.Browser.Browser == "Chrome")
                {
                    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                    Response.ContentType = "application/pdf";
                    Response.BinaryWrite(bytes);
                    Response.End();
                }

                else
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
}