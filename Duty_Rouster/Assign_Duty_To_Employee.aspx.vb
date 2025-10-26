Imports System.Data.SqlClient

Partial Class Assign_Duty_To_Employee
    Inherits System.Web.UI.Page

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Dim startTime As TimeSpan
        Dim endTime As Double
        Dim startHour As Double
        Dim dutyHours As Double
        If DropDownListShiftName.SelectedIndex >= 0 Then
            Try
                For i As Integer = 0 To CheckBoxList_Emp.Items.Count - 1
                    If CheckBoxList_Emp.Items(i).Selected = True Then


                        'code for getting start and end time of shift

                        Dim shift As String = DropDownListShiftName.SelectedValue


                        Dim cnString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                        Dim conn As SqlConnection = New SqlConnection(cnString)
                        Dim query As String = "select StartTime,EndTime from Admin_DutyRoster where Duty_Roster_ID=" + shift
                        Dim cmd As SqlCommand = New SqlCommand(query, conn)
                        conn.Open()
                        Dim reader As SqlDataReader = cmd.ExecuteReader()
                        reader.Read()
                        startTime = reader.GetDateTime(0).TimeOfDay
                        endTime = reader.GetDateTime(1).TimeOfDay.TotalHours
                        startHour = startTime.TotalHours
                        dutyHours = endTime - startHour
                        If dutyHours = 0.0 Then
                            dutyHours = 24
                        End If
                        conn.Close()
                        reader.Close()

                        'end code for shift timing







                        ' HiddenField_Emp_ID.Value = CheckBoxList_Emp.Items(i).Value


                        'Dim myDate As DateTime = Convert.ToDateTime(HiddenField_Date_Start.Value)
                        'While myDate <= Convert.ToDateTime(HiddenField_Date_End.Value)
                        '    'myDate = Convert.ToDateTime(HiddenField_Date_Start.Value)
                        '    HiddenField_MyDate.Value = myDate
                        '    For m As Integer = 0 To CheckBoxList_Day.Items.Count - 1
                        '        If Convert.ToDateTime(HiddenField_MyDate.Value).ToShortDateString() > Convert.ToDateTime(HiddenField_Date_End.Value).ToShortDateString() Then
                        '            Exit For
                        '        End If
                        '        If CheckBoxList_Day.Items(m).Selected = True Then
                        '            HiddenField_WeekDay.Value = CheckBoxList_Day.Items(m).Value
                        '            SqlDataSourceSaveInfo.Insert()
                        '        End If
                        '        HiddenField_MyDate.Value = myDate.AddDays(1).ToString()
                        '        myDate = myDate.AddDays(1)



                        '    Next
                        '    HiddenField_MyDate.Value = myDate.AddDays(1).ToString()
                        '    myDate = myDate.AddDays(1)

                        'End While

                        ''For m As Integer = 0 To CheckBoxList_Day.Items.Count - 1
                        ''    If CheckBoxList_Day.Items(m).Selected = True Then
                        ''        HiddenField_WeekDay.Value = CheckBoxList_Day.Items(m).Value
                        ''        SqlDataSourceSaveInfo.Insert()
                        ''    End If
                        ''Next




                        'code for inserting data in database
                        HiddenField_Emp_ID.Value = CheckBoxList_Emp.Items(i).Value
                        Dim temp1 As DateTime
                        Dim end_date As String = Convert.ToDateTime(HiddenField_Date_End.Value)
                        Dim start_date As String = Convert.ToDateTime(HiddenField_Date_Start.Value)
                        Dim dateCounter As DateTime = Convert.ToDateTime(HiddenField_Date_Start.Value)
                        If ckAlternative.SelectedValue = 0 Then
                            While dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value)
                                temp1 = dateCounter

                                Dim d As Integer = Convert.ToInt32((Convert.ToDateTime(WebDateChooser2.Value) - Convert.ToDateTime(WebDateChooser1.Value)).TotalDays)

                                For m As Integer = 0 To (WebDateChooser2.Value - WebDateChooser1.Value).TotalDays - 1
                                    If dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value) Then

                                        If dutyHours = 24.0 Then
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        Else
                                            HiddenField_Date_Start.Value = HiddenField_Date_Start.Value
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddHours(dutyHours)
                                        End If
                                        If (ckdobleduty.Checked = True) Then

                                            HiddenField_DoubleDuty.Value = 1
                                        Else
                                            HiddenField_DoubleDuty.Value = 0

                                        End If
                                        HiddenField_WeekDay.Value = 1
                                        HiddenFieldOff_Day.Value = 0
                                        dateCounter = dateCounter.AddDays(1)
                                        SqlDataSourceSaveInfo.Insert()
                                        HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        HiddenFieldOff_Day.Value = 1
                                        HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                        SqlDataSourceSaveInfo.Insert()
                                        HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        'dateCounter = dateCounter.AddDays(1)
                                    End If
                                    HiddenField_Date_End.Value = end_date


                                Next
                                If temp1 = dateCounter Then
                                    dateCounter = dateCounter.AddDays(1)
                                    HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                End If
                            End While

                        ElseIf ckAlternative.SelectedValue = 2 Then

                            While dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value)
                                temp1 = dateCounter
                                For m As Integer = 0 To CheckBoxList_Day.Items.Count - 1
                                    If dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value) Then

                                        If dutyHours = 24.0 Then
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        Else
                                            HiddenField_Date_Start.Value = HiddenField_Date_Start.Value
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddHours(dutyHours)
                                        End If

                                        HiddenField_WeekDay.Value = CheckBoxList_Day.Items(m).Value
                                        If WebDateChooser3.Value <> dateCounter And WebDateChooser4.Value <> dateCounter And WebDateChooser5.Value <> dateCounter And WebDateChooser6.Value <> dateCounter And WebDateChooser7.Value <> dateCounter Then

                                            HiddenFieldOff_Day.Value = 1
                                        Else
                                            HiddenFieldOff_Day.Value = 0
                                        End If

                                        SqlDataSourceSaveInfo.Insert()
                                        ' HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)

                                        dateCounter = dateCounter.AddDays(1)
                                        HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                    End If

                                    HiddenField_Date_End.Value = end_date


                                Next
                                If temp1 = dateCounter Then
                                    dateCounter = dateCounter.AddDays(1)
                                    HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                End If
                            End While
                        Else

                            While dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value)
                                temp1 = dateCounter
                                For m As Integer = 0 To CheckBoxList_Day.Items.Count - 1
                                    If CheckBoxList_Day.Items(m).Selected = True And dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value) And CheckBoxList_Day.Items(m).Value = Convert.ToInt16(dateCounter.DayOfWeek) Then
                                        'If dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value) Then

                                        If dutyHours = 24.0 Then
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        Else
                                            HiddenField_Date_Start.Value = HiddenField_Date_Start.Value
                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            HiddenField_Date_End.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddHours(dutyHours)
                                        End If

                                        HiddenFieldOff_Day.Value = 0


                                        HiddenField_WeekDay.Value = CheckBoxList_Day.Items(m).Value

                                        dateCounter = dateCounter.AddDays(1)
                                        SqlDataSourceSaveInfo.Insert()
                                        HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                        HiddenField_Date_End.Value = end_date
                                    Else
                                        If dateCounter <= Convert.ToDateTime(HiddenField_Date_End.Value) Then
                                            HiddenField_WeekDay.Value = CheckBoxList_Day.Items(m).Value
                                            If (ckdobleduty.Checked = True) Then
                                                HiddenFieldOff_Day.Value = 0
                                                HiddenField_DoubleDuty.Value = 1
                                            Else
                                                HiddenField_DoubleDuty.Value = 0
                                                HiddenFieldOff_Day.Value = 1
                                            End If

                                            HiddenField_MyDate.Value = HiddenField_Date_Start.Value
                                            SqlDataSourceSaveInfo.Insert()
                                        End If
                                    End If


                                Next
                                If temp1 = dateCounter Then
                                    dateCounter = dateCounter.AddDays(1)
                                    HiddenField_Date_Start.Value = Convert.ToDateTime(HiddenField_Date_Start.Value).AddDays(1)
                                End If
                            End While
                        End If


                        'End If
                        'Next
                        HiddenField_Date_Start.Value = start_date



                    End If
                Next

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            GridViewEmployeeShift.DataBind()
        Else
            lblMsg.Text = "Please select shift"
        End If
        CheckBoxList_Emp.DataBind()
    End Sub

    Protected Sub WebDateChooser1_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser1.ValueChanged
        Try
            HiddenField_Date_Start.Value = WebDateChooser1.Value
            WebDateChooser2.MinDate = WebDateChooser1.Value
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub WebDateChooser2_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser2.ValueChanged
        Try
            HiddenField_Date_End.Value = WebDateChooser2.Value
            GridViewEmployeeShift.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSourceSaveInfo_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles SqlDataSourceSaveInfo.Selecting

    End Sub

    Protected Sub DropDownListShiftName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListShiftName.SelectedIndexChanged
        GridViewEmployeeShift.DataBind()
    End Sub

    Protected Sub DDlDutyRosterForDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDlDutyRosterForDept.SelectedIndexChanged
        GridViewEmployeeShift.DataBind()
    End Sub

    Protected Sub DDLDutyRosterForSubDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDLDutyRosterForSubDept.SelectedIndexChanged
        GridViewEmployeeShift.DataBind()
    End Sub

    Protected Sub ckAlternative_SelectedIndexChanged(sender As Object, e As EventArgs)
        If (ckAlternative.SelectedValue = 0) Then
            CheckBoxList_Day.Visible = False
            Panel1.Visible = False
        ElseIf ckAlternative.SelectedValue = 1 Then

            CheckBoxList_Day.Visible = True
            Panel1.Visible = False

        ElseIf ckAlternative.SelectedValue = 2 Then
            CheckBoxList_Day.Visible = False
            Panel1.Visible = True

        End If
    End Sub

    Protected Sub DropDownListDepartment_SelectedIndexChanged(sender As Object, e As EventArgs)
        DropDownListSubDepartment.DataBind()
        DDlDutyRosterForDept.DataBind()
        DDLDutyRosterForSubDept.DataBind()
    End Sub

    Protected Sub DropDownListSubDepartment_SelectedIndexChanged(sender As Object, e As EventArgs)
        DDLDutyRosterForSubDept.DataBind()
    End Sub
End Class
