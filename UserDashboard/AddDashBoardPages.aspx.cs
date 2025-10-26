using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class DashBoards_AddDashBoardPages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (txtAddHeading.Text.Trim() != "" && txtReportName.Text.Trim() != "" && txtURL.Text.Trim() != "")
        {
            if (btnSave.Text == "Save")
            {
                saveData();
            }
            else
            {
                UpdateData();
            }
            lblMsg.Visible = true;
            bindGrid();
            txtReportName.Text = "";
            txtURL.Text = "";
        }
    }
    protected void saveData()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParams = { new SqlParameter("@Module_Name", txtAddHeading.Text),
                                         new SqlParameter("@Reprot_Name", txtReportName.Text),
                                         new SqlParameter("@URL", txtURL.Text)};
            dbMgr.ExecuteNonQuery("usp_InsertSystemReports", "BasicDataInfoConnectionString", sqlParams);
        }
        catch (Exception ex)
        {
        }
    }
    protected void UpdateData()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] sqlParams = { new SqlParameter("@Module_Name", txtAddHeading.Text),
                                         new SqlParameter("@Reprot_Name", txtReportName.Text),
                                         new SqlParameter("@URL", txtURL.Text),
            new SqlParameter("@ID", hid.Value)};
            dbMgr.ExecuteNonQuery("usp_UpdateSystemReports", "BasicDataInfoConnectionString", sqlParams);
            btnSave.Text = "Save";
            bindGrid();
        }
        catch (Exception ex)
        {
        }
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchModules(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Distinct Module_Name From System_Reports Where Module_Name LIKE '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Module_Name"].ToString(), ""));
        }
        return items;
    }

    protected void imgDelete_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgDel=sender as ImageButton;
        DbManager dbMgr = new DbManager();
        SqlParameter[] sqlParams = { new SqlParameter("@System_Report_Id", imgDel.CommandArgument) };
        dbMgr.ExecuteNonQuery("usp_DeleteSystemReports", "BasicDataInfoConnectionString", sqlParams);
        bindGrid();
    }
    protected void ImageEdit_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgDel = sender as ImageButton;
        GridViewRow row= (GridViewRow)imgDel.NamingContainer;
        hid.Value = imgDel.CommandArgument;
      HiddenField heading= (HiddenField) row.FindControl("HiddenField1");
        txtAddHeading.Text = heading.Value;
        HiddenField hfdReportName = (HiddenField)row.FindControl("HiddenField2");
        txtReportName.Text = hfdReportName.Value;
        HiddenField hfdtURL = (HiddenField)row.FindControl("HiddenField3");
        txtURL.Text = hfdtURL.Value;
        btnSave.Text = "Update";
        //DbManager dbMgr = new DbManager();
        //SqlParameter[] sqlParams = { new SqlParameter("@System_Report_Id", imgDel.CommandArgument) };
        //dbMgr.ExecuteNonQuery("usp_DeleteSystemReports", "BasicDataInfoConnectionString", sqlParams);
        //bindGrid();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (txtAddHeading.Text.Trim() != "")
        {
            bindGrid();
        }
    }
    protected void bindGrid()
    {
        try
        {
            SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString);
            String query = "SELECT        Module_Name, Reprot_Name, URL, System_Report_Id FROM System_Reports where Module_Name='"+txtAddHeading.Text+"'";
            SqlCommand cmd = new SqlCommand(query, con);

            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataTable dt = new DataTable();

            da.Fill(dt);

            gvSystemReports.DataSource = dt;
            gvSystemReports.DataBind();
        }
        catch (Exception ex)
        {
        }
    }
}