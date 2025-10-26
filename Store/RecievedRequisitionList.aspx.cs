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
 public partial class RecievedRequisitionList : System.Web.UI.Page
{
   
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
        if (!Page.IsPostBack) {
            //validate("", "");
            ddlFromOffice.DataBind();
            ddlFromOffice.SelectedValue = Session["SubDeptID"].ToString();
        }
       
    }



    protected void lbn_Remarks_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Row in GridView2.Rows)
        {
            HiddenField hf_Consumption = (HiddenField)Row.FindControl("hf_Consumption");
            Lbl_Requisition_No.Text=hf_Consumption.Value;
        }
        LinkButton lbl = (LinkButton)sender;
        HF_Re_ID.Value = lbl.CommandArgument;
         
        Panel_Remarks.Visible = true;

    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        try
        { 

            if (TextBox_Remarks.Text == "")
            {
                Label.Text = "Please Enter the Remarks First";
            }
            else
            {
                Sql_Remarks.Update();
                Label.Text = "Remarks Add successfully";
                TextBox_Remarks.Text = "";
                btn_Save.Visible = false;
            }

        }

        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Remarks.Visible = false;
        Label.Visible = false;
        GridView2.DataBind();
    }
    protected void GridView2_PreRender(object sender, EventArgs e)
    {
       
    }
   
    

 
}
