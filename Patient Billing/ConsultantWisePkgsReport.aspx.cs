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

public partial class Patient_Billing_ConsultantWisePkgsReport : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            FillPackages();
            GetDutyDepartment();
            GetDoctor();

            wdcStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            wdcEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            //if (Request.QueryString["RegNo"] != null && Request.QueryString["YearlyNo"] != null)
            //{
            //    ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            //    LoadReport();
            //}
          
        }
    }


    protected void DDL_DoctorDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetDoctor();
    }

    protected void FillPackages()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand(" Select 0 as ASP_ID,'---ALL---'as AP_NAme Union SELECT ASP_ID, AP_Name FROM  Admin_Service_Package", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownPackages.DataValueField = "ASP_ID";
            DropDownPackages.DataTextField = "AP_Name";
            DropDownPackages.DataSource = dt;
            DropDownPackages.DataBind();
          
        }
    }

    protected void GetDoctor()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);

        cmd = new SqlCommand("select 0 as Empid ,'---All---' as Name union select EmpID,isnull(EFName,'') +' '+ isnull(ELName,'') as Name  from Employee  Inner join SubDepartment on SubDepartment.SubDept_Id=Employee.SubDeptId where Employee.ActiveStatus=1 and Is_Consultant=1 and employee.SubDeptId=@SubdeptID or @SubdeptID=0", con);
        cmd.Parameters.AddWithValue("@SubdeptID", DDL_DoctorDepartment.SelectedValue);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        ddlDoctor.DataSource = dt;
        ddlDoctor.DataValueField = "EmpID";
        ddlDoctor.DataTextField = "Name";
        ddlDoctor.DataBind();
        //ddlDoctor.Items.Insert(0, new ListItem("All", "0"));
        con.Close();
    }

    protected void GetDutyDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select 0 as SubDept_Id,'---ALL---' as SubDept_Name union Select SubDepartment.SubDept_Id,SubDepartment.SubDept_Name from SubDepartment where SubDept_Type=1 ", con);
        //cmd.Parameters.AddWithValue("@DepartmentID", DDL_DoctorDepartment.SelectedValue);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        DDL_DoctorDepartment.DataSource = dt;
        DDL_DoctorDepartment.DataValueField = "SubDept_Id";
        DDL_DoctorDepartment.DataTextField = "SubDept_Name";
        DDL_DoctorDepartment.DataBind();
     
        con.Close();
    }
    protected void LoadReport()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            DataTable dt1 = new DataTable();
            con = new SqlConnection(conString);
            con.Open();

            cmd = new SqlCommand("ConsultantWisePkgsReport", con);
            cmd.CommandType = CommandType.StoredProcedure;

            //cmd.Parameters.AddWithValue("@DeptID", DDL_DoctorDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@DoctorID", ddlDoctor.SelectedValue);
            cmd.Parameters.AddWithValue("@PkgID", DropDownPackages.SelectedValue);
            cmd.Parameters.AddWithValue("@SDate", wdcStartDate.Text);
            cmd.Parameters.AddWithValue("@EDate", wdcEndDate.Text);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            
            da.Fill(dt1);




            string reportPath = Server.MapPath("ConsultantWisePkgsReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt1));
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
            //{
            ReportViewer1.Visible = true;
            //}

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
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


    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
}