using Microsoft.CSharp.RuntimeBinder;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_EvalutionFormSettingGeneric : System.Web.UI.Page
{
    
         SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BasicDataInfoConnectionString"].ConnectionString);
    SqlConnection con_hr = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString);
     public string str;
    public string sst;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FinancialYear();
            loadRecruitment();
        }
    }
   
    protected void loadRecruitment()
    {

        con_hr.Open();

        SqlCommand cmd = new SqlCommand("select '0' FactorId,'' as Name union select FactorId, Name from EvaluationFactors where isnull(active,0)=1 and types=@types", con_hr);
        cmd.Parameters.AddWithValue("@types",rbType.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        ddlHeading.DataSource = ds;
        ddlHeading.DataValueField = "FactorId";
        ddlHeading.DataTextField = "Name";
        ddlHeading.DataBind();
        con_hr.Close();

    }

   

    protected void ddlHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindGrid();
    }
    protected   void BindGrid()
    {
       
        DbManager objDbManager = new DbManager();
      
        SqlParameter[] sqlParams = new SqlParameter[] {
        new SqlParameter("@Type", rbType.SelectedItem.Text),
        new   SqlParameter("@FactorId",ddlHeading.SelectedValue),
        };
        gridFatorsDetails.DataSource = objDbManager.ExecuteDataTable("GetEvaluationFactorsDetails", "HRConnectionString", sqlParams);
        gridFatorsDetails.DataBind();
    }






    protected void btnsave_Click(object sender, EventArgs e)
    {
        headenter();
      
   
}
   
    private void headenter()
        {
        
        for (int i = 0; i < CheckBoxList_Emp.Items.Count; i++)

            if (CheckBoxList_Emp.Items[i].Selected == true)
            {

                DateTime now = DateTime.Now;
                con_hr.Open();
                SqlCommand cmd = new SqlCommand("employevalutioappraisal_Add", con_hr);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@EmpID", CheckBoxList_Emp.Items[i].Value);
                cmd.Parameters.AddWithValue("@Type", rbType.SelectedValue);
                cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
                cmd.Parameters.AddWithValue("@createdate", now);
                cmd.Parameters.AddWithValue("@factorid", ddlHeading.SelectedValue);
                cmd.Parameters.AddWithValue("@fianceyear", ddlFinancialYear.SelectedValue);
                cmd.Parameters.AddWithValue("@subdeptId", DDL_Branch.SelectedValue);
                cmd.Parameters.AddWithValue("@title", txtboxtilte.Text);
                cmd.Parameters.Add("@levelid", SqlDbType.Int, 50);
                cmd.Parameters["@levelid"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@EmployeeAppraisalID", SqlDbType.Int, 50);
                cmd.Parameters["@EmployeeAppraisalID"].Direction = ParameterDirection.Output;
                cmd.Parameters.Add("@status", SqlDbType.VarChar, 50);
                cmd.Parameters["@status"].Direction = ParameterDirection.Output;
                cmd.ExecuteNonQuery();
                con_hr.Close();
                lblmsg.Visible = true;
                lblmsg.Text= cmd.Parameters["@status"].Value.ToString();
                
               // lblmsg.Text = "Saved Successfully";
                str = cmd.Parameters["@EmployeeAppraisalID"].Value.ToString();
                sst = cmd.Parameters["@levelid"].Value.ToString();
                headerrow();
            }
      
    }

    private void headerrow()
    {
        for (int j = 0; j < gridFatorsDetails.Rows.Count; j++)

        {

            HiddenField hfFactorId = gridFatorsDetails.Rows[j].FindControl("hfFactorId") as HiddenField;
            HiddenField hfFactorDetailId = gridFatorsDetails.Rows[j].FindControl("hfFactorDetailId") as HiddenField;
            TextBox lblmarks = gridFatorsDetails.Rows[j].FindControl("lblmarks") as TextBox;
            CheckBox chkSelect = gridFatorsDetails.Rows[j].FindControl("chkSelect") as CheckBox;
            if (chkSelect.Checked)
            {
                con_hr.Open();
                SqlCommand cmdd = new SqlCommand("employevalutioappraisal_Add_row", con_hr);
                cmdd.CommandType = CommandType.StoredProcedure;
                cmdd.Parameters.AddWithValue("@factorid", hfFactorId.Value);
                cmdd.Parameters.AddWithValue("@factordetailid", hfFactorDetailId.Value);
                cmdd.Parameters.AddWithValue("@marks", lblmarks.Text);
                cmdd.Parameters.AddWithValue("@EmployAppraisalMain", str);
                cmdd.Parameters.AddWithValue("@levelid", sst);
                cmdd.ExecuteNonQuery();
                con_hr.Close();
                lblmsg.Visible = true;

            }
        }
    }
    protected void gridFatorsDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
       
            if (rbType.SelectedValue != "Probation")
            {
                //e.Row.Cells[3].Visible = false;
            }
      
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView dr = (DataRowView)e.Row.DataItem;

            if (dr["Selected"].ToString() == "True")
            {
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                chkSelect.Checked = true;
            }

            if (rbType.SelectedValue != "Probation")
            {
                //e.Row.Cells[3].Visible = false;
            }

        }
    }

    protected void rbType_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadRecruitment();
       // BindGrid();
    }


    protected void ddlFinancialYear_SelectedIndexChanged(object sender, EventArgs e)
    {
       
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

    protected void grdcheck_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox chk = (CheckBox)sender;
        foreach (GridViewRow rows in gridFatorsDetails.Rows)
        {
            CheckBox chkcheck = (CheckBox)rows.FindControl("chkSelect");
            chkcheck.Checked = chk.Checked ;
        }
    }

    protected void cbAll_CheckedChanged(object sender, EventArgs e)
    {

        for (int i = 0; i <= CheckBoxList_Emp.Items.Count - 1; i++)
        {
            CheckBoxList_Emp.Items[i].Selected = cbAll.Checked;
        }

    }
}