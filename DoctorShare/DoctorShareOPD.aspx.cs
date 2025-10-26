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

public partial class DoctorShare_DoctorShareOPD : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["BasicDataConnectionString"].ConnectionString;
    string _conFStr = ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!IsPostBack)
        {
          
            loadCategory();
            loadDepartment();
            loadServices();
            loadDoctor();
            wdcDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            WebDateDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
            loadvales();
            LoadReport();
        }

    }

    private void loadvales()
    {

        if (!string.IsNullOrEmpty(Request.QueryString["CID"] as string))
        {
            DropDownListCategory.SelectedValue = Request.QueryString["CID"].ToString();
            DropDownListCategory.Enabled = false;
        }


        if (!string.IsNullOrEmpty(Request.QueryString["D"] as string))
        {
            ddlDepartment.SelectedValue = Request.QueryString["D"].ToString();
            ddlDepartment.Enabled = false;
        }

        if (!string.IsNullOrEmpty( Request.QueryString["S"] as string))
        {
            DropDownListServices.SelectedValue = Request.QueryString["S"].ToString();
            DropDownListServices.Enabled = false;
        }

        if (!string.IsNullOrEmpty(Request.QueryString["PT"] as string))
        {
            DropDownTypeWise.SelectedValue = Request.QueryString["PT"].ToString();
            DropDownTypeWise.Enabled = false;
        }

        if (!string.IsNullOrEmpty(Request.QueryString["CN"] as string))
        {
            ddldoctor.SelectedValue = Request.QueryString["CN"].ToString();
            ddldoctor.Enabled = false;
        }

        if (!string.IsNullOrEmpty(Request.QueryString["TD"] as string))
        {
            wdcDateFrom.Text = Convert.ToDateTime(Request.QueryString["TD"]).ToString("yyyy-MM-dd");
            wdcDateFrom.Enabled = false;
        }

        if (!string.IsNullOrEmpty(Request.QueryString["TD"] as string))
        {
            WebDateDateTo.Text = Convert.ToDateTime(Request.QueryString["TD"]).ToString("yyyy-MM-dd");
            WebDateDateTo.Enabled = false;
        }

       




    }
    private void loadCategory()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("GetCategoryForDoctorShare", con);
        cmd.CommandType = CommandType.StoredProcedure;

        con.Open();
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        con.Close();
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
    private void loadServices()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("GetServicesForDoctorShare", con);

        cmd.CommandType = CommandType.StoredProcedure;
        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        con.Open();

        da.Fill(ds);
        con.Close();
         DropDownListServices.DataTextField = "S_Name";
         DropDownListServices.DataValueField = "S_ID";
        DropDownListServices.DataSource = ds;

        DropDownListServices.DataBind();
    }


    private void loadDoctor()
    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("GetConsultantFromDutyDepartment", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@deptid", ddlDepartment.SelectedValue);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        con.Open();
        
        da.Fill(ds);
        con.Close();
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

        int transferID;
        if (string.IsNullOrEmpty(Request.QueryString["tid"] as string))
        {
            transferID = 0;
         
        }
        else
        {
            transferID = Convert.ToInt32(Request.QueryString["tid"]);
        }

        SqlConnection con = new SqlConnection(_conFStr);
        SqlCommand cmd = new SqlCommand("usp_DoctorWiseSharePaid", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@startdate", wdcDateFrom.Text);
        cmd.Parameters.AddWithValue("@enddate", WebDateDateTo.Text);
        cmd.Parameters.AddWithValue("@deptid", ddlDepartment.SelectedValue);
        cmd.Parameters.AddWithValue("@empID", Session["emp_id"].ToString() );
        cmd.Parameters.AddWithValue("@S_ID", DropDownListServices.SelectedValue);
        cmd.Parameters.AddWithValue("@doctorid", ddldoctor.SelectedValue);
        cmd.Parameters.AddWithValue("@Type", DropDownTypeWise.SelectedValue);
        cmd.Parameters.AddWithValue("@Category", DropDownListCategory.SelectedValue);
        cmd.Parameters.AddWithValue("@transferID", transferID); 
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        con.Open();
        
        da.Fill(ds);

        con.Close();

        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];


        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = "DoctorShare/DoctorSharePaid.rdlc";
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.Refresh();

        ReportParameter rp1 = new ReportParameter("ReportParameter1", wdcDateFrom.Text.ToString());
        ReportParameter rp2 = new ReportParameter("ReportParameter2", WebDateDateTo.Text.ToString());
        ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp1, rp2 });

        if (!string.IsNullOrEmpty(Request.QueryString["TD"] as string) && Request.Browser.Browser == "Chrome")
        {
            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            Response.ContentType = "application/pdf";
            Response.BinaryWrite(bytes);
            Response.End();
        }

        else
        {
            ReportViewer1.Visible = true;
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

}