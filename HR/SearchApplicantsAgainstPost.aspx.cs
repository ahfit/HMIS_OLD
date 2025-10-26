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

public partial class HR_SearchApplicantsAgainstPost : System.Web.UI.Page
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
    
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        searchGrid();
    }

    protected void DDL_Advertisement_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllAdvertisementPosts(DDL_Advertisement.SelectedValue);
    }


    protected void btnReport_Click(object sender, EventArgs e) {

        LoadReport();
     //SqlCommand cmd;
     //   SqlConnection con = new SqlConnection(_conStr);
     //   try
     //   {
     //       con.Open();
     //       cmd = new SqlCommand("usp_AllApplicantsofPost", con);
     //       cmd.CommandType = CommandType.StoredProcedure;
     //       cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
     //       cmd.Parameters.AddWithValue("@Post_Id", ddlPosts.SelectedValue);


     //       SqlDataAdapter da = new SqlDataAdapter(cmd);
     //       DataTable dtforinterviewMarks = new DataTable();
     //       da.Fill(dtforinterviewMarks);


     //   }
     //   catch (Exception ex)
     //   {
     //   }
     //   finally
     //   {
     //       con.Close();
     //   }
    
    
    }

    


    private void searchGrid()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspSearchApplicantFor", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@adid", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@postid", ddlPosts.SelectedValue);
            

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
            SqlCommand cmd = new SqlCommand("usp_AllApplicantsofPost", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Ad_Id", DDL_Advertisement.SelectedValue);
            cmd.Parameters.AddWithValue("@Post_Id", ddlPosts.SelectedValue);
           
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

        da.Fill(dt);

        //DataView view = new DataView(dt);
        //DataTable distinctValues = view.ToTable(true, "iIDd");
        //for (int i = 0; i < distinctValues.Rows.Count; i++) 
        //{

        //    for (int j = 0; j < dt.Rows.Count; j++) 
        //    {

        //        if (Convert.ToInt32(distinctValues.Rows[i]["ID"]) == Convert.ToInt32(dt.Rows[i]["ID"])) 
        //        {
                
                
                
        //        }
            
        //    }
        //}
        //DataRow[] roe=dt.Select("distinct ID");

        //DataTable dt1 = new DataTable();
        //int val = 0;
        //DataRow[] datarow = dt.Select("ID <> 0");
        //for (int i = 0; i < datarow.Length; i++)
        //{
        //    if (i > 0) 
        //    {
        //        if (Convert.ToInt32(datarow[i]["ID"].ToString()) != val)
        //        {
                
        //        }
        //    }
        //    val=  Convert.ToInt32( datarow[i]["ID"].ToString());

        //}



        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;

        ReportViewer1.LocalReport.ReportPath = Server.MapPath("Applicant_Form_ReportCOPY.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
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

        con.Close();

    }
}
