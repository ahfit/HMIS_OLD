using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;

public partial class Store_Qutation_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            LoadReport();
            
        }
    }
    protected void LoadReport()
    {

        if (Request.QueryString["RQ_ID"] != null)
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@Demand_RQ_ID", Request.QueryString["RQ_ID"])};
            
            DataTable dt = dbm.ExecuteDataTable("uspQutationReport", "STOREConnectionString",sp);
            DbManager dbm1 = new DbManager();
            SqlParameter[] sp1 = { new SqlParameter("@Requisition_ID", Request.QueryString["RQ_ID"]) };

            DataTable dt1 = dbm1.ExecuteDataTable("uspGetQutationApprovalAuthoritiesReport", "STOREConnectionString", sp1);
            ReportViewer1.LocalReport.DataSources.Clear();

            string reportPath = "";
            if(Request.QueryString["T"]!=null && Request.QueryString["T"]=="I")
            {
                reportPath = Server.MapPath("Qutation_Report_Import.rdlc");
            }
            else
            {
                reportPath = Server.MapPath("Qutation_Report.rdlc");
            }
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", dt1));
            //ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet.Copy());
            ReportViewer1.LocalReport.EnableHyperlinks = true;
            ReportParameter[] repParams = new ReportParameter[3];
            repParams[0] = new ReportParameter("HospitalID", (Session["Hospitalid"].ToString()));
            repParams[1] = new ReportParameter("EmpID", (Session["emp_id"].ToString()));
            repParams[2] = new ReportParameter("BaseUrl", (GetSiteUrl()));
            ReportViewer1.LocalReport.SetParameters(repParams);
            
            ReportViewer1.LocalReport.Refresh();
        }

    }
    public static string GetSiteUrl()
    {
        string url = string.Empty;
        HttpRequest request = HttpContext.Current.Request;

        if (request.IsSecureConnection)
            url = "https://";
        else
            url = "http://";

        url += request["HTTP_HOST"] + "/razifinal";

        return url;
    }
}