using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Shared;
using System.Data.SqlClient;
using Microsoft.Reporting.WebForms;
public partial class Patient_Income_Rpt : System.Web.UI.Page
{
    //ReportDocument abc = new ReportDocument();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            WebDateChooser1.Value = DateTime.Now.AddDays(-1);
            WebDateChooser2.Value = DateTime.Now;
            GetPatientType();
            //showrpt();
            loadDepartments();  
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
    private void loadDepartments()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conststr);
            SqlCommand cmd = new SqlCommand("Select 0 Dept_ID, '----- ALL -----' Dept_Name UNION Select Dept_ID,Dept_Name From Department where Department.Hospital_ID=@HospitalID  Order By Dept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();
      

    }
    protected void showrpt()
    {  
        SqlParameter[] para={new SqlParameter("@StartDate",WebDateChooser1.Value.ToString()),
            new SqlParameter("@EndDate",WebDateChooser2.Value.ToString()),
            new SqlParameter("@Dept_ID", ddlDepartment.SelectedValue),
            new SqlParameter("Type", ddlrpttype.SelectedValue)};
        DbManager dbMgr=new DbManager();

        //ReportParameter[] repParams = new ReportParameter[3];

        //repParams[0] = new ReportParameter("StartDate", WebDateChooser1.Value.ToString());
        //repParams[1] = new ReportParameter("EndDate", WebDateChooser2.Value.ToString());
        //repParams[2] = new ReportParameter("PatientType", DropDownList1.SelectedItem.Text);

        
        DataTable dt = dbMgr.ExecuteDataTable("usp_PatientAndIncomeDetails", "Basic_Data_ConnectionString",para);
        ReportViewer1.LocalReport.DataSources.Clear();
        if(ddlrpttype.SelectedValue == "Monthly")
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("PatientIncomeMonthlywise.rdlc");
        else
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("PatientIncomeYearlywise.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1",dt));

        ReportParameter rp = new ReportParameter("ReportParameter1", Convert.ToDateTime(WebDateChooser1.Value.ToString()).ToString("dd MMM,yyyy"));
        ReportParameter rp2 = new ReportParameter("ReportParameter2", Convert.ToDateTime(WebDateChooser2.Value.ToString()).ToString("dd MMM,yyyy"));
        ReportParameter rp3 = new ReportParameter("ReportParameter3", "");
        ReportParameter rp4 = new ReportParameter("ReportParameter4", Convert.ToDateTime(WebDateChooser1.Value.ToString()).ToString("MMMM,yyyy"));
        ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2, rp3,rp4 });
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
 
        ReportViewer1.LocalReport.Refresh();
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
    protected void Button1_Click(object sender, EventArgs e)
    {
       
        showrpt();
    }
    protected void GetPatientType()
    {
        String conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("select Patient_type.Patient_Type_ID,Patient_type.Patient_type from Patient_type inner join Registration.dbo.Patient_Type_HospitalWise PH on PH.Patient_Type_Id=Patient_type.Patient_Type_ID where Active= 1 and PH.Hospital_Id=@HospitalId ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            cmd.Parameters.AddWithValue("@HospitalId", ddl_Hospital.SelectedValue);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField="Patient_type";
            DropDownList1.DataValueField = "Patient_type_id";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem() { Selected = true, Text = "All", Value = "0" });
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }
    protected void ddl_Hospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetPatientType();
    }
}
