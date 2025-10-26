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

public partial class HR_CandidateSelectionAfterInterview : System.Web.UI.Page
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
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        getdata();
    }
    private void LoadGrid()
    {
        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("uspApplicantSelectionAfterInterview ", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@advertismentID", DDL_Advertisement.SelectedValue);
        cmd.Parameters.AddWithValue("@postID", ddlPosts.SelectedValue);
        // cmd.Parameters.AddWithValue("@interviewdate", InterviewDate.Value);
        SqlDataAdapter adpter = new SqlDataAdapter(cmd);
        DataTable tb = new DataTable();
        adpter.Fill(tb);

        gvdAApplicants.DataSource = tb;
        gvdAApplicants.DataBind();
    }
    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
    }
    protected void btnSelection_Click(object sender, EventArgs e)
    {
        StringBuilder _StringBuilder = new StringBuilder();
        SqlConnection con = new SqlConnection(_conStr);

        try
        {

            for (int i = 0; i < gvdAApplicants.Rows.Count; i++)
            {

                GridViewRow row = gvdAApplicants.Rows[i];
                bool b = ((CheckBox)row.FindControl("chkboxCall")).Checked;
                string fdg = ((Label)row.FindControl("lblIsCalled")).Text;

                if (((CheckBox)row.FindControl("chkboxCall")).Checked == false && ((Label)row.FindControl("lblIsCalled")).Text == "True")
                {

                    //string totalMarks = ((TextBox)row.Cells[5].FindControl("txtboxTotalMarks")).Text;
                    //string marksObtained = ((TextBox)row.Cells[6].FindControl("txtboxObtained")).Text;
                    //string Remarks = ((TextBox)row.Cells[7].FindControl("txtboxRemarks")).Text;                                                           
                    string createdby = Session["emp_id"].ToString();
                    string createdOn = DateTime.Now.ToString();

                    string text = @"UPDATE [HR].[dbo].[CallForInterView]  SET [Is_Selected] =NULL    WHERE ID=" + ((CheckBox)row.FindControl("chkboxCall")).ToolTip.ToString() + ";";

                    //string text = @"UPDATE [HR].[dbo].[CallForInterView]  SET [Is_Selected] =NULL ,[Remarks] ='"+Remarks+"'       ,[MarksTotal] = "+totalMarks+"     ,[MarksObtained] ="+marksObtained+"     WHERE ID=" + ((CheckBox)row.Cells[8].FindControl("chkboxCall")).ToolTip.ToString() + ";";
                    _StringBuilder.Append(text);

                }

                //if (((CheckBox)row.Cells[8].FindControl("chkboxCall")).Checked == true && ((Label)row.Cells[8].FindControl("lblIsCalled")).Text == "1")
                //{

                //    string totalMarks = ((TextBox)row.Cells[5].FindControl("txtboxTotalMarks")).Text;
                //    string marksObtained = ((TextBox)row.Cells[6].FindControl("txtboxObtained")).Text;
                //    string Remarks = ((TextBox)row.Cells[6].FindControl("txtboxRemarks")).Text;
                //    string createdby = Session["emp_id"].ToString();
                //    string createdOn = DateTime.Now.ToString();

                //    string text = @"UPDATE [HR].[dbo].[CallForInterView]  SET [Is_Selected] = " + 0 + "     ,[Remarks] ='" + Remarks + "'       ,[MarksTotal] = " + totalMarks + "     ,[MarksObtained] =" + marksObtained + "     WHERE ID=" + ((CheckBox)row.Cells[8].FindControl("chkboxCall")).ToolTip.ToString() + ";";
                //    _StringBuilder.Append(text);

                //}


                if (((CheckBox)row.FindControl("chkboxCall")).Checked == true && ((Label)row.FindControl("lblIsCalled")).Text == "False")
                {


                    //string totalMarks = ((TextBox)row.Cells[5].FindControl("txtboxTotalMarks")).Text;
                    //string marksObtained = ((TextBox)row.Cells[6].FindControl("txtboxObtained")).Text;
                    //string Remarks = ((TextBox)row.Cells[6].FindControl("txtboxRemarks")).Text;
                    string createdby = Session["emp_id"].ToString();
                    string createdOn = DateTime.Now.ToString();

                    string text = @"UPDATE [HR].[dbo].[CallForInterView]  SET [Is_Selected] = " + 1 + "       WHERE ID=" + ((CheckBox)row.FindControl("chkboxCall")).ToolTip.ToString() + ";";

                    //string text = @"UPDATE [HR].[dbo].[CallForInterView]  SET [Is_Selected] = " + 1 + "     ,[Remarks] ='" + Remarks + "'       ,[MarksTotal] = " + totalMarks + "     ,[MarksObtained] =" + marksObtained + "     WHERE ID=" + ((CheckBox)row.Cells[8].FindControl("chkboxCall")).ToolTip.ToString() + ";";
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
        finally
        {
            con.Close();
        }
    }
    protected void gvdAApplicants_RowDataBound(object sender, GridViewRowEventArgs e)
    {
            //e.Row.Cells[4].Visible = false;
            //e.Row.Cells[5].Visible = false;
            //e.Row.Cells[6].Visible = false;
                            
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

           
            //string ID = ((Label)e.Row.FindControl("lblIsCalled")).Text.ToString();

            //if (Convert.ToInt32(ID) == 1)
            //{
            //    ((CheckBox)e.Row.FindControl("chkboxCall")).Checked = true;
            //}
        }
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
        finalDatasert.Columns.Add("Is_Selected");
        
        
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

        decimal experienceMarks = 0;
        for (int i = 0; i < AppID.Count; i++)
        {
            DataRow rows = null;
            DataRow newRow = finalDatasert.NewRow();
            rows = dtmarks.Select("AppID=" + AppID[i] + " ").First();

            newRow["Advrertisment"] = rows["Ad_Title"].ToString();
            newRow["Title"] = rows["Title"].ToString();
            newRow["Name"] = rows["name"].ToString();                               
            newRow["CNIC"] = rows["CNIC"].ToString();
            newRow["Mobile_Number"] = rows["Mobile_Number"].ToString();
            newRow["Is_Selected"] = rows["Is_Selected"].ToString();
            newRow["ID"] = rows["ID"].ToString();
            
            
            decimal finalMarks = 0;
            experienceMarks = 0;
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

            gvdAApplicants.DataSource = finalDatasert;



            gvdAApplicants.DataBind();
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

   
    protected void gvdAApplicants_PreRender(object sender, EventArgs e)
    {
        if (gvdAApplicants.Rows.Count > 0)
        {
            //gvdAApplicants.Columns[4].Visible = false;




            //gvdAApplicants.HeaderRow.Cells[4].Visible = false;
            //gvdAApplicants.HeaderRow.Cells[5].Visible = false;
            //gvdAApplicants.HeaderRow.Cells[6].Visible = false;


        }


    }

}