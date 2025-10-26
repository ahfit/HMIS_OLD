using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CreateCutomerLogin : System.Web.UI.Page
{
    Encryption ENC = new Encryption();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
        
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (ddlExpiryPolicy.SelectedItem.Text == "30 days")
        {
            hdfPEDate.Value = Convert.ToString(DateTime.Now.AddDays(30));
        
        }
        if (ddlExpiryPolicy.SelectedItem.Text == "60 days")
        {
            hdfPEDate.Value = Convert.ToString(DateTime.Now.AddDays(60));
        }
        if (ddlExpiryPolicy.SelectedItem.Text == "90 days")
        {
            hdfPEDate.Value = Convert.ToString(DateTime.Now.AddDays(90));
        }
        if (ddlExpiryPolicy.SelectedItem.Text == "Never")
        {
            hdfPEDate.Value = Convert.ToString(DateTime.Now.AddDays(1000));
        }
        hdfExpiryPolicy.Value = ddlExpiryPolicy.SelectedItem.Text;
        hdfPassword.Value = ENC.Encrypt_Main( txtPassword.Text,true);
        sdsInsertCustomerLogin.Insert();
    }
}