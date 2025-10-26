using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Text;
using Microsoft.Reporting.WebForms;

public partial class HR_CallForInterview : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            InterviewDate.Value = DateTime.Now.ToString();
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
            GridViewPosts.DataSource = dt;
            GridViewPosts.DataValueField = "Ad_Sub_Id";
            GridViewPosts.DataTextField = "Title";
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
    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

    protected void LoadReport()
    {

        SqlConnection con = new SqlConnection(_conStr);

        con.Open();
        SqlCommand cmd = null;
         cmd = new SqlCommand("GetApplicantQualificationPercentage2", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@Ad_Sub_Id", GridViewPosts.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
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


    private void LoadGrid()
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspCallApplicantForInterview", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@advertismentID",DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@postID",GridViewPosts.SelectedValue);
       // cmd.Parameters.AddWithValue("@inteviewdate", InterviewDate.Value);
        

        SqlDataAdapter adpter = new SqlDataAdapter(cmd);         
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        gvdAApplicants.DataSource = tb;
        gvdAApplicants.DataBind();
    }


    //protected void OnDataBound(object sender, EventArgs e)
    //{
    //    for (int i = gvdAApplicants.Rows.Count - 1; i > 0; i--)
    //    {
    //        GridViewRow row = gvdAApplicants.Rows[i];
    //        GridViewRow previousRow = gvdAApplicants.Rows[i - 1];
    //        for (int j = 0; j < row.Cells.Count; j++)
    //        {
    //            if (row.Cells[j].Text == previousRow.Cells[j].Text && row.Cells[6].Text == previousRow.Cells[6].Text)
    //            {

    //                if (previousRow.Cells[j].RowSpan == 0)
    //                {
    //                    if (row.Cells[j].RowSpan == 0)
    //                    {
    //                        previousRow.Cells[j].RowSpan += 2;
                            
    //                    }
    //                    else                         
    //                    {
    //                        previousRow.Cells[j].RowSpan = row.Cells[j].RowSpan + 1;
    //                    }
    //                    row.Cells[j].Visible = false;
    //                }
    //            }
    //        }
    //    }
    //}


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        LoadGrid();
    }

    protected void lnkbtnInterviewMarks_Click(object sender, EventArgs e)
    {
        string ID = (sender as LinkButton).CommandArgument;
        Response.Redirect("EntryTest_InterviewMarks.aspx?AppID=" + ID + "&postid=" + GridViewPosts.SelectedValue + "&advId=" + DDL_Advertisement.SelectedValue);
    }

    protected void lnkbtnReport_Click(object sender, EventArgs e)
    {
        string ID = (sender as LinkButton).CommandArgument;

       

        //if (Convert.ToInt32(count) > 0)
        //{

        Response.Redirect("EmployeeCallForInterview.aspx?AppID=" + ID);

        //}
        //else
        //{
        //    labelmsg.Visible = true;
        //    labelmsg.Text = "Candidate confirmation is Required";
        //}

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
        string ID = (sender as LinkButton).CommandArgument;
        panel.Visible = true;
        LoadGridQualification(ID);
    }


    protected void lnkbtnExperience_Click(object sender, EventArgs e)
    {
        string ID = (sender as LinkButton).CommandArgument;
        panelExperience.Visible = true;                
            LoadGridForExperience(ID);
        
    }
    protected void btnCloseExperience_Click(object sender, EventArgs e)
    {
        panelExperience.Visible = false;
    }

    protected void btnQulaifictionClose_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
    }





    protected void btnCallForInterview_Click(object sender, EventArgs e)
    {
        StringBuilder _StringBuilder = new StringBuilder();
        SqlConnection con = new SqlConnection(_conStr);

        try
        {

            for (int i = 0; i < gvdAApplicants.Rows.Count; i++)
            {

                GridViewRow row = gvdAApplicants.Rows[i];

                bool b=((CheckBox)row.Cells[7].FindControl("chkboxCall")).Checked;
                string val=((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip;
                if (((CheckBox)row.Cells[7].FindControl("chkboxCall")).Checked == true && ((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip=="0")
                {
                    string sdfg=row.Cells[5].ToString();
                    string AppID = ((Label)row.Cells[5].FindControl("lblAppID")).Text;
                    string Advertisment = DDL_Advertisement.SelectedValue;
                    string post = GridViewPosts.SelectedValue;
                    string date = InterviewDate.Value.ToString();
                    string createdby = Session["emp_id"].ToString();
                    string createdOn = DateTime.Now.ToString();

                    string text = @"INSERT INTO [HR].[dbo].[CallForInterView]
           ([AppID]
           ,[InterViewDate]
           ,[Advertisement]
           ,[Post]
           ,[is_Called]
           ,[CreatedOn]
           ,[CreatedBy]           )
     VALUES("+AppID+",'"+date+"',"+Advertisment+","+post+","+1+",'"+createdOn+"',"+createdby+");";
                    _StringBuilder.Append(text.ToString());
                }
               
         
            if (((CheckBox)row.Cells[7].FindControl("chkboxCall")).Checked == false && ((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip !="0")
                {
         

                    string sdfg=row.Cells[5].ToString();
                    string AppID = ((Label)row.Cells[5].FindControl("lblAppID")).Text;
                    string Advertisment = DDL_Advertisement.SelectedValue;
                    string post = GridViewPosts.SelectedValue;
                    string date = InterviewDate.Value.ToString();
                    string createdby = Session["emp_id"].ToString();
                    string createdOn = DateTime.Now.ToString();

                    string text = @"UPDATE [HR].[dbo].[CallForInterView] SET       is_Called =" + 0 + " ,InterViewDate='" + date + "'      WHERE ID=" + ((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip.ToString() + "";
                    _StringBuilder.Append(text);

                }
               
            
             if (((CheckBox)row.Cells[7].FindControl("chkboxCall")).Checked == true && ((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip !="0")
                {
         

                    string sdfg=row.Cells[5].ToString();
                    string AppID = ((Label)row.Cells[5].FindControl("lblAppID")).Text;
                    string Advertisment = DDL_Advertisement.SelectedValue;
                    string post = GridViewPosts.SelectedValue;
                    string date = InterviewDate.Value.ToString();
                    string createdby = Session["emp_id"].ToString();
                    string createdOn = DateTime.Now.ToString();

                    string text = @"UPDATE [HR].[dbo].[CallForInterView] SET       is_Called =" + 1 + ",InterViewDate='" + date + "'         WHERE ID=" + ((CheckBox)row.Cells[7].FindControl("chkboxCall")).ToolTip.ToString() + "";
                    _StringBuilder.Append(text);
                }               
            }

            SqlCommand cmd = new SqlCommand(_StringBuilder.ToString(), con);
            cmd.CommandType = CommandType.Text;
            con.Open();
            cmd.ExecuteNonQuery();

        }
        catch (Exception)
        {


        }
        finally {
            con.Close();
        }
    }
    protected void gvdAApplicants_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType==DataControlRowType.DataRow)
        {
            string ID = ((Label)e.Row.Cells[7].FindControl("lblIsCalled")).Text.ToString();

            if (Convert.ToInt32(ID) == 1)
            {
                ((CheckBox)e.Row.FindControl("chkboxCall")).Checked = true;
            }    
        }
    }
    protected void btnReportforSelectedInterview_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);

        con.Open();
        SqlCommand cmd = new SqlCommand("uspCallApplicantForInterviewForReport", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@advertismentID", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@postID", GridViewPosts.SelectedValue);
        cmd.Parameters.AddWithValue("@inteviewdate", InterviewDate.Value);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("CandidateSelectionForInterview.rdlc");
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
    protected void btnReport1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_conStr);

        con.Open();
        SqlCommand cmd = new SqlCommand("GetApplicantQualificationPercentage4", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@Ad_Sub_Id", GridViewPosts.SelectedValue);
        //cmd.Parameters.AddWithValue("@inteviewdate", InterviewDate.Value);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage_PreInterview.rdlc");
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
}