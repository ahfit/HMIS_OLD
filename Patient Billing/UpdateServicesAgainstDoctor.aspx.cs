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

public partial class Patient_Billing_UpdateServicesAgainstDoctor : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    DataTable _dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           
            txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    
    protected void LoadReport()
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            LoadDoctor();
            con.Open();
            cmd = new SqlCommand("usp_getPatientServicesDetail_UpdateDoctorWise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            if (txtRegno.Text.Trim() == "")
                cmd.Parameters.AddWithValue("@Yearly_No", 0);
            else
            {
                cmd.Parameters.AddWithValue("@Yearly_No", Convert.ToInt32(txtRegno.Text));
            }
            cmd.Parameters.AddWithValue("@FromDate", txtDateFrom.Text.ToString());
            cmd.Parameters.AddWithValue("@ToDate", txtDateTo.Text.ToString());

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            //ReportDataSource rds = new ReportDataSource();
            //rds.Name = "DataSet1";
            //rds.Value = dt;
            gvd.DataSource = dt;
            gvd.DataBind();
            //ReportViewer1.LocalReport.DataSources.Clear();
            //string reportPath = Server.MapPath("~/Patient Billing/PatientDetail.rdlc");
            //ReportViewer1.LocalReport.ReportPath = reportPath;
            //ReportViewer1.LocalReport.DataSources.Add(rds);
            //ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            //ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }


    }

     

    private  void LoadDoctor()
    {
        DataTable dt = new DataTable();
        string conStringBasic = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conStringBasic);
            con.Open();
            cmd = new SqlCommand("GetConsultantForPatientServicess ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            da.Fill(_dt);
        }
        catch (Exception ex)
        {

            con.Close();
        }
        finally {
           
        }        
    }

    protected void btnReport_Click(object sender, EventArgs e)
    {
        LoadReport();
    }

   

    protected void gvd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField ID = e.Row.FindControl("hfDctrID") as HiddenField;
            HiddenField hdfS_ID = e.Row.FindControl("hdfS_ID") as HiddenField;
            DropDownList list = e.Row.FindControl("ddl_Doctor") as DropDownList;


            DataRow[] dt = _dt.Select("Service_ID='" + hdfS_ID.Value + "' or Service_ID='0'");
            
            list.DataSource = dt.CopyToDataTable();
            list.DataValueField = "EmpID";
            list.DataTextField = "Name";
            list.DataBind();
           
            list.SelectedValue = ID.Value;
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Button btn=sender as Button;
        string ID=btn.CommandArgument;


        GridViewRow row=btn.NamingContainer as GridViewRow;
        DropDownList list = row.FindControl("ddl_Doctor") as DropDownList;
         SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("update Patient_Services set Doctor_ID=@DctriD where ID=@ID", con);
            cmd.CommandType = CommandType.Text;
           
                cmd.Parameters.AddWithValue("@ID", ID);
                cmd.Parameters.AddWithValue("@DctriD", list.SelectedValue);
                cmd.ExecuteNonQuery();
                LoadReport();
        }
        catch { }
        finally {
            con.Close();
        }
        
    }
}