using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;


public partial class PayRoll_MonthlyYearlyTax : System.Web.UI.Page
{
     string connectionString = ConfigurationManager.ConnectionStrings["payRollConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            gvdTaxSlab.DataBind();
        }
    }
    protected void btnCalculate_Click(object sender, EventArgs e)
    {

        if (txtboxSlabFrom.Text != string.Empty)
        {
            SqlConnection con = new SqlConnection(connectionString);
            con.Open();
            SqlCommand cmd = new SqlCommand("select [dbo].[MonthlyTax]("+txtboxSlabFrom.Text.Trim()+")", con);
           // int MonthlyTax = (int)cmd.ExecuteScalar();


            SqlDataReader reader = cmd.ExecuteReader();

            string data = string.Empty;
            while (reader.Read())
            {
                data = reader[0].ToString();

                
            }

            if (data == "")
            {
                lblMonthlyTax.Text = " Monthly tax is  0";
                lblYearlyTax.Text = "Yearly tax is 0";
            }
            else
            {



                decimal YearlyTax = 0;
                YearlyTax =Math.Round(Convert.ToDecimal(data) * 12);

                lblMonthlyTax.Text = " Monthly tax is " + Math.Round(Convert.ToDecimal(data));
                lblYearlyTax.Text = "Yearly tax is " + YearlyTax;
            }
        }
        else
        {
           
            lblMonthlyTax.Text = " Monthly tax is  0" ;
            lblYearlyTax.Text = "Yearly tax is 0";
        }
    }
    
}