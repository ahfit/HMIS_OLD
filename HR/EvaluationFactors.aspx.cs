using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_EvaluationFactors : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString);

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            loadgride();
            loadRecruitment();
        }

    }

   

    private void loadgride()
    {
       
        con.Open();
        SqlCommand cmd = new SqlCommand("SELECT  FactorId, Name,case when types=1 then 'Probation'when types=4 then 'Appraisal' end as types FROM   EvaluationFactors where isnull(Active,0)=1", con);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        gridFactor.DataSource = ds;
        gridFactor.DataBind();
        con.Close();
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("insert into EvaluationFactors (types,Name, Active) values (@types,@Name,@active)", con);
        cmd.Parameters.AddWithValue("@types", rbType.SelectedValue);
        cmd.Parameters.AddWithValue("@Name",TextBoxName.Text);
        cmd.Parameters.AddWithValue("@active", true);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();
    }
    protected void btn_Edit(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();
     
        SqlCommand cmd = new SqlCommand("update EvaluationFactors set Active='false' where FactorId = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();

    }
    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();

        SqlCommand cmd = new SqlCommand("update EvaluationFactors set Active='false' where FactorId = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgride();

    }
    
    protected void ddlHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
        //loadRecruitment();
        //loadRecruitment();
    }
    protected void loadRecruitment()
    {

        //con.Open();

        //SqlCommand cmd = new SqlCommand("select '0' FactorId,'' as Name union select FactorId, Name from EvaluationFactors where isnull(active,0)=1", con);

        //SqlDataAdapter da = new SqlDataAdapter(cmd);
        //DataTable ds = new DataTable();
        //da.Fill(ds);
        //ddlHeading.DataSource = ds;
        //ddlHeading.DataValueField = "FactorId";
        //ddlHeading.DataTextField = "Name";
        //ddlHeading.DataBind();
        //con.Close();
    }

    protected void rbType_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadRecruitment();
    }
}