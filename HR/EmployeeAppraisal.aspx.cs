using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class HR_EmployeeAppraisal : System.Web.UI.Page
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
            GetEvaluationFactosMain();
            
        }
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
        DataTable dt = manager.ExecuteDataTableWithQuery(@"SELECT SubDepartment.SubDept_Id,Department.Dept_Name FROM SubDepartment 
inner join Department ON SubDepartment.Dept_Id=Department.Dept_Id 
 ", "Basic_Data_ConnectionString", new SqlParameter[] {   });


        DropDownListSubDepartment.DataSource = dt;
        DropDownListSubDepartment.DataValueField = "SubDept_Id";
        DropDownListSubDepartment.DataTextField = "Dept_Name";

        DropDownListSubDepartment.DataBind();

    }

    private void Employee()
    {
        DbManager manager = new DbManager();

        DataTable dt = manager.ExecuteDataTableWithQuery(@"select empid,isnull(efname,'')+' '+isnull(emname,'')+' '+isnull(elname,'') as Name from employee where SubDeptId="+DropDownListSubDepartment.SelectedValue+"",
            "Basic_Data_ConnectionString", new SqlParameter[] {   });

        ddlEmployee.DataSource = dt;
        ddlEmployee.DataValueField = "empid";
        ddlEmployee.DataTextField="Name";
        ddlEmployee.DataBind();        
    }


    protected void DropDownListSubDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {
        Employee();
        BindDropDown();

        GetEvaluationFactosMain();
    }
    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindDropDown();

        GetEvaluationFactosMain();
    }
    protected void btnsave_Click(object sender, EventArgs e)
    {
        SaveDataOfAppraisalEvalution();
        lblmsg.Text = "Saved Successfully . . .";
        lblmsg.Visible = true;
        GetEvaluationFactosMain();
        Panel1.Visible = false;
    }

    protected void GetEvaluationFactosMain()
    {
        DbManager manager = new DbManager();


        SqlParameter[] par = {
        new SqlParameter("@EmpId",ddlEmployee.SelectedValue),
        new SqlParameter("@Type","Appraisal"),
        new SqlParameter("@DesignationID",ddlDesignation.SelectedValue),
        new SqlParameter("@subdeptid",DropDownListSubDepartment.SelectedValue),
        new SqlParameter("@FinancialYearId",ddlFinancialYear.SelectedValue),



        };

        DataSet ds = manager.ExecuteDataSet("GetEvaluationFactorsByTypeForEmployeeofAppraisal", "HRConnectionString", par);
        repeaterEvaluationOuter.DataSource = ds;
        repeaterEvaluationOuter.DataBind();

        //if (ds.Tables[0].Rows.Count > 0)
        //{
        //    tblEvaluation.Visible=false;EmployeeAppraisal
        //}
        //else
        //{
        //    tblEvaluation.Visible = true;
        //}


    }


    protected DataSet GetEvaluationFactosSub(int MainIDAppraisal, int factorID)
    {
        DbManager manager = new DbManager();


        SqlParameter[] par = {
        new SqlParameter("@MainIDAppraisal",MainIDAppraisal),
        new SqlParameter("@factorID",factorID),
        new SqlParameter("@designationID",ddlDesignation.SelectedValue),
        new SqlParameter("@empid",ddlEmployee.SelectedValue)
         
        };

        DataSet ds = manager.ExecuteDataSet("GetEvaluationFactorsByTypeForEmployeeofAppraisalSub", "HRConnectionString", par);
        return ds;
    }


    private void SaveDataOfAppraisalEvalution()
    {
        con_hr.Open();
        SqlCommand cmd = new SqlCommand("uspSaveEvalution", con_hr);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@empID", ddlEmployee.SelectedValue);
        cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
        cmd.Parameters.AddWithValue("@financialYear", ddlFinancialYear.SelectedValue);
        cmd.Parameters.AddWithValue("@subdeptid", DropDownListSubDepartment.SelectedValue);
        cmd.Parameters.AddWithValue("@DesignationID", ddlDesignation.SelectedValue);
        cmd.Parameters.AddWithValue("@Remarks", rdlRemarks.SelectedValue);

        cmd.Parameters.Add("@EmployeeAppraisalMainID", SqlDbType.Int, 18);
        cmd.Parameters["@EmployeeAppraisalMainID"].Direction = ParameterDirection.Output;

        cmd.ExecuteNonQuery();
        int mainID = int.Parse(cmd.Parameters["@EmployeeAppraisalMainID"].Value.ToString());

        con_hr.Close();
        for (int i = 0; i < repeaterEvaluationOuter.Items.Count; i++)
        {
            HiddenField hfYear = (HiddenField)repeaterEvaluationOuter.Items[i].FindControl("HfFinncialYearId");
            if (ddlFinancialYear.SelectedValue == hfYear.Value || hfYear.Value == "0")
            {
                Repeater repater = repeaterEvaluationOuter.Items[i].FindControl("repeaterEvaluationInner") as Repeater;
                for (int j = 0; j < repater.Items.Count; j++)
                {
                    HiddenField hfFactorId = repater.Items[j].FindControl("hfFactorId") as HiddenField;
                    HiddenField hfFactorDetailId = repater.Items[j].FindControl("hfFactorDetailId") as HiddenField;
                    HiddenField hfEvaluationIdMain = repater.Items[j].FindControl("hfEvaluationIdMain") as HiddenField;
                    HiddenField hfEvaluationIdSub = repater.Items[j].FindControl("hfEvaluationIdSub") as HiddenField;
                    TextBox txtboxGetMarks = repater.Items[j].FindControl("txtboxGetMarks") as TextBox;
                    TextBox txtboxRemarks = repater.Items[j].FindControl("txtboxRemarks") as TextBox;

                    con_hr.Open();
                    SqlCommand cmdd = new SqlCommand("uspSaveEvalutionSub", con_hr);
                    cmdd.CommandType = CommandType.StoredProcedure;
                    cmdd.Parameters.AddWithValue("@FactorID", hfFactorId.Value);
                    cmdd.Parameters.AddWithValue("@FactorDetailID", hfFactorDetailId.Value);
                    cmdd.Parameters.AddWithValue("@EmployeeAppraisalMainID", mainID);
                    cmdd.Parameters.AddWithValue("@GetMarks", txtboxGetMarks.Text);
                    cmdd.Parameters.AddWithValue("@Remarks", txtboxRemarks.Text);

                    cmdd.ExecuteNonQuery();
                    con_hr.Close();
                }
            }
        }
       

       

    }

    private void FinancialYear()
    {
        DbManager manager = new DbManager();
        // DataTable dt = manager.ExecuteDataTable_Query(@"SELECT SubDept_Name, SubDept_Id FROM SubDepartment", "Basic_Data_ConnectionString", new SqlParameter[] { });
        DataTable dt = manager.ExecuteDataTableWithQuery(@"select Financial_Year,Financial_Year_Id from Finance.dbo.Financial_Year order by SUBSTRING(Financial_Year,1,4) desc", "Basic_Data_ConnectionString", new SqlParameter[] { });


        ddlFinancialYear.DataSource = dt;
        ddlFinancialYear.DataValueField = "Financial_Year_Id";
        ddlFinancialYear.DataTextField = "Financial_Year";
        ddlFinancialYear.DataBind();

    }

    protected void repeaterEvaluationOuter_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
       if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
       {
           HiddenField hfAppraisalID=e.Item.FindControl("EmpAppraisalID") as HiddenField;
           HiddenField hfFactorId=e.Item.FindControl("hfFactorId") as HiddenField;
           Repeater RepeaterInner = e.Item.FindControl("repeaterEvaluationInner") as Repeater;

           RepeaterInner.DataSource = GetEvaluationFactosSub(int.Parse(hfAppraisalID.Value), int.Parse( hfFactorId.Value));
           RepeaterInner.DataBind();
           
       }
    }

    protected void ddlFinancialYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEvaluationFactosMain();
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        lbl_Ename.Text = ddlEmployee.SelectedItem.Text;
        lbl_FinancialYear.Text = ddlFinancialYear.SelectedItem.ToString();

        float GTotal = 0f;
        float totalGain = 0f;
        //GridView1.Rows.Count
        if (repeaterEvaluationOuter.Items.Count > 0)

        {
            // Repeater inner = (Repeater)repeaterEvaluationOuter.Controls.f("repeaterEvaluationInner");
            for (int i = 0; i < repeaterEvaluationOuter.Items.Count; i++)
            {
                Repeater inner = repeaterEvaluationOuter.Items[i].FindControl("repeaterEvaluationInner") as Repeater;
                for (int j = 0; j < inner.Items.Count; j++)
                {
                    String total = (inner.Items[j].FindControl("lblWeightage") as Label).Text;
                    String gain = (inner.Items[j].FindControl("txtboxGetMarks") as TextBox).Text;
                    if (!(string.IsNullOrEmpty(total)))                    {
                        GTotal += Convert.ToSingle(total);
                    }
                    if (!(string.IsNullOrEmpty(gain)))
                    {
                        totalGain += Convert.ToSingle(gain);
                    }
                }
                lbl_waitage.Text = GTotal.ToString();
                lbl_gain.Text = totalGain.ToString();
            }
        }
        Panel1.Visible = true;
        rdlRemarks.ClearSelection();
    }


    protected void Button3_Click(object sender, EventArgs e)
    {
        Panel1.Visible = false;
    }
}