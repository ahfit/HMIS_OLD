using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Finance_DonationSummeryReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            WebDateChooser_SDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
            WebDateChooser_EDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
            bindExpenditure();
            
        }
    }

    protected void bindExpenditure()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Head_Type", "Donation") };
        ddlExpanse.DataSource = dbm.ExecuteDataTable("uspGetExpenditureHeadWise", "Finance_ConnectionString", sp);
        ddlExpanse.DataBind();
    }


    protected void btnreport_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
    protected void ShowReport()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        try
        {
            con.Open();
            cmd.CommandText = "Usp_DonationSummeryReport";
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@startDate", WebDateChooser_SDate.Value);
            cmd.Parameters.AddWithValue("@endDate", WebDateChooser_EDate.Value);
            cmd.Parameters.AddWithValue("@Ecode", ddlExpanse.SelectedValue);
            cmd.Parameters.AddWithValue("@EntryBy", ddlreceived.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Finance/DonationSummeryReport.rdlc");

            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
          
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
           
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
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                cmd.Dispose();
            }

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