using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_Stock : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            bindCategory();
            bindSubCategory();
            bindManufacturer();
        }
    }
    protected void bindCategory()
    {
        DbManager dbMgr = new DbManager();
        String query = "SELECT    0 Item_Type_Id,'---ALL---' Item_Type union SELECT Item_Type_Id, Item_Type FROM Store_Item_Types Where Item_Type Like @Item_Type ";
        SqlParameter[] sqlParm = { new SqlParameter("@Item_Type", "%") };
        ddlCategory.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParm);
        ddlCategory.DataBind();
    }
    protected void bindSubCategory()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 as G_N_Id,'---ALL---' as Generic_Name union SELECT G_N_Id, Generic_Name FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id)";
        SqlParameter[] sqlParm = { new SqlParameter("@Cat_Id",ddlCategory.SelectedValue) };
        ddlGenericNames.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParm);
        ddlGenericNames.DataBind();
    }
    protected void bindManufacturer()
    {
        DbManager dbMgr = new DbManager();
        String query = "select '--ALL--' as Manufacturer_Name,0 as ID union select Manufacturer_Name,Manufacturer_Id ID from Items_Manufacturer WHERE (Manufacturer_Name = @Manufacturer_Name)";
        SqlParameter[] sqlParm = { new SqlParameter("@Manufacturer_Name", "%") };
        ddlManufacturer.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParm);
        ddlManufacturer.DataBind();
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'";
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        getStock();
    }
    protected void getStock()
    {
        DbManager dbGStore = new DbManager();
        SqlParameter[] sqlGStore = { new SqlParameter("@name", txtItemName.Text), new SqlParameter("@manufacture", ddlManufacturer.SelectedValue)
                                    , new SqlParameter("@Subdept", 23), new SqlParameter("@Category", ddlCategory.SelectedValue)
                                    , new SqlParameter("@SubCategory", ddlGenericNames.SelectedValue) };
        gvGStore.DataSource = dbGStore.ExecuteDataTable("uspGetDeptStock", "STOREConnectionString", sqlGStore);
        gvGStore.DataBind();
        DbManager dbPStore = new DbManager();
        SqlParameter[] sqlPStore = { new SqlParameter("@name", txtItemName.Text), new SqlParameter("@manufacture", ddlManufacturer.SelectedValue)
                                    , new SqlParameter("@Subdept", 83), new SqlParameter("@Category", ddlCategory.SelectedValue)
                                    , new SqlParameter("@SubCategory", ddlGenericNames.SelectedValue) };
        gvPStore.DataSource = dbPStore.ExecuteDataTable("uspGetDeptStock", "STOREConnectionString", sqlPStore);
        gvPStore.DataBind();
        DbManager dbPharmacy = new DbManager();
        SqlParameter[] sqlPharmacy = { new SqlParameter("@name", txtItemName.Text), new SqlParameter("@manufacture", ddlManufacturer.SelectedValue)
                                    , new SqlParameter("@Subdept", 50), new SqlParameter("@Category", ddlCategory.SelectedValue)
                                    , new SqlParameter("@SubCategory", ddlGenericNames.SelectedValue) };
        gvPharmacy.DataSource = dbPharmacy.ExecuteDataTable("uspGetDeptStock", "STOREConnectionString", sqlPharmacy);
        gvPharmacy.DataBind();

    }
}