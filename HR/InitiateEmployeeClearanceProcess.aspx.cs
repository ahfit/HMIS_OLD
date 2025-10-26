using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class HR_InitiateEmployeeClearanceProcess : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindCampus();
            bindSubDepartment();
            loadEmployee();
            loadClreanceDepartments();
            gvdClearance.DataBind();
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
            cmd = new SqlCommand("select Hospital_Id,Hospital_Name from  Hospital", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Campus.DataSource = dt;
            DDL_Campus.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

        }
    }


    //private void bindDepartment()
    //{
    //    SqlCommand cmd;
    //    SqlConnection con = new SqlConnection();
    //    try
    //    {
    //        con = new SqlConnection(conString);
    //        con.Open();
    //        cmd = new SqlCommand("select 0 as Dept_ID, '---ALL---' as Dept_Name union  select Dept_ID,Dept_Name from Department where hospital_Id=@Hospital_Id order by Dept_Name  ", con);
    //        cmd.Parameters.AddWithValue("@Hospital_Id", DDL_Campus.SelectedValue);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        DDL_Department.DataSource = dt;
    //        DDL_Department.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //        con.Close();
    //    }
    //}

    private void bindSubDepartment()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand(@"select SubDept_Id,SubDept_Name 
from  SubDepartment
inner join Department on SubDepartment.Dept_Id = Department.Dept_ID
where Hospital_ID = @HospitalId order by SubDept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@HospitalId",DDL_Campus.SelectedValue);
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

            cmd = new SqlCommand(@"select E.EmpID, ISNULL(E.EFName,'')+' '+ISNULL(E.EMName,'')+' '+ISNULL(E.ELName,'') as EmployeeName
 from Employee E
 where SubDeptId=@DeptId or @DeptId=0 order by EmployeeName", con);
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

    private void loadClreanceDepartments()
    {
        DataTable dt = new DataTable();
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString());
        try
        {

            con.Open();
            cmd = new SqlCommand(@"select SD.SubDept_Id,SD.SubDept_Name,CD.DesignationId from ClearanceDepartment CD
inner join SubDepartment SD on CD.SubDeptId = SD.SubDept_Id
where isnull(IsClearance,0) = 1
order by isnull(CD.IsFinal,0)", con);
            //cmd.Parameters.AddWithValue("@HospitalId", Session["HospitalID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            ChkClearanceDepartments.DataSource = dt;
            
            ChkClearanceDepartments.DataTextField = "SubDept_Name";
            ChkClearanceDepartments.DataValueField = "SubDept_Id";
            ChkClearanceDepartments.DataBind();


            foreach (ListItem item in ChkClearanceDepartments.Items)
            {
                item.Selected = true;
            }

        }
        catch (Exception ex)
        {

            con.Close();
        }
    }


    private void loadDepartment()
    {
DataTable dt = new DataTable();
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString());
        try
        {

            con.Open();
            cmd = new SqlCommand(@"select SD.SubDept_Id,SD.SubDept_Name,
Convert(bit,isnull(CD.IsClearance,0)) AS IsClearance,
Convert(bit,isnull(CD.IsFinal,0)) AS IsFinal, isnull(CD.Id,0) AS ClearanceId,isnull(CD.DesignationId,0) AS DesignationId
from SubDepartment SD
inner join Department D on SD.Dept_Id = D.Dept_ID
Left outer join ClearanceDepartment CD on SD.SubDept_Id = CD.SubDeptId

where D.Hospital_ID = @HospitalId order by SD.SubDept_Name", con);
            cmd.Parameters.AddWithValue("@HospitalId", Session["HospitalID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            
            da.Fill(dt);
            

        }
        catch (Exception ex)
        {

            con.Close();
        }
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString()))
        {
            string Depts = "";
            foreach (ListItem item in ChkClearanceDepartments.Items)
            {
                if (item.Selected)
                {
                    if (Depts == "")
                        Depts = Depts + item.Value;
                    else
                        Depts = Depts + "," + item.Value;

                }
                    
                
            }
            if (Depts != "")
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"Usp_InitiateClearanceProcess";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpId", ddl_Employee.SelectedValue);
                    cmd.Parameters.AddWithValue("@Depts", Depts);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Request Initiated......";
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Select Departments......";
            }
        }
        gvdClearance.DataBind();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubDepartment();
        loadEmployee();
    }

    protected void DDL_SubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadEmployee();
    }

    protected void lnkDeleteClearance_Delete(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;
                cmd.CommandText = @"Usp_DeleteEmployeeClearance";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ClearanceId", lnk.CommandArgument);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        gvdClearance.DataBind();
    }
}