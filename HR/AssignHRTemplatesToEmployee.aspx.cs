using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CkEditor;
public partial class HR_AssignHRTemplatesToEmployee : System.Web.UI.Page
{
    string _conStr = ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetDepartment();
            GetEmployeeDetailForSearch();
            GetAllEmployee();
           GetTemplates();
            LoadTemplateData();
            GetEmployeeDetail();
            GetEmployeeDetailWithTemplates();

        }
    }
    private void GetDepartment()
    {
        DbManager objManager = new DbManager();
        SqlParameter[] sqlParams = new[] {
        new SqlParameter("@HospitalId", Session["HospitalId"]),
        new SqlParameter("@Type", "0")
          };
        DataTable dt = objManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams);
        ddlSubdept.DataSource = dt;
        ddlSubdept.DataTextField = "SubDept_Name";
        ddlSubdept.DataValueField = "SubDept_Id";
        ddlSubdept.DataBind();


        ddLDepartmentForSearch.DataSource = dt;
        ddLDepartmentForSearch.DataTextField = "SubDept_Name";
        ddLDepartmentForSearch.DataValueField = "SubDept_Id";
        ddLDepartmentForSearch.DataBind();


    }


    private void GetEmployeeDetail()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspGetEmployeeGenericTemplate", con);
            cmd.Parameters.AddWithValue("@empid", ddlEmployee.SelectedValue);
            cmd.Parameters.AddWithValue("@ID", 0);
            
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dt = new DataSet();
            da.Fill(dt);
            gvd.DataSource = dt.Tables[1];
            gvd.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
        private void GetEmployeeDetailWithTemplates()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand("uspGetEmployeeLetterTemplatesRecord", con);
 
            cmd.Parameters.AddWithValue("@TemplateID",ddlTemplateNameForSearch.SelectedValue);
                cmd.Parameters.AddWithValue("@EMPid",ddlEmployeeForSearch.SelectedValue);
                cmd.Parameters.AddWithValue("@dEPTid", ddLDepartmentForSearch.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet dt = new DataSet();
            da.Fill(dt);
            gvdEmployeeDetail.DataSource = dt.Tables[0];
            gvdEmployeeDetail.DataBind();
        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

        private void GetAllEmployee()
        {
            DbManager objManager = new DbManager();
            SqlParameter[] sqlParams = new[] {
            new SqlParameter("@SubDeptId", ddlSubdept.SelectedValue)
            };
            ddlEmployee.DataSource = objManager.ExecuteDataTable("GetemployeeBySubDept", "Basic_Data_ConnectionString", sqlParams);
            ddlEmployee.DataTextField = "Name";
            ddlEmployee.DataValueField = "EmpID";
            ddlEmployee.DataBind();
            ddlEmployee.Items.Insert(0, new ListItem("All", "0"));
        }
    

   

    private void GetTemplates()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand(@"select ID,TemplateName from HR_GenericLetterTemplates GT
inner join HR_TemplatesType TT on GT.TemplateTypeID = TT.TemplateTypeID
where tt.Hospital_ID = @HospitalId", con);
            cmd.Parameters.AddWithValue("@HospitalId", Session["HospitalID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlTemplateName.DataSource = dt;
            ddlTemplateName.DataTextField = "TemplateName";
            ddlTemplateName.DataValueField = "ID";
            ddlTemplateName.DataBind();


            ddlTemplateNameForSearch.DataSource = dt;
            ddlTemplateNameForSearch.DataTextField = "TemplateName";
            ddlTemplateNameForSearch.DataValueField = "ID";
            ddlTemplateNameForSearch.DataBind();

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    protected void ddlSubdept_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetAllEmployee();
        GetEmployeeDetail();
        loadReferenceNo();
    }
    protected void ddlTemplateName_PreRender(object sender, EventArgs e)
    {
        LoadTemplateData();
        loadReferenceNo();
    }
    protected void ddlTemplateName_SelectedIndexChanged(object sender, EventArgs e)
    {
        LoadTemplateData();
        loadReferenceNo();
    }


    private void LoadTemplateData()
    {
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            con.Open();
            cmd = new SqlCommand(@" SELECT [ID],[TemplateName],[Heading],[Body], a.[TemplateTypeID],b.TemplateType
                                              FROM [dbo].[HR_GenericLetterTemplates] a inner join HR_TemplatesType b
                                              on a.TemplateTypeID=b.TemplateTypeID where ID=" + ddlTemplateName.SelectedValue + "", con);
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    textboxTemplateType.Text = reader["TemplateType"].ToString();
                    txtboxHeadingName.Text = reader["Heading"].ToString();
                    textboxBody.Text = reader["Body"].ToString();
                }
            }
            else
            {
                textboxTemplateType.Text = string.Empty;
                txtboxHeadingName.Text = string.Empty;
                textboxBody.Text = string.Empty;
            }

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }


    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        panel.Visible = true;
        loadReferenceNo();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(_conStr);
        try
        {
            string str = textboxBody.Text;
            string str1 = Server.HtmlEncode(str);
           

            con.Open();
            cmd = new SqlCommand("uspAssignTemplatesToEmployee", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Empid", ddlEmployee.SelectedValue);
            cmd.Parameters.AddWithValue("@GenericTemplateID", ddlTemplateName.SelectedValue);
            cmd.Parameters.AddWithValue("@CreatedBy", Session["emp_id"]);
            cmd.Parameters.AddWithValue("@Body", str.Trim());
            cmd.Parameters.AddWithValue("@heading", txtboxHeadingName.Text.Trim());
            cmd.Parameters.AddWithValue("@templateName", ddlTemplateName.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@templateType", textboxTemplateType.Text);
            cmd.Parameters.AddWithValue("@ReferenceNo", txtReference.Text + txtCounterYear.Text);
            cmd.ExecuteNonQuery();
        }
        catch (Exception ex) { }
        finally { }
    }
    protected void ddlEmployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEmployeeDetail();
    }
    protected void ddLDepartmentForSearch_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEmployeeDetailForSearch();
    }

    private void GetEmployeeDetailForSearch()
    {
        DbManager objManager = new DbManager();
        SqlParameter[] sqlParams = new[] {
            new SqlParameter("@SubDeptId", ddLDepartmentForSearch.SelectedValue)
            };
        ddlEmployeeForSearch.DataSource = objManager.ExecuteDataTable("GetemployeeBySubDept", "Basic_Data_ConnectionString", sqlParams);
        ddlEmployeeForSearch.DataTextField = "Name";
        ddlEmployeeForSearch.DataValueField = "EmpID";
        ddlEmployeeForSearch.DataBind();        

    }



    protected void btnSearch_Click(object sender, EventArgs e)
    {
        panel.Visible = false;
        GetEmployeeDetailWithTemplates();
    }

    private void loadReferenceNo()
    {
        DataTable dt = new DataTable();
        using (SqlConnection conn = new SqlConnection(_conStr))
        {
            using (SqlCommand cmd = new SqlCommand("Usp_GetLetterReferenceNo", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@TemplateType", ddlTemplateName.SelectedValue);
                cmd.Parameters.AddWithValue("@SubDeptId", ddlSubdept.SelectedValue);
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }
        if (dt.Rows.Count > 0)
        {
            txtReference.Text = dt.Rows[0]["ReferenceText"].ToString();
            txtCounterYear.Text = dt.Rows[0]["CounterYear"].ToString();
        }
        else
        {
            txtReference.Text = "";
            txtCounterYear.Text = "";
        }
    }
}