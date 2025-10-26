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
using System.Data.SqlClient;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
public partial class DC_CGS_ISSUE : System.Web.UI.Page
{
    ReportDocument doc = new ReportDocument();
    String constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void validate(string url, string dept)
    {

        if (Session["emp_id"] == null || Session["SubDeptId"] == null)
        {
            Response.Redirect("../login.aspx");
        }
    }
        
    protected void Page_Load(object sender, EventArgs e)
    {
        //validate("", "");

        if (!Page.IsPostBack)
        {
            DDL_Company.DataBind();
            DDL_Branch.DataBind();
            //DDL_Company.SelectedValue = Session["Financial_Company_Id"]
            //DDL_Branch.SelectedValue = Session["Subdeptid"]
            if (Convert.ToString( Session["Branch_Access"]) == "1")
            {
                DDL_Company.Enabled = false;
                DDL_Branch.Enabled = false;
            }
            
            WebDateChooser_date_From.Text = DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd");
            WebDateChooser_Date_To.Text = DateTime.Now.ToString("yyyy-MM-dd");
            bindGrid();
            
        }
    }
    protected void btnSearch_Click(object sender, System.EventArgs e)
    {
        lbl_Total_Amount.Text = "0";
        bindGrid();
    }
    


    protected void CB_Item_CheckedChanged(object sender, EventArgs e)
    {
        double amount = Convert.ToInt32(lbl_Total_Amount.Text);
        CheckBox Ck_Item =(CheckBox) sender;
        GridViewRow row = (GridViewRow) Ck_Item.NamingContainer;
        Label lblCost = (Label)row.FindControl("lbl_cost");
        if (string.IsNullOrEmpty(lblCost.Text.Trim()))
        {
            lblCost.Text = "0";
        }

        if (Ck_Item.Checked)
        {

            lbl_Total_Amount.Text = Convert.ToString(amount + Convert.ToDouble(lblCost.Text));

        }
        else
        {
            lbl_Total_Amount.Text = Convert.ToString(amount - Convert.ToDouble(lblCost.Text));
        }
    }

    protected void CB_Header_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox Ck_Head = (CheckBox)sender;
        ck_all(Ck_Head);
    }

    protected void Btn_Post_Click(object sender, EventArgs e)
    {
        if (GridView1.Rows.Count>0)
        {
            HiddenField HFCID = new HiddenField();
            HiddenField HFSID = new HiddenField();
            HiddenField HFRQID = new HiddenField();
            HiddenField HFPartyID = new HiddenField();
            CheckBox CK = new CheckBox();
            Label lblAmount = new Label();

            string data = "<DATA>";
            foreach (GridViewRow row in GridView1.Rows)
            {
                CK        = (CheckBox)row.FindControl("CB_Item");
                if (CK.Checked && CK.Visible)
                {
                    HFCID = (HiddenField)row.FindControl("hf_Consumption_Id");
                    HFSID = (HiddenField)row.FindControl("hf_SubDept_Id");
                    HFRQID = (HiddenField)row.FindControl("hf_Requisition_Id");
                    HFPartyID = (HiddenField)row.FindControl("hf_Consumption_Id");
                    lblAmount = (Label)row.FindControl("lbl_cost");
                    
                    data = data + "<row><C_ID>" + HFCID.Value + "</C_ID><Subdept_ID>" + HFSID.Value + "</Subdept_ID><P_ID>" + HFPartyID.Value + "</P_ID><RQ_ID>" + HFRQID.Value + "</RQ_ID><Amount>" + lblAmount.Text + "</Amount></row>";
                }
                

            }
            data = data + "</DATA>";

            if (data != "<DATA></DATA>")
            { 
                POSTVoucher(Convert.ToInt32(Session["emp_id"]) , Convert.ToInt32(Session["DesignationID"]), Convert.ToInt32(DDL_Branch.SelectedValue),Convert.ToDouble(lbl_Total_Amount.Text),Convert.ToDateTime( WebDateChooser_date_From.Text), Convert.ToDateTime(WebDateChooser_Date_To.Text), data);
            }
        }
        

    }

    protected void POSTVoucher(int empid,int Des,int Sub_dept ,double amount,DateTime Start,DateTime end , string Data)
    {
        SqlConnection con = null;
        SqlCommand cmd = null;
        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
            cmd = new SqlCommand("JV_StockCGSGroupRec", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@By_Emp_Id", empid);
            cmd.Parameters.AddWithValue("@Designation_Id", Des);
            cmd.Parameters.AddWithValue("@By_SubDept_Id", Sub_dept);
            cmd.Parameters.AddWithValue("@Total_Amount", amount);
            cmd.Parameters.AddWithValue("@Start_Date", Start);
            cmd.Parameters.AddWithValue("@END_Date", end);
            cmd.Parameters.AddWithValue("@Data", Data);

            cmd.ExecuteNonQuery();
            bindGrid();
        }

        catch (Exception ex)
        {

        }
        finally
        {
            if (con != null && con.State == ConnectionState.Open)
                con.Close();
            if (cmd != null)
                cmd.Dispose();
        }
    }

    protected void ck_all( CheckBox Ck_Head)
    {
        if (GridView1.Rows.Count > 0)
        {

            CheckBox Ck_row = new CheckBox();
            Label lblCost = new Label();
            double amount = 0;
            foreach (GridViewRow row in GridView1.Rows)
            {
                Ck_row = (CheckBox)row.FindControl("CB_Item");
                lblCost = (Label)row.FindControl("lbl_cost");
                if (string.IsNullOrEmpty(lblCost.Text.Trim()))
                {
                    lblCost.Text = "0";

                }
                if (Ck_row.Visible)
                {
                    if (Ck_Head.Checked)
                    {
                        amount = amount + Convert.ToDouble(lblCost.Text);
                    }

                    Ck_row.Checked = Ck_Head.Checked;
                }
            }
            lbl_Total_Amount.Text = Convert.ToString(amount);
        }

    }
    protected void bindGrid()
    {
        SqlConnection con = null;
        SqlCommand cmd = null;
        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
            cmd = new SqlCommand("usp_DeliveryChallanCGS_RSearch", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@SubDept_Id", DDL_Branch.SelectedValue);
            cmd.Parameters.AddWithValue("@TSubDept_Id", DDL_TBranch.SelectedValue);
            cmd.Parameters.AddWithValue("@RequisitionNo", txtRequistionNo.Text);
            cmd.Parameters.AddWithValue("@IssueDateFrom", WebDateChooser_date_From.Text);
            cmd.Parameters.AddWithValue("@IssueDateTo", WebDateChooser_Date_To.Text);
            cmd.Parameters.AddWithValue("@Company_ID", DDL_Party.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            if (GridView1.Rows.Count>0)
            {
                CheckBox CK_Head = (CheckBox)GridView1.HeaderRow.FindControl("CB_Header");
                CK_Head.Checked = true;
                ck_all(CK_Head);
            }
        }

        catch (Exception ex)
        {

        }
        finally
        {
            if (con != null && con.State == ConnectionState.Open)
                con.Close();
            if (cmd != null)
                cmd.Dispose();
        }
    }

    protected void lbl_V_Voucher_Click(object sender, EventArgs e)
    {
        LinkButton LK = (LinkButton)sender;
        Session.Add("VTI", LK.Text);
        Response.Redirect("~/FINANCE/CReport_Recipt_Voucher.aspx");

    }

    protected void DDL_Company_SelectedIndexChanged(object sender, EventArgs e)
    {
        DDL_Branch.DataBind();
    }
}

