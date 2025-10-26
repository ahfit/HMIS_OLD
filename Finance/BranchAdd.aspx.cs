
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

public partial class Finance_BranchAdd : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindBank();
            bindGrid();
        }
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
        SqlCommand command = new SqlCommand("SELECT Bank.Bank_Name, [Branch_ID],Bank_Branch.[Bank_Id],[Branch_Name],[Branch_phone] ,[Branch_address] FROM [Finance].[dbo].[Bank_Branch] join Bank on Bank.Bank_ID = Bank_Branch.Bank_Id WHERE Bank.Bank_ID = @bankID", con);
        command.Parameters.AddWithValue("@bankID", ddl_bank.SelectedValue);
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
        SqlCommand cmd = new SqlCommand("delete from [Finance].[dbo].[Bank_Branch] where Branch_ID=" + btn.CommandName + " ", con);
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
            cmd = new SqlCommand("insert into  Bank_Branch (Bank_Id,[Branch_Name],[Branch_phone],[Branch_address]) values (@Bank_Id,@Branch_Name,@Branch_phone,@Branch_address)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Bank_Id", ddl_bank.SelectedValue);
            cmd.Parameters.AddWithValue("@Branch_Name", TextBranch.Text);
            cmd.Parameters.AddWithValue("@Branch_phone", TextPhon.Text);
            cmd.Parameters.AddWithValue("@Branch_address", TextAddress.Text);
            cmd.ExecuteNonQuery();         
            con.Close();
            TextBranch.Text = "";
            TextPhon.Text = "";
            TextAddress.Text = "";
            bindGrid();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }





    protected void ddl_bank_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindGrid();

    }
}