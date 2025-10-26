using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Patient_Billing_Patientrefund_Details : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            LoadReport();

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
    protected void LoadReport()
    {
        
            SqlCommand cmd;
            SqlConnection con = new SqlConnection();
            try
            {
                con = new SqlConnection(conString);

                cmd = new SqlCommand("PatientRefundDetialsReport", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RegNo", Request.QueryString["RegNo"]);
                cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
                cmd.Parameters.AddWithValue("@Refund_ID", Request.QueryString["CashBookID"]);
                cmd.Parameters.AddWithValue("@CashBookId", Request.QueryString["0"]);


                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);


                string reportPath = Server.MapPath("~/Patient Billing/PatientRefund_details.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;
                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables[0]));
                ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ds.Tables[1]));
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
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

