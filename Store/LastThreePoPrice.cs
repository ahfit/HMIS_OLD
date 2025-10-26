using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_LastThreePoPrice : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
          //  bindSubdepartment();
            txtStartDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
          //  ddlSubDepartment.SelectedValue = Session["SubDeptID"].ToString();
           // bind_Manufacturer();
           // bind_Categories();
        }
    }
    //protected void bind_Categories()
    //{
    //    SqlCommand cmd;
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(conStr);
    //        string query = "SELECT    0 Item_Type_Id, '----- ALL -----' Item_Type union SELECT     Item_Type_Id, Item_Type  FROM   Store_Item_Types order by Item_Type ";
    //        cmd = new SqlCommand(query, con);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        ddl_Category.DataSource = dt;
    //        ddl_Category.DataTextField = "Item_Type";
    //        ddl_Category.DataValueField = "Item_Type_Id";
    //        ddl_Category.DataBind();

    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindReport();
    }
    //protected void bindSubdepartment()
    //{
    //    DbManager dbMgr = new DbManager();
    //    String query = "Select SubDept_Id,SubDept_Name From SubDepartment Where SubDept_Name like  @SubDept_Name  Order By SubDept_Name";
    //    SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%") };
    //    ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
    //    ddlSubDepartment.DataTextField = "SubDept_Name";
    //    ddlSubDepartment.DataValueField = "SubDept_Id";
    //    ddlSubDepartment.DataBind();

    //}
    //protected void bind_Manufacturer()
    //{
    //    SqlCommand cmd;
    //    try
    //    {
    //        SqlConnection con = new SqlConnection(conStr);
    //        string query = "select '--ALL--' as Manufacturer_Name,0 as ID union select Manufacturer_Name,Manufacturer_Id ID from Items_Manufacturer";
    //        cmd = new SqlCommand(query, con);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataTable dt = new DataTable();
    //        da.Fill(dt);
    //        DropDownList_Manufacturer.DataSource = dt;
    //        DropDownList_Manufacturer.DataBind();
    //    }
    //    catch (Exception ex)
    //    {
    //    }
    //}
    protected void bindReport()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = { new SqlParameter("@StartDate", txtStartDate.Text),
                                    new SqlParameter("@EndDate", txtEndDate.Text),                                   
                                    new SqlParameter("@Item_Name", txtItemName.Text)  };
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("uspGetLastThreePOPrices", "STOREConnectionString", sqlParam);
        ReportDataSource rds = new ReportDataSource();

       
        rds.Name = "DataSet1";
        rds.Value = dt; 
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("LastThreePoPrice.rdlc");
        ReportViewer1.LocalReport.DataSources.Add(rds);
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
        ReportViewer1.LocalReport.Refresh();
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
}