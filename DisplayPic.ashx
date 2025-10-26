<%@ WebHandler Language="C#" Class="DisplayPic" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;

using System.Configuration;

public class DisplayPic : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {

        if (context.Request.QueryString["Emp_Id"] == null) return;
        context.Response.ContentType = "image/jpeg";
        int Emp_Id = Convert.ToInt32(context.Request.QueryString["Emp_Id"]);

        
            string conn = Convert.ToString(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"]);
            string qry = "SELECT     ISNULL(Picture,'') AS Picture FROM Employee WHERE (EmpID = @EmpID)";
            using (SqlConnection con = new SqlConnection(conn))
            {
                using (SqlCommand cmd = new SqlCommand(qry, con))
                {
                    cmd.Parameters.AddWithValue("@EmpID", Emp_Id);
                    con.Open();

                    using (SqlDataReader rd = cmd.ExecuteReader(CommandBehavior.CloseConnection))
                    {
                        rd.Read();
                        try
                        {
                            if (rd["Picture"] != "0x")
                            {
                                context.Response.BinaryWrite((byte[])rd[rd.GetOrdinal("Picture")]);
                            }
                            else
                            {

                                FileStream fs1 = new FileStream(context.Server.MapPath("") + "/images/PictureFrame.png", FileMode.Open);
                                byte[] b = new byte[fs1.Length + 1];
                                fs1.Read(b, 0, (int)fs1.Length);
                                context.Response.BinaryWrite(b);
                                fs1.Close();
                            }
                           
                        }
                        catch (Exception)
                        {

                        FileStream fs1 = new FileStream(context.Server.MapPath("")+"/images/PictureFrame.png", FileMode.Open);
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}