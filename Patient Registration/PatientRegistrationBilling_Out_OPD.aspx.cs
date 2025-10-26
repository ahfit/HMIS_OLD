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
using System.Text;

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
        if (Session["emp_id"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }
        else
        {
            EmployeeNo = int.Parse(Session["emp_id"].ToString());
        }
        if (!Page.IsPostBack)
        {
 
            CheckBoxListRoom.DataBind();

            textboxage.Attributes.Add("OnBlur", "showAgedob(this)");
            DropDownListBIndicator.Attributes.Add("onChange", "changeYear()");
            textboxage.Attributes.Add("OnFocus", "showAgedobfocus(this)");
            //Session.Remove("YearlyNo");
            //Session.Remove("PayId");
            //Session.Remove("RegistrationNo");
            //Session.Remove("RegNo");
            rblPatientType_Sub.DataBind();
            if (rblPatientType_Sub.Items.Count > 0)
                rblPatientType_Sub.SelectedValue = "1";
            WebDateChooser1.Value = DateTime.Now;
            SetServiceForm(false, false);
            BindServicesGrid();
            HiddenField_IsUpdate.Value = "0";
           // txtRegistrationNo.Focus();
            //pnlAddServices.Visible = false;
            rblPatientType_Sub.Visible = false;
            textboxpfname.Focus();
            DDLDepartment.DataBind();
            DDLDepartment.SelectedValue = "66";

            DropDownList1.DataBind();
            DropDownList1.SelectedValue = "84";
            
            divRoom.Visible = true;
            //DropDownList1.DataBind();
            radiobtnListPatientType.DataBind();
            DropDownList_Employee_name.DataBind();

        }
        //DropDownList_Employee_name.Items.Insert(0, new ListItem("Doctor_id","0"));
        //RBLrelation.Attributes.Add("OnClick", "radio1()");
        
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

   
    protected void rblPatientType_Sub_SelectedIndexChanged(Object sender, System.EventArgs e)
    {
        //rblPatientType_Sub.
       // LoadPatientPanel();
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
                    DropDownList_Parties.Items.Insert(0, new ListItem(" Select Party ", "0"));
                    DropDownList_Parties.SelectedIndex = 0;
                }
                else
                {
                    td_Insurer.Visible = false;
                    td_Employee_Designation.Visible = false;
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
        HiddenField hfld1 = null, hfld2 = null;
        TextBox txtAmount = null;
        int serviceId = 0;

        if (lnkTemp != null)
        {
            serviceId = int.Parse(lnkTemp.CommandArgument);
            DataListItem itm = lnkTemp.NamingContainer as DataListItem;
            if (itm != null)
            {
                hfld1 = itm.FindControl("hfldEdit_Status") as HiddenField;
                hfld2 = itm.FindControl("hfldS_Category") as HiddenField;
                txtAmount = itm.FindControl("TextBox_Amount") as TextBox;
            }
        }

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

        if (DropDownList1.SelectedValue == "0")
        {
            LbL_Mg.Text = "Please Select First Department";
            DropDownList1.Focus();
        }
        else
        {
            try
            {
                main();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error occurred in Patient Registration";
            }
            if (!string.IsNullOrEmpty(HiddenField_RegistrationNo.Value) && GridView_Date_Wise.Rows.Count > 0)
            {
                try
                {
                    SavePatientServices();
                }
                catch (Exception ex)
                {
                    lblErrorMsg.Text = "Error occurred in saving Patient Services";
                }
                //if (Session["RegistrationNo"] == null) return;
                Session.Add("RegistrationNo", Session["RegistrationNo"].ToString());
                Session.Add("YearlyNo", Session["PayId"].ToString());
                Session.Add("PatientType", "Routine");
                Session.Remove("PatientServices");
                //Response.Redirect("~/Patient Billing/Indoor_Patient_Paymen.aspx?regno=" + Session["RegistrationNo"].ToString() + "&payid=" + Session["PayId"].ToString());

            }
            try
            {
                foreach (ListItem list in CheckBoxListRoom.Items)
                {
                    if (list.Selected)
                    {
                        int bedid = Get_Bed_Id(CheckBoxListRoom.SelectedValue, 62);
                        insert_bed(62, bedid);
                        //SqlDataSource_Update.UpdateParameters["ward_Id"].DefaultValue = "96";
                        //SqlDataSource_Update.UpdateParameters["Bed_ID"].DefaultValue = bedid.ToString();
                        //SqlDataSource_Update.Update();
                    }
                }
                hdnBedId.Value = "";
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error occurred in assigning Bed";
            }
            CheckBoxListRoom.DataBind();
            Session.Remove("PatientServices");
            ClearData();
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
            //lblErrorMsg.Text = ex.Message+"MSG";
        }

    }

    private void ClearData()
    {
        txtRegistrationNo.Text = string.Empty;
        textboxpfname.Text = string.Empty;
        WebDateTimeEdit_DOB.Value = string.Empty;
        sex.SelectedIndex = -1;
        textboxmcode.Text = string.Empty;
        RBLrelation.SelectedIndex = 0;
        textboxrfname.Text = string.Empty;
        DDLDepartment.DataBind();
        DDLDepartment.SelectedValue ="66" ;
        
        DropDownList1.DataBind();
        DropDownList1.SelectedValue = "84";
        DropDownList_Employee_name.SelectedIndex = -1;
        rblPatientType_Sub.SelectedIndex = 0;
        txtAddress.Text = string.Empty;
        TextBoxDiagnosis.Text = "";
        textboxage.Text = string.Empty;
        List<ApplicationDTO.PatientServicesBillingDTO> services = null;
        GridView_Date_Wise.DataSource = services;
        preRenderRequired = false;
        GridView_Date_Wise.DataBind();
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
                SqlDataSource2.InsertParameters["empid"].DefaultValue = Session["Emp_ID"].ToString();
                SqlDataSource2.InsertParameters["Amount"].DefaultValue = lblAmount.Text;
                SqlDataSource2.InsertParameters["Payment_Status"].DefaultValue = "0";
                SqlDataSource2.InsertParameters["SubDept_ID"].DefaultValue = Session["SubDeptID"].ToString();
                SqlDataSource2.InsertParameters["Dept_ID"].DefaultValue = Session["dept_id"].ToString();
                SqlDataSource2.InsertParameters["sdatetime"].DefaultValue = HiddenFieldServiceDateTime.Value;
                SqlDataSource2.InsertParameters["Qty"].DefaultValue = HiddenFieldQty.Value;
                SqlDataSource2.InsertParameters["Refer_By_ID"].DefaultValue = "0";
                SqlDataSource2.InsertParameters["Refer_From_Other"].DefaultValue = "";
                SqlDataSource2.InsertParameters["S_ID"].DefaultValue = HiddenFieldServiceId.Value;
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
                    POPUP_Meg = Pt_Reg_No+" Patient save successfully...";
                    //Response.Redirect("./Patient Registration/EmergencySlip.aspx?MR=" + Session["RegistrationNo"].ToString() + "&PN=" + Session["patientname"].ToString() + "");                    
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
            lblErrorMsg.Text = "Some error occurred.";
        }
        HiddenField_IsUpdate.Value = "0";
    }

    private bool SavePatientRecord()
    {
        bool isSaved = false;
        CNIC = "";
        if (!string.IsNullOrEmpty(textboxpfname.Text))
        {
            patientinsert();
            isSaved = true;
        }
        return isSaved;
    }

    private bool UpdatePatientRecord()
    {
        bool flag_result = false;
        
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
        HiddenFieldPMName.Value = "";
        HiddenFieldPLName.Value = "";
        HiddenField_PatientTYpeName.Value = rblPatientType_Sub.SelectedItem.Text;
        //HiddenField_phone_no.Value = textboxphoneno.Text;
        HiddenField_mobile_no.Value = textboxmcode.Text;
        HiddenField_cnic.Value = "";
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
            mycommand.Parameters.AddWithValue("@Diagonosis", TextBoxDiagnosis.Text);
            mycommand.Parameters.AddWithValue("@PatientType", ddlPatientType.SelectedValue);
            mycommand.Parameters.AddWithValue("@ReferFrom", string.Empty);
            mycommand.Parameters.AddWithValue("@to_sub_Dept", DropDownList1.SelectedValue);
            mycommand.Parameters.AddWithValue("@Patient_Type", rblPatientType_Sub.SelectedItem.Text);
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int);
            mycommand.Parameters["@paymentid"].Direction = ParameterDirection.Output;            
            mycommand.Parameters.AddWithValue("@Payment_Status", "Paid");
            mycommand.Parameters.AddWithValue("@Room_No","");
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
            mycommand_regNo.ExecuteNonQuery();
            Pt_Reg_No = mycommand_regNo.Parameters["@RegNo"].Value.ToString();
            
            Pt_Reg_No = Encry.Encrypt_Main(Pt_Reg_No, true);
           HiddenField_Msg_Mr_No.Value = Pt_Reg_No;
            
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

            HiddenFieldCast.Value = "0";
            Encryption ENC = new Encryption();
            HiddenField_msg_Patient_Name.Value = System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower()).ToString();


            mycommand.Parameters.AddWithValue("@Prefix", "");
            mycommand.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower()), true));
            mycommand.Parameters.AddWithValue("@PMName", "");
            mycommand.Parameters.AddWithValue("@PLName", "");
            mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedItem.Text);
            mycommand.Parameters.AddWithValue("@RFName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrfname.Text.ToLower()));
            mycommand.Parameters.AddWithValue("@RMName", "");
            mycommand.Parameters.AddWithValue("@RLName", "");
            mycommand.Parameters.AddWithValue("@SexID", Convert.ToInt32(sex.SelectedItem.Value));
            mycommand.Parameters.AddWithValue("@Room_No", "");
            mycommand.Parameters.AddWithValue("@Age", textboxage.Text);

            HiddenField_registration_date.Value = DateTime.Now.ToString("yyyyMMdd");

            mycommand.Parameters.AddWithValue("@RegDateTime", System.DateTime.Now);
            mycommand.Parameters.AddWithValue("@CountryCode", HiddenField_country.Value);
            mycommand.Parameters.AddWithValue("@ProvinceID", 0);
            mycommand.Parameters.AddWithValue("@DistrictID", 0);
            mycommand.Parameters.AddWithValue("@Tehsil", 0);
            mycommand.Parameters.AddWithValue("@ZipCode", string.Empty);
            mycommand.Parameters.AddWithValue("@House_No", txtAddress.Text);
            mycommand.Parameters.AddWithValue("@StreetAddress", txtAddress.Text);
            mycommand.Parameters.AddWithValue("@Colony", "");
            mycommand.Parameters.AddWithValue("@HomePhone", PhPhone);
            mycommand.Parameters.AddWithValue("@MobilePhone", PMP);
            mycommand.Parameters.AddWithValue("@NIC", CNIC);
            mycommand.Parameters.AddWithValue("@HospitalID", Session["HospitalId"]);
            mycommand.Parameters.AddWithValue("@ReferenceNo", txtReference.Text);

            try
            {
                string[] str = null;
                string date_val = null;
                str = WebDateTimeEdit_DOB.Text.Split(new char[] { '/' });
                //date_val = Conversion.Str(1) + "/" + Conversion.Str(0) + "/" + Conversion.Str(2);
                date_val = str[1] + "/" + str[0] + "/" + str[2];
                mycommand.Parameters.AddWithValue("@DateOFBirth", new DateTime(int.Parse(str[2]), int.Parse(str[1]), int.Parse(str[0])).ToString("yyyyMMdd"));
                //' '' ''Response.Write(CDate(date_val))

            }
            catch (Exception ex)
            {
                //ShowError(ex.Message);
                return;
            }

            mycommand.Parameters.Add("@NewRegNo", SqlDbType.VarChar, 50);
            mycommand.Parameters["@NewRegNo"].Direction = ParameterDirection.Output;
            mycommand.Parameters.AddWithValue("@RegNo", Pt_Reg_No);
            mycommand.Parameters.AddWithValue("@DateTime", HiddenField_registration_date.Value);
            mycommand.Parameters.AddWithValue("@DeptID", DDLDepartment.SelectedValue);
            mycommand.Parameters.AddWithValue("@EmpID", EmployeeNo);
            mycommand.Parameters.AddWithValue("@Diagonosis", TextBoxDiagnosis.Text);
            mycommand.Parameters.AddWithValue("@PatientType", ddlPatientType.SelectedValue);
            mycommand.Parameters.AddWithValue("@AgeType", DropDownListBIndicator.SelectedValue);
            mycommand.Parameters.AddWithValue("@ReferFrom", string.Empty);
            mycommand.Parameters.AddWithValue("@to_sub_Dept", DropDownList1.SelectedValue);
            mycommand.Parameters.AddWithValue("@Patient_Type", rblPatientType_Sub.SelectedItem.Text);
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int);
            mycommand.Parameters["@paymentid"].Direction = ParameterDirection.Output;
            mycommand.Parameters.AddWithValue("@pt_Cast", DropDownListBIndicator.SelectedValue);
            mycommand.Parameters.AddWithValue("@Payment_Status", "Paid");
            mycommand.Parameters.AddWithValue("@Passport_No", string.Empty);
            mycommand.Parameters.AddWithValue("@Email_address", string.Empty);
            mycommand.Parameters.AddWithValue("@DoctorID", 0);
            mycommand.Parameters.AddWithValue("@Religion", 0);
            mycommand.Parameters.AddWithValue("@Nationality", 0);

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

          //  mycommand.Parameters.AddWithValue("@barcode", null);
            mycommand.Parameters.AddWithValue("@NoDiary", 1);
          mycommand.Parameters.AddWithValue("@barcode", new byte[0]);
            
            try
            {
                con.Open();
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }

            PatientName = System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text);
            Session.Add("patientname", PatientName);
            mycommand.ExecuteNonQuery();

            
            string abc = mycommand.Parameters["@NewRegNo"].Value.ToString();
            Session.Add("RegistrationNo", abc);
            Session.Add("YearlyNo", mycommand.Parameters["@paymentid"].Value);
            Session.Add("PayId", mycommand.Parameters["@paymentid"].Value);

            Session.Add("RegistrationNopatientname", Pt_Reg_No);
            HiddenField_RegistrationNo.Value = abc;
            Session.Add("PRegNoForDetail", abc);
            con.Close();
            
            //if (flag == 1)
            //{
            //    string a1 = ConfigurationManager.ConnectionStrings["PatientBilllingConnectionString"].ConnectionString;
            //    SqlConnection con1 = new System.Data.SqlClient.SqlConnection(a);
            //    //===================================================================
            //    SqlCommand mycommand_regNo1 = new SqlCommand("panel_emp_patients", con);
            //    try
            //    {                    
            //        mycommand_regNo.CommandType = System.Data.CommandType.StoredProcedure;                   
            //        mycommand_regNo.Parameters.Add("@RegNo", SqlDbType.VarChar, 100);                    
            //        mycommand_regNo.Connection.Open();
            //        mycommand_regNo.ExecuteNonQuery();
            //        mycommand_regNo.Connection.Close();                    
            //    }
            //    catch (Exception ex)
            //    {                    
            //    }
            //}
        }
        catch (Exception ex)
        {
        }
    }

    private void ShowError(string msg)
    {
        lblErrorMsg.Text = msg;
    }

    protected void btnRegistrationSearch_Click(object sender, EventArgs e)
    {
        if (txtRegistrationNo.Text.Length < 12)
        {
            Label3.Text = "Please Enter Valid MR No";
        }

        else
        {
            Search_Patient();
            Label3.Text = string.Empty;
        }
        
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
                textboxpfname.Text = Convert.ToString(ENC.Encrypt_Main(Convert.ToString(dt.Rows[0]["PFName"]), false));
                WebDateTimeEdit_DOB.Value = Convert.ToDateTime(dt.Rows[0]["DateOfBirth"]).ToString("dd/MM/yyyy");
                textboxage.Text = dt.Rows[0]["age"].ToString();
                sex.SelectedValue = Convert.ToString(dt.Rows[0]["SexID"]);
                textboxmcode.Text = Convert.ToString(dt.Rows[0]["MobilePhone"]);
                
               
                try
                {
                    RBLrelation.SelectedValue = Convert.ToString(dt.Rows[0]["Relation"]).Trim();
                }
                catch (Exception)
                {

                    RBLrelation.SelectedIndex = 0;
                }


                textboxrfname.Text = Convert.ToString(dt.Rows[0]["RFName"]);
                txtAddress.Text = Convert.ToString(dt.Rows[0]["StreetAddress"]);
                //DDLDepartment.SelectedValue = Convert.ToString(dt.Rows[0]["DeptID"]);
                DropDownList1.DataBind();
                DropDownList1.SelectedValue = Convert.ToString(dt.Rows[0]["SubDept_id"]);
               
                DropDownList_Employee_name.DataBind();
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
        
     //   Search_Services();
    }
    protected  void Search_Services()
    {
        SqlDataSource_For_Grid.SelectParameters["S_Name"].DefaultValue = '%' + TextBox_Search_Service.Text + '%';
        SqlDataSource_For_Grid.SelectParameters["S_Category"].DefaultValue = DropDownList2.SelectedValue;
        SqlDataSource_For_Grid.SelectParameters["Reg_No"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["Yearly_No"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["ASP_ID"].DefaultValue = "0";
        SqlDataSource_For_Grid.SelectParameters["Hospital_Id"].DefaultValue = Session["HospitalId"].ToString();
        SqlDataSource_For_Grid.SelectParameters["Patient_Type_Id"].DefaultValue = rblPatientType_Sub.SelectedValue;
        SqlDataSource_For_Grid.SelectParameters["IPD_OPD"].DefaultValue = "IPD";
        SqlDataSource_For_Grid.SelectParameters["Billing_Party_Id"].DefaultValue = "0";

        //GridView2.DataBind();
        //DataListServices.DataBind();
        //DataListServices.Visible = true;
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

        if (TextBox_Search_Service.Text !=string.Empty)
        {
            loadServices();
        }
        TextBox_Search_Service.Text = "";
        hfNameId.Value = "";
        
    }
    protected void btn_Refresh_Click(object sender, EventArgs e)
    {
        ClearData();
    }

    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {


        CheckBoxListRoom.DataBind();
        DropDownList_Employee_name.DataBind();
        DropDownList1.Focus();
    }


    protected void DDLDepartment_SelectedIndexChanged(object sender, EventArgs e)
    {

        DropDownList1.DataBind();
        hdfTabindexCnt.Value ="1";

        if (DDLDepartment.SelectedItem.Text == "EMERGENCY")
        {
            CheckBoxListRoom.DataBind();
            divRoom.Visible = true;

        }
        else
        {
            divRoom.Visible = false;
        }


    }
    protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
    {
        //DataListServices.DataBind();

        Auto_Names_Extender.UseContextKey = true;
        Auto_Names_Extender.ContextKey = DropDownList2.SelectedValue;
    }
    protected void btnAddServices_Click(object sender, EventArgs e)
    {
        pnlServices.Visible = true;
        panelServices.Visible=true;
        //DataListServices.Visible = true;
        //DataListServices.DataBind();

        GridView_Date_Wise.DataBind();
    }
    protected void btnClose_Click(object sender, EventArgs e)
    {
        panelServices.Visible = false;
        pnlServices.Visible = false;
    }



    [System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()]
    public static List<string> SearchNames(string prefixText, int count, string contextKey)
    {
        List<string> customers = new List<string>();
        SqlConnection conn = new SqlConnection();
        conn.ConnectionString = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
        SqlCommand cmd = new SqlCommand();
        cmd.CommandText = "get_Services_For_Registration";
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@S_Name", prefixText);
        cmd.Parameters.AddWithValue("@S_Category", contextKey);
        cmd.Connection = conn;
        conn.Open();
        SqlDataReader sdr = cmd.ExecuteReader();
        while (sdr.Read())
        {
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr["S_Name"].ToString() + "  (" + sdr["S_Amount"].ToString() + ")", (sdr["S_ID"].ToString()+","+sdr["S_Amount"].ToString()+","+sdr["Edit_Status"]+","+sdr["S_Category"])));
        }
        return customers;
    }






    private void loadServices() {
      
        int serviceId = 0;
        string hfld1 = "", hfld2 = "";
            string txtAmount = "";




            if (!(string.IsNullOrEmpty(hfNameId.Value)))
            {

                string[] str = hfNameId.Value.Split(',');

                serviceId = int.Parse(str[0].ToString());
                txtAmount = str[1].ToString();
                hfld1 = str[2].ToString();
                hfld2 = str[3].ToString();


                //hfld1.Value = "1";
                //hfld2 = itm.FindControl("hfldS_Category") as HiddenField;
                //txtAmount = itm.FindControl("TextBox_Amount") as TextBox;



                ApplicationDTO.PatientServicesBillingDTO service = new ApplicationDTO.PatientServicesBillingDTO();
                service.ServiceID = serviceId;
                service.ServiceDateTime = DateTime.Now;
                service.ServiceName = TextBox_Search_Service.Text;
                service.ServiceCharges = (txtAmount == "" ? 0 : decimal.Parse(txtAmount));
                service.EditStatus = (hfld1 == "" ? false : bool.Parse(hfld1));
                service.Category = (hfld2 == "" ? 0 : int.Parse(hfld2));
                service.Payment_Status = 0;
                service.ID = 0;
                service.Doctor_ID = 0;
                service.Qty = 1;
                SaveServiceInSession(service);
                BindServicesGrid();
                ShowMessage("Service " + service.ServiceName + " added successfully.", false);
            }
    }



    public int Get_Bed_Id(string Bed_No, int ward_id)
    {
        int bed_id = 0;
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
            SqlConnection con_bed = new SqlConnection(constr);
            SqlCommand command1 = new SqlCommand("SELECT Bed_id FROM Ward_Beds where Bed_No=@Bed_No and ward_Id=@ward_Id", con_bed);
            command1.CommandType = CommandType.Text;
            command1.Parameters.AddWithValue("@Bed_No", Bed_No);
            command1.Parameters.AddWithValue("@ward_Id", ward_id);
            con_bed.Open();
            SqlDataReader reader = command1.ExecuteReader();
            while (reader.Read())
            {
                bed_id = reader.GetInt32(0);
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message)
        }
        return bed_id;
    }




    public void insert_bed(int ward_id, int bed_id)
    {
        try
        {
            string constr = ConfigurationManager.ConnectionStrings["Basic_Data_ConnectionString"].ConnectionString;
            SqlConnection con_ins = new SqlConnection(constr);
            SqlCommand command_inser = new SqlCommand("insert_Patient_Assign_Bed", con_ins);
            command_inser.CommandType = CommandType.StoredProcedure;
            con_ins.Open();
            command_inser.Parameters.AddWithValue("@Ward_id", ward_id);
            command_inser.Parameters.AddWithValue("@Bed_id", bed_id);
            command_inser.Parameters.AddWithValue("@admission_By", Session["Emp_Id"].ToString());
            command_inser.Parameters.AddWithValue("@Reg_No", Session["PRegNoForDetail"].ToString());
            // TextBox_RegNo.Text) '
            command_inser.Parameters.AddWithValue("@Yearly_No",Session["YearlyNo"].ToString() );
            //CInt(Session["YearlyNo"]))
            command_inser.Parameters.AddWithValue("@FloorID",62 );
            command_inser.Parameters.AddWithValue("@Patient_Type", 1);

            //command_inser.Parameters.AddWithValue("@Refer_By_Id", CInt(DropDownListReferBy.SelectedValue))
            command_inser.ExecuteNonQuery();
            con_ins.Close();
        }
        catch (Exception ex)
        {
            //HttpContext.Current.Response.Write(ex.Message)
        }
    }


    protected void btnBedStatus_Click(object sender, EventArgs e) {

        string url = "../Patient%20Billing/View_Room_Bed_Status.aspx?dept="+0+"&floor="+96+"";
        StringBuilder sb = new StringBuilder();
        sb.Append("<script type = 'text/javascript'>");
        sb.Append("window.open('");
        sb.Append(url);
        sb.Append("');");
        sb.Append("</script>");
        ClientScript.RegisterStartupScript(this.GetType(),
                "script", sb.ToString());




     


     
    }



    protected void GetTime(object sender, EventArgs e)
    {
        string selectedValue = hdnBedId.Value;
        CheckBoxListRoom.DataBind();
        if (!string.IsNullOrEmpty(selectedValue))
        {            
            CheckBoxListRoom.SelectedValue = selectedValue;
        }
    }


    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (radiobtnListPatientType.SelectedValue=="23")
        {
            
        }
    }
}






