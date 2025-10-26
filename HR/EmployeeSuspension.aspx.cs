using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_EmployeeSuspension : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Suspensiondatewebchooser.Value = DateTime.Now.ToString();
            lastworkdaywebchooser.Value = DateTime.Now.ToString();

            LoadGrid();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("insertEmployeeSuspension", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@FromDate", Suspensiondatewebchooser.Value);
            cmd.Parameters.AddWithValue("@ToDate", lastworkdaywebchooser.Value);
            cmd.Parameters.AddWithValue("@Reason", tbxresgreason.Text);
            cmd.Parameters.AddWithValue("@Remarks", tbxremarks.Text);
            cmd.Parameters.AddWithValue("@EmpID", Request.QueryString["empid"]);
            cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Status", ddllistSuspension.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@StatusForEmp", ddllistSuspension.SelectedItem.Value);
            

            cmd.ExecuteNonQuery();

            LoadGrid();
            panel.Visible = false;
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally { }

    }

    

        private void LoadGridForHistory()
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("selectEmpProbationDetail_History", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpID", Request.QueryString["empid"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvHistory.DataSource = dt;
            gvHistory.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally { }
         
    }

    private void LoadGrid()
    {
        SqlCommand cmd = new SqlCommand();
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("selectEmpProbationDetail", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpID", Request.QueryString["empid"]);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            grdEmpSuspension.DataSource = dt;
            grdEmpSuspension.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally { }
         
    }
     
    protected void btnAddSuspension_Click(object sender, EventArgs e)
    {
        panel.Visible = true;
        LoadGridForHistory();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
    }
}