using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Patient_Billing_CashReportCategoryWise : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            GetCounterType();
            if ( !string.IsNullOrEmpty(Request.QueryString["Sdate"]) && !string.IsNullOrEmpty(Request.QueryString["Edate"]) )
            {
                wdcStartDate.Text = Convert.ToDateTime(Request.QueryString["Sdate"].ToString()).ToString("yyyy-MM-dd");
                wdcEndDate.Text = Convert.ToDateTime(Request.QueryString["Edate"].ToString()).ToString("yyyy-MM-dd");
                DDL_Hospital.SelectedValue = Request.QueryString["Hid"].ToString();
                DDL_Shift.SelectedValue = Request.QueryString["SID"].ToString();
                DDL_CounterType.SelectedValue = Request.QueryString["CounterType"].ToString();
                ShowReport();
            }
            else
            {
                wdcStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            wdcEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            ShowReport();
            }
            
        }
    }
    private void GetCounterType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("select 'ALL' countertype  union select distinct countertype from Receptionist  ", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_CounterType.DataSource = dt;
            DDL_CounterType.DataTextField = "countertype";
            DDL_CounterType.DataValueField = "countertype";

            DDL_CounterType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    private void ShowReport()
    {
        try
        {
            DbManager dbMgr=new DbManager();

            DateTime startDate = Convert.ToDateTime(wdcStartDate.Text);
            DateTime EndDate = Convert.ToDateTime(wdcEndDate.Text);


            ReportParameter[] param = { new ReportParameter("SDate", startDate.ToString()), new ReportParameter("EDate", EndDate.ToString()) };

            SqlParameter[] para = { new SqlParameter("CCDAte", wdcStartDate.Text), new SqlParameter("CCEndDAte", wdcEndDate.Text),
                                      new SqlParameter("@shiftID",DDL_Shift.SelectedValue),new SqlParameter("@hid",DDL_Hospital.SelectedValue),
                                      new SqlParameter("@CounterType",DDL_CounterType.SelectedValue)
                                       
	 , new SqlParameter("rec_amount_id", "0") };
            DataSet dt = dbMgr.ExecuteDataSet("newCashReportCatageoryWise", "Basic_Data_ConnectionString", para);

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("CashReportCategoryWise.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            ReportViewer1.LocalReport.SetParameters(param);
            

            repDs.Name = "";
            repDs.Value = dt.Tables[1];

            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt.Tables[0]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt.Tables[1]));
            


            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

            //else
                ReportViewer1.Visible = true;

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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}
