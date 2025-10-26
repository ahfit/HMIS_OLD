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

public partial class Store_ItemExpiry : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);



    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bind_Department();
            DropDownList_Category.DataBind();
            DropDownList_Generic_ItemName.DataBind();
            bindGrids();
            // bindGrids();
        }
    }
    protected void bind_Department()
    {
        SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);

        SqlCommand cmd;
        try
        {

            string query = "select 0 SubDept_Id, ' --- ALL --- ' SubDept_Name union select SubDept_Id, SubDept_Name from SubDepartment where SubDept_Name Like '%Store%'";
            cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddl_SubDepartment.DataSource = dt;
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

                                 };
        DataSet ds = new DataSet();

        ds = dbMgr.ExecuteDataSet("uspGetMinMaxExpItems", "STOREConnectionString", sqlParm);
        GridViewMin.DataSource = ds.Tables[0];
        GridViewMin.DataBind();
        GridviewExp.DataSource = ds.Tables[2];
        GridviewExp.DataBind();

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
            Label minAlert = (Label)gvRow.FindControl("lblmin");
            Double min = 1;
            if (minAlert.Text != "")
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
}
