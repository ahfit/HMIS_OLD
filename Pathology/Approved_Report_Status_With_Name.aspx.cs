using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Approved_Report_Status_With_Name : System.Web.UI.Page

{  
    Encryption enc = new Encryption();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {


            WebDateChooser_Start_Date.Value = DateTime.Now;
            WebDateChooser_End_Date0.Value = DateTime.Now;

            HiddenField_start.Value = WebDateChooser_Start_Date.Value.ToString();
            HiddenField_End.Value = WebDateChooser_End_Date0.Value.ToString();
            //Response.Write(HiddenField_End.Value + "Start" + HiddenField_start.Value);
            GridView1.DataBind();
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //string s = ConfigurationManager.ConnectionStrings["Pathology2ConnectionString"].ConnectionString;
        //SqlConnection conn = new SqlConnection(s);
        //SqlCommand cmd = new SqlCommand("select RegNo,YearlyNo,trDate,Status,Approved_By,Status_by,Report_date_time from Path_PatientTestResult_Main ", conn);
        //conn.Open();
        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataSet ds = new DataSet();
        //da.Fill(ds);
        //GridView1.DataSource = ds;
        //GridView1.DataBind();

        LoadReport();
       
        GridView1.DataBind();
    }
    protected void LoadReport() {
       
        
        HiddenField_start.Value = WebDateChooser_Start_Date.Value.ToString();
        HiddenField_End.Value = WebDateChooser_End_Date0.Value.ToString();


        if (string.IsNullOrEmpty(Tb_regno.Text.Trim()))
        {

            HiddenField_reg_NO.Value = "%";

        }
        else
        {
            HiddenField_reg_NO.Value ="%" + enc.Encrypt_Main(Tb_regno.Text.Trim(),true) + "%";
         
            HiddenField_start.Value = WebDateChooser_Start_Date.Value.ToString();
            HiddenField_End.Value = WebDateChooser_End_Date0.Value.ToString();

            GridView1.DataBind();
        }
           
        
         
    }

    protected void Tb_regno_TextChanged(object sender, EventArgs e)
    {
            LoadReport();
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        
        foreach (GridViewRow row in GridView1.Rows) {

            HiddenField Enc_RegNo = (HiddenField)row.FindControl("HiddenField_Enc_RegNo");
            Label lbl = (Label)row.FindControl("label1");
            lbl.Text = enc.Encrypt_Main(Enc_RegNo.Value, false);

            HiddenField hdf_PFname = (HiddenField)row.FindControl("HiddenField_PFNAME");
            Label lbl_Pfname = (Label)row.FindControl("Label2");
            lbl_Pfname.Text = enc.Encrypt_Main(hdf_PFname.Value, false);
        }
    }
    protected void Report_Click(object sender, EventArgs e)
    {
        //DataView dv = (DataView)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
        //DataTable dt = dv.Table;
        //ReportViewer1.LocalReport.DataSources.Clear();
        //string reportPath = Server.MapPath("~/Pathology/Approved_status_Report.rdlc");
        //ReportViewer1.LocalReport.ReportPath = reportPath;
        //ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        //ReportViewer1.LocalReport.Refresh();
        
    }
    protected void TextBox_sample_TextChanged(object sender, EventArgs e)
    {
       
        if (string.IsNullOrEmpty(TextBox_sample.Text.Trim()))
        {
            HiddenField_sample.Value = "%";


        }
        else {

            HiddenField_sample.Value = TextBox_sample.Text;
        
        }
        GridView1.DataBind();
    }
    protected void TextBox_PFname_TextChanged(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(TextBox_PFname.Text.Trim()))
        {
            HiddenField_Pfname.Value = "%";

        }
        else
        {
            HiddenField_Pfname.Value = "%" + enc.Encrypt_Main(TextBox_PFname.Text.Trim(), true) + "%";
        
        }
        GridView1.DataBind();
    }
    
}