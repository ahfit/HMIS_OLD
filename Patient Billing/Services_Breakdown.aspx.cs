using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Patient_Billing_Services_Breakdown : System.Web.UI.Page
{
    String Constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    decimal Total = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadReport();
            // ServicesBreakdown();
        }
    }
    protected void LoadReport()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            string SDate = Convert.ToDateTime(Request.QueryString["SDate"]).ToString();
            string EDate = Convert.ToDateTime(Request.QueryString["EndDate"]).ToString();
            con = new SqlConnection(Constr);
            con.Open();

            cmd = new SqlCommand("usp_ServiceGetBreakdown", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CCDAte", SDate);
            cmd.Parameters.AddWithValue("@CCEndDAte", EDate);
            cmd.Parameters.AddWithValue("@hospital_id", Request.QueryString["H_Id"]);
            cmd.Parameters.AddWithValue("@Category", Request.QueryString["Cat"]);
            cmd.Parameters.AddWithValue("@C_ID", Request.QueryString["Cat_Id"]);
            cmd.Parameters.AddWithValue("@Type", Request.QueryString["Type"]);
            cmd.Parameters.AddWithValue("@EmpId", Request.QueryString["EmpId"]);
            cmd.Parameters.AddWithValue("@CounterType", Request.QueryString["CounterType"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt1 = new DataTable();
            da.Fill(dt1);
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt1;

            string reportPath = Server.MapPath("ServicesBreakDownReport.rdlc");
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(rds);

           


            ReportParameter rp = new ReportParameter("ReportParameter1", SDate);
            ReportParameter rp2 = new ReportParameter("ReportParameter2", EDate);
          
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2});
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt1));
            ReportViewer1.LocalReport.Refresh();
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

            //else
            {
                ReportViewer1.Visible = true;
            }

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