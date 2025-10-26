using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class Store_SubDepartmentWiseItemsReport : System.Web.UI.Page
{
    String conStr= ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
            hfIStartDate.Value = txtStartDate.Text;

            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            hfEndDate.Value = txtEndDate.Text;

            bind_SubDepartments();
            bind_Manufacturer();
            ddl_SubDepartment.Items.Insert(0, new ListItem("--Select Department--", "0"));
            //ddl_Manufacturer.Items.Insert(0, new ListItem("--Select Supplier--", "0"));
            //ddl_Category.SelectedIndex = -1;
            //ddl_Manufacturer.SelectedIndex = -1;
            //txt_ItemName.Text = "";

        }
    }


    protected void bind_SubDepartments()
    {
        SqlCommand cmd;
        try
        {
            SqlConnection con = new SqlConnection(conStr);
            string query = "select SubDept_Id, SubDept_Name from SubDepartment";
            cmd = new SqlCommand(query,con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_SubDepartment.DataSource = dt;
            ddl_SubDepartment.DataTextField = "SubDept_Name";
            ddl_SubDepartment.DataValueField = "SubDept_Id";
            ddl_SubDepartment.DataBind();
            
        }
        catch (Exception ex)
        {
        }
    }

    protected void bind_Manufacturer()
    {
        SqlCommand cmd;
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "SELECT     0 as   Manufacturer_Id,' ---ALL---' Manufacturer_Name union  SELECT        Manufacturer_Id, Manufacturer_Name FROM    Items_Manufacturer order by Manufacturer_Name";
                cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl_Manufacturer.DataSource = dt;
                ddl_Manufacturer.DataTextField = "Manufacturer_Name";
                ddl_Manufacturer.DataValueField = "Manufacturer_Id";
                ddl_Manufacturer.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }


    protected void Button_Report_Click(object sender, EventArgs e)
    {
        try
        {
            ShowReport();
        }
        catch(Exception ex)
        {

        }

    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
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


    private void ShowReport()
    {

        try
        {

            //DateTime start_date = Convert.ToDateTime(WebDateChooser_Start_Date.Value),
            //end_date = Convert.ToDateTime(WebDateChooser_end_Date.Value);

            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("uspSalePurchaseItemWise", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@SubDeptID", ddl_SubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@manufacturerId", ddl_Manufacturer.SelectedValue);
            cmd.Parameters.AddWithValue("@itemName", txt_ItemName.Text.Trim());

            cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
            cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("ItemsPurchaseAndSaleReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

            ReportParameter rp = new ReportParameter("ReportParameter1", txtStartDate.Text);
            ReportParameter rp2 = new ReportParameter("ReportParameter2", txtEndDate.Text);

            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });

            //ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("Po_Item_Stock_Report", ds.Tables["usp_Po_Item_Stock"]));
            ReportViewer1.LocalReport.Refresh();
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }

            else
                ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        {
        }

    }
    



}