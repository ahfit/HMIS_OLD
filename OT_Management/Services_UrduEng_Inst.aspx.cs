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

public partial class Services_UrduEng_Inst : System.Web.UI.Page
{
    SqlConnection objconn;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            grdServicesInstructions.DataBind();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {

        string strconn = ConfigurationManager.ConnectionStrings["Admin_Rad_ConnectionString"].ConnectionString;
              
        OpenConnection(strconn);

        SqlCommand cmd = new SqlCommand("Services_UrduEng_Inst_Insert", objconn);
        cmd.CommandType = CommandType.StoredProcedure;
        

        cmd.Parameters.AddWithValue("Sid", ddlServices.SelectedValue);
        cmd.Parameters.AddWithValue("UrduInst", txtUrduInstruction.Text);
        cmd.Parameters.AddWithValue("EnglishInst", txtEnglishInstruction.Text);
        cmd.Parameters.AddWithValue("HospitalId",Session["HospitalID"].ToString());
        cmd.Parameters.AddWithValue("EntryDate", DateTime.Now);
        cmd.Parameters.AddWithValue("EntryUserId", Session["emp_id"]);

       

        cmd.ExecuteNonQuery();

        CloseConnection();

        grdServicesInstructions.DataBind();
        ddlServices.DataBind();
    }
    
    public void OpenConnection(string strconn)
    {
        objconn = new SqlConnection(strconn);
        objconn.Open();
    }

    public void CloseConnection()
    {
        objconn.Close();
        objconn.Dispose();
    }
    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlServices.DataBind();
    }
    public void chkStatus_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chkStatus = (CheckBox)sender;
        GridViewRow row = (GridViewRow)chkStatus.NamingContainer;


        HiddenField hdnId = (HiddenField)row.FindControl("hdnId");

        string strconn = ConfigurationManager.ConnectionStrings["Admin_Rad_ConnectionString"].ConnectionString;

        OpenConnection(strconn);

        SqlCommand cmd = new SqlCommand("Services_UrduEng_Inst_ChangeStatus", objconn);
        cmd.CommandType = CommandType.StoredProcedure;


        cmd.Parameters.AddWithValue("Id", hdnId.Value);        


        cmd.ExecuteNonQuery();

        CloseConnection();

        grdServicesInstructions.DataBind();

    }
    protected void grdServicesInstructions_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
            if (e.Row.RowType == DataControlRowType.DataRow) 
            {
                CheckBox chkStatus = (CheckBox)e.Row.FindControl("chkStatus");
                if (chkStatus != null)
                {

                    chkStatus.Attributes.Add("onclick", "return confirmChangeStatus(this);");
                }
            }        
    }
}