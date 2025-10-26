using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_DepartmentWiseParLevels : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
    String conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            bind_Categories();
            bindSubCategory();
            bindSubdepartment();
            GetSubDepartmentsForSend();
            loadDefaultButtons();
        }
    }
    public void loadDefaultButtons()
    {
        if (!String.IsNullOrEmpty(Request.QueryString["BT"]) && GridView1.Rows.Count>0)
        {
            if (Request.QueryString["BT"] == "REQ")
            {
                btnGenrate.Visible = true;
                btnDemand.Visible = false;
            }
            else
            {
                btnGenrate.Visible = false;
            }
            if (Request.QueryString["BT"] == "DEM")
            {
                btnDemand.Visible = true;
                btnGenrate.Visible = false;
            }
            else
            {
                btnDemand.Visible = false;
            }
        }
        else
        {
            btnGenrate.Visible = false;
            btnDemand.Visible = false;
        }
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
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
    private void bindSubCategory()
    {
        con.Open();
        try
        {
            SqlCommand cmd;
            cmd = new SqlCommand("select '--- All ---' as [Generic_Name] ,0 as [G_N_Id] union SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id or @Cat_Id=0)", con);

            //cmd = new SqlCommand("SELECT 'All' [Generic_Name], 0 as  [G_N_Id] UNION SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id or @Cat_Id=0)", con);
            cmd.Parameters.AddWithValue("@Cat_Id", ddl_Category.SelectedValue);
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
    private void FillGridView()
    {
            DataTable dt = new DataTable();
           dt = getgrid_Data();
            GridView1.DataSource = dt;
            GridView1.DataBind();  
    }
    protected void bindSubdepartment()
    {
        
        if (Session["Emp_ID"] != null)
        {
            String type = "Internal";
            if (Request.QueryString["BT"] == "REQ")
            {
                type = "Demand";
            }
            if (Request.QueryString["BT"] == "DEM")
            {
                type = "Internal";
            }
                DbManager dbMgr = new DbManager();
                String query = "Select	 upper(SD.SubDept_Name) SubDept_Name, SD.SubDept_Id From requisition_department_filter RDF Join SubDepartment SD On RDF.Main_Subdept_ID = SD.SubDept_Id WHERE(RDF.sub_Subdept_ID = @SubDept_Id) and(RDF.Requisition_Type = @Type) and(RDF.EmpID = @EmpID) ";
                //"Select SubDept_Id,SubDept_Name From SubDepartment   Order By SubDept_Name -- Where SubDept_Name like  @SubDept_Name";
                SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Id", Session["SubDeptId"]), new SqlParameter("@EmpID", Session["Emp_ID"]),
                                            new SqlParameter("@Type",type)};
                ddl_Department.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
                ddl_Department.DataTextField = "SubDept_Name";
                ddl_Department.DataValueField = "SubDept_Id";
                ddl_Department.DataBind();
        }
        else
        {
            Response.Redirect("~/Login.aspx");
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(conString);
        
        try
        {
            FillGridView();
            loadDefaultButtons();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
        
       
    }
    protected void bind_Categories()
    {
        SqlCommand cmd;
        try
        {
            con.Open();
            try
            {
                cmd = new SqlCommand("SELECT  0 as Item_Type_Id, '--- All ---' as Item_Type union select Item_Type_Id, Item_Type FROM Store_Item_Types where IS_Pharmacy = 0  order by Item_Type", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl_Category.DataSource = dt;
                ddl_Category.DataTextField = "Item_Type";
                ddl_Category.DataValueField = "Item_Type_Id";
                ddl_Category.DataSource = dt;
                ddl_Category.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {
                con.Close();
            }
        }
        catch (Exception ex)
        {
        }
    }

    //protected void btnUpdate_Click(object sender, ImageClickEventArgs e)
    //{
    
    //    ImageButton btn = sender as ImageButton;
       
    //    TextBox lblPar_Level = (TextBox)btn.NamingContainer.FindControl("lblPar_Level");
    //    TextBox lblRe_Order = (TextBox)btn.NamingContainer.FindControl("lblRe_Order");
    //    TextBox lblMin_Level = (TextBox)btn.NamingContainer.FindControl("lblMin_Level");
    //    TextBox lblMax_Level = (TextBox)btn.NamingContainer.FindControl("lblMax_Level");

    //    HiddenField hfdsubdeptid = (HiddenField)btn.NamingContainer.FindControl("hfdsubdeptid");
    //    HiddenField lblCategoryid = (HiddenField)btn.NamingContainer.FindControl("hfdCategoryid");
    //    //DropDownList  DDLdeptid = (DropDownList)btn.NamingContainer.FindControl("DDLDept");
    //    //Label lblMax_Level = (Label)btn.NamingContainer.FindControl("HfIsAdditional");

    //    using (SqlConnection connection = new SqlConnection(conString))
    //    {
    //        SqlCommand command = new SqlCommand("UpdateDepartmentWiseParLevel", connection);
    //        command.CommandType = CommandType.StoredProcedure;
    //        command.Parameters.AddWithValue("@itemCode",btn.CommandArgument);
    //        command.Parameters.AddWithValue("@prlevel",lblPar_Level.Text);
    //        command.Parameters.AddWithValue("@reorder",lblRe_Order.Text);
    //        command.Parameters.AddWithValue("@minlevel",lblMin_Level.Text);
    //        command.Parameters.AddWithValue("@maxlevel", lblMax_Level.Text);
    //      //  command.Parameters.AddWithValue("@subdeptid", hfdsubdeptid.Value);
    //        command.Parameters.AddWithValue("@entryby", Session["Emp_ID"]);
    //        //command.Parameters.AddWithValue("@categoryid", lblCategoryid.Value);
    //        command.Parameters.AddWithValue("@categoryid", ddl_Category.SelectedValue);
    //        command.Parameters.AddWithValue("@subcategoryid", ddlSubCategory.SelectedValue);
    //        command.Parameters.Add("@Remarks", SqlDbType.Int).Direction = ParameterDirection.Output;
    //        command.Parameters.AddWithValue("@subdeptid", ddl_Department.SelectedValue); 

            
    //        connection.Open();
    //        command.ExecuteNonQuery();
    //        lblNewMsg.Visible = true;
    //        connection.Close();
    //        if (command.Parameters["@Remarks"].Value.ToString() == "1")
    //        {
    //            lblNewMsg.ForeColor = System.Drawing.Color.Red;
    //            lblNewMsg.Text = "Already Exists For This Department";
               
              

    //        }
    //        else if (command.Parameters["@Remarks"].Value.ToString() == "0")
    //        {
              
    //            lblNewMsg.ForeColor = System.Drawing.Color.Green;
    //            lblNewMsg.Text = "Saved Successfully!";
               
    //        }
    //    }
      
    //}
    protected void ddl_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubCategory();
    }
    private void ShowGridData()
    {
        DataTable dt = new DataTable();
        dt = getgrid_Data();
        GridView1.DataSource = dt;
        GridView1.DataBind();
    }
    protected DataTable getgrid_Data()
    {
        String ty = "";
        if(!String.IsNullOrEmpty(Request.QueryString["BT"]))
        {
            ty = Request.QueryString["BT"];
        }
        DataTable dt = new DataTable();
        using (SqlConnection connection = new SqlConnection(conString))
        {
            if (Session["SubDeptId"] != null)
            { 
            SqlCommand command = new SqlCommand("Select_DepartmentWiseParLevel", connection);
            command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command.Parameters.AddWithValue("@ItemName", txtItemName.Text);
            command.Parameters.AddWithValue("@categoryid", ddl_Category.SelectedValue);
            command.Parameters.AddWithValue("@subcategoryid", ddlSubCategory.SelectedValue);
            command.Parameters.AddWithValue("@subdeptid", ddl_Department.SelectedValue);
            command.Parameters.AddWithValue("@Specifications", txtSpecification.Text);
            command.Parameters.AddWithValue("@SendTo", ddlSendTo.SelectedValue);
            command.Parameters.AddWithValue("@Type", ty);
            sda.Fill(dt);
            GridView1.DataSource = dt;
            
            }
            else
            {
                Response.Redirect("~/Login.aspx");
            }
            return dt;
        }
       
    }
    private string GridViewSortDirection
    {
        get { return ViewState["SortDirection"] as string ?? "DESC"; }
        set { ViewState["SortDirection"] = value; }
    }

    private string ConvertSortDirectionToSql(SortDirection sortDirection)
    {
        switch (GridViewSortDirection)
        {
            case "ASC":
                GridViewSortDirection = "DESC";
                break;

            case "DESC":
                GridViewSortDirection = "ASC";
                break;
        }

        return GridViewSortDirection;
    }
    private void GetSubDepartmentsForSend()
    {
        using (SqlConnection connection = new SqlConnection(conString))
        {
            String name = "STORE";
            SqlCommand command = new SqlCommand("select SubDept_Id,SubDept_Name from SubDepartment Where SubDept_Name like '%'+@Name+'%' order by SubDept_Name", connection);
            command.Parameters.AddWithValue("@Name", name);
            SqlDataAdapter adot = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            adot.Fill(dt);
            ddlSendTo.DataSource = dt;

            ddlSendTo.DataTextField = "SubDept_Name";
            ddlSendTo.DataValueField = "SubDept_Id";
            ddlSendTo.DataBind();



        }
    }

    protected void btnGenrate_Click(object sender, EventArgs e)
    {
        getCounter();
        //forwardRequisition();
        insertMain();
        hdfNewDemandNo.Value = "";
        hdfYearlyCounter.Value = "";
        txtRemarks.Text = "";
        lblDemandMsg.Visible = true;
        lblDemandMsg.Font.Size = 10;
        lblDemandMsg.ForeColor = System.Drawing.Color.Green;
        lblDemandMsg.Text = " Requisition Generated Succesfully! ";
        GridView1.Visible = false;
        btnGenrate.Visible = true;
        Response.Redirect("~/Store/Demad/Demand_Requisition.aspx");
    }

    protected void btnDemand_Click(object sender, EventArgs e)
    {
        insertDemand();
        lblDemandMsg.Visible = true;
        lblDemandMsg.Text = "Demand Generated Successfully";
        btnDemand.Visible = true;
        if (!String.IsNullOrEmpty(lblNewMsg.Text))
        {
            Response.Redirect("IPO.aspx?Ty=MR&IB_ID=" + lblNewMsg.Text);
        }
    }
    public void getCounter()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        con.Open();
        SqlCommand command1 = new SqlCommand("SELECT ISNULL(MAX(Yearly_Counter), 0) + 1 AS NextID FROM Demand_Requisition_Main WHERE (DATEPART(yyyy, Date_Time) = DATEPART(yyyy, GETDATE())) AND (From_Sub_Dept_ID = @From_Sub_Dept_ID)", con);
        //command1.Parameters.AddWithValue("@From_Dept_ID", Session["dept_id"]);
        command1.Parameters.AddWithValue("@From_Sub_Dept_ID", ddl_Department.SelectedValue);
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
        hdfNewDemandNo.Value = "PR-" + DateTime.Today.Year + "-";
        while (len < 5)
        {
            hdfNewDemandNo.Value += "0";
            len++;
        }
        hdfNewDemandNo.Value += count.ToString() + "-" + Session["dept_id"].ToString() + "-" + Session["SubDeptID"].ToString();
    }
    protected void forwardRequisition()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Requisition_ID", hdfNewDemandNo.Value),new SqlParameter("@Send_By", Session["emp_id"]),
                                    new SqlParameter("@Send_By_Sub_Dept_Id",  ddl_Department.SelectedValue),
                                    new SqlParameter("@Send_To_Sub_Dept_Id", "0"),new SqlParameter("@SendDate", DateTime.Now),
                                    new SqlParameter("@Requisition_Remarks", ""),new SqlParameter("@Parent_Approval_Request_Id", "0"),
                                    new SqlParameter("@Approved_Status", "Pending"),new SqlParameter("@Approved_Date", DBNull.Value.ToString()),
                                    new SqlParameter("@Request_Level", "1")};
        dbMgr.ExecuteNonQuery("uspCreateDemandApprovalRequest", "STOREConnectionString", sqlParm);
    }
    private void insertMain()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@Demand_RQ_ID",hdfNewDemandNo.Value), new SqlParameter("@Yearly_Counter", hdfYearlyCounter.Value),
                             new SqlParameter("@From_Dept_ID",Session["dept_id"]),new SqlParameter("@From_Sub_Dept_ID",Session["SubDeptID"]),
                             new SqlParameter("@To_Sub_Dept_ID",ddlSendTo.SelectedValue),new SqlParameter("@Date_Time",DateTime.Now),
                             new SqlParameter("@Emp_ID",Session["Emp_id"]),new SqlParameter("@Description",txtRemarks.Text),
                             new SqlParameter("@ShiftID",Session["ShiftID"]),
                             new SqlParameter("@id","12"),new SqlParameter("@Is_Approved","false"),
                             new SqlParameter("@xmlItems",getXML())};
        dbm.ExecuteNonQuery("usp_GenerateDemand_Requisition", "STOREConnectionString", sp);
    }
    private void insertDemand()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] sp = {new SqlParameter("@Demand_RQ_ID", SqlDbType.VarChar, 100, ParameterDirection.Output, false,0,0,"", DataRowVersion.Default, 0),
                             new SqlParameter("@From_Dept_ID",Session["dept_id"]),new SqlParameter("@From_Sub_Dept_ID",ddl_Department.SelectedValue),
                             new SqlParameter("@To_Sub_Dept_ID",ddlSendTo.SelectedValue),new SqlParameter("@Date_Time",DateTime.Now),
                             new SqlParameter("@Emp_ID",Session["Emp_id"]),new SqlParameter("@Description",txtRemarks.Text),
                             new SqlParameter("@ShiftID",Session["ShiftID"]),
                             new SqlParameter("@id","12"),new SqlParameter("@Is_Approved","false"),
                             new SqlParameter("@xmlItems",getXML())};
        dbm.ExecuteNonQuery("usp_GenerateDemand_ReOrder", "STOREConnectionString", sp);
        hdfNewDemandNo.Value = sp[0].Value.ToString();
        lblNewMsg.Text = hdfNewDemandNo.Value;
    }
    public String getXML()
    {
        String xmlString = "<table>";
        foreach(GridViewRow row in GridView1.Rows)
        {
            TextBox qty = (TextBox)row.FindControl("lbl_ReqQty");
            Label code = (Label)row.FindControl("lblItem_Code");
            TextBox min = (TextBox)row.FindControl("lblMin_Level");
            TextBox max = (TextBox)row.FindControl("lblMax_Level");
            CheckBox chk = (CheckBox)row.FindControl("chkBody");
            if(string.IsNullOrEmpty(min.Text))
            {
                min.Text = "0";
            }
            if (string.IsNullOrEmpty(max.Text))
            {
                max.Text = "0";
            }
            if (Convert.ToDouble(qty.Text)>0 && chk.Checked)
            {
                xmlString = xmlString + "<row><code>"+code.Text+"</code><qty>"+qty.Text+"</qty><min>"+min.Text+"</min><max>"+max.Text+"</max></row>";
            }
        }
        return xmlString+"</table>";
    }

    protected void chkHead_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox head = (CheckBox)sender;
        foreach(GridViewRow row in GridView1.Rows)
        {
            CheckBox chk = (CheckBox)row.FindControl("chkBody");
            if(head.Checked)
            {
                chk.Checked = true;
            }
            else
            {
                chk.Checked = false;
            }

        }
    }

    protected void lblMax_Level_TextChanged(object sender, EventArgs e)
    {
        TextBox txtMax = (TextBox)sender;
        GridViewRow row = (GridViewRow)txtMax.NamingContainer;
        Label lblStock = (Label)row.FindControl("lblStock");
        TextBox txtReqQty = (TextBox)row.FindControl("lbl_ReqQty");
        TextBox txtMin = (TextBox)row.FindControl("lblMin_Level");
        if(String.IsNullOrEmpty(txtMax.Text.Trim()))
        {
            txtMax.Text = "0";
        }
        if(String.IsNullOrEmpty(txtMin.Text.Trim()))
        {
            txtMin.Text = "0";
        }
        if(Convert.ToDecimal(txtMax.Text.Trim())>0 && Convert.ToDecimal(txtMin.Text.Trim())>Convert.ToDecimal(lblStock.Text))
        {
            txtReqQty.Text = (Convert.ToDecimal(txtMax.Text) - Convert.ToDecimal(lblStock.Text)).ToString();
        }

    }
}