Imports System.Data
Imports System.Data.SqlClient

Partial Class HR_EmployeeSummaryAttendance
    Inherits System.Web.UI.Page
    Dim status As Boolean
    Dim statusCheckBox As Boolean
    Dim conString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            WebDateChooser_Start_Date.Value = Date.Now()
            HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
            WebDateChooser_end_Date.Value = Date.Now()
            HiddenField_end_Date.Value = WebDateChooser_end_Date.Value

            DDLForYear.SelectedValue = DateTime.Now.Date.Year
            DDLForMonth.SelectedValue = DateTime.Now.Date.Month

           
            'DDL_Company.DataBind()
            'DDL_Company.SelectedValue = Session("Hospital_Id")
            'DDL_Branch.DataBind()
            'DDL_Branch.SelectedValue = Session("Dept_Id")
            'DDL_Sold_By.DataBind()
            'DDL_Sold_By.SelectedValue = Session("emp_id")

            'DDL_Company.Enabled = False
            'DDL_Branch.Enabled = False
            'DDL_Sold_By.Enabled = False
            'ShowReport()
        End If

    End Sub

    Private Sub ShowReport()

        If RBL_Emp_stat.SelectedValue = 0 Then
            Dim cmd As SqlCommand
            statusCheckBox = False
            btn_Approve.Visible = False

            Dim con As SqlConnection = New SqlConnection(conString)
            Try
                con.Open()
                cmd = New SqlCommand("uspEmployeeSummaryAttendance", con)
                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)                
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()

                con.Close()
            Catch ex As Exception
                con.Close()
            End Try

        ElseIf RBL_Emp_stat.SelectedValue = 1 Then
            Dim cmd As SqlCommand
            status = True
            statusCheckBox = True

            Dim con As SqlConnection = New SqlConnection(conString)
            Try
                con.Open()
                cmd = New SqlCommand("uspEmployeeSummaryShortAttendance", con)
                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)                
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                If dt.Rows.Count > 0 Then
                    btn_Approve.Visible = True

                End If
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()

                con.Close()
            Catch ex As Exception
                con.Close()
            End Try
        ElseIf RBL_Emp_stat.SelectedValue = 2 Then
            Dim cmd As SqlCommand
            status = True
            statusCheckBox = True
            Dim con As SqlConnection = New SqlConnection(conString)
            Try
                con.Open()
                cmd = New SqlCommand("uspEmployeeSummaryHalfAttendance", con)
                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)                
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                If dt.Rows.Count > 0 Then
                    btn_Approve.Visible = True

                End If
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()

                con.Close()
            Catch ex As Exception
                con.Close()
            End Try
        ElseIf RBL_Emp_stat.SelectedValue = 3 Then
            Dim cmd As SqlCommand
            status = False
            statusCheckBox = True

            Dim con As SqlConnection = New SqlConnection(conString)
            Try
                con.Open()
                'cmd = New SqlCommand("uspEmployeeSummaryOverTimeAttendance", con)
                cmd = New SqlCommand("uspEmployeeOvertimeNew", con)

                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                If dt.Rows.Count > 0 Then
                    btn_Approve.Visible = True

                End If
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()

                con.Close()
            Catch ex As Exception
                con.Close()
            End Try

        ElseIf RBL_Emp_stat.SelectedValue = 4 Then
            Dim cmd As SqlCommand
            status = False
            statusCheckBox = True

            Dim con As SqlConnection = New SqlConnection(conString)
            Try
                con.Open()
                cmd = New SqlCommand("uspEmployeeSummaryDoubleOverTimeAttendance", con)
                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)                
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                If dt.Rows.Count > 0 Then
                    btn_Approve.Visible = True

                End If
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()

                con.Close()
            Catch ex As Exception
                con.Close()
            End Try

        ElseIf RBL_Emp_stat.SelectedValue = 5 Then
            Dim cmd As SqlCommand
            status = True
            statusCheckBox = True

            Dim con As SqlConnection = New SqlConnection(conString)
            Try

                cmd = New SqlCommand("uspEmployeeSummaryLateAttendance", con)
                cmd.CommandType = CommandType.StoredProcedure

                Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd")
                Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy-MM-dd")

                cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
                cmd.Parameters.AddWithValue("@DateTo", dateTo)
                cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
                cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
                cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
                cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)                
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                If dt.Rows.Count > 0 Then
                    btn_Approve.Visible = True

                End If
                GrdviewForEmployeeAttendanceSummary.DataSource = dt
                GrdviewForEmployeeAttendanceSummary.DataBind()


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If


        

    End Sub
    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
        HiddenField_end_Date.Value = WebDateChooser_end_Date.Value
        'If String.IsNullOrEmpty(TextBox_Emp.Text.Trim()) Then
        '    HiddenField_empNo.Value = "%"
        'Else
        '    HiddenField_empNo.Value = TextBox_Emp.Text.Trim()

        'End If
        ShowReport()
    End Sub

    Private Sub ReportParameter()
        Throw New NotImplementedException
    End Sub

    Private Sub repParams()
        Throw New NotImplementedException
    End Sub


    Protected Sub btnShortAttendance_Click(sender As Object, e As EventArgs)
        Dim cmd As SqlCommand
        status = False
        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("uspEmployeeSummaryShortAttendance", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            GrdviewForEmployeeAttendanceSummary.DataSource = dt
            GrdviewForEmployeeAttendanceSummary.DataBind()

            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    Protected Sub btnHalfDayAttendnace_Click(sender As Object, e As EventArgs)
        Dim cmd As SqlCommand
        status = True
        statusCheckBox = True
        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("uspEmployeeSummaryHalfAttendance", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            GrdviewForEmployeeAttendanceSummary.DataSource = dt
            GrdviewForEmployeeAttendanceSummary.DataBind()

            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    Protected Sub btnOverTime_Click(sender As Object, e As EventArgs)
        Dim cmd As SqlCommand
        status = False
        statusCheckBox = True

        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("uspEmployeeSummaryOverTimeAttendance", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            GrdviewForEmployeeAttendanceSummary.DataSource = dt
            GrdviewForEmployeeAttendanceSummary.DataBind()

            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    Protected Sub GrdviewForEmployeeAttendanceSummary_DataBinding(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GrdviewForEmployeeAttendanceSummary_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If status = True Then
            e.Row.Cells(11).Visible = False
            e.Row.Cells(12).Visible = False
        End If
        If statusCheckBox = False Then
            e.Row.Cells(13).Visible = False
        End If


    End Sub

    Protected Sub chkBoxSelectAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim ck As CheckBox = DirectCast(sender, CheckBox)

        For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            chinner.Checked = ck.Checked
        Next
    End Sub

    Protected Sub BtnDoubleOvertime_Click(sender As Object, e As EventArgs)
        Dim cmd As SqlCommand
        status = False
        statusCheckBox = True

        Dim con As SqlConnection = New SqlConnection(conString)
        Try

            cmd = New SqlCommand("uspEmployeeSummaryDoubleOverTimeAttendance", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            GrdviewForEmployeeAttendanceSummary.DataSource = dt
            GrdviewForEmployeeAttendanceSummary.DataBind()

            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    Protected Sub btn_Approve_Click(sender As Object, e As EventArgs)
        If RBL_Emp_stat.SelectedValue = 1 Then
            For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                If chinner.Checked = True Then
                    Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    Dim overtime As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblOverTime"), Label)
                    Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)

                    Dim mycommand As New System.Data.SqlClient.SqlCommand("if not exists (SELECT [id]  FROM [Machine_Attendance].[dbo].[PendingLeaves] where emp_id=@Empid and cast(for_date as date)=@forday and LeaveType='S/L') Begin Insert into [Machine_Attendance].[dbo].[PendingLeaves]([emp_id] ,[for_date],[LeaveType],[LeaveDeduction],[Mnth],[Yer],E_ID,LeaveQuantity)VALUES(@Empid,@forday,'S/L','0.3333333333333',@month,@year,@E_ID,1) end", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                    mycommand.Parameters.AddWithValue("@forday", forday.Text)
                    mycommand.Parameters.AddWithValue("@E_ID", 1685)
                    mycommand.Parameters.AddWithValue("@month", DDLForMonth.SelectedValue)
                    mycommand.Parameters.AddWithValue("@year", DDLForYear.SelectedValue)

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()

                End If
            Next
        ElseIf RBL_Emp_stat.SelectedValue = 2 Then
            For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                If chinner.Checked = True Then
                    Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    Dim overtime As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblOverTime"), Label)
                    Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)

                    Dim mycommand As New System.Data.SqlClient.SqlCommand("if not exists (SELECT [id]  FROM [Machine_Attendance].[dbo].[PendingLeaves] where emp_id=@Empid and cast(for_date as date)=@forday and LeaveType='H/L') Begin Insert into [Machine_Attendance].[dbo].[PendingLeaves]([emp_id] ,[for_date],[LeaveType],[LeaveDeduction],[Mnth],[Yer],E_ID,LeaveQuantity)VALUES(@Empid,@forday,'H/L','0.5',@month,@year,@E_ID,1) end", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                    mycommand.Parameters.AddWithValue("@forday", forday.Text)
                    mycommand.Parameters.AddWithValue("@E_ID", 1686)
                    mycommand.Parameters.AddWithValue("@month", DDLForMonth.SelectedValue)
                    mycommand.Parameters.AddWithValue("@year", DDLForYear.SelectedValue)

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()

                End If
            Next
        ElseIf RBL_Emp_stat.SelectedValue = 3 Then
            For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                If chinner.Checked = True Then
                    Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    Dim overtime As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblOverTime"), Label)
                    Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)
                    Dim AttId As HiddenField = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("hfAttendanceID"), HiddenField)
                    Dim DutyTime As HiddenField = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("HfDutyTime"), HiddenField)
                    Dim HourlyOverTime As HiddenField = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("HfOverTimeMinutes"), HiddenField)
                    Dim OverTimeType As HiddenField = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("HfOverTimeType"), HiddenField)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert into [Machine_Attendance].[dbo].[EmpPendingOverTime]([Emp_Id],[Att_Id],[OverTime],[For_date],[Is_Double],[Mnth],[Yer],E_ID,[Attendance_Id],[DutyTime],[HourlyOverTime],OverTimeType) Values (@Empid,1,@overtime,@forday,'false',@month,@year,@E_ID,@AttId,@DutyTime,@HourlyOverTime,@OverTimeType)", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                    mycommand.Parameters.AddWithValue("@forday", forday.Text)
                    mycommand.Parameters.AddWithValue("@overtime", overtime.Text)
                    mycommand.Parameters.AddWithValue("@E_ID", 1675)
                    mycommand.Parameters.AddWithValue("@month", DDLForMonth.SelectedValue)
                    mycommand.Parameters.AddWithValue("@year", DDLForYear.SelectedValue)
                    mycommand.Parameters.AddWithValue("@AttId", AttId.Value)
                    mycommand.Parameters.AddWithValue("@DutyTime", DutyTime.Value)
                    mycommand.Parameters.AddWithValue("@HourlyOverTime", HourlyOverTime.Value)
                    mycommand.Parameters.AddWithValue("@OverTimeType", OverTimeType.Value)
                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()

                End If
            Next
        ElseIf RBL_Emp_stat.SelectedValue = 4 Then
            For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                If chinner.Checked = True Then
                    Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    Dim overtime As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblOverTime"), Label)
                    Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert into [Machine_Attendance].[dbo].[EmpPendingOverTime]([Emp_Id],[Att_Id],[OverTime],[For_date],[Is_Double],[Mnth],[Yer],E_ID) Values (@Empid,1,@overtime,@forday,'true',@month,@year,@E_ID)", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                    mycommand.Parameters.AddWithValue("@forday", forday.Text)
                    mycommand.Parameters.AddWithValue("@overtime", overtime.Text)
                    mycommand.Parameters.AddWithValue("@E_ID", 1675)
                    mycommand.Parameters.AddWithValue("@month", DDLForMonth.SelectedValue)
                    mycommand.Parameters.AddWithValue("@year", DDLForYear.SelectedValue)
                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()

                End If
            Next
        ElseIf RBL_Emp_stat.SelectedValue = 5 Then
            For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                If chinner.Checked = True Then
                    Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)


                    Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)

                    Dim mycommand As New System.Data.SqlClient.SqlCommand("if not exists (SELECT [id]  FROM [Machine_Attendance].[dbo].[PendingLeaves] where emp_id=@Empid and cast(for_date as date)=@forday and LeaveType='late') Begin Insert into [Machine_Attendance].[dbo].[PendingLeaves]([emp_id] ,[for_date],[LeaveType],[LeaveDeduction],[Mnth],[Yer],E_ID,LeaveQuantity)VALUES(@Empid,@forday,'Late',0.3333333333333,@month,@year,@E_ID,1) end", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                    mycommand.Parameters.AddWithValue("@forday", forday.Text)
                    mycommand.Parameters.AddWithValue("@E_ID", 1684)
                    mycommand.Parameters.AddWithValue("@month", DDLForMonth.SelectedValue)
                    mycommand.Parameters.AddWithValue("@year", DDLForYear.SelectedValue)
                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()

                End If
            Next
        End If

        ShowReport()

    End Sub
End Class
