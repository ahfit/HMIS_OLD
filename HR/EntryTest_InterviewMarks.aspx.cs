using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class HR_EntryTest_InterviewMarks : System.Web.UI.Page
{
    bool chk = true;
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            GetAllActiveAdvertisement();
            GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
            get_allQualifications();
            tblMarks.Visible = false;

            if (!String.IsNullOrEmpty(Request.QueryString["AppID"]))
            {
                DDL_Advertisement.SelectedValue = Request.QueryString["advId"];
                GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
                ddlPosts.SelectedValue = Request.QueryString["postid"];
                DDL_Qualification.SelectedValue = "5";
                DDL_Advertisement.Enabled = false;
                ddlPosts.Enabled = false;
                DDL_Qualification.Enabled = false;
            }
        }
    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        searchGrid();
    }


    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            
            con = new SqlConnection(_conStr);
            con.Open();
            double obtndmarks = 0;
            foreach (GridViewRow row in GridView_Applicants.Rows)
            {
                HiddenField lblAdd_QulifincationID = (HiddenField)row.FindControl("App_Quali_Id");
                HiddenField lblAdd_App_ID = (HiddenField)row.FindControl("hfappid");
                TextBox ac = (TextBox)row.FindControl("lblEntryTestTotal");
                if(ac.Enabled==true)
                {
                    TextBox txtEntryTestTotal = (TextBox)row.FindControl("lblEntryTestTotal");
                    obtndmarks = Convert.ToDouble(txtEntryTestTotal.Text);
                }
                else if (ac.Enabled == false) 
                {
                    HiddenField txtEntryTestTotal = (HiddenField)row.FindControl("hdnTestTotal");
                    obtndmarks = Convert.ToDouble(txtEntryTestTotal.Value);
                }
                
                TextBox txtEntryTestobtain = (TextBox)row.FindControl("txtEntryTestobtain");

                double percent = (Convert.ToDouble(txtEntryTestobtain.Text) / Convert.ToDouble(obtndmarks)) * 100;

                cmd = new SqlCommand("addIntrviewEntryTestMarks", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@AppID", lblAdd_App_ID.Value);
                cmd.Parameters.AddWithValue("@obtaind", txtEntryTestobtain.Text);
                cmd.Parameters.AddWithValue("@marks", obtndmarks);
                cmd.Parameters.AddWithValue("@qualificationid", DDL_Qualification.SelectedValue);
                cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                cmd.Parameters.AddWithValue("@adID", DDL_Advertisement.SelectedValue);
                cmd.Parameters.AddWithValue("@percentage", percent);
                cmd.Parameters.AddWithValue("@status", lblAdd_QulifincationID.Value);
                cmd.ExecuteNonQuery();
            }
            searchGrid();
        }





        catch (Exception ex)
        {
            con.Close();
        }
        finally
        {
            con.Close();
        }
    }




    //protected void btnEtoExcel_Click(object sender, EventArgs e)
    //{
    //    try
    //    {

    //        HtmlForm form = new HtmlForm();
    //        Response.Clear();
    //        Response.Buffer = true;
    //        Response.Charset = "";
    //        Response.AddHeader("content-disposition", string.Format("attachment;filename={0}", "Entry Test and Interview Result.xls"));
    //        Response.ContentType = "application/ms-excel";
    //        StringWriter sw = new StringWriter();

    //        GridView_Applicants.AllowPaging = false;

    //        HtmlTextWriter hw = new HtmlTextWriter(sw);

    //        form.Attributes["runat"] = "server";
    //        form.Controls.Add(GridView_Applicants);
    //        this.Controls.Add(form);
    //        form.RenderControl(hw);
    //        string style = "<!--mce:2-->";
    //        Response.Write(style);
    //        Response.Output.Write(sw.ToString());
    //        Response.Flush();
    //        Response.End();


    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}

    private void GetAllActiveAdvertisement()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT  Ad_Title, Ad_Id FROM Advertisement_Main where Is_Active=1  order by Ad_Title", con);
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
    }


    private void get_allQualifications()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {

            con.Open();
            cmd = new SqlCommand("SELECT  Qualifications.Qualification_Id, Qualifications.Qualification_Name, Created_On FROM "
            + "Qualifications  where    (Qualifications.Is_deleted is NULL)", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Qualification.DataSource = dt;
            DDL_Qualification.DataBind();


        }
        catch (Exception ex)
        {

            con.Close();
        }
    }



    private DataTable Applicantmarks()
    {

        DataTable dtMarks = new DataTable();
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspGetApplicantMarksDetail", con);
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




    public class applicantDetail
    {

        public int appid { get; set; }
        public int qid { get; set; }
        public string marks { get; set; }


    }
    private void searchGrid()
    {

        if (DDL_Qualification.SelectedValue == "5" || DDL_Qualification.SelectedValue == "6")
        {
            tblMarks.Visible = true;
            settxtboxdisable();
            chk = false;
        }
        else
        {
            tblMarks.Visible = false;
            //
        }
        
       
            SqlCommand cmd;
            SqlConnection con = new SqlConnection(_conStr);
            try
            {
                con.Open();
                if (DDL_Qualification.SelectedValue == "6")
                {

                    cmd = new SqlCommand("uspGetApplicantForInterviewtest", con);
                }
                else
                {
                    cmd = new SqlCommand("uspGetApplicantForInterviewa", con);
                    if (!String.IsNullOrEmpty(Request.QueryString["AppID"]))
                    {
                        cmd.Parameters.AddWithValue("@AppID", Request.QueryString["AppID"]);
                    }
                }
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
                cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
                cmd.Parameters.AddWithValue("@Qualificationid", DDL_Qualification.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dtforinterviewMarks = new DataTable();
                da.Fill(dtforinterviewMarks);
                GridView_Applicants.DataSource = dtforinterviewMarks;
                GridView_Applicants.DataBind();

            }
            catch (Exception ex)
            {
            }
            finally
            {
                con.Close();
            }
        

    }

    protected void DDL_Qualification_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    private void settxtboxdisable()
    {

        foreach (GridViewRow row in GridView_Applicants.Rows)
        {
            TextBox txtbox = row.FindControl("lblEntryTestTotal") as TextBox;
             HiddenField txtEntryTestTotal = (HiddenField)row.FindControl("hdnTestTotal");
             txtEntryTestTotal.Value = txtTotalMarks.Text;
            txtbox.Text = txtTotalMarks.Text;
            txtbox.Enabled = false;
        }
        chk = false;
    }
    protected void GridView_Applicants_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TextBox txtbox_T = e.Row.FindControl("lblEntryTestTotal") as TextBox;
            TextBox txtbox_O = e.Row.FindControl("txtEntryTestobtain") as TextBox;

            HiddenField ID =(HiddenField)  e.Row.FindControl("hfappid") ;
            HiddenField TT = (HiddenField) e.Row.FindControl("Merit_experience");



            if (DDL_Qualification.SelectedValue == "5" || DDL_Qualification.SelectedValue == "6" )
            {
                txtbox_T.Enabled = false;
              
            }
            else
            {
                if (DDL_Qualification.SelectedValue == "14" && txtbox_T.Text == "0")
                {
                    txtbox_T.Text = TT.Value;
                    txtbox_O.Text = getpostObtain(ID.Value);


                }
                txtbox_T.Enabled = true;
                txtbox_O.Enabled = true;

            }
        }
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
    protected void LoadReport()
    {

        SqlConnection con = new SqlConnection(_conStr);

        con.Open();
        SqlCommand cmd = new SqlCommand("GetApplicantQualificationPercentage", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@Ad_Sub_Id", ddlPosts.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();

        da.Fill(dt);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;

        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
        //ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
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

    protected void btnBlankReport_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(DDL_Qualification.SelectedValue) == 5)
        {
            LoadReport();
        }
        else
        {
            SqlConnection con = new SqlConnection(_conStr);

            con.Open();
            SqlCommand cmd = new SqlCommand("GetApplicantEntryTestMarks", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@Ad_Sub_Id", ddlPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@Qualification_Id", DDL_Qualification.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("EmpQualificationAgainstPostAndQId.rdlc");
            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("ApplicantQualificationPercentage.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
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

    //private string getpostTotal()
    //{

    //    string status = "0";
    //    SqlCommand cmd;
    //    SqlConnection con = new SqlConnection(_conStr);
    //    try
    //    {
    //        con.Open();
    //        cmd = new SqlCommand("Select Experience from Advertisement_Sub where Ad_Id =@adid and ad_sub_id=@postid", con);
    //        cmd.CommandType = CommandType.Text;
    //        cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
    //        cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
    //        status = cmd.ExecuteScalar() as string;
    //        if (string.IsNullOrEmpty(status))
    //        {
    //            status = "0";
    //        }
    //    }
    //    catch { }
    //    finally { con.Close(); }
    //    return (status);
    //}
    private string getpostObtain( string AppID)
    {

        string status = "0";
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();

            cmd = new SqlCommand("Select sum(isnull(marks,0)) as T from adv_experience_marks where ad_id = @adid"
                + " and ad_sub_ID =@postid and [year] <=  (Select Sum( DATEDIFF(DAY, A.DateFrom ,A.DataTo))/365"
                + "from ApplicantExperience A where A.AppID =@AppID and A.isrelevent = 1)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            cmd.Parameters.AddWithValue("@AppID", AppID);
            status = cmd.ExecuteScalar().ToString() ; 
            if (string.IsNullOrEmpty(status))
            {
                status = "0";
            }
        }
        catch { }
        finally { con.Close(); }
        return (status);
    }
}