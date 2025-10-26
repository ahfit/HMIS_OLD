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


public partial class Store_RejectedReturnDC : System.Web.UI.Page
{
    String constr = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtStartDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            txtEndDate.Text = (DateTime.Now).ToString("yyyy-MM-dd");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        bindGrid();

    }


    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Panel_Remarks.Visible = false;
        Label.Visible = false;
        gridview1.DataBind();
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



    protected void lbn_Remarks_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow Row in gridview1.Rows)
        {
            HiddenField hf_Consumption = (HiddenField)Row.FindControl("hf_Consumption");
            Lbl_Requisition_No.Text = hf_Consumption.Value;
        }
        LinkButton lbl = (LinkButton)sender;
        HF_Re_ID.Value = lbl.CommandArgument;

        Panel_Remarks.Visible = true;

    }

    private void bindGrid()
    {
        SqlConnection con = new SqlConnection(constr); 
        con.Open();
        SqlCommand command = new SqlCommand("usp_Get_RejectedDCs", con);
        command.CommandType = CommandType.StoredProcedure;
        command.Parameters.AddWithValue("@Sub_Dept_ID", ddlFromOffice.SelectedValue);
        command.Parameters.AddWithValue("@StartDate", txtStartDate.Text);
        command.Parameters.AddWithValue("@EndDate", txtEndDate.Text);
        SqlDataAdapter dadapter = new SqlDataAdapter(command); 
        DataTable dt = new DataTable();
        dadapter.Fill(dt);
        gridview1.DataSource = dt;
        gridview1.DataBind();
        gridview1.DataBind(); 
        con.Close();
        
    }

    protected void lbreturn_Click(object sender, EventArgs e)
    {
        LinkButton btn = sender as LinkButton;
        try
        {
            GridViewRow gvRow = (GridViewRow)btn.NamingContainer;
            HiddenField hf_IBID = (HiddenField)gvRow.FindControl("hfIBID");
            Response.Redirect("Recieved_Wise_Items.aspx?C_ID="+btn.CommandArgument + "&IB_ID="+hf_IBID.Value+ "&subdeptid=" + ddlFromOffice.SelectedValue);
            lblmsg.Visible = true;
         
        }
        catch (Exception ex)
        {
            Console.Write(ex);
           

        }
      
       

        
    }
}