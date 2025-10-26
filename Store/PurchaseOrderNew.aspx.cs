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

public partial class MasterPage : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    public void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_PODate.Enabled = true;
            ddlPaymentTo.Enabled = true;
            DDL_Other_Currency.Enabled = true;
            txtCurrencyRate.Enabled = true;

            DDL_Other_Currency.SelectedValue = "PKR";
            GetRate("PKR");
            bindParty();
            hfPaymentToId.Value = ddlPaymentTo.SelectedValue;
            TextBox_PONo.Text = getconter();
            HiddenField_PO_ID.Value = TextBox_PONo.Text;
            WebDateChooser_PODate.Value = DateTime.Now;
            txtDateFrom.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtDateTo.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }

    protected void bindParty()
    {
        SqlConnection con = new SqlConnection(connection1);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT Party_Id, LTRIM(RTRIM(Party_Name)) as Party_Name FROM [Parties] WHERE     (LEN(LTRIM(RTRIM(Party_Name))) > 0)", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ddlPaymentTo.DataSource = ds;
            ddlPaymentTo.DataValueField = "Party_Id";
            ddlPaymentTo.DataTextField = "Party_Name";
            ddlPaymentTo.DataBind();
            BindCurrencyDropDown();
            con.Close();
        }
        catch (Exception ex)
        { }
        finally
        {
            con.Close();
        }

    }
    protected void ddlPaymentTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        hfPaymentToId.Value = ddlPaymentTo.SelectedValue;
        if (GridView1.Rows.Count > 1)
        {
            LoadGrid();
        }
    }

    protected void DDL_Other_Currency_SelectedIndexChanged(object sender, EventArgs e)
    {
        String Currency = DDL_Other_Currency.SelectedValue.ToString();
        GetRate(Currency);
    }
    protected void GetRate(String Currency)
    {
        SqlConnection con = new SqlConnection(connection1);
        string SP = "SELECT Current_rate FROM Currency WHERE (Currency_Abbrivation = @Currency)";

        SqlCommand command = new SqlCommand(SP, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Currency", Currency);

        con.Open();
        txtCurrencyRate.Text = command.ExecuteScalar().ToString();
        con.Close();
        con.Dispose();
        
    }
    protected void BindCurrencyDropDown()
    { 
        SqlConnection con = new SqlConnection(connection1);
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT[Currency_Name], [Currency_Abbrivation] FROM[Currency]", con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            DDL_Other_Currency.DataSource = ds;
            DDL_Other_Currency.DataValueField = "Currency_Abbrivation";
            DDL_Other_Currency.DataTextField = "Currency_Name";
            DDL_Other_Currency.DataBind();
            con.Close();
        }
        catch (Exception ex)
        { }
        finally
        {
            con.Close();
        }
    }
    protected void txtCurrencyRate_TextChanged(object sender, EventArgs e)
    {
        UpdateCurrency();
    }
    protected void UpdateCurrency()
    {
        SqlConnection con = new SqlConnection(connection1);
        string SP = "Update_Currency";

        SqlCommand command = new SqlCommand(SP, con);
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.AddWithValue("Other_Currency", DDL_Other_Currency.SelectedValue);
        command.Parameters.AddWithValue("Other_Currency_Rate", txtCurrencyRate.Text);
        command.Parameters.AddWithValue("PO_ID", TextBox_PONo.Text);

        con.Open();
        command.ExecuteNonQuery();
        con.Close();
        con.Dispose();
    }

    public string getconter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT ISNULL(MAX(Count), 0)+1 FROM Purchase_Order_Main where (Subdept_ID = @Dept_ID)", con);
        // WHERE (PO_ID LIKE 'P-" + HiddenField_Dept_ID.Value + "%')

        command.Parameters.AddWithValue("@Dept_ID", Convert.ToInt32(Session["SubDeptID"]));
        Int32 C;
        string rate = "0";

        try
        {
            C = (int)command.ExecuteScalar();
            if (C == 0)
            {
                rate = Convert.ToString(Convert.ToInt32(Session["SubdeptId"]) * 100000 + 1);
            }
            else
            {
                rate = Convert.ToString(C);
            }
        }
        catch (Exception ex)
        {
            //rate = "1";
        }
        con.Close();
        return rate;
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        int Count = 0;
        String XMLForOrder = "<table>";
        String XMLForFOC = "<table>";
        DbManager db = new DbManager();
        // Insert Into Purchase Order Main
        SqlParameter[] para =
        {
            new SqlParameter("@PO_ID",TextBox_PONo.Text),                   new SqlParameter("@Company_ID",ddlPaymentTo.SelectedValue),
            new SqlParameter("@Count",TextBox_PONo.Text),                   new SqlParameter("@Letter_NO","letter No"),
            new SqlParameter("@Date_Time",DateTime.Now),                    new SqlParameter("@Subject",""),
            new SqlParameter("@Emp_ID",Session["Emp_Id"]),                  new SqlParameter("@Dept_ID",Session["Dept_Id"]),
            new SqlParameter("@Status",false),                              new SqlParameter("@SubDept_ID",Session["SubDeptId"]),
            new SqlParameter("@Tender_Id",""),                              new SqlParameter("@PR_ID","0"),
            new SqlParameter("@Order_To",ddlPaymentTo.SelectedValue),       new SqlParameter("@Other_Currency",DDL_Other_Currency.SelectedValue),
            new SqlParameter("@Other_Currency_Rate",txtCurrencyRate.Text.Replace(",","").ToString()),
            new SqlParameter("@PO_Type",DropDownList_potype.SelectedValue),
            new SqlParameter("@NoType","PO"),                               new SqlParameter("@Mode_Of_Payment",DropDownList_modeof_payment.SelectedValue),
            new SqlParameter("@LeadTime",txtLeadTime.Text)
        };
        // End Main Insertion
        //Insert Into Purchase Order Sub
        foreach(GridViewRow gv in GridView1.Rows)
        {
            HiddenField hfItemCode = gv.FindControl("hfItemCode") as HiddenField;
            TextBox txtOrderQty = gv.FindControl("txtOrderQty") as TextBox;
            TextBox txtPrice_Unit = gv.FindControl("txtPrice_Unit") as TextBox;
            CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
            if (Convert.ToInt32(txtOrderQty.Text) > 0 && chkbox.Checked==true)
            {
                Count++;
                XMLForOrder = XMLForOrder + "<row> <PO_ID>" + TextBox_PONo.Text + "</PO_ID> <Item_Code>" + hfItemCode.Value + "</Item_Code> <Qty>" + txtOrderQty.Text.Replace(",","").ToString() + "</Qty> <Rate>" + txtPrice_Unit.Text.Replace(",", "").ToString() + "</Rate> <FCRate>" + txtCurrencyRate.Text.Replace(",", "").ToString() + "</FCRate> <Description></Description> </row>";
            }
        }
        XMLForOrder = XMLForOrder + "</table>";


        foreach (GridViewRow gv in GridView1.Rows)
        {
            HiddenField hfItemCode = gv.FindControl("hfItemCode") as HiddenField;
            TextBox txtFOC = gv.FindControl("txtFOC") as TextBox;
            TextBox txtPrice_Unit = gv.FindControl("txtPrice_Unit") as TextBox;
            CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
            if (txtFOC.Text == "")
            {
                txtFOC.Text = "0";
            }
            if (Convert.ToInt32(txtFOC.Text) > 0 && chkbox.Checked == true)
            {
                Count++;
                XMLForFOC = XMLForFOC + "<row> <PO_ID>" + TextBox_PONo.Text + "</PO_ID> <Item_Code>" + hfItemCode.Value + "</Item_Code> <FOC>" + txtFOC.Text.Replace(",", "").ToString() + "</FOC> <Rate>0</Rate> <FCRate>" + txtCurrencyRate.Text.Replace(",", "").ToString() + "</FCRate> <Description>FOC</Description> </row>";
            } 
        }
        XMLForFOC = XMLForFOC + "</table>";
        SqlParameter[] ParaSub =
        {
            new SqlParameter("@XMLforQty",XMLForOrder),
            new SqlParameter("@XMLforFOC",XMLForFOC),
            new SqlParameter("@Adjustment_PKR",Convert.ToDouble(PKRAdjustment.Text.Trim().Replace(",",""))),
            new SqlParameter("@Adjustment_FC",Convert.ToDouble(FCAdjustment.Text)),
            new SqlParameter("@PO_ID",TextBox_PONo.Text)
        };

        if (Count > 0)
        {
            db.ExecuteNonQuery("Insert_Purchase_Order_Main_New", "STOREConnectionString", para);

            db.ExecuteNonQuery("usp_InsertPurchaseOrderSubNew", "STOREConnectionString", ParaSub);

            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Success!";

            WebDateChooser_PODate.Enabled = false;
            ddlPaymentTo.Enabled = false;
            DDL_Other_Currency.Enabled = false;
            txtCurrencyRate.Enabled = false;
            GridView1.Visible = false;
            tblCalculations.Visible = false;
            LoadGridForUpdate();


        }


        // End Sub Insertion


    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GridView1.Visible = true;
        LoadGrid();
    }

    protected void LoadGrid()
    {
        DbManager db = new DbManager();
        SqlParameter[] para =
        {
            new SqlParameter("@StartDate",txtDateFrom.Text),
            new SqlParameter("@EnDDate",txtDateTo.Text),
            new SqlParameter("@ItemName", TextBox_specificItem.Text),
            new SqlParameter("@SubDeptID",Session["SubDeptId"]),
            new SqlParameter("@ForeignRate",txtCurrencyRate.Text),
            new SqlParameter("@Manufacturer",ddlPaymentTo.SelectedValue)
        };
        GridView1.DataSource = db.ExecuteDataTable("usp_GetItemsForPurchaseOrder_New", "STOREConnectionString", para);
        GridView1.DataBind();
        if (GridView1.Rows.Count > 0)
        { 
        tblCalculations.Visible = true;
        }
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
    }



    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkall = sender as CheckBox;
        CheckBox chkbox;
        if (chkall.Checked)
        {
            foreach (GridViewRow gv in GridView1.Rows)
            {
                chkbox = gv.FindControl("chkbox") as CheckBox;
                chkbox.Checked = true;
            }
        }
        else
        {
            foreach (GridViewRow gv in GridView1.Rows)
            {
                chkbox = gv.FindControl("chkbox") as CheckBox;
                chkbox.Checked = false;
            }
        }
        CalculateAmount();
        upVal.Update();
    }

    protected void chkbox_CheckedChanged(object sender, EventArgs e)
    {
        CalculateAmount();
        upVal.Update();
    }
    protected void CalculateAmount()
    {
        double GTotalFC= 0, GTotalPKR=0;
        Label lblTotalAmountFC, lblTotalAmountPKR;
        CheckBox chkbox;

        lblGTotalFC.Text = "0";
        lblGTotalPKR.Text = "0";
        FCNetValue.Text = "0";
        PKRNetValue.Text = "0";

        foreach (GridViewRow gv in GridView1.Rows)
        {
            chkbox = gv.FindControl("chkbox") as CheckBox;
            if (chkbox.Checked)
            {

                lblTotalAmountFC = gv.FindControl("lblTotalAmountFC") as Label;
                lblTotalAmountPKR = gv.FindControl("lblTotalAmountPKR") as Label;

                GTotalFC = GTotalFC + Convert.ToDouble(lblTotalAmountFC.Text);
                lblGTotalFC.Text = GTotalFC.ToString("0,00.00");

                GTotalPKR = GTotalPKR + Convert.ToDouble(lblTotalAmountPKR.Text);
                lblGTotalPKR.Text = GTotalPKR.ToString("0,00.00");

                if (PKRAdjustment.Text == "") { PKRAdjustment.Text = "0"; }
                if (PKRAdjustment.Text == "") { PKRAdjustment.Text = "0"; }
                FCNetValue.Text = (Convert.ToDouble(lblGTotalFC.Text) - Convert.ToDouble(FCAdjustment.Text)).ToString("0,00.00");
                PKRNetValue.Text = (Convert.ToDouble(lblGTotalPKR.Text) - Convert.ToDouble(PKRAdjustment.Text)).ToString("0,00.00");
            }

        }
    }

    protected void FCAdjustment_TextChanged(object sender, EventArgs e)
    {
        if(FCAdjustment.Text=="") { FCAdjustment.Text = "0";}
        PKRAdjustment.Text=(Convert.ToDouble(FCAdjustment.Text) * Convert.ToDouble(txtCurrencyRate.Text)).ToString("0,00.00");

        FCNetValue.Text = (Convert.ToDouble(lblGTotalFC.Text) - Convert.ToDouble(FCAdjustment.Text)).ToString("0,00.00");
        PKRNetValue.Text = (Convert.ToDouble(lblGTotalPKR.Text) - Convert.ToDouble(PKRAdjustment.Text)).ToString("0,00.00");
    }

    protected void PKRAdjustment_TextChanged(object sender, EventArgs e)
    {
        if (PKRAdjustment.Text == ""){PKRAdjustment.Text = "0"; }
        FCAdjustment.Text = (Convert.ToDouble(PKRAdjustment.Text) / Convert.ToDouble(txtCurrencyRate.Text)).ToString("0,00.00");

        FCNetValue.Text = (Convert.ToDouble(lblGTotalFC.Text) - Convert.ToDouble(FCAdjustment.Text)).ToString("0,00.00");
        PKRNetValue.Text = (Convert.ToDouble(lblGTotalPKR.Text) - Convert.ToDouble(PKRAdjustment.Text)).ToString("0,00.00");
    }

    protected void txtForeignRate_TextChanged(object sender, EventArgs e)
    {
        TextBox txtFRate = sender as TextBox;
        if (txtFRate.Text == "") { txtFRate.Text = "0"; }

        GridViewRow gv = (GridViewRow)txtFRate.NamingContainer;
        CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
        TextBox txtPKRrate = gv.FindControl("txtPrice_Unit") as TextBox;

        Label lblTotalAmountFC = gv.FindControl("lblTotalAmountFC") as Label;
        Label lblTotalAmountPKR = gv.FindControl("lblTotalAmountPKR") as Label;

        TextBox txtOrderQty = gv.FindControl("txtOrderQty") as TextBox;

        txtPKRrate.Text= (Convert.ToDouble(txtFRate.Text) * Convert.ToDouble(txtCurrencyRate.Text)).ToString("0,00.00");
        lblTotalAmountFC.Text=(Convert.ToDouble(txtFRate.Text)* Convert.ToDouble(txtOrderQty.Text)).ToString("0,00.00");
        lblTotalAmountPKR.Text=(Convert.ToDouble(txtPKRrate.Text)*Convert.ToDouble(txtOrderQty.Text)).ToString("0,00.00");
        try
        {
            if (chkbox.Checked)
            {
                CalculateAmount();
                upVal.Update();
            }
        }
        catch
        {

        }

    }

    protected void txtPrice_Unit_TextChanged(object sender, EventArgs e)
    {
        TextBox txtPkrRate = sender as TextBox;
        if (txtPkrRate.Text == "") { txtPkrRate.Text = "0"; }

        GridViewRow gv = (GridViewRow)txtPkrRate.NamingContainer;
        CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
        TextBox txtFCrate = gv.FindControl("txtForeignRate") as TextBox;

        Label lblTotalAmountFC = gv.FindControl("lblTotalAmountFC") as Label;
        Label lblTotalAmountPKR = gv.FindControl("lblTotalAmountPKR") as Label;

        TextBox txtOrderQty = gv.FindControl("txtOrderQty") as TextBox;

        txtFCrate.Text = (Convert.ToDouble(txtPkrRate.Text) / Convert.ToDouble(txtCurrencyRate.Text)).ToString("0,00.00");
        lblTotalAmountPKR.Text = (Convert.ToDouble(txtPkrRate.Text) * Convert.ToDouble(txtOrderQty.Text)).ToString("0,00.00");
        lblTotalAmountFC.Text = (Convert.ToDouble(txtFCrate.Text) * Convert.ToDouble(txtOrderQty.Text)).ToString("0,00.00");
        try
        {

        if (chkbox.Checked)
        {
            CalculateAmount();
            upVal.Update();
            }
        }
        catch
        {

        }

    }

    protected void txtOrderQty_TextChanged(object sender, EventArgs e)
    {
        TextBox txtQty = sender as TextBox;

        if (txtQty.Text == "") { txtQty.Text = "0"; }
        GridViewRow gv = (GridViewRow)txtQty.NamingContainer;

        CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
        TextBox txtFCrate = gv.FindControl("txtForeignRate") as TextBox;
        TextBox txtPkrRate = gv.FindControl("txtPrice_Unit") as TextBox;

        Label lblTotalAmountFC = gv.FindControl("lblTotalAmountFC") as Label;
        Label lblTotalAmountPKR = gv.FindControl("lblTotalAmountPKR") as Label;
        
        
        lblTotalAmountPKR.Text = (Convert.ToDouble(txtPkrRate.Text) * Convert.ToDouble(txtQty.Text)).ToString("0,00.00");
        lblTotalAmountFC.Text = (Convert.ToDouble(txtFCrate.Text) * Convert.ToDouble(txtQty.Text)).ToString("0,00.00");

        try
        {
            if (chkbox.Checked)
            {
                CalculateAmount();
                upVal.Update();
            }
        }
        catch
        {

        }
    }


    protected void LoadGridForUpdate()
    {
        DbManager db = new DbManager();
        SqlParameter[] para =
       {
            new SqlParameter("@StartDate",txtDateFrom.Text),
            new SqlParameter("@EnDDate",txtDateTo.Text),
            new SqlParameter("@SubDeptID",Session["SubDeptId"]),
            new SqlParameter("@PO_ID",TextBox_PONo.Text)

        };
        GridViewUpdate.DataSource = db.ExecuteDataTable("usp_GetItemsForPurchaseOrder_ForUpdate", "STOREConnectionString", para);
        GridViewUpdate.DataBind();
        if (GridViewUpdate.Rows.Count > 0)
        {

            btnTransfer.Visible = true;
        }
    }
    protected void updtBtn_Click(object sender, EventArgs e)
    {
        Button updtBtn = sender as Button;
        DbManager db = new DbManager();
        CheckBox chkbox;
        HiddenField hfPO_Sub_Id;
        HiddenField hfItemCode;
        TextBox txtOrderQty;
        TextBox txtForeignRate;
        TextBox txtPrice_Unit;
        GridViewRow gv = (GridViewRow)updtBtn.NamingContainer;
            
                hfPO_Sub_Id = gv.FindControl("hfPO_Sub_Id") as HiddenField;
                hfItemCode = gv.FindControl("hfItemCode") as HiddenField;
                txtOrderQty = gv.FindControl("txtOrderQty") as TextBox;
                txtForeignRate = gv.FindControl("txtForeignRate") as TextBox;
                txtPrice_Unit = gv.FindControl("txtPrice_Unit") as TextBox;


                SqlParameter[] para =
                    {
                        new SqlParameter("@PO_ID_Sub",hfPO_Sub_Id.Value),
                        new SqlParameter("@Item_Code",hfItemCode.Value),
                        new SqlParameter("@Qty",txtOrderQty.Text),
                        new SqlParameter("@ForeignRate",txtForeignRate.Text),
                        new SqlParameter("@UnitPrice",txtPrice_Unit.Text),
                    };
                db.ExecuteNonQuery("usp_UpdatePurchaseOrder_New", "STOREConnectionString", para);
                lblMessageForUpdate.Text = "Updated Successfully!";
            LoadGridForUpdate();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = sender as Button;
        DbManager db = new DbManager();
        SqlParameter[] para =
        {
            new SqlParameter("@PO_ID_Sub",btn.CommandArgument)
        };
        db.ExecuteDataTableWithQuery("Delete From Purchase_Order_Sub where PO_ID_Sub=@PO_ID_Sub", "STOREConnectionString", para);
        LoadGridForUpdate();
        lblMessageForUpdate.Text = "Deleted Successfully!";
    }

    protected void GridViewUpdate_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow gv in GridViewUpdate.Rows)
        {
            Button btn = gv.FindControl("btnDelete") as Button;
            if(GridViewUpdate.Rows.Count>1)
            {
                btn.Visible = true;
            }
            else
            {
                btn.Visible = false;
            }
        }
    }
    

    protected void btnTransfer_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridViewUpdate.Rows.Count; i++)
        {
            string qry = "update Purchase_Order_Main set FAC = 1 where PO_ID=@PO_ID";
            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand(qry, con);
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@PO_ID", TextBox_PONo.Text);
            command.ExecuteNonQuery();
            con.Close();
        }
        lblMessageForUpdate.Visible = true;
        lblMessageForUpdate.Text = "Successfully Transfer...";
        lblMessageForUpdate.ForeColor = System.Drawing.Color.Green;
        btnTransfer.Visible = false;
        GridViewUpdate.Visible = false;
        
    }
}


