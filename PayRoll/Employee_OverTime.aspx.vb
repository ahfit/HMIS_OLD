Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Data
Partial Class Payroll_Employee_OverTime
    Inherits System.Web.UI.Page

    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        Dropdownlistdepartment.Items.Insert(0, "")
    End Sub




    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click

        Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim dt As DataTable = New DataTable


        Dim mycommand As New System.Data.SqlClient.SqlCommand("EmpOverTime", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@deptid", Dropdownlistdepartment.SelectedValue)
        mycommand.Parameters.AddWithValue("@empid", DDLEmployee.SelectedValue)
        mycommand.Parameters.AddWithValue("@year", DDLYear.SelectedValue)
        mycommand.Parameters.AddWithValue("@month", DDLMonth.SelectedValue)
        Dim sda As SqlDataAdapter = New SqlDataAdapter(mycommand)
        sda.Fill(dt)

        GridView1.DataSource = dt
        GridView1.DataBind()



    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As String = GridView1.Rows(GridView1.SelectedIndex).Cells(5).Text
        Session.Add("Enter_emp_ID", GridView1.SelectedValue)
        Response.Redirect("Application.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            
            DDLMonth.SelectedValue = System.DateTime.Now.Month
            DDLYear.SelectedValue = System.DateTime.Now.Year
        End If

        Try

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        'If GridView1.Rows.Count <> 0 Then
        '    If DDL_Status.SelectedValue = "NULL" Then
        '        GridView1.Columns(7).Visible = True
        '    Else
        '        GridView1.Columns(7).Visible = False
        '    End If

        'End If
    End Sub

    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(sender As Object, e As EventArgs)
        DDLEmployee.DataBind()
    End Sub

    Protected Sub chkBoxSelectAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim ck As CheckBox = DirectCast(TryCast(sender, Control), CheckBox)

        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            chinner.Checked = ck.Checked
        Next
    End Sub

    Public Sub SaveInfo()
        Dim ok As Integer = -1

        Dim constring As String = ConfigurationManager.ConnectionStrings("PayRoll_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        con.Open()
        For i As Integer = 0 To GridView1.Rows.Count - 1

            Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            If chinner.Checked = True Then
                Dim cmd As New SqlCommand("usp_AddAllowancesDeductions", con)
                Dim empid As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
                cmd.CommandType = CommandType.StoredProcedure
                Dim amount As HiddenField = DirectCast(GridView1.Rows(i).FindControl("hfdamount"), HiddenField)
                Dim year As HiddenField = DirectCast(GridView1.Rows(i).FindControl("hfdyear"), HiddenField)
                Dim month As HiddenField = DirectCast(GridView1.Rows(i).FindControl("hfdmonth"), HiddenField)
                Dim tdays As HiddenField = DirectCast(GridView1.Rows(i).FindControl("hfddays"), HiddenField)
                Dim thors As HiddenField = DirectCast(GridView1.Rows(i).FindControl("hfdhors"), HiddenField)
                cmd.Parameters.AddWithValue("@E_id", 1675)

                cmd.Parameters.AddWithValue("@empId", chinner.ToolTip)
                cmd.Parameters.AddWithValue("@Amount", amount.Value)
                cmd.Parameters.AddWithValue("@Month", month.Value)
                cmd.Parameters.AddWithValue("@Year", year.Value)
                cmd.Parameters.AddWithValue("@EntryEmpID", Convert.ToInt32(Session("emp_id")))
                cmd.Parameters.AddWithValue("@TotalDays", tdays.Value)
                cmd.Parameters.AddWithValue("@TotalHours", thors.Value)

                cmd.ExecuteNonQuery()


                ok = 1
                cmd.Dispose()
                GridView1.Visible = False
            End If
        Next

    End Sub


    Protected Sub btn_Approve_Click(sender As Object, e As EventArgs)


        SaveInfo()
        'Response.Redirect("~/payroll/OverTimeAllowAttendance.aspx")
        'For i As Integer = 0 To GridView1.Rows.Count - 1
        '    Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
        '    If chinner.Checked = True Then
        '        Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
        '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        '        Dim forday As DateTime = Convert.ToDateTime(GridView1.Rows(i).FindControl("For_Date"))

        '        Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert into [Machine_Attendance].[dbo].[PendingLeaves]([emp_id] ,[for_date],[LeaveType],[LeaveDeduction])VALUES(@Empid,@forday,'S/L','0.34')", con)
        '        mycommand.CommandType = Data.CommandType.Text
        '        mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
        '        mycommand.Parameters.AddWithValue("@forday", forday)
        '        con.Open()
        '        mycommand.ExecuteNonQuery()
        '        con.Close()

        '    End If
        'Next
    End Sub
End Class
