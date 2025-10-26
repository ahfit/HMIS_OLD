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

public partial class DashBoards_TotalServicesSumofPatients : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DropDownList_Hospital.SelectedValue = Session["HospitalID"].ToString();
            DropDownList_Hospital.Enabled = false;
            txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
            GetCounterType();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadReport();
    }
    private void GetCounterType()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))

            try
            {


                SqlCommand command = new SqlCommand("select 'All' countertype  union select distinct countertype from Receptionist  ", con);
                SqlDataAdapter sda = new SqlDataAdapter(command);
                DataTable dt = new DataTable();

                sda.Fill(dt);
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
    protected void LoadReport()
    { 
        DateTime sDate = Convert.ToDateTime(txtDateFrom.Text);
        DateTime eDate = Convert.ToDateTime(txtDateTo.Text);
        con.Open();
        SqlCommand cmd = new SqlCommand("uspTotalServicesSumofPatient_Registration", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@fromDate", sDate);
        cmd.Parameters.AddWithValue("@ToDate", eDate);
     
        cmd.Parameters.AddWithValue("@hospitalID", DropDownList_Hospital.SelectedValue);
        
        cmd.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text);
        cmd.Parameters.AddWithValue("@PartyTypeID", ddl_PatientType.SelectedValue);
        cmd.Parameters.AddWithValue("@PartyID", DropDownList_Parties.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];


        SqlCommand cmd1 = new SqlCommand("usp_GetCashReceived", con);
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.AddWithValue("@DateStart", sDate);
        cmd1.Parameters.AddWithValue("@DateEnd", eDate);
        cmd1.Parameters.AddWithValue("@HospitalID", DropDownList_Hospital.SelectedValue);
        cmd1.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text);
        SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
        DataSet ds1 = new DataSet();
        da1.Fill(ds1);
        ReportDataSource rds1 = new ReportDataSource();
        rds1.Name = "DataSet2";
        rds1.Value = ds1.Tables[0];

        SqlCommand cmd2 = new SqlCommand("GetPatient_Services_Pharmacy_Refund", con);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.AddWithValue("@fromDate", sDate);
        cmd2.Parameters.AddWithValue("@ToDate", eDate);
        cmd2.Parameters.AddWithValue("@HospitalID", DropDownList_Hospital.SelectedValue);
        cmd2.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text);
        SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
        DataSet ds2 = new DataSet();
        da2.Fill(ds2);
        ReportDataSource rds2 = new ReportDataSource();
        rds2.Name = "DataSet3";
        rds2.Value = ds2.Tables[0];

        //ReportParameter[] para = { new ReportParameter("SDate", sDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", eDate.ToString("dd/MM/yyyy")) };
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/DashBoards/Report.rdlc");

        //ReportViewer1.LocalReport.SetParameters(para);

        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.DataSources.Add(rds1);
        ReportViewer1.LocalReport.DataSources.Add(rds2);
        //ReportParameter rp = new ReportParameter("ReportParameter1", txtDateFrom.Text);
        //ReportParameter rp2 = new ReportParameter("ReportParameter2", txtDateTo.Text);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);



        ReportViewer1.LocalReport.Refresh();
        con.Close();


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