using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Budget_TransferHead : System.Web.UI.Page
{
    SqlConnection conn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) { 
        bindBudget();
        reportData();
        }

    }
    protected void bindBudget()
    {
        conn.Open();
        SqlCommand cmd = new SqlCommand("select B_ID, convert(varchar,DATEPART(YEAR,Date_Start))+'_'+(convert(varchar,DATEPART(YEAR,Date_End))) as BudgetYear from Budget", conn);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlBudget.DataSource = ds;
        ddlBudget.DataValueField = "B_ID";
        ddlBudget.DataTextField = "BudgetYear";
        ddlBudget.DataBind();
        conn.Close();

    }
    protected void reportData()
    {
        conn.Open();
        SqlCommand cmd = new SqlCommand("Usp_Budget_TransferHead_Logs", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@b_id", ddlBudget.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("Budget_TransferHead_Log_Report.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.Refresh();

    }
    protected void ddlBudget_SelectedIndexChanged(object sender, EventArgs e)
    {
        reportData();

    }
}