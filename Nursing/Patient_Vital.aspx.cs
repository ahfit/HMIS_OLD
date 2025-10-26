using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class Nursing_Patient_Vital : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if(!Page.IsPostBack)
        {
            lblMsg.Text = "";
            DateTime date_Output = (DateTime)DateTime.Now;

            if (date_Output.Hour >= 0 && date_Output.Hour < 8 || date_Output.Hour >= 20 && date_Output.Hour < 24)
            {
                DropDownList2.SelectedValue = "2";
              
            }
            else if (date_Output.Hour >= 8 && date_Output.Hour < 14)
            {
                DropDownList2.SelectedValue = "3";
               
            }
            else if (date_Output.Hour >= 14 && date_Output.Hour <= 20)
            {
                DropDownList2.SelectedValue = "1";
             
            }
        }
        {
            JavaScriptMenu obj_menu = new JavaScriptMenu();
            obj_menu.loginvalidate();
            LabelSideMenu.Text = obj_menu.SideMenu( Request.PhysicalPath.Substring(0,(Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)));
            //LabelSideMenu.Text = obj_menu.SideMenu(string. (Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)));
            LabelFooter.Text = obj_menu.Footer_String();
            FillGridView();
        }



    }
    void ClearFields()
    {
        txtweight.Text = "";
        txtheight.Text = "";
        txtbpH.Text = "";
        txtbpL.Text = "";
        txtpulse.Text = "";
        txtRespiration.Text = "";
        txtblood.Text = "";
        txttemp.Text = "";
        txtBMI.Text = "";
        txtboxO2.Text = "";
        txtboxRAO2.Text = "";
        txtboxRmarks.Text = "";
        

    }
    private void FillGridView()
    {
        using (SqlConnection connection = new SqlConnection(connstr))
        {
            SqlCommand command = new SqlCommand("usp_PatientVitalSignRecord", connection);
            SqlDataAdapter sda = new SqlDataAdapter(command);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@YearlyNo", Convert.ToInt32(Session["YearlyNo"]));
            DataTable dt = new DataTable();
            sda.Fill(dt);
            GridView1.DataSource = dt;
            GridView1.DataBind();
            Chart1.DataSource = dt;
            
            Chart1.DataBind();

            Chart2.DataSource = dt;

            Chart2.DataBind();

            Chart3.DataSource = dt;

            Chart3.DataBind();

            Chart4.DataSource = dt;

            Chart4.DataBind();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        SqlConnection conn = new SqlConnection(connstr);
     
        try
        {
            if (txtweight.Text!="")
            {

            conn.Open();
            SqlCommand cmd = new SqlCommand("UspInsertPatientVital", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Weight_KG", txtweight.Text);
            cmd.Parameters.AddWithValue("@Height_CM", txtheight.Text);
            cmd.Parameters.AddWithValue("@BPHigh", txtbpH.Text);
            cmd.Parameters.AddWithValue("@BPLow", txtbpL.Text);
            cmd.Parameters.AddWithValue("@PulseRate", txtpulse.Text);
            cmd.Parameters.AddWithValue("@RespirationRate", txtRespiration.Text);
            cmd.Parameters.AddWithValue("@BloodSugar", txtblood.Text);
            cmd.Parameters.AddWithValue("@TemperatureF", txttemp.Text);
            cmd.Parameters.AddWithValue("@BMI", txtBMI.Text);
            cmd.Parameters.AddWithValue("@YearlyNo", Session["YearlyNo"]);
            cmd.Parameters.AddWithValue("@VitalDate",DateTime.Now.ToString());
            cmd.Parameters.AddWithValue("@Shift", DropDownList2.SelectedItem.ToString().Trim());
            cmd.Parameters.AddWithValue("@O2", txtboxO2.Text.Trim());
            cmd.Parameters.AddWithValue("@RAO2", txtboxRAO2.Text.Trim());
            cmd.Parameters.AddWithValue("@SugarRemarks", txtboxRmarks.Text.Trim());
            cmd.Parameters.AddWithValue("@EmpId", Session["emp_id"]);
            

            cmd.ExecuteNonQuery();
        }
            else
            {
                txtweight.Text = "Please enter first Value";
            }

        }
        catch (Exception ex)
        {


        }

        finally
        {
            conn.Close();
            lblMsg.Text = "Save Successfully...";
            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Font.Bold = true;
            lblMsg.Visible = true;
        }

        FillGridView();
        ClearFields();

    }


    protected void Reportbtn_Click(object sender, EventArgs e)
    {

        Response.Redirect("~/Nursing/Patient_Vital_Sign.aspx");
    }
}