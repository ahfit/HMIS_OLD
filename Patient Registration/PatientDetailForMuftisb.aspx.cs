using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class Patient_Registration_PatientDetailForMuftisb : System.Web.UI.Page
{
    string connstring = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            
            if (Request.QueryString["RegNo"] != null)
            {
                HfRegNo.Value = Request.QueryString["RegNo"].ToString();
                
            }
            if (Request.QueryString["Status"] != null)
            {
                HfStatus.Value = Request.QueryString["Status"].ToString();
            }
            if (Request.QueryString["YearlyNo"] != null)
            {
                hfYearlyNo.Value = Request.QueryString["YearlyNo"].ToString();
            }
            else
            {
                hfYearlyNo.Value = "0";
            }
            ddlPatientType.DataBind();
            search();
        }
    }

    protected void search()
    {
        DataSet ds = new DataSet();
        using (SqlConnection conn = new SqlConnection(connstring))
        {
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;
                cmd.CommandText = "Usp_GetPatientForZakat";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@RegNo", HfRegNo.Value);
                cmd.Parameters.AddWithValue("@Status", HfStatus.Value);
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(ds);
                }
            }
            conn.Close();
        }

        if (ds.Tables[0].Rows.Count > 0)
        {

            lblMr.Text = ds.Tables[0].Rows[0][0].ToString();
            lblName.Text = ds.Tables[0].Rows[0][1].ToString();
            lblRelationName.Text = ds.Tables[0].Rows[0][3].ToString();
            lblDateofBirth.Text = ds.Tables[0].Rows[0][7].ToString();
            lblAddress.Text = ds.Tables[0].Rows[0][8].ToString();
            lblIDCard.Text = ds.Tables[0].Rows[0][6].ToString();
            lblReceiptNo.Text = ds.Tables[0].Rows[0][5].ToString();
            lblDate.Text = ds.Tables[0].Rows[0]["regdatettime"].ToString();
            ddlPatientType.SelectedValue= ds.Tables[0].Rows[0]["Patient_Type_Id"].ToString();
        }

        if (ds.Tables[1].Rows.Count > 0)
        {
            txtCast.Text = ds.Tables[1].Rows[0]["Cast"].ToString();
            txtOccupation.Text = ds.Tables[1].Rows[0]["Occupation"].ToString();
            txtParent.Text = ds.Tables[1].Rows[0]["Parents"].ToString();
            txtfa.Text = ds.Tables[1].Rows[0]["moth"].ToString();
            txtbro.Text = ds.Tables[1].Rows[0]["bro"].ToString();
            txtdau.Text = ds.Tables[1].Rows[0]["daug"].ToString();
            txtboxDegar.Text = ds.Tables[1].Rows[0]["comm"].ToString();
            txtBrotherSister.Text = ds.Tables[1].Rows[0]["BrotherSister"].ToString();
            txtSon.Text = ds.Tables[1].Rows[0]["Sons"].ToString();
            txtDaughter.Text = ds.Tables[1].Rows[0]["Daughters"].ToString();
            txtOther.Text = ds.Tables[1].Rows[0]["OtherDependents"].ToString();
            txtSavings.Text = ds.Tables[1].Rows[0]["Savings"].ToString();
            txtJewellery.Text = ds.Tables[1].Rows[0]["Jewellery"].ToString();
            txtGoats.Text = ds.Tables[1].Rows[0]["Goats"].ToString();
            txtDepositCommite.Text = ds.Tables[1].Rows[0]["DepositCommite"].ToString();
            txtMonthlyIncome.Text = ds.Tables[1].Rows[0]["MonthlyIncome"].ToString();
            txtReceiveDebt.Text = ds.Tables[1].Rows[0]["ReceivingDept"].ToString();
            txtCows.Text = ds.Tables[1].Rows[0]["Cows"].ToString();
            ddlLandType.SelectedValue = ds.Tables[1].Rows[0]["LandType"].ToString();
            txtShopHouse.Text = ds.Tables[1].Rows[0]["HouseShop"].ToString();
            txtVehicle.Text = ds.Tables[1].Rows[0]["Vehicle"].ToString();
            txtOtherAssets.Text = ds.Tables[1].Rows[0]["OtherAssets"].ToString();
            txtLand.Text = ds.Tables[1].Rows[0]["Land"].ToString();
            txtPayings.Text = ds.Tables[1].Rows[0]["Payables"].ToString();
            txtReceivedCommite.Text = ds.Tables[1].Rows[0]["ReceivedCommite"].ToString();
            txtHouseRent.Text = ds.Tables[1].Rows[0]["HouseRent"].ToString();
            txtUtilityBills.Text = ds.Tables[1].Rows[0]["UtilityBills"].ToString();
            txtPendingInstallment.Text = ds.Tables[1].Rows[0]["PayableInstallment"].ToString();
            txtShopRent.Text = ds.Tables[1].Rows[0]["ShopRent"].ToString();
            txtPlotRent.Text = ds.Tables[1].Rows[0]["PlotRent"].ToString();
            txtOtherExpences.Text = ds.Tables[1].Rows[0]["OtherExpences"].ToString();
            Z_O_C.Text = ds.Tables[1].Rows[0]["Zakat_cons_comm"].ToString();
            lblDate.Text = ds.Tables[1].Rows[0]["regdatettime"].ToString();
            


            //ddlPatientType.SelectedValue = ds.Tables[1].Rows[0]["Patient_Type_Id"].ToString();
            //ddlPatientType.DataTextField = ds.Tables[1].Rows[0]["Patient_type"].ToString();
            //ddlCharityFund.SelectedValue = ds.Tables[1].Rows[0]["CharityFund"].ToString();
            //ddlZakatFund.SelectedValue = ds.Tables[1].Rows[0]["ZakatFund"].ToString();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        if (lblMr.Text.Trim() != "")
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connstring))
                {

                    using (SqlCommand cmd = new SqlCommand())
                    {
                        cmd.Connection = conn;
                        cmd.CommandText = "Usp_InsertPatientZakat";
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("ID", 0);
                        cmd.Parameters.AddWithValue("RegNo", lblMr.Text);
                        cmd.Parameters.AddWithValue("Cast", txtCast.Text.Trim());
                        cmd.Parameters.AddWithValue("Occupation", txtOccupation.Text.Trim());
                        cmd.Parameters.AddWithValue("Parents", txtParent.Text.Trim());
                        cmd.Parameters.AddWithValue("BrotherSister", txtBrotherSister.Text.Trim());
                        cmd.Parameters.AddWithValue("Sons", txtSon.Text.Trim());
                        cmd.Parameters.AddWithValue("dau", txtdau.Text.Trim());
                        cmd.Parameters.AddWithValue("moth", txtfa.Text.Trim());
                        cmd.Parameters.AddWithValue("comt", txtboxDegar.Text.Trim());
                        cmd.Parameters.AddWithValue("bro", txtbro.Text.Trim());
                        cmd.Parameters.AddWithValue("Daughters", txtDaughter.Text.Trim());
                        cmd.Parameters.AddWithValue("OtherDependents", txtOther.Text.Trim());
                        cmd.Parameters.AddWithValue("Savings", txtSavings.Text.Trim());
                        cmd.Parameters.AddWithValue("Jewellery", txtJewellery.Text.Trim());
                        cmd.Parameters.AddWithValue("Goats", txtGoats.Text.Trim());
                        cmd.Parameters.AddWithValue("DepositCommite", txtDepositCommite.Text.Trim());
                        cmd.Parameters.AddWithValue("MonthlyIncome", txtMonthlyIncome.Text.Trim());
                        cmd.Parameters.AddWithValue("ReceivingDept", txtReceiveDebt.Text.Trim());
                        cmd.Parameters.AddWithValue("Cows", txtCows.Text.Trim());
                        cmd.Parameters.AddWithValue("LandType", ddlLandType.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("HouseShop", txtShopHouse.Text.Trim());
                        cmd.Parameters.AddWithValue("Vehicle", txtVehicle.Text.Trim());
                        cmd.Parameters.AddWithValue("OtherAssets", txtOtherAssets.Text.Trim());
                        cmd.Parameters.AddWithValue("Land", txtLand.Text.Trim());
                        cmd.Parameters.AddWithValue("Payables", txtPayings.Text.Trim());
                        cmd.Parameters.AddWithValue("ReceivedCommite", txtReceivedCommite.Text.Trim());
                        cmd.Parameters.AddWithValue("HouseRent", txtHouseRent.Text.Trim());
                        cmd.Parameters.AddWithValue("UtilityBills", txtUtilityBills.Text.Trim());
                        cmd.Parameters.AddWithValue("PayableInstallment", txtPendingInstallment.Text.Trim());
                        cmd.Parameters.AddWithValue("ShopRent", txtShopRent.Text.Trim());
                        cmd.Parameters.AddWithValue("PlotRent", txtPlotRent.Text.Trim());
                        cmd.Parameters.AddWithValue("OtherExpences", txtOtherExpences.Text.Trim());
                        cmd.Parameters.AddWithValue("Z_O_C", Z_O_C.Text.Trim());
                        //cmd.Parameters.AddWithValue("CharityFund", ddlCharityFund.SelectedItem.Text);
                        //cmd.Parameters.AddWithValue("ZakatFund", ddlZakatFund.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("PatientTypeId", ddlPatientType.SelectedValue);
                        
                        DateTime dt = Convert.ToDateTime(lblDate.Text);
                        string date = dt.ToString("yyyy-MM-dd");
                        cmd.Parameters.AddWithValue("regdate", date);
                        cmd.Parameters.AddWithValue("@YearlyNo", hfYearlyNo.Value);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                        lblMessage.Text = "Data Saved Successfully";

                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Some Error Occured";
            }
        }
    }

    private void clearAllData()
    {
        HfRegNo.Value = "";
        lblMr.Text = "";
        lblName.Text = "";
        lblRelationName.Text = "";
        lblDateofBirth.Text = "";
        lblIDCard.Text = "";
        lblReceiptNo.Text = "";
        lblAddress.Text = "";
        txtCast.Text = "";
        txtOccupation.Text = "";
        txtParent.Text = "";
        txtBrotherSister.Text = "";
        txtSon.Text = "";
        txtDaughter.Text = "";
        txtOther.Text = "";
        txtSavings.Text = "";
        txtJewellery.Text = "";
        txtGoats.Text = "";
        txtDepositCommite.Text = "";
        txtMonthlyIncome.Text = "";
        txtReceiveDebt.Text = "";
        txtCows.Text = "";
        ddlLandType.SelectedIndex = 0;
        txtShopHouse.Text = "";
        txtVehicle.Text = "";
        txtOtherAssets.Text = "";
        txtLand.Text = "";
        txtPayings.Text = "";
        txtReceivedCommite.Text = "";
        txtHouseRent.Text = "";
        txtUtilityBills.Text = "";
        txtPendingInstallment.Text = "";
        txtShopRent.Text = "";
        txtPlotRent.Text = "";
        txtOtherExpences.Text = "";
        //ddlCharityFund.SelectedIndex = 0;
        //ddlZakatFund.SelectedIndex = 0;
        lblMessage.Text = "";
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        clearAllData();
    }


    protected void btnReverify_Click(object sender, EventArgs e)
    {
        Response.Redirect("PatientDetailForMuftiSbReport.aspx?RegNo=" + HfRegNo.Value);
    }
    


    protected void btnPrint_Click(object sender, EventArgs e)
    {
        Response.Redirect("PatientDetailForMuftiSbReport.aspx?RegNo="+HfRegNo.Value);
    }
}