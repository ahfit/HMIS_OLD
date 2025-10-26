using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leave_Management_EmployeeLeaves_MainPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        getEmployeeBasicData();
        if (!Page.IsPostBack)
        {
            string url = "~/Leave_Management/Employee_Leaves.aspx?Emp_ID=" + Convert.ToString(Session["emp_id"]) + "&SubDeptId=" + Convert.ToString(Session["SubDeptID"]);
            HYK_LeaveRequest.NavigateUrl = url;
            IMG_leave_Request.PostBackUrl = url;

            url = "~/Machine_Attendance/EmployeeAttendanceSummary.aspx?EmpId=" + Convert.ToString(Session["emp_id"]) + "&SubDeptId=" + Convert.ToString(Session["SubDeptID"]);
            HYK_ViewAttendnace.NavigateUrl = url;
            Img_ViewAttendane.PostBackUrl = url;

            url = "~/Leave_Management/Leave_History_Report.aspx?emp_id=" + Convert.ToString(Session["emp_id"]);
            HYK_LeaveHistory.NavigateUrl = url;
            Img_LeaveHistory.PostBackUrl = url;

            url = "~/Leave_Management/EmployeeLeavesBalanceReport.aspx?emp_id=" + Convert.ToString(Session["emp_id"]) + "&SubDeptId=" + Convert.ToString(Session["SubDeptID"]);
            HYK_LeaveSummary.NavigateUrl = url;
            Img_LeaveSummary.PostBackUrl = url;

            //url = "~/Machine_Attendance/EmplyeeOvertimeRequest.aspx?emp_id=" + Convert.ToString(Session["emp_id"]) + "&SubDeptId=" + Convert.ToString(Session["SubDeptID"]);
            //HYK_ApplyForOverTime.NavigateUrl = url;
            //Img_ApplyForOverTime.PostBackUrl = url;

            //url = "~/Machine_Attendance/EmplyeeMissingAttendanceRequest.aspx?emp_id=" + Convert.ToString(Session["emp_id"]) + "&SubDeptId=" + Convert.ToString(Session["SubDeptID"]);
            //HYK_ApplyForMissingAttendacnce.NavigateUrl = url;
            //Img_ApplyForMissingAttendacnce.PostBackUrl = url;
        }
    }

    protected void OpenURL(string URL)
    {
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + URL + "','_newtab');", true);
    }
    private void getEmployeeBasicData()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = {new SqlParameter("emp_id",Session["emp_id"]) };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("SP_getEmployeeBasicData", "Leave_ManagementConnectionString", para);
            lbl_Code.Text = Convert.ToString(dt.Rows[0]["EmpID"]);
            lbl_Name.Text = Convert.ToString(dt.Rows[0]["Employee_Name"]);
            lbl_FatherName.Text = Convert.ToString(dt.Rows[0]["Relation_Name"]);
            lbl_Designation.Text = Convert.ToString(dt.Rows[0]["Designation_Name"]);
            lbl_Email.Text = Convert.ToString(dt.Rows[0]["email_address"]);
            lbl_Mobile.Text = Convert.ToString(dt.Rows[0]["Mobile_Number"]);
            lblAuthority.Text = Convert.ToString(dt.Rows[0]["Reporting_Authority"]);
            
        }
        catch (Exception ex)
        {
            
            
        }
    }
}