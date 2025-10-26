<%@ WebHandler Language="C#" Class="Participant_Pic" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;

using System.Configuration;

public class Participant_Pic : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {

        if (context.Request.QueryString["Emp_Id"] == null) return;
        context.Response.ContentType = "image/jpeg";
        string Emp_Id = Convert.ToString(context.Request.QueryString["Emp_Id"]);

        string conn = Convert.ToString(ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"]);
        string qry = "select picture from Employee where empid = " + Emp_Id;
        using (SqlConnection con = new SqlConnection(conn))
        {
            using (SqlCommand cmd = new SqlCommand(qry, con))
            {
                con.Open();

                using (SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                {
                    rd.Read();
                    try
                    {
                        if (rd["Picture"] != "0x" && rd["Picture"].ToString()  != string.Empty)
                        {
                            context.Response.BinaryWrite((byte[])rd[rd.GetOrdinal("Picture")]);
                        }
                        else
                        {

                            FileStream fs1 = new FileStream(context.Server.MapPath("") + "/images_hacims/picplace.jpg", FileMode.Open);
                            byte[] b = new byte[fs1.Length + 1];
                            fs1.Read(b, 0, (int)fs1.Length);
                            context.Response.BinaryWrite(b);
                            fs1.Close();
                        }
                    }
                    catch (Exception)
                    {

                        FileStream fs1 = new FileStream(context.Server.MapPath("") + "/images_hacims/picplace.jpg", FileMode.Open);
                        byte[] b = new byte[fs1.Length + 1];
                        fs1.Read(b, 0, (int)fs1.Length);
                        context.Response.BinaryWrite(b);
                        fs1.Close();
                    }
                    rd.Close();
                }
            }

        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}