using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_ViewDemandReqWorkFlowProgress : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void gvRequisitionApprovalLevels_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblColor = null;
        HiddenField hfldColor = null;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            lblColor = e.Row.FindControl("lblColor") as Label;
            hfldColor = e.Row.FindControl("hfldColor") as HiddenField;

            if (hfldColor.Value == "Red")
                lblColor.BackColor = System.Drawing.Color.Red;
            else if (hfldColor.Value == "Green")
                lblColor.BackColor = System.Drawing.Color.Green;
            else if (hfldColor.Value == "Blue")
                lblColor.BackColor = System.Drawing.Color.Blue;
            else if (hfldColor.Value == "Maroon")
                lblColor.BackColor = System.Drawing.Color.Maroon;

        }

    }
}