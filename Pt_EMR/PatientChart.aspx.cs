using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Pt_EMR_PatientChart : System.Web.UI.Page
{
    Encryption enc = new Encryption();
    DbManager dbmgr = new DbManager();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadReport();
    }
    private void LoadReport()
    {
        if (Request.QueryString["RegNo"] != null && Request.QueryString["YearlyNo"] != null)
        {
            try
            {
               
                SqlParameter[] param = { 
                                           new SqlParameter("@RegNo", Request.QueryString["RegNo"]), 
                                           new SqlParameter("@YearlyNo", Request.QueryString["YearlyNo"])
                                       };
                ReportViewer1.LocalReport.DataSources.Clear();
                ds = dbmgr.ExecuteDataSet("PatientChart_GetAllData", "Basic_Data_ConnectionString", param);

                //string reportPath = Server.MapPath("~/Pt_EMR/PatientChart.rdlc");
                string reportPath = Server.MapPath("~/Pt_EMR/PatientChartNew.rdlc");
                ReportViewer1.LocalReport.ReportPath = reportPath;
                
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_BasicInfo", ds.Tables[0]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Vitals", ds.Tables[1]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Complaint", ds.Tables[2]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_History", ds.Tables[3]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Examination", ds.Tables[4]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_PatientDiagnosis", ds.Tables[5]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Medication", ds.Tables[6]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Investigations", ds.Tables[7]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_PhysicianNotes", ds.Tables[8]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_ReferalNotes", ds.Tables[9]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_Recommendations", ds.Tables[10]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_LabInvestigations", ds.Tables[11]));
                ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet_RadialogyTestResults", ds.Tables[12]));


                ReportParameter rp = new ReportParameter("YearlyNo", Request.QueryString["YearlyNo"]);

                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp });
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
                {
                    ReportViewer1.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

        }
    }
}