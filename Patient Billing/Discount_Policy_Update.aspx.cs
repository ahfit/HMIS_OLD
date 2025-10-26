using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administrator_Discount_Policy_Update : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            DropDownList1.DataBind();
            GridView_HospitalServices.DataBind();
            DropDownList_Patient_Type.DataBind();
            DropDownList_Company.DataBind();
        }

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            CheckBox c = (CheckBox)GridView1.Rows[i].FindControl("CheckBox1");
            HiddenField sid = (HiddenField)GridView1.Rows[i].FindControl("HiddenField_SID");
            if (c.Checked)
            {
                HiddenFieldAmount.Value = ((TextBox)GridView1.Rows[i].FindControl("txtAmount")).Text;
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
    protected void txtboxPercentage_TextChanged(object sender, EventArgs e)
    {

    }
    protected void DropDownList_Patient_Type_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        DropDownList_Company.DataBind();
        if (DropDownList_Patient_Type.SelectedValue.ToString() == "4")
        {
            DropDownList_Company.Items.RemoveAt(0);
            DropDownList_Company.Enabled = true;
        }
        else
        {
            DropDownList_Company.Enabled = false;
        }
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView_HospitalServices.DataBind();
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_Patient_Type.DataBind();
    }
}