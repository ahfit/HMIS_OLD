using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_AdminServicePackagesSub : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < grdServices.Rows.Count;i++ )
            {
                CheckBox chkSelect = (CheckBox)grdServices.Rows[i].FindControl("chkSelect");
                HiddenField hfS_ID = (HiddenField)grdServices.Rows[i].FindControl("hfS_ID");
                TextBox txtRate = (TextBox)grdServices.Rows[i].FindControl("txtRate");
                TextBox txtAmount = (TextBox)grdServices.Rows[i].FindControl("txtAmount");
                if (chkSelect.Checked && txtRate.Text != "")
                {
                    hfS_IDPage.Value = hfS_ID.Value;
                    hfRate.Value = txtRate.Text;
                    dsPackages.Insert();
                    lblMessage.Text = "";

                }
                else {
                    lblMessage.Text = "Please Enter Rate";
                    lblMessage.Visible = true;
                }
            }
            grdPckages.DataBind ();
        }
        catch (Exception ex)
        {
           // Response.Write(ex.Message);
        }
    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox chkSelectAll = (CheckBox)grdServices.HeaderRow.FindControl("chkSelectAll");
            for (int i = 0; i <= grdServices.Rows.Count - 1; i++)
            {

                CheckBox chkSelect = (CheckBox)grdServices.Rows[i].FindControl("chkSelect");
                chkSelect.Checked = chkSelectAll.Checked;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    int sum = 0;
    protected void grdPckages_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
        if (e.Row.RowType==DataControlRowType.DataRow)
        {
            TextBox rate = e.Row.FindControl("lblRate") as TextBox;
            sum += Convert.ToInt32(rate.Text);
        }

        

        if (e.Row.RowType==DataControlRowType.Footer)
        {
            Label total = e.Row.FindControl("lblSum") as Label;
            total.Text = sum.ToString();
        }


        
    }
    protected void grdPckages_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int rowindex=e.RowIndex;
        GridViewRow row=grdPckages.Rows[e.RowIndex] as GridViewRow;
        TextBox txt = row.FindControl("lblRate") as TextBox;
        TextBox txtservicename = row.FindControl("txtbox") as TextBox;
        
        dsPackages.UpdateParameters["Rate"].DefaultValue = txt.Text;
        
    }
}
