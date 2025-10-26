Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports OnBarcode.Barcode
Imports System.Io


Partial Class PatientRegistration_Card
    Inherits System.Web.UI.Page

    '==============================
    Dim daEmployeeDependents As New Patient_RegistrationTableAdapters.EmployeeDependentsTableAdapter
    Dim dsPatientRegistration As New Patient_Registration
    Dim File_Path As String = Server.MapPath("~/Patient_picture/")
    Dim fileName As String
    Dim EmployeeNo As Integer
    Dim DT, DateBirth As Date
    Dim PhPhone, PMP, CNIC As String
    Dim flag1 As Boolean
    Shared check As Boolean = False
    Shared fingerPrint As Byte()
    Dim ENC As New Encryption
    Dim daEmpTemp As New Patient_RegistrationTableAdapters.Emp_TempTableAdapter
    Shared Pt_Reg_No As String = ""
    '==========================
    Dim a As Boolean = False
    Dim userid, userid1, DeptID, DeptID1 As Integer
    Dim flag As Integer = 0
    Dim DOB As Integer = 0
    Dim userAuthen As New User_page_Authentication
    Dim classobj As New FileUpload
    Dim Encry As New Encryption
    Dim PatientName As String = ""
    Dim PatientPanel_Flag As Boolean = False
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim conn As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    '=======================================================================================================
   
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Server.Transfer("~/login.aspx")
            End If
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then

            DDLDepartment.DataBind()
            DropDownList1.DataBind()
            DropDownList1.SelectedValue = "1"

            DropDownList_Employee_name.DataBind()

            rblPatientType_Sub.DataBind()
            rblPatientType_Sub.SelectedIndex = 0
            ddlRate.DataBind()
            bindCity()
            bindTown()
            
        End If


        RBLrelation.Attributes.Add("OnClick", "radio1()")
        textboxnic1.Attributes.Add("onkeypress", "txtChange(this)")
        CheckBox_Same_as_Above.Attributes.Add("onClick", "copy1()")
        ButtonSave.Attributes.Add("onClick", "return checkrequiredrfname()")

        If Not IsPostBack Then
            Province.SelectedValue = 0
            textboxage.Attributes.Add("OnBlur", "showAgedob(this)")
            DropDownListBIndicator.Attributes.Add("onChange", "changeYear()")
            textboxage.Attributes.Add("OnFocus", "showAgedobfocus(this)")
            textboxnic1.Visible = True
            TextBox_passport_No.Visible = False
            lblCNIC.Text = "CNIC # :"
            Session.Remove("YearlyNo")
            Session.Remove("PayId")
            Session.Remove("RegistrationNo")
            Session.Remove("RegNo")
        End If

        WebDateTimeEdit_DOB.MaxValue = Date.Today
        Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        classobj.File_Upload(Panel1)
        If DDLDepartment.SelectedValue = "69" Then
            DropDownList_Employee_name.Visible = True
            'GridView_Doctor_Services.Visible = True

            'Else
            'DropDownList_Employee_name.Visible = False
            'GridView_Doctor_Services.Visible = False
        End If



        loginvalidate(Session("emp_id"), Session("dept_id"))
        Session.Timeout = 60


        Try
            If Session("emp_id").ToString = "" Then
                Response.Redirect("~/Login.aspx")
            Else
                EmployeeNo = CInt(Session("emp_id"))
                DeptID = Session("dept_id").ToString
            End If
        Catch ex As Exception
            Response.Redirect("~/Login.aspx")
        End Try
        If (Page.IsPostBack = True) Then
        Else
            DDLDepartment.Focus()
        End If



        RBLprefix.Attributes.Add("onClick", "show(this)")
        RBLprefix_ot.Attributes.Add("onClick", "show_ot(this)")
        ' ButtonSave.Attributes.Add("onClick", "return checkrequiredname(this)")        

        If Not IsPostBack Then

            Try
                country.DataBind()
                country.SelectedValue = "90"
                Province.DataBind()
                Province.SelectedValue = "0"
                district.DataBind()
                textboxphonecode.Text = district.SelectedValue
                country_ot.DataBind()
                country_ot.SelectedValue = "90"
                Province_ot.DataBind()
                Province_ot.SelectedValue = "0"
                district_ot.DataBind()
                textboxphonecode_ot.Text = district_ot.SelectedValue


            Catch ex As Exception

            End Try
            '  If Page.IsPostBack Then
            '    textboxmcode.InputMask = "####-#######"
            '  End If

        End If


    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click

        Dim daEmpTemp As New Patient_RegistrationTableAdapters.Emp_TempTableAdapter
        Dim dtFinger As New DataTable

        Try
            Dim dtCheck As New DataTable
            dtCheck = daEmpTemp.GetDataBy_Finger()

            If Session("HospitalID").ToString() = "1" And dtCheck.Rows.Count = 0 And RadioButtonList_Patient_Type.SelectedItem.Text = "Insurance" Then

                dtCheck = daEmpTemp.GetDataBy_Finger()
                Dim sb As StringBuilder = New StringBuilder
                sb.Append("<script language='javascript'>")
                sb.Append("alert('Please Register Patient Finger')</script>")
                Dim t As Type = Me.GetType
                If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                End If
            Else
                Try
                    Try
                        dtFinger = daEmpTemp.GetDataBy_EmpID(txtEmployeeNo.Text)
                        fingerPrint = dtFinger.Rows(0).Item("FingerPrint")
                    Catch ex As Exception

                    End Try
                    If (Label3.Visible = False And Label_CNIC.Text = "Available") Or (Label3.Visible = False And Label_CNIC.Visible = False) Then


                        If HiddenField_flag.Value <> "0" Then

                            Label_Mobile.Visible = False
                            HiddenField_DOB.Value = WebDateTimeEdit_DOB.Value

                            main()



                        End If
                        HiddenField_mobile_Phone.Value = textboxmcode_ot.Text.Replace("-", "")
                        HiddenFieldNIC_ot.Value = textboxnic1_ot.Text.Replace("-", "")

                        HiddenField_phone_ot.Value = textboxcountrycode_ot.Text + textboxphonecode_ot.Text + textboxphoneno_ot.Text
                        If checkbox_copyadd.Checked = True Then
                            SqlDataSource_info_ot.InsertParameters("District").DefaultValue = district.SelectedValue
                            SqlDataSource_info_ot.InsertParameters("Tehsil").DefaultValue = tehsil.SelectedValue
                        Else
                            SqlDataSource_info_ot.InsertParameters("District").DefaultValue = district_ot.SelectedValue
                            SqlDataSource_info_ot.InsertParameters("Tehsil").DefaultValue = tehsil_ot.SelectedValue

                        End If

                        SqlDataSource_info_ot.Insert()
                        textboxTown_ot.Text = ""
                        textboxphoneno_ot.Text = ""
                        textboxrfname_ot.Text = ""
                        textboxrmname_ot.Text = ""
                        textboxpfname_ot.Text = ""
                        textboxpmname_ot.Text = ""
                        Try
                            HiddenField_Appointment_ID.Value = Request.QueryString("Appointment_ID")
                            SqlDataSource_Patient_Appointment.Update()
                            SqlDataSource_Patient_Appointment.Delete()
                        Catch ex As Exception
                            'Response.Write(ex.Message)
                        End Try
                        textboxnic1.Text = ""
                        Label3.Visible = False
                        Label_CNIC.Visible = False

                        Dim sb As StringBuilder = New StringBuilder
                        sb.Append("<script language='javascript'>")
                        sb.Append("alert('Patient Name " + HiddenField_msg_Patient_Name.Value + "  Medical Record# " + Encry.Encrypt_Main(HiddenField_Msg_Mr_No.Value, False) + "  Your Information has been Saved')</script>")
                        Dim t As Type = Me.GetType
                        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                        End If

                        WebDateTimeEdit_DOB.Text = ""


                    Else
                        Label_Mobile.Visible = True
                    End If


                    '    End If
                    '======= this is the function that calll after the clicked the save button ==============


                Catch ex As Exception

                    ' Response.Write(ex.Message)
                End Try
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try


        ImageButton1.ImageUrl = "~/images_hacims/picplace.jpg"
        textboxnic1_ot.Text = ""
        textboxmcode_ot.Text = ""
        textboxnic1b.Text = ""
        textboxmcodeb.Text = ""
        TextBox_House_Ot.Text = ""
        TextBox_Street_OT.Text = ""
        textboxplname_ot.Text = ""
        TextBox_Email_Address.Text = ""

        country.SelectedItem.Text = "PAKISTAN"
        Province.SelectedItem.Text = "Islamabad"
        'district.SelectedItem.Text = "Islamabad"
        tehsil.SelectedItem.Text = "Islamabad"

        country_ot.SelectedItem.Text = "PAKISTAN"
        Province_ot.SelectedItem.Text = "Islamabad"
        district_ot.SelectedItem.Text = "Islamabad"
        tehsil_ot.SelectedItem.Text = "Islamabad"
        textboxHouseNo.Text = ""
        textboxstreetaddress.Text = ""
        textboxrfname.Text = ""
        textboxrmname.Text = ""
        textboxrlname.Text = ""
        textboxpfname.Text = ""
        textboxpmname.Text = ""
        textboxplname.Text = ""
    End Sub
    Sub Insert_Dependents()
        '    If pnlPanelPatient.Visible = True Then
        '        Dim conStr As String = ConfigurationManager.ConnectionStrings("PatientBillingConnectionString").ConnectionString
        '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(conStr)
        '        '===================================================================
        '        Dim mycommand_regNo As New SqlCommand("INSERT_Panel_EMP_Patients", con)
        '        Try
        '            mycommand_regNo.CommandType = Data.CommandType.StoredProcedure
        '            mycommand_regNo.Parameters.AddWithValue("@Reg_No", HiddenField_Msg_Mr_No.Value)
        '            mycommand_regNo.Parameters.AddWithValue("@Billing_Party_Id", DropDownList_Parties.SelectedValue)
        '            If rblRegistrationType.SelectedValue = "Self" Then
        '                mycommand_regNo.Parameters.AddWithValue("@Emp_PT_Relation_Id", 0)
        '                hfPatient_RegNo.Value = HiddenField_Msg_Mr_No.Value
        '            Else
        '                hfPatient_RegNo.Value = ddlEmp_Patient.SelectedValue
        '                mycommand_regNo.Parameters.AddWithValue("@Emp_PT_Relation_Id", ddlRelation.SelectedValue)
        '            End If

        '            mycommand_regNo.Parameters.AddWithValue("@Emp_Id", 0)

        '            mycommand_regNo.Parameters.AddWithValue("@Status_Id", 1)
        '            mycommand_regNo.Parameters.AddWithValue("@Category_Id", ddlDesignation.SelectedValue)
        '            mycommand_regNo.Parameters.AddWithValue("@Emp_Reg_No", hfPatient_RegNo.Value)
        '            mycommand_regNo.Connection.Open()
        '            'Response.Write("before ")
        '            mycommand_regNo.ExecuteNonQuery()
        '            mycommand_regNo.Connection.Close()
        '            ' Response.Write(Pt_Reg_No & " regNo")
        '        Catch ex As Exception
        '            ' Response.Write(ex.Message & " regNo")
        '        End Try
        '    End If
        'End Sub

        'Sub Javascript(ByVal msg As String)
        '    Label4.Text = "<script language ='Javascript' type='text/javascript'>window.open('" & msg & "');</script>"
        'Response.Write("<script language ='Javascript' type='text/javascript'>alert('" & msg & "');</script>")
    End Sub
    Sub main()
      
        Try
            If textboxphoneno.Text = "" Then
                PhPhone = ""
            Else
                PhPhone = textboxcountrycode.Text & textboxphonecode.Text & textboxphoneno.Text
            End If
            '  If textboxmno.Text = "" Then
            'PMP = ""
            'Else
            PMP = textboxmcode.Text.Replace("-", "")
            'End If
            SavePatientRecord()
        Catch ex As Exception
            Response.Write(ex.Message & " main")
        End Try

    End Sub

    Sub SavePatientRecord()
        'Make the three Parts of NIC Into One 
        CNIC = textboxnic1.Text.Replace("-", "")
        Dim PPNo As String
        PPNo = textboxcountrycode.Text & textboxphonecode.Text & textboxphoneno.Text
        Dim a As DateTime = Date.Now
        DT = a
        Dim b As Integer = DateTime.Now.Hour
        Dim c As Integer = DateTime.Now.Minute
        Dim d As Integer = DateTime.Now.Second
        Try
            If textboxpfname.Text <> "" And textboxrfname.Text <> "" Then
                DateOfBirth()
                patientinsert()
               
            End If

        Catch ex As Exception
            Response.Write(ex.Message & "Save Patient Record")
        End Try
    End Sub


    Sub patientinsert()

        Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
       

        '========================================================================
        Dim mycommand As New System.Data.SqlClient.SqlCommand("PatientRegistration_WithVisit", con) ' "select RegNo from Patient where (RegNo = @name )", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Try

            If DropDownListCast.SelectedValue <> "" Then
                HiddenFieldCast.Value = DropDownListCast.SelectedValue
            Else
                HiddenFieldCast.Value = TextBoxCast.Text
            End If
            Dim ENC As New Encryption
            HiddenField_msg_Patient_Name.Value = RBLprefix.SelectedItem.Text + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower).ToString + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text.ToLower).ToString + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text.ToLower).ToString
            mycommand.Parameters.AddWithValue("@Prefix", RBLprefix.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text.ToLower), True)) 'Encrypt_String(textboxpfname.Text, 2))
            mycommand.Parameters.AddWithValue("@PMName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text.ToLower), True)) ' Encrypt_String(textboxpmname.Text, 2))
            mycommand.Parameters.AddWithValue("@PLName", ENC.Encrypt_Main(System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text.ToLower), True))
            'If RBLprefix.SelectedItem.Text = "Mr." Then
            '    mycommand.Parameters.AddWithValue("@Relation", "S/O") 'RBLrelation.SelectedItem.Text)

            'Else

            '    mycommand.Parameters.AddWithValue("@Relation", "D/O") 'RBLrelation.SelectedItem.Text)


            'End If
            mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedItem.Text)

            mycommand.Parameters.AddWithValue("@RFName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrfname.Text.ToLower))
            mycommand.Parameters.AddWithValue("@RMName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrmname.Text.ToLower))
            mycommand.Parameters.AddWithValue("@RLName", System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxrlname.Text.ToLower))
            mycommand.Parameters.AddWithValue("@SexID", CType(sex.SelectedItem.Value, Integer))
            Try
                mycommand.Parameters.AddWithValue("@Age", textboxage.Text)
            Catch ex As Exception

            End Try
            If String.IsNullOrEmpty(HiddenField_registration_date.Value) Then
                HiddenField_registration_date.Value = DateTime.Now().ToString("yyyyMMdd") 'CStr(DateTime.Now())
            End If
            mycommand.Parameters.AddWithValue("@RegDateTime", Date.Now().ToString("yyyyMMdd"))
            mycommand.Parameters.AddWithValue("@CountryCode", HiddenField_country.Value) ' CType(country.SelectedItem.Value, Integer))
            mycommand.Parameters.AddWithValue("@ProvinceID", Province.SelectedValue) 'Province.SelectedItem.Value)


            mycommand.Parameters.AddWithValue("@DistrictID", district.SelectedValue) 'district.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@Tehsil", tehsil.SelectedValue) 'tehsil.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@ZipCode", textboxzipcode.Text)
            mycommand.Parameters.AddWithValue("@House_No", textboxHouseNo.Text)
            mycommand.Parameters.AddWithValue("@StreetAddress", textboxstreetaddress.Text)
            mycommand.Parameters.AddWithValue("@City", ddlCity.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@Colony", ddlTown.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@HomePhone", PhPhone)
            mycommand.Parameters.AddWithValue("@MobilePhone", PMP)
            mycommand.Parameters.AddWithValue("@NIC", CNIC)
            mycommand.Parameters.AddWithValue("@Room_No", TextBox_Room_No.Text.ToString())

            mycommand.Parameters.AddWithValue("@ReferenceNo", txtReference.Text)
            mycommand.Parameters.AddWithValue("@CheckupType", ddlCheckupType.SelectedValue)
            Try

                Dim str() As String
                Dim date_val As String
                str = WebDateTimeEdit_DOB.Text.Split("/")
                date_val = str(2) + Right("00" + str(1), 2) + Right("00" + str(0), 2) ' + "/" + str(2)
                'mycommand.Parameters.AddWithValue("@DateOFBirth", Convert.ToDateTime(date_val).ToString("yyyyMMdd"))
                mycommand.Parameters.AddWithValue("@DateOFBirth", date_val)

            Catch ex As Exception

            End Try
            mycommand.Parameters.Add("@NewRegNo", SqlDbType.VarChar, 50)
            mycommand.Parameters("@NewRegNo").Direction = ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@RegNo", Pt_Reg_No)
            mycommand.Parameters.AddWithValue("@DateTime", HiddenField_registration_date.Value)
            mycommand.Parameters.AddWithValue("@DeptID", DDLDepartment.SelectedValue)
            mycommand.Parameters.AddWithValue("@EmpID", EmployeeNo)
            mycommand.Parameters.AddWithValue("@Diagonosis", TextBoxDiagnosis.Text + DropDownListDiagnosis.SelectedItem.Text)
            Try
                mycommand.Parameters.AddWithValue("@PatientType", "Routine")
            Catch ex As Exception

            End Try
            mycommand.Parameters.AddWithValue("@AgeType", DropDownListBIndicator.SelectedValue)
            mycommand.Parameters.AddWithValue("@ReferFrom", TextBoxSpecialCase.Text)
            mycommand.Parameters.AddWithValue("@to_sub_Dept", DropDownList1.SelectedValue)
            Try
                mycommand.Parameters.AddWithValue("@Patient_Type", rblPatientType_Sub.SelectedItem.Text)
            Catch ex As Exception

            End Try
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int)
            mycommand.Parameters("@paymentid").Direction = ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@pt_Cast", DropDownListBIndicator.SelectedValue)
            mycommand.Parameters.AddWithValue("@Payment_Status", RadioButtonList_Type.SelectedValue)
            mycommand.Parameters.AddWithValue("@Passport_No", TextBox_passport_No.Text)
            Try
                mycommand.Parameters.AddWithValue("@Email_address", txtEmailAddress.Text.Trim())
            Catch ex As Exception

            End Try
            If DropDownList1.Visible = False Then
                mycommand.Parameters.AddWithValue("@DoctorID", 0)
            Else
                mycommand.Parameters.AddWithValue("@DoctorID", DropDownList_Employee_name.SelectedValue)
            End If


            Try
                mycommand.Parameters.AddWithValue("@Religion", DropDownList_Religion.SelectedValue)
                mycommand.Parameters.AddWithValue("@Nationality", DropDownList_Nationality.SelectedValue)
            Catch ex As Exception

            End Try



            Try
                If DropDownList_Parties.Visible = True Then
                    mycommand.Parameters.AddWithValue("@party_ID", DropDownList_Parties.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Party_Desg_ID", Convert.ToDecimal(ddlDesignation.SelectedValue))
                    mycommand.Parameters.AddWithValue("@RegistrationType", rblRegistrationType.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Emp_No", txtEmployeeNo.Text)
                Else

                    mycommand.Parameters.AddWithValue("@party_ID", 0)
                    mycommand.Parameters.AddWithValue("@Party_Desg_ID", 0)
                    mycommand.Parameters.AddWithValue("@RegistrationType", "")
                    mycommand.Parameters.AddWithValue("@Emp_No", "")
                End If

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

            '==================================== @to_sub_Dept'
            'If rblPatientType_Sub.SelectedValue = "4" Then
            '    mycommand.Parameters.AddWithValue("@S_ID", ddlRate.SelectedValue)
            '    mycommand.Parameters.AddWithValue("@Amount", ddlRate.SelectedItem.Text)
            'Else
            mycommand.Parameters.AddWithValue("@S_ID", ddlRate.SelectedValue)
            mycommand.Parameters.AddWithValue("@Amount", ddlRate.SelectedItem.Text)
            'End If
            mycommand.Parameters.AddWithValue("@PanelAmounts", ddlRate.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@Hospital_Id", Session("HospitalId"))
            mycommand.Parameters.Add("@SPM_ID", SqlDbType.Int)
            mycommand.Parameters("@SPM_ID").Direction = ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@Emp_DeptId", Session("Dept_Id"))
            mycommand.Parameters.AddWithValue("@Emp_SubDeptId", Session("SubDeptId"))
            mycommand.Parameters.AddWithValue("@Patient_Type_Id", rblPatientType_Sub.SelectedValue)
            mycommand.Parameters.AddWithValue("@Doctor_Subdept_Id", DropDownList1.SelectedValue)

            Try
                con.Open()
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

            mycommand.ExecuteNonQuery()
            ''''''''''''''''
            daEmpTemp.UpdateFinger(fingerPrint, Pt_Reg_No)
            daEmpTemp.DeleteEmpTemp()

            Session("PFName") = textboxpfname.Text
            Session("PRName") = textboxrfname.Text
            Session("Age") = textboxage.Text
            Session("PhoneNo") = textboxmcode.Text

            PatientName = System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpfname.Text) + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxpmname.Text) + " " + System.Globalization.CultureInfo.CurrentUICulture.TextInfo.ToTitleCase(textboxplname.Text)
            Session.Add("patientname", PatientName)

            textboxpfname.Text = ""
            textboxplname.Text = ""
            textboxrfname.Text = ""
            textboxrmname.Text = ""
            textboxrlname.Text = ""
            textboxstreetaddress.Text = ""
            textboxage.Text = ""
            txtEmployeeNo.Text = ""
            TextBox_Room_No.Text = ""
            ''''''''''''''''''
            ' Dim PayID As String = mycommand.Parameters("@paymentid").Value
            Dim abc As String = mycommand.Parameters("@NewRegNo").Value 'param1.Value
            Session.Add("YearlyNo", mycommand.Parameters("@paymentid").Value)
            Session.Add("PayId", mycommand.Parameters("@paymentid").Value)
            Session.Add("RegistrationNo", abc)
            HiddenField_RegistrationNo.Value = abc
            'classobj.save_image(Panel1, a, abc)
            Session.Add("PRegNoForDetail", abc)
            Session.Add("SPM_ID", mycommand.Parameters("@SPM_ID").Value)
            con.Close()
            reset2()

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


        Catch ex As Exception
            'Response.Redirect("login.aspx")
            Response.Write(ex.Message & "Insert main")
        End Try

  
        'flag will tell that info should insert or not.

        

    End Sub

    Sub DateOfBirth()
        Try
            '    Dim dob As Date
            '    dob = CDate(WebDateTimeEdit_DOB.Text)


            '    If textboxage.Text = "" Then
            '        'Response.Write("Please Enter Age")
            '        Exit Sub
            '    Else


            '        If DropDownListBIndicator.SelectedItem.Text = "Years" Then
            '            DateBirth = DateAdd(DateInterval.Year, -(CInt(textboxage.Text)), Date.Now)
            '        ElseIf DropDownListBIndicator.SelectedItem.Text = "Months" Then
            '            DateBirth = DateAdd(DateInterval.Month, -(CInt(textboxage.Text)), Date.Now)
            '        ElseIf DropDownListBIndicator.SelectedItem.Text = "Days" Then
            '            DateBirth = DateAdd(DateInterval.Day, -(CInt(textboxage.Text)), Date.Now)
            '        ElseIf DropDownListBIndicator.SelectedItem.Text = "Hours" Then
            '            DateBirth = DateAdd(DateInterval.Hour, -(CInt(textboxage.Text)), Date.Now)
            '        End If
            '    End If
        Catch ex As Exception
            '  Response.Write(ex.Message)
            ' Response.Write("PLease Enter Age")
        End Try
    End Sub

    Sub country1()
        Try
            If country.SelectedItem.Text = "Other" Then
                Province.Visible = False
                tehsil.Visible = False
                textboxprovince2.Visible = True
                textboxDistrict2.Visible = True
                textboxTehsil2.Visible = True
                '' Session("PCC") = country.SelectedValue
                Exit Sub
            Else
                textboxprovince2.Visible = False
                textboxDistrict2.Visible = False
                textboxTehsil2.Visible = False
                Province.Visible = True
                Province.Focus()
                '' Session("PCC") = country.SelectedValue
            End If
        Catch ex As Exception
            ' response.write(ex.message)
        End Try
    End Sub

    Protected Sub country_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles country.SelectedIndexChanged
        Try
            country1()
            Province.DataBind()
            district.DataBind()
            Province.SelectedValue = 0
            ' tehsil.DataBind()

        Catch ex As Exception
            ' response.write(ex.message)
        End Try
    End Sub

    Sub province1()
        Try
            ' district.Visible = True
            'district.Focus()
            '' Session("PPC") = Province.SelectedValue
        Catch ex As Exception
            '   response.write(ex.message)
        End Try
    End Sub

    Protected Sub Province_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Province.SelectedIndexChanged
        Try
            ' Province.DataBind()


            district.DataBind()
            textboxphonecode.Text = district.SelectedValue
            tehsil.DataBind()

        Catch ex As Exception
            ' response.write(ex.message)
        End Try

    End Sub

    Sub district1()
        Try
            tehsil.Visible = True
            'tehsil.Focus()
            district.Focus()
            '' Session("PDC") = district.SelectedValue
        Catch ex As Exception
            '  response.write(ex.message)
        End Try

    End Sub

    Protected Sub district_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles district.SelectedIndexChanged
        Try
            'district.DataBind()
            textboxphonecode.Text = district.SelectedValue
            tehsil.DataBind()

        Catch ex As Exception
            ' response.write(ex.message)
        End Try

    End Sub

    Protected Sub tehsil_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tehsil.SelectedIndexChanged
        Try
            'textboxcolony.Focus()
            '' Session("PTC") = tehsil.SelectedValue
        Catch ex As Exception
            ' response.write(ex.message)
        End Try

    End Sub

    Sub sex1()
        ''Session("PSex") = sex.SelectedValue
    End Sub

    Protected Sub Detail1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNDetail1.Click
        Try
            '' Session("Back") = "PatientMain.aspx"
            Response.Redirect("Detail.aspx")
        Catch ex As Exception
            ' response.write(ex.message)
        End Try
    End Sub

    Sub reset2()
        Try
            'textboxnic1.Text = ""

            textboxpfname.Text = ""
            textboxpmname.Text = ""
            textboxplname.Text = ""
            textboxrfname.Text = ""
            textboxrmname.Text = ""
            textboxrlname.Text = ""
            textboxage.Text = ""
            textboxHouseNo.Text = ""
            'textboxcolony.Text = ""
            textboxstreetaddress.Text = ""

            textboxphoneno.Text = ""

            textboxzipcode.Text = ""
            'DropDownListDiagnosis.SelectedIndex = 0
            textboxmcode.Text = ""
            ' textboxmno.Text = ""

            DropDownListBIndicator.SelectedIndex = 0
            RBLrelation.SelectedIndex = 0
            RBLprefix.SelectedIndex = 0
            sex.SelectedIndex = 0
        Catch ex As Exception
            ' response.write(ex.message)
        End Try
    End Sub

    Sub msgbox1()
        Try
            Dim msg As String
            Dim title As String
            Dim style As MsgBoxStyle
            Dim response As MsgBoxResult
            msg = "Do you want to continue?"   ' Define message.
            style = MsgBoxStyle.DefaultButton2 Or _
               MsgBoxStyle.Critical Or MsgBoxStyle.YesNo
            title = "MsgBox Demonstration"   ' Define title.
            response = MsgBox(msg, style, title)
        Catch ex As Exception
            '  response.write(ex.message)
        End Try
    End Sub




    Sub Printreport(ByVal PrinterName As String)
        Try
            Session.Add("PatientName", PatientName)
            Session.Add("Reg_No", Encry.Encrypt_Main(Session("RegistrationNo"), False))
            Response.Write("<script language='javascript' type='text/javascript'> window.open('EmergencyReportPrint.aspx')</script>'")
            'Response.Redirect('PatientRegistration.aspx')
        Catch ex As Exception

        End Try

        'End Try
        'Try

        '    Dim report As New ReportDocument()
        '    Dim strpath As String = ""
        '    Dim reportname As String = ""
        '    strpath = Server.MapPath("")
        '    Response.Write(strpath)
        '    If flag = 1 Then
        '        reportname = strpath + "\PatientReport.rpt"
        '    Else
        '        reportname = strpath + "\PatientReportIsuse.rpt"
        '    End If
        '    report.Load(reportname, OpenReportMethod.OpenReportByTempCopy)
        '    report.SetDatabaseLogon("sa", "abc@123", "DBA", "registration")
        '    report.SetParameterValue(0, Session("registrationno"))
        '    report.SetParameterValue(1, Session("yearlyno"))
        '    report.SetParameterValue(2, PatientName)
        '    report.SetParameterValue(3, Encry.Encrypt_Main(Session("registrationno"), False))
        '    report.PrintOptions.PrinterName = PrinterName
        '    report.PrintToPrinter(1, True, 0, 0)

        '    report.Close()
        'Catch ex As Exception
        '    Response.Write("  " & ex.Message)
        'End Try
    End Sub

    Protected Sub IbtnLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles IBtnLogOut.Click
        Try
            'Function For the LogOut Button 
            Session.RemoveAll()
            Response.Redirect("../Login.aspx")
        Catch ex As Exception
            '  Response.write(ex.message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            ' Function F0r the Save Print Button
            flag = 0
            main()
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub RadioButtonList_Patient_Type_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.DataBound
        RadioButtonList_Patient_Type.Items(0).Selected = True
    End Sub

    Protected Sub Province_ot_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Province_ot.DataBound

        If Not (IsPostBack) Then

            'Province_ot.SelectedItem.Text = "Punjab"
        End If

    End Sub

    Protected Sub DropDownListRelationwithPatient_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListRelationwithPatient_ot.SelectedIndexChanged
   

    End Sub

    Protected Sub Province_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Province_ot.SelectedIndexChanged
        district_ot.DataBind()
        textboxphonecode_ot.Text = district_ot.SelectedValue
        tehsil_ot.DataBind()
    End Sub

    Protected Sub district_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles district_ot.SelectedIndexChanged
        textboxphonecode_ot.Text = district_ot.SelectedValue
        tehsil_ot.DataBind()
    End Sub




    Protected Sub RadioButtonList_Patient_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.SelectedIndexChanged
       
        rblPatientType_Sub.DataBind()

    End Sub

    Protected Sub rblPatientType_Sub_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblPatientType_Sub.DataBound
       
        If rblPatientType_Sub.Items.Count > 0 Then
            rblPatientType_Sub.Items(0).Selected = True
        End If
        rblPatientType_Sub.Visible = True
        
    End Sub

    Protected Sub LoadPatientPanel()
        Dim sql_arg As New DataSourceSelectArguments
        pnlPanelPatient.Visible = True
        Dim dv As DataView = SQL_Patient_Type_Sub.Select(sql_arg)
        If dv.Table.Rows.Count > 0 Then
            Dim drr() As DataRow = dv.Table.Select("Patient_Type_ID=" & rblPatientType_Sub.SelectedValue)
            If drr.Length > 0 Then
                If CBool(drr(0)("Dependent_Allow")) = True Then
                    td_RegistrationType.Visible = True
                    rblRegistrationType.SelectedIndex = 0
                    ddlEmp_Patient.Visible = False
                    ddlRelation.Visible = False
                Else
                    gvDependents.Visible = False
                    td_RegistrationType.Visible = False
                End If

                If CBool(drr(0)("Panel_Company")) = True Then
                    DropDownList_Parties.DataBind()
                    ddlDesignation.DataBind()
                    td_Insurer.Visible = True
                    ReferenceId.Visible = True
                    td_Employee_Designation.Visible = True

                    DropDownList_Parties.Items.Insert(0, New ListItem(" Select Party ", "0"))
                    DropDownList_Parties.SelectedIndex = 0
                Else
                    td_Insurer.Visible = False
                    ReferenceId.Visible = False
                    td_Employee_Designation.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub rblPatientType_Sub_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblPatientType_Sub.PreRender
        'LoadPatientPanel()
        'If rblPatientType_Sub.SelectedItem.Text = "Private" Then rblPatientType_Sub.Visible = False

    End Sub



    Protected Sub rblPatientType_Sub_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblPatientType_Sub.SelectedIndexChanged
        'If rblPatientType_Sub.SelectedItem.Text.ToLower() = "private" Then
        '    ddlRate.Visible = True
        '    ddlRate.FocusddlRate.Visible = False
        'Else
        '    ddlRate.Visible = True
        '    rblPatientType_Sub.Focus()
        'End If



        If rblPatientType_Sub.SelectedValue = "4" Then
            pnlPanelPatient.Visible = True
            LoadPatientPanel()

        Else
            pnlPanelPatient.Visible = False
        End If
       
        ddlRate.DataBind()
      

    End Sub

    Protected Sub CheckBox_Same_as_Above_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        If CheckBox_Same_as_Above.Checked = True Then
            'textboxTown_ot.Text = textboxcolony.Text
            TextBox_House_Ot.Text = textboxHouseNo.Text
            TextBox_Street_OT.Text = textboxstreetaddress.Text
        Else
            textboxTown_ot.Text = ""
            TextBox_House_Ot.Text = ""
            TextBox_Street_OT.Text = ""
        End If
    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Try
            Dim check As Integer
            check = 0
            If Session("PFName") Is Nothing Then
                check = 1
            Else
                If (Session("PFName").ToString() = textboxpfname.Text And Session("Age").ToString() = textboxage.Text And Session("PhoneNo").ToString() = textboxmcode.Text And Session("PRName").ToString() = textboxrfname.Text) Then
                    Response.Write("User Already Registered")
                    check = 0
                Else
                    check = 1
                End If
            End If

            If check = 1 Then

                

                If (Label3.Visible = False And Label_CNIC.Text = "Available") Or (Label3.Visible = False And Label_CNIC.Visible = False) Then


                    Label_Mobile.Visible = False
                    HiddenField_DOB.Value = WebDateTimeEdit_DOB.Value
                    'DateOfBirth()
                    main()

                End If
                HiddenField_mobile_Phone.Value = textboxmcode_ot.Text.Replace("-", "")
                HiddenFieldNIC_ot.Value = textboxnic1_ot.Text.Replace("-", "")

                HiddenField_phone_ot.Value = textboxcountrycode_ot.Text + textboxphonecode_ot.Text + textboxphoneno_ot.Text
                SqlDataSource_info_ot.Insert()

                textboxTown_ot.Text = ""
                textboxphoneno_ot.Text = ""
                textboxrfname_ot.Text = ""
                textboxrmname_ot.Text = ""
                textboxpfname_ot.Text = ""
                textboxpmname_ot.Text = ""
                'rblPatientType_Sub.SelectedValue = 11
                'ddlRate.Visible = False

                textboxnic1.Text = ""
                Label3.Visible = False
                Label_CNIC.Visible = False


                ' ImageButton1.ImageUrl = "~/images_hacims/picplace.jpg"
                textboxnic1_ot.Text = ""
                textboxmcode_ot.Text = ""
                textboxnic1b.Text = ""
                textboxmcodeb.Text = ""
                TextBox_House_Ot.Text = ""
                TextBox_Street_OT.Text = ""
                textboxplname_ot.Text = ""
                TextBox_Email_Address.Text = ""
                ' DropDownList1.SelectedValue = ""
                LbL_Mg.Text = ""
                country.SelectedItem.Text = "PAKISTAN"
                Province.SelectedItem.Text = "Islamabad"
                'district.SelectedItem.Text = "Islamabad"
                tehsil.SelectedItem.Text = "Islamabad"

                country_ot.SelectedItem.Text = "PAKISTAN"
                Province_ot.SelectedItem.Text = "Islamabad"
                district_ot.SelectedItem.Text = "Islamabad"
                tehsil_ot.SelectedItem.Text = "Islamabad"
                WebDateTimeEdit_DOB.Text = ""


                '======= this is the function that calll after the clicked the save button ==============
                Dim MrNo As String = "0"
                Dim YearlyNo As String = "0"


                If String.IsNullOrEmpty(Session("RegistrationNo")) Then
                    MrNo = "0"
                Else
                    MrNo = Session("RegistrationNo").ToString()
                End If
                If String.IsNullOrEmpty(Session("YearlyNo")) Then
                    Session("YearlyNo") = "0"
                Else
                    YearlyNo = Session("YearlyNo").ToString()

                End If

                If Session("SPM_ID") > 0 Then
                    Dim url As String = "../Patient%20Registration/OPD_Slip_Report_Private.aspx?SPMID=" + Session("SPM_ID").ToString() + "&PS=1"

                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<script language='javascript'>")
                    sb.Append(" window.open('")
                    sb.Append(url)
                    'OPD_Slip_Report_Private.aspx
                    sb.Append("', '_Blank')</script>")
                    Dim t As Type = Me.GetType
                    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                    End If
                End If

            End If

            '==========================================================
            ' SMS Method
            '==========================================================
            SendSmS()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub
    Protected Sub Load_Control(ByVal RegNo As String)
       
    End Sub


    Protected Sub textboxnic1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles textboxnic1.TextChanged
        'Try
        '    Dim MR_No As String = ""
        '    Dim con As SqlConnection = New SqlConnection(constr)
        '    Dim command As SqlCommand = New SqlCommand("Select count(*) AS CNT,RegNo from Patient where CNIC='" + textboxnic1.Text.Replace("-", "") + "' GROUP BY RegNo", con)
        '    command.CommandType = CommandType.Text
        '    con.Open()
        '    Dim reader As SqlDataReader = command.ExecuteReader
        '    Dim count As Integer = 0
        '    While reader.Read
        '        count = reader.Item("CNT")
        '        MR_No = ENC.Encrypt_Main(reader.Item("RegNo"), False)
        '    End While

        '    If IsNumeric(textboxnic1.Text.Replace("-", "")) And Not (textboxnic1.Text.Replace("-", "").Contains(".")) And textboxnic1.Text.Replace("-", "").Length = 13 Then


        '        If count > 0 Then
        '            If textboxnic1.Text.Replace("-", "") = "" Then
        '                LinkButton_MRNo.Text = ""
        '            Else
        '                Label3.Visible = False
        '                Label_CNIC.Visible = True
        '                Label_CNIC.Text = "Already Exist"
        '                LinkButton_MRNo.Text = MR_No
        '                ' Load_Control(MR_No)
        '            End If


        '        Else
        '            LinkButton_MRNo.Text = ""
        '            If textboxnic1.Text.Replace("-", "") = "" Then

        '            Else
        '                Label3.Visible = False
        '                Label_CNIC.Visible = True
        '                Label_CNIC.Text = "Available"
        '            End If
        '        End If
        '    Else
        '        LinkButton_MRNo.Text = ""
        '        Label_CNIC.Visible = False
        '        Label3.Visible = True
        '    End If
        '    con.Close()


        'Catch ex As Exception

        '    Response.Write(ex.Message)
        'End Try
    End Sub

    Protected Sub Button_attach_pic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_attach_pic.Click
        '' Response.Write(System.IO.Path.GetFileName(Request.Path))
        'If FileUpload_image.HasFile = True Then
        '    fileName = FileUpload_image.FileName
        '    Dim extension As String = System.IO.Path.GetExtension(fileName)

        '    If extension = ".jpg" Or extension = ".JPG" Or extension = ".gif" Or extension = ".GIF" Or extension = ".bmp" Or extension = ".BMP" Then


        '        If System.IO.File.Exists(fileName) Then
        '            System.IO.File.Delete(fileName)
        '        End If
        '        Dim fs As FileStream = New FileStream(File_Path + fileName, FileMode.Create)
        '        Try
        '            fs.Write(FileUpload_image.FileBytes, 0, FileUpload_image.FileBytes.Length)
        '        Catch ' ex As Exception
        '            Response.Write("Hello")

        '        End Try

        '        Session("File_Path") = File_Path
        '        Session("fileName") = fileName
        '        fs.Close()
        '    Else

        '        Dim sb As StringBuilder = New StringBuilder
        '        sb.Append("<script language='javascript'>")
        '        sb.Append("alert(' Please Select Picture File ')</script>")
        '        Dim t As Type = Me.GetType
        '        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        '        End If

        '    End If


        'End If

        'ImageButton1.ImageUrl = "~/Patient_picture/" + fileName
    End Sub


    Protected Sub cmdPanelEmp_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cmdPanelEmp.Click
        
    End Sub

    Protected Sub DropDownList_Nationality_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Nationality.SelectedIndexChanged
        Try
            If DropDownList_Nationality.SelectedItem.Text = "Pakistani" Then
                textboxnic1.Visible = True
                TextBox_passport_No.Visible = False
                lblCNIC.Text = "CNIC # :"
                lblPassport.Text = ""
            Else
                textboxnic1.Visible = False
                TextBox_passport_No.Visible = True
                lblCNIC.Text = ""
                lblPassport.Text = "Passport # :"
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnSearchEmployee_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearchEmployee.Click
        textboxnic1b.Enabled = False
        If txtEmployeeNo.Text = "" Then
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript'>")
            sb.Append("alert(' Please Enter Employee # ')</script>")
            Dim t As Type = Me.GetType
            rblRegistrationType.Enabled = True
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If
        Else
            grdEmployeeDependents.DataBind()

            daEmployeeDependents.Fill(dsPatientRegistration.Tables("EmployeeDependents"), txtEmployeeNo.Text, Convert.ToInt32(DropDownList_Parties.SelectedValue), Convert.ToDecimal(ddlDesignation.SelectedValue))

            If grdEmployeeDependents.Rows.Count >= 1 And rblRegistrationType.SelectedValue = "Dependent" Then


                textboxrfname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PFName").ToString()
                textboxrmname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PMName").ToString()
                textboxrlname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PLName").ToString()
                textboxnic1b.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("CNIC").ToString()
                textboxmcodeb.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item(15).ToString()

                textboxrfname.ReadOnly = True
                textboxrmname.ReadOnly = True
                textboxrlname.ReadOnly = True
                textboxnic1b.ReadOnly = True
                textboxmcodeb.ReadOnly = True
            Else
                textboxrfname.ReadOnly = False
                textboxrmname.ReadOnly = False
                textboxrlname.ReadOnly = False
                textboxnic1b.ReadOnly = False
                textboxmcodeb.ReadOnly = False

            End If






            If grdEmployeeDependents.Rows.Count = 0 Then
                rblRegistrationType.SelectedValue = "Self"
                Dim sb As StringBuilder = New StringBuilder
                sb.Append("<script language='javascript'>")
                sb.Append("alert(' Please Register Employee as Self')</script>")
                Dim t As Type = Me.GetType
                rblRegistrationType.Enabled = True
                If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                End If
            Else
                rblRegistrationType.SelectedValue = "Dependent"
                rblRegistrationType.Enabled = False
                textboxrfname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PFName").ToString()
                textboxrmname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PMName").ToString()
                textboxrlname.Text = dsPatientRegistration.EmployeeDependents.Rows(0).Item("PLName").ToString()

                textboxrfname.ReadOnly = True
                textboxrmname.ReadOnly = True
                textboxrlname.ReadOnly = True

            End If

            textboxrfname.Text = (Encry.Encrypt_Main(textboxrfname.Text, False))
            textboxrmname.Text = Encry.Encrypt_Main(textboxrmname.Text, False)
            textboxrlname.Text = Encry.Encrypt_Main(textboxrlname.Text, False)
        End If

    End Sub

    Protected Sub grdEmployeeDependents_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdEmployeeDependents.PreRender
        If grdEmployeeDependents.Rows.Count > 0 Then
            ddlDesignation.Enabled = False
           
            Dim lblCnic As Label = grdEmployeeDependents.Rows(0).FindControl("Label_CNIC")
            Dim lblCell As Label = grdEmployeeDependents.Rows(0).FindControl("Label_Cell")
            textboxnic1b.Text = lblCnic.Text
            textboxmcodeb.Text = lblCell.Text

        Else
            ddlDesignation.Enabled = True
        End If

        For i As Integer = 0 To grdEmployeeDependents.Rows.Count - 1
            ' To enable the clear button
            btnSearchEmployee.Visible = False
            '            Button_Clear.Visible = True

            txtEmployeeNo.Enabled = False


            Dim hfRegNo As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfRegNo")
            Dim lblPatient As Label = grdEmployeeDependents.Rows(i).FindControl("lblPatientName")
            Dim lblRegNo As Label = grdEmployeeDependents.Rows(i).FindControl("lblRegNo")
            Dim lblRelation As Label = grdEmployeeDependents.Rows(i).FindControl("lblRelation")
            Dim hfPFName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfPFName")
            Dim hfPLName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfPLName")
            Dim hfPMName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfPMName")
            Dim hfRFName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfRFName")
            Dim hfRMName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfRMName")
            Dim hfRLName As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfRLName")
            Dim hfRelation As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfRelation")
            Dim hfPrefix As HiddenField = grdEmployeeDependents.Rows(i).FindControl("hfPrefix")



            lblRegNo.Text = Encry.Encrypt_Main(hfRegNo.Value, False)
            lblPatient.Text = hfPrefix.Value + " " + Encry.Encrypt_Main(hfPFName.Value, False) + " " + Encry.Encrypt_Main(hfPMName.Value, False) + " " + Encry.Encrypt_Main(hfPLName.Value, False)
            lblRelation.Text = hfRelation.Value + " " + hfRFName.Value + " " + hfRMName.Value + " " + hfRLName.Value
            Dim lblRegistrationType As Label = grdEmployeeDependents.Rows(i).FindControl("lblRegistrationType")
            If (lblRegistrationType.Text <> "Self") Then
                Dim lblRelationWith As Label = grdEmployeeDependents.Rows(i).FindControl("lblRelationWith")
                If hfRelation.Value = "S/O" Then

                    lblRelationWith.Text = "Son"
                ElseIf hfRelation.Value = "W/O" Then
                    lblRelationWith.Text = "Wife"
                ElseIf hfRelation.Value = "M/O" Then
                    lblRelationWith.Text = "Mother"
                ElseIf hfRelation.Value = "D/O" Then
                    lblRelationWith.Text = "Daughter"
                ElseIf hfRelation.Value = "F/O" Then
                    lblRelationWith.Text = "Father"
                ElseIf hfRelation.Value = "H/O" Then
                    lblRelationWith.Text = "Husband"
                End If

            End If
        Next


    End Sub


    Protected Sub btnFingerPrint_Click(ByVal sender As Object, ByVal e As System.EventArgs)
       
    End Sub


    Protected Sub LinkButton_MRNo_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Write(ENC.Encrypt_Main(LinkButton_MRNo.Text, True))
        ' Response.Redirect("View_PatientDetail.aspx?regno=13", False) '& ENC.Encrypt_Main(LinkButton_MRNo.Text, True))
    End Sub


    Protected Sub DropDownList_Parties_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Parties.SelectedIndexChanged
        ddlDesignation.DataBind()

    End Sub


    Protected Sub rblRegistrationType_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles rblRegistrationType.SelectedIndexChanged
        'If (rblRegistrationType.SelectedValue = "Dependent") Then
        '    ddlRelation.Visible = True
        '    Dim arg As New DataSourceSelectArguments
        '    Dim dv As DataView = SQL_Patient_Info.Select(arg)
        '    Dim dt As DataTable = dv.Table()
        '    ddlEmp_Patient.DataSource = dt

        '    For i As Integer = 0 To dt.Rows.Count - 1
        '        dt.Rows(i)("Prefix") = dt.Rows(i)("Prefix") + " " + ENC.Encrypt_Main(dt.Rows(i)("PFName"), False) + " " + ENC.Encrypt_Main(dt.Rows(i)("PMName"), False) + " " + ENC.Encrypt_Main(dt.Rows(i)("PLName"), False)
        '    Next
        '    ddlEmp_Patient.DataTextField = "Prefix"
        '    ddlEmp_Patient.DataValueField = "Reg_No"
        '    ddlEmp_Patient.DataBind()
        '    ddlEmp_Patient.Visible = True
        '    gvDependents.DataBind()
        '    gvDependents.Visible = True
        'Else
        '    ddlRelation.Visible = False
        '    ddlEmp_Patient.Visible = False
        '    gvDependents.Visible = False

        'End If
    End Sub

    Protected Sub gvDependents_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvDependents.PreRender

        If rblRegistrationType.SelectedValue = "Dependent" Then

            For i As Integer = 0 To gvDependents.Rows.Count - 1
                Dim lblName As Label = gvDependents.Rows(i).FindControl("lblName")
                Dim lblPrefix As Label = gvDependents.Rows(i).FindControl("lblPrefix")
                Dim lblPFName As Label = gvDependents.Rows(i).FindControl("lblPFName")
                Dim lblPMName As Label = gvDependents.Rows(i).FindControl("lblPMName")
                Dim lblPLName As Label = gvDependents.Rows(i).FindControl("lblPLName")

                lblName.Text = lblPrefix.Text + " " + ENC.Encrypt_Main(lblPFName.Text, False) + " " + ENC.Encrypt_Main(lblPMName.Text, False) + " " + ENC.Encrypt_Main(lblPLName.Text, False)
            Next
        End If
    End Sub

    Protected Sub ddlRelation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlRelation.SelectedIndexChanged
        gvDependents.DataBind()
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click

    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        '  DropDownList1.Focus()
        DropDownList_Employee_name.DataBind()

    End Sub

    Protected Sub textboxpfname_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles textboxpfname.TextChanged
        'textboxpfname.Text.Trim()
        'textboxpfname.Focus()
    End Sub

    Protected Sub textboxplname_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles textboxplname.TextChanged
        'textboxplname.Text.Trim()
        'textboxplname.Focus()
    End Sub

    Protected Sub textboxrfname_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles textboxrfname.TextChanged
        'textboxrfname.Text.Trim()
        'textboxrfname.Focus()
    End Sub

    Protected Sub DropDownList_Employee_name_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Employee_name.SelectedIndexChanged
        DropDownList_Employee_name.Focus()
        ddlRate.DataBind()
       

    End Sub

    Private Sub Payment_Detail(ByVal s_Id As Integer, ByVal s_Rate As Double)

    End Sub
   
    Protected Sub country_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles country_ot.SelectedIndexChanged
        country_ot.Items.Insert(0, New ListItem(" ", "Default value"))


    End Sub

    Protected Sub btn_Refresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Refresh.Click
        textboxpfname.Text = ""
        textboxplname.Text = ""
        textboxrfname.Text = ""
        textboxrlname.Text = ""
        textboxnic1.Text = ""
        textboxmcode.Text = ""
        TextBoxDiagnosis.Text = ""
        TextBoxSpecialCase.Text = ""
        textboxHouseNo.Text = ""
        txtEmailAddress.Text = ""
    End Sub

  

    Protected Sub SqlDataSource_Doctor_Services_Inserted(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Doctor_Services.Inserted
     
    End Sub

    Private Sub SendSmS()

        Dim C_no As String = String.Empty
        Dim sb As New StringBuilder()
        Dim t As Type = Me.[GetType]
        'Dim url As String = "http://sms.bmsolutions.pk/api?username=alkhidmatlhr&password=alkhidmatlhr&" + getPatientSMSURL(C_no, Session("RegistrationNo"), Session("YearlyNo"))

        Dim url As String = "http://b2bsms.telecard.com.pk/SMSPortal/Customer/ProcessSMS.aspx?userid=test129&pwd=test129&" + getPatientSMSURL(C_no, Session("RegistrationNo"), Session("YearlyNo"))

        ScriptManager.RegisterStartupScript(Me, [GetType](), "open", "openWin('" + url + "');", True)

    End Sub
    Protected Function getPatientSMSURL(ByRef contact_no As String, Reg_no As String, Yealy_no As String) As String
        Dim URL As String = String.Empty
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ToString()
        Dim qry As String = (Convert.ToString((Convert.ToString((Convert.ToString("SELECT     TOP (1) Isnull(P.Prefix,'') as Prefix, Isnull(P.PFName,'') as PFName, Isnull(P.PMName,'') as PMName, Isnull(P.PLName,'') as PLName,p.RegNo, '92'+right(REPLACE(p.MobilePhone,'-',''),10) as MobilePhone from patient p inner join payment  pmnt on p.RegNo=pmnt.RegNo where (pmnt.RegNo = '") & Reg_no) + "') AND (PMNT.PayID = ") & Yealy_no) + ")"))

        Dim con As New SqlConnection(constr)
        Dim command As New SqlCommand(qry, con)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim prefix As String = String.Empty
        Dim Fname As String = String.Empty
        Dim Mname As String = String.Empty
        Dim Con_no As String = String.Empty
        Dim YearlyNo As String = String.Empty
        Dim name As String = String.Empty
        If reader.HasRows Then
            While reader.Read()
                prefix = reader("Prefix")
                Fname = reader("PFName")
                Try
                    Mname = reader("PLName")
                Catch ex As Exception
                End Try
                Try
                    Con_no = reader("MobilePhone")
                Catch ex As Exception
                End Try

            End While

            name = (prefix & Convert.ToString(" ")) + ENC.Encrypt_Main(Fname, False)
            If Not String.IsNullOrEmpty(Mname) Then
                name = (name & Convert.ToString(" ")) + ENC.Encrypt_Main(Mname, False)
            End If

            Try
                contact_no = Con_no.Replace("-", "")
            Catch ex As Exception

                Return URL
            End Try
        End If

        URL = (Convert.ToString((Convert.ToString("mobileno=") & Con_no) + "&msg=Dear ") & name) + "  MR " + Session("RegistrationNo").ToString() + " You are welcome to visit our Hospital and thanks for availing services, your suggestion is highly appreciated for our continual improvement in service for contact:34718801-6 and whatsApp:03334718803"

        Return URL
    End Function



    Protected Sub bindTown()
        Dim dbMgr As DbManager = New DbManager()
        Dim sqlParm As SqlParameter() = {New SqlParameter("@CityID", ddlCity.SelectedValue)}
        Dim query As String = "Select TownID,TownName From Towns Where CityID=@CityID"
        ddlTown.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "BasicDataInfoConnectionString", sqlParm)
        ddlTown.DataTextField = "TownName"
        ddlTown.DataValueField = "TownName"
        ddlTown.DataBind()
    End Sub

   
    Protected Sub bindCity()
        Dim dbMgr As DbManager = New DbManager()
        Dim sqlParm As SqlParameter() = {New SqlParameter("@CityName", "%")}
        Dim query As String = "Select CityID,CityName From Cities Where CityName like @CityName"
        ddlCity.DataSource = dbMgr.ExecuteDataTableWithQuery(query, "BasicDataInfoConnectionString", sqlParm)
        ddlCity.DataTextField = "CityName"
        ddlCity.DataValueField = "CityID"
        ddlCity.DataBind()
    End Sub


    Protected Sub ddlCity_SelectedIndexChanged(sender As Object, e As EventArgs)
        bindTown()
    End Sub
End Class