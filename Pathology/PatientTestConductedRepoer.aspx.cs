using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Pathology_PatientTestConductedRepoer : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    string PathConstr = ConfigurationManager.ConnectionStrings["Pathology2ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtfromdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txttodate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            loadDepartments();
            loadPatientType();
            loadTestGroup();
            loadTestName();
        }
    }
    private void loadTestGroup()
    {
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 as TGID, 'ALL' TGName UNION  select TGID, TGName from TestGroup", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
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
    private void loadDepartments()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 Dept_ID, '----- ALL -----' Dept_Name UNION select SubDept_Id,SubDept_Name from SubDepartment", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();
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
            cmd = new SqlCommand("Select 0 as ID, ' ALL' Patient_Type UNION select ID, Patient_Type from Patient_Type where Active=1 order by Patient_Type ", con);
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

    private void loadTestName()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(PathConstr);
            con.Open();
            cmd = new SqlCommand("select '0' as TB_ID,'All' as TB_Name union select TB_ID,TB_Name from Test_Booking where MG_ID=@mgiD", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@mgiD", ddlTestGroup.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlTestName.DataSource = dt;
            ddlTestName.DataTextField = "TB_Name";
            ddlTestName.DataValueField = "TB_ID";

            ddlTestName.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    protected void ddlTestGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadTestName();

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
    protected void ShowReport()
    {
        SqlConnection conn = new SqlConnection(PathConstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("uspLabTestConductedReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Date_From", Convert.ToDateTime(txtfromdate.Text));
            cmd.Parameters.AddWithValue("@Date_To", Convert.ToDateTime(txttodate.Text));
            cmd.Parameters.AddWithValue("@SudDept_Id", Convert.ToInt32(ddlDepartment.SelectedValue));
            cmd.Parameters.AddWithValue("@IPDOPD", typeid.SelectedValue);
            cmd.Parameters.AddWithValue("@TGID", ddlTestGroup.SelectedValue);
            cmd.Parameters.AddWithValue("@typeID", DropDownList_PatientType.SelectedValue);
            cmd.Parameters.AddWithValue("@TestID", ddlTestName.SelectedValue);
            cmd.Parameters.AddWithValue("@PartyID", DropDownList_Parties.SelectedValue);



            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/LabPatientTestConductedReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
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
    protected void btnDepartmentView_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Patient%20Registration/Daily_Position_Rpt.aspx");
    }

     
}