using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Windows.Forms;

public partial class Pathology_LabTestSummaryReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
          
        }
    }

  


    protected void ShowReport()
    {
        string MRNo2 = mrNo.Text;
        if(MRNo2 == "")
        {
            MRNo2 = "0";
        }
        string FileNo = fileNo.Text;
        if(FileNo == "")
        {
            FileNo = "0";
        }


        SqlConnection conn = new SqlConnection(RegconString);
        DataTable dt = new DataTable();
        //DataSet ds = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("Sp_GetGayniProfileReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MRNo", Convert.ToString(MRNo2));
            cmd.Parameters.AddWithValue("@FileNo", Convert.ToInt32(FileNo));

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);

            //ReportDataSource datasource = new ReportDataSource("DataSet1", ds.Tables[0]);
            //ReportDataSource datasource1 = new ReportDataSource("DataSet2", ds.Tables[1]);

            //ReportViewer1.LocalReport.DataSources.Clear();
            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Administrator/GayniProfileReport.rdlc");
            ////ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            //ReportViewer1.LocalReport.DataSources.Add(datasource);
            //ReportViewer1.LocalReport.DataSources.Add(datasource1);
            ////ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt2));
            //ReportViewer1.LocalReport.SubreportProcessing += subReports;
            //ReportViewer1.LocalReport.Refresh();
            //ReportViewer1.Visible = true;
            //SqlCommand cmd2 = new SqlCommand("Sp_GetGayniProfileTrimReport", conn);
            //cmd.CommandType = CommandType.StoredProcedure;
            ////cmd.Parameters.AddWithValue("@MRNo", MRNo);
            ////cmd.Parameters.AddWithValue("@FileNo", Convert.ToInt32(FileNo));

            //SqlDataAdapter sda2 = new SqlDataAdapter(cmd2);
            //sda.Fill(dt2);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Administrator/GayniProfileReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            //ReportViewer1.LocalReport.DataSources.Add(datasource);
            //ReportViewer1.LocalReport.DataSources.Add(datasource1);
            //ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt2));
            ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}