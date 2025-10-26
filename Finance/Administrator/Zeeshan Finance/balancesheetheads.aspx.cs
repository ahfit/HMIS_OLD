using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Finance_balancesheetheads : System.Web.UI.Page
{
    string z = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            getgrddata();
        }
    }

    
    protected void btnsave_Click(object sender, EventArgs e)
    {
        insertupdatedataintotables();
        btnsave.Text = "Save";
        cleardata();
    }

    protected void insertupdatedataintotables()
    {

        using (SqlConnection con = new SqlConnection(z))
        {
            SqlCommand cmd = new SqlCommand("uspinsertbalancesheetheads", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Balance_Sheet_Id", balance_sheet_id.Text);
            cmd.Parameters.AddWithValue("@Main_Heading", main_heading.Text);
            cmd.Parameters.AddWithValue("@Sub_Heading", sub_heading.Text);
            cmd.Parameters.AddWithValue("@Sort_Order", sort_order.Text);
            cmd.Parameters.AddWithValue("@Notes", notes.Text);
            cmd.Parameters.AddWithValue("@MainSort_Order", main_sort_order.Text);
            cmd.Parameters.AddWithValue("@Group_type", group_type.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            getgrddata();
        }
    }

    protected void getgrddata()
    {

        using (SqlConnection con = new SqlConnection(z))
        {
            SqlCommand cmd = new SqlCommand("Select * from Balance_Sheet_Heads ", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    
    
    protected void LinkButton(object sender, EventArgs e)
    {
        Button Editbtn = (Button)sender;
        GridViewRow row = (GridViewRow)Editbtn.NamingContainer;
        Label n = (Label)row.FindControl("blncid");
        balance_sheet_id.Text = n.Text;
        Label a = (Label)row.FindControl("mnhdng");
        main_heading.Text = a.Text;
        Label b = (Label)row.FindControl("sbhdng");
        sub_heading.Text = b.Text;
        Label c = (Label)row.FindControl("srtordr");
        sort_order.Text = c.Text;

        Label d = (Label)row.FindControl("notes");
        notes.Text = d.Text;
        Label f = (Label)row.FindControl("mnsrtordr");
        main_sort_order.Text = f.Text;

        Label g = (Label)row.FindControl("grptype");
        group_type.SelectedValue = g.Text;

        btnsave.Text = "Update";
        
        main_heading.Focus();
    }

    protected void cleardata() {

        balance_sheet_id.Text = String.Empty;
        main_heading.Text = String.Empty;
        sub_heading.Text = String.Empty;
        sort_order.Text = String.Empty;
        notes.Text = String.Empty;
        main_sort_order.Text = String.Empty;

    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        cleardata();
        btnsave.Text = "Save";
    }

  
}
