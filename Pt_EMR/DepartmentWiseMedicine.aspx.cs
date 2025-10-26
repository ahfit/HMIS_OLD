using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;



public partial class Pt_EMR_DepartmentWiseMedicine : System.Web.UI.Page
{
    String connstr = ConfigurationManager.ConnectionStrings["TreatmentConnectionString"].ToString();


    protected void Page_Load() {
        if (!IsPostBack)
        {

            GetFrequency();
            BindGrid();
        }
    }
    protected void ButtonSave_Click(object sender, EventArgs e)
    {
        
        try
        {
            DbManager dbmanager = new DbManager();
            SqlParameter[] parameter = {
                //New SqlParameter("@Prescription_Id", SqlDbType.BigInt, 8, ParameterDirection.Output, False, 0, 0, 0, DataRowVersion.Default, 0)
                new SqlParameter("@ID",SqlDbType.BigInt,8,ParameterDirection.Output,false,0,0,"0",DataRowVersion.Default,0),
        new SqlParameter("@SubDept_id",Session["SubDeptID"]),
        new SqlParameter("@MedicineCode_ID",hfName.Value.Trim()),
        new SqlParameter("@RouteID_FK",DropDownList_route.SelectedValue),
        new SqlParameter("@MedicineFrequency",TextBox_Frequency.Text),
        new SqlParameter("@FrequencyID_FK",DropDownList_frequencyName.SelectedValue),
        new SqlParameter("@Days",TextBox_days.Text),
        new SqlParameter("@Meal",DropDownList_Meal.SelectedValue),
        new SqlParameter("@PhysicanNotes",TextBoxInstruction.Text.Trim()),
        new SqlParameter("@CreatedBy",Session["emp_id"]),
        new SqlParameter("@CreatedDate",DateTime.Now)};
            dbmanager.ExecuteNonQuery("uspSaveDepartmentWisePatientMedicine", "TreatmentConnectionString", parameter);
             parameter[0].Value.ToString();
            
            for (int i = 0; i < DataList_Frequency.Items.Count; i++)
            {
                HiddenField FrequencyID=DataList_Frequency.Items[i].FindControl("HF_F_S_Id") as HiddenField;
                HiddenField FrequencySubID = DataList_Frequency.Items[i].FindControl("Frequency_Sub_ID") as HiddenField;
                
                TextBox Dosage = DataList_Frequency.Items[i].FindControl("TextBox_dosage2") as TextBox;
                
                DbManager manager = new DbManager();
                SqlParameter[] parameters = { new SqlParameter("@FrequencyID_FK",FrequencySubID.Value),
                new SqlParameter("@FavouriteMedicineID_Fk",parameter[0].Value.ToString() ),
                new SqlParameter("@Dosage", Dosage.Text.Trim()) };
                manager.ExecuteNonQuery("uspDepartmentWiseMedicineFrequecnyDetail", "TreatmentConnectionString", parameters);
            }
            BindGrid();
            LabelMessage.Text = "Data is Save Successfully";
        }
        catch (Exception ex)
        {
            LabelMessage.Text = "Error is Occured";
        }
        finally { };
    }

    protected void btn_delete_Click(object sender, EventArgs e)
    {

    }

    protected void ImageButton_Frequency_ShowHide_Click(object sender, EventArgs e)
    {

    }
    private void GetFrequency() {
        DbManager dbmanager = new DbManager();
        SqlParameter[] param = { };
        DataSet ds=dbmanager.ExecuteDataSet("GetFrequency", "STOREConnectionString", param );

        DropDownList_frequencyName.DataSource = ds;
        DropDownList_frequencyName.DataBind();


    }






    protected void gvdFavouriteMedicine_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType==DataControlRowType.DataRow)
        {


            HiddenField hfRouteValue = e.Row.FindControl("hfDDlRuteValue") as HiddenField;
            HiddenField hfFrequencyIDs = e.Row.FindControl("hfFrequencyID") as HiddenField;
            HiddenField hfMeals = e.Row.FindControl("hfMeals") as HiddenField;
            HiddenField hfDeptMedID = e.Row.FindControl("hfDeptMedID") as HiddenField;
            
            TextBox MedicineName=e.Row.FindControl("txtboxMedicineName") as TextBox;
            DropDownList DDLRoutes=e.Row.FindControl("ddlRoute") as DropDownList;
            DropDownList DDlFrequecny = e.Row.FindControl("ddlFrequency") as DropDownList;
            DropDownList DDlMeal = e.Row.FindControl("ddlMeals") as DropDownList;
            TextBox PhysicanNotes = e.Row.FindControl("physicanNotes") as TextBox;
            TextBox Days = e.Row.FindControl("txtDays") as TextBox;
            
            DDLRoutes.DataBind();
            DDLRoutes.SelectedValue = hfRouteValue.Value;


            DbManager dbmanager = new DbManager();
            SqlParameter[] param = { };
            DDlFrequecny.DataSource = dbmanager.ExecuteDataSet("GetFrequency", "STOREConnectionString", param);            
            DDlFrequecny.DataBind();
            DDlFrequecny.SelectedValue = hfFrequencyIDs.Value;
            DDlMeal.DataBind();
            DDlMeal.SelectedValue = hfMeals.Value;

            
            DataList datalistDosage = e.Row.FindControl("ddlFrequencyList") as DataList;
            DbManager dbManager = new DbManager();
            datalistDosage.DataSource = dbManager.ExecuteDataTable("upsGetFrequencyDetailForDatalist", "TreatmentConnectionString", new SqlParameter[] {new SqlParameter("@MedicinrFrequency",hfFrequencyIDs.Value) });
            datalistDosage.DataBind();


            for (int i = 0; i < datalistDosage.Items.Count; i++)
            {
                DbManager mnger = new DbManager();
               DataTable dt= mnger.ExecuteDataTable("uspFrquencyList", "TreatmentConnectionString", new SqlParameter[] { new SqlParameter("@frequncylistID", hfFrequencyIDs.Value),
                   new SqlParameter("@DeptMedID", hfDeptMedID.Value) });



                if (dt.Rows.Count > 0)
                {
                    for (int j = 0; j < dt.Rows.Count; j++)
                    {
                        TextBox txtbox = datalistDosage.Items[j].FindControl("TextBox_dosage2") as TextBox;
                        txtbox.Text = dt.Rows[j]["Dosage"].ToString();
                    }
                }
                break;

            }


        }
    }



    private void BindGrid() {

        DbManager dbManager = new DbManager();
        gvdFavouriteMedicine.DataSource= dbManager.ExecuteDataTable("FavouriteMedicineList", "TreatmentConnectionString", new SqlParameter[] { });
        gvdFavouriteMedicine.DataBind();
    }





}
