using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Configuration;

public partial class GetCateGoryWiseRevenue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            GetCounterType();
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Hospital.DataValueField = "Hospital_ID";
            ddl_Hospital.DataTextField = "Hospital_Name";
            ddl_Hospital.DataSource = dt;
            ddl_Hospital.DataBind();
        }
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
    protected void getData()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        SqlConnection con1 = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        SqlConnection con2 = new SqlConnection(ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString);
        SqlConnection con3 = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand();
        SqlCommand cmd1 = new SqlCommand();
        SqlCommand cmd2 = new SqlCommand();
        SqlCommand cmd3 = new SqlCommand();
        try
        {
            con.Open();
            cmd.CommandText = "GetCategoryWiseRevenue";
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
            cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
            cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            cmd.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);



            con1.Open();
            cmd1.CommandText = "usp_GetCashReceived";
            cmd1.Connection = con1;
            cmd1.CommandType = CommandType.StoredProcedure;
            cmd1.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(txtStartDate.Text));
            cmd1.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(txtEndDate.Text));
            cmd1.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            cmd1.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text);

            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            DataTable dt1 = new DataTable();
            da1.Fill(dt1);

            con2.Open();
            cmd2.CommandText = "usp_GetstandRece";
            cmd2.Connection = con1;
            cmd2.CommandType = CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(txtStartDate.Text));
            cmd2.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(txtEndDate.Text));

            SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
            DataTable dt2 = new DataTable();
            da2.Fill(dt2);

            con3.Open();
            cmd3.CommandText = "usp_GetCashReceivedfromReceivable";
            cmd3.Connection = con1;
            cmd3.CommandType = CommandType.StoredProcedure;
            cmd3.Parameters.AddWithValue("@DateStart", Convert.ToDateTime(txtStartDate.Text));
            cmd3.Parameters.AddWithValue("@DateEnd", Convert.ToDateTime(txtEndDate.Text));

            SqlDataAdapter da3 = new SqlDataAdapter(cmd3);
            DataTable dt3 = new DataTable();
            da3.Fill(dt3);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/DashBoards/CategoryWiseRevenue.rdlc");

            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt1));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet3", dt2));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet4", dt3));

            ReportParameter rp = new ReportParameter("SDate", txtStartDate.Text);
            ReportParameter rp2 = new ReportParameter("EDate", txtEndDate.Text);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
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
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
                cmd.Dispose();
                con1.Close();
                cmd1.Dispose();
                con2.Close();
                cmd2.Dispose();
            }

        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        getData();
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