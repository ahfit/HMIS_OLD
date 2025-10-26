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


public partial class Expenditure_Heads_Level_4 : CSharpClass
{

    
    protected void Button3_Click(object sender, EventArgs e)
    {
       
        try
        {
            if (Button3.Text.ToString() == "Save")
            {
                if(TextBox_E_Name.Text.Trim() != ""){

                   // SqlDataSource_expenditure.Insert();

                    try
                    {
                         String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
                        SqlConnection con = new SqlConnection(conStr);
                        SqlCommand cmd = new SqlCommand("USP_INSERTCHECKExpenditure", con);
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@E_Code", TextBox_E_Code.Text.ToString());
                        cmd.Parameters.AddWithValue("@E_Name", TextBox_E_Name.Text.ToString());
                        cmd.Parameters.AddWithValue("@ESH_Code", DropDownList_Sub_ESH_name.SelectedValue);
                        cmd.Parameters.AddWithValue("@E_Old_Code", TextBox_old_Code.Text.ToString());
                        cmd.Parameters.AddWithValue("@Control_Account", RBL_CA.SelectedValue);
                        cmd.Parameters.AddWithValue("@Budget_Head", RBL_BC.SelectedValue);
                        cmd.Parameters.AddWithValue("@Balance_sheet_ID", ddlbsnote.SelectedValue);
                        cmd.Parameters.AddWithValue("@PL_Account_Id", ddlplnote.SelectedValue);

                        cmd.Parameters.Add("@OUTPUT", SqlDbType.VarChar, 150);
                        cmd.Parameters["@OUTPUT"].Direction = ParameterDirection.Output;

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        lblMsg.Text = cmd.Parameters["@OUTPUT"].Value.ToString();
                        lblMsg.Visible = true;
                      //lblMsg.ForeColor = System.Drawing.Color.Green;
                        con.Close();
                        Button3.Focus();
                        GridView2.DataBind();
                    }
                    catch (Exception ex)
                    {
                        
                        throw;
                    }
                    
                    getclearData();
                }
            }
             else
            {
                String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
                SqlConnection con = new SqlConnection(conStr);
                SqlCommand cmd = new SqlCommand("UPDATE Expenditure SET Control_Account = @Control_Account, Budget_Head = @Budget_Head,Balance_sheet_ID = @Balance_sheet_ID, PL_Account_Id = @PL_Account_Id WHERE (Expenditure.E_Code=@E_Code)", con);

                cmd.Parameters.AddWithValue("@E_Code", hfid.Value);
                cmd.Parameters.AddWithValue("@Control_Account", RBL_CA.SelectedValue);
                cmd.Parameters.AddWithValue("@Budget_Head", RBL_BC.SelectedValue);
                cmd.Parameters.AddWithValue("@Balance_sheet_ID", ddlbsnote.SelectedValue);
                cmd.Parameters.AddWithValue("@PL_Account_Id", ddlplnote.SelectedValue);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "Head Updated Successfully!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Green;
                TextBox_E_Name.Focus();
                GridView2.DataBind();
                GridView2.Enabled = true;
                  btncancel.Visible = false;
                  Button3.Text = "Save";
                  getclearData();
             }
        }
        catch
        {
        }

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            loadBalanceSheet();
            loadProftlosstSheet();

            if (Convert.ToString(Session["emp_id"]) == "")
            {
                Response.Redirect("~/login.aspx");
            }
            else
            {
                GridView2.DataBind();
            }
           
        }
    }

    private void loadProftlosstSheet()
    {
        String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("Select 0 as ID,'' As Name from ProfitAndLossHeads PLH Union Select PLH.PL_Id as ID,'('+ISNULL(PLH.Main_Heading,'')+')-( '+ISNULL(PLH.Sub_Heading,'')+' )' As Name from ProfitAndLossHeads PLH", con);
        con.Open();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ddlplnote.DataSource = dt;
        ddlplnote.DataTextField = "Name";
        ddlplnote.DataValueField = "ID";
        ddlplnote.DataBind();
    }

    private void loadBalanceSheet()
    {
        String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("Select BSH.Balance_Sheet_Id as ID,'('+ISNULL(BSH.Main_Heading,'')+')-( '+ISNULL(BSH.Sub_Heading,'')+' )' As Name from Balance_Sheet_Heads BSH", con);
        con.Open();
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ddlbsnote.DataSource = dt;
        ddlbsnote.DataTextField = "Name";
        ddlbsnote.DataValueField = "ID";
        ddlbsnote.DataBind();
    }
    protected void DropDownList_level1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_Sub_EH_Name.DataBind();
        DropDownList_Sub_ESH_name.DataBind ();
        GridView2.DataBind (); 
    }
    protected void DropDownList_Sub_EH_Name_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_Sub_ESH_name.DataBind();
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList_level1.SelectedItem.Text.Contains("expen") || DropDownList_level1.SelectedItem.Text.Contains("equi"))
        {
            RBL_BC.SelectedValue = "1";
            RBL_BC.Enabled = false;
        }
        else
        {
            RBL_BC.SelectedValue = "0";
            RBL_BC.Enabled = true;
        }

        GridView2.DataBind(); 

    }
    protected void DropDownList_level1_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind();
    }
    protected void DropDownList_Sub_EH_Name_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_level1_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_EH_Name_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected Boolean checkAlreadyExists(string headValue, string headCode)
    {
        Boolean isExists = false;
        String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("uspCheckLevel4Head", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@E_Name", headValue.Trim().ToLower());
        cmd.Parameters.AddWithValue("@E_Code", headCode.Trim().ToLower());
        con.Open();
        SqlDataAdapter dr = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dr.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            String strValue = dt.Rows[0][1].ToString();
            String strCode = dt.Rows[0][0].ToString();
            if (strValue.Trim().ToLower() == headValue.Trim().ToLower() && strCode.Trim().ToLower() == headCode.Trim().ToLower())
            {
                isExists = true;
                lblMsg.Text = "Head Code and Head Name are already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                TextBox_E_Code.Focus();
            }
            else if (strValue.Trim().ToLower() == headValue.Trim().ToLower())
            {
                isExists = true;
                lblMsg.Text = "Head Name already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                TextBox_E_Name.Focus();
            }
            else
            {
                isExists = true;
                lblMsg.Text = "Head Code already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                TextBox_E_Code.Focus();
            }

        }
        else
        {
            isExists = false;
        }
        return isExists;
    }
    protected void btnlnkupdateSelect_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";

        if (string.IsNullOrEmpty(ddlbsnote.SelectedValue))
        {
            lblMsg.Text = "PLEASE SELECT BALANCE SHEET HEAD FIRST!!!!";
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
        else{
            LinkButton btn = (LinkButton)(sender);
            string ID = btn.CommandArgument;

            hfid.Value = ID.ToString();
            btn.ForeColor = System.Drawing.Color.Red;

            String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("SELECT E.E_Code, E.E_Name, E.ESH_Code, E.E_Old_Code,E.E_Code,E.E_Name,E.E_Old_Code,ISNULL(E.Control_Account,'') AS Control_Account,ISNULL(E.Budget_Head,'') as Budget_Head,ISNULL(BSH.Balance_Sheet_Id,0) as BSHID,'('+ISNULL(BSH.Main_Heading,'')+')-( '+ISNULL(BSH.Sub_Heading,'')+' )' As BSHName,ISNUll(PLH.PL_Id,0) as PLHID,'('+ISNULL(PLH.Main_Heading,'')+')-( '+ISNULL(PLH.Sub_Heading,'')+' )' As PLHName FROM Expenditure E left join Balance_Sheet_Heads BSH on E.Balance_sheet_ID=BSH.Balance_Sheet_Id left join ProfitAndLossHeads PLH on E.PL_Account_Id=PLH.PL_Id WHERE (E.E_Code = @E_Code)", con);
            cmd.Parameters.AddWithValue("@E_Code", ID.ToString());
            con.Open();
            SqlDataAdapter dr = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dr.Fill(dt);
            if (dt.Rows.Count > 0)
            {

                TextBox_E_Code.Text = dt.Rows[0]["E_Code"].ToString();
                TextBox_old_Code.Text = dt.Rows[0]["E_Old_Code"].ToString();
                TextBox_E_Name.Text = dt.Rows[0]["E_Name"].ToString();

                //RBL_CA.DataValueField = dt.Rows[0][""].ToString();

                RBL_CA.DataBind();
                RBL_CA.SelectedValue = dt.Rows[0]["Control_Account"].ToString();

                RBL_BC.DataBind();
                RBL_BC.SelectedValue = Convert.ToInt32(dt.Rows[0]["Budget_Head"]).ToString();

                hfblid.Value= dt.Rows[0]["BSHID"].ToString();
                

                if (hfblid.Value== "0")
                {
                    ddlbsnote.DataBind();
                    ddlbsnote.ClearSelection();
                    ListItem lst = new ListItem("", "0");
                    ddlbsnote.Items.Insert(0, lst);
                }
                else
                {
                    ddlbsnote.DataBind();
                    ddlbsnote.SelectedValue = dt.Rows[0]["BSHID"].ToString();
                }

                ddlplnote.DataBind();
                ddlplnote.SelectedValue = dt.Rows[0]["PLHID"].ToString();

                DropDownList_level1.Enabled = false;
                DropDownList_Sub_EH_Name.Enabled = false;
                DropDownList_Sub_ESH_name.Enabled = false;

                TextBox_E_Code.Enabled = false;
                TextBox_old_Code.Enabled = false;
                TextBox_E_Name.Enabled = false;
                Button3.Text = "Update";
                Button3.Focus();
                btncancel.Visible = true;
                GridView2.Enabled = false;
            
        }
        }
    }
  
    protected void btncancel_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        getclearData();
        GridView2.DataBind();
        Button3.Text = "Save";
        GridView2.Enabled = true;
        btncancel.Visible = false;
    }
    protected void btndelete_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        try
        {
             LinkButton btn = (LinkButton)(sender);
             string ID = btn.CommandName;


            String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("USP_DELETEFROMEXPENDITURE", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@E_Code", ID.ToString());

            cmd.Parameters.Add("@OUTPUT", SqlDbType.VarChar, 150);
            cmd.Parameters["@OUTPUT"].Direction = ParameterDirection.Output;

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            lblMsg.Text = cmd.Parameters["@OUTPUT"].Value.ToString();

            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
            con.Close();
            Button3.Focus();
            GridView2.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
        private void getclearData()
        {
            DropDownList_level1.Enabled = true;
            DropDownList_Sub_EH_Name.Enabled = true;
            DropDownList_Sub_ESH_name.Enabled = true;

            //DropDownList_level1.SelectedIndex = -1;
            //DropDownList_Sub_EH_Name.SelectedIndex = -1;
            //DropDownList_Sub_ESH_name.SelectedIndex = -1;

            RBL_CA.SelectedIndex = 0;
            RBL_BC.SelectedIndex = 0;
            ddlbsnote.SelectedIndex = -1;
            ddlplnote.SelectedIndex = -1;

            TextBox_E_Code.Enabled = true;
            TextBox_old_Code.Enabled = true;
            TextBox_E_Name.Enabled = true;

            TextBox_E_Code.Text = "";
            TextBox_old_Code.Text = "";
            TextBox_E_Name.Text = "";
        }
    }

    