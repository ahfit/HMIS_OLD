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

public partial class Patient_Registration_AddPatientType : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillDiscountType();
            FillGridView();    
        }
        
    }
    protected void FillDiscountType()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("select id , DiscountType from Discount_Type order by DiscountType ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Discount_Type.DataTextField = "DiscountType";
            ddl_Discount_Type.DataValueField = "DiscountType";
            ddl_Discount_Type.DataSource = dt;
            ddl_Discount_Type.DataBind();
        }
    }

    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("Select_Patient_Type", connection);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
    protected void btn_markReceptionest_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(_str);

        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("Insert_Patient_Type", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@PatientType", Txt_PatientType.Text.Trim());
            cmd.Parameters.AddWithValue("@Status", "1");
            cmd.Parameters.AddWithValue("@hospitalID", Session["HospitalID"]);
            cmd.Parameters.AddWithValue("@DiscountType", ddl_Discount_Type.SelectedItem.Text);
            cmd.ExecuteNonQuery();
            con.Close();
            TextClear();
            
        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }


    }
    private void TextClear()
    {
        Txt_PatientType.Text = "";
        FillGridView();

    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        if (lb.Text == "Active")
        {
            HF_Status.Value = "0";

        }
        else if (lb.Text == "Deactive")
        {
            HF_Status.Value = "1";
        }

        using (SqlConnection con = new SqlConnection(_str))
        {
            string comand = @"UPDATE       Patient_Type SET  Active= " + HF_Status.Value + "    where Patient_Type.ID=@ID";
            SqlCommand command = new SqlCommand(comand, con);
            command.Parameters.AddWithValue("@ID", lb.CommandArgument);
            con.Open();
            command.ExecuteNonQuery();
            con.Close();
        }
        FillGridView();
    }

}