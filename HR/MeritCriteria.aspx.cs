using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class HR_MeritCriteria : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
            GetAllQualification();
            GetAllQualificationForGrid();
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
        GetAllQualificationForGrid();
    }


    private void GetAllQualification()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("select q.Qualification_Id,q.Qualification_Name from Qualifications q where q.Is_deleted is null", con);            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlQualification.DataSource = dt;
            ddlQualification.DataValueField = "Qualification_Id";
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (btnSave.Text != "Update")
        {
            float data = checkMeritOFPost();
            if (!((data + float.Parse(txtboxPercentage.Text)) > 100))
            {
                SqlCommand cmd;
                SqlConnection con = new SqlConnection(_conStr);
                try
                {
                    con.Open();
                    cmd = new SqlCommand("InsertMeritCriteria", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                    cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                    cmd.Parameters.AddWithValue("@qualificationid", ddlQualification.SelectedValue);
                    cmd.Parameters.AddWithValue("@createdby", Session["emp_id"]);
                    cmd.Parameters.AddWithValue("@creadteddate", DateTime.Now.ToString());
                    cmd.Parameters.AddWithValue("@percentage", txtboxPercentage.Text);
                    cmd.Parameters.AddWithValue("@isFixed", chkboxSelect.Checked);
                    cmd.Parameters.AddWithValue("@isAdd", CHKAd.Checked);
                    
                    cmd.ExecuteNonQuery();

                    lblmsg.Text = "Data is Save Successfully";
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    GetAllQualificationForGrid();
                }

                catch (Exception ex)
                {
                }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                lblmsg.Text = "Merit is exceed 100 Percent";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }

        }
        else
        {
            string finaldata = Session["finalData"].ToString();
            if (!((float.Parse(finaldata) + float.Parse(txtboxPercentage.Text)) > 100))
            {
                SqlCommand cmd;
                SqlConnection con = new SqlConnection(_conStr);
                try
                {
                    con.Open();
                    cmd = new SqlCommand("UpdateMeritCriteria", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                    cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                    cmd.Parameters.AddWithValue("@qualificationid", ddlQualification.SelectedValue);
                    cmd.Parameters.AddWithValue("@createdby", Session["emp_id"]);
                    cmd.Parameters.AddWithValue("@creadteddate", DateTime.Now.ToString());
                    cmd.Parameters.AddWithValue("@percentage", txtboxPercentage.Text);
                    cmd.Parameters.AddWithValue("@MeritID", hfMeritID.Value);
                    cmd.Parameters.AddWithValue("@isFixed", chkboxSelect.Checked);
                    cmd.Parameters.AddWithValue("@isAdd", CHKAd.Checked);

                    cmd.ExecuteNonQuery();

                    btnSave.Text = "Save";
                    btnCancel.Visible = false;
                    lblmsg.Text = "Data is Updated Successfully";
                    lblmsg.ForeColor = System.Drawing.Color.Green;
                    GetAllQualificationForGrid();

                    ddlPosts.Enabled = true;
                    DDL_Advertisement.Enabled = true;
                    ddlPosts.Enabled = true;
                }
                catch { }
                finally
                {
                    con.Close();
                }
            }
            else
            {
                lblmsg.Text = "Merit is exceed 100 Percent";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }

        }

}




    private void GetAllQualificationForGrid()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspmerircriteriaList", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@adID",DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid",ddlPosts.SelectedValue);
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



    private float checkMeritOFPost()
    {

        string status = "";
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("checkMeritCriteria", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            cmd.Parameters.Add("@status", SqlDbType.Int);
            cmd.Parameters["@status"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            status = cmd.Parameters["@status"].Value.ToString();

        }
        catch { }
        finally { con.Close(); }
        return float.Parse(status);
    }


    protected void btnUpdate_Click(object sender, EventArgs e) {

         float data = checkMeritOFPost();
        

         //if (!((data + int.Parse(txtboxPercentage.Text)) > 100))
         //{
             ImageButton btn = sender as ImageButton;

             HiddenField qualificationID = (HiddenField)btn.NamingContainer.FindControl("hfqualificationID");
             HiddenField Percentage = (HiddenField)btn.NamingContainer.FindControl("hfPercentage");
             HiddenField fix = (HiddenField)btn.NamingContainer.FindControl("HfIsFixed");
             HiddenField Addi = (HiddenField)btn.NamingContainer.FindControl("HfIsAdditional");


             string MeritID = btn.CommandArgument;
             hfMeritID.Value = MeritID;
             ddlQualification.SelectedValue = qualificationID.Value;


             DDL_Advertisement.Enabled = false;
             ddlPosts.Enabled = false;
             ddlQualification.Enabled = false;
             txtboxPercentage.Text = Percentage.Value;
             chkboxSelect.Checked = Convert.ToBoolean(fix.Value);
             CHKAd.Checked = Convert.ToBoolean(Addi.Value);

             string[] split = Percentage.Value.Split('.');


             Session["finalData"] = (data - int.Parse(split[0])).ToString();
        
        btnSave.Text = "Update";
             btnCancel.Visible = true;

//         }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
        ImageButton btn = sender as ImageButton;        
        string MeritID = btn.CommandArgument;
        
        SqlCommand cmd;
        
       
            con.Open();
            cmd = new SqlCommand("delete from MeritCriteria where MeritCriteriaID="+MeritID+" ", con);
           
            cmd.ExecuteNonQuery();
            GetAllQualificationForGrid();

        }
        catch { }
        finally { con.Close(); }        
    
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {

        btnCancel.Visible = false;
        lblmsg.Visible = false;
        btnSave.Text = "Save";
        ddlQualification.Enabled = true;
        DDL_Advertisement.Enabled = true;
        ddlPosts.Enabled = true;
        txtboxPercentage.Text = "";
    
    }

    private string getpostexperience()
    {

        string status = "0";
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("Select Experience from Advertisement_Sub where Ad_Id =@adid and ad_sub_id=@postid", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            status = cmd.ExecuteScalar() as string;
            if (string.IsNullOrEmpty(status))
            {
                status = "0";
            }
        }
        catch { }
        finally { con.Close(); }
        return (status);
    }

    protected void btnAdd_Click(object sender, ImageClickEventArgs e)
    {
        hf_experince_year.Value = getpostexperience();
        Pnl_detail.Visible = true;
        Gv_Detail.DataBind();
    }
    protected void Gv_Detail_PreRender(object sender, EventArgs e)
    {
        if (Gv_Detail.Rows.Count > 0)
        {
            int val = Convert.ToInt32(hf_experince_year.Value) % 10;
            if (Gv_Detail.PageIndex == 0)
            {
                TextBox txt = new TextBox();
                DataTable dt = getAdvExperienceMars();
                for (int i = 0; i < Gv_Detail.Rows.Count; i++)
                {

                    if (i + 1 <= Convert.ToInt64(hf_experince_year.Value))
                    {
                        txt = (TextBox)Gv_Detail.Rows[i].FindControl("txt_qty");
                        txt.Enabled = false;
                    }
                    else {
                        foreach (DataRow dr in dt.Rows)
                        {
                            if (Convert.ToInt32(dr["year"]) == i + 1)
                            {
                                txt = (TextBox)Gv_Detail.Rows[i].FindControl("txt_qty");
                                txt.Text = dr["marks"].ToString();
                            }
                        }
                    }

                }
            }
        }

    }
    protected void Btn_pnl_close_Click(object sender, EventArgs e)
    {
        Pnl_detail.Visible = false;
    }
    protected void Btn_pnl_Save_Click(object sender, EventArgs e)
    {
        if (Gv_Detail.Rows.Count > 0)
        {
            TextBox txt = new TextBox();
            HiddenField ID = new HiddenField();
            double value = 0;
            int year = 0;
            delete_Percent();
            foreach (GridViewRow row in Gv_Detail.Rows)
            {

                txt = row.FindControl("txt_qty") as TextBox;
                if (string.IsNullOrEmpty(txt.Text.Trim()))
                { txt.Text = "0";}

                value = Convert.ToDouble(txt.Text);
                if (value > 0)
                {
                    ID = row.FindControl("hfID") as HiddenField;
                    year =Convert.ToInt32( ID.Value);
                    
                    insert_percent(value,year);

                }
            }
            getExperienceMarks(); // for set Applicant experience Marks on merit criteria
        }
        Pnl_detail.Visible = false;
    }

    protected void delete_Percent()
    {
        
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = "delete adv_experience_marks where(ad_id = @adid)and( ad_sub_ID = @postid )";
                cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                cmd.ExecuteNonQuery();
            }
        }
        catch { }
        finally { con.Close(); }
    }
       

protected void insert_percent(double value,int year)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            string statement =  " INSERT INTO adv_experience_marks (ad_id, ad_sub_ID,[year], marks, enter_by)";
            statement = statement + " VALUES (@adid,@postid,@year,@mark,@empid)";
            cmd = new SqlCommand(statement, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@year", year);
            cmd.Parameters.AddWithValue("@mark", value);
            cmd.Parameters.AddWithValue("@empid", Session["emp_id"].ToString() );
            cmd.ExecuteNonQuery();

        }
        catch { }
        finally { con.Close(); }
    
    }

    protected DataTable getAdvExperienceMars()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        DataTable dt = new DataTable();
        try
        {
            con.Open();
            string statement = "Select year, Marks from adv_experience_marks where ad_id = @adid AND ad_sub_Id = @postid";
            cmd = new SqlCommand(statement, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                da.Fill(dt);
            }

        }
        catch(Exception ex) { }
        finally { con.Close(); }
        return dt;
    }

    private void getExperienceMarks()
    {
        SqlConnection con = new SqlConnection(_conStr);
        try
        {

            con.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = con;
                cmd.CommandText = @"usp_GetApplicantExperienceMarks";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                cmd.ExecuteNonQuery();
            }
        }
        catch { }
        finally { con.Close(); }
    }
}

