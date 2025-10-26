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
using System.IO;

public partial class Patient_Billing_Cash_Submitted_Date_Wise : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
   
        if (!Page.IsPostBack)
        {
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
        
    }
    protected void LoadReport()
    {
        

        //Response.Write("Date = " + TXT_Date.Text + "   Hos_ID" + DDL_Hospital.SelectedValue.ToString());
       
        SDS_Report.SelectParameters["Date"].DefaultValue =WebDateChooser_SDate.Value.ToString();
        SDS_Report.SelectParameters["Hos_ID"].DefaultValue = DDL_Hospital.SelectedValue.ToString();
        SDS_Report.SelectParameters["Emp_ID"].DefaultValue = Session["Emp_id"].ToString();
        SDS_Report.SelectParameters["EDate"].DefaultValue = WebDateChooser_EDate.Value.ToString();
        SDS_Report.SelectParameters["Shift_id"].DefaultValue = DDL_Shift.SelectedValue;
        SDS_Report.SelectParameters["CounterType"].DefaultValue = DDL_CounterType.SelectedValue;
        
        Gv_Report.DataBind();
    }
    protected void Chk_Head_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox HCh = (CheckBox)sender;
        CheckBox Ch = new CheckBox();
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            Ch = (CheckBox)row.FindControl("Chk_Add");
            Ch.Checked = HCh.Checked;
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
                    lb_amount = (Label)row.FindControl("lbl_Amount");
                    Current += Convert.ToInt32(lb_amount.Text);

                }
                catch
                { 
                
                }
            }
        }
        txt_TotalAmount.Text = Current.ToString();
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

                        SDS_Report.Update();
                        
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

        foreach (GridViewRow row in Gv_Report.Rows)
        {
            CheckBox chk = row.FindControl("Chk_EV") as CheckBox;
            if (chk.Checked)
            {
                HiddenField hf_Shift = row.FindControl("hf_Shift_ID") as HiddenField;
                HiddenField hf_subdept = row.FindControl("HF_Subdept_id") as HiddenField;
                HiddenField hf_Department = row.FindControl("HF_Department") as HiddenField;
                HiddenField hf_emp_id = row.FindControl("HF_emp_id") as HiddenField;
                HiddenField hf_ac_id = row.FindControl("HF_Acc_ID") as HiddenField;
                if (!string.IsNullOrEmpty(WebDateChooser_SDate.Text))
                {
                    Counter_Close_Date = Convert.ToDateTime(WebDateChooser_SDate.Value);
                }

                SDS_Voucher.InsertParameters["shift_id"].DefaultValue =hf_Shift.Value;
                SDS_Voucher.InsertParameters["Dept_Id"].DefaultValue = hf_Department.Value;
                SDS_Voucher.InsertParameters["SubDept_Id"].DefaultValue = hf_subdept.Value;
                SDS_Voucher.InsertParameters["CCdate"].DefaultValue = Counter_Close_Date.Year.ToString() + Right("0" + Counter_Close_Date.Month.ToString(), 2) + Right("0" + Counter_Close_Date.Day.ToString(), 2);
                SDS_Voucher.InsertParameters["CC_Emp_Id"].DefaultValue = hf_emp_id.Value;
                SDS_Voucher.InsertParameters["Receiving_Amount_ID"].DefaultValue = hf_ac_id.Value;
                SDS_Voucher.Insert();
            }


        }
        Gv_Report.DataBind();
    }
    protected void CHK_approve_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox HCh = (CheckBox)sender;
        CheckBox Ch = new CheckBox();
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            Ch = (CheckBox)row.FindControl("Chk_EV");
            Ch.Checked = HCh.Checked;

        }
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.ContentType = "application/ms-excel";
        Response.AddHeader("content-disposition", "attachment;filename=Report.xls");
        Response.Charset = "";
        Response.Cache.SetCacheability(HttpCacheability.NoCache);

        StringWriter sw = new StringWriter();
        HtmlTextWriter hw = new HtmlTextWriter(sw);

        // Remove interactive controls if needed
        foreach (GridViewRow row in Gv_Report.Rows)
        {
            row.Cells[row.Cells.Count - 1].Controls.Clear();
        }

        Gv_Report.RenderControl(hw);

        Response.Output.Write("<html><body style='font-family:Arial;'>");
        Response.Output.Write(sw.ToString());
        Response.Output.Write("</body></html>");
        Response.Flush();
        Response.End();
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        // This is required to export GridView
    }

    public static string Right(string original, int numberCharacters)
    {
        return original.Substring(original.Length - numberCharacters);
    }
    protected void Gv_Report_PreRender(object sender, EventArgs e)
    {
        if (Gv_Report.Rows.Count > 0)
        {
            Label L_amount = new Label();
            int totalQty = 0;
           
            Coma Co = new Coma();
            foreach (GridViewRow row in Gv_Report.Rows)
            {
                L_amount = (Label)row.FindControl("lbl_Amount");
                Co.Remove_Coma(L_amount.Text);
                totalQty = totalQty + Convert.ToInt32(L_amount.Text);
                Co.place_Coma(L_amount.Text);
            }

            Label f_total = (Label)Gv_Report.FooterRow.FindControl("lbl_total");
            f_total.Text = totalQty.ToString();


            if (!String.IsNullOrEmpty(Request.QueryString["VD"]))
            {


                Gv_Report.Columns[14].Visible = false;
               Gv_Report.Columns[15].Visible = false;

            }
        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        string url = "~/Patient Billing/Cash_Book_Submitted_Report.aspx?Hid="+DDL_Hospital.SelectedValue+"&SDID=0&ShID=0&Dt="+WebDateChooser_SDate.Value+ "&VS=1&EID=0&VID=-1&AR=1&Edate="+WebDateChooser_EDate.Value+"&PID=0&DID=0";
        Response.Redirect(url);
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        string url = "~/Patient Billing/Cash_Book_Submitted_Report.aspx?Hid=" + DDL_Hospital.SelectedValue + "&SDID=0&ShID=0&Dt=" + WebDateChooser_SDate.Value + "&VS=1&EID=0&VID=-1&Edate=" + WebDateChooser_EDate.Value + "&PID=0";
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
            updateDate(wdc.Value.ToString(), id);
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
        Response.Redirect("NewCashReport.aspx?Sdate=" + WebDateChooser_SDate.Value.ToString() + "&Edate=" + WebDateChooser_EDate.Value.ToString() + "&Hid=" + DDL_Hospital.SelectedValue + "&SID=" + DDL_Shift.SelectedValue);

    }






    protected void btnCategoryWise_Click(object sender, EventArgs e)
    {
        Response.Redirect("CashReportCategoryWise.aspx?Sdate=" + WebDateChooser_SDate.Value.ToString() + "&Edate=" + WebDateChooser_EDate.Value.ToString() + "&Hid=" + DDL_Hospital.SelectedValue + "&SID=" + DDL_Shift.SelectedValue);
    }
}