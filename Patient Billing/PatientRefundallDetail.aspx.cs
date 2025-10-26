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

public partial class Patient_Billing_PatientRefundallDetail : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["BasicDataConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            FillHospital();
            wdcDateFrom.Value = DateTime.Now.AddDays(-1);
            WebDateDateTo.Value = DateTime.Now.AddDays(7);
            DropDownList1.DataBind();
        }

    }

    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Hospital.DataValueField = "Hospital_ID";
            ddl_Hospital.DataTextField = "Hospital_Name";
            ddl_Hospital.DataSource = dt;
            ddl_Hospital.DataBind();
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();
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
    private void LoadReport()
    {

        SqlConnection con = new SqlConnection(_conStr);

        SqlCommand cmd = new SqlCommand("select_Patient_RefundAmount", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@SDate", Convert.ToDateTime(wdcDateFrom.Value).ToString());
        cmd.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(WebDateDateTo.Value).ToString());
        cmd.Parameters.AddWithValue("@RefundType", DropDownList1.SelectedValue);
        cmd.Parameters.AddWithValue("@RegNo", txtboxRegNo.Text.Trim());
        cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
       
 

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();


        da.Fill(ds);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];

        ReportParameter[] repParams = new ReportParameter[3];

        repParams[0] = new ReportParameter("StartDate", Convert.ToDateTime(wdcDateFrom.Value).ToString());
        repParams[1] = new ReportParameter("EndDate", Convert.ToDateTime(WebDateDateTo.Value).ToString());
        repParams[2] = new ReportParameter("RefundType",DropDownList1.SelectedItem.Text.ToString());


        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = "./Patient Billing/PatientRefundDetailReport.rdlc";
        ReportViewer1.LocalReport.SetParameters(repParams);
        ReportViewer1.LocalReport.DataSources.Add(rds);
          ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);



        ReportViewer1.LocalReport.Refresh();

        ////if (Request.Browser.Browser == "Chrome")
        ////{
        ////    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
        ////    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
        ////    Response.ContentType = "application/pdf";
        ////    Response.BinaryWrite(bytes);
        ////    Response.End();
        ////}

        ////else
            ReportViewer1.Visible = true;

    }

}