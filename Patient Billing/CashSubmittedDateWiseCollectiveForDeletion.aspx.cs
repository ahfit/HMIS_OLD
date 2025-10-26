using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Patient_Billing_CashSubmittedDateWiseCollectiveForDeletion : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {
            DDL_Hospital.DataBind();
            DDL_Hospital.SelectedValue = Session["HospitalID"].ToString();

            GetCounterType();
            if (!string.IsNullOrEmpty(Request.QueryString["Sdate"]))
            {
                WebDateChooser_SDate.Value = Request.QueryString["Sdate"].ToString();
            }
            else
            {
                WebDateChooser_SDate.Value = DateTime.Now;
            }
            if (!string.IsNullOrEmpty(Request.QueryString["Edate"]))
            {
                WebDateChooser_EDate.Value = Request.QueryString["Edate"];
            }
            else
            {
                WebDateChooser_EDate.Value = DateTime.Now;
            }
            if (!string.IsNullOrEmpty(Request.QueryString["SFT"]))
            {
                DDL_Shift.SelectedValue = Request.QueryString["SFT"] as string;

            }
            else
            {
                DDL_Shift.SelectedValue = "0";
            }
            if (!string.IsNullOrEmpty(Request.QueryString["VD"]))
            {

            }
            else
            {
                DDL_Shift.SelectedValue = "0";
            }





            // ============================================
            //              Shift Selection
            // ============================================


        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadReport();
        //   lnkCategoryWiseRevenue.NavigateUrl = "ServiceCatWiseRevenue.aspx?HId=" + DDL_Hospital.SelectedValue + "&CType=" + DDL_CounterType.SelectedValue + "&SDate=" + Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy-MM-dd") + "&EDate=" + Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy-MM-dd");
        //   lnkCategoryWiseDrCR.NavigateUrl = "FinaceHeadWiseDrCr.aspx?HId=" + DDL_Hospital.SelectedValue + "&CType=" + DDL_CounterType.SelectedValue + "&SDate=" + Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy-MM-dd") + "&EDate=" + Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy-MM-dd");
    }
    protected void LoadReport()
    {


        //Response.Write("Date = " + TXT_Date.Text + "   Hos_ID" + DDL_Hospital.SelectedValue.ToString());

        SDS_Report.SelectParameters["Date"].DefaultValue = WebDateChooser_SDate.Value.ToString();
        SDS_Report.SelectParameters["Hos_ID"].DefaultValue = DDL_Hospital.SelectedValue.ToString();
        SDS_Report.SelectParameters["Emp_ID"].DefaultValue = DDL_Employee.SelectedValue.ToString();
        SDS_Report.SelectParameters["EDate"].DefaultValue = WebDateChooser_EDate.Value.ToString();
        SDS_Report.SelectParameters["Shift_id"].DefaultValue = DDL_Shift.SelectedValue;
        SDS_Report.SelectParameters["CounterType"].DefaultValue = DDL_CounterType.SelectedValue;

        Gv_Report.DataBind();
        Gv_Report.Visible = true;

        if (Gv_Report.Rows.Count > 0)
        {
            // lnkCategoryWiseRevenue.Visible = true;
            //lnkCategoryWiseDrCR.Visible = true;
            //btnReport.Visible = true;

        }
        else
        {
            // lnkCategoryWiseRevenue.Visible = false;
            // lnkCategoryWiseDrCR.Visible = false;
            // btnReport.Visible = false;
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;

        Session.Add("VTI", lbtn.CommandArgument);
        Response.Redirect("~/finance/CReport_Recipt_Voucher.aspx");
    }


    public static string Right(string original, int numberCharacters)
    {
        return original.Substring(original.Length - numberCharacters);
    }
    protected void Gv_Report_PreRender(object sender, EventArgs e)
    {
        if (Gv_Report.Rows.Count > 0)
        {
            Label lblCash = new Label();
            Label lblCreditAmount = new Label();
            Label lblBankAmount = new Label();
            Label lblReceivableAmount = new Label();
            Label lblPanelAmount = new Label();

            HyperLink lnkTicket = new HyperLink();

            int totalCash = 0, totalCredit = 0, totalBank = 0,
                totalReceivable = 0, totalPanel = 0;


            Coma Co = new Coma();
            foreach (GridViewRow row in Gv_Report.Rows)
            {
                lblCash = (Label)row.FindControl("lblCash");
                lblCreditAmount = (Label)row.FindControl("lblCreditAmount");
                lblBankAmount = (Label)row.FindControl("lblBankAmount");
                lblReceivableAmount = (Label)row.FindControl("lblReceivableAmount");
                lblPanelAmount = (Label)row.FindControl("lblPanelAmount");

                lnkTicket = (HyperLink)row.FindControl("lnkTicket");


                HiddenField HF_emp_id = (HiddenField)row.FindControl("HF_emp_id");
                HiddenField HF_Acc_ID = (HiddenField)row.FindControl("HF_Acc_ID");

                Co.Remove_Coma(lblCash.Text);
                Co.Remove_Coma(lblCreditAmount.Text);
                Co.Remove_Coma(lblBankAmount.Text);
                Co.Remove_Coma(lblReceivableAmount.Text);
                Co.Remove_Coma(lblPanelAmount.Text);

                try
                {
                    totalCash = totalCash + Convert.ToInt32(lblCash.Text);
                    totalCredit = totalCredit + Convert.ToInt32(lblCreditAmount.Text);
                    totalBank = totalBank + Convert.ToInt32(lblBankAmount.Text);
                    totalReceivable = totalReceivable + Convert.ToInt32(lblReceivableAmount.Text);
                    totalPanel = totalPanel + Convert.ToInt32(lblPanelAmount.Text);
                }
                catch (Exception ex)
                {
                }
            }

            Label lblTotal_Cash = (Label)Gv_Report.FooterRow.FindControl("lblTotal_Cash");
            Label lblTotal_CreditAmount = (Label)Gv_Report.FooterRow.FindControl("lblTotal_CreditAmount");
            Label lblTotal_BankAmount = (Label)Gv_Report.FooterRow.FindControl("lblTotal_BankAmount");
            Label lblTotal_ReceivableAmount = (Label)Gv_Report.FooterRow.FindControl("lblTotal_ReceivableAmount");
            Label lblTotal_PanelAmount = (Label)Gv_Report.FooterRow.FindControl("lblTotal_PanelAmount");

            lblTotal_Cash.Text = totalCash.ToString();
            lblTotal_CreditAmount.Text = totalCredit.ToString();
            lblTotal_BankAmount.Text = totalBank.ToString();
            lblTotal_ReceivableAmount.Text = totalReceivable.ToString();
            lblTotal_PanelAmount.Text = totalPanel.ToString();

            //if (!String.IsNullOrEmpty(Request.QueryString["VD"]))
            //{
            // Gv_Report.Columns[14].Visible = false;
            // Gv_Report.Columns[15].Visible = false;

            //}
        }
    }

    protected void lnkEdit_Click(object sender, System.EventArgs e)
    {
        LinkButton btnEdit = (LinkButton)sender;
        int id = Convert.ToInt32(btnEdit.CommandArgument);
        GridViewRow gvRow = (GridViewRow)btnEdit.NamingContainer;
        Infragistics.WebUI.WebSchedule.WebDateChooser wdc = (Infragistics.WebUI.WebSchedule.WebDateChooser)gvRow.FindControl("WebDateChooser_DischargeDate");
        if (btnEdit.Text == "Edit")
        {
            wdc.Enabled = true;
            btnEdit.Text = "Update";
        }
        else
        {
            updateDate(Convert.ToDateTime(wdc.Value).ToString("yyyy-MM-dd"), id);
            wdc.Enabled = false;
            Gv_Report.DataBind();
            btnEdit.Text = "Edit";
        }
    }
    protected void updateDate(string dt, int id)
    {
        string conStr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        string query = "UpdateTokenNoAmountafterClosing";
        SqlCommand cmd = new SqlCommand(query, con);
        con.Open();
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@ID", id);
        cmd.Parameters.AddWithValue("@DateTime", dt);
        cmd.ExecuteNonQuery();
        con.Close();
        CounterCloseTrack(id);


    }

    private void CounterCloseTrack(int dt)
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("INSERT INTO CounterCloseTracking (TokanNo,Date,Empid) VALUES (@TokanNo,@Date,@Empid)", con);
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.AddWithValue("@TokanNo", dt);
            cmd.Parameters.AddWithValue("@Date", DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@Empid", Session["Emp_id"].ToString());
            cmd.ExecuteNonQuery();
            con.Close();
        }
        catch (Exception ex)
        {

            con.Close();
        }

    }
    private void GetCounterType()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            cmd = new SqlCommand("select 'ALL' countertype  union select distinct countertype from Receptionist  ", con);
            cmd.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDL_CounterType.DataSource = dt;
            DDL_CounterType.DataTextField = "countertype";
            DDL_CounterType.DataValueField = "countertype";
            DDL_CounterType.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }




    protected void btnCategoryWise_Click(object sender, EventArgs e)
    {
        Response.Redirect("CashReportCategoryWise.aspx?Sdate=" + WebDateChooser_SDate.Value.ToString() + "&Edate=" + WebDateChooser_EDate.Value.ToString() + "&Hid=" + DDL_Hospital.SelectedValue + "&SID=" + DDL_Shift.SelectedValue);
    }

    protected void SDS_Voucher_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }




    protected void btnDeleteCounterClose_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(conString))
        {
            Button btnDelete = (Button)sender;
            GridViewRow row = (GridViewRow)btnDelete.NamingContainer;
            HyperLink c = (HyperLink)row.FindControl("lnkTicket");
            HiddenField hfd_empid = (HiddenField)row.FindControl("hfd_empid");


            SqlCommand cmd = new SqlCommand();
            cmd.Connection = con;

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.CommandText = "uspDeleteCounterCloseEntry";

            cmd.Parameters.AddWithValue("@hfd_empid", hfd_empid.Value);
            cmd.Parameters.AddWithValue("@Payment_ticket", c.Text);

            cmd.Parameters.AddWithValue("@Empid", Session["Emp_id"].ToString());
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
            Gv_Report.DataBind();
            
        }
    }
}