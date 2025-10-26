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
using System.IO;
using System.Data;
using System.Data.SqlClient;

using System.Collections.Generic;

public partial class PurchaseRecieving : CSharpClass
{
   

    voucher_insertion VI = new voucher_insertion();
    string constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    string F_constr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        HiddenFieldReceive_Main_id.Value = HiddenFieldReceive_Main_id.Value;
        
        if (Convert.ToInt32(Session["SubDeptID"]) != 64)
        {
            TextBox_Rate.Enabled = false;

        }


        Check_Authentication();
        LabelCompanyName.Text = Request.QueryString["Comp_Name"].ToString();
        if (Request.QueryString["PO_ID"] == null)
        {
            Response.Redirect("../login.aspx");
        }
        HiddenField_Emp_ID.Value = Session["emp_id"].ToString();
        HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
        WebDateChooser_EXP.Enabled = false;

        if (!Page.IsPostBack)
        {
            //LC();
            // IS_Compleated();
            if (string.IsNullOrEmpty(HiddenFieldReceive_Main_id.Value))
            {
                HYP_GRN.NavigateUrl = string.Empty;
                //HYP_GRN.Visible = false;
                //btnGenerateGRN.Visible = false;
            }
            else
            {
                //HYP_GRN.Visible = true;
                HYP_GRN.NavigateUrl = HYP_GRN.NavigateUrl + HiddenFieldReceive_Main_id.Value + "&PO_ID=" + Request.QueryString["PO_ID"];
                //btnGenerateGRN.Visible = true;
            }

            GridView_Detail.Visible = false;
            HiddenField_Inv_No.Value = "";
            TextBox_Receive_Qty.Enabled = false;
            TextBox_Batch.Enabled = false;
            Label recqty;
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                recqty = (Label)GridView2.Rows[i].FindControl("LabelReceiveQty");
                recqty.Text = "0";
            }
            if (IS_Purchase_Button_Visible(Request.QueryString["PO_ID"].ToString()))
            {
                Button_Purchase.Visible = false;
            }
        }
    }

    protected Boolean IS_Purchase_Button_Visible(string IB_ID)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("SELECT FAC FROM Purchase_Order_Main where (FAC_Date_Time is not null) and (PO_ID = @PO_ID) and (FAC = 1)", con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@PO_ID", IB_ID);
        con.Open();
        Boolean flag = false;
        SqlDataReader reader = command.ExecuteReader();
        if (reader.Read())
        {
            flag = true;
        }
        con.Close();
        return flag;
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {

            SqlDataSource_Update_PO.Update();

            Response.Redirect("../store/Receive_Medicine.aspx");
            //Response.Write("<Script language='javascript' type='text/javascript'>window.open('../Adminmain.aspx','_top');</Script>");
        }
        catch (Exception ex)
        {

        }

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            string fileName = Request.QueryString["PO_ID"].ToString() + TextBox_Lc_No.Text.ToString() + TextBox_invoice_NO.Text.ToString() + FileUpload1.FileName;
            HiddenField_File_Header.Value = FileUpload1.FileName;
            HiddenField_file_URL.Value = fileName;
            if (File_Upload(FileUpload1, fileName, "Documents"))
            {
                SqlDataSource3.Insert();

            }
        }
        catch (Exception ex) { }
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtTotalRecQty.Text.Trim()) || string.IsNullOrEmpty(TextBox_invoice_NO.Text.Trim()))
        {
            lbl_MSG.Text = "Kindly fill Delivery Chellan No. and Total DC QTY first...";
            return ;
        }
        else
        { 
            GridView2.SelectedRow.BackColor = System.Drawing.Color.Plum;
            GridView_Detail.DataBind();
            LabelItem.Text = GridView2.Rows[GridView2.SelectedIndex].Cells[5].Text;
            TextBox_Rate.Text = GridView2.Rows[GridView2.SelectedIndex].Cells[1].Text;
            HiddenField_Item_ID.Value = Convert.ToString(GridView2.SelectedValue);
            HiddenField_IB_ID.Value = Convert.ToString(HiddenField_IB_ID.Value);
            HiddenFieldReceive_Main_id.Value = (HiddenFieldReceive_Main_id.Value);
            HiddenField detail = (HiddenField)GridView2.Rows[GridView2.SelectedIndex].FindControl("HF_Detail");
            HiddenFieldPOSub.Value = ((LinkButton)GridView2.Rows[GridView2.SelectedIndex].FindControl("lb_details")).CommandArgument;
            Label_ItemDetail.Text = detail.Value;
            TextBox_Receive_Qty.Text = "0";
            Label recqty;
            recqty = (Label)GridView2.Rows[GridView2.SelectedIndex].FindControl("LabelReceiveQty");
            HiddenField Allow_serial = (HiddenField)GridView2.Rows[GridView2.SelectedIndex].FindControl("HiddenField_is_Serial");

            HiddenField_Serial_Allow.Value = Allow_serial.Value;

            string demandqty = GridView2.Rows[GridView2.SelectedIndex].Cells[2].Text;
            //Response.Write("Text Box Recive: "+Convert.ToInt32(TextBoxReceiveQty.Text)+" recived qty: " + Convert.ToInt32(recqty.Text) + " demanded qty: " +Convert.ToInt32(demandqty));
            try
            {
                WebDateChooserMfg.Text = DateTime.Now.ToString("yyyy-MM-dd");
                WebDateChooser_EXP.Text = DateTime.Now.AddYears(2).ToString("yyyy-MM-dd");
                TextBox_Batch.Text = "  ";
            }
            catch (IOException exx)
            {
                Response.Write(exx.Message);
            }
            //Response.Write( + "   " + recqty.Text);
            if (recqty.Text == "")
            {
                recqty.Text = "0";
            }

            if ((Convert.ToInt32(TextBox_Receive_Qty.Text) + Convert.ToInt32(recqty.Text)) > Convert.ToInt32(demandqty))
            {
                ButtonSave.Enabled = false;
            }
            else
            {
                ButtonSave.Enabled = true;
            }

            if (LabelItem.Text != "")
            {
                TextBox_Receive_Qty.Enabled = true;
                TextBox_Batch.Enabled = true;
            }
            else
                TextBox_Receive_Qty.Enabled = false;
            int total = GridView_Detail.Rows.Count;
            if (total > 0)
            {
                TextBox_ToSerial.Visible = true;
                TextBox_FromSerial.Visible = true;
                TextBox_MarkOrderNo.Visible = true;
                Button_OrderNo.Visible = true;
                LBL_S_Order.Visible = true;
                lbl_S_O_S.Visible = true;
                lbl_S_O_E.Visible = true;
            }
            else
            {
                TextBox_ToSerial.Visible = false;
                TextBox_FromSerial.Visible = false;
                TextBox_MarkOrderNo.Visible = false;
                Button_OrderNo.Visible = false;
                LBL_S_Order.Visible = false;
                lbl_S_O_S.Visible = false;
                lbl_S_O_E.Visible = false;
            }
            lbl_MSG.Text = string.Empty;
        }

    }

    protected void ReceiveMain()
    {
        if (string.IsNullOrEmpty(HiddenFieldReceive_Main_id.Value))
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand command = new SqlCommand("Insert_Store_Item_Receive_Main", con);
            command.CommandType = CommandType.StoredProcedure;


            command.Parameters.AddWithValue("@IB_ID", Request.QueryString["PO_ID"].ToString());
            command.Parameters.AddWithValue("@Receive_Dept_Id", Session["dept_id"]);

            command.Parameters.AddWithValue("@Receive_Emp_Id", Session["emp_id"]);

            command.Parameters.AddWithValue("@Receive_Sub_dept_Id", Session["SubDeptID"]);

            command.Parameters.AddWithValue("@ShiftID", Session["ShiftID"]);
            command.Parameters.AddWithValue("@Item_Issue_Main_ID", "0");
            command.Parameters.AddWithValue("@Company_ID", "0");
            command.Parameters.AddWithValue("@DCNO", TextBox_invoice_NO.Text);
            command.Parameters.AddWithValue("@InvoiceNo", TextBox_Lc_No.Text);
            command.Parameters.AddWithValue("@TotalQty", txtTotalRecQty.Text);
            command.Parameters.Add("@Receive_Main_ID", SqlDbType.Int);
            command.Parameters["@Receive_Main_ID"].Direction = ParameterDirection.Output;

            //command.Parameters.Add("@Inv_No", SqlDbType.VarChar, 50);
            //command.Parameters["@Inv_No"].Direction = ParameterDirection.Output;


            con.Open();
            command.ExecuteNonQuery();

            HiddenFieldReceive_Main_id.Value = command.Parameters["@Receive_Main_ID"].Value.ToString();
            //HiddenField_Inv_No.Value =    command.Parameters["@Inv_No"].Value.ToString();
            //Response.Write(HiddenFieldReceive_Main_id.Value + " " + HiddenField_Inv_No.Value);
            con.Close();
            con.Dispose();
        }
    }


    protected void ButtonSave_Click(object sender, EventArgs e)
    {

        if (LabelItem.Text != "")
        {
            if (TextBox_Receive_Qty.Text != "0" && TextBox_Receive_Qty.Text != "")
            {

                Button_ReciveOrder.Visible = true;
                try
                {
                    ReceiveMain();
                    //SqlDataSource_Receive_Qty.Insert();
                    HiddenFieldStore__issue_Main_id.Value = (HiddenFieldStore__issue_Main_id.Value);
                    HiddenField_Exp.Value = WebDateChooser_EXP.Text;
                    HiddenField_Mfg_Date.Value =WebDateChooserMfg.Text;
                    SqlDataSourceReceiveQtySub.Insert();
                }
                catch { }
                //=====================================
                // SqlDataSourceUpdateRate.Update();
                if (TextBox_invoice_NO.Text == "")
                {
                    TextBox_invoice_NO.Text = HiddenField_Inv_No.Value;
                }
                GridView2.DataBind();
                //Inspection Report
                //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                //sb.Append("<script language='javascript'>window.open('InspectionNoteReport.aspx?Item_Code=" + HiddenField_Item_ID.Value + "&IB_ID=" + Request.QueryString["PO_ID"].ToString() + "&Receive_ID=" + HiddenFieldReceive_Main_id.Value + "');</script>");
                //if (!(ClientScript.IsClientScriptBlockRegistered(this.GetType(), "PopUP")))
                //{
                //    ClientScript.RegisterClientScriptBlock(this.GetType(), "PopUP", sb.ToString());
                //}

                TextBox_Batch.Text = "";
                TextBox_Receive_Qty.Text = "";
                WebDateChooser_EXP.Text = "Null";
                WebDateChooserMfg.Text = "Null";
                TextBox_Pack.Text = "";
                TextBox_Rate.Text = "";
                //TextBox_invoice_NO.Text = "";
                TextBox_ToSerial.Visible = true;
                TextBox_FromSerial.Visible = true;
                TextBox_MarkOrderNo.Visible = true;
                Button_OrderNo.Visible = true;
                LBL_S_Order.Visible = true;
                lbl_S_O_S.Visible = true;
                lbl_S_O_E.Visible = true;
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script language='javascript' type='text/javascript'>alert('Receive Quantity must be Greater then Zero and not empty');</script>");
                Type t = this.GetType();
                if (!ClientScript.IsClientScriptBlockRegistered(t, "Popup"))
                {
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString());
                }

            }
        }
        else
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>alert('First Select Item');</script>");
            Type t = this.GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "Popup"))
            {
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString());
            }

        }
        TextBox_Receive_Qty.Text = "0";

    }
    protected void SqlDataSourceReceiveQty_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        HiddenFieldReceive_Main_id.Value = Convert.ToString(e.Command.Parameters["@Receive_Main_ID"].Value);
    }

    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        Boolean check = false;
        if (GridView2.Rows.Count != 0)
        {
           
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                Label receive_qty = (Label)GridView2.Rows[i].FindControl("LabelReceiveQty");
                int poSubID = Convert.ToInt32(((LinkButton)GridView2.Rows[i].FindControl("lb_details")).CommandArgument);
                SqlDataReader reader_qty = Receive_Qty(Request.QueryString["PO_ID"], GridView2.Rows[i].Cells[4].Text,poSubID);
                while (reader_qty.Read())
                {
                    if (GridView2.Rows[i].Cells[4].Text == Convert.ToString(reader_qty.GetString(1)))
                    {
                        receive_qty.Text = Convert.ToString(reader_qty.GetInt32(0));
                    }
                }

            }
            GridView2.HeaderRow.Cells[4].Visible = false;
            GridView2.HeaderRow.Cells[5].Visible = false;
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                GridView2.Rows[i].Cells[4].Visible = false;
                GridView2.Rows[i].Cells[5].Visible = false;
            }
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                Label receive_qty = (Label)GridView2.Rows[i].FindControl("LabelReceiveQty");
                if (GridView2.Rows[i].Cells[2].Text == receive_qty.Text)
                {
                    check = true;
                }
                else
                {
                    check = false;
                    break;
                }
            }
            if (check == true)
            {
                ButtonSave.Enabled = false;
                Button_Purchase.Enabled = true;
                Button2.Enabled = false;
            }
        }
    }
    protected SqlDataReader Receive_Qty(string IB_ID, string Item_Code,int poSubID)
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("Store_Item_Partial_Receive", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@IB_ID", IB_ID);
        command.Parameters.AddWithValue("@Item_Code", Item_Code);
        command.Parameters.AddWithValue("@PO_ID_Sub", poSubID);
        con.Open();
        SqlDataReader reader = command.ExecuteReader();

        return reader;
    }
    protected void TextBoxBNo_TextChanged(object sender, EventArgs e)
    {
        if (TextBox_Batch.Text.Length != 0)
        {
            SqlConnection con = new SqlConnection(constr);
            SqlCommand command = new SqlCommand("Select_Exp_for_batch_already_Exists", con);
            command.CommandType = CommandType.StoredProcedure;
            string item_code = GridView2.Rows[GridView2.SelectedIndex].Cells[4].Text;
            command.Parameters.AddWithValue("@Item_Code", item_code);
            command.Parameters.AddWithValue("@BatchNo", TextBox_Batch.Text);
            con.Open();
            SqlDataReader exp_reader = command.ExecuteReader();
            if (exp_reader.Read())
            {
                ////response.write(exp_reader.getdatetime(0));
                WebDateChooser_EXP.Text = (exp_reader.GetDateTime(0)).ToString("yyyy-MM-dd");
                WebDateChooser_EXP.Enabled = false;

            }
            else
            {
                //Response.Write("date time not exist");
                WebDateChooser_EXP.Text = "";
                WebDateChooser_EXP.Enabled = true;
            }
        }
        else
        {
            WebDateChooser_EXP.Text = "";
            WebDateChooser_EXP.Enabled = false;
        }

    }

    protected void TextBoxReceiveQty_TextChanged(object sender, EventArgs e)
    {
        Label recqty;
        recqty = (Label)GridView2.Rows[GridView2.SelectedIndex].FindControl("LabelReceiveQty");
        string demandqty = GridView2.Rows[GridView2.SelectedIndex].Cells[2].Text;
        //Response.Write( + "   " + recqty.Text);
        if (TextBox_Receive_Qty.Text == "")
        {
            TextBox_Receive_Qty.Text = "0";
        }
        if ((Convert.ToInt32(TextBox_Receive_Qty.Text) + Convert.ToInt32(recqty.Text)) > Convert.ToInt32(demandqty))
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>alert('Excceding maximum Demand Quantity');</script>");
            Type t = this.GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "Popup"))
            {
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString());
            }


            TextBox_Receive_Qty.Text = "0";
            //   ButtonSave.Enabled = false;
        }
        else
        {
            ButtonSave.Enabled = true;
            TextBox_FromSerial.Text = recqty.Text;
            TextBox_ToSerial.Text = (Convert.ToInt32(TextBox_Receive_Qty.Text) + Convert.ToInt32(recqty.Text)).ToString();

        }


    }
    protected void GridView_Detail_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView_Detail_DataBound(object sender, EventArgs e)
    {
        //Label head = (Label)GridView_Detail.HeaderRow.FindControl("Label_Head_tag");

        for (int i = 0; i < GridView_Detail.Rows.Count; i++)
        {
            TextBox tag = (TextBox)GridView_Detail.Rows[i].FindControl("TextBox_tagNo");
            TextBox Order = (TextBox)GridView_Detail.Rows[i].FindControl("TextBox_OrderNo");

            if (HiddenField_Serial_Allow.Value == "False")
            {

                //tag.Enabled = false;


            }
            else
            {
                //tag.Enabled = true;
                //Order.Enabled = true;
            }


        }
        //int count_val = 0;
        //int total=0;
        //for (count_val = 0; count_val <= GridView_Detail.Rows.Count - 1; count_val++)
        //{
        //    Label lb = (Label)GridView_Detail.Rows[count_val].FindControl("Label2");
        //    total= total + Convert.ToInt32(lb.Text);


        //}
        //try
        //{
        //    Label lb_total = (Label)GridView_Detail.FooterRow.FindControl("Label_Total");
        //    lb_total.Text = Convert.ToString(total);
        //}
        //catch (Exception ex)
        //{ }

    }

    protected void Insert_Amount()
    {


    }

    protected void Insert_TAX_Discount_Voucher()
    {
        SqlConnection con = new SqlConnection(constr);
       

    }

    protected Int64 GetPartyID(string PO_ID)
    {
        SqlConnection con = new SqlConnection(constr);
        string qry = "SELECT Company_ID FROM Purchase_Order_Main where(PO_ID = @PO_ID)";
        Int64 CId = 0;
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@PO_ID", PO_ID);

        con.Open();
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            CId = Convert.ToInt64(reader[0].ToString());
        }
        con.Close();
        con.Dispose();
        return CId;

    }

    protected void CheckHead(string Item_Code, Int32 Dept_ID, Int32 SubDeptId)
    {
        SqlConnection con = new SqlConnection(constr);
        string SP = "[Insert_Store_Items_AccountHeads]";
        String HeadCode = "55002001001";
        SqlCommand command = new SqlCommand(SP, con);
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.AddWithValue("@Item_Code", Item_Code);
        command.Parameters.AddWithValue("@Dept_Id", Dept_ID);
        command.Parameters.AddWithValue("@SubDept_Id", SubDeptId);
        command.Parameters.AddWithValue("@E_Code", HeadCode);

        con.Open();
        command.ExecuteNonQuery();
        con.Close();
        con.Dispose();



    }


    protected string GetHead(string Item_Code, Int32 Dept_ID, Int32 SubDeptId)
    {
        CheckHead(Item_Code, Dept_ID, SubDeptId);
        SqlConnection con = new SqlConnection(constr);
        string qry = "SELECT isnull(E_Code,'') as E_Code FROM Store_Items_AccountHeads WHERE (Item_Code = @Item_Code) AND (Dept_Id = @Dept_Id) AND (SubDept_Id = @SubDept_Id)";
        String HeadCode = "0000000";
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Item_Code", Item_Code);
        command.Parameters.AddWithValue("@Dept_Id", Dept_ID);
        command.Parameters.AddWithValue("@SubDept_Id", SubDeptId);
        con.Open();
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            HeadCode = reader[0].ToString();
        }
        con.Close();
        con.Dispose();
        return HeadCode;

    }

    protected void UpdateStoreItemValue(string Item_Code, Int32 SRM_Id, Int32 Dept_ID, Int32 SubDeptId)
    {
        SqlConnection con = new SqlConnection(constr);
        string SP = "[Update_Store_Item_Value]";

        //String HeadCode = "55002001001";
        SqlCommand command = new SqlCommand(SP, con);
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.AddWithValue("@Item_Code", Item_Code);
        command.Parameters.AddWithValue("@Dept_ID", Dept_ID);
        command.Parameters.AddWithValue("@Sub_Dept_ID", SubDeptId);
        command.Parameters.AddWithValue("@Store_Receive_Main_ID", SRM_Id);

        con.Open();
        command.ExecuteNonQuery();
        con.Close();
        con.Dispose();



    }


    protected void UpdateStorePriceAvg(Int32 SRM_Id)
    {
        SqlConnection con = new SqlConnection(constr);
        string qry = "SELECT Store_Item_Received_Sub.Item_Code, Store_Item_Received_Main.Receive_Dept_Id, Store_Item_Received_Main.Receive_Sub_dept_Id FROM Store_Item_Received_Sub INNER JOIN Store_Item_Received_Main ON Store_Item_Received_Sub.Store_Receive_Main_ID = Store_Item_Received_Main.Store_Receive_Main_ID WHERE (Store_Item_Received_Main.Store_Receive_Main_ID = @Store_Receive_Main_ID)";

        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Store_Receive_Main_ID", SRM_Id);
        con.Open();

        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            UpdateStoreItemValue(reader["Item_Code"].ToString(), SRM_Id, 33, 47);
            //reader["Receive_Dept_Id"].ToString();
            //reader["Receive_Sub_dept_Id"].ToString();


        }

        con.Close();
        con.Dispose();

    }

    protected void Button_ReciveOrder_Click(object sender, EventArgs e)
    {

        //====================================
        //try
        //{
        //    SqlDataSource_JV_Finance.Insert();
        //}
        //catch (Exception ex)
        //{

        //}
        try
        {
            UpdateInv();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        //=====================================
        //if (HiddenField_RO_MID.Value == "")
        //{
        //    if (HiddenFieldReceive_Main_id.Value == "")
        //    {
        //       HiddenField_RO_MID.Value = Select_Inv().ToString();
        //    }
        //    else
        //    {
        //        HiddenField_RO_MID.Value = HiddenFieldReceive_Main_id.Value;
        //    }

        //    //UpdateStorePriceAvg(Convert.ToInt32(HiddenField_RO_MID.Value));
        //    // update according to Avg Method        

        //}
        //else
        //{
        //    UpdateStorePriceAvg(Convert.ToInt32(HiddenField_RO_MID.Value)); // update according to Avg Method

        //    UpdateInv();
        //}
        //Insert_Amount();

        // Button_ReciveOrder.Visible = false;
        TextBox_invoice_NO.Text = "";
        HiddenFieldReceive_Main_id.Value = "0";
        HiddenField_Inv_No.Value = "";




    }




    protected void UpdateInv()
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("UPDATE Store_Item_Received_Main SET IS_RO_Completed = 1 WHERE (Store_Receive_Main_ID = @Store_Receive_Main_ID) and (IS_RO_Completed = 0)", con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Store_Receive_Main_ID", HiddenFieldReceive_Main_id.Value);

        con.Open();
        command.ExecuteNonQuery();
        con.Close();
        con.Dispose();

    }


    protected Int32 Select_Inv()
    {
        Int32 Main_Id = 0;
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("Select_NotCompleted_Receive_Order", con);
        command.CommandType = CommandType.StoredProcedure;


        command.Parameters.AddWithValue("@InvoiceNo", TextBox_invoice_NO.Text);
        command.Parameters.AddWithValue("@IB_ID", Request.QueryString["PO_ID"].ToString());

        con.Open();
        SqlDataReader sdr = command.ExecuteReader();
        while (sdr.Read())
        {
            Main_Id = Convert.ToInt32(sdr["Store_Receive_Main_ID"].ToString());
            txtTotalRecQty.Text = sdr["TotalQty"].ToString();
            txtTotalRecQty.Enabled = false;
            TextBox_invoice_NO.Enabled = false;
        }
        con.Close();
        con.Dispose();

        return Main_Id;
    }

    protected void TextBox_invoice_NO_TextChanged(object sender, EventArgs e)
    {

        if (TextBox_invoice_NO.Text.Length != 0)
        {
            Int32 RM_ID = Select_Inv();
            HiddenField_RO_MID.Value = RM_ID.ToString();
            
            if (RM_ID != 0)
            {
                Button_ReciveOrder.Visible = true;
                HiddenFieldReceive_Main_id.Value = RM_ID.ToString();
                
            }
            else
            {
                HiddenFieldReceive_Main_id.Value = null;
                
            }
            //if (string.IsNullOrEmpty(HiddenFieldReceive_Main_id.Value) || RM_ID==0)
            //{
            //    HYP_GRN.NavigateUrl = string.Empty;
            //    HYP_GRN.Visible = false;
            //    btnGenerateGRN.Visible = false;
            //}
            //else
            //{
            //    HYP_GRN.Visible = true;
            //    HYP_GRN.NavigateUrl = HYP_GRN.NavigateUrl + HiddenFieldReceive_Main_id.Value + "&PO_ID=" + Request.QueryString["PO_ID"];
            //    btnGenerateGRN.Visible = true;
            //}

        }
    }
    protected void GridView_RO_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "SelectDO")
        {
            TextBox_invoice_NO.Text = Convert.ToString(e.CommandArgument);
            if (TextBox_invoice_NO.Text.Length != 0)
            {
                Int32 RM_ID = Select_Inv();
                HiddenField_RO_MID.Value = RM_ID.ToString();
                if (RM_ID != 0)
                {
                    Button_ReciveOrder.Visible = true;
                }

            }

        }
    }

    //protected void lbtnItemRecieving_Click(object sender, EventArgs e)
    //{
    //    LinkButton lbtn = (LinkButton)sender;
    //    ViewState["Sub_ID"] = Convert.ToInt32(lbtn.CommandArgument);
    //    gvAddSerialNo.DataSource = CreateDataTableForSerialNo(Convert.ToInt32(lbtn.CommandName));
    //    gvAddSerialNo.DataBind();
    //    pnlSerialDetails.Visible = true;
    //}

    protected DataTable CreateDataTableForSerialNo(int Qty)
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("SrNo");
        dt.Columns.Add("SerialNo");
        dt.Columns.Add("SO_ID");
        for (int count = 0; count < Qty; count++)
        {
            DataRow dr = dt.NewRow();
            dr["SrNo"] = (count + 1).ToString();
            dt.Rows.Add(dr);
        }
        return dt;
    }

    protected void SqlDataSource_RO_Detail_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        ViewState["Identity"] = e.Command.Parameters["@Identity"].Value;
    }
    protected void lbtnViewSerialNo_Click(object sender, EventArgs e)
    {
        Response.Redirect("PurchaseRecieving_SerialNo.aspx?Sub_ID=" + ((LinkButton)sender).CommandArgument);
    }


    protected void Button_report_Click(object sender, EventArgs e)
    {
        //Response.Write(HiddenFieldReceive_Main_id.Value);
        Response.Redirect("Serial_Wise_View_Report.aspx?Main_ID=" + Request.QueryString["PO_ID"]);

    }
    protected void Button3_report_Click(object sender, EventArgs e)
    {
        //HiddenFieldStore__issue_Main_id.Value = HiddenFieldReceive_Main_id.Value;

        //Store ds = new Store();
        //StoreTableAdapters.Issue_DetailTableAdapter da = new StoreTableAdapters.Issue_DetailTableAdapter();
        //da.Fill(ds.Issue_Detail, Convert.ToInt32(HiddenFieldStore__issue_Main_id.Value));//Convert.ToDecimal(HiddenFieldStore__issue_Main_id.Value)); 
        //abc.FileName = Server.MapPath("Issue_Report_Detail.rpt");
        //abc.Database.Tables["Issue_Detail"].SetDataSource(ds.Tables["Issue_Detail"]);
        //CrystalReportViewer_Issue_Detail.ReportSource = abc;
        //CrystalReportViewer_Issue_Detail.DataBind();
    }
    protected void Button6_Click(object sender, EventArgs e)
    {

        HiddenField_PO_ID.Value = Request.QueryString["PO_ID"];
        Response.Redirect("OtherExpenseReport.aspx?PO_ID=" + HiddenField_PO_ID.Value);
    }


    protected void Button_UpdateTag_Click(object sender, EventArgs e)
    {

        foreach (GridViewRow gvr in GridView_Detail.Rows)
        {
            TextBox txtTagNo = (TextBox)gvr.FindControl("TextBox_TagNo");
            TextBox txtSOID = (TextBox)gvr.FindControl("TextBox_OrderNo");
            TextBox txtQuotation = (TextBox)gvr.FindControl("TextBox_PR_NO");
            Label lb_SerialId = (Label)gvr.FindControl("LabelSerialId");
            Label lb_Id = (Label)gvr.FindControl("lblID");
            hdfID.Value = lb_Id.Text;
            HiddenField_OrderNo.Value = txtSOID.Text;
            HiddenField_TagNo.Value = txtTagNo.Text;
            HiddenField_Quotation.Value = txtQuotation.Text;
            HiddenField_SerialID.Value = lb_SerialId.Text;
            SqlDataSourceReceiveQtySub.Update();

        }

    }
    protected void btn_tag_wise_report_Click(object sender, EventArgs e)
    {

        HiddenField_PO_ID.Value = Request.QueryString["PO_ID"];

        Response.Redirect("TagComparisonReport.aspx?PO_ID=" + HiddenField_PO_ID.Value);

    }

    protected void btn_report_Click(object sender, EventArgs e)
    {
        HiddenField_PO_ID.Value = Request.QueryString["PO_ID"];
        HiddenField_PO_ID.Value = HiddenField_PO_ID.Value;
        Response.Redirect("Received_Tag_No.aspx?PO_ID=" + HiddenField_PO_ID.Value);
    }

    protected void LC()
    {
        SqlConnection con = new SqlConnection(constr);
        SqlCommand command = new SqlCommand("select LC_NO from Purchase_Order_Main where PO_ID =@PO_ID", con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@PO_ID", Request.QueryString["PO_ID"].ToString());
        con.Open();
        TextBox_Lc_No.Text = command.ExecuteScalar().ToString();
        con.Close();


    }
    protected void IS_Compleated()
    {
        //  SqlConnection con = new SqlConnection(constr);
        //  SqlCommand command = new SqlCommand("SELECT IS_RO_Completed FROM Store_Item_Received_Main WHERE (IB_ID =@IB_ID ) AND (Receive_Sub_dept_Id = @SubdeptId) ", con);
        //command.CommandType = CommandType.Text;
        //command.Parameters.AddWithValue("@SubdeptId", Session["Subdeptid"]);
        //command.Parameters.AddWithValue("@IB_ID", Request.QueryString["PO_ID"].ToString());
        //con.Open();
        //Button_ReciveOrder.Visible = Convert.ToBoolean(command.ExecuteScalar());
        ////Button_ReciveOrder.Visible = false;

        ////SqlDataReader reader = command.ExecuteReader();
        ////while (reader.Read())
        ////{
        ////    Button_ReciveOrder.Visible = Convert.ToBoolean(reader["IS_RO_Completed"]);
        ////}


        //con.Close();
    }

    protected void DataList_Items_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void DataList_Items_PreRender(object sender, EventArgs e)
    {

    }
    protected void Button_OrderNo_Click(object sender, EventArgs e)
    {
        int i = 0, Start, End;

        if (Convert.ToInt32(TextBox_FromSerial.Text) < 1)
        {
            TextBox_FromSerial.Text = "1";
        }
        if (Convert.ToInt32(TextBox_ToSerial.Text) < 1)
        {
            TextBox_FromSerial.Text = "1";
        }
        if (TextBox_FromSerial.Text == "")
        {
            TextBox_FromSerial.Text = "0";
        }
        Start = Convert.ToInt32(TextBox_FromSerial.Text) - 1;
        End = Convert.ToInt32(TextBox_ToSerial.Text) - 1;
        for (i = Start; i <= End; i++)
        {
            if (GridView_Detail.Rows.Count > End)
            {
                TextBox txtSOID = (TextBox)GridView_Detail.Rows[i].FindControl("TextBox_OrderNo");
                txtSOID.Text = TextBox_MarkOrderNo.Text;
                if (TextBox_MarkOrderNo.Text == "")
                {
                    txtSOID.Enabled = true;
                }
                else
                {
                    txtSOID.Enabled = false;
                }
            }
            else
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();
                sb.Append("<script language='javascript' type='text/javascript'>alert('Excceding maximum Entered #');</script>");
                Type t = this.GetType();
                if (!ClientScript.IsClientScriptBlockRegistered(t, "Popup"))
                {
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString());
                }

                TextBox_ToSerial.Focus();

            }
        }


        TextBox_MarkOrderNo.Text = "";




    }
    protected void TextBox_ToSerial_TextChanged(object sender, EventArgs e)
    {

    }

    protected void Btn_close_sp_Click(object sender, EventArgs e)
    {
        Pnl_Specificatiom.Visible = false;
        Ck_Item_Detail.Checked = false;
    }
    protected void Ck_Item_Detail_CheckedChanged(object sender, EventArgs e)
    {
        if (Ck_Item_Detail.Checked)
        {
            Pnl_Specificatiom.Visible = true;
        }
        else
        {
            Pnl_Specificatiom.Visible = false;
        }
    }
    protected void lb_details_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        HiddenField_POSubID.Value = lb.CommandArgument;
        GV_Detail.DataBind();

    }
    protected void LB_Specification_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lbtn.NamingContainer;
        int i = Convert.ToInt32(row.RowIndex);
        Button btnSave = (Button)GridView_Detail.Rows[i].FindControl("Btn_Update");
        TextBox Specification = (TextBox)GridView_Detail.Rows[i].FindControl("TXT_Specification");
        lbtn.Visible = false;
        Specification.Visible = true;
        btnSave.Visible = true;

    }
    protected void Btn_Update_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        GridViewRow row = (GridViewRow)btn.NamingContainer;
        int i = Convert.ToInt32(row.RowIndex);
        TextBox order = (TextBox)GridView_Detail.Rows[i].FindControl("TextBox_OrderNo");
        TextBox Serial = (TextBox)GridView_Detail.Rows[i].FindControl("TextBox_TagNo");
        TextBox Specification = (TextBox)GridView_Detail.Rows[i].FindControl("TXT_Specification");
        HiddenField item_code = (HiddenField)GridView_Detail.Rows[i].FindControl("HF_Item_Code");
        LinkButton lbtn = (LinkButton)GridView_Detail.Rows[i].FindControl("LB_Specification");


        btn.Visible = false;
        HF_Stock_Order.Value = order.Text;
        HF_Stock_Serial.Value = Serial.Text;
        HF_Stock_Item_code.Value = item_code.Value;
        HF_Stock_Specification.Value = Specification.Text;
        Specification.Visible = false;
        lbtn.Visible = true;

        Sql_Stock_Specification.Update();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {


    }


    protected void CH_A_Serial_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ch = (CheckBox)sender;
        GridViewRow row = ch.NamingContainer as GridViewRow;
        if (row != null)
        {
            HiddenField IC = (HiddenField)row.FindControl("hf_item_code");
            hf_item_code.Value = IC.Value;
        }
        if (ch.Checked)
        {
            GridView_Detail.Visible = true;
            HF_u_A_SERIAL.Value = "True";

        }
        else
        {
            GridView_Detail.Visible=false;
            HF_u_A_SERIAL.Value = "False";
            HiddenField_Serial_Allow.Value = "False";
        }

        SqlDataSource6.Update();

        GridView2.DataBind();
        GridView_Detail.DataBind();

    }

    protected void btnSelectAllSerial_Click(object sender, EventArgs e)
    {
        List<SerialSearchCollection> serCol = new List<SerialSearchCollection>();
        SerialSearchCollection searchItem = null;
        GridViewRow gvrTemp = null;
        TextBox tempTxtOrder = null;
        TextBox tempTxtTag = null;
        string allSerials;
        string[] serials;
        string orderNo = string.Empty;
        string duplicateSerials = string.Empty;
        string unAdjustedSerials = string.Empty;
        bool isDuplicate = false;

        allSerials = txtSerialsForSelection.Text;
        serials = allSerials.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

        if (txtOrderForSerial.Text.Trim() == string.Empty || txtSerialsForSelection.Text.Trim() == string.Empty)
        {
            lblErrorMsg.Text = "Please enter Order # and Serials to mark.";
            return;
        }


        foreach (string x in serials)
        {
            serCol.Add(new SerialSearchCollection(x.Trim(), false));
        }

        orderNo = txtOrderForSerial.Text;

        foreach (SerialSearchCollection ser1 in serCol)
        {
            isDuplicate = false;
            foreach (GridViewRow gvRow in GridView_Detail.Rows)
            {
                //,
                tempTxtOrder = gvRow.FindControl("TextBox_OrderNo") as TextBox;
                tempTxtTag = gvRow.FindControl("TextBox_TagNo") as TextBox;

                if (orderNo == tempTxtOrder.Text && tempTxtTag.Text == ser1.Serial)
                {
                    isDuplicate = true;
                    gvRow.CssClass = "highlightInvalidSerial";
                    duplicateSerials += ser1.Serial + ", ";
                }

            }

            if (isDuplicate == false)
            {
                foreach (GridViewRow gvRow in GridView_Detail.Rows)
                {
                    //,
                    tempTxtOrder = gvRow.FindControl("TextBox_OrderNo") as TextBox;
                    tempTxtTag = gvRow.FindControl("TextBox_TagNo") as TextBox;

                    if (orderNo == tempTxtOrder.Text && tempTxtTag.Text.Trim() == string.Empty)
                    {
                        tempTxtTag.Text = ser1.Serial;
                        ser1.IsFound = true;
                        break;
                    }

                }
            }

        }

        foreach (SerialSearchCollection t in serCol)
        {
            if (t.IsFound == false && !duplicateSerials.ToUpper().Contains(t.Serial.ToUpper()))
            {
                unAdjustedSerials += t.Serial + ", ";
            }
        }

        if (duplicateSerials.Length > 0)
            duplicateSerials = duplicateSerials.Substring(0, duplicateSerials.Length - 2);

        if (unAdjustedSerials.Length > 0)
            unAdjustedSerials = unAdjustedSerials.Substring(0, unAdjustedSerials.Length - 1);

        if (duplicateSerials.Length > 0)
            lblErrorMsg.Text = "Duplicate serials found " + duplicateSerials.Split(new char[] { ',' }).Length + " : " + duplicateSerials + "<br />";
        if (unAdjustedSerials.Length > 0)
            lblErrorMsg.Text += "Serials not found :: " + unAdjustedSerials;

    }

    protected void btnClearSerial_Click(object sender, EventArgs e)
    {
        txtOrderForSerial.Text = string.Empty;
        txtSerialsForSelection.Text = string.Empty;
        lblErrorMsg.Text = string.Empty;

        foreach (GridViewRow gvRow in GridView_Detail.Rows)
        {
            if (gvRow.RowIndex % 2 == 0)
                gvRow.CssClass = "";
            else
                gvRow.CssClass = "GridAltItem";
        }

    }

    protected void btnReceieveAll_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            Label lblRecieveQty = (Label)GridView2.Rows[i].FindControl("LabelReceiveQty");
            if (lblRecieveQty.Text == "0")
            {

                ReceiveMain();
                HiddenFieldStore__issue_Main_id.Value = (HiddenFieldStore__issue_Main_id.Value);
                HiddenField_Exp.Value = Convert.ToString(WebDateChooser_EXP.Text);
                HiddenField_Mfg_Date.Value = Convert.ToString(WebDateChooserMfg.Text);

                HiddenField hdnQty = (HiddenField)GridView2.Rows[i].FindControl("hdnQty");
                HiddenField itemCode = (HiddenField)GridView2.Rows[i].FindControl("hf_item_code");
                HiddenField POSubID = (HiddenField)GridView2.Rows[i].FindControl("hfPOSUBID");

                SqlConnection con = new SqlConnection(constr);
                SqlCommand command = new SqlCommand("Insert_Store_Item_Receive_Sub_ByPO", con);
                command.CommandType = CommandType.StoredProcedure;

                command.Parameters.AddWithValue("@Store_Receive_Main_ID", HiddenFieldReceive_Main_id.Value);
                command.Parameters.AddWithValue("@Item_Code", itemCode.Value);
                command.Parameters.AddWithValue("@Item_Qty", hdnQty.Value);
                command.Parameters.AddWithValue("@BatchNo", TextBox_Batch.Text);
                command.Parameters.AddWithValue("@PO_ID", Request.QueryString["PO_ID"]);
                command.Parameters.AddWithValue("@exp", HiddenField_Exp.Value);
                command.Parameters.AddWithValue("@Mfg", HiddenField_Mfg_Date.Value);
                command.Parameters.AddWithValue("@Pack", "0");
                command.Parameters.AddWithValue("@Dept_ID", Session["Dept_ID"]);
                command.Parameters.AddWithValue("@Sub_Dept_ID", Session["SubDeptId"]);
                command.Parameters.AddWithValue("@Designation_Id", 1);
                command.Parameters.AddWithValue("@By_Emp_Id", Session["emp_id"]);
                command.Parameters.AddWithValue("@POSub_ID", POSubID.Value);


                con.Open();
                command.ExecuteNonQuery();
                con.Close();
            }
        }
    }

    protected void btnGenerateGRN_Click(object sender, EventArgs e)
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = {new SqlParameter("@ReceiveMainID",HiddenFieldReceive_Main_id.Value),
                                   new SqlParameter("@By_Emp_Id",Session["emp_id"]),
                                   new SqlParameter("@Designation_Id",Session["DesignationID"])};
        dbMgr.ExecuteNonQuery("JV_Purchase_Voucher_GRN", "STOREConnectionString", sqlParam);
        string url = "PurchaseRecievingReport.aspx?RM_ID="+ HiddenFieldReceive_Main_id.Value+"&PO_ID="+Request.QueryString["PO_ID"];
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);
    }
    protected void btnGenerateGRNWithRate_Click(object sender, EventArgs e)
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = {new SqlParameter("@ReceiveMainID",HiddenFieldReceive_Main_id.Value),
                                   new SqlParameter("@By_Emp_Id",Session["emp_id"]),
                                   new SqlParameter("@Designation_Id",Session["DesignationID"])};
        dbMgr.ExecuteNonQuery("JV_Purchase_Voucher_GRN", "STOREConnectionString", sqlParam);
        string url = "PurchaseRecievingQty_RateReport.aspx?RM_ID=" + HiddenFieldReceive_Main_id.Value + "&PO_ID=" + Request.QueryString["PO_ID"];
        Page.ClientScript.RegisterStartupScript(this.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", true);

    }

    protected void rollbackbtn_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/store/PurchaseReturn.aspx?PO_ID=" + Request.QueryString["PO_ID"].ToString());
    }
}

public class SerialSearchCollection
{
    private String _serial;

    public String Serial
    {
        get
        {
            return _serial;
        }
        set
        {
            _serial = value;
        }
    }


    private bool _IsFound;
    public Boolean IsFound
    {
        get
        {
            return _IsFound;
        }
        set
        {
            _IsFound = value;
        }
    }

    public SerialSearchCollection(string ser, bool found)
    {
        IsFound = found;
        Serial = ser;
    }

}





