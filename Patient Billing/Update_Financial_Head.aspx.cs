using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;

public partial class Patient_Billing_Update_Financial_Head : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Btn_Export_Click(object sender, EventArgs e)
    {

    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select S_ID,S_Name  from Admin_Services where S_Name LIKE '%' + @Search + '%' Or S_ID like '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["S_Name"].ToString(), sdr["S_ID"].ToString()));
        }
        return items;
    }
    protected void ddl_category_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
    protected void btn_export_Click(object sender, EventArgs e)
    {
        ShowAllComplaints();
    }

    private void ShowAllComplaints()
    {
        GridView1.DataBind();
        //string fileName = ("Category Wise Rate List" + ".xls");
        //Response.ClearContent();
        //Response.AddHeader("content-disposition", ("attachment;filename=" + fileName));
        //Response.ContentType = "application/excel";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter htm = new HtmlTextWriter(sw);
        //GridView repAllCustomers = this.GridView1;
        //repAllCustomers.AllowPaging = false;
        //repAllCustomers.CssClass = "grid_dash";
        //repAllCustomers.RenderControl(htm);
        //Response.Write(sw.ToString());
        //Response.End();
        // HF_is_Report.Value = "0";
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        // base.VerifyRenderingInServerForm(control);
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType==DataControlRowType.DataRow)
        {
            DropDownList ddlStatus = e.Row.FindControl("ddlStatus") as DropDownList;
            HiddenField hfStatus = e.Row.FindControl("hfStatus") as HiddenField;
            Label lblSID = e.Row.FindControl("lblSID") as Label;
            HiddenField hfdstatus = e.Row.FindControl("hfdstatus") as HiddenField;

            if (hfdstatus.Value == "Yes")
            {
                ddlStatus.Enabled = true;
            }

            SqlCommand cmd = new SqlCommand("SELECT  E_Code, E_Name FROM  Expenditure order by E_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable ds = new DataTable();
            da.Fill(ds);
            ddlStatus.DataSource = ds;
            ddlStatus.DataValueField = "E_Code";
            ddlStatus.DataTextField = "E_Name";
            ddlStatus.DataBind();

            SqlCommand cmd1 = new SqlCommand("Select Account_Head_ID from  Admin_Services where S_ID=@sid", con);
            SqlDataAdapter da1 = new SqlDataAdapter(cmd1);
            cmd1.Parameters.AddWithValue("@sid", lblSID.Text);
            DataTable ds1 = new DataTable();
            da1.Fill(ds1);
           
            ddlStatus.SelectedValue  = ds1.Rows[0][0].ToString();
          
        }
        

    }
    
    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row=GridView1.Rows[e.RowIndex] as GridViewRow;
        DropDownList ddlStatus = row.FindControl("ddlStatus") as DropDownList;
        Label S_ID = row.FindControl("lblSID") as Label;
        ddlStatus.Enabled = true;
        HiddenFieldSID.Value = S_ID.Text;
        HiddenFieldSHID.Value = ddlStatus.SelectedValue;
      //status.Value = ddlStatus.SelectedValue;

    }

    protected void GridView1_RowUpdating1(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = GridView1.Rows[e.RowIndex] as GridViewRow;
        DropDownList ddlStatus = row.FindControl("ddlStatus") as DropDownList;
        Label S_ID = row.FindControl("lblSID") as Label;
        ddlStatus.Enabled = true;
        HiddenFieldSID.Value = S_ID.Text;
        HiddenFieldSHID.Value = ddlStatus.SelectedValue;
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        if (this.GridView1.EditIndex == -1)
        {
            this.GridView1.EditIndex = e.NewEditIndex;



            GridViewRow currentRow = this.GridView1.Rows[e.NewEditIndex];

            DropDownList ddlStatus = currentRow.FindControl("ddlStatus") as DropDownList;
            HiddenField hfdstatus = currentRow.FindControl("hfdstatus") as HiddenField;
            ddlStatus.Enabled = true;
            HiddenFieldPHID.Value = ddlStatus.SelectedValue;
            hfdstatus.Value = "Yes";



        }
    }
}