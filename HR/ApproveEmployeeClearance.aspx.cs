using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class HR_ApproveEmployeeClearance : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["empid"] != null)
        {
            HfEmpId.Value = Request.QueryString["empid"].ToString();
        }
        if (Request.QueryString["clearanceId"] != null)
        {
            HfClearanceId.Value = Request.QueryString["clearanceId"].ToString();
        }
        if (!IsPostBack)
        {
            
            GridView6.DataBind();
        }
    }


    protected void btnAddRemarks_Click(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (txtRemarks.Text.Trim() != "")
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"Usp_ApproveEmployeeClearance";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ClearanceId", HfClearanceId.Value);
                    cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubDeptId", Session["SubDeptID"]);
                    cmd.Parameters.AddWithValue("@ApprovedBy", Session["emp_id"]);
                    cmd.Parameters.AddWithValue("@Type", "Remarks");
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Remarks Added.....";
            clearFields();
            dlRemarks.DataBind();
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Enter Remarks First.....";
        }

    }

    private void clearFields()
    {
        txtRemarks.Text = "";
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        lblMsg.Visible = false;
        if (txtRemarks.Text.Trim() != "")
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString()))
            {
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = conn;
                    cmd.CommandText = @"Usp_ApproveEmployeeClearance";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ClearanceId", HfClearanceId.Value);
                    cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
                    cmd.Parameters.AddWithValue("@SubDeptId", Session["SubDeptID"]);
                    cmd.Parameters.AddWithValue("@ApprovedBy", Session["emp_id"]);
                    cmd.Parameters.AddWithValue("@Type", "Approve");
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Request Approved.....";
            clearFields();
            GridView6.DataBind();
            dlRemarks.DataBind();
        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "Enter Remarks First.....";
        }

    }

    protected void GridView6_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)

        {
            Label lblstatus = e.Row.FindControl("lblStatus") as Label;
            //HiddenField hfcolor = e.Row.FindControl("hfcolor") as HiddenField;
            if (lblstatus.Text == "Pending")
            {
                lblstatus.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                lblstatus.ForeColor = System.Drawing.Color.Green;
            }
           
        }

    }
}