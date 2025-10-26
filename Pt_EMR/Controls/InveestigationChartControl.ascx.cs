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


public partial class Pt_EMR_InveestigationChartControl : System.Web.UI.UserControl
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
        
        SqlParameter[] sqlParams = {
                new SqlParameter("@regno", Session["registrationNo"]),
                new SqlParameter("@YearlyNo", Session["YearlyNo"])
                };

        ds = manager.ExecuteDataSet("patientTestsWrtRegNo", "Path_ConnectionString", sqlParams);
                   
        repaterSub.DataSource = ds;
        repaterSub.DataBind();
    }


    protected void lnkbtnTestName_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        string testID = lnkbtn.CommandArgument;

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
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pt_EMR/InvestigationComparisionReport.rdlc");
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
        //Response.Redirect("PatientLabTests.aspx");
        panel_Report.Visible = false;
    }

    protected void btnVerifyAll_Click(object sender, EventArgs e)
    {
        DbManager objDbManager = new DbManager();

        for (var b = 0; b < repaterSub.Rows.Count; b++)

        {
            CheckBox chkVerify = (CheckBox)repaterSub.Rows[b].FindControl("chkVerify");
            if (chkVerify.Checked)
            {
                HiddenField hdnPsId = (HiddenField)repaterSub.Rows[b].FindControl("hdnPsId");
                HiddenField hdnYearlyNo = (HiddenField)repaterSub.Rows[b].FindControl("hdnYearlyNo");

                SqlParameter[] sqlParams = {
                    new SqlParameter("@PsId", hdnPsId.Value),
                    new SqlParameter("@ConsultantId", Session["emp_id"]),
                    new SqlParameter("@VisitId", hdnYearlyNo.Value)
                };
                objDbManager.ExecuteNonQuery("PatientTestVerified", "Path_ConnectionString", sqlParams);
            }
        }
        LoadData();
    }

    protected void chkVerifyHeader_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox rd = (CheckBox)sender;
        GridViewRow row = (GridViewRow)rd.NamingContainer;
        CheckBox chkVerifyHeader = (CheckBox)row.FindControl("chkVerifyHeader");

        for (var b = 0; b < repaterSub.Rows.Count; b++)
        {
            CheckBox chkVerify = (CheckBox)repaterSub.Rows[b].FindControl("chkVerify");
            if (chkVerifyHeader.Checked)
            {
                chkVerify.Checked = true;
            }
            else
            {
                chkVerify.Checked = false;
            }
        }

    }

    protected void repaterSub_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label status =(Label) e.Row.FindControl("lblStatus");
            CheckBox chkVerify = (CheckBox)e.Row.FindControl("chkVerify");
            Label lblVerified = (Label)e.Row.FindControl("lblVerified");


            HiddenField hfPrimaryConsultant = (HiddenField)e.Row.FindControl("hfPrimaryConsultant");
            HiddenField hfSecondaryConsultant = (HiddenField)e.Row.FindControl("hfSecondaryConsultant");

            if(hfPrimaryConsultant.Value!="" || hfSecondaryConsultant.Value != "")
            {
                chkVerify.Visible = false;
                lblVerified.Visible = true;
                lblVerified.CssClass = "Active";
                lblVerified.ToolTip = hfPrimaryConsultant.Value + hfSecondaryConsultant.Value;
            }

            if (status.Text == "Advice")
            {
                status.CssClass = "Advice";
            }

            if (status.Text == "Sample Collection")
            {
                status.CssClass = "Sample-Collection";
            }


            if (status.Text == "Sample Received")
            {
                status.CssClass = "Sample-Received";
            }

            if (status.Text == "Result Entry")
            {
                status.CssClass = "Result-Entry";
            }

            if (status.Text == "Test Cancel")
            {
                status.CssClass = "Test-Cancel";
            }

            if (status.Text == "Test Conducted")
            {
                status.CssClass = "Test-Conducted";
            }
            if (status.Text == "Un Delivered Reports")
            {
                status.CssClass = "Un-Delivered";
            }

            if (status.Text == "Delivered Report")
            {
                status.CssClass = "Delivered";
            }


            if (status.Text == "Ready")
            {
                status.CssClass = "Sample-Collection";
            }

            if (status.Text == "Verify")
            {
                status.CssClass = "Test-Conducted";
            }


        }

    }


    protected void btnPrevTests_Click(object sender, EventArgs e)
    {

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();

        SqlParameter[] sqlParams = {
                new SqlParameter("@regno", Session["registrationNo"])                
                };

        ds = manager.ExecuteDataSet("Pathology_GetPatientPrevTests", "Path_ConnectionString", sqlParams);

        GridView_PrevTests.DataSource = ds;
        GridView_PrevTests.DataBind();

        panel_PrevTests.Visible = true;
    }
    protected void lnkbtnTestNamePrev_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        string testID = lnkbtn.CommandArgument;

        lblTName.Text = lnkbtn.Text;

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("Pathology_GetTestResultByTestIdAndPayID", "Path_ConnectionString", new SqlParameter[] { new SqlParameter() { ParameterName = "@RegNo", Value = Session["registrationNo"] },
            new SqlParameter() { ParameterName = "testID", Value = testID } ,new SqlParameter() { ParameterName = "@payid", Value = lnkbtn.ToolTip.Trim() }
        });
        GridView_PrevTestResults.DataSource = ds;
        GridView_PrevTestResults.DataBind();
        divResultPrev.Visible = true;
    }
    protected void Button_ClosePrevTest_Panel_Click(object sender, EventArgs e)
    {
        //Response.Redirect("PatientLabTests.aspx");
        panel_PrevTests.Visible = false;        
    }
}