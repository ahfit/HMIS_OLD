using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_ViewDoctorWiseDetail : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
   
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FillHospital();
            bindGride();
           
        }
        
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select Refer_Id,Refer_Doctor_Name from Refer_Doctors  where Refer_Doctor_Name LIKE '%' + @Search + '%' Or Refer_Id like '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Refer_Doctor_Name"].ToString(), sdr["Refer_Id"].ToString()));
        }
        return items;
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
    

    private void bindGride()
    {

        DbManager dbMgr = new DbManager();
        SqlParameter[] para = { 
                                  new SqlParameter("@DoctorName", txtboxDoctorName.Text.Trim()) ,
                                   new SqlParameter("@HospitalID", ddl_Hospital.SelectedValue)
                              };
        gridviewEPLOYEE.DataSource = dbMgr.ExecuteDataTable("usp_getDoctorWisePatientTotal", "Reg_ConnectionString", para);
        gridviewEPLOYEE.DataBind();
        con.Close();

    }
    
    protected void txtboxDoctorName_TextChanged(object sender, EventArgs e)
    {
        bindGride();
    }
    protected void gridviewEPLOYEE_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        Control ctrl = e.CommandSource as Control;
        if (ctrl != null)
        {
            GridViewRow gvRow = ctrl.Parent.NamingContainer as GridViewRow;


            if (e.CommandName == "ViewDetails")
            {
                HiddenField hdDName = (HiddenField)gvRow.FindControl("hdnDoctorNAme");
                LinkButton lb = (LinkButton)gvRow.FindControl("lnkViewDetails");

                Response.Redirect("~/Patient Billing/DoctorWisePatientDetail.aspx?DoctorName="+hdDName.Value);
            }
        }           
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        bindGride();
    }
}