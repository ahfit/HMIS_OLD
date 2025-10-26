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

public partial class Patient_Registration_AddHospitalWisePatientType : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillHospital();
            FillPatientType();
           FillGridView();    
        }
        
    }
    protected void FillHospital()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_Hospital.DataValueField = "Hospital_ID";
            ddl_Hospital.DataTextField = "Hospital_Name";
            ddl_Hospital.DataSource = dt;
            ddl_Hospital.DataBind();
        }
    }

    protected void FillPatientType()
    {
        string conststr = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        using (SqlConnection con = new SqlConnection(conststr))
        {
            SqlCommand command = new SqlCommand("SELECT  Patient_Type.Patient_type, Patient_type.ID as Patient_Type_ID FROM Patient_Type  WHERE        (Patient_Type.Active = 1) ", con);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            //command.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            ddl_PatientType.DataValueField = "Patient_Type_ID";
            ddl_PatientType.DataTextField = "Patient_type";
            ddl_PatientType.DataSource = dt;
            ddl_PatientType.DataBind();
        }
    }

    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("Select_HospitalWisePatientType", connection);
            command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
            command.Parameters.AddWithValue("@PatientType", ddl_PatientType.SelectedValue);

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
            SqlCommand cmd = new SqlCommand("Insert_HospitalWisePatientType", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@hospitalID", ddl_Hospital.SelectedValue);
            cmd.Parameters.AddWithValue("@PatientType", ddl_PatientType.SelectedValue);
          
            
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
            string comand = @"UPDATE   Patient_Type_HospitalWise SET  Dependent_Allow= " + HF_Status.Value + "    where Patient_Type_HospitalWise.Id=@ID";
            SqlCommand command = new SqlCommand(comand, con);
            command.Parameters.AddWithValue("@ID", lb.CommandArgument);
            con.Open();
            command.ExecuteNonQuery();
            con.Close();
        }
        FillGridView();
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        LinkButton lb = (LinkButton)sender;
        if(lb.Text=="Active")
        {
            HF_Status.Value = "0";
        }
        else if(lb.Text=="Deactive")
        {
            HF_Status.Value = "1";
        }
        using (SqlConnection con = new SqlConnection(_str))
        {
            string comand= @"UPDATE   Patient_Type_HospitalWise SET  Panel_Company= " + HF_Status.Value + "    where Patient_Type_HospitalWise.Id=@ID";
            SqlCommand cmd = new SqlCommand(comand,con);
            cmd.Parameters.AddWithValue("@ID", lb.CommandArgument);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }
        FillGridView();
    }

    protected void ddl_PatientType_SelectedIndexChanged(object sender, EventArgs e)
    {
        FillGridView();
    }

   
}