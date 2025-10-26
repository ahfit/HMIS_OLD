using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Pathology_PatientTestsReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(! IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            txtfromdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txttodate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTimeFrom.Text = DateTime.Now.AddHours(-12).ToString("HH:mm:ss");
            txtTimeTo.Text = DateTime.Now.AddHours(-12).ToString("HH:mm:ss");
            //DropDownList1.SelectedValue = Session["SubDeptID"].ToString();
        }
    }

    private void ShowData()
    {
        SqlConnection con = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        
        try
        {
            SqlCommand sc = new SqlCommand("GetCollectedSampleTest", con);
            sc.CommandType = CommandType.StoredProcedure;
            DateTime ToDate = Convert.ToDateTime(txttodate.Text);
            //string To = ToDate.AddDays(1).ToString();
            DateTime from = Convert.ToDateTime(txtfromdate.Text) + TimeSpan.Parse(txtTimeFrom.Text);
            DateTime to = ToDate + TimeSpan.Parse(txtTimeTo.Text);
            var SubDeptID = DropDownList1.SelectedValue;
            sc.Parameters.AddWithValue("@DateFrom", from);
            sc.Parameters.AddWithValue("@DateTo", to);
            sc.Parameters.AddWithValue("@SubDeptID", Convert.ToInt32(SubDeptID));
            sc.Parameters.AddWithValue("@TGID", Convert.ToInt32(DropDownList2.SelectedValue));
            sc.Parameters.AddWithValue("@StatusID", Convert.ToInt32(DropDownList3.SelectedValue));
            sc.Parameters.AddWithValue("@MRNo", txtMRNo.Text);
            sc.Parameters.AddWithValue("@LabNo", txtLabNo.Text);
            //  sc.Parameters.AddWithValue("@SubDeptID", Session["SubDeptID"]);SubDeptID

            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);
        }
        catch (Exception ex)
        {
            Response.Redirect("Exception Message : " + ex.Message);
        }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/CollectedSampleReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            //ReportParameter rp = new ReportParameter("StartDate", Convert.ToDateTime(txtfromdate.Text).ToString("dd-MM-yyyy"));
            //ReportParameter rp2 = new ReportParameter("EndDate", Convert.ToDateTime(txttodate.Text).ToString("dd-MM-yyyy"));

            //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowData();
    }
}