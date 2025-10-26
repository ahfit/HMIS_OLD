using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
using System.Configuration;


public partial class PayRoll_EmployeeDynamicSalaryReport : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dropdownlist_Hospital.DataBind();
            DDL_Dept.DataBind();
            DDL_Emp.DataBind();

            for (int count = 2010; count <= DateTime.Now.Year; count++)
            {
                ddlYear.Items.Add(count.ToString());
            }


            DDL_Dept.DataBind();            
            ddlYear.DataBind();
            DDL_Emp.DataBind();
         
            ddlYear.SelectedValue = Convert.ToString(DateTime.Now.Year);
            ddlMonth.SelectedValue = Convert.ToString(DateTime.Now.Month);
        }




    }
   
    protected void btn_Report_Click(object sender, EventArgs e)
    {
       LoadReport();
       

    }
    
    private void HideandShow()
    {
        
        ReportViewer1.Visible = false;
    }


    private void LoadReport()
    {

        SqlConnection con = new SqlConnection(_conStr);
        try
        {


            con.Open();
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            SqlCommand cmd = new SqlCommand("Employee_DynamicSalaryReport", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Hospital_Id", dropdownlist_Hospital.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept_Id", DDL_Dept.SelectedValue);
            cmd.Parameters.AddWithValue("@Emp_ID", DDL_Emp.SelectedValue);
            cmd.Parameters.AddWithValue("@SalaryMonth", ddlMonth.SelectedValue);
            cmd.Parameters.AddWithValue("@SalaryYear", ddlYear.SelectedValue);
                   
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();


            da.Fill(ds);

            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = ds.Tables[0];
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("EmployeeSalaryDynamicReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(rds);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportParameter rp = new ReportParameter("Parameter1", ddlMonth.SelectedItem.Text);
            ReportParameter rp2 = new ReportParameter("Parameter2", ddlYear.SelectedItem.Text);
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp ,rp2});
            ReportViewer1.LocalReport.Refresh();

        }
        catch (Exception ex)
        {

        }
        finally
        {
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

    protected void DDL_Dept_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Emp.DataBind();
    }
    protected void dropdownlist_Hospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Dept.DataBind();
    }
}