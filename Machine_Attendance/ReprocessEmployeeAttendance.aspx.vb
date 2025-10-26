Imports System.Data
Imports System.Data.SqlClient
Imports iTextSharp.text.pdf
Imports iTextSharp.text
Imports System.IO
Imports System.Text
Imports System.Drawing.Printing
Imports System.Drawing.Imaging
Imports Infragistics.WebUI.WebSchedule

Partial Class HR_ReprocessEmployeeAttendance
    Inherits System.Web.UI.Page

    Dim conString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Machine_AttendanceConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            DDL_Company.DataBind()
            DDL_Branch.DataBind()
            DDL_Sold_By.DataBind()

            If Not Request.QueryString("Subdept") Is Nothing Then
                DDL_Branch.SelectedValue = Request.QueryString("Subdept").ToString()
            End If
            If Not Request.QueryString("EmpId") Is Nothing Then
                DDL_Sold_By.SelectedValue = Request.QueryString("EmpId").ToString()
            End If
            ShowReport()
        End If

    End Sub

    Private Sub ShowReport()
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("usp_UpdateMachieID", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", 0)
            cmd.Parameters.AddWithValue("@SubDept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            gvupdatemachineID.DataSource = dt
            gvupdatemachineID.DataBind()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
            con.Close()
        End Try

        lblMessage.Text = ""
    End Sub
    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        ShowReport()
    End Sub
    Protected Sub DDL_Branch_SelectedIndexChanged(sender As Object, e As EventArgs)
        DDL_Sold_By.DataBind()
    End Sub
    Protected Sub btnUpdate_Click(sender As Object, e As EventArgs)
        Try
            Dim Status As String = ""
            For Each row As GridViewRow In gvupdatemachineID.Rows
                Dim chkatt As CheckBox = CType(row.FindControl("chkatt"), CheckBox)

                If chkatt.Checked = True Then
                    Status = ""
                    Dim txtboxMachineID As TextBox = CType(row.FindControl("txtDutyHours"), TextBox)

                    If txtboxMachineID.Text.Trim() <> "" Then
                        If Convert.ToInt32(txtboxMachineID.Text.Trim()) <> 0 Then
                            Dim Conn As SqlConnection = New SqlConnection(conString)
                            Dim cmd As SqlCommand = New SqlCommand("Update Employee set DutyHours = @DutyHours where EmpId = @EmpID ", Conn)
                            'cmd.CommandType = CommandType.StoredProcedure
                            cmd.Parameters.AddWithValue("@DutyHours", txtboxMachineID.Text)
                            cmd.Parameters.AddWithValue("@EmpID", chkatt.ToolTip)
                            'cmd.Parameters.Add("@Status", SqlDbType.VarChar, 100)
                            'cmd.Parameters("@Status").Direction = ParameterDirection.Output
                            Conn.Open()
                            cmd.ExecuteNonQuery()
                            Conn.Close()
                            Status = "OK"
                            'Status = cmd.Parameters("@Status").Value
                        End If

                    End If
                    If Status = "OK" Then
                        lblMessage.Text = "Record Updated Succesfully......"
                        lblMessage.ForeColor = System.Drawing.Color.Green
                    Else
                        lblMessage.Text = Status
                        lblMessage.ForeColor = System.Drawing.Color.Red
                    End If



                End If
            Next

        Catch ex As Exception
            lblMessage.Text = "Some Error Occured...."
            lblMessage.ForeColor = System.Drawing.Color.Red
            Response.Write(ex.Message())
        End Try
    End Sub

    Protected Sub grdPatientsSchedules_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If (e.Row.RowType = DataControlRowType.DataRow) Then
            Dim ScheduleDate As WebDateChooser = e.Row.FindControl("webdatechooser")
            ScheduleDate.Value = DateTime.Now
        End If
        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim HfShiftId As HiddenField = DirectCast(e.Row.FindControl("HfShiftId"), HiddenField)
        '    Dim ddlShift As DropDownList = DirectCast(e.Row.FindControl("ddlShift"), DropDownList)
        '    Dim HfSubDeptId As HiddenField = DirectCast(e.Row.FindControl("HfSubDeptId"), HiddenField)
        '    BindShifts(HfSubDeptId.Value, ddlShift)
        '    ddlShift.SelectedValue = HfShiftId.Value
        'End If

    End Sub

    Private Sub BindShifts(SubdeptId As Integer, ddlShift As DropDownList)
        Dim dbMgr As DbManager = New DbManager()
        Dim dt As DataTable = New DataTable()
        Dim sqlParam As SqlParameter() = {(New SqlParameter("@SubDept_ID", SubdeptId))}

        dt = dbMgr.ExecuteDataTableWithQuery("select ads.ShiftID,ads.ShiftName from Admin_DutyRoster adr inner join Admin_Shift ads on adr.Shift_ID = ads.ShiftID where SubDeptId = @SubDept_ID", "Basic_Data_ConnectionString", sqlParam)
        ddlShift.DataSource = dt
        ddlShift.DataBind()
    End Sub

    Protected Sub lnkbtn_Click(sender As Object, e As EventArgs)
        Dim btn As LinkButton = TryCast(sender, LinkButton)
        Dim row As GridViewRow = TryCast(sender, GridViewRow)
        Dim id As Integer = Convert.ToInt32(btn.CommandArgument)
        Dim clickedRow As GridViewRow = TryCast((CType(sender, LinkButton)).NamingContainer, GridViewRow)
        Dim webdates As WebDateChooser = CType(clickedRow.FindControl("webdatechooser"), WebDateChooser)
        'Response.Write(webdates.Value.ToString())
        Dim cs As SqlConnection = New SqlConnection(constr)
        Dim sqlquery As String = "ImportAttendance"
        cs.Open()
        Dim cmd As SqlCommand = New SqlCommand(sqlquery, cs)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@EmpId", id)
        cmd.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(webdates.Value).ToString("yyyy-MM-dd"))
        'cmd.Parameters.AddWithValue("@ToDate", Date.Now.ToString("yyyy-MM-dd"))
        cmd.ExecuteNonQuery()
        cs.Close()
        lblMessage.Text = "Attendance Reprocessed......"
    End Sub
End Class
