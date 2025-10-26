using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Pharmacy_ReturnItems : System.Web.UI.Page
{
    string constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    string constring1 = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    int total_Stock = 0;
    voucher_insertion voucher = new voucher_insertion();
    double unit_amount;
    string Vou_main_Id;
    int qty_Remain;
    int Batch_qty;
    int Sale_Return_Id = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            btn_forward.Enabled = true;

            GridView1.DataBind();
            if (GridView1.Rows.Count > 0)
            {
                //btn_forward.Visible = true;
                ddlSubDepartment.Visible = true;
                ddlDepartment.Visible = true;
                ddlDepartment.DataBind();
                ddlDepartment.SelectedValue = Session["Dept_id"].ToString();
                ddlSubDepartment.DataBind();
                ddlSubDepartment.SelectedValue = Session["Subdeptid"].ToString();
                lbl_dept.Visible = true;
                lbl_subdept.Visible = true;
                
                //selectValues();
            }
            //GridView2.DataBind();
            //if (GridView2.Rows.Count > 0)
            //{
            //    Label1.Visible = true;
            //}

        }
    }
    protected void selectValues()
    {
        String connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        String command = "usp_Select_Values_by_Consumption";
        SqlCommand cmd = new SqlCommand(command, con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Consumption_Id", Request.QueryString["C_ID"]);
        SqlDataReader dr = cmd.ExecuteReader();
        
        while (dr.Read())
        {
            HF_IB_ID.Value = dr["Requisition_Id"].ToString();
            HF_Company_ID.Value = dr["Company_Id"].ToString();
            hdf_Sale_Return_Id.Value = dr["Sale_Return_Id"].ToString();
            HF_Recieve_main_id.Value = dr["Store_Receive_Main_ID"].ToString();
        }
        con.Close();
       
    }
    protected void ReceiveMain()
    {
        selectValues();
        String saleReturnId = hdf_Sale_Return_Id.Value;
        String receiveMainId = HF_Recieve_main_id.Value;
        
        if (Convert.ToInt32(saleReturnId) == -1 && Convert.ToInt32(receiveMainId) == -1)
        {
            sdsInsertReceiveMain.Insert();
            sdsSaleReturnMain.Insert();
            
        }
        else
        {

        }
    }

    protected void btn_forward_Click(object sender, EventArgs e)
    {
        btn_forward.Enabled = false;
        int chkReturn = 0;
        foreach (GridViewRow gvRow in GridView1.Rows)
        {
            //CheckBox chk = (CheckBox)gvRow.FindControl("Chk_Status");
            TextBox txt = (TextBox)gvRow.FindControl("txtQty");
            if (Convert.ToInt32(txt.Text.Trim())> 0)
            {
                chkReturn++;
            }
        }
        if (chkReturn > 0)
        {
            String Return_ID = "0";
            String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("usp_Return_Receive_Medicine", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@EmpID", Session["Emp_Id"]);
            cmd.Parameters.AddWithValue("@SubDeptID", ddlSubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@DeptID", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@ConsumptionID", Request.QueryString["C_ID"]);
            cmd.Parameters.AddWithValue("@RegNo", Request.QueryString["regNO"]);
            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["payid"]);
            cmd.Parameters.AddWithValue("@RefundType", RadioButtonList1.SelectedItem.Text);
            cmd.Parameters.Add("@Sale_Return_ID", SqlDbType.Int);
            cmd.Parameters["@Sale_Return_ID"].Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            con.Open();
            cmd.ExecuteNonQuery();
            Return_ID = cmd.Parameters["@Sale_Return_ID"].Value.ToString() ;
            con.Close();
            Response.Redirect("~/Pharmacy/PatientSaleReturnReport.aspx?C_ID=" + Request.QueryString["C_ID"] + "&Rtn_ID=" + Return_ID);
            GridView1.DataBind();
        }
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow gvRow in GridView1.Rows)
        {
            HiddenField chkSer = gvRow.FindControl("hfChkSer") as HiddenField;
            TextBox returnQty = gvRow.FindControl("txtQty") as TextBox;
            LinkButton btnSerials = gvRow.FindControl("btnSerials") as LinkButton;
            LinkButton chk = gvRow.FindControl("Chk_Status") as LinkButton;
            HiddenField conQty = gvRow.FindControl("HF_ConQty") as HiddenField;
            HiddenField allowSerial = gvRow.FindControl("hdfAllowSerial") as HiddenField;
            //Response.Write(chk.CommandArgument);
            if (Convert.ToBoolean(allowSerial.Value)==false)
            {
                returnQty.Enabled = true;
                btnSerials.Visible = false;
                if (returnQty.Visible == false)
                {
                    chk.Visible = false ;
                }
                else
                {
                    chk.Visible = true;
                }
                
            }
            else
            {
                returnQty.Enabled = false;
                btnSerials.Visible = true;
                chk.Visible = false;
            }
            if (returnQty.Text == conQty.Value)
            {
                returnQty.Enabled = false;
                chk.Visible = false;
                btnSerials.Visible = false;
            }
        }
    }
    protected void sdsInsertReceiveMain_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        HF_Recieve_main_id.Value = e.Command.Parameters["@Receive_Main_ID"].ToString();
    }
    protected void sdsSaleReturnMain_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hdf_Sale_Return_Id.Value = e.Command.Parameters["@Sale_Return_Id"].ToString();
    }
    protected void btnSerials_Click(object sender, EventArgs e)
    {
        LinkButton btnTemp = sender as LinkButton;
        long id = Convert.ToInt64(btnTemp.CommandArgument);
        hdf_Consumption_Sub_Id.Value = id.ToString();
        sdsSerials.SelectParameters["Sub_Id"].DefaultValue = id.ToString();

        gvSerials.DataBind();
        gvSerials.Visible = true;
        btnReturnSerials.Visible = true;
        btn_forward.Visible = false;
    }
    protected void gvSerials_PreRender(object sender, EventArgs e)
    {
        int sr = 1;
        foreach (GridViewRow row in gvSerials.Rows)
        {
            Label lblS = (Label)row.FindControl("lblSr");
            lblS.Text = sr.ToString();
            sr++;
        }
    }
    protected void btnReturnSerials_Click(object sender, EventArgs e)
    {
        int count = 0;
        int chk = 0;
        int qty = 0;
        foreach (GridViewRow row in gvSerials.Rows)
        {
            CheckBox Chk_Status = (CheckBox)row.FindControl("chkSerials");

            if (Chk_Status.Checked)
            {
                    HiddenField HF_Item_Code = (HiddenField)row.FindControl("HF_Item_Code");
                    HiddenField HF_Tag_IG = (HiddenField)row.FindControl("HF_ItemTagID");
                    HiddenField HF_ConDetail_ID = (HiddenField)row.FindControl("HF_Consumption_Detail_ID");
                    HiddenField HF_Serial = (HiddenField)row.FindControl("HF_SerialNo");
                    HiddenField HF_Serial_Id = (HiddenField)row.FindControl("HF_SerialNO_Id");
                    HiddenField HF_ConSerial_ID = (HiddenField)row.FindControl("HF_Consumption_Serial_ID");
                    insertMarkedSerial(HF_Serial_Id.Value, HF_ConDetail_ID.Value, HF_Serial.Value, HF_Tag_IG.Value, HF_ConSerial_ID.Value, HF_Item_Code.Value);
            }
            GridView1.DataBind();
            btnReturnSerials.Visible = false;
            btn_forward.Visible = true;
            
        }
        btn_forward_Click(this, e);
        btn_forward.Visible = false;
    }
    protected void sdsSaleReturnSub_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hdf_Sale_Sub_Id.Value = e.Command.Parameters["@Sale_Sub_Id"].Value.ToString();
    }
    protected void sdsInsertReceiveSub_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hdf_Receive_Sub_Id.Value = e.Command.Parameters["@Sub_Id"].Value.ToString();
    }
    protected void insertMarkedSerial(String snoId, String conDetailId, String serialNo, String TagID, String conSerialID, String Item_Code)
    {
        try
        {
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            String command = "usp_Insert_Sale_Return_Serial_Saved";
            SqlCommand cmd = new SqlCommand(command, con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Serial_NO_ID", snoId);
            cmd.Parameters.AddWithValue("@Consumption_Detail_ID", conDetailId);
            cmd.Parameters.AddWithValue("@Serial_No", serialNo);
            cmd.Parameters.AddWithValue("@PO_Tag_ID", TagID);
            cmd.Parameters.AddWithValue("@ReservedBy", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Consumption_Serial_ID", conSerialID);
            cmd.Parameters.AddWithValue("@Item_Code", Item_Code);
            cmd.Parameters.AddWithValue("@Consumption_ID", Request.QueryString["C_ID"]);
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception ex)
        {
        }
    }


    protected void btnChk_Status_Click(object sender, EventArgs e)
    {
        LBL_MSG.Visible = false;
        LinkButton btnTemp = sender as LinkButton;
        btnTemp.Enabled = false;
       // Response.Write(btnTemp.CommandArgument);
        long id = Convert.ToInt64(btnTemp.CommandArgument);
        GridViewRow row = (GridViewRow)btnTemp.NamingContainer;
        TextBox qty = (TextBox)row.FindControl("txtQty");
        HiddenField cqty = (HiddenField)row.FindControl("HF_ConQty");
        //hdf_Consumption_Sub_Id.Value = id.ToString();
        //sdsSerials.SelectParameters["Sub_Id"].DefaultValue = id.ToString();
        Label lblConQty = (Label)row.FindControl("lblConQty");
        Label lblRetQty = (Label)row.FindControl("lblReturnQty");


        HiddenField PO_ID = (HiddenField)row.FindControl("hfPO_ID");
        HiddenField PO_ID_Sub = (HiddenField)row.FindControl("hfPO_ID_Sub");
        HiddenField ExpiryDate = (HiddenField)row.FindControl("hfExpiryDate");
        HiddenField BatchNo = (HiddenField)row.FindControl("hfBatchNo");

        if (!checkISAlreadyMarked(id))
        {
            if (Convert.ToInt32(qty.Text) > Convert.ToInt32(cqty.Value) || Convert.ToInt32(qty.Text) <= 0)
            {
                LBL_MSG.Visible = true;
                LBL_MSG.Text = "Invalid Return Quantity please Re-enter ";
            }
            else
            {
                LBL_MSG.Visible = false;
                try
                {
                    if (Convert.ToInt32(lblConQty.Text) >= (Convert.ToInt32(lblRetQty.Text) + Convert.ToInt32(qty.Text) + getMarkedQty(id)))
                    {
                        SqlConnection con = new SqlConnection(constr);
                        con.Open();
                        String command = "usp_Insert_Sale_Return_Nonserial_Saved";
                        SqlCommand cmd = new SqlCommand(command, con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Consumption_Detail_ID", id);
                        cmd.Parameters.AddWithValue("@ReservedBy", Session["emp_id"]);
                        cmd.Parameters.AddWithValue("@Consumption_ID", Request.QueryString["C_ID"]);
                        cmd.Parameters.AddWithValue("@qty", qty.Text);
                        cmd.Parameters.AddWithValue("@PO_ID", PO_ID.Value);
                        cmd.Parameters.AddWithValue("@PO_ID_Sub", PO_ID_Sub.Value);
                        cmd.Parameters.AddWithValue("@ExpiryDate", ExpiryDate.Value);
                        cmd.Parameters.AddWithValue("@BatchNo", BatchNo.Value);
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                    viewMarkedItems();
                    if (gvReturnItems.Rows.Count > 0)
                    {
                        btn_forward.Visible = true;
                    }
                    else
                    {
                        btn_forward.Visible = false;
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("Error =" + ex);
                }

            }
        }
        else
        {
            LBL_MSG.Text = "Already Marked for return kindly see below!!! ";
            LBL_MSG.Visible = true;
            LBL_MSG.ForeColor = System.Drawing.Color.Red;
        }
        btnTemp.Enabled = true;
    }

     protected void btnShow_return_Click(object sender, EventArgs e)
     {
         viewMarkedItems();
    }

     protected void btnDelete_Click(object sender, EventArgs e)
     {
         LinkButton btnTemp = (LinkButton)sender;
         try
         {
             SqlConnection con = new SqlConnection(constr);
             con.Open();
             String command = "usp_Delete_Sale_Return_Serial_Saved";
             SqlCommand cmd = new SqlCommand(command, con);
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.Parameters.AddWithValue("@Consumption_Detail_ID", btnTemp.CommandArgument);
             cmd.Parameters.AddWithValue("@ReservedBy", Session["Emp_Id"]);
             cmd.ExecuteNonQuery();
             con.Close();
             viewMarkedItems();
             GridView1.DataBind();
         }
         catch (Exception ex)
         {

         }
     }
     protected void viewMarkedItems()
     {
         try
         {
             SqlConnection con = new SqlConnection(constr);
             con.Open();
             String command = "usp_Get_Marked_Serials";
             SqlCommand cmd = new SqlCommand(command, con);
             cmd.CommandType = CommandType.StoredProcedure;
             cmd.Parameters.AddWithValue("@Consumption_ID", Request.QueryString["C_ID"]);
             cmd.Parameters.AddWithValue("@ReservedBy", Session["Emp_Id"]);
             SqlDataAdapter da = new SqlDataAdapter(cmd);
             DataTable dt = new DataTable();
             da.Fill(dt);
             gvReturnItems.DataSource = dt;
             gvReturnItems.DataBind();
             gvReturnItems.Visible = true;

         }
         catch (Exception ex)
         {
         }
     }
     protected void chkAll_CheckedChanged(object sender, EventArgs e)
     {
         CheckBox chkAll = (CheckBox)sender;
         CheckBox chkSerialSelect = default(CheckBox);
         foreach (GridViewRow gvRow in gvSerials.Rows)
         {
             chkSerialSelect = (CheckBox)gvRow.FindControl("chkSerials");
             chkSerialSelect.Checked = chkAll.Checked;
         }
     }
     protected void btnShowDC_Click(object sender, EventArgs e)
     {

     }
     protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
     {
         Label lblConQty;
         Label lblQtyReturn;
         TextBox txtReturQty;

         if (e.Row.RowType == DataControlRowType.DataRow)
         {
             lblConQty = e.Row.FindControl("lblConQty") as Label;
             lblQtyReturn = e.Row.FindControl("lblReturnQty") as Label;
             txtReturQty = e.Row.FindControl("txtQty") as TextBox;
             txtReturQty.Attributes.Add("onkeyup", "CheckQuantityLimit('" + lblConQty.Text + "','" + txtReturQty.ClientID + "','" + lblQtyReturn.Text + "')");
         }
     }
    protected int getMarkedQty(long CDID)
    {
        DbManager dbMgr = new DbManager();
        String query = "Select ISNULL(Sum(ReturnQty),0) AlreadyMarked From Sale_Retun_Serial_Saved Where Consumption_Detail_ID=@ID";
        SqlParameter[] sqlParm = { new SqlParameter("@ID", CDID) };
        DataTable dt=dbMgr.ExecuteDataTableWithQuery(query, "STORECOnnectionString", sqlParm);
        int qty = 0;
        if(dt.Rows.Count>0)
        {
            qty = Convert.ToInt32(dt.Rows[0][0].ToString());
        }
        else
        {
            qty = 0;
        }
        return qty;
    }
    protected bool checkISAlreadyMarked(long CDID)
    {
        viewMarkedItems();
        bool status = false;
        foreach(GridViewRow row in gvReturnItems.Rows)
        {
            Label detialID = (Label)row.FindControl("lblDetilID");
            if(Convert.ToDouble(detialID.Text)==CDID)
            {
                status = true;
                goto abc;
            }
        }
        abc :
        return status;
    }
}