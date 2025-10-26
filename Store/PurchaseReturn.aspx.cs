using System;
using System.Data;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Megaplus.Finance;
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Collections.Generic;
using System.Net.Mail;

public partial class PurchaseReturn : System.Web.UI.Page
{
    //static string connection = ConfigurationManager.ConnectionStrings["Pharmacy_ConnectionString"].ToString();
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    static string basicConStr = ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ToString();
    static string Con = ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ToString();
    Encryption ENC = new Encryption();
    public string getStock(string MedCode)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("Select_Stock_For_Medicine_Issue", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@Item_Code", MedCode);
        command.Parameters.AddWithValue("@Dept_ID", Session["dept_id"]);
        command.Parameters.AddWithValue("@SubDept_ID", Session["SubDeptID"]);
        command.Parameters.AddWithValue("@ShiftID", Session["ShiftID"]);
        SqlDataReader reader = command.ExecuteReader();
        reader.Read();
        string str;
        try
        {
            str = reader[0].ToString();
        }
        catch (Exception ex)
        {
            string str1 = ex.ToString();
            str = "0";
        }
        reader.Close();
        con.Close();
        return str;
        //Response.Write(str);
    }
    public bool checkalreadyinserted(string str)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT item_Request_Track.* FROM item_Request_Track WHERE (IB_ID = '" + str + "')", con);
        SqlDataReader reader = command.ExecuteReader();
        bool val = reader.HasRows;
        reader.Close();
        con.Close();
        return true;
    }

    public void getCounter()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Store_Indent_Book_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Dept_ID = @From_Dept_ID) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID) and (LEFT(IB_ID,2) = 'PR' and emp_id = @Emp_ID )", con);
        command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", Session["SubDeptID"]);
        command1.Parameters.AddWithValue("@Emp_id", HiddenField_Emp_ID.Value);
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
        Labeb_Requisition_No.Text = "PR" + DateTime.Today.Year + "-" + Session["Emp_id"].ToString() + "-";
        while (len < 5)
        {
            Labeb_Requisition_No.Text += "0";
            len++;
        }
        Labeb_Requisition_No.Text += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
        HiddenField_counter.Value = Labeb_Requisition_No.Text;



    }

    protected void validate(string url, string dept)
    {
        if (Session["emp_id"] == null || Session["SubDeptId"] == null)
        {
            Response.Redirect("../login.aspx");
        }
    }

    protected void resetit()
    {
        if (Request.QueryString["YearlyRequest"] != null)
        {
            HiddenField_counter.Value = "Y" + ddlFromOffice.SelectedValue.ToString() + "-" + DateTime.Now.Year;
            Labeb_Requisition_No.Text = HiddenField_counter.Value;
            if (checkalreadyinserted(HiddenField_counter.Value))
            {
                Labeb_Requisition_No.Text = "Already Submited";
                Button_update_QTY.Visible = false;
                Button5.Visible = false;
                //Button3.Visible = false;
                Button4.Visible = false;
                Button7.Visible = false;

                Button1.Visible = false;

            }
            else
            {
                SqlDataSource_Medicine_Main.InsertParameters["Type"].DefaultValue = "Return";
                SqlDataSource_Medicine_Main.Insert();
            }

        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {

            validate("", "");
            HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
            HiddenField_Emp_ID.Value = Session["emp_id"].ToString();
            ddlFromOffice.DataBind();
            DropDownList_Department.DataBind();
            DropDownListStore.DataBind();
            ddlCompnay.DataBind();
            ddlCompnay.SelectedValue=Request.QueryString["CID"];
            ddlCompnay.Items.Insert(0, new ListItem("Select Company", "0"));
            GridView1.DataBind();
            Check_IB_ID();
            LoadDictionaries();
            DropDownList_Department.Enabled = false;
            DropDownListStore.Enabled = false;
            DropDownList_Department.SelectedValue = Session["dept_id"].ToString();
            string Adil= Session["SubDeptId"].ToString();
            DropDownListStore.SelectedValue = Session["SubDeptId"].ToString();
            if (Request.QueryString["PO_ID"]!=null)
            {
                txtPR.Text = Request.QueryString["PO_ID"].ToString();
                Button1_Click(sender, e);
            }
            else
            {
                //txtPR.Text = "0";
            }


            // DropDownList_Department.SelectedValue = "1";
            // DropDownListStore.SelectedValue = "12";
            //if (Session["SubDeptId"].ToString() == "12")
            //{
            //    DropDownList_Department.Enabled = true;
            //    DropDownListStore.Enabled = true;
            //}
            //else
            //{
            //    DropDownList_Department.Enabled = false;
            //    DropDownListStore.Enabled = false;
            //}
            //if (Convert.ToInt32(Session["Financial_Company_Id"]) == 1)
            //{
            //    rbManufacturer.SelectedValue = "Schneider";

            //}
            //else
            //{
            //    rbManufacturer.SelectedValue = "HP";
            //}
            //ddlManufacturer.DataBind();
            //if (rbManufacturer.SelectedValue == "Others")
            //{
            //    ddlManufacturer.SelectedValue = "-------All------";
            //}
            //else
            //{
            //    ddlManufacturer.SelectedValue = rbManufacturer.SelectedValue;
            //}

        }
        //else 
        //{
        //    Check_IB_ID();
        //}


        if (GridView1.Rows.Count == 0)
        {
            Button5.Visible = false;
            resetit();
            Button_update_QTY.Visible = false;


        }
        else
        {
            Button5.Visible = true;


        }

        Button1.Attributes.Add("OnClick", "return CheckRequirment()");

        

    }

    private void LoadDictionaries()
    {
        //FillDictionaries dics = new FillDictionaries();
        //dics.FillItemTypes(ref ddlItemType);
    }



    protected void TextBox_specificMedicine_TextChanged(object sender, EventArgs e)
    {
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
    }

    protected void Button3_Click(object sender, EventArgs e)
    {
        if (HiddenField_counter.Value != "")
        {
            Label1.Visible = false;
            try
            {

                SqlDataSourceDelete_Sub.Delete();
                SqlDataSource_Medicine_Main.Delete();
                //SqlDataSource_Requsition_SendTo_Delete.Delete();
                Label1.Text = "This Requisition RoleBacked";
                Label1.Visible = true;
                HiddenField_counter.Value = "";
                Labeb_Requisition_No.Text = "";
                Button_update_QTY.Visible = false;
                //Button4.Visible = false;
                //Button7.Visible = false;
            }
            catch (Exception ex)
            {
                Label1.Text = "This Requisition Can not RoleBacked" + ex.Message;
                Label1.Visible = true;
            }
        }

        GridView1.DataBind();

        resetit();
    }

    protected void Button_update_QTY_Click(object sender, EventArgs e)
    {

        update_Items();
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {

            HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
            TextBox qty = (TextBox)GridView1.Rows[i].FindControl("TextBox1");
            int balance = Convert.ToInt32(0);
            GridView1.Rows[i].Cells[2].Text = balance.ToString();
        }

        if (GridView1.Rows.Count == 1)
        {
            GridView1.HeaderRow.Cells[0].Visible = false;
            GridView1.Rows[0].Cells[0].Visible = false;

        }
        if (GridView1.Rows.Count > 0)
        {
            Pnl_GST.Visible = false;
        }
        else
        {
            Pnl_GST.Visible = false;
        }


    }

    protected void Button4_Click(object sender, EventArgs e)
    {
        if (Request.QueryString.HasKeys())
        {
            if (ddlCompnay.SelectedValue != "0")
            {
                lblMsg.Visible = false;
                double tAmount = totalAmount(), outstanding = 0;
                if (!string.IsNullOrEmpty(LBL_Total.Text.Trim()))
                {
                    outstanding = Convert.ToDouble(LBL_Total.Text.Replace(",", "").Trim());
                }
                if (String.IsNullOrEmpty(LBL_CL.Text.Trim()))
                {
                    LBL_CL.Text = "0.00";
                }
                //if (tAmount <= Convert.ToDouble(LBL_CL.Text) - outstanding)
                //{
                update_Items();
                CompleteRequisition();
            }
            else
            {
                lblMsg.Visible = true;
            }
        }
        else
        {
            lblMsg.Visible = false;
            double tAmount = totalAmount(), outstanding = 0;
            if (!string.IsNullOrEmpty(LBL_Total.Text.Trim()))
            {
                outstanding = Convert.ToDouble(LBL_Total.Text.Replace(",", "").Trim());
            }
            if (String.IsNullOrEmpty(LBL_CL.Text.Trim()))
            {
                LBL_CL.Text = "0.00";
            }
            //if (tAmount <= Convert.ToDouble(LBL_CL.Text) - outstanding)
            //{
            update_Items();
            CompleteRequisition();
        }
        //}
        //else
        //{
        //    PNL_Exceed_limit.Visible = true;
        //    Label1.Text = "Can not proceed exceeding Credit Limit";

        //    Label1.Visible = true;
        //}
        //}
        //else
        //{
        //    lblMsg.Visible = true;
        //}

    }

    protected double totalAmount()
    {
        double amount = 0, gst = 0;
        foreach (GridViewRow row in GridView1.Rows)
        {
            TextBox txt_Qty = (TextBox)row.FindControl("TextBox1");
            TextBox txt_Rate = (TextBox)row.FindControl("txt_item_qty");
            if (txt_Rate.Text.Trim() == "")
            {
                txt_Rate.Text = "0";
            }
            amount = amount + (Convert.ToDouble(txt_Qty.Text) * Convert.ToDouble(txt_Rate.Text));
        }
        if (!string.IsNullOrEmpty(TXT_GST.Text.Trim()))
        {
            gst = (amount * (Convert.ToInt32(TXT_GST.Text.Trim())) / 100);
        }


        return amount + gst;

    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       if(ddlCompnay.SelectedValue!="0" || txtPR.Text != "")
        {

        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        // Search By Po
        SqlCommand cmd = new SqlCommand("Search_By_PO", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@SubDept_Id", ddlFromOffice.SelectedValue);
        cmd.Parameters.AddWithValue("@PONumber", txtPR.Text);
        cmd.Parameters.AddWithValue("@ItemName", TextBox_specificMedicine.Text);
        cmd.Parameters.AddWithValue("@Party_Name", txtVendor.Text);
        SqlDataAdapter adot = new SqlDataAdapter();
        adot.SelectCommand = cmd;
        DataTable dt = new DataTable();
        adot.Fill(dt);
        GridViewMedicine.DataSource = dt;
        GridViewMedicine.DataBind();
        GridViewMedicine.Visible = true;


        // Get Party Name

        //if (txtPR.Text != "")
        //{

        //    SqlCommand cmd2 = new SqlCommand("Search_Party_By_PO_ID", con);

        //    cmd2.CommandType = CommandType.StoredProcedure;
        //    cmd2.Parameters.AddWithValue("@PONumber", txtPR.Text);
        //    SqlDataAdapter adot2 = new SqlDataAdapter();
        //    adot2.SelectCommand = cmd2;
        //    DataTable dt2 = new DataTable();
        //    adot2.Fill(dt2);
        //    TXT_Party_Name.Text = dt2.Rows[0][1].ToString();
        //    BtnSearchParty_Click(sender, e);
        //    loadPartyDetail();
        //}
        //else
        //{
        //    TXT_Party_Name.Text = txtVendor.Text;
        //    //BtnSearchParty_Click(sender, e);
        //    //loadPartyDetail();
        //}
        


        con.Close();
            lblErrorMsg.Visible = false;

        }
       else
        {
            lblErrorMsg.Visible = true;
            lblErrorMsg.Text = "Please Enter PO # or Select Vendor.";

        }


    }
    

    public void Check_IB_ID()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command_IB_ID = new SqlCommand("SELECT IB_ID,Company_ID, ISnull(Delivery_Site,'') as Delivery_Site , ISnull(Delivery_Address,'') Delivery_Address, ISnull(Contact_Person,'') Contact_Person, ISnull(Phone_No,'') Phone_No, ISnull(Remarks,'') Remarks,ISnull(GST,0) GST FROM Store_Indent_Book_Main WHERE (ShiftID = @ShiftID) AND (Emp_ID=@Emp_ID) AND (IB_ID NOT IN (SELECT IB_ID FROM Item_Request_Track WHERE (By_Dept_ID = @bysubdept))) AND (From_Dept_ID = @DeptID) AND (From_Sub_Dept_ID = @SubDeptID) and left(IB_ID,2) = 'PR'", con);

        command_IB_ID.Parameters.AddWithValue("@DeptID", Session["dept_id"]);
        command_IB_ID.Parameters.AddWithValue("@bysubdept", HiddenField_Dept_ID.Value);

        command_IB_ID.Parameters.AddWithValue("@SubDeptID", ddlFromOffice.SelectedValue);
        command_IB_ID.Parameters.AddWithValue("@ShiftID", Session["ShiftID"]);
        command_IB_ID.Parameters.AddWithValue("@Emp_ID", Session["Emp_Id"]);

        SqlDataReader reader = command_IB_ID.ExecuteReader();
        if (reader.HasRows)
        {
            reader.Read();

            HiddenField_counter.Value = reader["IB_ID"].ToString();
            if (!string.IsNullOrEmpty(reader["Company_ID"].ToString()) && reader["Company_ID"].ToString() != "0")
            {
                Hf_PARTY_NAME.Value = "%";
                ddlCompnay.DataBind();
                ddlCompnay.SelectedValue = reader["Company_ID"].ToString();
            }

            TXT_DeliverySite.Text = reader["Delivery_Site"].ToString();
            TXT_delivery_Address.Text = reader["Delivery_Address"].ToString();
            TXT_Person.Text = reader["Contact_Person"].ToString();
            TXT_Phone.Text = reader["Phone_No"].ToString();
            if (!string.IsNullOrEmpty(reader["GST"].ToString()))
            {
                TXT_GST.Text = reader["GST"].ToString();
            }

            TextBox_Requsition_Description.Text = reader["Remarks"].ToString();

            Labeb_Requisition_No.Text = HiddenField_counter.Value;
            GridView1.DataBind();
            if (ddlCompnay.SelectedValue != "0")
            {
                //Load_Information();
            }

        }

        reader.Close();
        con.Close();


    }
    public void fillTree(string MedicineName, string MedicineCategory)
    {
        try
        {


            SqlConnection con = new SqlConnection(connection1);
            con.Open();
            SqlCommand command = new SqlCommand("Select_Medicine_Department_DrugCategory", con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Dept_Id", DropDownList_Department.SelectedValue);
            command.Parameters.AddWithValue("@SubDept_Id", DropDownListStore.SelectedValue);//Session["SubDeptID"]);   
            command.Parameters.AddWithValue("@Item_Name", MedicineName);
            command.Parameters.AddWithValue("@Drug_Category", MedicineCategory);
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string str = reader.GetString(0);
                TreeNode obj = new TreeNode("", str);



                getmedicine(obj, str, MedicineCategory, MedicineName);
            }
            reader.Close();
            con.Close();

        }
        catch (Exception msg)
        {
            // Response.Write(msg.Message ) ;
        }
    }
    public string getmedicine(TreeNode obj, string str, string cat, string med_name)
    {
        SqlConnection con1 = new SqlConnection(connection1);
        con1.Open();
        SqlCommand command1 = new SqlCommand("Select_Store_Item", con1);
        command1.CommandType = CommandType.StoredProcedure;
        command1.Parameters.AddWithValue("@category", str);
        command1.Parameters.AddWithValue("@Dept_Id", DropDownList_Department.SelectedValue);
        command1.Parameters.AddWithValue("@SubDept_Id", DropDownListStore.SelectedValue);
        command1.Parameters.AddWithValue("@Store_Items", med_name);
        command1.Parameters.AddWithValue("@Drug_Category", cat);
        SqlDataReader readerchild = command1.ExecuteReader();
        while (readerchild.Read())
        {
            TreeNode chil = new TreeNode(readerchild.GetString(1), readerchild.GetString(0));
            obj.ChildNodes.Add(chil);
        }
        con1.Close();
        return "hello";
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {

        fillTree("", "%");

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {

            HiddenField_Med_Code.Value = Convert.ToString(e.CommandArgument);

            SqlDataSource_Medicine_Sub.Delete();
            GridView1.DataBind();

        }
    }
    protected void BtnSearchParty_Click(object sender, EventArgs e)
    {
        Hf_PARTY_NAME.Value = "%" + TXT_Party_Name.Text.Trim() + "%";
        ddlCompnay.DataBind();

    }



    protected void Button_Report_Click(object sender, EventArgs e)
    {
        //if (ddlCompnay.SelectedValue != "0")
        //{
        lblMsg.Visible = false;
        update_Items();
        Response.Redirect("PurcahseReturnReport.aspx?QO_id=" + Labeb_Requisition_No.Text + "&PID=" + ddlCompnay.SelectedValue.ToString() + "&CBI=" + DropDownListStore.SelectedValue.ToString());
        //}
        //else
        //{
        //    lblMsg.Visible = true;
        //}
    }
    protected void DropDownList_Department_SelectedIndexChanged(object sender, EventArgs e)
    {
        Check_IB_ID();
        DropDownListStore.DataBind();
        fillTree("", "%");
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

            LBL_Rec_MSG.Text = count.ToString() + " Record(s) found ";
            Hf_PARTY_NAME.Value = "%" + TXT_Party_Name.Text.Trim() + "%";
            ddlCompnay.DataBind();
            loadPartyDetail();
            //Load_Information();
        }
        else
        {
            LBL_Rec_MSG.Text = "No Record Found";
            Hf_PARTY_NAME.Value = "%";

        }

        con_Party.Close();

    }
    public void update_Items()
    {
        try
        {
            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                TextBox qty = (TextBox)GridView1.Rows[i].FindControl("TextBox1");
                TextBox rate = (TextBox)GridView1.Rows[i].FindControl("lblcost");
                TextBox pack = (TextBox)GridView1.Rows[i].FindControl("txtPack");
                TextBox unitPack = (TextBox)GridView1.Rows[i].FindControl("txtUnitsPack");
                HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
                TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");
                HiddenField_Rate.Value = rate.Text;
                HiddenField_Med_Pack.Value = pack.Text;
                HiddenField_Med_Unit_Pack.Value = unitPack.Text;
                HiddenField_Med_Qty.Value = qty.Text;
                HiddenField_Med_Code.Value = code.Value;
                HiddenField_Specification.Value = TextBox_Specification.Text;
                try
                {
                    if (String.IsNullOrEmpty(qty.Text))
                    {
                        SqlDataSource_Submit.Delete();
                    }
                    else
                    {
                        SqlDataSource_Medicine_Sub.Update();
                    }
                }
                catch (Exception ex)
                {
                    string str = ex.ToString();
                    Response.Write(str);
                }

            }


            if (string.IsNullOrEmpty(TXT_GST.Text.Trim()))
            {
                SqlDataSource_Medicine_Main.UpdateParameters["GST"].DefaultValue = "0";
            }
            else
            {
                SqlDataSource_Medicine_Main.UpdateParameters["GST"].DefaultValue = TXT_GST.Text.Trim();
            }



            SqlDataSource_Medicine_Main.Update();
            //updatePartyDetail();
            GridView1.DataBind();
        }
        catch
        {
            Label1.Text = "Unable to update items ....";
        }


    }


    private int PartyID
    {
        get
        {
            try
            {
                return Convert.ToInt32(ddlCompnay.SelectedValue);
            }
            catch
            {
                return 0;
            }
        }
    }
    private int CompanyBranchID
    {
        get
        {
            try
            {
                return Convert.ToInt32(Session["Company_Branch_Id"]);

            }
            catch
            {
                return 0;
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

    private void Load_Information()
    {
        Megaplus.Finance.FinanceDBManager FinDBManager = new Megaplus.Finance.FinanceDBManager(Con);
        DataSet ds = FinDBManager.GetPartyBalancePeriodData(DateTime.Now, PartyID, CompanyBranchID);
        UpdateBalanceData(ds);
        if (ds.Tables[0].Rows.Count > 1)
        {
            LBL_Total.Text = GetBalance(ds, 1).ToString("#,#0.00");
            LBL_30.Text = GetBalance(ds, 2).ToString("#,#0.00");
            LBL_60.Text = GetBalance(ds, 3).ToString("#,#0.00");
            LBL_90.Text = GetBalance(ds, 4).ToString("#,#0.00");
            lbl_90plus.Text = GetBalance(ds, 1).ToString("#,#0.00");

        }
        else
        {
            LBL_Total.Text = "0.00";
            LBL_30.Text = "0.00";
            LBL_60.Text = "0.00";
            LBL_90.Text = "0.00";
            lbl_90plus.Text = "0.00";

        }


        DataSet dsCompanyPay = FinDBManager.GetPartyAndPaymentData(PartyID);
        if (dsCompanyPay.Tables[0].Rows.Count > 0)
        {

            LBL_CL.Text = GetCompanyInvoicePayData(dsCompanyPay, "CR");
            LBL_LI.Text = GetCompanyInvoicePayData(dsCompanyPay, "INV");
            LBL_LP.Text = GetCompanyInvoicePayData(dsCompanyPay, "PAY");
        }
        else
        {
            LBL_CL.Text = "0.00";
            LBL_LI.Text = "0.00";
            LBL_LP.Text = "0.00";
        }

    }
    protected void ddlCompnay_SelectedIndexChanged(object sender, EventArgs e)
    {

        //Load_Information();

    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {


        SqlDataSource_Medicine_Sub.DeleteParameters["Item_Code"].DefaultValue = (sender as ImageButton).CommandArgument;
        SqlDataSource_Medicine_Sub.Delete();
        GridView1.DataBind();
    }
    protected void SqlDataSource_Medicine_Sub_Deleting(object sender, SqlDataSourceCommandEventArgs e)
    {

    }

    protected void forwardDemand()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", Labeb_Requisition_No.Text),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id", ddlFromOffice.SelectedValue),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks",""),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateQuotationApprovalRequest", "STOREConnectionString", sqlParm);

    }
    protected void CompleteRequisition()
    {
        try
        {

            {
                forwardDemand();
                //updatePartyDetail();
                SqlDataSource_Submit.Insert();
                SqlDataSourceApprove.Insert();
                //send_ipo_for_approval();
            }
            Response.Redirect("PurcahseReturnReport.aspx?QO_id=" + Labeb_Requisition_No.Text + "&PID=" + ddlCompnay.SelectedValue.ToString() + "&CBI=" + DropDownListStore.SelectedValue.ToString());


        }
        catch (Exception ex)
        {
            string str = ex.ToString();

            Labeb_Requisition_No.Text = "Anual Requisition Already Submited";
        }

    }

    protected void BTN_Save_Click(object sender, EventArgs e)
    {
        SDS_Exceeded.Update();
        update_Items();
        CompleteRequisition();
    }
    protected void BTN_Cancel_Click(object sender, EventArgs e)
    {
        PNL_Exceed_limit.Visible = false;
    }
    protected void SendEMail(String manufacturer)
    {
        GETData(manufacturer);
    }
    private void GETData(String mfg)
    {
        String finConString = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        List<string> emailAttachments = new List<string>();
        string fileNameExt = string.Format("_{0}.pdf", DateTime.Now.ToString("yyyyMMdd"));
        String outFile = Server.MapPath("~/Store/EMail/IPO_For_" + ddlCompnay.SelectedItem.Text + fileNameExt);
        PurchaseOrder ds = new PurchaseOrder();
        //PurchaseOrderTableAdapters.IPOReportTableAdapter da = new PurchaseOrderTableAdapters.IPOReportTableAdapter();
        String reportPath = Server.MapPath("~/store/Reports/IPOPriceReport.rdlc");
        //da.Fill(ds.IPOReport, Labeb_Requisition_No.Text);

        FinanceDBManager finManager = new FinanceDBManager(finConString);
        DataSet dsBalance = finManager.GetPartyBalancePeriodData(DateTime.Now, PartyID, CompanyBranchID);
        DataSet dsCompanyPay = finManager.GetPartyAndPaymentData(PartyID);

        UpdateBalanceData(dsBalance);

        ReportViewer ReportViewer1 = new ReportViewer();
        ReportParameter[] repParams = new ReportParameter[9];
        repParams[0] = new ReportParameter("QO_ID", Labeb_Requisition_No.Text);
        repParams[1] = new ReportParameter("Balance1", GetBalance(dsBalance, 1).ToString());
        repParams[2] = new ReportParameter("Balance2", GetBalance(dsBalance, 2).ToString());
        repParams[3] = new ReportParameter("Balance3", GetBalance(dsBalance, 3).ToString());
        repParams[4] = new ReportParameter("Balance4", GetBalance(dsBalance, 4).ToString());
        repParams[5] = new ReportParameter("Balance5", GetBalance(dsBalance, 5).ToString());
        repParams[6] = new ReportParameter("CreditLimit", GetCompanyInvoicePayData(dsCompanyPay, "CR"));
        repParams[7] = new ReportParameter("LastInvoice", GetCompanyInvoicePayData(dsCompanyPay, "INV"));
        repParams[8] = new ReportParameter("LastPayment", GetCompanyInvoicePayData(dsCompanyPay, "PAY"));
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.SetParameters(repParams);
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables["IPOReport"]));
        ReportViewer1.LocalReport.Refresh();
        String outFile1 = Server.MapPath("~/Store/EMail/LastFiveSoldItems_" + Session["SubDeptId"] + ".pdf");
        String outFile2 = Server.MapPath("~/Store/EMail/LastFiveSoldItemsParty_" + Session["SubDeptId"] + ".pdf");
        String outFile3 = Server.MapPath("~/Store/EMail/LastFivePurchases_" + Session["SubDeptId"] + ".pdf");

        String reportPath1 = Server.MapPath("~/Store/LastFiveSoldItemsReport.rdlc");
        String reportPath2 = Server.MapPath("~/Store/LastFiveSoldItemsPartyReport.rdlc"); String reportPath3 = Server.MapPath("~/Store/LastPurchasePricesByIPOReport.rdlc");

        DataView dvLastFiveSoldItems = sdsLastFiveSoldItems.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dtLastFiveSoldItems = dvLastFiveSoldItems.Table;
        ReportViewer ReportViewer2 = new ReportViewer();
        ReportViewer2.LocalReport.DataSources.Clear();
        ReportViewer2.LocalReport.ReportPath = reportPath1;
        ReportViewer2.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dtLastFiveSoldItems));
        ReportViewer2.LocalReport.Refresh();
        // Second Report
        DataView dvLastFiveSoldItemsParty = sdsLastFiveSoldItemsParty.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dtLastFiveSoldItemsParty = dvLastFiveSoldItemsParty.Table;
        ReportViewer ReportViewer3 = new ReportViewer();
        ReportViewer3.LocalReport.DataSources.Clear();
        ReportViewer3.LocalReport.ReportPath = reportPath2;
        ReportViewer3.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dvLastFiveSoldItemsParty));
        ReportViewer3.LocalReport.Refresh();

        // Third Report
        DataView dvLastFivePurchases = sdsLastFivePurchases.Select(DataSourceSelectArguments.Empty) as DataView;
        DataTable dtLastFivePurchases = dvLastFivePurchases.Table;
        ReportViewer ReportViewer4 = new ReportViewer();
        ReportViewer4.LocalReport.DataSources.Clear();
        ReportViewer4.LocalReport.ReportPath = reportPath3;
        ReportViewer4.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dvLastFivePurchases));
        ReportViewer4.LocalReport.Refresh();
        if (File.Exists(outFile1))
        {
            File.Delete(outFile1);
        }
        if (File.Exists(outFile2))
        {
            File.Delete(outFile2);
        }
        if (File.Exists(outFile3))
        {
            File.Delete(outFile3);
        }
        byte[] ReportContent = ReportViewer1.LocalReport.Render("PDF", null);
        using (FileStream stream = new FileStream(outFile, FileMode.Create))
        {
            stream.Write(ReportContent, 0, ReportContent.Length);
            emailAttachments.Add(outFile);
        }
        ReportContent = ReportViewer2.LocalReport.Render("PDF", null);
        using (FileStream stream = new FileStream(outFile1, FileMode.Create))
        {
            stream.Write(ReportContent, 0, ReportContent.Length);
            emailAttachments.Add(outFile1);

        }
        ReportContent = ReportViewer3.LocalReport.Render("PDF", null);
        using (FileStream stream = new FileStream(outFile2, FileMode.Create))
        {

            stream.Write(ReportContent, 0, ReportContent.Length);
            emailAttachments.Add(outFile2);
        }
        ReportContent = ReportViewer4.LocalReport.Render("PDF", null);
        using (FileStream stream = new FileStream(outFile3, FileMode.Create))
        {

            stream.Write(ReportContent, 0, ReportContent.Length);
            emailAttachments.Add(outFile3);
        }
        Send_Email(emailAttachments, mfg);

    }
    private void Send_Email(List<string> attachments, String IPOFor)
    {
        string From = "mpsoftware@megaplus.com.pk";
        string ToEmail = "";
        if (IPOFor == "HP")
        {
            ToEmail = "asim@megaplus.com.pk;shabir@megaplus.com.pk;arshad@megaplus.com.pk;rashid@megaplus.com.pk";
        }
        else
        {
            ToEmail = "asim@megaplus.com.pk;shabir@megaplus.com.pk;arshad@megaplus.com.pk;rashid@megaplus.com.pk;Mahmood.ali@megaplus.com.pk";
        }
        string ccEmail = "tariq@megaplus.com.pk";
        string password = "dellsoft";
        try
        {
            System.Net.Mail.MailMessage mail = new System.Net.Mail.MailMessage();

            string[] toEmailAddresses = ToEmail.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string t in toEmailAddresses)
            {
                mail.To.Add(t);
            }

            string[] ccEmailAddresses = ccEmail.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries);

            foreach (string t in ccEmailAddresses)
            {
                mail.CC.Add(t);
            }

            mail.From = new MailAddress(From, "MEGAPLUS", System.Text.Encoding.UTF8);
            mail.Subject = "IPO for " + ddlCompnay.SelectedItem.Text + DateTime.Now.ToString("dd-MMM-yyyy");
            mail.SubjectEncoding = System.Text.Encoding.UTF8;
            mail.Body = "Email For IPO.<br/><br/>Dear Sir, <br /><br />Please find the attachments." +
                "<br /> Regards, <br /> Megaplus Support Team.";

            foreach (string t in attachments)
            {
                Attachment attachFile = new Attachment(t);
                mail.Attachments.Add(attachFile);
            }

            mail.BodyEncoding = System.Text.Encoding.UTF8;
            mail.IsBodyHtml = true;
            mail.Priority = MailPriority.High;

            SmtpClient client = new SmtpClient();

            client.Credentials = new System.Net.NetworkCredential(From, password);
            client.Port = int.Parse("587");
            client.Host = "mail.megaplus.com.pk";
            client.EnableSsl = false;
            try
            {
                client.Send(mail);
                insertEmailLogs("Email Sent Successfully!!!!!");
            }
            catch (Exception ex)
            {
                insertEmailLogs("Some Error Occured While Email Sending!!!!!");
            }

        }
        catch (Exception ex)
        {
        }

    }

    protected void btnItem_Click(object sender, EventArgs e)
    {


        LinkButton btnTemp = sender as LinkButton;
        String itemCode = btnTemp.CommandArgument.ToString();
        Double itemRate = 0, itemQty = 0;
        GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        TextBox txtQty = gvRow.FindControl("txtQty") as TextBox;
        Label txtCost = gvRow.FindControl("lblcost") as Label;
        Label lblStock = gvRow.FindControl("lblStock") as Label;
        if (txtQty.Text.Trim() == "")
        {
            itemQty = 1;
        }
        else
        {
            itemQty = Convert.ToDouble(txtQty.Text);
        }
        if (txtCost.Text.Trim() == "")
        {
            itemRate = 0;
        }
        else
        {
            itemRate = Convert.ToDouble(txtCost.Text);
        }
        if (itemQty <= Convert.ToInt32(lblStock.Text))
        {
            if (itemQty > 0 && itemRate >= 0)
            {

                insertItem(itemCode, itemRate, itemQty);
                txtQty.Text = "";
                txtCost.Text = "";
            }

        }
        else
        {
            Label1.Text = "Demand Quantity Exceeds From Total Available Stock";
            Label1.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void insertItem(String Item_Code, Double itemRate, Double itemQty)
    {
        try
        {


            HiddenField_Med_Code.Value = Item_Code;
            Check_IB_ID();
            Label1.Visible = false;
            if (HiddenField_counter.Value == "")
            {
                getCounter();
                try
                {
                    Hf_PO_ID.Value = txtPR.Text;

                    SqlDataSource_Medicine_Main.InsertParameters["Type"].DefaultValue = "Return";

                    SqlDataSource_Medicine_Main.Insert();
                }
                catch (Exception ex)
                {
                    string str = ex.ToString();
                    HiddenField_counter.Value = "";
                    Labeb_Requisition_No.Text = "";
                }
                //                Response.Write("if part");
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Qty"].DefaultValue = itemQty.ToString();
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Rate"].DefaultValue = itemRate.ToString();
                SqlDataSource_Medicine_Sub.Insert();
                GridView1.DataBind();

            }
            else
            {
                //   Response.Write("else part");
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Qty"].DefaultValue = itemQty.ToString();
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Rate"].DefaultValue = itemRate.ToString();
                //SqlDataSource_Medicine_Sub.InsertParameters["Type"].DefaultValue = "Demand";
                SqlDataSource_Medicine_Sub.Insert();
            }
        }
        catch (Exception ex)
        {
            string str = ex.ToString();
        }
        GridView1.DataBind();
        if (GridView1.Rows.Count != 0)
        {
            Button_update_QTY.Visible = true;
        }
    }
    protected void btnExcludeGST_Click(object sender, EventArgs e)
    {
        Double gst = 0, rate = 0;
        if (GridView1.Rows.Count > 0)
        {
            if (TXT_GST.Text.Trim() == "0")
            {
                TXT_GST.Text = "17";
            }
            foreach (GridViewRow gvRow in GridView1.Rows)
            {
                TextBox txtRate = gvRow.FindControl("txt_item_qty") as TextBox;
                gst = Convert.ToDouble(TXT_GST.Text);
                rate = Convert.ToDouble(txtRate.Text);
                txtRate.Text = (rate - (rate * (gst / 100))).ToString("#,##.##");
            }
        }
        else
        {

        }
    }
    protected void insertEmailLogs(String msg)
    {
        try
        {
            SqlConnection con = new System.Data.SqlClient.SqlConnection(connection1);
            string Procedurename = "usp_Insert_IPO_Email_Logs";
            System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand(Procedurename, con);

            mycommand.CommandType = CommandType.StoredProcedure;
            mycommand.CommandText = Procedurename;
            mycommand.Parameters.AddWithValue("@IB_ID", Labeb_Requisition_No.Text);//, 
            mycommand.Parameters.AddWithValue("@Remarks", msg);

            con.Open();
            mycommand.ExecuteScalar();


            con.Close();


        }
        catch (Exception ex)
        {


        }
    }
    public void loadPartyDetail()
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand cmd = new SqlCommand("usp_Get_Party_Detail", con);

        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@Party_Id", ddlCompnay.SelectedValue);

        SqlDataReader reader = cmd.ExecuteReader();
        if (reader.HasRows)
        {
            reader.Read();

            txtEmail.Text = reader["Email"].ToString();
            TXT_delivery_Address.Text = reader["Address"].ToString();
            TXT_Person.Text = reader["Contact_Person_Name"].ToString();
            TXT_Phone.Text = reader["Party_Phone"].ToString();

        }

        reader.Close();
        con.Close();


    }
    public void updatePartyDetail()
    {
        try
        {

            SqlConnection con = new System.Data.SqlClient.SqlConnection(basicConStr);
            string Procedurename = "usp_Update_Party_Detail";
            System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand(Procedurename, con);

            mycommand.CommandType = CommandType.StoredProcedure;
            mycommand.CommandText = Procedurename;
            mycommand.Parameters.AddWithValue("@Party_Phone", TXT_Phone.Text.Trim());
            mycommand.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            mycommand.Parameters.AddWithValue("@Address", TXT_delivery_Address.Text.Trim());
            mycommand.Parameters.AddWithValue("@Contact_Person_Name", TXT_Person.Text.Trim());
            mycommand.Parameters.AddWithValue("@Party_Id", ddlCompnay.SelectedValue);
            con.Open();
            mycommand.ExecuteScalar();

            con.Close();

        }
        catch (Exception ex)
        {


        }
    }




    private string GetPersonLevel(string sendTo)
    {
        string retVal = string.Empty;
        string level = sendTo;
        int indx = 0;
        indx = level.IndexOf("(");
        if (indx != -1)
        {
            retVal = level.Substring(indx + 1);
            retVal = retVal.Replace(")", "");
        }

        return retVal;
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

    protected void txtPack_TextChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvRow in GridView1.Rows)
        {
            TextBox pack = (TextBox)gvRow.FindControl("txtPack");
            TextBox unitPack = (TextBox)gvRow.FindControl("txtUnitsPack");
            TextBox qty = (TextBox)gvRow.FindControl("TextBox1");
            qty.Text = (Convert.ToInt32(pack.Text) * Convert.ToInt32(unitPack.Text)).ToString();
        }
    }
    protected void txtUnitsPack_TextChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gvRow in GridView1.Rows)
        {
            TextBox pack = (TextBox)gvRow.FindControl("txtPack");
            TextBox unitPack = (TextBox)gvRow.FindControl("txtUnitsPack");
            TextBox qty = (TextBox)gvRow.FindControl("TextBox1");
            qty.Text = (Convert.ToInt32(pack.Text) * Convert.ToInt32(unitPack.Text)).ToString();
        }
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

    protected void Button_Close_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
    }
    protected void ddlFromOffice_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListStore.SelectedValue = ddlFromOffice.SelectedValue;
        Button1_Click(sender, e);
    }

    protected void ddlCompnay_SelectedIndexChanged1(object sender, EventArgs e)
    {
        loadPartyDetail();
    }
}