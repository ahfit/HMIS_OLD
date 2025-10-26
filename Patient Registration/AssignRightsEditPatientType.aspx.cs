using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Patient_Registration_AssignRightsEditPatientType : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    String conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadDepartments();
            loadEmployee();
            loadEditPatientType();
            FillGridView();    
        }
        
    }
    protected void deleteRecord(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        SqlConnection con = new SqlConnection(conString);
        con.Open();

        SqlCommand cmd = new SqlCommand("Delete_AssignEditPatientRights", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ID", btn.CommandName);
        cmd.ExecuteNonQuery();
        FillGridView();
        con.Close();
    }

    private void FillGridView()
    {
        try

        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("DeptID",ddlDepartment.SelectedValue),
                    new SqlParameter("EmpID",DDLEmployee.SelectedValue)};
          GridView1.DataSource=  dbMgr.ExecuteDataTable("Select_AssignEditRightsPatientType", "Reg_ConnectionString", para);
            
            GridView1.DataBind();
        }
        catch (Exception ex)
        {


        }
    }
    protected void btn_markReceptionest_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_str);

        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Insert_AssignEditRightsPatientType", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@EmpID", DDLEmployee.SelectedValue);
            cmd.Parameters.AddWithValue("@Type", DDLEditType.SelectedItem.Text);

            cmd.ExecuteNonQuery();
            con.Close();
            FillGridView();




        }
        catch (Exception ex)
        {


        }
        finally
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
            cmd = new SqlCommand("Select Dept_ID,Dept_Name From Department  Order By Dept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataValueField = "Dept_ID";
            ddlDepartment.DataTextField = "Dept_Name";
            
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

    private void loadEmployee()
    {

        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select EmpID,isnull(EFName,'') +' '+ isnull(ELName,'') as EmpName From Employee where ActiveStatus=1 and Employee.DeptID=@DeptID Order By EmpName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@DeptID", ddlDepartment.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDLEmployee.DataSource = dt;
            DDLEmployee.DataValueField = "EmpID";
            DDLEmployee.DataTextField = "EmpName";
            
            DDLEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }

    private void loadEditPatientType()
    {

        SqlConnection con = new SqlConnection(_str);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT ID, EditType FROM   AddEditPatientType order by EditType ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDLEditType.DataSource = dt;
            DDLEditType.DataValueField = "ID";
            DDLEditType.DataTextField = "EditType";

            DDLEditType.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }



    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadEmployee();
        FillGridView();
    }

    protected void DDLEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGridView();
    }
}