using Microsoft.Reporting.WebForms;
using Microsoft.ReportingServices.DataProcessing;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OT_Management_OTNotesReport : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            LoadReport();
        }
    }
    private void LoadReport()
    {
        if (Request.QueryString["RegNo"] != null && Request.QueryString["VisitNo"] != null)
        {
            try
            {
                DataSet ds = new DataSet();
                SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OT_ManagementConnectionString"].ConnectionString);
                con.Open();
                SqlCommand cmd = new SqlCommand("OTNotesReport", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Order_ID", Request.QueryString["OrderId"]);
                cmd.Parameters.AddWithValue("@yearlyno", Request.QueryString["VisitNo"]);
                cmd.Parameters.AddWithValue("@RegNo", Request.QueryString["RegNo"]);
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                sda.Fill(ds);
                 
                ReportViewer1.LocalReport.DataSources.Clear();
                 
                //string reportPath = Server.MapPath("~/Pt_EMR/PatientChart.rdlc");
                string reportPath = Server.MapPath("OTNotesReport.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;

                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", ds.Tables[2]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", ds.Tables[0]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", ds.Tables[1]));
                

                //ReportParameter rp = new ReportParameter("YearlyNo", Request.QueryString["YearlyNo"]);

                //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
                //ReportViewer1.LocalReport.Refresh();



               
                    ReportViewer1.Visible = true;

            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
    }
}