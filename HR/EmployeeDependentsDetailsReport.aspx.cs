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

public partial class HR_EmployeeDependentsDetailsReport : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            BindCampus();
            bindDepartment();
            bindSubDepartment();
            loadEmployee();
            //bindType();

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
            SqlConnection con = new SqlConnection(conString);
            try
            {
                con.Open();
                cmd = new SqlCommand("usp_AllEmployeeDependentsList", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Dept_Id", DDL_Department.SelectedValue);
                cmd.Parameters.AddWithValue("@SubDept_Id", DDL_SubDept.SelectedValue);
            cmd.Parameters.AddWithValue("@EmpID", ddl_Employee.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ReportDataSource rds = new ReportDataSource();
                rds.Name = "DataSet1";
                rds.Value = dt;
                ReportViewer1.LocalReport.DataSources.Clear();
                string reportPath = "";
                //if (DDL_Department.SelectedValue !="0" && DDL_Department.SelectedItem.Text == DDL_SubDept.SelectedItem.Text)
                //{
                //    reportPath = Server.MapPath("EmployeeList2.rdlc");
                //}
                //else
                //{
                   
                //}
                reportPath = Server.MapPath("EmployeeDependentsDetailsReport.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;
                ReportViewer1.LocalReport.DataSources.Add(rds);
                ReportViewer1.LocalReport.SubreportProcessing +=new SubreportProcessingEventHandler(subReports);
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
                //    ReportViewer1.Visible = true;

            }
            catch (Exception ex)
            {

                con.Close();
            }
            finally
            {
                con.Close();
            }
     

    }

    private void bindDepartment()
    {
         SqlCommand cmd;
            SqlConnection con = new SqlConnection();
            try
            {
                con = new SqlConnection(conString);
                con.Open();
                cmd = new SqlCommand("select 0 as Dept_ID, '---ALL---' as Dept_Name union  select Dept_ID,Dept_Name from Department where hospital_Id=@Hospital_Id order by Dept_Name  ", con);
                cmd.Parameters.AddWithValue("@Hospital_Id", DDL_Campus.SelectedValue);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                DDL_Department.DataSource = dt;
                DDL_Department.DataBind();
            }
        catch (Exception ex)
            {
                con.Close();
        }
    }

    private void bindSubDepartment()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("select 0 as SubDept_Id, '---ALL---' as SubDept_Name union  select SubDept_Id,SubDept_Name from  SubDepartment where Dept_ID=@Dept_ID order by SubDept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Department.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_SubDept.DataSource = dt;
            DDL_SubDept.DataBind();
            con.Close();
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
            cmd.Parameters.AddWithValue("@DeptId", DDL_SubDept.SelectedValue);

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




    private void BindCampus()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("Select Hospital_Id,Hospital_Name from  Hospital", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Department.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Campus.DataSource = dt;
            DDL_Campus.DataBind();
            DDL_Campus.SelectedValue = Session["HospitalID"].ToString();
            con.Close();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e )
    {
        LoadReport();
    }

    protected void DDL_Department_SelectedIndexChanged(object sender,EventArgs e)
    {
        bindSubDepartment();
        loadEmployee();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindDepartment();
        bindSubDepartment();
        loadEmployee();
    }

    protected void DDL_SubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadEmployee();
    }
}
