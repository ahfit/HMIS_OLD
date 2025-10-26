using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

public partial class Finance_PostVoucher : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_Reciept.Value = DateTime.Now;
            bindFinancialCompany();
            bindFinancialYear();
            //DDL_Finacial_Year.SelectedValue = "7";
            ddlFinancialComapny.SelectedValue = Session["Financial_Company_Id"].ToString();
            bindCompanyBranch();
            ddlBranch.SelectedValue = Session["Company_Branch_Id"].ToString();
            bindAccountHead();
            createDataTable();
            loadVourcherType();
            loadCostCenter();
        }
    }
    private void bindFinancialCompany()
    {
        SqlParameter[] para = { };
        DataTable dt = execDataTablewithQuery("SELECT [Financial_Company_Id], [Financial_Company_Name] FROM [Group_Financial_Companies] ORDER BY [Financial_Company_Name]", conStr, para);
        ddlFinancialComapny.DataSource = dt;
        ddlFinancialComapny.DataBind();

    }
    private void bindFinancialYear()
    {
        SqlParameter[] para = { };
        DataTable dt = execDataTablewithQuery("select Financial_Year_Id,Financial_Year from Financial_Year", conStr, para);
        DDL_Finacial_Year.DataSource = dt;
        DDL_Finacial_Year.DataBind();
        DDL_Finacial_Year.SelectedValue = "10";
    }
    private void bindCompanyBranch()
    {

        SqlParameter[] para = { new SqlParameter("@Financial_Company_Id", ddlFinancialComapny.SelectedValue) };
        DataTable dt = execDataTablewithQuery("SELECT Company_Branch_Id, Company_Branch_Name FROM Group_Company_Branches WHERE (Financial_Company_Id = @Financial_Company_Id)", conStr, para);
        ddlBranch.DataSource = dt;
        ddlBranch.DataBind();

    }
    private void bindAccountHead()
    {

        SqlParameter[] para = { };
        DataTable dt = execDataTablewithQuery("SELECT   E_Code,E_Name + ' (' + E_Code +')' as E_Name FROM Expenditure Where E_Code<>0  ORDER BY E_Code desc , E_Name", conStr, para);
        ddlAccountHead.DataSource = dt;
        ddlAccountHead.DataBind();
        bindParties();
    }
    protected void ddlAccountHead_SelectedIndexChanged(object sender,EventArgs e)
    {
        bindParties();
    }
    private void bindParties()
    {
        //debator e Code 33302
        //creditr e Code 22101
        //advance to staff  e Code 33301
        //sale Non Gst  e Code 41101
        //sale Gst  e Code 41104
        DataTable dt=new DataTable();
        //if (ddlAccountHead.SelectedValue == "33302") //for debator
        //{
        //    SqlParameter[] para = { new SqlParameter("Name1", "Customer"), new SqlParameter("Name2", "Both") };
        //    dt = execDataTablewithQuery("select Party_Id,Party_Name from Parties where Party_Type is not null and ( Party_Type like '%'+@Name1+'%' or Party_Type like '%'+@Name2+'%')", conStr, para);
        //}
        if (ddlAccountHead.SelectedValue == "2201001") //for creditor
        {
            SqlParameter[] para = { new SqlParameter("Name1", "Vendor"), new SqlParameter("Name2", "Both") };
            dt = execDataTablewithQuery("select Party_Id,Party_Name from Parties", conStr, para);
        }
        else if (ddlAccountHead.SelectedValue == "3303003" || ddlAccountHead.SelectedValue == "3303004" || ddlAccountHead.SelectedValue == "3303005") //for Advance to staff
        {
            SqlParameter[] para = { };
            dt = execDataTablewithQuery("select Party_Id,Party_Name from Parties where   Party_Type='Customer'", conStr, para);
        }

       
        DDL_Parties.DataSource = dt;
        DDL_Parties.DataBind();
        if (dt.Rows.Count > 0)
        {
            DDL_Parties.Visible = true;
        }
        else
        {
            DDL_Parties.Visible = false;
        }
    }


    protected void btnSearch_Click(object sender,EventArgs e)
    {
         SqlParameter[] para = {new SqlParameter("@Search",txtHeadName.Text) };
         DataTable dt = execDataTablewithQuery("select E_Code,E_Name + ' (' + E_Code +')' as E_Name from expenditure where E_Code<>'0' and (E_Name + ' (' + E_Code +')' like '%'+@Search+'%' or E_Name + ' (' + E_Code +')' like '%'+@Search+'%')", conStr, para);
        ddlAccountHead.DataSource = dt;
        ddlAccountHead.DataBind();
        bindParties();
    }
    private DataTable execDataTablewithQuery(string query, string conString, SqlParameter[] para)
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        DataTable dt = new DataTable();
        try
        {
            con.Open();
            cmd = new SqlCommand(query, con);
            foreach (SqlParameter param in para)
            {
                cmd.Parameters.Add(param);
            }
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            return dt;
        }
        catch (Exception ex)
        {
            lblMsg2.Text = ex.ToString();
            return null;
        }
        finally
        {
            con.Close();
        }
    }


    protected void btnSave_Click(object sender,EventArgs e)
    {
        Label dr = (Label)GridView1.FooterRow.FindControl("lblTotalDr");
        Label cr = (Label)GridView1.FooterRow.FindControl("lblTotalCr");
        if (Convert.ToDouble(dr.Text) == Convert.ToDouble(cr.Text))
        {
            insert_Main();
        }
        else
        {
                
        }
    }


    protected void btnAdd_Click(object sender, EventArgs e)
    { 
        int party = 0;
        string party_name = "";
        try
        {
            DataTable dt = (DataTable)Session["dt"];
            string cheque_Date = "";
            if (WebDateChooser_CheqDate.Value!=null)
            {
                cheque_Date = WebDateChooser_CheqDate.Value.ToString();   
            }
          
            lblMsg.Visible = false;
            if (DDL_Parties.Visible==true)
            {
                party = Convert.ToInt32(DDL_Parties.SelectedValue);
                party_name=DDL_Parties.SelectedItem.Text;
            }
            //int party_id = 0;
            //if (DDL_Parties.SelectedItem.Text)
            //{ }
            //string costcenterid = "";
            //if (ddlCostCenter.SelectedValue=="0")
            //{
            //    costcenterid = "";
            //}
            //else
            //{
            //    costcenterid = ddlCostCenter.SelectedValue;
            //}

            dt.Rows.Add(GridView1.Rows.Count + 1, Convert.ToInt32(ddlFinancialComapny.SelectedValue), Convert.ToInt32(ddlBranch.SelectedValue),
                WebDateChooser_Reciept.Value, Convert.ToInt32(DropDownList_VoucherType.SelectedValue), Convert.ToInt32(ddlAccountHead.SelectedValue), ddlAccountHead.SelectedItem.Text + " ( " + party_name+ " ) ",
                party, txtCheque.Text, cheque_Date, Convert.ToInt32(txtAmount.Text), Convert.ToInt32(DDL_CreditType.SelectedValue), txtDescription.Text, ddlCostCenter.SelectedValue, ddlCostCenter.SelectedItem.Text.Trim());
            GridView1.DataSource = dt;
            GridView1.DataBind();
            Session.Add("dt", dt);
            if (GridView1.Rows.Count > 0)
            {
                btnSave.Visible = true;
                ddlFinancialComapny.Enabled = false;
                ddlBranch.Enabled = false;
                DropDownList_VoucherType.Enabled = false;
                DDL_Finacial_Year.Enabled = false;
            }
            else
            {
                btnSave.Visible = false;
            }
           

        }
        catch (Exception ex)
        {
            lblMsg2.Text=ex.ToString();
        }

    }

    private void createDataTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Id", typeof(Int64));
        dt.Columns.Add("Company_Id", typeof(Int64));
        dt.Columns.Add("Branch_Id", typeof(Int64));
        dt.Columns.Add("Date", typeof(DateTime));
        dt.Columns.Add("Voucher", typeof(Int64));
        dt.Columns.Add("Head_Id", typeof(Int64));
        dt.Columns.Add("Head_Name", typeof(string));
        dt.Columns.Add("Party_Id", typeof(string));
        dt.Columns.Add("Cheque", typeof(string));
        dt.Columns.Add("Cheque_Date", typeof(string));
        dt.Columns.Add("Amount", typeof(Int64));
        dt.Columns.Add("Dr", typeof(Int64));
        dt.Columns.Add("Description", typeof(string));
        dt.Columns.Add("CostCenter", typeof(Int64));
        dt.Columns.Add("CostCenterName", typeof(string));


        Session.Add("dt", dt);
    }

    protected void lbtnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lbtn = (LinkButton)sender;
            DataTable dt = (DataTable)Session["dt"];
            dt.Rows[Convert.ToInt32(lbtn.CommandArgument) - 1].Delete();
            Session.Add("dt", dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (GridView1.Rows.Count > 0)
            {
                btnSave.Visible = true;
            }
            else
            {
                btnSave.Visible = false;
            }
        }
        catch (Exception ex)
        {
            lblMsg2.Text = ex.ToString();
        }
    }



    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        int dr = 0, cr = 0;
        foreach (GridViewRow row in GridView1.Rows)
        {
            Label lbldr = (Label)row.FindControl("lblDr");
            Label lblcr= (Label)row.FindControl("lblCr");

            if (lbldr.ToolTip == "1")
            {
                lbldr.Text = lblcr.ToolTip;
                lblcr.Text = "0";
            }
            else if (lbldr.ToolTip == "2")
            {
                lblcr.Text=lblcr.ToolTip;
                lbldr.Text = "0";
            }
            if (lbldr.ToolTip=="1")
            {
                dr = dr + Convert.ToInt32(lblcr.ToolTip);
            }
            else if (lbldr.ToolTip == "2")
            {
                cr = cr + Convert.ToInt32(lblcr.ToolTip);
            }
        }
        if (GridView1.Rows.Count>0)
        {
            Label lblTotalDr = (Label)GridView1.FooterRow.FindControl("lblTotalDr");
            Label lblTotalCr = (Label)GridView1.FooterRow.FindControl("lblTotalCr");
            lblTotalDr.Text = dr.ToString();
            lblTotalCr.Text = cr.ToString();
            if (dr == cr)
            {
                btnSave.Visible = true;
            }
            else
            {
                btnSave.Visible = false;
            }
        }
    }
  
    public void insert_Main()
    {
        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("usp_InsertVoucherMain", con);
        cmd.CommandType =CommandType.StoredProcedure;
        con.Open();
        cmd.Parameters.AddWithValue("@Account_No", DropDownList_VoucherType.SelectedValue);
        cmd.Parameters.AddWithValue("@For_Date", WebDateChooser_Reciept.Value);
        cmd.Parameters.AddWithValue("@Voucher_Type", DropDownList_VoucherType.SelectedItem.Text);
        cmd.Parameters.AddWithValue("@EmpID", Session["emp_id"]);
        cmd.Parameters.AddWithValue("@DeptID", Session["dept_id"]);
        cmd.Parameters.AddWithValue("@Party_ID", 0);
        cmd.Parameters.AddWithValue("@Financial_Company_Id", ddlFinancialComapny.SelectedValue);
        cmd.Parameters.AddWithValue("@Company_Branch_Id", ddlBranch.SelectedValue);
        cmd.Parameters.AddWithValue("@Financial_Year_Id", DDL_Finacial_Year.SelectedValue);
        cmd.Parameters.AddWithValue("@costcenterid", ddlCostCenter.SelectedValue);
        
        
        cmd.Parameters.Add("@Voucher_Trans_ID", System.Data.SqlDbType.Int);
        cmd.Parameters["@Voucher_Trans_ID"].Direction = System.Data.ParameterDirection.Output;


  
        //requestis

        try
        {
            cmd.ExecuteNonQuery();

            string value = cmd.Parameters["@Voucher_Trans_ID"].Value.ToString();

         
            con.Close();
            insertDetailData(Convert.ToInt32(cmd.Parameters["@Voucher_Trans_ID"].Value.ToString()));
            ddlFinancialComapny.Enabled = true;
            ddlBranch.Enabled = true;
            DropDownList_VoucherType.Enabled = true;
            bindAccountHead();
            txtHeadName.Text = "";
            txtCheque.Text = "0";
            txtAmount.Text = "0";
            Session.Remove("dt");
            createDataTable();
            GridView1.DataBind();
            btnSave.Visible = false;
            lblMsg.Text = "Voucher Saved Successfully.......";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Visible = true;

            Session.Add("VTI", value);
            //string MyVar = Session[""].ToString();

            Response.Redirect("~/Finance/CReport_Recipt_Voucher.aspx");
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            lblMsg.Text = "Error Saving Voucher .......";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Visible = true;
        }

    }
    protected void insertDetailData(int vId)
    {
        SqlConnection con = new SqlConnection(conStr);
       
        con.Open();
        DataTable dtable=(DataTable)Session["dt"];
        foreach (DataRow dr in dtable.Rows)
        {
            SqlCommand cmd = new SqlCommand("usp_InsertVoucherSub", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Voucher_Trans_Id", vId);
            cmd.Parameters.AddWithValue("@Account_Head_id", dr["Head_Id"]);
            cmd.Parameters.AddWithValue("@Amount", dr["Amount"]);
            cmd.Parameters.AddWithValue("@Cr_Dr_Action_Id", dr["Dr"]);
            cmd.Parameters.AddWithValue("@Party_ID", dr["Party_Id"]);
            cmd.Parameters.AddWithValue("@SubDeptID", Session["SubDeptid"]);
            cmd.Parameters.AddWithValue("@Cheque_No", dr["Cheque"]);
            cmd.Parameters.AddWithValue("@Cheque_Date", dr["Cheque_Date"]);
            cmd.Parameters.AddWithValue("@Description", dr["Description"]);
            cmd.Parameters.AddWithValue("@costcenterid", dr["CostCenter"]);
            try
            {
                cmd.ExecuteNonQuery();                
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
        }
        con.Close();
    }
    protected void ddlFinancialComapny_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindCompanyBranch();
    }



    private void loadVourcherType() {

        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("SELECT  Voucher_Type_ID,Voucher_Type_Name      FROM [Voucher_Types] where isnull(IsActive,1) = 1 ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);

        DropDownList_VoucherType.DataSource = dt;
        DropDownList_VoucherType.DataBind();

    
    }


    private void loadCostCenter() {

        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("select CostCenterID,MainCostCenter + ' --> '  + CostCenterName as CostCenterName from costcenter order by MainCostCenter asc ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        
        ddlCostCenter.DataSource = dt;
        ddlCostCenter.DataBind();
    

    
    }



    

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchHead(string prefixText, int count)
    {

        List<string> customers = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select E_Code,E_Name + ' (' + E_Code + ')' as E_Name from expenditure where E_Code<>0 and (E_Name like '%'+@pretext+'%' or E_Code like '%'+@pretext+'%')";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@pretext", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["E_Name"].ToString(), (sdr["E_Code"].ToString())));
        }
        return customers;


    }





}