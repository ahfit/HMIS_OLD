using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Patient_Billing_Account_Services_Breakdown : System.Web.UI.Page
{
    String Constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    decimal Total = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ServicesBreakdown();
        }
    }

    protected void ServicesBreakdown()
    {

        SqlConnection conn = new SqlConnection(Constr);
        DataTable dt = new DataTable();
        try
        {
            SqlCommand sc = new SqlCommand("usp_AccountServiceBreakdown", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@CCDAte", Convert.ToDateTime(Request.QueryString["SDate"]));
            sc.Parameters.AddWithValue("@CCEndDAte", Convert.ToDateTime(Request.QueryString["EndDate"]));
            sc.Parameters.AddWithValue("@hospital_id", Request.QueryString["H_Id"]);
            sc.Parameters.AddWithValue("@Category", Request.QueryString["Cat"]);
            sc.Parameters.AddWithValue("@C_ID", Request.QueryString["Cat_Id"]);
            sc.Parameters.AddWithValue("@Type", Request.QueryString["Type"]);
            sc.Parameters.AddWithValue("@EmpId", Request.QueryString["EmpId"]);
            sc.Parameters.AddWithValue("@CounterType", Request.QueryString["CounterType"]);
            sc.Parameters.AddWithValue("@PartyID", Request.QueryString["PartyId"]);

            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);

            gvd.DataSource = dt;
            gvd.DataBind();

        }
        catch (Exception Ex)
        {
            Response.Write(Ex.Message);
        }
    }

    protected void gvd_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label total = (Label)e.Row.FindControl("lblS_Amount");

            Total += Convert.ToDecimal(total.Text);
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
           Label lbl = (Label)e.Row.FindControl("lblTotal");
           lbl.Text = Total.ToString();
        }
    }
}