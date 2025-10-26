using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_AddDonation : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            bindCompany();
            bindCompanyBranches();
            bindExpenditure();
            bindCostCenter();
            ddlCostCenter.SelectedValue = "9";
            ddlCostCenter.Enabled = false;
            bindCCHead();
            ddlHead.SelectedValue = "3305003";
            ddlHead.Enabled = false;
            bindGrid();
        }
    }
    protected void bindCompany()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Emp_ID", Session["Emp_ID"]) };
        ddlCompany.DataSource = dbm.ExecuteDataTable("uspGetFinancialCompaniesEmpWise", "Finance_ConnectionString", sp);
        ddlCompany.DataBind();
    }
    protected void bindCompanyBranches()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Emp_ID", Session["Emp_ID"].ToString()), new SqlParameter("@Financial_Company_Id",ddlCompany.SelectedValue ) };
        ddlBranch.DataSource = dbm.ExecuteDataTable("uspGetCompanyBranchesEmpWise", "Finance_ConnectionString", sp);
        ddlBranch.DataBind();
    }

    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindCompanyBranches();
        bindGrid();
    }
    protected void bindExpenditure()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Head_Type", "Donation") };
        ddlExpanse.DataSource = dbm.ExecuteDataTable("uspGetExpenditureHeadWise", "Finance_ConnectionString", sp);
        ddlExpanse.DataBind();
    }
    protected void bindCostCenter()
    {
        DbManager dbm = new DbManager();
        string query = "Select	CostCenterID,CostCenterName From	CostCenter C Where	HospitalID=@HospitalID";
        SqlParameter[] sp = { new SqlParameter("@HospitalID", Session["HospitalID"]) };
        ddlCostCenter.DataSource = dbm.ExecuteDataTableWithQuery(query, "Finance_ConnectionString", sp);
        ddlCostCenter.DataBind();
    }
    protected void bindCCHead()
    {
        DbManager dbm = new DbManager();
        string query = "Select	E_Code,E_Name From	Expenditure  Where E_Name like '%'+@E_Name+'%'";
        SqlParameter[] sp = { new SqlParameter("@E_Name", ddlPaymentMode.SelectedValue) };
        ddlHead.DataSource = dbm.ExecuteDataTableWithQuery(query, "Finance_ConnectionString", sp);
        ddlHead.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@DonorName", txtName.Text), new SqlParameter("@DonorAddress", txtAddress.Text),
                                  new SqlParameter("@DonorRemarks", txtRemarks.Text), new SqlParameter("@Financial_Company_Id", ddlCompany.SelectedValue),
                                  new SqlParameter("@Company_Branch_Id", ddlBranch.SelectedValue), new SqlParameter("@Description", txtDescription.Text),
                                  new SqlParameter("@Amount", txtAmount.Text), new SqlParameter("@Dept_Id", Session["Dept_id"]),
                                  new SqlParameter("@SubDept_Id", Session["SubDeptID"]), new SqlParameter("@ChequeNo", txtChequeNo.Text),
                                  new SqlParameter("@DonationHead", ddlExpanse.SelectedValue), new SqlParameter("@OtherHead", ddlHead.SelectedValue),
                                  new SqlParameter("@CostCenterID", ddlCostCenter.SelectedValue),new SqlParameter("@CellNo", txtCellNo.Text),
                                  new SqlParameter("@EmpID", Session["emp_id"]),new SqlParameter("@DesignationID", Session["DesignationID"]),
                                  new SqlParameter("@DonorID", SqlDbType.BigInt, 8, ParameterDirection.Output, false, 0, 0, "0", DataRowVersion.Default, 0)

            };
            dbm.ExecuteNonQuery("uspAddDonation", "Finance_ConnectionString",sp);
            string url;
            url = "../Finance/DonationReport.aspx?DID=" + sp[16].Value.ToString();
            Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);
        }
           
        catch(Exception ex)
        {

        }

        bindCCHead();
    }
  
    
    protected void ddlPaymentMode_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(ddlPaymentMode.SelectedValue.ToString()== "Bank")
        {
            lblCheqNo.Visible = true;
            txtChequeNo.Visible = true;
        }
        else
        {
            lblCheqNo.Visible = false;
            txtChequeNo.Visible = false;
        }
        bindCCHead();
    }
    protected void bindGrid()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Financial_Company_Id", ddlCompany.SelectedValue), new SqlParameter("@Company_Branch_Id", ddlBranch.SelectedValue) };
        gvDonations.DataSource = dbm.ExecuteDataTable("uspGetDonations", "Finance_ConnectionString", sp);
        gvDonations.DataBind();
    }

    protected void lnkReceipt_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        string url = "../Finance/DonationReport.aspx?DID=" + lbtn.CommandArgument;
        StringBuilder sb = new StringBuilder();
        sb.Append("<script language='javascript'>");
        sb.Append(" window.open('");
        sb.Append(url);
        sb.Append("', '_Blank')</script>");
        Type t = this.GetType();
        if(ClientScript.IsClientScriptBlockRegistered(t, "PopupScript"))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString());
        }
        else
        {
            Response.Redirect(url);
        }
    }
}