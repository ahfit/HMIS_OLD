using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OT_Management_MainHeading : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OT_ManagementConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            loadgride();           
        }

    }

   

    private void loadgride()
    {
       
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT HeadingId,Name,Type FROM MainHeading where isnull(Active,0)=1", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        gridFactor.DataSource = ds;
        gridFactor.DataBind();
        con.Close();
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("insert into MainHeading (Name,Type, Active) values (@Name,@Type,'true')", con);
        cmd.Parameters.AddWithValue("@Name",TextBoxName.Text);
        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();
    }
    protected void btn_Edit(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();
     
        SqlCommand cmd = new SqlCommand("update MainHeading set Active='false' where HeadingId = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();

    }
    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();

        SqlCommand cmd = new SqlCommand("update MainHeading set Active='false' where HeadingId = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();

    }


}