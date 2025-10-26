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

public partial class Leave_Management_LeaveApprovalAuthority : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bindHospital();
            bindDepartment();
            bindSubDeptReporting();
            //bindEmployee();

            loadDepartment();
            loadDesignation();
            getApprovalAuthoeiries();
        }

    }

    protected void bindHospital()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        cmd = new SqlCommand("select Hospital_ID, Hospital_Name from Hospital order by Hospital_Name", con);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlHospital.DataSource = ds;
        ddlHospital.DataValueField = "Hospital_ID";
        ddlHospital.DataTextField = "Hospital_Name";
        ddlHospital.DataBind();
        con.Close();
    }

    protected void bindDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDept_Name,SubDept_ID from SubDepartment order by SubDept_Name", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddldepartment.DataSource = dt;
        ddldepartment.DataBind();
        con.Close();

    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        displayGrid();
    }

    protected DataTable getreturnGriddata()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand(@"select isnull(e.EFName,'')+' '+isnull(e.EMName,'')+' '+isnull(e.ELName,'') as Employee_Name,e.EmpID,DS.Designation_Name,sd.SubDept_Name
from Employee e
inner
join Designation ds on e.DesignationID = ds.Designation_ID
inner
join SubDepartment sd on e.SubDeptId = sd.SubDept_Id  where (e.ActiveStatus = 1) AND e.SubDeptID=" + ddldepartment.SelectedValue + " order by Employee_Name", con);


        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        return dt;
    }

    protected void displayGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        DataTable dt = new DataTable();
        dt = getreturnGriddata();
        Gridview1.DataSource = dt;
        Gridview1.DataBind();
        con.Close();

    }

    protected void btnMark_Click(object sender, EventArgs e)
    {

        LinkButton btn = sender as LinkButton;
        btnReporting.CommandArgument = btn.CommandArgument;
        Label lb = (Label)btn.FindControl("lbEName");
        lblEmpName.Text = lb.Text;
        HfEmpId.Value = btn.CommandArgument;
        panel.Visible = true;
        displayPanelGrid();

    }

    protected void displayPanelGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
     
        SqlCommand cmd = new SqlCommand("uspDisplayMarkAuthorityLeaveDept", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@EmpID", HfEmpId.Value);
        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        Gridview2.DataSource = dt;
        Gridview2.DataBind();
        

    }

    protected void ddlsubdeptReporting_SelectedIndexChanged(object sender, EventArgs e)
    {
        //bindEmployee();

    }

    protected void bindEmployee()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select e.EmpID,isnull(e.EFName,'')+isnull(e.EMName,'')+isnull(e.ELName,'') as Employee_Name from Employee e where (e.ActiveStatus = 1) And e.SubDeptId=" + ddlsubdeptReporting.SelectedValue + " ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlEmpName.DataSource = dt;
        ddlEmpName.DataBind();
        con.Close();

    }
    protected void btnReporting_Click(object sender, EventArgs e)
    {
        //for (int i = 0; i < Gridview1.Rows.Count; i++)
        //{
        //CheckBox c = (CheckBox)Gridview1.Rows[i].FindControl("CheckBox1");
        //HiddenField hdfRole = (HiddenField)Gridview1.Rows[i].FindControl("hfEmpID") as HiddenField;

        //if (c.Checked)
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        SqlConnection con1 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DutyRoaster"].ConnectionString);
        con1.Open();
        con.Open();
        SqlCommand cmd = new SqlCommand("uspInsertEmployeeReportingAuthorityforleave", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@EmpID", btnReporting.CommandArgument);
        cmd.Parameters.AddWithValue("@ddlsubdeptReporting", ddlsubdeptReporting.SelectedValue);
        //cmd.Parameters.AddWithValue("@PriorityLevel",txtboxPriority.Text);

        cmd.Parameters.Add("@status", SqlDbType.Int);
        cmd.Parameters["@status"].Direction = ParameterDirection.Output;

        cmd.ExecuteNonQuery();
        string value = cmd.Parameters["@status"].Value.ToString();
        con.Close();

        if (value == "0")
        {
            lblexist.Visible = true;
            lblexist.ForeColor = System.Drawing.Color.Red;
            lblexist.Text = "Authority Already Exist...";

        }
        else if (value == "2")
        {
            lblexist.Visible = true;
            lblexist.ForeColor = System.Drawing.Color.Red;
            lblexist.Text = "Authority Level Already Assigned...";
        }
        else
        {
            Label1.Visible = true;

            displayPanelGrid();
        }
    }

    protected void closebtnPanel_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
        Label1.Text = "";
        lblexist.Text = "";
    }

    protected void btnDelAuthority_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        LinkButton btn = sender as LinkButton;
        con.Open();
        SqlCommand cmd = new SqlCommand("delete from EmployeedepartmentAuthorityforLeave  where  ReportingID=" + btn.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        displayGrid();
        displayPanelGrid();
    }


    protected void bindSubDeptReporting()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDept_Id,SubDept_Name from SubDepartment order by SubDept_Name", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlsubdeptReporting.DataSource = dt;
        ddlsubdeptReporting.DataBind();
        con.Close();

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
            cmd = new SqlCommand("select  SubDept_Id ,SubDept_Name from subdepartment  order by SubDept_Name ", con);
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
    protected void loadDesignation()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {            
            con.ConnectionString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();

            cmd = new SqlCommand("selectDesingationDepartmentWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@SubdeptID", ddl_SubDeptId.SelectedValue);
             

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDesignation.DataSource = dt;
            ddlDesignation.DataTextField = "Designation_Name";
            ddlDesignation.DataValueField = "Designation_ID";


            ddlDesignation.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            con.Close();
        }
    }
 
 
   
    protected void ddl_SubDeptId_SelectedIndexChanged(object sender, EventArgs e)
    {
        //loadDesignation();
        
    }
 

     
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string Status = "0";
        String connstr = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ToString();
        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("InsertLeaveApprovalAuthority", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DeptID", ddl_SubDeptId.SelectedValue);
            cmd.Parameters.AddWithValue("@Authority", 1);
            cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@CreatedDate", DateTime.Now);
            cmd.Parameters.AddWithValue("@DesignationID", ddlDesignation.SelectedValue);
            cmd.Parameters.Add("@status", SqlDbType.Int, 10);
            cmd.Parameters["@status"].Direction = System.Data.ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();

            Status = cmd.Parameters["@status"].Value.ToString();
            if (Status == "1")
            {
                lblMsg.Text = "Data is Saved Successfully . . .";
            }
            else 
            {
                lblMsg.Text = "HOD is Already Saved For This Department . . .";
            }
           
        }
        catch (Exception ex)
        {

            lblMsg.Text = "Some Error is Occured.";
            
        }
        finally {
            conn.Close();
        }
        getApprovalAuthoeiries();
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
            gvd.DataSource = dt;
            gvd.DataBind();
        }
        catch (Exception ex)
        { }
        finally
        { }
    }





    protected void lnkDelete_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ToString()))
        {
            using (SqlCommand cmd = new SqlCommand("Delete from LeaveApprovalAuthorities where ID = @ID", conn))
            {
                conn.Open();
                cmd.Parameters.AddWithValue("@ID",lnk.CommandArgument);
                cmd.ExecuteNonQuery();
                conn.Close();
                
            }
            
        }
        getApprovalAuthoeiries();
    }

  
    protected void gvdCnicExpiry_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        Gridview1.PageIndex = e.NewPageIndex;
        this.displayGrid();
    }
    protected void Gridview1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
}

