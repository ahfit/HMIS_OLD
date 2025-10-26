using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Configuration;

public partial class DashBoards_ServicesStrengthActivityServiceWise : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        if (!Page.IsPostBack)
        {
            FillHospital();
            wdcStartDate.Value = DateTime.Now.AddDays(-3);
            wdcEndDate.Value = DateTime.Now;
            ShowReport();
           
           
        }
    }
    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Hospital.DataValueField = "Hospital_ID";
            ddl_Hospital.DataTextField = "Hospital_Name";
            ddl_Hospital.DataSource = dt;
            ddl_Hospital.DataBind();
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        ShowReport();
    }
    protected void ShowReport()
    {         
            sdsPatientCount.SelectParameters["Start_Date"].DefaultValue = wdcStartDate.Value.ToString();
            sdsPatientCount.SelectParameters["End_Date"].DefaultValue = wdcEndDate.Value.ToString();
            sdsPatientCount.SelectParameters["HospitalID"].DefaultValue = ddl_Hospital.SelectedValue;
           
            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;

            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/ServicesStrengthActivityServiceWise_Report.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            ReportViewer1.LocalReport.Refresh();
     }
   }