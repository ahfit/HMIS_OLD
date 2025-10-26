using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Approve_Demand_Requisition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            sqlDs_RequistionDetail.InsertParameters["Requisition_ID"].DefaultValue = Request.QueryString["RQ_ID"];
            sqlDs_RequistionDetail.InsertParameters["Send_By"].DefaultValue = Session["emp_id"].ToString();
            sqlDs_RequistionDetail.InsertParameters["Send_By_Sub_Dept_Id"].DefaultValue = Session["SubDeptId"].ToString();
            sqlDs_RequistionDetail.InsertParameters["Send_To"].DefaultValue = ddlSendTo.SelectedValue;
            sqlDs_RequistionDetail.InsertParameters["Send_To_Sub_Dept_Id"].DefaultValue = "0";
            sqlDs_RequistionDetail.InsertParameters["SendDate"].DefaultValue = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
            sqlDs_RequistionDetail.InsertParameters["Requisition_Remarks"].DefaultValue = txtRemarks.Text;
            sqlDs_RequistionDetail.InsertParameters["Parent_Approval_Request_Id"].DefaultValue = GetParentRequestID();
            sqlDs_RequistionDetail.InsertParameters["Approved_Status"].DefaultValue = "Pending";
            sqlDs_RequistionDetail.InsertParameters["Approved_Date"].DefaultValue = DBNull.Value.ToString();
            sqlDs_RequistionDetail.InsertParameters["Request_Level"].DefaultValue = GetPersonLevel();
            sqlDs_RequistionDetail.Insert();
            lbl_message.Text = "Forwarded to " + ddlSendTo.SelectedItem.Text.Substring(0, ddlSendTo.SelectedItem.Text.Length - 5);
        }
        catch
        {
 
        }
    }
    private string GetPersonLevel()
    {
        string retVal = string.Empty;
        string level = ddlSendTo.SelectedItem.Text;
        int indx = 0;
        indx = level.IndexOf("(");
        if (indx != -1)
        {
            retVal = level.Substring(indx + 1);
            retVal = retVal.Replace(")", "");
        }

        return retVal;
    }
    private string GetParentRequestID()
    {
        try
        {
            return Request.QueryString["PID"];
        }
        catch (Exception)
        {

            return "0";
        }
    }
    protected void btnSaveQuantity_Click(object sender, EventArgs e)
    {
        HiddenField hfld_RQ_ID = null;
        HiddenField hfld_Item_Code = null;
        TextBox txtNewQty = null;
        TextBox txtRate = null;
        TextBox txtDiscount = null;
        TextBox txtTotalAmount = null;

        foreach (GridViewRow grow in gvRequistionDetail.Rows)
        {
            hfld_RQ_ID = grow.FindControl("hfld_RQ_ID") as HiddenField;
            hfld_Item_Code = grow.FindControl("hfld_Item_Code") as HiddenField;
            txtNewQty = grow.FindControl("txtNewQty") as TextBox;
            txtRate = grow.FindControl("txtRate") as TextBox;
            txtDiscount = grow.FindControl("txtDiscount") as TextBox;
            txtTotalAmount = grow.FindControl("txtTotalAmount") as TextBox;

            sqlDs_RequistionDetail.UpdateParameters["Qty"].DefaultValue = txtNewQty.Text;
            sqlDs_RequistionDetail.UpdateParameters["Demand_RQ_ID"].DefaultValue = hfld_RQ_ID.Value;
            sqlDs_RequistionDetail.UpdateParameters["Item_Code"].DefaultValue = hfld_Item_Code.Value;
            sqlDs_RequistionDetail.UpdateParameters["Rate"].DefaultValue = txtRate.Text;
            sqlDs_RequistionDetail.UpdateParameters["Discount"].DefaultValue = txtDiscount.Text;
            sqlDs_RequistionDetail.UpdateParameters["Amount"].DefaultValue = txtTotalAmount.Text;
            sqlDs_RequistionDetail.Update();

        }
    }
    protected void Btn_Return_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/store/DemandRequisitionSearch.aspx");
    }
    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {
        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
        txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
        txtRate = gvRow.FindControl("txtRate") as TextBox;
        txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
        if (txtDiscount.Text.Trim() != "")
        {
                if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
                {
                    txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
                }
        }
        else
        {
            txtDiscount.Text = "0";
            
        }
    }
    protected void txtRate_TextChanged(object sender, EventArgs e)
    {
        
        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        
         
            TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
            txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
            txtRate = gvRow.FindControl("txtRate") as TextBox;
            txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
            txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
            if (txtRate.Text.Trim() != "")
            {
                if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
                {
                    txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
                    txtDiscount.Focus();
                }
            }
            else
            {
                txtRate.Text = "0";
                txtTotalAmount.Text = "0";
            }
            
           
    }
    protected void txtNewQty_TextChanged(object sender, EventArgs e)
    {
        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
        txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
        txtRate = gvRow.FindControl("txtRate") as TextBox;
        txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
        if (txtNewQty.Text.Trim() != "")
        {
            if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
            {
                txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
                txtRate.Focus();
            }
        }
        else
        {
            txtNewQty.Text = "0";
            txtTotalAmount.Text = "0";
        }
    }
}