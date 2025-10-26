using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leave_Management_EmployeeReportingAuthority : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    int ab = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindHospital();
            bindDepartment();
            bindSubDepartment();
            bindSubDeptReporting();
            bindEmployee();
            //bindAuthorityEmployee();
          
          
        }

    }


     protected void bindEmployee()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select e.EmpID,isnull(e.EFName,'')+isnull(e.EMName,'')+isnull(e.ELName,'') as Employee_Name from Employee e where e.SubDeptId=" + ddlsubdeptReporting.SelectedValue + " ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlEmpName.DataSource = dt;
        ddlEmpName.DataBind();
        con.Close();

    }

    protected void bindSubDeptReporting()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDept_Name,SubDept_Id from SubDepartment", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlsubdeptReporting.DataSource = dt;
        ddlsubdeptReporting.DataBind();
        con.Close();

    }

    protected void displayGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("select isnull(e.EFName,'')+' '+isnull(e.EMName,'')+' '+isnull(e.ELName,'') as Employee_Name,e.EmpID from Employee e  where e.DeptID=" + ddldepartment.SelectedValue + " and (  e.ActiveStatus=1)", con);


        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        Gridview1.DataSource = dt;
        Gridview1.DataBind();
        con.Close();

    }


    protected void displayPanelGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DutyRoaster"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("uspDisplayMarkAuthority", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@EmpID", btnReporting.CommandArgument);
        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        Gridview2.DataSource = dt;
        Gridview2.DataBind();
        con.Close();

    }

    protected void bindHospital()
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("select Hospital_ID, Hospital_Name from Hospital ", con);

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
        cmd = new SqlCommand("select Dept_Name,Dept_ID from Department ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddldepartment.DataSource = dt;
        ddldepartment.DataBind();
        con.Close();

    }

    protected void ddldepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubDepartment();
    }

    protected void bindSubDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDept_Name,SubDept_Id from SubDepartment where Dept_Id='" + ddldepartment.SelectedValue + "' ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlsubdepartment.DataSource = dt;
        ddlsubdepartment.DataBind();
        con.Close();


    }

    protected void btnShow_Click(object sender, EventArgs e)
    {
        displayGrid();
    }
    protected void btnReporting_Click(object sender, EventArgs e)
    {
        //for (int i = 0; i < Gridview1.Rows.Count; i++)
        //{
            //CheckBox c = (CheckBox)Gridview1.Rows[i].FindControl("CheckBox1");
            //HiddenField hdfRole = (HiddenField)Gridview1.Rows[i].FindControl("hfEmpID") as HiddenField;

            //if (c.Checked)
        SqlConnection con1 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DutyRoaster"].ConnectionString);
        con1.Open();
              
                 SqlCommand cmd = new SqlCommand("uspInsertEmployeeReportingAuthority", con1);
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
                        lblmsg.Visible = true;

                        displayPanelGrid();
                    }
    }

    protected void ddlsubdeptReporting_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindEmployee();
          
    }
    protected void lnkbtnRemoveLeft_Click(object sender, EventArgs e)
    {
             LinkButton btn = sender as LinkButton;
                  con.Open();
                SqlCommand cmd = new SqlCommand("delete from EmployeeReportingAuthority  where  ReportingID=" +btn.CommandName+ "", con);
                cmd.ExecuteNonQuery();
                con.Close();
                displayGrid();
              
        }

    protected void lnkbtnRemoveLeftTwo_Click(object sender, EventArgs e)
    {
             LinkButton btn = sender as LinkButton;
                  con.Open();
                SqlCommand cmd = new SqlCommand("delete from EmployeeReportingAuthority  where  ReportingID=" +btn.CommandName+ "", con);
                cmd.ExecuteNonQuery();
                con.Close();
              
              
        }

    protected void closebtnPanel_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
        lblmsg.Text = "";
        lblexist.Text = "";
    }
    protected void btnMark_Click(object sender, EventArgs e)
    {

        LinkButton btn = sender as LinkButton;
        btnReporting.CommandArgument = btn.CommandArgument;
        Label lb= (Label)btn.FindControl("lbEName");
         lblEmpName.Text =lb.Text;
        panel.Visible = true;
        displayPanelGrid();

    }
    protected void btnDelAuthority_Click(object sender, EventArgs e)
    {
        SqlConnection con1 = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DutyRoaster"].ConnectionString);
        LinkButton btn = sender as LinkButton;
        con1.Open();
        SqlCommand cmd = new SqlCommand("delete from EmployeeReportingAuthority  where  ReportingID=" + btn.CommandArgument + "", con1);
        cmd.ExecuteNonQuery();
        con1.Close();
        displayGrid();
        displayPanelGrid();
    }
}