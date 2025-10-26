using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Pharmacy_Dead_Item_for_Pharamacist : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            bindSubdepartment();
        }

    }

    protected void bindSubdepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 SubDept_Id,'------ ALL -----' SubDept_Name union Select SubDept_Id,SubDept_Name From SubDepartment  Order By SubDept_Name";
      
        ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery_WithOutParm(query, "STOREConnectionString");
        ddlSubDepartment.DataTextField = "SubDept_Name";
        ddlSubDepartment.DataValueField = "SubDept_Id";
        ddlSubDepartment.DataBind();


    }
    protected void ExportToExcel(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=DeadItem.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            GridAdminService.AllowPaging = false;
            this.bindGrid();

            GridAdminService.DataBind();

            GridAdminService.HeaderRow.BackColor = System.Drawing.Color.White;
            foreach (TableCell cell in GridAdminService.HeaderRow.Cells)
            {
                cell.BackColor = GridAdminService.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in GridAdminService.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = GridAdminService.AlternatingRowStyle.BackColor;
                    }
                    else
                    {
                        cell.BackColor = GridAdminService.RowStyle.BackColor;
                    }
                    cell.CssClass = "textmode";
                }
            }

            GridAdminService.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();
      
    }

    private void bindGrid()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Id", ddlSubDepartment.SelectedValue),

                                    new SqlParameter("@StartDate", txtStartDate.Text),
                                    new SqlParameter("@EndDate", txtEndDate.Text)};
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("PharmacyDead_Item_for_Pharamacist", "STOREConnectionString", sqlParam);
        GridAdminService.DataSource = dt;
        GridAdminService.DataBind();
    }
    protected void GridAdminService_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridAdminService.PageIndex = e.NewPageIndex;
        bindGrid(); 
    }

}