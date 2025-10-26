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
            DDLMonth.SelectedValue = System.DateTime.Now.Month
            DDLYear.SelectedValue = System.DateTime.Now.Year

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




        Dim con As SqlConnection = New SqlConnection(conString)
        Dim cmd As SqlCommand
        Try
            con.Open()
            cmd = New SqlCommand("uspEmployeeOvertimeCalculation", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", 1)
            'cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            If dt.Rows.Count > 0 Then
                btn_Approve.Visible = True
            End If

            Dim tempDatatable As DataTable = dt.Select("overtime > 0").CopyToDataTable()

              

            GrdviewForEmployeeAttendanceSummary.DataSource = tempDatatable
            GrdviewForEmployeeAttendanceSummary.DataBind()

            con.Close()
        Catch ex As Exception
            con.Close()
        End Try








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





    Protected Sub GrdviewForEmployeeAttendanceSummary_DataBinding(sender As Object, e As EventArgs)

    End Sub

    Protected Sub GrdviewForEmployeeAttendanceSummary_RowDataBound(sender As Object, e As GridViewRowEventArgs)

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim overtime As Label = e.Row.FindControl("lblOverTime")

            If overtime.Text.Contains("-") Then
                overtime.Text = "0"
            End If
        End If
    End Sub

    Protected Sub chkBoxSelectAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim ck As CheckBox = DirectCast(TryCast(sender, Control), CheckBox)

        For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            chinner.Checked = ck.Checked
        Next
    End Sub



    Protected Sub btn_Approve_Click(sender As Object, e As EventArgs)
        lblMsg.Visible = False
        If GrdviewForEmployeeAttendanceSummary.Rows.Count > 0 Then


            'Dim _dbManager As DbManager = New DbManager()
            '_dbManager.ExecuteNonQuery("uspDeleteEmployeeMontlyOverTime_Mac", "Machine_AttendanceConnectionString", New SqlParameter() {New SqlParameter("@Emp_Id", DDL_Sold_By.SelectedValue), New SqlParameter("", ""), New SqlParameter("", "")})

            Try
                For i As Integer = 0 To GrdviewForEmployeeAttendanceSummary.Rows.Count - 1
                    Dim chinner As CheckBox = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                    If chinner.Checked = True Then
                        Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                        Dim overtime As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblOverTime"), Label)
                        Dim forday As Label = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("lblForDate"), Label)
                        Dim HFAttendanceID As HiddenField = DirectCast(GrdviewForEmployeeAttendanceSummary.Rows(i).FindControl("hfAttendanceID"), HiddenField)

                        If Convert.ToInt32(overtime.Text) > 0 Then
                            Dim mycommand As New System.Data.SqlClient.SqlCommand("uspInsertEmployeeMontlyOverTime_Mac", con)
                            mycommand.CommandType = Data.CommandType.StoredProcedure
                            mycommand.Parameters.AddWithValue("@Emp_Id", chinner.ToolTip)
                            mycommand.Parameters.AddWithValue("@For_date", forday.Text)
                            mycommand.Parameters.AddWithValue("@overtime", overtime.Text)
                            mycommand.Parameters.AddWithValue("@Att_Id", HFAttendanceID.Value)
                            mycommand.Parameters.AddWithValue("@ApproveBy", Session("emp_id"))
                            mycommand.Parameters.AddWithValue("@SalaryMonth", DDLMonth.SelectedValue)
                            con.Open()
                            mycommand.ExecuteNonQuery()
                            con.Close()
                        End If
                    End If
                Next
                
                lblMsg.Text = "Over Time is Approved. . ."
                lblMsg.ForeColor = Drawing.Color.Green
                lblMsg.Visible = True
            Catch ex As Exception
                lblMsg.Text = "Some Error Is Occured. . ."
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Visible = True
            End Try
        End If
    End Sub
End Class
