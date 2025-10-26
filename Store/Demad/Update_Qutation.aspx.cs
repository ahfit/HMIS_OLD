using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;


public partial class Store_Update_Qutation : System.Web.UI.Page
{
    static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.QueryString["RQ_ID"] != null && Request.QueryString["Main_ID"] == null)
            {
                DDL_Other_Currency.SelectedValue = "PKR";
                GetRate("PKR");
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtWEDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtDeliveryDays.Text = DateTime.Now.ToString("yyyy-MM-dd");
                SDS_GV.SelectParameters["Demand_RQ_ID"].DefaultValue = Request.QueryString["RQ_ID"];
                GridView1.DataBind();
                hfID.Value = Request.QueryString["RQ_ID"];
                getTermsAndConditions();
            }
            if (Request.QueryString["RQ_ID"] != null && Request.QueryString["Main_ID"] != null)
            {
                DDL_Other_Currency.SelectedValue = "PKR";
                GetRate("PKR");
                LoadValues();

            }
        }
    }
    protected void txtUnitPrice_TextChanged(object sender, EventArgs e)
    {

        double unitPrice, qtyDemanded, discount, total, final;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        TextBox txtTotal = gvRow.FindControl("txtTotal") as TextBox;
        TextBox txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        TextBox txtFinal = gvRow.FindControl("txtFinal") as TextBox;
        Label qtyD = gvRow.FindControl("lblQty") as Label;


        if (qtyD.Text.Trim() != "" && tbox.Text.Trim() != "")
        {
            qtyDemanded = Convert.ToDouble(qtyD.Text);
            unitPrice = Convert.ToDouble(tbox.Text);
            discount = Convert.ToDouble(txtDiscount.Text);
            total = qtyDemanded * unitPrice;
            txtTotal.Text = total.ToString("#,#.##");
            final = total - discount;
            txtFinal.Text = final.ToString("#,#.##");

            txtDiscount.Focus();
        }
        else
        {
            tbox.Text = "0";
        }
    }

    protected void txtDiscount_TextChanged(object sender, EventArgs e)
    {

        double discount, total, final;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        TextBox txtTotal = gvRow.FindControl("txtTotal") as TextBox;
        TextBox txtDiscount = gvRow.FindControl("txtDiscount") as TextBox;
        TextBox txtFinal = gvRow.FindControl("txtFinal") as TextBox;

        if (txtTotal.Text.Trim() != "" && txtDiscount.Text.Trim() != "" && tbox.Text.Trim() != "")
        {
            total = Convert.ToDouble(txtTotal.Text);
            discount = Convert.ToDouble(txtDiscount.Text);
            final = total - discount;
            txtFinal.Text = final.ToString("#,#.##");
        }
        else
        {
            tbox.Text = "0";
        }

    }

    protected void txtAccDiscount_TextChanged(object sender, EventArgs e)
    {
        double finalPrice = 0;
        double total = 0;
        double accDiscount = 0;
        Label gtotal;
        if (btnSave.Text == "Save")
        {

          

            if (accDiscount < total && txtAccDiscount.Text.Trim() != "")
            {
                
                accDiscount = Convert.ToDouble(txtAccDiscount.Text);
                finalPrice = total - accDiscount;
                txtFinalPrice.Text = finalPrice.ToString("#,#.##");
                txtPayment.Focus();
            }
            else
            {
                txtAccDiscount.Text = "0";
                txtPayment.Focus();
            }
        }
        if (btnSave.Text == "Approve")
        {
            

            if (accDiscount < total && txtAccDiscount.Text.Trim() != "")
            {
                accDiscount = Convert.ToDouble(txtAccDiscount.Text);
                finalPrice = total - accDiscount;
                txtFinalPrice.Text = finalPrice.ToString("#,#.##");
                txtPayment.Focus();
            }
            else
            {
                txtAccDiscount.Text = "0";
                txtPayment.Focus();
            }
        }
    }
    protected void insertProduct()
    {
        string filePath = fuQuotationUpload.PostedFile.FileName;
        string filename = Path.GetFileName(filePath);
        string ext = Path.GetExtension(filename);
        string contenttype = String.Empty;
        contenttype = ext;
        //Set the contenttype based on File Extension
        if (contenttype != String.Empty)
        {

            Stream fs = fuQuotationUpload.PostedFile.InputStream;
            BinaryReader br = new BinaryReader(fs);
            Byte[] bytes = br.ReadBytes((Int32)fs.Length);

            //insert the file into database
            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["STOREConnectionString"].ConnectionString);
            string strQuery = "uspUpdateQutationAttachment";
            SqlCommand cmd = new SqlCommand(strQuery,con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            cmd.Parameters.AddWithValue("@Qutation_Main_ID",SqlDbType.Int).Value= hf_Qutation_Main_Id.Value;
            cmd.Parameters.AddWithValue("@QuotationFile", SqlDbType.Binary).Value= fuQuotationUpload.FileBytes;
            cmd.Parameters.AddWithValue("@QuotationFileType",SqlDbType.Variant).Value=contenttype;
            cmd.ExecuteNonQuery();
            con.Close();

        }
        else
        {
            lblMsg.Visible = true;
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Text = "some error occured while prcessing quotation upload";
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (btnSave.Text == "Update")
        {
            if (txtPerson.Text != "" && ddlVendor.SelectedItem != null && txtDate.Text != null)
            {
                
                 Sql_Qutation_Main.Update();
                //if(fuQuotationUpload.HasFile)
                //{
                //    insertProduct();
                //}
                
                lblMsg.Text = "Qutation Updated Successfully";
                lblMsg.Visible = true;
                lblMsg.ForeColor = Color.Green;

            }
            else
            {
                lblMsg.Text = "Enter Contact Person ";
                lblMsg.ForeColor = Color.Red;
                lblMsg.Visible = true;
            }
        }
       
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        if (btnCancel.Text == "Return")
        {
            Response.Redirect("~/Store/Demad/Demand_Requisition_Qutation.aspx");
        }
        if (btnCancel.Text == "Cancel")
        {
            Response.Redirect("~/Store/Demad/Approve_Qutations.aspx?RQ_ID=" + Request.QueryString["RQ_ID"]);
        }
    }

    protected void Sql_Qutation_Main_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        hf_Qutation_Main_Id.Value = e.Command.Parameters["@Qutation_Main_ID"].Value.ToString();
    }

    protected void btnQtyOffer_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            Label lblItemCode = GridView2.Rows[i].FindControl("lblItemCode") as Label;
            TextBox txtQtyOffer = GridView2.Rows[i].FindControl("txtQtyOffer") as TextBox;
            TextBox txtDiscount = GridView2.Rows[i].FindControl("txtDiscountApp") as TextBox;
            Label lblFinal = GridView2.Rows[i].FindControl("lblFinal") as Label;
            sds_UpdateOffer.UpdateParameters["Item_Code"].DefaultValue = lblItemCode.Text;
            sds_UpdateOffer.UpdateParameters["Qty_Offered"].DefaultValue = txtQtyOffer.Text;
            sds_UpdateOffer.UpdateParameters["Discount"].DefaultValue = txtDiscount.Text;
            sds_UpdateOffer.UpdateParameters["Total_Amount"].DefaultValue = lblFinal.Text;
            sds_UpdateOffer.Update();

        }
        lblMsg.Text = "Quantity Offered Updated Successfully";
        lblMsg.ForeColor = Color.Green;
        lblMsg.Visible = true;
    }
    protected void txtDiscountApp_TextChanged(object sender, EventArgs e)
    {
        double discount, total, final, accDiscount, finalPrice;
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        Label lblTotal = gvRow.FindControl("lblTotal") as Label;
        Label lblFinal = gvRow.FindControl("lblFinal") as Label;
        Label lblgt = GridView2.FooterRow.FindControl("lblGrandTotal") as Label;
        double gt = 0;

        if (lblTotal.Text.Trim() != "" && tbox.Text.Trim() != "")
        {
            total = Convert.ToDouble(lblTotal.Text);
            discount = Convert.ToDouble(tbox.Text);
            final = total - discount;
            lblFinal.Text = final.ToString("#,#.##");
        }
        else
        {
            tbox.Text = "0";
        }
        for (int i = 0; i < GridView2.Rows.Count; i++)
        {
            Label Final = GridView2.Rows[i].FindControl("lblFinal") as Label;

            gt += Convert.ToDouble(Final.Text);


        }
        accDiscount = Convert.ToDouble(txtAccDiscount.Text);
        finalPrice = gt - accDiscount;
        txtFinalPrice.Text = finalPrice.ToString("#,#.##");
        lblgt.Text = gt.ToString("#,#.##");
    }
    protected void txtQtyOffer_TextChanged(object sender, EventArgs e)
    {
        TextBox tbox = sender as TextBox;
        GridViewRow gvRow = tbox.NamingContainer as GridViewRow;
        Label lblQtyDem = gvRow.FindControl("lblQty") as Label;
        double QtyDem = Convert.ToDouble(lblQtyDem.Text.Trim());
        if (tbox.Text.Trim() == "" || tbox.Text.Trim() == "0" || Convert.ToDouble(tbox.Text.Trim()) > QtyDem)
        {
            lblQtyMsg.ForeColor = Color.Red;
            lblQtyMsg.Font.Bold = true;
            lblQtyMsg.Visible = true;
            tbox.Focus();
        }
        else
        {
            lblQtyMsg.Visible = false;
            Label lblUnitPrice = gvRow.FindControl("lblUnitPrice") as Label;
            Label lblTotal = gvRow.FindControl("lblTotal") as Label;
            TextBox txtDiscount = gvRow.FindControl("txtDiscountApp") as TextBox;
            Label lblFinal = gvRow.FindControl("lblFinal") as Label;
            Label lblgt = GridView2.FooterRow.FindControl("lblGrandTotal") as Label;
            double total, discount, final, qty, unitPrice, accDiscount, finalPrice, gt = 0;
            unitPrice = Convert.ToDouble(lblUnitPrice.Text.Trim());
            qty = Convert.ToDouble(tbox.Text.Trim());
            total = unitPrice * qty;
            lblTotal.Text = total.ToString();
            discount = Convert.ToDouble(txtDiscount.Text.Trim());
            final = total - discount;
            lblFinal.Text = final.ToString("#,#.##");
            accDiscount = Convert.ToDouble(txtAccDiscount.Text.Trim());
            finalPrice = final - accDiscount;
            txtFinalPrice.Text = finalPrice.ToString("#,#.##");
            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                gt += Convert.ToDouble(lblFinal.Text);
            }
            lblgt.Text = gt.ToString("#,#.##");
        }
    }
    protected void GridView1_PreRender(object sender, EventArgs e)
    {
        double total = 0;
        double accDiscount = 0;
        double finalPrice = 0;
        if (GridView1.Rows.Count > 0)
        {
            CheckBox parent = (CheckBox)GridView1.HeaderRow.FindControl("chkHead");
            CheckBox child = new CheckBox();
            TextBox totalAmonut = new TextBox();
            foreach (GridViewRow row in GridView1.Rows)
            {
                totalAmonut = row.FindControl("txtFinal") as TextBox;
                child = row.FindControl("chkInner") as CheckBox;

                total += Convert.ToDouble(totalAmonut.Text);
                if (parent.Checked)
                    child.Checked = true;
                else
                    child.Checked = false;
            }
            Label gtotal = GridView1.FooterRow.FindControl("lblGrandTotal") as Label;
            gtotal.Text = total.ToString("#,#.##");
            accDiscount = Convert.ToDouble(txtAccDiscount.Text);
            finalPrice = total - accDiscount;
            txtFinalPrice.Text = finalPrice.ToString("#,#.##");

        }
    }
    protected void LoadValues()
    {
        GridView2.Visible = true;
        btnCancel.Text = "Cancel";
        btnSave.Text = "Update";
        String connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
        SqlConnection con = new SqlConnection(connection1);
        con.Open();
        String command = "SELECT  Vendor_ID, Qutation_Date, Contact_Person, Contact_No, Accumulated_Discount, Final_Price, Delivery_Days, Tax, Payment,Terms_Conditions,Delivery_Date,WithEffectDate,Convert(int,isnull(Is_approved,0)) Is_approved,Contact_No,QutationType,Distributor,Warranty,InstallationInPak,ISNULL(StockAvailability,0) StockAvailability,ManufacturerOrigin,ISNULL(OtherCurrency,'') OtherCurrency,CurrencyRate FROM Qutation_Main WHERE Qutation_Main_ID=@Qutation_Main_ID AND Demand_RQ_ID=@Demand_RQ_ID";
        SqlCommand cmd = new SqlCommand(command, con);
        cmd.Parameters.AddWithValue("@Qutation_Main_ID", Request.QueryString["Main_ID"]);
        cmd.Parameters.AddWithValue("@Demand_RQ_ID", Request.QueryString["RQ_ID"]);
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            if (dr["Vendor_ID"].ToString() != null)
            {
                ddlVendor.DataBind();
                ddlVendor.SelectedValue = dr["Vendor_ID"].ToString();
            }
            else
            {

            }
            DateTime qutationDate = Convert.ToDateTime(dr["Qutation_Date"].ToString());
            DateTime wed = Convert.ToDateTime(dr["WithEffectDate"].ToString());
            DateTime ddate = Convert.ToDateTime(dr["Delivery_Date"].ToString());
            txtDate.Text = qutationDate.ToString("yyyy-MM-dd");
            txtWEDate.Text = wed.ToString("yyyy-MM-dd");
            txtDeliveryDays.Text = wed.ToString("yyyy-MM-dd");
            txtPerson.Text = dr["Contact_Person"].ToString();
            txtContactNo.Text = dr["Contact_No"].ToString();
            txtAccDiscount.Text = dr["Accumulated_Discount"].ToString();
            txtFinalPrice.Text = dr["Final_Price"].ToString();
            txtDDays.Text = dr["Delivery_Days"].ToString();
            txtTax.Text = dr["Tax"].ToString();
            txtPayment.Text = dr["Payment"].ToString();
            txtTerms.Text = dr["Terms_Conditions"].ToString();
            //ddlDistributor.SelectedValue = dr["Distributor"].ToString();
            DDL_Other_Currency.SelectedValue = dr["OtherCurrency"].ToString();
            txtCurrencyRate.Text = dr["CurrencyRate"].ToString();
            txtWarranty.Text = dr["Warranty"].ToString();
            txtOrigin.Text = dr["ManufacturerOrigin"].ToString();
            txtInstallInPak.Text = dr["InstallationInPak"].ToString();
            ddlStockAvailability.SelectedValue=dr["StockAvailability"].ToString();
            try
            {
                DropDownList_potype.SelectedValue = dr["QutationType"].ToString();
                if (DropDownList_potype.SelectedValue == "Import")
                {
                    DDL_Other_Currency.Enabled = true;
                    txtCurrencyRate.Enabled = true;
                    txtWarranty.Enabled = true;
                    txtOrigin.Enabled = true;
                    txtInstallInPak.Enabled = true;
                    ddlStockAvailability.Enabled = true;
                }

            }
            catch(Exception ex)
            {
            }
            if (Convert.ToInt32(dr["Is_Approved"].ToString()) == 1)
            {
                btnSave.Visible = false;
               

            }
            else
            {

            }
        }
        dr.Close();
        con.Close();
       
    }
    protected void getTermsAndConditions()
    {
        try
        {
            txtTerms.Text = "";
            String query = "Select Terms_Conditions From TermsAndConditions Where Terms_Conditions like @Terms_Conditions";
            DbManager dbm = new DbManager();
            SqlParameter[] sp = { new SqlParameter("@Terms_Conditions", "%") };
            DataTable dt = new DataTable();
            dt = dbm.ExecuteDataTableWithQuery(query, "STOREConnectionString", sp);
            foreach (DataRow dr in dt.Rows)
            {
                txtTerms.Text = txtTerms.Text + "• " + dr[0].ToString().Trim() + "\n";
            }
        }
        catch (Exception ex)
        {

        }
    }


    protected void txtDDays_TextChanged(object sender, EventArgs e)
    {
        txtDeliveryDays.Text = DateTime.Now.AddDays(Convert.ToInt32(txtDDays.Text)).ToString("yyyy-MM-dd");
    }

    protected void DDL_Other_Currency_SelectedIndexChanged(object sender, EventArgs e)
    {
        String Currency = DDL_Other_Currency.SelectedValue.ToString();
        GetRate(Currency);
    }
    protected void GetRate(String Currency)
    {
        SqlConnection con = new SqlConnection(connection1);
        string SP = "SELECT Current_rate FROM Currency WHERE (Currency_Abbrivation = @Currency)";

        SqlCommand command = new SqlCommand(SP, con);
        command.CommandType = CommandType.Text;

        command.Parameters.AddWithValue("@Currency", Currency);

        con.Open();
        txtCurrencyRate.Text = command.ExecuteScalar().ToString();
        con.Close();
        con.Dispose();



    }
    protected void txtCurrencyRate_TextChanged(object sender, EventArgs e)
    {
        SDS_Update_Currency.Update();
    }

    protected void DropDownList_potype_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DropDownList_potype.SelectedValue == "Import")
        {
            DDL_Other_Currency.Enabled = true;
            txtCurrencyRate.Enabled = true;
            txtWarranty.Enabled = true;
            txtOrigin.Enabled = true;
            txtInstallInPak.Enabled = true;
            ddlStockAvailability.Enabled = true;
        }
        else
        {
            DDL_Other_Currency.Enabled = false;
            txtCurrencyRate.Enabled = false;
            txtWarranty.Enabled = false;
            txtOrigin.Enabled = false;
            txtInstallInPak.Enabled = false;
            ddlStockAvailability.Enabled = false;
        }
    }

    protected void chkHead_CheckedChanged(object sender, EventArgs e)
    {
     
    }
}