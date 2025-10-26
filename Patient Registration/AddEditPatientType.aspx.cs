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

public partial class Patient_Registration_AddEditPatientType : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillGridView();    
        }
        
    }
    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("Select_AddEditPatientType", connection);
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
            if (Txt_EditPatientType.Text != "")
            {

                con.Open();
                SqlCommand cmd = new SqlCommand("Insert_AddEditPatientType", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EditType", Txt_EditPatientType.Text.Trim());

                cmd.ExecuteNonQuery();
                con.Close();
                TextClear();
                lblmg.Text = "Save Successfully";
            }
            else
            {
                lblmg.Text = "Please enter first Value";
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
    private void TextClear()
    {
        Txt_EditPatientType.Text = "";
        FillGridView();

    }
    protected void deleteRecord(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        SqlConnection con = new SqlConnection(_str);
        con.Open();

        SqlCommand cmd = new SqlCommand("Delete_AddEditPatientRights", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ID", btn.CommandName);
        cmd.ExecuteNonQuery();
        FillGridView();
        con.Close();
    }

}