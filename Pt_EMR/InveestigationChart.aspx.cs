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

public partial class Pt_EMR_InveestigationChart : System.Web.UI.Page
{
    string VisitDate = "";
    String Conster = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
        }
    }


    private void LoadData()
    {
        //DataSet ds = new DataSet();
        //DbManager manager = new DbManager();
        //ds = manager.ExecuteDataSet("patientTestsWrtRegNo", "Path_ConnectionString", new SqlParameter[] { new SqlParameter() { ParameterName = "regno", Value = Session["registrationNo"] } });
        //mainRepeater.DataSource = ds;
        //mainRepeater.DataBind();

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("patientTestsWrtPayID", "Path_ConnectionString", new SqlParameter[] {
                    new SqlParameter() { ParameterName = "regno", Value = Session["registrationNo"] }});
        repaterSub.DataSource = ds;
        repaterSub.DataBind();
    }


    //protected void mainRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //{
    //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //    {
    //        GridView repeater = e.Item.FindControl("repaterSub") as GridView;
    //        Label lblYearlyNo = e.Item.FindControl("hfVisitDetail") as Label;

    //        DataSet ds = new DataSet();
    //        DbManager manager = new DbManager();
    //        ds = manager.ExecuteDataSet("patientTestsWrtPayID", "Path_ConnectionString", new SqlParameter[] { new SqlParameter() { ParameterName = "regno", Value = Session["registrationNo"] } ,
    //            new SqlParameter() { ParameterName = "@payid", Value = lblYearlyNo.ToolTip } } );
    //        repeater.DataSource = ds;
    //        repeater.DataBind();

    //    }
    //}

    protected void lnkbtnTestName_Click(object sender, EventArgs e) {
        LinkButton lnkbtn=sender as LinkButton;
        string testID=lnkbtn.CommandArgument;

        lblTName.Text = lnkbtn.Text;
        
        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("Pathology_GetTestResultByTestIdAndPayID", "Path_ConnectionString", new SqlParameter[] { new SqlParameter() { ParameterName = "@RegNo", Value = Session["registrationNo"] },
            new SqlParameter() { ParameterName = "testID", Value = testID } ,new SqlParameter() { ParameterName = "@payid", Value = lnkbtn.ToolTip.Trim() }
        });
        SubRepeater.DataSource = ds;
        SubRepeater.DataBind();
        //LoadReport(testID);
        divResult.Visible = true;
    }
    private void LoadReport(string ID)
    {
        panel_Report.Visible = true;
        SqlConnection conn = new SqlConnection(Conster);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand sc = new SqlCommand("Pathology_GetTestResultComparsionReport", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@RegNo", Session["registrationNo"]);
            sc.Parameters.AddWithValue("@testID", ID);
            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath =Server.MapPath("~/Pt_EMR/InvestigationComparisionReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            this.ReportViewer1.LocalReport.SubreportProcessing += subReports;
            

            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        { }
        finally
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
        catch (Exception ex)
        {
        }
    }
    protected void lnkbtnComparsion_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        LoadReport(lnkbtn.CommandArgument);
    }

    protected void btnclose_Panel_Click(object sender, EventArgs e)
    {
        Response.Redirect("InveestigationChart.aspx");
    }
}
 





