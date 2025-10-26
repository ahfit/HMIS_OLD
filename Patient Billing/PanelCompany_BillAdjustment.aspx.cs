using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Text;

public partial class Patient_Billing_PanelCompany_BillAdjustment : System.Web.UI.Page
{
    string conFinance = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
    string conBilling = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
    string conBasic = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    DataSet dsRelation = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Load_PanelCompanies();
            Get_PanelCompanyId();
            Get_PatientServices();
            Get_CategoryWiseSum();
        }
    }
    private void Load_PanelCompanies()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conFinance);
        try
        {
            cmd = new SqlCommand("select Party_Id,Party_Name from Parties", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_Company.DataSource = dt;
            DDL_Company.DataBind();
        }
        catch (Exception ex)
        {

        }
    }

    private void Get_PanelCompanyId()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conFinance);
        try
        {
            con.Open();
            cmd = new SqlCommand("select Billing_Party_Id from Payment where PayId=@PayId", con);
            cmd.Parameters.AddWithValue("@PayId",Request.QueryString["YearlyNo"]);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.HasRows)
            {
                reader.Read();
                DDL_Company.SelectedValue = reader["Billing_Party_Id"].ToString();
            }
            reader.Close();
            con.Close();
        }
        catch (Exception ex)
        {

        }
    }

    private void Get_PatientServices()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conBasic);
        try
        {
            cmd = new SqlCommand("GetPatientServicesForPanelAdjustment", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@YearlyNo",Request.QueryString["YearlyNo"]);
            cmd.Parameters.AddWithValue("@RegNo",Request.QueryString["RegNo"]);
            cmd.Parameters.AddWithValue("@Company_Id",DDL_Company.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);                        
            DataTable dt = new DataTable();

            da.Fill(dt);

            
            GridView_Services.DataSource = dt;
            GridView_Services.DataBind();

        }
        catch (Exception ex)
        {

        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        StringBuilder stringBuilder = new StringBuilder();

        SqlConnection con = new SqlConnection(conBilling);
        SqlCommand cmd = new SqlCommand();

        con.Open();
        foreach (GridViewRow item in GridView_Services.Rows)
        {
            if (((CheckBox)item.FindControl("chkbox")).Checked)
            {
                string Sid = ((HiddenField)item.FindControl("hdnS_Id")).Value.ToString();
                string PSid = ((HiddenField)item.FindControl("hdnPsid")).Value.ToString();
                string CompanyAmount = ((TextBox)item.FindControl("txtpanelAmount")).Text.ToString();
                string is_insert=((TextBox)item.FindControl("txtpanelAmount")).ToolTip.ToString();

                string hf_billid = ((HiddenField)item.FindControl("HiddenField1")).Value.ToString();
                string PatientAmount = ((TextBox)item.FindControl("txtPatientAmount")).Text.ToString();
                string CompanyID = DDL_Company.SelectedValue.ToString();

                if (string.IsNullOrEmpty(PatientAmount.Trim()))
                {
                    PatientAmount = "0";
                }
                if (string.IsNullOrEmpty(CompanyAmount.Trim()))
                {
                    CompanyAmount = "0";
                }
                //if (is_insert!="0")
                //{
                    stringBuilder.Append(@"Delete from Panel_Patient_Bill_Adjustment where BillID=" + hf_billid + "; ");
                //}
                stringBuilder.Append(@"insert into Panel_Patient_Bill_Adjustment([PsID],[SID]   ,[CompanyAmount] ,[PatientAmount] ,[CompanyID]) values 

                                      (" + PSid + "," + Sid + "," + CompanyAmount.Trim() + "," + PatientAmount.Trim() + "," + CompanyID + ") ; ");
            }
        }


        try
        {
            cmd.CommandText = stringBuilder.ToString();
            cmd.Connection = con;
            cmd.CommandType = CommandType.Text;

            cmd.ExecuteNonQuery();
            Get_PatientServices();
            Get_CategoryWiseSum();
        }
        catch (Exception)
        {


        }
           
                       

    }

    private void Get_CategoryWiseSum()
    {

        SqlCommand cmd;
        SqlConnection con = new SqlConnection(conBasic);
        try
        {
            cmd = new SqlCommand("usp_categoryWiseSum_forPanel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString["YearlyNo"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);


            GridView_CategoryDetail.DataSource = dt;
            GridView_CategoryDetail.DataBind();

        }
        catch (Exception ex)
        {

        }
    }
}