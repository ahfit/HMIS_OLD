
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pt_EMR_icdcodeRecord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
         if(!Page.IsPostBack)
        {
            StartDate.Value = DateTime.Now;
            bindManufactuer();
            BindGrid();
           //  gridview.DataBind();
         }
    }

    protected void bindManufactuer()
    {
        DbManager dbMgr = new DbManager();
        String query = "select Asc_id, Asc_Name from Admin_Service_Category where Asc_id in(5,6,9,10,34,42,29)";
        SqlParameter[] sqlParam = { };
        ddlCategory.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sqlParam);
        ddlCategory.DataTextField = "Asc_Name";
        ddlCategory.DataValueField = "Asc_id";
        ddlCategory.DataBind();
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> GetDiagnosisList(string prefixText, int count)
    {

        List<string> ICDCOde = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "SELECT  DISTINCT   Field1 + ' ' + Field3 AS Title,Field1 as ID FROM chapters_detail WHERE     (Field1 + ' ' + Field3 like '%' + @Name + '%')";
        cmd.Parameters.AddWithValue("@Name", prefixText.Trim());
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {

            ICDCOde.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Title"].ToString(), sdr["ID"].ToString()));
        }
        return ICDCOde;
    }

    protected void btnSave_Click(object sender, EventArgs e)
{
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString);
        try
        {
            con.Open();
            SqlCommand cmd;
            cmd = new SqlCommand("INSERT INTO ICDRecord(CategoryID,IcdCode,Date,Type,Remarks,YearlyNo,ICDName) VALUES(@CategoryID,@IcdCode,@Date,@Type,@Remarks,@YearlyNo,@ICDName)", con);
            cmd.Parameters.AddWithValue("@CategoryID", ddlCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@IcdCode", txt_Code.Text);
            cmd.Parameters.AddWithValue("@Date", StartDate.Value);
            cmd.Parameters.AddWithValue("@Type", txtType.Text);
            cmd.Parameters.AddWithValue("@Remarks", txt_Remarks.Text);
            cmd.Parameters.AddWithValue("@YearlyNo", txtboxVisitno.Text);
            cmd.Parameters.AddWithValue("@ICDName", txtDisease.Text);
            cmd.ExecuteNonQuery();
            txt_Code.Text = string.Empty;
            txtType.Text = string.Empty;
            txt_Remarks.Text = string.Empty;
            con.Close();
            BindGrid();
        }
        catch (Exception ex)
        {
            con.Close();
        }
    }

    private void BindGrid()
    {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ICD10ConnectionString"].ConnectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("GetICDRecord", con);
            SqlDataAdapter dadapter = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dadapter.Fill(dt);
            gridview.DataSource = dt;
            gridview.DataBind();
            con.Close();
     } 
    }




