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
using System.Collections.Generic;

public partial class Store_Demand_Requisition : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();

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
        Response.Write(str);
    }


    public string getmedicine(TreeNode obj, string str, string cat, string med_name)
    {
        SqlConnection con1 = new SqlConnection(connection1);
        con1.Open();
        SqlCommand command1 = new SqlCommand("Select_Store_Item", con1);
        command1.CommandType = CommandType.StoredProcedure;
        command1.Parameters.AddWithValue("@category", str);
        command1.Parameters.AddWithValue("@Dept_Id", ddlDepartment.SelectedValue);
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
    public bool checkalreadyinserted(string str)
    {
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command = new SqlCommand("SELECT item_Request_Track.* FROM item_Request_Track WHERE (Demand_RQ_ID = '" + str + "')", con);
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
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Demand_Requisition_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", ddlFromOffice.SelectedValue);
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
        //if (count == 1)
        //{
        //    count = 0000 + count;
        //    HiddenField_YearlyCounter.Value = count.ToString();
        //}
        int len = count.ToString().Length;
        Labeb_Requisition_No.Text = "D" + DateTime.Today.Year + "-";
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
                TextBox_specificMedicine.Visible = false;

            }
            else
            {
                SqlDataSource_Medicine_Main.Insert();
            }

        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            //DDL_Hospital.SelectedValue = "4";

            validate("", "");
            HiddenField_Dept_ID.Value = Session["SubDeptId"].ToString();
            HiddenField_Emp_ID.Value = Session["emp_id"].ToString();
            GridView1.DataBind();
            ddlFromOffice.DataBind();
            
            //ddlFromOffice.Enabled = false;
            ddlDepartment.DataBind();
            DropDownListStore.DataBind();
            ddlCompnay.DataBind();
            DropDownList_Budget.DataBind();
            LoadBalance();
            label_Budget.Text = "";
            Check_IB_ID();
            if(String.IsNullOrEmpty(Labeb_Requisition_No.Text))
            {
                ddlFromOffice.SelectedValue = Session["SubDeptId"].ToString();
            }
            
            ddlCompnay.Items.Insert(0, new ListItem("Select Company", "0"));
            DropDownList_Category.DataBind();
            DropDownList_Category.Items.Insert(0, new ListItem("----- All -----", "0"));


        }
        if (IsPostBack)
        {
            // Check_IB_ID();
        }

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
                SqlDataSource_Medicine_Sub.Delete();
                SqlDataSourceDelete_Sub.Delete();
                SqlDataSource_Medicine_Main.Delete();
                Label1.Text = "This Requisition RoleBacked";
                Label1.Visible = true;
                HiddenField_counter.Value = "";
                Labeb_Requisition_No.Text = "";
                Button_update_QTY.Visible = false;
                Button4.Visible = false;
                Button7.Visible = false;
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
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
           
            HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
            TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");

            TextBox txtQty, txtQtyPacks, txtUnitsPerPack;
            txtQty = GridView1.Rows[i].FindControl("txtQtyPacks") as TextBox;
            txtQtyPacks = GridView1.Rows[i].FindControl("txtPacks") as TextBox;
            txtUnitsPerPack = GridView1.Rows[i].FindControl("txtUnitPack") as TextBox;
            TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("txtUnitRate");
            TextBox TextBox_Discount = (TextBox)GridView1.Rows[i].FindControl("txtDiscount");
            TextBox TextBox_Total = (TextBox)GridView1.Rows[i].FindControl("txtTotal");
            HiddenField_Med_Qty.Value = txtQty.Text;
            HiddenField_Med_Code.Value = code.Value;
            hfldUnits.Value = txtQtyPacks.Text;
            hfldQtyPerUnit.Value = txtUnitsPerPack.Text;
            HiddenField_Specification.Value = TextBox_Specification.Text;
            SqlDataSource_Medicine_Sub.UpdateParameters["Item_Rate"].DefaultValue = TextBox_Rate.Text;
            SqlDataSource_Medicine_Sub.UpdateParameters["Discount"].DefaultValue = TextBox_Discount.Text;
            SqlDataSource_Medicine_Sub.UpdateParameters["Total"].DefaultValue = TextBox_Total.Text;
            try
            {

                SqlDataSource_Medicine_Sub.Update();
            }
            catch (Exception ex)
            {
                string str = ex.ToString();
                Response.Write(str);
            }
        }
        //SqlDataSource_Medicine_Main.Update();
        GridView1.DataBind();
    }

    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        double total = 0;
        double accDiscount = 0;
        double finalPrice = 0;
        double t = 0;
        if (GridView1.Rows.Count > 0)
        {
            DropDownListStore.Enabled = false;
            ddlFromOffice.Enabled = false;
            TextBox totalAmonut = new TextBox();
            TextBox Qty = new TextBox();
            TextBox Rate = new TextBox();
            foreach (GridViewRow row in GridView1.Rows)
            {
                ImageButton ImageButton2 = row.FindControl("ImageButton2") as ImageButton;
                if (GridView1.Rows.Count == 1)
                {
                    ImageButton2.Visible = false;
                }
                else
                {
                    ImageButton2.Visible = true;
                }
                totalAmonut = row.FindControl("txtTotal") as TextBox;
                Qty = row.FindControl("txtQtyPacks") as TextBox;
                Rate = row.FindControl("txtUnitRate") as TextBox;
                t = Convert.ToDouble(Qty.Text) * Convert.ToDouble(Rate.Text);
                if (t == 0.0)
                {
                    totalAmonut.Text = (t).ToString();
                }
                else
                {
                    totalAmonut.Text = (t).ToString("#,##.##");
                }
                total += Convert.ToDouble(totalAmonut.Text);
            }
            Label gtotal = GridView1.FooterRow.FindControl("lblGrandTotal") as Label;
            gtotal.Text = total.ToString("#,#.##");
            accDiscount = Convert.ToDouble(txtAccDiscount.Text);
            accDiscount = (total * Convert.ToDouble(txtAccDiscount.Text)) / 100;
            finalPrice = total - accDiscount;
            txtGrandTotal.Text = finalPrice.ToString("#,#.##");

        }
        else
        {
            DropDownListStore.Enabled = true;
            ddlFromOffice.Enabled = true;
        }
    }
   
    protected void Button4_Click(object sender, EventArgs e)
    {
        if (checkApprovalAth() > 0)
        {
            lblApprovalAuthorityMsg.Text = "";
            forwardDemand();
            submitDemand();
        }
        else
        {
            lblApprovalAuthorityMsg.Text = "Approval Authorities not found for your department";
        }
    }
    
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (TextBox_specificMedicine.Text == "")
        {
            HF_Item_Name.Value = "%";
        }
        else
        {
            HF_Item_Name.Value = "%" + TextBox_specificMedicine.Text + "%";
        }
        
        
        GridViewMedicine.DataBind();
        GridViewMedicine.Visible = true;
        // TreeView1.Visible = true;

        //getspecificMedicine();
    }
    protected void btnItem_Click(object sender, EventArgs e)
    {
        LinkButton btnTemp = sender as LinkButton;
        String itemCode = btnTemp.CommandArgument.ToString();
        Double itemRate = 0;
        int itemQty = 0;
        GridViewRow gvRow = btnTemp.NamingContainer as GridViewRow;
        TextBox txtQty = gvRow.FindControl("txtQty") as TextBox;
        TextBox txtCost = gvRow.FindControl("txtCost") as TextBox;
        if (txtQty.Text.Trim() == "")
        {
            itemQty = 1;
        }
        else
        {
            itemQty = Convert.ToInt32(txtQty.Text);
        }
        if (txtCost.Text.Trim() == "")
        {
            itemRate = 0;
        }
        else
        {
            itemRate = Convert.ToDouble(txtCost.Text);
        }
        double balance=Convert.ToDouble(lblBalance.Text);
        double alreadyAdd = 0;
        if (itemQty > 0 && itemRate >= 0)
        {
            //if(balance>0)
            //{
                if (GridView1.Rows.Count > 0)
                {
                    foreach(GridViewRow gvR in GridView1.Rows)
                    {
                        TextBox txtGQty = (TextBox)gvR.FindControl("txtQtyPacks");
                        TextBox txtGRate = (TextBox)gvR.FindControl("txtUnitRate");
                        alreadyAdd = alreadyAdd + (Convert.ToInt32(txtGQty.Text) * Convert.ToDouble(txtGRate.Text));
                    }
                }
                //if(((itemRate*itemQty)+alreadyAdd)<=balance)
                //{
                    insertItem(itemCode, itemRate, itemQty);

                //}
                //else
                //{
                  //  label_Budget.Text = "Cannot add due to exceed balance limit";
                //}
           // }
           // else
           // {

           // }
            
            txtQty.Text = "1";
            //txtCost.Text = "0";
            Button7.Visible = true;
        }
        else
        {
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
                    SqlDataSource_Medicine_Main.InsertParameters["Demand_RQ_ID"].DefaultValue = HiddenField_counter.Value.ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["Yearly_Counter"].DefaultValue = HiddenField_YearlyCounter.Value.ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["From_Dept_ID"].DefaultValue = Session["Dept_id"].ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["From_Sub_Dept_ID"].DefaultValue = ddlFromOffice.SelectedValue.ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["To_Sub_Dept_ID"].DefaultValue = DropDownListStore.SelectedValue.ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["Date_Time"].DefaultValue = DateTime.Now.ToString("yyyy-MM-dd");
                    SqlDataSource_Medicine_Main.InsertParameters["Emp_ID"].DefaultValue = Session["emp_id"].ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["Request_Priority"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["When_Required"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["ShiftID"].DefaultValue = Session["ShiftID"].ToString();
                    SqlDataSource_Medicine_Main.InsertParameters["Reg_No"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["Yearly_NO"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["Description"].DefaultValue = TextBox_Requsition_Description.Text;
                    SqlDataSource_Medicine_Main.InsertParameters["Company_ID"].DefaultValue = "";
                    //SqlDataSource_Medicine_Main.InsertParameters["id"].DefaultValue = "12";
                    //SqlDataSource_Medicine_Main.InsertParameters["Is_Approved"].DefaultValue = Convert.ToBoolean(0);
                    SqlDataSource_Medicine_Main.InsertParameters["SO_ID"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["Remarks"].DefaultValue = "";
                    SqlDataSource_Medicine_Main.InsertParameters["Type"].DefaultValue = "Demand";

                    //SqlDataSource_Medicine_Main.InsertParameters["Is_Completed"].DefaultValue = "0";
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
                SqlDataSource_Medicine_Sub.InsertParameters["Type"].DefaultValue = "Demand";
                SqlDataSource_Medicine_Sub.Insert();
                GridView1.DataBind();

            }
            else
            {
                //   Response.Write("else part");
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Qty"].DefaultValue = itemQty.ToString();
                SqlDataSource_Medicine_Sub.InsertParameters["Item_Rate"].DefaultValue = itemRate.ToString();
                HiddenField_Specification.Value = "";
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

    protected void GridViewMedicine_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            HiddenField_Med_Code.Value = Convert.ToString(GridViewMedicine.SelectedValue);

            Label1.Visible = false;

            if (HiddenField_counter.Value == "")
            {
                getCounter();
                try
                {
                    SqlDataSource_Medicine_Main.Insert();
                }
                catch (Exception ex)
                {
                    string str = ex.ToString();
                    HiddenField_counter.Value = "";
                    Labeb_Requisition_No.Text = "";
                }
                SqlDataSource_Medicine_Sub.Insert();
                GridView1.DataBind();

            }
            else
            {
                SqlDataSource_Medicine_Sub.Insert();
            }
        }
        catch (Exception ex)
        {
            string str = ex.ToString();
            Response.Write(str);
        }
        GridView1.DataBind();
        Response.Write(GridView1.Rows.Count.ToString());
        if (GridView1.Rows.Count != 0)
        {

            Response.Write("PnlVisible true");
            //Button_update_QTY.Visible = true;
            Button5.Visible = true;
            //Button4.Visible = true;
        }
    }

    public void Check_IB_ID()
    {
        //Response.Write((int)Session["Dept_Id"]);
        //if ((int)Session["Dept_Id"] == )
        //{

        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        SqlCommand command_IB_ID = new SqlCommand("SELECT     Demand_RQ_ID, Company_ID,To_Sub_Dept_ID,From_Sub_Dept_ID, Remarks, Delivery_Site, Delivery_Address, Contact_Person, Contact_No, Acc_Discount,BudgetHead, GST, WHTax, ITax, OtherTax FROM Demand_Requisition_Main WHERE (ShiftID = @ShiftID) AND (Demand_RQ_ID NOT IN (SELECT IB_ID FROM Item_Request_Track WHERE (By_Dept_ID = @bysubdept))) AND (From_Dept_ID = @DeptID) AND (From_Sub_Dept_ID = @SubDeptID)", con);

        command_IB_ID.Parameters.AddWithValue("@DeptID", Session["dept_id"]);
        command_IB_ID.Parameters.AddWithValue("@bysubdept", HiddenField_Dept_ID.Value);

        command_IB_ID.Parameters.AddWithValue("@SubDeptID", ddlFromOffice.SelectedValue);
        command_IB_ID.Parameters.AddWithValue("@ShiftID", Session["ShiftID"]);

        SqlDataReader reader = command_IB_ID.ExecuteReader();
        if (reader.HasRows)
        {
            reader.Read();
            HiddenField_counter.Value = reader["Demand_RQ_ID"].ToString();
            //ddlCompnay.SelectedValue = reader["Company_ID"].ToString();
            //TXT_DeliverySite.Text = reader["Delivery_Site"].ToString();
            //TXT_delivery_Address.Text = reader["Delivery_Address"].ToString();
            //TXT_Person.Text = reader["Contact_Person"].ToString();
            //TXT_Phone.Text = reader["Contact_No"].ToString();
            //TextBox_Requsition_Description.Text = reader["Remarks"].ToString();
            //txtAccDiscount.Text = reader["Acc_Discount"].ToString();
            //TXT_GST.Text = reader["GST"].ToString();
            //TXT_WHT.Text = reader["WHTax"].ToString();
            //TXT_IT.Text = reader["ITax"].ToString();
            //TXT_oTHER.Text = reader["OtherTax"].ToString();
            ddlFromOffice.SelectedValue = reader["From_Sub_Dept_ID"].ToString();
            DropDownListStore.SelectedValue = reader["To_Sub_Dept_ID"].ToString();
            Labeb_Requisition_No.Text = HiddenField_counter.Value;
            //DropDownList_Budget.SelectedValue = reader["BudgetHead"].ToString();
            //DropDownList_Budget.Enabled = false;
        }
        // Response.Write("None");
        reader.Close();
        con.Close();
    }


    protected void LinkButton1_Click(object sender, EventArgs e)
    {
    }
    //XMLGeneratation ds = new XMLGeneratation();
    //XMLGeneratationTableAdapters.Patient_Basic_InfoTableAdapter daPatient_Basic_Info = new XMLGeneratationTableAdapters.Patient_Basic_InfoTableAdapter();

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {
            HiddenField_Med_Code.Value = Convert.ToString(e.CommandArgument);//GridView1.Rows[indx].Cells[5].Text;//hid_item_code.Value;
            //Response.Write(HiddenField_Med_Code.Value);
            SqlDataSource_Medicine_Sub.Delete();
            GridView1.DataBind();
            //Response.End();
        }
    }


   

    protected void Button_Report_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            TextBox qty = (TextBox)GridView1.Rows[i].FindControl("txtQtyPacks");
            HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
            TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");
            TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("txtUnitRate");
            TextBox TextBox_Discount = (TextBox)GridView1.Rows[i].FindControl("txtDiscount");
            TextBox TextBox_Total = (TextBox)GridView1.Rows[i].FindControl("txtTotal");
            HiddenField_Med_Qty.Value = qty.Text;
            HiddenField_Med_Code.Value = code.Value;
            HiddenField_Specification.Value = TextBox_Specification.Text;

            try
            {
                SqlDataSource_Medicine_Sub.UpdateParameters["Item_Rate"].DefaultValue = TextBox_Rate.Text;
                SqlDataSource_Medicine_Sub.UpdateParameters["Discount"].DefaultValue = TextBox_Discount.Text;
                SqlDataSource_Medicine_Sub.UpdateParameters["Total"].DefaultValue = TextBox_Total.Text;
                SqlDataSource_Medicine_Sub.Update();
            }
            catch (Exception ex)
            {
                string str = ex.ToString();

            }
        }
        SqlDataSource_Medicine_Main.Update();
        GridView1.DataBind();
        Response.Redirect("Demand_Requisition_Report.aspx?RequsitionNo=" + HiddenField_counter.Value.ToString());
    }
    protected void DropDownList_Department_SelectedIndexChanged(object sender, EventArgs e)
    {
        Check_IB_ID();
        DropDownListStore.DataBind();
        //fillTree("", "%");
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
            ddlCompnay.DataBind();
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

    protected void txtPacks_TextChanged(object sender, EventArgs e)
    {
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        TextBox txtPacks, txtUnitPacks, txtQty;
        txtPacks = gvRow.FindControl("txtPacks") as TextBox;
        txtUnitPacks = gvRow.FindControl("txtUnitPack") as TextBox;
        txtQty = gvRow.FindControl("txtQtyPacks") as TextBox;
        double packs, unitPacks, Qty;
        if (txtPacks.Text.Trim() != "")
        {
            if (double.TryParse(txtPacks.Text, out packs) && double.TryParse(txtUnitPacks.Text, out unitPacks) && double.TryParse(txtQty.Text, out Qty))
            {
                Qty = packs * unitPacks;
                txtQty.Text = Qty.ToString();
                txtUnitPacks.Focus();
            }
        }
        else
        {
            txtPacks.Text="1";
        }

        //TextBox txtQtyPacks, txtRate, TextDiscount,total;
        //txtQtyPacks = gvRow.FindControl("txtQtyPacks") as TextBox;
        //txtRate = gvRow.FindControl("txtUnitRate") as TextBox;
        //TextDiscount= gvRow.FindControl("txtDiscount") as TextBox;
        //total = gvRow.FindControl("txtTotal") as TextBox;
        //if (txtQtyPacks.Text.Trim() != "")
        //{
        //    if (double.TryParse(txtQtyPacks.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(TextDiscount.Text, out discount))
        //    {
        //        total.Text = Convert.ToString((units * rateUnit) - discount);
        //        txtRate.Focus();
        //    }
        //}
        //else
        //{
        //    txtQtyPacks.Text = "1";
        //}
        

    }

    protected void txtUnitsPerPack_TextChanged(object sender, EventArgs e)
    {
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        TextBox txtPacks, txtUnitPacks, txtQty;
        txtPacks = gvRow.FindControl("txtPacks") as TextBox;
        txtUnitPacks = gvRow.FindControl("txtUnitPack") as TextBox;
        txtQty = gvRow.FindControl("txtQtyPacks") as TextBox;
        double packs, unitPacks, Qty;
        if (txtUnitPacks.Text.Trim() != "")
        {
            if (double.TryParse(txtPacks.Text, out packs) && double.TryParse(txtUnitPacks.Text, out unitPacks) && double.TryParse(txtQty.Text, out Qty))
            {
                Qty = packs * unitPacks;
                txtQty.Text = Qty.ToString();
                txtQty.Focus();
            }
        }
        else
        {
            txtUnitPacks.Text = "1";
        }
        //double units, rateUnit, discount;
        //TextBox tbox = sender as TextBox;
        //GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        //TextBox txtQtyPacks, txtRate, TextDiscount, total;
        //txtQtyPacks = gvRow.FindControl("txtQtyPacks") as TextBox;
        //txtRate = gvRow.FindControl("txtUnitRate") as TextBox;
        //TextDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        //total = gvRow.FindControl("txtTotal") as TextBox;
        //if (txtRate.Text.Trim() != "")
        //{
        //    if (double.TryParse(txtQtyPacks.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(TextDiscount.Text, out discount))
        //    {
        //        total.Text = Convert.ToString((units * rateUnit) - discount);
        //        //TextDiscount.Focus();
        //    }
        //}
        //else
        //{
        //    txtRate.Text = "0";
        //}
        
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListStore.DataBind();
    }
    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {

        double units, rateUnit, discount, dAmount, gTotal=0;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;

        TextBox txtQtyPacks, txtRate, TextDiscount, total;
        txtQtyPacks = gvRow.FindControl("txtQtyPacks") as TextBox;
        txtRate = gvRow.FindControl("txtUnitRate") as TextBox;
        TextDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        total = gvRow.FindControl("txtTotal") as TextBox;
        if (TextDiscount.Text.Trim() != "")
        {
            if (double.TryParse(txtQtyPacks.Text, out units) && double.TryParse(txtRate.Text, out rateUnit) && double.TryParse(TextDiscount.Text, out discount))
            {
                dAmount = (units * rateUnit) * discount / 100;
                total.Text = Convert.ToString((units * rateUnit) - dAmount);
                txtAccDiscount.Focus();
            }
        }
        else
        {
            TextDiscount.Text = "0";
        }


    }
    protected void BtnSearchParty_Click(object sender, EventArgs e)
    {
        
        int count = 0;
        SqlConnection con_Party = new SqlConnection(connection1);
        con_Party.Open();
        SqlCommand command_Party = new SqlCommand("select Count(*) from parties where party_name like '%'+@P_Name+'%'", con_Party);
        command_Party.Parameters.AddWithValue("@P_Name", TXT_Party_Name.Text.Trim());

        count = Convert.ToInt32(command_Party.ExecuteScalar());
        if (count > 0)
        {
            

            LBL_Rec_MSG.Text =" ( "+ count.ToString() + " Record(s) found )";
            Hf_PARTY_NAME.Value = "%" + TXT_Party_Name.Text.Trim() + "%";
            ddlCompnay.DataBind();
        }
        else
        {
            LBL_Rec_MSG.Text = "No Record Found";
            Hf_PARTY_NAME.Value = "%";

        }
    }
    protected void txtAccDiscount_TextChanged(object sender, EventArgs e)
    {
        double grandTotal = 0, finalPrice = 0, accDiscount = 0 ;
        Label lblgt = GridView1.FooterRow.FindControl("lblGrandTotal") as Label;
        grandTotal = Convert.ToDouble(lblgt.Text.Trim());
        accDiscount = Convert.ToDouble(txtAccDiscount.Text.Trim());
        if (accDiscount > 0)
        {
            finalPrice = (grandTotal * accDiscount) / 100;
            txtGrandTotal.Text = (grandTotal-finalPrice).ToString();
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
    protected void LoadBalance()
    {
        try
        {
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString);
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
            lblBalance.Text = "0";//command.Parameters["@amount"].Value.ToString();
            if (string.IsNullOrEmpty(lblBalance.Text.Trim()))
            {
                lblBalance.Text = "0";

            }
            con.Close();
        }
        catch(Exception ex)
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
    protected void btnForward_Click(object sender, EventArgs e)
    {
        forwardDemand();
        submitDemand();
    }
    protected void bindForwardTo()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@SubDeptID", Session["SubDeptId"]),new SqlParameter("@CurrentDemandAmount", "0")};
        DataTable dt = new DataTable();
        dt = dbMgr.ExecuteDataTable("uspGetDemandAuthority", "STOREConnectionString", sqlParm);
        if(dt.Rows.Count>0)
        {
            ddlForwardTo.DataSource = dt;
            ddlForwardTo.DataBind();
        }
        else
        {
            lblForwardMsg.Visible = true;
            btnForward.Visible = false;
        }
        
    }
    protected void submitDemand()
    {
        try
        {

            SqlDataSource_Medicine_Main.Update();
        }
        catch (Exception ex)
        {
            string str = ex.ToString();

        }

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {

            HiddenField code = (HiddenField)GridView1.Rows[i].FindControl("HiddenField1");
            TextBox TextBox_Specification = (TextBox)GridView1.Rows[i].FindControl("TextBox_Specification");

            TextBox txtQty, txtQtyPacks, txtUnitsPerPack;
            txtQty = GridView1.Rows[i].FindControl("txtQtyPacks") as TextBox;
            txtQtyPacks = GridView1.Rows[i].FindControl("txtPacks") as TextBox;
            txtUnitsPerPack = GridView1.Rows[i].FindControl("txtUnitPack") as TextBox;

            TextBox TextBox_Rate = (TextBox)GridView1.Rows[i].FindControl("txtUnitRate");
            TextBox TextBox_Discount = (TextBox)GridView1.Rows[i].FindControl("txtDiscount");
            TextBox TextBox_Total = (TextBox)GridView1.Rows[i].FindControl("txtTotal");
            HiddenField_Med_Qty.Value = txtQty.Text;
            HiddenField_Med_Code.Value = code.Value;
            hfldUnits.Value = txtQtyPacks.Text;
            hfldQtyPerUnit.Value = txtUnitsPerPack.Text;
            HiddenField_Specification.Value = TextBox_Specification.Text;

            SqlDataSource_Medicine_Sub.UpdateParameters["Item_Rate"].DefaultValue = TextBox_Rate.Text;
            SqlDataSource_Medicine_Sub.UpdateParameters["Discount"].DefaultValue = TextBox_Discount.Text;
            SqlDataSource_Medicine_Sub.UpdateParameters["Total"].DefaultValue = TextBox_Total.Text;
            int checkint = Convert.ToInt32(HiddenField_Med_Qty.Value);

            if (checkint > 0)
            {
                try
                {

                    SqlDataSource_Medicine_Sub.Update();
                }
                catch (Exception ex)
                {
                    string str = ex.ToString();

                }
            }
            else
            {
                try
                {
                    SqlDataSource_Submit.Delete();
                }
                catch (Exception ex)
                {
                    string str = ex.ToString();
                }
            }
        }
        GridView1.DataBind();
        try
        {

            {
                SqlDataSource_Submit.Insert();
                SqlDataSourceApprove.Insert();//Button4.Visible = true;
                Response.Redirect("Demand_Requisition_Report.aspx?RequsitionNo=" + Labeb_Requisition_No.Text + "&PID=" + ddlCompnay.SelectedValue);
            }
        }

        catch (Exception ex)
        {
            string str = ex.ToString();
            //Response.Write(str);
            Label_Message.Text = "Requisition Already Submited";
        }
    }

    protected void btnClosePanel_Click(object sender, EventArgs e)
    {
        pnlForward.Visible = false;
    }
    protected void forwardDemand()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", Labeb_Requisition_No.Text),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id", ddlFromOffice.SelectedValue),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks", txtForwardRemarks.Text),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateDemandApprovalRequest", "STOREConnectionString",sqlParm);

    }
    private string GetPersonLevel()
    {
        string retVal = string.Empty;
        string level = ddlForwardTo.SelectedItem.Text;
        int indx = 0;
        indx = level.IndexOf("(");
        if (indx != -1)
        {
            retVal = level.Substring(indx + 1);
            retVal = retVal.Replace(")", "");
        }

        return retVal;
    }
    protected int checkApprovalAth()
    {
        int i = 0;
        String query = "Select ISNULL(Count(*),0) Cou From Approval_Authority_For_Demand Where SubDeptId=@SubDeptId";
        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@SubDeptId", ddlFromOffice.SelectedValue) };
        DataTable dt = dbm.ExecuteDataTableWithQuery(query, "STOREConnectionString", sp);
        if (dt.Rows.Count > 0)
        {
            i = Convert.ToInt32(dt.Rows[0][0].ToString());
        }
        return i;
    }

}