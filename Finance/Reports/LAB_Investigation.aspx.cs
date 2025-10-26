using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;

public partial class Finance_Reports_LAB_Investigation : System.Web.UI.Page
{
    ReportDocument doc = new ReportDocument(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList_HospitalId.DataBind();

           DropDownList_HospitalId.Items.Insert(0, "All");
            DropDownList_HospitalId.Items[0].Value = "0";
            //DateTime first = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            //DateTime last = first.AddMonths(1).AddDays(-1);
            WebDateChooser1.Value = DateTime.Now;
            //WebDateChooser2.Value = Convert.ToDateTime(last);
            DateTime t;
            t = Convert.ToDateTime(WebDateChooser1.Value);
            HiddenField1.Value = Convert.ToString(t.ToShortDateString()) + " 12:00:00 AM";
            HiddenField2.Value = Convert.ToString(t.ToShortDateString()) + " 11:59:59 PM";

        }
        ShowRpt();
    }
    protected void ShowRpt()
    {
        AdminReports ds = new AdminReports();
        AdminReportsTableAdapters.LAB_INVESTIGATIONTableAdapter da = new AdminReportsTableAdapters.LAB_INVESTIGATIONTableAdapter();
        da.FillByHospitalId(ds.LAB_INVESTIGATION, Convert.ToDateTime(HiddenField1.Value), Convert.ToDateTime(HiddenField2.Value), Convert.ToInt32(DropDownList_HospitalId.SelectedValue));
        AdminReportsTableAdapters.Hospital_HeaderTableAdapter hda = new AdminReportsTableAdapters.Hospital_HeaderTableAdapter();
        int i = 0;
        if (DropDownList_HospitalId.SelectedValue == "0")
        {
            i = 11;
        }
        else
        {
            i = Convert.ToInt32(DropDownList_HospitalId.SelectedValue);
        }
        hda.Fill(ds.Hospital_Header, i);
        String path = Server.MapPath("LAB_Investigation.rpt");

        doc.FileName = path;
        doc.Database.Tables["Hospital_Header"].SetDataSource(ds.Tables["Hospital_Header"]);
        doc.Database.Tables["LAB_INVESTIGATION"].SetDataSource(ds.Tables["LAB_INVESTIGATION"]);
        doc.SetParameterValue("ReportDate", "( Dated: " + Convert.ToDateTime(WebDateChooser1.Value).ToShortDateString() + " )");
        CrystalReportViewer1.ReportSource = doc;
        CrystalReportViewer1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime t;
        t = Convert.ToDateTime(WebDateChooser1.Value);
        HiddenField1.Value = Convert.ToString(t.ToShortDateString()) + " 12:00:00 AM";
        HiddenField2.Value = Convert.ToString(t.ToShortDateString()) + " 11:59:59 PM";
        ShowRpt();
    }
}
