
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

public partial class Finance_BankAdd : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindGrid();
        }
    }

  
  
    private void bindGrid()
    {
        SqlCommand command = new SqlCommand("select * from [Finance].[dbo].[Bank]", con);
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
        SqlCommand cmd = new SqlCommand("delete from [Finance].[dbo].[Bank] where Bank_ID=" + btn.CommandName + " ", con);
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
            cmd = new SqlCommand("insert into  Bank (Bank_Name,Bank_phone,Address) values (@Bank_Name,@Bank_phone,@Address)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@Bank_Name", txtbank.Text);
            cmd.Parameters.AddWithValue("@Bank_phone", TextPhon.Text);
            cmd.Parameters.AddWithValue("@Address", TextAddress.Text);
            cmd.ExecuteNonQuery();         
            con.Close();
            txtbank.Text = "";
            TextPhon.Text = "";
            TextAddress.Text = "";
            bindGrid();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }



  
}