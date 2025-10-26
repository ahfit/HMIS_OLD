using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.VisualBasic;
public partial class DeliveryNotes: System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            JavaScriptMenu obj_menu = new JavaScriptMenu();
            obj_menu.loginvalidate();
            String str = Request.PhysicalPath;
            String s = str.Substring(Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length);
            LabelSideMenu.Text = obj_menu.SideMenu(s);
            getPatientInfo();
            txtDateDelivery.Text = (DateTime.Now).ToString("yyyy-MM-dd");
            bindGrid();
        }
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connstr);
        try
        {
            conn.Open();
            SqlCommand sc = new SqlCommand("usp_insert_Delivery_Registeration", conn);
            sc.CommandType = CommandType.StoredProcedure;
            sc.Parameters.AddWithValue("@Patientname", txtNamePatient.Text);
            sc.Parameters.AddWithValue("@Husbandname", txtHusbandName.Text);
            sc.Parameters.AddWithValue("@Cnic", txtCNICHusband.Text);
            sc.Parameters.AddWithValue("@Deliverydate", txtDateDelivery.Text);
            sc.Parameters.AddWithValue("@Deliverytime", txtTime.Text);
            sc.Parameters.AddWithValue("@Babysex", ddlSexofBaby.SelectedValue);
            sc.Parameters.AddWithValue("@Apgar", txtApgar.Text);
            sc.Parameters.AddWithValue("@Onemint", txt1Minut.Text);
            sc.Parameters.AddWithValue("@Fivemint", txt5Minut.Text);
            sc.Parameters.AddWithValue("@Deliverytype", txtTypesofDelivery.Text);
            sc.Parameters.AddWithValue("@Weight", txtWeight.Text);
            sc.Parameters.AddWithValue("@Conductedby", txtDeliveryConductedBy.Text);
            sc.Parameters.AddWithValue("@Assistant", txtAssistant.Text);
            sc.Parameters.AddWithValue("@Serialno", txtBCSrNo.Text);
            sc.Parameters.AddWithValue("@Sign", txtSignRMO.Text);
            if(!String.IsNullOrEmpty(Request.QueryString["regno"]))
            {
                sc.Parameters.AddWithValue("@RegNo", Request.QueryString["regno"]);
                sc.Parameters.AddWithValue("@YearlyNo", Request.QueryString["PayID"]);
            }
            else
            {
                sc.Parameters.AddWithValue("@RegNo", Session["registrationNo"]);
                sc.Parameters.AddWithValue("@YearlyNo", Session["YearlyNo"]);
            }
            
            sc.ExecuteNonQuery();
        }
        catch(Exception)
        {
            lblMsg.Text = "Error Occured";
            lblMsg.ForeColor = System.Drawing.Color.Red;
            lblMsg.Font.Bold = true;
            lblMsg.Visible = true;
        }
        finally
        {
            conn.Close();
           
                lblMsg.Text = "Record Saved Successfully";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Font.Bold = true;
                lblMsg.Visible = true;
                Clear();
                bindGrid();
        }
    }

    protected void Clear()
    {
        
    }
    protected void getPatientInfo()
    {
        try
        {
            DbManager dbm = new DbManager();
            String regNo = "";
            String yearlyNo = "";
            if (!String.IsNullOrEmpty(Request.QueryString["regno"]))
            {
                regNo=Request.QueryString["regno"];
                yearlyNo=Request.QueryString["PayID"];
            }
            else
            {
               regNo= Session["registrationNo"].ToString();
                 yearlyNo=Session["YearlyNo"].ToString();
            }
            SqlParameter[] sp = { new SqlParameter("@RegNo", regNo), new SqlParameter("@YearlyNo",yearlyNo) };
            DataTable dt = new DataTable();
            dt = dbm.ExecuteDataTable("uspGetPatientInfoForDeliveryNotes", "TreatmentConnectionString", sp);
            txtNamePatient.Text = dt.Rows[0]["PatientName"].ToString();
            txtHusbandName.Text = dt.Rows[0]["HusandName"].ToString();
            txtCNICHusband.Text = dt.Rows[0]["CNIC"].ToString();
            txtNamePatient.Enabled = false;
            txtHusbandName.Enabled = false;
        }
        catch(Exception ex)
        {

        }
    }
    protected void bindGrid()
    {
        try
        {
            DbManager dbm = new DbManager();
            String regNo = "";
            String yearlyNo = "";
            if (!String.IsNullOrEmpty(Request.QueryString["regno"]))
            {
                regNo = Request.QueryString["regno"];
                yearlyNo = Request.QueryString["PayID"];
            }
            else
            {
                regNo = Session["registrationNo"].ToString();
                yearlyNo = Session["YearlyNo"].ToString();
            }
            SqlParameter[] sp = { new SqlParameter("@YearlyNo", yearlyNo) };
            gvDeliveryNote.DataSource = dbm.ExecuteDataTable("uspGetDeliveryNote", "TreatmentConnectionString", sp);
            gvDeliveryNote.DataBind();
           
        }
        catch (Exception ex)
        {

        }
    }
}
