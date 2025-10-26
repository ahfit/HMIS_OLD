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
    voucher_insertion VI = new voucher_insertion();
    DbManager dbMgr = new DbManager();
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    string F_constr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;

    public string getconter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("uspGetPONewPO_ID", con);
        command.CommandType = CommandType.StoredProcedure;
        // WHERE (PO_ID LIKE 'P-" + HiddenField_Dept_ID.Value + "%')

        command.Parameters.AddWithValue("@Dept_ID", Convert.ToInt32(Session["Subdeptid"]));
        command.Parameters.AddWithValue("@EmpID", Convert.ToInt32(Session["emp_id"]));

        Int32 C;
        string rate;
        SqlDataAdapter da = new SqlDataAdapter(command);
        DataTable dt = new DataTable();
        da.Fill(dt);
        try
        {
            rate = dt.Rows[0][0].ToString();
            HiddenField_Count.Value = dt.Rows[0][1].ToString();
            //if (C == 0
            //{
            //    rate = Convert.ToString(Convert.ToInt32(Session["Subdeptid"]) * 100000 + 1);
            //}
            //else
            //{
            //    rate = Convert.ToString(C + 1);
            //}

        }
        catch (Exception ex)
        {
            rate = "1";
        }
        con.Close();
        return rate;
    }
    public string getrate(string item)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT  isnull(Rate,0), Med_Code FROM Store_Tender_Sub WHERE (SR_NO =" + item + ")", con);
        SqlDataReader reader = command.ExecuteReader();
        reader.Read();
        string rate = reader[0].ToString();
        HiddenField_Item_Code.Value = reader[1].ToString();
        con.Close();
        return rate;
    }
    protected void validate(string url, string dept)
    {
        if (Session["emp_id"] == null || Session["SubDeptId"] == null)
        {
            Response.Redirect("../login.aspx");
        }

    }
    protected void Load_PO_For_PR(String PR_ID, String Company_ID)
    {
        //Company Name
        ddlPaymentTo.Text = getCompanyName(Company_ID);
        HiddenField_PR_ID.Value = PR_ID;
        string qry = "SELECT Purchase_Requsition_Sub.Item_Code, ISNULL(Purchase_Requsition_Suggested_Companies.Finalized_Rate_Per_Unit, '') AS Finalized_Rate, ISNULL(Purchase_Requsition_Suggested_Companies.Finalized_Qty, '') AS Finalized_Qty FROM Purchase_Requsition_Suggested_Companies INNER JOIN Purchase_Requsition_Sub ON Purchase_Requsition_Suggested_Companies.Item_Code = Purchase_Requsition_Sub.Item_Code AND Purchase_Requsition_Suggested_Companies.PR_ID = Purchase_Requsition_Sub.PR_ID WHERE (Purchase_Requsition_Sub.PR_ID = 'PR-1104') AND (Purchase_Requsition_Suggested_Companies.IS_Finalized = 1) AND (Purchase_Requsition_Suggested_Companies.Company_ID = 200043) ORDER BY Purchase_Requsition_Sub.Entry_Date";
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@PR_ID", PR_ID);
        command.Parameters.AddWithValue("@Company_ID", Company_ID);

        SqlDataReader reader = command.ExecuteReader();

        while (reader.Read())
        {

            Insert_PO_For_PR(reader["Item_Code"].ToString(), reader["Finalized_Rate"].ToString(), reader["Finalized_Qty"].ToString());
        }
        reader.Close();
        con.Close();

    }
    protected void Insert_PO_For_PR(String Item_Code, String Rate, String Qty)
    {

        HiddenField_Item_Code.Value = Item_Code;
        HiddenField_ItemRate.Value = Rate;
        HiddenField_Item_Qty.Value = Qty;


        try
        {

            HiddenField_PODate.Value = txtPODate.Text.ToString();
            SqlDataSource1.Insert();



        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        try
        {
            //HiddenField_Rate.Value = getrate(TreeView1.SelectedValue);

            SqlDataSource_For_POPR.Insert();
            if (GridView1.Rows.Count > 0)
            {
                ddlPaymentTo.Enabled = false;
                addlink.Visible = false;

            }
            else
            {
                ddlPaymentTo.Enabled = true;
                addlink.Visible = true;

            }
            GridView1.DataBind();
            Button1.Visible = true;
        }
        catch (Exception ex1)
        {
            Response.Write(ex1.Message);
        }




    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {

                ddlManufacturer.DataBind();
                ddlManufacturer.SelectedValue = "0";

                if (Request.QueryString["TY"] == "Loan")
                {
                    txtDemandReqNo.Enabled = false;
                    btnAddDemandItems.Visible = false;
                    DropDownList_potype.SelectedValue = "Loan";
                    DropDownList_potype.Enabled = false;
                }

                if (Request.QueryString["TY"] != null && Request.QueryString["PR_ID"] != null 
                    && Request.QueryString["SubDeptId"] != null)
                {
                    if (Request.QueryString["TY"] == "PR")
                    {
                        txtDemandReqNo.Enabled = false;
                        txtDemandReqNo.Text = Request.QueryString["PR_ID"].ToString();
                        HiddenField_PR_ID.Value = txtDemandReqNo.Text.Trim();
                        btnAddDemandItems.Visible = false;
                        btnAddAllItems.Visible = true;
                        ddlforstore.SelectedValue = Request.QueryString["SubDeptId"].ToString();
                    }

                }
                HiddenField_Company_ID.Value = hfPaymentToId.Value;
            }
            //ddlPaymentTo.Attributes.Add("onKeyUp", "checkEscKey("+ddlPaymentTo+e+")");
            //validate("", "");

            HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
            HiddenField_Emp_ID.Value = Session["emp_id"].ToString();

            if (!(IsPostBack))
            {

                label_Budget.Text = "";

                txtPODate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtDDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                //DropDownList_SelectTaxDiscount.DataBind();
                DDL_Other_Currency.SelectedValue = "PKR";
                GetRate("PKR");
                DDL_Other_Currency.Enabled = true;
                DropDownList_Budget.DataBind();
                LoadBalance();
                loadRecieveDepartmebt();
                //  LoadQuotation();

            }


            //Request.QueryString["Company_ID"].ToString();
            if (!IsPostBack)
            {

                TextBox_PONo.Text = getconter();
                HiddenField_PO_ID.Value = TextBox_PONo.Text;
                //SqlDataSource1.Delete();


            }
            if (GridView1.Rows.Count <= 0)
            {
                Button1.Visible = false;
            }
            else
            {
                Button1.Visible = true;
            }

            DataList_TAXDiscount.DataBind();
            //Load_Tax();
            if (!IsPostBack)
            {
                if (Session["PR_ID"] != null && Session["Company_ID"] != null)
                {
                    Load_PO_For_PR(Session["PR_ID"].ToString(), Session["Company_ID"].ToString());
                }



                if (Request.QueryString["PO_ID"] != null)
                {
                    //if (CheckIfPOAlreadyApproved() == false)
                    //{
                        TextBox_PONo.Text = Request.QueryString["PO_ID"].ToString();
                        TextBox_PONo.Enabled = false;
                        HiddenField_PO_ID.Value = TextBox_PONo.Text;
                        GetSetPONo();
                    //}
                    //else
                    //{
                    //    Label_Msg.Text = "Approved Or Forwarded to Store PO Cannot be Edited";
                    //    Label_Msg.Visible = true;
                    //}
                }
                if (Request.QueryString["phm"] == null)
                {
                    //if (String.IsNullOrEmpty(Request.QueryString["phm"].ToString()))
                    //{
                        checkIsForwarded();
                    //}
                }
                else
                {
                    btnForward.Visible = true;
                }
                if (!ddlforstore.SelectedItem.Text.Contains("STORE"))
                {
                    aceItems.ContextKey = "0";
                }
                else
                {
                    aceItems.ContextKey = ddlforstore.SelectedValue;
                }
            }

        }
        catch (Exception ex) {
            //Response.Write(ex.Message);
        }
    }

    private bool CheckIfPOAlreadyApproved()
    {
        if (Request.QueryString["PO_ID"] != null)
        {
            DbManager db = new DbManager();
            SqlParameter[] param = new SqlParameter[]
            {
                new SqlParameter("PO_ID",Request.QueryString["PO_ID"].ToString())
            };
            DataTable dt = db.ExecuteDataTableWithQuery(@"select isnull(ForWardToStore,0)as ForWardToStore,FAC,FAC_Complete
from Purchase_Order_Main where PO_ID=@PO_ID", "STOREConnectionString", param);

            if (dt.Rows.Count > 0)
            {
                if (Convert.ToBoolean(dt.Rows[0]["FAC"]) == true ||
                    Convert.ToBoolean(dt.Rows[0]["ForWardToStore"]) == true)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }


    private void loadRecieveDepartmebt()
    {
        try
        {
            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            String query = "";
            if (!String.IsNullOrEmpty(Request.QueryString["Con"]))
            {
                query = "Select	 upper(SD.SubDept_Name) SubDept_Name, SD.SubDept_Id From	SubDepartment SD Where SubDept_Name like 'Con%' and  SubDept_Id in (Select Distinct Main_Subdept_ID From requisition_department_filter R Where EmpID=@EmpID and (Requisition_Type like 'GRN') )  Order By SubDept_Name";
            }
            else
            {
                query = "Select	 upper(SD.SubDept_Name) SubDept_Name, SD.SubDept_Id From	SubDepartment SD Where  SubDept_Id in (Select Distinct Main_Subdept_ID From requisition_department_filter R Where EmpID=@EmpID and (Requisition_Type like 'GRN') )  Order By SubDept_Name desc";
            }
            SqlCommand command = new SqlCommand(query, con);
            command.Parameters.AddWithValue("@EmpID", Session["emp_id"].ToString());
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddlforstore.DataSource = dt;
            ddlforstore.DataTextField = "SubDept_Name";
            ddlforstore.DataValueField = "SubDept_Id";
            ddlforstore.DataBind();
        }
        catch (Exception ex)
        {


        }
    }
    protected void GetSetPONo()
    {
        IsExist(TextBox_PONo.Text);

        Load_PO(TextBox_PONo.Text);
        btn_OCurrency.Text = "Report in " + DDL_Other_Currency.SelectedItem.Text;
        btn_OCurrency.Visible = true;
        Button4.Visible = true;


    }
    public void Load_Tax()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT Amount FROM PO_Tax_Discount WHERE (PO_ID = @PO_ID) AND (Tax_ID = @Tax_ID)", con);
        command.Parameters.AddWithValue("@PO_ID", TextBox_PONo.Text);
        command.Parameters.AddWithValue("@Tax_ID", DropDownList_SelectTaxDiscount.SelectedValue);
        try
        {
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                TextBox_TaxDiscountAmount.Text = reader["Amount"].ToString();
            }
            else
            {
                TextBox_TaxDiscountAmount.Text = "0";
            }

        }
        catch (Exception ex)
        {

        }
        con.Close();

    }
    protected void TextBox_specificMedicine_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string PRID = "";
        if (txtItemVendor.Text == "")
        {
            hdfItemVendor.Value = "0";
        }
        if (TextBox_specificItem.Text == "")
        {
            hfItemName.Value = "%";
            sdsItems.SelectParameters["Item_Name"].DefaultValue = "%";
        }
        else
        {
            hfItemName.Value = TextBox_specificItem.Text;
            sdsItems.SelectParameters["Item_Name"].DefaultValue = TextBox_specificItem.Text;
        }
        if (txtDemandReqNo.Text.Trim() != "" && TextBox_specificItem.Text == "")
        {
            PRID = Request.QueryString["PR_ID"].ToString();
        }
        LoadItemGrid(PRID);

        // gvItems.DataBind();
    }
    
    protected void Button3_Click(object sender, EventArgs e)
    {

    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count > 0)
        {
            ddlPaymentTo.Enabled = false;
            addlink.Visible = false;
        }
        else
        {
            addlink.Visible = true;
            ddlPaymentTo.Enabled = true;
        }

        if (GridView1.Rows.Count != 0)
        {

            double G_Total = 0;
            double TotalQty = 0;
            double TotalQty_ForQtyWiseExpense = 0;
            double TotalQty_ForAmountWiseExpense = 0;
            double totalDisAmount = 0;
            double GD_Total = 0;
            if (txtCurrencyRate.Text.Trim() == "0" || txtCurrencyRate.Text.Trim() == "")
                txtCurrencyRate.Text = "1";
            Label OC_Head = (Label)GridView1.HeaderRow.FindControl("label_OCurrency_Head");
            OC_Head.Text = "Rate in " + DDL_Other_Currency.SelectedItem.Value;
            Label OCA_Head = (Label)GridView1.HeaderRow.FindControl("lbl_hCAmount");
            OCA_Head.Text = "Amount in " + DDL_Other_Currency.SelectedItem.Value;
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {

                TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");
                TextBox TextBox_ORate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Other_Currency_Rate");
                TextBox TextBox_Qty = (TextBox)GridView1.Rows[i].FindControl("TextBox_Qty");
                TextBox txtPack = (TextBox)GridView1.Rows[i].FindControl("txtPack");
                TextBox txtUnitsPack = (TextBox)GridView1.Rows[i].FindControl("txtUnitsPack");
                TextBox txtPackRate = (TextBox)GridView1.Rows[i].FindControl("txtPackRate");

                TextBox lblDiscountRate = (TextBox)GridView1.Rows[i].FindControl("lblDiscountRate");
                Label Label_Amount = (Label)GridView1.Rows[i].FindControl("Label_Amount");
                Label lblExpenseQtyWise = (Label)GridView1.Rows[i].FindControl("lblExpenseQtyWise");
                Label lblExpenseAmountWise = (Label)GridView1.Rows[i].FindControl("lblExpenseAmountWise");
                Label lblDisAmount = (Label)GridView1.Rows[i].FindControl("lblTotalDisAmount");
                double Rate, packRate;
                double Qty, pack, unitPack;
                double ORate;


                if (lblExpenseQtyWise.Text == "NaN")
                {
                    lblExpenseQtyWise.Text = "0";
                }
                if (lblExpenseAmountWise.Text == "NaN")
                {
                    lblExpenseAmountWise.Text = "0";
                }
                if (txtPackRate.Text == "")
                {
                    packRate = 0;
                    txtPackRate.Text = "0";
                }
                else
                {

                    packRate = Convert.ToDouble(txtPackRate.Text);

                }
                if (TextBox_Rate.Text == "")
                {
                    Rate = 0;
                    ORate = 0;
                    TextBox_Rate.Text = "0";
                }
                else
                {

                    Rate = Convert.ToDouble(TextBox_Rate.Text.Trim());
                    ORate = Convert.ToDouble(Math.Round((Convert.ToDecimal(TextBox_Rate.Text) / Convert.ToDecimal(txtCurrencyRate.Text)), 2));

                }
                //if (txtPack.Text == "")
                //{
                //    pack = 0;
                //    txtPack.Text = "0";
                //}
                //else
                //{
                //    pack = Convert.ToDouble(txtPack.Text);
                //}
                if (txtUnitsPack.Text == "")
                {
                    unitPack = 0;
                    txtUnitsPack.Text = "0";
                }
                else
                {
                    unitPack = Convert.ToDouble(txtUnitsPack.Text);
                }
                if (TextBox_Qty.Text == "")
                {
                    Qty = 0;
                    TextBox_Qty.Text = "0";
                }
                else
                {
                    Qty = Convert.ToDouble(TextBox_Qty.Text);
                }
                //if (pack == 1 && unitPack == 1)  Comment by Zia on 18/06/2020
                //{

                //}
                //else
                //{
                //    Qty = pack * unitPack;
                //}

                if (packRate == 0)
                {
                    //packRate = (Rate * Qty) / pack;
                    //txtPackRate.Text = packRate.ToString();
                }
                else
                {
                    //packRate = packRate * pack;    Comment By Zia on 18/06/2020
                    //Rate = (packRate) / Qty;
                }
                if (lblDisAmount.Text == "")
                {
                    lblDisAmount.Text = "0";
                }
                double DTotal = Convert.ToDouble(lblDisAmount.Text);
                GD_Total += DTotal;
                //lblDisAmount.Text = DTotal.ToString();
                //double DTotal = Convert.ToDouble(lblDiscountRate.Text.Trim()) * Qty;
                //GD_Total += DTotal;
                //lblDisAmount.Text = DTotal.ToString();
                //totalDisAmount = totalDisAmount + Convert.ToDouble(lblDisAmount.Text); Comment by Zia on 18/06/2020
                double Total = Rate * Qty;

                G_Total += Total;
                Label_Amount.Text = Total.ToString();
                TotalQty += Qty;
                if (lblExpenseQtyWise.Text.Trim() != "0")
                    TotalQty_ForQtyWiseExpense += Qty;
                if (lblExpenseAmountWise.Text.Trim() != "0")
                    TotalQty_ForAmountWiseExpense += Total;
                TextBox_ORate.Text = ORate.ToString();
                TextBox_Rate.Text = Rate.ToString();
            }

            Label Label_GTotalAmount = (Label)GridView1.FooterRow.FindControl("Label_GTotalAmount");
            Label_GTotalAmount.Text = G_Total.ToString();

            Label lblGDisTotalAmount = (Label)GridView1.FooterRow.FindControl("LblDisTotalAmount");
            //lblGDisTotalAmount.Text = totalDisAmount.ToString(); Comment by Zia on 18/06/2020
            lblGDisTotalAmount.Text = GD_Total.ToString();

            Panel_TaxDiscount.Visible = false;

            //  ===================================================================================================
            foreach (GridViewRow gvr in GridView1.Rows)
            {
                TextBox TextBox_Qty = (TextBox)gvr.FindControl("TextBox_Qty");
                Label Label_Amount = (Label)gvr.FindControl("Label_Amount");
                Label lblItemWiseExpense = (Label)gvr.FindControl("lblItemWiseExpense");
                Label lblCostWiseExpense = (Label)gvr.FindControl("lblCostWiseExpense");
                Label lblExpenseQtyWise = (Label)gvr.FindControl("lblExpenseQtyWise");
                Label lblExpenseAmountWise = (Label)gvr.FindControl("lblExpenseAmountWise");
                TextBox TextBox_Other_Currency_Rate = (TextBox)gvr.FindControl("TextBox_Other_Currency_Rate");
                lblItemWiseExpense.Text = (Math.Round(Convert.ToDouble((Convert.ToDouble(lblExpenseQtyWise.Text) / TotalQty_ForQtyWiseExpense) * Convert.ToDouble(TextBox_Qty.Text)), 2)).ToString();
                lblCostWiseExpense.Text = (Math.Round(Convert.ToDouble((Convert.ToDouble(Label_Amount.Text) / TotalQty_ForAmountWiseExpense) * Convert.ToDouble(lblExpenseAmountWise.Text)), 2)).ToString();
                //===================================== Set Rates According To Currency Rate ============================  
                TextBox TXT_Currency_Rate = (TextBox)gvr.FindControl("TXT_Currency_Rate");
                TXT_Currency_Rate.Text = Convert.ToString(Convert.ToDouble(TextBox_Other_Currency_Rate.Text) * Convert.ToDouble(TextBox_Qty.Text));//Convert.ToString(Convert.ToDouble(Label_Amount.Text) * Convert.ToDouble(txtCurrencyRate.Text));

            }
            Label lblCurrencyRateFooter = (Label)GridView1.FooterRow.FindControl("lblCurrencyRateFooter");
            lblCurrencyRateFooter.Text = Convert.ToString(System.Math.Round((Convert.ToDouble(Label_GTotalAmount.Text) / Convert.ToDouble(txtCurrencyRate.Text)), 2));
        }
        else
        {
            Panel_TaxDiscount.Visible = false;
        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        Label Total_amount = (Label)GridView1.FooterRow.FindControl("Label_GTotalAmount");

        //if (Convert.ToInt64(lblBalance.Text) >= Convert.ToInt64(Total_amount.Text))
        //{
        //label_Budget.Text = "";
        updatePOMain();
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            try
            {
                HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
                HiddenField poSubID = (HiddenField)GridView1.Rows[i].FindControl("HiddenField_PO_Sub_ID");
                TextBox qty = (TextBox)GridView1.Rows[i].FindControl("TextBox_Qty");
                TextBox pack = (TextBox)GridView1.Rows[i].FindControl("txtPack");
                TextBox unitPack = (TextBox)GridView1.Rows[i].FindControl("txtUnitsPack");
                TextBox packRate = (TextBox)GridView1.Rows[i].FindControl("txtPackRate");
                TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");
                Label lblCostWiseExpense = (Label)GridView1.Rows[i].FindControl("lblCostWiseExpense");
                Label lblItemWiseExpense = (Label)GridView1.Rows[i].FindControl("lblItemWiseExpense");
                TextBox TextBox_For_Cus = (TextBox)GridView1.Rows[i].FindControl("Txt_For_Customer");
                TextBox TextBox_For_Branch = (TextBox)GridView1.Rows[i].FindControl("Txt_For_Branch");
                TextBox TextBox_QO_No = (TextBox)GridView1.Rows[i].FindControl("Txt_QO_No");
                TextBox TextBox_OR_No = (TextBox)GridView1.Rows[i].FindControl("Txt_Order_No");
                TextBox txtDiscount = (TextBox)GridView1.Rows[i].FindControl("txtDiscount");
                TextBox txtBonusQty = (TextBox)GridView1.Rows[i].FindControl("txtBonusQty");
                TextBox txtRate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");
                TextBox txtSale = (TextBox)GridView1.Rows[i].FindControl("txtVat");
                if (qty.Text.Trim() != "")
                {
                    HiddenField_Item_Code.Value = code.Value;
                    HiddenField_QTY.Value = qty.Text.Trim();
                    HiddenField_DTL_Sample.Value = "";//DTL.Text;
                    HiddenField_Specification.Value = TextBox_Specification.Text;
                    Hf_OR_No.Value = TextBox_OR_No.Text;
                    Hf_QO_No.Value = TextBox_QO_No.Text;
                    Hf_For_Customer.Value = TextBox_For_Cus.Text;
                    Hf_for_branch.Value = TextBox_For_Branch.Text;
                    hdfPack.Value = pack.Text;
                    hdfUnitPack.Value = unitPack.Text;
                    hdfPackRate.Value = packRate.Text;
                    try
                    {
                        if (txtTermsAndConditions.Text == "")
                        {
                            TextBox_Temp_TermsAndCondition.Text = "0";
                        }
                        else
                        {
                            TextBox_Temp_TermsAndCondition.Text = txtTermsAndConditions.Text;
                        }

                        TextBox txt_Rate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");
                        TextBox lblDisRate = (TextBox)GridView1.Rows[i].FindControl("lblDiscountRate");
                        HiddenField_ItemOrgRate.Value = txt_Rate.Text;
                        HiddenField_ItemRate.Value = lblDisRate.Text;
                        if (lblCostWiseExpense.Text == "NaN")
                        {
                            lblCostWiseExpense.Text = "0";

                        }
                        if (lblItemWiseExpense.Text == "NaN")
                        {
                            lblItemWiseExpense.Text = "0";

                        }
                        hf_CostWiseExpense.Value = lblCostWiseExpense.Text;
                        hf_ItemWiseExpense.Value = lblItemWiseExpense.Text;
                        SqlDataSource2.UpdateParameters["Discount"].DefaultValue = txtDiscount.Text;
                        SqlDataSource2.UpdateParameters["BonusQty"].DefaultValue = txtBonusQty.Text;
                        SqlDataSource2.UpdateParameters["PO_ID_Sub"].DefaultValue = poSubID.Value;
                        SqlDataSource2.Update();
                        btn_OCurrency.Text = "Report in " + DDL_Other_Currency.SelectedItem.Text;
                        btn_OCurrency.Visible = true;
                        Button4.Visible = true;
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex.Message);

                    }

                }

            }
            catch (Exception ex) { }

        }
        //}
        //else
        //{
        //    label_Budget.Text = "Actual amount is exceeding budget amount.";
        //}

        GridView1.DataBind();
    }
    protected void Button4_Click(object sender, EventArgs e)
    {


        if (GridView1.Rows.Count != 0)
        {
            updatePOMain();
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>window.open('PurchaseOrderReport.aspx?PO_ID=" + HiddenField_PO_ID.Value + "')</script>");
            Type t = GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "PopUp"))
            {
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
            }
        }
    }



    protected void TextBox3_TextChanged(object sender, EventArgs e)
    {

        try
        {
            SqlConnection con = new SqlConnection(connection1);
            SqlCommand command = new SqlCommand("SELECT DISTINCT top(1) ISNULL(Store_Tender_Sub.Company_ID, 0) AS Company_ID FROM Store_Tender_Sub INNER JOIN Store_Items ON Store_Tender_Sub.Med_Code = Store_Items.Item_Code WHERE (Store_Items.Item_Name LIKE @Item_Name + '%')", con);
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@Item_Name", TextBoxItemName.Text);
            con.Open();
            Int32 company_id = (Int32)command.ExecuteScalar();
            hfPaymentToId.Value = company_id.ToString();
            con.Close();
        }
        catch (Exception ex)
        {
        }
    }
    protected void TextBox_ItemCode_TextChanged(object sender, EventArgs e)
    {
        try
        {
            HiddenField_PODate.Value = txtPODate.Text.ToString();
            SqlDataSource1.Insert();

        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);    
        }
        try
        {
            //HiddenField_Rate.Value = getrate(TreeView1.SelectedValue);
            HiddenField_Item_Code.Value = TextBox_ItemCode.Text;
            SqlDataSource2.Insert();
            if (GridView1.Rows.Count > 0)
            {
                ddlPaymentTo.Enabled = false;
                addlink.Visible = false;

            }
            else
            {
                ddlPaymentTo.Enabled = true;
                addlink.Visible = true;

            }
            GridView1.DataBind();
            Button1.Visible = true;
        }
        catch (Exception ex1)
        {
            //Response.Write(ex1.Message);
        }
    }

    protected bool IsExist(String PO_ID)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        bool flag = false;
        SqlCommand command = new SqlCommand("usp_Select_Existing_PO", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@PO_ID", PO_ID);
        DropDownList_potype.Enabled = false;
        try
        {
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                flag = true;
                HiddenField_CompanyID.Value = reader["Company_ID"].ToString();
                DateTime dt = Convert.ToDateTime(reader["date_time"].ToString());
                txtPODate.Text = dt.ToString("yyyy-MM-dd");
                txtPODate.Enabled = false;
                txtTermsAndConditions.Text = reader["Term_and_Conditions"].ToString();
                if (txtTermsAndConditions.Text == "")
                {
                    getTermsAndConditions();
                }
                if (!String.IsNullOrEmpty(reader["Receiving_Dept"].ToString()) && reader["Receiving_Dept"].ToString() != "0")
                {
                    ddlforstore.SelectedValue = reader["Receiving_Dept"].ToString();
                }
                TextBox_payment_Process.Text = reader["Payment_Process"].ToString();
                DDL_Other_Currency.SelectedValue = reader["Other_Currency"].ToString();
                txtCurrencyRate.Text = reader["Other_Currency_Rate"].ToString();
                lblQuotationNo.Text = reader["Qutation_Main_ID"].ToString();

                if (reader["LC_No"] != "")
                {
                    TextBox_LC.Text = reader["LC_No"].ToString();
                }
                if (reader["PO_Type"] != "")
                {
                    DropDownList_modeof_payment.SelectedValue = reader["PO_Type"].ToString();
                }
                if (reader["For_Customer"] != "")
                {
                    TextBox_customer.Text = reader["For_Customer"].ToString();
                }
                if (reader["Mode_Of_Payment"] != "")
                {
                    DropDownList_modeof_payment.SelectedValue = reader["Mode_Of_Payment"].ToString();
                }
                if (reader["For_Branches"] != "")
                {
                    TextBox_branches.Text = reader["For_Branches"].ToString();
                }
                if (reader["Ship_To"] != "")
                {
                    TextBox_shipto.Text = reader["Ship_To"].ToString();
                }
                if (reader["QO_No"] != "")
                {
                    TextBox_quotation.Text = reader["QO_No"].ToString();
                }
                if (reader["Mode_Of_Delivery"] != "")
                {
                    TextBox_modeof_delivery.Text = reader["Mode_Of_Delivery"].ToString();
                }
                //if (reader["Order_To_Vandor"] != "")
                //{
                //    hfOrderTo.Value = reader["Order_To_vendor"].ToString();
                //}
                if (reader["Payment_To"] != "")
                {
                    ddlPaymentTo.Text = reader["Payment_To"].ToString();
                }
                if (reader["OrderTo"] != "" || reader["OrderTo"] != "-2")
                {
                    ddlOrderTo.Text = reader["OrderTo"].ToString();
                }
                else
                {
                    ddlOrderTo.Text = ddlPaymentTo.Text;
                }
                if (reader["PayTerms"] != "")
                {
                    ddlPayTerms.SelectedValue = reader["PayTerms"].ToString();
                }
                if (reader["Delivery_Date"] != "")
                {
                    DateTime d = Convert.ToDateTime(reader["Delivery_Date"].ToString());
                    txtDDate.Text = d.ToString("yyyy-MM-dd");
                }
            }
            else
            {
                flag = false;
            }
        }
        catch (Exception ex)
        {
            flag = false;
        }
        con.Close();
        return flag;

    }
    protected void getTermsAndConditions()
    {
        try
        {
            String query = "Select Terms_Conditions From TermsAndConditions Where Terms_Conditions like @Terms_Conditions";
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@Terms_Conditions", "%") };
            DataTable dt = new DataTable();
            dt = dbm.ExecuteDataTableWithQuery(query, "STOREConnectionString", sp);
            foreach (DataRow dr in dt.Rows)
            {
                txtTermsAndConditions.Text = txtTermsAndConditions.Text + "• " + dr[0].ToString().Trim() + "\n";
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected bool IsApproved(String PO_ID)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        bool flag = false;
        SqlCommand command = new SqlCommand("SELECT Company_ID, Date_Time FROM Purchase_Order_Main where ( FAC = 1 ) and  (FAC_Complete = 1) And (PO_ID = @PO_ID)", con);
        command.Parameters.AddWithValue("@PO_ID", PO_ID);

        try
        {
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                flag = true;
                HiddenField_CompanyID.Value = reader["Company_ID"].ToString();
                txtPODate.Text = reader["Date_Time"].ToString();
                txtPODate.Enabled = false;


            }
            else
            {
                flag = false;
            }
        }
        catch (Exception ex)
        {
            flag = false;
        }
        con.Close();
        return flag;

    }

    
    protected void Load_PO(string PO_ID)
    {
        HiddenField_PO_ID.Value = PO_ID;
        hfPaymentToId.Value = HiddenField_CompanyID.Value;
        hfOrderTo.Value = HiddenField_CompanyID.Value;
        ddlPaymentTo.Enabled = false;
        GridView1.DataBind();
        Button1.Visible = true;

    }

    protected void TextBox_PONo_TextChanged(object sender, EventArgs e)
    {

        //HiddenField_PO_ID.Value = TextBox_PONo.Text;
        TextBox_TaxDiscountAmount.Text = "";
        if (IsApproved(TextBox_PONo.Text))
        {
            Label_Msg.Text = "Already Existed and Approved";
            Label_Msg.Visible = true;
            txtTermsAndConditions.Text = "";
            TextBox_payment_Process.Text = "";

            Button1.Visible = false;
            HiddenField_PO_ID.Value = "0";
        }

        else
        {

            if (IsExist(TextBox_PONo.Text))
            {
                Label_Msg.Text = "Already Existed";
                Label_Msg.Visible = true;
                Load_PO(TextBox_PONo.Text);
                btn_OCurrency.Text = "Report in " + DDL_Other_Currency.SelectedItem.Text;
                btn_OCurrency.Visible = true;
                Button4.Visible = true;


            }
            else
            {
                Label_Msg.Text = "";
                Label_Msg.Visible = false;
                ddlPaymentTo.Enabled = true;
                txtTermsAndConditions.Text = "";
                TextBox_payment_Process.Text = "";
                //GridView1.Visible = false;
                Button1.Visible = false;
                HiddenField_PO_ID.Value = TextBox_PONo.Text;

                txtPODate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtPODate.Enabled = true;
            }


        }




    }

    protected void Button_SaveTaxDis_Click(object sender, EventArgs e)
    {
        if (TextBox_TaxDiscountAmount.Text == "")
        {
            TextBox_TaxDiscountAmount.Text = "0";
        }
        try
        {
            double amount;
            Label lblTotal = (Label)GridView1.FooterRow.FindControl("Label_GTotalAmount");
            amount = Convert.ToDouble(lblTotal.Text) * Convert.ToDouble(TextBox_TaxDiscountAmount.Text) / 100;
            SqlDataSource_TAX_Discount_Insert.InsertParameters["Amount"].DefaultValue = amount.ToString();
            SqlDataSource_TAX_Discount_Insert.Insert();

            DataList_TAXDiscount.DataBind();
        }
        catch (Exception ex)
        {
        }
        //Load_Tax();

    }

    protected void DataList_TAXDiscount_PreRender(object sender, EventArgs e)
    {
        if (DataList_TAXDiscount.Items.Count != 0)
        {
            for (Int32 i = 0; i < DataList_TAXDiscount.Items.Count; i++)
            {
                Label AmountLabel = (Label)DataList_TAXDiscount.Items[i].FindControl("AmountLabel");
                Label Tax_NameLabel = (Label)DataList_TAXDiscount.Items[i].FindControl("Tax_NameLabel");

                if (AmountLabel.Text == "0")
                {
                    AmountLabel.Visible = false;
                    Tax_NameLabel.Visible = false;
                }
                else
                {
                    AmountLabel.Visible = true;
                    Tax_NameLabel.Visible = true;
                }
            }

        }

    }


    protected void DropDownList_Store_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        //setItemCode();
    }

    protected void btnAddExpenses_Click(object sender, EventArgs e)
    {
        pnlPOExpenses.Visible = true;
    }
    protected void btnSaveExpense_Click(object sender, EventArgs e)
    {
        SQL_Expenses.Insert();
        gvExpenseView.DataBind();
        GridView1.DataBind();
        Insert_Amount();
        pnlPOExpenses.Visible = false;
        //Response.Write("expense _D =" + ddlExpense.SelectedValue);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnlPOExpenses.Visible = false;
    }
    protected void txtCurrencyRate_TextChanged(object sender, EventArgs e)
    {
        SDS_Update_Currency.Update();
    }
    protected void btnExcludeCancel_Click(object sender, EventArgs e)
    {
        pnlExpenseExclude.Visible = false;
    }
    protected void lbtnExcludeExpense_Click(object sender, EventArgs e)
    {
        hf_POSub_ID.Value = ((LinkButton)sender).CommandArgument;
        hf_POID_Expense.Value = ((LinkButton)sender).CommandName;
        cblExpenseItem.DataBind();
        pnlExpenseExclude.Visible = true;
    }
    protected void btnExclude_Click(object sender, EventArgs e)
    {
        foreach (ListItem li in cblExpenseItem.Items)
        {
            if (li.Selected == true)
            {
                hf_Expense_Value_ID.Value = li.Value;
                SQL_Item_Expense_Exclude.Insert();
            }
        }
    }
    protected void lbtnNewExpense_Click(object sender, EventArgs e)
    {
        pnlNewExpense.Visible = true;
    }
    protected void btnCancelNewExpense_Click(object sender, EventArgs e)
    {
        pnlNewExpense.Visible = false;
    }
    protected void btnSaveNewExpense_Click(object sender, EventArgs e)
    {
        SQL_AddNewExpense.Insert();
        gv_new_Expanse.DataBind();


    }


    protected void SQL_Item_Expense_Exclude_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void gv_new_Expanse_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Insert_Amount()
    {
        Int32 VMId;



        double TotalAmt = Convert.ToDouble(txtExpenseCost.Text);
        string desc = ddlExpense.SelectedItem.Text + " Expense against P/O " + TextBox_PONo.Text;
        VMId = Convert.ToInt32(VI.insert_Main_Payment("", F_constr, "", DateTime.Now, "Store Purchase", desc, /*ds.Tables[0].Rows[0].ItemArray[1].ToString()*/"0", 0, "0", 0, Convert.ToInt32(Session["Dept_Id"]), Convert.ToInt32(Session["emp_id"]), Convert.ToInt32(Session["emp_id"]), Convert.ToInt32(Session["emp_id"]), 0));
        VI.Insert_payment(VMId.ToString(), 0, "15010001", txtExpenseCost.Text, 1, 1, desc, F_constr, "0", "0", "0", Session["SubDeptId"].ToString(), 0);
        VI.Insert_payment(VMId.ToString(), Convert.ToInt32(DDL_Charge_To.SelectedValue), "32020012", txtExpenseCost.Text, 2, 1, desc, F_constr, "0", "0", "0", Session["SubDeptId"].ToString(), 0);


    }
    protected Int64 GetPartyID(string PO_ID)
    {
        SqlConnection con = new SqlConnection(connection1);
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

    protected string GetHead(string Item_Code, Int32 Dept_ID, Int32 SubDeptId)
    {
        CheckHead(Item_Code, Dept_ID, SubDeptId);
        SqlConnection con = new SqlConnection(connection1);
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

    protected void CheckHead(string Item_Code, Int32 Dept_ID, Int32 SubDeptId)
    {
        SqlConnection con = new SqlConnection(connection1);
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
    protected void BTN_Voucher_Click(object sender, EventArgs e)
    {

        Insert_Amount();
        Response.Write("Insert compleated");
    }


    protected void TextBox_Subject_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        //Response.Redirect("OtherExpenseReport.aspx?PO_ID=" + TextBox_PONo.Text);
    }
    protected void Button_Company_Click(object sender, EventArgs e)
    {

    }



    protected void btm_OCurrency_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count != 0)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>window.open('PurchaseOrderReportInOtherCurrency.aspx?PO_ID=" + HiddenField_PO_ID.Value + "')</script>");
            Type t = GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "PopUp"))
            {
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
            }
        }
    }

    protected void TextBox_Other_Currency_Rate_TextChanged(object sender, EventArgs e)
    {
        TextBox btn = (TextBox)sender;
        try
        {

            GridViewRow row = (GridViewRow)btn.NamingContainer;
            int i = Convert.ToInt32(row.RowIndex);

            HiddenField_changed.Value = "0";
            TextBox TXT_ORate = (TextBox)sender;

            TextBox TXT_rate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");

            double rate = Convert.ToDouble(System.Math.Round(Convert.ToDecimal(Convert.ToDecimal(TXT_ORate.Text) * Convert.ToDecimal(txtCurrencyRate.Text)), 2));
            TXT_rate.Text = Convert.ToString(rate);
        }
        catch (Exception ex)
        {
            btn.Text = "1";
            btn.Focus();
        }
    }


    protected void Button7_Click(object sender, EventArgs e)
    {

    }
    protected void Button_Company_Click1(object sender, EventArgs e)
    {

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
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count, string contextKey)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name Item_Name From Store_Items I left Join Generic_Names G ON I.G_N_Id=G.G_N_Id Where (Item_Name LIKE '%' + @Search + '%' or Item_Code like '%' + @Search +'%') AND (ForStore=@ForStore or @ForStore = 0)";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Parameters.AddWithValue("@ForStore", contextKey);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
    }
    public String getCompanyName(String CompanyId)
    {
        String qry = "Select Party_Name From Parties Where Party_Id=@Party_Id";
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Party_Id", CompanyId);
        SqlDataReader reader = command.ExecuteReader();
        String Company_Name = "";
        if (reader["Party_Name"] != "")
        {
            Company_Name = reader["Party_Name"].ToString();
        }
        con.Close();
        return Company_Name;
    }
    protected void btnItemName_Click(object sender, EventArgs e)
    {
        //Response.Write(ddlPaymentTo.Text + hfPaymentToId.Value);
        if (ddlPaymentTo.Text != "" && hfPaymentToId.Value != "-1")
        {

            try
            {

                HiddenField_PODate.Value = txtPODate.Text.ToString();
                if (!String.IsNullOrEmpty(Request.QueryString["phm"]))
                {
                    SqlDataSource1.InsertParameters["typ"].DefaultValue = "phm";
                }
                else
                {
                    SqlDataSource1.InsertParameters["typ"].DefaultValue = "";
                }
                SqlDataSource1.Insert();
                String temp = hfOrderTo.Value;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            try
            {

                LinkButton btnTemp = (LinkButton)sender;
                TextBox qty, rate;
                HiddenField hfPackQty;
                TextBox pack;
                TextBox Bonus;
                TextBox SaleTax;
                
                GridViewRow gvRow = (GridViewRow)btnTemp.NamingContainer;

                qty = (TextBox)gvRow.FindControl("txtQty");
                rate = (TextBox)gvRow.FindControl("txtRate");
                hfPackQty = (HiddenField)gvRow.FindControl("HfPackQty");
                pack = (TextBox)gvRow.FindControl("txtPackQty");
                Bonus = (TextBox)gvRow.FindControl("txtFOC");
                SaleTax = (TextBox)gvRow.FindControl("txtVat");
                
                


                SqlDataSource2.InsertParameters["Item_Code"].DefaultValue = btnTemp.CommandArgument;
                SqlDataSource2.InsertParameters["PackQty"].DefaultValue = hfPackQty.Value;
                SqlDataSource2.InsertParameters["Qty"].DefaultValue =  qty.Text;
                SqlDataSource2.InsertParameters["Rate"].DefaultValue = rate.Text;
                SqlDataSource2.InsertParameters["OrgRate"].DefaultValue = rate.Text;
                SqlDataSource2.InsertParameters["Pack"].DefaultValue = pack.Text;
                SqlDataSource2.InsertParameters["Bonus"].DefaultValue = Bonus.Text;
                SqlDataSource2.InsertParameters["SaleTax"].DefaultValue = SaleTax.Text;

                SqlDataSource2.Insert();
                HiddenField_PO_ID.Value = TextBox_PONo.Text;
                GridView1.DataBind();

                if (GridView1.Rows.Count > 0)
                {
                    ddlPaymentTo.Enabled = false;

                    addlink.Visible = false;

                }
                else
                {
                    ddlPaymentTo.Enabled = true;
                    addlink.Visible = true;

                }
                GridView1.DataBind();
                Button1.Visible = true;
            }
            catch (Exception ex1)
            {
                Response.Write(ex1.Message);
            }
            Label_Msg.Text = "";


        }
        else
        {
            Label_Msg.Text = "First Select Any Company";
            Label_Msg.Visible = true;
        }

        TextBox_specificItem.Text = "";

        if (txtDemandReqNo.Text == "")
        {
            gvItems.DataSource = null;
            gvItems.DataBind();
        }
    }

    private void AddItems()
    {
        //Response.Write(ddlPaymentTo.Text + hfPaymentToId.Value);
        if (ddlPaymentTo.Text != "" && hfPaymentToId.Value != "-1")
        {

            try
            {

                HiddenField_PODate.Value = txtPODate.Text.ToString();
                if (!String.IsNullOrEmpty(Request.QueryString["phm"]))
                {
                    SqlDataSource1.InsertParameters["typ"].DefaultValue = "phm";
                }
                else
                {
                    SqlDataSource1.InsertParameters["typ"].DefaultValue = "";
                }
                SqlDataSource1.Insert();
                String temp = hfOrderTo.Value;
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            try
            {
                foreach (GridViewRow gvRow in gvItems.Rows)
                {
                    CheckBox CheckSelect = (CheckBox)gvRow.FindControl("chkSelect");
                    if (CheckSelect.Checked == true)
                    {
                        LinkButton btnTemp = (LinkButton)gvRow.FindControl("btnItem");
                        TextBox qty, rate;
                        HiddenField hfPackQty;
                        //GridViewRow gvRow = (GridViewRow)btnTemp.NamingContainer;

                        qty = (TextBox)gvRow.FindControl("txtQty");
                        rate = (TextBox)gvRow.FindControl("txtRate");
                        hfPackQty = (HiddenField)gvRow.FindControl("HfPackQty");

                        SqlDataSource2.InsertParameters["Item_Code"].DefaultValue = btnTemp.CommandArgument;
                        SqlDataSource2.InsertParameters["PackQty"].DefaultValue = hfPackQty.Value;
                        SqlDataSource2.InsertParameters["Qty"].DefaultValue = qty.Text;
                        SqlDataSource2.InsertParameters["Rate"].DefaultValue = rate.Text;
                        SqlDataSource2.InsertParameters["OrgRate"].DefaultValue = rate.Text;
                        SqlDataSource2.Insert();
                        HiddenField_PO_ID.Value = TextBox_PONo.Text.Trim();
                        GridView1.DataBind();
                    }
                }

                if (GridView1.Rows.Count > 0)
                {
                    ddlPaymentTo.Enabled = false;

                    addlink.Visible = false;

                }
                else
                {
                    ddlPaymentTo.Enabled = true;
                    addlink.Visible = true;

                }
                GridView1.DataBind();
                unselectAll();
                Button1.Visible = true;

            }
            catch (Exception ex1)
            {
                Response.Write(ex1.Message);
            }
            Label_Msg.Text = "";
        }
        else
        {
            Label_Msg.Text = "First Select Any Company";
            Label_Msg.Visible = true;
        }

        TextBox_specificItem.Text = "";

        if (txtDemandReqNo.Text == "")
        {
            gvItems.DataSource = null;
            gvItems.DataBind();
        }
    }

    protected void LoadItemGrid(string PRID)
    {
        try
        {


            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand("usp_Items_For_Purchase_Order", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Manufacturer", ddlManufacturer.SelectedValue);
            command.Parameters.AddWithValue("@Item_Name", hfItemName.Value);
            command.Parameters.AddWithValue("@vendorID", hdfItemVendor.Value);

            if (!ddlforstore.SelectedItem.Text.Contains("STORE"))
            {
                command.Parameters.AddWithValue("@ForStore", "0");
            }
            else
            {
                command.Parameters.AddWithValue("@ForStore", ddlforstore.SelectedValue);
            }
            command.Parameters.AddWithValue("@PRID", PRID);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                gvItems.DataSource = dt;
                gvItems.DataBind();
            }

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);

        }
    }

    protected void LoadQuotation()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("select Qutation_Main.Vendor_ID, parties.Party_Name from Qutation_Main join parties on parties.Party_Id = Qutation_Main.Vendor_ID where Qutation_Main.Qutation_Main_ID = @Qid AND Is_Approved=1", con);
        command.CommandType = CommandType.Text;
        command.Parameters.AddWithValue("@Qid", lblQuotationNo.Text);
        SqlDataReader reader = command.ExecuteReader();
        if (reader.HasRows)
        {

            if (reader.Read())
            {
                hfPaymentToId.Value = reader["Vendor_ID"].ToString();
                ddlPaymentTo.Text = reader["Party_Name"].ToString();
                ddlOrderTo.Text = reader["Party_Name"].ToString();
                hfOrderTo.Value = reader["Vendor_ID"].ToString();
                HiddenField_Company_ID.Value = hfPaymentToId.Value;
            }
            Button1.Visible = true;
            insertPOFromQutation();
        }

        con.Close();




    }

    protected void insertPOFromQutation()
    {
        try
        {
            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand("uspInsertPOfromQutationID", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Qutation_Main_ID", lblQuotationNo.Text);
            command.Parameters.AddWithValue("@PO_NO", TextBox_PONo.Text);
            command.Parameters.AddWithValue("@PODate", txtPODate.Text);
            command.Parameters.AddWithValue("@emp_id", Session["emp_id"].ToString());
            command.Parameters.AddWithValue("@SubDeptID", Session["SubDeptID"].ToString());
            command.Parameters.AddWithValue("@DeptID", Session["Dept_ID"].ToString());
            command.Parameters.AddWithValue("@BudgetHead", DropDownList_Budget.SelectedValue);
            command.Parameters.AddWithValue("@PO_Type", DropDownList_potype.SelectedValue);
            command.Parameters.AddWithValue("@Mode_Of_Payment", DropDownList_modeof_payment.SelectedValue);
            command.ExecuteNonQuery();
            con.Close();
            btnRollback.Visible = true;
            GridView1.DataBind();

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    protected void LoadBalance()
    {
        try
        {
            SqlConnection con = new SqlConnection(F_constr);
            string procudure = "budget_head_balance";


            SqlCommand command = new SqlCommand(procudure, con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@E_Code", DropDownList_Budget.SelectedValue);
            command.Parameters.AddWithValue("@Company_Branch_Id", 1);
            command.Parameters.AddWithValue("@c_Date", DateTime.Now);
            command.Parameters.Add("@amount", SqlDbType.Int);
            command.Parameters["@amount"].Direction = ParameterDirection.Output;

            con.Open();
            command.ExecuteNonQuery();
            lblBalance.Text = command.Parameters["@amount"].Value.ToString();
            if (string.IsNullOrEmpty(lblBalance.Text.Trim()))
            {
                lblBalance.Text = "0";

            }
            con.Close();
        }
        catch
        {
            lblBalance.Text = "0";
        }


    }
    protected void DropDownList_Budget_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadBalance();
        if (lblBalance.Text == "0")
        {
            label_Budget.Visible = true;
        }
        else
        {
            label_Budget.Visible = false;
        }

    }
    protected void updatePOMain()
    {
        try
        {
            SqlParameter[] sqlParams = { new SqlParameter("@PO_ID", TextBox_PONo.Text),
                                   new SqlParameter("@PO_Type", DropDownList_potype.SelectedItem.Text),
                                   new SqlParameter("@Mode_Of_Payment",DropDownList_modeof_payment.SelectedItem.Text),
                                   new SqlParameter("@BUDGET_head", DropDownList_Budget.SelectedValue),
                                   new SqlParameter("@Ship_To", TextBox_shipto.Text),
                                   new SqlParameter("@For_Branches", TextBox_branches.Text),
                                   new SqlParameter("@Mode_Of_Delivery", TextBox_modeof_delivery.Text),
                                   new SqlParameter("@Payment_Process", TextBox_payment_Process.Text),
                                    new SqlParameter("@Receiving_Dept", ddlforstore.SelectedValue),
                                     new SqlParameter("@Deliverydays", TextBox_DeliveryDays.Text),
                                     new SqlParameter("@DDate", txtDDate.Text),
                                     new SqlParameter("@PaymentTerms", ddlPayTerms.SelectedValue)
                                   };
            dbMgr.ExecuteNonQuery("usp_Update_PO_Main", "STOREConnectionString", sqlParams);
        }
        catch (Exception ex)
        {
        }
    }
    protected void txtPack_TextChanged(object sender, EventArgs e)
    {
        //foreach (GridViewRow gvRow in GridView1.Rows)
        //{
        //    TextBox pack = (TextBox)gvRow.FindControl("txtPack");
        //    TextBox unitPack = (TextBox)gvRow.FindControl("txtUnitsPack");
        //    TextBox qty = (TextBox)gvRow.FindControl("TextBox_Qty");
        //    qty.Text = (Convert.ToInt32(pack.Text) * Convert.ToInt32(unitPack.Text)).ToString();

        //}
    }
    protected void txtUnitPack_TextChanged(object sender, EventArgs e)
    {
        //TextBox txt = (TextBox)sender;
        //GridViewRow gvRow = txt.NamingContainer as GridViewRow;
        //TextBox qty = (TextBox)gvRow.FindControl("TextBox_Qty");
        //if (Convert.ToDouble(txt.Text.Trim()) > Convert.ToDouble(qty.Text.Trim()))
        //{
        //    qty.Text = txt.Text.Trim();
        //}
        //foreach (GridViewRow gvRow in GridView1.Rows)
        //{
        //    TextBox pack = (TextBox)gvRow.FindControl("txtPack");
        //    TextBox unitPack = (TextBox)gvRow.FindControl("txtUnitsPack");
        //    TextBox qty = (TextBox)gvRow.FindControl("TextBox_Qty");
        //    qty.Text = (Convert.ToInt32(pack.Text) * Convert.ToInt32(unitPack.Text)).ToString();

        //}
    }
    protected void btnAddDemandItems_Click(object sender, EventArgs e)
    {
        if (ddlPaymentTo.Text != "" && hfPaymentToId.Value != "-1"
            //&& txtDemandReqNo.Text.Length == 16
            )
        {

            try
            {

                HiddenField_PODate.Value = txtPODate.Text.ToString();
                SqlDataSource1.Insert();
                String temp = hfOrderTo.Value;

            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            try
            {
                //HiddenField_Rate.Value = getrate(TreeView1.SelectedValue);
                if (GridView1.Rows.Count > 0)
                {
                    for (int i = 0; i < GridView1.Rows.Count; i++)
                    {
                        TextBox packRate = (TextBox)GridView1.Rows[i].FindControl("txtPackRate");
                        TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");
                        TextBox pack = (TextBox)GridView1.Rows[i].FindControl("txtPack");
                        TextBox unitPack = (TextBox)GridView1.Rows[i].FindControl("txtUnitsPack");
                        TextBox TextBox_Qty = (TextBox)GridView1.Rows[i].FindControl("TextBox_Qty");
                        Label Label_Amount = (Label)GridView1.Rows[i].FindControl("Label_Amount");
                        HiddenField HiddenField1 = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
                        TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");
                        TextBox TextBox_For_Cus = (TextBox)GridView1.Rows[i].FindControl("Txt_For_Customer");
                        TextBox TextBox_QO_No = (TextBox)GridView1.Rows[i].FindControl("Txt_QO_No");
                        TextBox TextBox_OR_No = (TextBox)GridView1.Rows[i].FindControl("Txt_Order_No");
                        HiddenField_Specification.Value = TextBox_Specification.Text;
                        HiddenField_Item_Code.Value = HiddenField1.Value;
                        HiddenField_Item_Qty.Value = TextBox_Qty.Text;
                        if (TextBox_Rate.Text == "")
                        {
                            TextBox_Rate.Text = "0";
                        }
                        Hf_OR_No.Value = TextBox_OR_No.Text;
                        Hf_QO_No.Value = TextBox_QO_No.Text;
                        Hf_For_Customer.Value = TextBox_For_Cus.Text;
                        HiddenField_ItemRate.Value = TextBox_Rate.Text;
                        HiddenField_TotalAmt.Value = Label_Amount.Text;
                        SqlDataSource_UpdateSub.UpdateParameters["Pack"].DefaultValue = pack.Text;
                        SqlDataSource_UpdateSub.UpdateParameters["Unit_Pack"].DefaultValue = unitPack.Text;
                        SqlDataSource_UpdateSub.UpdateParameters["PackRate"].DefaultValue = packRate.Text;
                        SqlDataSource_UpdateSub.Update();

                    }

                }


                //ADD Demand Items

                addDemandItems();

                HiddenField_PO_ID.Value = TextBox_PONo.Text;
                GridView1.DataBind();

                if (GridView1.Rows.Count > 0)
                {
                    ddlPaymentTo.Enabled = false;

                    addlink.Visible = false;

                }
                else
                {
                    ddlPaymentTo.Enabled = true;
                    addlink.Visible = true;

                }
                GridView1.DataBind();
                Button1.Visible = true;
            }
            catch (Exception ex1)
            {
                Response.Write(ex1.Message);
            }
            Label_Msg.Text = "";


        }
        else
        {
            Label_Msg.Text = "First Select Any Company or Demand # is incorrect";
            Label_Msg.Visible = true;
        }
    }
    protected void addDemandItems()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParams = { new SqlParameter("@Demand_RQ_ID", txtDemandReqNo.Text.Trim()),
                                     new SqlParameter("@PO_ID",TextBox_PONo.Text)};
            dbMgr.ExecuteNonQuery("uspAddDemandItemsInPO", "STOREConnectionString", sqlParams);
        }
        catch (Exception ex)
        {
        }

    }


    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        
        GridViewRow gvRow = txt.NamingContainer as GridViewRow;
        Label lblAmount = (Label)gvRow.FindControl("Label_Amount");
        TextBox txtOrgRate = (TextBox)gvRow.FindControl("TextBox_Rate");
        Label lblDisAmount = (Label)gvRow.FindControl("lblTotalDisAmount");
        TextBox lblDisRate = (TextBox)gvRow.FindControl("lblDiscountRate");
        Label lblActualAmount = (Label)gvRow.FindControl("Label_Amount");
        TextBox txtSaletax = (TextBox)gvRow.FindControl("txtVat");
        Double salestax = Convert.ToDouble(txtSaletax.Text);
        if (txt.Text.Trim() == "")
        {
            txt.Text = "0";
            
        }
         
        Double total = Math.Round(((Convert.ToDouble(lblActualAmount.Text)) - ((Convert.ToDouble(txt.Text)   * Convert.ToDouble(lblActualAmount.Text)) / 100)), 2);
        lblDisAmount.Text = (total + salestax).ToString();
        lblDisRate.Text = Math.Round(((Convert.ToDouble(txtOrgRate.Text)) - ((Convert.ToDouble(txt.Text)* Convert.ToDouble(txtOrgRate.Text)) / 100)),2).ToString();
    }

    protected void DropDownList_modeof_payment_SelectedIndexChanged(object sender, EventArgs e)
    {
        //TextBox_specificItem.Text="";
    }

    protected void Button_Close_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
    }

    protected void lnkDetail_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lb.NamingContainer;
        if (row != null)
        {
            //int index = row.RowIndex; //gets the row index selected
            LinkButton lbl = (LinkButton)row.FindControl("btnItem");


            SqlCommand cmd;
            SqlConnection con1 = new SqlConnection(connection1);
            SqlConnection con2 = new SqlConnection(connection1);
            try
            {


                cmd = new SqlCommand("uspGetDeptStockSingle", con1);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@itemCode", lbl.CommandArgument);
                con1.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                Gridview2.DataSource = dt;
                Gridview2.DataBind();
                panel.Visible = true;
            }
            catch (Exception ex)
            {
                con1.Close();


            }

        }
    }

    protected void ibDelete_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("UpdatePurchaseOrder.aspx");
    }

    protected void lblQuotationNo_TextChanged(object sender, EventArgs e)
    {
        LoadQuotation();
    }

    protected void btnRollback_Click(object sender, EventArgs e)
    {
        try
        {
            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand("Remove_Purchase_Order", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@PO_ID", TextBox_PONo.Text);
            command.ExecuteNonQuery();
            lblQuotationNo.Text = string.Empty;

            GridView1.DataBind();
            btnRollback.Visible = false;
            con.Close();

        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }


    }
    protected void ddlPaymentTo_TextChanged(object sender, EventArgs e)
    {

        try
        {
            ddlOrderTo.Text = ddlPaymentTo.Text;
            hfOrderTo.Value = hfPaymentToId.Value;
            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand("Select ISNULL(Delivery_Days,'0') AS Delivery_Days from Finance.dbo.parties where Party_Id=@Party_Id", con);
            command.Parameters.AddWithValue("@Party_Id", hfPaymentToId.Value.ToString());
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                TextBox_DeliveryDays.Text = dt.Rows[0]["Delivery_Days"].ToString();
            }

        }
        catch (Exception ex)
        {


        }
    }

    protected void lblDiscountRate_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow gvRow = txt.NamingContainer as GridViewRow;
        TextBox txtOrgRate = (TextBox)gvRow.FindControl("TextBox_Rate");
        Label lblActualAmount = (Label)gvRow.FindControl("Label_Amount");
        TextBox txtSaletax = (TextBox)gvRow.FindControl("txtVat");
        
        if (txt.Text.Trim() == "")
        {
            txt.Text = txtOrgRate.Text.Trim();
        }

        Label lblAmount = (Label)gvRow.FindControl("Label_Amount");
        TextBox txtDiscount = (TextBox)gvRow.FindControl("txtDiscount");
        Label lblDisAmount = (Label)gvRow.FindControl("lblTotalDisAmount");
        Double salestax = (Convert.ToDouble(txtSaletax.Text) * Convert.ToDouble(lblActualAmount.Text))/100;

        double Total = Math.Round((100 - ((Convert.ToDouble(txt.Text.Trim()) / Convert.ToDouble(txtOrgRate.Text.Trim())) * 100)), 2);
        txtDiscount.Text = (Total + salestax).ToString();
        lblDisAmount.Text = Math.Round(((Convert.ToDouble(lblActualAmount.Text))  - ((Convert.ToDouble(txtDiscount.Text.Trim()) * Convert.ToDouble(lblActualAmount.Text)) / 100)), 2).ToString();
  
        //txtDiscount.Text = ((Convert.ToDouble(txtOrgRate.Text)) - ((Convert.ToDouble(txt.Text) * Convert.ToDouble(txtOrgRate.Text)) / 100)).ToString();
    }


    //protected void TextBox_Qty_TextChanged(object sender, EventArgs e)
    //{
    //    //TextBox txt = (TextBox)sender;
    //    //GridViewRow gvRow = txt.NamingContainer as GridViewRow;
    //    //TextBox txtOrgRate = (TextBox)gvRow.FindControl("TextBox_Rate");
    //    //TextBox txtUnitsPack = (TextBox)gvRow.FindControl("txtUnitsPack");
    //    //if (txt.Text.Trim() == "")
    //    //{
    //    //    txt.Text = txtUnitsPack.Text.Trim();

    //    //}

    //    //Label lblAmount = (Label)gvRow.FindControl("Label_Amount");
    //    //TextBox txtDiscount = (TextBox)gvRow.FindControl("txtDiscount");
    //    //Label lblDisAmount = (Label)gvRow.FindControl("lblTotalDisAmount");

    //    //lblAmount.Text = Math.Round(Convert.ToDouble(txt.Text.Trim()) * Convert.ToDouble(txtOrgRate.Text.Trim()),4).ToString();

    //    ////txtDiscount.Text = Math.Round((100 - ((Convert.ToDouble(txt.Text.Trim()) / Convert.ToDouble(txtOrgRate.Text.Trim())) * 100)), 4).ToString();

    //    //lblDisAmount.Text = ((Convert.ToDouble(lblAmount.Text)) - ((Convert.ToDouble(txtDiscount.Text.Trim()) * Convert.ToDouble(lblAmount.Text)) / 100)).ToString();
    //}

    protected void TextBox_Rate_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        if (txt.Text.Trim() == "")
        {
            txt.Text = "1";

        }
        GridViewRow gvRow = txt.NamingContainer as GridViewRow;
        TextBox txtOrgRate = (TextBox)gvRow.FindControl("TextBox_Rate");
        TextBox txtUnitsPack = (TextBox)gvRow.FindControl("txtUnitsPack");
        TextBox txtDiscountRate = (TextBox)gvRow.FindControl("lblDiscountRate");
        TextBox txtDiscount = (TextBox)gvRow.FindControl("txtDiscount");

        txtDiscountRate.Text = txt.Text.Trim();
        txtDiscount.Text = "0";
    }
    protected void btnForward_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@PO_ID", TextBox_PONo.Text) };
            dbm.ExecuteNonQuery("uspInsertPOApprovalRequest", "STOREConnectionString", sp);
            //lblMsg.Visible = true;
            //lblMsg.Text = "Purchase Order is forward for approval";
            checkIsForwarded();
        }
        catch (Exception ex)
        {
            throw;
        }
    }
    protected void checkIsForwarded()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@PO_ID", TextBox_PONo.Text) };
            DataTable dt = dbm.ExecuteDataTable("uspCheckPOforwarded", "STOREConnectionString", sp);
            if (dt.Rows.Count > 0)
            {
                if (Convert.ToBoolean(dt.Rows[0][0].ToString()) == true || dt.Rows[0][0].ToString() == "1")
                {
                    btnForward.Visible = false;
                    Button1.Visible = false;
                    Button2.Visible = false;
                    lblMsg.Visible = true;
                    lblMsg.Text = "Purchase Order is forward for approval";
                }
                else
                {
                    btnForward.Visible = true;
                    Button1.Visible = true;
                    Button2.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    protected void ddlforstore_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (!ddlforstore.SelectedItem.Text.Contains("STORE"))
        {
            aceItems.ContextKey = "0";
        }
        else
        {
            aceItems.ContextKey = ddlforstore.SelectedValue;
        }

    }


    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox CheckSelectAll = (CheckBox)sender;
        foreach (GridViewRow row in gvItems.Rows)
        {
            CheckBox CheckSelect = (CheckBox)row.FindControl("chkSelect");
            CheckSelect.Checked = CheckSelectAll.Checked;

        }
    }

    protected void btnAddAllItems_Click(object sender, EventArgs e)
    {
        AddItems();
    }

    private void unselectAll()
    {
        foreach (GridViewRow row in gvItems.Rows)
        {
            CheckBox CheckSelect = (CheckBox)row.FindControl("chkSelect");
            CheckSelect.Checked = false;

        }
    }
    protected void txtPackQty_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow row = (GridViewRow)txt.NamingContainer;
        TextBox Qty = (TextBox)row.FindControl("txtQty");
        Label lblPackQty = (Label)row.FindControl("lblPackSize");
        
        TextBox txtPackRate = (TextBox)row.FindControl("txtRate");
        TextBox txtUnitRate = (TextBox)row.FindControl("txtUnitRate");
        
        if (txt.Text != null) 
        {
            Qty.Text = (Convert.ToInt32(txt.Text) * Convert.ToInt32(lblPackQty.Text)).ToString();
            
            
        }
        
       
        
    }
    protected void txtRate_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow row = (GridViewRow)txt.NamingContainer;
        TextBox txtRate = (TextBox)row.FindControl("txtRate");
        Label lblPackSize = (Label)row.FindControl("lblPackSize");
        TextBox txtUnitRate = (TextBox)row.FindControl("txtUnitRate");
        if (txt.Text != null & txtRate.Text != null)
        {
            if (lblPackSize.Text == "0")
            {
                txtUnitRate.Text = "0";

            }
            else
            {
                Decimal total = Convert.ToDecimal(txtRate.Text) / Convert.ToDecimal(lblPackSize.Text);
                //Response.Write(total);
                total = Math.Round(total, 2);
                txtUnitRate.Text = (total).ToString();
            }
        }
    }
    protected void txtFOC_TextChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView1.Rows)
        {
            TextBox txtQty = (TextBox)row.FindControl("TextBox_Qty");
            TextBox txtFoc = (TextBox)row.FindControl("txtFOC");


            txtQty.Text = (Convert.ToInt32(txtQty.Text) + Convert.ToInt32(txtFoc.Text)).ToString();

        }
    }
    
    protected void txtVat_TextChanged1(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;

        GridViewRow gvRow = txt.NamingContainer as GridViewRow;

        Label lblActualAmount = (Label)gvRow.FindControl("Label_Amount");
        Label lblTotalAmount = (Label)gvRow.FindControl("lblTotalDisAmount");
        Response.Write(lblActualAmount.Text );
        TextBox txtSaletax = (TextBox)gvRow.FindControl("txtVat");
        Double salestax = Convert.ToDouble(txtSaletax.Text);
        if (txt.Text.Trim() == "")
        {
            txt.Text = "0";

        }

        Double total = Math.Round(((Convert.ToDouble(lblActualAmount.Text)) + (Convert.ToDouble(txt.Text) )), 2);
        lblTotalAmount.Text = total.ToString();
       
    }
    protected void txtFOC_TextChanged1(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow row = (GridViewRow)txt.NamingContainer;
        TextBox txtRate = (TextBox)row.FindControl("txtRate");
        Label lblPackQty = (Label)row.FindControl("lblPackSize");
        TextBox txtPackQty = (TextBox)row.FindControl("txtPackQty");
        
        TextBox txtUnitRate = (TextBox)row.FindControl("txtUnitRate");
        if (txt.Text != null & txtRate.Text != null)
        {
            if (lblPackQty.Text == "0")
            {
                txtUnitRate.Text = "0";

            }
            else
            {
                Decimal total = Convert.ToDecimal(txtRate.Text) / (Convert.ToDecimal(lblPackQty.Text) + ( Convert.ToDecimal(txt.Text) / Convert.ToDecimal(txtPackQty.Text)));
                //Response.Write(total);
                total = Math.Round(total, 2);
                txtUnitRate.Text = (total).ToString();
            }
        }
    }
}


