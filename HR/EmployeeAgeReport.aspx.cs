using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class HR_EmployeeAgeReport : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(! IsPostBack)
        {
            txtStart.Text = "60";
            txtEnd.Text = "100";
            LoadReport();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

    protected void LoadReport()
    {
        SqlConnection conn = new SqlConnection(conStr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand sc = new SqlCommand("usp_GetEmployeeByAge", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@StartAge", txtStart.Text);
            sc.Parameters.AddWithValue("@EndAge", txtEnd.Text);

            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);
            string path = Server.MapPath("EmployeeAgeReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportParameter[] repParams = new ReportParameter[2];
            repParams[0] = new ReportParameter("FromDate", txtStart.Text);
            repParams[1] = new ReportParameter("ToDate", txtEnd.Text);
            ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf"; Response.BinaryWrite(bytes); Response.End();
            //}
            //else
            //{
                ReportViewer1.Visible = true;
            //}
        }
        catch(Exception Ex)
        {
            Response.Write(Ex.Message);
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