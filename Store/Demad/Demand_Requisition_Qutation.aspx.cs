using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using System.Collections.Generic;
public partial class Store_Demand_Requisition_Approval_New : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindSubDept();

            txtStartDate.Value = DateTime.Now.AddDays(-10);
            txtEndDate.Value = DateTime.Now;
 
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();
    }

    protected void lbAddQutation_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

       
         Response.Redirect("~/Store/Demad/Add_qutation.aspx?RQ_ID=" + lb.CommandArgument);
    }
    protected void lbQutationReport_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

        Response.Redirect("~/Store/Demad/Qutation_Report.aspx?RQ_ID=" + lb.CommandArgument);
    }
    protected void lbApproveQutation_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

        Response.Redirect("~/Store/Demad/Approve_Qutations.aspx?RQ_ID=" + lb.CommandArgument);
    }
    protected void bindSubDept()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = {new SqlParameter("@Type", "SubDeptAll") };
            ddlSubDepartment.DataSource = dbm.ExecuteDataTable("uspGetDefaultValuesDemand", "STOREConnectionString", sp);
            ddlSubDepartment.DataBind();
           // ddlSubDepartment.SelectedValue = Session["SubDeptID"].ToString();
        }
        catch(Exception ex)
        {

        }
        

    }
    protected void bindGrid()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@requisitionNo", txtIndentBookNo.Text),new SqlParameter("@ByDeparmtent",ddlSubDepartment.SelectedValue),
                                  new SqlParameter("@startDate",txtStartDate.Value),new SqlParameter("@endDate",txtEndDate.Value),
                                  new SqlParameter("@toSubDept",Session["SubDeptID"])};
            GridView1.DataSource = dbm.ExecuteDataTable("uspSelectDemandRequisitionQutation", "STOREConnectionString", sp);
            GridView1.DataBind();
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
        }


    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdfQID = (HiddenField)e.Row.FindControl("hfMainID");
            LinkButton lbAdd = (LinkButton)e.Row.FindControl("lbAddQutation");
            if (hdfQID.Value != "0")
            {
                lbAdd.Visible = false;
            }
            else
            {
                lbAdd.Visible = true;
            }
        }
    }

    protected void lnkViewApprove_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        Label lbD = (Label)row.FindControl("lblDemandNo");
        Response.Redirect("Add_Qutation.aspx?RQ_ID="+lbD.Text+"&Main_ID="+lb.CommandArgument);
    }

    protected void lnkGeneratePO_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        hfDemandRQ_ID.Value = lnkbtn.CommandArgument;
        Response.Redirect("~/Store/PurchaseOrder.aspx?PR_ID=" + lnkbtn.CommandArgument);
        //pnlGenPO.Visible = true;
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchCustomers(string prefixText, int count)
    {
        List<string> customers = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "SELECT Party_Id, LTRIM(RTRIM(Party_Name)) as Party_Name FROM [Parties] WHERE     (LEN(LTRIM(RTRIM(Party_Name))) > 0) AND (Party_Name LIKE '%' + @Search + '%')  ORDER BY LTRIM(RTRIM(Party_Name))";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Party_Name"].ToString(), sdr["Party_Id"].ToString()));
        }
        return customers;
    }

    protected void btnGenratePO_Click(object sender, EventArgs e)
    {
        if (ddlPaymentTo.Text != "")
        {
            DbManager db = new DbManager();
            SqlParameter[] para =
            {
            new SqlParameter("@RQ_ID",hfDemandRQ_ID.Value),
            new SqlParameter("@emp_id",Session["Emp_Id"]),
            new SqlParameter("@PO_NO",SqlDbType.BigInt,8,ParameterDirection.Output,false,0,0,"",DataRowVersion.Default,0),
            new SqlParameter("@DeptID",Session["Dept_Id"]),
            new SqlParameter("@SubDeptID",Session["SubDeptId"]),
            new SqlParameter("@Company_id",hfPaymentToId.Value)
        };
            db.ExecuteNonQuery("Insert_PO_from_Demand_REQ_Direct", "STOREConnectionString", para);
            
            Response.Redirect("~/Store/PurchaseOrder.aspx?PO_ID=" + para[2].Value.ToString());

        }

    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnlGenPO.Visible = false;
        bindGrid();
    }
}