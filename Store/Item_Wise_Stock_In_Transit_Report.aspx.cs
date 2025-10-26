using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Store_Item_Wise_Stock_In_Transit_Report : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bind_Manufacturer();
            bindHospital();
            bindSubdepartment();
        }
    }


    protected void bind_Manufacturer()
    {
        SqlCommand cmd;
        try
        {
            SqlConnection con = new SqlConnection(conStr);
            string query = "select '--ALL--' as Manufacturer_Name,0 as ID union select Manufacturer_Name,Manufacturer_Id ID from Items_Manufacturer";
            cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_Manufacturer.DataSource = dt;
            DropDownList_Manufacturer.DataBind();
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
        catch (Exception ex)
        {

        }

    }

    protected void bindSubdepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 SubDept_Id,'------ ALL -----' SubDept_Name union Select SubDept_Id,SubDept_Name From SubDepartment inner join  Department on Department.Dept_ID=Subdepartment.Dept_ID  Where (Department.Hospital_ID=@Hospitalid or @Hospitalid=0) Order By SubDept_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@Hospitalid", DDLbranch.SelectedValue) };
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddlSubDepartment.DataTextField = "SubDept_Name";
        ddlSubDepartment.DataValueField = "SubDept_Id";
        ddlSubDepartment.DataBind();

    }
    protected void bindHospital()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 Hospital_ID,'------ ALL -----' Hospital_Name union Select Hospital_ID,Hospital_Name from Hospital  Order By Hospital_ID,Hospital_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%") };
        DDLbranch.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        DDLbranch.DataTextField = "Hospital_Name";
        DDLbranch.DataValueField = "Hospital_ID";
        DDLbranch.DataBind();

    }


    private void ShowReport()
    {

        try
        {

           
            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("usp_Item_Wise_Stock_Transit", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@order_no ", "");
            cmd.Parameters.AddWithValue("@part_no", "");
            cmd.Parameters.AddWithValue("@name", txtItemName.Text);
            cmd.Parameters.AddWithValue("@manufacture", DropDownList_Manufacturer.SelectedValue);
            cmd.Parameters.AddWithValue("@SubDept_Id", ddlSubDepartment.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);


            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "dataSet_Item_Wise_Stock_In_Transit";//coordinates in your case.
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Item_Wise_Stock_In_Transit_Report.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer1.LocalReport.Refresh();
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

            //else
                ReportViewer1.Visible = true;
        }
        catch (Exception ex)
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
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'";
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


}