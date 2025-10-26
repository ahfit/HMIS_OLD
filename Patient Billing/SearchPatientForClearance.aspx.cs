using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_SearchPatientForClearance : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (!Page.IsPostBack)
        {
            
            LoadGridData();

        }
    }

    private void LoadGridData()
    {
        DbManager db = new DbManager();
        SqlParameter[] param =
        {
            new SqlParameter("@SubDeptId",Session["SubDeptId"])
        };
        GridView1.DataSource = db.ExecuteDataTable("uspGetPatientForClearance", "Basic_Data_ConnectionString", param);
        GridView1.DataBind();
    }
    
    protected void btnClear_Clicked(object sender, EventArgs e)
    {
        LinkButton btnTemp = sender as LinkButton;
        DbManager db = new DbManager();
        SqlParameter[] param =
        {
            new SqlParameter("@SubDeptId",Session["SubDeptId"]),
            new SqlParameter("@RegNo",btnTemp.CommandArgument),
            new SqlParameter("@YearlyNo",btnTemp.ToolTip)
        };
        db.ExecuteDataTable("uspMarkPatientCleared", "Basic_Data_ConnectionString", param);
        LoadGridData();
    }





    protected void ddlPatientSubDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadGridData();
    }
}