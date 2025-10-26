using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ApprovalAuthoritiesQutation : System.Web.UI.Page
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
        sqlDs_ApprovalAuthorities.Update();
    }
    protected void imgDelete_Click(object sender, EventArgs e)
    {
        ImageButton btnTemp = sender as ImageButton;
        long recordId = long.Parse(btnTemp.CommandArgument);
        sqlDs_ApprovalAuthorities.DeleteParameters["Id"].DefaultValue = recordId.ToString();
        sqlDs_ApprovalAuthorities.Delete();
        LoadGridData();
    }
    protected void ddlEmployeeSubdept_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlAuthority.DataBind();
    }
}