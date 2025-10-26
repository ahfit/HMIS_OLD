using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Text;

public partial class PayRoll_ApproveAllowDeductions : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            dropdownlist_Hospital.DataBind();
            lblMsg.Visible = false;
            DropDownList_SalaryHeads.DataBind();
            for (int i = 0; i < 50; i++)
            {
                DropDownList_SalaryYear.Items.Insert(i, Convert.ToString(2000 + i));
            }
            DropDownList_SalaryYear.SelectedValue = Convert.ToString(DateTime.Now.Year);
            DropDownList_SalaryMonth.SelectedValue = Convert.ToString(DateTime.Now.Month);
            GridView_ApprovedList.DataBind();
        }
    }
    protected void btnShowReport_Click(object sender, EventArgs e)
    {
        Approve();
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }

    SqlConnection con = null;


    void open()
    {
        if (con == null)
        {
            con = new SqlConnection(ConfigurationManager.ConnectionStrings["PayRoll_ConnectionString"].ConnectionString);
            con.Open();
        }
        else
        {
            con.Open();
        }
    }

    void Close()
    {
        if (con.State == ConnectionState.Open)
        {
            con.Close();
        }
    }




    public int Approve()
    {
        string Empids = string.Empty;
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            CheckBox chkEmp = (CheckBox)GridView2.Rows[i].FindControl("chkApprove");
            HiddenField hid = (HiddenField)GridView2.Rows[i].FindControl("HiddenField_Empid");
            if (chkEmp.Checked)
            {
                Empids += Convert.ToString(hid.Value).Trim() + ",";
            }
            
        }
        Empids = Empids.TrimEnd(',');
        int ok = -1;
        try
        {
            open();

            SqlParameter parm = new SqlParameter("@ApproveID", SqlDbType.Int);
            parm.Direction = ParameterDirection.Output;
            SqlCommand cmd = new SqlCommand("usp_ApproveDeduction", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Empid", Empids);
            cmd.Parameters.AddWithValue("@month", DropDownList_SalaryMonth.SelectedValue);
            cmd.Parameters.AddWithValue("@Year", DropDownList_SalaryYear.SelectedValue);
            cmd.Parameters.AddWithValue("@E_ID", DropDownList_SalaryHeads.SelectedValue);
            cmd.Parameters.AddWithValue("@ApproveBy", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Remarks", txtRemarks.Text.Trim());
            cmd.Parameters.Add(parm);
            cmd.ExecuteNonQuery();
            int ApprovedId = Convert.ToInt32(cmd.Parameters["@ApproveID"].Value);

            approveReport(ApprovedId);
            GridView_ApprovedList.DataBind();
            ok = 1;
            cmd.Dispose();
            lblMsg.Text = "Approved Successfully!";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            txtRemarks.Text = string.Empty;
        }
        catch (Exception ex)
        {
            lblMsg.Text = "Failed to Approve!";
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }

        finally
        {
            Close();
        }
        return ok;
    }
    protected void chk_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkList = (CheckBox)sender;
        if (chkList.Checked)
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox chkEmp = (CheckBox)GridView2.Rows[i].FindControl("chkApprove");
                chkEmp.Checked = true;
            }
        }
        else
        {
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                CheckBox chkEmp = (CheckBox)GridView2.Rows[i].FindControl("chkApprove");
                chkEmp.Checked = false;
            }
        }
    }
    protected void dropdownlist_Hospital_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }
    protected void Dropdownlistdepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }
    protected void DropDownList_SalaryHeads_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }
    protected void DropDownList_SalaryMonth_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }
    protected void DropDownList_SalaryYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView2.DataBind();
        GridView_ApprovedList.DataBind();
    }
    protected void lnkReport_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        approveReport(Convert.ToInt32(lnk.CommandArgument));
    }


    void approveReport(int ApprovedId) 
    {
        string url = "HeadFinalRpt.aspx?ApprovedID=" + ApprovedId;


        StringBuilder sb = new StringBuilder();
        sb.Append("<script language='javascript' type='text/javascript'>window.open(' " + url + " ')</script>");
        Type t = this.GetType();
        if ((!ClientScript.IsClientScriptBlockRegistered(t, "PopUp")))
        {
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString());
        }
    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {
        try
        {

            if (GridView2.Rows.Count > 0)
            {

                Decimal Total = 0;


                foreach (GridViewRow gvr in GridView2.Rows)
                {

                    Label ltrTemp = gvr.FindControl("LBL_Amount") as Label;
                        Total += Convert.ToDecimal(ltrTemp.Text);


                    
                }


                Label lblTemp = GridView2.FooterRow.FindControl("LBL_T_Amount") as Label;
                if (lblTemp != null)
                    lblTemp.Text = string.Format("{0}", Total.ToString("#,##.00"));
                GridView2.FooterRow.Cells[7].Text = "Total : ";
                GridView2.FooterRow.Cells[0].Text = "Total";
            }

        }
        catch
        {

        }
    }
   
}