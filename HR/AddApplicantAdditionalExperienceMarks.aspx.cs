using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class HR_AddApplicantAdditionalExperienceMarks : System.Web.UI.Page
{

    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
        }
    }


    private void GetAllActiveAdvertisement()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT  Ad_Title, Ad_Id FROM Advertisement_Main where Is_Active=1", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Advertisement.DataSource = dt;
            DDL_Advertisement.DataTextField = "Ad_Title";
            DDL_Advertisement.DataValueField = "Ad_Id";
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

    private void GetAllAdvertisementPosts(string ID)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
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
            ddlPosts.Items.Insert(0, new ListItem() { Text = "", Value = "" });

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
        
    }

    protected void ddlPosts_SelectedIndexChanged(object sender, EventArgs e)
    {
        //idAdditionalMarks.Visible = true;
        //idExperience.Visible = true;

          SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("getAdditionalExperienceMarks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);             
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvd.DataSource = dt;
            gvd.DataBind();

            ddlQualification.DataSource = dt;
            ddlQualification.DataValueField="Qualification_Id";
            ddlQualification.DataTextField = "Qualification_Name";
            ddlQualification.DataBind();


        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }        
    }
    protected void btnSarch_Click(object sender, EventArgs e)
    {
         SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("setexperienceAndAdditionalMarks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ad_id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@QID", ddlQualification.SelectedValue);    
            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvdAddMarks.DataSource = dt;
            gvdAddMarks.DataBind();
            

        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }        


        
    }


    protected void btn_Click(object sender, EventArgs e) {
        Button btn=sender as Button;
        GridViewRow row=btn.NamingContainer as GridViewRow;
        Label lblAppID=row.FindControl("lblAppID") as Label;
        TextBox marks=row.FindControl("txtAddAddMarks") as TextBox;
        Label merit = row.FindControl("lblMerit") as Label;
        Label perID = row.FindControl("lblAppPercentageID") as Label;
        
        
        
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("UspAddApplicantPercentageofMarks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@PostID", ddlPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@AdID", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@AppID",lblAppID.Text );
            cmd.Parameters.AddWithValue("@QID", ddlQualification.SelectedValue);
            cmd.Parameters.AddWithValue("@MarksPercentage", marks.Text);
            cmd.Parameters.AddWithValue("@MeritID", merit.Text);
            
            

            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    
    }

    protected void gvd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hfqid = e.Row.FindControl("hfQid") as HiddenField;
            Session["QID"] = hfqid.Value;

            HiddenField hfMERIT = e.Row.FindControl("hfMeritID") as HiddenField;
            Session["MID"] = hfMERIT.Value;
        }
    }
    protected void txtAddAddMarks_TextChanged(object sender, EventArgs e)
    {
        

        //TextBox txtboxMarks=sender as TextBox;
        //GridViewRow gridview = txtboxMarks.NamingContainer as GridViewRow;
        //Label lbl=gridview.FindControl("lblMarks") as Label;
        
        
        //string marks=txtboxMarks.Text;

        //if (marks == Session["QID"].ToString())
        //{
        //    lbl.Visible = true;
        //}
        //else
        //{
        //    lbl.Visible = false;
        //}

    }

    protected void txtAddExperience_TextChanged(object sender, EventArgs e)
    {
        //TextBox txtboxExperience = sender as TextBox;

        //GridView gridview = txtboxExperience.NamingContainer as GridView;
        //Label lbl = gridview.FindControl("lblexperience") as Label;

        //string experience=txtboxExperience.Text;

        //if (experience == Session["MID"].ToString())
        //{
        //    lbl.Visible = true;
        //}
        //else
        //{
        //    lbl.Visible = false;
        //}
    }

    

}