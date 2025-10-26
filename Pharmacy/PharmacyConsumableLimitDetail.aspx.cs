using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
using System.Activities.Expressions;

public partial class Pharmacy_PharmacyConsumableLimitDetail : System.Web.UI.Page
{
    string strg = ConfigurationManager.ConnectionStrings["HRConnectionString1"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            getdeptdata();
            txt_frmdate.Text = DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd");
            txt_todate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            getsubdeptdata();
        }

    }
    protected void btn_Srch_Click(object sender, EventArgs e)
    {
        getgriddata();
    }

    protected void getgriddata()
    {
        using (SqlConnection con = new SqlConnection(strg))
        {
            con.Open();
            string command = "usp_GetPharmacyconsumableLimitDetail";
            SqlCommand cmd = new SqlCommand(command, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@MRNo", txt_Mr_No.Text.Trim());
            cmd.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(txt_frmdate.Text.ToString()));
            cmd.Parameters.AddWithValue("@ToDdate", Convert.ToDateTime(txt_todate.Text.ToString()));
            cmd.Parameters.AddWithValue("@subdeptID", ddl_subdeptid.SelectedValue);
            SqlDataAdapter sda = new SqlDataAdapter();

            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/Pharmacy/PharmacyConsumableLimitDetail.rdlc");

            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.Width = Unit.Percentage(100);
            ReportViewer1.LocalReport.Refresh();
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

    protected void getdeptdata()
    {
        using (SqlConnection con = new SqlConnection(strg))
        {
            con.Open();
            string command = "select Dept_ID,Dept_Name from Department Order By Dept_Name";
            SqlCommand cmd = new SqlCommand(command, con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter sda = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            ddl_deptid.DataSource = dt;
            ddl_deptid.DataTextField = "Dept_Name";
            ddl_deptid.DataValueField = "Dept_ID";
            ddl_deptid.DataBind();
            con.Close();
        }
       
    }

    protected void getsubdeptdata()
    {
        using (SqlConnection con = new SqlConnection(strg))
        {
            con.Open();
            string command = "Select distinct SD.SubDept_Id,SD.SubDept_Name from SubDepartment SD inner   join Department D on SD.Dept_Id = d.Dept_ID Where sd.Dept_Id =@deptID ";
            SqlCommand cmd = new SqlCommand(command, con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@deptID", ddl_deptid.SelectedValue);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            sda.SelectCommand = cmd;
            sda.Fill(dt);
            ddl_subdeptid.DataSource = dt;
            ddl_subdeptid.DataTextField = "SubDept_Name";
            ddl_subdeptid.DataValueField = "SubDept_Id";
            ddl_subdeptid.DataBind();
            con.Close();
        }
    }

    protected void ddl_deptid_SelectedIndexChanged(object sender, EventArgs e)
    {
        getsubdeptdata();
    }

}