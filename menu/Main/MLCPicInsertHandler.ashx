<%@ WebHandler Language="C#" Class="MLCPicInsertHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


public class MLCPicInsertHandler : IHttpHandler
{
    String connection = ConfigurationManager.ConnectionStrings["MLCConnectionString"].ToString();
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
            string X_axis = context.Request.QueryString["c"].ToString();
            string Y_axis = context.Request.QueryString["d"].ToString();
            string Pic_ID = context.Request.QueryString["e"].ToString();
            string From_Marked = context.Request.QueryString["f"].ToString();

            SqlCommand cmd = new SqlCommand("mlc_insert_picinfo", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@ReqNo", reg_No);
            cmd.Parameters.AddWithValue("@YearlyNo", yearly_No);
            cmd.Parameters.AddWithValue("@xaxis", X_axis);
            cmd.Parameters.AddWithValue("@yaxis", Y_axis);
            cmd.Parameters.AddWithValue("@description", Pic_ID);
            cmd.Parameters.AddWithValue("@From_Marked", From_Marked);
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