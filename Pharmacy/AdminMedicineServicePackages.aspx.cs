using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
using Microsoft.Reporting.WebForms;

public partial class Pharmacy_AdminMedicineServicePackages : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlPackages.SelectedValue != "0")
            {
                for (int i = 0; i < grdServices.Rows.Count; i++)
                {
                    CheckBox chkSelect = (CheckBox)grdServices.Rows[i].FindControl("chkSelect");
                    HiddenField hfS_ID = (HiddenField)grdServices.Rows[i].FindControl("hfS_ID");
                    TextBox txtRate = (TextBox)grdServices.Rows[i].FindControl("txtRate");
                    Label txtAmount = (Label)grdServices.Rows[i].FindControl("txtAmount");
                    TextBox txtQty = (TextBox)grdServices.Rows[i].FindControl("txtQty");
                    if (chkSelect.Checked)
                    {
                        if (txtQty.Text != "")
                        {

                            hfS_IDPage.Value = hfS_ID.Value;
                            hfRate.Value = txtAmount.Text;
                            hfQty.Value = txtQty.Text;
                            dsPackages.Insert();
                            lblMessage.Text = "";
                        }
                        else
                        {
                            lblMessage.Text = "Please Enter Quantity";
                        }

                    }


                }
                grdPckages.DataBind();
                //grdServices.DataBind();
                txtItemName.Text = "";
                clearChecks();
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }
    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchItems(string prefixText, int count)
    {
        List<string> items = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "Select Item_Code,Item_Name Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%' Or Item_Code like '%' + @Search + '%'";
        cmd.CommandType = CommandType.Text;
        cmd.Parameters.AddWithValue("@Search", prefixText);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["Item_Name"].ToString(), sdr["Item_Code"].ToString()));
        }
        return items;
    }
    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox chkSelectAll = (CheckBox)grdServices.HeaderRow.FindControl("chkSelectAll");
            for (int i = 0; i <= grdServices.Rows.Count - 1; i++)
            {

                CheckBox chkSelect = (CheckBox)grdServices.Rows[i].FindControl("chkSelect");
                chkSelect.Checked = chkSelectAll.Checked;
            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
        }
    }

    Decimal sum = 0;
    protected void grdPckages_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label rate = e.Row.FindControl("lblRate") as Label;
            if (rate.Text != "")
            {


                TextBox qty = e.Row.FindControl("lblQty") as TextBox;
                Decimal TotalAmount = (Convert.ToDecimal(rate.Text)) * (Convert.ToDecimal(qty.Text));
                Label lbltotal = e.Row.FindControl("lbltotal") as Label;

                lbltotal.Text = TotalAmount.ToString();
                sum += Convert.ToDecimal(lbltotal.Text);
            }





        }



        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label total = e.Row.FindControl("lblSum") as Label;
            total.Text = sum.ToString();
        }



    }
    protected void grdPckages_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        int rowindex = e.RowIndex;
        GridViewRow row = grdPckages.Rows[e.RowIndex] as GridViewRow;
        Label txt = row.FindControl("lblRate") as Label;
        TextBox txtservicename = row.FindControl("txtbox") as TextBox;

        dsPackages.UpdateParameters["Rate"].DefaultValue = txt.Text;
        dsPackages.UpdateParameters["S_Name"].DefaultValue = txtservicename.Text;
    }
    protected void AddMedicinePackage()
    {
        if (TextBox_MedicinePackage.Text.Trim().Length > 0)
        {
            String _str = ConfigurationManager.ConnectionStrings["Pharmacy_ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(_str);

            try
            {
                con.Open();
                Lbl_mg.Text = string.Empty;
                SqlCommand cmd = new SqlCommand("INSERT INTO AdminMedicineServicesPackage (MP_Name  ,Total_Amount ) VALUES (@MP_Name  ,@Total_Amount) ", con);
                cmd.CommandType = CommandType.Text;

                cmd.Parameters.AddWithValue("@MP_Name", TextBox_MedicinePackage.Text.Trim());
                cmd.Parameters.AddWithValue("@Total_Amount", TextBox_MedicinePackageAmount.Text.Trim());

                cmd.ExecuteNonQuery();
                Lbl_mg.Text = "Add Sucessfully";
                TextBox_MedicinePackage.Text = string.Empty;
                TextBox_MedicinePackageAmount.Text = string.Empty;
                con.Close();


            }
            catch (Exception ex)
            {


            }
            finally
            {
                con.Close();
            }
        }
        else {
            Lbl_mg.ForeColor = System.Drawing.Color.Red;
           Lbl_mg.Text= "Package Name cannot be null";
        
        }


    }
    protected void btn_add_Click(object sender, EventArgs e)
    {
        AddMedicinePackage();
        ddlPackages.DataBind();
    }
    protected void Button1_Search_Click(object sender, EventArgs e)
    {
        SelectMedicineForGrid();
    }
    protected void SelectMedicineForGrid()
    {
        String _str = ConfigurationManager.ConnectionStrings["Pharmacy_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(_str);

        try
        {
            con.Open();
            Lbl_mg.Text = string.Empty;
            SqlCommand cmd = new SqlCommand("select_PackageCategoryItems", con);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@Item_Name", txtItemName.Text);
            cmd.Parameters.AddWithValue("@Itemtypeid", ddlAdminServiceCategory.SelectedValue);

            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            sda.Fill(dt);
            grdServices.DataSource = dt;
            grdServices.DataBind();


        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }



    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        DeleteMedicinePackage();
        ddlPackages.DataBind();

    }
    protected void DeleteMedicinePackage()
    {
        String _str = ConfigurationManager.ConnectionStrings["Pharmacy_ConnectionString"].ConnectionString;
        SqlConnection con = new SqlConnection(_str);

        try
        {
            con.Open();
            Lbl_mg.Text = string.Empty;
            SqlCommand cmd = new SqlCommand("Delete from AdminMedicineServicesPackageSub where AMSP_ID=@id;Delete from AdminMedicineServicesPackage  where AMP_ID=@id and AMP_ID<>23", con);
            cmd.CommandType = CommandType.Text;

            cmd.Parameters.AddWithValue("@id", ddlPackages.SelectedValue);

            cmd.ExecuteNonQuery();
            Lbl_mg.Text = "Add Sucessfully";
            TextBox_MedicinePackage.Text = string.Empty;
            TextBox_MedicinePackageAmount.Text = string.Empty;
            con.Close();


        }
        catch (Exception ex)
        {


        }
        finally
        {
            con.Close();
        }



    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in grdPckages.Rows)
        {

            String _str = ConfigurationManager.ConnectionStrings["Pharmacy_ConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(_str);

            try
            {
                HiddenField hfdid = (HiddenField)row.FindControl("hfdid");
                TextBox pri = (TextBox)row.FindControl("lblpriority");
                TextBox Qty = (TextBox)row.FindControl("lblQty");

                con.Open();
                Lbl_mg.Text = string.Empty;
                SqlCommand cmd = new SqlCommand("update AdminMedicineServicesPackageSub set Priority=@pri,Qty=@qty where ID=@id", con);
                cmd.CommandType = CommandType.Text;

                cmd.Parameters.AddWithValue("@id", hfdid.Value);
                cmd.Parameters.AddWithValue("@pri", pri.Text);
                cmd.Parameters.AddWithValue("@qty", Qty.Text);

                cmd.ExecuteNonQuery();
                Lbl_mg.Text = "updated Sucessfully";
                TextBox_MedicinePackage.Text = string.Empty;
                TextBox_MedicinePackageAmount.Text = string.Empty;
                con.Close();
                grdPckages.DataBind();



            }
            catch (Exception ex)
            {


            }
        }
    }

    private void clearChecks()
    {
        foreach (GridViewRow dgr in grdServices.Rows)
        {
            CheckBox chk = (CheckBox)dgr.FindControl("chkSelect");
            chk.Checked = false;

        }
    }
}
