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

public partial class HR_ApproveStaffLoanRequests : System.Web.UI.Page
{
    string connstr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            AddYears();            
            displayGrid();
            //if(Session["dept_id"].ToString() !="74")
            //{
            //    txtApproveLoanAmount.Enabled = false;
            //    txtApprovedInstallment.Enabled = false;
            //    ddlYear.Enabled = false;
            //    ddlMonth.Enabled = false;
            //}
            
        }
    }

   

    protected void displayGrid()
    {
        using (SqlConnection con = new SqlConnection(connstr))
        {

            using (SqlCommand cmd = new SqlCommand("usp_GetAllEmployeeLoanRequestsForApproval", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ApprovalEmpId", Session["emp_id"]);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds);
                gvList.DataSource = ds;

                gvList.DataBind();
            }
        }

    }

    protected void lnkApprove_Click(object sender, EventArgs e)
    {
        pnl_Approval.Visible = true;

        LinkButton btn = sender as LinkButton;
        HiddenField EmployeeId = (HiddenField)btn.NamingContainer.FindControl("HiddenField_EmpId");
        HiddenField HiddenField_ApporvedId = (HiddenField)btn.NamingContainer.FindControl("HiddenField_ApporvedId");

        Label ApplicationNo = (Label)btn.NamingContainer.FindControl("lblApplicationId");
        HiddenField DateOfJoining = (HiddenField)btn.NamingContainer.FindControl("HfJoinDate");
        Label Employee = (Label)btn.NamingContainer.FindControl("lblEmployee");
        Label LoanAmount = (Label)btn.NamingContainer.FindControl("lblLoanAmount");
        Label lblInstallment = (Label)btn.NamingContainer.FindControl("lblInstallment");
        HiddenField HfRequestedMonth = (HiddenField)btn.NamingContainer.FindControl("HfRequestedMonth");
        HiddenField HfRequestedYear = (HiddenField)btn.NamingContainer.FindControl("HfRequestedYear");
        Label SurityEmployee = (Label)btn.NamingContainer.FindControl("lblSurityEmployee");

        HfEmpId.Value = EmployeeId.Value;
        HFApporvedId.Value = HiddenField_ApporvedId.Value;

        lblApplicationNo.Text= ApplicationNo.Text;

        lblDateOfJoining.Text = DateOfJoining.Value;
        lblEmpName.Text = Employee.Text;
        txtApproveLoanAmount.Text = LoanAmount.Text;
        txtApprovedInstallment.Text = lblInstallment.Text;
        lblSurityEmployee.Text = SurityEmployee.Text;
        ddlMonth.SelectedValue = HfRequestedMonth.Value;
        ddlYear.SelectedValue = HfRequestedYear.Value;



    }

    protected void AddYears()
    {
        int startYear = DateTime.Now.Year;
        for(int y=0;y<5;y++)
        {
            ddlYear.Items.Add(new System.Web.UI.WebControls.ListItem(startYear.ToString(), startYear.ToString()));
            startYear++;
        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnl_Approval.Visible = false;
    }

    protected void btnApprove_Click(object sender, EventArgs e)
    {
        DbManager manager = new DbManager();
        

        SqlParameter[] par = {
        new SqlParameter("@LoanID",lblApplicationNo.Text.Trim()),
        new SqlParameter("@ApporvedId",HFApporvedId.Value),
        new SqlParameter("@ApprvedEmpId",Session["emp_id"]),        
        new SqlParameter("@EmpId", HfEmpId.Value),      
        new SqlParameter("@Installment",txtApprovedInstallment.Text),
        new SqlParameter("@Amount",txtApproveLoanAmount.Text),
        new SqlParameter("@Month",ddlMonth.SelectedValue),
        new SqlParameter("@Year",ddlYear.SelectedValue),
        new SqlParameter("@DeptId",Session["dept_id"]),
        new SqlParameter("@Status",radoApprovalStatus.SelectedItem.Text),
        new SqlParameter("@IsApproved",radoApprovalStatus.SelectedValue)

        };
        manager.ExecuteNonQuery("EmployeeLoanRequests_ChangeStatus", "HRConnectionString", par);

        pnl_Approval.Visible = false;
        displayGrid();

        //       using (SqlConnection con = new SqlConnection(connstr))
        //       {
        //           con.Open();

        //           using (SqlCommand cmd = new SqlCommand(@"UPDATE [dbo].[EmployeeLoanRequests]
        //  SET [ApprovedLoanAmount] = @LoanAmount
        //     ,[ApprovedLoanInstallment] = @InstallmentAmount
        //     ,[ApprovadStartDate] = @StartDate
        //     ,[ApprovedEndDate] = @EndDate
        //WHERE LoanID = @LoadId ", con))
        //           {

        //               cmd.Parameters.AddWithValue("@LoadId", lblApplicationNo.Text);
        //               cmd.Parameters.AddWithValue("@LoanAmount", txtApproveLoanAmount.Text.Trim());

        //               cmd.Parameters.AddWithValue("@InstallmentAmount", txtApprovedInstallmentAmount.Text.Trim());
        //               cmd.Parameters.AddWithValue("@StartMonth", ddlMonth.SelectedValue);
        //               cmd.Parameters.AddWithValue("@StartYear", ddlYear.SelectedValue);
        //               cmd.ExecuteNonQuery();

        //               //cmd.CommandText = @"Update HR_Approval_Log set AuthorityStatus = @Status 
        //               //                    where AuthorityEmpID = @senderID AND EmpLoanID = @LoadId";
        //               //cmd.Parameters.AddWithValue("@Status", radoApprovalStatus.SelectedValue);
        //               //cmd.Parameters.AddWithValue("@senderID", Session["emp_id"]);
        //               //cmd.ExecuteNonQuery();

        //               cmd.Parameters.Clear();

        //               //if (ddlApprovalStatus.SelectedItem.Text == "Approved")
        //               //{
        //               //    cmd.CommandText = @"uspInsertEmployeeLogInfoForLoan";
        //               //    cmd.CommandType = CommandType.StoredProcedure;
        //               //    cmd.Parameters.AddWithValue("@empid", HfEmpId.Value);
        //               //    cmd.Parameters.AddWithValue("@senderDeptID", Session["SubDeptId"]);
        //               //    cmd.Parameters.AddWithValue("@senderID", Session["emp_id"]);
        //               //    cmd.Parameters.AddWithValue("@SenderDesgid", Session["DesignationID"]);
        //               //    cmd.Parameters.AddWithValue("@EmpLoanID", lblApplicationNo.Text);
        //               //    cmd.Parameters.Add("@status", SqlDbType.Int, 5);
        //               //    cmd.Parameters["@status"].Direction = ParameterDirection.Output;
        //               //    cmd.ExecuteNonQuery();
        //               //}
        //               con.Close();
        //           }
        //       }

    }


    private void clearData()
    {

    }


}