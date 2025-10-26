using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Approve_Requisition : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FormView1.DataBind();
            gvRequistionDetail.DataBind();
        }
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
            lbl_msg.Text = "Request sent for approval to " + ddlSendTo.SelectedItem.Text.Substring(0,ddlSendTo.SelectedItem.Text.Length - 6);
        }
        catch
        {
            lbl_msg.Text = "Request not sent for approval";

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
        HiddenField hfld_IB_ID = null;
        HiddenField hfld_Item_Code = null;
        TextBox txtNewQty = null;

        foreach (GridViewRow grow in gvRequistionDetail.Rows)
        {
            hfld_IB_ID = grow.FindControl("hfld_IB_ID") as HiddenField;
            hfld_Item_Code = grow.FindControl("hfld_Item_Code") as HiddenField;
            txtNewQty = grow.FindControl("txtNewQty") as TextBox;

            sqlDs_RequistionDetail.UpdateParameters["Qty"].DefaultValue = txtNewQty.Text;
            sqlDs_RequistionDetail.UpdateParameters["IB_ID"].DefaultValue = hfld_IB_ID.Value;
            sqlDs_RequistionDetail.UpdateParameters["Item_Code"].DefaultValue = hfld_Item_Code.Value;
            sqlDs_RequistionDetail.Update();

        }
    }
    protected void Btn_Return_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/store/SearchIPO_Approved.aspx");
    }
    protected void gvRequistionDetail_PreRender(object sender, EventArgs e)
    {
        if (gvRequistionDetail.Rows.Count > 0)
        {
            
            
            Label totalAmount = null;
            Label grandTotal = null;
            Double total = 0;
            foreach (GridViewRow grow in gvRequistionDetail.Rows)
            {
                totalAmount = grow.FindControl("lblTotalAmount") as Label;
                if (String.IsNullOrEmpty(totalAmount.Text))
                {
                    totalAmount.Text = "0";
                }
                
                total = total + Convert.ToDouble(totalAmount.Text);
            }
            grandTotal = gvRequistionDetail.FooterRow.FindControl("lblTotalAmount") as Label;
            grandTotal.Text = total.ToString("#,##.##");
        }
    }
}