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

public partial class Rad_Administrator_Patient_Result_Report : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["RadiologyConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadReport();
        }
    }

    
    private void LoadReport()
    {
       
        DbManager dbmanager = new DbManager();
        SqlParameter[] parameter = { new SqlParameter() { ParameterName = "@RegNo", Value = Request.QueryString["RegNo"].ToString() },
                                       new SqlParameter() { ParameterName = "@YearlyNo", Value = Request.QueryString["YearlyNo"].ToString() },
                                       new SqlParameter() { ParameterName = "@Main_ID", Value = Request.QueryString["Main_ID"].ToString() },
                                       new SqlParameter() { ParameterName = "@TGID", Value = Request.QueryString["TGID"].ToString() },
                                       new SqlParameter() { ParameterName = "@TB_ID", Value = Request.QueryString["TB_ID"].ToString() },
                                   };
        DataTable dt = dbmanager.ExecuteDataTable("RadiologyCompnentInformation", "RadiologyConnectionString", parameter);


        DbManager dbmanager2 = new DbManager();
        SqlParameter[] parameter2 = { new SqlParameter() { ParameterName = "@RegNo", Value = Request.QueryString["RegNo"].ToString() },                                       
                                       new SqlParameter() { ParameterName = "@Main_ID", Value = Request.QueryString["Main_ID"].ToString() }                                       
                                   };
        DataTable dt2 = dbmanager2.ExecuteDataTable("RadiologyPatientInformation", "RadiologyConnectionString", parameter2);


        DbManager dbmanager3 = new DbManager();
        SqlParameter[] parameter3 = { new SqlParameter() { ParameterName = "@RegNo", Value = Request.QueryString["RegNo"].ToString() },
                                       new SqlParameter() { ParameterName = "@YearlyNo", Value = Request.QueryString["YearlyNo"].ToString() },
                                       new SqlParameter() { ParameterName = "@Main_ID", Value = Request.QueryString["Main_ID"].ToString() },
                                       new SqlParameter() { ParameterName = "@TGID", Value = Request.QueryString["TGID"].ToString() },
                                       new SqlParameter() { ParameterName = "@TB_ID", Value = Request.QueryString["TB_ID"].ToString() },
                                       
                                       new SqlParameter() { ParameterName = "@EmpId", Value = Session["Emp_Id"].ToString() },
                                   };

        DataTable dt3 = dbmanager3.ExecuteDataTable("RadiologyReportInformation", "RadiologyConnectionString", parameter3);

        ReportViewer1.LocalReport.DataSources.Clear();
        if (Request.QueryString["Header"] != null)
            if (Request.QueryString["Header"].ToString() == "1")
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Patient_Result_Report.rdlc");
        else
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Patient_Result_ReportWithoutHeader.rdlc");
        else
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Patient_Result_Report.rdlc");

        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1",dt));
        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2",dt2));
        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3",dt3));

        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

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

    }


    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }


    }

}