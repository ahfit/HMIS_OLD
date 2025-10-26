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

public partial class Store_Stock_Adjustment_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            startDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            endDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            fillsubdepartment();
        }

    }
    protected void fillsubdepartment()
    {
        string ConStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(ConStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 as SubDept_Id,'All' as SubDept_Name UNION Select SubDept_Id,SubDept_Name from SubDepartment order by SubDept_Id", con);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();



        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
    public void LoadReport()
    {

        string ConStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(ConStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_Get_Stock_Adjustment_Report", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StartDate", startDate.Text.ToString());
            cmd.Parameters.AddWithValue("@EndDate", endDate.Text.ToString());
            cmd.Parameters.AddWithValue("@subdeptid", ddlDepartment.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;
            string reportPath = Server.MapPath("~/Store/Stock_Adjustment_Report.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(rds);

            ReportParameter[] param = new ReportParameter[2];
            param[0] = new ReportParameter("startDate", Convert.ToDateTime(startDate.Text).ToString("dd MMM yyyy"));
            param[1] = new ReportParameter("endDate", Convert.ToDateTime(endDate.Text).ToString("dd MMM yyyy"));
            ReportViewer1.LocalReport.SetParameters(param);

            ReportViewer1.LocalReport.Refresh();
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }

            else
                ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        {

        }
        finally
        {
            con.Close();
        }
    }
}