 
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Store_StockAdjustment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bindLocation();
            bindVendor();
            try
            {
                ddlLocation.SelectedValue = Session["SubDeptId"].ToString();
            }
            catch
            {
                Response.Redirect("~/Login.aspx");
            }
          
        }
    }
    protected void bindVendor()
    {
        String query = "select 0 as Party_Id,'---ALL---' as Party_Name union select[Manufacturer_Id] as Party_Id, [Manufacturer_Name] as Party_Name from Items_Manufacturer  ";
        ddlVendor.DataSource = bindingdropdowns("STOREConnectionString", query);
        ddlVendor.DataTextField = "Party_Name";
        ddlVendor.DataValueField = "Party_Id";
        ddlVendor.DataBind();

    }

    protected void bindLocation()
    {
        String query = " select SubDept_Id,SubDept_Name from SubDepartment ";
        ddlLocation.DataSource = bindingdropdowns("STOREConnectionString", query);
        ddlLocation.DataTextField = "SubDept_Name";
        ddlLocation.DataValueField = "SubDept_Id";
        ddlLocation.DataBind();

    }
    protected DataTable bindingdropdowns(string connectionString, string Querry)
    {
        string Con = ConfigurationManager.ConnectionStrings[connectionString].ConnectionString;
        SqlConnection sq = new SqlConnection(Con);
        sq.Open();
        SqlDataAdapter adot = new SqlDataAdapter(Querry, sq);
        DataTable dt = new DataTable();
        adot.Fill(dt);
        sq.Close();
        return dt;
    }

    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Code+' - '+ Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
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

    protected void ddlLocation_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindVendor();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        DbManager dbmgr = new DbManager();
        string vendorText = ddlVendor.SelectedItem.Text;
        string vendor = ddlVendor.SelectedValue;
        if (vendor == "0")
        {
            vendorText = "";
        }

        SqlParameter[] param ={
            new SqlParameter("@Vendor",vendorText),
            new SqlParameter("@Location",ddlLocation.SelectedValue),
            new SqlParameter("@ItemName",txtItemName.Text),
        };

        string querry = "usp_GetItemsForStockAdjustments";
        gvStockItems.DataSource = dbmgr.ExecuteDataTable(querry, "STOREConnectionString", param);
        gvStockItems.DataBind();
        foreach (GridViewRow row in gvStockItems.Rows)
        {
            TextBox txtExpiry = row.FindControl("txtExpiry") as TextBox;
            txtExpiry.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }

    protected void chkall_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkall = sender as CheckBox;
        if (chkall.Checked == true)
        {
            foreach (GridViewRow gv in gvStockItems.Rows)
            {
                CheckBox chk = gv.FindControl("chksingle") as CheckBox;
                chk.Checked = true;
            }
        }
        else
        {
            foreach (GridViewRow gv in gvStockItems.Rows)
            {
                CheckBox chk = gv.FindControl("chksingle") as CheckBox;
                chk.Checked = false;
            }
        }
    }


    protected void txtAdd_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtAdd = row.FindControl("txtAdd") as TextBox;
        TextBox txtSub = row.FindControl("txtSubtract") as TextBox;
        HiddenField hfStock = row.FindControl("hfStock") as HiddenField;
        TextBox txtBalance = row.FindControl("txtBalance") as TextBox;
        if (txtAdd.Text == "")
        {
            txtAdd.Text = "0";
        }
        if (Convert.ToInt32(txtAdd.Text) > 0)
        {

            txtBalance.Text = (Convert.ToInt32(hfStock.Value) + Convert.ToInt32(txtAdd.Text)).ToString();
            txtSub.Enabled = false;
            lblMsg.Text = "";
        }
        else
        {
            txtBalance.Text = hfStock.Value;
            txtSub.Enabled = true;
            lblMsg.Text = "";
        }

    }

    protected void txtSubtract_TextChanged(object sender, EventArgs e)
    {
        TextBox txt = (TextBox)sender;
        GridViewRow row = txt.NamingContainer as GridViewRow;
        TextBox txtAdd = row.FindControl("txtAdd") as TextBox;
        TextBox txtSub = row.FindControl("txtSubtract") as TextBox;
        TextBox txtRate = row.FindControl("txtRate") as TextBox;
        HiddenField hfStock = row.FindControl("hfStock") as HiddenField;
        TextBox txtBalance = row.FindControl("txtBalance") as TextBox;
        if(txtSub.Text=="")
        {
            txtSub.Text = "0";
        }
        if (Convert.ToInt32(txtSub.Text) <= Convert.ToInt32(hfStock.Value))
        {
            if (Convert.ToInt32(txtSub.Text) > 0)
            {
                txtAdd.Enabled = false;
                txtRate.Enabled = false;
                txtBalance.Text = (Convert.ToInt32(hfStock.Value) - Convert.ToInt32(txtSub.Text)).ToString();
                lblMsg.Text = "";

            }
            else
            {
                txtBalance.Text = hfStock.Value;
                txtAdd.Enabled = true;
                txtRate.Enabled = true;
            }
            lblMsg.Text = "";
        }
        else
        {
            lblMsg.Text = "Substraction value must be smaller than Available Stock ";
        }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string ItemAdd_XML = "<table>";
        string ItemSub_XML = "<table>";
        int chkforAdd = 0;
        int chkforSub= 0;
        TextBox txtSub;
        TextBox txtAdd;
        TextBox txtExpiry;
        TextBox txtRate;
        HiddenField hfitemcode;
        TextBox txtRemarks=null;
        foreach (GridViewRow gv in gvStockItems.Rows)
        {
            txtAdd = gv.FindControl("txtAdd") as TextBox;
            txtSub = gv.FindControl("txtSubtract") as TextBox;
            hfitemcode = gv.FindControl("hfItem_Code") as HiddenField;
            txtExpiry = gv.FindControl("txtExpiry") as TextBox;
            txtRate = gv.FindControl("txtRate") as TextBox;
            HiddenField hfStock = gv.FindControl("hfStock") as HiddenField;
            CheckBox chkbox = gv.FindControl("chksingle") as CheckBox;
            txtRemarks = gv.FindControl("txtRemarks") as TextBox;
             
            if (chkbox.Checked == true)
            {
                if (Convert.ToDouble(txtAdd.Text) > 0)
                {
                    chkforAdd = chkforAdd + 1;
                    ItemAdd_XML = ItemAdd_XML + "<row><Item_Code>" + hfitemcode.Value + "</Item_Code><Stock>"+hfStock.Value+"</Stock><AdditionQty>" + txtAdd.Text + "</AdditionQty><Rate>"+ txtRate .Text+ "</Rate><ExpiryDate>" + txtExpiry.Text + "</ExpiryDate><remarks>" + txtRemarks.Text + "</remarks></row>";
                }
                if(Convert.ToDouble(txtSub.Text) > 0)
                {
                    chkforSub = chkforSub + 1;
                    ItemSub_XML = ItemSub_XML + "<row><item_code>" + hfitemcode.Value + "</item_code><stock>" + hfStock.Value + "</stock><qty>" + txtSub.Text + "</qty><remarks>" + txtRemarks.Text + "</remarks></row>";
                }
            }
        }
        ItemAdd_XML = ItemAdd_XML + "</table>";
        ItemSub_XML = ItemSub_XML + "</table>";

        if (chkforAdd > 0)
        {
            // Add Wala Procedure
            DbManager dbm = new DbManager();
            SqlParameter[] sp = {
            new SqlParameter("@Emp_Id", Session["Emp_Id"].ToString()),
            new SqlParameter("@Dept_Id",Session["Dept_Id"].ToString()),
            new SqlParameter("@SubDept_Id", ddlLocation.SelectedValue),
            new SqlParameter("@XML_Addition", ItemAdd_XML),
            new SqlParameter("@Remarks", txtRemarks.Text),
            
        };
            dbm.ExecuteNonQuery("uspStockAdjusmentAddition", "StoreConnectionString", sp);
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Record Updated Successfully!";
        }
        else if(chkforSub>0 )
        {
            // Subtract wala Procedure
            DbManager dbm = new DbManager();
            SqlParameter[] sp = {
            new SqlParameter("@Emp_Id", Session["Emp_Id"].ToString()),
            new SqlParameter("@Dept_Id",Session["Dept_Id"].ToString()),
            new SqlParameter("@SubDept_Id", ddlLocation.SelectedValue),
            new SqlParameter("@ItemSub_XML", ItemSub_XML),
             new SqlParameter("@Remarks", txtRemarks.Text),
        };
            dbm.ExecuteNonQuery("uspStockAdjusmentSubtraction", "StoreConnectionString", sp);
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Record Updated Successfully!";
        }
        else
        {
            lblMsg.Text = "Please Select Atleast One Item";
        }

        btnSearch_Click(sender, e);
    }
    



}