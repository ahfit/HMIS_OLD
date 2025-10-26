using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Radiology_AddNewTemplate : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            getAllTemplates();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveTemplate();
        ClearFields();
    }

    [System.Web.Services.WebMethod]
    public static List<string> GetRadioTest(string prefixText, int count)
    {
        string conString = ConfigurationManager.ConnectionStrings["Admin_Rad_ConnectionString"].ConnectionString;
        List<string> tests = new List<string>();
        try
        {


            SqlConnection con = new SqlConnection(conString);
            con.Open();
            SqlCommand command = new SqlCommand("select TB_Name,TB_ID from Test_Booking where TB_Name like '%'+@TB_Name+'%' ", con);
            command.CommandType = CommandType.Text;
            command.Parameters.AddWithValue("@TB_Name", prefixText);
            SqlDataAdapter da = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            da.Fill(dt);
            con.Close();
            foreach (DataRow row in dt.Rows)
            {
                tests.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(row["TB_Name"].ToString(), (row["TB_ID"].ToString())));
            }

        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.Message);
        }
        return tests;

    }

    private void SaveTemplate()
    {
        try
        {
           
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("Templates_Name", txtTemplate.Text.Trim()), new SqlParameter("Templates_Description", TextBox_Description.Text)
                                  ,new SqlParameter("TB_Id",hdftest.Value), new SqlParameter("Template_Id",DDL_Template.SelectedValue)};
            dbMgr.ExecuteNonQuery("usp_InsertTemplate", "Admin_Rad_ConnectionString", para);
            TextBox_Description.Text = "";
            getAllTemplates();
        }
        catch (Exception ex)
        {

        }
    }
    private void ClearFields()
    {
        //txtGroup.Text = "";
        //hdftest.Value = "";
        //txtTemplate.Text="";
        //TextBox_Description.Text="";

    }
    private void getAllTemplates()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("TB_Id", hdftest.Value) };
            DataTable dt = dbMgr.ExecuteDataTable("usp_GetTemplate", "Admin_Rad_ConnectionString", para);
            DDL_Template.DataSource = dt;
            DDL_Template.DataBind();

            getTemplateDescription();
        }
        catch (Exception ex)
        {

        }
    }

    private void ViewReportStyle()
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("id", btnReport.CommandArgument) };
            DataTable dt = dbMgr.ExecuteDataTable("usp_getTemplateForDisplayStyle", "Admin_Rad_ConnectionString", para);
            ReportViewer1.LocalReport.DataSources.Clear();
            string reportPath = "";

            reportPath = Server.MapPath("Administrator/View_ReportStyle.rdlc");
            ReportViewer1.LocalReport.ReportPath = reportPath;
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("DataSet1", dt));

            ReportViewer1.LocalReport.Refresh();
            if (Request.Browser.Browser == "Chrome")
            {
                Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
                Response.ContentType = "application/pdf";
                Response.BinaryWrite(bytes);
                Response.End();
            }

            else
                ReportViewer1.Visible = true;
        }
        catch (Exception ex)
        {

        }
    }
    private void getTemplateDescription()
    {
        if (DDL_Template.Items.Count > 0)
        {
            try
            {
                DbManager dbMgr = new DbManager();
                SqlParameter[] para = { new SqlParameter("Radiology_templates_ID", DDL_Template.SelectedValue) };
                DataTable dt = dbMgr.ExecuteDataTable("usp_GetTemplateDescription", "Admin_Rad_ConnectionString", para);
                if (dt.Rows.Count > 0)
                {

                    txtTemplate.Text = dt.Rows[0]["Templates_Name"].ToString();
                    TextBox_Description.Text = dt.Rows[0]["Templates_Description"].ToString();
                    btnSave.CommandArgument = dt.Rows[0]["Radiology_templates_ID"].ToString();
                    btnReport.CommandArgument = dt.Rows[0]["Radiology_templates_ID"].ToString();
                }

            }
            catch (Exception ex)
            {

            }
        }
    }

    protected void DDL_Test_SelectedIndexChanged(object sender, EventArgs e)
    {
        getAllTemplates();
    }

    protected void DDL_Template_SelectedIndexChanged(object sender, EventArgs e)
    {
        getTemplateDescription();
       


    }
    protected void btnclear_Click(object sender, EventArgs e)
    {
        ClearFields();
    }
    protected void btnReport_Click(object sender, EventArgs e)
    {
        ViewReportStyle();
    }
    protected void btnDelTem_Click(object sender, EventArgs e)
    {
        try
        {
            DbManager dbMgr = new DbManager();
            SqlParameter[] para = { new SqlParameter("id",DDL_Template.SelectedValue) };
           dbMgr.ExecuteNonQuery("usp_DeleteTemplate", "Admin_Rad_ConnectionString", para);
           TextBox_Description.Text = "";
            getAllTemplates();
        }
        catch (Exception ex)
        {

        }
    }
}