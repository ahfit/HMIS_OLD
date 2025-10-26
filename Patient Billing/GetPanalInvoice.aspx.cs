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

public partial class Patient_Billing_GetPanalInvoice : System.Web.UI.Page
{

    string _conStr = ConfigurationManager.ConnectionStrings["PatientBillingConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadReport();
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


    private void loadReport() {

        if (Request.QueryString["InvoiceNo"] != null)
        {
            SqlCommand cmd;
            SqlConnection con = new SqlConnection();
            try
            {
                

                con = new SqlConnection(_conStr);

                cmd = new SqlCommand("GetPanelInvoice", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@InvoiceNo", Request.QueryString["InvoiceNo"]);

                // Add Party Name parameter if provided
                if (Request.QueryString["PartyName"] != null && !string.IsNullOrEmpty(Request.QueryString["PartyName"]))
                {
                    cmd.Parameters.AddWithValue("@PartyName", Request.QueryString["PartyName"]);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@PartyName", DBNull.Value);
                }

                // Add Invoice Date parameter if provided
                if (Request.QueryString["InvoiceDate"] != null && !string.IsNullOrEmpty(Request.QueryString["InvoiceDate"]))
                {
                    DateTime invoiceDate;
                    if (DateTime.TryParse(Request.QueryString["InvoiceDate"], out invoiceDate))
                    {
                        cmd.Parameters.AddWithValue("@InvoiceDate", invoiceDate);
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@InvoiceDate", DBNull.Value);
                    }
                }
                else
                {
                    cmd.Parameters.AddWithValue("@InvoiceDate", DBNull.Value);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DataSet1";
                rds.Value = dt;
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("panel_Invoice.rdlc");
                ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

                ReportViewer1.LocalReport.DataSources.Add(rds);
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
            finally {                       
            }
        }
    }


}