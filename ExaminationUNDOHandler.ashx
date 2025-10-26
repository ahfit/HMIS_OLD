<%@ WebHandler Language="C#" Class="ExaminationUNDOHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public class ExaminationUNDOHandler : IHttpHandler
{
    String connection = ConfigurationManager.ConnectionStrings["LGHConnectionString"].ToString();
    const string str = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
    
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/xml";
        SqlConnection con = new SqlConnection(connection);
        con.Open();
        
        try
        {
            string yearly_No = context.Request.QueryString["a"].ToString();
            string Pic_ID = context.Request.QueryString["b"].ToString();
            SqlCommand cmd = new SqlCommand("Pt_undo_Examination", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Yearly_No", yearly_No);
            cmd.Parameters.AddWithValue("@Pic_ID", Pic_ID);
            
            cmd.ExecuteNonQuery();
            context.Response.Write(str + "<root><acknowlegment>Undo Complete</acknowlegment></root>");
        }
        catch (Exception ex) 
        {
            context.Response.Write(str + "<root><acknowlegment>Undo faild</acknowlegment></root>");
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