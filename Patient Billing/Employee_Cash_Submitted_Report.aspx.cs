using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class Patient_Billing_Employee_Cash_Submitted_Report : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!Page.IsPostBack)
        {

            WebDateChooser_Date.Value = DateTime.Now;
            WebDateChooser_Sdate.Value = DateTime.Now.AddDays(-2);
            DDL_Hospital.SelectedValue = Session["Hospitalid"].ToString();
            DDL_Employee.DataBind();
            CheckEmployee(DDL_Employee,Page.ID);
            GetCashBookRights();
            LoadReport();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        LoadReport();

    }

    protected void CheckEmployee(DropDownList DDL_Employee, string id)
    {
        foreach(ListItem Item  in DDL_Employee.Items){
            if (Item.Value == Session["emp_id"].ToString())
            {
                lblEmployee.Visible = false;
                divlabel.Visible = false;
            }
        }
    }
    public void GetCashBookRights()
    {
        DbManager obj = new DbManager();
        DataTable dt = default(DataTable);
        SqlParameter[] sqlParams = { new SqlParameter("@EmpID", Session["emp_id"]) };

        dt = obj.ExecuteDataTable("GetCashBookRights", "Basic_Data_ConnectionString", sqlParams);
        if (dt.Rows.Count > 0)
        {
            DDL_Employee.Enabled = true;

        }
        else
        {
            DDL_Employee.SelectedValue = Session["emp_id"].ToString();
            DDL_Employee.Enabled = false;

        }
        if (lblEmployee.Visible == true)
        {

            lblEmployee.Text = "<b>User Is Not Authorized To View This Page!</b>";
            lblEmployee.ForeColor = System.Drawing.Color.Red;
            grdvisiblefalse.Visible = false;
        }


    }


    protected void LoadReport()
    {

        //Response.Write("Date = " + TXT_Date.Text + "   Hos_ID" + DDL_Hospital.SelectedValue.ToString());

        SDS_Report.SelectParameters["SDate"].DefaultValue = WebDateChooser_Sdate.Value.ToString();
        SDS_Report.SelectParameters["EDate"].DefaultValue = WebDateChooser_Date.Value.ToString();
        SDS_Report.SelectParameters["Hos_ID"].DefaultValue = DDL_Hospital.SelectedValue.ToString();
        SDS_Report.SelectParameters["Emp_id"].DefaultValue = DDL_Employee.SelectedValue.ToString();//Session["Emp_id"].ToString();
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

        catch (Exception ex)
        {
            LBl_Msg.Text = "Could not Deposit" + ex.Message;
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

                        SDS_Report.UpdateParameters["shift_id"].DefaultValue = Shift.Value;
                        SDS_Report.UpdateParameters["Subdept_id"].DefaultValue = subdept.Value;
                        SDS_Report.UpdateParameters["Deposit_By"].DefaultValue = Session["Emp_id"].ToString();
                        SDS_Report.UpdateParameters["Emp_id"].DefaultValue = hf_emp_id.Value;
                        SDS_Report.UpdateParameters["Submitted_Date"].DefaultValue = WebDateChooser_Date.Value.ToString();
                        SDS_Report.UpdateParameters["EntryVoucher_Trans_ID"].DefaultValue = hf_Voucher.Value;
                        SDS_Report.UpdateParameters["Voucher_Trans_ID"].DefaultValue = HF_Voucher_Trans_ID.Value;
                        SDS_Report.Update();
                        Gv_Report.DataBind();

                    }
                    catch (Exception ex)
                    {
                        LBl_Msg.Text = ex.Message;
                    }
                }
            }
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
        LBl_Msg.Text = string.Empty;
    }
    protected void SDS_Deposit_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        HF_Voucher_Trans_ID.Value = e.Command.Parameters["@Voucher_Trans_ID"].Value.ToString();
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        Session["VTI"] = lbtn.Text;
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
                if (!string.IsNullOrEmpty(WebDateChooser_Date.Text))
                {
                    Counter_Close_Date = Convert.ToDateTime(WebDateChooser_Date.Value);
                }

                SDS_Voucher.InsertParameters["shift_id"].DefaultValue = hf_Shift.Value;
                SDS_Voucher.InsertParameters["Dept_Id"].DefaultValue = hf_Department.Value;
                SDS_Voucher.InsertParameters["SubDept_Id"].DefaultValue = hf_subdept.Value;
                SDS_Voucher.InsertParameters["CCdate"].DefaultValue = Counter_Close_Date.Year.ToString() + Right("0" + Counter_Close_Date.Month.ToString(), 2) + Right("0" + Counter_Close_Date.Day.ToString(), 2);
                SDS_Voucher.InsertParameters["CC_Emp_Id"].DefaultValue = hf_emp_id.Value;

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
    public static string Right(string original, int numberCharacters)
    {
        return original.Substring(original.Length - numberCharacters);
    }
    protected void WebDateChooser_Date_ValueChanged(object sender, Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs e)
    {
        LoadReport();

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
                totalQty = totalQty + Convert.ToInt32(Co.Remove_Coma(L_amount.Text));
                L_amount.Text = Co.place_Coma(L_amount.Text);
            }

            Label f_total = (Label)Gv_Report.FooterRow.FindControl("lbl_total");

            f_total.Text = "Total Amount  :" + totalQty.ToString("#,##");
            f_total.BackColor = System.Drawing.Color.Wheat;
            f_total.ForeColor = System.Drawing.Color.Black;
        }

    }
}