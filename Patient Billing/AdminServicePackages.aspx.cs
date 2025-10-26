using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Billing_AdminServicePackages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            dsAdminServicePckg.Insert();
            grdAdminServicePckg.DataBind();
            txtDescription.Text = "";
            txtDoctorShare.Text = "";
            txtPackageName.Text = "";
            txtTotalAmount.Text = "";
        }
        catch (Exception ex)
        { }
    }
}
