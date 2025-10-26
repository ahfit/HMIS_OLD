using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_Advertisement_New_Advertisement : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            From_Date.Value = DateTime.Now;
            To_Date.Value = DateTime.Now.AddDays(15);
            GetAllAdvertisements();
        }
    }

    private void InsertAdvertisement()
    {
        SqlCommand cmd=new SqlCommand();
        SqlConnection con = new SqlConnection(conString);
        try
        {
            if (txtTitle.Text != "" && txtDescription.Text != "")
            {
                con.Open();
                if (btnAdd.CommandArgument != "")
                {
                    cmd = new SqlCommand("UPDATE Advertisement_Main SET Ad_No=@Ad_No, Ad_Title =@Ad_Title, Description =@Description, Start_Date =@Start_Date, End_Date =@End_Date where Ad_Id=@Ad_Id", con);
                    cmd.Parameters.AddWithValue("@Ad_Id", btnAdd.CommandArgument);
                    btnAdd.CommandArgument = "";
                    btnAdd.Text = "Add";
                
                }
                else
                {
                    cmd = new SqlCommand("usp_InsertAdvertisementMain", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Created_On", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Created_By", Session["emp_id"]);
                }

                cmd.Parameters.AddWithValue("@Ad_No", txtAdNo.Text);
                cmd.Parameters.AddWithValue("@Ad_Title", txtTitle.Text);
                cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
                cmd.Parameters.AddWithValue("@Start_Date", From_Date.Value.ToString());
                cmd.Parameters.AddWithValue("@End_Date", To_Date.Value.ToString());
             
                cmd.ExecuteNonQuery();
                txtAdNo.Text = "";
                txtTitle.Text = "";
                txtDescription.Text = "";
                GetAllAdvertisements();
            }
            else
            {
                lblMsg.Text = "Enter Title or Description";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        InsertAdvertisement();
    }

    private void GetAllAdvertisements()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("select Ad_No, Ad_Id,Ad_Title,Description,Start_Date,End_Date from Advertisement_Main", con);
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

    protected void lbtnAddPosts_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        btnAddPost.CommandArgument = lbtn.CommandArgument;
        PanelAddPosts.Visible = true;
        PanelQuotaPosts.Visible = false;
        GetAllAdvertisementPosts();
    }
    protected void btnAddPost_Click(object sender, EventArgs e)
    {
        InsertAdvertisementPosts();
        GetAllAdvertisementPosts();
    }
    private void InsertAdvertisementPosts()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            if (txtPostsTitle.Text != "" && txtPosts.Text != "" && txtPayScale.Text != "" && txtPostsDescription.Text != "")
            {
                con.Open();
                cmd = new SqlCommand("usp_InsertAdvertisementPosts", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Ad_Id", btnAddPost.CommandArgument);
                cmd.Parameters.AddWithValue("@Title", txtPostsTitle.Text);
                cmd.Parameters.AddWithValue("@Posts", txtPosts.Text);
                cmd.Parameters.AddWithValue("@Pay_Scale", txtPayScale.Text);
                cmd.Parameters.AddWithValue("@Description", txtPostsDescription.Text);
                cmd.Parameters.AddWithValue("@Qualification", txtPostQualification.Text);
                cmd.Parameters.AddWithValue("@Experience", txtPostExperience.Text);
                cmd.Parameters.AddWithValue("@Created_On", DateTime.Now);
                cmd.Parameters.AddWithValue("@Created_By", Session["emp_id"]);
                cmd.Parameters.AddWithValue("@agelimit", txtboxOverAge.Text);
                cmd.Parameters.AddWithValue("@agelimitd", txtboxUnderAge.Text);
                cmd.Parameters.AddWithValue("@division", txtboxDivision.Text);
                cmd.Parameters.AddWithValue("@documentsrequired", txtboxdocumentsrequired.Text);


                cmd.ExecuteNonQuery();
                txtPostsTitle.Text = "";
                txtPosts.Text = "";
                txtPayScale.Text = "";
                txtPostsDescription.Text = "";
                txtPostQualification.Text = "";
                txtPostExperience.Text = "";

            }
            else
            {
                lblMsg.Text = "Enter Title or Description";
                lblMsg.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    private void GetAllAdvertisementPosts()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT Ad_Sub_Id, Ad_Id, Title, Posts, Pay_Scale, Description, Qualification, Experience"
                                    + " FROM Advertisement_Sub where Ad_Id=@Ad_Id", con);
            cmd.Parameters.AddWithValue("@Ad_Id", btnAddPost.CommandArgument);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridViewPosts.DataSource = dt;
            GridViewPosts.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void lbtnDeletePosts_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM Advertisement_Sub where Ad_Sub_Id=@Ad_Sub_Id", con);
            cmd.Parameters.AddWithValue("@Ad_Sub_Id", lbtn.CommandArgument);
            cmd.ExecuteNonQuery();
            GetAllAdvertisementPosts();

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void lbtnAddQuota_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        btnAddQuotaPosts.CommandArgument = lbtn.CommandArgument;
        PanelQuotaPosts.Visible = true;
        PanelAddPosts.Visible = false;
        LoadPosts();
        GetAllQuotaPosts();
        if (DDL_Posts.Items.Count == 0)
        {
            btnAddQuotaPosts.Visible = false;
        }
    }
    protected void btnAddQuotaPosts_Click(object sender, EventArgs e)
    {
        InsertQuotaForPosts();
        LoadPosts();
        GetAllQuotaPosts();
    }

    private void LoadPosts()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("select  Ad_Sub_Id,Title,Posts from Advertisement_Sub where Ad_Id=@Ad_Id", con);
            cmd.Parameters.AddWithValue("@Ad_Id", btnAddQuotaPosts.CommandArgument);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Posts.DataSource = dt;
            DDL_Posts.DataBind();

            DDL_Posts_Qty.DataSource = dt;
            DDL_Posts_Qty.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    protected void DDL_Posts_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Posts_Qty.SelectedValue = DDL_Posts.SelectedValue;
    }

    private void InsertQuotaForPosts()
    {
        if (Convert.ToInt32(txtQuotaPosts.Text) > Convert.ToInt32(DDL_Posts_Qty.SelectedItem.ToString()))
        {
            lblQuotaMsg.Text = "Enter Valid Quantity";
            lblQuotaMsg.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            SqlCommand cmd;
            SqlConnection con = new SqlConnection(conString);
            try
            {
                if (txtQuotaFor.Text != "" && txtQuotaPosts.Text != "")
                {
                    con.Open();
                    cmd = new SqlCommand("usp_InsertQuotaForPosts", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Ad_Id", btnAddQuotaPosts.CommandArgument);
                    cmd.Parameters.AddWithValue("@Ad_Post_Id", DDL_Posts.SelectedValue);
                    cmd.Parameters.AddWithValue("@Post_For", txtQuotaFor.Text);
                    cmd.Parameters.AddWithValue("@Posts", txtQuotaPosts.Text);
                    cmd.Parameters.AddWithValue("@Created_On", DateTime.Now);
                    cmd.Parameters.AddWithValue("@Created_By", Session["emp_id"]);
                    cmd.ExecuteNonQuery();
                    txtQuotaFor.Text = "";
                    txtQuotaPosts.Text = "";
                    GetAllQuotaPosts();
                }
                else
                {
                    lblMsg.Text = "Enter Quota Posts or Name";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                con.Close();
            }
        }
    }

    private void GetAllQuotaPosts()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_GetQuotaPosts", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", btnAddQuotaPosts.CommandArgument);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridViewQuotaPosts.DataSource = dt;
            GridViewQuotaPosts.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }


    protected void lbtnDeleteQuotaPosts_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conString);
        try
        {
            con.Open();
            cmd = new SqlCommand("DELETE FROM Quota_For_Advertised_Posts where Post_Quota_Id=@Post_Quota_Id", con);
            cmd.Parameters.AddWithValue("@Post_Quota_Id", lbtn.CommandArgument);
            cmd.ExecuteNonQuery();
            GetAllQuotaPosts();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void lbtnEdit_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lbtn.NamingContainer;
        Label title = (Label)row.FindControl("lblTitle");
        Label lblAdNo = (Label)row.FindControl("lblAdNo");
        TextBox GridtxtDescription = (TextBox)row.FindControl("GridtxtDescription");
        Label GridlblStart_Date = (Label)row.FindControl("GridlblStart_Date");
        Label GridlblEnd_Date = (Label)row.FindControl("GridlblEnd_Date");
        txtTitle.Text = title.Text;
        txtAdNo.Text= lblAdNo.Text;
        txtDescription.Text = GridtxtDescription.Text;
        From_Date.Value = Convert.ToDateTime(GridlblStart_Date.Text);
        To_Date.Value = Convert.ToDateTime(GridlblEnd_Date.Text);
        btnAdd.CommandArgument = title.ToolTip;
        btnAdd.Text = "Update";
    }
}