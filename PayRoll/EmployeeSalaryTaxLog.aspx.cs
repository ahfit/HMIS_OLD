using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PayRoll_EmployeeSalaryTaxLog : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DDLMonth.SelectedValue = DateTime.Now.Month.ToString();
            ddlYear.SelectedValue = DateTime.Now.Year.ToString();
            showHistory();
        }
    }

    private void showHistory()
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(conString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_GetSalaryTaxLOGHistory", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@FinancialYearId", ddlFinancialYear.SelectedValue);
                cmd.Parameters.AddWithValue("@EmpId", Request.QueryString["EmpId"]);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
               
            }
        }
        gvdSalaryHistory.DataSource = dt;
        gvdSalaryHistory.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string Status = "";
        using (SqlConnection conn = new SqlConnection(conString))
        {
            using (SqlCommand cmd = new SqlCommand("usp_InsertEmployeeTaxLOGHistory", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpId", Request.QueryString["EmpId"]);
                cmd.Parameters.AddWithValue("@FinancialYearId", ddlFinancialYear.SelectedValue);
                cmd.Parameters.AddWithValue("@Month", DDLMonth.SelectedValue);
                cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@Tax",txtTax.Text.Trim());
                cmd.Parameters.AddWithValue("@Reason",txtReason.Text.Trim());
                cmd.Parameters.AddWithValue("@EnterBy", Session["emp_id"]);
                cmd.Parameters.AddWithValue("@Year", ddlYear.SelectedValue);
                cmd.Parameters.Add("@Status", SqlDbType.VarChar, 50);
                cmd.Parameters["@Status"].Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Status = cmd.Parameters["@Status"].Value.ToString();
                if (Status == "Ok")
                {
                    lblMsg.Text = "Record Save Successfully...";
                    lblMsg.ForeColor = Color.Green;
                    ClearFields();
                    showHistory();
                }
                else if (Status == "Already Exists")
                {
                    lblMsg.Text = "Record Already Exists...";
                    lblMsg.ForeColor = Color.Red;
                }
                else
                {
                    lblMsg.Text = "Some Error Occured...";
                    lblMsg.ForeColor = Color.Red;
                }
            }
        }
               
    }

    private void ClearFields()
    {
        txtSalary.Text = "0";
        txtTax.Text = "0";
        lblMsg.Text = "";
        txtReason.Text = "";
    }

    protected void lnk_Delete_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;

        using (SqlConnection conn = new SqlConnection(conString))
        {
            using (SqlCommand cmd = new SqlCommand("Delete from IncomeTaxLog where Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", lnk.CommandArgument);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        showHistory();
    }

    protected void ddlFinancialYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        showHistory();
    }

    Decimal TotalSalary = 0, TotalTax = 0;
    protected void gvdSalaryHistory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lblSalary = (Label)e.Row.FindControl("lblSalary");
            Label lblTax = (Label)e.Row.FindControl("lblTax");

            TextBox txtSalary = (TextBox)e.Row.FindControl("txtSalary");
            TextBox txtTax = (TextBox)e.Row.FindControl("txtTax");
            try
            {
                if (lblSalary.Text.Trim() != null)
                    TotalSalary += Convert.ToDecimal(lblSalary.Text.Trim());
                if (lblTax.Text.Trim() != null)
                    TotalTax += Convert.ToDecimal(lblTax.Text.Trim());
            }
            catch (Exception ex)
            {
                if (txtSalary.Text.Trim() != null)
                    TotalSalary += Convert.ToDecimal(txtSalary.Text.Trim());
                if (txtTax.Text.Trim() != null)
                    TotalTax += Convert.ToDecimal(txtTax.Text.Trim());
            }

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotalSalary = (Label)e.Row.FindControl("lblTotalSalary");
            Label lblTotalTax = (Label)e.Row.FindControl("lblTotalTax");
            lblTotalSalary.Text = TotalSalary.ToString("#,##0");
            lblTotalTax.Text = TotalTax.ToString("#,##0");
        }
    }

    protected void gvdSalaryHistory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvdSalaryHistory.EditIndex = -1;
        showHistory();
    }

    protected void gvdSalaryHistory_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvdSalaryHistory.EditIndex = e.NewEditIndex;
        showHistory();

    }

    protected void gvdSalaryHistory_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        TextBox txtSalary = (TextBox) gvdSalaryHistory.Rows[e.RowIndex].FindControl("txtSalary");
        TextBox txtTax = (TextBox)gvdSalaryHistory.Rows[e.RowIndex].FindControl("txtTax");
        HiddenField HfId = (HiddenField)gvdSalaryHistory.Rows[e.RowIndex].FindControl("HfLogId");
        using (SqlConnection conn = new SqlConnection(conString))
        {
            using (SqlCommand cmd = new SqlCommand("Update IncomeTaxLog set TaxAmount = @Tax, Income = @Salary where Id = @Id", conn))
            {
                cmd.Parameters.AddWithValue("@Salary", txtSalary.Text.Trim());
                cmd.Parameters.AddWithValue("@Tax", txtTax.Text.Trim());
                cmd.Parameters.AddWithValue("@Id", HfId.Value);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        gvdSalaryHistory.EditIndex = -1;

        showHistory();
    }
}