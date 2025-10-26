using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Pathology_SearchCorporateLabPatient : System.Web.UI.Page
{
    String _str = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            startDateChooser.Value = DateTime.Now.AddYears(-1);
            HiddenField_StartDate.Value = startDateChooser.Value.ToString();
            endDateChooser.Value = DateTime.Now;
            HiddenField_EndDate.Value = startDateChooser.Value.ToString();
            FillGridView();    
        }
        
    }
    private void FillGridView()
    {
         
         

        using (SqlConnection connection = new SqlConnection(_str))
        {
            SqlCommand command = new SqlCommand("get_SearchCorporateLabPatient", connection);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@FromDate", startDateChooser.Value);
            command.Parameters.AddWithValue("@ToDate", endDateChooser.Value);
            command.Parameters.AddWithValue("@RegNo", txtRegNo.Text.Trim());
            command.Parameters.AddWithValue("@yearlyNo", txtVisitNo.Text.Trim());
             command.Parameters.AddWithValue("@ReferenceNo", txtReference.Text.Trim());
            command.Parameters.AddWithValue("@PartyId", Session["Company_Id"].ToString());
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }


    protected void btn_Search_Click(object sender, EventArgs e)
    {
        FillGridView();
    }
    protected void lnkMainID_Click(object sender, EventArgs e)
    {

    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridView1.PageIndex = e.NewPageIndex;
        FillGridView();
    }
}