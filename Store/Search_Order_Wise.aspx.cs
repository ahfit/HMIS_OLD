using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class Search_Order_Wise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!Page.IsPostBack)
        {
            Show_Rpt();
        }


    }
    
 private void Show_Rpt()
 {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;

            SqlCommand cmd;
            SqlConnection con=new SqlConnection(conStr);
            cmd = new SqlCommand("Search_Order_Wise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Consumption_Id", Convert.ToDecimal(Request.QueryString["C_ID"].ToString()));
            cmd.Parameters.AddWithValue("@Requisition_Id", "0");
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
          
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource reportDataSource = new ReportDataSource();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "Search_Order_Wise";
            reportDataSource.Value = dt;
            String path = "";
            if (Request.QueryString["R"] != null)
            {

                 path = Server.MapPath("Search_Order_Wise_Report_With_Rate.rdlc");
            }
            else
            {
                 path = Server.MapPath("Search_Order_Wise_Report.rdlc");
            }

            ReportViewer1.LocalReport.ReportPath = path;
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);

            //if( Request.UserAgent.Contains("Chrome"))
            //{
            //     Byte []bytes= ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}
         
            //else
                ReportViewer1.Visible = true;




            

        }
        catch (Exception ex)
        {

        }
    }

    protected void btn_report_Click(object sender, EventArgs e)
    {
        Show_Rpt();
    }


   
    
}


    