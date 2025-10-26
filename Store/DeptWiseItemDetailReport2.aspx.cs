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

public partial class Store_DeptWiseItemDetailReport2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            txtStartDate.Value = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtEndDate.Value = DateTime.Now.ToString("yyyy-MM-dd");
            bindSubdepartment();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindReport();
    }
    protected void bindSubdepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 SubDept_Id,'------ ALL -----' SubDept_Name union Select SubDept_Id,upper(SubDept_Name) SubDept_Name From SubDepartment Where SubDept_Name like  @SubDept_Name  Order By SubDept_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%")};
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddlSubDepartment.DataTextField = "SubDept_Name";
        ddlSubDepartment.DataValueField = "SubDept_Id";
        ddlSubDepartment.DataBind();
        
    }
    protected void bindReport()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Id", ddlSubDepartment.SelectedValue),
                                    new SqlParameter("@Item_Code", hfItemCode.Value),
                                    new SqlParameter("@StartDate", txtStartDate.Value),
                                    new SqlParameter("@EndDate", txtEndDate.Value)};
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("DeptWise_uspItemLedger_duplicat", "STOREConnectionString", sqlParam);
        ReportDataSource rds = new ReportDataSource();
        rds.Name = "DataSet1";
        rds.Value = dt;
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("DeptWiseItemDetailReport2.rdlc");
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
        cmd.CommandText = "Select Item_Code,Item_Code+' - '+ Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
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