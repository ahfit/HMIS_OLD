using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
public partial class HR_AddemployeeAppraisal: System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString);
    SqlConnection con_hr = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FinancialYear();
            SubDepartment();
            Employee();
            BindDropDown();
            LoadGridRecord();
            title();
            loadRecruitment();


        }
    }

    private void LoadGridRecord()
    {
       string firstname =  Request.QueryString["EmployeeAppraisalID"];
        DbManager manager = new DbManager();
        SqlParameter[] para = {
            new SqlParameter("@EmployeeAppraisalID",firstname)
        };
        DataTable dt = manager.ExecuteDataTable("GetEvaluationFactorsByTypeForEmployeeofAppraisals", "HRConnectionString", para);

        gridFatorsDetails.DataSource = dt;
        gridFatorsDetails.DataBind();
    }

    protected void loadRecruitment()
    {
        string firstname = Request.QueryString["EmployeeAppraisalID"];
        SqlCommand cmd = new SqlCommand(@"select distinct c.Name,c.FactorId from EmployeeAppraisalMain a inner join EmployeeAppraisalSub b on a.EmployeeAppraisalID=b.EmployeeAppraisalMain
 inner join EvaluationFactors c on b.FactorID=c.FactorId
 and EmployeeAppraisalMain=@EmployeeAppraisalMain", con_hr);
       cmd.Parameters.AddWithValue("@EmployeeAppraisalMain", firstname);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        ddlHeading.DataSource = ds;
        ddlHeading.DataValueField = "FactorId";
        ddlHeading.DataTextField = "Name";
        ddlHeading.DataBind();
       }


    protected void BindDropDown()
    {
        DbManager objDbManager = new DbManager();
        SqlParameter[] sqlParams = new SqlParameter[] { };
     ddlDesignation.DataSource = objDbManager.ExecuteDataTableWithQuery(@"select Designation_ID,Designation_Name from Designation
 inner join employee on Employee.DesignationID=Designation.Designation_ID  where EmpID=" + ddlEmployee.SelectedValue + "", "Basic_Data_ConnectionString", sqlParams);
        ddlDesignation.DataValueField = "Designation_ID";
        ddlDesignation.DataTextField = "Designation_Name";

        ddlDesignation.DataBind();
    }

    private void SubDepartment()
    {
        DbManager manager = new DbManager();
        // DataTable dt = manager.ExecuteDataTable_Query(@"SELECT SubDept_Name, SubDept_Id FROM SubDepartment", "Basic_Data_ConnectionString", new SqlParameter[] { });
        DataTable dt = manager.ExecuteDataTable(@"usp_GetSubDeprtmentsByHospital", "HRConnectionString", new SqlParameter[] {   });


        DropDownListSubDepartment.DataSource = dt;
        DropDownListSubDepartment.DataValueField = "SubDept_Id";
        DropDownListSubDepartment.DataTextField = "SubDept_Name";

        DropDownListSubDepartment.DataBind();

    }

    private void Employee()
    {
        string firstname = Request.QueryString["EmployeeAppraisalID"];
        DbManager manager = new DbManager();
        SqlParameter[] paraz = {
            new SqlParameter("@EmployeeAppraisalID",firstname)
        };
        DataTable dt = manager.ExecuteDataTableWithQuery(@"select distinct e.EmpID ,isnull(efname,'')+' '+isnull(emname,'')+' '+isnull(elname,'') as Name from employee e inner join EmployeeAppraisalMain m on m.EmpID=e.EmpID and m.EmployeeAppraisalID=@EmployeeAppraisalID ",
            "HRConnectionString", paraz);

        ddlEmployee.DataSource = dt;
        ddlEmployee.DataValueField = "EmpID";
        ddlEmployee.DataTextField="Name";
        ddlEmployee.DataBind();
     
    }


    protected void DropDownListSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Employee();
        BindDropDown();
        loadRecruitment();
      
    }
    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDropDown();
        loadRecruitment();
      
        title();
        LoadGridRecord();
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        SaveDataOfAppraisalEvalution();
        lblmsg.Text = "Saved Successfully . . .";
        lblmsg.Visible = true;
       
        
    }
    


    private void SaveDataOfAppraisalEvalution()
    {

      
    }

    private void FinancialYear()
    {
        string firstname = Request.QueryString["EmployeeAppraisalID"];
        SqlCommand cmd = new SqlCommand(@"select   Financial_Year,Financial_Year_Id from Finance.dbo.Financial_Year inner join EmployeeAppraisalMain m on m.FinancialYear=Financial_Year_Id where m.EmployeeAppraisalID=@EmployeeAppraisalID", con_hr);
         cmd.Parameters.AddWithValue("@EmployeeAppraisalID", firstname);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        ddlFinancialYear.DataSource = ds;
        ddlFinancialYear.DataValueField = "Financial_Year_Id";
        ddlFinancialYear.DataTextField = "Financial_Year";
        ddlFinancialYear.DataBind();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        string firstname = Request.QueryString["EmployeeAppraisalID"];
        for (int j = 0; j < gridFatorsDetails.Rows.Count; j++)
        {
            HiddenField hfEmployeeAppraisalID = gridFatorsDetails.Rows[j].FindControl("hfEmployeeAppraisalID") as HiddenField;
            HiddenField hfdid = gridFatorsDetails.Rows[j].FindControl("hfdid") as HiddenField;
            TextBox lblWeightage = gridFatorsDetails.Rows[j].FindControl("lblWeightage") as TextBox;
            TextBox txtRemarks = gridFatorsDetails.Rows[j].FindControl("txtRemarks") as TextBox;
            con_hr.Open();
            SqlCommand cmdd = new SqlCommand("addemployeeappraisal", con_hr);
            cmdd.CommandType = CommandType.StoredProcedure;
            cmdd.Parameters.AddWithValue("@EmployeeAppraisalMain", firstname);
            cmdd.Parameters.AddWithValue("@EmployeeAppraisalSubID", hfdid.Value);
            cmdd.Parameters.AddWithValue("@Enterby", Session["emp_id"]);
            cmdd.Parameters.AddWithValue("@weightage", lblWeightage.Text);
            cmdd.Parameters.AddWithValue("@Remarks", txtRemarks.Text);
            cmdd.ExecuteNonQuery();
          
            con_hr.Close();
        }
        lblmsg.Visible = true;
        lblmsg.Text = "Saved Successfully";
        btnforward.Enabled = true;
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        
    }

    protected void ddlHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }

    protected void ddltitle_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
      private void title()
    {

        SqlCommand cmd = new SqlCommand(@" select Top 1 Title from EmployeeAppraisalMain where EmpID=@EmpID", con_hr);
        cmd.Parameters.AddWithValue("@EmpID", ddlEmployee.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        ddltitle.DataSource = ds;
        ddltitle.DataValueField = "Title";
        ddltitle.DataTextField = "Title";
        ddltitle.DataBind();
    }
 protected void gridFatorsDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void btnforward_Click(object sender, EventArgs e)
    {
        string firstname = Request.QueryString["EmployeeAppraisalID"];
      
    
        con_hr.Open();
        SqlCommand cmdd = new SqlCommand("usp_ForwardEmployeeAppraisal", con_hr);
            cmdd.CommandType = CommandType.StoredProcedure;
            cmdd.Parameters.AddWithValue("@EmployeeAppraisalID", firstname);
            cmdd.ExecuteNonQuery();

            con_hr.Close();
       
        lblmsg.Visible = true;
        lblmsg.Text = " Successfully forward";
        btnforward.Enabled = true;
        Response.Redirect("EmployeeAppraisalRequest.aspx");
        //backpage();
    }
    //  private void backpage()
    // {
    //    HtmlMeta meta = new HtmlMeta();
    //    meta.HttpEquiv = "Refresh";
    //    meta.Content = "1;url=EmployeeAppraisalRequest.aspx";
    //    this.Page.Controls.Add(meta);
    //    Label1.Text = "You will now be redirected in 5 seconds";
    //}
}