using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class Finance_SearchItemsReport : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
    String conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (!Page.IsPostBack)
            {
                bindSubdepartment();
                bind_Categories();
                bindSubCategory();
            }

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

    private void bindSubCategory()
    {
        con.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("select '--- All ---' as [Generic_Name] ,0 as [G_N_Id] union SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id or @Cat_Id=0)", con);
            cmd.Parameters.AddWithValue("@Cat_Id", ddl_Category.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "Generic_Name";
            ddlSubCategory.DataValueField = "G_N_Id";
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    } 
    protected void bind_Categories()
    {
        SqlCommand cmd;
        try
        {
            con.Open();
            try
            {


                cmd = new SqlCommand("SELECT  0 as Item_Type_Id, '--- All ---' as Item_Type union select Item_Type_Id, Item_Type FROM Store_Item_Types where IS_Pharmacy = 0", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl_Category.DataSource = dt;
                ddl_Category.DataTextField = "Item_Type";
                ddl_Category.DataValueField = "Item_Type_Id";
                ddl_Category.DataSource = dt;
                ddl_Category.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {

                con.Close();
            }

        }
        catch (Exception ex)
        {
        }
    } 
    protected void ddl_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubCategory();
    }


    protected void bindSubdepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select SubDept_Id,SubDept_Name From SubDepartment Where SubDept_Name like  @SubDept_Name  Order By SubDept_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%") };
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddlSubDepartment.DataTextField = "SubDept_Name";
        ddlSubDepartment.DataValueField = "SubDept_Id";
        ddlSubDepartment.DataBind();

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
        using (SqlConnection connection = new SqlConnection(conString))
        {
            SqlCommand command = new SqlCommand("usp_GetItemsSearch", connection);
            command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command.Parameters.AddWithValue("@ItemName", txtItemName.Text);
            command.Parameters.AddWithValue("@categoryid", ddl_Category.SelectedValue);
            command.Parameters.AddWithValue("@subcategoryid", ddlSubCategory.SelectedValue);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = "store/Search_itemReport.rdlc";
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
              this.ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }

        }
    }
}