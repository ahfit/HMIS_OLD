using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Demad_CreateDemandFromDemands : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {


            txtStartDate.Value = DateTime.Now.AddDays(-10);
            txtEndDate.Value = DateTime.Now;

            
            bindDefaults();
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();
        if (gvSearch.Rows.Count > 0)
            btnGenDemand.Visible = true;
        else
            btnGenDemand.Visible = false;
    }
    protected void bindDefaults()
    {
        DbManager dbMgrD = new DbManager();
        DbManager dbMgrE = new DbManager();
        SqlParameter[] sqlParmD = { new SqlParameter("@Type", "SubDept") };
        SqlParameter[] sqlParmE = { new SqlParameter("@Type", "Employee") };
        ddlSubDept.DataSource = dbMgrD.ExecuteDataTable("uspGetDefaultValuesDemand", "STOREConnectionString", sqlParmD);
        ddlSubDept.DataBind();
        ddlEmployee.DataSource = dbMgrE.ExecuteDataTable("uspGetDefaultValuesDemand", "STOREConnectionString", sqlParmE);
        ddlEmployee.DataBind();
    }
    protected void bindGrid()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@To_Sub_Dept_ID",Session["SubDeptID"]),new SqlParameter("@From_Sub_Dept_ID",ddlSubDept.SelectedValue),
                             new SqlParameter("@EmpID",ddlEmployee.SelectedValue),new SqlParameter("@StartDate",txtStartDate.Value),
                             new SqlParameter("@EndDate",txtEndDate.Value)};
        gvSearch.DataSource = dbm.ExecuteDataTable("uspGetDemands", "STOREConnectionString", sp);
        gvSearch.DataBind();
    }

    protected void btnGenDemand_Click(object sender, EventArgs e)
    {
        pnlGen.Visible = true;
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Type", "SubDeptAll") };
        ddlSendTo.DataSource = dbm.ExecuteDataTable("uspGetDefaultValuesDemand", "STOREConnectionString", sp);
        ddlSendTo.DataBind();
        ddlSendTo.SelectedValue = Session["SubDeptID"].ToString();
        getCounter();
    }

    protected void chkAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkAll = (CheckBox)sender;
        foreach (GridViewRow gvRow in gvSearch.Rows)
        {
            CheckBox chk = (CheckBox)gvRow.FindControl("chk");
            if (chkAll.Checked)
                chk.Checked = true;
            else
                chk.Checked = false;
        }
    }

    protected void btnGenerateNewDemand_Click(object sender, EventArgs e)
    {
        if (ddlSendTo.SelectedValue != "0")
        {
            insertMain();
            forwardDemand();
            hdfNewDemandNo.Value = "";
            hdfYearlyCounter.Value = "";
            txtRemarks.Text = "";
            bindGrid();
            pnlGen.Visible = false;
        }
    }

    private void insertMain()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@Demand_RQ_ID",hdfNewDemandNo.Value), new SqlParameter("@Yearly_Counter", hdfYearlyCounter.Value),
                             new SqlParameter("@From_Dept_ID",Session["dept_id"]),new SqlParameter("@From_Sub_Dept_ID",Session["SubDeptID"]),
                             new SqlParameter("@To_Sub_Dept_ID",ddlSendTo.SelectedValue),new SqlParameter("@Date_Time",DateTime.Now),
                             new SqlParameter("@Emp_ID",Session["Emp_id"]),new SqlParameter("@Description",txtRemarks.Text),
                             new SqlParameter("@ShiftID",Session["ShiftID"]),new SqlParameter("@Is_Approved","false")};
        dbm.ExecuteNonQuery("usp_CreateDemand_Requisition_Main", "STOREConnectionString", sp);
        insertSub();
    }
    private void insertSub()
    {
        foreach (GridViewRow gvRow in gvSearch.Rows)
        {
            try
            {
                LinkButton lnk = (LinkButton)gvRow.FindControl("lnkDemandID");
                CheckBox chk = (CheckBox)gvRow.FindControl("chk");
                if (chk.Checked)
                {
                    DbManager dbm = new DbManager();
                    SqlParameter[] sp = { new SqlParameter("@New_Demand_RQ_ID", hdfNewDemandNo.Value), new SqlParameter("@Old_Demand_RQ_ID", lnk.Text) };
                    dbm.ExecuteNonQuery("uspInsertDemandSubFromOld", "STOREConnectionString", sp);
                }
            }
            catch(Exception ex)
            {

            }
        }
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnlGen.Visible = false;
    }
    public void getCounter()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Demand_Requisition_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Dept_ID = @From_Dept_ID) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", Session["SubDeptID"]);
        int count;

        try
        {
            count = (int)command1.ExecuteScalar();
            hdfYearlyCounter.Value = count.ToString();

        }
        catch (Exception ex)
        {
            count = 1;
        }
        con.Close();
        int len = count.ToString().Length;
        hdfNewDemandNo.Value = "D" + DateTime.Today.Year + "-";
        while (len < 5)
        {
            hdfNewDemandNo.Value += "0";
            len++;
        }
        hdfNewDemandNo.Value += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
    }

    protected void lnkDemandID_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('Demand_Requisition_Report.aspx?RequsitionNo=" + lnk.CommandArgument + "','_newtab');", true);
    }
    protected void forwardDemand()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", hdfNewDemandNo.Value),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id", Session["SubDeptId"]),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks", txtRemarks.Text),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateDemandApprovalRequest", "STOREConnectionString", sqlParm);

    }
}