using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
public partial class Finance_Department_Budget : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindDepartment();
            bindHeadLabels();
        }
    }
    protected void bindDepartment()
    {
        DbManager dbMgr = new DbManager();
        String str = "Select SubDept_Id,SubDept_Name From SubDepartment Where SubDept_Name like '%'+@SubDept_Name+'%' Order By SubDept_Name";
        SqlParameter[] sqlParm = { new SqlParameter("@SubDept_Name", "%") };
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(str, "Finance_ConnectionString", sqlParm);
        ddlSubDepartment.DataBind();
    }
    protected void bindHeadLabels()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@BD_ID", Request.QueryString["BD_ID"]) };
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("uspGetBudgetDetailhead", "Finance_ConnectionString", sqlParm);
        if (dt.Rows.Count > 0)
        {
            lblHeadName.Text = dt.Rows[0]["E_Name"].ToString();
            lblTotalAmount.Text = Convert.ToDouble(dt.Rows[0]["Revise_Amount"].ToString()).ToString("0,00,00");
            lblMonthlyLimit.Text = Convert.ToDouble(dt.Rows[0]["MonthlyLimit"].ToString()).ToString("0,00,00");
            bindGrid();
            
        }
    }
    protected void bindGrid()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@BD_ID", Request.QueryString["BD_ID"]) };
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("uspGetBudgetDepartmentalDetail", "Finance_ConnectionString", sqlParm);
        gvDetail.DataSource = dt;
        gvDetail.DataBind();
        if (gvDetail.Rows.Count > 0)
        {
            
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParm = { new SqlParameter("@BD_ID", Request.QueryString["BD_ID"]),
                                   new SqlParameter("@SubDept_Id", ddlSubDepartment.SelectedValue),
                                   new SqlParameter("@MonthlyLimit", txtMonthlyLimit.Text),
                                   new SqlParameter("@YearlyLimit", txtYearlyLimit.Text),
                                   new SqlParameter("@EntryBy", Session["emp_Id"]),
                                   new SqlParameter("@Desription", txtDescription.Text)};
            dbMgr.ExecuteNonQuery("uspInsertDepartmentalBudgetDetail", "Finance_connectionString", sqlParm);
            bindGrid();
        }
        catch (Exception ex)
        {

        }
    }
    protected void gvDetail_PreRender(object sender, EventArgs e)
    {
        double amount = 0;
        if (gvDetail.Rows.Count > 0)
        {
            foreach (GridViewRow gvRow in gvDetail.Rows)
            {
                amount = amount + Convert.ToDouble((gvRow.FindControl("lblYearlyLimit") as Label).Text);
            }
            (gvDetail.FooterRow.FindControl("lblTotalDeptBudget") as Label).Text = amount.ToString("0,00,00");

            lblRemaningAmount.Text = (Convert.ToDouble(lblTotalAmount.Text) - amount).ToString("0,00,00");
        }
    }
}
