using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class PayRoll_EmployeeLoanAdvanceReport : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindHospital();
            bindDepartment();
            bindSubDepartment();
            bindEmployee();
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            ShowReport();

        }
    }
    protected void bindHospital()
    {
        DbManager dbMgr = new DbManager();
        String query = "SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]";
        SqlParameter[] sqlParams = {};
        ddlHospital.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParams);
        ddlHospital.DataBind();
    }
    protected void bindDepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select Dept_ID,Dept_Name From Department Where Hospital_ID=@Hospital_ID";
        SqlParameter[] sqlParams = { new SqlParameter("@Hospital_ID", ddlHospital.SelectedValue) };
        ddlDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataBind();
    }
    protected void bindSubDepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select SubDept_Id,SubDept_Name From SubDepartment Where Dept_Id=@Dept_Id";
        SqlParameter[] sqlParams = { new SqlParameter("@Dept_Id", ddlDepartment.SelectedValue) };
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParams);
        ddlSubDepartment.DataBind();
    }
    protected void bindEmployee()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select EmpID,ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') EmpName From Employee Where SubDeptId=@SubDeptId Order By EmpName";
        SqlParameter[] sqlParams = { new SqlParameter("@SubDeptId", ddlSubDepartment.SelectedValue) };
        ddlEmployee.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParams);
        ddlEmployee.DataBind();
    }
    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindDepartment();
        bindSubDepartment();
        bindEmployee();
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubDepartment();
        bindEmployee();
    }
    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindEmployee();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
    private void ShowReport()
    {
        DbManager dbMgr = new DbManager();
        ReportViewer1.LocalReport.DataSources.Clear();
        String reportPath = Server.MapPath("~/payroll/EmployeeMonthlyInstalmentReport.rdlc");
        SqlParameter[] sqlParams = { new SqlParameter("@MainId",Request.QueryString["MainId"])};
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dbMgr.ExecuteDataTable("uspEmployeeLoanAdvanceDetails", "PayRoll_ConnectionString", sqlParams)));
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();
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