using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Pt_EMR_DialysisSessionStart : System.Web.UI.Page
{
    User_page_Authentication userAuthen = new User_page_Authentication();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["registrationno"]==null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if(!Page.IsPostBack)
        {
            checkDialysis();
            checkDialysisSession();
            LoadDialysisMachine();
            showHideButtons();
            LoadDialysisSession();
            getIntraDialysis();
        }
    }
    public static string Right(string original, int numberCharacters)
    {
        return original.Substring(original.Length - numberCharacters);
    }
    protected void btnSavePre_Click(object sender, EventArgs e)
    {
        savePrePostDialysis(Convert.ToInt64(Session["DialysisSessionID"]), Convert.ToInt32(txtPrePulse.Text), txtPreBP.Text, Convert.ToDecimal(txtPreTemp.Text), txtPreWT.Text, txtPreRespiration.Text, "Pre Dialysis");
    }
    protected void btnSaveIntraDia_Click(object sender, EventArgs e)
    {
        saveIntraDialysis();
        getIntraDialysis();
    }
    protected void showHideButtons()
    {
        if (Session["DialysisSessionID"] != null)
        {
            btnSaveIntraDia.Visible = true;
            btnSavePost.Visible = true;
            btnSavePre.Visible = true;
        }
        else
        {
            btnSaveIntraDia.Visible = false;
            btnSavePost.Visible = false;
            btnSavePre.Visible = false;
        }
    }
    protected void btnSaveStartSession_Click(object sender, EventArgs e)
    {
        Int64 id=saveDialysisSession();
        Session.Add("DialysisSessionID", id);
        showHideButtons();
    }
    protected Int64 saveDialysisSession()
    {
        Int64 id = 0;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ConnectionString);
        try
        {
            SqlCommand cmd = new SqlCommand("uspInsertDialysisSession", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@DialysisID", Session["DialysisID"]);
            cmd.Parameters.AddWithValue("@SessionDate", txtSessionStartDate.Text);
            cmd.Parameters.AddWithValue("@DIalysisNo", txtDialysisNo.Text);
            cmd.Parameters.AddWithValue("@Dialyzer", txtDialyzer.Text);
            cmd.Parameters.AddWithValue("@DialysisSolution", txtDiaSolution.Text);
            cmd.Parameters.AddWithValue("@MachineNo", ddlDialysisMachineNo.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@PrimingSolution", txtPriSolution.Text);
            cmd.Parameters.AddWithValue("@StartingTime", txtStartTime.Text);
            cmd.Parameters.AddWithValue("@FinishiningTime", txtEndTime.Text);
            cmd.Parameters.AddWithValue("@EntryBy", Session["Emp_Id"]);
            cmd.Parameters.AddWithValue("@SchedulerID", ddlDialysisSession.SelectedValue);
            cmd.Parameters.AddWithValue("@DialysisSessionID", SqlDbType.Int).Direction = ParameterDirection.Output;
            con.Open();
            cmd.ExecuteNonQuery();
            id = Convert.ToInt64(cmd.Parameters["@DialysisSessionID"].Value.ToString());
        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        return id;
    }
    protected void savePrePostDialysis(Int64 DiaSesID,int pulse,String BP,decimal temp,string wt,string respiration,String type)
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = new SqlParameter[8];
        sqlParam[0] = new SqlParameter("@DialysisSessionID", DiaSesID);
        sqlParam[1] = new SqlParameter("@Pulse", pulse);
        sqlParam[2] = new SqlParameter("@BP", BP);
        sqlParam[3] = new SqlParameter("@Temp", temp);
        sqlParam[4] = new SqlParameter("@Wt", wt);
        sqlParam[5] = new SqlParameter("@Respiration", respiration);
        sqlParam[6] = new SqlParameter("@PrePostType", type);
        sqlParam[7] = new SqlParameter("@EntryBy", Session["emp_Id"]);

        dbMgr.ExecuteNonQuery("uspInsertPrePostDialysis", "TreatmentConnectionString", sqlParam);
    }
    protected void saveIntraDialysis()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = new SqlParameter[12];
        sqlParam[0] = new SqlParameter("@DialysisSessionID", Session["DialysisSessionID"]);
        sqlParam[1] = new SqlParameter("@IntraTime", txtIDTime.Text);
        sqlParam[2] = new SqlParameter("@pulse", txtIDPulse.Text);
        sqlParam[3] = new SqlParameter("@BP", txtIDBP.Text);
        sqlParam[4] = new SqlParameter("@GC", txtIDGC.Text);
        sqlParam[5] = new SqlParameter("@BloodFlow", txtIDBloodFlow.Text);
        sqlParam[6] = new SqlParameter("@UFTarget", txtIDUFTarget.Text);
        sqlParam[7] = new SqlParameter("@UFRateTMP", txtIDUFRate.Text);
        sqlParam[8] = new SqlParameter("@ArtPressure", txtIDARTPre.Text);
        sqlParam[9] = new SqlParameter("@VenPressure", txtIDVENPre.Text);
        sqlParam[10] = new SqlParameter("@Heparin", txtIDHeparin.Text);
        sqlParam[11] = new SqlParameter("@EntryBy", Session["emp_Id"]);

        dbMgr.ExecuteNonQuery("uspInsertIntraDialysis", "TreatmentConnectionString", sqlParam);
    }

    protected void btnSavePost_Click(object sender, EventArgs e)
    {
        savePrePostDialysis(Convert.ToInt64(Session["DialysisSessionID"]), Convert.ToInt32(txtPostPulse.Text), txtPostBP.Text, Convert.ToDecimal(txtPostTemp.Text), txtPostWT.Text, txtPostRespiration.Text, "Post Dialysis");
    }
    protected void getIntraDialysis()
    {
        DbManager dbMgr = new DbManager();
        DataTable dt = new DataTable();
        SqlParameter[] sqlParam = { (new SqlParameter("@DialysisID", Session["DialysisID"])) };
        dt = dbMgr.ExecuteDataTable("uspGetIntraDialysis", "TreatmentConnectionString", sqlParam);
        gvIntraDialysis.DataSource = dt;
        gvIntraDialysis.DataBind();
    }
    protected void checkDialysis()
    {
        DbManager dbm = new DbManager();
        DataTable dt = new DataTable();
        SqlParameter[] sqlParam = { new SqlParameter("@RegNo", Session["registrationno"]), new SqlParameter("@YearlyNo", Session["yearlyno"]) };
        dt = dbm.ExecuteDataTable("uspCheckDialysisSession", "TreatmentConnectionString", sqlParam);
        if (dt.Rows.Count > 0)
        {
            Session.Add("DialysisID", dt.Rows[0]["DialysisID"].ToString());
        }
    }
    protected void checkDialysisSession()
    {
        DbManager dbm = new DbManager();
        DataTable dt = new DataTable();
        SqlParameter[] sqlParam = { new SqlParameter("@DialysisID", Session["DialysisID"]), new SqlParameter("@DialysisDate", DateTime.Now) };
        dt = dbm.ExecuteDataTable("uspCheckPatientDialysisSession", "TreatmentConnectionString", sqlParam);
        if (dt.Rows.Count > 0)
        {
            DateTime d = new DateTime();
            d = Convert.ToDateTime(dt.Rows[0]["SessionDate"].ToString());
            Session.Add("DialysisSessionID", dt.Rows[0]["DialysisSessionID"].ToString());
            txtDialysisNo.Text = dt.Rows[0]["DIalysisNo"].ToString();
            txtDialysisNo.Enabled = false;
            //txtWeight.Text = dt.Rows[0]["IBWeight"].ToString();
            //txtWeight.Enabled = false;
            txtSessionStartDate.Text = d.ToString("yyyy-MM-dd");
            txtSessionStartDate.Enabled = false;
            //ddlFailureCause.SelectedValue = dt.Rows[0]["CORFailure"].ToString();
            //ddlFailureCause.Enabled = false;
            //ddlBloodGroup.SelectedValue = dt.Rows[0]["BloodGroup"].ToString();
            //ddlBloodGroup.Enabled = false;
        }
    }
    protected void LoadDialysisSession()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] para =
        {
            new SqlParameter("@DialsisID",Session["DialysisID"]),
        };
        ddlDialysisSession.DataSource = dbm.ExecuteDataTable_Query("Select SchedulerID,SDayName+'( '+COnvert(varchar,SDate,105)+' )' SDayName From DialysisPatientsSchedules Where DialysisID=@DialsisID", "TreatmentConnectionString", para);
        ddlDialysisSession.DataValueField = "SchedulerID";
        ddlDialysisSession.DataTextField = "SDayName";
        ddlDialysisSession.DataBind();
    }
    protected void LoadDialysisMachine()
    {
        DbManager dbm = new DbManager();
        SqlParameter[] para =
        {
            new SqlParameter("@ID",""),
        };
        ddlDialysisMachineNo.DataSource = dbm.ExecuteDataTable_Query("Select id,MachineName From Machine_Name", "Reg_ConnectionString", para);
        ddlDialysisMachineNo.DataValueField = "id";
        ddlDialysisMachineNo.DataTextField = "MachineName";
        ddlDialysisMachineNo.DataBind();
    }
}
  