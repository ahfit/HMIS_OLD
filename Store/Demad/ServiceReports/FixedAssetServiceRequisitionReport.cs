using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Store_FixedAssetServiceRequisitionReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            ddlDepartment.DataBind();
           
            //ddlDepartment.SelectedValue = Session["Dept_ID"].ToString();
            
            wdcFromDate.Value = DateTime.Now.AddDays(-10);
            wdcToDate.Value = DateTime.Now;
        }
    }
    protected void btnSearchRequisition_Click(object sender, EventArgs e)
    {

        bindReport();
      
    }

    protected void bindReport()
    {
        SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        conn.Open();
        DataTable dt = new DataTable();
        try
        {
            SqlCommand sc = new SqlCommand("usp_GetServiceRequisitionsFixedReport", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@Demand_RequisitionNo",txtRequisitionNo.Text);
            sc.Parameters.AddWithValue("@From_Dept_ID", ddlDepartment.SelectedValue);
            sc.Parameters.AddWithValue("@FromDate", wdcFromDate.Value);
            sc.Parameters.AddWithValue("@ToDate", wdcToDate.Value); 
            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);
        }
        catch (Exception ex)
        {
        }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = "Store/Demad/serviceReports/FixedAssetServiceRequisitionReport.rdlc";
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            //   this.ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }
        }

    }

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    
}