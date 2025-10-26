Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports System.Configuration.AppSettingsReader
Partial Class Patient_Registration_New
    Inherits System.Web.UI.Page
    '==============================
    Dim ENC As New Encryption
    Dim EmployeeNo As Integer
    Dim DT, DateBirth As Date
    Dim PhPhone, PMP, CNIC As String
    Dim PAtient_Type As String = ""

    '==========================
    Dim a As Boolean = False
    Dim userid, userid1, DeptID, DeptID1 As Integer
    Dim flag As Integer = 0
    Dim DOB As Integer = 0
    '=======================================================================================================
    'Declare the web.config variables
    Dim To_Sub_Dept As Integer = New System.Configuration.AppSettingsReader().GetValue("Patient_Registration_To_Sub_Dept", GetType(String))
    '=======================================================================================================
    ' Developer  Name         Imran Ahmed Awan
    ' Design Aprove  by       Muhammad Tariq
    ' Web Design By           Imran Sharif
    ' Date Started            October 5 ,2006
    ' Description      
    ' This form is used for patient registration in Emergency Department.
    ' I used store procedure to insert value in tables (Patient,Payment)
    ' variable "flag " is a globel variable which is used for the purpose that after press the save button 
    ' which page will be opened if save button is pressed then errorpage.aspx will be open and if saved and 
    ' print button is perssed then errorpage1.aspx is opened 


    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Server.Transfer("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Label2.Text = ""
        TextBoxage.Attributes.Add("onBlur", "return ForAge()")
        country.Attributes.Add("onChange", "getList(this)")
        Province.Attributes.Add("onChange", "getList(this)")
        district.Attributes.Add("onChange", "getList(this)")
        tehsil.Attributes.Add("onChange", "setit(this)")
        'TextBox_Address.Attributes.Add("onChange", "return requirment()")

        loginvalidate(Session("emp_id"), Session("dept_id"))
        Session.Timeout = 60

        Try
            If Session("emp_id").ToString = "" Then

            Else
                EmployeeNo = CInt(Session("emp_id"))
                DeptID = Session("dept_id").ToString
            End If
        Catch ex As Exception

        End Try
        If (Page.IsPostBack = True) Then
        Else
            DDLDepartment.Focus()
        End If
        country.SelectedValue = 3
        TextBox_Diagnosis.Attributes.Add("OnFocus", "showFocus(this)")
        TextBox_Diagnosis.Attributes.Add("OnBlur", "showFocus1(this)")
        RBLprefix.Attributes.Add("onClick", "show(this)")
        ButtonSave.Attributes.Add("onClick", "return checkrequiredname(this)")
        btnSavePrint.Attributes.Add("onClick", "return checkrequiredname(this)")
        Panel3.Visible = False
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        'Try
        '    '======= this is the function that calll after the clicked the save button ==============
        '    DateOfBirth()
        '    Try
        '        main()
        '    Catch ex As Exception
        '        Response.Write("june" & ex.Message)
        '    End Try

        '    Panel1.Visible = True
        '    Panel3.Visible = True
        '    Select_Sample_No()
        '    If Pt_Type(Session("registrationNo"), Session("YearlyNo")) = "OPD" Then
        '        Panel2.Visible = True
        '        Panel3.Visible = True
        '    End If
        'Catch ex As Exception
        '    Response.Write("May" & ex.Message)
        'End Try

    End Sub
    Sub main()
        '======= session("Periviouspage") is used for the back button to go back to perivous page ==============
        '======= this function concatinate the three parts of phone no. and in another varible saved 
        '======= the two parts of mobile no. 

        ' HANDLE THE TELEPHONE NUMBERS
        Try
            If TextBoxphoneno.Text = "" Then
                PhPhone = ""
            Else
                PhPhone = TextBoxcountrycode.Text & TextBoxphonecode.Text & TextBoxphoneno.Text
            End If
            If TextBoxmno.Text = "" Then
                PMP = ""
            Else
                PMP = TextBoxmcode.Text & TextBoxmno.Text
            End If
            SavePatientRecord()
        Catch ex As Exception
            Response.Write("This is it" & ex.Message)
        End Try

    End Sub
    Sub SavePatientRecord()
        If EmployeeNo <> 0 Or DeptID <> 0 Then

        End If
        'Make the three Parts of NIC Into One 
        CNIC = TextBoxnic1.Text & TextBoxnic2.Text & TextBoxnic3.Text
        Dim PPNo As String
        PPNo = TextBoxcountrycode.Text & TextBoxphonecode.Text & TextBoxphoneno.Text
        Dim a As DateTime = Date.Now
        DT = a
        Dim b As Integer = DateTime.Now.Hour
        Dim c As Integer = DateTime.Now.Minute
        Dim d As Integer = DateTime.Now.Second
        Try
            If TextBox_Pt_FName.Text <> "" Then 'And TextBox_Rel_FName.Text <> "" And TextBoxage.Text <> "" Then
                DateOfBirth()
                patientinsert()
                If flag = 0 Then

                Else
                    Printreport()
                End If
               ' form1.Dispose()
            Else
                ' LabelErrorMessage.Text = "Please enter the First Name,Age,Relative/Father Name"
            End If
        Catch ex As Exception
            Label2.Text = ex.Message
        End Try

    End Sub


    Sub patientinsert()
        Dim Pt_Reg_No As String = ""
        Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand_regNo As New SqlCommand("Create_Patient_RegistrationNo", con)
        mycommand_regNo.CommandType = Data.CommandType.StoredProcedure
        mycommand_regNo.Parameters.Add("@RegNo", SqlDbType.VarChar, 200)
        mycommand_regNo.Parameters("@RegNo").Direction = ParameterDirection.Output
        mycommand_regNo.Connection.Open()
        mycommand_regNo.ExecuteNonQuery()
        Pt_Reg_No = mycommand_regNo.Parameters("@RegNo").Value
        Pt_Reg_No = ENC.Encrypt_Main(Pt_Reg_No, True)
        mycommand_regNo.Connection.Close()
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Pt_Registration_pathology", con) ' "select RegNo from Patient where (RegNo = @name )", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure


        If TextBox_Diagnosis.Text <> "" Then

            TextBox_Diagnosis.Text = TextBox_Diagnosis.Text
        Else
            TextBox_Diagnosis.Text = "Diabetes"
        End If
        If textboxage.Text <> "" Then
            DateOfBirth()
        Else
            ' DateBirth = WebDateTimeEditDOB.Value
        End If
        Dim Sex_id As Integer = 0
        If RBLprefix.SelectedValue = "Mr." Then
            Sex_id = 1
        ElseIf RBLprefix.SelectedValue = "Miss" & "Mrs." Then
            Sex_id = 2
        End If
        Try
            mycommand.Parameters.AddWithValue("@PMName", ENC.Encrypt_Main(ENC.TitleCase(TextBox_Pt_MName.Text), True))
            mycommand.Parameters.AddWithValue("@Prefix", RBLprefix.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(ENC.TitleCase(TextBox_Pt_FName.Text), True))
            mycommand.Parameters.AddWithValue("@PLName", TextBox_Pt_LName.Text)
            mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedItem.Text)
            mycommand.Parameters.AddWithValue("@RFName", textbox_Rel_FName.Text)
            mycommand.Parameters.AddWithValue("@RMName", textbox_Rel_Mname.Text)
            mycommand.Parameters.AddWithValue("@RLName", textbox_Rel_LName.Text)
            mycommand.Parameters.AddWithValue("@SexID", CType(DropDownList_Gender.SelectedItem.Value, Integer))
            mycommand.Parameters.AddWithValue("@Age", textboxage.Text)
            mycommand.Parameters.AddWithValue("@RegDateTime", Date.Now())
            mycommand.Parameters.AddWithValue("@CountryCode", HiddenField_country.Value) ' CType(country.SelectedItem.Value, Integer))
            mycommand.Parameters.AddWithValue("@ProvinceID", HiddenField_province.Value) 'Province.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@DistrictID", HiddenField_district.Value) 'district.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@Tehsil", HiddenField_tehsil.Value) 'tehsil.SelectedItem.Value)
            mycommand.Parameters.AddWithValue("@ZipCode", textbox_Zip_Code.Text)
            mycommand.Parameters.AddWithValue("@House_No", textbox_House_No.Text)
            mycommand.Parameters.AddWithValue("@StreetAddress", textbox_Street_Address.Text)
            mycommand.Parameters.AddWithValue("@Colony", textbox_Colony.Text)
            mycommand.Parameters.AddWithValue("@HomePhone", PhPhone)
            mycommand.Parameters.AddWithValue("@MobilePhone", PMP)
            mycommand.Parameters.AddWithValue("@NIC", CNIC)
            mycommand.Parameters.AddWithValue("@DateOFBirth", DateBirth)
            '***********************************************************************************
            mycommand.Parameters.Add("@NewRegNo", SqlDbType.VarChar, 50)
            mycommand.Parameters("@NewRegNo").Direction = ParameterDirection.Output
            '***********************************************************************************            
            mycommand.Parameters.AddWithValue("@RegNo", Pt_Reg_No)
            mycommand.Parameters.AddWithValue("@DateTime", Date.Now())
            mycommand.Parameters.AddWithValue("@DeptID", Session("Dept_id"))
            'mycommand.Parameters.AddWithValue("@DeptID_Reffreral", DDLDepartment.SelectedValue)
            mycommand.Parameters.AddWithValue("@Status", "BMI")
            mycommand.Parameters.AddWithValue("@EmpID", EmployeeNo)
            mycommand.Parameters.AddWithValue("@Diagonosis", TextBox_Diagnosis.Text)
            '*****************************************

            mycommand.Parameters.AddWithValue("@Patient_Type", DropDownList_Pt_Type.SelectedValue)
            '***********************************************
            mycommand.Parameters.AddWithValue("@ReferFrom", TextBoxSpecialCase.Text)
            mycommand.Parameters.AddWithValue("@to_sub_Dept", To_Sub_Dept)
            mycommand.Parameters.Add("@paymentid", SqlDbType.Int)
            mycommand.Parameters("@paymentid").Direction = ParameterDirection.Output
            mycommand.Parameters.AddWithValue("@AgeType", DropDownListBIndicator.SelectedValue)
            mycommand.Parameters.AddWithValue("@pt_Cast", "")
            mycommand.Parameters.AddWithValue("@Refer_Department", 0)
            mycommand.Parameters.AddWithValue("@Refer_SubDepartment", 0)

            '====================================
            con.Open()
            mycommand.ExecuteNonQuery()
            ''''''''''''''''
            TextBox_Pt_FName.Text = ""
            TextBox_Pt_LName.Text = ""
            textbox_Rel_FName.Text = ""
            textbox_Rel_Mname.Text = ""
            textbox_Rel_LName.Text = ""
            textbox_Street_Address.Text = ""
            TextBox_Diagnosis.Text = ""
            textboxage.Text = ""
            ''''''''''''''''''

            Dim ab As String = mycommand.Parameters("@paymentid").Value
            Dim abc As String = mycommand.Parameters("@NewRegNo").Value 'param1.Value
            Session.Add("registrationNo", abc)
            Session.Add("YearlyNo", ab)
            If ab <> 0 Then
                Session.Add("BMIPayID", ab)
            Else
                Session.Add("PRegNoForDetail", abc)
            End If
            'Response.Write(Session("registrationNo"))
            'Response.Write(Session("YearlyNo"))
            'Response.End()
            Patient_Insert_Images(abc, DateBirth)
            con.Close()
            reset2()
        Catch ex As Exception
            Response.Write(ex.Message & " Save Patient Record ")
        End Try
    End Sub
    Sub Patient_Insert_Images(ByVal RegistrationNo As String, ByVal DateofBirth As String)
        'Dim a As String = ConfigurationManager.ConnectionStrings("RecameImageDBConnectionString").ConnectionString
        'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_Registration_Images", con) ' "select RegNo from Patient where (RegNo = @name )", con)
        'mycommand.CommandType = Data.CommandType.StoredProcedure

        Try
            'mycommand.Parameters.AddWithValue("@PMName", TextBox_Pt_MName.Text)
            'mycommand.Parameters.AddWithValue("@PFName", TextBox_Pt_FName.Text)
            'mycommand.Parameters.AddWithValue("@PLName", TextBox_Pt_LName.Text)
            'mycommand.Parameters.AddWithValue("@Sex", CType(sex.SelectedItem.Value, Integer))
            'mycommand.Parameters.AddWithValue("@ZipCode", TextBox_Zip_Code.Text)
            'mycommand.Parameters.AddWithValue("@Address1", TextBox_House_No.Text & "  " & TextBox_Street_Address.Text & " " & TextBox_Colony.Text)
            'mycommand.Parameters.AddWithValue("@StreetAddress", TextBox_Street_Address.Text)
            'mycommand.Parameters.AddWithValue("@HomePhone", PhPhone)
            'mycommand.Parameters.AddWithValue("@WorkPhone", PMP)
            'mycommand.Parameters.AddWithValue("@Reserved", "")
            'mycommand.Parameters.AddWithValue("@BirthDate", DateBirth)
            'mycommand.Parameters.AddWithValue("@Ident", RegistrationNo)
            'mycommand.Parameters.AddWithValue("@Occupation", Date.Now.ToString)
            ''====================================
            'con.Open()
            'mycommand.ExecuteNonQuery()
            'con.Close()

        Catch ex As Exception
            Response.Write(ex.Message & "ImAGE error")
        End Try
    End Sub

    Sub DateOfBirth()

        Try

            If TextBoxage.Text = "" Then
                DateBirth = Date.Now
            Else
                If DropDownListBIndicator.SelectedItem.Text = "Years" Then
                    DateBirth = DateAdd(DateInterval.Year, -(CInt(TextBoxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Months" Then
                    DateBirth = DateAdd(DateInterval.Month, -(CInt(TextBoxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Days" Then
                    DateBirth = DateAdd(DateInterval.Day, -(CInt(TextBoxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Hours" Then
                    DateBirth = DateAdd(DateInterval.Hour, -(CInt(TextBoxage.Text)), Date.Now)
                End If
            End If
        Catch ex As Exception
            Response.Write("PLease Enter Age")
        End Try
    End Sub
    Sub country1()
        Try
            If country.SelectedItem.Text = "Other" Then
                Province.Visible = False
                tehsil.Visible = False
                TextBoxprovince2.Visible = True
                TextBoxDistrict2.Visible = True
                TextBoxTehsil2.Visible = True
                '' Session("PCC") = country.SelectedValue
                Exit Sub
            Else
                TextBoxprovince2.Visible = False
                TextBoxDistrict2.Visible = False
                TextBoxTehsil2.Visible = False
                Province.Visible = True
                Province.Focus()
                '' Session("PCC") = country.SelectedValue
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub country_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles country.SelectedIndexChanged
        Try
            country1()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub province1()
        Try
            district.Visible = True
            district.Focus()
            '' Session("PPC") = Province.SelectedValue
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub Province_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Province.SelectedIndexChanged
        Try
            province1()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub district1()
        Try
            tehsil.Visible = True
            'tehsil.Focus()
            district.Focus()
            '' Session("PDC") = district.SelectedValue
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub


    Protected Sub district_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles district.SelectedIndexChanged
        Try
            district1()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub tehsil_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tehsil.SelectedIndexChanged
        Try
            TextBox_Colony.Focus()
            '' Session("PTC") = tehsil.SelectedValue
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub sex1()
    End Sub
    Protected Sub Detail1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNDetail1.Click
        Try
            Response.Redirect("Detail.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub reset2()
        Try
            TextBoxnic1.Text = ""
            TextBoxnic2.Text = ""
            TextBoxnic3.Text = ""
            TextBox_Pt_FName.Text = ""
            TextBox_Pt_MName.Text = ""
            TextBox_Pt_LName.Text = ""
            TextBox_Rel_FName.Text = ""
            TextBox_Rel_Mname.Text = ""
            TextBox_Rel_LName.Text = ""
            TextBoxage.Text = ""
            TextBox_House_No.Text = ""
            TextBox_Colony.Text = ""
            TextBox_Street_Address.Text = ""
            TextBox_Diagnosis.Text = ""
            TextBoxphoneno.Text = ""
            TextBoxSpecialCase.Text = ""
            TextBox_Zip_Code.Text = ""
            '  DropDownListDiagnosis.SelectedIndex = 0
            TextBoxmcode.Text = ""
            TextBoxmno.Text = ""
            DropDownList_Pt_Type.SelectedIndex = 0
            DropDownListBIndicator.SelectedIndex = 0
            RBLrelation.SelectedIndex = 0
            RBLprefix.SelectedIndex = 0
            DropDownList_Gender.SelectedIndex = 0
        Catch ex As Exception
            Response.Write(ex.Message)
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
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub btnSavePrint_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSavePrint.Click
        Try
            ' Function F0r the Save Print Button
            flag = 1

            main()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub Printreport()
        Try

            Dim b As String
            ' checkpayid()
            ' Below Six LInes Are The Code OF The Genereate Crystal Report ANd Print WithOut Preivieew The Report .
            Dim report As New ReportDocument()
            b = (Session("BMIPayID"))
            'report.Load(Server.MapPath("patient.rpt"))
            'strPath = Server.MapPath("patient.rpt")
            report.Load("e:\lgh\lgh_app\Patient.rpt")  ' Location Of TH e Report. 
            report.SetDatabaseLogon("sa", "123456", "lghsrvr", "LGH")
            report.SetParameterValue(0, b)
            ' Response.Write(report.Name + report.ParameterFields(0).ToString)
            report.PrintToPrinter(1, True, 0, 0)
            report.Close()
            Session("PDT") = Date.Now
            'printinfosave.Insert()
        Catch ex As Exception
            Response.Write("  " & ex.Message)
        End Try
    End Sub

    Protected Sub IbtnLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles IBtnLogOut.Click
        Try
            'Function For the LogOut Button 
            Session.RemoveAll()
            'Response.Redirect("Login.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub TextBoxage_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBoxage.TextChanged
        Try
            Label2.Text = ""
            Dim patient_Visit_Date As Date = Date.Today
            If DropDownListBIndicator.SelectedValue = "Days" Then
                If CInt(TextBoxage.Text) > 1000 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Day, -CInt(TextBoxage.Text), Date.Today)
            ElseIf DropDownListBIndicator.SelectedValue = "Months" Then
                If CInt(TextBoxage.Text) > 30 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Month, -CInt(TextBoxage.Text), Date.Today)
            ElseIf DropDownListBIndicator.SelectedValue = "Hours" Then
                If CInt(TextBoxage.Text) > 72 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Hour, -CInt(TextBoxage.Text), Date.Now)
            ElseIf DropDownListBIndicator.SelectedValue = "Years" Then
                If CInt(TextBoxage.Text) > 150 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Year, -CInt(TextBoxage.Text), Date.Today)
            End If

        Catch ex As Exception
            Label2.Font.Bold = True
            Label2.ForeColor = Drawing.Color.Red
            'Label2.Text = "Enter Correct Age"
        End Try
    End Sub

    Protected Sub DropDownListBIndicator_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Label2.Text = ""
            Dim patient_Visit_Date As Date = Date.Today
            If DropDownListBIndicator.SelectedValue = "Days" Then
                If CInt(TextBoxage.Text) > 1000 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Day, -CInt(TextBoxage.Text), Date.Today)
            ElseIf DropDownListBIndicator.SelectedValue = "Months" Then
                If CInt(TextBoxage.Text) > 30 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Month, -CInt(TextBoxage.Text), Date.Today)
            ElseIf DropDownListBIndicator.SelectedValue = "Hours" Then
                If CInt(TextBoxage.Text) > 72 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Hour, -CInt(TextBoxage.Text), Date.Now)
            ElseIf DropDownListBIndicator.SelectedValue = "Years" Then
                If CInt(TextBoxage.Text) > 150 Then
                    Label2.Text = "Enter Correct Age"
                    'TextBoxage.Text = 0
                    TextBoxage.Focus()
                    Exit Sub
                End If
                patient_Visit_Date = DateAdd(DateInterval.Year, -CInt(TextBoxage.Text), Date.Today)
            End If
            'Dim cal12 As Calendar = Calendar1.FindControl("Calendar1")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub DDLDepartment_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDepartment.PreRender
        DDLDepartment.Items.Add("")
        DDLDepartment.SelectedIndex = DDLDepartment.Items.Count - 1
    End Sub

    '========================================  Test Booking  =================================

    Protected Sub TextBox_Test_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Test.TextChanged
        HiddenField_Flag.Value = True
    End Sub

    Protected Sub DropDownList_Main_Group_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Main_Group.SelectedIndexChanged
        HiddenField_Flag.Value = False
        GridView_Booking.DataBind()
    End Sub

    Protected Sub GridView_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Services.PreRender
        Dim ENC As New Encryption
        'ENC.Grid_prerender(GridView_Services, 1)
    End Sub


    Protected Sub GridView_Booking_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Booking.PreRender
        'For i As Integer = 0 To GridView_Booking.Rows.Count - 1
        '    If i = 0 Then
        '    Else
        '        If GridView_Booking.Rows(i).Cells(2).Text = GridView_Booking.Rows(i - 1).Cells(2).Text Then
        '            GridView_Booking.Rows(i).Cells(2).Text = ""
        '        End If
        '    End If
        'Next
        Dim ENC As New Encryption
        ENC.Grid_prerender(GridView_Booking, 2)
    End Sub

    Protected Sub GridView_Booking_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Booking.RowDataBound

    End Sub

    Protected Sub GridView_Booking_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Booking.SelectedIndexChanged
        Try
            Insert_Values()
            If ((Session("registrationNo") Is Nothing)) Then
                Label2.Text = "Register patient First"
                Exit Sub
            End If
            Dim Hid_TB_ID As HiddenField = GridView_Booking.Rows(GridView_Booking.SelectedIndex).FindControl("HiddenField_TB_ID")
            HiddenField_TBID.Value = Hid_TB_ID.Value
            Try
                SqlDataSource_Booking.Insert()
            Catch ex As Exception
                Response.Write(ex.Message & "Check this")

            End Try
            Try
                GridView_Services.DataBind()
            Catch ex As Exception
                Response.Write(ex.Message & "OR CHeck this")

            End Try

            If Pt_Type(Session("registrationNo"), Session("YearlyNo")) = "OPD" Then
                Dim payment As Integer = 0
                For i As Integer = 0 To GridView_Services.Rows.Count - 1
                    Dim lbl_count As Label = GridView_Services.Rows(i).FindControl("Label1")
                    payment = payment + CInt(lbl_count.Text)
                Next
                TextBox_Grand_total.Text = payment
            End If
        Catch ex As Exception
            Response.Write(ex.Message & "kjkkj")
        End Try
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList2.SelectedIndexChanged
        Try
            If DropDownList2.SelectedItem.Text = "Biopsy" Then
                Response.Redirect("Path_Test_Biopsy.aspx?YearlyNo=" & Request.QueryString("YearlyNo").ToString & "&RegNo=" & Request.QueryString("RegNo").ToString)
            End If
        Catch ex As Exception

        End Try
        HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
        Label2.Text = ""
        Try
            HiddenField2.Value = DropDownList2.SelectedItem.Text
            labelGName.Text = HiddenField2.Value
            btnAdd.Visible = True
            BtnUncheckAll.Visible = True
        Catch ex As Exception
            labelGName.Text = ""
        End Try
        ' call the checkTest function for the checkboxlistTest 
    End Sub

    Sub Select_Sample_No()
        TextBox_Sample_number.Text = Session("YearlyNo")
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        'inserts tests for patients in database
        ' check that which checboxlist is active and send the value to checkboxlistcheck function.
        If Session("registrationNo") Is Nothing Or Session("RegistrationNo").ToString = "" Then
            Response.Write("dfasdf  ")
            Label2.Text = "Register patient First"
            Exit Sub
        End If
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)

            '************************** Inserts TB_Id
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo)", con)


            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        Dim Counter As Integer = 0
        If GridView_Services.Rows.Count > 0 Then
            Counter = 1
        End If
        If Counter <> 0 Then
            Button_Move_Next.Visible = True
            'Button_Move_Next_function()
        End If
        Payment_Button_Save()
        Main_Group()
        'Session.Remove("RegistrationNo")
        'Session.Remove("YearlyNo")
        'Response.Redirect("Patient_Registration_New.aspx")

    End Sub

    Sub Main_Group()
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        con.Open()
        Dim command1 As SqlCommand = New SqlCommand("Select_Main_Group_For_Assign_Test", con)
        command1.CommandType = CommandType.StoredProcedure
        command1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
        command1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = command1
        da.Fill(ds, "ABC")
        TreeView1.Nodes.Clear()
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            Dim obj As TreeNode = New TreeNode(ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(0))
            TreeView1.NodeStyle.ForeColor = Drawing.Color.Green
            TreeView1.NodeStyle.Font.Bold = True
            TreeView1.Nodes.Add(obj)
            Tests(ds.Tables(0).Rows(i).Item(0), obj)
        Next
        TreeView1.CollapseAll()
        con.Close()
    End Sub

    Sub Tests(ByVal cat_ID As Integer, ByVal obj As TreeNode)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            con.Open()
            Dim command1 As SqlCommand = New SqlCommand("Select_Sub_Group_For_Assign_Test", con)
            command1.CommandType = CommandType.StoredProcedure
            command1.Parameters.AddWithValue("@TGID", cat_ID)
            command1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            command1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            Dim reader As SqlDataReader = command1.ExecuteReader()
            While reader.Read
                Dim obj1 As TreeNode = New TreeNode(reader.GetString(1), reader.GetInt32(0))
                obj.ChildNodes.Add(obj1)
                TreeView1.LeafNodeStyle.Font.Bold = False
                TreeView1.LeafNodeStyle.ForeColor = Drawing.Color.Blue
            End While
            reader.Close()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "RET ")
        End Try
    End Sub
    Protected Sub Button_Move_Next_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Move_Next.Click
        '' Code is paste in below function 
        ''End Sub
        ''Sub Button_Move_Next_function()
        Try
            Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
            HiddenField_Sample_collection.Value = SDate
            If DropDownList1.SelectedValue = "Days" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
            ElseIf DropDownList1.SelectedValue = "Hours" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
            End If
            'Insert_Values()
            Response.Redirect("Pathology_Payment.aspx")

        Catch ex As Exception
            Response.Write(ex.Message & " Insert Values 826")
        End Try
    End Sub

    Sub Insert_Values()
        Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        HiddenField_Sample_collection.Value = SDate
        If DropDownList1.SelectedValue = "Days" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
        ElseIf DropDownList1.SelectedValue = "Hours" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
        End If
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", HiddenField_Sample_collection.Value)
        param = mycommand.Parameters.AddWithValue("@Sample_No", TextBox_Sample_number.Text)
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", HiddenField_Report_Date.Value)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", TextBox_Grand_discount.Text)
        param = mycommand.Parameters.AddWithValue("@Description", TextBoxDescription.Text)
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", RadioButtonList_Type.SelectedValue)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", 0)
        param = mycommand.Parameters.AddWithValue("@From_Dept_ID", 0)
        param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", 0)
        param = mycommand.Parameters.AddWithValue("@To_Dept_ID", Session("dept_id"))
        param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", Session("SubDeptID"))
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Function Pt_Type(ByVal RegNo As String, ByVal yearlyno As Integer) As String
        Dim da_Basic As New Pt_Radiology_TestTableAdapters.Pt_Basic_DataTableAdapter
        Dim ds_Basic As New Pt_Radiology_Test
        da_Basic.Fill(ds_Basic.Tables("Pt_Basic_Data"), RegNo, yearlyno)
        PAtient_Type = ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("Patient_Type")
        Return PAtient_Type
    End Function

    Protected Sub TextBox_Grand_discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Grand_discount.TextChanged
        TotalDiscount()
    End Sub

    Function TotalDiscount() As Integer
        Dim count As Integer = 0
        Dim total_Discount As Integer = 0
        Try
            'Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView_Services.Rows.Count - 1
                    Dim lbl_count As Label = GridView_Services.Rows(i).FindControl("Label1")
                    count = count + CInt(lbl_count.Text)
                Next
                'Response.Write(count)
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then
                    Else
                        total_Discount = CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        total_Discount = CInt(per_discount)
                    End If
                End If
            End If
            TextBox_Total_Price.Text = count - total_Discount
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return total_Discount
    End Function

    Protected Sub TextBox5_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox5.TextChanged
        'Response.Write("dsfdsf")
        'TotalDiscount()
        'Response.Write("end")
    End Sub

    Protected Sub DropDownList_Discount_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Discount_Type.SelectedIndexChanged
        TotalDiscount()
    End Sub

    Sub Payment_Button_Save()
        Try
            Dim RegNo As String = Session("registrationNo")
            Dim YearlyNo As Integer = Session("YearlyNo")
            HiddenFieldTotalAmount.Value = CInt(TextBox_Grand_total.Text)
            HiddenFieldTotalPaid.Value = CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            HiddenFieldTotal_Discount.Value = TotalDiscount()
            HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
            Insert_Test_Info()
            SqlDataSourceInsertSub.Insert()
            Update_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update Path_Result_Delivery set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "update_status")
        End Try
    End Sub

    Sub Insert_Test_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_ID from Test_Booking_Services Where RegNo = @RegNo and YearlyNo = @YearlyNo ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("Insert_Pt_Pathology_Test_Amount", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@RID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@Reg_No", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Main_ID(Session("registrationNo"), Session("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Protected Sub TextBox6_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim TestName As String = ""
        HiddenField_Flag.Value = True
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_Name From Test_Booking where TB_ID= " & TextBox6.Text, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            TestName = mycommand.ExecuteScalar
            mycommand.Connection.Close()
            TextBox_Test.Text = TestName
        Catch ex As Exception
            Response.Write(ex.Message & " Select Test Name")
        End Try
    End Sub

    Protected Sub TextBox_Address_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Address.TextChanged
        Try
            '======= this is the function that calll after the clicked the save button ==============
            'Response.Write("addasddasdsa")
            If TextBox_Address.Text = "" Then
                Dim sb As New StringBuilder
                sb.Append("<script language='javascript' type='text/javascript'>alert('Enter the Address Information');</script>")
                Dim t As Type = Me.GetType
                If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                End If
            Else
                DateOfBirth()
                Try
                    main()
                Catch ex As Exception
                    Response.Write("june" & ex.Message)
                End Try

                Panel1.Visible = True
                Panel3.Visible = True
                Select_Sample_No()
                If Pt_Type(Session("registrationNo"), Session("YearlyNo")) = "OPD" Then
                    Panel2.Visible = True
                    Panel3.Visible = True
                End If
            End If
        Catch ex As Exception
            Response.Write("May" & ex.Message)
        End Try
    End Sub
End Class