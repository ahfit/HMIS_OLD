using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Net.Mail;
using Megaplus.Finance;
using System.IO;
using Microsoft.Reporting.WebForms;
using System.Text;

public partial class Store_Approve_Demand_Requisition_Request : System.Web.UI.Page
{
    String con = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if( !Page.IsPostBack)
        {
            FormView1.DataBind();
            HiddenField isApproved=(HiddenField)FormView1.FindControl("hdfApprovalStatus");
            if(isApproved.Value=="1")
            {
                btnApprove.Visible = false;
                btnReject.Visible = false;
                btnhold.Visible = false;
            }
            else if(isApproved.Value == "")
            {
                btnApprove.Visible = false;
                btnReject.Visible = false;
                btnhold.Visible = false;
            }
            else
            {
                if (checkIsApproved() == true)
                {
                    btnApprove.Visible = false;
                    btnReject.Visible = false;

                }
                else
                {
                    btnApprove.Visible = true;
                    btnReject.Visible = true;

                }
            }

        }

    }
    public bool checkIsApproved()
    {
        bool val = false;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        con.Open();
        SqlCommand command = new SqlCommand("Select Approved_Status  From Approval_Request_For_Demand Where Requisition_ID=@IB_ID and Send_To=@EmpID", con);
        command.Parameters.AddWithValue("@IB_ID", Request.QueryString["RQ_ID"]);
        command.Parameters.AddWithValue("@EmpID", Session["Emp_id"]);
        SqlDataAdapter da = new SqlDataAdapter(command);
        DataTable dt = new DataTable();
        da.Fill(dt);

        con.Close();
        if (dt.Rows[0][0].ToString() == "Approved")
        {
            val = true;
        }
        else
        {
            val = false;
        }
        return val;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlSendTo.Items.Count == 0)
                return;

            sqlDs_RequistionDetail.InsertParameters["Requisition_ID"].DefaultValue = Request.QueryString["RQ_ID"];
            sqlDs_RequistionDetail.InsertParameters["Send_By"].DefaultValue = Session["emp_id"].ToString();
            sqlDs_RequistionDetail.InsertParameters["Send_By_Sub_Dept_Id"].DefaultValue = Session["SubDeptId"].ToString();
            sqlDs_RequistionDetail.InsertParameters["Send_To"].DefaultValue = ddlSendTo.SelectedValue;
            sqlDs_RequistionDetail.InsertParameters["Send_To_Sub_Dept_Id"].DefaultValue = "0";
            sqlDs_RequistionDetail.InsertParameters["SendDate"].DefaultValue = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
            sqlDs_RequistionDetail.InsertParameters["Requisition_Remarks"].DefaultValue = txtRemarks.Text;
            sqlDs_RequistionDetail.InsertParameters["Parent_Approval_Request_Id"].DefaultValue = GetParentRequestID();
            sqlDs_RequistionDetail.InsertParameters["Approved_Status"].DefaultValue = "Pending";
            sqlDs_RequistionDetail.InsertParameters["Approved_Date"].DefaultValue = DBNull.Value.ToString();
            sqlDs_RequistionDetail.InsertParameters["Request_Level"].DefaultValue = GetPersonLevel();
            sqlDs_RequistionDetail.Insert();
            lbl_f_.Text = ddlSendTo.SelectedItem.Text.Substring(0, ddlSendTo.SelectedItem.Text.Length - 5);
        }
        catch
        {
        }
    }
    private string GetPersonLevel()
    {
        string retVal = string.Empty;
        string level = ddlSendTo.SelectedItem.Text;
        int indx = 0;
        indx = level.IndexOf("(");
        if (indx != -1)
        {
            retVal = level.Substring(indx + 1);
            retVal = retVal.Replace(")", "");
        }

        return retVal;
    }
    private string GetParentRequestID()
    {
        try
        {
            return Request.QueryString["PID"];
        }
        catch (Exception)
        {

            return "0";
        }
    }
    protected void btnSaveQuantity_Click(object sender, EventArgs e)
    {


        //   Updating Main
        try
        {
            SqlDataSource1.UpdateParameters["Demand_RQ_ID"].DefaultValue = Request.QueryString["RQ_ID"] as string;
           // SqlDataSource1.UpdateParameters["IsGST"].DefaultValue = CKGST.Checked.ToString();
            SqlDataSource1.UpdateParameters["GST"].DefaultValue = TXT_GST.Text;
            //SqlDataSource1.UpdateParameters["ISWHT"].DefaultValue = CKWHT.Checked.ToString();
            SqlDataSource1.UpdateParameters["WHTax"].DefaultValue = TXT_WHT.Text;
            //SqlDataSource1.UpdateParameters["ISITax"].DefaultValue = CKIncometax.Checked.ToString();
            SqlDataSource1.UpdateParameters["ITax"].DefaultValue = TXT_IT.Text;
            //SqlDataSource1.UpdateParameters["isOtherTax"].DefaultValue = CKoTHER.Checked.ToString();
            SqlDataSource1.UpdateParameters["OtherTax"].DefaultValue = TXT_oTHER.Text;
            SqlDataSource1.Update();
            //   Updating Sub
            HiddenField hfld_RQ_ID = null;
            HiddenField hfld_Item_Code = null;
            TextBox txtNewQty = null;
            TextBox txtRate = null;
            TextBox txtDiscount = null;
            TextBox txtTotalAmount = null;
            TextBox po = null;
            TextBox txtRebate = null;

            foreach (GridViewRow grow in gvRequistionDetail.Rows)
            {
                hfld_RQ_ID = grow.FindControl("hfld_RQ_ID") as HiddenField;
                hfld_Item_Code = grow.FindControl("hfld_Item_Code") as HiddenField;
                txtNewQty = grow.FindControl("txtNewQty") as TextBox;
                txtRate = grow.FindControl("txtRate") as TextBox;
                txtDiscount = grow.FindControl("txtDiscount") as TextBox;
                txtTotalAmount = grow.FindControl("txtTotalAmount") as TextBox;
                po = grow.FindControl("txtPO") as TextBox;
                txtRebate = grow.FindControl("txtRebate") as TextBox;
                sqlDs_RequistionDetail.UpdateParameters["Qty"].DefaultValue = txtNewQty.Text;
                sqlDs_RequistionDetail.UpdateParameters["Demand_RQ_ID"].DefaultValue = hfld_RQ_ID.Value;
                sqlDs_RequistionDetail.UpdateParameters["Item_Code"].DefaultValue = hfld_Item_Code.Value;
                sqlDs_RequistionDetail.UpdateParameters["Rate"].DefaultValue = txtRate.Text;
                sqlDs_RequistionDetail.UpdateParameters["Discount"].DefaultValue = txtDiscount.Text;
                sqlDs_RequistionDetail.UpdateParameters["Amount"].DefaultValue = txtTotalAmount.Text;
                sqlDs_RequistionDetail.UpdateParameters["Purchase"].DefaultValue = po.Text;
                sqlDs_RequistionDetail.UpdateParameters["Rebate"].DefaultValue = po.Text;
                sqlDs_RequistionDetail.Update();

            }
            lbl_msg.Text = "Demand Updated Susscessfully...";
            HF_Load_back.Value = "1";
        }
        catch (Exception ex)
        {
            lbl_msg.Text = "An Error Occur while updating...";
        }
        
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            sqlDs_Approve.UpdateParameters["Approval_Remarks"].DefaultValue = txtApprovalRemarks.Text;
            sqlDs_Approve.UpdateParameters["Approved_Date"].DefaultValue = DateTime.Now.ToString("yyyy/MM/dd hh:mm:ss");
            sqlDs_Approve.UpdateParameters["Approval_Request_Id"].DefaultValue = Request.QueryString["PID"];
            sqlDs_Approve.Update();
            
            lbl_approve.Text = "Approved ... ";
            gvRequisitionApprovalLevels.DataBind();
            DataList_Requisition_Remarks.DataBind();
            btnReject.Visible = false;
            btnhold.Visible = false;
        }
        catch
        {

        }
    }
    protected void btnReject_Click(object sender, EventArgs e)
    {
        try
        {
            sqlDs_Reject.UpdateParameters["Remarks"].DefaultValue = txtRejectedReason.Text;
            sqlDs_Reject.UpdateParameters["Demand_RQ_ID"].DefaultValue = Request.QueryString["RQ_ID"];
            sqlDs_Reject.UpdateParameters["Parent_Request_Id"].DefaultValue = Request.QueryString["PID"];
            sqlDs_Reject.Update();
            lbl_reject.Text = "Rejected ...";
            btnReject.Visible = false;
            btnhold.Visible = false;
            btnApprove.Visible = false;
        }
        catch
        {
        }
    }
    protected void gvRequisitionApprovalLevels_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblColor = null;
        HiddenField hfldColor = null;

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            lblColor = e.Row.FindControl("lblColor") as Label;
            hfldColor = (HiddenField)e.Row.FindControl("hfldColor");

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
    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {
        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
        txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
        txtRate = gvRow.FindControl("txtRate") as TextBox;
        txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
        if (txtDiscount.Text.Trim() != "")
        {
            if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
            {
                txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
            }
        }
        else
        {
            txtDiscount.Text = "0";

        }
    }
    protected void txtRate_TextChanged(object sender, EventArgs e)
    {

        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;


        TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
        txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
        txtRate = gvRow.FindControl("txtRate") as TextBox;
        txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
        if (txtRate.Text.Trim() != "")
        {
            if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
            {
                txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
                txtDiscount.Focus();
            }
        }
        else
        {
            txtRate.Text = "0";
            txtTotalAmount.Text = "0";
        }


    }
    protected void txtNewQty_TextChanged(object sender, EventArgs e)
    {
        double units, rateUnit, discount;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        TextBox txtNewQty, txtRate, txtDiscount, txtTotalAmount;
        txtNewQty = gvRow.FindControl("txtNewQty") as TextBox;
        txtRate = gvRow.FindControl("txtRate") as TextBox;
        txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        txtTotalAmount = gvRow.FindControl("txtTotalAmount") as TextBox;
        if (txtNewQty.Text.Trim() != "")
        {
            if (double.TryParse(txtNewQty.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(txtDiscount.Text, out discount))
            {
                txtTotalAmount.Text = Convert.ToString((units * rateUnit) - discount);
                txtRate.Focus();
            }
        }
        else
        {
            txtNewQty.Text = "0";
            txtTotalAmount.Text = "0";
        }
    }
    protected void gvRequistionDetail_PreRender(object sender, EventArgs e)
    {
        decimal TotalAmount = 0;
        HiddenField lqty = new HiddenField();
        HiddenField lUSRate = new HiddenField();
        HiddenField lDiscount = new HiddenField();
        HiddenField lTSamount = new HiddenField();
        HiddenField lUPRate = new HiddenField();
        HiddenField lRebate = new HiddenField();
        TextBox qty = new TextBox();
        TextBox USRate = new TextBox();
        TextBox Discount = new TextBox();
        TextBox TSamount = new TextBox();
        TextBox UPRate = new TextBox();
        TextBox Rebate = new TextBox();
        Label TPCost = new Label();
        Label RAmount = new Label();
        Label NetCost = new Label();
        Label Profit = new Label();
        
        if (gvRequistionDetail.Rows.Count > 0)
        {
            foreach (GridViewRow Row in gvRequistionDetail.Rows)
            {
                TSamount = Row.FindControl("txtTotalAmount") as TextBox;
               
                if (!Page.IsPostBack ) 
                {

                    lqty = Row.FindControl("hfld_qty") as HiddenField;
                    lUSRate = Row.FindControl("hfld_Rate") as HiddenField;
                    lDiscount = Row.FindControl("hfld_Discount") as HiddenField;
                    lTSamount = Row.FindControl("hfid_Total_Amount_Sale") as HiddenField;
                    lUPRate = Row.FindControl("hfid_Purchase_rate") as HiddenField;
                    lRebate = Row.FindControl("hfid_Rebate") as HiddenField;

                    qty = Row.FindControl("txtNewQty") as TextBox;
                    USRate = Row.FindControl("txtRate") as TextBox;
                    Discount = Row.FindControl("txtDiscount") as TextBox;
                    
                    UPRate = Row.FindControl("txtPO") as TextBox;
                    Rebate = Row.FindControl("txtRebate") as TextBox;

                    qty.Text = lqty.Value;
                    USRate.Text = Convert.ToDouble(lUSRate.Value).ToString("#,##.##");
                    Discount.Text = lDiscount.Value;
                    TSamount.Text = Convert.ToDouble(lTSamount.Value).ToString("#,##.##");
                    UPRate.Text = lUPRate.Value;
                    Rebate.Text = lRebate.Value;
                    
                    calCost(Row);

                }
                
                if (!String.IsNullOrEmpty(TSamount.Text))
                {
                    TotalAmount = TotalAmount + Convert.ToDecimal(TSamount.Text);
                }
                HF_Load_back.Value = "0";
            }
            

        }
        if (TotalAmount.ToString()!="0")
        {
            Txt_Total.Text = TotalAmount.ToString("#,##.##");
        }
       
        Calculate();
    }
    //protected void CKGST_CheckedChanged(object sender, EventArgs e)
    //{

    //    TXT_GST.Enabled = CKGST.Checked;
    //    if (!CKGST.Checked)
    //    {
    //        TXT_GST.Text = "0";
    //    }
    //}
    //protected void CKWHT_CheckedChanged(object sender, EventArgs e)
    //{
    //    TXT_WHT.Enabled = CKWHT.Checked;
    //    if (!CKWHT.Checked)
    //    {
    //        TXT_WHT.Text = "0";
    //    }
    //}
    //protected void CKIncometax_CheckedChanged(object sender, EventArgs e)
    //{
    //    TXT_IT.Enabled = CKIncometax.Checked;
    //    if (!CKIncometax.Checked)
    //    {
    //        TXT_IT.Text = "0";
    //    }
    //}
    //protected void CKoTHER_CheckedChanged(object sender, EventArgs e)
    //{
    //    TXT_oTHER.Enabled = CKoTHER.Checked;

    //    if (!CKoTHER.Checked)
    //    {
    //        TXT_oTHER.Text = "0";
    //    }
    //}
    protected void TXT_TaxChanged(object sender, EventArgs e)
    {
        TextBox percent = sender as TextBox;
        try
        {
            if (Convert.ToDouble(percent.Text) > 100)
            {
                percent.Text = "100";
            }

        }
        catch
        {
            percent.Text = "0";
        }
        Calculate();
    }
    private void Calculate()
    {
        Decimal gst = 0, wht = 0, IT = 0, other = 0, TOTAL = Convert.ToDecimal(Txt_Total.Text.Trim());
        if (string.IsNullOrEmpty(TXT_GST.Text.Trim()))
        {
            TXT_GST.Text = "0";

        }
        else
        {
            if (TXT_GST.Text.Trim() != "0")
            {
                gst = TOTAL * Convert.ToDecimal(TXT_GST.Text.Trim()) / 100;
            }
        }
        if (string.IsNullOrEmpty(TXT_WHT.Text.Trim()))
        {
            TXT_WHT.Text = "0";
        }
        else
        {
            if (TXT_WHT.Text.Trim() != "0")
            {
                wht = TOTAL * Convert.ToDecimal(TXT_WHT.Text.Trim()) / 100;
            }
        }
        if (string.IsNullOrEmpty(TXT_IT.Text.Trim()))
        {
            TXT_IT.Text = "0";
        }
        else
        {
            if (TXT_IT.Text.Trim() != "0")
            {
                IT = TOTAL * Convert.ToDecimal(TXT_IT.Text.Trim()) / 100;
            }
        }
        if (string.IsNullOrEmpty(TXT_oTHER.Text.Trim()))
        {
            TXT_oTHER.Text = "0";
        }
        else
        {
            if (TXT_oTHER.Text.Trim() != "0")
            {
                other = TOTAL * Convert.ToDecimal(TXT_oTHER.Text.Trim()) / 100;
            }
        }


        TxtFTamount.Text = (TOTAL + gst + wht + IT + other).ToString("#,#");
    }

    protected void FormView1_PreRender(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
        if (FormView1.PageCount > 0)
        {

            FormView1.AllowPaging = false;
            HiddenField ck_gst = FormView1.FindControl("hf_isgst") as HiddenField;
            HiddenField txtgst = FormView1.FindControl("hf_gst") as HiddenField;
            HiddenField ck_wht = FormView1.FindControl("hf_iswht") as HiddenField;
            HiddenField txtwht = FormView1.FindControl("hf_wht") as HiddenField;
            HiddenField ck_IT = FormView1.FindControl("hf_isit") as HiddenField;
            HiddenField txtIT = FormView1.FindControl("hf_it") as HiddenField;
            HiddenField ck_OT = FormView1.FindControl("hf_isother") as HiddenField;
            HiddenField txtOT = FormView1.FindControl("hf_other") as HiddenField;
           // CKGST.Checked = Convert.ToBoolean(ck_gst.Value);
            if (string.IsNullOrEmpty(txtgst.Value))
            {
                TXT_GST.Text = "0";
            }
            else
            {
                TXT_GST.Text = txtgst.Value;
                TXT_GST.Enabled = true;
            }
           // CKWHT.Checked = Convert.ToBoolean(ck_wht.Value);

            if (string.IsNullOrEmpty(txtwht.Value))
            {
               TXT_WHT.Text = "0";
            }
            else
            {
                TXT_WHT.Text = txtwht.Value;
                TXT_WHT.Enabled = true;

            }
            //CKIncometax.Checked = Convert.ToBoolean(ck_IT.Value);
            if (string.IsNullOrEmpty(txtIT.Value))
            {
                TXT_IT.Text = "0";
            }
            else
            {
                TXT_IT.Text = txtIT.Value;
                TXT_IT.Enabled = true;
            }
            //CKoTHER.Checked = Convert.ToBoolean(ck_OT.Value);
            
            if (string.IsNullOrEmpty(txtIT.Value))
            {
                TXT_oTHER.Text = "0";
            }
            else
            {
                TXT_oTHER.Text = txtOT.Value;
                TXT_oTHER.Enabled = true;
            }
         
        
        }
            
        }
    }
   
    private void UpdateBalanceData(DataSet data)
    {
        decimal runTotal = 0, currentValue = 0;
        Boolean isFirstPass = true;
        if (data.Tables[0].Rows.Count == 0)
        {
            return;
        }

        runTotal = Convert.ToDecimal(data.Tables[0].Rows[0]["Balance"].ToString());

        foreach (DataTable dt in data.Tables)
        {
            foreach (DataRow dr in dt.Rows)
            {
                if (isFirstPass == true)
                {
                    isFirstPass = false;
                    continue;
                }

                currentValue = Math.Abs(Convert.ToDecimal(dr["Balance"].ToString()));
                if (runTotal < 0)
                {
                    dr["balance"] = 0;
                }
                else if (currentValue == 0)
                {
                    continue;
                }
                else if (runTotal - currentValue < 0)
                {
                    dr["Balance"] = runTotal;
                    runTotal = 0;
                }
                else if (runTotal == 0)
                {
                    dr["balance"] = 0;
                }
                else if (runTotal - currentValue > 0)
                {
                    runTotal = runTotal - currentValue;
                }

            }

        }
    }
    private decimal GetBalance(DataSet dsTemp, int rowId)
    {
        decimal retVal = 0;

        try
        {
            switch (rowId)
            {
                case 1:
                    if (dsTemp.Tables[0].Rows[rowId - 1][0].ToString() == "Current")
                    {
                        retVal = Convert.ToDecimal(dsTemp.Tables[0].Rows[rowId - 1]["Balance"].ToString());
                    }
                    break;
                case 2:
                    if (dsTemp.Tables[0].Rows[rowId - 1][0].ToString() == "30 Days")
                    {
                        retVal = Convert.ToDecimal(dsTemp.Tables[0].Rows[rowId - 1]["Balance"].ToString());
                    }
                    break;
                case 3:
                    if (dsTemp.Tables[0].Rows[rowId - 1][0].ToString() == "60 Days")
                    {
                        retVal = Convert.ToDecimal(dsTemp.Tables[0].Rows[rowId - 1]["Balance"].ToString());
                    }
                    break;
                case 4:
                    if (dsTemp.Tables[0].Rows[rowId - 1][0].ToString() == "90 Days")
                    {
                        retVal = Convert.ToDecimal(dsTemp.Tables[0].Rows[rowId - 1]["Balance"].ToString());
                    }
                    break;
                case 5:
                    if (dsTemp.Tables[0].Rows[rowId - 1][0].ToString() == "Earlier")
                    {
                        retVal = Convert.ToDecimal(dsTemp.Tables[0].Rows[rowId - 1]["Balance"].ToString());
                    }
                    break;

            }
        }
        catch
        {
            return retVal;
        }
        if (string.IsNullOrEmpty(retVal.ToString()))
        {
            retVal = 0;
        }
        return retVal;
    }

    private string GetCompanyInvoicePayData(DataSet data, string field)
    {
        string retVal = String.Empty;

        if (field == "CR")
        {
            return Convert.ToDecimal(data.Tables[0].Rows[0]["Credit_Limit"].ToString()).ToString("#,#0.00");
        }
        else if (field == "INV")
        {
            if (Convert.ToDateTime(data.Tables[0].Rows[0]["Invoice_Date"].ToString()).ToString("yyyy-MM-dd") == "9999-09-09")
            {
                retVal = String.Empty;
            }
            else
            {
                retVal = Convert.ToDecimal(data.Tables[0].Rows[0]["Invoice_Amount"].ToString()).ToString("#,#0.00") + " ( " + Convert.ToDateTime(data.Tables[0].Rows[0]["Invoice_Date"].ToString()).ToString("dd MMM yyyy") + " ) ";
            }
        }
        else if (field == "PAY")
        {
            if (Convert.ToDateTime(data.Tables[0].Rows[0]["Payment_Date"].ToString()).ToString("yyyy-MM-dd") == "9999-09-09")
            {
                retVal = String.Empty;
            }
            else
            {
                retVal = Convert.ToDecimal(data.Tables[0].Rows[0]["Pay_Amount"].ToString()).ToString("#,#0.00") + " ( " + Convert.ToDateTime(data.Tables[0].Rows[0]["Payment_Date"].ToString()).ToString("dd MMM yyyy") + " ) ";
            }
        }
        return retVal;
    }
    private int CompanyBranchID
    {
        get
        {
            try
            {
                return 0;
                    //Convert.ToInt32(Session["Company_Branch_Id"]);
            }
            catch
            {
                return 0;
            }
        }
    }
    private int PartyID
    {
        get
        {
            try
            {
                int pId = 0;
                String connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
                SqlConnection con = new SqlConnection(connection1);
                con.Open();
                String command = "Select Company_ID From Demand_Requisition_Main Where Demand_RQ_ID=@Demand_RQ_ID";
                SqlCommand cmd = new SqlCommand(command, con);
                cmd.Parameters.AddWithValue("@Demand_RQ_ID", Request.QueryString["RQ_ID"]);
                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["Company_ID"].ToString() != null)
                    {
                        pId = Convert.ToInt32(dr["Company_ID"].ToString());
                    }
                    else
                    {
                        pId = 0;
                    }
                }
                return pId;
            }
            catch
            {
                return 0;
            }
        }
    }
    protected void txtRebate_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        
        calCost(row);
    }


    protected void txtPO_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = sender as TextBox;
        GridViewRow row = txt.NamingContainer as GridViewRow;
       
        calCost(row);
    }
    protected void calCost(GridViewRow row) {
        decimal Camount = 0,RAmount = 0;
        TextBox txCostUnit = row.FindControl("txtPO") as TextBox;
        TextBox txtNewQty = row.FindControl("txtNewQty") as TextBox;
        TextBox txtRebate = row.FindControl("txtRebate") as TextBox;
        Label lbl_TCost = row.FindControl("LBL_Total_Cost") as Label;
        Label lbl_TRebate = row.FindControl("LBL_Total_Rebate") as Label;
        Label lbl_N_cost = row.FindControl("LBL_Total_NetCost") as Label;


        if (string.IsNullOrEmpty(txCostUnit.Text.Trim()))
        {
            txCostUnit.Text = "0";
        }
        if (string.IsNullOrEmpty(txtNewQty.Text.Trim()))
        {
            txtNewQty.Text = "0";
        }
        if (string.IsNullOrEmpty(txtRebate.Text.Trim()))
        {
            txtRebate.Text = "0";
        }
        Camount = Convert.ToDecimal(txCostUnit.Text) * Convert.ToDecimal(txtNewQty.Text);
        lbl_TCost.Text = Camount.ToString();
        RAmount = Camount*Convert.ToDecimal(txtRebate.Text)/100;
        lbl_TRebate.Text = RAmount.ToString();
        lbl_N_cost.Text = (Camount - RAmount).ToString();
    }





    protected void btnhold_Click(object sender, EventArgs e)
    {
     
        try
        {
            sqlDs_Hold.UpdateParameters["Remarks"].DefaultValue = txtHoldRemarks.Text;
            sqlDs_Hold.UpdateParameters["Demand_RQ_ID"].DefaultValue = Request.QueryString["RQ_ID"];
            sqlDs_Hold.UpdateParameters["Parent_Request_Id"].DefaultValue = Request.QueryString["PID"];
            sqlDs_Hold.Update();
            lbl_Hold.Text = "On Hold ...";
            btnReject.Visible = false;
            btnhold.Visible = false;
            btnApprove.Visible = false;
        }
        catch
        {
        }
    
}

    protected void Changebtn_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        string itemcode = btn.CommandArgument;
        txtItemCodeOld.Text = itemcode;
        pnlChangeCode.Visible = true;
    }

    protected void btnclose_Click(object sender, EventArgs e)
    {
        pnlChangeCode.Visible = false;
        gvRequistionDetail.DataBind();
    }

    protected void btnUpDATE_Click(object sender, EventArgs e)
    {
        string olditemcode = txtItemCodeOld.Text;
        string newitemcode = txtItemCodeNew.Text;
        SqlConnection sq = new SqlConnection(con);
        sq.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("usp_ChangeItemCode", sq);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IB_ID", Request.QueryString["RQ_ID"]);
            cmd.Parameters.AddWithValue("@OldItemCode", olditemcode);
            cmd.Parameters.AddWithValue("@NewItemCode", newitemcode);
            cmd.Parameters.Add("@remarks", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            sq.Close();

            if (cmd.Parameters["@remarks"].Value.ToString() == "1")
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Failed! Both Items are Not From Same Category.";
            }
            else if (cmd.Parameters["@remarks"].Value.ToString() == "0")
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Item Updated Successfully!";
            }

        }
        catch (Exception ex)
        {

            sq.Close();
        }

    }
    protected void btn_delete_Click(object sender, EventArgs e)
    {
    
              Button btn = sender as Button;   
              GridViewRow gvRow = btn.NamingContainer as GridViewRow;
              HiddenField hf_reqId = gvRow.FindControl("hfld_RQ_ID") as HiddenField;
              HiddenField hf_itemcode = gvRow.FindControl("hfld_Item_Code") as HiddenField ;
             
              SqlConnection sq = new SqlConnection(con);
              sq.Open();
              try
              {

                  SqlCommand cmd;
                  cmd = new SqlCommand("usp_DeleteItem", sq);
                  cmd.CommandType = CommandType.StoredProcedure;
                  cmd.Parameters.AddWithValue("@ReqId", Request.QueryString["RQ_ID"]);
                  cmd.Parameters.AddWithValue("@ItemCode", hf_itemcode.Value);
                  cmd.ExecuteNonQuery();
                  sq.Close();
                  gvRequistionDetail.DataBind();

              }
              catch (Exception ex)
              {

                  sq.Close();
              }
                
              
     }

    protected void btnconsumption_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<script language=\'javascript\'>");
        sb.Append((" window.open(\'ConsumptionAgingReport.aspx?RQ_ID=" + Request.QueryString["RQ_ID"] + "\' )</script>"));
        Type t = this.GetType();
        if (!ClientScript.IsClientScriptBlockRegistered(t, "PopupScript"))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString());
        }
      
    }

    protected void gvRequistionDetail_Load(object sender, EventArgs e)
    {
        int rows = gvRequistionDetail.Rows.Count;
        if (rows > 1)
        {
            foreach (GridViewRow gv in gvRequistionDetail.Rows)
            {
                Button btndelete = gv.FindControl("btn_delete") as Button;
                btndelete.Visible = true;
            }
        }
        else
        {
            foreach (GridViewRow gv in gvRequistionDetail.Rows)
            {
                Button btndelete = gv.FindControl("btn_delete") as Button;
                btndelete.Visible = false;
            }
        }


    }
}