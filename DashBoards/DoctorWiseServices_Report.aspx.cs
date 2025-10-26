using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class DashBoards_DoctorWiseServices_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        if (!Page.IsPostBack)
        {
            FillHospital();
            ddl_Hospital.SelectedValue = Session["HospitalID"].ToString();
            ddl_Hospital.Enabled = false;
            GetCategories();
            wdcStartDate.Value = DateTime.Now.AddDays(-3);
            wdcEndDate.Value = DateTime.Now;


            GetServicesCatageoryWise(ddlCategory.SelectedValue,txtboxServices.Text);
            GetDepartment();
            GetDutyDepartment();
            GetDoctor(DDL_DoctorDepartment.SelectedValue);

           //ShowReport();                      
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        
        ShowReport();
    }
    protected void GetCategories()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("SELECT  CONVERT (varchar, Asc_id) AS Asc_id, Asc_Name FROM Admin_Service_Category ORDER BY Asc_Name", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow dr = dt.NewRow();
        dr[0] = "0";
        dr[1] = "All";

        dt.Rows.InsertAt(dr, 0);
        ddlCategory.DataSource = dt;
        ddlCategory.DataBind();
        //ddlCategory.Items.Insert(0, new ListItem() { Text = "All", Value = "0" });
        con.Close();
    }
    
    
    protected void GetServices()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("SELECT CONVERT (varchar, Asc_id) AS Asc_id, Asc_Name FROM Admin_Service_Category ORDER BY Asc_Name", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        //DataRow dr = dt.NewRow();
        //dr[0] = "0";
        //dr[1] = "All";

        //dt.Rows.InsertAt(dr, 0);
        ddlCategory.DataSource = dt;
        ddlCategory.DataBind();
        con.Close();
    }


    protected void GetServicesCatageoryWise(string CatageoryID,string ServicesNam)
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("usp_GetAllServices", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@service_Catageory",ddlCategory.SelectedValue);
        cmd.Parameters.AddWithValue("@serviceName",txtboxServices.Text);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DataRow dr = dt.NewRow();
        dr[0] = "0";
        dr[1] = "All";

        dt.Rows.InsertAt(dr, 0);
        ddlServcies.DataSource = dt;
        ddlServcies.DataValueField = "S_ID";
        ddlServcies.DataTextField = "S_Name";
        ddlServcies.DataBind();
        con.Close();
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



    protected void GetDoctor(string CatageoryID)
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("getDoctorDepartmentAgainstServices", con);
        cmd.Parameters.AddWithValue("@DepartmentID",DDL_DoctorDepartment.SelectedValue);
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        ddlDoctor.DataSource = dt;
        ddlDoctor.DataValueField = "EmpID";
        ddlDoctor.DataTextField = "Name";
        ddlDoctor.DataBind();
        ddlDoctor.Items.Insert(0, new ListItem("All", "0"));
        con.Close();
    }

    protected void GetDutyDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDepartment.SubDept_Id,SubDepartment.SubDept_Name from SubDepartment where SubDept_Type=1 ", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        //DataRow dr = dt.NewRow();
        //dr[0] = "0";
        //dr[1] = "All";

        //dt.Rows.InsertAt(dr, 0);

        DDL_DoctorDepartment.DataSource = dt;
        DDL_DoctorDepartment.DataValueField = "SubDept_Id";
        DDL_DoctorDepartment.DataTextField = "SubDept_Name";
        DDL_DoctorDepartment.DataBind();
        DDL_DoctorDepartment.Items.Insert(0, new ListItem("All", "0"));
        con.Close();
    }
    protected void GetDepartment()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("select SubDepartment.SubDept_Id,SubDepartment.SubDept_Name from SubDepartment where SubDept_Type=1 ", con);        
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        //DataRow dr = dt.NewRow();
        //dr[0] = "0";
        //dr[1] = "All";

        //dt.Rows.InsertAt(dr, 0);

        ddlDepartment.DataSource = dt;
        ddlDepartment.DataValueField = "SubDept_Id";
        ddlDepartment.DataTextField = "SubDept_Name";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("All", "0"));
        con.Close();
    }

    protected void ShowReport()
    {         
            sdsPatientCount.SelectParameters["Start_Date"].DefaultValue = wdcStartDate.Value.ToString();
            sdsPatientCount.SelectParameters["End_Date"].DefaultValue = wdcEndDate.Value.ToString();
            sdsPatientCount.SelectParameters["CategoryId"].DefaultValue = ddlCategory.SelectedValue;
            sdsPatientCount.SelectParameters["serviceID"].DefaultValue = ddlServcies.SelectedValue;
            sdsPatientCount.SelectParameters["DepatmentID"].DefaultValue = ddlDepartment.SelectedValue;
            sdsPatientCount.SelectParameters["DoctorID"].DefaultValue = ddlDoctor.SelectedValue;
            sdsPatientCount.SelectParameters["HospitalID"].DefaultValue = Session["HospitalID"].ToString();

            ReportParameter[] repParams = new ReportParameter[2];

            repParams[0] = new ReportParameter("StartDate",Convert.ToDateTime( wdcStartDate.Value.ToString()).ToString("dd/MM/yyyy"));
            repParams[1] = new ReportParameter("EndDate",Convert.ToDateTime( wdcEndDate.Value.ToString()).ToString("dd/MM/yyyy"));

            DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
            DataTable dt = dv.Table;

            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/DashBoards/Search_DoctorWisePatientServices_Report.rdlc");

          ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));

            ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            ReportViewer1.LocalReport.Refresh();
     }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetServicesCatageoryWise(ddlCategory.SelectedValue.ToString(),txtboxServices.Text);
    }
    protected void DDL_DoctorDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetDoctor(DDL_DoctorDepartment.SelectedValue);
    }



    protected void btnSearchServices_Click(object sender, EventArgs e) 
    {
        
    
    }

    protected void txtboxServices_TextChanged(object sender, EventArgs e)
    {
        GetServicesCatageoryWise(ddlCategory.SelectedValue.ToString(), txtboxServices.Text);
    }
    
}