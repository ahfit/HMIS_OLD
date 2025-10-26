using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SearchItemsCritical : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
    String conString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bind_Categories();
            bindSubCategory();
        }
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

    private void bindSubCategory()
    {
        con.Open();
        try
        {

            SqlCommand cmd;
            cmd = new SqlCommand("select '--- All ---' as [Generic_Name] ,0 as [G_N_Id] union SELECT [Generic_Name], [G_N_Id] FROM [Generic_Names] WHERE ([Cat_Id] = @Cat_Id or @Cat_Id=0)", con);
            cmd.Parameters.AddWithValue("@Cat_Id", ddl_Category.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataTextField = "Generic_Name";
            ddlSubCategory.DataValueField = "G_N_Id";
            ddlSubCategory.DataSource = dt;
            ddlSubCategory.DataBind();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }

    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(conString))
        {
            SqlCommand command = new SqlCommand("usp_SerachItems", connection);
            command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter sda = new SqlDataAdapter(command);       
            command.Parameters.AddWithValue("@ItemName", txtItemName.Text);
            command.Parameters.AddWithValue("@categoryid", ddl_Category.SelectedValue);
            command.Parameters.AddWithValue("@subcategoryid", ddlSubCategory.SelectedValue);
            command.Parameters.AddWithValue("@status", ddl_Status.SelectedValue);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
   

    protected void Button1_Click(object sender, EventArgs e)
    {

        SqlConnection con = new SqlConnection(conString);
        try
        {
            FillGridView();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    protected void bind_Categories()
    {
        SqlCommand cmd;
        try
        {
            con.Open();
            try
            {


                cmd = new SqlCommand("SELECT Item_Type_Id, Item_Type FROM Store_Item_Types where IS_Pharmacy = 1", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddl_Category.DataSource = dt;
                ddl_Category.DataTextField = "Item_Type";
                ddl_Category.DataValueField = "Item_Type_Id";
                ddl_Category.DataSource = dt;
                ddl_Category.DataBind();
                con.Close();
            }
            catch (Exception ex)
            {

                con.Close();
            }

        }
        catch (Exception ex)
        {
        }
    }
    

    protected void ddl_Category_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubCategory();
    }
    
    protected void btnMarkExpensive_Click(object sender, EventArgs e)
    {
        HiddenField hf_ItemCode;
        CheckBox chkbox;
        DbManager dbmgr=new DbManager();
        foreach (GridViewRow row in GridView1.Rows)
        {
             chkbox = row.FindControl("chkbox") as CheckBox;

            if (chkbox.Checked)
            {

                hf_ItemCode = row.FindControl("hf_ItemCode") as HiddenField;

                SqlParameter[] para ={
                    new SqlParameter("@ItemCode",hf_ItemCode.Value)
                };
                dbmgr.ExecuteNonQuery("usp_MarkItemCritical", "STOREConnectionString", para);
            }
            lblNewMsg.Visible = true;
            lblNewMsg.ForeColor = System.Drawing.Color.Green;
            lblNewMsg.Text ="Items Successfully Marked...";
            FillGridView();
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            HiddenField hfis_expensive = e.Row.FindControl("hfis_expensive") as HiddenField;
            CheckBox chkbox = e.Row.FindControl("chkbox") as CheckBox;
            LinkButton btnUnmark = e.Row.FindControl("btnUnmark") as LinkButton;
            if (hfis_expensive.Value == "True")
            {
                chkbox.Checked = true;
                chkbox.Enabled = false;
                btnUnmark.Visible = true;
                }
            }
        }

    protected void btnUnmark_Click(object sender, EventArgs e)
    {
        LinkButton btnUnmark = sender as LinkButton;
        DbManager dbmgr = new DbManager();
      
                SqlParameter[] para ={
                    new SqlParameter("@ItemCode",btnUnmark.CommandArgument)
                };
                dbmgr.ExecuteNonQuery("usp_UnMarkItemNarcotic", "STOREConnectionString", para);
        FillGridView();
        lblNewMsg.Visible = true;
        lblNewMsg.ForeColor = System.Drawing.Color.Green;
        lblNewMsg.Text = "Items Successfully UnMarked";
    }
}