using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PayRoll_TaxSlab : System.Web.UI.Page
{
    string conString = ConfigurationManager.ConnectionStrings["PayRollConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            Bind_FYear();
            getAllTaxSlab();
        }
    }

    private void Bind_FYear()
    {
        DbManager manager = new DbManager();

        SqlParameter[] sqlParams = { 
                                      new SqlParameter("@CurrentFinancialYear", "0") 
                                   };


        DataTable dt = manager.ExecuteDataTable("GetFinancialYear", "PayRoll_ConnectionString", sqlParams);
       
        DDL_fYear.DataSource = dt;
        DDL_fYear.DataBind();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (btnSave.Text == "Save")
        {
            insert_NewSlab();
            getAllTaxSlab();
        }
        else if (btnSave.Text == "Update")
        {
            UpdateTaxLab();
            getAllTaxSlab();
        }
    }
    private void insert_NewSlab()
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("usp_InsertTaxSlab", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Financial_Year", DDL_fYear.SelectedValue);
            cmd.Parameters.AddWithValue("@Slab_From", txtSlabFrom.Text.Trim());
            cmd.Parameters.AddWithValue("@Slab_To", txtSlabTo.Text);
            cmd.Parameters.AddWithValue("@Tax", txtTax.Text.Trim());
            cmd.Parameters.AddWithValue("@Fixed_Amount", txtFixedAmount.Text.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text.Trim());
            //cmd.Parameters.AddWithValue("@IsExceeding", chkExceeding.Checked);
            cmd.ExecuteNonQuery();
            clearFields();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
        finally
        {
            con.Close();
        }
    }

    private void clearFields()
    {
        txtDescription.Text = "";
        txtFixedAmount.Text = "";
        txtSlabFrom.Text = "";
        txtSlabTo.Text = "";
        txtTax.Text = "";
    }

    private void getAllTaxSlab()
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("SELECT  TaxSlab_Id, Financial_Year, Slab_From, Slab_To, Tax, Fixed_Amount, Description,Convert(bit,isnull(IsExceedingPercentage,0)) AS IsExceedingPercentage FROM   TaxSlab where Financial_Year=@Year", con);
            cmd.Parameters.AddWithValue("@Year", DDL_fYear.SelectedValue);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            GridView_Tax.DataSource = dt;
            GridView_Tax.DataBind();

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }

    protected void lbtnDelete_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("delete from taxslab where TaxSlab_Id=@Id", con);
            cmd.Parameters.AddWithValue("@Id", lbtn.CommandArgument);
            cmd.ExecuteNonQuery();
            getAllTaxSlab();

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }
    protected void lbtnupdate_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        GridViewRow row = (GridViewRow)lbtn.NamingContainer;
        Label lblSlab_From = (Label)row.FindControl("lblSlab_From");
        Label lblslab_To = (Label)row.FindControl("lblslab_To");
        Label lblTax = (Label)row.FindControl("lblTax");
        Label lblFixedAmount = (Label)row.FindControl("lblFixedAmount");
        Label lblDescription = (Label)row.FindControl("lblDescription");
        Label lblF_Year = (Label)row.FindControl("lblF_Year");
        CheckBox chckPer = (CheckBox)row.FindControl("chkExceedingCheck");
        txtSlabFrom.Text = lblSlab_From.Text;
        txtSlabTo.Text = lblslab_To.Text;
        txtTax.Text = lblTax.Text;
        txtFixedAmount.Text = lblFixedAmount.Text;
        txtDescription.Text = lblDescription.Text;
        DDL_fYear.SelectedValue = lblF_Year.Text;
        //chkExceeding.Checked = chckPer.Checked;
        btnSave.Text = "Update";
        btnSave.CommandArgument = lbtn.CommandArgument;
    }
    protected void DDL_fYear_SelectedIndexChanged(object sender, EventArgs e)
    {
        getAllTaxSlab();
    }


    private void UpdateTaxLab()
    {
        SqlConnection con = new SqlConnection(conString);
        SqlCommand cmd;
        try
        {
            con.Open();
            cmd = new SqlCommand("UPDATE TaxSlab SET  Financial_Year =@Financial_Year, Slab_From =@Slab_From, Slab_To =@Slab_To, Tax =@Tax, Fixed_Amount =@Fixed_Amount, Description =@Description,IsExceedingPercentage = @IsExceedingPercentage WHERE        (TaxSlab_Id = @TaxSlab_Id)", con);
            cmd.Parameters.AddWithValue("@Financial_Year", DDL_fYear.SelectedValue);
            cmd.Parameters.AddWithValue("@Slab_From", txtSlabFrom.Text);
            cmd.Parameters.AddWithValue("@Slab_To", txtSlabTo.Text);
            cmd.Parameters.AddWithValue("@Tax", txtTax.Text);
            cmd.Parameters.AddWithValue("@Fixed_Amount", txtFixedAmount.Text);
            cmd.Parameters.AddWithValue("@Description", txtDescription.Text);
            cmd.Parameters.AddWithValue("@TaxSlab_Id", btnSave.CommandArgument); 
            cmd.Parameters.AddWithValue("@IsExceedingPercentage",0);
            cmd.ExecuteNonQuery();
            clearFields();
            btnSave.Text = "Save";
            btnSave.CommandArgument = "";

        }
        catch (Exception ex)
        {
        }
        finally
        {
            con.Close();
        }
    }


    private int Function(String Salary) {

        int totlaSalary =   Convert.ToInt32( Salary) * 12;

        int X = Convert.ToInt32(Salary) - (Convert.ToInt32(txtSlabFrom.Text)-1);

        int y = X * (Convert.ToInt32(txtTax.Text) / 100);

        int TotalTax = Convert.ToInt32(txtFixedAmount.Text) + y;


        int MonthlyTax = TotalTax / 12;

        return MonthlyTax;

    }


}