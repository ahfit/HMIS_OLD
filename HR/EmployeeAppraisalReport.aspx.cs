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

public partial class HR_EmployeeAppraisalReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["HRConnectionString1"].ToString();
    SqlConnection con_hr = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FinancialYear();
            SubDepartment();
            department();
            Employee();
            BindDropDown();
            loadRecruitment();



        }
    }
    protected void btnReport_Click(object sender, EventArgs e)
    {
        Reports();
    }
    private void FinancialYear()
    {
        DbManager manager = new DbManager();
        // DataTable dt = manager.ExecuteDataTableWithQuery(@"SELECT SubDept_Name, SubDept_Id FROM SubDepartment", "Basic_Data_ConnectionString", new SqlParameter[] { });
        DataTable dt = manager.ExecuteDataTableWithQuery(@"select Financial_Year,Financial_Year_Id from Finance.dbo.Financial_Year order by substring(Financial_Year,1,4) Desc", "Basic_Data_ConnectionString", new SqlParameter[] { });


        ddlFinancialYear.DataSource = dt;
        ddlFinancialYear.DataValueField = "Financial_Year_Id";
        ddlFinancialYear.DataTextField = "Financial_Year";
        ddlFinancialYear.DataBind();

    }

    protected void loadRecruitment()
    {

        con_hr.Open();

        SqlCommand cmd = new SqlCommand(@"select 0 as FactorId,'---ALL---' as Name union select b.FactorId,b.Name from EmployeeAppraisalMain a inner join EvaluationFactors b on a.FactorID=b.FactorId where a.EmpID=@EmpID", con_hr);
        cmd.Parameters.AddWithValue("@EmpID", ddlEmployee.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        ddlHeading.DataSource = ds;
        ddlHeading.DataValueField = "FactorId";
        ddlHeading.DataTextField = "Name";
        ddlHeading.DataBind();
        con_hr.Close();
    }
    protected void BindDropDown()
    {
        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams = new SqlParameter[] { };

        ddlDesignation.DataSource = objDbManager.ExecuteDataTableWithQuery(@"select 0 as Designation_ID,'All' as Designation_Name   union select Designation_ID,Designation_Name from Designation
inner join employee on Employee.DesignationID=Designation.Designation_ID  where EmpID=" + ddlEmployee.SelectedValue + "", "Basic_Data_ConnectionString", sqlParams);
        
        ddlDesignation.DataValueField = "Designation_ID";
        ddlDesignation.DataTextField = "Designation_Name";

        ddlDesignation.DataBind();
        if (ddlEmployee.SelectedValue != "0")
        {
            ddlDesignation.Items.Remove(ddlDesignation.Items.FindByValue("0"));
        }

    }

    private void SubDepartment()
    {
        DbManager manager = new DbManager();
        // DataTable dt = manager.ExecuteDataTableWithQuery(@"SELECT SubDept_Name, SubDept_Id FROM SubDepartment", "Basic_Data_ConnectionString", new SqlParameter[] { });
        DataTable dt = manager.ExecuteDataTable(@"usp_GetSubDeprtmentsByHospitalWithALL", "Basic_Data_ConnectionString", new SqlParameter[] {
              new SqlParameter("@HospitalID",ddlhospital.SelectedValue),
        new   SqlParameter("@DeptID",ddldept.SelectedValue),
         new   SqlParameter("@WithAll",0),
        });


        DropDownListSubDepartment.DataSource = dt;
        DropDownListSubDepartment.DataValueField = "SubDept_Id";
        DropDownListSubDepartment.DataTextField = "SubDept_Name";

        DropDownListSubDepartment.DataBind();

    }

    private void Employee()
    {
        DbManager manager = new DbManager();

        DataTable dt = manager.ExecuteDataTableWithQuery(@"select 0 as empid ,'All' as Name union select empid,isnull(efname,'')+' '+isnull(emname,'')+' '+isnull(elname,'') as Name from employee where ActiveStatus=1 and SubDeptId=@SubDeptId", "Basic_Data_ConnectionString", new SqlParameter[] {
            new SqlParameter("@SubDeptId",DropDownListSubDepartment.SelectedValue),
        });

        ddlEmployee.DataSource = dt;
        ddlEmployee.DataValueField = "empid";
        ddlEmployee.DataTextField = "Name";
        ddlEmployee.DataBind();
    }
    protected void DropDownListSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Employee();
        BindDropDown();
        loadRecruitment();
    }
    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDropDown();
        loadRecruitment();       
    }


    protected void  Reports()
    {
        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("usp_EmployeeAppraisalReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpId", ddlEmployee.SelectedValue);
           cmd.Parameters.AddWithValue("@FinancialYear", ddlFinancialYear.SelectedValue);
           cmd.Parameters.AddWithValue("@Designation_ID", ddlDesignation.SelectedValue);
            cmd.Parameters.AddWithValue("@Department", ddldept.SelectedValue);
            cmd.Parameters.AddWithValue("@FactorId", ddlHeading.SelectedValue);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/HR/EmployeeAppraisalReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}
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
    private void department()
    {
        DbManager manager = new DbManager();

        DataTable dt = manager.ExecuteDataTableWithQuery(@"select 0 as Dept_ID ,'All' as Dept_Name union select Dept_ID,Dept_Name from Department where Hospital_ID=@Hospital_ID","Basic_Data_ConnectionString", new SqlParameter[] {
            new SqlParameter("@Hospital_ID",ddlhospital.SelectedValue),
        });

        ddldept.DataSource = dt;
        ddldept.DataValueField = "Dept_ID";
        ddldept.DataTextField = "Dept_Name";
        ddldept.DataBind();
    }


    protected void ddldept_SelectedIndexChanged(object sender, EventArgs e)
    {
        SubDepartment();
    }

    protected void ddlhospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        department();
        SubDepartment();
    }
}

