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


public partial class HR_EmployeeGenericTemplateReport : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            lblDate.Text = DateTime.Now.ToString("MMM dd, yyyy");
            LoadReport();
        }
    }
    protected void LoadReport()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);

            cmd = new SqlCommand("uspGetEmployeeGenericTemplate", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            cmd.Parameters.AddWithValue("@ID", Request.QueryString["TemplateID"]);
            cmd.Parameters.AddWithValue("@empid", Request.QueryString["EmpID"]);
            
            da.Fill(ds);
            lblReferenceNo.Text = "Ref: " + ds.Tables[0].Rows[0]["ReferenceNo"].ToString();

            lblName.Text = ds.Tables[1].Rows[0]["EmployeeName"].ToString()+" ,";
            lblDesignation.Text = ds.Tables[1].Rows[0]["Designation_Name"].ToString();
            lblDepartment.Text = ds.Tables[1].Rows[0]["DeptName"].ToString();
            lblSalutation.Text = ds.Tables[1].Rows[0]["EmployeeName"].ToString();
            lblTemplateName.Text ="Subject :"+ ds.Tables[0].Rows[0]["TemplateName"].ToString();


            

            placeholder.Controls.Add(new Literal { Text = ds.Tables[0].Rows[0]["Body"].ToString() });


            

        }
        catch (Exception ex)
        {


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