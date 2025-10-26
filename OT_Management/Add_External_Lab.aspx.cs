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

public partial class Radiology_Add_External_Lab : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
            gvExternalLab.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlDataSource_Save.Insert();
        gvExternalLab.DataBind();
    }
    protected void SqlDataSource_Save_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        int res = Convert.ToInt32(e.Command.Parameters["@Identity"].Value);
        if (res > 0)
        {
            lblMessage.Text = "Your Information has been saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            txtLabName.Text = "";
        }
        else if (res == -2)
        {
            lblMessage.Text = txtLabName.Text + " Name already exists";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            lblMessage.Text = "Your information has not been saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void lbtnDelete_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        HiddenField_Lab_ID.Value = lbtn.CommandArgument;
        SqlDataSource_Save.Delete();
    }
}
