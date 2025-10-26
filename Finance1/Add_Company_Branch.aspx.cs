using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

public partial class Finance_Add_Company_Branch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        
        
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Finance/Budget.aspx");
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        if (ddl_FinancialCompany.SelectedValue != null && txtBranchName.Text != "")
        {
            sql_ComapnyBranch.InsertParameters["Financial_Company_Id"].DefaultValue = ddl_FinancialCompany.SelectedValue;
            sql_ComapnyBranch.InsertParameters["Company_Branch_Name"].DefaultValue = txtBranchName.Text;
            sql_ComapnyBranch.InsertParameters["Company__Branch_Address"].DefaultValue = txtAddress.Text;
            sql_ComapnyBranch.InsertParameters["Account_No"].DefaultValue = txtAccount.Text;
            sql_ComapnyBranch.InsertParameters["Payable_Head"].DefaultValue =txtPayable.Text;
            sql_ComapnyBranch.InsertParameters["SIT_Head"].DefaultValue = txtSIT.Text;
            sql_ComapnyBranch.InsertParameters["Description"].DefaultValue = txt_Description.Text;
            sql_ComapnyBranch.InsertParameters["Receivable_Head"].DefaultValue = txtReceivable.Text;
            sql_ComapnyBranch.InsertParameters["Inventory_Head"].DefaultValue =txtInventory.Text;
            sql_ComapnyBranch.InsertParameters["Backup_Store_Head"].DefaultValue = txtBackup.Text;
            sql_ComapnyBranch.Insert();
            lbl_Msg.Text = "Branch Added Successfully.";
            lbl_Msg.ForeColor = Color.Green;
            lbl_Msg.Visible = true;
            txtBranchName.Text = "";

        }
        else
        {
            lbl_Msg.Text = "Please Enter Data First.";
            lbl_Msg.Visible = true;
        }
    }
}