<%@ WebHandler Language="C#" Class="XRayInsertionHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public class XRayInsertionHandler : IHttpHandler {

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
            
            SqlCommand cmd = new SqlCommand("Pt_insert_XRay", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Reg_No",reg_No);
            cmd.Parameters.AddWithValue("@Yearly_No",yearly_No);
            cmd.Parameters.AddWithValue("@XRay_ID",xray_Id);
            cmd.Parameters.AddWithValue("@Emp_ID", emp_id);
            cmd.ExecuteNonQuery();
            context.Response.Write(str + "<root><acknowlegment>Marked</acknowlegment></root>");
        }
        catch (Exception ex) 
        {
         string error = ex.ToString();
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