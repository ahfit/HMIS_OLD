using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Microsoft.Reporting.WebForms;
using System.IO;

public partial class HR_SearchApplicantsQualificationPercentage : System.Web.UI.Page
{

    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
            btnSelect.Visible = false;
            LoadGrid();
        }
    }
    
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ReportViewer1.Visible=false;
        GridView_Applicants.Visible = true;
        gvdAApplicants.Visible = true;
        LoadGrid();
        getdata();

        if (GridView_Applicants.Rows.Count > 0) 
        {

            btnSelect.Visible = true;
        }


    }

    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
        LoadGrid();
    }

    protected void ddlPosts_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        LoadGrid();
        
    }

    protected void btnReport_Click(object sender, EventArgs e) 
    {
        GridView_Applicants.Visible = false;
        gvdAApplicants.Visible = false;
        ReportViewer1.Visible = true;

        LoadReport();

        //SqlCommand cmd;
        //SqlConnection con = new SqlConnection(_conStr);
        //try
        //{
        //    con.Open();
        //    cmd = new SqlCommand("getval", con);
        //    cmd.CommandType = CommandType.StoredProcedure;
        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    da.Fill(dt);

        //    ReportDataSource rds = new ReportDataSource();
        //    rds.Name = "DataSet1";
        //    rds.Value = dt;
        //    //ReportViewer1.LocalReport.ReportPath = Server.MapPath("testit.rdlc");
        //    ReportViewer1.LocalReport.DataSources.Clear();
        //    ReportViewer1.LocalReport.ReportPath = Server.MapPath("SearchApplicantsQualificationPercentage.rdlc");
        //    ReportViewer1.LocalReport.DataSources.Add(rds);
        //    ReportViewer1.LocalReport.Refresh();

        //}
        //catch (Exception ex)
        //{
        //}
        //finally
        //{
        //    con.Close();
        //}
     
    }

    protected void btn_exportClick(object sender, EventArgs e)
    {
        ShowAllComplaints();

      

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
    }
    protected void ShowAllComplaints()
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ClearContent();
        Response.ClearHeaders();
        Response.Charset = "";
        string FileName = "Applicant_Detail" + DateTime.Now + ".xls";
        StringWriter strwritter = new StringWriter();
        HtmlTextWriter htmltextwrtter = new HtmlTextWriter(strwritter);
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        Response.ContentType = "application/vnd.ms-excel";
        Response.AddHeader("Content-Disposition", "attachment;filename=" + FileName);
        GridView_Applicants.GridLines = GridLines.Both;
        GridView_Applicants.HeaderStyle.Font.Bold = true;
        GridView_Applicants.RenderControl(htmltextwrtter);
        Response.Write(strwritter.ToString());
        Response.End();   
      
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


     protected void LoadReport()
    {
       
        SqlConnection con = new SqlConnection(_conStr);
      
            con.Open();
            SqlCommand cmd = null;
            if (DDL_AgeCriteria.SelectedValue == "1")
            {
                cmd = new SqlCommand("GetApplicantQualificationPercentage3", con);
            }
            if (DDL_AgeCriteria.SelectedValue == "2")
            {
                cmd = new SqlCommand("GetApplicantQualificationPercentageForUnderAge3", con);
            }
            if (DDL_AgeCriteria.SelectedValue == "3")
            {
                cmd = new SqlCommand("GetApplicantQualificationPercentageForOverAge3", con);
            }
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@Ad_Sub_Id", ddlPosts.SelectedValue);
           
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dt.Clear();
        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;
        
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
        //ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.Refresh();

        //if (Request.Browser.Browser == "Chrome")
        //        {
        //            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
        //            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
        //            Response.ContentType = "application/pdf";
        //            Response.BinaryWrite(bytes);
        //            Response.End();
        //        }

                //else
                    ReportViewer1.Visible = true;

        con.Close();

    }

     private void getdata()
     {

         DbManager dbmanager = new DbManager();
         DataTable dt = dbmanager.ExecuteDataTable_Query("select distinct q.Qualification_Name,q.Qualification_Id from MeritCriteria a inner join Qualifications q on a.Qualification_ID=q.Qualification_Id"
                   + " where a.AD_ID=" + DDL_Advertisement.SelectedValue + " and a.Post_ID=" + ddlPosts.SelectedValue + "", "HRConnectionString", new SqlParameter[0]);


         DataTable dtmarks = Applicantmarks();

         DataSet ds = new DataSet();
         ds.Tables.Add(dt);
         ds.Tables.Add(dtmarks);

         DataTable finalDatasert = new DataTable();
         finalDatasert.Columns.Add("Advrertisment");
         finalDatasert.Columns.Add("Title");
         finalDatasert.Columns.Add("Name");
         finalDatasert.Columns.Add("ID");
         //finalDatasert.Columns.Add("Is_Selected");
         //finalDatasert.Columns.Add("IsCalled");
         finalDatasert.Columns.Add("CNIC");
         finalDatasert.Columns.Add("Mobile_Number");




        

         var AppID = (from r in dtmarks.AsEnumerable()
                      select r["AppID"]).Distinct().ToList();

         //var qualificationID = (from r in dtmarks.AsEnumerable()
         //                       select r["Qualification_Id"]).Distinct().ToList();

         //List<string> strQualifincationName = new List<string>();
         //foreach (var item in qualificationID)
         //{
         //    DataRow row = dt.Select("Qualification_Id=" + item + "").First();
         //    strQualifincationName.Add(row["Qualification_Name"].ToString());

         //}

         foreach (DataRow item in dt.Rows)
         {
             finalDatasert.Columns.Add(item["Qualification_Name"].ToString());
         }
         finalDatasert.Columns.Add("Total");

        decimal finalMarks = 0;
        for (int i = 0; i < AppID.Count; i++)
         {
             DataRow rows = null;
             DataRow newRow = finalDatasert.NewRow();
             rows = dtmarks.Select("AppID=" + AppID[i] + " ").First();

             newRow["Advrertisment"] = rows["Ad_Title"].ToString();
             newRow["Title"] = rows["Title"].ToString();
             newRow["Name"] = rows["name"].ToString();
             newRow["ID"] = rows["AppID"].ToString();
             //newRow["Is_Selected"] = rows["Is_Selected"].ToString();
            // newRow["IsCalled"] = rows["IsCalled"].ToString();
             newRow["CNIC"] = rows["CNIC"].ToString();
             newRow["Mobile_Number"] = rows["Mobile_Number"].ToString();
            

             finalMarks = 0;
            
             foreach (DataRow item in dtmarks.Rows)
             {

                 if (rows["AppID"].ToString() == item["AppID"].ToString())
                 {
                     string qualificationName = item["Qualification_Name"].ToString();
                     float marks = float.Parse(item["TotalMarks"].ToString());
                     float obtain = float.Parse(item["ObtainedBy"].ToString());
                     float percentage = float.Parse(item["percentage"].ToString());

                     string total = Math.Round(((obtain / marks) * percentage),3).ToString();


                     finalMarks += Convert.ToDecimal(total);

                     newRow[qualificationName] = total;
                   
                     newRow["Total"] = finalMarks.ToString();

                }

             }
            finalDatasert.Rows.Add(newRow);
             GridView_Applicants.DataSource = finalDatasert;



             GridView_Applicants.DataBind();
         }
         btn_export.Visible = true;




     }
     private DataTable Applicantmarks()
     {

         DataTable dtMarks = new DataTable();
         SqlCommand cmd = null;
         SqlConnection con = new SqlConnection(_conStr);
         try
         {
             if (GridView_Applicants.Rows.Count > 0) 
             {
                // GridView_Applicants.Columns.Clear();
                 GridView_Applicants.DataSource = null;
                 GridView_Applicants.DataBind();
             }
             con.Open();
             if (DDL_AgeCriteria.SelectedValue == "1")
             {
                 cmd = new SqlCommand("uspGetApplicantMarksDetail", con);
             }
             else if (DDL_AgeCriteria.SelectedValue == "2")
             {
                 cmd = new SqlCommand("uspGetApplicantMarksDetailForUnderAge", con);
             }
             else if (DDL_AgeCriteria.SelectedValue == "3")
             {
                 cmd = new SqlCommand("uspGetApplicantMarksDetailForOverAge", con);
             }
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
             cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
             SqlDataAdapter da = new SqlDataAdapter(cmd);

             da.Fill(dtMarks);
            

         }
         catch (Exception ex)
         {
         }
         finally
         {
             con.Close();
         }

         return dtMarks;
        
     }


     protected void btnSelect_Click(object sender, EventArgs e)
    {
        try
        {
            string session = Convert.ToString(Session["emp_id"]);
            int Ad_id = Convert.ToInt32(DDL_Advertisement.SelectedValue);
            int Post_id = Convert.ToInt32(ddlPosts.SelectedValue);
            foreach (GridViewRow row in GridView_Applicants.Rows)
            {
                CheckBox ckbx = (CheckBox)row.FindControl("chkbox");
                if (ckbx.Checked == true)
                {
                    int lblid = Convert.ToInt32(row.Cells[6].Text);


                    SqlConnection con = new SqlConnection(_conStr);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_InsertEmpSelection", con);
                    cmd.Parameters.AddWithValue("@apid", lblid);
                    cmd.Parameters.AddWithValue("@adid", Ad_id);
                    cmd.Parameters.AddWithValue("@postid", Post_id);
                    cmd.Parameters.AddWithValue("@createdname", session);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                    //DbManager dbmgr = new DbManager();
                    //SqlParameter[] param = { new SqlParameter("apid", lblid), new SqlParameter("adid", Ad_id), new SqlParameter("postid", Post_id) };
                    //dbmgr.ExecuteNonQuery("sp_InsertEmpSelection", _conStr, param);

                }
            }
            LoadGrid();
        }
        catch (Exception ex)
        {

        }
    }

     private void LoadGrid()
     {
         SqlConnection con = new SqlConnection(_conStr);
         SqlCommand cmd = new SqlCommand("uspCallApplicantForInterview", con);
         cmd.CommandType = CommandType.StoredProcedure;
         cmd.Parameters.AddWithValue("@advertismentID", DDL_Advertisement.SelectedValue);
         cmd.Parameters.AddWithValue("@postID", ddlPosts.SelectedValue);


         SqlDataAdapter adpter = new SqlDataAdapter(cmd);
         DataTable tb = new DataTable();
         adpter.Fill(tb);

         gvdAApplicants.DataSource = tb;
        gvdAApplicants.DataBind();
     }

     protected void chkbox_CheckedChanged(object sender, EventArgs e)
     {
        
    }

    protected void chkboxUnSelect_CheckedChanged(object sender, EventArgs e)
    {

    }
    protected void GridView_Applicants_RowDataBound(object sender, GridViewRowEventArgs e)
     {
         if (e.Row.RowType == DataControlRowType.DataRow)
         {
             int appid = Convert.ToInt32(e.Row.Cells[6].Text);
             int age = getageagainstpost(appid);
             if (age == 1)
             {
                 CheckBox chkbox = (CheckBox)e.Row.FindControl("chkbox");
                 chkbox.Enabled = false;
                 e.Row.BackColor = System.Drawing.Color.Red;
             }
            //TextBox txtExp = (TextBox)e.Row.FindControl("Experiance Marks ");
            //TextBox total = (TextBox)e.Row.FindControl("Total");
            //txtExp.Text = getExperienceMarks(Convert.ToInt32(appid)).ToString();
            //total.Text = Convert.ToDecimal(total.Text) + Convert.ToDecimal(txtExp.Text).ToString();
        }
     }
     private int getageagainstpost(int val) 
     {
         int agecheck = 0;
         try
         {

             SqlConnection con = new SqlConnection(_conStr);

             con.Open();
             SqlCommand cmd = new SqlCommand("GetAgeagaisntpost", con);
             cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@Ad_Sub_Id", ddlPosts.SelectedValue);
             cmd.Parameters.AddWithValue("@App_id", val);
             cmd.Parameters.Add("@chkreturn", SqlDbType.Int);
           
            cmd.Parameters["@chkreturn"].Direction = ParameterDirection.Output;
           

            SqlDataAdapter da = new SqlDataAdapter(cmd);
             DataTable dt = new DataTable();

           da.Fill(dt);
           agecheck = Convert.ToInt32(cmd.Parameters["@chkreturn"].Value);
            con.Close();

             
         }
         catch (Exception ex)
         {


         }
         finally 
         {
            
         }
         return agecheck;
     
     }
     protected void LinkButton1_Click(object sender, EventArgs e)
     {
         SqlConnection con = new SqlConnection(_conStr);
         try
         {
             LinkButton lnkbtn = sender as LinkButton;
             GridViewRow row = lnkbtn.NamingContainer as GridViewRow;
             HiddenField1.Value = Convert.ToString(row.Cells[6].Text);
             PanelToAddRemarks.Visible = false;



             int empid = Convert.ToInt32(HiddenField1.Value);


             con.Open();
             SqlCommand cmd = new SqlCommand("Select Remarks From  Applicant Where AppID=@apid", con);
             cmd.Parameters.AddWithValue("@apid", empid);
             SqlDataAdapter sda = new SqlDataAdapter(cmd);
             DataTable dt = new DataTable();
             sda.Fill(dt);

             txtRemarks.Text = Convert.ToString(dt.Rows[0][0]);
             cmd.ExecuteNonQuery();
             PanelToAddRemarks.Visible = true;
         }
         catch (Exception)
         {


         }
         finally
         {
             con.Close();

         }
        
     }
     protected void Button1_Click(object sender, EventArgs e)
     {
         SqlConnection con = new SqlConnection(_conStr);
         try
         {


             int empid = Convert.ToInt32(HiddenField1.Value);


             con.Open();
             SqlCommand cmd = new SqlCommand("Update Applicant set Remarks='" + txtRemarks.Text + "' where  AppID=@apid", con);
             cmd.Parameters.AddWithValue("@apid", empid);

             cmd.ExecuteNonQuery();
             lblWarning.Text = "Successfully Updated";
             lblWarning.ForeColor = System.Drawing.Color.Green;
         }
         catch (Exception)
         {


         }
         finally
         {
             con.Close();

         }

     }
     protected void Button2_Click(object sender, EventArgs e)
     {
         lblWarning.Text = "";
         lblWarning.ForeColor = System.Drawing.Color.Red;
         PanelToAddRemarks.Visible = false;
     }

    protected void BtnUnselect_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in gvdAApplicants.Rows)
            {
                CheckBox ckbx = (CheckBox)row.FindControl("chkboxUnSelect");
                if (ckbx.Checked == true)
                {

                    SqlConnection con = new SqlConnection(_conStr);
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_DeleteEmpSelection", con);
                    cmd.Parameters.AddWithValue("@apid", row.Cells[3].Text);
                    cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                    cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.ExecuteNonQuery();

                    //DbManager dbmgr = new DbManager();
                    //SqlParameter[] param = { new SqlParameter("apid", lblid), new SqlParameter("adid", Ad_id), new SqlParameter("postid", Post_id) };
                    //dbmgr.ExecuteNonQuery("sp_InsertEmpSelection", _conStr, param);

                }
            }
            LoadGrid();
        }
        catch (Exception ex)
        {

        }
    }
}
