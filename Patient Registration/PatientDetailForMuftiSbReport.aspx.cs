using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Patient_Registration_PatientDetailForMuftiSbReport : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["RegNo"] != null)
            {
                Hf_RegNo.Value = Request.QueryString["RegNo"].ToString();
            }
            ShowReport();
            //ddl_Category.SelectedIndex = -1;
            //ddl_Manufacturer.SelectedIndex = -1;
            //txt_ItemName.Text = "";

        }
    }


    
    protected void Button_Report_Click(object sender, EventArgs e)
    {
        try
        {
            ShowReport();
        }
        catch(Exception ex)
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


    private void ShowReport()
    {
        try
        {
            
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("Usp_GetPatientForZakatReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@RegNo", Hf_RegNo.Value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("PatientDetailForMuftiSbReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);


            //ReportParameter rp = new ReportParameter("ReportParameter1", hfIStartDate.Value);
            //ReportParameter rp2 = new ReportParameter("ReportParameter2", hfEndDate.Value);
           
            //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            //ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("Po_Item_Stock_Report", ds.Tables["usp_Po_Item_Stock"]));
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
        catch (Exception ex)
        {
        }

    }
    



}