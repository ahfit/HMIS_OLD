using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Drawing;

public partial class PayRoll_BankLetter : System.Web.UI.Page
{
    SqlConnection con = null;


    private void Open()
    {
        if (con == null)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString);
            con.Open();
        }
        else
        {
            con.Open();
        }
    }

    private void Close()
    {
        if (con != null)
        {
            con.Close();
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_Date.Value = DateTime.Now;
            for (int i = 0; i < 50; i++)
            {
                DropDownList_year.Items.Insert(i, Convert.ToString(2000 + i));
            }
            DropDownList_year.SelectedValue = Convert.ToString(DateTime.Now.Year);
            DropDownList_Month.SelectedValue = Convert.ToString(DateTime.Now.Month);
            Dropdownlist_company.DataBind();
            Dropdownlist_Department.DataBind();
            txtApproveDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            Search_Record();
        }

    }
    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkAll = (CheckBox)sender;
        if (chkAll.Checked)
        {
            for (int i = 0; i < grdSalary.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)grdSalary.Rows[i].FindControl("chkApproveSalary");
                chk.Checked = true;
            }
        }
        else
        {
            for (int i = 0; i < grdSalary.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)grdSalary.Rows[i].FindControl("chkApproveSalary");
                chk.Checked = false;
            }
        }
        CalculateSum();
    }

    protected void chk_CheckedChanged(object sender, EventArgs e)
    {
        upd_bankletter.Visible = false;
           CheckBox chk = (CheckBox)sender;
        GridViewRow row = (GridViewRow)chk.NamingContainer;
        
        CalculateSum(row.RowIndex);
        chk.Focus();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        Search_Record();    
    }
    protected void btnGenerateLetter_Click(object sender, EventArgs e)
    {
        if (txtCheckNo.Text == string.Empty || txtLetterNo.Text == string.Empty || WebDateChooser_Date.Value == null 
            || DropDownListAccountNumber.SelectedIndex == -1 || DropDownlist_bank.SelectedIndex == -1)
        {
            lblMsg.Text = "Incomplete input";
            lblMsg.ForeColor = Color.Red;
            return;
        }
        else
        {
            Save();
        }
         if (!string.IsNullOrEmpty( HiddenField_sbtid.Value))
         {
            string url = "../BankLetterRpt.aspx?SBTID=" + HiddenField_sbtid.Value;
            StringBuilder sb = new StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>window.open(' " + url + " ')</script>");
            Type t = this.GetType();
            if ((!ClientScript.IsClientScriptBlockRegistered(t, "PopUp")))
            {
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
            }
         }
         Search_Record();
    }


    void Save()
    {
        CalculateSum();
        string empids = SelectedEmployees();
        try
        {
            if (string.IsNullOrEmpty(empids))
            {
                lblMsg.Text = "No Employee Selected..";
                lblMsg.ForeColor = Color.Red;
                return;
            }
            else
            {
                SqlParameter parm = new SqlParameter();
                parm.Direction = ParameterDirection.InputOutput;

                Open();
                SqlCommand cmd = new SqlCommand("usp_BankSalaryTransfer", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@empids", empids);
                cmd.Parameters.AddWithValue("@Total_Amount", HiddenField_TotalSalary.Value);
                cmd.Parameters.AddWithValue("@From_Account", DropDownListAccountNumber.SelectedValue);
                cmd.Parameters.AddWithValue("@bank_id", DropDownlist_bank.SelectedValue);
                cmd.Parameters.AddWithValue("@Check_No", txtCheckNo.Text.Trim());
                //cmd.Parameters.AddWithValue("@Approved_Date", Convert.ToDateTime(txtApproveDate.Text).ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@Approved_Date", Convert.ToDateTime(WebDateChooser_Date.Value).ToString("yyyy-MM-dd"));
                cmd.Parameters.AddWithValue("@Approve_by", DropDownList_ApprovedBy.SelectedValue);
                cmd.Parameters.AddWithValue("@Salary_Month", DropDownList_Month.SelectedValue);
                cmd.Parameters.AddWithValue("@Salary_Year", DropDownList_year.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Status_Id", 1);
                cmd.Parameters.AddWithValue("@DeptId", Dropdownlist_Department.SelectedValue);
                cmd.Parameters.AddWithValue("@LetterNo", txtLetterNo.Text);
                cmd.Parameters.Add("@id", SqlDbType.Int).Direction = ParameterDirection.Output;
                try
                {

                    cmd.ExecuteNonQuery();
                    HiddenField_sbtid.Value = cmd.Parameters["@id"].Value.ToString();
                    lblMsg.Text = "Approved Successfully";
                    lblMsg.ForeColor = Color.Green;
                }
                catch (Exception)
                {
                    lblMsg.Text = "Failed to approve please check your input.";
                    lblMsg.ForeColor = Color.Red;
                }
                finally
                {
                    cmd.Dispose();
                    Close();
                }
            }

        }
        catch (Exception)
        {

        }
    }


    void Search_Record()
    {
        grdSalary.DataBind();
        if (grdSalary.Rows.Count>0)
        {
            btnGenerateLetter.Visible = true;
            btnGenerateLetter1.Visible = true;
        }
        else
        {
            btnGenerateLetter.Visible = false;
            btnGenerateLetter1.Visible = false;
        }
        GridViewBankLetters.DataBind();
        if (GridViewBankLetters.Rows.Count > 0)
        {
            btnRollBack.Visible = true;
            btnRollBack1.Visible = true;
        }
        else
        {
            btnRollBack.Visible = false;
            btnRollBack1.Visible = false;
        }
    }
    void CalculateSum()
    {
        decimal sum = 0;
        for (int i = 0; i < grdSalary.Rows.Count; i++)
        {
            CheckBox chk = (CheckBox)grdSalary.Rows[i].FindControl("chkApproveSalary");
            if (chk.Checked)
            {
                Label lbl = (Label)grdSalary.Rows[i].FindControl("lblIndividualSalary");
                sum += Convert.ToDecimal(lbl.Text);
            }
        }
        if (grdSalary.Rows.Count > 0)
        {
            grdSalary.FooterRow.Cells[4].Text = "Total";
            Label lblSum = (Label)grdSalary.FooterRow.FindControl("lblSum");
            lblSum.Text = Convert.ToString(sum);
            HiddenField_TotalSalary.Value = Convert.ToString(sum);
        }
    }

    void CalculateSum( int index)
    {
        decimal Total = 0,Index_amount=0;
        CheckBox chk = (CheckBox)grdSalary.Rows[index].FindControl("chkApproveSalary");
        Label lbl = (Label)grdSalary.Rows[index].FindControl("lblIndividualSalary");
        Label lblSum = (Label)grdSalary.FooterRow.FindControl("lblSum");
        if (!string.IsNullOrEmpty(lbl.Text.Trim()))
        {
            Index_amount = Convert.ToDecimal(lbl.Text.Trim());
        }
        if (!string.IsNullOrEmpty(lblSum.Text.Trim()))
        {
            Total = Convert.ToDecimal(lblSum.Text.Trim());
        }

            if (chk.Checked)
            {
                Total += Index_amount;
            }
            else
            {
                Total -= Index_amount;
            }

            lblSum.Text = Convert.ToString(Total);
            HiddenField_TotalSalary.Value = Convert.ToString(Total);

    }
    protected void grdSalary_DataBound(object sender, EventArgs e)
    {
     //   CalculateSum();
    }
    protected void btnCalculate_Click(object sender, EventArgs e)
    {
        CalculateSum();
    }

    string SelectedEmployees()
    {
        string empid = string.Empty;

        for (int i = 0; i < grdSalary.Rows.Count; i++)
        {
            CheckBox chk = (CheckBox) grdSalary.Rows[i].FindControl("chkApproveSalary");
            if (chk.Checked)
            {
                HiddenField HD_EmpID = (HiddenField)grdSalary.Rows[i].FindControl("HiddenField_EmpId");
                empid += HD_EmpID.Value + ",";
            }
        }
        if (empid.Length>0)
        { 
            empid = empid.Remove(empid.Length - 1);
        }
        
        return empid;
    }
    protected void btnRollBack_Click(object sender, EventArgs e)
    {
        if (GridViewBankLetters.Rows.Count > 0)
        {
            rollBack(DropDownList_Month.SelectedValue, DropDownList_year.SelectedItem.Text, "0");
        }
        else
        {
            lblMsg.Text = "No Record found to be Rollback...";
        }
        Search_Record();
   
    }
    protected void lBtn_Show_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;

        rollBack(DropDownList_Month.SelectedValue, DropDownList_year.SelectedItem.Text, lnk.CommandArgument.ToString());
        Search_Record();
    }

    protected void rollBack(string Month,string Year,string STB_ID )
    {
        Open();
        SqlCommand comand = new SqlCommand("Usp_DeleteTransactionForSalary", con);
        comand.CommandType = CommandType.StoredProcedure;
        comand.Parameters.AddWithValue("@salarymonth",Month );
        comand.Parameters.AddWithValue("@salaryyear", Year);
        if (STB_ID != "0" )
        {
            comand.Parameters.AddWithValue("@SBT_id", STB_ID);
        }
        
        comand.ExecuteNonQuery();
        Close();
        
    }
    protected void grdSalary_PreRender(object sender, EventArgs e)
    {
        if (grdSalary.Rows.Count>0)
        {
            btnGenerateLetter.Visible = true;
            btnGenerateLetter1.Visible = true;
        }
        else
        {
            btnGenerateLetter.Visible = false;
            btnGenerateLetter1.Visible = false;
        }

    }
    protected void GridViewBankLetters_PreRender(object sender, EventArgs e)
    {
        if (GridViewBankLetters.Rows.Count > 0)
        {
            btnRollBack.Visible = true;
            btnRollBack1.Visible = true;
        }
        else
        {
            btnRollBack.Visible = false;
            btnRollBack1.Visible = false;
        }
    }
    protected void Dropdownlist_company_SelectedIndexChanged(object sender, EventArgs e)
    {
        Dropdownlist_Department.DataBind();
    }
}
        
  