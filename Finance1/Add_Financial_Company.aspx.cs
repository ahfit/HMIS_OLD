using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;


public partial class Finance_Add_Financial_Company : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Finance/Budget.aspx");
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        if (txt_Name.Text != "" && txt_Description.Text != "")
        {
            sql_FinancialComapny.InsertParameters["Financial_Company_Name"].DefaultValue = txt_Name.Text;
            sql_FinancialComapny.InsertParameters["Description"].DefaultValue = txt_Description.Text;
            sql_FinancialComapny.Insert();
            lbl_Msg.Text = "Financial Company Save Successfully.";
            lbl_Msg.ForeColor = Color.Green;
            lbl_Msg.Visible = true;
            txt_Name.Text = "";
            txt_Description.Text = "";
        }
        else
        {
            lbl_Msg.Text = "Please Enter Company Name and Description";
            lbl_Msg.Visible = true;

        }
    }
}