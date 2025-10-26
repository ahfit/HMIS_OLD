using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Configuration;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Drawing;
public partial class Pt_EMR_Controls_InveestigationChartControlForRadialogy : System.Web.UI.UserControl
{
    string VisitDate = "";
    String Conster = ConfigurationManager.ConnectionStrings["RadiologyConnectionString"].ToString();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadData();
            
            DirectoryInfo di = new DirectoryInfo(Server.MapPath("~/pt_EMR/Images"));

            foreach (FileInfo file in di.GetFiles())
            {
                file.Delete();
            }

        }
    }


    private void LoadData()
    {
        //DataSet ds = new DataSet();
        //DbManager manager = new DbManager();
        //ds = manager.ExecuteDataSet("patientTestsWrtRegNo", "Path_ConnectionString", new SqlParameter[] { new SqlParameter() { ParameterName = "regno", Value = Session["registrationNo"] } });
        //mainRepeater.DataSource = ds;
        //mainRepeater.DataBind();

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
     
        SqlParameter[] sqlParams = {
                new SqlParameter("@regno", Session["registrationNo"]),
                new SqlParameter("@YearlyNo", Session["YearlyNo"])
                };

        ds = manager.ExecuteDataSet("patientTestsWrtRegNo", "RadiologyConnectionString", sqlParams);
        repaterSub.DataSource = ds;
        repaterSub.DataBind();
    }


    protected void lnkbtnTestName_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        string testID = lnkbtn.CommandArgument;

        lblTName.Text = lnkbtn.Text;

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("Report_GetPatientRadiologyTestResults", "RadiologyConnectionString", new SqlParameter[] 
        {            
            new SqlParameter() { ParameterName = "@TBId", Value = testID } ,
            new SqlParameter() { ParameterName = "@YearlyNo", Value = lnkbtn.ToolTip.Trim() }
        });
        ddlImages.DataSource = ds.Tables[0];
        ddlImages.DataBind();
        divRemarks.InnerHtml = "";

        if (ds.Tables[1].Rows.Count > 0)
        {
            divRemarks.InnerHtml = ds.Tables[1].Rows[0]["Report"].ToString();
            divResult.Visible = true;
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "enlargeImage()",false);
        
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
        catch (Exception ex)
        {
        }
    }
   
    protected void btnVerifyAll_Click(object sender, EventArgs e)
    {
        DbManager objDbManager = new DbManager();

        for (var b = 0; b < repaterSub.Rows.Count; b++)

        {
            CheckBox chkVerify = (CheckBox)repaterSub.Rows[b].FindControl("chkVerify");
            if (chkVerify.Checked)
            {
                HiddenField hdnPsId = (HiddenField)repaterSub.Rows[b].FindControl("hdnPsId");
                HiddenField hdnYearlyNo = (HiddenField)repaterSub.Rows[b].FindControl("hdnYearlyNo");

                SqlParameter[] sqlParams = {
                    new SqlParameter("@PsId", hdnPsId.Value),
                    new SqlParameter("@ConsultantId", Session["emp_id"]),
                    new SqlParameter("@VisitId", hdnYearlyNo.Value)
                };
                objDbManager.ExecuteNonQuery("PatientTestVerified", "RadiologyConnectionString", sqlParams);
            }
        }
        LoadData();
    }

    protected void chkVerifyHeader_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox rd = (CheckBox)sender;
        GridViewRow row = (GridViewRow)rd.NamingContainer;
        CheckBox chkVerifyHeader = (CheckBox)row.FindControl("chkVerifyHeader");

        for (var b = 0; b < repaterSub.Rows.Count; b++)
        {
            CheckBox chkVerify = (CheckBox)repaterSub.Rows[b].FindControl("chkVerify");
            if (chkVerifyHeader.Checked)
            {
                chkVerify.Checked = true;
            }
            else
            {
                chkVerify.Checked = false;
            }
        }

    }

    protected void repaterSub_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label status =(Label) e.Row.FindControl("lblStatus");
            CheckBox chkVerify = (CheckBox)e.Row.FindControl("chkVerify");
            Label lblVerified = (Label)e.Row.FindControl("lblVerified");


            HiddenField hfPrimaryConsultant = (HiddenField)e.Row.FindControl("hfPrimaryConsultant");
            HiddenField hfSecondaryConsultant = (HiddenField)e.Row.FindControl("hfSecondaryConsultant");

            if(hfPrimaryConsultant.Value!="" || hfSecondaryConsultant.Value != "")
            {
                chkVerify.Visible = false;
                lblVerified.Visible = true;
                lblVerified.CssClass = "Active";
                lblVerified.ToolTip = hfPrimaryConsultant.Value + hfSecondaryConsultant.Value;
            }

            if (status.Text == "Advice")
            {
                status.CssClass = "Advice";
            }

            if (status.Text == "Sample Collection")
            {
                status.CssClass = "Sample-Collection";
            }


            if (status.Text == "Sample Received")
            {
                status.CssClass = "Sample-Received";
            }

            if (status.Text == "Result Entry")
            {
                status.CssClass = "Result-Entry";
            }

            if (status.Text == "Test Cancel")
            {
                status.CssClass = "Test-Cancel";
            }

            if (status.Text == "Test Conducted")
            {
                status.CssClass = "Test-Conducted";
            }
            if (status.Text == "Un Delivered Reports")
            {
                status.CssClass = "Un-Delivered";
            }

            if (status.Text == "Delivered Report")
            {
                status.CssClass = "Delivered";
            }


            if (status.Text == "Ready")
            {
                status.CssClass = "Sample-Collection";
            }

            if (status.Text == "Verify")
            {
                status.CssClass = "Test-Conducted";
            }


        }

    }


    protected void ddlImages_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if(e.Item.ItemType==ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            DataRowView drv = e.Item.DataItem as DataRowView;
            if (drv != null)
            {
               System.Web.UI.WebControls.Image RadImage =(System.Web.UI.WebControls.Image) e.Item.FindControl("RadImage");
                HtmlAnchor anchorImg= (HtmlAnchor)e.Item.FindControl("anchorImg");

                byte[] image = (byte[])drv["ImageFile"];
                string base64 = Convert.ToBase64String(image);
                RadImage.ImageUrl = "data:Image/png;base64," + base64;
                RadImage.Attributes.Add("onclick", "enlargeImage()");


                byte[] imageBytes = Convert.FromBase64String(base64);
                MemoryStream ms = new MemoryStream(imageBytes, 0, imageBytes.Length);
                ms.Write(imageBytes, 0, imageBytes.Length);
                System.Drawing.Image image1 = System.Drawing.Image.FromStream(ms, true);

                Guid id = Guid.NewGuid();
                
                image1.Save(Server.MapPath("~/pt_EMR/Images/RadiologyImage" + id + ".png"));
                anchorImg.HRef = "~/pt_EMR/Images/RadiologyImage" + id + ".png";
                

            }
        }
    }

    protected void btnPrevTests_Click(object sender, EventArgs e)
    {

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();

        SqlParameter[] sqlParams = {
                new SqlParameter("@regno", Session["registrationNo"])
                };

        ds = manager.ExecuteDataSet("Radiology_GetPatientPrevTests", "RadiologyConnectionString", sqlParams);

        GridView_PrevTests.DataSource = ds;
        GridView_PrevTests.DataBind();

        panel_PrevTests.Visible = true;
    }
    protected void lnkbtnTestNamePrev_Click(object sender, EventArgs e)
    {
        LinkButton lnkbtn = sender as LinkButton;
        string testID = lnkbtn.CommandArgument;

        lblTName.Text = lnkbtn.Text;

        DataSet ds = new DataSet();
        DbManager manager = new DbManager();
        ds = manager.ExecuteDataSet("Report_GetPatientRadiologyTestResults", "RadiologyConnectionString", new SqlParameter[]
        {
            new SqlParameter() { ParameterName = "@TBId", Value = testID } ,
            new SqlParameter() { ParameterName = "@YearlyNo", Value = lnkbtn.ToolTip.Trim() }
        });
        ddlImagesPrev.DataSource = ds.Tables[0];
        ddlImagesPrev.DataBind();
        divRemarksPrev.InnerHtml = "";

        if (ds.Tables[1].Rows.Count > 0)
        {
            divRemarksPrev.InnerHtml = ds.Tables[1].Rows[0]["Report"].ToString();
            divResultPrev.Visible = true;
        }
       // ScriptManager.RegisterStartupScript(this, this.GetType(), "alertUser", "enlargeImage()", false);

    }
    protected void Button_ClosePrevTest_Panel_Click(object sender, EventArgs e)
    {        
        panel_PrevTests.Visible = false;        
    }
}