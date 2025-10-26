using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
//using PatientBilllingDataSet_Panel_PayableTableAdapters;
using Microsoft.Reporting.WebForms;

public partial class Patient_Billing_Panel_Company_Payables : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            start_date.Value = DateTime.UtcNow.AddDays(-3);
            end_date.Value = DateTime.Now.ToString();
        }
    }
    protected void SearchEmployee_Click(object sender, EventArgs e)
    { 
        showGrid();
        showReport();
    } 
    public void showReport()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "usp_Panel_Company_Payable";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@start_date", start_date.Value);
            cmd.Parameters.AddWithValue("@end_date", end_date.Value);
            cmd.Parameters.AddWithValue("@party_id", DropDownList_Parties.SelectedValue);
            //cmd.Parameters.AddWithValue("@party_id", 1);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Encryption enc = new Encryption();
            dt.Columns["Prefix"].ReadOnly = false;
            dt.Columns["PFName"].ReadOnly = false;
            dt.Columns["PMName"].ReadOnly = false;
            dt.Columns["PLName"].ReadOnly = false;
            dt.Columns["RegNo"].ReadOnly = false;
            
            foreach (DataRow row in dt.Rows)
            {
                if (row["PFName"].ToString() != "")
                {
                    row["PFName"] = enc.Encrypt_Main(row["PFName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PFName"].ToString(); 
                }
                if (row["PMName"].ToString() != "")
                {
                    row["PMName"] = enc.Encrypt_Main(row["PMName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PMName"].ToString();
                }
                if (row["PLName"].ToString() != "")
                {
                    row["PLName"] = enc.Encrypt_Main(row["PLName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PLName"].ToString();
                }
                row["RegNo"] = enc.Encrypt_Main(row["RegNo"].ToString(), false);

            } 
           // PatientBilllingDataSet_Panel_Payable ds = new PatientBilllingDataSet_Panel_Payable(); 
            //usp_Panel_Company_PayableTableAdapter daa = new usp_Panel_Company_PayableTableAdapter();
            //daa.Fill(ds.usp_Panel_Company_Payable,Convert.ToDateTime(start_date.Value),Convert.ToDateTime(end_date.Value),1);
            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet_Panel_Payable";//coordinates in your case.
            reportDataSource.Value = dt; 
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Panel_Company_Payables_Report.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
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
    public void showGrid()
    {
        try
        {
            string conStr = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;
            cmd.CommandText = "usp_Panel_Company_Payable";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@start_date",start_date.Value);
            cmd.Parameters.AddWithValue("@end_date",end_date.Value);
            cmd.Parameters.AddWithValue("@party_id", DropDownList_Parties.SelectedValue);
            //cmd.Parameters.AddWithValue("@party_id",1);            
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Encryption enc = new Encryption();
            int totalAmount = 0;
            foreach(DataRow row in dt.Rows)
            {
                if (row["PFName"].ToString() != "")
                {
                    row["PFName"] = enc.Encrypt_Main(row["PFName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PFName"].ToString();
                }
                if (row["PMName"].ToString() != "")
                {
                    row["PMName"] = enc.Encrypt_Main(row["PMName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PMName"].ToString();
                }
                if (row["PLName"].ToString() != "")
                {
                    row["PLName"] = enc.Encrypt_Main(row["PLName"].ToString(), false);
                    row["Prefix"] = row["Prefix"].ToString() + " " + row["PLName"].ToString();
                }

                totalAmount = totalAmount + Convert.ToInt32(row["Amount"].ToString());
            }

            
            GridViewPatient.DataSource = dt;
            GridViewPatient.DataBind();
        }
        catch(Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }
    protected void GridViewPatient_PreRender(object sender, EventArgs e)
    {
        Double totalAmount = 0;
        Coma coma = new Coma();
        Label lblAmount = new Label();
        if (GridViewPatient.Rows.Count > 0)
        {
            foreach (GridViewRow row in GridViewPatient.Rows)
            {
                lblAmount = (Label)row.FindControl("LabelAmount");
                totalAmount = totalAmount + Convert.ToDouble(lblAmount.Text.ToString());
                lblAmount.Text = coma.place_Coma(lblAmount.Text);

            }

           Label lblTotal=(Label)GridViewPatient.FooterRow.FindControl("footerAmount");
           lblTotal.Text = coma.place_Coma(totalAmount.ToString()); 
        }
    }
}