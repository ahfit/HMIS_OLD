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

public partial class HR_FullandFinalSettelement : System.Web.UI.Page
{

    string conString = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DDLMonth.SelectedValue = DateTime.Now.Date.Month.ToString();
            DDLYear.SelectedValue = DateTime.Now.Date.Year.ToString();
            //LoadReport();
        }




    }


    protected void LoadReport()
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("full_settlement_report", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@empid", Request.QueryString["Emp_Id"].ToString());
            cmd.Parameters.AddWithValue("@Month", DDLMonth.SelectedValue);
            cmd.Parameters.AddWithValue("@Year", DDLYear.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
          
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = Server.MapPath("~/hr/FullandFinalSettelementFinal.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
        

            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables[0]));
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables[1]));
            //ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ds.Tables[2]));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);


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


    protected void btnReport_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
}