using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
public partial class HR_EmployeeList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) {

            WebCalendar_Date_of_Birth.Value = DateTime.Now.AddMonths(-1);
            HFStartDate.Value = WebCalendar_Date_of_Birth.Value.ToString();

            WebDateChooser1.Value = DateTime.Now;
            HFEndDate.Value = WebDateChooser1.Value.ToString();

            showReport();

        }
         // WebCalendar_Date_of_Birth.Value WebDateChooser1.Value
    }

    private void showReport() {
        HFStartDate.Value = WebCalendar_Date_of_Birth.Value.ToString();
        HFEndDate.Value = WebDateChooser1.Value.ToString();

        DbManager manager = new DbManager();
        
        SqlParameter[] par = {
            new SqlParameter("@ActiveStatus", hdfCurrentEmployee.Value),
            new SqlParameter("@StartDate",Convert.ToDateTime(HFStartDate.Value).ToString("yyyy-MM-dd")),
            new SqlParameter("@EndDate",Convert.ToDateTime(HFEndDate.Value).ToString("yyyy-MM-dd"))
            };
        DataTable dt = manager.ExecuteDataTable("usp_EmployeeStatus", "HRConnectionString", par);

        if (hdfCurrentEmployee.Value == "0")
        {

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/hr/CurrentExEmployeeList.rdlc");
        }
        else
        {
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/hr/CurrentEmployeeList.rdlc");
        }
    ReportViewer1.LocalReport.DataSources.Clear();
    ReportDataSource repDs = new ReportDataSource();
    repDs.Name = "DataSet1";
    repDs.Value = dt;
   
    ReportViewer1.LocalReport.DataSources.Add(repDs);
   ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

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
    protected void btnCurrentEmployee_Click(object sender, EventArgs e) {
        hdfCurrentEmployee.Value = "1";
        showReport();
    }
    protected void btnExEmployee_Click(object sender, EventArgs e) {

        hdfCurrentEmployee.Value = "0";
        showReport();
    }

  
}