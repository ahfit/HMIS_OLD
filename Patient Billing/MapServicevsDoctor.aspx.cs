using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_MapServicevsDoctor : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    SqlConnection Str_con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            FillHospital();
            bindPatientType();
            binddepartment();
            binddoctors();
            bindServices();
            displayGrid();
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
    protected void deleteRecord(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        Str_con.Open();

        SqlCommand cmd = new SqlCommand("DELETE FROM MapServiceswithDoctor where ID=" + btn.CommandName + " ", Str_con);

        cmd.ExecuteNonQuery();
        
        displayGrid();
        Str_con.Close();
    }
    protected void bindPatientType()
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT        Patient_Type.Patient_type, Patient_Type_HospitalWise.Patient_Type_Id FROM Patient_Type INNER JOIN Registration.dbo.Patient_Type_HospitalWise ON Patient_Type.ID = Patient_Type_HospitalWise.Patient_Type_Id where Patient_Type_HospitalWise.Hospital_Id=@HospitalID  ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@HospitalID", ddl_Hospital.SelectedValue);
        
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddlPatientType.DataSource = ds;
        ddlPatientType.DataValueField = "Patient_Type_ID";
        ddlPatientType.DataTextField = "Patient_type";
        ddlPatientType.DataBind();
        con.Close();
    }

    private void binddoctors()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand(" SELECT        Employee.EmpID, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + '' + ISNULL(Employee.EMName, '') + '' + ISNULL(Employee.ELName, '')  + ' ( ' + SubDepartment.SubDept_Name + ' )' AS Name FROM            SubDepartment INNER JOIN   Employee ON SubDepartment.Dept_Id = Employee.DeptID AND SubDepartment.SubDept_Id = Employee.SubDeptId wHERE        (Employee.ActiveStatus = 1) AND (Employee.Is_Consultant = 1) ", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddldoctors.DataSource = ds;
        ddldoctors.DataTextField = "Name";
        ddldoctors.DataValueField = "EmpID";
        ddldoctors.DataBind();
        con.Close();
    }


    private void binddepartment()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("GetSubDeptByHospital", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        cmd.Parameters.AddWithValue("@HospitalId", ddl_Hospital.SelectedValue);
        cmd.CommandType = CommandType.StoredProcedure;
        DataSet ds = new DataSet();
        da.Fill(ds);
        ddldept.DataSource = ds;
        ddldept.DataTextField = "SubDept_Name";
        ddldept.DataValueField = "SubDept_Id";
        ddldept.DataBind();
        con.Close();

    }

    protected void displayGrid()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT MS.ID, CONVERT(varchar, MS.EntryDate, 107) AS EntryDate, SubDepartment.SubDept_Name, isnull(Employee.EFName,'') +' ' + isnull(Employee.EMName,'')+''+ isnull(Employee.ELName,'') as Doctor,  ADS.S_Name + ' ( ' + CONVERT(varchar, ASR.S_Amount) + ' )' AS S_Name  FROM MapServiceswithDoctor MS JOIN Admin_OPD_Slip_Rates ASR ON ASR.Id=MS.S_ID  JOIN Admin_Services ADS ON ADS.S_ID=ASR.S_id INNER JOIN SubDepartment ON MS.DeptID = SubDepartment.SubDept_Id  INNER JOIN Employee ON MS.DoctorID = Employee.EmpID WHERE MS.DoctorID=" + ddldoctors.SelectedValue +" and ASR.SubDept_Id=" + ddldept.SelectedValue + " and ASR.Patient_Type_id=" + ddlPatientType.SelectedValue + "", con);

        SqlDataAdapter dadapter = new SqlDataAdapter(cmd);

        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        GridView1.DataSource = dt;
        GridView1.DataBind();
        con.Close();
        
    }

protected void bindServices()
{
     con.Open();
     SqlCommand cmd = new SqlCommand("SELECT DISTINCT ASR.Id, ADS.S_Name + ' ( ' + CONVERT(varchar, ASR.S_Amount) + ' )' AS S_Name FROM  Admin_Services ADS INNER JOIN Admin_OPD_Slip_Rates ASR ON ADS.S_ID = ASR.S_id where ASR.SubDept_Id=" + ddldept.SelectedValue + " and ASR.Patient_Type_id=" + ddlPatientType.SelectedValue + "", Str_con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataSet ds = new DataSet();
        
        da.Fill(ds);
       
        ddlServices.DataSource = ds;
        ddlServices.DataValueField = "ID";
        ddlServices.DataTextField = "S_Name";
        ddlServices.DataBind();
        con.Close();
 
}



protected void btn_Update_Click(object sender, EventArgs e)
{
    try
    {

        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        con.Open();

        SqlCommand cmd = new SqlCommand("INSERT INTO MapServiceswithDoctor (DeptID, DoctorID, S_ID)VALUES(@DeptID,@DoctorID,@S_ID)", con);
        cmd.Parameters.AddWithValue("@DeptID", ddldept.SelectedValue);
        cmd.Parameters.AddWithValue("@DoctorID", ddldoctors.SelectedValue);
        cmd.Parameters.AddWithValue("@S_ID", ddlServices.SelectedValue);
        cmd.ExecuteNonQuery();

        lblmsg.ForeColor = System.Drawing.Color.Green;
        lblmsg.Visible = true;

        con.Close();
        displayGrid();
    }
    

    catch (Exception ex)
    {
        lblmsg.Text = "Services Already Marked";
       
    }

}


protected void ddldept_SelectedIndexChanged(object sender, EventArgs e)
{
   // binddoctors();
    bindServices();
    displayGrid();
    //bindPatientType();
}
protected void ddlPatientType_SelectedIndexChanged(object sender, EventArgs e)
{
    bindServices();
        displayGrid();
        //bindPatientType();
    }
protected void ddldoctors_SelectedIndexChanged(object sender, EventArgs e)
{

    bindServices();
    displayGrid();
}
protected void ddl_Hospital_SelectedIndexChanged(object sender, EventArgs e)
{
    binddepartment();
    bindPatientType();
        displayGrid();
    }
}