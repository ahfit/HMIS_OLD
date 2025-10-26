using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DoctorShare_BirthAndDeathReport : System.Web.UI.Page
{
    SqlDataAdapter _SqlAdapter = new SqlDataAdapter();
    SqlConnection _SqlCon = default(SqlConnection);
    SqlCommand _SqlCommand = new SqlCommand();
    DataTable _dtConsultant = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtSDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtEDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
          
           
        }
    }

    private void ShowReport()
    {
        try
        {
            DbManager dbMgr = new DbManager();
           
            SqlParameter[] para = { new SqlParameter("@FromDate", txtSDate.Text),
                                      new SqlParameter("@EndDate", txtEDate.Text),
                                      new SqlParameter("@RegNo",regno.Text),
                                   new SqlParameter("@Status", ddl_Status.SelectedValue),

                                  };
            DataTable dt = dbMgr.ExecuteDataTable("[Usp_GetPatientStatusReport]", "Reg_ConnectionString", para);

            DateTime startDate = Convert.ToDateTime(txtSDate.Text);
            DateTime EndDate = Convert.ToDateTime(txtEDate.Text);
            ReportParameter[] param = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/DoctorShare/PatientStatusReport.rdlc");
            ReportViewer1.LocalReport.SetParameters(param);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            repDs.Name = "DataSet1";
            repDs.Value = dt;
            ReportViewer1.LocalReport.DataSources.Add(repDs);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
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
    protected void btnReport_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}