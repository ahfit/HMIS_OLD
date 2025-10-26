using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Patient_Billing_PatientServiceCanceletionReport : System.Web.UI.Page
{
    String strCon = ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(! IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            txtStartDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            txtEndDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            loadDepartment();
            getDropdown();
            
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetDate();
    }
    private void getDropdown()
    {
        DbManager dbManager = new DbManager();
        DataTable dt = dbManager.ExecuteDataTableWithQuery("select  ' All' Patient_type,0 as Patient_Type_ID union all select Patient_type,Patient_Type_ID from Patient_type where Active=1  order by Patient_type asc ", "Basic_Data_ConnectionString", new SqlParameter[0]);
        ddlPatientType.DataSource = dt;
        ddlPatientType.DataValueField = "Patient_Type_ID";
        ddlPatientType.DataTextField = "Patient_type";
        ddlPatientType.DataBind();
    }


    private void loadDepartment()
    {
        DbManager dbmanage = new DbManager();
        SqlParameter[] sqlParams = {
        new SqlParameter("Type", 1),
        new SqlParameter("@HospitalId", ddHospital.SelectedValue) };
        ddlDepartment.DataSource = dbmanage.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataTextField = "SubDept_Name";
        ddlDepartment.DataValueField = "SubDept_Id";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("All", "0"));
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

    protected void GetDate()
    {
        SqlConnection conn = new SqlConnection(strCon);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("Get_ServicesCanceletion", conn);
            cmd.CommandType = CommandType.StoredProcedure; 
            cmd.Parameters.AddWithValue("@DateStart", txtStartDate.Text);
            cmd.Parameters.AddWithValue("@DateEnd", txtEndDate.Text);
            cmd.Parameters.AddWithValue("@hospital_id", ddHospital.SelectedValue);
            cmd.Parameters.AddWithValue("@patient_type", ddlOPDIPD.SelectedValue);
            cmd.Parameters.AddWithValue("@subdeptid", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@PatientType", ddlPatientType.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);

            string reportPath = Server.MapPath("~/Patient Billing/PatientServicesCanceletionReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.Refresh();
            this.ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.Visible = true;

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}
            //else
            //{
            //    ReportViewer1.Visible = true;
            //}

        }
        catch(Exception Ex)
        {
            Response.Write(Ex.Message);
        }
        
    }
}