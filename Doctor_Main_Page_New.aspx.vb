Imports System.Data
Imports System.Data.SqlClient

Partial Class Doctor_Main_Page_New
    Inherits System.Web.UI.Page
    Dim obj As New GenerateXML
    'Dim obj1 As New GenerateXML
    Dim ENC As New Encryption
    Dim MessageTo As New ArrayList
    Dim AddRecipents As New ArrayList
    Dim MeetingAtt As New ArrayList
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString

    Dim Pt_Reg_No As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'DataListSubDepartment.DataBind()
        Dim obj_mess As New PatientAppointment

        If Not Page.IsPostBack Then
            'txtDateFrom.Text = Date.Now.ToString("yyyy-MM-dd")
            'txtDateTo.Text = Date.Now.ToString("yyyy-MM-dd")
            txtDate.Text = Date.Now.ToString("yyyy-MM-dd")
            bindSub()
            Try
                ddlSubDept.SelectedValue = Session("SubDeptId")
                ddlSubDept.Enabled = False
                ' ddlSubDept.Enabled = True
                ddlDoctors.DataBind()
                ddlDoctors.SelectedValue = Session("emp_id")
                ddlDoctors.Enabled = False

            Catch ex As Exception

            End Try
            
            'Fill_DataList("5555")

            Dim dte As DateTime = Date.Now
            Session.Add("LogType", Request.QueryString("Type"))
            If Request.QueryString("Type") = "Assessment" Or Request.QueryString("Type") = "Nutrition" Then
                ddlDoctors.Visible = False
            End If


            BindAppointmentList()

        End If
    End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Fill_DataList(0)
    'End Sub
    Protected Sub bindSub()
        Try
            Dim dbm As DbManager = New DbManager()
            Dim query = "SELECT DISTINCT SubDepartment.SubDept_Name,SubDepartment.SubDept_Id FROM SubDepartment WHERE SubDepartment.SubDept_Type = @SubDept_Type"
            Dim sp As SqlParameter() = {New SqlParameter("@SubDept_Type", "1")}
            ddlSubDept.DataSource = dbm.ExecuteDataTableWithQuery(query, "Basic_Data_ConnectionString", sp)
            ddlSubDept.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Sub Fill_DataList(ByVal subDept As Integer)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select_Patient_For_Main_Page", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@DoctorID", ddlDoctors.SelectedValue)
            'If TextBoxPFName.Text.Trim() = "" Then
            command.Parameters.AddWithValue("@PFName", "%")
            'Else
            '    command.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(ENC.TitleCase(TextBoxPFName.Text), True))
            'End If

            'If TextBoxRegNo.Text = "" Then
            command.Parameters.AddWithValue("@RegNo", "%")
            'Else
            '    command.Parameters.AddWithValue("@RegNo", ENC.Encrypt_Main(TextBoxRegNo.Text, True))
            'End If

            'If TextBoxYearlyNo.Text = "" Then
            command.Parameters.AddWithValue("@yearlyNo", 0)
            'Else
            '    command.Parameters.AddWithValue("@yearlyNo", TextBoxYearlyNo.Text)
            'End If
            command.Parameters.AddWithValue("@Deptid", Session("DeptId"))
            command.Parameters.AddWithValue("@request_type_id", 1)
            command.Parameters.AddWithValue("@SubDept_id", subDept)
            command.Parameters.AddWithValue("@HospitalId", Session("HospitalId"))
            command.Parameters.AddWithValue("@DateFrom", txtDate.Text)
            command.Parameters.AddWithValue("@DateTo", txtDate.Text)

            con.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = command
            ds.Reset()
            da.Fill(ds, "PatientDataList")


        Catch ex As Exception

        End Try
    End Sub
    'Protected Sub DropDownListDept_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.PreRender
    '    If Not Page.IsPostBack Then
    '        DropDownListDept.Items.Insert(0, New ListItem("All", 0))
    '        DropDownListDept.SelectedValue = Session("dept_id")

    '        DataListSubDepartment.DataBind()
    '    End If
    'End Sub
    Protected Sub LinkButtonName_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim d As LinkButton = sender
        Session.Add("payid", d.CommandArgument)


        Response.Redirect("~/Pt_EMR/OPD_Encounter_Form.aspx?RegNo=" + d.ToolTip + "&PayID=" + d.CommandArgument + "")
    End Sub

    'Protected Sub DropDownListDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.SelectedIndexChanged
    '    Fill_DataList(0)
    'End Sub

    Function visit(ByVal regno As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("select Max(Payment.PayID) from Payment where Payment.RegNo =@Reg_no", con)
        command.Parameters.AddWithValue("@Reg_no", regno)
        con.Open()
        Return command.ExecuteScalar
        con.Close()
    End Function
    Function IPD_OPD(ByVal Pay_Id As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("select Patient_Type from Payment where Payment.Payid =@Yealry_No", con)
        command.Parameters.AddWithValue("@Yealry_No", Pay_Id)
        con.Open()
        Return command.ExecuteScalar
        con.Close()
    End Function

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

        Return appdate
    End Function

    Protected Sub LinkButton_AddAppointment_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("PatientAppointment_box.aspx")
    End Sub

    Protected Sub LinkButton2_Click(ByVal sender As Object, ByVal e As System.EventArgs)


    End Sub

    Protected Sub lnkPrefix_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim Mycell As DataListItem = CType(CType(sender, Control).Parent, DataListItem)

        'Dim index As Integer = Mycell.ItemIndex
        'Dim Label_RegNo As Label = DataList_ViewPtInfo.Items(index).FindControl("Label_RegNo")
        'Dim Label_YearlyNo As Label = DataList_ViewPtInfo.Items(index).FindControl("Label_YearlyNo")

        'Dim MyUrl As String = "Pt_EMR/Pt_Diagnosis.aspx?RegNo="
        'MyUrl = MyUrl & HiddenField_Reg_No.Value
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub SqlDataSourceInsert_Message_Main_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourceInsert_Message_Main.Inserted
        HiddenFieldMessage_ID.Value = e.Command.Parameters("@Message_Id").Value
    End Sub

    Protected Sub lblViewCompleteRecipients_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbtn As LinkButton = sender
        Dim gvr As GridViewRow = lbtn.NamingContainer
        Dim lblShort As Label = gvr.FindControl("lblShort")
        Dim lblLong As Label = gvr.FindControl("lblLong")
        lblShort.Visible = False
        lblLong.Visible = True
        lbtn.Visible = True
    End Sub

    Protected Sub LinkButton2_Click1(sender As Object, e As System.EventArgs)
        Dim lik As LinkButton = sender
        Session("RegNo") = lik.CommandArgument
        Response.Redirect("Pt_EMR/pt_path_test_new.aspx")

    End Sub

    Protected Sub lnkbtnPatient_Click(sender As Object, e As System.EventArgs)
        Dim linkbtn As LinkButton = sender
        Dim YearlyNo As String = linkbtn.CommandArgument
        Dim reg As String = linkbtn.ToolTip

        Session.Add("YearlyNo", YearlyNo)
        Session.Add("registrationNo", reg)

        Dim jmenu As JavaScriptMenu = New JavaScriptMenu()
        Dim templateId As String = jmenu.Template_id()
        Response.Redirect("~/pt_EMR/OPD_Encounter_Form.aspx")

    End Sub

    Protected Sub lnkbtnCheckupStatus_Click(sender As Object, e As System.EventArgs)
        Response.Redirect("~/pt_EMR/PatientChart.aspx?RegNo=" & Session("registrationNo") & "&YearlyNo=" & Session("YearlyNo"))
    End Sub

    Protected Sub BindAppointmentList()

        If Session("emp_id") <> Nothing Then
            Dim d As DayOfWeek = DateTime.Now.DayOfWeek

            Dim dbManager As DbManager = New DbManager()
            Dim ds As DataSet = dbManager.ExecuteDataSet("uspGetDateWiseDoctorAppointmensForDoctorMainPage_New", "Basic_Data_ConnectionString", New SqlParameter() {
                                     New SqlParameter("@vdate", txtDate.Text),
                                     New SqlParameter("@Doctor_ID", ddlDoctors.SelectedValue),
                                     New SqlParameter("@RegNo", txtMrNo.Text.Trim()),
                                     New SqlParameter("@MobileNo", txtMobileNo.Text.Trim()),
                                     New SqlParameter("@Status", ddlCheckUpStatus.SelectedValue),
                                     New SqlParameter("@SubDept_Id", ddlSubDept.SelectedValue)
                                     })
            gvdLoadData.DataSource = ds
            gvdLoadData.DataBind()

        End If
    End Sub


    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        'Fill_DataList(0)
        BindAppointmentList()
    End Sub

End Class