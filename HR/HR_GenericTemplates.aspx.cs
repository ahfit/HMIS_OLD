using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
public partial class HR_HR_GenericTemplates : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadTemplateType(); 
            LoadGenericTemplates();
        }
    }

    private void LoadTemplateType()
    {
        DbManager db = new DbManager();
        ddlTemplateType.DataSource = db.ExecuteDataTableWithQuery("select TemplateTypeID,TemplateType from hr_templatestype where Hospital_ID = @HospitalId", "HRConnectionString", new System.Data.SqlClient.SqlParameter[] { new SqlParameter("@HospitalId",Session["HospitalID"])});
        ddlTemplateType.DataValueField = "TemplateTypeID";
        ddlTemplateType.DataTextField = "TemplateType";
        ddlTemplateType.DataBind();

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        
        DbManager db = new DbManager();
        db.ExecuteNonQuery("uspInsertHr_GenericTemplates", "HRConnectionString", new SqlParameter[]{
                                        new SqlParameter("@TemplateName",txtboxTemplate.Text.Trim()),
                                        new SqlParameter("@Heading",txtboxHeadingName.Text.Trim()),
                                        new SqlParameter("@Body",textboxBody.Text.Trim()),
                                        new SqlParameter("@TemplateTypeID",ddlTemplateType.SelectedValue),                                        
                                        new SqlParameter("@ID",hfHrTemplateIDMain.Value)
            });
        btnSave.Text = "Save";
        LoadGenericTemplates();
        panel.Visible = false;
    }
    
    protected void btnAddGenericTemplate_Click(object sender, EventArgs e)
    {
        panel.Visible = true;
       
    }


    private void LoadGenericTemplates(){
            DbManager db = new DbManager();
           gvd.DataSource= db.ExecuteDataTable("usp_SelectHrTemplatesGeneric", "HRConnectionString", new SqlParameter[]{new SqlParameter("@HospitalId",Session["HospitalId"]) });
           gvd.DataBind();
           panel.Visible = false;
       
    }
    protected void lnkbtn_Click(object sender, EventArgs e)
    {
        LinkButton btn=sender as LinkButton;
        GridViewRow row=btn.NamingContainer as GridViewRow;
        HiddenField hfID = row.FindControl("hfID") as HiddenField;
        HiddenField hfTemplateTypeID = row.FindControl("hfTemplateTypeID") as HiddenField;
        HiddenField hfTemplateName = row.FindControl("hfTemplateName") as HiddenField;
        HiddenField hfTemplateHeading = row.FindControl("hfTemplateHeading") as HiddenField;
        


        textboxBody.Text = btn.CommandName;
        txtboxHeadingName.Text = hfTemplateHeading.Value;
        txtboxTemplate.Text = hfTemplateName.Value;
        ddlTemplateType.SelectedValue = hfTemplateTypeID.Value;
        hfHrTemplateIDMain.Value = hfID.Value;

        if (btnSave.Text=="Save")
        {
            btnSave.Text = "Update";
        }
        panel.Visible = true;
    }

    
    //protected void btnUpdate_Click(object sender, EventArgs e)
    //{
    //    DbManager db = new DbManager();
    //    db.ExecuteDataTableWithQuery("update HR_GenericLetterTemplates set ", "", new SqlParameter[] { new SqlParameter("", txtboxTempateForUpdate.Text.Trim()) });
    //}
}