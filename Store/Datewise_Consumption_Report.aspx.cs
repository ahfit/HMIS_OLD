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

public partial class Datewise_Consumption_Report : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            WebDateChooser_SDate.Value = DateTime.Now.AddDays(-3);
            WebDateChooser_EDate.Value = DateTime.Now;

            DropDownList_Category.DataBind();
            bind_Department();
        }
    }


    protected void bind_Department()
    {
        SqlCommand cmd;
        try
        {
            SqlConnection con = new SqlConnection(conStr);
            string query = "select 0 SubDept_Id, ' --- ALL --- ' SubDept_Name union select SubDept_Id, SubDept_Name from SubDepartment";
            cmd = new SqlCommand(query, con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlDepartment.DataSource = dt;
            ddlDepartment.DataBind();
            ddlIssueDepartment.DataSource = dt;
            ddlIssueDepartment.DataBind();
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

            string name, order;


            if (txtItemName.Text == "")
            {
                name = "%";
            }
            else
                name = "%" + txtItemName.Text + "%";



            if (txtcode.Text == "")
            {
                order = "%";
            }
            else
                order = "%" + txtcode.Text + "%";

            ReportViewer1.LocalReport.DataSources.Clear();

            SqlConnection conn = new SqlConnection(conStr);
            SqlCommand cmd = new SqlCommand("Usp_DatewiseConsumptionReport", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string S_date = WebDateChooser_SDate.Value.ToString();
            string E_date = WebDateChooser_EDate.Value.ToString();

            cmd.Parameters.AddWithValue("@deptid", ddlIssueDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@Ideptid", ddlDepartment.SelectedValue);
            cmd.Parameters.AddWithValue("@S_Date", S_date);
            cmd.Parameters.AddWithValue("@E_Date", E_date);
            cmd.Parameters.AddWithValue("@ItemName", name);
            cmd.Parameters.AddWithValue("@itemCode", order);
            cmd.Parameters.AddWithValue("@empID", ddl_employee.SelectedValue);
            cmd.Parameters.AddWithValue("@Category", DropDownList_Category.SelectedValue);
            cmd.Parameters.AddWithValue("@SubCategory", ddlSubCategory.SelectedValue);
            cmd.Parameters.AddWithValue("@MrNo", txtMrNo.Text);
            cmd.Parameters.AddWithValue("@RequsitionType", ddlType.SelectedValue);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            conn.Close();

            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt;
            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("Date_Wise_Consumption_Report.rdlc");

            ReportViewer1.LocalReport.EnableHyperlinks = true;
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Store/Date_Wise_Consumption_Report.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(rds);




            ReportParameter rp = new ReportParameter("Start_Date", WebDateChooser_SDate.Value.ToString());
            ReportParameter rp2 = new ReportParameter("End_Date", WebDateChooser_EDate.Value.ToString());
            ReportParameter rp3 = new ReportParameter("Type", ddlType.SelectedItem.Text);
            ReportParameter rp4 = new ReportParameter("URL", GetSiteUrl());

            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2, rp3 });
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();


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

    protected void ddlDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddl_employee.DataBind();
    }
    public static string GetSiteUrl()
    {
        string url = string.Empty;
        HttpRequest request = HttpContext.Current.Request;

        if (request.IsSecureConnection)
            url = "https://";
        else
            url = "http://";

        url += request["HTTP_HOST"] + "/EverCare";
        return url;
    }
}