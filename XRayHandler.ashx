<%@ WebHandler Language="C#" Class="XRayHandler" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public class XRayHandler : IHttpHandler {

    String connection = ConfigurationManager.ConnectionStrings["Admin_Rad_ConnectionString"].ToString();
    SqlDataReader reader;
    string querry;

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.QueryString["a"] == "xray")
        {
            querry = "RD_select_Xray";
        }
        else if (context.Request.QueryString["a"] == "image")
        {
            querry = "RD_select_Images";
        }
        else
        {
           querry = "RD_select_characteristics";
       }
        SqlConnection con = new SqlConnection(connection);
        con.Open();
        SqlCommand cmd = new SqlCommand(querry, con);
        cmd.CommandType = CommandType.StoredProcedure;

        if (context.Request.QueryString["a"] == "xray")
        {
            cmd.Parameters.AddWithValue("@body_part_id", context.Request.QueryString["b"]);
        }
        else if (context.Request.QueryString["a"] == "image")
        {
            cmd.Parameters.AddWithValue("@Projection_ID", context.Request.QueryString["b"]);
        }
            
        else
        {
           cmd.Parameters.AddWithValue("@Projection_ID", context.Request.QueryString["b"]);
        }
        reader = cmd.ExecuteReader();

        const string str = @"<?xml version=""1.0"" encoding=""utf-8"" ?>";
        string str1 = "";
        context.Response.ContentType = "application/xml";
        while (reader.Read())
        {
            str1 += "<collection><name>" + reader.GetString(0) + "</name><code>" + reader.GetInt32(1) + "</code></collection>";
        }
        con.Close();
        context.Response.Write(str + "<root>" + str1 + "</root>");
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}