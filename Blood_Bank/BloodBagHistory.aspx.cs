using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.Reporting.WebForms;
using System.Data.SqlClient;

public partial class Blood_Bank_BloodBagHistory : System.Web.UI.Page
{
    String connection = ConfigurationManager.ConnectionStrings["BloodBank_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ReportViewer1.Visible = false;
              WebDateChooser_FromDate.Value = DateTime.Now.AddDays(-12);
                WebDateChooser_Todate.Value = DateTime.Now.ToString();
                HiddenField_FromDate.Value = Convert.ToString (WebDateChooser_FromDate.Value);
                HiddenField_ToDate.Value =Convert.ToString ( WebDateChooser_Todate.Value);
            // WebDateChooser1.Enabled = false;
            //CheckBox1.Checked = false;
            //HiddenField_Date.Value = Convert.ToString(DateTime.Now);
            //RadioButtonList1.DataBind();
          //  ShowReport();

        }

    }
    protected void ShowReport()
    {
        //GridView_Results.Visible = false;
        //HiddenField_Date.Value = Convert.ToString(DateTime.Now);
        ////if (CheckBox1.Checked == true)
        ////{
        ////    sdsPatientCount.SelectParameters["Is_Date_Given"].DefaultValue = "1";

        ////}
        ////else
        ////{
        ////    sdsPatientCount.SelectParameters["Is_Date_Given"].DefaultValue = "0";

        ////}

        ////sdsPatientCount.SelectParameters["Condition"].DefaultValue = RadioButtonList1.SelectedValue;
        ////sdsPatientCount.SelectParameters["GivenDate"].DefaultValue = HiddenField_Date.Value;

        //DataView dv = sdsPatientCount.Select(DataSourceSelectArguments.Empty) as DataView;
        //DataTable dt = dv.Table;

        DataTable dt = new DataTable();
        SqlConnection conn = new SqlConnection(connection);
        try
        {
            SqlCommand sc = new SqlCommand("GETBloodDetailHostory", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@DRegNo", txtPName.Text);
            sc.Parameters.AddWithValue("@PRegNo", txtRegNo.Text);
            sc.Parameters.AddWithValue("@BagNo", txtCnic.Text);
            sc.Parameters.AddWithValue("@BG", DropDownList_BG.SelectedValue);
            sc.Parameters.AddWithValue("@DateFrom", WebDateChooser_FromDate.Value );
            sc.Parameters.AddWithValue("@DateTo", WebDateChooser_Todate.Value);

            SqlDataAdapter sda = new SqlDataAdapter(sc);
          
            sda.Fill(dt);

           

        }
        catch
        {

        }


        ReportViewer1.LocalReport.DataSources.Clear();
        string reportPath = Server.MapPath("~/Blood_Bank/DonorHistory.rdlc");
        ReportViewer1.LocalReport.ReportPath = reportPath;
        ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt));
        ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(subReports);

        ReportViewer1.LocalReport.Refresh();
        ReportViewer1.Visible = true;
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
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView_Results.DataBind();
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        if (CheckBox1.Checked == true)
        {
            WebDateChooser1.Enabled = true;
            if (WebDateChooser1.Value == null)
            {
                WebDateChooser1.Value = DateTime.Now;
                HiddenField_Date.Value = Convert.ToString(WebDateChooser1.Value);
            }
            else
            {
                HiddenField_Date.Value = Convert.ToString(WebDateChooser1.Value);
            }

        }
        else
        {
            if (WebDateChooser1.Value == null)
            {
                WebDateChooser1.Value = DateTime.Now;
                HiddenField_Date.Value = Convert.ToString(WebDateChooser1.Value);
            }
            else
            {
                HiddenField_Date.Value = Convert.ToString(WebDateChooser1.Value);
            }
            //WebDateChooser1.Enabled = false;
        }
        GridView_Results.DataBind();

    }
    protected void WebDateChooser1_ValueChanged(object sender, Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs e)
    {
        HiddenField_Date.Value = Convert.ToString(WebDateChooser1.Value);
        GridView_Results.DataBind();
    }
    protected void GridView_Results_PreRender(object sender, EventArgs e)
    {


    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 1);

    }
    private void ConvertToHyperLink(string gvRow, int Component_Id)
    {

        Response.Redirect("Stock_Expiry_Status.aspx?BGID=" + gvRow + "&Component_Id=" + Component_Id);
    }
    protected void LinkButton2_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 2);
    }
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 3);
    }
    protected void LinkButton4_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 4);
    }
    protected void LinkButton5_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 5);
    }
    protected void LinkButton6_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 6);
    }
    protected void LinkButton7_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 7);
    }
    protected void LinkButton8_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 8);
    }
    protected void LinkButton9_Click(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 9);
    }
    protected void LinkButton9_Click1(object sender, EventArgs e)
    {
        GridViewRow gvRow = (GridViewRow)(sender as Control).Parent.Parent;
        HiddenField HiddenField_BGID = (HiddenField)gvRow.FindControl("HiddenField_BGID");
        ConvertToHyperLink(HiddenField_BGID.Value, 9);
    }
    protected void btnreport_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        ShowReport();
    }
}
