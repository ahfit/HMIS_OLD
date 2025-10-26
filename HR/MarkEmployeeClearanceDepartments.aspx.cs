using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class HR_MarkEmployeeClearanceDepartments : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadDepartment();
        }

    }
    private void loadDepartment()
    {
DataTable dt = new DataTable();
        SqlCommand cmd;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString());
        try
        {

            con.Open();
            cmd = new SqlCommand(@"select SD.SubDept_Id,SD.SubDept_Name,
Convert(bit,isnull(CD.IsClearance,0)) AS IsClearance,
Convert(bit,isnull(CD.IsFinal,0)) AS IsFinal, isnull(CD.Id,0) AS ClearanceId,isnull(CD.DesignationId,0) AS DesignationId
from SubDepartment SD
inner join Department D on SD.Dept_Id = D.Dept_ID
Left outer join ClearanceDepartment CD on SD.SubDept_Id = CD.SubDeptId

where D.Hospital_ID = @HospitalId order by SD.SubDept_Name", con);
            cmd.Parameters.AddWithValue("@HospitalId", Session["HospitalID"]);
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            
            da.Fill(dt);
            gvdDepartments.DataSource = dt;
            gvdDepartments.DataBind();

        }
        catch (Exception ex)
        {

            con.Close();
        }
    }



    protected void btnSave_Click(object sender, EventArgs e)
    {
        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ToString()))
        {
            foreach (GridViewRow dgr in gvdDepartments.Rows)
            {
                CheckBox CheckClearance = (CheckBox)dgr.FindControl("ChkClearance");
                DropDownList ddlDesignation = (DropDownList)dgr.FindControl("ddlDesignation");
                //if (CheckClearance.Checked == true && ddlDesignation.SelectedValue != "0")
                //{

                    HiddenField hfSubDeptId = (HiddenField)dgr.FindControl("hfSubDeptId");
                    
                    CheckBox CheckFinal = (CheckBox)dgr.FindControl("ChkFinalClearance");
                    HiddenField HfClearanceId = (HiddenField)dgr.FindControl("HfClearanceId");
                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = @"Usp_InsertClearanceDepartment";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@SubDeptId", hfSubDeptId.Value);
                        cmd.Parameters.AddWithValue("@DesignationId", ddlDesignation.SelectedValue);
                        cmd.Parameters.AddWithValue("@IsClearance", CheckClearance.Checked);
                        cmd.Parameters.AddWithValue("@IsFinal", CheckFinal.Checked);
                        cmd.Parameters.AddWithValue("@ClearanceId", HfClearanceId.Value);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();

                    }
                //}
            }
        }
        loadDepartment();
    }

    protected void gvdDepartments_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            SqlDataSource ds = (SqlDataSource)e.Row.FindControl("SqlDataSourceDesignation");
            HiddenField SubDeptId = (HiddenField)e.Row.FindControl("hfSubDeptId");
            HiddenField HfDesg = (HiddenField)e.Row.FindControl("HfDesignationId");
            ds.SelectParameters[0].DefaultValue = SubDeptId.Value;
            DropDownList ddlDesignation = (DropDownList)e.Row.FindControl("ddlDesignation");
            ddlDesignation.DataBind();
            ddlDesignation.SelectedValue = HfDesg.Value;
        }
    }
}