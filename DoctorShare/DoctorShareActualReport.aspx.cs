using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class DoctorShare_DoctorShareActualReport : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["BasicDataConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadCategory();
            loadDepartment();
            loadDoctor();
            wdcDateFrom.Value = DateTime.Now.AddDays(-1);
            WebDateDateTo.Value = DateTime.Now.AddDays(7);
        }

    }
     
    private void loadCategory()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("GetCategoryForDoctorShare", con);
        cmd.CommandType = CommandType.StoredProcedure;


        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        DropDownListCategory.DataSource = ds;
        DropDownListCategory.DataValueField = "Asc_id";
        DropDownListCategory.DataTextField = "Asc_Name";
        DropDownListCategory.DataBind();

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

    private void loadDepartment()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("SELECT     0 Dept_ID,  ' --- All ---' Dept_Name union SELECT     Department.Dept_ID, Department.Dept_Name FROM  Department INNER JOIN SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id where SubDepartment.SubDept_Type=1 ORDER BY Dept_Name", con);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        con.Open();

        da.Fill(ds);
        con.Close();
        ddlDepartment.DataSource = ds;

        ddlDepartment.DataBind();
    }


    private void loadDoctor()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("GetConsultantFromDutyDepartment", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@deptid", ddlDepartment.SelectedValue);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);

        ddldoctor.DataSource = ds;
        ddldoctor.DataValueField = "EmpID";
        ddldoctor.DataTextField = "Name";
        ddldoctor.DataBind();
        ddldoctor.Items.Insert(0, new ListItem("All", "0"));

    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadDoctor();
    }


    private void LoadReport()
    {

        SqlConnection con = new SqlConnection(_conStr);

        SqlCommand cmd = new SqlCommand("usp_DoctorWisePatientReport", con);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.AddWithValue("@startdate", wdcDateFrom.Value);
        cmd.Parameters.AddWithValue("@enddate", WebDateDateTo.Value);
        cmd.Parameters.AddWithValue("@deptid", ddlDepartment.SelectedValue);
        cmd.Parameters.AddWithValue("@doctorid", ddldoctor.SelectedValue);
        cmd.Parameters.AddWithValue("@Type", DropDownTypeWise.SelectedValue);
        cmd.Parameters.AddWithValue("@Category", DropDownListCategory.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();


        da.Fill(ds);

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];


        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = "DoctorShare/DoctorShareActualReport.rdlc";
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.Refresh();

        ////if (Request.Browser.Browser == "Chrome")
        ////{
        ////    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
        ////    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
        ////    Response.ContentType = "application/pdf";
        ////    Response.BinaryWrite(bytes);
        ////    Response.End();
        ////}

        ////else
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