Imports System.Data
Imports System.Data.SqlClient

Partial Class DashboardMain
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



            BindAppointmentList()

        End If
    End Sub


    Protected Sub LinkButtonName_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim d As LinkButton = sender
        Session.Add("payid", d.CommandArgument)


        Response.Redirect("~/Pt_EMR/Pt_Presenting_Complaint.aspx?RegNo=" + d.ToolTip + "&PayID=" + d.CommandArgument + "")
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



    Protected Sub lnkbtnCheckupStatus_Click(sender As Object, e As System.EventArgs)
        Response.Redirect("~/pt_EMR\PatientChart.aspx?RegNo=" & Session("registrationNo") & "&YearlyNo=" & Session("YearlyNo"))
    End Sub

    Protected Sub BindAppointmentList()

        If Session("emp_id") <> Nothing Then
            Dim d As DayOfWeek = DateTime.Now.DayOfWeek

            Dim dbManager As DbManager = New DbManager()
            Dim ds As DataSet = dbManager.ExecuteDataSet("GetPatientForDoctorMainPage", "Basic_Data_ConnectionString", New SqlParameter() {
                                     New SqlParameter("@vdate", Convert.ToDateTime(txtDate.Text).ToString("dd/MM/yyyy")),
                                     New SqlParameter("@RegNo", txtMrNo.Text.Trim()),
                                     New SqlParameter("@Doctor_ID", Session("emp_id")),
                                     New SqlParameter("@MobileNo", txtMobileNo.Text.Trim()),
                                     New SqlParameter("@Status", ddlCheckUpStatus.SelectedValue)
                                     })
            gvdLoadData.DataSource = ds
            gvdLoadData.DataBind()

        End If
    End Sub

    Protected Sub gvdLoadData_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvdLoadData.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then


            Dim hf As HiddenField = e.Row.FindControl("hf")
            Dim hfstatus As HiddenField = e.Row.FindControl("HiddenField_Status")
            Dim hfregno As HiddenField = e.Row.FindControl("hfRegno")
            Dim CheckUpStatus As LinkButton = e.Row.FindControl("lnkbtnCheckupStatus")
            Dim CheckUpStartSession As LinkButton = e.Row.FindControl("lnkbtnStartSession")


           



            '' If String.IsNullOrEmpty(hfstatus.Value) And Not (String.IsNullOrEmpty(CheckUpStatus.ToolTip)) Then
            If hfstatus.Value = "1" Then
                Dim imgAssesment As Image = DirectCast(e.Row.FindControl("imgAssesment"), Image)
                imgAssesment.Visible = True

            ElseIf hfstatus.Value = "2" Then
                Dim imgLabPending As Image = DirectCast(e.Row.FindControl("imgLabPending"), Image)
                imgLabPending.Visible = True

            ElseIf hfstatus.Value = "3" Then
                Dim imgLabConducted As Image = DirectCast(e.Row.FindControl("imgLabConducted"), Image)
                imgLabConducted.Visible = True

            ElseIf hfstatus.Value = "4" Then
                Dim CheckComplete As Image = DirectCast(e.Row.FindControl("imgCheckComplete"), Image)
                CheckComplete.Visible = True


                'ElseIf hfstatus.Value = "12" Then
                '    Dim imgStatus As Image = DirectCast(e.Row.FindControl("Image1"), Image)
                '    imgStatus.Visible = True


                'ElseIf Not (String.IsNullOrEmpty(hfstatus.Value)) And hfstatus.Value <> "12" And hfstatus.Value <> "6" And hfstatus.Value <> "17" And Not (String.IsNullOrEmpty(CheckUpStatus.ToolTip)) Then

                '    Dim imgStatus As Image = DirectCast(e.Row.FindControl("Image1"), Image)
                '    imgStatus.Visible = True

            End If
        End If

    End Sub
    Protected Sub lnkbtnPatient_Click(sender As Object, e As System.EventArgs)
        Dim linkbtn As LinkButton = sender
        Dim YearlyNo As String = linkbtn.CommandArgument
        Dim reg As String = linkbtn.ToolTip

        Session.Add("YearlyNo", YearlyNo)
        Session.Add("registrationNo", reg)

        Response.Redirect("~/pt_EMR/Pt_Presenting_Complaint.aspx")
        



    End Sub
    Protected Sub lnkbtnCreate_Click(sender As Object, e As EventArgs)
        Dim lnkbtn As LinkButton = sender
        Dim row As GridViewRow = DirectCast(lnkbtn.NamingContainer, GridViewRow)
        Dim hfYearly_No As HiddenField = row.FindControl("hfYearly_No")
        Dim hfRegno As HiddenField = row.FindControl("hfRegno")
        Response.Redirect("~/Pt_EMR/AddEditDialysisPatient.aspx?RegNo=" + hfRegno.Value + "&Yearlyno=" + hfYearly_No.Value + "")

    End Sub


    Protected Sub lnkbtnStartSession_Click(sender As Object, e As EventArgs)

        Dim lnkbtn As LinkButton = sender
        Dim row As GridViewRow = DirectCast(lnkbtn.NamingContainer, GridViewRow)
        Dim hfYearly_No As HiddenField = row.FindControl("hfYearly_No")
        Dim hfRegno As HiddenField = row.FindControl("hfRegno")

        Session("registrationno") = hfRegno.Value
        Session("yearlyno") = hfYearly_No.Value

        Response.Redirect("~/Pt_EMR/DialysisSessionStart.aspx?RegNo=" + hfRegno.Value + "&Yearlyno=" + hfYearly_No.Value + "")

    End Sub




    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        'Fill_DataList(0)
        BindAppointmentList()
    End Sub
    Protected Sub gvdLoadData_SelectedIndexChanged(sender As Object, e As EventArgs) Handles gvdLoadData.SelectedIndexChanged


    End Sub

    


End Class