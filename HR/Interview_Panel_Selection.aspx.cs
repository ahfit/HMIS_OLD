using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class HR_Advertisement_Interview_Panel_Selection : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
            GetDepartment();
            GetEmployees();
            GetInterviewPanel();
            empDetailouter.Visible = false;
            divddlOuterEmployee.Visible = false;

            GetOuterEmployeesForGrid();
        }
    }
    private void GetAllActiveAdvertisement()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT  Ad_Title, Ad_Id FROM Advertisement_Main where Is_Active=1", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Advertisement.DataSource = dt;
            DDL_Advertisement.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_Insert_InterviewPanel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id",DDL_Advertisement.SelectedValue);
            
            cmd.Parameters.AddWithValue("@Created_On",DateTime.Now);
            cmd.Parameters.AddWithValue("@Created_By", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@PostID", ddlPosts.SelectedValue);
            
            if (chkboxSelection.Checked)
            {
                cmd.Parameters.AddWithValue("@Emp_Id", ddlOuterEmployee.SelectedValue);
                cmd.Parameters.AddWithValue("@emptype", "OuterEmployee");
            }
            else
            {
                cmd.Parameters.AddWithValue("@Emp_Id", DDL_Employee.SelectedValue);            
            }
            cmd.Parameters.Add("@status", SqlDbType.Int);
            cmd.Parameters["@status"].Direction = ParameterDirection.Output;
            

            cmd.ExecuteNonQuery();

            string status=Convert.ToString( cmd.Parameters["@status"].Value);

            if (@status=="0")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Data is save Successfully";
                lblMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "This Employee  Already Exists";
                lblMsg.ForeColor = System.Drawing.Color.Red;

            }

            GetInterviewPanel();
            GetOuterEmployeesForGrid();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void RemoveOuterFaculty_Click(object sender, EventArgs e)
    {
       LinkButton lnkbutton =sender as LinkButton;   
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM OuterEmployeeForPanel where OuterEmployee_ID=@OuterEmployee_ID", con);
            cmd.Parameters.AddWithValue("@OuterEmployee_ID", lnkbutton.CommandArgument);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gridviewOuterEmployee.DataSource = dt;
            gridviewOuterEmployee.DataBind();
            GetOuterEmployeesForGrid();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }

    
    protected void lbtnRemove_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM Interview_Panel_ofAdvertised_Jobs where Interview_Panel_Id=@Interview_Panel_Id", con);
            cmd.Parameters.AddWithValue("@Interview_Panel_Id",lbtn.CommandArgument);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GetInterviewPanel();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    private void GetDepartment()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT Dept_ID, Dept_Name FROM Department", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Department.DataSource = dt;
            DDL_Department.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    private void GetEmployees()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT EmpID,ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') as Employee_Name FROM Employee where ActiveStatus=1 and DeptID=@Dept_Id", con);
            cmd.Parameters.AddWithValue("@Dept_Id", DDL_Department.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Employee.DataSource = dt;
            DDL_Employee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    protected void DDL_Department_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEmployees();
    }

    private void GetInterviewPanel()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_GetInterviewPanel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    private void GetDtalist()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("OuterEmployeeDetail", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", ddlOuterEmployee.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            tempEmployyDatalist.DataSource=dt;
            tempEmployyDatalist.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    protected void chkboxSelection_CheckedChanged(object sender, EventArgs e)
    {
        if (chkboxSelection.Checked)
        {

            divddlOuterEmployee.Visible = true;
            empDetailouter.Visible = true;
            GetOuterEmployees();
            GetDtalist();

            department.Visible = false;
            employee.Visible = false;
            lblMsg.Visible = false;   
            
        }
        else
        {

            department.Visible = true;
            employee.Visible = true;
            GetDepartment();
            GetEmployees();            
            divddlOuterEmployee.Visible = false;
            empDetailouter.Visible = false;
            lblMsg.Visible = false;
        }
    }
    protected void ddlOuterEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    private void GetOuterEmployees()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("select OuterEmployee_ID,employeename from OuterEmployeeForPanel ", con);
           
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlOuterEmployee.DataSource = dt;
            ddlOuterEmployee.DataValueField = "OuterEmployee_ID";
            ddlOuterEmployee.DataTextField = "employeename";
            ddlOuterEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    private void GetOuterEmployeesForGrid()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand(@"select *,OuterEmployee_ID,d.Ad_Title from OuterEmployeeForPanel a inner join Interview_Panel_ofAdvertised_Jobs b  inner join Advertisement_Main d on d.Ad_Id=b.Ad_Id
on a.OuterEmployee_ID=b.Emp_Id where b.emptype='OuterEmployee' and  b.Ad_Id=" + DDL_Advertisement.SelectedValue + "", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gridviewOuterEmployee.DataSource = dt;
            gridviewOuterEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }    
    protected void DDL_Employee_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetDtalist();
    }
    private void GetEmployyDetail(string id)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("select * from OuterEmployeeForPanel where OuterEmployee_ID="+id+"", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void lnkbtnAddOuterEmployee_Click(object sender, EventArgs e)
    {
        string url = "./OuterEmployeeForInterview.aspx";

        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());
    
    }    
    protected void DDL_EmployeeOuter_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {

        GetInterviewPanel();
        GetOuterEmployeesForGrid();
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue); ;
    }
    private void GetAllAdvertisementPosts(string ID)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT Ad_Sub_Id, Ad_Id, Title, Posts, Pay_Scale, Description, Qualification, Experience"
                                    + " FROM Advertisement_Sub where Ad_Id=@Ad_Id", con);
            cmd.Parameters.AddWithValue("@Ad_Id", ID);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlPosts.DataSource = dt;
            ddlPosts.DataValueField = "Ad_Sub_Id";
            ddlPosts.DataTextField = "Title";
            ddlPosts.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void ddlPosts_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}