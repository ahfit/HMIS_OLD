using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_Advertisement_Advertisement_Status : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetAllActiveAdvertisement();
        }
    }
    private void GetAllActiveAdvertisement()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_getActiveAdvertisement", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Is_Active",DDL_AD_Status.SelectedValue);
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

    protected void lbtnChangeStatus_Click(object sender, EventArgs e)
    {
        LinkButton lbtn=(LinkButton)sender;
        int status;
        if (lbtn.ToolTip=="False")
        {
            status = 1;
        }
        else
        {
            status = 0;
        }
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("Update Advertisement_Main set Is_Active=@status where Ad_Id=@Ad_Id", con);
            cmd.Parameters.AddWithValue("@Ad_Id",lbtn.CommandArgument);
            cmd.Parameters.AddWithValue("@status",status);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            GetAllActiveAdvertisement();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void DDL_AD_Status_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllActiveAdvertisement();
    }
}