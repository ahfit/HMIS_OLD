using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Leave_Management_AllEmployeeOpeningBalance : System.Web.UI.Page
{
    SqlConnection con = null;
    public Leave_Management_AllEmployeeOpeningBalance()
    {
        con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ConnectionString);
    }

    private void Open()
    {
        if (con != null)
            con.Open();
        else
        {
            con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Leave_ManagementConnectionString"].ConnectionString);
        }
    }

    private void Close()
    {
        if (con != null && con.State == ConnectionState.Open)
            con.Close();
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            WDC_OpeningDate.Value = DateTime.Now;
            HiddenField_OpeningDate.Value = WDC_OpeningDate.Value.ToString();
            txtWithoutCashLeaves.Text = "0";

            for (int i = 0; i < 50; i++)
            {
                DDLyearBalance.Items.Insert(i, Convert.ToString(2000 + i));
            }
            DDLyearBalance.SelectedValue = Convert.ToString(DateTime.Now.Year);
            DDL_Campus.DataBind();
            Dropdownlistdepartment.DataBind();
            DropDownList_SubDepartment.DataBind();
            grdOpeningBalanace.DataBind();
        }

    }
    protected void btnSelectAllEmployee_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < CheckBoxList_Employee.Items.Count; i++)
        {
            CheckBoxList_Employee.Items[i].Selected = true;
        }
    }
    protected void UpdateRecord_Click(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            Save(); 
            lblMsg.Text = "Save successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            grdOpeningBalanace.DataBind();
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Failed to Save!";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            Response.Write(ex.Message);
        }
    }

    protected void DDL_Campus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Dropdownlistdepartment.DataBind();
        DropDownList_SubDepartment.DataBind();
        DropDownList_LeaveType.DataBind();
        grdOpeningBalanace.DataBind();
    }
    private void Save() 
    {
        string empIDs = string.Empty;
        foreach (ListItem item in CheckBoxList_Employee.Items)
        {
            if (item.Selected==true)
            {
                empIDs += item.Value + ',';
            }
        }
        
        empIDs.TrimEnd(',');
        Open();

            SqlCommand cmd = new SqlCommand("usp_CreateEmployeeOpening", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@EmployeeIDs",empIDs);
            cmd.Parameters.AddWithValue("@LeaveDetailTypeId", DropDownList_LeaveType.SelectedValue);
            cmd.Parameters.AddWithValue("@OpeningDate", WDC_OpeningDate.Value);
            cmd.Parameters.AddWithValue("@LeaveBalance", txtLeaveBalance.Text.Trim());
            cmd.Parameters.AddWithValue("@WithoutCashLeaves", txtWithoutCashLeaves.Text.Trim());
            cmd.Parameters.AddWithValue("@SubDept_Id", DropDownList_SubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@DeptID", Dropdownlistdepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@BalanceYear", DDLyearBalance.Text);
            cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
            cmd.ExecuteNonQuery();

            cmd.Dispose();
            Close();
            
    }
}