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

public partial class Store_Approve_Requisition_Request : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        
        FormView1.DataBind();
        HiddenField isApproved = (HiddenField)FormView1.FindControl("hdfApprovalStatus");
        if (isApproved.Value == "1")
        {
            btnApprove.Visible = false;
            btnReject.Visible = false;
            btnhold.Visible = false;
        }
        else if (isApproved.Value == "")
        {
            btnApprove.Visible = false;
            btnReject.Visible = false;
            btnhold.Visible = false;
        }
        else
        {
            if (checkIsApproved()==true)
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
    public bool checkIsApproved()
    {
        bool val = false;
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("Select Approved_Status  From Approval_Request Where Requisition_ID=@IB_ID and Send_To=@EmpID and Approval_Request_Id=@ReqId", con);
        command.Parameters.AddWithValue("@IB_ID", Request.QueryString["IB_ID"]);
        command.Parameters.AddWithValue("@ReqId", Request.QueryString["PID"]);
        command.Parameters.AddWithValue("@EmpID", Session["Emp_id"]);
        SqlDataAdapter da=new SqlDataAdapter(command);
        DataTable dt=new DataTable();
        da.Fill(dt);
        
        con.Close();
        if(dt.Rows[0][0].ToString()=="Approved")
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

        if (ddlSendTo.Items.Count == 0)
        {
            Lbl_F_approval.Text = "No Forwarding Possible";
            return;
        }
        sqlDs_RequistionDetail.InsertParameters["Requisition_ID"].DefaultValue = Request.QueryString["IB_ID"];
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
        Lbl_F_approval.Text = "Forwarded to " + ddlSendTo.SelectedItem.Text.Substring(0, ddlSendTo.SelectedItem.Text.Length - 5);

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
        HiddenField hfld_IB_ID = null;
        HiddenField hfld_Item_Code = null;
        TextBox txtNewQty = null;

        foreach (GridViewRow grow in gvRequistionDetail.Rows)
        {
            hfld_IB_ID = grow.FindControl("hfld_IB_ID") as HiddenField;
            hfld_Item_Code = grow.FindControl("hfld_Item_Code") as HiddenField;
            txtNewQty = grow.FindControl("txtNewQty") as TextBox;

            sqlDs_RequistionDetail.UpdateParameters["Qty"].DefaultValue = txtNewQty.Text;
            sqlDs_RequistionDetail.UpdateParameters["IB_ID"].DefaultValue = hfld_IB_ID.Value;
            sqlDs_RequistionDetail.UpdateParameters["Item_Code"].DefaultValue = hfld_Item_Code.Value;
            sqlDs_RequistionDetail.Update();

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
            btnApprove.Visible = false;
            Lbl_approve.Text = "Approved ...";
            gvRequisitionApprovalLevels.DataBind();
            DataList_Requisition_Remarks.DataBind();
            btnReject.Visible = false;

        }
        catch (Exception ex)
        {
            Lbl_approve.Text = "Error ...";

        }
       
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        sqlDs_Reject.UpdateParameters["Remarks"].DefaultValue = txtRejectedReason.Text;
        sqlDs_Reject.UpdateParameters["IB_ID"].DefaultValue = Request.QueryString["IB_ID"];
        sqlDs_Reject.UpdateParameters["Parent_Request_Id"].DefaultValue = Request.QueryString["PID"];
        sqlDs_Reject.Update();
        lbl_Reject.Text = "Rejected ... ";
        btnReject.Visible = false;
        btnhold.Visible = false;
        btnApprove.Visible = false;
    }

    protected void gvRequisitionApprovalLevels_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblColor = null;
        HiddenField hfldColor = null;
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
          
            lblColor = e.Row.FindControl("lblColor") as Label;
            hfldColor = e.Row.FindControl("hfldColor") as HiddenField;

            if(hfldColor.Value == "Red")
                lblColor.BackColor = System.Drawing.Color.Red;
            else if (hfldColor.Value == "Green")
                lblColor.BackColor = System.Drawing.Color.Green;
            else if (hfldColor.Value == "Blue")
                lblColor.BackColor = System.Drawing.Color.Blue;
            else if (hfldColor.Value == "Maroon")
                lblColor.BackColor = System.Drawing.Color.Maroon;

        }
       
     
    }

    protected void btnrETURN_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Store/SearchIPO_Approved.aspx");
    }
    protected void gvRequistionDetail_PreRender(object sender, EventArgs e)
    {
        if (gvRequistionDetail.Rows.Count > 0)
        {


            Label totalAmount = null;
            Label grandTotal = null;
            Double  total = 0;
            foreach (GridViewRow grow in gvRequistionDetail.Rows)
            {
                totalAmount = grow.FindControl("lblTotalAmount") as Label;
                try
                {
                    total = total + Convert.ToDouble(totalAmount.Text);
                }
                catch (Exception ex)
                {

                    total = total + 0;
                }
              
            }
            grandTotal = gvRequistionDetail.FooterRow.FindControl("lblTotalAmount") as Label;
            grandTotal.Text = total.ToString("#,##.##");
        }
    }


    protected void btnhold_Click(object sender, EventArgs e)
    {

        try
        {
            sqlDs_Hold.UpdateParameters["Remarks"].DefaultValue = txtHoldRemarks.Text;
            sqlDs_Hold.UpdateParameters["IB_ID"].DefaultValue = Request.QueryString["IB_ID"];
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
    protected void btnconsumption_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<script language=\'javascript\'>");
        sb.Append((" window.open(\'demad/ConsumptionAgingReport.aspx?RQ_ID=" + Request.QueryString["IB_ID"] + "\' )</script>"));
        Type t = this.GetType();
        if (!ClientScript.IsClientScriptBlockRegistered(t, "PopupScript"))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString());
        }
        else
        {
            Response.Redirect("~/store/demad/ConsumptionAgingReport.aspx?RQ_ID=" + Request.QueryString["IB_ID"] +"");
        }
            
        
    }

    protected void btndelete_Click(object sender, EventArgs e)
    { 
        String con = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        Button btn = sender as Button;
        GridViewRow gvRow = btn.NamingContainer as GridViewRow;
        HiddenField hf_reqId = gvRow.FindControl("hfld_IB_ID") as HiddenField;
        HiddenField hf_itemcode = gvRow.FindControl("hfld_Item_Code") as HiddenField;

        SqlConnection sq = new SqlConnection(con);
        sq.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("usp_DeleteItemReq", sq);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IB_ID", hf_reqId.Value);
            cmd.Parameters.AddWithValue("@Item_Code", hf_itemcode.Value);
            cmd.ExecuteNonQuery();
            sq.Close();
            gvRequistionDetail.DataBind();

        }
        catch (Exception ex)
        {

            sq.Close();
        }
}



    

    protected void gvRequistionDetail_Load1(object sender, EventArgs e)
    {
        int rows = gvRequistionDetail.Rows.Count;
        if (rows > 1)
        {
            foreach (GridViewRow gv in gvRequistionDetail.Rows)
            {
                Button btndelete = gv.FindControl("btndelete") as Button;
                btndelete.Visible = true;
            }
        }
        else
        {
            foreach (GridViewRow gv in gvRequistionDetail.Rows)
            {
                Button btndelete = gv.FindControl("btndelete") as Button;
                btndelete.Visible = false;
            }
        }

    }
    protected void updtQty_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        string ItemCode = btn.CommandArgument;
        GridViewRow row = btn.NamingContainer as GridViewRow;
        TextBox txtNewQty = row.FindControl("txtNewQty") as TextBox;
        string IB_ID=Request.QueryString["IB_ID"];

        SqlParameter[] para={
                                new SqlParameter("@ItemCode",ItemCode),
                                new SqlParameter("@IB_ID",IB_ID),
                                new SqlParameter("@QTY",txtNewQty.Text),
                            };

        DbManager db = new DbManager();
        db.ExecuteNonQuery("usp_UpdateRequisitonQty", "STOREConnectionString", para);
        gvRequistionDetail.DataBind();
        
        
    }
}