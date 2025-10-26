using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Store_POReceiveDetail : System.Web.UI.Page
{
    String conStr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = DateTime.UtcNow.Date.AddMonths(-1).ToString("yyyy-MM-dd");
            txtEndDate.Text = DateTime.UtcNow.Date.ToString("yyyy-MM-dd");
            bindBranch();
           
        }

        }

    private void bindBranch()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection();
        try
        {
            con.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
            con.Open();
            cmd = new SqlCommand("select 0 SubDept_Id,  '---ALL---' SubDept_Name from subdepartment union select  SubDept_Id ,SubDept_Name from subdepartment where Is_Hidden is null   order by SubDept_Name", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlBranch.DataSource = dt;
            ddlBranch.DataTextField = "SubDept_Name";
            ddlBranch.DataValueField = "SubDept_Id";
            ddlBranch.DataSource = dt;
            ddlBranch.DataBind();
        }
        catch (Exception ex)
        {

            con.Close();
        }
    }

    protected void LoadReport()
    {
        SqlConnection con = new SqlConnection(conStr);
        try
        {
            //con.Open();  
            //SqlCommand cmd = new SqlCommand("Usp_POReceiveDetail", con);
            //cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
            //cmd.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
            //cmd.Parameters.AddWithValue("@POID", txtPO.Text.Trim());
            //cmd.Parameters.AddWithValue("@SubDeptID", ddlBranch.SelectedValue);
            //SqlDataAdapter da = new SqlDataAdapter(cmd);
            //DataTable dt = new DataTable();
            //da.Fill(dt);
            //ReportDataSource rds = new ReportDataSource();
            //rds.Name = "DataSet1";
            //rds.Value = dt;
            //ReportViewer1.LocalReport.DataSources.Clear();
            //ReportViewer1.LocalReport.ReportPath = Server.MapPath("POReceiveDetail.rdlc");
            //ReportViewer1.LocalReport.DataSources.Add(rds);
            //ReportViewer1.LocalReport.Refresh();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
           
        }
       

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadReport();

    }

    protected void Gv_PO_PreRender(object sender, EventArgs e)
    {
        if (Gv_PO.Rows.Count>0)
        {
            CheckBox ck = new CheckBox();
            foreach( GridViewRow row in Gv_PO.Rows)
            {
                GridView g = (GridView)row.FindControl("GV_Detail");
                g.DataBind();
                if (!(g.Rows.Count>0))
                {
                    ck = (CheckBox)row.FindControl("CB_Item");
                    ck.Visible = false;
                }
            }

        }
    }

    protected void CB_header_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox Ck_Head =(CheckBox) sender;
        ck_all(Ck_Head);
    }
    protected void ck_all(CheckBox Ck_Head)
    {
        if (Gv_PO.Rows.Count > 0)
        {

            CheckBox Ck_row = new CheckBox();
 
            
            foreach (GridViewRow row in Gv_PO.Rows)
            {
                Ck_row = (CheckBox)row.FindControl("CB_Item");
 
               
                if (Ck_row.Visible)
                {
               
                    Ck_row.Checked = Ck_Head.Checked;
                }
            }
 
        }

    }

    protected void Btn_PO_POST_Click(object sender, EventArgs e)
    {
        if (Gv_PO.Rows.Count > 0)
        {
            CheckBox Ck_row = new CheckBox();
            HiddenField PO = new HiddenField();
            
            foreach (GridViewRow row in Gv_PO.Rows)
            {

                Ck_row = (CheckBox)row.FindControl("CB_Item");
                if (Ck_row.Checked)
                {
                    PO = (HiddenField)row.FindControl("HF_PO_ID");
                    PostVoucher(PO.Value,Convert.ToInt32(Session["emp_id"]),Convert.ToInt32(Session["DesignationID"])  );


                }
            }
        }

        Gv_PO.DataBind();

        }

    private void PostVoucher(string PO,int emp_id,int Des)
    {
        SqlConnection con = null;
        SqlCommand cmd = null;
        try
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
            cmd = new SqlCommand("JV_PO_Complete_Voucher", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@PO_ID", PO);
            cmd.Parameters.AddWithValue("@By_Emp_Id", emp_id);
            cmd.Parameters.AddWithValue("@Designation_Id", Des);
           
            cmd.ExecuteNonQuery();
           // bindGrid();
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