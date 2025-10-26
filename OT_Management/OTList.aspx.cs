using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OT_Management_OTList : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            GetPatientForAppointments();
        }
    }
    protected void GetPatientForAppointments()
    {
        DbManager manager = new DbManager();

        Int64 visitNo = txtVisitNo.Text == "" ? 0 : int.Parse(txtVisitNo.Text);
        

        SqlParameter[] par = {
        new SqlParameter("@MrNo",txtMrNO.Text.Trim()),
        new SqlParameter("@VisitNo",visitNo),
        new SqlParameter("@Date",txtDate.Text)

        };
        DataTable dt = manager.ExecuteDataTable("OTList_GetPatients", "OT_ManagementConnectionString", par);

        grdAppointments.DataSource = dt;
        grdAppointments.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        GetPatientForAppointments();
    }
}