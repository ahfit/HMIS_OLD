using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Pt_EMR_PatientICDCodeDiagnosis : System.Web.UI.Page
{
    static string _conStr = ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDiagnosisType();
        }
    }

    private void LoadDiagnosisType()
    {
          string _conStrTreatment = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ConnectionString;
        
        SqlConnection con = new SqlConnection(_conStrTreatment);
        SqlCommand cmd = new SqlCommand("select Type,DiagnosisType  from DiagnoseType", con);

        DataSet ds = new DataSet();

        SqlDataAdapter da = new SqlDataAdapter(cmd);

        da.Fill(ds);
        ddllist.DataSource = ds;
        ddllist.DataValueField = "Type";
        ddllist.DataTextField = "DiagnosisType";
        ddllist.DataBind();
    }


    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchNames(string prefixText, int count)
    {

        List<string> customers = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = @"select ISNULL( [Field1],'') Field1  ,Field3 from (
SELECT  
      [Field1]      
      ,[Field3]
      
  FROM [ICD10].[dbo].[chapters_detail]
   ) abc where abc.Field3 is not null and [Field1] like '%" + prefixText + "%'";
        cmd.CommandType = CommandType.Text;
        
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Field1"].ToString(), (sdr["Field3"].ToString())));
        }
        return customers;

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
         DbManager dbMgr = new DbManager();
                    SqlParameter[] sqlParam = new SqlParameter[7];
                    sqlParam[0] = new SqlParameter("@ICDCode",txtboxICDCodes.Text);
                    sqlParam[1] = new SqlParameter("@ICDDiseaseName", txtboxDiagnoseName.Text);
                    sqlParam[2] = new SqlParameter("@Regno", Request.QueryString["Regno"]);
                    sqlParam[3] = new SqlParameter("@YearlyNo", Request.QueryString["yearlyno"]);
                    sqlParam[4] = new SqlParameter("@CreatedBy", Session["Emp_ID"]); 
                    sqlParam[5] = new SqlParameter("@Remarks",txtboxRemarks.Text);
                    sqlParam[6] = new SqlParameter("@DiagnoseType", ddllist.SelectedValue);
        
                    
                    dbMgr.ExecuteNonQuery("uspInsertPatientICDCodeDiagnosis", "TreatmentConnectionString", sqlParam);
          
    }
}