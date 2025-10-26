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

public partial class Pathology_LabBarCode : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["Sample_No"] != null)
            {
                Hf_SampleNo.Value = Request.QueryString["Sample_No"].ToString();
            }
            if (Request.QueryString["TB_ID"] != null)
            {
                Hf_TbId.Value = Request.QueryString["TB_ID"].ToString();
            }

            if (Request.QueryString["TG_ID"] != null)
            {
                Hf_TgId.Value = Request.QueryString["TG_ID"].ToString();
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
            SqlCommand cmd = new SqlCommand("Usp_GetPatientDataForLabBarCode", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SampleNo", Hf_SampleNo.Value);
            cmd.Parameters.AddWithValue("@TBId", Hf_TbId.Value);
            cmd.Parameters.AddWithValue("@TGId", Hf_TgId.Value);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("LabBarCode.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);


            //ReportParameter rp = new ReportParameter("ReportParameter1", hfIStartDate.Value);
            //ReportParameter rp2 = new ReportParameter("ReportParameter2", hfEndDate.Value);
           
            //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            //ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

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