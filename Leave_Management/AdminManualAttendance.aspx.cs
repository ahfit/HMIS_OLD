
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Leave_Management_AdminManualAttendance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            WebDateChooser_Date.Value = System.DateTime.Now.Date;
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("Date",Convert.ToDateTime(WebDateChooser_Date.Value)),
                                  new SqlParameter("Dept_Id",DDL_Branch.SelectedValue),
                                  new SqlParameter("SubDept_id",DDL_SubDepartment.SelectedValue),
                                 };
            DataTable dt = dbMgr.ExecuteDataTable("usp_GetAttendanceForModification", "Basic_Data_ConnectionString", para);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            foreach (GridViewRow row in GridView1.Rows)
            {
                TextBox txtTimeIn = (TextBox)row.FindControl("txtTimeIn");
                TextBox txtTimeOut = (TextBox)row.FindControl("txtTimeOut");
                if (txtTimeIn.Text.Trim() != "")
                    txtTimeIn.Text = DateTime.Parse(txtTimeIn.Text.ToString()).TimeOfDay.ToString();
                if (txtTimeOut.Text.Trim() != "")
                    txtTimeOut.Text = DateTime.Parse(txtTimeOut.Text.ToString()).TimeOfDay.ToString();
            }

        }
        catch (Exception)
        {

        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chkatt = (CheckBox)row.FindControl("chkatt");
                if (chkatt.Checked == true)
                {
                    TextBox txtTimeIn = (TextBox)row.FindControl("txtTimeIn");
                    TextBox txtTimeOut = (TextBox)row.FindControl("txtTimeOut");
                    TextBox txtComment = (TextBox)row.FindControl("txtComment");
                    Label lblDate = (Label)row.FindControl("lblDate");
                   
                    DateTime? TimeOut =null, TimeIn = null;
                    if (txtTimeIn.Text!="")
                    {
                         TimeIn = Convert.ToDateTime(lblDate.Text) + TimeSpan.Parse(txtTimeIn.Text);   
                    }
                    if (txtTimeOut.Text != "")
                    {
                         TimeOut = Convert.ToDateTime(lblDate.Text) + TimeSpan.Parse(txtTimeOut.Text);
                    }
                    if (txtTimeIn.Text != "" || txtTimeOut.Text != "")
                    {

                        DbManager dbMgr = new DbManager();
                        SqlParameter[] para = { new SqlParameter("Emp_Id",lblDate.ToolTip), new SqlParameter("Comments",txtComment.Text),
                                      new SqlParameter("att_Id",chkatt.ToolTip), new SqlParameter("forday",lblDate.Text),
                                  new SqlParameter("Time_In",TimeIn), new SqlParameter("Time_out",TimeOut)};
                        dbMgr.ExecuteNonQuery("usp_updateEmployeeTimeInOut", "Basic_Data_ConnectionString", para);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
}