using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class RejectedItemsRecieved : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            ShowReport();
        }
    }
    private void ShowReport()
    {

        DbManager dbm = new DbManager();
        SqlParameter[] sp = { new SqlParameter("@Consumption_ID", Request.QueryString["C_ID"]) };
        DataTable dt = new DataTable();
        dt = dbm.ExecuteDataTable("uspGetItemIssueByIPO", "STOREConnectionString", sp);
        GridView2.DataSource = dt;
        GridView2.DataBind();
    }
    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox c = (CheckBox)(sender as Control);
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            CheckBox x = (CheckBox)GridView2.Rows[i].FindControl("CheckBox1");
            x.Checked = c.Checked;
        }

    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Remarks.Visible = false;
        Label.Visible = false;

    }



    protected void ButtonRej_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Row in GridView2.Rows)
        {
            CheckBox c = (CheckBox)Row.FindControl("CheckBox1");
            HiddenField hf_Consumption = (HiddenField)Row.FindControl("hf_Consumption");
            Lbl_Requisition_No.Text = hf_Consumption.Value;
            if (c.Checked)
            {
                Panel_Remarks.Visible = true;
            }
        }
    }


    protected void ButtonApprove_Click(object sender, EventArgs e)
    {
        string Med_Record = "<table>";
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            CheckBox c = (CheckBox)GridView2.Rows[i].FindControl("CheckBox1");
            HiddenField itemcode = (HiddenField)GridView2.Rows[i].FindControl("hf_itemcode");
            if (c.Checked)
            {
                Med_Record = Med_Record + "<row><item_code>" + itemcode.Value + "</item_code></row>";

            }


        }
        Med_Record = Med_Record + "</table>";
        if (Med_Record != "<table></table>")
        {
            SDS_Approved.InsertParameters["XML_Sub"].DefaultValue = Med_Record;
            SDS_Approved.Insert();
        }
        ButtonApprove.Enabled = false;
        Response.Redirect("RecievedRequisitionList.aspx");
    }


    protected void btn_PanelReject_Click(object sender, EventArgs e)
    {
        string Med_Record = "<table>";
        foreach (GridViewRow Row in GridView2.Rows)
        {
            CheckBox c = (CheckBox)Row.FindControl("CheckBox1");
            HiddenField itemcode = (HiddenField)Row.FindControl("hf_itemcode");
            Med_Record = Med_Record + "<row><item_code>" + itemcode.Value + "</item_code></row>";
            Med_Record = Med_Record + "</table>";
            if (c.Checked)
            {

                if (Med_Record != "<table></table>")
                {
                    Sql_Remarks.UpdateParameters["XML_Sub"].DefaultValue = Med_Record;
                    Sql_Remarks.Update();
                    Label.Text = "Rejected and remarks Added successfully";
                    TextBox_Remarks.Text = "";


                }
            }
        }
    }

    protected void GridView2_PreRender(object sender, EventArgs e)
    {

    }
}
