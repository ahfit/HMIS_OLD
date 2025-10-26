using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Patient_Registration_DeathCertificate : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            btnSave.Visible = false;
            txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
    protected void btnSearchMR_Click(object sender, EventArgs e)
    {
        if (txtMRNo.Text.Trim() != "" && txtMRNo.Text.Length == 14)
        {
            lblMsgTop.Visible = false;
            getPatientINfo();
            bindGrid();
        }
        else
        {
            lblMsgTop.Text = "Kindly Provide correct MR # !!!";
            lblMsgTop.Visible = true;
            lblMsgTop.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void getPatientINfo()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@RegNo", txtMRNo.Text.Trim()) };
            DataTable dt = dbm.ExecuteDataTable("uspGetPatientInfoFroDeath", "Basic_Data_ConnectionString", sp);
            txtName.Text = Convert.ToString(dt.Rows[0]["PatientName"]);
            lblRelation.Text = Convert.ToString(dt.Rows[0]["Relation"]);
            txtRelationName.Text = Convert.ToString(dt.Rows[0]["RelationName"]);
            txtCNICNo.Text = Convert.ToString(dt.Rows[0]["CNIC"]);
            txtAddress.Text = Convert.ToString(dt.Rows[0]["Address"]);
            btnSave.Visible = true;
            txtMRNo.Enabled = false;
            txtRelationName.Enabled = false;
            txtName.Enabled = false;
            //txtCNICNo.Enabled = false;
        }
        catch (Exception ex)
        {

        }

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtMRNo.Text.Trim() != "" && txtMRNo.Text.Length == 14)
        {
            lblMsg.Visible = false;
            saveRecord();
            bindGrid();
        }
        else
        {
            lblMsg.Text = "Kindly Provide correct MR # !!!";
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void saveRecord()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { 
                                    new SqlParameter("@RegNo", txtMRNo.Text.Trim()),
                                    new SqlParameter("@PatientName", txtName.Text.Trim()), 
                                    new SqlParameter("@Relation", lblRelation.Text.Trim()),
                                    new SqlParameter("@RelationName", txtRelationName.Text.Trim()),
                                    new SqlParameter("@CNIC", txtCNICNo.Text.Trim()),
                                    new SqlParameter("@HomeAddress", txtAddress.Text.Trim()),
                                    new SqlParameter("@DeathDate", txtDate.Text.Trim()),
                                    new SqlParameter("@DeathHours", txtHours.Text.Trim()),
                                    new SqlParameter("@Place", txtPlace.Text.Trim()),
                                    new SqlParameter("@History", txtHistory.Text.Trim()),
                                    new SqlParameter("@Examination", txtExamination.Text.Trim()),
                                    new SqlParameter("@Cause", txtCauseOfDeath.Text.Trim()),
                                    new SqlParameter("@Handover_Refer", rblRefer.SelectedValue),
                                    new SqlParameter("@KinName", txtPatName.Text.Trim()),
                                    new SqlParameter("@KinCNIC", txtPCNIC.Text.Trim()),
                                    new SqlParameter("@KinAddress", txtPContactNo.Text.Trim()),
                                    new SqlParameter("@KinContact", txtPAddress.Text.Trim()),
                                    new SqlParameter("@EntryBy", Session["emp_id"]),
                                    new SqlParameter("@ID", SqlDbType.BigInt, 8, ParameterDirection.Output,false, 0, 0, "0", DataRowVersion.Default, 0)
                                };
            dbm.ExecuteNonQuery("uspAddDeathCertificateInfo", "Basic_Data_ConnectionString", sp);
            if (Convert.ToInt32(sp[18].ToString()) >0)
            {
                lblMsg.Text = "Save successfully !!!";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Visible = true;
                bindGrid();
            }
            else if (Convert.ToInt32(sp[18].ToString())== 0)
            {
                lblMsg.Text = "Already exists !!!";
                lblMsg.ForeColor = System.Drawing.Color.SeaGreen;
                lblMsg.Visible = true;
            }
            else
            {
                lblMsg.Text = "Some error occured while processing !!!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Visible = true;
            }
        }
        catch (Exception ex)
        {

        }

    }
    protected void bindGrid()
    {
        try
        {
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@RegNo", txtMRNo.Text), new SqlParameter("@ID","0") };
            gvDetails.DataSource = dbm.ExecuteDataTable("uspGetSavedDeathCertificate", "Basic_Data_ConnectionString", sp);
            gvDetails.DataBind();

        }
        catch (Exception ex)
        {

        }
    }
}