using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class HR_Manage_Qualification  : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            get_allQualifications();
        }
    }






    protected void btnSave_Click(object sender, System.EventArgs e)
    {
        if (btnSave.Text == "Save")
        {
            if (!string.IsNullOrEmpty(txtQualiName.Text.Trim()))
            {
                create_new_Qualification();
                get_allQualifications();
                txtQualiName.Text = "";
            }
        }
        if (btnSave.Text == "Update")
        {
            update_Qualification();

        }

    }

    protected void btnUpdate_Click(object sender, System.EventArgs e)
    {
        LinkButton btnTemp = sender as LinkButton;
        long recordId = long.Parse(btnTemp.CommandArgument);
        btnSave.Text = "Update";
        GridViewRow gvRow = (GridViewRow)btnTemp.NamingContainer;
        Label Label1 = (Label)gvRow.FindControl("Label1");
        Label Label2 = (Label)gvRow.FindControl("Label2");
        txtQualiName.Text = Label2.Text;
        hdfProgID.Value = recordId.ToString();
    }

    private void get_allQualifications()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("SELECT     Qualifications.Qualification_Id, Qualifications.Qualification_Name, Employee.Name as Created_By,Created_On FROM         Qualifications INNER JOIN" +
                      " Employee ON Qualifications.Created_By = Employee.EmpID WHERE     (Qualifications.Is_deleted is NULL)", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }



    protected void btnDelete_Click(object sender, EventArgs e)
    {
        ImageButton ibtn = (ImageButton)sender;
        int program_id = Convert.ToInt32(ibtn.CommandArgument);
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("update Qualifications set is_deleted=@is_deleted where Qualification_Id=@Qualification_Id", con);
            cmd.Parameters.AddWithValue("@Qualification_Id", program_id);
            cmd.Parameters.AddWithValue("@is_deleted", 1);
            cmd.ExecuteNonQuery();
            get_allQualifications();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }


    private void update_Qualification()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("update Qualifications set Qualification_Name=@Name where Qualification_Id=@Qualification_Id", con);
            cmd.Parameters.AddWithValue("@Qualification_Id", hdfProgID.Value);
            cmd.Parameters.AddWithValue("@Name", txtQualiName.Text);
            cmd.ExecuteNonQuery();
            con.Close();

            btnSave.Text = "Save";
            txtQualiName.Text = "";

            get_allQualifications();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }

    private void create_new_Qualification()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("usp_InsertNewQualification", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Qualification_Name", txtQualiName.Text);
            cmd.Parameters.AddWithValue("@Created_On", DateTime.Now);
            cmd.Parameters.AddWithValue("@Created_By", Session["emp_id"]);
            cmd.ExecuteNonQuery();
            con.Close();
            btnSave.Text = "Save";
            txtQualiName.Text = "";
            get_allQualifications();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
}