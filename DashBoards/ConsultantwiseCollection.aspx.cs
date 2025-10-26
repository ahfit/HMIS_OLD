using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

public partial class DashBoards_consultantwiseCollection : System.Web.UI.Page
{

    SqlDataAdapter _SqlAdapter = new SqlDataAdapter();
    SqlConnection _SqlCon = default(SqlConnection);
    SqlCommand _SqlCommand = new SqlCommand();
    DataTable _dataTable = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        if (!Page.IsPostBack)
        {
            wdcStartDate.Value = DateTime.Now.AddDays(-3);
            wdcEndDate.Value = DateTime.Now;
           
            loadDepartment();
            GetConsultants();
            ShowReport();
           
           
        }
    }
    public DataTable ExecuteDataTable(string ProcedureName, string connStr, SqlParameter[] prms)
    {

        try
        {

            Openconn(connStr);
            _dataTable = new DataTable();
            _SqlCommand = new SqlCommand(ProcedureName, _SqlCon);
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlCommand.CommandText = ProcedureName;
            foreach (SqlParameter sqlParam in prms)
            {
                _SqlCommand.Parameters.Add(sqlParam);
            }


            _SqlAdapter.SelectCommand = _SqlCommand;
            _SqlAdapter.Fill(_dataTable);

            _SqlCon.Close();
            _SqlCommand.Dispose();

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dataTable;
    }
    public void ExecuteNonQuery(string ProcedureName, string connStr, SqlParameter[] prms)
    {

        try
        {

            Openconn(connStr);

            _SqlCommand = new SqlCommand(ProcedureName, _SqlCon);
            _SqlCommand.CommandType = CommandType.StoredProcedure;
            _SqlCommand.CommandText = ProcedureName;
            foreach (SqlParameter sqlParam in prms)
            {
                _SqlCommand.Parameters.Add(sqlParam);
            }

            _SqlCommand.ExecuteNonQuery();

            _SqlCon.Close();
            _SqlCommand.Dispose();



        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    public void Openconn(string connStr)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings[connStr].ConnectionString;
            _SqlCon = new SqlConnection(constr);
            _SqlCon.Open();
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }
    private void loadDepartment()
    {
        SqlParameter[] sqlParams = {
		
	};

        ddlDepartment.DataSource = ExecuteDataTable("GetDepartments", "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataTextField = "Dept_Name";
        ddlDepartment.DataValueField = "Dept_ID";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("All", "0"));

        GetConsultants();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetConsultants();

    }
    public void GetConsultants()
    {
        SqlParameter[] sqlParams = { new SqlParameter("@DeptID", ddlDepartment.SelectedValue.ToString()) };

        ddlDoctors.DataSource = ExecuteDataTable("GetConsultant", "Basic_Data_ConnectionString", sqlParams);
        ddlDoctors.DataTextField = "Name";
        ddlDoctors.DataValueField = "EmpID";
        ddlDoctors.DataBind();

        ddlDoctors.Items.Insert(0, new ListItem("All", "0"));

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
        DateTime sDate = Convert.ToDateTime(wdcStartDate.Value.ToString());
        DateTime eDate = Convert.ToDateTime(wdcEndDate.Value.ToString());

            sdsPatientCount.SelectParameters["Start_Date"].DefaultValue =sDate.ToString();
            sdsPatientCount.SelectParameters["End_Date"].DefaultValue = eDate.ToString();

            sdsPatientCount.SelectParameters["DeptID"].DefaultValue = ddlDepartment.SelectedValue.ToString();
            sdsPatientCount.SelectParameters["Doctor"].DefaultValue = ddlDoctors.SelectedValue.ToString();
       
           
            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;


            DateTime startDate = Convert.ToDateTime(wdcStartDate.Value);
            DateTime EndDate = Convert.ToDateTime(wdcEndDate.Value);
            string Department = ddlDepartment.SelectedItem.Text.ToString();
            string Doctor = ddlDoctors.SelectedItem.Text.ToString();
            ReportParameter[] para = { new ReportParameter("SDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", EndDate.ToString("dd/MM/yyyy")),new ReportParameter("Department",Department),new ReportParameter("Doctor",Doctor) };



            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/ConsultantWiseSummary_Report.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.SetParameters(para);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);    
        ReportViewer1.LocalReport.Refresh();
     }
   }