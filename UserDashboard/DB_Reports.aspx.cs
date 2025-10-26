using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Configuration;
using Microsoft.VisualBasic;
using System.Collections;
using System.Diagnostics;
public partial class DashBoards_DB_Reports : System.Web.UI.Page
{
    string myScript = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadReportsDB();
            RegisterClientScript();
        }
    }

    private void LoadReportsDB()
    {
        Panel pnl = null;
        Literal ltr = null;
        StringBuilder sb = null;
        List<ReportsDTO> lstMenu = GetReportsDashboard();
        List<string> groups = lstMenu.GroupBy(i => i.Module_Name)
                                               .Select(i => i.Key)
                                               .ToList();

        foreach (string mnuMain in groups)
        {
            pnl = new Panel();
            pnl.CssClass = "ColumnLeftToRight";
            pnl.ID = "pnlAccordion_" + mnuMain.Replace(" ", "_").Replace("&", "_");
            ltr = new Literal();
            sb = new StringBuilder();
            sb.Append(string.Format("<h3 style='font-size: medium;'>{0}</h3><div class='LinksDiv'><ul>", mnuMain));

            myScript += "$(\"#ctl00_ContentPlaceHolder1_" + pnl.ID + "\" ).accordion({collapsible: true, active: false});";

            foreach (ReportsDTO t in lstMenu.Where(i => i.Module_Name == mnuMain))
            {
                sb.Append(string.Format("<li><a href='{0}' target='_blank' style='font-size: x-small;'>{1}</a></li>", GetPageURL(t.URL), t.Reprot_Name));
            }
            sb.Append("</ul></div>");
            ltr.Text = sb.ToString();
            pnl.Controls.Add(ltr);
            phMainMenu.Controls.Add(pnl);
        }
    }

    private string GetPageURL(string p)
    {
        string retVal = p;
        if (p.StartsWith("~/"))
            retVal = p.Replace("~/", "");
        retVal = Request.ApplicationPath + "/" + p;
        return retVal;
    }

    private List<ReportsDTO> GetReportsDashboard()
    {
        List<ReportsDTO> lstMenu = new List<ReportsDTO>();
        ReportsDTO mnuEnti = null;

        SqlConnection sqlCon = new SqlConnection(SystemSetting.Basic_Connection_String);
        SqlCommand sqlCmd = new SqlCommand();
        SqlDataReader dataReader = null;

        try
        {
            sqlCon.Open();
            sqlCmd.Connection = sqlCon;
            sqlCmd.CommandText = "usp_Get_DB_Reports";
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@emp_id", Session["emp_id"]);
            dataReader = sqlCmd.ExecuteReader();

            while (dataReader.Read())
            {
                mnuEnti = new ReportsDTO();
                mnuEnti.Module_Name = dataReader.GetString(0);
                mnuEnti.Reprot_Name = dataReader.GetString(1);
                mnuEnti.URL = dataReader.GetString(2);
                lstMenu.Add(mnuEnti);
            }
        }
        catch (Exception)
        {
            lstMenu = new List<ReportsDTO>();
        }
        finally
        {
            if (dataReader != null && dataReader.IsClosed == false)
                dataReader.Close();
            if (sqlCon != null && sqlCon.State == ConnectionState.Open)
                sqlCon.Close();
            if (sqlCmd != null)
                sqlCmd.Dispose();
        }

        return lstMenu;
    }


    private void RegisterClientScript()
    {
        myScript = "$(function() {" + myScript + "});";
        Page.ClientScript.RegisterStartupScript(this.GetType(), "myKey", myScript, true);
    }

    protected void imgBtnSearch_Click(object sender, ImageClickEventArgs e)
    {
        LoadReportsDB();
        RegisterClientScript();
    }
}

public class ReportsDTO
{
    public ReportsDTO()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string Module_Name
    {
        get;
        set;
    }

    public string Reprot_Name
    {
        get;
        set;
    }

    public string URL
    {
        get;
        set;
    }


}

public class SystemSetting
{

    private static string conString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
    public static string Basic_Connection_String = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;

    public static string Store_Connection_String = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    public static SystemSetting GetSystemSettingByID(int settingId)
    {

        SystemSetting sysSetting = new SystemSetting();
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd = new SqlCommand();
        SqlDataReader reader = default(SqlDataReader);

        try
        {
            con.Open();
            cmd.Connection = con;
            cmd.CommandText = "usp_GetSystemSetting";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SystemSettingID", SqlDbType.Int).Value = settingId;
            reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                sysSetting.Setting_ID = reader.GetInt32(reader.GetOrdinal("Setting_ID"));
                sysSetting.Setting_Name = reader.GetString(reader.GetOrdinal("Setting_Name"));
                sysSetting.Setting_Value = reader.GetString(reader.GetOrdinal("Setting_Value"));

            }


        }
        catch (Exception ex)
        {

        }
        finally
        {
            if (cmd != null)
            {
                cmd.Dispose();
            }

            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }

        }

        return sysSetting;

    }

    private int _Setting_ID;
    public int Setting_ID
    {
        get { return _Setting_ID; }
        set { _Setting_ID = value; }
    }


    private string _Setting_Name;
    public string Setting_Name
    {
        get { return _Setting_Name; }
        set { _Setting_Name = value; }
    }


    private string _Setting_Value;
    public string Setting_Value
    {
        get { return _Setting_Value; }
        set { _Setting_Value = value; }
    }


}

