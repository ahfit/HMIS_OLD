using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OT_Management_Questions : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OT_ManagementConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetHeadings();
            GetQuestions();
        }

    }


    protected void GetQuestions()
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("select rh.Name,rh.HeadingId,rd.Details,rd.QuestionId from MainHeading rh join Questions rd on rh.HeadingId=rd.HeadingId where isnull(rd.Active,0)=1 and rh.HeadingId= @HeadingId", con);

        cmd.Parameters.AddWithValue("@HeadingId", ddlHeading.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        gridsDetails.DataSource = ds;
        gridsDetails.DataBind();
        con.Close();
    }

    protected void GetHeadings()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select Name,HeadingId from MainHeading where Type=@Type and Active=1", con);
        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlHeading.DataSource = dt;
        ddlHeading.DataTextField = "Name";
        ddlHeading.DataValueField = "HeadingId";
        ddlHeading.DataBind();
        con.Close();
    }

    protected void btnsave2_Click1(object sender, EventArgs e)
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("insert into Questions (Details,HeadingId,Active) values (@Details,@HeadingId,'true')", con);
        cmd.Parameters.AddWithValue("@Details", Txtdetail.Text);
        cmd.Parameters.AddWithValue("@HeadingId", ddlHeading.SelectedValue);

        cmd.ExecuteNonQuery();
        con.Close();
        GetQuestions();
    }

    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();

        SqlCommand cmd = new SqlCommand("update Questions set Active='false' where QuestionId   = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        GetQuestions();
    }

    protected void ddlHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetQuestions();
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetHeadings();
        GetQuestions();
    }
}