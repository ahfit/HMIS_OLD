using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class Pathology_LabStatisticsReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    string PatconString = ConfigurationManager.ConnectionStrings["Pathology2ConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtfromdate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
            txttodate.Text = DateTime.Now.ToString("yyyy-MM-dd");
           
            loadPatientType();
            DDL_Hospital.DataBind();
            DDL_Hospital.SelectedValue = Session["HospitalID"].ToString();
            loadTestGroup();
            Employee_Info();
        }
    }
    public void Employee_Info()
    {
        try
        {
            string constring = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
            System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(constring);
            System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand("SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name from Employee WHERE (Employee.EmpID = @Emp_ID)", con);
            mycommand.CommandType = System.Data.CommandType.Text;
            System.Data.SqlClient.SqlParameter param;
            param = mycommand.Parameters.AddWithValue("@Emp_ID", Session["Emp_ID"]);
            con.Open();
            System.Data.SqlClient.SqlDataReader reader = mycommand.ExecuteReader();
            if (reader.Read() == true)
                Session["emp_Name"] = reader[0].ToString();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    protected void ShowReport()
    {


        SqlConnection conn = new SqlConnection(PatconString);
        DataSet dt = new DataSet();
        try
        {
            SqlCommand cmd = new SqlCommand("LAB_StatisticsReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(txtfromdate.Text));
            cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(txttodate.Text));
            
            cmd.Parameters.AddWithValue("@IPDOPD", DropDownList_PatientType.SelectedValue);
            cmd.Parameters.AddWithValue("@TGID", ddlTestGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@HospitalID", DDL_Hospital.SelectedValue);

           

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/LabStatisticsReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet2", dt.Tables[0]));
          
            ReportViewer1.LocalReport.SubreportProcessing += subReports;

            ReportParameter rp1 = new ReportParameter("FromDate", txtfromdate.Text.ToString());
            ReportParameter rp2 = new ReportParameter("EndDate", txttodate.Text.ToString());
            ReportParameter rp3 = new ReportParameter("Name", Session["emp_Name"].ToString());

            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp1, rp2, rp3 });

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
            Response.Write(ex.Message);
        }
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
        catch (Exception)
        {
        }
    }

    private void loadTestGroup()
    {
        String connstrRad = ConfigurationManager.ConnectionStrings["RadiologyConnectionString"].ToString();
        SqlConnection con = new SqlConnection(connstrRad);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 as TGID, 'ALL' TGName UNION  select TGID, TGName from Pathology2.dbo.TestGroup", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
          //  cmd.Parameters.AddWithValue("@Hospitalid", DDL_Hospital.SelectedValue);

            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlTestGroup.DataSource = dt;
            ddlTestGroup.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    
    private void loadPatientType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(RegconString);
            con.Open();
            cmd = new SqlCommand("Select 0 as ID, 'ALL' Patient_Type UNION select ID, Patient_Type from Patient_Type where Active=1 order by ID ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_PatientType.DataSource = dt;
            DropDownList_PatientType.DataTextField = "Patient_type";
            DropDownList_PatientType.DataValueField = "ID";

            DropDownList_PatientType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}