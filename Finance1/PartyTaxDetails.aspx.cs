using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Finance_PartyTaxDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            wdcStartDate.Value = DateTime.Now.AddDays(-7);
            wdcEndDate.Value = DateTime.Now;
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if(hfPartyId.Value!="-1" && txtParty.Text!="")
        {
            loadReportData();
        }
    }
    protected void loadReportData()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("usp_GetPartyTaxDetail", con);
        try
        {
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@Party_ID", hfPartyId.Value);
            cmd.Parameters.AddWithValue("@StartDate", wdcStartDate.Value.ToString());
            cmd.Parameters.AddWithValue("@EndDate", wdcEndDate.Value.ToString());
            SqlDataAdapter dr = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            dr.Fill(dt);
            ReportDataSource reportDataSource = new ReportDataSource();

            // Must match the DataSource in the RDLC
            reportDataSource.Name = "DataSet1";//coordinates in your case.
            reportDataSource.Value = dt;

            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("PartyTaxDetails.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();

            ReportViewer1.LocalReport.DataSources.Add(reportDataSource);
            ReportViewer1.LocalReport.Refresh();

            txtParty.Text = "";
            hfPartyId.Value = "-1";
        }
        catch(Exception ex)
        {

        }
        finally
        {

            con.Close();
            cmd.Dispose();
        }
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchCustomers(string prefixText, int count)
    {
        List<string> customers = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["FinanceConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "SELECT Party_Id, LTRIM(RTRIM(Party_Name)) as Party_Name FROM [Parties] WHERE     (LEN(LTRIM(RTRIM(Party_Name))) > 0) AND (Party_Name LIKE '%' + @Search + '%')  ORDER BY LTRIM(RTRIM(Party_Name))";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Party_Name"].ToString(), sdr["Party_Id"].ToString()));
        }
        return customers;
    }
}