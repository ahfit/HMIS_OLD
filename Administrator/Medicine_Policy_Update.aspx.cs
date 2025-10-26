using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Administrator_Discount_Policy_Update : System.Web.UI.Page
{
    String Conster = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            HiddenField_MedCode.Value = "";
            BindPatientType();
            GetMedicine();
        }
    }

    private void BindPatientType()
    {
        DbManager objDBManager = new DbManager();

        SqlParameter[] sqlParams = {
            new SqlParameter("@Active",1)
            };

        DropDownList_Patient_Type.DataSource = objDBManager.ExecuteDataTable("usp_Get_PatientType", "Basic_Data_ConnectionString", sqlParams);
        DropDownList_Patient_Type.DataValueField = "Patient_Type_ID";
        DropDownList_Patient_Type.DataTextField = "Patient_Type";
        DropDownList_Patient_Type.DataBind();
    }

    protected void CHKAll_CheckedChanged(object sender, EventArgs e)
    {
        if (CHKAll.Checked)
        {
            txtMedicine.Text = "";
            HiddenField_MedCode.Value = "";
            txtMedicine.Enabled = false;
        }
        else
        {
            txtMedicine.Enabled = true;
        }
    }

    private void GetMedicine()
    {
        DbManager objDBManager = new DbManager();

        SqlParameter[] sqlParams = {
                new SqlParameter("@Patient_Type_Id", DropDownList_Patient_Type.SelectedValue)
            };
        
        gvdMedicine.DataSource = objDBManager.ExecuteDataTable("usp_Get_Medicine_PatientTypeWise", "Basic_Data_ConnectionString", sqlParams);
        gvdMedicine.DataBind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        DbManager objDBManager = new DbManager();

        SqlParameter[] sqlParams = {
                new SqlParameter("@Patient_Type_Id", DropDownList_Patient_Type.SelectedValue),                
                new SqlParameter("@Percentage", txtPercentage.Text)
            };
        objDBManager.ExecuteNonQuery("usp_Insert_MedicinePolicy", "Basic_Data_ConnectionString", sqlParams);
        gvdMedicine.DataBind();
    }

    protected void DropDownList_Patient_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetMedicine();
    }

    protected void lknbtnDelMed_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        DbManager objDBManager = new DbManager();

        SqlParameter[] sqlParams = {
            new SqlParameter("@Item_code",btn.CommandArgument),
            new SqlParameter("@PatientType_Id",DropDownList_Patient_Type.SelectedValue)
            };
        objDBManager.ExecuteNonQuery("usp_Delete_Medicine", "Basic_Data_ConnectionString", sqlParams);
        // Load Medicine
        GetMedicine();
    }
}