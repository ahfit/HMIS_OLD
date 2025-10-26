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

public partial class Store_Purchase_Order_Edit : System.Web.UI.Page
{
    voucher_insertion VI = new voucher_insertion();

    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    string F_constr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;

    public string getconter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT isnull(Max(Count),0) FROM Purchase_Order_Main", con);
        // WHERE (PO_ID LIKE 'P-" + HiddenField_Dept_ID.Value + "%')
        Int32 C;
        string rate;

        try
        {
            C = (int)command.ExecuteScalar();
            if (C == 0)
            {
                rate = Convert.ToString(1100 + 1);
            }
            else
            {
                rate = Convert.ToString(C + 1);
            }
        }
        catch (Exception ex)
        {
            rate = "1";
        }
        con.Close();
        return rate;
    }

    //public string getrate(string item)
    //{
    //    SqlConnection con = new SqlConnection(connection1);
    //    con.Open();
    //    SqlCommand command = new SqlCommand("SELECT  Rate, Med_Code FROM Store_Tender_Sub WHERE (SR_NO =" + item + ")", con);
    //    SqlDataReader reader = command.ExecuteReader();
    //    reader.Read();
    //    string rate = reader[0].ToString();
    //    HiddenField_Item_Code.Value = reader[1].ToString();
    //    con.Close();
    //    return rate;
    //}

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


    public void Fill_ItemList(string item)
    {
        //TreeView1.Nodes.Clear();
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("Medicine_Purchase_New", con);
        command.CommandType = CommandType.StoredProcedure;

        command.Parameters.AddWithValue("@Dept_ID", HiddenField_Dept_ID.Value);
        command.Parameters.AddWithValue("@Category", DropDownList_Store_Category.SelectedValue);
        command.Parameters.AddWithValue("@Item_Name", item);
        //command.Parameters.AddWithValue("@Company_ID", DropDownList1.SelectedValue);

        //SqlDataReader reader = command.ExecuteReader();
        //while (reader.Read())
        //{
        //    TreeNode obj = new TreeNode(reader[1].ToString(), reader[0].ToString());
        //    //HiddenFieldTender_ID.Value = reader[2].ToString();
        //    TreeView1.Nodes.Add(obj);
        //}
        //reader.Close();
        DataTable dt = new DataTable();
        SqlDataAdapter da = new SqlDataAdapter();
        da.SelectCommand = command;
        da.Fill(dt);

        DataList_Items.DataSource = dt;
        DataList_Items.DataBind();
        con.Close();
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
        DropDownList1.DataBind();
        DropDownList1.SelectedValue = Company_ID;
        HiddenField_Company_ID.Value = DropDownList1.SelectedValue.ToString();
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

            HiddenField_PODate.Value = WebDateChooser_PODate.Value.ToString();
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
                DropDownList1.Enabled = false;

                addlink.Visible = false;

            }
            else
            {
                DropDownList1.Enabled = true;
                addlink.Visible = true;

            }
            GridView1.DataBind();
            //Button1.Visible = true;
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
            //validate("", "");
            HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
            HiddenField_Emp_ID.Value = Session["emp_id"].ToString();
            if (!(IsPostBack))
            {

                DropDownList1.DataBind();
                DropDownList1.Items.Insert(0, "");
                DropDownList1.Items[0].Value = "0";
                //DropDownList_SelectTaxDiscount.DataBind();
            }


            HiddenField_Company_ID.Value = DropDownList1.SelectedValue;//Request.QueryString["Company_ID"].ToString();
            if (!IsPostBack)
            {
                Label1.Text = getconter();
                //"P-" + HiddenField_Dept_ID.Value + "-" +
                /*============================================= Comment By Imran =============================
                //HiddenField_PO_ID.Value = getconter();
                //TextBox_PONo.Text = getconter();
                //SqlDataSource1.Delete();
                 * * =========================================================================================*/
                WebDateChooser_PODate.Value = DateTime.Now;
                 

            }
            //if (GridView1.Rows.Count <= 0)
            //{
            //    Button1.Visible = false;
            //}
            //else
            //{
            //    Button1.Visible = true;
            //}

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
                    DDL_PO_NO.SelectedValue = Request.QueryString["PO_ID"].ToString();
                    HiddenField_PO_ID.Value = DDL_PO_NO.SelectedValue.ToString();
                    GetSetPONo();
                }
            }

        }
        catch (Exception ex) { }


    }

    protected void GetSetPONo()
    {
        IsExist(DDL_PO_NO.SelectedValue.ToString());

        Load_PO(DDL_PO_NO.SelectedValue.ToString());
        Button4.Visible = true;


    }
    public void Load_Tax()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT Amount FROM PO_Tax_Discount WHERE (PO_ID = @PO_ID) AND (Tax_ID = @Tax_ID)", con);
        command.Parameters.AddWithValue("@PO_ID", DDL_PO_NO.SelectedValue.ToString());
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
        Fill_ItemList(TextBox_specificItem.Text);
        //TextBox_specificItem.Text = "";
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        //Response.Write(TextBox_specificItem.Text);
        Fill_ItemList(TextBox_specificItem.Text);

    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        Fill_ItemList("%");
    }


    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        
        if (GridView1.Rows.Count > 0)
        {
            DropDownList1.Enabled = false;
            addlink.Visible = false;
        }
        else
        {
            addlink.Visible = true;
            DropDownList1.Enabled = true;
        }

        if (GridView1.Rows.Count != 0)
        {
            double G_Total = 0;
            double Other_Curr_Cost = 0;
            double ItemWiseExpense = 0;
            double CostWiseExpense = 0;
            for (int i = 0; i < GridView1.Rows.Count; i++)
           {
                
                Label Label_Amount = (Label)GridView1.Rows[i].FindControl("Label_Amount");
                if (String.IsNullOrEmpty(Label_Amount.Text))
                {
                    Label_Amount.Text = "0";
                }
                G_Total += double.Parse(Label_Amount.Text);

               Label Label_Other_Cost = (Label)GridView1.Rows[i].FindControl("Label_Other_Cost");
               if (String.IsNullOrEmpty(Label_Other_Cost.Text))
                {
                    Label_Other_Cost.Text = "0";
                }
               Other_Curr_Cost += double.Parse(Label_Other_Cost.Text);

               TextBox Label_Item_Wise_Expense = (TextBox)GridView1.Rows[i].FindControl("Label_Item_Wise_Expense");
               if (String.IsNullOrEmpty(Label_Item_Wise_Expense.Text))
               {
                   Label_Item_Wise_Expense.Text = "0";
               }
               ItemWiseExpense += double.Parse(Label_Item_Wise_Expense.Text);

               Label Label_Cost_Wise_Expense = (Label)GridView1.Rows[i].FindControl("Label_Cost_Wise_Expense");
               if (String.IsNullOrEmpty(Label_Cost_Wise_Expense.Text))
               {
                   Label_Cost_Wise_Expense.Text = "0";
               }
                CostWiseExpense += double.Parse(Label_Cost_Wise_Expense.Text);
            }
            
            Label Label_GTotalAmount = (Label)GridView1.FooterRow.FindControl("Label_GTotalAmount");
            Label_GTotalAmount.Text = G_Total.ToString("#,##.00");

            Label Label_lblCurrencyRateFooter = (Label)GridView1.FooterRow.FindControl("Label_GTotal_Other_Cost");
            Label_lblCurrencyRateFooter.Text = Other_Curr_Cost.ToString("#,##0.00");

            Label Label_TotalItem_Wise_Expense = (Label)GridView1.FooterRow.FindControl("Label_TotalItem_Wise_Expense");
            Label_TotalItem_Wise_Expense.Text = ItemWiseExpense.ToString("#,##0.00");

            Label Label_TotalCost_Wise_Expense = (Label)GridView1.FooterRow.FindControl("Label_TotalCost_Wise_Expense");
            Label_TotalCost_Wise_Expense.Text = CostWiseExpense.ToString("#,##0.00");
        }
        else
        {
            Panel_TaxDiscount.Visible = false;
        }
        if (GridView1.Rows.Count > 0)
        {
            btnAddExpenses.Visible = true;
            Updatebtn.Visible = true;
        }
        else
        {
            btnAddExpenses.Visible = false;
            Updatebtn.Visible = false;
        }
    }

    public void setItemCode()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT Cat_Abbr FROM Store_Item_Category where (Item_Category_ID = @Item_Category_ID)", con);
        command.Parameters.AddWithValue("@Item_Category_ID", DropDownList_Store_Category.SelectedValue);
        try
        {
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                TextBox_ItemCode.Text = reader["Cat_Abbr"].ToString() + "-";

            }

        }
        catch (Exception ex)
        {

        }
        con.Close();

    }

    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            HiddenField ten_Id = (HiddenField)DataList1.Items[DataList1.SelectedIndex].FindControl("HiddenFieldTen_ID");
            HiddenFieldTender_ID.Value = ten_Id.Value;
            SqlDataSource1.Insert();
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);    
        }
        try
        {
            HiddenField_Rate.Value = getrate(Convert.ToString(DataList1.SelectedValue));
            SqlDataSource2.Insert();
            GridView1.DataBind();
            //Button1.Visible = true;
        }
        catch (Exception ex1)
        {
            //Response.Write(ex1.Message);
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
            DropDownList1.SelectedValue = company_id.ToString();
            DropDownList1.DataBind();
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
            HiddenField_PODate.Value = WebDateChooser_PODate.Value.ToString();
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
                DropDownList1.Enabled = false;

                addlink.Visible = false;

            }
            else
            {
                DropDownList1.Enabled = true;
                addlink.Visible = true;

            }
            GridView1.DataBind();
            //Button1.Visible = true;
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
        SqlCommand command = new SqlCommand("SELECT Company_ID, Date_Time, isnull(Term_and_Conditions,'') as Term_and_Conditions, isnull(Payment_Process,'') as Payment_Process FROM Purchase_Order_Main where (PO_ID = @PO_ID)", con);
        command.Parameters.AddWithValue("@PO_ID", PO_ID);

        try
        {
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                flag = true;
                HiddenField_CompanyID.Value = reader["Company_ID"].ToString();
                WebDateChooser_PODate.Value = reader["date_time"];
                WebDateChooser_PODate.Enabled = false;
                //WebHtmlEditor_TermsAndCondition.Text = reader["Term_and_Conditions"].ToString();
                TextBox_payment_Process.Text = reader["Payment_Process"].ToString();
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
                WebDateChooser_PODate.Value = reader["Date_Time"];
                WebDateChooser_PODate.Enabled = false;


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
        DropDownList1.SelectedValue = HiddenField_CompanyID.Value;
        DropDownList1.Enabled = false;
        GridView1.DataBind();
       // Button1.Visible = true;

    }

    protected void TextBox_PONo_TextChanged(object sender, EventArgs e)
    {
        

    }

    protected void Button_SaveTaxDis_Click(object sender, EventArgs e)
    {
        if (TextBox_TaxDiscountAmount.Text == "")
        {
            TextBox_TaxDiscountAmount.Text = "0";
        }

        SqlDataSource_TAX_Discount_Insert.Insert();

        DataList_TAXDiscount.DataBind();
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
        Fill_ItemList(TextBox_specificItem.Text);
        setItemCode();
    }
    protected void DataList_Items_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList1.SelectedValue != "0")
        {
            try
            {

                HiddenField_PODate.Value = WebDateChooser_PODate.Value.ToString();
                SqlDataSource1.Insert();



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
                        TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("TextBox_Rate");
                        TextBox TextBox_Qty = (TextBox)GridView1.Rows[i].FindControl("TextBox_Qty");
                        Label Label_Amount = (Label)GridView1.Rows[i].FindControl("Label_Amount");
                        HiddenField HiddenField1 = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
                        TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");
                        HiddenField_Specification.Value = TextBox_Specification.Text;
                        HiddenField_Item_Code.Value = HiddenField1.Value;
                        HiddenField_Item_Qty.Value = TextBox_Qty.Text;
                        HiddenField_ItemRate.Value = TextBox_Rate.Text;
                        HiddenField_TotalAmt.Value = Label_Amount.Text;
                        SqlDataSource_UpdateSub.Update();

                    }

                }

                HiddenField_Item_Code.Value = DataList_Items.SelectedValue.ToString();
                SqlDataSource2.Insert();

                if (GridView1.Rows.Count > 0)
                {
                    DropDownList1.Enabled = false;

                    addlink.Visible = false;

                }
                else
                {
                    DropDownList1.Enabled = true;
                    addlink.Visible = true;

                }
                GridView1.DataBind();
                //Button1.Visible = true;
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

    }

    protected void btnAddExpenses_Click(object sender, EventArgs e)
    {
        txtExpenseCost.Text = string.Empty;
        txtbox_CurrencyRate.Text = string.Empty;
        TextBox_Description.Text = string.Empty;
        hfditemcode.Value="";
        gvBankAmount.DataBind();
        pnlPOExpenses.Visible = true;
        pnlNewExpense.Visible = false;
    }
    protected void btnSaveExpense_Click(object sender, EventArgs e)
    {
        if(hfditemcode.Value == "" || hfditemcode.Value == null)
        {


            Label lblTotalAmount = (Label)GridView1.FooterRow.FindControl("Label_GTotalAmount");
            if (rblAmountType.SelectedValue == "Percentage")
            {
                SQL_Expenses.InsertParameters["Expense_Cost"].DefaultValue = (Convert.ToDouble(lblTotalAmount.Text) * Convert.ToDouble(txtExpenseCost.Text) / 100).ToString();
                SQL_Expenses.InsertParameters["Percentage"].DefaultValue = txtExpenseCost.Text;
            }
            else
            {
                SQL_Expenses.InsertParameters["Expense_Cost"].DefaultValue = txtExpenseCost.Text;
                SQL_Expenses.InsertParameters["Percentage"].DefaultValue = ((Convert.ToDouble(txtExpenseCost.Text) / Convert.ToDouble(lblTotalAmount.Text)) * 100).ToString();
            }

        }
        else
        {
            if (rblAmountType.SelectedValue == "Percentage")
            {
                SQL_Expenses.InsertParameters["Expense_Cost"].DefaultValue = (Convert.ToDouble(hfdamount.Value) * Convert.ToDouble(txtExpenseCost.Text) / 100).ToString();
                SQL_Expenses.InsertParameters["Percentage"].DefaultValue = txtExpenseCost.Text;
            }
            else
            {
                SQL_Expenses.InsertParameters["Expense_Cost"].DefaultValue = txtExpenseCost.Text;
                SQL_Expenses.InsertParameters["Percentage"].DefaultValue = ((Convert.ToDouble(txtExpenseCost.Text) / Convert.ToDouble(hfdamount.Value)) * 100).ToString();
            } 
        }
     //  HiddenField   HiddenField1=(HiddenField)GridView1.FindControl("HiddenField1");
      // hfditemcode.Value = HiddenField1.Value;
        try
        {
            SQL_Expenses.Insert();
            lbl_Message.Text = "Save Successfully";
        }
        catch (Exception ex)
        {
            lbl_Message.Text = "Not Saved";
        }
        
        gvExpenseView.DataBind();
        GridView1.DataBind();
       
        //++++++++++++++++++++++++ Voucher Insertion +++++++++++++++++++++++
        //Insert_Amount();
        //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        pnlPOExpenses.Visible = false;
        //Response.Write("expense _D =" + ddlExpense.SelectedValue);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnlPOExpenses.Visible = false;
        ResetPNLExpanse();

    }
    protected void txtCurrencyRate_TextChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
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
       //pnlNewExpense.Visible = false; 
       // pnlPOExpenses.Visible = false;
       //pnlExpenseExclude.Visible = false;
        Response.Redirect("AddExpense.aspx?PO_ID=" + HiddenField_PO_ID.Value);
    }
    protected void btnCancelNewExpense_Click(object sender, EventArgs e)
    {
        //Response.Redirect("~/AddExpense.aspx");
        pnlNewExpense.Visible = false;
        //pnlPOExpenses.Visible = true;
    }
    protected void btnSaveNewExpense_Click(object sender, EventArgs e)
    {
                if(CheckBox1.Checked)
        
           { 
                HF_Charge_To_Purchases.Value = "True";
           }
            else
           {
                HF_Charge_To_Purchases.Value = "false";

            }
       


        SQL_AddNewExpense.Insert();
        gv_new_Expanse.DataBind();


    }
    protected void Insert_Amount()
    {
        Int32 VMId;
        


          double TotalAmt = Convert.ToDouble(txtExpenseCost.Text);
          string desc = ddlExpense.SelectedItem.Text + "  against Purchases  P/O " + DDL_PO_NO.SelectedValue.ToString();
        VMId = Convert.ToInt32(VI.insert_Main_Payment("", F_constr, "", DateTime.Now, " Purchases Cost", desc, /*ds.Tables[0].Rows[0].ItemArray[1].ToString()*/"0", 0, "0", 0, Convert.ToInt32(Session["Dept_Id"]), Convert.ToInt32(Session["emp_id"]), Convert.ToInt32(Session["emp_id"]), Convert.ToInt32(Session["emp_id"]), 0));
        VI.Insert_payment(VMId.ToString(), 0, "33101", txtExpenseCost.Text, 1, 1, desc, F_constr, "0", "0", "0", Session["SubDeptId"].ToString(), 0);
        VI.Insert_payment(VMId.ToString(), Convert.ToInt32(DDL_Charge_To.SelectedValue), "22101", txtExpenseCost.Text, 2, 1, desc, F_constr, "0", "0", "0", Session["SubDeptId"].ToString(), 0);
              

       
    }

    protected Int64 GetPartyID(string PO_ID)
    {
        SqlConnection con = new SqlConnection(connection1);
        string qry = "SELECT Company_ID,Other_Currency_Rate FROM Purchase_Order_Main where(PO_ID = @PO_ID)";
        Int64 CId = 0;
        SqlCommand command = new SqlCommand(qry, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@PO_ID", PO_ID);
        

        con.Open();
        SqlDataReader reader = command.ExecuteReader();
        while (reader.Read())
        {
            CId = Convert.ToInt64(reader[0].ToString());
            txtCurrencyRate.Text = Convert.ToString(reader[1]);
            txtCurrencyRateNew.Text = Convert.ToString(reader[1]);
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
    protected void WebHtmlEditor_TermsAndCondition_ToolbarClick(object sender, Infragistics.WebUI.WebHtmlEditor.ToolbarEventArgs e)
    {

    }

    protected void DDL_PO_NO_SelectedIndexChanged(object sender, EventArgs e)
    {
        //HiddenField_PO_ID.Value = TextBox_PONo.Text;
        TextBox_TaxDiscountAmount.Text = "";
        if (IsApproved(DDL_PO_NO.SelectedValue.ToString()))
        {
            Label_Msg.Text = "Already Existed and Approved";
            Label_Msg.Visible = true;
            Load_PO(DDL_PO_NO.SelectedValue.ToString());
            Button4.Visible = true;
            GetPartyID(DDL_PO_NO.SelectedValue);
            ////////////WebHtmlEditor_TermsAndCondition.Text = "";
            ////////////TextBox_payment_Process.Text = "";
            //////////////GridView1.Visible = false;

            ////////////Button1.Visible = false;
            //////////////TreeView1.Visible = false;
            ////////////DataList_Items.Visible = false;
            ////////////HiddenField_PO_ID.Value = "0";
        }

        else
        {

            DataList_Items.Visible = true;
            if (IsExist(DDL_PO_NO.SelectedValue.ToString()))
            {
                Label_Msg.Text = "Already Existed";
                Label_Msg.Visible = true;
                Load_PO(DDL_PO_NO.SelectedValue.ToString());
              Button4.Visible = true;

            }
            else
            {
                Label_Msg.Text = "";
                Label_Msg.Visible = false;
                DropDownList1.Enabled = true;
                WebHtmlEditor_TermsAndCondition.Text = "";
                TextBox_payment_Process.Text = "";
                //GridView1.Visible = false;
                //Button1.Visible = false;
                HiddenField_PO_ID.Value = DDL_PO_NO.SelectedValue.ToString();
                WebDateChooser_PODate.Enabled = true;
                WebDateChooser_PODate.Value = DateTime.Now;
            }



        }



    }


    protected void txtExpenseCost_TextChanged(object sender, EventArgs e)
    {
        try
        {

            txtbox_CurrencyRate.Text = Convert.ToString(Convert.ToDecimal(txtExpenseCost.Text) / Convert.ToDecimal(txtCurrencyRate.Text));
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    
    }
    protected void txtbox_CurrencyRate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            txtExpenseCost.Text = Convert.ToString(Convert.ToDecimal(txtCurrencyRate.Text) * Convert.ToDecimal(txtbox_CurrencyRate.Text));
        }
        catch (Exception EX)
        {
            Response.Write(EX.Message);
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void gvExpenseView_PreRender(object sender, EventArgs e)
    {
        try
        {



            Decimal Total = 0;
            Decimal TotalUSRate = 0;
            Decimal CurrencyRate = 0;


            foreach (GridViewRow gvr in gvExpenseView.Rows)
            {
                if (gvr.RowType == DataControlRowType.DataRow)
                {
                    Label ltrTemp = gvr.FindControl("lblExpenseCost") as Label;
                    Total += Convert.ToDecimal(ltrTemp.Text);

                    ltrTemp = gvr.FindControl("lblUSRate") as Label;
                    TotalUSRate += Convert.ToDecimal(ltrTemp.Text);

                    ltrTemp = gvr.FindControl("lblCurrencyCost") as Label;
                    CurrencyRate += Convert.ToDecimal(ltrTemp.Text);
                }
            }


            Label lblTemp = gvExpenseView.FooterRow.FindControl("lblTotalExpenseCost") as Label;
            if (lblTemp != null)
                lblTemp.Text = string.Format("{0}", Total.ToString("#,##.00"));

            lblTemp = gvExpenseView.FooterRow.FindControl("lblTotalUSRate") as Label;
            if (lblTemp != null)
                lblTemp.Text = string.Format("{0}", TotalUSRate.ToString("#,##.00"));


            lblTemp = gvExpenseView.FooterRow.FindControl("lblTotalCurrencyCost") as Label;
            if (lblTemp != null)
                lblTemp.Text = string.Format("{0}", CurrencyRate.ToString("#,##.00"));


        }
        catch
        {

        }

    }
    protected void gvExpenseView_DataBound(object sender, EventArgs e)
    {
        
    }

    protected void btnFilterPO_Click(object sender, ImageClickEventArgs e)
    {
        SDS_Find_PO_No.SelectParameters["Param"].DefaultValue = "%" + Txt_PO_No.Text + "%";
        DDL_PO_NO.DataBind();
      

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SQL_Expense_GV_Deleted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void SDS_Find_PO_No_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void TXT_Party_Name_TextChanged(object sender, EventArgs e)
    {
        int count = 0;
        SqlConnection con_Party = new SqlConnection(connection1);
        con_Party.Open();
        SqlCommand command_Party = new SqlCommand("select Count(*) from parties where party_name like '%'+@P_Name+'%'", con_Party);
        command_Party.Parameters.AddWithValue("@P_Name", TXT_Party_Name.Text.Trim());

        count = Convert.ToInt32(command_Party.ExecuteScalar());
        if (count > 0)
        {
            //while (reader.Read())
            //{
            //    count++;

            //}

            LBL_Rec_MSG.Text = count.ToString() + " Record(s) found ";
            Hf_PARTY_NAME.Value = "%" + TXT_Party_Name.Text.Trim() + "%";
            DDL_Charge_To.DataBind();
        }
        else
        {
            LBL_Rec_MSG.Text = "No Record Found";
            Hf_PARTY_NAME.Value = "%";

        }


        //Response.Write("None");
        //reader.Close();
        con_Party.Close();

    }
    public void ResetPNLExpanse()
    {
        txtExpenseCost.Text = String.Empty;
        txtbox_CurrencyRate.Text = String.Empty;
        TXT_Party_Name.Text = String.Empty;
        Hf_PARTY_NAME.Value = String.Empty;
        TextBox_Description.Text = String.Empty;
        LBL_Rec_MSG.Text = "<< Type Text to Search Company ";
    }
    protected void Lb_View_Voucher_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        Session.Add("VTI", lb.CommandArgument);
        if (string.IsNullOrEmpty(lb.CommandArgument.ToString()))
        {
            Label_Msg.Text = "No voucher Information Present . . .";
        }
        else
        { 
        }
        //Response.Redirect("CReport_Recipt_Voucher.aspx");
        string URL = "../finance/CReport_Recipt_Voucher.aspx";
        //if (!ClientScript.IsClientScriptBlockRegistered(this.GetType(), "PopUp"))
        //{
        //    ClientScript.RegisterClientScriptBlock(this.GetType(), "PopUp", Utility.GetJSPopupScript(URL));
        //}
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count != 0)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>window.open('PurchaseOrderReport.aspx?PO_ID=" + DDL_PO_NO.SelectedValue + "')</script>");
            Type t = GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "PopUp"))
            {
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
            }
        }
        //string URL = "OtherExpenseReport.aspx?PO_ID="+ DDL_PO_NO.SelectedValue.ToString();
        //if (!ClientScript.IsClientScriptBlockRegistered(this.GetType(), "PopUp"))
        //{
        //    ClientScript.RegisterClientScriptBlock(this.GetType(), "PopUp", URL);
        ////}
        //Response.Redirect("OtherExpenseReport.aspx?PO_ID=" + HiddenField_PO_ID.Value);
    }

    protected void btnDistDetail_Click(object sender, EventArgs e)
    {
        //string URL = "ViewPO_Distribution.aspx?PO_ID=" + DDL_PO_NO.SelectedValue.ToString();
        //if (!ClientScript.IsClientScriptBlockRegistered(this.GetType(), "PopUp"))
        //{
        //    ClientScript.RegisterClientScriptBlock(this.GetType(), "PopUp", Utility.GetJSPopupScript(URL));
        //}
    }
    protected void Updatebtn_Click(object sender, EventArgs e)
    {
        CheckBox chk;
        TextBox txtExpense;
        HiddenField hfItem_Code;
        HiddenField hfPO_Id_SUb;
        foreach (GridViewRow gv in GridView1.Rows)
        {
            chk = gv.FindControl("chkbox") as CheckBox;

            txtExpense = gv.FindControl("Label_Item_Wise_Expense") as TextBox;
            hfItem_Code = gv.FindControl("HiddenField1") as HiddenField;
            hfPO_Id_SUb = gv.FindControl("HfPO_ID_Sub") as HiddenField;
            if (chk.Checked)
            {

                DbManager db = new DbManager();
                string qry = "update Purchase_Order_Sub set Cost_Wise_Expense=@Expense where PO_ID_Sub=@PO_ID_Sub and Item_Code=@ItemCode";
                SqlParameter[] param =
                {
                    new SqlParameter("@ItemCode",hfItem_Code.Value),
                    new SqlParameter("@PO_ID_Sub",hfPO_Id_SUb.Value),
                    new SqlParameter("@Expense",txtExpense.Text.Replace(",",""))
                };
                db.ExecuteDataTableWithQuery(qry, "STOREConnectionString", param);
                Label_Msg.Text = "Updated Successfully!";
                GridView1.DataBind();
            }

        }
    }

    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkall = sender as CheckBox;
        foreach (GridViewRow gv in GridView1.Rows)
        {
            CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;
            if (chkall.Checked)
            {
                chkbox.Checked = true;
            }
            else
            {
                chkbox.Checked = false;
            }
        }
    }
    protected void btnaddexpense_Click(object sender, EventArgs e)
    {
        Button btn =sender as Button;
        GridViewRow row=btn.NamingContainer as GridViewRow;
        HiddenField HiddenField1 = (HiddenField)row.FindControl("HiddenField1");
        Label amount = (Label)row.FindControl("Label_Amount");
        hfditemcode.Value = HiddenField1.Value;
        hfdamount.Value = amount.Text;
        pnlPOExpenses.Visible = true;
    }
}