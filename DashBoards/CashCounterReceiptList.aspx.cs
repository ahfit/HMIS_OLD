using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using Microsoft.Reporting.WebForms;
public partial class CashCounterReceiptList : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            txtDateFrom.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTimeFrom.Text = DateTime.Now.AddHours(-1).ToString("hh:mm");
            txtTimeTo.Text = DateTime.Now.ToString("hh:mm");
           
            
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
    protected void LoadCategoryWiseCollection()
    {


        DateTime sDate = Convert.ToDateTime(txtDateFrom.Text) + TimeSpan.Parse(txtTimeFrom.Text);
        DateTime eDate = Convert.ToDateTime(txtDateTo.Text) + TimeSpan.Parse(txtTimeTo.Text);
        con.Open();
        SqlCommand cmd = new SqlCommand("CashCounterReceiptList", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@startDate",sDate);
        cmd.Parameters.AddWithValue("@endDate", eDate);
        cmd.Parameters.AddWithValue("@Type", ddlType.SelectedValue);
        cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = ds.Tables[0];

      


        ReportParameter[] para = { new ReportParameter("SDate", sDate.ToString("dd/MM/yyyy")), new ReportParameter("EDate", eDate.ToString("dd/MM/yyyy")) };
        ReportViewer1.ProcessingMode = ProcessingMode.Local;
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("CashCounterReceiptList.rdlc");

        ReportViewer1.LocalReport.SetParameters(para);

        ReportViewer1.LocalReport.DataSources.Add(rds);

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
   

    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadCategoryWiseCollection();
       
    }
   
}
