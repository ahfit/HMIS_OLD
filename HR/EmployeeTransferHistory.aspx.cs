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

public partial class HR_EmployeeTransferHistory : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
           
            WebDateChooser_StartDate.Value = DateTime.Now;
            WebDateChooser_EndDate.Value = DateTime.Now;
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
            SqlCommand sc = new SqlCommand("usp_GetEmployeeTransferHistoryReport", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@StartDate", Convert.ToDateTime(WebDateChooser_StartDate.Value).ToString("yyyy/MM/dd"));
            sc.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(WebDateChooser_EndDate.Value).ToString("yyyy/MM/dd"));
            sc.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue);
            sc.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue);
            //sc.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);
            string path = Server.MapPath("EmployeeTransferHistory.rdlc");
            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Clear();
            //ReportParameter[] repParams = new ReportParameter[2];
            //repParams[0] = new ReportParameter("FromDate", txtStart.Text);
            //repParams[1] = new ReportParameter("ToDate", txtEnd.Text);
            //ReportViewer1.LocalReport.SetParameters(repParams);
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