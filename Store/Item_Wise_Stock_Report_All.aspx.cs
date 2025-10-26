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

public partial class Store_Item_Wise_Stock_Report_All : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList_Category.DataBind();
            DropDownList_Generic_ItemName.DataBind();
            bind_Manufacturer();
            binddepartment();
            bindSubdepartment();
            bindStores();
        }
    }


    protected void bind_Manufacturer()
    {
        SqlCommand cmd;
        try
        {
            SqlConnection con = new SqlConnection(conStr);
            string query = "select '--ALL--' as Manufacturer_Name,0 as ID union select Manufacturer_Name,Manufacturer_Id ID from Items_Manufacturer";
            cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_Manufacturer.DataSource = dt;
            DropDownList_Manufacturer.DataBind();
        }
        catch (Exception ex)
        {
        }
    }

    protected void binddepartment()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 Dept_Id,'------ ALL -----' as Dept_Name union Select Dept_Id,Dept_Name From Department Where Dept_Name like  @Dept_Name  Order By Dept_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@Dept_Name", "%") };

        ddlDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddlDepartment.DataTextField = "Dept_Name";
        ddlDepartment.DataValueField = "Dept_Id";
        ddlDepartment.DataBind();
    }

        protected void bindSubdepartment()
    {
        DbManager dbMgr = new DbManager();
        //        String query = @"Select 0 SubDept_Id,'------ ALL -----' as SubDept_Name,0 as Dept_Id 
        //union Select SubDept_Id,SubDept_Name,Dept_Id From SubDepartment Where (SubDept_Name like  @SubDept_Name) 
        //and (Dept_Id = @DeptId or @DeptId = 0)  Order By Dept_Id,SubDept_Name";
        String query = @"Select SubDept_Id,SubDept_Name,Dept_Id From SubDepartment Where (SubDept_Name like  @SubDept_Name) 
and (Dept_Id = @DeptId or @DeptId = 0)  Order By Dept_Id,SubDept_Name";
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%"), new SqlParameter("@DeptId",ddlDepartment.SelectedValue)};
        //ddlSubDepartment.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        //ddlSubDepartment.DataTextField = "SubDept_Name";
        //ddlSubDepartment.DataValueField = "SubDept_Id";
        //ddlSubDepartment.DataBind();

        chklstSubDepartments.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        chklstSubDepartments.DataTextField = "SubDept_Name";
        chklstSubDepartments.DataValueField = "SubDept_Id";
        chklstSubDepartments.DataBind();

       for (int i = 0; i<= chklstSubDepartments.Items.Count-1; i++)
       {
            chklstSubDepartments.Items[i].Selected = true;
        }
    }



    protected void bindStores()
    {
        DbManager dbMgr = new DbManager();
        String query = "Select 0 SubDept_Id,'------ ALL -----' SubDept_Name union Select SubDept_Id,SubDept_Name From SubDepartment Where SubDept_Name like '%Store%'";
        SqlParameter[] sqlParam = { new SqlParameter("@SubDept_Name", "%") };
        ddlStore.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "STOREConnectionString", sqlParam);
        ddlStore.DataTextField = "SubDept_Name";
        ddlStore.DataValueField = "SubDept_Id";
        ddlStore.DataBind();

    }
    protected void Button_Report_Click(object sender, EventArgs e)
    {
        try
        {
            ShowReport();
        }
        catch (Exception ex)
        {

        }

    }


    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));
        }
        catch (Exception)
        {

        }


    }

    private void ShowReport()
    {

        try
        {

            string manufacture, name, part, order;

            //check manufacturer
            if (DropDownList_Manufacturer.SelectedValue == "--ALL--")
            {
                manufacture = "%%";
            }
            else
                manufacture = DropDownList_Manufacturer.SelectedValue;


            //check item name
            if (txtItemName.Text == "")
            {
                name = "%%";
            }
            else
                name = txtItemName.Text;


            //check order no
            if (txtOrderNo.Text == "")
            {
                order = "%%";
            }
            else
                order = txtOrderNo.Text;



            //check part no
            if (txtPartno.Text == "")
            {
                part = "%%";
            }
            else
                part = txtPartno.Text;


            string data = "<data>";
            for (int i = 0; i <= chklstSubDepartments.Items.Count - 1; i++)
            {
                if (chklstSubDepartments.Items[i].Selected == true)
                {
                    data += "<row>";
                    data += "<subdeptid>" + chklstSubDepartments.Items[i].Value.ToString() + "</subdeptid>";
                    data += "</row>";
                }
            }
            data += "</data>";



            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("usp_Item_Wise_Stock_With_Par_Levels", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Category ", DropDownList_Category.SelectedValue);
            cmd.Parameters.AddWithValue("@SubCategory", DropDownList_Generic_ItemName.SelectedValue);
            cmd.Parameters.AddWithValue("@order_no ", order);
            cmd.Parameters.AddWithValue("@part_no", part);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@manufacture", manufacture);
            cmd.Parameters.AddWithValue("@Subdept", ddlSubDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@ForStore", ddlStore.SelectedValue);
            cmd.Parameters.AddWithValue("@SubDeptData", data);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);


            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Item_Wise_Stock_Report_All.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

           // else
                ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        {
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


    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        bindSubdepartment();
        chkSelect.Checked = true;
    }

    protected void chkSelect_CheckedChanged(object sender, EventArgs e)
    {
        for (int i = 0; i <= chklstSubDepartments.Items.Count - 1; i++)
        {
            chklstSubDepartments.Items[i].Selected = chkSelect.Checked;
        }
    }
}