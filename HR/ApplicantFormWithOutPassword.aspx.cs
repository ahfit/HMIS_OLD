using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;

public partial class HR_ApplicantFormWithOutPassword : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    string appid = "";

    string name = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["appid"] == null)
        {

            btnConfirmPostId.Visible = false;
        }
        else 
        {
            btnConfirmPostId.Visible = true;
        
        }
        if (!IsPostBack)
        {

            get_allQualifications();
            //GetAllActiveAdvertisement();
            //GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);

           

             if (Request.QueryString["appid"] != null)
            {
                ApplicantDetailForExistingUser(Request.QueryString["appid"].ToString());
                appDetails.Visible = true;
                btnReport.Visible = true;
                btnSave.Text = "Update";
                btnSave.CommandName = "Update";
                LoadGrid(Request.QueryString["appid"].ToString());
                TextBox_CNIC.Enabled = false;
                
            }
             else if (Request.QueryString["cnic"] != null)
             {
                // getAppid(Request.QueryString["cnic"].ToString());
                 TextBox_CNIC.Text = Request.QueryString["cnic"].ToString();
                 TextBox_CNIC.Enabled = false;
                 
             }
else {

            appDetails.Visible = false;
            
             }
        }
        GetPostForApplicant();
        
    }
    private void getAppid(string cnic) 
    {
        DbManager db = new DbManager();
        SqlParameter[] param = { new SqlParameter("cnic", cnic) };
        DataTable dt = db.ExecuteDataTable("getAppId", "HRConnectionString", param);
        btnSavePost.CommandArgument=dt.Rows[0]["AppID"].ToString();
    }
    private int getAppid1(string cnic)
    {
        DbManager db = new DbManager();
        SqlParameter[] param = { new SqlParameter("cnic", cnic) };
        DataTable dt = db.ExecuteDataTable("getAppId", "HRConnectionString", param);
        return Convert.ToInt32(dt.Rows[0]["AppID"].ToString());
    }
    private void GetPostForApplicant() 
    {
        try
        {
            if (Request.QueryString["appid"] != null)
            {
                DbManager db = new DbManager();
                SqlParameter[] param = { new SqlParameter("app_id", Request.QueryString["appid"].ToString()) };
                DataTable dt = db.ExecuteDataTable("usp_GetApplicantsApplications", "HRConnectionString", param);
                gvPost.DataSource = dt;
                gvPost.DataBind();
            }
            else if (Request.QueryString["cnic"] != null)
            {
                int id = getAppid1(Request.QueryString["cnic"].ToString());
                DbManager db = new DbManager();
                SqlParameter[] param = { new SqlParameter("app_id", id) };
                DataTable dt = db.ExecuteDataTable("usp_GetApplicantsApplications", "HRConnectionString", param);
                gvPost.DataSource = dt;
                gvPost.DataBind();
            }
        }
        catch(Exception ex){}
    
    }
    protected void DropDownList_place_of_birth_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_dist_ID.SelectedValue = DropDownList_place_of_birth.SelectedValue;
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        TextBox_present_address.Text = homeadd.Text;
    }
    protected void Button_attach_pic_Click(object sender, EventArgs e)
    {
        string File_Path = Server.MapPath("~/HR/picture/");
        if (FileUpload_image.HasFile)
        {
            string fileExtension = System.IO.Path.GetExtension(FileUpload_image.FileName);

            if (fileExtension.ToLower() != ".jpeg" && fileExtension.ToLower() != ".jpg" && fileExtension.ToLower() != ".png")
            {
                this.ImageButton1.ImageUrl = "~/Fileupload_Images/dummyImage.png";
            }

            else
            {
                string FileName = System.IO.Path.GetFileName(FileUpload_image.PostedFile.FileName);

                //Save files to images folder

                FileUpload_image.SaveAs(Server.MapPath("~/Fileupload_Images/" + FileName));
                this.ImageButton1.ImageUrl = "~/Fileupload_Images/" + FileName;
            }
        }
        else
        {
            this.ImageButton1.ImageUrl = "~/Fileupload_Images/dummyImage.png";
        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        if (btnSave.CommandName == "Update")
        {
            UpdateApplicant(Request.QueryString["appid"].ToString());
           
        }
        else
        {


            SqlConnection con = new SqlConnection(_conStr);
            SqlCommand cmd = new SqlCommand("uspAddApplicant", con);

            try
            {

                cmd.CommandType = CommandType.StoredProcedure;

                try
                {

                    FileStream fstream = new FileStream(Server.MapPath(ImageButton1.ImageUrl), FileMode.Open);
                    byte[] b = new byte[fstream.Length + 1];
                    fstream.Read(b, 0, Convert.ToInt32(fstream.Length));
                    cmd.Parameters.AddWithValue("@picture", b);
                }
                catch
                {
                    byte[] b = new byte[0];
                    cmd.Parameters.AddWithValue("@picture", b);
                }

                //General Information
                
                cmd.Parameters.AddWithValue("@firstName", txtEFName.Text);
                cmd.Parameters.AddWithValue("@middleName", txtEMName.Text);
                cmd.Parameters.AddWithValue("@LastName", TxtELName.Text);
                cmd.Parameters.AddWithValue("@Sex", Dropdownlistsex.SelectedValue);
                cmd.Parameters.AddWithValue("@relationName", Relation.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@RFname", TextBoxRFName.Text);
                cmd.Parameters.AddWithValue("@RmName", TextBoxRMName.Text);
                cmd.Parameters.AddWithValue("@RlNAME", TextBoxRLName.Text);


                //Basic Information
                cmd.Parameters.AddWithValue("@DateOfBirth", DOB.Value.ToString());
                cmd.Parameters.AddWithValue("@PlaceOfBirth", DropDownList_place_of_birth.SelectedValue);
                cmd.Parameters.AddWithValue("@Religion", DropDownList_religion.SelectedValue);
                cmd.Parameters.AddWithValue("@Domicile", DropDownList_Domicile.SelectedValue);
                cmd.Parameters.AddWithValue("@MartialStatus", RadioButtonList_marital_status.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Nationality", DropDownList_nationality.SelectedValue);
                cmd.Parameters.AddWithValue("@Language", TextBox_language.Text);
                cmd.Parameters.AddWithValue("@Cnic", TextBox_CNIC.Text);
                cmd.Parameters.AddWithValue("@pasword", txt_Password.Text);


                //Address Information
                cmd.Parameters.AddWithValue("@District", DropDownList_dist_ID.SelectedValue);
                cmd.Parameters.AddWithValue("@TechID", DropDownList_teh_ID.SelectedValue);
                cmd.Parameters.AddWithValue("@HomePhone", txthp.Text);
                cmd.Parameters.AddWithValue("@MobileNo", TextBox_mobile_No.Text);
                cmd.Parameters.AddWithValue("@Email", TextBox_email.Text);
                cmd.Parameters.AddWithValue("@PresentAddress", TextBox_present_address.Text);
                cmd.Parameters.AddWithValue("@HomeAddress", homeadd.Text);
                cmd.Parameters.AddWithValue("@prefix", prefix.SelectedItem.Text);

                //cmd.Parameters.AddWithValue("@AdertismentID", DDL_Advertisement.SelectedValue);
                //cmd.Parameters.AddWithValue("@PostID", GridViewPosts.SelectedValue);


                cmd.Parameters.Add("@chkreturn", SqlDbType.Int);
                cmd.Parameters["@chkreturn"].Direction = ParameterDirection.Output;

                cmd.Parameters.Add("@appid", SqlDbType.Int);
                cmd.Parameters["@appid"].Direction = ParameterDirection.Output;


                con.Open();
                cmd.ExecuteNonQuery();
                
                
                int chkval=2;
                chkval= Convert.ToInt32(cmd.Parameters["@chkreturn"].Value);
                Session["Aplicantid"] = cmd.Parameters["@appid"].Value;
                if (chkval == 1)
                {
                    lblWarn.Text = "User with this Id is already Registered";
                    
                }
                else if (chkval == 0)
                {
                    lblWarn.Text = "";
                    appid = cmd.Parameters["@appid"].Value.ToString();
                    Session["AppID"] = cmd.Parameters["@appid"].Value.ToString();
                    appDetails.Visible = true;
                    btnReport.Visible = true;
                    btnSave.Visible = false;
                    lblMessage.Visible = true;
                    Response.Redirect("ApplicantFormWithOutPassword.aspx?appid=" + appid + "", false);
                    LoadGrid(appid);
               }
               
              
                if (Request.QueryString["cnic"] != null)
                {
               int value= getAppid1(Convert.ToString(TextBox_CNIC.Text));
                 Response.Redirect("ApplicantForm.aspx?appid=" + value + "");
                }

            }
            catch(Exception ex) { }
            finally { con.Close(); }
        }
    }


    private void LoadGrid(string ID)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantDetail", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        gvdApplicantInfo.DataSource = tb;
        gvdApplicantInfo.DataBind();
    }


    private void LoadGridQualification(string ID)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantQualificationForGrid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        gvdQualification.DataSource = tb;
        gvdQualification.DataBind();
    }


    private void LoadGridCountryVisited(string ID)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantCountryVisitedForGrid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        CountryGird.DataSource = tb;
        CountryGird.DataBind();
    }





    private void LoadGridReserachPaper(string ID)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantReserachPaperForGrid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        ReserachPaperPGrid.DataSource = tb;
        ReserachPaperPGrid.DataBind();
    }
    private void FillPanelForPost() 
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("end_date", DateTime.Today) };
          DataTable dt=  dbMgr.ExecuteDataTable("usp_GetCurrentAdvertisement", "HRConnectionString", para);
            ddlAdvertiseforpost.DataSource=dt;
            ddlAdvertiseforpost.DataValueField="Ad_Id";
            ddlAdvertiseforpost.DataTextField="Ad_Title";
            ddlAdvertiseforpost.DataBind();
            // ddlQulaification.DataSource = dt;
            //ddlQulaification.DataBind();
        }
        catch (Exception ex)
        {

        }
    
    }
 
    private void LoadGridFormalTraining(string ID)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantFormalTrainingForGrid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        FormalTrainingGrid.DataSource = tb;
        FormalTrainingGrid.DataBind();
    }

 
    private void LoadGridForExperience(string ID)
    {
       
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantExperienceForGird", con);
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@appid", ID);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        gvdForExperience.DataSource = tb;
        gvdForExperience.DataBind();
    }
 
    protected void lnkbtnQualification_Click(object sender, EventArgs e)
    {
        panel.Visible = true;
        if (Request.QueryString["appid"] !=null)
        {
            get_allQualifications();
            LoadGridQualification(Request.QueryString["appid"].ToString());    
        }
        
    }


    protected void lnkbtnReserachPaper_Click(object sender, EventArgs e)
    {
        panelReserachPaper.Visible = true ;
        if (Request.QueryString["appid"] != null)
        {
            LoadGridReserachPaper(Request.QueryString["appid"].ToString());
        }
    }

    protected void RPbtnSaveQualification_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspAddAppReserachPaper", con);

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@journalName", RPJournalName.Text);
            cmd.Parameters.AddWithValue("@PrincipleCoAuthor", RPPrincipleCoAuthor.Text);
            cmd.Parameters.AddWithValue("@TitleOfReserachPapaer", RPTitleOfReserachPapaer.Text);
            cmd.Parameters.AddWithValue("@PublicationDate", RPPublicationDate.Text);
            
            if (Request.QueryString["appid"] != null)
            {
                cmd.Parameters.AddWithValue("@AppId", Request.QueryString["appid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@AppId", Session["AppID"].ToString());
            }
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
                LoadGridReserachPaper(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridReserachPaper(Session["AppID"].ToString());
            }
            ClearQualification();
        }
        catch { }
        finally
        {
            con.Close();
        }
        

    }
    protected void RPClose_Click(object sender, EventArgs e)
    {
          panelReserachPaper.Visible = false;     
        

    }

    protected void ReserachPaperPimagebtn_Click(object sender, EventArgs e)
    {
        string btn = (sender as ImageButton).CommandArgument;

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("delete from AppReserachPaper where ID=@ID", con);

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", btn);
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
               LoadGridReserachPaper(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridReserachPaper(Session["AppID"].ToString());
            }

        }
        catch { }
        finally { con.Close(); }
        

    }

    protected void btnCountrySave_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspAddAppCounteriesVisited", con);

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@CountryName",CCountryName.Text);
            cmd.Parameters.AddWithValue("@CountryDuration",CDuration.Text);
            cmd.Parameters.AddWithValue("@CountrypurposeOfVisit", CpurposeOfVisit.Text);
            

            if (Request.QueryString["appid"] != null)
            {
                cmd.Parameters.AddWithValue("@AppId", Request.QueryString["appid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@AppId", Session["AppID"].ToString());
            }
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
                LoadGridCountryVisited(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridCountryVisited(Session["AppID"].ToString());
            }
            ClearQualification();
        }
        catch { }
        finally
        {
            con.Close();
        }
        
        

    }
    protected void btnCountryClose_Click(object sender, EventArgs e)
    {

        PanelCountriesVisited.Visible = false;

    }


    private void get_allQualifications()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(_conStr);
            con.Open();
            cmd = new SqlCommand("SELECT     Qualifications.Qualification_Id, Qualifications.Qualification_Name FROM         Qualifications" +
                      " WHERE     (Qualifications.Is_deleted is NULL)", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlQulaification.DataSource = dt;
            ddlQulaification.DataValueField = "Qualification_Id";
            ddlQulaification.DataTextField = "Qualification_Name";
            ddlQulaification.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    
    
    protected void lnkbtnExperience_Click(object sender, EventArgs e)
    {
        panelExperience.Visible = true;
 
        if (Request.QueryString["appid"] != null)
        {
            LoadGridForExperience(Request.QueryString["appid"].ToString());
        }
    }

    protected void btnSaveExperience_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspAddApplicantExperience", con);

        try
        {

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Institute",ERtxtboxInstitute.Text);
            cmd.Parameters.AddWithValue("@NatureOfJob", ERddlNatureOfJob.Text);
            cmd.Parameters.AddWithValue("@DateFrom", ERtxtboxPeriodFrom.Text);
            cmd.Parameters.AddWithValue("@DateTo", ERtxtboxPeriodTo.Text);
            cmd.Parameters.AddWithValue("@BPS", ERtxtboxBPS.Text);
            cmd.Parameters.AddWithValue("@Designation", ERtxtboxDesignation.Text);
            cmd.Parameters.AddWithValue("@JobDescription", ERtxtboxJobDescription.Text);
            cmd.Parameters.AddWithValue("@Experience", txtbxExperience.Text);

            if (Request.QueryString["appid"] != null)
            {
                cmd.Parameters.AddWithValue("@AppId", Request.QueryString["appid"].ToString());

            }
            else
            {
                cmd.Parameters.AddWithValue("@AppID", Session["AppID"].ToString());
            }
             
            con.Open();
            cmd.ExecuteNonQuery();

            if (Request.QueryString["appid"] != null)
            {
              
                LoadGridForExperience(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridForExperience(Session["AppID"].ToString());
            }



            
            ClearExperience();
        }
        catch { }
        finally
        {
            con.Close();
        }
    }


    protected void btnSaveQualification_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspAddAppQualification", con);

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Institute", txtboxInstitue.Text);
            cmd.Parameters.AddWithValue("@DegreeName", ddlQulaification.SelectedValue);
            cmd.Parameters.AddWithValue("@Year", txtboxYear.Text);
            cmd.Parameters.AddWithValue("@DivisionDistinction", DivisionDistinction.Text);
            cmd.Parameters.AddWithValue("@Attempts", Attempts.Text);
            cmd.Parameters.AddWithValue("@Percentage", txtboxPercentage.Text);
            
            if (chkboxSelect.Checked)
            {
                cmd.Parameters.AddWithValue("@iscgpa", "true");
                cmd.Parameters.AddWithValue("@TotalMarks", txtTotalCgpa.Text);
                cmd.Parameters.AddWithValue("@ObtainMarks", txtObtainCgpa.Text);
            }
            else
            {
                cmd.Parameters.AddWithValue("@iscgpa", "false");
                cmd.Parameters.AddWithValue("@TotalMarks", txtboxTotalMarks.Text);
                cmd.Parameters.AddWithValue("@ObtainMarks", txtboxObtainedMarks.Text);
            }
            //cmd.Parameters.AddWithValue("@ADID", DDL_Advertisement.SelectedValue);
            //cmd.Parameters.AddWithValue("@PostID", GridViewPosts.SelectedValue);
            
                

            if (Request.QueryString["appid"] != null)
            {
                cmd.Parameters.AddWithValue("@AppId", Request.QueryString["appid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@AppId", Session["AppID"].ToString());
            }
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
                LoadGridQualification(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridQualification(Session["AppID"].ToString());
            }
            ClearQualification();
        }
        catch { }
        finally
        {
            con.Close();
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
    }
    protected void btnCloseExperience_Click(object sender, EventArgs e)
    {
        panelExperience.Visible = false;
    }


    protected void imagebtn_Click(object sender, EventArgs e)
    {
        string btn = (sender as ImageButton).CommandArgument;

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("delete from ApplicatnQualification where ID=@ID", con);

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", btn);
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"]!=null)
            {
                LoadGridQualification(Request.QueryString["appid"].ToString());    
            }
            else
            {
                LoadGridQualification(Session["AppID"].ToString());
            }
           
        }
        catch { }
        finally { con.Close(); }
    }



    protected void imagebtnExperience_Click(object sender, EventArgs e)
    {
        string btn = (sender as ImageButton).CommandArgument;

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("delete from ApplicantExperience where ID=@ID", con);

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", btn);
            con.Open();
            cmd.ExecuteNonQuery();
            LoadGridForExperience(Session["AppID"].ToString());
        }
        catch { }
        finally { con.Close(); }
    }




    protected void lnkbtnFormalTraining_Click(object sender, EventArgs e)
    {
        PanelFormalTraining.Visible = true;
        if (Request.QueryString["appid"] != null)
        {
            LoadGridFormalTraining(Request.QueryString["appid"].ToString());
        }
    }

    protected void imagebtnFormalTraining_Click(object sender, EventArgs e)
    {
        string btn = (sender as ImageButton).CommandArgument;

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("delete from FormalTrainingOrEducation where ID=@ID", con);

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", btn);
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
               LoadGridFormalTraining(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridFormalTraining(Session["AppID"].ToString());
            }

        }
        catch { }
        finally { con.Close(); }  
    }

    protected void imagebtnCountryVisit_Click(object sender, EventArgs e)
    {
        string btn = (sender as ImageButton).CommandArgument;

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("delete from AppCountryVisit where ID=@ID", con);

        try
        {
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@ID", btn);
            con.Open();
            cmd.ExecuteNonQuery();
            LoadGridCountryVisited(Session["AppID"].ToString());
        }
        catch { }
        finally { con.Close(); }
    }


    protected void lnkbtnCountriesVisited_Click(object sender, EventArgs e)
    {
        PanelCountriesVisited.Visible = true;
        if (Request.QueryString["appid"] != null)
        {
            LoadGridCountryVisited(Request.QueryString["appid"].ToString());
        }
    }

    protected void btnSaveFormalTraining_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspAddAppFormalTraining", con);

        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Institute", FTInstitute.Text);
            cmd.Parameters.AddWithValue("@PeriodFrom", FTPeriodFrom.Text);
            cmd.Parameters.AddWithValue("@PeriodTo", FTPeriodTo.Text);
            cmd.Parameters.AddWithValue("@TrainingType", FTTrainingType.Text);
            cmd.Parameters.AddWithValue("@CertificateDiplomaObtained", FTCertificateDiplomaObtained.Text);
            
            if (Request.QueryString["appid"] != null)
            {
                cmd.Parameters.AddWithValue("@AppId", Request.QueryString["appid"].ToString());
            }
            else
            {
                cmd.Parameters.AddWithValue("@AppId", Session["AppID"].ToString());
            }
            con.Open();
            cmd.ExecuteNonQuery();
            if (Request.QueryString["appid"] != null)
            {
                LoadGridFormalTraining(Request.QueryString["appid"].ToString());
            }
            else
            {
                LoadGridFormalTraining(Session["AppID"].ToString());
            }
            ClearQualification();
        }
        catch { }
        finally
        {
            con.Close();
        }
    }

    protected void btnCloseFormalTraining_Click(object sender, EventArgs e)
    {
        PanelFormalTraining.Visible = false;
    }
        
    private void ClearQualification()
    {
        Attempts.Text = "";
        DivisionDistinction.Text = "";
        txtboxInstitue.Text = "";
        //txtboxDegreeName.Text = ""
        txtboxYear.Text = "";
        //txtboxTotal.Text = "";
        //txtboxObtained.Text = "";
        txtboxPercentage.Text = "";
    }

    private void ClearExperience()
    {

        //txtboxCompany.Text = "";
        //txtboxDesignation.Text = "";
        //txtboxDateFrom.Text = "";
        //txtboxDateTo.Text = "";
        //txtboxExperience.Text = "";

    }

    //private void GetAllActiveAdvertisement()
    //{
    //    SqlCommand cmd;
    //    SqlConnection con = new SqlConnection(_conStr);
    //    try
    //    {
    //        con.Open();
    //        cmd = new SqlCommand("SELECT  Ad_Title, Ad_Id FROM Advertisement_Main where Convert(varchar,End_Date,112)>=Convert(varchar,@Date,112) and Is_Active=1", con);
    //        cmd.Parameters.AddWithValue("@Date",DateTime.Now);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        DDL_Advertisement.DataSource = dt;
    //        DDL_Advertisement.DataTextField = "Ad_Title";
    //        DDL_Advertisement.DataValueField = "Ad_Id";
    //        DDL_Advertisement.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}

    //private void GetAllAdvertisementPosts(string ID)
    //{
    //    SqlCommand cmd;
    //    SqlConnection con = new SqlConnection(_conStr);
    //    try
    //    {
    //        con.Open();
    //        cmd = new SqlCommand("SELECT Ad_Sub_Id, Ad_Id, Title, Posts, Pay_Scale, Description, Qualification, Experience"
    //                                + " FROM Advertisement_Sub where Ad_Id=@Ad_Id", con);
    //        cmd.Parameters.AddWithValue("@Ad_Id", ID);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        GridViewPosts.DataSource = dt;
    //        GridViewPosts.DataValueField = "Ad_Sub_Id";
    //        GridViewPosts.DataTextField = "Title";
    //        GridViewPosts.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }
    //}



    //protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
    //}


    private void ApplicantDetailForExistingUser(string appid)
    {
        SqlConnection con = new SqlConnection(_conStr);
        try
        {

            if (Request.QueryString["appid"] != null)
            {

                SqlCommand cmd = new SqlCommand("select * from applicant where appid=@appid", con);

                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@appid", appid);

                con.Open();
                SqlDataReader read=cmd.ExecuteReader();

                while (read.Read())
                {

                    byte[] b = (byte[])read["Picture"];
                    string imageString=Convert.ToBase64String(b);
                    ImageButton1.ImageUrl = "data:Image/png;base64," + imageString;

                      txtEFName.Text=  read["appName"].ToString();
                     txtEMName.Text =read["AppMName"].ToString();
                     TxtELName.Text =read["AppLName"].ToString();
                    Relation.SelectedValue=read["Relation"].ToString();

                     Dropdownlistsex.SelectedValue =read["SexID"].ToString();
                     
                     TextBoxRFName.Text =read["RFName"].ToString();
                     TextBoxRMName.Text =read["RMName"].ToString();
                     TextBoxRLName.Text =read["RLName"].ToString();


                    //Basic Information
                     DOB.Value = read["DateOfBirth"].ToString();
                   

                      


                      DropDownList_place_of_birth.SelectedValue = read["Place_of_birth"].ToString();
                      DropDownList_religion.SelectedValue =read["Religion"].ToString();
                    DropDownList_Domicile.SelectedValue =read["Domicile"].ToString();
                     RadioButtonList_marital_status.SelectedItem.Text =read["Marital_Status"].ToString();
                      DropDownList_nationality.SelectedValue =read["Nationality"].ToString();
                     TextBox_language.Text =read["Language_Known"].ToString();
                      TextBox_CNIC.Text =read["CNIC"].ToString();
                      txt_Password.Text = read["Pasword"].ToString();


                    //Address Information
                     DropDownList_dist_ID.SelectedValue =read["dist_ID"].ToString();
                     DropDownList_teh_ID.SelectedValue =read["tech_ID"].ToString();

                     txthp.Text = read["HPhoneNo"].ToString();
                      
                     TextBox_mobile_No.Text =read["Mobile_Number"].ToString();
                     TextBox_email.Text =read["email_address"].ToString();
                     TextBox_present_address.Text =read["Present_address"].ToString();
                     homeadd.Text =read["HomeAdd"].ToString();
                     prefix.SelectedItem.Text =read["Prefix"].ToString();
 
                    //DDL_Advertisement.SelectedValue =read["AdertismentID"].ToString();
                    //GridViewPosts.SelectedValue =read["PostID"].ToString();

                    //DDL_Advertisement.Enabled = false;
                    //GridViewPosts.Enabled = false;
                    ButtonUpdatePassword.CommandArgument = read["appid"].ToString();
                    btnSavePost.CommandArgument = read["appid"].ToString();
                    lblPassword.Text = "Your Current Password=" + read["Pasword"].ToString();
                    lblPassword.Visible = false;
                    lnkpasword.Visible = false;
                    FillPanelForPost();
 
                }


            }
        }
        catch { }
        finally
        {
            con.Close();
        }
    }





    private void UpdateApplicant(string appid)
    {
        SqlConnection con = new SqlConnection(_conStr);
        try
        {

            if (Request.QueryString["appid"] != null)
            {

                SqlCommand cmd = new SqlCommand("uspUpdateApplicantDetail", con);

                byte[] b;
                if (ImageButton1.ImageUrl.Contains("data:Image/png;base64"))
                {
                    b = Convert.FromBase64String(ImageButton1.ImageUrl.Replace("data:Image/png;base64,", ""));
                }
                else
                {
                    FileStream fs = new FileStream(Server.MapPath(ImageButton1.ImageUrl), FileMode.Open);
                    b = new byte[fs.Length + 1];
                    fs.Read(b, 0, Convert.ToInt32(fs.Length));
                }

                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@appid", Request.QueryString["appid"].ToString());
                cmd.Parameters.AddWithValue("@picture", b);
                cmd.Parameters.AddWithValue("@firstName", txtEFName.Text);
                cmd.Parameters.AddWithValue("@middleName", txtEMName.Text);
                cmd.Parameters.AddWithValue("@LastName", TxtELName.Text);
                cmd.Parameters.AddWithValue("@Sex", Dropdownlistsex.SelectedValue);
                cmd.Parameters.AddWithValue("@relationName", Relation.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@RFname", TextBoxRFName.Text);
                cmd.Parameters.AddWithValue("@RmName", TextBoxRMName.Text);
                cmd.Parameters.AddWithValue("@RlNAME", TextBoxRLName.Text);


                //Basic Information
                cmd.Parameters.AddWithValue("@DateOfBirth", DOB.Value.ToString());
                cmd.Parameters.AddWithValue("@PlaceOfBirth", DropDownList_place_of_birth.SelectedValue);
                cmd.Parameters.AddWithValue("@Religion", DropDownList_religion.SelectedValue);
                cmd.Parameters.AddWithValue("@Domicile", DropDownList_Domicile.SelectedValue);
                cmd.Parameters.AddWithValue("@MartialStatus", RadioButtonList_marital_status.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Nationality", DropDownList_nationality.SelectedValue);
                cmd.Parameters.AddWithValue("@Language", TextBox_language.Text);
                cmd.Parameters.AddWithValue("@Cnic", TextBox_CNIC.Text);


                //Address Information
                cmd.Parameters.AddWithValue("@District", DropDownList_dist_ID.SelectedValue);
                cmd.Parameters.AddWithValue("@TechID", DropDownList_teh_ID.SelectedValue);
                cmd.Parameters.AddWithValue("@HomePhone", txthp.Text);
                cmd.Parameters.AddWithValue("@MobileNo", TextBox_mobile_No.Text);
                cmd.Parameters.AddWithValue("@Email", TextBox_email.Text);
                cmd.Parameters.AddWithValue("@PresentAddress", TextBox_present_address.Text);
                cmd.Parameters.AddWithValue("@HomeAddress", homeadd.Text);
                cmd.Parameters.AddWithValue("@prefix", prefix.SelectedItem.Text);

                //cmd.Parameters.AddWithValue("@AdertismentID", DDL_Advertisement.SelectedValue);
                //cmd.Parameters.AddWithValue("@PostID", GridViewPosts.SelectedValue);

                FillPanelForPost();


                con.Open();
                cmd.ExecuteNonQuery();
                }


            }
       
        catch { }
        finally
        {
            con.Close();
        }
    }


    protected void btnReport_Click(object sender,EventArgs e)
    {
        string id="";
        if (Request.QueryString["appid"]!=null)
            {
                id=Request.QueryString["appid"].ToString();    
            }
            else
            {
                id=Session["AppID"].ToString();
            }
        String Url = "Applicant_Form_Report.aspx?App_Id=" + id;

       // Response.Redirect(Url);


        string url = "Applicant_Form_Report.aspx?App_Id=" + id;
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());        
    }
    protected void lnkpassword_Click(object sender, EventArgs e)
    {

    }
    protected void lnkpasword_Click(object sender, EventArgs e)
    {
        panelChangePassword.Visible = true;
        //ButtonUpdatePassword.CommandName=
    }
    protected void ButtonUpdatePassword_Click(object sender, EventArgs e)
    {

        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("password", TextBoxPassword.Text), new SqlParameter("app_id", ButtonUpdatePassword.CommandArgument) };
            dbMgr.ExecuteNonQuery("usp_UpdateApplicantPassword", "HRConnectionString", para);
            //lblPassword.Text = "Your Current Password=" + TextBoxPassword.Text;
            //txt_Password.Text = TextBoxPassword.Text;
            panelChangePassword.Visible = false;
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnCloseChangePasswordPanel_Click(object sender, EventArgs e)
    {
        panelChangePassword.Visible = false;
    }
    protected void btnConfirmPostId_Click(object sender, EventArgs e)
    {
        panelforpost.Visible = true;
    }
    protected void btnClosePost_Click(object sender, EventArgs e)
    {
        SuccessMessage.Text = "";
        panelforpost.Visible = false;
    }
    protected void btnConfirmPostId_Click1(object sender, EventArgs e)
    {

        panelforpost.Visible = true;
        FillPanelForPost();
        changePost();

    }
    //protected void DDL_Advertisement_SelectedIndexChanged1(object sender, EventArgs e)
    //{

    //    DbManager dbMgr = new DbManager();
    //    SqlParameter[] para = { new SqlParameter("ad_id", ddlAdvertise.SelectedValue) };
    //    DataTable dt=dbMgr.ExecuteDataTable("usp_SelectPost", "HRConnectionString", para);

    //    ddlPost.DataSource = dt;
    //    ddlPost.DataValueField = "Ad_Sub_Id";

    //    ddlPost.DataTextField = "Title";
    //    ddlPost.DataBind();
    //}
    //protected void ddlAdvertise_SelectedIndexChanged(object sender, EventArgs e)
    //{

        
    //}
    private void changePost() 
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("ad_id", ddlAdvertiseforpost.SelectedValue) };
            DataTable dt = dbMgr.ExecuteDataTable("usp_SelectPost", "HRConnectionString", para);

            ddlPost.DataSource = dt;
            ddlPost.DataValueField = "Ad_Sub_Id";

            ddlPost.DataTextField = "Title";
            ddlPost.DataBind();
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlAdvertiseforpost_SelectedIndexChanged(object sender, EventArgs e)
    {
        changePost();
    }
    protected void btnSavePost_Click(object sender, EventArgs e)
    {
        

        try
        {
            using (SqlConnection con=new SqlConnection(_conStr))
            {
                int val = 0;
                SqlCommand command = new SqlCommand("usp_SaveApplicantsPost",con);
                command.CommandType = CommandType.StoredProcedure;
              
                    command.Parameters.AddWithValue("@app_id", btnSavePost.CommandArgument);
                
                command.Parameters.AddWithValue("@ad_id", ddlAdvertiseforpost.SelectedValue);
                command.Parameters.AddWithValue("@post_id", ddlPost.SelectedValue);
                command.Parameters.Add("@val", SqlDbType.Int);
                command.Parameters["@val"].Direction = ParameterDirection.Output;
                con.Open();
                command.ExecuteNonQuery();
                val = Convert.ToInt32(command.Parameters["@val"].Value);
                if (val == 0)
                {
                    SuccessMessage.Text = "Already Applied";
                }
                else if(val==1)
                {
                    SuccessMessage.Text = "Saved";
                    
                }
                GetPostForApplicant();
            }
            
        }
        catch (Exception ex) 
        {
        
        
        }
    }
    //protected void Button3_Click(object sender, EventArgs e)
    //{
    //    DbManager db = new DbManager();
    //    SqlParameter[] param = { new SqlParameter("applyforid",) };
    //    db.ExecuteNonQuery("usp_DeleteApplyId", "HRConnectionString", param);
    //    GetPostForApplicant();
    //}
    protected void btnDeletePost_Click(object sender, EventArgs e)
    {
        Button btn=(Button)sender;
         DbManager db = new DbManager();
        SqlParameter[] param = { new SqlParameter("applyforid",btn.CommandName) };
        db.ExecuteNonQuery("usp_DeleteApplyId", "HRConnectionString", param);
        GetPostForApplicant();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] para = { new SqlParameter("cnic", txtSearch.Text) };
        DataTable dt = dbMgr.ExecuteDataTable("Usp_SearchApplicantantCnic", "HRConnectionString", para);
        lblMsSearch.Text = "";
        int appId = 0;
        if(dt.Rows.Count>0)
        {
            appId=int.Parse(dt.Rows[0]["appID"].ToString());
            Response.Redirect("~/hr/ApplicantFormWithOutPassword.aspx?appid=" + appId);
        }
        else
        {
            lblMsSearch.Text = "Applicant not registered";
            lblMsSearch.ForeColor = System.Drawing.Color.Red;
        }
    }
}

