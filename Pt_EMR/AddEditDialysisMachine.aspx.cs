using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pt_EMR_AddEditDialysisMachine : System.Web.UI.Page

{
    // SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindSubDepartment();
            bindSession();
            bindGrid();
        }
    }

    private void bindGrid()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select m.id, m.MachineName, SubDepartment.SubDept_Name, m.Datetime, ap.Session_Name, isnull(e.EFName,'')+' '+ isnull(e.EMName,'')+' '+isnull(e.ELName,'') as Name from Machine_Name m join Employee e on e.EmpID=m.Createdby join Appointment_Sessions ap on ap.Session_ID=m.Session_id join SubDepartment on SubDepartment.SubDept_Id=m.Subdept_id", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        gridview.DataSource = dt;
        gridview.DataBind();
        gridview.DataBind();
        con.Close();

    }
    protected void deleteRecord(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;      
        string conString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        con.Open();
        SqlCommand cmd = new SqlCommand("delete from Machine_Name where id="+btn.CommandName+"", con);
        cmd.ExecuteNonQuery();
        con.Close();
        bindGrid();
    }
    protected void bindSubDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDepartment.SubDept_Name,SubDepartment.SubDept_Id,SubDepartment.Dept_Id FROM SubDepartment", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlsubdepartment.DataSource = dt;
        ddlsubdepartment.DataBind();
        con.Close();
    }


    protected void ddlsubdepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSession();
    }

    private void bindSession()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select Session_ID, Session_Name from Appointment_Sessions where SubDept_ID=@subdeptid", con);
        cmd.Parameters.AddWithValue("@subdeptid", ddlsubdepartment.SelectedValue);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlSession.DataSource = dt;
        ddlSession.DataBind();
        con.Close(); 
    }
    
    protected void btn_save_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("insert into Machine_Name(Subdept_id,Session_id,MachineName,Datetime,Createdby) values (@Subdept_id,@Session_id,@MachineName,GETDATE(),@Createdby)", con);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Subdept_id", ddlsubdepartment.SelectedValue);
        cmd.Parameters.AddWithValue("@Session_id", ddlSession.SelectedValue);
        cmd.Parameters.AddWithValue("@MachineName", textMachine.Text);
        cmd.Parameters.AddWithValue("@Createdby", Session["emp_id"]);
        cmd.ExecuteNonQuery();
        bindGrid();
        lblmsg.ForeColor = System.Drawing.Color.Green;
        lblmsg.Visible = true;
        con.Close();

    }
}
