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

public partial class Store_ManufacturerWiseItem_Report : System.Web.UI.Page
{
    String conStr= ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
 ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);

        
        if (!Page.IsPostBack)
        {
            
            txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
            hfIStartDate.Value = txtStartDate.Text;

            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            hfEndDate.Value     = txtEndDate.Text;
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            bind_Categories();
            bind_Manufacturer();
            ddl_Category.Items.Insert(0, new ListItem("--Select Category--", "0"));
            ddl_Manufacturer.Items.Insert(0, new ListItem("--Select Manufacture--", "0"));
            //ddl_Category.SelectedIndex = -1;
            //ddl_Manufacturer.SelectedIndex = -1;
            //txt_ItemName.Text = "";

        }
    }


    protected void bind_Categories()
    {
        SqlCommand cmd;
        try
        {
            SqlConnection con = new SqlConnection(conStr);
            string query = "select Item_Category_ID, Item_Category from Store_Item_Category";
            cmd = new SqlCommand(query,con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_Category.DataSource = dt;
            ddl_Category.DataTextField = "Item_Category";
            ddl_Category.DataValueField = "Item_Category_ID";
            ddl_Category.DataBind();
            
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
                string query = "select Manufacturer_Id, Manufacturer_Name from Items_Manufacturer";
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
            

            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("Manufacturer_Wise_Item_Report", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@categoryId", ddl_Category.SelectedValue);
            cmd.Parameters.AddWithValue("@manufacturerId", ddl_Manufacturer.SelectedValue);
            cmd.Parameters.AddWithValue("@itemName", txt_ItemName.Text.Trim());
             cmd.Parameters.AddWithValue("@StartDate",hfIStartDate.Value);
            cmd.Parameters.AddWithValue("@EndDate",  hfEndDate.Value);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();
            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("ManufacturersWiseItemList.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);


            ReportParameter rp = new ReportParameter("ReportParameter1", hfIStartDate.Value);
            ReportParameter rp2 = new ReportParameter("ReportParameter2", hfEndDate.Value);
           
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

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