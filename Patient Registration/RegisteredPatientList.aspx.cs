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

public partial class Patient_Registration_RegisteredPatientList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            loadDepartment();
            txtDateFrom.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetPatientList();
    }

  

    protected void loadDepartment()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("  SELECT  0 as SubDept_Id,'--All--' SubDept_Name UNION SELECT SubDepartment.SubDept_Id, SubDepartment.SubDept_Name FROM SubDepartment where SubDept_Type = 1 order by SubDept_Name", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlDepartment.DataValueField = "SubDept_Id";
            ddlDepartment.DataTextField = "SubDept_Name";
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();
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
    private void GetPatientList()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("StartDate", txtDateFrom.Text), 
                                      new SqlParameter("EndDate", txtDateTo.Text) ,
                                      new SqlParameter("HospitalID", ddl_Hospital.SelectedValue),
                                      new SqlParameter("subdeptid", ddlDepartment.SelectedValue),
                                      new SqlParameter("rank", DropDownListRank.SelectedValue),
                                  };
            DataTable dt = dbMgr.ExecuteDataTable("usp_GetNewRegisteredPatient", "Basic_Data_ConnectionString", para);
            ReportParameter[] reportPara = { new ReportParameter("fromDate", txtDateFrom.Text), new ReportParameter("endDate", txtDateTo.Text)};
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("RegisteredPatientList.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1",dt));
            ReportViewer1.LocalReport.SetParameters(reportPara);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();

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
}