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

public partial class Patient_Billing_FinaceHeadWiseDrCr : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        { 
            
            ddHospital.DataBind();
            ReportViewer1.LocalReport.EnableHyperlinks = true;
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            GetCounterType();
            getDropdown();
            loadDepartment();
            DDL_Employee.DataBind();
            if (!string.IsNullOrEmpty(Request.QueryString["EmpId"]))
            {
                DDL_Employee.SelectedValue = Request.QueryString["EmpId"];
                pnlFilter.Visible = false;


            }
                //GetCounterType();
            if ( !string.IsNullOrEmpty(Request.QueryString["Sdate"]) && !string.IsNullOrEmpty(Request.QueryString["Edate"]) )
            {
                wdcStartDate.Text = Request.QueryString["Sdate"].ToString();
                wdcEndDate.Text = Request.QueryString["Edate"].ToString();
                ddHospital.SelectedValue = Request.QueryString["Hid"].ToString();
                //DDL_Shift.SelectedValue = Request.QueryString["SID"].ToString();
                DDL_CounterType.SelectedValue = Request.QueryString["CType"].ToString();
               
            }
            else
            {
            wdcStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            wdcEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            
            }
            ShowReport();
        }
    }
    
    private void getDropdown()
    {
        DbManager dbManager = new DbManager();
        DataTable dt = dbManager.ExecuteDataTableWithQuery("select 'All' Patient_type,0 as Patient_Type_ID union all select Patient_type,Patient_Type_ID from Patient_type where Active=1  order by Patient_type asc ", "Basic_Data_ConnectionString", new SqlParameter[0]);
        ddlPatientType.DataSource = dt;
        ddlPatientType.DataValueField = "Patient_Type_ID";
        ddlPatientType.DataTextField = "Patient_type";
        ddlPatientType.DataBind();
    }
    private void loadDepartment()
    {
        DbManager dbmanage = new DbManager();
        SqlParameter[] sqlParams = {
        new SqlParameter("Type", 1),
        new SqlParameter("@HospitalId", ddHospital.SelectedValue) };
        ddlDepartment.DataSource = dbmanage.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataTextField = "SubDept_Name";
        ddlDepartment.DataValueField = "SubDept_Id";
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("All", "0"));
    }
    private void GetCounterType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("select 'All' countertype  union select distinct countertype from Receptionist  ", con);
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
            string url = Request.Url.Authority;
            string  ticketNo="0";
            if(Request.QueryString["TicketNo"] !=null)
            {
                ticketNo=Request.QueryString["TicketNo"];
            }

            ReportParameter[] param = { 
                                          new ReportParameter("SDate", startDate.ToString()), 
                                          new ReportParameter("EDate", EndDate.ToString()),
                                          new ReportParameter("Hospital_ID",ddHospital.SelectedValue),
                                          new ReportParameter("Type",ddlOPDIPD.SelectedItem.Text),
                                          new ReportParameter("ShiftID","All") ,
                                          new ReportParameter("URL",url),
                                          new ReportParameter("CounterType",DDL_CounterType.SelectedValue)
                                      };

           
            DataSet ds;




            if (!string.IsNullOrEmpty(Request.QueryString["EmpId"]))
            {
                SqlParameter[] para = { 
                                      
                                      new SqlParameter("@TicketNo",ticketNo)
                                  };
                ds = dbMgr.ExecuteDataSet("Report_FinancialHeadWiseEmployee", "Basic_Data_ConnectionString", para);
            }
            else
            {
                SqlParameter[] para = { 
                                      new SqlParameter("@DateStart", wdcStartDate.Text), 
                                      new SqlParameter("@DateEnd", wdcEndDate.Text),
                                      new SqlParameter("@hospital_id", ddHospital.SelectedValue),
                                      new SqlParameter("@patient_type", ddlOPDIPD.SelectedValue),
                                      new SqlParameter("@subdeptid", ddlDepartment.SelectedValue),
                                      new SqlParameter("@PatientType", ddlPatientType.SelectedValue),
                                      new SqlParameter("EmpId",DDL_Employee.SelectedValue),
                                      new SqlParameter("@CounterType",DDL_CounterType.SelectedValue),
                                      new SqlParameter("@TicketNo",ticketNo)
                                  };
                ds = dbMgr.ExecuteDataSet("Report_ServiceAccountWise", "Basic_Data_ConnectionString", para);
            }


          
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("FinaceHeadWiseDrCr.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportDataSource repDs = new ReportDataSource();
            ReportViewer1.LocalReport.SetParameters(param);
            
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DS_ServiceCategoryWise", ds.Tables[0]));            
                                  
            ReportViewer1.Visible = true;

        }
        catch (Exception ex)
        {

        }


    }
   
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowReport();
    }

    protected void ddHospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadDepartment();
    }
}
