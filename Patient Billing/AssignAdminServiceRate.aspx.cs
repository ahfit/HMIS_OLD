using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_AssignAdminServiceRate : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindHospital();
            ddlhospital.SelectedValue = Session["HospitalID"].ToString();
            bindPatientType();
            bindServiceCategory();
            bindServices();
            displayGrid();
            bindSubDepartment();

        }

    }

    protected void displayGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT Opd.Patient_Type_id, Opd.S_Amount, AServ.S_Name, Patient_Type.Patient_type FROM  Admin_OPD_Slip_Rates AS Opd INNER JOIN Admin_Services AS AServ ON Opd.S_id = AServ.S_ID INNER JOIN  Patient_Type ON Opd.Patient_Type_id = Patient_Type.ID where Opd.SubDept_Id=@SubDept_Id and opd.Patient_Type_id=@Patient_Type_id and  Opd.s_id=@s_id", con);

        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@Patient_Type_id", ddlPatientType.SelectedValue);
        cmd.Parameters.AddWithValue("@SubDept_Id", DDL_SubDepartment.SelectedValue);
        cmd.Parameters.AddWithValue("@s_id", ddlServices.SelectedValue);

        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        con.Close();

    }

    protected void bindServices()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("GetServicesByHospital", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        cmd.CommandType = CommandType.StoredProcedure;
        DataSet ds = new DataSet();
        cmd.Parameters.AddWithValue("@Hospital", ddlhospital.SelectedValue);        
        cmd.Parameters.AddWithValue("@S_Category", ddlCategory.SelectedValue);
        da.Fill(ds);

        ddlServices.DataSource = ds;
        ddlServices.DataValueField = "S_ID";
        ddlServices.DataTextField = "S_Name";
        ddlServices.DataBind();
        con.Close();

    }
    protected void bindSubDepartment()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("GetSubDeptByHospital", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@HospitalId", ddlhospital.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);

        DDL_SubDepartment.DataSource = ds;
        DDL_SubDepartment.DataValueField = "SubDept_Id";
        DDL_SubDepartment.DataTextField = "SubDept_Name";
        DDL_SubDepartment.DataBind();
        con.Close();

    }

    protected void bindServiceCategory()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select Asc_Name,Asc_id from  Admin_Service_Category", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlCategory.DataSource = ds;
        ddlCategory.DataValueField = "Asc_id";
        ddlCategory.DataTextField = "Asc_Name";
        ddlCategory.DataBind();
        con.Close();
    }

    protected void bindPatientType()
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT pt.ID Patient_Type_ID, Patient_Type FROM  Patient_Type AS pt INNER JOIN  Registration.dbo.Patient_Type_HospitalWise AS pth ON pt.ID = pth.Patient_Type_Id WHERE   (pth.Hospital_Id = @Hospital_Id) AND ISNULL(pt.Active,0)=1", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@Hospital_Id", ddlhospital.SelectedValue);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlPatientType.DataSource = ds;
        ddlPatientType.DataValueField = "Patient_Type_ID";
        ddlPatientType.DataTextField = "Patient_type";
        ddlPatientType.DataBind();
        con.Close();
    }

    protected void bindHospital()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select Hospital_ID, Hospital_Name from Hospital ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlhospital.DataSource = ds;
        ddlhospital.DataValueField = "Hospital_ID";
        ddlhospital.DataTextField = "Hospital_Name";
        ddlhospital.DataBind();
        con.Close();
    }


    protected void btn_Update_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("Insert into  Admin_OPD_Slip_Rates (Patient_Type_id,S_id,S_Amount,SubDept_Id)values(@Patient_Type_id,@S_id,@S_Amount,@SubDept_Id)", con);
        cmd.Parameters.AddWithValue("@Patient_Type_id", ddlPatientType.SelectedValue);
        cmd.Parameters.AddWithValue("@S_id", ddlServices.SelectedValue);
        cmd.Parameters.AddWithValue("@S_Amount", txtbox.Text);
        cmd.Parameters.AddWithValue("@SubDept_Id", DDL_SubDepartment.SelectedValue);
        cmd.ExecuteNonQuery();

        lblmsg.ForeColor = System.Drawing.Color.Green;
        lblmsg.Visible = true;

        con.Close();
        displayGrid();

    }
    protected void ddlPatientType_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindServices();
        displayGrid();
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindServices();
        displayGrid();
    }
    protected void ddlServices_SelectedIndexChanged(object sender, EventArgs e)
    {       
        displayGrid();
    }
    protected void DDL_SubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        displayGrid();
    }
}