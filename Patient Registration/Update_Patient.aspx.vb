Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.Common
Imports System.Data.SqlClient
Imports System.IO
Partial Class Update_Patient
    Inherits System.Web.UI.Page
    Dim ins_Typ As String
    Dim ins_Insurer As String
    Dim ins_Designation As String
    Dim ins_EmployeeNo As String

    Dim EmployeeNo As Integer
    Dim DT, DateBirth As Date
    Dim PhPhone, PMP, CNIC As String
    '==========================
    Dim File_Path As String = Server.MapPath("~/Patient_picture/")
    Dim fileName As String
    Dim a As Boolean = False
    Dim userid, userid1, DeptID, DeptID1 As Integer
    Dim flag As Integer = 0
    Dim DOB As Integer = 0
    Dim userAuthen As New User_page_Authentication
    Dim classobj As New FileUpload
    Dim Encry As New Encryption
    Dim PatientName As String = ""
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim enc As New Encryption
    Dim AgeDate As String
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Server.Transfer("../login.aspx")
            End If
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try

    End Sub

    Sub Patient_Info()
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("PatientCompleteDetail", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString(0))
            Session.Add("registrationNO", Request.QueryString(0))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "Patient")
            RBLprefix.SelectedValue = ds.Tables(0).Rows(0).Item(1).ToString
            Try
                Session.Add("yearlyno", ds.Tables(0).Rows(0).Item(33).ToString())
            Catch ex As Exception

            End Try
            textboxpfname.Text = enc.Encrypt_Main(ds.Tables(0).Rows(0).Item(2).ToString, False)
            textboxpmname.Text = enc.Encrypt_Main(ds.Tables(0).Rows(0).Item(3).ToString, False)
            textboxplname.Text = enc.Encrypt_Main(ds.Tables(0).Rows(0).Item(4).ToString, False)

            Try
                Dim patientname As String
                patientname = RBLprefix.SelectedItem.Text + " " + textboxpfname.Text + " " + textboxpmname.Text + " " + textboxplname.Text
                Session.Add("patientname", patientname.Trim)
            Catch ex As Exception

            End Try

            RBLrelation.SelectedValue = ds.Tables(0).Rows(0).Item(5).ToString
            textboxrfname.Text = ds.Tables(0).Rows(0).Item(6).ToString
            textboxrmname.Text = ds.Tables(0).Rows(0).Item(7).ToString
            textboxrlname.Text = ds.Tables(0).Rows(0).Item(8).ToString
            sex.SelectedValue = ds.Tables(0).Rows(0).Item(9).ToString
            Try
                Dim cnic As String = ds.Tables(0).Rows(0).Item(25).ToString
                'Dim cnic_val As String
                'cnic_val = cnic.Substring(0, 5) & "-"
                'cnic_val = cnic_val & cnic.Substring(5, 7) & "-"
                'cnic_val = cnic_val & cnic.Substring(12, 1)

                cnic = cnic.Insert(5, "-")
                textboxnic1.Text = cnic.Insert(13, "-")
            Catch ex As Exception

            End Try
            If ds.Tables(0).Rows(0).Item(35).ToString = "0" Then
                DropDownList_Religion.SelectedIndex = -1
            Else
                DropDownList_Religion.SelectedValue = ds.Tables(0).Rows(0).Item(35).ToString
            End If

            If ds.Tables(0).Rows(0).Item(36).ToString = "0" Then
                DropDownList_Nationality.SelectedIndex = -1
            Else
                DropDownList_Nationality.SelectedValue = ds.Tables(0).Rows(0).Item(36).ToString
            End If

            If ds.Tables(0).Rows(0).Item(12).ToString = "0" Then
                country.SelectedIndex = -1
            Else
                country.SelectedValue = ds.Tables(0).Rows(0).Item(12).ToString
            End If


            If ds.Tables(0).Rows(0).Item(13).ToString = "0" Then
                Province.SelectedIndex = -1
            Else
                Province.SelectedValue = ds.Tables(0).Rows(0).Item(13).ToString
            End If


            If ds.Tables(0).Rows(0).Item(14).ToString = "0" Then
                district.SelectedIndex = -1
            Else
                district.SelectedValue = ds.Tables(0).Rows(0).Item(14).ToString
            End If


            If ds.Tables(0).Rows(0).Item(15).ToString = "0" Then
                tehsil.SelectedIndex = -1
            Else
                tehsil.SelectedValue = ds.Tables(0).Rows(0).Item(15).ToString
            End If

            Try
                textboxstreetaddress.Text = ds.Tables(0).Rows(0).Item(17).ToString
            Catch ex As Exception

            End Try


            Try
                textboxcolony.Text = ds.Tables(0).Rows(0).Item(18).ToString
            Catch ex As Exception

            End Try


            Try

                RadioButtonList_Patient_Type.SelectedValue = ds.Tables(0).Rows(0).Item(31).ToString
                HiddenField_PatientType.Value = ds.Tables(0).Rows(0).Item(31).ToString
                If ds.Tables(0).Rows(0).Item(31).ToString = "Panel" Then
                    DropDownList_Parties.Visible = True
                End If
                '   If RadioButtonList_Patient_Type.SelectedValue = "" Then
                'RadioButtonList_Patient_Type.SelectedValue = "Public"
                'End If

            Catch ex As Exception

                'RadioButtonList_Patient_Type.SelectedValue = "Public"

            End Try


            Try
                textboxHouseNo.Text = ds.Tables(0).Rows(0).Item(28).ToString
            Catch ex As Exception

            End Try




            'If ds.Tables(0).Rows(0).Item(16).ToString = "0" Then
            'textboxzipcode.Text = ""
            'Else
            Try
                If ds.Tables(0).Rows(0).Item(16).ToString = 0 Then
                    textboxzipcode.Text = ""
                Else
                    textboxzipcode.Text = ds.Tables(0).Rows(0).Item(16).ToString
                End If

            Catch ex As Exception

            End Try
            Try

                TextBox_passport_No.Text = ds.Tables(0).Rows(0).Item(30).ToString
            Catch ex As Exception

            End Try
            'End If

            Try
                ' textboxcountrycode.Text = ds.Tables(0).Rows(0).Item(22).ToString.Substring(0, 4)
                If ds.Tables(0).Rows(0).Item(22).ToString.Length = 13 Then
                    '  textboxphonecode.Text = ds.Tables(0).Rows(0).Item(22).ToString.Substring(4, 2)
                    textboxphoneno.Text = ds.Tables(0).Rows(0).Item(22).ToString.Substring(6)

                Else
                    '  textboxphonecode.Text = ds.Tables(0).Rows(0).Item(22).ToString.Substring(4, 3)
                    textboxphoneno.Text = ds.Tables(0).Rows(0).Item(22).ToString.Substring(7)
                End If

            Catch ex As Exception

            End Try


            Try
                textboxmcode.Text = ds.Tables(0).Rows(0).Item(23).ToString.Insert(4, "-")
            Catch ex As Exception

            End Try

            Try
                AgeDate = ds.Tables(0).Rows(0).Item(26).ToString
            Catch ex As Exception

            End Try


            Try
                Dim str() As String
                str = ds.Tables(0).Rows(0).Item(26).ToString().Split("/")
                WebDateTimeEdit_DOB.Text = str(1) + "/" + str(0) + "" + "/" + str(2)
            Catch ex As Exception

            End Try

            Try
                TextBox_Email_Address.Text = ds.Tables(0).Rows(0).Item(32).ToString
            Catch ex As Exception

            End Try
            Try
                If ds.Tables(0).Rows(0).Item(34).ToString = "0" Then
                    DropDownList_Parties.SelectedIndex = -1
                Else
                    DropDownList_Parties.SelectedValue = ds.Tables(0).Rows(0).Item(34).ToString
                End If
            Catch ex As Exception

            End Try
            'If ds.Tables(0).Rows(0).Item(29).ToString <> "" Then
            'Image1.Visible = True
            'Image1.ImageUrl = "~" & ds.Tables(0).Rows(0).Item(29).ToString
            'Else
            'Image1.Visible = False
            'End If
            Calculate_DOB(AgeDate)
            Try

                'If ds.Tables(0).Rows(0).Item(37).ToString = "0x00000000" Then
                '    ImageButton1.ImageUrl = "~/images_hacims/picplace.jpg"
                '    ImageButton1.PostBackUrl = "~/images_hacims/picplace.jpg"

                'Else
                '    ImageButton1.ImageUrl = "Patient_pic.aspx"
                '    ImageButton1.PostBackUrl = "Patient_pic.aspx"

                'End If
                If IS_Picture_Available() Then
                    Image_Pic.ImageUrl = "~/ShowImage.ashx?RegNO=" + Session("RegistrationNo").ToString()
                Else
                    Image_Pic.ImageUrl = "~/Patient_picture/picplace.jpg"

                End If


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        Catch ex As Exception

        End Try
    End Sub

    Sub Calculate_DOB(ByVal AgeDate As String)
        Dim Total_Days As Integer = DateDiff(DateInterval.Day, CDate(AgeDate), Date.Now.Date)
        If Total_Days < 31 Then
            textboxage.Text = Total_Days
            DropDownListBIndicator.SelectedValue = "Days"
        ElseIf Total_Days > 31 And Total_Days < 365 Then
            textboxage.Text = CInt(Total_Days / 31)
            DropDownListBIndicator.SelectedValue = "Month"
        ElseIf Total_Days > 365 Then
            textboxage.Text = CInt(Total_Days / 365)
            DropDownListBIndicator.SelectedValue = "Years"
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Add("emp_id", Session("emp_id"))
        WebDateTimeEdit_DOB.MaxValue = Date.Today
        RBLprefix.Attributes.Add("onClick", "show(this)")
        RBLprefix_ot.Attributes.Add("onClick", "show_ot(this)")
        textboxage.Attributes.Add("OnBlur", "showAgedob(this)")
        DropDownListBIndicator.Attributes.Add("onChange", "changeYear()")
        textboxage.Attributes.Add("OnFocus", "showAgedobfocus(this)")


        RBLprefix.Attributes.Add("onClick", "show(this)")
        RBLprefix_ot.Attributes.Add("onClick", "show_ot(this)")
        If Not IsPostBack Then

            Try
                country.DataBind()
                'country.SelectedValue = "90"
                Province.DataBind()
                'Province.SelectedValue = "8"
                district.DataBind()
                ' textboxphonecode.Text = district.SelectedValue
                country_ot.DataBind()
                ''country_ot.SelectedValue = "90"
                Province_ot.DataBind()
                'Province_ot.SelectedValue = "8"
                district_ot.DataBind()
                '			    textboxphonecode_ot.Text = district_ot.SelectedValue


            Catch ex As Exception

            End Try

        End If
        If Page.IsPostBack = False Then

            country.DataBind()
            Province.DataBind()

            district.DataBind()
            sex.DataBind()
            tehsil.DataBind()
            DropDownListBIndicator.DataBind()
            country_ot.DataBind()
            Province_ot.DataBind()
            district_ot.DataBind()
            tehsil_ot.DataBind()

            Patient_Info()
            Try
                nextofkin()
            Catch ex As Exception

            End Try


        End If
        ' If Not Page.IsPostBack Then
        'Try
        'If RadioButtonList_Patient_Type.SelectedItem.Text = "" Then
        'RadioButtonList_Patient_Type.SelectedIndex = 0
        'End If

        'Catch ex As Exception

        'End Try


        'End If

    End Sub

    Protected Sub update()
        DateOfBirth()
        If DropDownList_Parties.Visible = True Then
            HiddenField_Party_ID.Value = DropDownList_Parties.SelectedValue
        Else
            HiddenField_Party_ID.Value = 0
        End If

        HiddenFieldPFName.Value = enc.Encrypt_Main(textboxpfname.Text, True)
        HiddenFieldPMName.Value = enc.Encrypt_Main(textboxpmname.Text, True)
        HiddenFieldPLName.Value = enc.Encrypt_Main(textboxplname.Text, True)
        HiddenField_phone_no.Value = textboxphoneno.Text
        HiddenField_mobile_no.Value = textboxmcode.Text

        Try
            Dim str() As String
            str = WebDateTimeEdit_DOB.Text.Split("/")
            HiddenField_DOB.Value = str(1) + "/" + str(0) + "/" + str(2)
            HiddenField_cnic.Value = textboxnic1.Text
            SqlDataSourceUpdate.Update()

            Try

                Dim fs1 As FileStream = New FileStream(Session("File_Path") + Session("fileName"), FileMode.Open)

                Dim reader As SqlDataReader

                Dim conn As New SqlConnection
                conn.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
                Dim SQL As String = "update [Patient] set [picture]= @picture where RegNo='" + Session("RegistrationNo") + "'"
                Dim myCommand1 As New SqlCommand(SQL, conn)
                Dim b(fs1.Length) As Byte
                fs1.Read(b, 0, fs1.Length)
                myCommand1.Parameters.AddWithValue("@picture", b)
                conn.Open()
                myCommand1.ExecuteNonQuery()
                conn.Close()
            Catch ex As Exception

            End Try
            If HiddenField_PatientType.Value = "Private" And RadioButtonList_Patient_Type.SelectedValue = "Panel" Then
                SqlDataSource_Patient_Services.Update()
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Function IS_Picture_Available() As Boolean
        Dim is_pic As Boolean = False
        Dim con As New SqlConnection(constr)
        Dim qry As String = "SELECT  case when len(Convert(Varchar,ISNULL(Picture, 0))) = 4 then 0 else 1 end AS Picture FROM Patient WHERE (RegNo = @RegNo)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@RegNo", Session("RegistrationNo").ToString)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            If reader.Item("Picture") = "0" Then
                is_pic = False
            Else
                is_pic = True
            End If
        End While

        Return is_pic

    End Function
    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click
        Try
            update()
            Response.Redirect("~/Patient Registration/PatientVisit.aspx?Recomended_Id=999")

        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub
    Sub nextofkin()

        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_OT_PatientRelative_Undertaking", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@PatientRegNo", Request.QueryString(0))
            HiddenField_RegistrationNo.Value = Request.QueryString(0)
            Session.Add("registrationNO", Request.QueryString(0))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "PatientRelative")
            RBLprefix_ot.SelectedValue = ds.Tables(0).Rows(0).Item(1).ToString
            textboxpfname_ot.Text = ds.Tables(0).Rows(0).Item(2).ToString
            textboxpmname_ot.Text = ds.Tables(0).Rows(0).Item(3).ToString
            textboxplname_ot.Text = ds.Tables(0).Rows(0).Item(4).ToString
            RBLrelation_ot.SelectedValue = ds.Tables(0).Rows(0).Item(5).ToString
            textboxrfname_ot.Text = ds.Tables(0).Rows(0).Item(6).ToString
            textboxrmname_ot.Text = ds.Tables(0).Rows(0).Item(7).ToString
            textboxrlname_ot.Text = ds.Tables(0).Rows(0).Item(8).ToString
            'DropDownList_Gender.SelectedValue = ds.Tables(0).Rows(0).Item(9).ToString
            Try
                Dim cnic As String = ds.Tables(0).Rows(0).Item(9).ToString
                cnic = cnic.Insert(5, "-")

                textboxnic1_ot.Text = cnic.Insert(13, "-")

            Catch ex As Exception

            End Try

            country_ot.DataBind()
            country_ot.SelectedValue = ds.Tables(0).Rows(0).Item(11).ToString
            Province_ot.DataBind()
            Province_ot.SelectedValue = ds.Tables(0).Rows(0).Item(12).ToString
            district_ot.DataBind()
            district_ot.SelectedValue = ds.Tables(0).Rows(0).Item(13).ToString
            tehsil_ot.DataBind()
            tehsil_ot.SelectedValue = ds.Tables(0).Rows(0).Item(14).ToString
            Try


                ' textboxcountrycode_ot.Text = ds.Tables(0).Rows(0).Item(15).ToString.Substring(0, 4)
                If ds.Tables(0).Rows(0).Item(15).ToString.Length = 13 Then
                    '   textboxphonecode_ot.Text = ds.Tables(0).Rows(0).Item(15).ToString.Substring(4, 2)
                    textboxphoneno_ot.Text = ds.Tables(0).Rows(0).Item(15).ToString.Substring(6)

                Else
                    '   textboxphonecode_ot.Text = ds.Tables(0).Rows(0).Item(15).ToString.Substring(4, 3)
                    textboxphoneno_ot.Text = ds.Tables(0).Rows(0).Item(15).ToString.Substring(7)
                End If


            Catch ex As Exception

            End Try

            RadioButtonList1_ot.SelectedValue = ds.Tables(0).Rows(0).Item(16).ToString
            DropDownListRelationwithPatient_ot.SelectedValue = ds.Tables(0).Rows(0).Item(17).ToString
            Try
                Dim mobileno As String
                mobileno = ds.Tables(0).Rows(0).Item(18).ToString
                textboxmcode_ot.Text = mobileno.Insert(4, "-")

            Catch ex As Exception

            End Try
            Try
                textboxTown_ot.Text = ds.Tables(0).Rows(0).Item(19).ToString

            Catch ex As Exception

            End Try
            Try
                TextBox_House_Ot.Text = ds.Tables(0).Rows(0).Item(20).ToString

            Catch ex As Exception

            End Try
            Try

                TextBox_Street_OT.Text = ds.Tables(0).Rows(0).Item(21).ToString
            Catch ex As Exception

            End Try

        Catch ex As Exception

        End Try
    End Sub
    Sub DateOfBirth()
        Try
            'If TextBox5.Text = "" Then
            '    Response.Write("Please Enter Age")
            '    Exit Sub
            'Else
            '    If DropDownList_BIndicator.SelectedItem.Text = "Years" Then
            '        HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Year, -(CInt(TextBox5.Text)), Date.Now)
            '    ElseIf DropDownList_BIndicator.SelectedItem.Text = "Months" Then
            '        HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Month, -(CInt(TextBox5.Text)), Date.Now)
            '    ElseIf DropDownList_BIndicator.SelectedItem.Text = "Days" Then
            '        HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Day, -(CInt(TextBox5.Text)), Date.Now)
            '    ElseIf DropDownList_BIndicator.SelectedItem.Text = "Hours" Then
            '        HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Hour, -(CInt(TextBox5.Text)), Date.Now)
            '    End If
            'End If
        Catch ex As Exception
            'Response.Write("PLease Enter Age")
        End Try
    End Sub

    Protected Sub Button_ot_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_ot.Click
        Try
            HiddenField_mobile_Phone.Value = textboxmcode_ot.Text
            HiddenField_phone_no_ot.Value = textboxphoneno.Text
            HiddenFieldNIC_ot.Value = textboxnic1_ot.Text
            SqlDataSource_info_ot.Insert()

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub DropDownList_Province_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        district.DataBind()
        tehsil.DataBind()

    End Sub

    Protected Sub DropDownList_Country_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        district.DataBind()
        tehsil.DataBind()
    End Sub

    Protected Sub DropDownList_District_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        tehsil.DataBind()
    End Sub

    Protected Sub Province_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Province_ot.SelectedIndexChanged
        district_ot.DataBind()
        ''   textboxphonecode_ot.Text = district_ot.SelectedValue
        tehsil_ot.DataBind()
    End Sub

    Protected Sub district_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles district_ot.SelectedIndexChanged
        ''    textboxphonecode_ot.Text = district_ot.SelectedValue
        tehsil_ot.DataBind()
    End Sub

    Protected Sub textboxnic1_ValueChange(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebDataInput.ValueChangeEventArgs)
        Try

            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select count(*) from Patient where CNIC='" + textboxnic1.Text.Replace("-", "") + "'", con)
            command.CommandType = CommandType.Text
            con.Open()
            Dim count As Integer = 0
            count = command.ExecuteScalar
            If count > 0 Then
                If textboxnic1.Text.Replace("-", "") = "" Then

                Else
                    '    Label_CNIC.Visible = True

                    '   Label_CNIC.Text = "Patient with this CNIC Already Registered"

                    '  Label_CNIC.Focus()
                End If


            Else
                If textboxnic1.Text.Replace("-", "") = "" Then

                Else
                    '   Label_CNIC.Visible = True
                    '  Label_CNIC.Text = "This CNIC is Available"
                End If
            End If
            con.Close()


        Catch ex As Exception


        End Try
        'textboxnic1.re()
    End Sub
    Protected Sub DropDownListRelationwithPatient_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListRelationwithPatient_ot.SelectedIndexChanged
        If DropDownListRelationwithPatient_ot.SelectedValue = "Son" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Daughter" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Father" And (RBLrelation.SelectedValue = "S/O" Or RBLrelation.SelectedValue = "D/O") Then
            textboxpfname_ot.Text = textboxrfname.Text
            textboxpmname_ot.Text = textboxrmname.Text
            textboxplname_ot.Text = textboxrlname.Text
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Mother" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Wife" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Husband" And (RBLrelation.SelectedValue = "W/O") Then
            textboxpfname_ot.Text = textboxrfname.Text
            textboxpmname_ot.Text = textboxrmname.Text
            textboxplname_ot.Text = textboxrlname.Text
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Brother" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Sister" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        ElseIf DropDownListRelationwithPatient_ot.SelectedValue = "Other" Then
            textboxpfname_ot.Text = ""
            textboxpmname_ot.Text = ""
            textboxplname_ot.Text = ""
        End If

    End Sub

    Protected Sub district_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        ''  textboxphonecode.Text = district.SelectedValue
        tehsil.DataBind()
    End Sub

    Protected Sub Province_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        district.DataBind()
        '' textboxphonecode.Text = district.SelectedValue
        tehsil.DataBind()

    End Sub

    Protected Sub tehsil_ot_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        ' DateOfBirth()
        ' HiddenFieldPFName.Value = enc.Encrypt_Main(textboxpfname.Text, True)
        ' HiddenFieldPMName.Value = enc.Encrypt_Main(textboxpmname.Text, True)
        ' HiddenFieldPLName.Value = enc.Encrypt_Main(textboxplname.Text, True)
        ' HiddenField_phone_no.Value = textboxphoneno.Text
        ' '' HiddenField_mobile_no.Value = textboxmcode.Value
        Try
            ' Dim str() As String
            ' str = WebDateTimeEdit_DOB.Text.Split("/")
            ' HiddenField_DOB.Value = str(1) + "/" + str(0) + "/" + str(2)
            ' '' HiddenField_cnic.Value = textboxnic1.Value

            ' SqlDataSourceUpdate.Update()
            ' If HiddenField_PatientType.Value = "Private" And RadioButtonList_Patient_Type.SelectedValue = "Panel" Then
            '     SqlDataSource_Patient_Services.Update()
            ' End If

            update()
            Try
                Dim patientname As String
                patientname = RBLprefix.SelectedItem.Text + " " + textboxpfname.Text + " " + textboxpmname.Text + " " + textboxplname.Text
                Session.Add("patientname", patientname.Trim)
            Catch ex As Exception

            End Try

            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript'>")
            sb.Append(" window.open('cardpage.aspx', '_Blank')</script>")
            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If
            WebDateTimeEdit_DOB.Text = ""
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub RadioButtonList_Patient_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.SelectedIndexChanged
        If RadioButtonList_Patient_Type.SelectedValue = "Panel" Then
            DropDownList_Parties.Visible = True

        Else
            DropDownList_Parties.Visible = False
        End If
    End Sub


    Protected Sub Button_attach_pic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_attach_pic.Click
        If FileUpload_image.HasFile = True Then
            fileName = FileUpload_image.FileName
            If System.IO.File.Exists(fileName) Then
                System.IO.File.Delete(fileName)
            End If
            Dim fs As FileStream = New FileStream(File_Path + fileName, FileMode.Create)
            fs.Write(FileUpload_image.FileBytes, 0, FileUpload_image.FileBytes.Length)
            Session("File_Path") = File_Path
            Session("fileName") = fileName
            fs.Close()
        End If

        Image_Pic.ImageUrl = "~/Patient_picture/" + fileName
    End Sub

    Protected Sub Button_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Cancel.Click
        Response.Redirect("~/Patient Registration/PatientVisit.aspx")
    End Sub

    Protected Sub RadioButtonList_Patient_Type_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.PreRender
        fill_insurence()
    End Sub

    Protected Sub RadioButtonList_Patient_Type_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.DataBound
        fill_insurence()
    End Sub
    Sub fill_insurence()




        If RadioButtonList_Patient_Type.SelectedValue = "Private" Then


            Panel2.Visible = False
        Else
            fill_ins()
            'rblRegistrationType.SelectedValue = ins_Typ

            'Try

            '    DropDownList1.SelectedValue = ins_Insurer
            '    DropDownList1.DataBind()
            'Catch ex As Exceptions
            '    DropDownList1.SelectedIndex = -1
            'End Try
            'Try
            '    ddlDesignation.SelectedValue = ins_Designation
            '    ddlDesignation.DataBind()

            'Catch ex As Exception
            '    ddlDesignation.SelectedIndex = -1
            'End Try

            'ddlDesignation.SelectedValue = ins_Designation
            txtEmployeeNo.Text = ins_EmployeeNo
            dsEmployeeDependents.SelectParameters.Item(0).DefaultValue = ins_EmployeeNo
            dsEmployeeDependents.SelectParameters.Item(1).DefaultValue = ins_Insurer
            dsEmployeeDependents.SelectParameters.Item(2).DefaultValue = ins_Designation
            grdEmployeeDependents.DataBind()

        End If


    End Sub
    Sub fill_ins()
        Dim pb As String = Convert.ToString(ConfigurationManager.ConnectionStrings("PatientBillingConnectionString"))
        Dim qry As String
        ' If Session("yearlyno") > 0 Then
        '  qry = "SELECT  Party_Id, Party_Desg_ID,  RegistrationType, Emp_No FROM Party_Medical_Services_Group WHERE     (Reg_No = @regNO) AND (YearlyNo = @YearlyNo)"
        ' Else
        qry = "SELECT top(1)  Party_Id, Party_Desg_ID,  RegistrationType, Emp_No FROM Party_Medical_Services_Group WHERE     (Reg_No = @regNO)"
        '  End If


        Dim i As New SqlConnection(pb)
        Dim m As New SqlCommand(qry, i)
        m.Parameters.AddWithValue("@regNO", Request.QueryString("regno"))

        '  If Not Session("yearlyno") Is Nothing Then
        ' m.Parameters.AddWithValue("@YearlyNo", Convert.ToInt64(Session("yearlyno")))
        '  End If



        i.Open()
        Dim f As SqlDataReader = m.ExecuteReader()
        If (f.Read()) Then
            ins_Typ = f(2).ToString()
            ins_Insurer = f(0)
            ins_Designation = f(1).ToString()
            ins_EmployeeNo = f(3).ToString()

        End If
        i.Close()


    End Sub

    Protected Sub grdEmployeeDependents_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdEmployeeDependents.PreRender
        If grdEmployeeDependents.Rows.Count > 0 Then
            ddlDesignation.Enabled = False
        Else
            ddlDesignation.Enabled = True
        End If

        For i As Integer = 0 To grdEmployeeDependents.Rows.Count - 1
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
End Class
