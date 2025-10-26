Imports System.Data
Imports System.Data.SqlClient

Partial Class Doctor_Main_Page
    Inherits System.Web.UI.Page
    Dim obj As New GenerateXML
    'Dim obj1 As New GenerateXML
    Dim ENC As New Encryption
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString

    Dim Pt_Reg_No As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DataListSubDepartment.DataBind()
        If Not Page.IsPostBack Then
            Fill_DataList(0)
            Critical_Reading()
            Procedures()
            If Session("Flag") = "1" Then
                Session.Remove("Flag")
                'Response.Write("viewPatientAppointment_box.aspx")
                'Response.Redirect("viewPatientAppointment_box.aspx")
            End If

            Dim dte As DateTime = Date.Now
            getstartEndDateofWeek(dte.DayOfWeek, dte)
            Load_Doctor_List()
            Panel_App.Visible = False
        End If
        'Response.Write(Session("Emp_Id").ToString())
        'Response.Write(Session("Dept_Id").ToString())
        obj.Height = 816
        obj.Width = 228
        obj.FlashName = "patients_ward2.swf?dept_id=13"
        obj.FlashVariable = "patients_ward2?dept_id=13"
        obj.ProcedureName = "Select_Total_Patient_For_XML"
        obj.ConStr = "Reg_ConnectionString"
        obj.Dept_ID = 0
        obj.FileName = "ward_Patient.xml"
        obj.Create_XML()
        Label1.Text = obj.Create_Object()

        

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''





        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


        Dim str_main As String = "<?xml version=""1.0"" encoding=""utf-8""?><root>"
        Dim string_sub As String = ""

        obj.ConStr = "NurseConnectionString"
        obj.XMLType = "reading"
        obj.Dept_ID = Session("dept_id")
        obj.ProcedureName = "Select_Critical_Reading_For_XML"
        obj.FileName = "critical_readings.xml"
        obj.CreateXML_Enc_Patient()

        obj.ConStr = "STOREConnectionString"
        obj.ProcedureName = "Store_Item_Issue_XML"
        obj.XMLType = "issue"
        obj.FileName = "medicine_issue.xml"
        obj.Dept_ID = 47
        obj.CreateXML_Issue_Medicine()

        obj.ConStr = "STOREConnectionString"
        obj.ProcedureName = "Store_Item_Receive_XML"
        obj.XMLType = "recieve"
        obj.FileName = "medicine_recieve.xml"
        obj.Dept_ID = 47
        obj.CreateXML_Issue_Medicine()
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        obj.ConStr = "OperationTheaterConnectionString"
        obj.ProcedureName = "Operation_List"
        obj.FileName = "procedures.xml"
        obj.XMLType = "today"
        obj.Create_XML_For_Procedures()


        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        string_sub = string_sub + obj.XML_Return_String_Store("fast", "Fast_Moving_Store_Items_XML", "STOREConnectionString")
        string_sub = string_sub + obj.XML_Return_String_Store("slow", "Slow_Moving_Store_Items_XML", "STOREConnectionString")
        str_main = str_main + string_sub + "</root>"
        Dim path As String = HttpContext.Current.Server.MapPath("")
        Dim file_name As String = path + "\" + "medicine_usage.xml"
        My.Computer.FileSystem.WriteAllText(file_name, str_main, False)

        If Not IsPostBack Then
            Fill_DataList(Session("subdeptid"))
        End If

    End Sub
    Public Sub Critical_Reading()
        Dim ds As New DoctorMainPage
        Dim da As New DoctorMainPageTableAdapters.Select_Critical_Reading_For_XMLTableAdapter
        da.Fill(ds.Tables("Select_Critical_Reading_For_XML"), Convert.ToInt32(Session("Dept_Id")))
        'da.Fill(ds.Tables("Select_Critical_Reading_For_XML"), Session("Dept_Id"))
        If ds.Tables("Select_Critical_Reading_For_XML").Rows.Count <> 0 Then
            For i As Integer = 0 To ds.Tables("Select_Critical_Reading_For_XML").Rows.Count - 1
                ds.Tables("Select_Critical_Reading_For_XML").Rows(i).Item("Prefix") = ds.Tables("Select_Critical_Reading_For_XML").Rows(i).Item("Prefix") + " " + ENC.Encrypt_Main(ds.Tables("Select_Critical_Reading_For_XML").Rows(i).Item("PFName"), False) + " " + ENC.Encrypt_Main(ds.Tables("Select_Critical_Reading_For_XML").Rows(i).Item("PMName"), False) + " " + ENC.Encrypt_Main(ds.Tables("Select_Critical_Reading_For_XML").Rows(i).Item("PLName"), False)
            Next
        End If
        DataList_CriticalReading.DataSource = ds.Tables("Select_Critical_Reading_For_XML")
        DataList_CriticalReading.DataBind()
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Fill_DataList(0)
    End Sub
    Sub Fill_DataList(ByVal subDept As Integer)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select_Patient_For_Nurse_MainPage", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@DoctorID", Session("Emp_Id"))
            If TextBoxPFName.Text = "" Then
                command.Parameters.AddWithValue("@PFName", "%")
            Else
                command.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(ENC.TitleCase(TextBoxPFName.Text), True))
            End If

            If TextBoxRegNo.Text = "" Then
                command.Parameters.AddWithValue("@RegNo", "%")
            Else
                command.Parameters.AddWithValue("@RegNo", ENC.Encrypt_Main(TextBoxRegNo.Text, True))
            End If

            If TextBoxYearlyNo.Text = "" Then
                command.Parameters.AddWithValue("@yearlyNo", 0)
            Else
                command.Parameters.AddWithValue("@yearlyNo", TextBoxYearlyNo.Text)
            End If
            command.Parameters.AddWithValue("@Deptid", DropDownListDept.SelectedValue)
            command.Parameters.AddWithValue("@request_type_id", 1)
            command.Parameters.AddWithValue("@SubDept_id", subDept)
            con.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = command
            da.Fill(ds, "PatientDataList")
            DataList1.DataSource = ds.Tables(0)
            DataList1.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub DropDownListDept_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.PreRender
        If Not Page.IsPostBack Then
            DropDownListDept.Items.Insert(0, New ListItem("All", 0))
            DropDownListDept.SelectedValue = Session("dept_id")
            DataList1.DataBind()
            DataListSubDepartment.DataBind()
        End If
    End Sub

    Protected Sub DataList1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.PreRender
        For i As Integer = 0 To DataList1.Items.Count - 1
            Dim lnkName As LinkButton = DataList1.Items(i).FindControl("LinkButtonName")
            Dim lblprfix As Label = DataList1.Items(i).FindControl("PrefixLabel")
            Dim lblPFName As Label = DataList1.Items(i).FindControl("PFNameLabel")
            Dim lblPMName As Label = DataList1.Items(i).FindControl("PMNameLabel")
            Dim lblPLName As Label = DataList1.Items(i).FindControl("PLNameLabel")
            Dim lblRegNo As Label = DataList1.Items(i).FindControl("LabelRegNo")
            lnkName.Text = lblprfix.Text + " " + ENC.Encrypt_Main(lblPFName.Text, False) + " " + ENC.Encrypt_Main(lblPMName.Text, False) + " " + ENC.Encrypt_Main(lblPLName.Text, False)
            lblRegNo.Text = ENC.Encrypt_Main(lblRegNo.Text, False)
        Next
    End Sub

    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged
        Label3.Text = "select"
        Dim lblregno As HiddenField = DataList1.Items(DataList1.SelectedIndex).FindControl("HiddenField_reg_no")
        'Dim lblpayid As HiddenField = DataList1.Items(DataList1.SelectedIndex).FindControl("HiddenField_pay_ID")

        'Session.Add("val", lblregno.Text)
        Session.Add("registrationno", lblregno.Value)
        Dim a As String
        a = visit(lblregno.Value)
        Session.Add("yearlyno", a)
        Response.Redirect("~/Nursing/Nursing_Notes.aspx?RegNo=" & lblregno.Value)
        ' Me.Parent.ref()
       ' Response.Redirect("PatientBasicInfo_Iframe.aspx")
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "refresh", "var url = window.opener.location.href; window.opener.location.href = url;", True)

    End Sub

    Protected Sub DataListSubDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListSubDepartment.SelectedIndexChanged
        Fill_DataList(DataListSubDepartment.SelectedValue)
        DataList1.Visible = True
        Panel_App.Visible = False
    End Sub



    Protected Sub DropDownListDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.SelectedIndexChanged
        Fill_DataList(0)
    End Sub

    Protected Sub LinkButton_Private_Patient_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Private_Patient.Click
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT ISNULL(Patient.Prefix, '') AS Prefix, ISNULL(Patient.PFName, '') AS PFName, ISNULL(Patient.PMName, '') AS PMName, ISNULL(Patient.PLName, '') AS PLName, Patient.Age, Patient.AgeType, CONVERT(varchar, Patient.DateOfBirth, 107) AS DateOfBirth, Gender.Gender, Payment.Diagonosis, Payment.RegNo, Payment.PayID, dbo.Function_Bed_No(Payment.RegNo, Payment.PayID) AS BedNo FROM         Patient INNER JOIN Payment ON Patient.RegNo = Payment.RegNo INNER JOIN Gender ON Patient.SexID = Gender.Gender_ID where Payment.DoctorID=@DoctorID  AND Payment.DeptID=69", con)
        command.Parameters.AddWithValue("@DoctorID", Session("emp_id"))
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = command
        da.Fill(ds, "PatientDataList")
        DataList1.DataSource = ds.Tables(0)
        DataList1.DataBind()
        DataList1.Visible = True
        Panel_App.Visible = False

    End Sub

    Protected Sub LinkButtonName_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub



    Protected Sub DataList_Pathology_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_Pathology.PreRender
        If DataList_Pathology.Items.Count <> 0 Then
            For i As Integer = 0 To DataList_Pathology.Items.Count - 1
                Dim hfRegNo As HiddenField = DataList_Pathology.Items(i).FindControl("HiddenField_RegNo")
                Dim Reg_No As Label = DataList_Pathology.Items(i).FindControl("RegNoLabel")
                Dim PrefixLabel As Label = DataList_Pathology.Items(i).FindControl("PrefixLabel")
                Dim hfPrefix As HiddenField = DataList_Pathology.Items(i).FindControl("hfPrefix")
                Dim HiddenField_PFName As HiddenField = DataList_Pathology.Items(i).FindControl("HiddenField_PFName")
                Dim HiddenField_PMName As HiddenField = DataList_Pathology.Items(i).FindControl("HiddenField_PMName")
                Dim HiddenField_PLName As HiddenField = DataList_Pathology.Items(i).FindControl("HiddenField_PLName")
                Reg_No.Text = ENC.Encrypt_Main(hfRegNo.Value, False)
                PrefixLabel.Text = hfPrefix.Value + " " + ENC.Encrypt_Main(HiddenField_PFName.Value, False) + " " + ENC.Encrypt_Main(HiddenField_PMName.Value, False) + " " + ENC.Encrypt_Main(HiddenField_PLName.Value, False)
            Next
        End If
    End Sub
    Public Sub Procedures()
        Dim ds As New DoctorMainPage
        Dim da As New DoctorMainPageTableAdapters.Operation_ListTableAdapter
        da.Fill(ds.Tables("Operation_List"), CInt(Session("Emp_ID")))

        If ds.Tables("Operation_List").Rows.Count <> 0 Then
            For i As Integer = 0 To ds.Tables("Operation_List").Rows.Count - 1
                ds.Tables("Operation_List").Rows(i).Item("Prefix") = ds.Tables("Operation_List").Rows(i).Item("Prefix") + " " + ENC.Encrypt_Main(ds.Tables("Operation_List").Rows(i).Item("PFName"), False) + " " + ENC.Encrypt_Main(ds.Tables("Operation_List").Rows(i).Item("PMName"), False) + " " + ENC.Encrypt_Main(ds.Tables("Operation_List").Rows(i).Item("PLName"), False) + " " + ds.Tables("Operation_List").Rows(i).Item("Relation")
                ds.Tables("Operation_List").Rows(i).Item("RegNo") = ENC.Encrypt_Main(ds.Tables("Operation_List").Rows(i).Item("RegNo"), False)
            Next
        End If

        DataList_OperationList.DataSource = ds.Tables("Operation_List")
        DataList_OperationList.DataBind()
    End Sub

    Protected Sub DataList_OperationList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_OperationList.SelectedIndexChanged

        Try

            Dim lblregno As Label = DataList_OperationList.Items(DataList_OperationList.SelectedIndex).FindControl("Label_RegNo")
            Dim Label_YearlyNo As Label = DataList_OperationList.Items(DataList_OperationList.SelectedIndex).FindControl("Label_YearlyNo")
            'Dim lblpayid As HiddenField = DataList1.Items(DataList1.SelectedIndex).FindControl("HiddenField_pay_ID")
            'Response.Write(lblregno.Text)
            'Session.Add("val", lblregno.Text)
            Session.Add("registrationno", lblregno.Text)
            Session("YearlyNo") = Label_YearlyNo.Text
            Dim a As String
            a = visit(ENC.Encrypt_Main(lblregno.Text, True))
            Session.Add("yearlyno", a)
            Response.Redirect("~/Pt_EMR/Pt_Diagnosis.aspx?RegNo=" & ENC.Encrypt_Main(lblregno.Text, True).ToString() & "YearlyNo=" & Label_YearlyNo.Text)
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub lnkAppointment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lnkAppointment.Click
        Panel_App.Visible = True
        DataList1.Visible = False
    End Sub

    Protected Sub DataList_CriticalReading_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_CriticalReading.SelectedIndexChanged

        Try
            Dim hfRegNo As HiddenField = DataList_CriticalReading.SelectedItem.FindControl("hfRegNo")
            Dim hfYearlyNo As HiddenField = DataList_CriticalReading.SelectedItem.FindControl("hfYearlyNo")
            Session.Add("YearlyNo", hfYearlyNo.Value)
            ' Response.Write(hfRegNo.Value)
            Response.Redirect("~/NursingNotesView.aspx?RegNo=" + hfRegNo.Value)
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub DataList_RadiologyTest_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_RadiologyTest.PreRender
        Try

            For i As Integer = 0 To DataList_RadiologyTest.Items.Count - 1
                Dim lblPrefix As Label = DataList_RadiologyTest.Items(i).FindControl("PrefixLabel")
                Dim hfPrefix As HiddenField = DataList_RadiologyTest.Items(i).FindControl("hfPrefix")
                Dim hfPFName As HiddenField = DataList_RadiologyTest.Items(i).FindControl("HiddenField_PFName")
                Dim hfPMName As HiddenField = DataList_RadiologyTest.Items(i).FindControl("HiddenField_PMName")
                Dim hfPLName As HiddenField = DataList_RadiologyTest.Items(i).FindControl("HiddenField_PLName")
                Dim hfRegNo As HiddenField = DataList_RadiologyTest.Items(i).FindControl("HiddenField_Reg_No")
                Dim lblRegNo As Label = DataList_RadiologyTest.Items(i).FindControl("Reg_NoLabel")
                lblPrefix.Text = hfPrefix.Value + " " + ENC.Encrypt_Main(hfPFName.Value, False) + " " + ENC.Encrypt_Main(hfPMName.Value, False) + " " + ENC.Encrypt_Main(hfPLName.Value, False)
                lblRegNo.Text = ENC.Encrypt_Main(hfRegNo.Value, False)


            Next
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub DataList_DOCTOR_CALL_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_DOCTOR_CALL.PreRender
        Try

            For i As Integer = 0 To DataList_DOCTOR_CALL.Items.Count - 1
                Dim linkbtn_Pt As LinkButton = DataList_DOCTOR_CALL.Items(i).FindControl("LinkButton_Patient")
                Dim hfPrefix As HiddenField = DataList_DOCTOR_CALL.Items(i).FindControl("hfPrefix")
                Dim hfPFName As HiddenField = DataList_DOCTOR_CALL.Items(i).FindControl("HiddenField_PFName")
                Dim hfPMName As HiddenField = DataList_DOCTOR_CALL.Items(i).FindControl("HiddenField_PMName")
                Dim hfPLName As HiddenField = DataList_DOCTOR_CALL.Items(i).FindControl("HiddenField_PLName")
                Dim hfRegNo As HiddenField = DataList_DOCTOR_CALL.Items(i).FindControl("HiddenField_Reg_No")
                Dim lblRegNo As Label = DataList_DOCTOR_CALL.Items(i).FindControl("Label_RegNo")
                linkbtn_Pt.Text = hfPrefix.Value + " " + ENC.Encrypt_Main(hfPFName.Value, False) + " " + ENC.Encrypt_Main(hfPMName.Value, False) + " " + ENC.Encrypt_Main(hfPLName.Value, False)
                lblRegNo.Text = ENC.Encrypt_Main(hfRegNo.Value, False)


            Next
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub DataList_DOCTOR_CALL_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_DOCTOR_CALL.SelectedIndexChanged
        Try
            Dim hfRegNo As HiddenField = DataList_DOCTOR_CALL.Items(DataList_DOCTOR_CALL.SelectedIndex).FindControl("HiddenField_Reg_No")
            Dim lblpayid As Label = DataList_DOCTOR_CALL.Items(DataList_DOCTOR_CALL.SelectedIndex).FindControl("Label_YearlyNo")
            Session.Add("registrationno", hfRegNo.Value)
            Session.Add("yearlyno", lblpayid.Text)
            Response.Redirect("~/Pt_EMR/Pt_Diagnosis.aspx?RegNo=" + hfRegNo.Value)
        Catch ex As Exception
            Response.Write(ex.Message)

        End Try
        
    End Sub


    ' Data List Code-------------------------------------------------------------


    Public Sub Load_Doctor_List()

        Dim ds As New Appointment
        Dim da_DoctorList As New AppointmentTableAdapters.DoctorListTableAdapter
        Dim da_Week_Appointment As New AppointmentTableAdapters.Select_Week_Appointment_For_DoctorTableAdapter
        Try
            da_DoctorList.FillBy(ds.Tables("DoctorList"), Session("Emp_Id"))
            'da_DoctorList.Fill(ds.Tables("DoctorList"))
            'da_Week_Appointment.Fill(ds.Tables("Select_Week_Appointment_For_Doctor"), Session("Sdate"), Session("edate"))
            da_Week_Appointment.Fill(ds.Tables("Select_Week_Appointment_For_Doctor"), HiddenField_Sdate.Text, HiddenField_Edate.Text)
        Catch ex As Exception

        End Try

        For i As Integer = 0 To ds.Tables("DoctorList").Rows.Count - 1
            For j As Integer = 0 To ds.Tables("Select_Week_Appointment_For_Doctor").Rows.Count - 1
                If ds.Tables("DoctorList").Rows(i).Item("EmpID") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Doctor_ID") Then
                    If ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Monday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Monday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Tuesday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Tuesday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Wednesday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Wednesday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Thursday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Thursday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Friday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Friday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Saturday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Saturday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    ElseIf ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Day_Name") = "Sunday" Then
                        ds.Tables("DoctorList").Rows(i).Item("Sunday") = ds.Tables("Select_Week_Appointment_For_Doctor").Rows(j).Item("Appointment")
                    End If
                End If
            Next

        Next
        DataList_DoctorsList.DataSource = ds.Tables("DoctorList")
        DataList_DoctorsList.DataBind()
    End Sub


    Public Sub getstartEndDateofWeek(ByVal weekday As String, ByVal dte As DateTime)
        GetWeekday(weekday, dte)
    End Sub

    Public Sub GetWeekday(ByVal weekday As Double, ByVal dte As DateTime)
        If dte.AddDays(1 - weekday).Day >= 1 And dte.AddDays(1 - weekday).Day <= 9 Then
            HiddenField_Sdate.Text = CStr(dte.AddDays(1 - weekday).Year) + "-0" + CStr(dte.AddDays(1 - weekday).Day) + "-" + CStr(dte.AddDays(1 - weekday).Month) + " 00:00:00"
            Session.Add("Sdate", dte.AddDays(1 - weekday))

        Else
            HiddenField_Sdate.Text = CStr(dte.AddDays(1 - weekday).Year) + "-" + CStr(dte.AddDays(1 - weekday).Day) + "-" + CStr(dte.AddDays(1 - weekday).Month) + " 00:00:00"
            Session.Add("Sdate", dte.AddDays(1 - weekday))
        End If

        If dte.AddDays(7 - weekday).Day >= 1 And dte.AddDays(7 - weekday).Day <= 9 Then
            HiddenField_Edate.Text = CStr(dte.AddDays(7 - weekday).Year) + "-0" + CStr(dte.AddDays(7 - weekday).Day) + "-" + CStr(dte.AddDays(7 - weekday).Month) + " 00:00:00"
            Session.Add("Edate", dte.AddDays(7 - weekday))
        Else
            HiddenField_Edate.Text = CStr(dte.AddDays(7 - weekday).Year) + "-" + CStr(dte.AddDays(7 - weekday).Day) + "-" + CStr(dte.AddDays(7 - weekday).Month) + " 00:00:00"
            Session.Add("Edate", dte.AddDays(7 - weekday))
        End If

        Label_Edate.Text = Session("Edate")
        Label_Sdate.Text = Session("Sdate")

        Label_Week.Text = "Mon-Sun (" + CStr(Convert.ToDateTime(Label_Sdate.Text).Day) + "/" + CStr(Convert.ToDateTime(Label_Sdate.Text).Month) + "/" + CStr(Convert.ToDateTime(Label_Sdate.Text).Year) + " To " + CStr(Convert.ToDateTime(Label_Edate.Text).Day) + "/" + CStr(Convert.ToDateTime(Label_Edate.Text).Month) + "/" + CStr(Convert.ToDateTime(Label_Edate.Text).Year) + " )"
    End Sub
    Public Sub Load_ViewPatientAppointment()
        Dim ds As New Appointment
        Dim da_VPA As New AppointmentTableAdapters.ViewPatientAppointmentTableAdapter
        Dim da_PtInfo As New AppointmentTableAdapters.Pt_Appointment_InfoTableAdapter

        Dim dat As String = HiddenFieldAppointmentDateTime.Value
        Session.Add("date", dat)
        Session.Add("DayofWeek", HiddenField_DayofWeek.Value)
        Try
            da_VPA.FillBy(ds.Tables("ViewPatientAppointment"), HiddenField_DayofWeek.Value, HiddenField_DoctorID.Value, HiddenFieldAppointmentDateTime.Value.ToString)
            da_PtInfo.FillBy(ds.Tables("Pt_Appointment_Info"), HiddenField_DayofWeek.Value, dat, HiddenField_DoctorID.Value)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try



        For i As Integer = 0 To ds.Tables("ViewPatientAppointment").Rows.Count - 1
            For j As Integer = 0 To ds.Tables("Pt_Appointment_Info").Rows.Count - 1
                If ((ds.Tables("ViewPatientAppointment").Rows(i).Item("Doctor_App_Slot_Id") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Doctor_App_Slot_Id")) And (ds.Tables("ViewPatientAppointment").Rows(i).Item("Doctor_ID") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Doctor_ID"))) Then
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("patient") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("patient")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Complaint") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Complaint")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Appointment") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Appointment")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Pt_Appointment_Time") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Slot_Time")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("App_Type") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("App_Type")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("CellNo") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("CellNo")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("DistrictName") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("DistrictName")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Appoinment_ID") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Appoinment_ID")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Prefix") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Prefix")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("PFName") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("PFName")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("PMName") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("PMName")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("PLName") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("PLName")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Reg_no") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Reg_no")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("S_ID") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("S_ID")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Status") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Status")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Phone") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("PhoneNo")
                    ds.Tables("ViewPatientAppointment").Rows(i).Item("Appointment_Status") = ds.Tables("Pt_Appointment_Info").Rows(j).Item("Appointment_Status")

                End If
            Next
        Next
        DataList_ViewPtInfo.DataSource = ds.Tables("ViewPatientAppointment")
        Session.Add("dt", ds.Tables("ViewPatientAppointment"))
        DataList_ViewPtInfo.DataBind()
    End Sub

    Public Sub load_Labels()
        Try

            Dim con As SqlConnection = New SqlConnection(constr)

            Dim qry As String = "Selected_Date_Appointment_Sumary"
            Dim cmd As SqlCommand = New SqlCommand(qry, con)
            cmd.CommandType = CommandType.StoredProcedure
            con.Open()
            cmd.Parameters.AddWithValue("@EmpID", HiddenField_DoctorID.Value)
            cmd.Parameters.AddWithValue("@Day_Name", HiddenField_DayofWeek.Value)
            cmd.Parameters.AddWithValue("@Date", HiddenFieldAppointmentDateTime.Value.ToString)
            ' cmd.Parameters.AddWithValue("@Admin_Doctor_Time_ID", HiddenField_Admin_Doctor_Time_ID.Value)


            Dim reader As SqlDataReader = cmd.ExecuteReader
            If (reader.Read) Then
                AppointmentLabel1.Text = reader.Item("Appointment").ToString()
                Day_NameLabel1.Text = reader.Item("Day_Name").ToString()

            Else
                AppointmentLabel1.Text = reader.Item("Appointment").ToString()
                Day_NameLabel1.Text = reader.Item("Day_Name").ToString()
            End If

            Label_app_SLabel.Visible = True
            Label_app_ELabel.Visible = True
        Catch ex As Exception

        End Try



    End Sub
    Function visit(ByVal regno As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("select Top(1) (Payment.PayID) from Payment where Payment.RegNo =@Reg_no Order By Payment.Datetime desc", con)
        command.Parameters.AddWithValue("@Reg_no", regno)
        con.Open()
        Return command.ExecuteScalar
        con.Close()
    End Function



    Protected Sub DataList_ViewPtInfo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_ViewPtInfo.SelectedIndexChanged

        ' Label3.Text = "select"
        Dim lblregno As HiddenField = DataList_ViewPtInfo.Items(DataList_ViewPtInfo.SelectedIndex).FindControl("HiddenField_reg_no")

        Session.Add("registrationno", lblregno.Value)
        Dim a As String
        a = visit(lblregno.Value)

        '        Session.Add("yearlyno", a)
        Response.Redirect("Pt_EMR/Pt_Diagnosis.aspx?RegNo=" & lblregno.Value)

        'Dim sb As New StringBuilder
        ''Dim dat As String = HiddenFieldAppointmentDateTime.Value
        ''Session.Add("date", dat)
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('Pt_EMR/Pt_Diagnosis.aspx?RegNo=" + Convert.ToString(lblregno.Value) + "')</script>")
        ''sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Appointment_Report.aspx')</script>")
        'Dim t As Type = Me.GetType()
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        'End If


    End Sub

    Protected Sub DataList_ViewPtInfo_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_ViewPtInfo.PreRender
        If DataList_ViewPtInfo.Items.Count <> 0 Then
            For i As Integer = 0 To DataList_ViewPtInfo.Items.Count - 1
                Dim LinkButton_AddAppointment As HyperLink = DataList_ViewPtInfo.Items(i).FindControl("LinkButton_AddAppointment")
                Dim LinkButton_Cancel As LinkButton = DataList_ViewPtInfo.Items(i).FindControl("LinkButton1")
                Dim LinkButton_OK As LinkButton = DataList_ViewPtInfo.Items(i).FindControl("LinkButton2")
                Dim HiddenField_Appoinment_ID As HiddenField = DataList_ViewPtInfo.Items(i).FindControl("HiddenField_Appoinment_ID")
                Dim HiddenField_Status As HiddenField = DataList_ViewPtInfo.Items(i).FindControl("HiddenField_Status")
                Dim Lnkbtn_3 As LinkButton = DataList_ViewPtInfo.Items(i).FindControl("LinkButton3")
                Dim HiddenField_regNo As HiddenField = DataList_ViewPtInfo.Items(i).FindControl("HiddenField_reg_no")
                If HiddenField_Appoinment_ID.Value = "0" Then
                    LinkButton_AddAppointment.Visible = True
                    LinkButton_Cancel.Visible = False
                    LinkButton_OK.Visible = False
                ElseIf HiddenField_Status.Value = "2" Then
                    LinkButton_AddAppointment.Visible = False
                    LinkButton_Cancel.Visible = False
                    LinkButton_OK.Visible = False
                    Dim a As String
                    a = visit(HiddenField_regNo.Value)
                    Lnkbtn_3.Text = a
                ElseIf HiddenField_Status.Value = "1" Then
                    LinkButton_AddAppointment.Visible = False
                    LinkButton_Cancel.Visible = True
                    LinkButton_OK.Visible = True
                End If





            Next

        End If

    End Sub

    Public Function GetAppointmentDate(ByVal DayName As String) As String
        Dim sdate As DateTime = Session("Sdate")
        Dim i As Integer
        Dim appdate As String = ""
        Select Case DayName
            Case "Monday"
                i = 0
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")

                    Session.Add("ApDateWF", sdate.AddDays(i))
                Else
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                    Session.Add("ApDateWF", sdate.AddDays(i))

                End If
            Case "Tuesday"
                i = 1
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                    Session.Add("ApDateWF", sdate.AddDays(i))

                Else
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                    Session.Add("ApDateWF", sdate.AddDays(i))

                End If
            Case "Wednesday"
                i = 2
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                    Session.Add("ApDateWF", sdate.AddDays(i))

                Else

                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                    Session.Add("ApDateWF", sdate.AddDays(i))

                End If
            Case "Thursday"
                i = 3
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                Else
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                End If
            Case "Friday"
                i = 4
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                Else
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                End If
            Case "Saturday"
                i = 5
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                Else
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                End If
            Case "Sunday"
                i = 6
                If sdate.AddDays(i).Day >= 1 And sdate.AddDays(i).Day <= 9 Then
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-0" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                Else
                    Session.Add("ApDateWF", sdate.AddDays(i))
                    appdate = Convert.ToString(CStr(sdate.AddDays(i).Year) + "-" + CStr(sdate.AddDays(i).Day) + "-" + CStr(sdate.AddDays(i).Month) + " 00:00:00")
                End If
        End Select

        HiddenFieldAppointmentDateTime.Value = appdate
        Label_APP_DATE.Text = Session("ApDateWF")
        Session.Add("AppDate", Convert.ToDateTime(Label_APP_DATE.Text).Date)
        Session.Remove("ApDateWF")
        'Response.Write(Session("ApDateWF"))
        'Response.Write(HiddenFieldAppointmentDateTime.Value)

        Return appdate
    End Function



    Protected Sub DataList_DoctorsList_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_DoctorsList.ItemCommand
        Dim dte As DateTime = Convert.ToDateTime(Label_Sdate.Text)
        getstartEndDateofWeek(dte.DayOfWeek, dte)
        Load_Doctor_List()

        HiddenField_DayofWeek.Value = e.CommandArgument
        HiddenFieldAppointmentDateTime.Value = GetAppointmentDate(HiddenField_DayofWeek.Value)
        Label_AppointmentDate.Text = CStr(Convert.ToDateTime(Label_APP_DATE.Text).Day) + "/" + CStr(Convert.ToDateTime(Label_APP_DATE.Text).Month) + "/" + CStr(Convert.ToDateTime(Label_APP_DATE.Text).Year)
        'Label_AppointmentDate.Text = Mid(HiddenFieldAppointmentDateTime.Value, 6, 2) + "/" + Mid(HiddenFieldAppointmentDateTime.Value, 9, 2) + "/" + Left(HiddenFieldAppointmentDateTime.Value, 4)
        Label_AppointmentDate.Visible = True

        Dim con As New SqlConnection(constr)
        Dim cmd As New SqlCommand("SELECT Day_Abbr FROM Week_Day WHERE (Day_Name = @Day_Name)", con)
        con.Open()
        cmd.Parameters.AddWithValue("@Day_Name", HiddenField_DayofWeek.Value)
        Label_Weekday.Text = cmd.ExecuteScalar()
        Label_Weekday.Visible = True
        con.Close()

    End Sub

    Protected Sub DataList_DoctorsList_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_DoctorsList.SelectedIndexChanged

        Dim HiddenField_EmpID As HiddenField = DataList_DoctorsList.Items(DataList_DoctorsList.SelectedItem.ItemIndex).FindControl("HiddenField_EmpID")
        HiddenField_DoctorID.Value = HiddenField_EmpID.Value
        Dim HiddenField_Ad_Time_ID As HiddenField = DataList_DoctorsList.Items(DataList_DoctorsList.SelectedItem.ItemIndex).FindControl("HiddenField_Ad_Time_ID")
        HiddenField_Admin_Doctor_Time_ID.Value = HiddenField_Ad_Time_ID.Value
        DatalistSelected()
        LinkButton_Print.Visible = True

    End Sub
    Public Sub DatalistSelected()
        Try
            load_Labels()

            Load_ViewPatientAppointment()
            DataList_Search.DataBind()
            DataList_Search.Visible = True
            DataList_SelectDateAppointment.DataBind()
            DataList_SelectDateAppointment.Visible = True
            DataList_ViewPtInfo.DataBind()
            DataList_ViewPtInfo.Visible = True
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub ImageButton_Forward_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward.Click

        Dim dte As DateTime = Convert.ToDateTime(Label_Sdate.Text).AddDays(7)
        getstartEndDateofWeek(dte.DayOfWeek, dte)

        Load_Doctor_List()

        '        ImageButton_Previous.Enabled = True

    End Sub

    Protected Sub ImageButton_Previous_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous.Click
        'Dim s As String = Convert.ToString(Convert.ToDateTime(Label_Sdate.Text).Subtract(Date.Now.Date))
        'If s.Contains("-") Then
        '    ImageButton_Previous.Enabled = False
        'Else

        Dim dte As DateTime = Convert.ToDateTime(Label_Sdate.Text).AddDays(-7)
        getstartEndDateofWeek(dte.DayOfWeek, dte)
        Load_Doctor_List()
        ImageButton_Previous.Enabled = True
        '        End If



    End Sub



    Protected Sub LinkButton_AddAppointment_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("PatientAppointment_box.aspx")
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DataList_ViewPtInfo_CancelCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_ViewPtInfo.CancelCommand
        Dim hid As HiddenField = e.Item.FindControl("HiddenField_Appoinment_ID")
        HiddenField_Appointment_ID.Value = hid.Value
        HiddenField_status.Value = 3
        SqlDataSource_Patient_Appointment.Delete()
    End Sub

    Protected Sub DataList_ViewPtInfo_UpdateCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_ViewPtInfo.UpdateCommand
        Dim enc As New Encryption
        Dim hid As HiddenField = e.Item.FindControl("HiddenField_Appoinment_ID")
        Dim Prefix As HiddenField = e.Item.FindControl("HiddenField_Prefix")
        Dim PFName As HiddenField = e.Item.FindControl("HiddenField_PFName")
        Dim PMName As HiddenField = e.Item.FindControl("HiddenField_PMName")
        Dim PLName As HiddenField = e.Item.FindControl("HiddenField_PLName")
        Dim Reg_no As HiddenField = e.Item.FindControl("HiddenField_reg_no")
        Dim S_ID As HiddenField = e.Item.FindControl("HiddenField_S_ID")
        Dim Doctor_ID As HiddenField = e.Item.FindControl("HiddenField_Doctor_ID")

        HiddenField_Appointment_ID.Value = hid.Value
        HiddenField_Prefix.Value = Prefix.Value
        HiddenField_PFName.Value = enc.Encrypt_Main(PFName.Value, True)
        HiddenField_PMName.Value = enc.Encrypt_Main(PMName.Value, True)
        HiddenField_PLName.Value = enc.Encrypt_Main(PLName.Value, True)
        HiddenField_reg_no.Value = Reg_no.Value
        HiddenField_DoctorID.Value = Doctor_ID.Value
        HiddenField_S_ID.Value = S_ID.Value

        ''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''
        If HiddenField_reg_no.Value = "" Then
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
            Pt_Reg_No = enc.Encrypt_Main(Pt_Reg_No, True)
            mycommand_regNo.Connection.Close()
            HiddenField_reg_no.Value = Pt_Reg_No

            SqlDataSource_Patient_Appointment.Insert()
            SqlDataSource_Patient_Appointment.Update()

        Else

            SqlDataSource_Patient_Appointment.Update()

        End If

        HiddenField_status.Value = 2
        SqlDataSource_Patient_Appointment.Delete()
        Try
            Dim payment_services_object As New Payment_Services
            payment_services_object.Doctor_payment(HiddenField_S_ID.Value, HiddenField_reg_no.Value, HiddenField_YearlyNo.Value, 69, 105, HiddenField_DoctorID.Value)

        Catch ex As Exception

        End Try
        DataList_ViewPtInfo.DataBind()
        '''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''







    End Sub

    Protected Sub SqlDataSource_Patient_Appointment_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Patient_Appointment.Updated
        HiddenField_YearlyNo.Value = e.Command.Parameters("@YearlyNo").Value
    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub



    Protected Sub LinkButton_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Print.Click
        Dim sb As New StringBuilder
        'Dim dat As String = HiddenFieldAppointmentDateTime.Value
        'Session.Add("date", dat)
        sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Appointment_Report.aspx?DoctorID=" + Convert.ToString(HiddenField_DoctorID.Value) + "')</script>")
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Appointment_Report.aspx')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If

    End Sub















End Class

