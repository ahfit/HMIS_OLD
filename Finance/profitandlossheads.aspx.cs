using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;

public partial class Finance_profitandlossheads : System.Web.UI.Page
{
    string z = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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
            SqlCommand cmd = new SqlCommand("uspinsertprofitandlossheads", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@PL_Id", PL_id.Text);
            cmd.Parameters.AddWithValue("@Main_Heading", main_heading.Text);
            cmd.Parameters.AddWithValue("@Sub_Heading", sub_heading.Text);
            cmd.Parameters.AddWithValue("@Sub_Heading2", sub_heading2.Text);
            cmd.Parameters.AddWithValue("@Sort_Order", sort_order.Text);
            cmd.Parameters.AddWithValue("@Notes", notes.Text);
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
            SqlCommand cmd = new SqlCommand("Select * from ProfitAndLossHeads ", con);
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
        Label n = (Label)row.FindControl("plid");
        PL_id.Text = n.Text;
        Label a = (Label)row.FindControl("mnhdng");
        main_heading.Text = a.Text;
        Label b = (Label)row.FindControl("sbhdng");
        sub_heading.Text = b.Text;
        Label c = (Label)row.FindControl("sbhdng2");
        sub_heading2.Text = c.Text;

        Label d = (Label)row.FindControl("notes");
        notes.Text = d.Text;
        Label f = (Label)row.FindControl("srtordr");
        sort_order.Text = f.Text;

        Label g = (Label)row.FindControl("grptype");
        group_type.SelectedValue = g.Text;

        btnsave.Text = "Update";

        main_heading.Focus();
    }

    protected void cleardata()
    {

        PL_id.Text = String.Empty;
        main_heading.Text = String.Empty;
        sub_heading.Text = String.Empty;
        sub_heading2.Text = String.Empty;
        sort_order.Text = String.Empty;
        notes.Text = String.Empty;

    }

    protected void btnClear_Click(object sender, EventArgs e)
    {
        cleardata();
        btnsave.Text = "Save";
    }

}