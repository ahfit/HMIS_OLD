using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Store_CashSalePurchaseWithProfitInvoiceWise : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtStartDate.Text = (DateTime.Now.AddDays(-10)).ToString("yyyy-MM-dd");
            txtEndDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            getSubDepts();
        }
    }
    private void getSubDepts()
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);

        SqlCommand cmd = new SqlCommand("select * from SubDepartment where SubDept_Name like '%Pharmacy%' and SubDept_Name not like '%Store%'", conn);

        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        sda.Fill(dt);
        ddlSubDept.DataSource = dt;

        ddlSubDept.DataTextField = "SubDept_Name";
        ddlSubDept.DataValueField = "SubDept_Id";
        ddlSubDept.DataBind();
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = new[] { new SqlParameter("@EmpID", Session["emp_id"]) };
            string str = "Select Main_Subdept_ID From requisition_department_filter Where Requisition_Type='PHARMACY' and EmpID=@EmpID";

            DataTable dt1 = dbm.ExecuteDataTableWithQuery(str, "STOREConnectionString", sp);
            if ((dt1.Rows.Count > 0))
            {
                if ((dt1.Rows.Count == 1))
                    ddlSubDept.SelectedValue = dt1.Rows[0][0].ToString();
                else
                    ddlSubDept.SelectedValue = Session["subdeptid"].ToString();
            }
        }
        catch (Exception ex)
        {
        }
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
            if (txtItemName.Text == "")
            {
                hfItemCode.Value = "";
            }
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParam = { new SqlParameter("@start_Date", txtStartDate.Text),
                                        new SqlParameter("@End_Date", txtEndDate.Text),
                                        new SqlParameter("@item_code", hfItemCode.Value),
                                        new SqlParameter("@SubdeptID", ddlSubDept.SelectedValue)
                                        };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("usp_CashSalePurchaseWithProfitInvoiceWise", "STOREConnectionString", sqlParam);
            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet_Item_Stock";//coordinates in your case.
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("CashSalePurchaseWithProfitInvoiceWise.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
        }
        catch(Exception e)
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
    protected void txtItemName_TextChanged(object sender, EventArgs e)
    {
        if (String.IsNullOrEmpty(txtItemName.Text))
        {
            hfItemCode.Value = "";
        }
    }

}