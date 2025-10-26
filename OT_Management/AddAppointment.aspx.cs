using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class OT_Management_AddAppointment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txtboxDOO.Text = DateTime.Now.ToString("yyyy-MM-dd");
            GetAnesthesia();
            GetConsultants();
            loadmooperation();
            LoadTimeSlots();
            GetOTList();
            
        }

    }
    protected void loadmooperation()
    {
        DataTable dt = new DataTable();
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["OT_ManagementConnectionString"].ConnectionString);
        con.Open();
        SqlCommand cmd = new SqlCommand("OT_Add_Appointment", con);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@MainId", Request.QueryString["MainId"]);
        cmd.Parameters.AddWithValue("@yearlyno", Request.QueryString["VisitNo"]);
        cmd.Parameters.AddWithValue("@regno", Request.QueryString["RegNo"]);
        SqlDataAdapter sda = new SqlDataAdapter(cmd);
        sda.Fill(dt);
        if (dt.Rows.Count > 0)
        {
            RadioButtonList_Type.SelectedValue = dt.Rows[0]["ModeOfOperation"].ToString();

            DropDownListConsultant.SelectedValue = dt.Rows[0]["Consultant"].ToString();
            ddlAnesthsia.SelectedValue = dt.Rows[0]["Anesthesia_Name"].ToString();
            txtboxDOA.Text = Convert.ToDateTime(dt.Rows[0]["Date_Of_Admission"]).ToString("yyyy-MM-dd");
            txtboxDOO.Text = Convert.ToDateTime(dt.Rows[0]["DateOfOperation"]).ToString("yyyy-MM-dd");
            lblpackage.Text = dt.Rows[0]["Package"].ToString();
            lblProcedures.Text = dt.Rows[0]["proceduress"].ToString();
        }
    }
    private void GetConsultants()
    {
        DbManager manager = new DbManager();
        DataTable ds = new DataTable();
        ds = manager.ExecuteDataTableWithQuery("select EmpID,ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') as Name from Employee where Is_Consultant=1", "Basic_Data_ConnectionString", new SqlParameter[] { });
       

        DropDownListConsultant.DataSource = ds;
        DropDownListConsultant.DataValueField = "EmpID";
        DropDownListConsultant.DataTextField = "Name";
        DropDownListConsultant.DataBind();
    }

    public void LoadTimeSlots()
    {
        DbManager manager = new DbManager();
        DataTable dt = manager.ExecuteDataTable("uspGetOT_TimeSlots_am", "OT_ManagementConnectionString",
                                                         new SqlParameter[] { new SqlParameter("@datetime", Convert.ToDateTime(txtboxDOO.Text)) });
        ddltimeslot.DataSource = dt;

        if (dt.Rows.Count > 0)
        {

            if (dt.Rows[0]["TimeSlotID"].ToString() == "0")
            {
                btnSave.Visible = false;
                ddltimeslot.DataValueField = "TimeSlotID";
                ddltimeslot.DataTextField = "TimeSlot";
                ddltimeslot.DataBind();
            }
            else
            {
                ddltimeslot.DataValueField = "TimeSlotID";
                ddltimeslot.DataTextField = "TimeSlot";
                ddltimeslot.DataBind();
                btnSave.Visible = true;
            }
        }



    }

    protected void txtboxDOO_TextChanged(object sender, EventArgs e)
    {
        LoadTimeSlots();
        GetOTList();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {


            DbManager manager = new DbManager();
            manager.ExecuteNonQuery("uspSavePatientOTDetail", "OT_ManagementConnectionString",
                                                            new SqlParameter[] {
                                                             new SqlParameter("@MainId",Request.QueryString["MainId"]),
                                                             new SqlParameter("@timeSlotID",ddltimeslot.SelectedValue),
                                                             new SqlParameter("@OperationDate",Convert.ToDateTime(txtboxDOO.Text)),
                                                             new SqlParameter("@ConsultantId",DropDownListConsultant.SelectedValue),
                                                             new SqlParameter("@AnesthesiaId",ddlAnesthsia.SelectedValue),
                                                             new SqlParameter("@ModOfOp",RadioButtonList_Type.SelectedValue)
                                                            });

            //loadmooperation();
            GetOTList();
            lblMessage.Text = "Appointment is Made";

        }
        catch (Exception exp)
        {
            string s = exp.ToString();

        }
    }


    private void GetAnesthesia()
    {
        DbManager manager = new DbManager();
        ddlAnesthsia.DataSource = manager.ExecuteDataTableWithQuery("Select   Anesthesia_Id,Anesthesia_Name from Anesthesia_Type", "OT_ManagementConnectionString", new SqlParameter[] { });
        ddlAnesthsia.DataValueField = "Anesthesia_Id";
        ddlAnesthsia.DataTextField = "Anesthesia_Name";
        ddlAnesthsia.DataBind();
    }


    private void GetOTList()
    {
        DbManager manager = new DbManager();
         
        SqlParameter[] par = {
        
        new SqlParameter("@Date",txtboxDOO.Text)

        };
        DataTable dt = manager.ExecuteDataTable("GetPatientsForOTList", "OT_ManagementConnectionString", par);

        grdAppointments.DataSource = dt;
        grdAppointments.DataBind();

    }


    


}