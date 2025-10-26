//using System;
using System.Collections.Generic;

using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System;
using System.Drawing;

public partial class Leave_Management_Leave_Opening_Balance : System.Web.UI.Page
{

    SqlConnection con = null;
    public Leave_Management_Leave_Opening_Balance()
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
            WDC_OpeningDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            HiddenField_OpeningDate.Value = WDC_OpeningDate.Text.ToString();
            txtWithoutCashLeaves.Text = "0";
            
            for (int i = 0; i < 50; i++)
            {
                DDLyearBalance.Items.Insert(i, Convert.ToString(2000 + i));
            }
            DDLyearBalance.SelectedValue = Convert.ToString(DateTime.Now.Year);
            DropDownList_LeaveType.DataBind();
            DDL_Campus.DataBind();
            Dropdownlistdepartment.DataBind();
            DropDownList_SubDepartment.DataBind();
            DropDownListEmployee.DataBind();
            


            if (Request.QueryString["Dept"] != null)
            {
                Dropdownlistdepartment.SelectedValue = Request.QueryString["Dept"].ToString();
                DropDownList_SubDepartment.DataBind();
            }
            if (Request.QueryString["SubDept"] != null)
            {
                DropDownList_SubDepartment.SelectedValue = Request.QueryString["SubDept"].ToString();
                DropDownListEmployee.DataBind();
            }
            if (Request.QueryString["EmpId"] != null)
            {
                DropDownListEmployee.SelectedValue = Request.QueryString["EmpId"].ToString();
            }
            if (Request.QueryString["LeaveType"] != null)
            {
                DropDownList_LeaveType.SelectedValue = Request.QueryString["LeaveType"].ToString();
            }
            grdOpeningBalanace.DataBind();
        }
        
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            HiddenField_OpeningDate.Value = WDC_OpeningDate.Text.ToString();
            SaveOpeningBalance();
            grdOpeningBalanace.DataBind();
            EnableAllControls();
            //lblMsg.Text = "Save successfully!";
            //lblMsg.ForeColor = Color.Green;

        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
        
        
    }

    private void SaveOpeningBalance()
    {
        try
        {
            Open();

            SqlCommand cmd = new SqlCommand("sp_InsertLeaveOpeningBalance", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@id", HiddenField_ID.Value);
            cmd.Parameters.AddWithValue("@Emp_id", DropDownListEmployee.SelectedValue);
            cmd.Parameters.AddWithValue("@Leave_detail_type_id", DropDownList_LeaveType.SelectedValue);
            cmd.Parameters.AddWithValue("@Leave_Balance_Date", WDC_OpeningDate.Text);
            cmd.Parameters.AddWithValue("@Leaves", txtLeaveBalance.Text.Trim());
            cmd.Parameters.AddWithValue("@Without_Cash_Leave", txtWithoutCashLeaves.Text.Trim());
            cmd.Parameters.AddWithValue("@SubDeptID", DropDownList_SubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@Dept_id", Dropdownlistdepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@yearBalance", DDLyearBalance.Text);
            cmd.Parameters.AddWithValue("@CreatedBy",Session["emp_id"].ToString());
            cmd.Parameters.Add("@Remarks", System.Data.SqlDbType.VarChar, 50);
            cmd.Parameters["@Remarks"].Direction = System.Data.ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            lblMsg.Text = cmd.Parameters["@Remarks"].Value.ToString();
            cmd.Dispose();
            
            HiddenField_ID.Value = "-1";
        }
        catch (Exception)
        {
            lblMsg.Text = "Insertion fail";
            return;
        }
        finally
        {
            Close();
        }
    }

    protected void Update_Record_Click(object sender, EventArgs e)
    {
        
        
    }



    public DataTable GetRecord(string id)
    {
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("sp_SpecificOpeningRecord", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);

            da.SelectCommand = cmd;
            da.Fill(dt);
            cmd.Dispose();
        }
        catch (Exception ex)
        {
            dt = null;
            Response.Write(ex.Message);
        }
        finally
        {
            Close();
        }

        return dt;
    }

    protected void DropDownListEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_LeaveType.DataBind();
        grdOpeningBalanace.DataBind();
    }
    protected void Dropdownlistdepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_LeaveType.DataBind();
        DropDownList_SubDepartment.DataBind();
        DropDownListEmployee.DataBind();
        grdOpeningBalanace.DataBind();
    }
    protected void DDL_Campus_SelectedIndexChanged(object sender, EventArgs e)
    {
        Dropdownlistdepartment.DataBind();
        DropDownList_SubDepartment.DataBind();
        DropDownListEmployee.DataBind();
        DropDownList_LeaveType.DataBind();
        grdOpeningBalanace.DataBind();
    }
    protected void DropDownList_SubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListEmployee.DataBind();
        grdOpeningBalanace.DataBind();

    }
    protected void Delete_Click(object sender, EventArgs e)
    {
        LinkButton lik = (LinkButton)sender;
        string id = lik.CommandArgument;
       DeleteRecord(id);
       grdOpeningBalanace.DataBind();

    }
    public void DeleteRecord(string id)
    {

        try
        {
            Open();
            SqlCommand cmd = new SqlCommand("sp_DeleteOpeningRecord", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@id", id);

            cmd.ExecuteNonQuery();
            cmd.Dispose();
        }
        catch (Exception)
        {
           
        }
        finally
        {
            Close();
        }

       
    }

    protected void lnk_UpdateRecord_Click(object sender, EventArgs e)
    {
        LinkButton lik = (LinkButton)sender;
        string id = lik.CommandArgument;
        DataTable dt = GetRecord(id);
        HiddenField_ID.Value = id;
        Dropdownlistdepartment.SelectedValue = dt.Rows[0]["dept_id"].ToString();
        //DropDownList_SubDepartment.DataBind();
        DropDownList_SubDepartment.SelectedValue = dt.Rows[0]["SubDeptID"].ToString();
        //DropDownListEmployee.DataBind();
        //DropDownListEmployee.SelectedValue = dt.Rows[0]["Emp_id"].ToString();
        DropDownList_LeaveType.SelectedValue = dt.Rows[0]["Leave_detail_type_id"].ToString();
        WDC_OpeningDate.Text = dt.Rows[0]["Leave_Balance_Date"].ToString();
        txtLeaveBalance.Text = dt.Rows[0]["Leaves"].ToString();
        txtWithoutCashLeaves.Text = dt.Rows[0]["Without_Cash_Leave"].ToString();
        DDLyearBalance.SelectedValue = dt.Rows[0]["Balance_Year"].ToString();
      
        DisableAllControls();
        

    }

    private void DisableAllControls()
    {
        btnSave.Text = "Update";

        DDL_Campus.Enabled = false;
        Dropdownlistdepartment.Enabled = false;
        DropDownList_SubDepartment.Enabled = false;
        DropDownListEmployee.Enabled = false;
        DropDownList_LeaveType.Enabled = false;
        DDLyearBalance.Enabled = false;
        
    }
    private void EnableAllControls()
    {
        btnSave.Text = "Save";

        DDL_Campus.Enabled = true;
        Dropdownlistdepartment.Enabled = true;
        DropDownList_SubDepartment.Enabled = true;
        DropDownListEmployee.Enabled = true;
        DropDownList_LeaveType.Enabled = true;
        DDLyearBalance.Enabled = true;

    }
}
