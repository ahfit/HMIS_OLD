using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


public partial class Store_UpdateHeadAgainstItems : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
    string conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddl_Hospital.SelectedValue = Session["HospitalID"].ToString();
            ddl_Hospital.Enabled = false;
            bindHospital();
           
            DropDownList_Category.DataBind();
            DropDownList_Generic_ItemName.DataBind();
        }
    }
   

    protected void bindHospital()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = {
        };
        String query = "Select 0 Hospital_ID,'------ ALL -----' Hospital_Name union select Hospital_ID, Hospital_Name from Hospital  Order By Hospital_Name";

        ddl_Hospital.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddl_Hospital.DataTextField = "Hospital_Name";
        ddl_Hospital.DataValueField = "Hospital_ID";
        ddl_Hospital.DataBind();

    }

    protected void bindGrids()
    {
        IsFirstTime.Value = "1";
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@Category", DropDownList_Category.SelectedValue)
                                 ,new SqlParameter("@SubCategory", DropDownList_Generic_ItemName.SelectedValue)
                                 ,new SqlParameter("@ItemName", txtItemName.Text.Trim())
                                 };
        DataSet ds = new DataSet();

        ds = dbMgr.ExecuteDataSet("uspGetStoreItemsforMapingwithHead", "STOREConnectionString", sqlParm);
        GridViewMin.DataSource = ds.Tables[0];
        GridViewMin.DataBind();
        

        con.Close();
       
       
    }
    protected void GridViewMin_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewMin.PageIndex = e.NewPageIndex;
        bindGrids(); // Rebind your data here
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        bindGrids();
        
    }

    protected void chkselectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkAll = (CheckBox)sender;
        foreach (GridViewRow grd in GridViewMin.Rows)
        {
            CheckBox chk = (CheckBox)grd.FindControl("chkSelect");
            chk.Checked = chkAll.Checked;
        }
    }  
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        CheckBox ck = new CheckBox();
        HiddenField hf_item_code = new HiddenField();

        DropDownList ddl_sh = new DropDownList();
        DropDownList ddl_ch = new DropDownList();
         foreach (GridViewRow grd in GridViewMin.Rows)
        {
            ck = (CheckBox)grd.FindControl("chkSelect");
           if (ck.Checked)
            {
                ddl_sh= (DropDownList)grd.FindControl("ddl_StockHead");
                ddl_ch= (DropDownList)grd.FindControl("ddl_ConsumableHead");
                hf_item_code = (HiddenField)grd.FindControl("hf_item_code");
               
                updaterecord(hf_item_code.Value, ddl_sh.SelectedValue, ddl_ch.SelectedValue);
            }
        }
         bindGrids();
    }
   
   
    private void updaterecord(string item_code, string SH, string CH)
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        
        string Ecode, Consump,C;
        Ecode = SH;
        Consump = CH;
        C = item_code;

        SqlCommand cmd = new SqlCommand("usp_UpdateHeadAgainstItems", con);
        cmd.Parameters.AddWithValue("@SH", Ecode);
        cmd.Parameters.AddWithValue("@CH", CH);
        cmd.Parameters.AddWithValue("@Item_Code", C);
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();
        GetStudentList();
    }

    void GetStudentList()
    {
        SqlCommand cmd = new SqlCommand("select E_Code,Consumption_Head from Store_items", con);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        GridviewExp.DataSource = dt;
        GridviewExp.DataBind();
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
    }

    protected void GridViewMin_PreRender(object sender, EventArgs e)
    {
        if (IsFirstTime.Value == "1")
        {

        
       foreach(GridViewRow Row in GridViewMin.Rows)
       {
           DropDownList ddS = Row.FindControl("ddl_StockHead") as DropDownList;
           DropDownList ddC = Row.FindControl("ddl_ConsumableHead") as DropDownList;

           HiddenField hS = Row.FindControl("hf_SH") as HiddenField;
           HiddenField hC = Row.FindControl("hf_CH") as HiddenField;
           ddS.SelectedValue = hS.Value;
           ddC.SelectedValue = hC.Value;
           IsFirstTime.Value = "0";
       }
        }
    }

  
}
