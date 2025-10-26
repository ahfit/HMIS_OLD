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

public partial class Administrator_Admin_Hospital_Company_Rates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox c = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            HiddenField sid = (HiddenField)GridView1.Rows[i].FindControl("HiddenField_SID");
            if (c.Checked)
            {
                HiddenFieldAmount.Value = ((TextBox)GridView1.Rows[i].FindControl("txtCompanyAmount")).Text;
                HiddenFieldSID.Value = sid.Value;
                SqlDataSource_HospitalServices.Insert();
            }
        }
        GridView1.DataBind();
        GridView_HospitalServices.DataBind();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void CheckBox3_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox c = (CheckBox)(sender as Control);


            for (int i = 0; i < GridView1.Rows.Count; i++)
            {
                CheckBox x = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
                x.Checked = c.Checked;
            }
        
    }
    protected void CheckBox4_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox c = (CheckBox)(sender as Control);


        for (int i = 0; i < GridView_HospitalServices.Rows.Count; i++)
        {
            CheckBox x = (CheckBox)GridView_HospitalServices.Rows[i].FindControl("CheckBox2");
            x.Checked = c.Checked;
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView_HospitalServices.Rows.Count; i++)
        {
            CheckBox c = (CheckBox)GridView_HospitalServices.Rows[i].FindControl("CheckBox2");
            HiddenField sid = (HiddenField)GridView_HospitalServices.Rows[i].FindControl("HiddenField1");
            if (c.Checked)
            {
                HiddenFieldSID.Value = sid.Value;
                SqlDataSource_HospitalServices.Delete();
            }
        }
        GridView1.DataBind();
        GridView_HospitalServices.DataBind();
    }

    protected void txtpercen_TextChanged(object sender, EventArgs e)
    {
        if (txtpercen.Text.Trim() == "")
            txtpercen.Text = "0";
        foreach (GridViewRow row in GridView1.Rows)


        {

          Label actualamount=  row.FindControl("lblAmount") as Label;
            if (Convert.ToInt32(actualamount.Text) > 0)
            {
                TextBox percentageamount = row.FindControl("txtCompanyAmount") as TextBox;
                if (string.IsNullOrEmpty(percentageamount.Text.Trim()))
                {
                    percentageamount.Text = "0";
                }

                percentageamount.Text = Convert.ToString(Convert.ToInt32(actualamount.Text)+(Convert.ToInt32(txtpercen.Text) * (Convert.ToInt32(actualamount.Text)) / 100));


            }
           
        }
    }
    protected void txtPercenSub_TextChanged(object sender, EventArgs e)
    {
        if (txtPercenSub.Text.Trim() == "")
            txtPercenSub.Text = "0";
        foreach(GridViewRow row in GridView1.Rows)
        {
            Label actualamount = row.FindControl("lblAmount") as Label;
            if (Convert.ToInt32(actualamount.Text) > 0)
            {
                TextBox percentageamount = row.FindControl("txtCompanyAmount") as TextBox;
                if (string.IsNullOrEmpty(percentageamount.Text.Trim()))
                {
                    percentageamount.Text = "0";
                }

                percentageamount.Text = Convert.ToString(Convert.ToInt32(actualamount.Text) - (Convert.ToInt32(txtPercenSub.Text) * (Convert.ToInt32(actualamount.Text)) / 100));


            }

        }

    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.DataBind();
    }
   
}
