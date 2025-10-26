Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data
Imports System.Configuration

Partial Class AttendenceList
    Inherits System.Web.UI.Page
    Dim TotalWorkingDays As Integer
    Protected Sub DropDownList_desg_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.DataBound
        DropDownList_desg.Items.Insert(0, "All")
        DropDownList_desg.Items(0).Value = "%"
    End Sub
    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        'Dropdownlistdepartment.Items.Insert(0, "All")
        'Dropdownlistdepartment.Items(0).Value = 0
    End Sub
    Protected Sub DropDownList1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.DataBound
        DropDownList1.Items.Insert(0, "All")
        DropDownList1.Items(0).Value = "%"
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        HF_Status.Value = 1

        Attendance_Search()

        'If WebdatechooserAttendanceDate.Value > WebDateChooser_Start_Date.Value And WebdatechooserAttendanceDate.Value < WebDateChooser_end_Date.Value Then

        '    Label_Alert.Visible = False
        'Else
        '    Label_Alert.Visible = True
        'End If



    End Sub
    Sub Attendance_Search()
        Try
            Dim Start_date As DateTime = WebDateChooser_Start_Date.Value
            Dim end_date As DateTime = WebDateChooser_end_Date.Value
            Dim attendance_Sdate As DateTime = WebdatechooserAttendanceDate.Value
            Dim attendance_Edate As DateTime = WebdatechooserAttendanceEDate.Value

            HiddenField_Start_Date.Value = CStr(Start_date.Month) + "/" + CStr(Start_date.Day) + "/" + CStr(Start_date.Year)
            HiddenField_end_Date.Value = CStr(end_date.Month) + "/" + CStr(end_date.Day) + "/" + CStr(end_date.Year)
            HiddenField_AttendanceDate.Value = CStr(attendance_Sdate.Month) + "/" + CStr(attendance_Sdate.Day) + "/" + CStr(attendance_Sdate.Year)
            Dim Attendence_E_date As String = CStr(attendance_Edate.Month) + "/" + CStr(attendance_Edate.Day) + "/" + CStr(attendance_Edate.Year)
            SqlDataSource1.SelectParameters("Aend_Date").DefaultValue = Attendence_E_date
            GridView1.DataBind()
            '=====================================================
            PreviousMonth()
            HolyDays()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub HolyDays()
        Dim i As Integer = 0
        Dim Salary_days As Integer = 0, Attendence_date As Integer = 0
        TextBox_AfterAttendance.Text = "0"

        Dim StartDay As Integer = 0
        Dim Start_date As DateTime = WebDateChooser_Start_Date.Value
        Dim end_date As DateTime = WebDateChooser_end_Date.Value
        Dim AttendanceSDate As DateTime = WebdatechooserAttendanceDate.Value
        Dim AttendanceEDate As DateTime = WebdatechooserAttendanceEDate.Value
        Salary_days = end_date.DayOfYear - Start_date.DayOfYear + 1
        Attendence_date = AttendanceEDate.DayOfYear - AttendanceSDate.DayOfYear + 1
        TextBox_Totaldays.Text = Salary_days

        Dim remainingdays As Integer = Salary_days - Attendence_date
        ' txtMonthDays.Text = Salary_days

        '  =======================================================
        '         Latest imran
        '  =======================================================
        Dim connect As String = Convert.ToString(ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString"))
        Dim con As New SqlConnection(connect)
        Dim qry As String = "SELECT Count(*) FROM Holiday WHERE  (Holiday_Date BETWEEN @From_Date AND @ToDate) "
        Dim cmd As New SqlCommand(qry, con)
        Dim cmd1 As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("Dept_Id", Dropdownlistdepartment.SelectedValue)
        cmd.Parameters.AddWithValue("@From_Date", Start_date)
        cmd.Parameters.AddWithValue("@ToDate", end_date)
        'cmd1.Parameters.AddWithValue("Dept_Id", Dropdownlistdepartment.SelectedValue)
        'cmd1.Parameters.AddWithValue("@From_Date", AttendanceSDate)
        'cmd1.Parameters.AddWithValue("@ToDate", AttendanceEDate)
        con.Open()
        TextBox_Holydays.Text = cmd.ExecuteScalar()
        '  TextBox_AfterAttendance.Text = Convert.ToString(remainingdays) ' - Convert.ToUInt32(cmd1.ExecuteScalar()))
        con.Close()
        '  =======================================================
        '        Close
        '  =======================================================

        'For i = Start_date.DayOfYear To end_date.DayOfYear
        '    If Start_date.DayOfWeek = DayOfWeek.Sunday Or Start_date.DayOfWeek = DayOfWeek.Saturday Then
        '        TextBox_Holydays.Text = TextBox_Holydays.Text + 1
        '    ElseIf Start_date.DayOfYear >= AttendanceDate.DayOfYear + 1 Then
        '        If Not (Start_date.DayOfWeek = DayOfWeek.Sunday Or Start_date.DayOfWeek = DayOfWeek.Saturday) Then

        '            TextBox_AfterAttendance.Text = TextBox_AfterAttendance.Text + 1
        '        End If
        '    End If
        'Start_date = DateAdd(DateInterval.Day, 1, Start_date)
        'Next

        TextBox_Totaldays.Text = CInt(TextBox_Totaldays.Text) - CInt(TextBox_Holydays.Text)
        HiddenField_TWorkingDays.Value = TextBox_Totaldays.Text
        TextBox_Holydays.Text = 0
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        For count As Integer = 0 To GridView1.Rows.Count - 1

            Dim Start_date As DateTime = WebDateChooser_Start_Date.Value
            Dim end_date As DateTime = WebDateChooser_end_Date.Value
            Dim attendance_date As DateTime = WebdatechooserAttendanceDate.Value
            HiddenField_Start_Date.Value = CStr(Start_date.Month) + "/" + CStr(Start_date.Day) + "/" + CStr(Start_date.Year)
            HiddenField_end_Date.Value = CStr(end_date.Month) + "/" + CStr(end_date.Day) + "/" + CStr(end_date.Year)
            HiddenField_AttendanceDate.Value = CStr(attendance_date.Month) + "/" + CStr(attendance_date.Day) + "/" + CStr(attendance_date.Year)

            Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField_emp_ID")
            Dim hid_late_comming As HiddenField = GridView1.Rows(count).FindControl("HiddenField_late_Comming")
            HiddenField_late_Comming.Value = hid_late_comming.Value
            HiddenField_Emp_ID.Value = hid.Value
            Dim Mac_att As HiddenField = GridView1.Rows(count).FindControl("HiddenFieldMachine_att")
            HiddenField_Machine_Attendance.Value = Mac_att.Value 'GridView1.Rows(count).Cells(5).Text
            Dim txt As TextBox = GridView1.Rows(count).FindControl("TextBox_Oth_Att")
            HiddenField_Other_Attendance.Value = txt.Text

            Dim HiddenFieldDES As HiddenField = GridView1.Rows(count).FindControl("HiddenField_DESIG_ID")
            Dim HiddenFieldDEPT As HiddenField = GridView1.Rows(count).FindControl("HiddenField_DEPT_ID")
            Dim HiddenFieldSUBDEPT As HiddenField = GridView1.Rows(count).FindControl("HiddenField_SUBDEPT_ID")

            HiddenField_CurrntDesigID.Value = HiddenFieldDES.Value
            HiddenField_CurrntDeptId.Value = HiddenFieldDEPT.Value
            HiddenField_CurrntSubDeptId.Value = HiddenFieldSUBDEPT.Value

            Dim txt1 As TextBox = GridView1.Rows(count).FindControl("TextBox_Leave")
            HiddenField_Leave.Value = txt1.Text
            Dim txt2 As TextBox = GridView1.Rows(count).FindControl("TextBox1")
            HiddenField_Over_Time.Value = txt2.Text

            HiddenField_Deducted.Value = GridView1.Rows(count).Cells(7).Text
            Dim val As DateTime = WebDateChooser_end_Date.Value
            HiddenField_month.Value = val.Month
            HiddenField_year.Value = val.Year
            '========================================
            Dim txtsalarydays As TextBox = GridView1.Rows(count).FindControl("TextBox_SalaryDays")
            If String.IsNullOrEmpty(txtsalarydays.Text) Then
                txtsalarydays.Text = "0"

            End If
            HiddenField_SalaryDays.Value = txtsalarydays.Text.Trim()

            Dim txtPreMinutes As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Min")
            HiddenField_PreMinutes.Value = txtPreMinutes.Text

            Dim txtPreDaysDedected As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Leave")
            HiddenField_PreDaysDeducted.Value = txtPreDaysDedected.Text

            Dim txtRemarks As TextBox = GridView1.Rows(count).FindControl("txtRemarks")
            HiddenField_Remarks.Value = txtRemarks.Text



            Try
                SqlDataSource1.Insert()
            Catch ex As Exception
                Response.Write(ex.Message)
                'SqlDataSource1.Update()
            End Try
            '============================
            HiddenField_PreDaysDeducted.Value = 0
            HiddenField_PreMinutes.Value = 0
            HiddenField_SalaryDays.Value = 0
            HiddenField_Other_Attendance.Value = 0
            HiddenField_late_Comming.Value = 0


        Next
        Label_Mesg.Visible = True
        Label_Mesg.Text = "Save Successfully!"
    End Sub



    Protected Sub Button_Calc_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Calc.Click



        For count As Integer = 0 To GridView1.Rows.Count - 1

            Update_row(count)
        Next
    End Sub
    Sub Update_row(ByVal count As Integer)
        Dim Salarydays As Integer = 0
        Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField_emp_ID")
        HiddenField_Emp_ID.Value = hid.Value
        HiddenField_Machine_Attendance.Value = GridView1.Rows(count).Cells(5).Text
        Dim txt As TextBox = GridView1.Rows(count).FindControl("TextBox_Oth_Att")
        Dim txt1 As TextBox = GridView1.Rows(count).FindControl("TextBox_Leave")
        Dim txtx As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Min")
        Dim txtMA As HiddenField = GridView1.Rows(count).FindControl("HiddenFieldMachine_att")
        Dim txtLWP As TextBox = GridView1.Rows(count).FindControl("txtLWP")
        Dim lbl_Holiday As Label = GridView1.Rows(count).FindControl("lbl_Holidays")
        If txtx.Text = "" Then txtx.Text = 0
        If TextBox_AfterAttendance.Text = "" Then TextBox_AfterAttendance.Text = 0
        If txt1.Text = "" Then txt1.Text = 0
        If txt.Text = "" Then txt.Text = 0
        If txtMA.Value = "" Then txtMA.Value = 0
        If txtLWP.Text = "" Then txtLWP.Text = 0

        Dim Total_Atten_Days As Double = CDbl(txtMA.Value) + CDbl(txt.Text)

        If Total_Atten_Days = 0 Then

            Salarydays = 0 'CInt(txt1.Text) + CInt(txt.Text) + CInt(GridView1.Rows(count).Cells(6).Text) + CInt(TextBox_Holydays.Text) + CInt(TextBox_AfterAttendance.Text)
        Else
            Salarydays = CDbl(txt1.Text) + CDbl(txt.Text) + CDbl(txtMA.Value) + CDbl(TextBox_AfterAttendance.Text) + CDbl(lbl_Holiday.Text)
        End If

        If Salarydays > txtMonthDays.Text Then
            Salarydays = txtMonthDays.Text

        End If

        'Dim txtPreDaysDedected As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Leave")

        '========================================
        Dim txtsalarydays As TextBox = GridView1.Rows(count).FindControl("TextBox_SalaryDays")

        'If txtPreDaysDedected.Text = "" Then
        '    txtPreDaysDedected.Text = 0
        'End If

        txtsalarydays.Text = Salarydays '- (CInt(txtPreDaysDedected.Text))



        'If CInt(txtsalarydays.Text) > (CInt(TextBox_Holydays.Text) + CInt(TextBox_Totaldays.Text)) Then
        '    txtsalarydays.Text = Convert.ToString((CInt(TextBox_Holydays.Text) + CInt(TextBox_Totaldays.Text)))

        'End If

    End Sub

    Sub PreviousMonth()
        Dim PreviousMonth As Integer = 0
        If Month(WebDateChooser_Start_Date.Value) = 1 Then
            PreviousMonth = 12
        Else
            PreviousMonth = Month(WebDateChooser_Start_Date.Value) - 1
        End If
        Dim ds As New EmployeeSalaries
        Dim da As New EmployeeSalariesTableAdapters.Employee_PreviousMonthTableAdapter
        da.Fill_PreviousMonth(ds.Tables("Employee_PreviousMonth"), PreviousMonth)

        For count As Integer = 0 To GridView1.Rows.Count - 1
            Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField_emp_ID")
            Dim txtPreDaysDedected As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Leave")
            Dim txtPreMinutes As TextBox = GridView1.Rows(count).FindControl("TextBox_Pre_Min")
            For i As Integer = 0 To ds.Tables("Employee_PreviousMonth").Rows.Count - 1
                If ds.Tables("Employee_PreviousMonth").Rows(i).Item("EmpID") = hid.Value Then
                    txtPreDaysDedected.Text = ds.Tables("Employee_PreviousMonth").Rows(i).Item("Leave_Deducted")
                    txtPreMinutes.Text = ds.Tables("Employee_PreviousMonth").Rows(i).Item("Minute_Deduct")
                End If
            Next
            '========================================

        Next
    End Sub

    Protected Sub TextBox_TCPHolyDat_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_TCPHolyDat.TextChanged
        TextBox_Totaldays.Text = CInt(HiddenField_TWorkingDays.Value) - TextBox_TCPHolyDat.Text

    End Sub

    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.SelectedIndexChanged
        'Attendance_Search()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            'DropdownlistHospital.SelectedValue = "0"



            'WebDateChooser_Start_Date.Value = New DateTime(DateTime.Now.Year, DateTime.Now.AddMonths(-1).Month, 26)
            'WebDateChooser_end_Date.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 25)

            'WebdatechooserAttendanceDate.Value = New DateTime(DateTime.Now.Year, DateTime.Now.AddMonths(-1).Month, 26)
            'WebdatechooserAttendanceEDate.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 25)

            DropdownlistHospital.DataBind()
            ddlMonths.DataBind()
            ddlMonths.SelectedValue = Date.Now.Month
            ChooseDatesDefault()
            Attendance_Search()
            'WebDateChooser_Start_Date.Value = New DateTime(DateTime.Now.Year, DateTime.Now.AddMonths(-1).Month, 26)
            'WebDateChooser_end_Date.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 25)

            'WebdatechooserAttendanceDate.Value = New DateTime(DateTime.Now.Year, DateTime.Now.AddMonths(-1).Month, 26)
            'WebdatechooserAttendanceEDate.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 25)

            'RadioButtonList_EmployeeType.SelectedValue = 1
            '12/22/2010 12:20:30 PM 
            'old code commented by MW
            '_Start
            'Dim todaydte As Date = Date.Now
            ''Response.Write()
            'Dim dtTest As New DateTime(2014, 2, 24)
            'dtTest = Convert.ToString(dtTest)

            'Dim dt As New DateTime(Convert.ToInt32(todaydte.Year), Convert.ToInt32(todaydte.Month), 25)
            'WebdatechooserAttendanceDate.Value = dt.ToString("dd/MM/yyyy")
            '' = Convert.ToDateTime(CStr(todaydte.Month) + "/25/" + CStr(todaydte.Year))

            'Dim dt2 As New DateTime(Convert.ToInt32(todaydte.Year), Convert.ToInt32(todaydte.Month), 1)
            ''WebDateChooser_Start_Date.Value = Convert.ToDateTime(CStr(todaydte.Month) + "/01/" + CStr(todaydte.Year))
            'WebDateChooser_Start_Date.Value = dt2.ToString("dd/MM/yyyy")

            'Dim dt3 As New DateTime(Convert.ToInt32(todaydte.Year), Convert.ToInt32(todaydte.Month), 28)
            'WebDateChooser_end_Date.Value = dt3.ToString("dd/MM/yyyy")
            ''Convert.ToDateTime(CStr(todaydte.Month) + "/" + "28" + "/" + CStr(todaydte.Year))
            '_End
        End If
    End Sub
    Private Sub ChooseDatesDefault()
        Try
            Dim dv As DataView = CType(sqlDs_SalaryDates.Select(DataSourceSelectArguments.Empty), DataView)
            Dim dt As DataTable = dv.Table
            Dim day As Integer, month As Integer, year As Integer, totalWorkingDays As Integer, monthDays As Integer, day_after As Integer
            Dim isLastMonthDate As Boolean
            day = Integer.Parse(dt.Rows(0)(1).ToString())
            isLastMonthDate = Boolean.Parse(dt.Rows(0)(2).ToString())
            month = Integer.Parse(ddlMonths.SelectedValue)
            year = DateTime.Now.Year
            Dim dtStart As DateTime = New DateTime(year, month, day)

            Dim td As DateTime = New DateTime(Date.Now.Year, ddlMonths.SelectedValue, DateTime.DaysInMonth(dtStart.Year, dtStart.Month))
            If isLastMonthDate = True Then
                dtStart = dtStart.AddMonths(-1)
            End If
            Dim endDate As DateTime = dtStart.AddMonths(1).AddDays(-1)
            'WebDateChooser_Start_Date.Value = dtStart
            'WebDateChooser_end_Date.Value = endDate
            'WebdatechooserAttendanceDate.Value = dtStart
            'WebdatechooserAttendanceEDate.Value = td

            'Dim month As Integer, year As Integer
            month = Integer.Parse(ddlMonths.SelectedValue)

            If month = 1 Then
                WebDateChooser_Start_Date.Value = New DateTime(DateTime.Now.Year - 1, 12, 26)
            Else
                WebDateChooser_Start_Date.Value = New DateTime(DateTime.Now.Year, month - 1, 26)
            End If

            WebDateChooser_end_Date.Value = New DateTime(DateTime.Now.Year, month, 25)

            If month = 1 Then
                WebdatechooserAttendanceDate.Value = New DateTime(DateTime.Now.Year - 1, 12, 26)
            Else
                WebdatechooserAttendanceDate.Value = New DateTime(DateTime.Now.Year, month - 1, 26)
            End If


            WebdatechooserAttendanceEDate.Value = New DateTime(DateTime.Now.Year, month, 25)




            totalWorkingDays = (endDate - dtStart).TotalDays + 1
            monthDays = (endDate - dtStart).TotalDays + 1
            day_after = 31 - (CDate(WebdatechooserAttendanceEDate.Value) - td).TotalDays
            TextBox_Totaldays.Text = totalWorkingDays.ToString()
            txtMonthDays.Text = monthDays.ToString()
            TextBox_AfterAttendance.Text = day_after
            TextBox_AfterAttendance.Text = "0"
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender

        If GridView1.Rows.Count < 1 Then
            Label_Mesg.Text = "Attendance For " + Dropdownlistdepartment.SelectedItem.Text + "Has Been Forwarded"
            Label_Mesg.Visible = True
            If HF_Status.Value = 1 Then
                For Each row As GridViewRow In GridView1.Rows
                    Dim hf_OA As HiddenField = row.FindControl("HiddenField_OA")
                    Dim TXT_OA As TextBox = row.FindControl("TextBox_Oth_Att")
                    TXT_OA.Text = hf_OA.Value

                Next

            End If
            HF_Status.Value = 0
        Else
        Label_Mesg.Visible = False

        End If

    End Sub


    Protected Sub WebDateChooser_end_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_end_Date.ValueChanged
        'WebdatechooserAttendanceDate.Value = WebDateChooser_end_Date.Value
    End Sub

    Protected Sub DropdownlistHospital_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropdownlistHospital.SelectedIndexChanged
        'ChooseDatesDefault()
        'Attendance_Search()
        Dropdownlistdepartment.DataBind()
    End Sub

    Protected Sub ddlMonths_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlMonths.SelectedIndexChanged
        ChooseDatesDefault()
        'Attendance_Search()
    End Sub

    Protected Sub TextBox_Oth_Att_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim txt As TextBox = sender
        text_change(txt)

    End Sub
    Protected Sub text_change(ByRef txt As TextBox)
        Dim row As GridViewRow = txt.NamingContainer
        Dim index As Integer = row.RowIndex
        Update_row(index)
    End Sub

    Protected Sub TextBox_Leave_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim txt As TextBox = sender
        text_change(txt)
    End Sub

    Protected Sub TextBox_SalaryDays_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim txt As TextBox = sender
        If CDec(txt.Text) > CInt(txtMonthDays.Text) Then
            'txt.Text = txtMonthDays.Text
            txtMonthDays.Text = txt.Text
        End If
        Dim row As GridViewRow = txt.NamingContainer
        Dim txt_OA As TextBox = row.FindControl("TextBox_Oth_Att")
        Dim txt_lev As TextBox = row.FindControl("TextBox_Leave")
        Dim txt_pre As TextBox = row.FindControl("TextBox_Pre_Min")
        Dim txtPreDaysDedected As TextBox = row.FindControl("TextBox_Pre_Leave")
        Dim Remaining As Decimal = 0.0
        Remaining = CDec(txt.Text) - CDec(row.Cells(6).Text) - CDec(txt_OA.Text) + CDec(txtPreDaysDedected.Text)
        If Remaining > 0 Then
            txt_OA.Text = Remaining

        End If

    End Sub

    Protected Sub WebdatechooserAttendanceDate_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebdatechooserAttendanceDate.ValueChanged

    End Sub

    Protected Sub TextBox_SalaryDays_TextChanged1(sender As Object, e As EventArgs)
        'Dim txt As TextBox = sender
        'If CDec(txt.Text) > CInt(txtMonthDays.Text) Then
        '    'txt.Text = txtMonthDays.Text
        '    txtMonthDays.Text = txt.Text
        'End If
        'Dim row As GridViewRow = txt.NamingContainer
        'Dim txt_OA As TextBox = row.FindControl("TextBox_Oth_Att")
        'Dim txt_lev As TextBox = row.FindControl("TextBox_Leave")
        'Dim txt_pre As TextBox = row.FindControl("TextBox_Pre_Min")
        'Dim txtPreDaysDedected As TextBox = row.FindControl("TextBox_Pre_Leave")
        'Dim Remaining As Decimal = 0.0
        'Remaining = CDec(txt.Text) - CDec(row.Cells(6).Text) - CDec(txt_OA.Text) + CDec(txtPreDaysDedected.Text)
        'If Remaining > 0 Then
        '    txt_OA.Text = Remaining

        'End If

    End Sub
End Class
