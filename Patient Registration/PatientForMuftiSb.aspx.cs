using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class Patient_Registration_PatientForMuftiSb : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ShowPatients();
        }
    }
    
    

    protected void btn_Click(object sender, EventArgs e)
    {
        ShowPatients();
    }

    protected void ShowPatients()
    {
        try
        {
            DbManager dbmanager = new DbManager();
            gvd.DataSource = dbmanager.ExecuteDataTable("SearchPatientForMufti", "Reg_ConnectionString",
                new SqlParameter[] { new SqlParameter("@Name",txtboxName.Text),
               new SqlParameter("@Mr",txtboxMr.Text), new SqlParameter("@Cnic",txtboxCnic.Text )
            ,new SqlParameter("@MobileNo",txtboxMobileno.Text), new SqlParameter("@Status",ddlStatus.SelectedValue)
             });

            gvd.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    
    protected void lnkbtnGoToPatient_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        GridViewRow row = lnk.NamingContainer as GridViewRow;
        HiddenField hdf = row.FindControl("hdfYearlyNo") as HiddenField;
        Response.Redirect("PatientDetailForMuftisb.aspx?RegNo=" + lnk.Text+ "&Status=" +  lnk.CommandArgument+"&YearlyNo="+hdf.Value);
    }

    protected void lnkbtnPrint_Click(object sender, EventArgs e)
    {
        LinkButton lnk = (LinkButton)sender;
        Response.Redirect("PatientDetailForMuftiSbReport.aspx?RegNo=" + lnk.ToolTip);
    }




}
    
