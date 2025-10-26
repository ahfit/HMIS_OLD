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

public partial class Patient_CashSubmittedDateWiseCollective : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            DDL_Hospital.DataBind();
            DDL_Hospital.SelectedValue=Session["HospitalID"].ToString();

            GetCounterType();
            if (!string.IsNullOrEmpty(Request.QueryString["Sdate"]))
            {
                WebDateChooser_SDate.Value = Request.QueryString["Sdate"].ToString();
            }
            else {
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
                Btn_Approve.Visible = false;
                BTn_Deposit.Visible = false;

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
        lnkCategoryWiseRevenue.NavigateUrl = "ServiceCatWiseRevenue.aspx?HId=" + DDL_Hospital.SelectedValue + "&CType=" + DDL_CounterType.SelectedValue + "&SDate=" + Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy-MM-dd") + "&EDate=" + Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy-MM-dd");
        lnkCategoryWiseDrCR.NavigateUrl = "FinaceHeadWiseDrCr.aspx?HId=" + DDL_Hospital.SelectedValue + "&CType=" + DDL_CounterType.SelectedValue + "&SDate=" + Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy-MM-dd") + "&EDate=" + Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy-MM-dd");
    }
    protected void LoadReport()
    {
        

        //Response.Write("Date = " + TXT_Date.Text + "   Hos_ID" + DDL_Hospital.SelectedValue.ToString());
       
        SDS_Report.SelectParameters["Date"].DefaultValue =WebDateChooser_SDate.Value.ToString();
        SDS_Report.SelectParameters["Hos_ID"].DefaultValue = DDL_Hospital.SelectedValue.ToString();
        SDS_Report.SelectParameters["Emp_ID"].DefaultValue = DDL_Employee.SelectedValue.ToString();
        SDS_Report.SelectParameters["EDate"].DefaultValue = WebDateChooser_EDate.Value.ToString();
        SDS_Report.SelectParameters["Shift_id"].DefaultValue = DDL_Shift.SelectedValue;
        SDS_Report.SelectParameters["CounterType"].DefaultValue = DDL_CounterType.SelectedValue;
        
        Gv_Report.DataBind();
        Gv_Report.Visible = true;
        ReportViewer1.Visible = false;
        if (Gv_Report.Rows.Count>0)
        {
            lnkCategoryWiseRevenue.Visible = true;
            //lnkCategoryWiseDrCR.Visible = true;
            //btnReport.Visible = true;

        }
        else
        {
            lnkCategoryWiseRevenue.Visible = false;
           // lnkCategoryWiseDrCR.Visible = false;
           // btnReport.Visible = false;
        }
    }
    protected void Chk_Head_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox HCh = (CheckBox)sender;
        CheckBox Ch = new CheckBox();
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            Ch = (CheckBox)row.FindControl("Chk_Add");
            if (Ch.Visible)

            {
                Ch.Checked = HCh.Checked;
            }
        }
    }
    protected void BTn_Deposit_Click(object sender, EventArgs e)
    {
        int Current = 0;
      
        CheckBox Ch = new CheckBox();
        Label lb_amount = new Label();
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            Ch = (CheckBox)row.FindControl("Chk_Add");

            if (Ch.Checked == true)
            {
                try
                {
                    lb_amount = (Label)row.FindControl("lblCash");
                    Current += Convert.ToInt32(lb_amount.Text);
        
                }
                catch
                { 
                
                }
            }
        }
        txt_TotalAmount.Text = Current.ToString();
        txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        Panel1.Visible = true;
        Button2.Enabled = true;
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        try
        {
            SDS_Deposit.Insert();
            LBl_Msg.Text = "Deposit in Bank";
            Button2.Enabled = false;
        }
        
        catch( Exception ex )
        { 
            LBl_Msg.Text = "Could not Deposit" +ex.Message;
        }
        if (!string.IsNullOrEmpty(HF_Voucher_Trans_ID.Value))
        {
            foreach (GridViewRow row in Gv_Report.Rows)
            {
                CheckBox Ch = (CheckBox)row.FindControl("Chk_Add");
                if (Ch.Checked == true)
                {
                    try
                    {
                        
                        HiddenField Shift = (HiddenField)row.FindControl("hf_Shift_ID");
                        HiddenField subdept = (HiddenField)row.FindControl("HF_Subdept_id");
                        HiddenField Hospital = (HiddenField)row.FindControl("Hf_Hospital");
                        HiddenField hf_emp_id = (HiddenField)row.FindControl("HF_emp_id");
                        HiddenField hf_Voucher = (HiddenField)row.FindControl("HF_Ent_Voucher");
                        HiddenField hf_ac_id = row.FindControl("HF_Acc_ID") as HiddenField;

                        
                        SDS_Report.UpdateParameters["shift_id"].DefaultValue = Shift.Value;
                        SDS_Report.UpdateParameters["Subdept_id"].DefaultValue = subdept.Value;
                        SDS_Report.UpdateParameters["Deposit_By"].DefaultValue = Session["Emp_id"].ToString();
                        SDS_Report.UpdateParameters["Emp_id"].DefaultValue = hf_emp_id.Value;
                        SDS_Report.UpdateParameters["Submitted_Date"].DefaultValue = WebDateChooser_SDate.Value.ToString();
                        SDS_Report.UpdateParameters["EntryVoucher_Trans_ID"].DefaultValue = HF_Voucher_Trans_ID.Value;
                        SDS_Report.UpdateParameters["Voucher_Trans_ID"].DefaultValue = HF_Voucher_Trans_ID.Value;
                        SDS_Report.UpdateParameters["rec_amount_ID"].DefaultValue = hf_ac_id.Value;
                        SDS_Report.UpdateParameters["Submitted_DateEnd"].DefaultValue = WebDateChooser_EDate.Value.ToString();

                        SDS_Report.Update();
                        Ch.Checked = false;   
                    }
                    catch (Exception ex)
                    {
                        LBl_Msg.Text = ex.Message;
                    }
                    Gv_Report.DataBind();
                    Button2.Visible = false;
                    Button3.Text = "Close";
                }
            }
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        LBl_Msg.Text = string.Empty;
        Button2.Visible = true;
        Button3.Text = "close";

    }
    protected void SDS_Deposit_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        HF_Voucher_Trans_ID.Value = e.Command.Parameters["@Voucher_Trans_ID"].Value.ToString();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;

        Session.Add("VTI",lbtn.CommandArgument);
        Response.Redirect("~/finance/CReport_Recipt_Voucher.aspx");
    }
    protected void Btn_Approve_Click(object sender, EventArgs e)
    {
        DateTime Counter_Close_Date = DateTime.Now;
        //string record = "<Data>";
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            
            CheckBox chk = row.FindControl("Chk_EV") as CheckBox;
            if (chk.Checked)
            {
                HiddenField hf_ac_id = row.FindControl("HF_Acc_ID") as HiddenField;
                HiddenField HF_emp_id = row.FindControl("HF_emp_id") as HiddenField;

                SDS_Voucher.InsertParameters["Receiving_Amount_ID"].DefaultValue = hf_ac_id.Value;                
                SDS_Voucher.InsertParameters["EmpId"].DefaultValue = HF_emp_id.Value;

                SDS_Voucher.Insert();
                Gv_Report.DataBind();
                lblMsg.Text = string.Empty;


                //if (!string.IsNullOrEmpty(hf_ac_id.Value))
                //{
                //     record = record + "<row><Rec_ID>" + hf_ac_id.Value + "</Rec_ID></row>";
                //}

            }
        }
        //record = record + "</Data>";
        //if (record == "<Data></Data>")
        //{
        //    lblMsg.Text = "No voucher Posted...";
        //}
        //else
        //{
        //    SDS_Voucher.InsertParameters["Receiving_Amount_ID"].DefaultValue = record;
        //    SDS_Voucher.InsertParameters["CounterDate"].DefaultValue = WebDateChooser_SDate.Value.ToString();

        //    SDS_Voucher.Insert();
        //    Gv_Report.DataBind();
        //    lblMsg.Text = string.Empty;
        //}
        
    }
    protected void CHK_approve_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox HCh = (CheckBox)sender;
        CheckBox Ch = new CheckBox();
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            Ch = (CheckBox)row.FindControl("Chk_EV");

            if (Ch.Visible)
            {
                Ch.Checked = HCh.Checked;
            }

        }
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


                HiddenField  HF_emp_id = (HiddenField)row.FindControl("HF_emp_id");
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
                catch (Exception ex )
                {                    
                }
                
                //Co.place_Coma(lblCash.Text);
                lnkTicket.NavigateUrl = "FinaceHeadWiseDrCr.aspx?HId=" + DDL_Hospital.SelectedValue + "&CType=" + DDL_CounterType.SelectedValue + "&SDate=" + Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy-MM-dd") + "&EDate=" + Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy-MM-dd") + "&EmpId=" + HF_emp_id.Value + "&TicketNo=" + HF_Acc_ID.Value;
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
    protected void Button4_Click(object sender, EventArgs e)
    {
        string url = "~/Patient Billing/Cash_Book_report.aspx?Hid=" + DDL_Hospital.SelectedValue + "&SDID=0&ShID=0&Dt=" + WebDateChooser_SDate.Value + "&VS=1&EID=0&VID=-1&AR=1&Edate=" + WebDateChooser_EDate.Value + "&PID=0&DID=0";
        Response.Redirect(url);
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        string url = "~/Patient Billing/Cash_Book_report.aspx?Hid=" + DDL_Hospital.SelectedValue + "&SDID=0&ShID=0&Dt=" + WebDateChooser_SDate.Value + "&VS=1&EID=0&VID=-1&Edate=" + WebDateChooser_EDate.Value + "&PID=0";
        Response.Redirect(url);
    }
    protected void lnkEdit_Click(object sender, System.EventArgs e)
    {
        LinkButton btnEdit = (LinkButton)sender;
        int id = Convert.ToInt32(btnEdit.CommandArgument);
        GridViewRow gvRow =(GridViewRow)btnEdit.NamingContainer;
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


    protected void btnReport_Click(object sender, System.EventArgs e)
    {
        Response.Redirect("NewCashReport.aspx?Sdate=" + WebDateChooser_SDate.Value.ToString() + "&Edate=" + WebDateChooser_EDate.Value.ToString() + "&Hid=" + DDL_Hospital.SelectedValue + "&SID=" + DDL_Shift.SelectedValue + "&CounterType=" + DDL_CounterType.SelectedValue);

    }

    protected void btnCategoryWise_Click(object sender, EventArgs e)
    {
        Response.Redirect("CashReportCategoryWise.aspx?Sdate=" + WebDateChooser_SDate.Value.ToString() + "&Edate=" + WebDateChooser_EDate.Value.ToString() + "&Hid=" + DDL_Hospital.SelectedValue + "&SID=" + DDL_Shift.SelectedValue);
    }

    protected void SDS_Voucher_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {

    }
    protected void LoadReportForCashSubmittedDateWise()
    {
        string dateFrom = Convert.ToDateTime(WebDateChooser_SDate.Value).ToString("yyyy/MM/dd");
        string dateTo = Convert.ToDateTime(WebDateChooser_EDate.Value).ToString("yyyy/MM/dd");

        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con = new SqlConnection(conString);
            con.Open();
            
            cmd = new SqlCommand("Cash_Submitted_Date_wise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Date", dateFrom);
            cmd.Parameters.AddWithValue("@Hos_ID", DDL_Hospital.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@Emp_ID", DDL_Employee.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@EDate", dateTo);
            cmd.Parameters.AddWithValue("@Shift_id", DDL_Shift.SelectedValue);
            cmd.Parameters.AddWithValue("@CounterType", DDL_CounterType.SelectedValue);
            //cmd.Parameters.AddWithValue("@empid", DDL_Employee.SelectedValue);



            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da = new SqlDataAdapter(cmd);
            DataTable dt2 = new DataTable();
            da.Fill(dt2);
            ReportDataSource rds = new ReportDataSource();
            rds.Name = "DataSet1";
            rds.Value = dt2;

            ReportViewer1.LocalReport.DataSources.Clear();

            string reportPath = Server.MapPath("~/Patient Billing/CashSubmittedDateWiseCollectiveReport.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;

            ReportViewer1.LocalReport.DataSources.Add(rds);


            ReportParameter rp = new ReportParameter("SDate", dateFrom);
            ReportParameter rp2 = new ReportParameter("EDate",dateTo);

            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });

            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt2));

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

            //else
            {
                ReportViewer1.Visible = true;
            }

        }
        catch (Exception ex)
        {

            con.Close();
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

    protected void BtnReportCashSubmittedDateWise_Click(object sender, EventArgs e)
    {
        Gv_Report.Visible = false;
        LoadReportForCashSubmittedDateWise();

    }
}