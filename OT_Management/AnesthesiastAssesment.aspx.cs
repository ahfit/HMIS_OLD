using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class OT_Management_AnesthesiastAssesment : System.Web.UI.Page
{
    bool _IsSaved = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!IsPostBack)
        {
            JavaScriptMenu obj_menu = new JavaScriptMenu();
            LabelSideMenu.Text = obj_menu.SideMenu(Request.PhysicalPath.Substring (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length));
            LabelFooter.Text = obj_menu.Footer_String();

            GetQuestions();
          
        }
        
    }
   
    
    protected void GetQuestions()
    {
        DbManager manager = new DbManager();
        SqlParameter[] par = {                
        new SqlParameter("@YearlyNo",Request.QueryString["YearlyNo"]),
         new SqlParameter("@OutPut",SqlDbType.VarChar, 10, ParameterDirection.InputOutput, false, 0, 0, "0", DataRowVersion.Default, ""),
         new SqlParameter("@Type","Anesthetist Assesment")

        };
        

        DataSet ds = manager.ExecuteDataSet("GetOTQuestionsListsForPatientAssesment", "OT_ManagementConnectionString", par);

        string msg =par[1].Value.ToString();

        if (msg != "NO OT")
        {

            DataRelation dr = new DataRelation("OTQuestions", ds.Tables[0].Columns["HeadingId"], ds.Tables[1].Columns["HeadingId"]);

            ds.Relations.Add(dr);

            repeaterOTQuestionsOuter.DataSource = ds.Tables[0];
            repeaterOTQuestionsOuter.DataBind();

            txtDrRemarks.Text = ds.Tables[1].Rows[0]["DoctorRemarks"].ToString();
            hdnAssesmentId.Value= ds.Tables[1].Rows[0]["AssesmentId"].ToString();
            hdnOTOrderMainId.Value = ds.Tables[1].Rows[0]["Main_ID"].ToString();
        }
      

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            SaveAssesmentMain();
            DbManager manager = new DbManager();

            for (int i = 0; i <= repeaterOTQuestionsOuter.Items.Count - 1; i++)
                {

                    Repeater repeaterOTQuestionsInner = (Repeater)repeaterOTQuestionsOuter.Items[i].FindControl("repeaterOTQuestionsInner");

                    for (int j = 0; j <= repeaterOTQuestionsInner.Items.Count - 1; j++)
                    {

                        HiddenField hfHeadingId = ((HiddenField)repeaterOTQuestionsInner.Items[j].FindControl("hfHeadingId"));
                        HiddenField hfQuestionId = ((HiddenField)repeaterOTQuestionsInner.Items[j].FindControl("hfQuestionId"));
                        HiddenField hfAssesmentIdSub = ((HiddenField)repeaterOTQuestionsInner.Items[j].FindControl("hfAssesmentIdSub"));

                        RadioButton rdoYes = (RadioButton)repeaterOTQuestionsInner.Items[j].FindControl("rdoYes");
                        RadioButton rdoNo = (RadioButton)repeaterOTQuestionsInner.Items[j].FindControl("rdoNo");
                        TextBox txtRemarks = (TextBox)repeaterOTQuestionsInner.Items[j].FindControl("txtRemarks");
                       

                        string value = "";
                        if (rdoYes.Checked)
                        value = "Yes";

                        if (rdoNo.Checked)
                        value = "No";

                       

                        SqlParameter[] par1 = {
                        new SqlParameter("@AssesmentId",hdnAssesmentId.Value),
                        new SqlParameter("@AssesmentIdSub",hfAssesmentIdSub.Value),
                        new SqlParameter("@HeadingId",hfHeadingId.Value),
                        new SqlParameter("@QuestionId",hfQuestionId.Value),
                        new SqlParameter("@Value",value),
                        new SqlParameter("@Remarks",txtRemarks.Text)
                        };
                        manager.ExecuteNonQuery("AddAssesmentSub", "OT_ManagementConnectionString", par1);
                    }
                }

            
            lblmsg.Visible = true;
            lblmsg.ForeColor = System.Drawing.Color.Green;
            lblmsg.Text = "Saved Successfully";

            GetQuestions();
           
        }
        catch(Exception exp)
        {
            lblmsg.Visible = true;
            lblmsg.ForeColor = System.Drawing.Color.Red;
            lblmsg.Text = "Some error occured!";
        }
    }
   

    protected void SaveAssesmentMain()
    {
       
        DbManager manager = new DbManager();
        SqlParameter[] par = {
                new SqlParameter("@AssesmentId",SqlDbType.BigInt, 8, ParameterDirection.InputOutput, false, 0, 0, "0", DataRowVersion.Default, hdnAssesmentId.Value),
                new SqlParameter("@YearlyNo",Request.QueryString["YearlyNo"]),
                new SqlParameter("@MainId",hdnOTOrderMainId.Value),
                new SqlParameter("@Type","Anesthetist Assesment"),
                new SqlParameter("@DoctorRemarks",txtDrRemarks.Text.Trim()),
                new SqlParameter("@StatusId","4")
                };

        manager.ExecuteNonQuery("AddAssesmentMain", "OT_ManagementConnectionString", par);

        hdnAssesmentId.Value = par[0].Value.ToString();
    }
    protected void repeaterOTQuestionsOuter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //string name = ((HiddenField)e.Item.FindControl("hfName")).Value;
        Repeater repeaterOTQuestionsInner = (Repeater)e.Item.FindControl("repeaterOTQuestionsInner");
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            repeaterOTQuestionsInner.DataSource = ((DataRowView)e.Item.DataItem).CreateChildView("OTQuestions");  //need to add relationship name as parameter for CreateChildView once it has been defined above.
            repeaterOTQuestionsInner.DataBind();
        }
    }

    protected void repeaterOTQuestionsInner_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            RadioButton rdoYes = e.Item.FindControl("rdoYes") as RadioButton;
            RadioButton rdoNo = e.Item.FindControl("rdoNo") as RadioButton;
            TextBox txtRemarks = e.Item.FindControl("txtRemarks") as TextBox;
           


            DataRow row = ((DataRowView)e.Item.DataItem).Row;
            String value = row.Field<String>("Value");

            if (value == "Yes")
            {
                rdoYes.Checked = true;
            }
            else if (value == "No")
            {
                
                rdoNo.Checked = true;
            }

            txtRemarks.Text = row.Field<String>("Remarks");
        }
    }

}