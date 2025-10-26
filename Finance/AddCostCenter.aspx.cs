using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_AddCostCenter : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            bindGrid();
            ddlHospital.DataBind();
            FillMainCostCenter();
           
        }
    }

    protected void FillMainCostCenter()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT        MainCostCenterId, MainCostCenterName FROM  MainCostCenter order by MainCostCenterName", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            DropDownList1.DataValueField = "MainCostCenterId";
            DropDownList1.DataTextField = "MainCostCenterName";
            DropDownList1.DataSource = dt;
            DropDownList1.DataBind();
        }
    }

    protected void ddlHospital_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        ddlHospital.DataBind();
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

    protected void btnSave_Click1(object sender, EventArgs e)
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@CostCenterName", txtName.Text),
                new SqlParameter("@HospitalID", ddlHospital.SelectedValue)
            };
            dbm.ExecuteNonQuery("uspAddCostCenter", "Finance_ConnectionString", sp);
            bindGrid();
            //Response.Redirect("~/Finance/DonationReport.aspx?DID="+ sp[16].Value.ToString());
        }
        catch (Exception ex)
        {

        }

    }

    protected void bindGrid()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@MainCostCenterId", DropDownList1.SelectedValue) };
        gvCostCenter.DataSource = dbm.ExecuteDataTable("uspGetCostCenter", "Finance_ConnectionString", sp);
        gvCostCenter.DataBind();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();
    }
}