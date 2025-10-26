using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class HR_EvaluationFactorsDetail : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["HRConnectionString"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadskills();
            loadgridskill();
        }

    }


    protected void loadgridskill()
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("select rh.Name,rh.FactorId,case when rh.types=1 then 'Probation'when rh.types=4  then 'Appraisal' end as types,rd.Detail, rd.FactorDetailId,rd.marks from EvaluationFactors rh inner join EvaluationFactorDetails rd on rh.FactorId = rd.FactorId where isnull(rd.Active, 0) = 1 and rh.FactorId= @FactorId", con);

        cmd.Parameters.AddWithValue("@FactorId", ddlHeading.SelectedValue);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable ds = new DataTable();
        da.Fill(ds);
        gridsDetails.DataSource = ds;
        gridsDetails.DataBind();
        con.Close();
    }

    protected void loadskills()
    {
        con.Open();
        SqlCommand cmd = new SqlCommand("select Name,FactorId from EvaluationFactors  where Active=1", con);

        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        ddlHeading.DataSource = dt;
        ddlHeading.DataTextField = "Name";
        ddlHeading.DataValueField = "FactorId";
        ddlHeading.DataBind();
        con.Close();
    }

    protected void btnsave2_Click1(object sender, EventArgs e)
    {

        con.Open();
        SqlCommand cmd = new SqlCommand("insert into EvaluationFactorDetails (Detail,FactorId,marks) values (@Detail,@FactorId,@marks)", con);
        cmd.Parameters.AddWithValue("@Detail", Txtdetail.Text);
        cmd.Parameters.AddWithValue("@FactorId", ddlHeading.SelectedValue);
        cmd.Parameters.AddWithValue("@marks", txtmarks.Text);

        cmd.ExecuteNonQuery();
        con.Close();
        loadgridskill();
    }

    protected void btn_Delete_Click(object sender, EventArgs e)
    {
        LinkButton btn1 = sender as LinkButton;
        GridViewRow row = (GridViewRow)btn1.NamingContainer;
        LinkButton btn = (LinkButton)row.FindControl("btn_Delete");
        con.Open();

        SqlCommand cmd = new SqlCommand("update EvaluationFactorDetails set Active='false' where FactorDetailId   = " + btn1.CommandArgument + "", con);
        cmd.ExecuteNonQuery();
        con.Close();
        loadgridskill();
    }

    protected void ddlHeading_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadgridskill();
    }
}