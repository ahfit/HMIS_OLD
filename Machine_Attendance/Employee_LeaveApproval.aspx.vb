Imports System.Data.SqlClient
Imports System.Globalization
Imports System.Data
Partial Class Employee_LeaveApproval
    Inherits System.Web.UI.Page

    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        Dropdownlistdepartment.Items.Insert(0, "")
    End Sub

    


    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        
            Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim dt As DataTable = New DataTable


        Dim mycommand As New System.Data.SqlClient.SqlCommand("LeaveCalculation", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@deptid", Dropdownlistdepartment.SelectedValue)
        mycommand.Parameters.AddWithValue("@empid", DDLEmployee.SelectedValue)
        mycommand.Parameters.AddWithValue("@Month", DDLMonth.SelectedValue)
        mycommand.Parameters.AddWithValue("@Year", DDLYear.SelectedValue)
        'mycommand.Parameters.AddWithValue("@stratdate", WebDateChooser_Start_Date.Value)
        'mycommand.Parameters.AddWithValue("@enddate", WebDateChooser_end_Date.Value)
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
        Try


            If Not IsPostBack Then

                WebDateChooser_Start_Date.Value = Date.Now()
                HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
                WebDateChooser_end_Date.Value = Date.Now()
                HiddenField_end_Date.Value = WebDateChooser_end_Date.Value

                DDLMonth.SelectedValue = DateTime.Now.Date.Month
                DDLYear.SelectedValue = DateTime.Now.Date.Year


            End If
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

    Protected Sub btn_Approve_Click(sender As Object, e As EventArgs)

        Try


        
        For Each row As GridViewRow In GridView1.Rows
                Dim chinner As CheckBox = DirectCast(row.FindControl("chkBoxSelect"), CheckBox)
                Dim LDSelect As CheckBox = DirectCast(row.FindControl("chkBoxLeaveDeduction"), CheckBox)
            If chinner.Checked = True Then
                    Dim LeaveTotal As String = GridView1.Rows(row.RowIndex).Cells(6).Text
                    Dim LeaveBalance As String = GridView1.Rows(row.RowIndex).Cells(7).Text
                    Dim hfdeid As HiddenField = DirectCast(row.FindControl("hfdE_ID"), HiddenField)
                    Dim hfdquantity As HiddenField = DirectCast(row.FindControl("hfdquantity"), HiddenField)
                    Dim HfLeaveType As HiddenField = DirectCast(row.FindControl("HfLeaveType"), HiddenField)
                    Dim HfLeaveTotal As HiddenField = DirectCast(row.FindControl("HfLeaveTotal"), HiddenField)
                Dim constring As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim forday As DateTime = Convert.ToDateTime(row.FindControl("For_Date"))

                Dim mycommand As New System.Data.SqlClient.SqlCommand("deductleaveorsalary", con)
                mycommand.CommandType = Data.CommandType.StoredProcedure

                mycommand.Parameters.AddWithValue("@Empid", chinner.ToolTip)
                mycommand.Parameters.AddWithValue("@formonth", DDLMonth.SelectedValue)
                mycommand.Parameters.AddWithValue("@foryear", DDLYear.SelectedValue)
                mycommand.Parameters.AddWithValue("@totalleave", LeaveTotal)
                mycommand.Parameters.AddWithValue("@totalleavebalance", LeaveBalance)
                    mycommand.Parameters.AddWithValue("@eid", hfdeid.Value)
                    mycommand.Parameters.AddWithValue("@leaveamount", hfdquantity.Value)
                    mycommand.Parameters.AddWithValue("@leaveType", HfLeaveType.Value)
                    mycommand.Parameters.AddWithValue("@TotalLate", HfLeaveTotal.Value)
                    mycommand.Parameters.AddWithValue("@Approved", HfLeaveTotal.Value)
                    If LDSelect.Checked = True Then
                        mycommand.Parameters.AddWithValue("@LeaveCheck", "True")
                    Else
                        mycommand.Parameters.AddWithValue("@LeaveCheck", "False")
                    End If


                con.Open()
                mycommand.ExecuteNonQuery()
                con.Close()

            End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    'Public Function GetUrl(Emp_ID As Object) As String


    '    Dim url As String = "~/Machine_Attendance/EmpoyeeDayWiseLeave.aspx?month=" + DDLForMonth.SelectedValue + "&Emp_ID=" + Emp_ID.ToString() + "&year=" + DDLForYear.SelectedValue

    '    Return url
    'End Function

    
    Protected Sub lnkbtnAction_Click(sender As Object, e As EventArgs)
        Dim lbtn As LinkButton = DirectCast(sender, LinkButton)
        Dim row As GridViewRow = DirectCast(lbtn.NamingContainer, GridViewRow)
        Dim ckbx As CheckBox = DirectCast(row.FindControl("chkBoxSelect"), CheckBox)
        Response.Redirect("~/Machine_Attendance/EmpoyeeDayWiseLeave.aspx?month=" + WebDateChooser_Start_Date.Value + "&Emp_ID=" + ckbx.ToolTip + "&year=" + WebDateChooser_end_Date.Value)

    End Sub
End Class
