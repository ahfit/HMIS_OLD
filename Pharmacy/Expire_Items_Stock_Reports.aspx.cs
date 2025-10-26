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

public partial class Store_Expire_Items_Stock_Reports : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            bind_Manufacturer();
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

            if (WebDateChooser_Date.Value == null || WebDateChooser_Date.Value.ToString() == String.Empty)
            {
                HfExpiryDate.Value = "1900-01-01";
            }
            else
            {
                HfExpiryDate.Value = Convert.ToDateTime(WebDateChooser_Date.Value).ToString("yyyy-MM-dd");
            }

            if (txtItemName.Text == "")
            {
                hfItemCode.Value = "";
            }
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParam = { new SqlParameter("@order_no", txtOrderNo.Text),
                                        new SqlParameter("@name", txtItemName.Text),
                                        new SqlParameter("@Subdept", DDL_Branch.SelectedValue),
                                        new SqlParameter("@Manufacturer", DropDownList_Manufacturer.SelectedValue),
                                        new SqlParameter("@Exp_NonExp", rdoExp.SelectedValue),
                                        new SqlParameter("@DeptId", Dropdownlistdepartment.SelectedValue),
                                        new SqlParameter("@ItemsOf", ddlStore.SelectedValue),
                                        new SqlParameter("@ExpiryDate", HfExpiryDate.Value)
            };


            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("usp_Item_Expired_Stock", "STOREConnectionString", sqlParam);

            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet_Item_Stock";//coordinates in your case.
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();
            if (ddlReportType.SelectedValue == "1")
            {
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Expire_Items_Stock_Reports.rdlc");
            }
            else if (ddlReportType.SelectedValue == "2")
            {
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Expire_Items_Stock_Reports_PurchaseDetail.rdlc");
            }
            else
            {
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("Expire_Items_Stock_Reports.rdlc");
            }
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
            Response.Write(ex.Message);

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

}