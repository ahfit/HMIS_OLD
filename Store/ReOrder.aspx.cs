
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_ReOrder : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
    String conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            loadSavedItems();
            getSubDepartments();

            ddlSubDept.SelectedValue = Session["SubDeptId"].ToString();

            bindCategory();
            bindSubCategory();
            GetSubDepartmentsForSend();
        }


    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        BindGrid();
        Addbtn.Visible = true;
    }


    private void bindSubCategory()
    {
        con.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("select '--- All ---' as [Generic_Name] ,0 as [G_N_Id] union SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id)", con);
            cmd.Parameters.AddWithValue("@Cat_Id", ddlCategory.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "Generic_Name";
            ddlSubCategory.DataValueField = "G_N_Id";
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataBind();
            con.Close();
            
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }
    private void getSubDepartments()
    {
        con.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("select SubDept_Id, SubDept_Name from SubDepartment where Subdept_Id='"+Session["SubDeptId"]+"' ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubDept.DataSource = dt;
            ddlSubDept.DataTextField = "SubDept_Name";
            ddlSubDept.DataValueField = "SubDept_Id";

            ddlSubDept.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }

    private void bindCategory()
    {
        con.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("SELECT  0 as Item_Type_Id, '--- All ---' as Item_Type union SELECT  Item_Type_Id, Item_Type FROM Store_Item_Types where IS_Pharmacy =0", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "Item_Type";
            ddlCategory.DataValueField = "Item_Type_Id";
            ddlCategory.DataSource = dt;
            ddlCategory.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }


    private void BindGrid()
    {
        DbManager manager = new DbManager();
        SqlParameter[] par = {

            new SqlParameter("@itemName",txtItemName.Text),
            new SqlParameter("@Category",ddlCategory.SelectedValue),
            new SqlParameter("@subCategory",ddlSubCategory.SelectedValue),
            new SqlParameter("@specification",txtSpecification.Text),
            new SqlParameter("@SubDeptId",ddlSubDept.SelectedValue),
            new SqlParameter("@SendToDept",ddlSendTo.SelectedValue)
            };

        DataTable dt = manager.ExecuteDataTable("Usp_Get_Reorder", "STOREConnectionString", par);

        gridview.DataSource = dt;
        gridview.DataBind();

    }

    private void loadSavedItems()
    {
        DbManager manager = new DbManager();
        SqlParameter[] par = {

            new SqlParameter("@EmpId",Session["Emp_Id"].ToString()),
            new SqlParameter("@SubDeptId",Session["SubDeptId"].ToString())
            };

        DataTable dt = manager.ExecuteDataTable("Usp_Get_SavedItems", "STOREConnectionString", par);

        if (dt.Rows.Count > 0)
        {
            GridViewSavedItems.DataSource = dt;
            GridViewSavedItems.DataBind();
            if (Request.QueryString["BT"] == "REQ")
            {
                btnDemand.Visible = true;
            }
            else if (Request.QueryString["BT"] == "DEM")
            {

                btnGenrate.Visible = true;
            }
        }
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code, Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
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

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubCategory();
    }

    protected void btnUpdate_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btn = sender as ImageButton;

        TextBox lblPar_Level = (TextBox)btn.NamingContainer.FindControl("lblParLevel");
        TextBox lblMin_Level = (TextBox)btn.NamingContainer.FindControl("lblMinLevel");
        TextBox lblMax_Level = (TextBox)btn.NamingContainer.FindControl("lblMaxLevel");


        using (SqlConnection connection = new SqlConnection(conString))
        {
            SqlCommand command = new SqlCommand("Usp_UpdateDepartmentWiseParLevel", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@itemCode", btn.CommandArgument);
            command.Parameters.AddWithValue("@prlevel", lblPar_Level.Text);
            command.Parameters.AddWithValue("@minlevel", lblMin_Level.Text);
            command.Parameters.AddWithValue("@maxlevel", lblMax_Level.Text);
            command.Parameters.AddWithValue("@entryby", Session["Emp_ID"]);
            command.Parameters.AddWithValue("@categoryid", ddlCategory.SelectedValue);
            command.Parameters.AddWithValue("@subcategoryid", ddlSubCategory.SelectedValue);
            command.Parameters.Add("@remarks", SqlDbType.Int).Direction = ParameterDirection.Output;

            command.Parameters.AddWithValue("@subdeptid", ddlSubDept.SelectedValue);


            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
            if (command.Parameters["@remarks"].Value.ToString() == "1")
            {
                lblNewMsg.Visible = true;
                lblNewMsg.ForeColor = System.Drawing.Color.Green;
                lblNewMsg.Text = "  Updated Successfully!";

            }

        }
    }

    protected void chkboxall_CheckedChanged(object sender, EventArgs e)
    {
        GridViewRow row = gridview.HeaderRow;
        CheckBox chkboxall = row.FindControl("chkboxall") as CheckBox;

        foreach (GridViewRow gv in gridview.Rows)
        {

            CheckBox chkbox = gv.FindControl("chkbox") as CheckBox;

            if (chkboxall.Checked == true)
            {
                chkbox.Checked = true;
            }
            else
            {
                chkbox.Checked = false;
            }


        }

    }

    protected void Addbtn_Click(object sender, EventArgs e)
    {
        int ItemErrorCount = 0;
        int CountCheckboxes = 0;
        int subdeptId = Convert.ToInt32(Session["SubDeptId"].ToString());
        int empId = Convert.ToInt32(Session["Emp_Id"].ToString());

        foreach (GridViewRow gv in gridview.Rows)
        {

            CheckBox chk = gv.FindControl("chkbox") as CheckBox;

            if (chk.Checked == true)
            {
                CountCheckboxes = CountCheckboxes = 1;

                HiddenField itemcode = gv.FindControl("hfitemcode") as HiddenField;
                TextBox maxlevel = gv.FindControl("lblMaxLevel") as TextBox;
                Label lblstock = gv.FindControl("lblStock") as Label;

                int max = Convert.ToInt32(maxlevel.Text);
                int stock = Convert.ToInt32(lblstock.Text);

                int orderqty = (max - stock);

                if (orderqty > 0)
                {
                    int countAlreadySaved = 0;
                    int countnewSaved = 0;
                    using (SqlConnection connection = new SqlConnection(conString))
                    {
                        SqlCommand command = new SqlCommand("Usp_ReOrder_DemandSave", connection);
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@EmpId", empId);
                        command.Parameters.AddWithValue("@SubDeptId", subdeptId);
                        command.Parameters.AddWithValue("@ItemCode", itemcode.Value.ToString());
                        command.Parameters.AddWithValue("@OrderQty", orderqty);

                        command.Parameters.Add("@remarks", SqlDbType.Int).Direction = ParameterDirection.Output;
                        connection.Open();
                        command.ExecuteNonQuery();
                        connection.Close();

                        if (command.Parameters["@remarks"].Value.ToString() == "0")
                        {
                            countnewSaved = countnewSaved + 1;

                        }
                        else if(command.Parameters["@remarks"].Value.ToString() == "1")
                        {
                            countAlreadySaved = countAlreadySaved + 1;
                        }

                    }
                    if (countAlreadySaved > 0)
                    {
                        lblNewMsg.Visible = true;
                        lblNewMsg.Font.Size = 10;
                        lblNewMsg.ForeColor = System.Drawing.Color.Green;
                        if (countnewSaved > 0)
                        {
                            lblNewMsg.Text = countnewSaved +" Items Added Succesfully and " +countAlreadySaved  +" Items are already added";
                        }
                        else
                        {

                            lblNewMsg.ForeColor = System.Drawing.Color.Red;
                            lblNewMsg.Text = " Items are already added";
                        }

                    }
                    else
                    {
                        lblNewMsg.Visible = true;
                        lblNewMsg.Font.Size = 10;
                        lblNewMsg.ForeColor = System.Drawing.Color.Green;
                        lblNewMsg.Text = countnewSaved + " Items Added Succesfully! "; 
                    }
                }
                else
                {
                    ItemErrorCount = ItemErrorCount + 1;
                }
            }
        }
        if (ItemErrorCount > 0)
        {
            lblNewMsg.Visible = true;
            lblNewMsg.ForeColor = System.Drawing.Color.DarkOrange;
            lblNewMsg.Font.Size = 10;
            lblNewMsg.Text = ItemErrorCount + " Items are not added! Stock Must be less than Max Level";
        }
        if(CountCheckboxes==0)
        {

            lblNewMsg.Visible = true;
            lblNewMsg.ForeColor = System.Drawing.Color.Red;
            lblNewMsg.Font.Size = 10;
            lblNewMsg.Text ="Please select atleast One Item.";
        }
        loadSavedItems();

    }

    protected void itemname_Click(object sender, EventArgs e)
    {
        LinkButton lb = sender as LinkButton;
        int itemcode = Convert.ToInt32(lb.CommandArgument);
        DbManager manager = new DbManager();
        SqlParameter[] par = {

            new SqlParameter("@Item_Code",itemcode),
            
            new SqlParameter("@SubDeptID",ddlSubDept.SelectedValue)
            };

        DataTable dt = manager.ExecuteDataTable("uspGetPreviousMonthsItemConsumption", "STOREConnectionString", par);
        
        Gridview_Consumption.DataSource = dt;
        Gridview_Consumption.DataBind();
        panelbox.Visible = true;
    }

    protected void closbtn_Click(object sender, EventArgs e)
    {
        panelbox.Visible = false;
    }
    private void GetSubDepartmentsForSend()
    {
        using (SqlConnection connection = new SqlConnection(conString))
        {
            SqlCommand command = new SqlCommand("select SubDept_Id,SubDept_Name from SubDepartment Where SubDept_Name like '%Store%'", connection);
            SqlDataAdapter adot = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            adot.Fill(dt);
            ddlSendTo.DataSource = dt;
           
            ddlSendTo.DataTextField = "SubDept_Name";
            ddlSendTo.DataValueField = "SubDept_Id";
            ddlSendTo.DataBind();
           


        }
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        pnlGen.Visible = false;
    }

    protected void btnGenerateNewDemand_Click(object sender, EventArgs e)
    {
            //insertMain();
            //hdfNewDemandNo.Value = "";
            //hdfYearlyCounter.Value = "";
            //txtRemarks.Text = "";
            //pnlGen.Visible = false;
            //lblDemandMsg.Visible = true;
            //lblDemandMsg.Font.Size = 10;
            //lblDemandMsg.ForeColor = System.Drawing.Color.Green;
            //lblDemandMsg.Text = " Demand Generated Succesfully! ";
            //GridViewSavedItems.Visible = false;
            //btnGenrate.Visible = false;
    }
    public void getCounter()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Demand_Requisition_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        //command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", ddlSubDept.SelectedValue);
        int count;

        try
        {
            count = (int)command1.ExecuteScalar();
            hdfYearlyCounter.Value = count.ToString();

        }
        catch (Exception ex)
        {
            count = 1;
        }
        con.Close();
        int len = count.ToString().Length;
        hdfNewDemandNo.Value = "D" + DateTime.Today.Year + "-";
        while (len < 5)
        {
            hdfNewDemandNo.Value += "0";
            len++;
        }
        hdfNewDemandNo.Value += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
    }
    private void insertMain()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@Demand_RQ_ID",hdfNewDemandNo.Value), new SqlParameter("@Yearly_Counter", hdfYearlyCounter.Value),
                             new SqlParameter("@From_Dept_ID",Session["dept_id"]),new SqlParameter("@From_Sub_Dept_ID",Session["SubDeptID"]),
                             new SqlParameter("@To_Sub_Dept_ID",ddlSendTo.SelectedValue),new SqlParameter("@Date_Time",DateTime.Now),
                             new SqlParameter("@Emp_ID",Session["Emp_id"]),new SqlParameter("@Description",txtRemarks.Text),
                             new SqlParameter("@ShiftID",Session["ShiftID"]),
                             new SqlParameter("@id","12"),new SqlParameter("@Is_Approved","false")};
        dbm.ExecuteNonQuery("usp_GenerateDemand_Requisition", "STOREConnectionString", sp);
        
    }


    protected void btnGenrate_Click(object sender, EventArgs e)
    {
        getCounter();
        //pnlGen.Visible = true;
        GetSubDepartmentsForSend();
        //forwardRequisition();
        insertMain();
        hdfNewDemandNo.Value = "";
        hdfYearlyCounter.Value = "";
        txtRemarks.Text = "";
       // pnlGen.Visible = false;
        lblDemandMsg.Visible = true;
        lblDemandMsg.Font.Size = 10;
        lblDemandMsg.ForeColor = System.Drawing.Color.Green;
        lblDemandMsg.Text = "Demand Requisition Generated Succesfully! ";
        GridViewSavedItems.Visible = false;
        btnUpdateQty.Visible = false;
        btnGenrate.Visible = false;
    }

    protected void forwardRequisition()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", hdfNewDemandNo.Value),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id",  ddlSubDept.SelectedValue),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks", ""),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateDemandApprovalRequest", "STOREConnectionString", sqlParm);

    }

    protected void forwardDemand()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", Labeb_Requisition_No.Text),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id", ddlSubDept.SelectedValue),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks",""),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateQuotationApprovalRequest", "STOREConnectionString", sqlParm);

    }
    public void getCounterforDem()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
       
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Store_Indent_Book_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE()))  AND (From_Sub_Dept_ID = @From_Sub_Dept_ID) and (LEFT(IB_ID,3) = 'IPO' and emp_id = @Emp_ID )", con);
        //command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID",ddlSubDept.SelectedValue);
        command1.Parameters.AddWithValue("@Emp_id", Session["emp_id"]);
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
        Labeb_Requisition_No.Text = "IPO" + DateTime.Today.Year + "-" + Session["Emp_id"].ToString() + "-";
        while (len < 5)
        {
            Labeb_Requisition_No.Text += "0";
            len++;
        }
        Labeb_Requisition_No.Text += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
        HiddenField_counter.Value = Labeb_Requisition_No.Text;



    }

    private void insertDemand()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@Demand_RQ_ID",HiddenField_counter.Value), new SqlParameter("@Yearly_Counter", HiddenField_YearlyCounter.Value),
                             new SqlParameter("@From_Dept_ID",Session["dept_id"]),new SqlParameter("@From_Sub_Dept_ID",Session["SubDeptID"]),
                             new SqlParameter("@To_Sub_Dept_ID",ddlSendTo.SelectedValue),new SqlParameter("@Date_Time",DateTime.Now),
                             new SqlParameter("@Emp_ID",Session["Emp_id"]),new SqlParameter("@Description",txtRemarks.Text),
                             new SqlParameter("@ShiftID",Session["ShiftID"]),
                             new SqlParameter("@id","12"),new SqlParameter("@Is_Approved","false")};
        dbm.ExecuteNonQuery("usp_GenerateDemand_ReOrder", "STOREConnectionString", sp);

    }
    protected void btnDemand_Click(object sender, EventArgs e)
    {
        //pnlGen.Visible = true;
        btnGenerateNewDemand.Visible = false;
        btnInternal.Visible = true;
        GetSubDepartmentsForSend();
        getCounterforDem();
        insertDemand();
        //forwardDemand();
        lblDemandMsg.Visible = true;
        lblDemandMsg.Text = "Internal Requisition Generated Successfully";
        GridViewSavedItems.Visible = false;
        btnUpdateQty.Visible = false;
        btnDemand.Visible = false;
    }

    protected void lnkConsumption_Click(object sender, EventArgs e)
    {
        LinkButton lnkConsumption = sender as LinkButton;
        string ICode = lnkConsumption.CommandArgument;
        Response.Redirect("~/store/demad/ConsumptionAgingReport.aspx?ICode=" + ICode);
    }

    protected void delbtn_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton btndel=sender as ImageButton;
        DbManager dbmgr = new DbManager();
        SqlParameter[] par =
        {
            new SqlParameter("@id",btndel.CommandArgument)
        };
        dbmgr.ExecuteDataTableWithQuery("Delete from Departmental_Reorder_Saved where id=@id", "STOREConnectionString", par);
        loadSavedItems();
    }
    protected void btnInternal_Click(object sender, EventArgs e)
    {
        //getCounterforDem();
        //insertDemand();
        //forwardDemand();
        //lblDemandMsg.Visible = true;
        //lblDemandMsg.Text = "Demand Generated Successfully";
        //btnDemand.Visible = false;
    }
    protected void btnUpdateQty_Click(object sender, EventArgs e)
    {
        DbManager db = new DbManager();
        
        foreach (GridViewRow gv in GridViewSavedItems.Rows)
        {
            HiddenField hfItemId = gv.FindControl("hfItemId") as HiddenField;
            TextBox orderqty = gv.FindControl("orderqty") as TextBox;
            SqlParameter[] para={
                                    new SqlParameter("@Id",hfItemId.Value),
                                    new SqlParameter("@Qty",orderqty.Text)
                                };
            db.ExecuteDataTableWithQuery("Update Departmental_Reorder_Saved set Order_Quantity=@Qty where Id=@Id", "STOREConnectionString", para);

            lblDemandMsg.Visible = true;
            lblDemandMsg.Font.Size = 10;
            lblDemandMsg.ForeColor = System.Drawing.Color.Green;
            lblDemandMsg.Text = " Quantity Updated Succesfully! ";

        }

    }
}