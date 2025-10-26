using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pathology_Approved_Report_Status : System.Web.UI.Page

{  
    Encryption enc = new Encryption();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            

         
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (txtMRNo.Text == "" && txtMobile.Text == "")
        {
            return;
        }
        string s = ConfigurationManager.ConnectionStrings["Pathology2ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(s);
        SqlCommand cmd = new SqlCommand();


        cmd = new SqlCommand("GetPatientReportMRWise", con);
        cmd.CommandType = CommandType.StoredProcedure;
        string RegNo = txtMRNo.Text;
        if (RegNo == "")
        {
            RegNo = "0";
        }
        string MobileNo = txtMobile.Text;
        if (MobileNo == "")
        {
            MobileNo = "0";
        }
        cmd.Parameters.Add("@MRNo", SqlDbType.VarChar).Value = RegNo;
        cmd.Parameters.Add("@MobileNo", SqlDbType.VarChar).Value = MobileNo;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        grdcode.DataSource = ds;
        grdcode.DataBind();
        //cmd.ExecuteNonQuery();
        con.Close();

    }

    protected void grdcode_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int row = grdcode.SelectedRow.RowIndex;
            string Report = grdcode.Rows[row].Cells[2].Text;

            Response.ContentType = "Application/pdf";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Report);
            Response.TransmitFile(Server.MapPath("~/Pathology/Patientlabreports/" + Report));
            Response.End();
        }
        catch (Exception ex)
        {

        }
    }
//    protected void grdcode_RowCommand(object sender, GridViewCommandEventArgs e)
//{
//    try
//        {
//            int row = grdcode.SelectedRow.RowIndex;
//            string Report = e.CommandArgument.ToString();

//            if (!string.IsNullOrEmpty(Report))
//            {
//                    Response.ContentType = "application/pdf";
//                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + Report);
//                    Response.TransmitFile(Server.MapPath("~/Pathology/Patientlabreports/" + Report));
//                    Response.End();
//                }
//            }
       
//        catch (Exception ex)
//        {
            
//        }
//    }
}