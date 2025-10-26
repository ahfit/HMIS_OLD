using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leave_Management_MyAttendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            datefrom.Text = DateTime.Now.AddDays(-10).ToString("yyyy-MM-dd");
            dateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        loadAttendance();
    }

    protected void lbtnshowPanel_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lbtn.NamingContainer;
        Label lblDate = (Label)row.FindControl("lblDate");
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("Emp_id",lbtn.CommandArgument), new SqlParameter("for_date",lblDate.Text),
                                      new SqlParameter("att_Id",lbtn.ToolTip)};
            DataTable dt = dbMgr.ExecuteDataTable("usp_GetAttendanceForModification", "Basic_Data_ConnectionString", para);
            DateFor.Text = lblDate.Text;//.ToString("yyyy-MM-ddd");
            if (dt.Rows.Count > 0)
            {

                txtTimeIn.Text = DateTime.Parse(dt.Rows[0]["Time_In"].ToString()).TimeOfDay.ToString();
                txtTimeOut.Text = DateTime.Parse(dt.Rows[0]["Time_out"].ToString()).TimeOfDay.ToString();
                TextBox_Remarks.Text = dt.Rows[0]["admin_comment"].ToString();
            }

            Button_SaveRemarks.CommandArgument = lbtn.CommandArgument;
            Button_SaveRemarks.ToolTip = lbtn.ToolTip;
            pnlPopUp.Visible = true;
        }
        catch (Exception ex)
        {

        }

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (Request.QueryString["emp_id"] == "" || Request.QueryString["emp_id"] == null)
        {
            e.Row.Cells[7].Visible = false;
        }

    }
    protected void Button1_Click(object sender, ImageClickEventArgs e)
    {
        pnlPopUp.Visible = false;
        loadAttendance();
        txtTimeIn.Text = "";
        txtTimeOut.Text = "";
        TextBox_Remarks.Text = "";
    }
    protected void Button_SaveRemarks_Click(object sender, EventArgs e)
    {
        try
        {
            DateTime TimeIn = Convert.ToDateTime(DateFor.Text) + TimeSpan.Parse(txtTimeIn.Text);
            DateTime TimeOut = Convert.ToDateTime(DateFor.Text) + TimeSpan.Parse(txtTimeOut.Text);
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("Emp_Id",Button_SaveRemarks.CommandArgument), new SqlParameter("Comments",TextBox_Remarks.Text),
                                      new SqlParameter("att_Id",Button_SaveRemarks.ToolTip), new SqlParameter("forday",DateFor.Text),
                                  new SqlParameter("Time_In",TimeIn), new SqlParameter("Time_out",TimeOut)};
            dbMgr.ExecuteNonQuery("usp_updateEmployeeTimeInOut", "Basic_Data_ConnectionString", para);
        }
        catch (Exception ex)
        {

        }
    }
    private void loadAttendance()
    {
        try
        {
            string emp_id = "0";
            if (Request.QueryString["emp_id"] != "" && Request.QueryString["emp_id"] != null)
            {
                emp_id = Request.QueryString["emp_id"].ToString();
            }
            else
            {
                emp_id = Session["emp_id"].ToString();
            }
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("DateFrom",datefrom.Text),
                                  new SqlParameter("DateTo",dateTo.Text),
                                  new SqlParameter("EmpID", emp_id),
                                  new SqlParameter("Dept_ID", "0"),
                                  new SqlParameter("Hospital_ID", "0"),
                                  new SqlParameter("E_status", "0"),
                                  new SqlParameter("EmpNo", "0"),};
            DataTable dt = dbMgr.ExecuteDataTable("uspEmployeeAttendanceSummary", "Basic_Data_ConnectionString", para);
            GridView1.DataSource = dt;
            GridView1.DataBind();


        }
        catch (Exception ex)
        {


        }
    }
}