using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.IO;
using System.Text;
using System.Drawing.Printing;
using System.Drawing.Imaging;

public partial class HR_ApplyForStaffLoan : System.Web.UI.Page
{

    string connstr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddl_SubDepartment.DataBind();
            ddlEmployee.DataBind();

            if (Request.QueryString["Type"] != null)
            {
                ddl_SubDepartment.SelectedValue = Session["SubDeptId"].ToString();
                ddlEmployee.DataBind();
                ddlEmployee.SelectedValue = Session["emp_id"].ToString();
                ddl_SubDepartment.Enabled = false;
                ddlEmployee.Enabled = false;
                
            }

            if (Request.QueryString["SubDeptId"] != null)
            {
                ddl_SubDepartment.SelectedValue = Request.QueryString["SubDeptId"].ToString();
                ddlEmployee.DataBind();
                
            }
            if (Request.QueryString["EmpId"] != null)
            {
                ddlEmployee.SelectedValue = Request.QueryString["EmpId"].ToString();
                ddl_SubDepartment.Enabled = false;
                ddlEmployee.Enabled = false;
            }

            AddYears();
            ddlYear.SelectedValue = Convert.ToString(DateTime.Now.Year);
            //ddlEmployee.DataBind();
            //ddlEmployee.Enabled = false;
            displayGrid();
            
            //ddlEmployee.SelectedValue = Session["emp_id"].ToString();
        }
    }

    protected void AddYears()
    {
        int startYear = DateTime.Now.Year;
        for (int y = 0; y < 5; y++)
        {
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(startYear.ToString(), startYear.ToString()));
            startYear++;
        }
    }
    //protected void bindemployee()
    //{
    //    //string str;


    //    SqlConnection con = new SqlConnection(connstr);
    //    SqlCommand cmd = new SqlCommand("getemployee", con);
    //    cmd.Parameters.AddWithValue("@EmpID", hfempid.Value);
    //    cmd.CommandType = CommandType.StoredProcedure;
    //    SqlDataAdapter da = new SqlDataAdapter(cmd);
    //    DataTable dt = new DataTable();
    //    da.Fill(dt);
    //    ddlEmployee.DataSource = dt;
    //    //ddlEmployee.DataBind();
    //    ddlEmployee.DataTextField = "Name";
    //    ddlEmployee.DataValueField = "EmpID";
    //    ddlEmployee.DataBind();

    //}
    private void displayGrid()
    {
        DataTable ds = new DataTable();
        using (SqlConnection con = new SqlConnection(connstr))
        {

            using (SqlCommand cmd = new SqlCommand("usp_GetAllEmployeeLoanRequests", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                   
                        cmd.Parameters.AddWithValue("@LoanEmpId", ddlEmployee.SelectedValue);

                    da.Fill(ds);
                }
            }
        }
        gvList.DataSource = ds;

        gvList.DataBind();

    }

    protected void lnkdelete_Click(object sender, EventArgs e)
    {
        lblSaveMessage.Text = "";
        LinkButton btn = sender as LinkButton;
        using (SqlConnection con = new SqlConnection(connstr))
        {
            con.Open();

            using (SqlCommand cmd = new SqlCommand("deleteEmployeeLoanRequests", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@LoanId", btn.CommandName);
                cmd.Parameters.Add("@status", SqlDbType.Char, 500);
                cmd.Parameters["@status"].Direction = ParameterDirection.Output;


                //("delete from EmployeeLoanRequests where LoanId=" + btn.CommandName + " ", con))

                cmd.ExecuteNonQuery();
                con.Close();

                lblSaveMessage.Text = cmd.Parameters["@status"].Value.ToString();
            }
                
        }

        displayGrid();

    }


    private void clearData()
    {
        txtLoanAmount.Text = "0";
        txtInstallmentAmount.Text = "0";
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        lblSaveMessage.Text = "";
        bool check = false;
        int loanID = 0;
        SqlConnection conn = new SqlConnection(connstr);
        try
        {
            
            using (SqlCommand cmd = new SqlCommand("usp_InsertEmployeeLoanRequest", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@LoanEmpId", ddlEmployee.SelectedValue);
                cmd.Parameters.AddWithValue("@LoanAmount", txtLoanAmount.Text.Trim());
                cmd.Parameters.AddWithValue("@SurityEmpId", ddlSurityEmployee.SelectedValue);
                cmd.Parameters.AddWithValue("@Installment", txtInstallmentAmount.Text.Trim());
                cmd.Parameters.AddWithValue("@RequestedMonth", ddlMonth.SelectedValue);
                cmd.Parameters.AddWithValue("@RequestedYear", ddlYear.SelectedValue);
                cmd.Parameters.AddWithValue("@SubdeptId", Session["SubDeptId"]);
                cmd.Parameters.AddWithValue("@ApplyBy", Session["emp_id"]);

                //cmd.Parameters.Add("@Check", SqlDbType.Bit);
                //cmd.Parameters["@Check"].Direction = ParameterDirection.Output;

                //cmd.Parameters.Add("@LoanId", SqlDbType.Int, 10);
                //cmd.Parameters["@LoanId"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@statuss", SqlDbType.VarChar, 500);
                cmd.Parameters["@statuss"].Direction = ParameterDirection.Output;
                conn.Open();
                cmd.ExecuteNonQuery();
                lblSaveMessage.Text = cmd.Parameters["@statuss"].Value.ToString();
                //  check = Convert.ToBoolean(cmd.Parameters["@Check"].Value);
                //  loanID = Convert.ToInt32(cmd.Parameters["@LoanId"].Value);

            }

            //DbManager manager = new DbManager();


            //SqlParameter[] par = {
            //new SqlParameter("@LoanID",loanID),
            //new SqlParameter("@ApporvedId",Session["emp_id"]),
            //new SqlParameter("@ApprvedEmpId",Session["emp_id"]),
            //new SqlParameter("@EmpId", "0"),
            //new SqlParameter("@Installment",txtInstallmentAmount.Text.Trim()),
            //new SqlParameter("@Amount",txtLoanAmount.Text.Trim()),
            //new SqlParameter("@Month",ddlMonth.SelectedValue),
            //new SqlParameter("@Year",ddlYear.SelectedValue),
            //new SqlParameter("@DeptId",Session["dept_id"]),            
            //new SqlParameter("@Status","Pending")

            //};
            //manager.ExecuteNonQuery("EmployeeLoanRequests_ChangeStatus", "HRConnectionString", par);
        }
        catch (Exception ex)
        {
            Response.Write(ex);
            lblSaveMessage.ForeColor = System.Drawing.Color.Red;
            lblSaveMessage.Text = "Some Error Occured";

        }

        finally
        {
            conn.Close();
            displayGrid();
        }
        //if (check == true)
        //{
        //    InitiateApprovalProcess(loanID);
        //    lblSaveMessage.ForeColor = System.Drawing.Color.Green;
        //    lblSaveMessage.Text = "Request Saved Successfully";
        //    clearData();
        //    displayGrid();
        //}
        //else
        //{
        //    lblSaveMessage.ForeColor = System.Drawing.Color.Red;
        //    lblSaveMessage.Text = "No Approval Authority is Defined for the Department of Employee Belongs To . . .";
        //}

    }

    //private void InitiateApprovalProcess(int loanID)
    //{
    //    SqlConnection con = new SqlConnection(connstr);
    //    try
    //    {
    //        SqlCommand cmd = new SqlCommand("uspInsertEmployeeLogInfoForLoan", con);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.AddWithValue("@empid", ddlEmployee.SelectedValue);
    //        cmd.Parameters.AddWithValue("@senderDeptID", Session["SubDeptId"]);
    //        cmd.Parameters.AddWithValue("@senderID", Session["emp_id"]);
    //        cmd.Parameters.AddWithValue("@SenderDesgid", Session["DesignationID"]);
    //        cmd.Parameters.AddWithValue("@EmpLoanID", loanID);
    //        cmd.Parameters.Add("@status", SqlDbType.Int, 5);
    //        cmd.Parameters["@status"].Direction = ParameterDirection.Output;
    //        con.Open();
    //        cmd.ExecuteNonQuery();

    //        //int Status = (int)cmd.Parameters["@status"].Value;
    //        //    if (Status == 1)
    //        //    {
    //        //        lblMessage.Text = "Request is Initiated . . .";
    //        //        lblMessage.ForeColor = System.Drawing.Color.Green;
    //        //        LoadData();
    //        //    }
    //        //    else
    //        //    {
    //        //        lblMessage.ForeColor = System.Drawing.Color.Red;
    //        //        lblMessage.Text = "No Approval Authority is Defined for the Department of Employee Belongs To . . . ";
    //        //    }


    //    }
    //    catch (Exception ex)
    //    {
    //        Response.Write(ex.Message);
    //    }
    //    finally
    //    {
    //        con.Close();
    //    }

    //}

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblSaveMessage.Text = "";
        displayGrid();
    }
}