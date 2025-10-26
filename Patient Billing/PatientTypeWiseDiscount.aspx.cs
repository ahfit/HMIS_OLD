using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Patient_Billing_PatientTypeWiseDiscount : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["PatientBillingConnectionString"].ConnectionString;
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    string BasicString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            startDateChooser.Value = DateTime.Now.AddDays(-7);
            endDateChooser.Value = DateTime.Now;
            loadDepartments();
            loadDiscount_Type();
            loadPatientType();
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
        SqlConnection con = new SqlConnection(BasicString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_patientTypeWiseDiscount", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@startDate", startDateChooser.Value.ToString());
            cmd.Parameters.AddWithValue("@endDate", endDateChooser.Value.ToString());
            cmd.Parameters.AddWithValue("@DiscountType", ddlDiscountType.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@PatientType", DropDownList_PatientType.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept_ID", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@Type", DropDownTypeWise.SelectedValue);
            cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/Patient Billing/Patient_TypeWise_Discount.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(rds);


            ReportParameter rp = new ReportParameter("ReportParameter1", startDateChooser.Value.ToString());
            ReportParameter rp2 = new ReportParameter("ReportParameter2", endDateChooser.Value.ToString());
            ReportParameter rp3 = new ReportParameter("ReportParameter3", ddlDiscountType.SelectedItem.Text);
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2,rp3 });
              ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);


            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }

         
           
     
    }
    private void loadPatientType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(RegconString);
            con.Open();
            cmd = new SqlCommand("Select 0 as ID, 'ALL' Patient_Type UNION select ID, Patient_Type from Patient_Type   order by ID, Patient_Type ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_PatientType.DataSource = dt;
            DropDownList_PatientType.DataTextField = "Patient_type";
            DropDownList_PatientType.DataValueField = "ID";

            DropDownList_PatientType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    private void loadDiscount_Type()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(BasicString);
            con.Open();
            cmd = new SqlCommand("Select 0 as ID, 'ALL' DiscountType UNION select ID, DiscountType from Discount_Type  ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDiscountType.DataSource = dt;
            ddlDiscountType.DataValueField = "DiscountType";
            ddlDiscountType.DataTextField = "DiscountType";

            ddlDiscountType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    private void loadDepartments()
    {

        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 Dept_ID, '----- ALL -----' Dept_Name UNION Select Dept_ID,Dept_Name From Department where Department.Hospital_ID=@HospitalID  Order By Dept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    protected void btnReport_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
    protected void ddl_Hospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadDepartments();
    }
}