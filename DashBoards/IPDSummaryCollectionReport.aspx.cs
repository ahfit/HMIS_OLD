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

public partial class DashBoards_IPDSummaryCollectionReport : System.Web.UI.Page
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
    //private void loadDepartment()
    //{
    //    SqlParameter[] sqlParams = {
		
    //};

    //    ddlDepartment.DataSource = ExecuteDataTable("GetDepartments", "Basic_Data_ConnectionString", sqlParams);
    //    ddlDepartment.DataTextField = "Dept_Name";
    //    ddlDepartment.DataValueField = "Dept_ID";
    //    ddlDepartment.DataBind();
    //    ddlDepartment.Items.Insert(0, new ListItem("All", "0"));

    //    GetConsultants();
    //}
    //protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    GetConsultants();

    //}
    //public void GetConsultants()
    //{
    //    SqlParameter[] sqlParams = { new SqlParameter("@DeptID", ddlDepartment.SelectedValue.ToString()) };

    //    ddlDoctors.DataSource = ExecuteDataTable("GetConsultant", "Basic_Data_ConnectionString", sqlParams);
    //    ddlDoctors.DataTextField = "Name";
    //    ddlDoctors.DataValueField = "EmpID";
    //    ddlDoctors.DataBind();

    //    ddlDoctors.Items.Insert(0, new ListItem("All", "0"));

    //}


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

        sdsPatientCount.SelectParameters["startDate"].DefaultValue = sDate.ToString();
        sdsPatientCount.SelectParameters["endDate"].DefaultValue = eDate.ToString();
        sdsPatientCount.SelectParameters["HospitalID"].DefaultValue = ddl_Hospital.SelectedValue;
           

           
       
           
            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;


            DateTime startDate = Convert.ToDateTime(wdcStartDate.Value);
            DateTime EndDate = Convert.ToDateTime(wdcEndDate.Value);
           
            ReportParameter[] para = { new ReportParameter("startDate", startDate.ToString("dd/MM/yyyy")), new ReportParameter("endDate", EndDate.ToString("dd/MM/yyyy"))};

            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/IPDSummaryCollectionReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.SetParameters(para);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);    
        ReportViewer1.LocalReport.Refresh();
     }
   }