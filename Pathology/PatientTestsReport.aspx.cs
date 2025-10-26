using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Pathology_PatientTestsReport : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ToString();
    String coBasic = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(! IsPostBack)
        {
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet);
            txtfromdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txttodate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txtTimeFrom.Text = DateTime.Now.AddHours(-1).ToString("hh:mm");
            txtTimeTo.Text = DateTime.Now.ToString("hh:mm");
            loadDepartments();
            loadTestStatus();
            loadUser();
            loadUserShift();
            loadGroup();
        }
    }
    private void loadDepartments()
    {

        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams =
        {
            new SqlParameter("@HospitalId", Session["HospitalId"]),
            new SqlParameter("@Type", "1")
        };

        DataTable dt = objDbManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams);
        ddlDepartment.DataSource = dt;
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, new ListItem("All", "0"));

    }
    private void loadGroup()
    {
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT 0 TGID , ' All' TGName  union SELECT TGID ,TGName FROM TestGroup order by TGName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DropDownList_MGName.DataSource = dt;
            DropDownList_MGName.DataValueField = "TGID";
            DropDownList_MGName.DataTextField = "TGName";
            DropDownList_MGName.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    private void loadUser()
    {
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("Select 0 EmpID ,' All' EmpName union SELECT     EmpID, isnull(EFName,'') +' '+ isnull(EMName,'') +' '+ isnull(ELName,'') as EmpName FROM   Employee where  SubDeptId in (19) order by EmpName", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DDLEmployee.DataSource = dt;
            DDLEmployee.DataValueField = "EmpID";
            DDLEmployee.DataTextField = "EmpName";
            DDLEmployee.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    private void loadUserShift()
    {
        SqlConnection con = new SqlConnection(coBasic);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT  0 as Shift_ID, 'All' as Shift   union SELECT Shift_ID  ,  Shift  FROM   Shift", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();
            da.Fill(dt);
            DDLShift.DataSource = dt;
            DDLShift.DataValueField = "Shift_ID";
            DDLShift.DataTextField = "Shift";
            DDLShift.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["Path_ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "select s_id,S_Name from Admin_Services where S_Category in (12,26,29,63,64,75,79) and S_Name  LIKE '%' + @Search + '%' order by S_Name";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["S_Name"].ToString(), sdr["s_id"].ToString()));
        }
        return items;
    }
    private void loadTestStatus()
    {
        SqlConnection con = new SqlConnection(connstr);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("select 0 Status_ID,'All' Status union select Status_ID,Status from Test_Status where act_status=1 order by Status_ID", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            
            DataTable dt = new DataTable();
            da.Fill(dt);
            DDLStatus.DataSource = dt;
            DDLStatus.DataValueField = "Status_ID";
            DDLStatus.DataTextField = "Status";
            DDLStatus.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }

    }

    private void ShowData()
    {
        SqlConnection con = new SqlConnection(connstr);
        DataTable dt = new DataTable();


        string dateFrom = Convert.ToDateTime(txtfromdate.Text).ToString("yyyy-MM-dd");
        string dateTo = Convert.ToDateTime(txttodate.Text).ToString("yyyy-MM-dd");
        DateTime sDate = Convert.ToDateTime(txtfromdate.Text) + TimeSpan.Parse(txtTimeFrom.Text);
        DateTime eDate = Convert.ToDateTime(txttodate.Text) + TimeSpan.Parse(txtTimeTo.Text);
        try
        {
            SqlCommand sc = new SqlCommand("GetPatientTest", con);
            sc.CommandType = CommandType.StoredProcedure;

            sc.Parameters.AddWithValue("@RegNo", txtMrNo.Text.Trim());
            sc.Parameters.AddWithValue("@PFName", txtPFName.Text.Trim());
            sc.Parameters.AddWithValue("@Date_From", sDate);
            sc.Parameters.AddWithValue("@Date_To", eDate);
          //  sc.Parameters.AddWithValue("@SubDeptID", Session["SubDeptID"]);
            sc.Parameters.AddWithValue("@Status", DDLStatus.SelectedValue);
            sc.Parameters.AddWithValue("@Search", hfItemCode.Value);
            sc.Parameters.AddWithValue("@SendOutStatus", CheckBoxSendOutTest.Checked);
            sc.Parameters.AddWithValue("@Empid",DDLEmployee.SelectedValue);
            sc.Parameters.AddWithValue("@ShiftId", DDLShift.SelectedValue);
            sc.Parameters.AddWithValue("@DeptId", ddlDepartment.SelectedValue);
            sc.Parameters.AddWithValue("@TGID", DropDownList_MGName.SelectedValue);
            sc.Parameters.AddWithValue("@MainID", txtLabNo.Text.Trim());

            SqlDataAdapter sda = new SqlDataAdapter(sc);
            sda.Fill(dt);
        }
        catch (Exception ex)
        {
            Response.Redirect("Exception Message : " + ex.Message);
        }
        finally
        {
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/PatientTestReportCrossWise.rdlc");
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));
            ReportParameter rp = new ReportParameter("StartDate", Convert.ToDateTime(txtfromdate.Text).ToString("yyyy-MM-dd"));
            ReportParameter rp2 = new ReportParameter("EndDate", Convert.ToDateTime(txttodate.Text).ToString("yyyy-MM-dd"));

            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            ReportViewer1.LocalReport.SubreportProcessing += subReports;
            ReportViewer1.LocalReport.Refresh();
            ReportViewer1.Visible = true;
            con.Close();
            //if (Request.Browser.Browser == "Chrome")
            //{
            //    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            //    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            //    Response.ContentType = "application/pdf";
            //    Response.BinaryWrite(bytes);
            //    Response.End();
            //}

        }
    }

    public void subReports(object sender, SubreportProcessingEventArgs e)
    {
        try
        {
            e.DataSources.Clear();
            DataTable dt = (DataTable)Session["DynamicHeader"];
            e.DataSources.Add(new ReportDataSource("DataSet1", dt));
            e.DataSources.Add(new ReportDataSource("DataSetFooter", dt));

        }
        catch (Exception)
        {
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ShowData();
        //txtS_Name.Text = "";
    }
}