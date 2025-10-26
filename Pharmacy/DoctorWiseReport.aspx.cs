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

public partial class Pharmacy_DocotrWiseReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            txtStartDate.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchDoctors(string prefixText, int count)
    {
        List<string> names = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select 0 EmpID,'Self' Name union Select EmpID,Name From Employee Where Name like '%'+@Search+'%' and Is_Consultant=1 Order by Name";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            names.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Name"].ToString(), sdr["EmpID"].ToString()));
        }
        return names;
    }
    protected void bindReport()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParam = { new SqlParameter("@StartDate", txtStartDate.Text),
                                        new SqlParameter("@EndDate", txtEndDate.Text),
                                        new SqlParameter("@DoctorID", hfDoctorID.Value),
                                        new SqlParameter("@PType", DropDownTypeWise.SelectedValue),

                                      };
            DataTable dt = new DataTable();
            dt = dbMgr.ExecuteDataTable("uspPharmacyDoctorRevnue", "STOREConnectionString", sqlParam);
            ReportDataSource reportDataSource = new ReportDataSource();
            ReportViewer1.LocalReport.DataSources.Clear();
            // Must match the DataSource in the RDLC

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("DoctorWiseReport.rdlc");
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message);
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindReport();
    }
}