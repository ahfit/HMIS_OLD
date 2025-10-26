using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_PendingGRN : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            bindDepartment();
            bindSubDepartment();
            bindPOHead();
            ViewState["postCount"] = 0;
            ViewState["cplCount"] = 0;
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtComapny.Text.Trim()))
        {
            hfComapnyId.Value = "0";
        }
        lblTotalAmount.Text = "0";
        bindGrid();

    }
    protected void bindDepartment()
    {
        DbManager dbMgr = new DbManager();
        string query = "Select 0 Dept_ID,' ------- ALL ------- ' Dept_Name union Select Dept_ID,Dept_Name From Department Where Dept_Name=@Dept_Name Order by Dept_Name";
        SqlParameter[] sqlParm = { new SqlParameter("@Dept_Name", "%") };
        ddlDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParm);
        ddlDepartment.DataBind();
    }
    protected void bindSubDepartment()
    {
        DbManager dbMgr = new DbManager();
        string query = "Select 0 SubDept_Id,' ------- ALL ------- ' SubDept_Name union Select SubDept_Id,SubDept_Name From SubDepartment Where (@Dept_Id=0 or Dept_Id=@Dept_Id) Order By SubDept_Name";
        SqlParameter[] sqlParm = { new SqlParameter("@Dept_Id", ddlDepartment.SelectedValue) };
        ddlSubdepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParm);
        ddlSubdepartment.DataBind();
    }
    protected void bindGrid()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@StartDate", txtStartDate.Text),
                                    new SqlParameter("@EndDate", txtEndDate.Text),
                                    new SqlParameter("@Company_ID", hfComapnyId.Value),
                                    new SqlParameter("@Dept_ID", ddlDepartment.SelectedValue),
                                    new SqlParameter("@SubDept_Id", ddlSubdepartment.SelectedValue),
                                    new SqlParameter("@POHead", ddlPOHead.SelectedValue)};
        gvPendingGRN.DataSource = dbMgr.ExecuteDataTable("uspGetPendingReceivedGRN", "STOREConnectionString", sqlParm);
        gvPendingGRN.DataBind();

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

    protected void lnkGenerate_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = {new SqlParameter("@ReceiveMainID",lnk.CommandArgument),
                                   new SqlParameter("@By_Emp_Id",Session["emp_id"]),
                                   new SqlParameter("@Designation_Id",Session["DesignationID"])};
        dbMgr.ExecuteNonQuery("JV_Purchase_Voucher_GRN", "STOREConnectionString", sqlParam);
        string url = "PurchaseRecievingReport.aspx ? RM_ID = " + lnk.CommandArgument;
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);
        bindGrid();
    }

    protected void gvPendingGRN_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvPendingGRN.PageIndex = e.NewPageIndex;
        bindGrid();
    }


    protected void gvPendingGRN_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        CheckBox chkPost = (CheckBox)e.Row.FindControl("chkPost");
        CheckBox chkComplete = (CheckBox)e.Row.FindControl("chkComplete");
        LinkButton lnkPost = (LinkButton)e.Row.FindControl("lnkPostView");
        LinkButton lnkComplete = (LinkButton)e.Row.FindControl("lnkCompleteView");
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (hfComapnyId.Value == "0")
            {
                //chkPost.Visible = false;
                //chkComplete.Visible = false;
                gvPendingGRN.Columns[11].Visible = false;
                gvPendingGRN.Columns[12].Visible = false;
                
            }
            else
            {
                
                //chkPost.Visible = true;
                gvPendingGRN.Columns[11].Visible = true;

                //chkComplete.Visible = true;
                gvPendingGRN.Columns[12].Visible = false;
            }
            if(lnkPost.CommandArgument!=null)
            {
                lnkPost.Visible = false;
            }
            else
            {
                lnkPost.Visible = false;
            }
            if (lnkComplete.CommandArgument != null)
            {
                lnkComplete.Visible = false;
            }
            else
            {
                lnkComplete.Visible = false;
            }
        }
    }

    protected void btnPost_Click(object sender, EventArgs e)
    {
        if(lblTotalAmount.Text!="0")
        {
            GetGRNIDs();
            pnlPost.Visible = true;
            bindPostHeads();
            lblPostAmount.Text = lblTotalAmount.Text;
        }
        else
        {
            lblMsg.Text = "Select Amount first then POST";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }

    private void GetGRNIDs()
    {
        hf_grn_id.Value = string.Empty;
        bool isFirst = true;
        CheckBox ck = new CheckBox();
        foreach (GridViewRow row in gvPendingGRN.Rows)
        {
            ck = (CheckBox)row.FindControl("chkPost");
            if (ck.Checked && ck.Visible)
            {
                if (isFirst)
                {
                    hf_grn_id.Value = ck.ToolTip;
                    isFirst = false;
                }
                else
                {
                    hf_grn_id.Value =hf_grn_id.Value +","+ ck.ToolTip;
                }
            }
        }

    }

    protected void btnComplete_Click(object sender, EventArgs e)
    {
        if (lblComleteTotalAmount.Text != "0")
        {
            pnlComplete.Visible = true;
            bindCompleteHeads();
            lblCompleteAmount.Text = lblComleteTotalAmount.Text;
        }
        else
        {
            lblMsg.Text = "Select Amount first then Complete";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }
    }
    protected void bindPostHeads()
    {
        DbManager dbMgrD = new DbManager();
        string queryD = "GetGRNIItemsbyPO";
        SqlParameter[] sqlParmD = { new SqlParameter("@GRN_ID", hf_grn_id.Value) };
        Gvd_GRN_DR.DataSource = dbMgrD.ExecuteDataSet(queryD, "StoreConnectionString", sqlParmD);
        Gvd_GRN_DR.DataBind();
      
        

        DbManager dbMgrC = new DbManager();
        string queryC = "Select E_Code,E_Name From Expenditure Where E_Name like '%'+@E_Name+'%'";
        SqlParameter[] sqlParm = { new SqlParameter("@E_Name", "Creditor") };
        ddlPostCr.DataSource = dbMgrC.ExecuteDataTableWithQuery(queryC, "FinanceConnectionString", sqlParm);
        ddlPostCr.DataBind();
        ddlPostCr.Enabled = false;
    }
    protected void btnPostVoucher_Click(object sender, EventArgs e)
    {


        

        
        String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        try
        {
            SqlCommand cmd = new SqlCommand("usp_JV_Post_GRN", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Dept_Id", Session["dept_id"]);
            cmd.Parameters.AddWithValue("@SubDept_Id", Session["SubDeptID"]);
            cmd.Parameters.AddWithValue("@By_Emp_Id", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Designation_Id", Session["DesignationID"]);
            cmd.Parameters.AddWithValue("@Amount", lblPostAmount.Text);
            cmd.Parameters.AddWithValue("@DrHead", getDr());
            cmd.Parameters.AddWithValue("@CrHead", ddlPostCr.SelectedValue);
            cmd.Parameters.AddWithValue("@Company_Id", hfComapnyId.Value);
            cmd.Parameters.AddWithValue("@CompanyName", txtComapny.Text);
            cmd.Parameters.AddWithValue("@Description", txtPostDescription.Text);
            cmd.Parameters.AddWithValue("@VID", SqlDbType.BigInt);
            cmd.Parameters["@VID"].Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            hdfVID.Value = cmd.Parameters["@VID"].Value.ToString();
            updatePostVoucherID();
            pnlPost.Visible = false;
            bindGrid();
            lblTotalAmount.Text="0";
        }
        catch(Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            if(con.State==ConnectionState.Open)
            {
                con.Close();
            }
        }
    }

    private string getDr()
    {
        String Data = "<Data>";
        if (Gvd_GRN_DR.Rows.Count > 0)
        {
            HiddenField LE_Code = new HiddenField();
            Label LAmount = new Label();

            foreach (GridViewRow row in Gvd_GRN_DR.Rows)
            {
                LE_Code = (HiddenField)row.FindControl("lbl_E_code");
                LAmount = (Label)row.FindControl("lbl_amount");
                Data = Data + "<row><e_code>" + LE_Code.Value + "</e_code><amount>" + LAmount.Text.Replace(",", "") + "</amount></row>";
            }
            Data = Data + "</Data>";
        }

        return Data;
    }
    protected void bindCompleteHeads()
    {
        DbManager dbMgrD = new DbManager();
        string queryD = "Select E_Code,E_Name From Expenditure Where E_Name like '%'+@E_Name+'%'";
        SqlParameter[] sqlParmD = { new SqlParameter("@E_Name", "Accrued Supplier") };
        ddlCompleteDr.DataSource = dbMgrD.ExecuteDataTableWithQuery(queryD, "FinanceConnectionString", sqlParmD);
        ddlCompleteDr.DataBind();

        DbManager dbMgrC = new DbManager();
        string queryC = "Select E_Code,E_Name From Expenditure Where E_Name like '%'+@E_Name+'%'";
        SqlParameter[] sqlParm = { new SqlParameter("@E_Name", "Creditor") };
        ddlCompleteCr.DataSource = dbMgrC.ExecuteDataTableWithQuery(queryC, "FinanceConnectionString", sqlParm);
        ddlCompleteCr.DataBind();
    }
    protected void btnCloseCompletePanel_Click(object sender, EventArgs e)
    {
        pnlComplete.Visible = false;
    }

    protected void btnClosePostPnl_Click(object sender, EventArgs e)
    {
        pnlPost.Visible = false;
    }

    protected void chkPost_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkP = (CheckBox)sender;
        GridViewRow gvRow = chkP.NamingContainer as GridViewRow;
        Label amount = (Label)gvRow.FindControl("lblAmount");
        double total = 0, totalAmount=0;
        int postCount = Convert.ToInt32(ViewState["postCount"]);
        if(chkP.Checked)
        {
            postCount = postCount + 1;
            totalAmount = Convert.ToDouble(lblTotalAmount.Text);
            total = totalAmount+Convert.ToDouble(amount.Text);
            lblTotalAmount.Text = total.ToString();
        }
        else
        {
            postCount = postCount - 1;
            
            totalAmount = Convert.ToDouble(lblTotalAmount.Text);
            total = totalAmount - Convert.ToDouble(amount.Text);
            lblTotalAmount.Text = total.ToString();
        }
        ViewState["postCount"] = postCount;
        if (postCount > 0)
        {
            btnPost.Visible = true;
        }
        else
        {
            if (postCount <= 0)
            {
                btnPost.Visible = false;
            }
        }
    }

    protected void chkComplete_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkC = (CheckBox)sender;
        GridViewRow gvRow = chkC.NamingContainer as GridViewRow;
        Label amount = (Label)gvRow.FindControl("lblAmount");
        double total = 0, totalAmount = 0;
        int cplCount = Convert.ToInt32(ViewState["cplCount"]);
        if (chkC.Checked)
        {
            cplCount = cplCount + 1;
            totalAmount = Convert.ToDouble(lblComleteTotalAmount.Text);
            total = totalAmount + Convert.ToDouble(amount.Text);
            lblComleteTotalAmount.Text = total.ToString();
        }
        else
        {
            cplCount = cplCount - 1;
            totalAmount = Convert.ToDouble(lblComleteTotalAmount.Text);
            total = totalAmount - Convert.ToDouble(amount.Text);
            lblComleteTotalAmount.Text = total.ToString();
        }
        ViewState["cplCount"] = cplCount;
        if (cplCount > 0)
        {
            btnComplete.Visible = true;
        }
        else
        {
            if (cplCount <= 0)
            {
                btnComplete.Visible = false;
            }
        }
    }
    protected void updatePostVoucherID()
    {
        foreach (GridViewRow gvRow in gvPendingGRN.Rows)
        {
            Label receiveID = (Label)gvRow.FindControl("lblReceiveID");
            CheckBox chk = (CheckBox)gvRow.FindControl("chkPost");
            if (chk.Checked)
            {
                DbManager dbMgr = new DbManager();
                SqlParameter[] sqlParm = { new SqlParameter("@ReceiveID", receiveID.Text), new SqlParameter("@PostVID", hdfVID.Value) };
                dbMgr.ExecuteNonQuery("uspUpdatePostReceiveVoucherID", "STOREConnectionString", sqlParm);
            }
        }
    }
    protected void updateCompleteVoucherID()
    {
        foreach (GridViewRow gvRow in gvPendingGRN.Rows)
        {
            Label receiveID = (Label)gvRow.FindControl("lblReceiveID");
            CheckBox chk = (CheckBox)gvRow.FindControl("chkComplete");
            if (chk.Checked)
            {
                DbManager dbMgr = new DbManager();
                SqlParameter[] sqlParm = { new SqlParameter("@ReceiveID", receiveID.Text), new SqlParameter("@CompleteVID", hdfVID.Value) };
                dbMgr.ExecuteNonQuery("uspUpdateCompleteReceiveVoucherID", "STOREConnectionString", sqlParm);
            }
        }
    }
    protected void btnComplateVoucher_Click(object sender, EventArgs e)
    {
        String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        try
        {
            SqlCommand cmd = new SqlCommand("usp_JV_Complete_GRN", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Dept_Id", Session["dept_id"]);
            cmd.Parameters.AddWithValue("@SubDept_Id", Session["SubDeptID"]);
            cmd.Parameters.AddWithValue("@By_Emp_Id", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Designation_Id", Session["DesignationID"]);
            cmd.Parameters.AddWithValue("@Amount", lblCompleteAmount.Text);
            cmd.Parameters.AddWithValue("@DrHead", ddlCompleteDr.SelectedValue);
            cmd.Parameters.AddWithValue("@CrHead", ddlCompleteCr.SelectedValue);
            cmd.Parameters.AddWithValue("@Company_Id", hfComapnyId.Value);
            cmd.Parameters.AddWithValue("@CompanyName", txtComapny.Text);
            cmd.Parameters.AddWithValue("@VID", SqlDbType.BigInt);
            cmd.Parameters["@VID"].Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            hdfVID.Value = cmd.Parameters["@VID"].Value.ToString();
            updateCompleteVoucherID();
            pnlComplete.Visible = false;
            bindGrid();
            lblComleteTotalAmount.Text = "0";
        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
    protected void lnkPostView_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        Session.Add("Voucher_Trans_ID", lnk.CommandArgument);
        string url = Server.MapPath("~/Finance/CReport_Recipt_Voucher.aspx");
        Response.Redirect(url);
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);

    }
    protected void lnkCompleteView_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        Session.Add("Voucher_Trans_ID", lnk.CommandArgument);
        string url = Server.MapPath("~/Finance/CReport_Recipt_Voucher.aspx");
        Response.Redirect(url);
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);
    }
    protected void bindPOHead()
    {
        DbManager dbMgr = new DbManager();
        string query = "SELECT        Expenditure.E_Code, Expenditure.E_Code + ' (' + Expenditure.E_Name + ')' AS E_Name FROM Expenditure INNER JOIN Head_Master_Table ON Expenditure.E_Code = Head_Master_Table.E_Code WHERE        (Head_Master_Table.Head_Type LIKE '%'+@Head_Type+'%')";
        SqlParameter[] sqlParm = { new SqlParameter("@Head_Type", "PO") };
        ddlPOHead.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "FinanceConnectionString", sqlParm);
        ddlPOHead.DataBind();
    }
}