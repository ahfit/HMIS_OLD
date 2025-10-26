using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Dialysis_AddEditDialysisPatient : System.Web.UI.Page
{
    User_page_Authentication userAuthen = new User_page_Authentication();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["registrationno"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        if (!Page.IsPostBack)
        {
            txtRegDate.Text  = DateTime.Now.ToString("MM/dd/yyyy");
            bindWeekDays();
            bindShifts();
            checkDialysis();
            if(Session["DialysisID"]!=null)
            {
                getHepatitisSerology();
            }
        }
    }
    public static string Right(string original, int numberCharacters)
    {
        return original.Substring(original.Length - numberCharacters);
    }
    protected void btnSaveAll_Click(object sender, EventArgs e)
    {
        saveMain();
        saveHepatitisSerology();
        saveScheduler();
    }

    protected void saveMain()
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ConnectionString);
        try
        {
            if (Session["DialysisID"]==null)
            {
                Int64 id = 0;
                SqlCommand cmd = new SqlCommand("uspInserDialysisPatient", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RegNo", Session["registrationno"]);
                cmd.Parameters.AddWithValue("@YearlyNo", Session["yearlyno"]);
                cmd.Parameters.AddWithValue("@DialysisRegDate", txtRegDate.Text);
                cmd.Parameters.AddWithValue("@IBWeight", txtWeight.Text);
                cmd.Parameters.AddWithValue("@BloodGroup", ddlBloodGroup.SelectedValue);
                cmd.Parameters.AddWithValue("@CORFailure", ddlFailureCause.SelectedValue);
                cmd.Parameters.AddWithValue("@Diagnosis", txtDiagnosis.Text);
                cmd.Parameters.AddWithValue("@EmpID", Session["emp_Id"]);
                cmd.Parameters.AddWithValue("@DialysisID", SqlDbType.Int).Direction = ParameterDirection.Output;
                con.Open();
                cmd.ExecuteNonQuery();
                id = Convert.ToInt64(cmd.Parameters["@DialysisID"].Value.ToString());
                Session.Add("DialysisID", id);
            }
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
        
    }
    protected void saveHepatitisSerology()
    {
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParam = new SqlParameter[7];
        sqlParam[0] = new SqlParameter("@DialysisID",Session["DialysisID"]);
        sqlParam[1] = new SqlParameter("@HSDate", txtHSDate.Text);
        sqlParam[2] = new SqlParameter("@HBsAg", ddlHBsAg.SelectedValue);
        sqlParam[3] = new SqlParameter("@AntiHCV", ddlAntiHCV.SelectedValue);
        sqlParam[4] = new SqlParameter("@AntiHBs", ddlAntiHBs.SelectedValue);
        sqlParam[5] = new SqlParameter("@HCVPCR", ddlHCVPCR.SelectedValue);
        sqlParam[6] = new SqlParameter("@HBoV", ddlHBoV.SelectedValue);

        dbMgr.ExecuteNonQuery("uspInserDialysisPatientHepatitisSerology", "TreatmentConnectionString", sqlParam);
        
    }
    protected void saveScheduler()
    {
        // (@DialysisID, @StartDate, @EndDate, @Shift, @Moday, @Tuesday, @Wednesday, @Thursday, @Friday, @Saturday, @Sunday)
        DateTime temp1;
        String startDate = wdcSStartDate.Value.ToString();
        String endDate = wdcSEndDate.Value.ToString();
        DateTime dateCounter = Convert.ToDateTime(wdcSStartDate.Value);
        while (dateCounter <= Convert.ToDateTime(endDate))
        {
            temp1 = dateCounter;
            for (int m = 0; m <= chkDays.Items.Count-1 ; m++)
            {

                if (chkDays.Items[m].Selected == true && dateCounter <= Convert.ToDateTime(endDate) && Convert.ToInt32(chkDays.Items[m].Value)== Convert.ToInt32(dateCounter.DayOfWeek) )
                {
                    dateCounter = dateCounter.AddDays(1);
                    DbManager dbMgr = new DbManager();
                    SqlParameter[] sqlParam = new SqlParameter[7];
                    sqlParam[0] = new SqlParameter("@DialysisID", Session["DialysisID"]);
                    sqlParam[1] = new SqlParameter("@StartDate", wdcSStartDate.Value);
                    sqlParam[2] = new SqlParameter("@EndDate", wdcSEndDate.Value);
                    sqlParam[3] = new SqlParameter("@Shift", ddlShift.SelectedValue);
                    sqlParam[4] = new SqlParameter("@SDayName",chkDays.Items[m].Text);
                    sqlParam[5] = new SqlParameter("@SDayValue", chkDays.Items[m].Value);
                    sqlParam[6] = new SqlParameter("@SDate", temp1.AddDays(-1));
                    dbMgr.ExecuteNonQuery("uspDialysisPatientScheduler", "TreatmentConnectionString", sqlParam);
                }
            }
            if (temp1 == dateCounter)
            {
                dateCounter = dateCounter.AddDays(1);
            }
        }
        string dayName = "";
        bool dayValue = false;

        foreach (ListItem item in chkDays.Items)
        {
            if (item.Selected)
            {
                dayName = item.Value;
                dayValue = true;
            }
            else
            {
                dayName = item.Value;
                dayValue = false;
            }
        }

        
    }
    protected void clearFields()
    {
        //wdcRegDate.Value = DateTime.Now;
        txtWeight.Text = "";
        ddlBloodGroup.DataBind();

    }
    protected void getHepatitisSerology()
    {
        DbManager dbMgr = new DbManager();
        String query = "SELECT        COnvert(varchar,HSDate,101) HSDate, HBsAg, AntiHCV, AntiHBs, HCVPCR, HBoV FROM DialysisPatientsHepatitisSerology WHERE (DialysisID = @DialysisID) Order By HSDate";
        SqlParameter[] sqlParam = { new SqlParameter("@DialysisID", Session["DialysisID"]) };
        DataTable dt = new DataTable();
        dt=dbMgr.ExecuteDataTableWithQuery(query, "TreatmentConnectionString", sqlParam);
        gvHepatitisSerolorgy.DataSource = dt;
        gvHepatitisSerolorgy.DataBind();
    }
    protected void btnSaveHepatitisSerology_Click(object sender, EventArgs e)
    {
        if (txtHSDate.Text != "")
        {
            saveHepatitisSerology();
            getHepatitisSerology();
        }
    }
    protected void btnSaveMainDialysis_Click(object sender, EventArgs e)
    {
        saveMain();
    }
    protected void btnSaveScheduler_Click(object sender, EventArgs e)
    {
        saveScheduler();
    }
    protected void bindWeekDays()
    {
        DbManager dbMgr = new DbManager();
        DataTable dt = new DataTable();
        SqlParameter[] sqlParam={(new SqlParameter("@Day_Name","%"))};
        dt = dbMgr.ExecuteDataTableWithQuery("SELECT Day_Name, Day_ID FROM Week_Day Where Day_Name Like @Day_Name", "BasicDataInfoConnectionString",sqlParam);
        chkDays.DataSource = dt;
        chkDays.DataBind();
    }
    protected void bindShifts()
    {
        DbManager dbMgr = new DbManager();
        DataTable dt = new DataTable();
        SqlParameter[] sqlParam = { (new SqlParameter("@SubDept_ID", "2")) };
        dt = dbMgr.ExecuteDataTableWithQuery("Select Session_ID ShiftID,Session_Name ShiftName From Appointment_Sessions Where SubDept_ID=@SubDept_ID and Session_ID in (Select Session_Id From Admin_Doctor_Time_Slice)", "Reg_ConnectionString",sqlParam);
        ddlShift.DataSource = dt;
        ddlShift.DataBind();
    }
    protected void checkDialysis()
    {
        DbManager dbm = new DbManager();
        DataTable dt =new DataTable();
        SqlParameter[] sqlParam = { new SqlParameter("@RegNo", Session["registrationno"]), new SqlParameter("@YearlyNo", Session["yearlyno"]) };
        dt = dbm.ExecuteDataTable("uspCheckDialysisSession", "TreatmentConnectionString", sqlParam);
        if(dt.Rows.Count>0)
        {
            DateTime d = new DateTime();
            d = Convert.ToDateTime(dt.Rows[0]["DialysisRegDate"].ToString());
            Session.Add("DialysisID", dt.Rows[0]["DialysisID"].ToString());
            txtDiagnosis.Text = dt.Rows[0]["Diagnosis"].ToString();
            txtDiagnosis.Enabled = false;
            txtWeight.Text = dt.Rows[0]["IBWeight"].ToString();
            txtWeight.Enabled = false;
            txtRegDate.Text = d.ToString("yyyy-MM-dd");
            txtRegDate.Enabled = false;
            ddlFailureCause.SelectedValue= dt.Rows[0]["CORFailure"].ToString();
            ddlFailureCause.Enabled = false;
            ddlBloodGroup.SelectedValue = dt.Rows[0]["BloodGroup"].ToString();
            ddlBloodGroup.Enabled = false;
        }
    }
    
}