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

public partial class Machine_Attendance_Leave_History_Report : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ShowReport();
        }
    }

    private void ShowReport()
    {
        SqlCommand cmd = default(SqlCommand);
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("Emp_Leave_InfoForReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Emp_ID", Request.QueryString["emp_id"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Leave_History_Report.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            repDs.Name = "DataSet1";
            repDs.Value = dt;
            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);    
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
            con.Close();
        }
        catch (Exception ex)
        {
            con.Close();
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