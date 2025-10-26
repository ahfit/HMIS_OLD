using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class HR_CardExpireReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            WebDateChooser_Start_Date.Value = DateTime.Now.AddMonths(-3);
            WebDateChooser_end_Date.Value = DateTime.Now;
            GetDesg();
            loadDepartment();
            loadEmployee();            
            EmployeeType();
        }
    }

    private void loadDepartment()
    {
        
        try
        {
            // con = new SqlConnection(BasicConn);

            DbManager objDbManager = new DbManager();
            SqlParameter[] sqlParams = { 
                                           new SqlParameter("@HospitalId", Session["HospitalId"]) ,
                                           new SqlParameter("@Type", "0") 
                                       };

            DataTable dt = new DataTable();
            dt = objDbManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams);                        
            ddl_SubDeptId.DataSource = dt;
            ddl_SubDeptId.DataValueField = "SubDept_Id";
            ddl_SubDeptId.DataTextField = "SubDept_Name";
            ddl_SubDeptId.DataBind();                                    
        }
        catch (Exception ex)
        {
           
        }
    }
    protected void loadEmployee()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            // con = new SqlConnection(BasicConn);

            con.ConnectionString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();

            cmd = new SqlCommand("Get_Employee_DeptWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DeptId", ddl_SubDeptId.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_Employee.DataSource = dt;
            ddl_Employee.DataTextField = "EmployeeName";
            ddl_Employee.DataValueField = "EmpID";
            ddl_Employee.DataSource = dt;

            ddl_Employee.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            con.Close();
        }
    }
    private void EmployeeType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            // con = new SqlConnection(BasicConn);

            con.ConnectionString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
            con.Open();
            cmd = new SqlCommand(" select 0 as Employee_Type_ID ,'All' as Type union select Employee_Type_ID,Type from Employee_Type order by Type", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_EType.DataSource = dt;
            ddl_EType.DataTextField = "Type";
            ddl_EType.DataValueField = "Employee_Type_ID";
            ddl_EType.DataSource = dt;

            ddl_EType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
   
 
    protected void GetDesg()
    {
        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams = new SqlParameter[] { };

        ddl_Designation.DataSource = objDbManager.ExecuteDataTableWithQuery("GetDesignations", "Basic_Data_ConnectionString", sqlParams);
        ddl_Designation.DataValueField = "Designation_ID";
        ddl_Designation.DataTextField = "Designation_Name";

        ddl_Designation.DataBind();

        ddl_Designation.Items.Insert(0, new ListItem("All", "0"));
    }
    protected void ddl_SubDeptId_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadEmployee();
        
    }
    protected void CardExpireReports()
    {
        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("usp_CardExpireyDetail", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd"));

            cmd.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd"));

            cmd.Parameters.AddWithValue("@EmpId", Convert.ToInt32(ddl_Employee.SelectedValue));

            cmd.Parameters.AddWithValue("@EmployeeStatus", ddl_EType.SelectedValue);

            cmd.Parameters.AddWithValue("@Designation", ddl_Designation.SelectedValue);
            cmd.Parameters.AddWithValue("@Department", ddl_SubDeptId.SelectedValue);
            cmd.Parameters.AddWithValue("@EmployeeType", ddl_EmployeeType.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/HR/CardExpireyReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += subReports;
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        CardExpireReports();
    }
}