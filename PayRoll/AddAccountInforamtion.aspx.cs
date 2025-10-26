using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class PayRoll_AddAccountInforamtion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadBank();
            LoadDepartment();
        }
    }

    private void LoadDepartment()
    {

        DbManager manager = new DbManager();
        DDLDept.DataSource = manager.ExecuteDataTableWithQuery("SELECT  Dept_ID, Dept_Name FROM   Department order by Dept_Name", "Basic_Data_ConnectionString", new System.Data.SqlClient.SqlParameter[] { });
        DDLDept.DataTextField = "Dept_Name";
        DDLDept.DataValueField = "Dept_ID";
        DDLDept.DataBind();



    }
    private void LoadSubDepartment()
    {

        DbManager manager = new DbManager();
        DDLSubDept.DataSource = manager.ExecuteDataTableWithQuery("SELECT SubDept_Name, SubDept_Id FROM SubDepartment where Dept_Id=@DeptId  order By SubDept_Name", "Basic_Data_ConnectionString", new System.Data.SqlClient.SqlParameter[] { new SqlParameter("@DeptId", DDLDept.SelectedValue) });
        DDLSubDept.DataTextField = "SubDept_Name";
        DDLSubDept.DataValueField = "SubDept_Id";
        DDLSubDept.DataBind();



    }

    private void LoadBank()
    {

        DbManager manager = new DbManager();
        ddlBankName.DataSource = manager.ExecuteDataTableWithQuery("select Bank_ID,Bank_Name from bank", "Finance_ConnectionString", new System.Data.SqlClient.SqlParameter[] { });
        ddlBankName.DataTextField = "Bank_Name";
        ddlBankName.DataValueField = "Bank_ID";
        ddlBankName.DataBind();



    }

    private void InsertBankDetail()
    {
        lblMsg.Text = "";
        if (ddlEmployee.SelectedValue != "0")
        {
            try
            {
                DbManager manager = new DbManager();
                manager.ExecuteNonQuery("uspInsertBankEmpAccount", "PayRoll_ConnectionString", new SqlParameter[] { new SqlParameter("@Emp_ID", ddlEmployee.SelectedValue), new SqlParameter("@Bank_ID", ddlBankName.SelectedItem.Value),
            new SqlParameter("@Account_Number",txtboxAccount.Text.Trim()     )
            });
                lblMsg.Text = "Account # saved!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                SelectEmployye();
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Some Error Is Occured . . ." + ex.Message;
                lblMsg.ForeColor = System.Drawing.Color.Red;

            }
            finally
            {

            }
        }
        else {
            lblMsg.Text = "Please Select Employee Name";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }

    protected DataTable get_SelectEmployye()
    {
        DataTable dt = new DataTable();
        try
        {
            DbManager manager = new DbManager();
            dt = manager.ExecuteDataTable("uspSelectAccountInformation_am", "PayRoll_ConnectionString", new SqlParameter[] { new SqlParameter("@empid", ddlEmployee.SelectedValue),
                new SqlParameter("@deptid", DDLSubDept.SelectedValue)
            });

        }
        catch (Exception)
        {
            lblMsg.Text = "Some Error Is Occured . . .";
            lblMsg.ForeColor = System.Drawing.Color.Red;

        }
        finally
        {

        }
        return dt;
    }
    private void SelectEmployye()
    {
        DataTable dt = new DataTable();
        dt = get_SelectEmployye();
        gvd.DataSource = dt;
        gvd.DataBind();

    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        InsertBankDetail();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SelectEmployye();
    }

    protected void gvd_Sorting(object sender, GridViewSortEventArgs e)
    {
        DataTable dt = new DataTable();
        dt=get_SelectEmployye();

        if (dt.Rows.Count > 0)
        {
            DataView dataView = new DataView(dt);
            dataView.Sort = e.SortExpression + " " + ConvertSortDirectionToSql(e.SortDirection);

            gvd.DataSource = dataView;
            gvd.DataBind();
        }
    }

    protected void gvd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvd.PageIndex = e.NewPageIndex;
        this.gvd.DataBind();
    }
     private string GridViewSortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "DESC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        switch (GridViewSortDirection)
        {
            case "ASC":
                GridViewSortDirection = "DESC";
                break;

            case "DESC":
                GridViewSortDirection = "ASC";
                break;
        }

        return GridViewSortDirection;
    }
    protected void DDLDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadSubDepartment();
    }
}