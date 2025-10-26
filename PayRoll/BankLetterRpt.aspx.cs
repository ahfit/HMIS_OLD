using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;
using System.Data;

public partial class PayRoll_BankLetterRpt : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ShowReport();
        }
    }

    private void ShowReport()
    {
        try
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            PayRoll ds = new PayRoll();
            string reportPath = Server.MapPath("~/Payroll/BankLetter.rdlc");
            PayRollTableAdapters.usp_BankLetterRptTableAdapter da = new PayRollTableAdapters.usp_BankLetterRptTableAdapter();
            da.Fill(ds.usp_BankLetterRpt, Convert.ToInt32(Request.QueryString["SBTID"]));

            DataTable dt = ds.Tables["usp_BankLetterRpt"];
            double sum = 0;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                sum += Convert.ToDouble(dt.Rows[i]["Salary_Amount"]);
            }


            AmountInWords amnt = new AmountInWords();
            string Salaryeng = amnt.In_Words(Convert.ToInt32(sum));
            ReportParameter[] repParams = new ReportParameter[1];
            repParams[0] = new ReportParameter("AmountInEng", Salaryeng);
          
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet.Copy());


            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.SetParameters(repParams);
            ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables["usp_BankLetterRpt"]));
            ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }

    }
}