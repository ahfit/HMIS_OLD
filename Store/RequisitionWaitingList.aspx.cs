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

public partial class RequisitionWaitingList : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();

    String constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    DataTable dt;
    protected void validate(string url, string dept)
    {

        if (Session["emp_id"] == null || Session["SubDeptId"] == null)
        {
            Response.Redirect("../login.aspx");
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //WebDateChooser_date_From.Value = DateTime.Now;
        //WebDateChooser_Date_To.Value = DateTime.Now;

        if (!IsPostBack)
        {
            WebDateChooser_date_From.Value = DateTime.Today.AddYears(-2);
            WebDateChooser_Date_To.Value = DateTime.Today.Date;
            HiddenField_from_date.Value = WebDateChooser_date_From.Value.ToString();
            HiddenField_to_Date.Value = WebDateChooser_Date_To.Value.ToString();
            HiddenField_DepartmentFrom.Value = "%";
            HiddenField_RequisitionNo.Value = "%";
            HiddenFiled_RequisitionFor.Value = "%";
            HiddenField_dept_ID.Value = Session["SubDeptId"].ToString();
            SqlDataSource_List.Select(DataSourceSelectArguments.Empty);
            GridView2.DataBind();
            //Response.Write(GridView2.Rows.Count.ToString());
        }

    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {

        if (GridView2.Rows.Count > 0)
        {
            foreach (GridViewRow Row in GridView2.Rows)
            {

                Label ib_id = (Label)Row.FindControl("Label1");
                LinkButton btnGenerate = (LinkButton)Row.FindControl("btnGenerateReq");
                HiddenField hdfOIB_ID = (HiddenField)Row.FindControl("hdfOldIB_ID");
                string ch = ib_id.Text.Substring(0, 3).ToUpper();
                LinkButton lbn_Remarks = (LinkButton)Row.FindControl("lbn_Remarks");
                LinkButton lnkbtnDetail = (LinkButton)Row.FindControl("lnkbtnDetail");
                HiddenField hfdremqty = (HiddenField)Row.FindControl("hfdremqty");
                if(Convert.ToInt32(hfdremqty.Value)>0)
                {
                    lbn_Remarks.Visible = true;
                    lnkbtnDetail.Visible = true;
                }
                else
                {
                    lbn_Remarks.Visible = false;
                    lnkbtnDetail.Visible = false;

                }
                if (ch == "IPO")
                {
                    Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#f6e1c5");//Color.RosyBrown;
                    //if (Convert.ToInt32(Session["Financial_Company_Id"]) == 1)
                    //{
                        btnGenerate.Visible = true;
                        if (hdfOIB_ID.Value != "NA")
                        {
                            btnGenerate.Text = "View";
                        }
                        else
                        {
                            btnGenerate.Text = "Generate Requisition";
                        }
                    //}
                }
            }
        }
    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lnk = sender as LinkButton;

        GridViewRow gr = lnk.NamingContainer as GridViewRow;

        HiddenField lblEmptyMessage = gr.FindControl("hdfCId") as HiddenField;
        Int32 PID;
        if (String.IsNullOrEmpty(lblEmptyMessage.Value))
        {
            PID = 0;
        }
        else
        {
            PID = Convert.ToInt32(lblEmptyMessage.Value);
        }
        
        LinkButton btnTemp = sender as LinkButton;
        String id = btnTemp.CommandArgument;
        string CID = Convert.ToString(Session["Company_Branch_Id"]);

        //if (id.Contains("IPO"))
        //{
            Response.Redirect("~/Store/IPOrderReport.aspx?QO_ID=" + id + "&PID=" + PID + "&CID=" + CID);
        //}
        //else
        //{
        //    Response.Redirect("~/Store/Requsition_Report.aspx?RequsitionNo=" + id);
        //}
    }

    protected void lbn_Remarks_Click(object sender, EventArgs e)
    {
        LinkButton lbl = (LinkButton)sender;
        HF_Re_ID.Value = lbl.CommandArgument;
        Lbl_Requisition_No.Text = HF_Re_ID.Value;
        Panel_Remarks.Visible = true;

    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        try
        {
            if (TextBox_Remarks.Text == "")
            {
                Label.Text = "Please Enter the Remarks First";
            }
            else
            {
                Sql_Remarks.Update();
                Label.Text = "Remarks Add successfully";
                // TextBox_Remarks.Text = "";
                btn_Save.Visible = false;
            }

        }

        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Remarks.Visible = false;
        Label.Visible = false;
        GridView2.DataBind();
    }
    protected void LBtn_Completed_Click(object sender, EventArgs e)
    {
        try
        {
            lbl_msg.Text = "";
            LinkButton lb = (LinkButton)sender;
            HF_Re_ID.Value = lb.CommandArgument;
            SqlDataSource_List.Update();
            GridView2.DataBind();

        }
        catch (Exception ex)
        {
            lbl_msg.Text = ex.InnerException.ToString() + "deletion";
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        HiddenField_from_date.Value = WebDateChooser_date_From.Value.ToString();
        HiddenField_to_Date.Value = WebDateChooser_Date_To.Value.ToString();
        HiddenFiled_RequisitionFor.Value = "%" + txtRequisitionFor.Text + "%";
        HiddenField_RequisitionNo.Value = "%" + txtIndentBookNo.Text + "%";
        HiddenField_DepartmentFrom.Value = "%" + txtFromDepartment.Text + "%";
        GridView2.DataBind();
    }

    protected void SqlDataSource_List_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        try
        {
            int x = 9;
        }
        catch (Exception ex)
        {

        }
    }

    protected void SqlDataSource_List_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        try
        {
            int x = 9;
        }
        catch (Exception ex)
        {

        }
    }


    protected void btnGenerateReq_Click(object sender, EventArgs e)
    {

        LinkButton btnTemp = sender as LinkButton;
        string IB_ID = btnTemp.CommandArgument;
        GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        HiddenField hdfCID = gvRow.FindControl("hdfCId") as HiddenField;
        HiddenField hdfOID = gvRow.FindControl("hdfOldIB_ID") as HiddenField;
        hdfComapnyId.Value = hdfCID.Value;
        hdfIBID.Value = IB_ID;
        if (btnTemp.Text == "Generate Requisition")
        {
            pnlGenReq.Visible = true;
            getCounter();
            gvItems.DataBind();
        }
        else
        {
            String path = "Requsition_Report.aspx?RequsitionNo=" + hdfOID.Value;
            Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + path + "','_newtab');", true);
        }
    }
    public void getCounter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Store_Indent_Book_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Dept_ID = @From_Dept_ID) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", Session["SubDeptID"]);
        int count;
        try
        {
            count = (int)command1.ExecuteScalar();
            HiddenField_YearlyCounter.Value = count.ToString();
        }
        catch (Exception ex)
        {
            count = 1;
            HiddenField_YearlyCounter.Value = "1";
        }
        con.Close();
        int len = count.ToString().Length;
        Labeb_Requisition_No.Text = "R" + DateTime.Today.Year + "-";
        while (len < 5)
        {
            Labeb_Requisition_No.Text += "0";
            len++;
        }
        Labeb_Requisition_No.Text += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
        HiddenField_counter.Value = Labeb_Requisition_No.Text;
    }
    protected void DropDownList_Department_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListStore.DataBind();

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (pnlGenReq.Visible == true)
        {
            if (DropDownListStore.SelectedValue != null)
            {
                try
                {
                    sdsGenerateReq.Insert();
                    insertSub();
                    SqlDataSource_Submit.Insert();
                    SqlDataSourceApprove.Insert();
                    Response.Redirect("Requsition_Report.aspx?RequsitionNo=" + Labeb_Requisition_No.Text);
                }
                catch (Exception ex)
                {
                    Label1.Text = "Some Error Occured while Processing.";
                    Label1.Visible = true;
                }
            }

        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnlGenReq.Visible = false;
    }
    protected void insertSub()
    {
        if (gvItems.Rows.Count > 0)
        {
            CheckBox chkItems;
            TextBox txtQty;
            HiddenField hfRate, hfItemCode;
            foreach(GridViewRow gvRow in gvItems.Rows)
            {
                chkItems = (CheckBox)gvRow.FindControl("cbItems");
                if (chkItems.Checked == true)
                {
                    txtQty = (TextBox)gvRow.FindControl("txtQty");
                    hfItemCode = (HiddenField)gvRow.FindControl("hdfItemCode");
                    hfRate = (HiddenField)gvRow.FindControl("hdfItemRate");

                    sdsItems.InsertParameters["Item_Code"].DefaultValue = hfItemCode.Value;
                    sdsItems.InsertParameters["Item_Qty"].DefaultValue = txtQty.Text;
                    sdsItems.InsertParameters["Item_Rate"].DefaultValue = hfRate.Value;
                    sdsItems.Insert();
                }
            }
        }
    }

    protected void gvItems_PreRender(object sender, EventArgs e)
    {
        if (gvItems.Rows.Count>0)
        {

        foreach (GridViewRow gvRow in gvItems.Rows)
        {
            CheckBox chkItems = (CheckBox)gvRow.FindControl("cbItems");
            if (gvItems.Rows.Count == 1)
            {
                chkItems.Enabled = false;
            }
        }

        }
    }

    protected void lnkbtnDetail_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        Response.Redirect("~/Store/IssueItemsExternal.aspx?RequisitionID="+btn.CommandArgument+"&Shift="+btn.ToolTip);
    }
}
