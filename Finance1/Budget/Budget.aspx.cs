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

public partial class Budget : CSharpClass
{
    int b_ID;
    DateTime E_Date;

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            Label_error.Visible = false;
            DropDownList_FinancialCompany.DataBind();
            DropDownList_FinancialCompany.SelectedValue = Session["Financial_Company_Id"].ToString();
            DropDownList_FinancialCompany.Enabled = false;
            DropDownList_CompanyBranches.DataBind();
            DropDownList_CompanyBranches.SelectedValue = Session["Company_Branch_Id"].ToString();
            
        }
        
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        try
        {

            //if (Convert.ToInt32(TextBox_end_Year.Text) <= Convert.ToInt32(DateTime.Today.Year) + 1)
            //{
            //if (Convert.ToInt32(TextBox_start_year.Text) < Convert.ToInt32(TextBox_end_Year.Text))
            int CMonth = DateTime.Now.Month;
            if (Convert.ToInt32(TextBox_end_Year.Text) - Convert.ToInt32(TextBox_start_year.Text) == 1)
            {

                Label_error.Visible = false;
                SqlDataReader reader;
                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
                SqlCommand con = new SqlCommand("SELECT isnull(max(B_ID),0),ISNULL(max(Date_END),GetDate()) FROM Budget  ", conn);
                conn.Open();
                reader = con.ExecuteReader();
                if (reader.Read())
                {
                    b_ID = reader.GetInt32(0) + 1;
                    
                    E_Date = reader.GetDateTime(1);
                    if (CMonth > 7)
                    {
                        E_Date = E_Date.AddYears(1);
                    }
                }
                else
                {
                    b_ID = 1;
                }
                HiddenField_B_ID.Value = Convert.ToString(b_ID);
                reader.Close();
                conn.Close();

                DateTime start_date;
                DateTime end_date;
                string comb_start_date;
                string comb_end_date;
                comb_start_date = Label_start_month.Text + '/' + Label_start_day.Text + '/' + TextBox_start_year.Text;
                comb_end_date = Label_end_month.Text + '/' + Label_end_day.Text + '/' + TextBox_end_Year.Text;

                start_date = Convert.ToDateTime(comb_start_date);
                end_date = Convert.ToDateTime(comb_end_date);

                if (E_Date >= end_date)
                {
                    Label_error.Visible = true;
                    Label_error.Text = "Can't insert previous year Budget ";
                    return;
                }


                HiddenField_start_Date.Value = Convert.ToString(start_date);
                HiddenField_end_date.Value = Convert.ToString(end_date);
                SqlDataSource_Budget.Insert();
                TextBox_start_year.Text = "";
                TextBox_end_Year.Text = "";
                txtboxReceipt.Text = "";
                txtboxOther.Text = "";
                txt_OP_balance.Text="";
                //SqlDataSource_Budget.SelectParameters["Financial_Company_Id"].DefaultValue = DropDownList_FinancialCompany.SelectedValue;
                //SqlDataSource_Budget.SelectParameters["Company_Branch_Id"].DefaultValue = DropDownList_CompanyBranches.SelectedValue;
                GridView4.DataBind();

            }
            else
            {
                Label_error.Visible = true;


                Label_error.Text = "NOT Valid Financial Year ...";
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            //Label_error.Visible = true;
            //Label_error.Text = "Already saved Budget ...";
        }
       }
    //    else
    //    {
    //        Label_error.Visible = true;
    //        Label_error.Text = "Starting Year is greater than current year";
         
    //    }
    //}
    protected void GridView4_SelectedIndexChanged(object sender, EventArgs e)
    {
        HiddenField_B_ID.Value = GridView4.SelectedValue.ToString();
        SqlDataSource_Budget_Approve.Update();
        GridView4.DataBind();
    }


    protected void lbl_Financial_Company_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Finance/Add_Financial_Company.aspx");
    }
    protected void lbl_Company_Branch_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Finance/Add_Company_Branch.aspx");
    }
    protected void DropDownList_FinancialCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
       DropDownList_CompanyBranches.DataBind();
       
    }
    
}
