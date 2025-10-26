using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class PayRoll_IncomeTaxLogReport : System.Web.UI.Page
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            //bindHospital();
           // bindDepartment();
            bindSubDepartment();
            bindEmployee();
            bindyear();
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        }
    }
    //protected void bindHospital()
    //{
    //    DbManager dbMgr = new DbManager();
    //    String query = "SELECT [Hospital_ID], [Hospital_Name] FROM [Hospital]";
    //    SqlParameter[] sqlParams = {};
    //    ddlHospital.DataSource = dbMgr.ExecuteDataTable_Query(query, "Basic_Data_ConnectionString", sqlParams);
    //    ddlHospital.DataBind();
    //}
    //protected void bindDepartment()
    //{
    //    DbManager dbMgr = new DbManager();
    //    String query = "Select Dept_ID,Dept_Name From Department Where Hospital_ID=@Hospital_ID order by Dept_Name";
    //    SqlParameter[] sqlParams = { new SqlParameter("@Hospital_ID", ddlHospital.SelectedValue) };
    //    ddlDepartment.DataSource = dbMgr.ExecuteDataTable_Query(query, "Basic_Data_ConnectionString", sqlParams);
    //    ddlDepartment.DataBind();
    //}
    protected void bindSubDepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select SubDept_Id,SubDept_Name From SubDepartment";
        SqlParameter[] sqlParams = { };
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTable_Query(query, "Basic_Data_ConnectionString", sqlParams);
        ddlSubDepartment.DataBind();
    }
    protected void bindEmployee()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select EmpID,ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'')+' '+Cast(Employee.EmpID as varchar)+' '+' ('+Cast( Designation.Designation_Name as varchar )+')' AS EmpName From Employee inner join Designation on Employee.DesignationID=Designation.Designation_ID Where SubDeptId=@SubDeptId Order By EmpName";
        SqlParameter[] sqlParams = { new SqlParameter("@SubDeptId", ddlSubDepartment.SelectedValue) };
        ddlEmployee.DataSource = dbMgr.ExecuteDataTable_Query(query, "Basic_Data_ConnectionString", sqlParams);
        ddlEmployee.DataBind();
    }
    protected void bindyear()
    {
        DbManager dbMgr = new DbManager();
        String query = "select Financial_Year,Financial_Year_Id from Financial_Year";
        SqlParameter[] sqlParams = { };
        ddl_year.DataSource = dbMgr.ExecuteDataTable_Query(query, "Finance_ConnectionString", sqlParams);
        ddl_year.DataBind();
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
        String reportPath = Server.MapPath("~/payroll/IncomeTaxLogReport.rdlc");
        SqlParameter[] sqlParams = { new SqlParameter("@EmpId", ddlEmployee.SelectedValue), new SqlParameter("@Financial_Year_ID", ddl_year.SelectedValue) };
        ReportViewer1.LocalReport.ReportPath = reportPath;
        DataTable dt = dbMgr.ExecuteDataTable("usp_IncomeTaxLogReport", "PayRoll_ConnectionString", sqlParams);


        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
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