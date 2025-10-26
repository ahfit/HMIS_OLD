using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_DemandReqMinimumAuthorityLevel : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadGridData();
        }
    }
    private void LoadGridData()
    {
        gvApprovalAuthorities.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        sqlDs_MinApprovalAuthorities.Update();
        LoadGridData();
    }
    protected void imgDelete_Click(object sender, EventArgs e)
    {
        ImageButton btnTemp = sender as ImageButton;
        long recordId = long.Parse(btnTemp.CommandArgument);
        sqlDs_MinApprovalAuthorities.DeleteParameters["Min_Approval_Auth_Id"].DefaultValue = recordId.ToString();
        sqlDs_MinApprovalAuthorities.Delete();
        LoadGridData();
    }
}