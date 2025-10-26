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
using System.Data.SqlClient;


public partial class MarkHospitalwiseExpenditure : CSharpClass
{

    
    protected void Button3_Click(object sender, EventArgs e)
    { 

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Convert.ToString(Session["emp_id"]) == "")
        {
            Response.Redirect("~/login.aspx");
        }
        else {  }
    }
    protected void DropDownList_level1_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_Sub_EH_Name.DataBind();
        DropDownList_Sub_ESH_name.DataBind ();
        GridView2.DataBind (); 
    }
    protected void DropDownList_Sub_EH_Name_SelectedIndexChanged(object sender, EventArgs e)
    {
        DropDownList_Sub_ESH_name.DataBind();
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_SelectedIndexChanged(object sender, EventArgs e)
    {
        
        GridView2.DataBind(); 
    }
    protected void DropDownList_level1_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind();
    }
    protected void DropDownList_Sub_EH_Name_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_DataBinding(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_level1_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_EH_Name_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected void DropDownList_Sub_ESH_name_DataBound(object sender, EventArgs e)
    {
        GridView2.DataBind(); 
    }
    protected Boolean checkAlreadyExists(string headValue, string headCode)
    {
        Boolean isExists = false;
        String conStr = ConfigurationManager.ConnectionStrings["Finance_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(conStr);
        SqlCommand cmd = new SqlCommand("uspCheckLevel4Head", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@E_Name", headValue.Trim().ToLower());
        cmd.Parameters.AddWithValue("@E_Code", headCode.Trim().ToLower());
        con.Open();
        SqlDataAdapter dr = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        dr.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            String strValue = dt.Rows[0][1].ToString();
            String strCode = dt.Rows[0][0].ToString();
            if (strValue.Trim().ToLower() == headValue.Trim().ToLower() && strCode.Trim().ToLower() == headCode.Trim().ToLower())
            {
                isExists = true;
                lblMsg.Text = "Head Code and Head Name are already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                
            }
            else if (strValue.Trim().ToLower() == headValue.Trim().ToLower())
            {
                isExists = true;
                lblMsg.Text = "Head Name already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                
            }
            else
            {
                isExists = true;
                lblMsg.Text = "Head Code already Exists!!!!";
                lblMsg.Visible = true;
                lblMsg.ForeColor = System.Drawing.Color.Red;
                
            }

        }
        else
        {
            isExists = false;
        }
        return isExists;
    }

    protected void btnExpenditure_Click(object sender, EventArgs e)
    {
        
        HiddenField hf_ECode;
        DbManager dbmgr = new DbManager();
        try
        {
            foreach (GridViewRow row in GridView2.Rows)
            {
                CheckBox chkbox = row.FindControl("chkbox") as CheckBox;
                if (chkbox.Checked)
                {
                    hf_ECode = row.FindControl("hf_Ecode") as HiddenField;
                    SqlParameter[] para ={
                    new SqlParameter("@ECode",hf_ECode.Value),
                    new SqlParameter("@HospitalID",ddl_Hospital.SelectedValue),
                    new SqlParameter("@status",SqlDbType.BigInt, 8, ParameterDirection.Output, false, 0, 0, "0", DataRowVersion.Default, 0)
            };
                    dbmgr.ExecuteNonQuery("usp_MarkHospitalwiseExpenditure", "STOREConnectionString", para);
                    lblMsg.Visible = true;
                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Items Successfully Marked...";
                    string value = para[2].Value.ToString();
                    if (value == "0")
                    {
                        lblMsg.Visible = true;
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        lblMsg.Text = "Already Exist...";
                    }
                }
            }
        }
        catch (Exception ex)
        {


        }
    }
        
}
    