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
public partial class PO_ReceivingPOST : System.Web.UI.Page
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
            CheckBox CK = new CheckBox();
            Label lblAmount = new Label();
            Label lblQty = new Label();
            //string data = "<DATA>";
            foreach (GridViewRow row in GridView1.Rows)
            {
                CK        = (CheckBox)row.FindControl("CB_Item");
                if (CK.Checked && CK.Visible)
                {
                    HFCID = (HiddenField)row.FindControl("hf_Consumption_Id");
                    HFSID = (HiddenField)row.FindControl("hf_SubDept_Id");
                    HFRQID = (HiddenField)row.FindControl("hf_Requisition_Id");
                    lblAmount = (Label)row.FindControl("lbl_cost");
                    lblQty = (Label)row.FindControl("lblqty");
                    POSTVoucher(HFRQID.Value, Convert.ToInt32(Session["emp_id"]), Convert.ToInt32(Session["DesignationID"]),
                        Convert.ToInt32(DDL_Branch.SelectedValue), Convert.ToInt32(HFSID.Value), Convert.ToDouble(lblAmount.Text),
                        Convert.ToDateTime(WebDateChooser_Date_To.Text), Convert.ToInt32(HFCID.Value), Convert.ToInt32(lblQty.Text));
                }
            }
            bindGrid();

        }
        

    }

    protected void POSTVoucher(string po_id, int empid,int Des,int ISub_dept , int RSub_dept ,double amount,DateTime VDate , int RMI,int Qty)
    {
        SqlConnection con = null;
        SqlCommand cmd = null;
        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
            cmd = new SqlCommand("JV_Issue_Received_PO_Wise", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();

            cmd.Parameters.AddWithValue("@PO_ID", po_id);
            cmd.Parameters.AddWithValue("@By_Emp_Id", empid);
            cmd.Parameters.AddWithValue("@Designation_Id", Des);
            cmd.Parameters.AddWithValue("@IssueBy_SubDept_Id", ISub_dept);
            cmd.Parameters.AddWithValue("@RecBy_SubDept_Id", RSub_dept);
            cmd.Parameters.AddWithValue("@Purchase_Cost", amount);
            cmd.Parameters.AddWithValue("@Reciept_date", VDate);
            cmd.Parameters.AddWithValue("@Rec_Main_ID", RMI);
            cmd.Parameters.AddWithValue("@item_Qty", Qty);

            cmd.ExecuteNonQuery();
            
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
            cmd = new SqlCommand("usp_PO_First_Rec", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@SubDept_Id", DDL_Branch.SelectedValue);
            cmd.Parameters.AddWithValue("@TSubDept_Id", DDL_TBranch.SelectedValue);
            cmd.Parameters.AddWithValue("@RequisitionNo", txtRequistionNo.Text);
            cmd.Parameters.AddWithValue("@IssueDateFrom", WebDateChooser_date_From.Text);
            cmd.Parameters.AddWithValue("@IssueDateTo", WebDateChooser_Date_To.Text);
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
}

