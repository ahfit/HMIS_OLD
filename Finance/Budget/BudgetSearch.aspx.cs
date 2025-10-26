using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_BudgetSearch : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList_FinancialCompany.DataBind();
            DropDownList_FinancialCompany.SelectedValue = Session["Financial_Company_Id"].ToString();
            DropDownList_FinancialCompany.Enabled = false;
            DropDownList_CompanyBranches.DataBind();
            DropDownList_CompanyBranches.SelectedValue = Session["Company_Branch_Id"].ToString();
        }
    }
    protected void DropDownList_FinancialCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_CompanyBranches.DataBind();
        GridView4.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView4.DataBind();
    }
}