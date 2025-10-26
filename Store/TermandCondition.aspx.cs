using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Store_TermandCondition : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillGridView();
        }
    }
    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("SP_SelectTermsAndConditions", connection);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }

    protected void ibDelete_Click(object sender, EventArgs e)
    {
        ImageButton ib = (ImageButton)sender;

        using (SqlConnection con = new SqlConnection(_str))
        {
            string comand = @"DELETE from TermsAndConditions where ID=@id";
            SqlCommand command = new SqlCommand(comand, con);
            command.Parameters.AddWithValue("@id", ib.CommandArgument);
            con.Open();
            command.ExecuteNonQuery();
            con.Close();
        }
        FillGridView();
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(_str);

        try
        {
            if (TextBox_Terms_Conditions.Text !="")
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_InsertTermsAndConditions", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Terms_Conditions", TextBox_Terms_Conditions.Text);
                cmd.ExecuteNonQuery();
                lblmg.Text = "Information saved successfully!!!";
                TextBox_Terms_Conditions.Text = "";
            }
            else
            {
                lblmg.Text = "Please Enter Terms & Conditions";
            }
            FillGridView();

        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }


    }
}