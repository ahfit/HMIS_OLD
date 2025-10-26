using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;
public partial class Patient_Registration_BirthCertificateInfo : System.Web.UI.Page
{
    string RegconString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            startDateChooser.Text = DateTime.Now.Date.ToString("yyyy-MM-dd");
            startDateChooserTime.Text = DateTime.Now.ToString("hh:mm");
           
            loadDoctor();
            loadGender();
            LoadGrid();
            btnsave.Visible = false;
        }

    }
    private void loadGender()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(RegconString);
            con.Open();
            cmd = new SqlCommand("select gender_id,Gender from gender where Gender_ID in (1,2) ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownListGender.DataSource = dt;
            DropDownListGender.DataTextField = "Gender";
            DropDownListGender.DataValueField = "gender_id";

            DropDownListGender.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }

    private void loadDoctor()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("SELECT ''  AS Name,0 as EmpID union SELECT ISNULL(EFName, '') + ' ' + ISNULL(EMName, '') + ' ' + ISNULL(ELName, '') AS Name, EmpID  FROM Employee WHERE (Is_Consultant=1) and ActiveStatus=1 order by Name ", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList1.DataSource = dt;
            DropDownList1.DataTextField = "Name";
            DropDownList1.DataValueField = "EmpID";

            DropDownList1.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }
    protected void ClearFields()
    {
        TextBoxMRNO.Text = "";
        TextBoxVISIT_IPDNO.Text = "";
        TextBoxBillNO.Text = "";
        TextBoxPatientName.Text = "";
        TextBoxFatherCNIC.Text = "";
        TextBoxMotherCNIC.Text = "";
        TextBoxStatus.Text = "";
        TextBoxPlaceofBirth.Text = "";
        TextBoxResidentailAddress.Text = "";
        TextBoxResidentailAddress.Text = "";
        TextBoxFatherName.Text = "";
        TextBoxMotherName.Text = "";
        TextBoxIssuedBy.Text = "";

    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        DateTime SDate = Convert.ToDateTime(startDateChooser.Text);
        DateTime STime = Convert.ToDateTime(startDateChooserTime.Text);
        DateTime DOB = Convert.ToDateTime(SDate.Date.ToString("MM/dd/yy") + " " + STime.ToString("hh:mm:ss tt"));
        if (TextBoxMRNO.Text != "")
        {

            SqlConnection con = new SqlConnection(RegconString);

            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("BirthCertificateInformation", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@MrNo", TextBoxMRNO.Text.Trim());
                cmd.Parameters.AddWithValue("@VisitNo", TextBoxVISIT_IPDNO.Text.Trim());

                cmd.Parameters.AddWithValue("@PatientName", TextBoxPatientName.Text.Trim());
                cmd.Parameters.AddWithValue("@Consultant", DropDownList1.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Status", TextBoxStatus.Text.Trim());
                cmd.Parameters.AddWithValue("@ResidentailAddress", TextBoxResidentailAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Gender", DropDownListGender.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@PlaceofBirth", TextBoxPlaceofBirth.Text.Trim());

                cmd.Parameters.AddWithValue("@FatherName", TextBoxFatherName.Text.Trim());
                cmd.Parameters.AddWithValue("@MotherName", TextBoxMotherName.Text.Trim());
                cmd.Parameters.AddWithValue("@FatherCNIC", TextBoxFatherCNIC.Text.Trim());
                cmd.Parameters.AddWithValue("@MatherCNIC", TextBoxMotherCNIC.Text.Trim());
                cmd.Parameters.AddWithValue("@DateofBirth", DOB);
                cmd.Parameters.AddWithValue("@AliveDead", RadioButtonList1.SelectedValue);
                cmd.Parameters.AddWithValue("@IssuedBy", Session["Emp_ID"]);



                cmd.ExecuteNonQuery();
                con.Close();
                btnsave.Enabled = false;
                LoadGrid();
                Search_Patient();



            }

            catch (Exception ex)
            {


            }

        }
        else
        {
            Label1.Text = "Please fill first ....";
        }
        LoadGrid();
        ClearFields();


    }

    private void LoadGrid()
    {

        SqlConnection con = new SqlConnection(RegconString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("GetBirthCertificateInfo", con);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@RegNo", TextBoxMRNO.Text.Trim());
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            GridViewBirthCertificateInfo.DataSource = dt;
            GridViewBirthCertificateInfo.DataBind();

            if (GridViewBirthCertificateInfo.Rows.Count > 0)
            {
                btnsave.Enabled = false;
            }
            else
            {
                btnsave.Enabled = true;
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
    void Search_Patient()
    {
        if (TextBoxMRNO.Text.Length == 14)
        {
            btnsave.Visible = true;
            Label2.Visible = false;

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
            SqlCommand cmd = new SqlCommand("Search_BirthCertificateInfo", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@RegNo", TextBoxMRNO.Text.Trim());
            try
            {
                loadDoctor();
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.HasRows)
                {

                    while (reader.Read())
                    {

                        TextBoxMRNO.Text = Convert.ToString(reader["RegNo"].ToString());
                        TextBoxVISIT_IPDNO.Text = Convert.ToString(reader["PayID"]);
                        TextBoxBillNO.Text = Convert.ToString(reader["SrNo"]);
                        TextBoxPatientName.Text = Convert.ToString(reader["PatientName"]);
                        DropDownList1.SelectedItem.Text = Convert.ToString(reader["ConsultantName"]);
                        TextBoxFatherName.Text = Convert.ToString(reader["RelationName"]);
                        TextBoxStatus.Text = Convert.ToString(reader["Status"]);
                        TextBoxFatherCNIC.Text = Convert.ToString(reader["FatherCNIC"].ToString());
                        TextBoxMotherCNIC.Text = Convert.ToString(reader["MatherCNIC"]);
                        RadioButtonList1.SelectedItem.Text = Convert.ToString(reader["AliveDead"].ToString());
                        TextBoxResidentailAddress.Text = Convert.ToString(reader["ResidentailAddress"]);
                        TextBoxPlaceofBirth.Text = Convert.ToString(reader["PlaceofBirth"]);


                    }


                }
                else
                {
                    Label2.Text = "Please enter 12 Digit Value...";
                }
            }
            catch (Exception ex)
            {

            }
            finally
            {
                cmd.Dispose();
                con.Close();
            }
        }
        TextBoxMRNO.Enabled = false;
        TextBoxVISIT_IPDNO.Enabled = false;
        TextBoxPatientName.Enabled = false;
        TextBoxStatus.Enabled = false;

    }
    protected void btn_Update_Click(object sender, EventArgs e)
    {

        Search_Patient();
        LoadGrid();
    }
}
