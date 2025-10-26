using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Patient_Billing_Patient_Search_Discount_After_Bill : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            txtfromdate.Text = DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd");
            txttodate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            FillGrid();
        }
    }
    protected void FillGrid()
    {
        using (SqlConnection con = new SqlConnection(RegconString))
        {
            try
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("Search_for_Discount", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Convert date safely
                    DateTime sDate = DateTime.TryParse(txtfromdate.Text, out sDate) ? sDate : DateTime.MinValue;
                    DateTime eDate = DateTime.TryParse(txttodate.Text, out eDate) ? eDate : DateTime.MaxValue;

                    // Add parameters
                    cmd.Parameters.AddWithValue("@RegDateFrom", sDate);
                    cmd.Parameters.AddWithValue("@RegDateTo", eDate);
                    cmd.Parameters.AddWithValue("@VisitNo", string.IsNullOrWhiteSpace(TextBoxYearlyNo.Text) ? 0 : Convert.ToInt32(TextBoxYearlyNo.Text));
                    cmd.Parameters.AddWithValue("@RegNo", TextBoxRegNo.Text.Trim());
                    cmd.Parameters.AddWithValue("@CNIC", txtcnic.Text.Trim());
                    cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

                    // Fill DataTable
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt1 = new DataTable();
                    da.Fill(dt1);

                    if (dt1.Rows.Count > 0)
                    {
                        GridView1.DataSource = dt1;
                        GridView1.DataBind();

                        ViewState["GridData"] = dt1;
                    }
                    else
                    {
                        lblError.Text = "No records found!";
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }
        }
    }
    protected void btn_Ledger_Click(object sender, EventArgs e)
    {
        FillGrid();
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (ViewState["GridData"] != null)
        {
            DataTable dt = (DataTable)ViewState["GridData"];
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    protected void lnk_Discount_Click(object sender, EventArgs e)
    {
        LinkButton lnkButton = (LinkButton)sender; 
        string regNo = lnkButton.CommandArgument;  
        string visitNo = lnkButton.ToolTip;       

        // Redirect with regno and visitNo as parameters
        Response.Redirect("../Patient%20Billing/Patient_Search_Discount_New.aspx?regno=" + regNo + "&payid=" + visitNo);
    }
}