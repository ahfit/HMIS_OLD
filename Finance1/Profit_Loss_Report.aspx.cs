using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Configuration;

public partial class Finance_Profit_Loss_Report : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            DropDownList_Companyname.DataBind();
            DropDownList_Companyname.SelectedValue = Session["Financial_Company_Id"].ToString();
            DropDownList_Branchname.DataBind();
            DropDownList_Branchname.SelectedValue = Session["Company_Branch_Id"].ToString();
            DropDownList_Companyname.Enabled = false;
            DropDownList_Branchname.Enabled = false;
            WebDateChooserSdate.Value = DateTime.Now.AddMonths(-1);
            Webdatechooser_Edate.Value = DateTime.Now;
            LoadReport();
        }
    }

    private void LoadReport()

    {

        SqlConnection con = new SqlConnection(_conStr);
        SqlCommand cmd = new SqlCommand("usp_ProfitLossReport", con);
        cmd.CommandType = CommandType.StoredProcedure;


        cmd.Parameters.Add("@Financial_Company_Id", DropDownList_Companyname.SelectedValue);
        cmd.Parameters.Add("@Company_Branch_Id", DropDownList_Branchname.SelectedValue);
        cmd.Parameters.Add("@Start_Date", WebDateChooserSdate.Value.ToString());
        cmd.Parameters.Add("@End_Date", Webdatechooser_Edate.Value.ToString());
        cmd.Parameters.AddWithValue("@CCID", DropDownList_CostCentre.SelectedValue);
        cmd.Parameters.AddWithValue("@postedUnposted", DDLVoucher.SelectedValue);


        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];


        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = "./Finance/Profit_Loss_Report.rdlc";
        // ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("d1",ds.Tables[0]));     
        ReportViewer1.LocalReport.SetParameters(new ReportParameter("Company", DropDownList_Companyname.SelectedItem.Text));
        ReportViewer1.LocalReport.SetParameters(new ReportParameter("Branch", DropDownList_Branchname.SelectedItem.Text));
            ReportViewer1.LocalReport.SetParameters(new ReportParameter("StartDate", Convert.ToDateTime(WebDateChooserSdate.Value).ToString("dd-MMMM-yyyy")));
            ReportViewer1.LocalReport.SetParameters(new ReportParameter("EndDate", Convert.ToDateTime(Webdatechooser_Edate.Value).ToString("dd-MMMM-yyyy")));
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();




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

    protected void Button_Search_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

}