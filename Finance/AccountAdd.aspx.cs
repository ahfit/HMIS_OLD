
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

public partial class Finance_AccountAdd : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindBank();
            bindBranch();
            bindAccountHead();
            bindGrid();
        }
    }

    private void bindAccountHead()
    {
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand(@"select E_Code,ISNULL(E_Name,'')+' '+ISNULL(E_Code,'') Name from Expenditure where E_Name like '%bank%'", con);

        DataSet ds = new DataSet();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        da.Fill(ds);
        ddl_AccountHead.DataSource = ds;
        ddl_AccountHead.DataValueField = "E_Code";
        ddl_AccountHead.DataTextField = "Name";
        ddl_AccountHead.DataBind();
    }

    private void bindBranch()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("SELECT   [Branch_ID],[Branch_Name] FROM [Finance].[dbo].[Bank_Branch] where Bank_Id=@bankid", con);
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@bankid", ddl_bank.SelectedValue);
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        DropDownList_Branch.DataSource = dt;
        DropDownList_Branch.DataBind();
        con.Close();
    }

    protected void bindBank()
    {
        SqlCommand cmd;
        string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conString);
        cmd = new SqlCommand("SELECT  [Bank_ID] ,[Bank_Name] ,[Bank_phone],[Address] FROM [Finance].[dbo].[Bank]", con);
        cmd.CommandType = CommandType.Text;
        con.Open();
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddl_bank.DataSource = dt;
        ddl_bank.DataBind();
        con.Close();
    }




    private void bindGrid()
    {
        SqlCommand command = new SqlCommand("SELECT Bank_Account.Account_ID,Bank_Account.Bank_E_Code, Bank_Account.Account_No,Bank_Name, Bank_Account.[Branch_Id],Bank_Branch.[Bank_Id],[Branch_Name],[Branch_phone] ,[Branch_address] FROM [Finance].[dbo].[Bank_Branch] join Bank on Bank.Bank_ID= Bank_Branch.Bank_Id join [Bank_Account] on Bank_Account.BankId=Bank.Bank_ID", con);
        con.Open();
        SqlDataAdapter dadapter = new SqlDataAdapter(command);      
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        gride.DataSource = dt;
        gride.DataBind();
        gride.DataBind();
        con.Close();

    }
    protected void deleteRecord(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        con.Open();
        SqlCommand cmd = new SqlCommand("delete from [Finance].[dbo].[Bank_Account] where Account_ID=" + btn.CommandName + " ", con);
        cmd.ExecuteNonQuery();
        con.Close();
        bindGrid();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        con.Open();
        try
        {
            SqlCommand cmd;
       
            cmd = new SqlCommand("insert into Bank_Account (Account_No,Branch_Id,Bank_E_Code,E_Code,BankId) values (@Account_No,@Branch_Id,@Bank_E_Code,@E_Code,@BankId)", con); 


            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Account_No",TextBoxAccount.Text);
            cmd.Parameters.AddWithValue("@Branch_Id", DropDownList_Branch.SelectedValue);
            cmd.Parameters.AddWithValue("@Bank_E_Code",ddl_AccountHead.SelectedValue);
            cmd.Parameters.AddWithValue("@E_Code", ddl_AccountHead.SelectedValue);
            cmd.Parameters.AddWithValue("@BankId", ddl_bank.SelectedValue);
            cmd.ExecuteNonQuery();         
            con.Close();
            TextBoxAccount.Text = "";          
            bindGrid();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }





    protected void ddl_bank_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindBranch();

    }
}