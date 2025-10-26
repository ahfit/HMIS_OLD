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

           DropDownList_HospitalId.Items.Insert(0, "All Hospitals");
            DropDownList_HospitalId.Items[0].Value = "%";

            DropDownList_TGID.DataBind();
            DropDownList_TGID.Items.Insert(0, "All Groups");
            DropDownList_TGID.Items[0].Value = "%";
            DateTime first = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            DateTime last = first.AddMonths(1).AddDays(-1);
            WebDateChooser1.Value = Convert.ToDateTime(first);
            WebDateChooser2.Value = Convert.ToDateTime(last);
            DateTime t;
            t = Convert.ToDateTime(WebDateChooser1.Value);
            HiddenField1.Value = Convert.ToString(t.ToShortDateString()) + " 12:00:00 AM";
            t = Convert.ToDateTime(WebDateChooser2.Value);
            HiddenField2.Value = Convert.ToString(t.ToShortDateString()) + " 11:59:59 PM";
            HiddenField_Path.Value = "LAB_Investigation_Haematology_AmountGW.rpt";
        }
        ShowRpt(HiddenField_Path.Value);
    }
    protected void ShowRpt(String rptname)
    {
        AdminReports ds = new AdminReports();
       // AdminReportsTableAdapters. da = new AdminReportsTableAdapters.LAB_Investigation_HaematologyTableAdapter();
        AdminReportsTableAdapters.LAB_Investigation_Haematology_AmountTableAdapter da = new AdminReportsTableAdapters.LAB_Investigation_Haematology_AmountTableAdapter();
        //da.FillByHospitalId(ds.LAB_INVESTIGATION, Convert.ToDateTime(HiddenField1.Value), Convert.ToDateTime(HiddenField2.Value), Convert.ToInt32(DropDownList_HospitalId.SelectedValue));


        if (DropDownListSubDepartment.Visible == true)
        {
            da.Fill(ds.LAB_Investigation_Haematology_Amount, Convert.ToDateTime(HiddenField1.Value), Convert.ToDateTime(HiddenField2.Value), DropDownList_HospitalId.SelectedValue, DropDownList_TGID.SelectedValue, RadioButtonList1.SelectedValue, DropDownListSubDepartment.SelectedValue);
        }
        else
        {
            da.Fill(ds.LAB_Investigation_Haematology_Amount, Convert.ToDateTime(HiddenField1.Value), Convert.ToDateTime(HiddenField2.Value), DropDownList_HospitalId.SelectedValue, DropDownList_TGID.SelectedValue, RadioButtonList1.SelectedValue, "%");
        }
        AdminReportsTableAdapters.Hospital_HeaderTableAdapter hda = new AdminReportsTableAdapters.Hospital_HeaderTableAdapter();
        int i = 0;
        if (DropDownList_HospitalId.SelectedValue == "%")
        {
            i = 11;
        }
        else
        {
            i = Convert.ToInt32(DropDownList_HospitalId.SelectedValue);
        }
        hda.Fill(ds.Hospital_Header, i);
        
        
        String path = Server.MapPath(rptname);

        doc.FileName = path;
        doc.Database.Tables["Hospital_Header"].SetDataSource(ds.Tables["Hospital_Header"]);
        doc.Database.Tables["LAB_Investigation_Haematology_Amount"].SetDataSource(ds.Tables["LAB_Investigation_Haematology_Amount"]);
        doc.SetParameterValue("ReportDate", " From Date: " + Convert.ToDateTime(WebDateChooser1.Value).ToShortDateString() + " To: " + Convert.ToDateTime(WebDateChooser2.Value).ToShortDateString());
        doc.SetParameterValue("ForHospital", "For Hospital: " + DropDownList_HospitalId.SelectedItem.Text);
        doc.SetParameterValue("ForTG", "For Patient: " + DropDownList_TGID.SelectedItem.Text);
        //doc.SetParameterValue("ipdopd", "For Category: " + RadioButtonList1.SelectedItem.Text);
        if (DropDownListSubDepartment.Visible == true)
        {
            doc.SetParameterValue("ipdopd", "For Category: " + RadioButtonList1.SelectedItem.Text + " ( " + DropDownListSubDepartment.SelectedItem.Text + " )");
        }
        else
        {
            doc.SetParameterValue("ipdopd", "For Category: " + RadioButtonList1.SelectedItem.Text);
        }
        CrystalReportViewer1.ReportSource = doc;
        CrystalReportViewer1.DataBind();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string RptName = "LAB_Investigation_Haematology_Amount.rpt";
        HiddenField_Path.Value = "LAB_Investigation_Haematology_Amount.rpt";
        DateTime t;
        t = Convert.ToDateTime(WebDateChooser1.Value);
        HiddenField1.Value = Convert.ToString(t.ToShortDateString()) + " 12:00:00 AM";
        t = Convert.ToDateTime(WebDateChooser2.Value);
        HiddenField2.Value = Convert.ToString(t.ToShortDateString()) + " 11:59:59 PM";
        ShowRpt(RptName);
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string RptName = "LAB_Investigation_Haematology_AmountGW.rpt";
        HiddenField_Path.Value = "LAB_Investigation_Haematology_AmountGW.rpt";
        DateTime t;
        t = Convert.ToDateTime(WebDateChooser1.Value);
        HiddenField1.Value = Convert.ToString(t.ToShortDateString()) + " 12:00:00 AM";
        t = Convert.ToDateTime(WebDateChooser2.Value);
        HiddenField2.Value = Convert.ToString(t.ToShortDateString()) + " 11:59:59 PM";
        ShowRpt(RptName);
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (RadioButtonList1.SelectedValue == "IPD" || RadioButtonList1.SelectedValue == "OPD")
        {
            switch (RadioButtonList1.SelectedValue)
            {
                case "OPD":
                    HiddenField_DepartmentId.Value = "1";
                    break;
                case "IPD":
                    HiddenField_DepartmentId.Value = "2";
                    break;
            }
            Label_Dept.Visible = true;
            DropDownListSubDepartment.Visible = true;
            DropDownListSubDepartment.DataBind();
            DropDownListSubDepartment.Items.Insert(0, "All");
            DropDownListSubDepartment.Items[0].Value = "%";
        }
        else
        {
            Label_Dept.Visible = false;
            DropDownListSubDepartment.Visible = false;


        }
    }
    protected void DropDownList_HospitalId_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownListSubDepartment.DataBind();
        DropDownListSubDepartment.Items.Insert(0, "All");
        DropDownListSubDepartment.Items[0].Value = "%";
    }
}
