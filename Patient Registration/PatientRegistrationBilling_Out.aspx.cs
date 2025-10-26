using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using OnBarcode.Barcode;
using System.IO;

public partial class Patient_Registration_PatientRegistrationBilling_Out : System.Web.UI.Page
{
    Coma coma = new Coma();
    bool preRenderRequired = false;
    private String PhPhone, PMP, CNIC;
    private DateTime DT, DateBirth;
    int flag = 0;
    String PatientName = "";
    Encryption Encry = new Encryption();
    static string Pt_Reg_No = "";
    int EmployeeNo;
    Patient_RegistrationTableAdapters.Emp_TempTableAdapter daEmpTemp = new Patient_RegistrationTableAdapters.Emp_TempTableAdapter();
    static Byte[] fingerPrint;
    FileUpload classobj = new FileUpload();
    Encryption ENC = new Encryption();

    protected void Page_Load(object sender, EventArgs e)
    {
        

        lblMsg.Visible = false;
        EmployeeNo = int.Parse(Session["emp_id"].ToString());
        if (!Page.IsPostBack)
        {
            getSubDept();
            DropDownList1.SelectedValue="63";
            getConsultant();
            textboxage.Attributes.Add("OnBlur", "showAgedob(this)");
            DropDownListBIndicator.Attributes.Add("onChange", "changeYear()");
            textboxage.Attributes.Add("OnFocus", "showAgedobfocus(this)");
            Session.Remove("YearlyNo");
            Session.Remove("PayId");
            Session.Remove("RegistrationNo");
            Session.Remove("RegNo");
            rblPatientType_Sub.DataBind();
            if (rblPatientType_Sub.Items.Count > 0)
                rblPatientType_Sub.SelectedValue = "1";
            WebDateChooser1.Value = DateTime.Now;
            SetServiceForm(false, false);
            BindServicesGrid();
            HiddenField_IsUpdate.Value = "0";
           // txtRegistrationNo.Focus();
            //pnlAddServices.Visible = false;
            ShowMessage("Service aaaa successfully.", false);

        }

      
        //DropDownList_Employee_name.Items.Insert(0, new ListItem("Doctor_id","0"));
        RBLrelation.Attributes.Add("OnClick", "radio1()");
        RBLprefix.Attributes.Add("onClick", "show(this)");
        
    }

    private void SetServiceForm(bool isEditForm, bool isPaymentForm)
    {
        //pnlAddServices.Visible = false;
        //pnlServices.Visible = false;
        //pnlPayment.Visible = false;

        //if (GridView_Date_Wise.Rows.Count > 0)-
        //    pnlPaymentButton.Visible = true;
        //else
        //    pnlPaymentButton.Visible = false;

        //if (isEditForm == true)
        //    pnlAddServices.Visible = true;
        //else if (isPaymentForm == true)
        //    pnlPayment.Visible = true;
        //else
        //    pnlServices.Visible = true;
    }

    protected void RadioButtonList_Patient_Type_SelectedIndexChanged(Object sender, System.EventArgs e)
    {
        if (RadioButtonList_Patient_Type.SelectedValue == "public")
        {
            pnlPanelPatient.Visible = true;
            DropDownList_Parties.SelectedValue = "200120";
            DropDownList_Parties.Enabled = false;

        }
        rblPatientType_Sub.DataBind();

    }

    protected void CheckBox_Same_as_Above_CheckedChanged(Object sender, System.EventArgs e)
    {
        if (CheckBox_Same_as_Above.Checked == true)
        {
            //TextBox_House_Ot.Text = textboxHouseNo.Text;
            //TextBox_Street_OT.Text = textboxstreetaddress.Text;
        }
        else
        {
            //textboxTown_ot.Text = string.Empty;
            //TextBox_House_Ot.Text = string.Empty;
            //TextBox_Street_OT.Text = string.Empty;
        }
    }

    protected void rblPatientType_Sub_SelectedIndexChanged(Object sender, System.EventArgs e)
    {
        //rblPatientType_Sub.
        LoadPatientPanel();
    }

    protected void LoadPatientPanel()
    {
        DataSourceSelectArguments sql_arg = new DataSourceSelectArguments();
        pnlPanelPatient.Visible = true;
        DataView dv = (DataView)SQL_Patient_Type_Sub.Select(sql_arg);
        if (dv.Table.Rows.Count > 0)
        {
            DataRow[] drr = dv.Table.Select("Patient_Type_ID=" + rblPatientType_Sub.SelectedValue);
            if (drr.Length > 0)
            {
                if (bool.Parse(drr[0]["Dependent_Allow"].ToString()) == true)
                {
                    td_RegistrationType.Visible = true;
                    rblRegistrationType.SelectedIndex = 0;
                    ddlEmp_Patient.Visible = false;
                    ddlRelation.Visible = false;
                }
                else
                {
                    //gvDependents.Visible = false;
                    td_RegistrationType.Visible = false;
                }

                if (bool.Parse(drr[0]["Panel_Company"].ToString()) == true)
                {
                    DropDownList_Parties.DataBind();
                    ddlDesignation.DataBind();
                    td_Insurer.Visible = true;
                    td_Employee_Designation.Visible = true;
                    ReferenceId.Visible = true;
                    DropDownList_Parties.Visible = true;
                    DropDownList_Parties.Items.Insert(0, new ListItem(" Select Party ", "0"));
                    DropDownList_Parties.SelectedIndex = 0;
                }
                else
                {
                    DropDownList_Parties.Visible = false;
                    td_Insurer.Visible = false;
                    td_Employee_Designation.Visible = false;
                    ReferenceId.Visible = false;
                }
            }
        }
    }

   
    protected void GridView2_PreRender(Object sender, System.EventArgs e)
    {
        //for(int i = 0; i <= GridView2.Rows.Count - 1;i++)
        //{
        //    Label a = (Label)GridView2.Rows[i].FindControl("HiddenFieldSAmount");
        //    Label b = (Label)GridView2.Rows[i].FindControl("HiddenFieldSID");
        //    Label c = (Label)GridView2.Rows[i].FindControl("HiddenField_Edit_Status");
        //    a.Visible = false;
        //    b.Visible = false;
        //    c.Visible = false;

        //    TextBox Hid_Amount = (TextBox)GridView2.Rows[i].FindControl("TextBox_Amount");
        //    Label Hid_lbl = (Label)GridView2.Rows[i].FindControl("Label1");
        //    Hid_Amount.Text = coma.place_Coma(Hid_lbl.Text);
        //    Hid_Amount.Visible = true;
        //    Hid_lbl.Visible = false;

        //}
    }

    protected void GridView_Date_Wise_PreRender(object sender, System.EventArgs e)
    {
        if (preRenderRequired == false || GridView_Date_Wise.Rows.Count == 0) return;
        decimal totalCharges = 0.0M;
        Label lblTemp = null;

        foreach (GridViewRow gvRow in GridView_Date_Wise.Rows)
        {
            lblTemp = gvRow.FindControl("lblServiceCharges") as Label;
            totalCharges += decimal.Parse(lblTemp.Text);
        }

        lblTemp = GridView_Date_Wise.FooterRow.FindControl("lblTotalCharges") as Label;
        lblTemp.Text = totalCharges.ToString();

        //if (GridView_Date_Wise.Rows.Count > 0)
        //    pnlPaymentButton.Visible = true;

    }

    //protected void btnSearchService_Click(object sender, System.EventArgs e)
    //{
        
    //}

    protected void btnAddService_Click(object sender, System.EventArgs e)
    {
        //pnlMain.Visible = false;
        //pnlAddServices.Visible = true;
        SetServiceForm(true, false);
    }

    protected void btnCloseAddService_Click(object sender, System.EventArgs e)
    {
        //pnlAddServices.Visible = false;
        
        BindServicesGrid();
        SetServiceForm(false, false);
    }

    protected void lnkServiceName_Click(object sender, System.EventArgs e)
    {

        LinkButton lnkTemp = sender as LinkButton;
        HiddenField hfld1 = null, hfld2 = null; TextBox txtboxQty = null;
        TextBox txtAmount = null;
        int serviceId = 0;

        if (lnkTemp != null)
        {
            serviceId = int.Parse(lnkTemp.CommandArgument);
            DataListItem itm = lnkTemp.NamingContainer as DataListItem;
            if (itm != null)
            {
                txtboxQty = itm.FindControl("txtQty") as TextBox;
                hfld1 = itm.FindControl("hfldEdit_Status") as HiddenField;
                hfld2 = itm.FindControl("hfldS_Category") as HiddenField;
                txtAmount = itm.FindControl("TextBox_Amount") as TextBox;
            }
        }
        if (txtboxQty.Text.Trim() != string.Empty)
        {
            for (int i = 0; i < int.Parse(txtboxQty.Text); i++)
            {
                ApplicationDTO.PatientServicesBillingDTO service = new ApplicationDTO.PatientServicesBillingDTO();
                service.ServiceID = serviceId;
                service.ServiceDateTime = DateTime.Now;
                service.ServiceName = lnkTemp.Text;
                service.ServiceCharges = decimal.Parse(txtAmount.Text);
                service.EditStatus = bool.Parse(hfld1.Value);
                service.Category = int.Parse(hfld2.Value);
                service.Payment_Status = 0;
                service.ID = 0;
                service.Doctor_ID = 0;
                service.Qty = 1;
                SaveServiceInSession(service);
                BindServicesGrid();
                ShowMessage("Service " + service.ServiceName + " added successfully.", false);
            }
        }
        
            
        
    }

    private void ShowMessage(string msg, bool isError)
    {
        lblMsg.Text = msg;
        lblMsg.Visible = true;
        lblMsg.ForeColor = System.Drawing.Color.Green;
    }

    private void SaveServiceInSession(ApplicationDTO.PatientServicesBillingDTO service)
    {
        List<ApplicationDTO.PatientServicesBillingDTO> services = null;
        services = GetServicesFromSession();
        services.Add(service);
        UpdatePaymentButton(services);
        SaveServicesInSession(services);
    }

    private void SaveServicesInSession(List<ApplicationDTO.PatientServicesBillingDTO> services)
    {
        Session["PatientServices"] = services;
    }

    private List<ApplicationDTO.PatientServicesBillingDTO> GetServicesFromSession()
    {
        List<ApplicationDTO.PatientServicesBillingDTO> services = null;
        if (Session["PatientServices"] != null)
        {
            services = (List<ApplicationDTO.PatientServicesBillingDTO>)Session["PatientServices"];
        }
        else
        {
            services = new List<ApplicationDTO.PatientServicesBillingDTO>();
        }

        return services;
    }

    private void BindServicesGrid()
    {
        List<ApplicationDTO.PatientServicesBillingDTO> services = GetServicesFromSession();
        GridView_Date_Wise.DataSource = services;
        preRenderRequired = true;
        GridView_Date_Wise.DataBind();
    }

    protected void imgBtnDeleteService_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton imgBtn = sender as ImageButton;
        if (imgBtn != null)
        {
            
            GridViewRow gvRow = imgBtn.NamingContainer as GridViewRow;
            List<ApplicationDTO.PatientServicesBillingDTO> services = GetServicesFromSession();

            ApplicationDTO.PatientServicesBillingDTO service = services[gvRow.RowIndex];
            services.RemoveAt(gvRow.RowIndex);
            ShowMessage("Service " + service.ServiceName + " removed successfully.", false);
            UpdatePaymentButton(services);
            SaveServicesInSession(services);
            BindServicesGrid();
        }
    }

    private void UpdatePaymentButton(List<ApplicationDTO.PatientServicesBillingDTO> services)
    {
        //if (services.Count > 0)
        //    btnMakePayment.Visible = true;
        //else
        //    btnMakePayment.Visible = false;
    }

    protected void btnMakePayment_Click(object sender, EventArgs e)
    {
        try
        {
            if (DropDownList1.SelectedValue == "0")
            {
                LbL_Mg.Text = "Please Select First Department";
                DropDownList1.Focus();
            }
            else if (DropDownList_Parties.SelectedValue == "0" && DropDownList_Parties.Visible == true)
            {
                LbL1_Mg.Text = "Please Select Party";
                DropDownList_Parties.Focus();
            }
            else
            {


                main();
                if (!string.IsNullOrEmpty(HiddenField_RegistrationNo.Value) && GridView_Date_Wise.Rows.Count > 0)
                {
                    SavePatientServices();

                    if (Session["RegistrationNo"] == null) return;
                    // Session.Add("RegistrationNo", Session["RegistrationNo"].ToString());
                    Session.Add("YearlyNo", Session["PayId"].ToString());
                    Session.Add("PatientType", "Routine");
                    Session.Remove("PatientServices");
                    Response.Redirect("~/Patient Billing/Patient_Payment.aspx?regno=" + Session["RegistrationNo"].ToString() + "&payid=" + Session["PayId"].ToString());

                }
            }      //ClearData();
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message;
        }
      
    }
               
    
    protected void btnCancelPaymentProcess_Click(object sender, EventArgs e)
    {
        SetServiceForm(false, false);
    }

    protected void btnSaveInformation_Click(object sender, EventArgs e)
    {
        try
        {
            main();
            SavePatientServices();
            ClearData();

        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message+"MSG";
        }

    }

    private void ClearData()
    {
        txtRegistrationNo.Text = string.Empty;
        textboxpfname.Text = string.Empty;
        textboxpmname.Text = string.Empty;
        textboxplname.Text = string.Empty;
        WebDateTimeEdit_DOB.Value = string.Empty;
        sex.SelectedIndex = -1;
        textboxmcode.Text = string.Empty;
        DropDownList_Religion.SelectedIndex = -1;
        DropDownList_Nationality.SelectedIndex = -1;
        RBLrelation.SelectedIndex = 0;
        textboxrfname.Text = string.Empty;
        textboxrmname.Text = string.Empty;
        textboxrlname.Text = string.Empty;
        DDLDepartment.SelectedIndex = -1;
        DropDownList1.SelectedIndex = -1;
        DropDownList_Employee_name.SelectedIndex = -1;
        rblPatientType_Sub.SelectedIndex = 0;


    }


    private void SavePatientServices()
    {
        try
        {
            for (int b = 0; b < GridView_Date_Wise.Rows.Count; b++)
            {
                Label lblAmount = (Label)GridView_Date_Wise.Rows[b].FindControl("lblServiceCharges");
                HiddenField HiddenFieldServiceId = (HiddenField)GridView_Date_Wise.Rows[b].FindControl("HiddenField_SID2");
                HiddenField HiddenFieldQty = (HiddenField)GridView_Date_Wise.Rows[b].FindControl("HiddenField_Qty");
                HiddenField HiddenFieldServiceDateTime = (HiddenField)GridView_Date_Wise.Rows[b].FindControl("HiddenField_ServiceDateTime");
                DropDownList DropDownListDoctor = (DropDownList)GridView_Date_Wise.Rows[b].FindControl("DropDownList_Doctor");


                SqlDataSource2.InsertParameters["regNo"].DefaultValue = Convert.ToString(Session["RegistrationNo"]);
                SqlDataSource2.InsertParameters["YearlyNo"].DefaultValue = Session["PayId"].ToString();
                SqlDataSource2.InsertParameters["S_ID"].DefaultValue = HiddenFieldServiceId.Value;
                SqlDataSource2.InsertParameters["empid"].DefaultValue = Session["Emp_ID"].ToString();
                SqlDataSource2.InsertParameters["Amount"].DefaultValue = lblAmount.Text;
                SqlDataSource2.InsertParameters["Payment_Status"].DefaultValue = "0";
                SqlDataSource2.InsertParameters["SubDept_ID"].DefaultValue = Session["SubDeptID"].ToString();
                SqlDataSource2.InsertParameters["Dept_ID"].DefaultValue = Session["dept_id"].ToString();
                SqlDataSource2.InsertParameters["sdatetime"].DefaultValue = HiddenFieldServiceDateTime.Value;
                SqlDataSource2.InsertParameters["Qty"].DefaultValue = HiddenFieldQty.Value;


                SqlDataSource2.InsertParameters["Refer_By_ID"].DefaultValue = "0";
                SqlDataSource2.InsertParameters["Refer_From_Other"].DefaultValue = "";
                
                SqlDataSource2.InsertParameters["DoctorId"].DefaultValue = DropDownListDoctor.SelectedValue;
                SqlDataSource2.Insert();
            }

            //List<ApplicationDTO.PatientServicesBillingDTO> services = GetServicesFromSession();
            //foreach (ApplicationDTO.PatientServicesBillingDTO service in services)
            //{
            //    SqlDataSource2.InsertParameters["regNo"].DefaultValue = Convert.ToString(HiddenField_RegistrationNo.Value);
            //    SqlDataSource2.InsertParameters["YearlyNo"].DefaultValue = Session["PayId"].ToString();
            //    SqlDataSource2.InsertParameters["empid"].DefaultValue = Session["Emp_ID"].ToString();
            //    SqlDataSource2.InsertParameters["Amount"].DefaultValue = service.ServiceCharges.ToString();
            //    SqlDataSource2.InsertParameters["Payment_Status"].DefaultValue = "0";
            //    SqlDataSource2.InsertParameters["SubDept_ID"].DefaultValue = Session["SubDeptID"].ToString();
            //    SqlDataSource2.InsertParameters["Dept_ID"].DefaultValue = Session["dept_id"].ToString();
            //    SqlDataSource2.InsertParameters["sdatetime"].DefaultValue = service.ServiceDateTime.ToString();
            //    SqlDataSource2.InsertParameters["Qty"].DefaultValue = service.Qty.ToString();
            //    SqlDataSource2.InsertParameters["Refer_By_ID"].DefaultValue = "0";
            //    SqlDataSource2.InsertParameters["Refer_From_Other"].DefaultValue = "";
            //    SqlDataSource2.InsertParameters["S_ID"].DefaultValue = service.ServiceID.ToString();
            //    SqlDataSource2.InsertParameters["S_ID"].DefaultValue = service.ServiceID.ToString();
            //    SqlDataSource2.Insert();
            //}
        }
        catch (Exception ex)
        {

            throw;
        }
    }

    private void main()
    {
        try
        {
            PhPhone = "";           
            PMP = textboxmcode.Text.Replace("-", "");
            string POPUP_Meg = string.Empty;
            if (string.IsNullOrEmpty( txtRegistrationNo.Text.Trim()))
            {
                if (SavePatientRecord())
                {
                    POPUP_Meg = "Patient save successfully...";
                }
                else
                {
                    POPUP_Meg = "Error Occur while saving Patient...";
                }                
            }
            else
            {
                if (UpdatePatientRecord())
                {
                    savePatientVisit();
                    POPUP_Meg = "Patient Update successfully.";                   
                }
                else
                {
                    POPUP_Meg = "Error Occur while updating Patient...";
                }
            }
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script language='javascript' type='text/javascript'>alert('" + POPUP_Meg + "');</script>");
            Type t = this.GetType();
            if (!ClientScript.IsClientScriptBlockRegistered(t, "Popup"))
            {
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString());
            }
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message+" MAIN";
        }
        HiddenField_IsUpdate.Value = "0";
    }

    private bool SavePatientRecord()
    {
        bool flag_result = false;
        //Make the three Parts of NIC Into One 
        CNIC = TextBox_CNIC_No.Text.Replace("-", "");
        //CNIC = string.Empty;
        string PPNo = null;
        //PPNo = textboxcountrycode.Text + textboxphonecode.Text + textboxphoneno.Text;
        PPNo = string.Empty;
        DateTime a = System.DateTime.Now;
        DT = a;
        int b = DateTime.Now.Hour;
        int c = DateTime.Now.Minute;
        int d = DateTime.Now.Second;
        SystemSetting sysSetting; 

        try
        {
            if (!string.IsNullOrEmpty(textboxpfname.Text) & !string.IsNullOrEmpty(textboxrfname.Text))
            {
                DateOfBirth();
                patientinsert();                
                Insert_Dependents();

            }
            else
            {
                //LabelErrorMessage.Text = "Please enter the First Name,Age,Relative/Father Name"
            }
                flag_result = true;
        }
        catch (Exception ex)
        {
                Response.Write(ex.Message + "Save Patirny Record");
        }

        if (flag_result)
        {
            Session.Add("PatientName", PatientName);
            Session.Add("Reg_No", Encry.Encrypt_Main(Session["RegistrationNo"].ToString(), false));

        }
        return flag_result;
    }

    private bool UpdatePatientRecord()
    {
        bool flag_result = false;
        DateOfBirth();
        if (DropDownList_Parties.Visible == true)
        {
            HiddenField_Party_ID.Value = DropDownList_Parties.SelectedValue;
        }
        else
        {
            HiddenField_Party_ID.Value = "0";
        }

        HiddenField_RegistrationNUmber.Value = ENC.Encrypt_Main(txtRegistrationNo.Text, true);
        HiddenFieldPFName.Value = ENC.Encrypt_Main(textboxpfname.Text, true);
        HiddenFieldPMName.Value = ENC.Encrypt_Main(textboxpmname.Text, true);
        HiddenFieldPLName.Value = ENC.Encrypt_Main(textboxplname.Text, true);
        HiddenField_PatientTYpeName.Value = rblPatientType_Sub.SelectedItem.Text;
        //HiddenField_phone_no.Value = textboxphoneno.Text;
        HiddenField_mobile_no.Value = textboxmcode.Text;
        HiddenField_cnic.Value = TextBox_CNIC_No.Text.Replace("-", "");
        try
        {
            string[] str = null;
            str = WebDateTimeEdit_DOB.Text.Split('/');
            HiddenField_DOB.Value = str[1] + "/" + str[0] + "/" + str[2];
           
            HiddenField_IPD_OPD.Value = ddlPatientType.SelectedItem.Text;
            SqlDataSourceUpdate.Update();

            flag_result = true;           

        }
        catch (Exception ex)
        {
            flag_result = false;
        }
        return flag_result;
    }



    private void DateOfBirth()
    {

    }

    private void Insert_Dependents()
    {

    }
    private void getSubDept()
    {
        DbManager dbManager = new DbManager();


        SqlParameter[] par = {
        new SqlParameter("@Type","1"),
        new SqlParameter("@HospitalId",Session["HospitalID"])
        };


        DataTable dt = dbManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", par);
        DropDownList1.DataSource = dt;
        DropDownList1.DataValueField = "SubDept_Id";
        DropDownList1.DataTextField = "SubDept_Name";
        DropDownList1.DataBind();
    }
    private void getConsultant()
    {
        DbManager dbManager = new DbManager();


        SqlParameter[] par = {
        new SqlParameter("@Dept_type",DropDownList1.SelectedValue),
        new SqlParameter("@HospitalId",Session["HospitalID"])
        };


        DataTable dt = dbManager.ExecuteDataTable("Select_Consultant_By_SubDept", "Basic_Data_ConnectionString", par);
        DropDownList_Employee_name.DataSource = dt;
        DropDownList_Employee_name.DataValueField = "EmpID";
        DropDownList_Employee_name.DataTextField = "Employee Name";
        DropDownList_Employee_name.DataBind();
    }
    public void savePatientVisit()
    {
         string a = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlConnection con = new System.Data.SqlClient.SqlConnection(a);
        System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand("PatientVisitRegistration_FromWalkIn", con);        
        mycommand.CommandType = System.Data.CommandType.StoredProcedure;
        try
        {
            
            mycommand.Parameters.Add("@NewRegNo", SqlDbType.VarChar, 50);
            mycommand.Parameters["@NewRegNo"].Direction = ParameterDirection.Output;

            mycommand.Parameters.AddWithValue("@RegNo", Session["RegistrationNo"]);
           // mycommand.Parameters.AddWithValue("@DateTime", DateTime.Now);
            mycommand.Parameters.AddWithValue("@DeptID", DDLDepartment.SelectedValue);
            mycommand.Parameters.AddWithValue("@Status", "");
            mycommand.Parameters.AddWithValue("@EmpID", EmployeeNo);
            mycommand.Parameters.AddWithValue("@Diagonosis", string.Empty);
            mycommand.Parameters.AddWithValue("@PatientType", ddlPatientType.SelectedValue);
            
            mycommand.Parameters.AddWithValue("@ReferFrom", TextBox_refer_other.Text.Trim());
            mycommand.Parameters.AddWithValue("@to_sub_Dept", DropDownList1.SelectedValue);
            mycommand.Parameters.AddWithValue("@Patient_Type", rblPatientType_Sub.SelectedItem.Text);
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int);
            mycommand.Parameters["@paymentid"].Direction = ParameterDirection.Output;            
            mycommand.Parameters.AddWithValue("@Payment_Status", RadioButtonList_Type.SelectedValue);
            mycommand.Parameters.AddWithValue("@Room_No", TextBox_Room_No.Text.ToString());
            mycommand.Parameters.AddWithValue("@ReferDoctor", TextBox_refer_other.Text.Trim());
	        mycommand.Parameters.AddWithValue("@Hospital_ID", Session["HospitalId"].ToString());
            mycommand.Parameters.AddWithValue("@CheckupType", ddlCheckupType.SelectedValue);

            if (DropDownList1.Visible == false)
            {
                mycommand.Parameters.AddWithValue("@DoctorID", 0);
            }
            else
            {
                mycommand.Parameters.AddWithValue("@DoctorID", DropDownList_Employee_name.SelectedValue);
            }
            if (DropDownList_Parties.Visible == true)
            {
                mycommand.Parameters.AddWithValue("@party_ID", DropDownList_Parties.SelectedValue);
                mycommand.Parameters.AddWithValue("@Party_Desg_ID", Convert.ToDecimal(ddlDesignation.SelectedValue));                              

            }
            else
            {
                mycommand.Parameters.AddWithValue("@party_ID", 0);
                mycommand.Parameters.AddWithValue("@Party_Desg_ID", 0);                           
            }
            mycommand.Parameters.AddWithValue("@NoDiary", 1);
            mycommand.Parameters.AddWithValue("@ReferenceNo", txtReference.Text);
            con.Open();

            mycommand.ExecuteNonQuery();
            
            Session.Add("YearlyNo", mycommand.Parameters["@paymentid"].Value);
            Session.Add("PayId", mycommand.Parameters["@paymentid"].Value);
        }
        catch (Exception ex)
        {
            ;
        }
    }            

    public void patientinsert()
    {
        string a = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
        SqlConnection con = new System.Data.SqlClient.SqlConnection(a);
        //===================================================================
        SqlCommand mycommand_regNo = new SqlCommand("Create_Patient_RegistrationNo", con);

        try
        {
            mycommand_regNo.CommandType = System.Data.CommandType.StoredProcedure;
            mycommand_regNo.Parameters.AddWithValue("@Gender", Convert.ToInt32(sex.SelectedValue));
            mycommand_regNo.Parameters.AddWithValue("@SubDeptID", Session["SubDeptID"].ToString());
            mycommand_regNo.Parameters.AddWithValue("@ProvinceID", 0);
            mycommand_regNo.Parameters.AddWithValue("@HospitalID", Session["HospitalID"].ToString());
            mycommand_regNo.Parameters.Add("@RegNo", SqlDbType.VarChar, 200);
            mycommand_regNo.Parameters["@RegNo"].Direction = ParameterDirection.Output;
            mycommand_regNo.Connection.Open();
            //Response.Write("before ")
            mycommand_regNo.ExecuteNonQuery();
            Pt_Reg_No = mycommand_regNo.Parameters["@RegNo"].Value.ToString();
            //Response.Write("after ")
            
            Pt_Reg_No = Encry.Encrypt_Main(Pt_Reg_No, true);
           HiddenField_Msg_Mr_No.Value = Pt_Reg_No;

            //Response.Write(Pt_Reg_No & " Registration No ")
            mycommand_regNo.Connection.Close();
            // Response.Write(Pt_Reg_No & " regNo")
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + " regNo");
        }


        //========================================================================
        System.Data.SqlClient.SqlCommand mycommand = new System.Data.SqlClient.SqlCommand("PatientRegistration_Card", con);
        // "select RegNo from Patient where (RegNo = @name )", con)
        mycommand.CommandType = System.Data.CommandType.StoredProcedure;

        try
        {
            //if (!string.IsNullOrEmpty(DropDownListCast.SelectedValue))
            //{
            //    HiddenFieldCast.Value = DropDownListCast.SelectedValue;
            //}
            //else
            //{
            //    HiddenFieldCast.Value = TextBoxCast.Text;
            //}
            HiddenFieldCast.Value = "0";
            Encryption ENC = new Encryption();
            HiddenField_msg_Patient_Name.Value = RBLprefix.SelectedItem.Text + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower()).ToString() + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text.ToLower()).ToString() + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text.ToLower()).ToString();


            mycommand.Parameters.AddWithValue("@Prefix", RBLprefix.SelectedItem.Text);
            mycommand.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower()), true));
            //Encrypt_String(textboxpfname.Text, 2))
            mycommand.Parameters.AddWithValue("@PMName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text.ToLower()), true));
            // Encrypt_String(textboxpmname.Text, 2))
            mycommand.Parameters.AddWithValue("@PLName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text.ToLower()), true));
            mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedItem.Text);
            mycommand.Parameters.AddWithValue("@RFName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrfname.Text.ToLower()));
            mycommand.Parameters.AddWithValue("@RMName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrmname.Text.ToLower()));
            mycommand.Parameters.AddWithValue("@RLName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrlname.Text.ToLower()));
            mycommand.Parameters.AddWithValue("@SexID", Convert.ToInt32(sex.SelectedItem.Value));
            mycommand.Parameters.AddWithValue("@Room_No", TextBox_Room_No.Text.ToString());
            //mycommand.Parameters.AddWithValue("@IPD_OPD", ddlPatientType.SelectedItem.Text);
            try
            {
                mycommand.Parameters.AddWithValue("@Age", textboxage.Text);

            }
            catch (Exception ex)
            {
            }
            if (string.IsNullOrEmpty(HiddenField_registration_date.Value))
            {
                HiddenField_registration_date.Value = DateTime.Now.ToString("yyyyMMdd");
            }
            mycommand.Parameters.AddWithValue("@RegDateTime", System.DateTime.Now);
            mycommand.Parameters.AddWithValue("@CountryCode", HiddenField_country.Value);
            // CType(country.SelectedItem.Value, Integer))
            //mycommand.Parameters.AddWithValue("@ProvinceID", Province.SelectedValue);
            mycommand.Parameters.AddWithValue("@ProvinceID", 0);
            //Province.SelectedItem.Value)

            //ehsan chang start
            // mycommand.Parameters.AddWithValue("@DistrictID", district.SelectedValue) 'district.SelectedItem.Value)
            //ehsan chang end
            mycommand.Parameters.AddWithValue("@DistrictID", 0);
            mycommand.Parameters.AddWithValue("@Tehsil", 0);
            //tehsil.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@ZipCode", string.Empty);
            mycommand.Parameters.AddWithValue("@House_No", txtAddress.Text);
            mycommand.Parameters.AddWithValue("@StreetAddress", txtAddress.Text);
            //mycommand.Parameters.AddWithValue("@HouseNo", txtHouseNo.Text)
            //mycommand.Parameters.AddWithValue("@Colony", textboxcolony.Text)
            mycommand.Parameters.AddWithValue("@Colony", "");
            mycommand.Parameters.AddWithValue("@HomePhone", PhPhone);
            mycommand.Parameters.AddWithValue("@MobilePhone", PMP);
            mycommand.Parameters.AddWithValue("@NIC", CNIC);
            mycommand.Parameters.AddWithValue("@HospitalID", Session["HospitalId"]);
            mycommand.Parameters.AddWithValue("@ReferenceNo",txtReference.Text);
            try
            {
                string[] str = null;
                string date_val = null;
                str = WebDateTimeEdit_DOB.Text.Split(new char[] { '/' });
                //date_val = Conversion.Str(1) + "/" + Conversion.Str(0) + "/" + Conversion.Str(2);
                date_val = str[1] + "/" + str[0] + "/" + str[2];
                mycommand.Parameters.AddWithValue("@DateOFBirth", new DateTime(int.Parse(str[2]),int.Parse(str[1]),int.Parse(str[0])).ToString("yyyyMMdd"));
                //' '' ''Response.Write(CDate(date_val))

            }
            catch (Exception ex)
            {
                ShowError(ex.Message);
                return;
            }
            mycommand.Parameters.Add("@NewRegNo", SqlDbType.VarChar, 50);
            mycommand.Parameters["@NewRegNo"].Direction = ParameterDirection.Output;
            mycommand.Parameters.AddWithValue("@RegNo", Pt_Reg_No);
            mycommand.Parameters.AddWithValue("@DateTime", HiddenField_registration_date.Value);
            mycommand.Parameters.AddWithValue("@DeptID", DDLDepartment.SelectedValue);
            //mycommand.Parameters.AddWithValue("@Status", "BMI")
            mycommand.Parameters.AddWithValue("@EmpID", EmployeeNo);
            mycommand.Parameters.AddWithValue("@Diagonosis", string.Empty);

            
            try
            {
                mycommand.Parameters.AddWithValue("@PatientType",ddlPatientType.SelectedValue);

            }
            catch (Exception ex)
            {
            }
            mycommand.Parameters.AddWithValue("@AgeType", DropDownListBIndicator.SelectedValue);
            mycommand.Parameters.AddWithValue("@ReferFrom", TextBox_refer_other.Text.Trim());
            mycommand.Parameters.AddWithValue("@to_sub_Dept", DropDownList1.SelectedValue);
            try
            {
                mycommand.Parameters.AddWithValue("@Patient_Type", rblPatientType_Sub.SelectedItem.Text);

            }
            catch (Exception ex)
            {
            }
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int);
            mycommand.Parameters["@paymentid"].Direction = ParameterDirection.Output;
            mycommand.Parameters.AddWithValue("@pt_Cast", DropDownListBIndicator.SelectedValue);
            mycommand.Parameters.AddWithValue("@Payment_Status", RadioButtonList_Type.SelectedValue);
            mycommand.Parameters.AddWithValue("@Passport_No", string.Empty);
            mycommand.Parameters.AddWithValue("@CheckupType", ddlCheckupType.SelectedValue);
            try
            {
                mycommand.Parameters.AddWithValue("@Email_address", txtEmailAddress.Text.Trim());

            }
            catch (Exception ex)
            {
            }
            if (DropDownList1.Visible == false)
            {
                mycommand.Parameters.AddWithValue("@DoctorID", 0);
            }
            else
            {
                mycommand.Parameters.AddWithValue("@DoctorID", DropDownList_Employee_name.SelectedValue);
            }


            try
            {
                mycommand.Parameters.AddWithValue("@Religion", DropDownList_Religion.SelectedValue);
                mycommand.Parameters.AddWithValue("@Nationality", DropDownList_Nationality.SelectedValue);
              //  mycommand.Parameters.AddWithValue("@ReferenceNo", txtReference.Text);

            }
            catch (Exception ex)
            {
            }



            try
            {
                if (DropDownList_Parties.Visible == true)
                {
                    mycommand.Parameters.AddWithValue("@party_ID", DropDownList_Parties.SelectedValue);
                    mycommand.Parameters.AddWithValue("@Party_Desg_ID", Convert.ToDecimal(ddlDesignation.SelectedValue));
                    mycommand.Parameters.AddWithValue("@RegistrationType", rblRegistrationType.SelectedValue);
                    mycommand.Parameters.AddWithValue("@Emp_No", txtEmployeeNo.Text);

                }
                else
                {
                    mycommand.Parameters.AddWithValue("@party_ID", 0);
                    mycommand.Parameters.AddWithValue("@Party_Desg_ID", 0);
                    mycommand.Parameters.AddWithValue("@RegistrationType", "");
                    mycommand.Parameters.AddWithValue("@Emp_No", "");
                }

            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }



            try
            {
                Linear barcode = new Linear();
                barcode.Type = BarcodeType.CODE39;

                barcode.Data =ENC.Encrypt_Main( HiddenField_Msg_Mr_No.Value,false);
                barcode.ShowText = false;
                byte[] b = new byte[barcode.drawBarcodeAsBytes().Length + 1];
                b = barcode.drawBarcodeAsBytes();

                mycommand.Parameters.AddWithValue("@barcode", b);

            }
            catch (Exception ex)
            {
            }
            try
            {
                mycommand.Parameters.AddWithValue("@NoDiary", 1);              
            }
            catch (Exception ex)
            {
            }

            //mycommand.Parameters.AddWithValue("@Reg", Pt_Reg_No)
            //==================================== @to_sub_Dept'
            try
            {
                con.Open();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            PatientName = System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text) + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text) + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text);
            Session.Add("patientname", PatientName);
            //Response.Write(" Before Execute")

            mycommand.ExecuteNonQuery();
            ///'''''''''''''
            daEmpTemp.UpdateFinger(fingerPrint, Pt_Reg_No);
            daEmpTemp.DeleteEmpTemp();

            //textboxpfname.Text = "";
            //textboxplname.Text = "";
            //textboxrfname.Text = "";
            //textboxrmname.Text = "";
            //textboxrlname.Text = "";
            //textboxstreetaddress.Text = "";
            //textboxage.Text = "";
            //txtEmployeeNo.Text = "";
            ///'''''''''''''''
            // Dim PayID As String = mycommand.Parameters("@paymentid").Value
            string abc = mycommand.Parameters["@NewRegNo"].Value.ToString();
            //param1.Value
            //Response.Write(abc & "imran")
            Session.Add("YearlyNo", mycommand.Parameters["@paymentid"].Value);
            Session.Add("PayId", mycommand.Parameters["@paymentid"].Value);

            Session.Add("RegistrationNo", Pt_Reg_No);
            HiddenField_RegistrationNo.Value = abc;
            classobj.save_image(Panel1, a, abc);
            //If ab <> 0 Then
            Session.Add("PRegNoForDetail", abc);
            //Session.Add("BMIPayID", ab)
            //Else
            //Session.Add("PRegNoForDetail", abc)
            //End If
            //Response.Write(Session("YearlyNo") + Session("RegistrationNo"))
            con.Close();
            //reset2();

            ///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


            try
            {
                FileStream fs1 = new FileStream(Session["File_Path"].ToString() + Session["fileName"].ToString(), FileMode.Open);

                SqlDataReader reader = default(SqlDataReader);

                SqlConnection conn = new SqlConnection();
                conn.ConnectionString = ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString;
                string SQL = "update [Patient] set [picture]= @picture where RegNo='" + Session["RegistrationNo"].ToString() + "'";
                SqlCommand myCommand1 = new SqlCommand(SQL, conn);
                byte[] b = new byte[fs1.Length + 1];
                fs1.Read(b, 0, (int)fs1.Length);
                myCommand1.Parameters.AddWithValue("@picture", b);
                conn.Open();
                myCommand1.ExecuteNonQuery();
                conn.Close();

            }
            catch (Exception ex)
            {
            }
        }
        catch (Exception ex)
        {
            ShowError(ex.Message);
            //Response.Redirect("login.aspx")
            //Response.Write(ex.Message & "Insert main")
        }




        ///changed by Jam
        ///'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        //flag will tell that info should insert or not.


        if (flag == 1)
        {



            string a1 = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            SqlConnection con1 = new System.Data.SqlClient.SqlConnection(a);
            //===================================================================
            SqlCommand mycommand_regNo1 = new SqlCommand("panel_emp_patients", con);
            try
            {
                ///Pt_Reg_No
                ///partyid
                /// 
                mycommand_regNo.CommandType = System.Data.CommandType.StoredProcedure;
                //mycommand_regNo.Parameters.AddWithValue("@Gender", Convert.ToInt32(sex.SelectedValue))
                //mycommand_regNo.Parameters.AddWithValue("@SubDeptID", Convert.ToInt32(DropDownList1.SelectedValue))
                //mycommand_regNo.Parameters.AddWithValue("@ProvinceID", Convert.ToInt32(Province.SelectedValue))
                //mycommand_regNo.Parameters.AddWithValue("@HospitalID", 1)
                mycommand_regNo.Parameters.Add("@RegNo", SqlDbType.VarChar, 100);
                //mycommand_regNo.Parameters("@RegNo").Direction = ParameterDirection.Output
                mycommand_regNo.Connection.Open();

                mycommand_regNo.ExecuteNonQuery();

                mycommand_regNo.Connection.Close();
                // Response.Write(Pt_Reg_No & " regNo")

            }
            catch (Exception ex)
            {
                // Response.Write(ex.Message & " regNo")
            }


        }

    }

    private void ShowError(string msg)
    {
        lblErrorMsg.Text = msg;
    }
    protected void lnkRegNo_Click(object sender, System.EventArgs e)
    {
        try
        {
            LinkButton btn = (LinkButton)sender;

            hfRegNo.Value = btn.CommandArgument;
            txtRegistrationNo.Text = hfRegNo.Value.Trim();

            Search_Patient();
            Label3.Text = String.Empty;
        }
        catch (Exception ex) { }
    }
    private void SearchByMobileNo(string n)
    {
        DataTable dt = new DataTable();
        try
        {

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand("usp_GetPatientByMobileNo", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@MobileNo", TextBoxMobile.Text);

                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }

                }
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            gvdPatient.DataSource = dt;
            gvdPatient.DataBind();
            divRegistration.Visible = true;
            TextBoxMobile.Text = "";
        }
       
    }
    protected void btnRegistrationSearch_Click(object sender, EventArgs e)
    {
        {
            lblMsg.Text = "";
            if (TextBoxMobile.Text != "" && TextBoxMobile.Text.Length == 11)
            {

                SearchByMobileNo(TextBoxMobile.Text.Trim());
                DisabledFields();

            }

            else
            {
                if (txtRegistrationNo.Text.Length > 11 || txtRegistrationNo.Text.Length == 10)
                {
                    Search_Patient();
                    DisabledFields();
                    Label3.Text = string.Empty;
                }

                else
                {
                    Label3.Text = "Please Enter Valid MR No";

                }
            }


        }

        
    }
    protected void DisabledFields()
    {
        textboxpfname.Enabled = false;
        textboxpmname.Enabled = false;
        textboxplname.Enabled = false;
        WebDateTimeEdit_DOB.Enabled = true;
        textboxage.Enabled = true;
        DropDownListBIndicator.Enabled = false;
        textboxrmname.Enabled = false;
        RBLrelation.Enabled = false;
        textboxrfname.Enabled = false;
        textboxrlname.Enabled = false;
        sex.Enabled = true;
        ddlPatientType.Enabled = false;

       
    }

    void Search_Patient()
    {

        
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Reg_ConnectionString"].ConnectionString);
        SqlCommand cmd = new SqlCommand("usp_searchPatient", con);
        cmd.CommandType = CommandType.StoredProcedure;

        //string id = ENC.Encrypt_Main("281239169015036036036043085050", false);
        cmd.Parameters.AddWithValue("@regNo", ENC.Encrypt_Main(txtRegistrationNo.Text.Trim(), true));
        try
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            string cnic = string.Empty;

            if (dt != null && dt.Rows.Count > 0)
            {
                HiddenField_RegistrationNo.Value = Convert.ToString(dt.Rows[0]["RegNo"]);
                // = Convert.ToString(ENC.Encrypt_Main(Convert.ToString(dt.Rows[0]["RegNo"]), true));
               Session.Add("RegistrationNo",Convert.ToString(dt.Rows[0]["RegNo"]));
               //Session.Add("YearlyNo", Convert.ToString(dt.Rows[0]["PayID"]));
               //Session.Add("PayID", Convert.ToString(dt.Rows[0]["PayID"]));
                RBLprefix.SelectedItem.Text = Convert.ToString(dt.Rows[0]["Prefix"]);
                textboxpfname.Text = Convert.ToString(ENC.Encrypt_Main(Convert.ToString(dt.Rows[0]["PFName"]), false));
                textboxpmname.Text = Convert.ToString(ENC.Encrypt_Main(Convert.ToString(dt.Rows[0]["PMName"]), false));
                textboxplname.Text = Convert.ToString(ENC.Encrypt_Main(Convert.ToString(dt.Rows[0]["PLName"]), false));
                WebDateTimeEdit_DOB.Value = Convert.ToDateTime(dt.Rows[0]["DateOfBirth"]).ToString("dd/MM/yyyy");
                textboxage.Text = dt.Rows[0]["age"].ToString();
                sex.SelectedValue = Convert.ToString(dt.Rows[0]["SexID"]);
                textboxmcode.Text = Convert.ToString(dt.Rows[0]["MobilePhone"]);
                cnic = Convert.ToString(dt.Rows[0]["CNIC"]);
                txtEmailAddress.Text = Convert.ToString(dt.Rows[0]["email_Address"]);
                if (cnic.Length > 0)
                {
                    TextBox_CNIC_No.Text = cnic.Substring(0, 5) + "-" + cnic.Substring(5, 7) + "-" + cnic.Substring(12, 1);
                }
                try
                {
                    DropDownList_Religion.SelectedValue = Convert.ToString(dt.Rows[0]["Religion"]);
                }
                catch (Exception)
                {

                    DropDownList_Religion.SelectedIndex = 0;
                }
                try
                {
                    DropDownList_Nationality.SelectedValue = Convert.ToString(dt.Rows[0]["Nationality"]).Trim();
                }
                catch (Exception)
                {

                    DropDownList_Nationality.SelectedIndex = 0;
                }

                try
                {
                    RBLrelation.SelectedValue = Convert.ToString(dt.Rows[0]["Relation"]).Trim();
                }
                catch (Exception)
                {

                    RBLrelation.SelectedIndex = 0;
                }


                textboxrfname.Text = Convert.ToString(dt.Rows[0]["RFName"]);
                textboxrmname.Text = Convert.ToString(dt.Rows[0]["RMName"]);
                textboxrlname.Text = Convert.ToString(dt.Rows[0]["RLName"]);
                TextBox_refer_other.Text = Convert.ToString(dt.Rows[0]["ReferFrom"]);
                txtAddress.Text = Convert.ToString(dt.Rows[0]["StreetAddress"]);
                //DDLDepartment.SelectedValue = Convert.ToString(dt.Rows[0]["DeptID"]);
                //DropDownList1.DataBind();
                DropDownList1.SelectedValue = Convert.ToString(dt.Rows[0]["SubDept_id"]);
                               
                getConsultant();
                //DropDownList_Employee_name.Items.Insert(0, new ListItem("", "0"));
                DropDownList_Employee_name.SelectedValue = Convert.ToString(dt.Rows[0]["DoctorID"]);
                rblPatientType_Sub.Items.FindByText(Convert.ToString(dt.Rows[0]["Patient_Type"])).Selected = true;
                ddlPatientType.SelectedValue = Convert.ToString(dt.Rows[0]["Patient_IPD_OPD"]);
                HiddenField_UpdateRegNo.Value = ENC.Encrypt_Main(txtRegistrationNo.Text.Trim(), true);
                HiddenField_IsUpdate.Value = "1";
            }
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = ex.Message;
        }
        finally
        {
            cmd.Dispose();
            con.Close();
        }
    }

    protected void textboxrlname_TextChanged(object sender, EventArgs e)
    {

    }

    //protected void btnSearchService_Click(object sender, EventArgs e)
    //{
    //    SqlDataSource_For_Grid.SelectParameters["S_Name"].DefaultValue = '%' + TextBox_Search_Service.Text + '%';
    //    SqlDataSource_For_Grid.SelectParameters["S_Category"].DefaultValue = DropDownList2.SelectedValue;
    //    SqlDataSource_For_Grid.SelectParameters["Reg_No"].DefaultValue = "0";
    //    SqlDataSource_For_Grid.SelectParameters["Yearly_No"].DefaultValue = "0";
    //    SqlDataSource_For_Grid.SelectParameters["ASP_ID"].DefaultValue = "0";
    //    SqlDataSource_For_Grid.SelectParameters["Hospital_Id"].DefaultValue = Session["HospitalId"].ToString();
    //    SqlDataSource_For_Grid.SelectParameters["Patient_Type_Id"].DefaultValue = rblPatientType_Sub.SelectedValue;
    //    SqlDataSource_For_Grid.SelectParameters["IPD_OPD"].DefaultValue = "IPD";
    //    SqlDataSource_For_Grid.SelectParameters["Billing_Party_Id"].DefaultValue = "0";

    //    //GridView2.DataBind();
    //    DataListServices.DataBind();
    //    DataListServices.Visible = true;
    //    //repeaterServices.DataBind();
    //}
    protected void btnSearchTest_Click(object sender, EventArgs e)
    {
        Search_Services();
    }
    protected void Search_Services()
    {
        SqlDataSource_For_Grid.SelectParameters["S_Name"].DefaultValue = '%' + TextBox_Search_Service.Text + '%';
        SqlDataSource_For_Grid.SelectParameters["S_Category"].DefaultValue = DropDownList2.SelectedValue;
        SqlDataSource_For_Grid.SelectParameters["Reg_No"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["Yearly_No"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["ASP_ID"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["Hospital_Id"].DefaultValue = Session["HospitalId"].ToString();
        SqlDataSource_For_Grid.SelectParameters["Patient_Type_Id"].DefaultValue = rblPatientType_Sub.SelectedValue;
        SqlDataSource_For_Grid.SelectParameters["IPD_OPD"].DefaultValue = "IPD";
        SqlDataSource_For_Grid.SelectParameters["Billing_Party_Id"].DefaultValue = DropDownList_Parties.SelectedValue;

        //GridView2.DataBind();
        DataListServices.DataBind();
        DataListServices.Visible = true;
        //repeaterServices.DataBind();
    }
    
    protected void SqlDataSource_For_Grid_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
    {
        int x = 100;
    }

    protected void SqlDataSource_For_Grid_Selected(object sender, SqlDataSourceStatusEventArgs e)
    {
        int x = 100;
    }


    protected void TextBox_Search_Service_TextChanged(object sender, EventArgs e)
    {
        Search_Services();
    }
    protected void btn_Refresh_Click(object sender, EventArgs e)
    {
        ClearData();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {        
        getConsultant();
        DropDownList1.Focus();
    }


    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Search_Services();
        
    }
    protected void DropDownList_Parties_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataListServices.DataBind();
        Search_Services();
    }
}
