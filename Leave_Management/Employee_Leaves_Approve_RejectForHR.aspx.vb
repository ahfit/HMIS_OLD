Imports System.Data
Imports System.Data.SqlClient

Imports System.Collections
Partial Class Employee_Leaves_Approve_RejectForHR
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString

    Dim requestStatus As String = ""



    ' =====================================================================================================================================================================================================================
    '                                       User Define Subs and functions
    ' =====================================================================================================================================================================================================================

    Protected Sub Load_GRIDVIEW6()

        Dim Leave_Type_Id As Integer
        Dim Carries_Forward As Boolean
        Dim ds As New Data.DataSet
        Dim ds_tb As Data.DataTable = ds.Tables.Add("Leave")
        Dim data_column(4) As System.Data.DataColumn
        '''''''''''''''''''


        '''''''''''''''''''
        ds_tb.Columns.Add("Leave Name")
        ds_tb.Columns.Add("Days")
        ds_tb.Columns.Add("Total")
        ds_tb.Columns.Add("Remaining Leave")


        Dim connection As New SqlConnection
        Dim command As SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        command = connection.CreateCommand
        command.CommandText = " SELECT     Leave_Type_Id, Carries_Forward FROM Leave_Types"
        connection.Open()
        reader = command.ExecuteReader
        While reader.Read
            Leave_Type_Id = reader.Item(0)
            Carries_Forward = reader.Item(1)
            Dim pro_connection As New SqlConnection
            Dim pro_command As SqlCommand
            Dim pro_reader As SqlDataReader
            pro_connection.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
            pro_command = pro_connection.CreateCommand
            pro_command.CommandType = Data.CommandType.StoredProcedure
            pro_command.CommandText = "pro_Leave_Record"
            'pro_command.Parameters.Add("@emp_ID", Data.SqlDbType.Int)
            'pro_command.Parameters.Add("@Leave_Type_Id", Data.SqlDbType.Int)
            'pro_command.Parameters.Add("@Carries_Forward", Data.SqlDbType.Int)
            'pro_command.Parameters.AddWithValue("@emp_ID", Request.QueryString("Emp_ID"))

            pro_command.Parameters.AddWithValue("@emp_ID", Request.QueryString("EMP_ID"))
            pro_command.Parameters.AddWithValue("@Leave_Type_Id", Leave_Type_Id)
            pro_command.Parameters.AddWithValue("@Carries_Forward", Carries_Forward)
            pro_connection.Open()
            pro_reader = pro_command.ExecuteReader()
            Try


                If pro_reader.Read Then

                    Dim new_row As System.Data.DataRow = ds_tb.NewRow


                    new_row(1) = pro_reader.Item(0)
                    new_row(2) = pro_reader.Item(1)
                    new_row(3) = pro_reader.Item(2)
                    new_row(0) = pro_reader.Item(3)
                    ds_tb.Rows.Add(new_row)
                End If






            Catch ex As Exception

            End Try
            pro_reader.Close()
            pro_connection.Close()

        End While

        GridView6.DataSource = ds.Tables("Leave")
        GridView6.DataBind()
        reader.Close()
        connection.Close()



    End Sub
    Protected Sub LoadEmployeeLeaveBalance()
        Dim db As DbManager = New DbManager()
        Dim ds As DataSet = db.ExecuteDataSet("usp_LeaveBalance", "Leave_ManagementConnectionString", New SqlParameter() {New SqlParameter("empid", Request.QueryString("Emp_ID"))})

        GridView6.DataSource = ds.Tables(0)
        GridView6.DataBind()

        Session("EmployeeLeaveBalance") = ds.Tables(0)


    End Sub

    Protected Sub LoadLeaveDocumnets()
        Dim db As DbManager = New DbManager()
        Dim ds As DataTable = db.ExecuteDataTableWithQuery("select ID,EmpId,EmpLeaveId,FileName,ContentType,Extension from LeaveDocuments where EmpLeaveId = @Emp_Leave_Id", "Leave_ManagementConnectionString", New SqlParameter() {New SqlParameter("Emp_Leave_Id", Request.QueryString("Emp_Leave_Id"))})
        GridView_LeaveDouments.DataSource = ds
        GridView_LeaveDouments.DataBind()

    End Sub
    Protected Sub Load_Data(ByVal Emp_Leave_ID As Integer)
        If Not Page.IsPostBack() Then
            DropDownList_Leave_Name.DataBind()
        End If

        Dim con As New SqlConnection(constr)
        Dim qry As String = "SELECT Start_Date, End_Date, Leave_Days,Leave_Cat_Id, isnull(Description,'') as Description,isnull(Salary_Day,0) Salary_Day, Requested_Days, Type_Detail_Id FROM Employee_Leaves where (Emp_Leave_Id = @Emp_Leave_Id)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@Emp_Leave_Id", Emp_Leave_ID)
        con.Open()

        Dim reader As SqlDataReader = cmd.ExecuteReader()
        While reader.Read
            WebDateChooser_Start_Date.Value = reader.Item("Start_Date")
            WebDateChooser_End_Date.Value = reader.Item("End_Date")
            TextBox_Leave_Day.Text = reader.Item("Leave_Days")
            TextBox_Salary_Day.Text = reader.Item("Salary_Day")
            TextBox_Description.Text = reader.Item("Description")
            DropDownList_Leave_Name.SelectedValue = Convert.ToInt32(reader.Item("Type_Detail_Id"))
            TextBox_Requested_Leave.Text = reader.Item("Requested_Days")
            If TextBox_Requested_Leave.Text = "0" Then
                TextBox_Requested_Leave.Text = "1"
            End If
            DropDownList_L_Sub_Cat.SelectedValue = reader.Item("Leave_Cat_Id")
        End While
        con.Close()
        WebDateChooser_Start_Date.Enabled = False
        WebDateChooser_End_Date.Enabled = False
        GetDaysList()
    End Sub
    Protected Sub Load_DataFromApprovalLogs(ByVal Emp_Leave_ID As Integer)

        'If Not IsPostBack() Then
        'DropDownList_Leave_Name.DataBind()
        'End If
        Dim con As New SqlConnection(constr)
        Dim qry As String = "usp_LoadEmpLeaveDatafromLog"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@empLeaveID", Emp_Leave_ID)
        cmd.CommandType = CommandType.StoredProcedure
        con.Open()


        Dim reader As SqlDataReader = cmd.ExecuteReader()
        While reader.Read

            requestStatus = reader.Item("ApprovalStatus").ToString()

            WebDateChooser_Start_Date.Value = reader.Item("Start_Date")
            WebDateChooser_End_Date.Value = reader.Item("End_Date")
            TextBox_Leave_Day.Text = reader.Item("Leave_Days")
            TextBox_Salary_Day.Text = reader.Item("Salary_Day")
            TextBox_Description.Text = reader.Item("Remarks").ToString()
            DropDownList_Leave_Name.SelectedValue = Convert.ToInt32(reader.Item("Type_Detail_Id"))
            TextBox_Requested_Leave.Text = reader.Item("Requested_Days").ToString()
            If TextBox_Requested_Leave.Text = "0" Then
                TextBox_Requested_Leave.Text = "1"
            End If
            DropDownList_L_Sub_Cat.SelectedValue = reader.Item("Leave_Cat_Id").ToString()
        End While
        con.Close()
    End Sub
    Protected Sub Show(ByVal MSG As String)
        LBL_Message.Text = MSG

    End Sub
    Protected Sub MgShow()
        LBL_Message.Text = "Request Rejected"
    End Sub
    Protected Sub GetLeavePayDetails()
        Dim sqlParams As SqlParameter() = {
           New SqlParameter("@Type_Detail_id", DropDownList_Leave_Name.SelectedValue)
        }
        Dim objDbManager As DbManager = New DbManager()
        Dim dt As DataTable = objDbManager.ExecuteDataTable("GetLeavePayDetails", "Leave_ManagementConnectionString", sqlParams)
        If dt.Rows(0)("Pay") = "Full" Then
            DropDownList_L_Sub_Cat.SelectedValue = "1"
        Else
            DropDownList_L_Sub_Cat.SelectedValue = "3"
        End If

        If dt.Rows(0)("Salary_Day") = 0 Then
            DropDownList_L_Sub_Cat.SelectedValue = "1"
            TextBox_Salary_Day.Text = "0"
        Else
            TextBox_Salary_Day.Text = "1"
        End If
        hf_has_balance.Value = dt.Rows(0)("Has_Opening")

    End Sub
    Sub DrawLeave()
        Try

            If DropDownList_L_Sub_Cat.SelectedValue <> 1 Then
                

                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            End If


            CalculateLeaveDays()


        Catch ex As Exception

        End Try

    End Sub
    Sub CalculateLeaveDays()
        Try
            Dim start_date As Date
            Dim end_date As Date
            Dim days As Decimal

            days = 0

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Then
                days = 0.3
            ElseIf DropDownList_L_Sub_Cat.SelectedValue = 3 Then
                days = 0.5

            End If

            If DropDownList_L_Sub_Cat.SelectedValue = 1 Then

                start_date = WebDateChooser_Start_Date.Value
                end_date = WebDateChooser_End_Date.Value
                TextBox_Leave_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                TextBox_Salary_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
            Else
                TextBox_Leave_Day.Text = Convert.ToString(days)
                TextBox_Salary_Day.Text = Convert.ToString(days)
            End If


        Catch ex As Exception

        End Try
    End Sub
    Protected Sub LoadEmployeeAndThererLogsDetail()
        Dim db As DbManager = New DbManager()
        Dim ds As DataSet = db.ExecuteDataSet("uspSelectEmployeeLevaesApprovaLogs", "Leave_ManagementConnectionString", New SqlParameter() {New SqlParameter("Emp_Leave_Id", Request.QueryString("Emp_Leave_Id"))})
        GridView2.DataSource = ds.Tables(0)
        GridView2.DataBind()

        GridView1.DataSource = ds.Tables(1)
        GridView1.DataBind()
        If GridView1.Rows.Count > 0 Then
            hf_has_balance.Value = Convert.ToBoolean(ds.Tables(0).Rows(0)("Has_Opening")).ToString()
        Else
            hf_has_balance.Value = Convert.ToBoolean(0).ToString()
        End If



    End Sub

    Private Sub GetDaysList()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "usp_WorkingDaysFind"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@StartDate", Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyyMMdd")) 'HiddenField_StartDate.Value
        cmd.Parameters.AddWithValue("@EndDate", Convert.ToDateTime(WebDateChooser_End_Date.Value).ToString("yyyyMMdd")) 'HiddenField_EndDate.Value
        cmd.Parameters.AddWithValue("@Dept_Id", Session("Dept_Id"))
        cmd.Parameters.AddWithValue("@EmpId", Request.QueryString("Emp_ID"))
        cmd.Parameters.AddWithValue("@emp_leave_id", Request.QueryString("Emp_Leave_Id"))
        cmd.Connection = conn
        conn.Open()
        Dim var As Integer = 0

        Using sdr As SqlDataReader = cmd.ExecuteReader()
            CheckBoxList_Dates_Of_Leaves.Items.Clear()
            While sdr.Read()
                Dim item As New ListItem()
                item.Text = sdr("FullDate").ToString()
                item.Value = sdr("DateJ").ToString()
                ' item.Selected = Convert.ToBoolean(sdr("CheckStatus"))
                CheckBoxList_Dates_Of_Leaves.Items.Add(item)
                If sdr("CheckStatus").ToString() = True Then

                    CheckBoxList_Dates_Of_Leaves.Items(var).Selected = True
                Else
                    CheckBoxList_Dates_Of_Leaves.Items(var).Enabled = False

                    If sdr("Is_leave").ToString() = True Or sdr("Is_leave").ToString() = "1" Then
                        CheckBoxList_Dates_Of_Leaves.Items(var).Attributes.Add("style", "color: red; font-weight:bold;")

                    End If
                End If
                If sdr("Is_Hodliday").ToString() = True Then
                    CheckBoxList_Dates_Of_Leaves.Items(var).Attributes.Add("style", "color: Green; font-weight:bold;")
                End If


                var = var + 1
            End While
        End Using
        conn.Close()

    End Sub

    Private Sub getMaxMinValue(ByRef MinI As Date, ByRef MaxI As Date)
        Dim first As Integer = 0
        For Each item As ListItem In CheckBoxList_Dates_Of_Leaves.Items
            If item.Selected Then
                If first = 0 Then
                    MinI = Convert.ToDateTime(item.Text)
                    MaxI = Convert.ToDateTime(item.Text)
                    first = 1
                Else
                    MaxI = Convert.ToDateTime(item.Text)
                End If
            End If

        Next


    End Sub
    Private Sub Approve_Reject_leave(status As Boolean)

        HiddenField_Approved_Rejected.Value = Convert.ToInt32(status)
        Try

            HiddenField_From_Date.Value = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd")
            HiddenField_to_Date.Value = Convert.ToDateTime(WebDateChooser_End_Date.Value).ToString("yyyy-MM-dd")
            SqlDataSource_Leaves_For_Approval.UpdateParameters("Data").DefaultValue = getLeaveDate()
            SqlDataSource_Leaves_For_Approval.Update()
            Button_approve.Visible = False
            ButtonRejected.Visible = False

            Dim msg As String = String.Empty
            If status Then
                msg = "Request approved ..."
            Else
                msg = "Request Rejected ..."
            End If
            Show(msg)
            GridView6.DataBind()
            LoadEmployeeAndThererLogsDetail()
            Alert(msg, "../HR/Search_EmployeeRequestHODtoHR.aspx?SubDeptId=" + Request.QueryString("SubDeptId").ToString())
        Catch ex As Exception
            Show(ex.Message)
        End Try


    End Sub
    Private Sub Authorize_leave(status As Boolean)
        If Convert.ToBoolean(hf_has_balance.Value) Then

            Dim dt As DataTable = CType(Session("EmployeeLeaveBalance"), DataTable)
            Dim dr As DataRow() = dt.Select("Leave_Name='" + DropDownList_Leave_Name.SelectedItem.Text + "' ")

            Dim salaryDay As Double
            salaryDay = CType(TextBox_Leave_Day.Text, Double)

            Dim AllowedLeaves As Double
            Try

                AllowedLeaves = CType(dr(0)(0).ToString(), Double)

            Catch ex As Exception

                AllowedLeaves = 0

            End Try


            If Not (salaryDay > AllowedLeaves) Then

                Button_approve.Visible = True

                Approve_Reject_leave(status)
            Else
                LBL_Message.Text = "Salary Days Cannot be greater than Available Leaves"
                LBL_Message.Visible = True
                LBL_Message.ForeColor = Drawing.Color.Red
                Button_approve.Visible = False
                ButtonRejected.Visible = False
                'btnRefresh.Visible = True
            End If
        Else
            Approve_Reject_leave(status)

        End If

        'Session.Remove("EmployeeLeaveBalance")

    End Sub

    Private Sub ValidateRemaining()
        If Convert.ToBoolean(hf_has_balance.Value) Then
            If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then
                If GridView6.Rows.Count > 0 Then
                    Dim Remaining As New Label
                    Dim lbltypeID As New HiddenField

                    For Each row As GridViewRow In GridView6.Rows
                        lbltypeID = row.FindControl("lbltypeID")
                        If DropDownList_Leave_Name.SelectedValue = lbltypeID.Value Then
                            Remaining = row.FindControl("lblRemaining")
                            If CDbl(Remaining.Text) > 0 And CDbl(TextBox_Leave_Day.Text) > 0 And CDbl(Remaining.Text) >= CDbl(TextBox_Leave_Day.Text) Then

                            Else
                                Alert("Applied leaves are greater than Remaining leaves...")
                            End If
                        End If
                        


                    Next
                Else
                    Alert("Leave Balance is missing...")
                End If
            End If

        End If
    End Sub

    Private Sub Alert(msg As String)
        Dim sb As New System.Text.StringBuilder()

        sb.Append("<script language='javascript' type='text/javascript'>alert('" + msg + "');</script>")
        Dim t As Type = Me.GetType()
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If
    End Sub
    Private Sub Alert(msg As String, url As String)
        Dim sb As New System.Text.StringBuilder()

        sb.Append("<script language='javascript' type='text/javascript'>alert('" + msg + "');window.location.replace('" + url + "'); </script>")
        Dim t As Type = Me.GetType()
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If

    End Sub

    Private Function getLeaveDate() As String
        Dim Data As String = "<Data>"
        If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then
            For Each ck As ListItem In CheckBoxList_Dates_Of_Leaves.Items
                If ck.Selected Then

                    Data = Data + "<row><d>" + Convert.ToDateTime(ck.Value).ToString("yyyy-MM-dd") + "</d></row>"
                End If
            Next
        End If

        Data = Data + "</Data>"

        Return Data

    End Function

    ' =====================================================================================================================================================================================================================
    '                                       System Events
    ' =====================================================================================================================================================================================================================

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Load_Data(Request.QueryString("Emp_Leave_Id"))
            LoadEmployeeLeaveBalance()
            HiddenField_Emp_Leave_ID.Value = Request.QueryString("Emp_Leave_Id")
            Load_DataFromApprovalLogs(Request.QueryString("LeaveApprovalID"))
            LoadEmployeeAndThererLogsDetail()
            LoadLeaveDocumnets()

            'If requestStatus = "0" Or requestStatus = "" Then
            '    Button_approve.Visible = False
            '    ButtonRejected.Visible = False
            '    LBL_Message.Text = "Reuest is Reject By HOD"
            '    LBL_Message.ForeColor = Drawing.Color.Red
            'Else
            '    Button_approve.Visible = True
            '    ButtonRejected.Visible = True
            '    LBL_Message.Text = ""

            'End If




            HiddenField_Emp_Leave_ID.Value = Request.QueryString("Emp_Leave_Id")

            GridView6.Visible = True
            Panel_Leave.Visible = True
            GridView1.Visible = True
            GridView4.Visible = True

        End If


    End Sub
    Protected Sub Button_approve_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_approve.Click
        LBL_Message.ForeColor = System.Drawing.Color.Black
        If IsLeaveChecked() Then
            Authorize_leave(True)
        Else
            LBL_Message.ForeColor = System.Drawing.Color.Red
            LBL_Message.Text = "Select atleast 1 leave date...."
        End If
        'Try
        '    HiddenField_Approved_Rejected.Value = 1
        '    HiddenField_From_Date.Value = WebDateChooser_Start_Date.Value
        '    HiddenField_to_Date.Value = WebDateChooser_End_Date.Value
        '    SqlDataSource_Leaves_For_Approval.Update()
        '    Button_approve.Visible = False
        '    ButtonRejected.Visible = False
        '    Show()
        '    LoadEmployeeAndThererLogsDetail()
        'Catch ex As Exception
        '    Response.Write(ex.Message)
        'End Try


    End Sub
    Protected Sub ButtonRejected_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonRejected.Click
        LBL_Message.ForeColor = System.Drawing.Color.Black
        If IsLeaveChecked() Then
            Approve_Reject_leave(False)
        Else
            LBL_Message.ForeColor = System.Drawing.Color.Red
            LBL_Message.Text = "Select atleast 1 leave date...."
        End If
        'Try

        '    HiddenField_Approved_Rejected.Value = 0
        '    SqlDataSource_Leaves_For_Approval.Update()
        '    ButtonRejected.Visible = False
        '    Button_approve.Visible = False
        '    LoadEmployeeAndThererLogsDetail()
        '    MgShow()
        'Catch ex As Exception

        'End Try

    End Sub

    Private Function IsLeaveChecked() As Boolean
        Dim Check As Boolean = False
        For Each chk As ListItem In CheckBoxList_Dates_Of_Leaves.Items
            If chk.Selected = True Then
                Check = True
            End If

        Next
        Return Check
    End Function
    Protected Sub WebDateChooser_Start_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_Start_Date.ValueChanged
        Try
            'draw_diary()
            Dim start_date As Date
            Dim end_date As Date

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Or DropDownList_L_Sub_Cat.SelectedValue = 3 Then
                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value

                start_date = WebDateChooser_Start_Date.Value
                end_date = WebDateChooser_End_Date.Value
                TextBox_Leave_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                TextBox_Salary_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                DrawLeave()
            Else

                start_date = WebDateChooser_Start_Date.Value
                end_date = WebDateChooser_End_Date.Value
                TextBox_Leave_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                TextBox_Salary_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1

            End If


        Catch ex As Exception

        End Try
    End Sub
    Protected Sub WebDateChooser_End_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_End_Date.ValueChanged
        Try
            'draw_diary()
            Dim start_date As Date
            Dim end_date As Date
            If DropDownList_L_Sub_Cat.SelectedValue = 2 Or DropDownList_L_Sub_Cat.SelectedValue = 3 Then
                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value

                start_date = WebDateChooser_Start_Date.Value
                end_date = WebDateChooser_End_Date.Value
                TextBox_Leave_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                TextBox_Salary_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                DrawLeave()
            Else
                start_date = WebDateChooser_Start_Date.Value
                end_date = WebDateChooser_End_Date.Value
                TextBox_Leave_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
                TextBox_Salary_Day.Text = Convert.ToInt32(DateDiff(DateInterval.Day, start_date, end_date, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.Jan1)) + 1
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub DropDownList_Leave_Name_SelectedIndexChanged(sender As Object, e As EventArgs)

        'GetLeavePayDetails()
        'ValidateRemaining()

    End Sub
    Protected Sub DropDownList_L_Sub_Cat_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_L_Sub_Cat.SelectedIndexChanged

        If DropDownList_L_Sub_Cat.SelectedValue = 2 Or DropDownList_L_Sub_Cat.SelectedValue = 3 Then
            WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            WebDateChooser_End_Date.Enabled = False

        End If
        DrawLeave()
    End Sub
    Protected Sub GridView1_PreRender(sender As Object, e As EventArgs) Handles GridView1.PreRender
        Dim maxrow As Integer = GridView1.Rows.Count
        If maxrow > 0 Then
            Dim s As String = GridView1.Rows(maxrow - 1).Cells(4).Text
            If s = "Rejected" Then
                Button_approve.Visible = False
                LBL_Message.Text = "Rejected By HOD"
                LBL_Message.ForeColor = Drawing.Color.Red
            End If


        End If
    End Sub
    Protected Sub CheckBoxList_Dates_Of_Leaves_SelectedIndexChanged(sender As Object, e As EventArgs) Handles CheckBoxList_Dates_Of_Leaves.SelectedIndexChanged

        If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then
            Dim Min, Max As Date
            getMaxMinValue(Min, Max)
            WebDateChooser_Start_Date.Value = Min
            WebDateChooser_End_Date.Value = Max

            CalculateLeaveDays()

        Else
            TextBox_Leave_Day.Text = "0"
            TextBox_Salary_Day.Text = "0"

        End If


    End Sub

    Protected Sub lnkDownload_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = DirectCast(sender, LinkButton)
        Dim folderPath As String = Server.MapPath("~/Leave_Management/LeaveDocs/")
        Response.ContentType = lnk.CommandName
        Response.WriteFile(folderPath & lnk.Text)
        Response.[End]()
    End Sub



End Class
