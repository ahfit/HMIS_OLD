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

public partial class Patient_Registration_PatientPayment_IsExpired : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadReport();
        WebDateChooser1.Value = DateTime.Now.AddMonths(-1);
        WebDateChooser2.Value = DateTime.Now;
    }

    private void LoadReport()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
            SqlCommand cmd;
            SqlConnection con = new SqlConnection(conStr);
            cmd = new SqlCommand("usp_Get_Patient_Payment_expire_search", con);
            cmd.CommandType = CommandType.StoredProcedure;          
            cmd.Parameters.AddWithValue("@Fromdate", WebDateChooser1.Value.ToString());
            cmd.Parameters.AddWithValue("@Todate", WebDateChooser2.Value.ToString());
            cmd.Parameters.AddWithValue("@Is_Expired", DropDownList1.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@RegNo", txtregisterationno.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
    
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource reportDataSource = new ReportDataSource();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            String path = Server.MapPath("Patient_Payment_IsExpired.rdlc");

            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportParameter rp = new ReportParameter("ReportParameter1", DropDownList1.SelectedValue.ToString());
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });

            if (Request.UserAgent.Contains("Chrome"))
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
          //Response.Write (ex.Message);
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
    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
}