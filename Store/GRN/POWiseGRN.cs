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

public partial class Store_POWiseGRN : System.Web.UI.Page
{
    String conStr= ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            
            txtStartDate.Text = DateTime.Now.AddYears(-2).ToString("yyyy-MM-dd");
            hfIStartDate.Value = txtStartDate.Text;

            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            hfEndDate.Value     = txtEndDate.Text;
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            loadDepartment();
            bind_Manufacturer();
            ddl_Manufacturer.Items.Insert(0, new ListItem("--Select Supplier--", "0"));
            //ddl_Category.SelectedIndex = -1;
            //ddl_Manufacturer.SelectedIndex = -1;
            //txt_ItemName.Text = "";

        }
    }


    private void loadDepartment()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            // con = new SqlConnection(BasicConn);

            con.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
            con.Open();
            cmd = new SqlCommand(" select 0 SubDept_Id,  '---ALL---' SubDept_Name from subdepartment union select  SubDept_Id ,SubDept_Name from subdepartment  order by SubDept_Name ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_SubDeptId.DataSource = dt;
            ddl_SubDeptId.DataTextField = "SubDept_Name";
            ddl_SubDeptId.DataValueField = "SubDept_Id";
            ddl_SubDeptId.DataSource = dt;

            ddl_SubDeptId.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }


    protected void bind_Manufacturer()
    {
        SqlCommand cmd;
        try
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                string query = "select party_id,Party_Name from Parties order by Party_Name";
                cmd = new SqlCommand(query, con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl_Manufacturer.DataSource = dt;
                ddl_Manufacturer.DataTextField = "Party_Name";
                ddl_Manufacturer.DataValueField = "party_id";
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

            hfIStartDate.Value = txtStartDate.Text;
            hfEndDate.Value = txtEndDate.Text;
            
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("POWiseGRN", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Receive_Sub_dept_Id",ddl_SubDeptId.SelectedValue);
             
            cmd.Parameters.AddWithValue("@itemName", txt_ItemName.Text.Trim());
            cmd.Parameters.AddWithValue("@PoNo", txtPoNo.Text);
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


            ReportViewer1.LocalReport.ReportPath = Server.MapPath("POWiseGRN.rdlc");
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