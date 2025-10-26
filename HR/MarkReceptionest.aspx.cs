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

public partial class HR_MarkReceptionest : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        FillGridView();
        GetCounterType();

    }
    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("SP_SelectEmployeeReceptionist", connection);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    private void GetCounterType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(_str);
            con.Open();
            cmd = new SqlCommand("select distinct countertype from Receptionist  ", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_CounterType.DataSource = dt;
            DDL_CounterType.DataTextField = "countertype";
            DDL_CounterType.DataValueField = "countertype";

            DDL_CounterType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }

    protected void btn_markReceptionest_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_str);

        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SPInsert_Receptionest", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Receptionist_id", TextBox_Receptioniest.Text);
            cmd.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedItem.Text.Trim());

            cmd.Parameters.Add("@CheckReturn", SqlDbType.Int);
            cmd.Parameters["@CheckReturn"].Direction = ParameterDirection.Output;
            cmd.ExecuteNonQuery();
            int value = Convert.ToInt32(cmd.Parameters["@CheckReturn"].Value);
            con.Close();
            if (value == 0)
            {
                lblmg.Text = "ID Exist ... Try Another";
            }
            else if (value == 1)
            {
                lblmg.Text = "Information Insert Successfully...";
                FillGridView();
                TextBox_Receptioniest.Text="";

            }
        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }




    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;

        using (SqlConnection con = new SqlConnection(_str))
        {
            string comand = @"DELETE from Receptionist where Receptionist_id=@id";
            SqlCommand command = new SqlCommand(comand, con);
            command.Parameters.AddWithValue("@id", lb.CommandArgument);
            con.Open();
            command.ExecuteNonQuery();
            con.Close();
        }
        FillGridView();
    }

}