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

public partial class Leave_Management_LeaveBalanceReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            loadDepartment();
            loadEmployee();
            
            
        }

    }

    private void loadDepartment()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            // con = new SqlConnection(BasicConn);

            con.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
            con.Open();
            cmd = new SqlCommand(" select 0 SubDept_Id,  '---ALL---' SubDept_Name from subdepartment union select  SubDept_Id ,SubDept_Name from subdepartment  order by SubDept_Name ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_SubDeptId.DataSource = dt;
            ddl_SubDeptId.DataTextField = "SubDept_Name";
            ddl_SubDeptId.DataValueField = "SubDept_Id";
            ddl_SubDeptId.DataSource = dt;

            ddl_SubDeptId.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    protected void loadEmployee()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {            
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
            

            ddl_Employee.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            con.Close();
        }
    }
 
 
   
    protected void ddl_SubDeptId_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadEmployee();
        
    }
    protected void CardExpireReports()
    {


        String connstr = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ToString();
        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("usp_LeaveBalanceReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Emp_Id", Convert.ToInt32(ddl_Employee.SelectedValue));
            cmd.Parameters.AddWithValue("@SubDept_Id", ddl_SubDeptId.SelectedValue);
            cmd.Parameters.AddWithValue("@balanceYear", ddlBalanceYear.SelectedValue);

            

            
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Leave_Management/EmployeeLeaveBalanceeport.rdlc");
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



    private void getApprovalAuthoeiries()
    {
          String connstr = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ToString();
        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("SelectApprovalAuthorities", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        { }
    }


}