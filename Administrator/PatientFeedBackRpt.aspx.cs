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
using System.Windows.Forms;

public partial class Pathology_LabTestSummaryReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadDepartments();
            loadAllEmployee();
            startDate.Value = DateTime.Now.AddDays(-1);
            endDate.Value = DateTime.Now;
        }
    }
    private void loadDepartments()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 SubDept_ID, '----- ALL -----' SubDept_Name UNION Select SubDept_ID,SubDept_Name From SubDepartment where SubDept_Type="+1+"  Order By SubDept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubDepartment.DataSource = dt;
            ddlSubDepartment.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    private void loadAllEmployee()
    {

        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select Prefix+' '+EFName +' '+ ELName as Name,EmpID From Employee where Is_Consultant = "+1+" Order By EFName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlEmployee.DataSource = dt;
            ddlEmployee.DataTextField = "Name";
            ddlEmployee.DataValueField = "EmpID";
            ddlEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }

    protected void ddlSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlEmployee.Items.Clear();
     
        SqlConnection con = new SqlConnection(connstr);

        

        cmd = new SqlCommand("Sp_GetEmployeDeptWise2", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@DeptID", SqlDbType.Int).Value = ddlSubDepartment.SelectedItem.Value;
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ddlEmployee.DataSource = dt;
        ddlEmployee.DataBind();

        //SqlConnection con = new SqlConnection(connstr);
        //SqlCommand cmd = new SqlCommand("select * from Employee where  SubDeptId=" + ddlSubDepartment.SelectedItem.Value+"And Is_Consultant = "+1+"Or select * from Employee where  SubDeptId=" +0  , con);
        //SqlDataAdapter sda = new SqlDataAdapter(cmd);
        //DataTable dt = new DataTable();
        //sda.Fill(dt);
        //ddlEmployee.DataSource = dt;
        //ddlEmployee.DataBind();
    }


    protected void ShowReport()
    {
        //DateTime sd = Convert.ToDateTime(startDate.Text);
        //var StartingDate = String.Format("{0:yyyy-dd-MM}", sd);

         //DateTime ed = Convert.ToDateTime(endDate.Text);
         //var EndingDate = String.Format("{0:yyyy-dd-MM}", ed);
        DateTime StartingDate = DateTime.ParseExact(startDate.Text, "dd/MM/yyyy", null);
        DateTime Endingdate = DateTime.ParseExact(endDate.Text, "dd/MM/yyyy", null);

        SqlConnection conn = new SqlConnection(connstr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand cmd = new SqlCommand("Sp_GetPatientFeedbakReport2", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DoctorID", Convert.ToInt32(ddlEmployee.SelectedValue));
            cmd.Parameters.AddWithValue("@StartDate", StartingDate);
            cmd.Parameters.AddWithValue("@EndDate", Endingdate.AddDays(1));


            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            sda.Fill(dt);
        }
        catch (Exception ex)
        { }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Administrator/PatientFeedBakReport.rdlc");
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}