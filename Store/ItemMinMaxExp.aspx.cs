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


public partial class Store_ItemsDetails : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
   

    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ddl_Hospital.SelectedValue = Session["HospitalID"].ToString();
            ddl_Hospital.Enabled = false;
            bindHospital();
            ddlDepartment.SelectedValue= Session["dept_id"].ToString();
            ddlDepartment.DataBind();
            bind_Department();
            DropDownList_Category.DataBind();
            DropDownList_Generic_ItemName.DataBind();
           // bindGrids();
        }
    }
    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bind_Department();
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


    protected void bind_Department()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
        
        SqlCommand cmd;
        try
        {

            DbManager dbMgr = new DbManager();
            String query = "select SubDept_Id, SubDept_Name from SubDepartment where Dept_Id=@deptID";
            SqlParameter[] sqlParam = { new SqlParameter("@deptID", ddlDepartment.SelectedValue) };
            ddl_SubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
            ddl_SubDepartment.DataTextField = "SubDept_Name";
            ddl_SubDepartment.DataValueField = "SubDept_Id";
            ddl_SubDepartment.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
    protected void bindGrids()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParm = { new SqlParameter("@SubDeptID", ddl_SubDepartment.SelectedValue) 
                                 ,new SqlParameter("@Category", DropDownList_Category.SelectedValue)
                                 ,new SqlParameter("@SubCategory", DropDownList_Generic_ItemName.SelectedValue)
                                 ,new SqlParameter("@ItemName", txtItemName.Text.Trim())
                                 };
        DataSet ds = new DataSet();

        ds = dbMgr.ExecuteDataSet("uspGetMinMaxItems", "STOREConnectionString", sqlParm);
        GridViewMin.DataSource = ds.Tables[0];
        GridViewMin.DataBind();
        //GridviewExp.DataSource = ds.Tables[2];
        //GridviewExp.DataBind();

        con.Close();
       
    }

    protected void GridviewExp_PreRender(object sender, EventArgs e)
    {
        //foreach (GridViewRow gvRow in GridviewExp.Rows)
        //{
        //    Label daysRemaning = (Label)gvRow.FindControl("lblRemaningDays");
        //    if (Convert.ToDouble(daysRemaning.Text) <= 10)
        //    {
        //        gvRow.BackColor = System.Drawing.ColorTranslator.FromHtml("#f1c0c0");
        //    }
        //    else
        //    {

        //    }
        //}
    }
    protected void GridViewMin_PreRender(object sender, EventArgs e)
    {
        foreach (GridViewRow gvRow in GridViewMin.Rows)
        {
            Label qty = (Label)gvRow.FindControl("lblQtyR");
            TextBox minAlert = (TextBox)gvRow.FindControl("txtMinLevel");
            Double min = 1;
            if (minAlert.Text!="")
            {
                min = Convert.ToDouble(minAlert.Text);
            }
            if (Convert.ToDouble(qty.Text) < min)
            {
                gvRow.BackColor = System.Drawing.ColorTranslator.FromHtml("#f1c0c0");
            }
        }
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
        string data = "<data>";
        TextBox txtMinLevel;
        TextBox txtMaxLevel;
        TextBox txtReorderLevel;
        Label lblItemCode;
        HiddenField HfSubDeptId;
        int count = 0;
        foreach (GridViewRow grd in GridViewMin.Rows)
        {
            CheckBox chk = (CheckBox)grd.FindControl("chkSelect");
            if (chk.Checked == true)
            {
                
                txtMinLevel = (TextBox)grd.FindControl("txtMinLevel");
                txtMaxLevel = (TextBox)grd.FindControl("txtMaxLevel");
                txtReorderLevel = (TextBox)grd.FindControl("txtReorderLevel");
                lblItemCode = (Label)grd.FindControl("lblItemCode");
                HfSubDeptId = (HiddenField)grd.FindControl("HfSubDeptId");

                data += "<row>";
                data += "<itemcode>"+ lblItemCode.Text +"</itemcode>";
                data += "<minlevel>"+ txtMinLevel.Text.Trim() +"</minlevel>";
                data += "<maxlevel>"+ txtMaxLevel.Text.Trim() +"</maxlevel>";
                data += "<reorderlevel>"+ txtReorderLevel.Text.Trim() +"</reorderlevel>";
                data += "<subdeptid>" + HfSubDeptId.Value + "</subdeptid>";
                data += "</row>";
                count++;
            }
        }

        data += "</data>";
        if (count > 0)
        {
            DbManager db = new DbManager();
            SqlParameter[] param = new SqlParameter[] {
                new SqlParameter("EnterBy", Session["emp_id"]),
                new SqlParameter("SubDeptId", ddl_SubDepartment.SelectedValue),
                new SqlParameter("Itemdata", data)

            };
            db.ExecuteNonQuery("usp_UpdateItemMinMaxLevels", "STOREConnectionString", param);
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = "Items PAR levels updated successfully....";
        }
        else
        {
            lblMessage.Text = "select Items First....";
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
}
