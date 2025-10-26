using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_DischargedPatient : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            txtSDate.Text = DateTime.Now.AddDays(-20).ToString("yyyy-MM-dd");
            txtEDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    private void GetPatients()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { 
                                      new SqlParameter("SDate", txtSDate.Text.Trim()),
                                      new SqlParameter("EDate", txtEDate.Text.Trim()) ,
                                      new SqlParameter("RegNo", txtRegNo.Text.Trim()),
                                      new SqlParameter("YealyNo", txtVisitNo.Text.Trim())
                                  };
            DataTable dt = dbMgr.ExecuteDataTable("SearchDischarge_Patient_for_ALL", "Reg_ConnectionString", para);
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
        catch (Exception ex)
        {

        }


    }

    protected void lbtnChange_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lbtn=(LinkButton)sender;
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("PayId",lbtn.CommandArgument)};
            dbMgr.ExecuteNonQuery("usp_updateDischargeStatus", "Reg_ConnectionString", para);
            GetPatients();
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnReport_Click(object sender,EventArgs e)
    {
        GetPatients();
    }
}