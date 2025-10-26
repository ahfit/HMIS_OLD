using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class HR_Advertisement_Selected_Candidate_For_Job : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
            LoadGrid();
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
        LoadGrid();
    }

    private void LoadGrid()
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("usp_GetSelectedCandidate", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@advertismentID", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@postID", GridViewPosts.SelectedValue);
        cmd.Parameters.AddWithValue("@type", DDL_Candidate_Type.SelectedValue);
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        DataTable tb = new DataTable();
        adpter.Fill(tb);


        Cache["data"] = tb;

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
        panelExperience.Visible = true;
        LoadGridForExperience(ID);
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


    protected void GridViewPosts_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadGrid();
    }
    private string CheckCandidateConfirmation(string appID,string AdDID,string postid)
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand(@"declare @count int select @count=COUNT(id) from ApplicantConfirmationAfterSelection where ApplicantID="+appID+" and Ad_ID="+AdDID+" and PostId="+postid+" select @count ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataReader reader = cmd.ExecuteReader();
        string count="";

        while (reader.Read())
        {
            count=reader[0].ToString();
        }
        con.Close();
        return count;

    }
    protected void lbtnAppointLetter_Click(object sender, EventArgs e)
    {
        string ID = (sender as LinkButton).CommandArgument;

        string count = CheckCandidateConfirmation(ID, DDL_Advertisement.SelectedValue, GridViewPosts.SelectedValue);

        //if (Convert.ToInt32(count) > 0)
        //{
            labelmsg.Visible = false;
            Response.Redirect("EmployeeAppointmentLetter.aspx?AppID=" + ID);
           
        //}
        //else
        //{
        //    labelmsg.Visible = true;
        //    labelmsg.Text = "Candidate confirmation is Required";
        //}
        
    }
    protected void lbtnArrivalReport_Click(object sender, EventArgs e)
    {
        string ID = (sender as LinkButton).CommandArgument;

        //string count = CheckCandidateConfirmation(ID, DDL_Advertisement.SelectedValue, GridViewPosts.SelectedValue);

        //if (Convert.ToInt32(count) > 0)
        //{
            Response.Redirect("EmployeeArrivalLetter.aspx?AppID=" + ID);
            labelmsg.Visible = false;
        //}
        //else
        //{
//labelmsg.Visible = true;
  //          labelmsg.Text = "Candidate confirmation is Required";
       // }

    }

    protected void gvdAApplicants_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //if (Convert.ToInt32(DDL_Candidate_Type.SelectedValue) == 0)
            //{
            //    //LinkButton lbtnAppointLetter = (LinkButton)e.Row.FindControl("lbtnAppointLetter");
            //    //LinkButton lbtnArrivalReport = (LinkButton)e.Row.FindControl("lbtnArrivalReport");
            //    //lbtnAppointLetter.Visible = false;
            //    //lbtnArrivalReport.Visible = false;
            //}
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {


        DataTable dt1 = new DataTable();
        dt1 = loadSelectedCandidate();
        LoadReport(dt1);
        DataTable dt = Cache["data"] as DataTable;
       
        Cache.Remove("data");
    }
    private DataTable loadSelectedCandidate() 
    {
        DataTable tb = new DataTable();
        try
        {
            SqlConnection con = new SqlConnection(_conStr);
            SqlCommand cmd = new SqlCommand("usp_GetSelectedCandidate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@advertismentID", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postID", GridViewPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@type", DDL_Candidate_Type.SelectedValue);
            SqlDataAdapter adpter = new SqlDataAdapter(cmd);
            
            adpter.Fill(tb);
            return tb;

        }
        catch(Exception ex)
        {}
        return tb;
    }
    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }
    }
    protected void LoadReport(DataTable dt)
    {



        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("SelectedCandidate.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);

        ReportParameter[] repParams = new ReportParameter[2];

        repParams[0] = new ReportParameter("SelectedCadidate",DDL_Candidate_Type.SelectedItem.Text);
        repParams[1] = new ReportParameter("ForPost",GridViewPosts.SelectedItem.Text);
        ReportViewer1.LocalReport.SetParameters(repParams);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();
        if (Request.Browser.Browser == "Chrome")
        {
            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(bytes);
            Response.End();
        }

        else
            ReportViewer1.Visible = true;

    }



    protected void btnAdd_Click1(object sender, EventArgs e)
    {
        LoadGrid();
    }
}

