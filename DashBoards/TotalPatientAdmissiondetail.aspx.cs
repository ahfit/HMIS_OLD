using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;


public partial class DashBoards_TotalPatientAdmissiondetail : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        if (!Page.IsPostBack)
        {
            FillHospital();
            wdcStartDate.Value = DateTime.Now.AddDays(-3);
            wdcEndDate.Value = DateTime.Now;
            loadPatientType();
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
    private void loadPatientType()
    {
        string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(RegconString);
            con.Open();
            cmd = new SqlCommand("Select 0 as ID, 'ALL' Patient_Type UNION select ID, Patient_Type from Patient_Type where Active=1 order by Patient_Type ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_PatientType.DataSource = dt;
            DropDownList_PatientType.DataTextField = "Patient_type";
            DropDownList_PatientType.DataValueField = "ID";

            DropDownList_PatientType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
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
        sdsPatientCount.SelectParameters["startDate"].DefaultValue = wdcStartDate.Value.ToString();
        sdsPatientCount.SelectParameters["endDate"].DefaultValue = wdcEndDate.Value.ToString();
        sdsPatientCount.SelectParameters["type"].DefaultValue = DropDownList_PatientType.SelectedValue;
        sdsPatientCount.SelectParameters["HospitalID"].DefaultValue = ddl_Hospital.SelectedValue;
        
            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;

            DateTime startDate = Convert.ToDateTime(wdcStartDate.Value);
            DateTime EndDate = Convert.ToDateTime(wdcEndDate.Value);
            ReportParameter[] para = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")) };
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/TotalPatientAdmissionDetail.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;

            ReportViewer1.LocalReport.SetParameters(para);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
     }
   }