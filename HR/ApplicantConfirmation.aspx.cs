using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class HR_ApplicantConfirmation : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            GetAllAdvertisements();
            GetAllAdvertisementPosts(DDL_Advertizement.SelectedValue);
            selectedCanidates(DDL_Advertizement.SelectedValue, DDL_Posts.SelectedValue);        


            //if (Request.QueryString["appid"] != null)
            //{
            //    ddlCandidates.SelectedValue = Request.QueryString["appid"];
            //}
            //if (Request.QueryString["postid"] != null)
            //{
            //    DDL_Posts.SelectedValue = Request.QueryString["postid"].ToString();
            //}
            //if (Request.QueryString["ad_id"] != null)
            //{
            //    DDL_Advertizement.SelectedValue = Request.QueryString["ad_id"].ToString();
            //}

            WebDateJoinDate.Value = DateTime.Now.Date;
            WDCapproval.Value = DateTime.Now.Date;

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspInsertApplicantConfirmationAfterSelection", con);

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertizement.SelectedValue);
            cmd.Parameters.AddWithValue("@PostId", DDL_Posts.SelectedValue);
            cmd.Parameters.AddWithValue("@JoiningDate", WebDateJoinDate.Value);
            cmd.Parameters.AddWithValue("@ApprovalDate", WDCapproval.Value);
            cmd.Parameters.AddWithValue("@ApproveBy", ddRecBy.SelectedValue);
            cmd.Parameters.AddWithValue("@Remarks", tbxRemarks.Text);
            cmd.Parameters.AddWithValue("@ApplicantID", ddlCandidates.SelectedValue);
            cmd.Parameters.AddWithValue("@salary", txtboxSalary.Text);
            
            cmd.ExecuteNonQuery();
            con.Close();
            lblMsg.Visible = true;
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    private void GetAllAdvertisements()
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("select Ad_Id,Ad_Title from Advertisement_Main order by Ad_Title", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            DDL_Advertizement.DataSource = dt;
            DDL_Advertizement.DataValueField = "Ad_Id";
            DDL_Advertizement.DataTextField = "Ad_Title";
            DDL_Advertizement.DataBind();
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
            DDL_Posts.DataSource = dt;
            DDL_Posts.DataValueField = "Ad_Sub_Id";
            DDL_Posts.DataTextField = "Title";
            DDL_Posts.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    private void selectedCanidates(string advertismentid,string postid)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand(@" SELECT     Applicant.AppID,ISNULL( Applicant.AppName,'')+' '+ISNULL(Applicant.AppMName,'')+' '+ISNULL(Applicant.AppLName,'') as name
FROM         Applicant INNER JOIN

Applicant_Applied_forPost apfp on Applicant.AppID=apfp.AppId 
INNER JOIN
   Advertisement_Main ON apfp.Ad_Id = Advertisement_Main.Ad_Id

                      
                       INNER JOIN
                      Advertisement_Sub ON apfp.post_id = Advertisement_Sub.Ad_Sub_Id INNER JOIN
                      CallForInterView ON Applicant.AppID = CallForInterView.AppID  
                      where apfp.Ad_Id=" + advertismentid+ " and apfp.post_id=" + postid + " and CallForInterView.Is_Selected=1", con);
            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCandidates.DataSource = dt;
            ddlCandidates.DataValueField = "AppID";
            ddlCandidates.DataTextField = "name";
            ddlCandidates.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }


    
    protected void DDL_Advertizement_SelectedIndexChanged(object sender, EventArgs e)
    {        
        GetAllAdvertisementPosts(DDL_Advertizement.SelectedValue);        
        selectedCanidates(DDL_Advertizement.SelectedValue, DDL_Posts.SelectedValue);
    }

    protected void ddlCandidates_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void DDL_Advertizement_SelectedIndexChanged1(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertizement.SelectedValue);
    }
    protected void DDL_Posts_SelectedIndexChanged(object sender, EventArgs e)
    {        
        selectedCanidates(DDL_Advertizement.SelectedValue, DDL_Posts.SelectedValue);

    }
}