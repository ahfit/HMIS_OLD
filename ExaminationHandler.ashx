<%@ WebHandler Language="C#" Class="ExaminationHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public class ExaminationHandler : IHttpHandler
{
    String connection = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();
    const string str = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/xml";
        SqlConnection con = new SqlConnection(connection);
        con.Open();
        
        try
        {
            string reg_No = context.Request.QueryString["a"].ToString();
            string yearly_No = context.Request.QueryString["b"].ToString();
            string xray_Id = context.Request.QueryString["c"].ToString();
            string emp_id=context.Request.QueryString["d"].ToString();
            string X_axis = context.Request.QueryString["e"].ToString();
            string Y_axis = context.Request.QueryString["f"].ToString();
            string Pic_ID = context.Request.QueryString["g"].ToString();
            string Region_ID = context.Request.QueryString["h"].ToString();
            context.Response.Write(reg_No + " yn " + yearly_No + " xr " + xray_Id + " mp " + emp_id + " xaxis " + X_axis + " yaxis " + Y_axis + " picid " + Pic_ID + " regionid " + Region_ID);
            SqlCommand cmd = new SqlCommand("Pt_insert_Examination", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Reg_No",reg_No);
            cmd.Parameters.AddWithValue("@Yearly_No",yearly_No);
            cmd.Parameters.AddWithValue("@XRay_ID",xray_Id);
            cmd.Parameters.AddWithValue("@Emp_ID", emp_id);
            cmd.Parameters.AddWithValue("@X_axis", X_axis);
            cmd.Parameters.AddWithValue("@Y_axis", Y_axis);
            cmd.Parameters.AddWithValue("@Pic_ID", Pic_ID);
            cmd.Parameters.AddWithValue("@region_ID", Region_ID);
            cmd.ExecuteNonQuery();
                      context.Response.Write(str + "<root><acknowlegment>Marked</acknowlegment></root>");
        }
        catch (Exception ex) 
        {
            context.Response.Write(str + "<root><acknowlegment>ParaMeter Missing Or Alrady Marked</acknowlegment></root>");
            con.Close();
        }  
       
       
        con.Close();
  
       
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
