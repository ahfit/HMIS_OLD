using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leave_Management_EmployeeReportingTo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        fillGridview();
    }
    private void fillGridview()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] param = { new SqlParameter("emp_id", Session["emp_id"]) };
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("SP_EmployeeReporting", "Leave_ManagementConnectionString", param);
        GridView1.DataSource = dt;
        GridView1.DataBind();

    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void lbViewAttedance_Click(object sender, EventArgs e)
    {
        //LinkButton lb=(LinkButton)sender;
        int Id = Convert.ToInt32((sender as LinkButton).CommandArgument);
        Response.Redirect("MyAttendance.aspx?emp_id=" + Id);

    }

    protected void lbtnLeaveSummary_Click(object sender, EventArgs e)
    {
        //LinkButton lb=(LinkButton)sender;
        int Id = Convert.ToInt32((sender as LinkButton).CommandArgument);
        Response.Redirect("~/Machine_Attendance/Leaves_Report.aspx?emp_id=" + Id);

    }
}