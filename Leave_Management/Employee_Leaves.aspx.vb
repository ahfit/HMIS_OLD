Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Collections
Imports System.IO
Partial Class Leave_Management_Employee_Leaves
    Inherits System.Web.UI.Page
    Dim user_constr As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
    ' Dim crdoc As New ReportDocument

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If Convert.ToBoolean(HfDocumentRequired.Value) And Not Fileupload_Document.HasFile Then
            lblMsg.Text = "Please Select Document For " + DropDownList_Leave_Name.SelectedItem.Text + " Leaves"
        Else
            Try
                Dim msg As String = String.Empty
                If isLeaveValid(msg) = False Then
                    Dim M As String = String.Format("leave(s) is marked for {0} Day(s).", msg)
                    Alert(M)
                    lblMsg.Text = M

                End If
                GetMINMAXDates()
                SqlDataSource_Employee_Leaves.InsertParameters("Leave_Days").DefaultValue = TextBox_Leave_Day.Text
                SqlDataSource_Employee_Leaves.InsertParameters("Salary_Day").DefaultValue = TextBox_Salary_Day.Text
                If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then
                    Dim lDate As DateTime = Convert.ToDateTime(CheckBoxList_Dates_Of_Leaves.SelectedValue)
                    If Not Convert.ToBoolean(HiddenField_HasOpening.Value) Then
                        insert_leave()
                    Else
                        'If Convert.ToBoolean(HiddenField_HasOpening.Value) Then
                        '    lblMsg.Text = "Please enter Leave Opening Balance first!"
                        'End If
                        If GridView6.Rows.Count = 0 Then
                            lblMsg.Text = "Please enter Leave Opening Balance first!"
                        Else
                            Dim Leave_Name As New Label
                            Dim R As New Label
                            Dim LeaveTypeId As Int32
                            Dim AppliedLeaves As Int32 = 0
                            For Each row As GridViewRow In GridView6.Rows
                                Leave_Name = row.FindControl("lblLeave_Name")
                                LeaveTypeId = Convert.ToInt32(DirectCast(row.FindControl("lbltypeID"), HiddenField).Value)
                                'AppliedLeaves = GetPendingAppliedLeaves(Request.QueryString("Emp_ID"), LeaveTypeId)
                                If Leave_Name.Text = DropDownList_Leave_Name.SelectedItem.Text Then
                                    R = row.FindControl("lblRemaining")
                                    If (Convert.ToDecimal(R.Text) >= (Convert.ToDecimal(TextBox_Leave_Day.Text.Trim())) + AppliedLeaves) Then
                                        insert_leave()
                                    Else
                                        If AppliedLeaves = 0 Then
                                            lblMsg.Text = "Remaining Leaves Balance is less then leave Applied..."
                                        Else
                                            lblMsg.Text = "Remaining Leaves Balance is less then leave Applied plus pending leaves..."
                                        End If
                                        lblMsg.Visible = True
                                        lblMsg.ForeColor = Drawing.Color.Red
                                    End If
                                End If
                            Next row
                        End If
                    End If


                Else
                    lblMsg.Text = "Please Select A valid Date ..."
                End If
                WebDateChooser_Start_Date.Value = Date.Now
                WebDateChooser_End_Date.Value = Date.Now
                DrawLeave()
                GridView4.DataBind()
            Catch ex As Exception
                lblMsg.Text = "Fail to save."
                lblMsg.ForeColor = Drawing.Color.Red
                Response.Write(ex.Message)
            End Try
            GridView6.DataBind()
        End If

    End Sub

    Private Function GetPendingAppliedLeaves(EmpId As Integer, LeaveTypeId As Integer) As Decimal
        Dim leaves As Decimal = 0
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "usp_GetPendingUnApprovedLeave"
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpId", EmpId)
                cmd.Parameters.AddWithValue("@LeaveTypeId", LeaveTypeId)
                cmd.Connection = conn
                conn.Open()
                Using sdr As SqlDataReader = cmd.ExecuteReader()
                    While sdr.Read()
                        leaves = Convert.ToDecimal(sdr(0))
                    End While
                End Using
            End Using
            conn.Close()
        End Using
        Return leaves
    End Function

    Private Sub GetDaysList()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "usp_WorkingDaysFind"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@StartDate", HiddenField_StartDate.Value)
        cmd.Parameters.AddWithValue("@EndDate", HiddenField_EndDate.Value)
        cmd.Parameters.AddWithValue("@Dept_Id", Session("Dept_Id"))
        cmd.Parameters.AddWithValue("@EmpId", Request.QueryString("Emp_ID"))
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
    Private Function isLeaveValid(ByRef msg As String) As Boolean

        Dim retVal As Boolean = True

        For Each itm As ListItem In CheckBoxList_Dates_Of_Leaves.Items
            If itm.Selected Then
                sqlDs_CheckEmpAttendance.SelectParameters("Emp_Id").DefaultValue = Request.QueryString("Emp_ID")
                sqlDs_CheckEmpAttendance.SelectParameters("For_Day").DefaultValue = DateTime.Parse(itm.Text)
                sqlDs_CheckEmpAttendance.SelectParameters("AttendanceMarked").DefaultValue = "N"
                sqlDs_CheckEmpAttendance.Select(DataSourceSelectArguments.Empty)

                If hfldAttendanceMarked.Value = "Y" Then
                    msg = msg + "," + DateTime.Parse(itm.Text).ToString("dd/MM/yyyy")
                    retVal = False
                End If
            End If
        Next

        If msg.Length > 0 Then
            msg = msg.Substring(1, msg.Length - 1)
        End If

        Return retVal

    End Function
    Protected Sub sqlDs_CheckEmpAttendance_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sqlDs_CheckEmpAttendance.Selected
        hfldAttendanceMarked.Value = e.Command.Parameters("@AttendanceMarked").Value
    End Sub
    Sub AddLeavesDetail()
        Dim i As Integer
        For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
            If CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True Then
                HiddenField_LeaveDate.Value = CheckBoxList_Dates_Of_Leaves.Items(i).Value
                'HiddenField_LeaveID.Value =
                SqlDataSource_InsertLeaveDetail.Insert()
            End If


        Next

    End Sub

    Protected Sub Load_Data(ByVal Emp_Leave_ID As Integer)
        Dim con As New SqlConnection(constr)
        Dim qry As String = "SELECT     Start_Date, End_Date, Leave_Days, ISNULL(Description, '') AS Description, Salary_Day, Requested_Days, Type_Detail_Id, Leave_Cat_Id FROM  Employee_Leaves WHERE (Emp_Leave_Id = @Emp_Leave_Id)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@Emp_Leave_Id", Emp_Leave_ID)
        con.Open()
        DropDownList_Leave_Name.DataBind()
        Dim reader As SqlDataReader = cmd.ExecuteReader()
        While reader.Read
            WebDateChooser_Start_Date0.Value = reader.Item("Start_Date")
            WebDateChooser_End_Date0.Value = reader.Item("End_Date")
            TextBox_Leave_Day0.Text = reader.Item("Leave_Days")
            TextBox_Salary_Day0.Text = reader.Item("Salary_Day")
            TextBox_Description0.Text = reader.Item("Description")
            DropDownList_Leave_Name0.SelectedValue = Convert.ToInt32(reader.Item("Type_Detail_Id"))
            TextBox_Requested_Leave.Text = reader.Item("Requested_Days")
            If TextBox_Requested_Leave.Text = "0" Then
                TextBox_Requested_Leave.Text = "1"
            End If
            DropDownList_L_Sub_Cat0.SelectedValue = reader.Item("Leave_Cat_Id")
        End While
        con.Close()
    End Sub
    Protected Sub Button_approve_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_approve.Click
        Try


            HiddenField_Approved_Rejected.Value = True
            HiddenField_From_Date0.Value = WebDateChooser_Start_Date0.Value
            HiddenField_to_Date0.Value = WebDateChooser_End_Date0.Value
            SqlDataSource_Leaves_For_Approval.Update()
            Button_approve.Visible = False
            ButtonRejected.Visible = False
            Show()
            Panel2.Visible = False
            GridView4.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub ButtonRejected_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonRejected.Click


        Try

            HiddenField_Approved_Rejected.Value = False
            SqlDataSource_Leaves_For_Approval.Update()
            ButtonRejected.Visible = False
            Button_approve.Visible = False
            MgShow()
            Panel2.Visible = False
            GridView4.DataBind()
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub Show()
        Try

            LBL_Message.Text = "Request Approved"
            LBL_Message.ForeColor = Drawing.Color.Aqua
            GridView6.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub MgShow()
        Try

            LBL_Message.Text = "Request Rejected"
            LBL_Message.ForeColor = Drawing.Color.OrangeRed
            GridView6.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Page_InitComplete(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.InitComplete


    End Sub

    Sub CalculateLeaveDays()
        Try
            Dim i As Integer
            Dim days As Decimal
            Dim sDays As Decimal
            days = 0

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Then
                days = 0.3
            ElseIf DropDownList_L_Sub_Cat.SelectedValue = 3 Then
                days = 0.5
            Else
                For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
                    If CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True Then
                        days = days + 1
                    End If
                Next
            End If

            If HfSalaryDay.Value = "1" Then
                sDays = days
            Else
                sDays = 0
            End If



            TextBox_Leave_Day.Text = Convert.ToString(days)
            TextBox_Salary_Day.Text = Convert.ToString(sDays)
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Request.QueryString("Emp_ID") Is Nothing Then
            Panel1.Visible = False
            HiddenField_EmpId.Value = Request.QueryString("Emp_ID").ToString()
        Else
            Panel1.Visible = True

            If Not DropDownListEmployee.SelectedValue Is Nothing Then
                HiddenField_EmpId.Value = DropDownListEmployee.SelectedValue
            Else
                HiddenField_EmpId.Value = "0"
            End If


        End If


        If Not IsPostBack Then
            DropDownList_Leave_Name.DataBind()
            GetLeavePayDetails()
            WebDateChooser_Start_Date.Value = Date.Now.ToString("dd/MM/yyyy")
            WebDateChooser_End_Date.Value = Date.Now.ToString("dd/MM/yyyy")
            HiddenField_StartDate.Value = WebDateChooser_Start_Date.Value
            HiddenField_EndDate.Value = WebDateChooser_End_Date.Value
            'GetDaysList()
            DrawLeave()
            CalculateLeaveDays()


            GridView6.DataBind()


        End If


    End Sub

    Protected Sub WebDateChooser_Start_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_Start_Date.ValueChanged
        If Not String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) Then
            If String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then
                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            End If
        End If
        If Convert.ToDateTime(WebDateChooser_Start_Date.Value) > Convert.ToDateTime(WebDateChooser_End_Date.Value) Then
            WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
        End If

        DrawLeave()

    End Sub


    Protected Sub WebDateChooser_Start_Date0_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_Start_Date0.ValueChanged

        TextBox_Leave_Day0.Text = DateDiff(DateInterval.Day, Convert.ToDateTime(WebDateChooser_Start_Date0.Value), Convert.ToDateTime(WebDateChooser_End_Date0.Value)) + 1





    End Sub


    Protected Sub WebDateChooser_End_Date0_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_End_Date0.ValueChanged
        TextBox_Leave_Day0.Text = DateDiff(DateInterval.Day, Convert.ToDateTime(WebDateChooser_Start_Date0.Value), Convert.ToDateTime(WebDateChooser_End_Date0.Value)) + 1
    End Sub


    Protected Sub Check_Status()
        'Dim connection As New SqlConnection
        'Dim command As SqlCommand
        'Dim reader As SqlDataReader
        'connection.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        'command = connection.CreateCommand
        'command.CommandText = " SELECT     Leave_Type_Id, Carries_Forward FROM Leave_Types"
        'connection.Open()
    End Sub

    Protected Sub WebDateChooser_End_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_End_Date.ValueChanged

        If Not String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then
            If String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) Then
                WebDateChooser_Start_Date.Value = WebDateChooser_End_Date.Value
            End If
        End If
        If Convert.ToDateTime(WebDateChooser_Start_Date.Value) > Convert.ToDateTime(WebDateChooser_End_Date.Value) Then
            WebDateChooser_Start_Date.Value = WebDateChooser_End_Date.Value
        End If

        DrawLeave()

    End Sub

    Sub DrawLeave()
        Try

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Or DropDownList_L_Sub_Cat.SelectedValue = 3 Then

                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value

            End If



            If Not String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) And Not String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then

                HiddenField_StartDate.Value = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd")

                HiddenField_EndDate.Value = Convert.ToDateTime(WebDateChooser_End_Date.Value).ToString("yyyy-MM-dd")
                GetDaysList()
                '  GetDaysListOFPreviousDays()
            End If
            CalculateLeaveDays()



            'If Not String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) Then
            '    HiddenField_StartDate.Value = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd")

            '    If String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then
            '        WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            '    ElseIf Convert.ToDateTime(WebDateChooser_Start_Date.Value) < Convert.ToDateTime(WebDateChooser_End_Date.Value) Then
            '        WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            '    End If
            'End If

            'If Not String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) And Not String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then
            '    HiddenField_EndDate.Value = Convert.ToDateTime(WebDateChooser_End_Date.Value).ToString("yyyy-MM-dd")
            '    If String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) Then
            '        WebDateChooser_Start_Date.Value = WebDateChooser_End_Date.Value
            '    ElseIf Convert.ToDateTime(WebDateChooser_Start_Date.Value) > Convert.ToDateTime(WebDateChooser_End_Date.Value) Then
            '        WebDateChooser_Start_Date.Value = WebDateChooser_End_Date.Value
            '    End If


        Catch ex As Exception

        End Try

    End Sub

    Protected Sub DropDownListEmployee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListEmployee.SelectedIndexChanged
        HiddenField_EmpId.Value = DropDownListEmployee.SelectedValue
    End Sub

    Protected Sub DropDownList_desg_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.SelectedIndexChanged
        Try
            DropDownListEmployee.DataBind()
            HiddenField_EmpId.Value = DropDownListEmployee.SelectedValue
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnSelectAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSelectAll.Click
        Dim i As Integer
        If btnSelectAll.Text = "Select All" Then
            For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
                If CheckBoxList_Dates_Of_Leaves.Items(i).Enabled Then
                    CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True

                End If

            Next
            btnSelectAll.Text = "Un Select All"
        Else
            For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
                If CheckBoxList_Dates_Of_Leaves.Items(i).Enabled Then
                    CheckBoxList_Dates_Of_Leaves.Items(i).Selected = False
                End If

            Next
            btnSelectAll.Text = "Select All"
        End If


        CalculateLeaveDays()
    End Sub

    Protected Sub SqlDataSource_InsertLeaveDetail_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs)

    End Sub

    Protected Sub SqlDataSource_Employee_Leaves_Deleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Employee_Leaves.Deleted
        GridView6.DataBind()
    End Sub

    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.SelectedIndexChanged

    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim lik As LinkButton = sender
            HiddenField_Emp_Leave_ID.Value = lik.CommandArgument
            Load_Data(lik.CommandArgument)
            Panel2.Visible = True
        Catch ex As Exception
            Response.Write("err" + ex.Message)
        End Try
    End Sub

    Protected Sub buttonCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles buttonCancel.Click
        Try
            Response.Redirect("~/Leave_Management/Employee_Leaves.aspx?Emp_ID=" + (Request.QueryString("Emp_ID").ToString()))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btn_return_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_return.Click
        Response.Redirect("~/Leave_Management/Search_Employee.aspx")
    End Sub

    Protected Sub DropDownList_L_Sub_Cat_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_L_Sub_Cat.SelectedIndexChanged
        If DropDownList_L_Sub_Cat.SelectedValue = 2 Or DropDownList_L_Sub_Cat.SelectedValue = 3 Then
            WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            WebDateChooser_End_Date.Enabled = False
        Else
            WebDateChooser_End_Date.Enabled = True
        End If
        DrawLeave()
    End Sub
    Protected Sub DropDownList_Leave_Name_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Leave_Name.SelectedIndexChanged

        GetLeavePayDetails()
        DrawLeave()
        ValidateRemaining()
    End Sub
    Protected Sub GetLeavePayDetails()
        Dim sqlParams As SqlParameter() = {
           New SqlParameter("@Type_Detail_id", DropDownList_Leave_Name.SelectedValue)
        }
        Dim objDbManager As DbManager = New DbManager()
        Dim dt As DataTable = objDbManager.ExecuteDataTable("GetLeavePayDetails", "Leave_ManagementConnectionString", sqlParams)
        If dt.Rows.Count > 0 Then
            If dt.Rows(0)("Pay") = "Full" Then
                DropDownList_L_Sub_Cat.SelectedValue = "1"
            Else
                DropDownList_L_Sub_Cat.SelectedValue = "3"
            End If

            If dt.Rows(0)("Salary_Day") = 0 Then
                DropDownList_L_Sub_Cat.SelectedValue = "1"
                HfSalaryDay.Value = "0"
            Else
                HfSalaryDay.Value = "1"
            End If

            HiddenField_HasOpening.Value = dt.Rows(0)("Has_Opening")
            HfDocumentRequired.Value = dt.Rows(0)("IsDocumentRequired")
        End If

    End Sub
    Protected Sub lb_delete_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim Message As String = String.Empty
        Dim lk As LinkButton = sender
        Dim row As GridViewRow = lk.NamingContainer
        Dim emp_leave_id As HiddenField = row.FindControl("hf_e_l_id")
        Dim emp_Status As HiddenField = row.FindControl("hf_status")
        If String.IsNullOrEmpty(emp_Status.Value) Then
            delete_leave(emp_leave_id.Value)
            Message = "Leave Record Deleted Successfully..."
            DrawLeave()

        ElseIf emp_Status.Value = "True" Then
            hf_el_id.Value = emp_leave_id.Value
            pnl_app_delete.Visible = True
        Else
            Message = "Rejected Record Can't be Deleted.."

        End If

        lblMsg.Text = Message



    End Sub

    Protected Sub btn_del_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_del.Click
        If String.IsNullOrEmpty(txt_delete.Text.Trim) Then
            lbl_dele_msg.Text = "Please Enter The Reason First..."
            txt_delete.Focus()
        Else
            sds_record.Insert()
            delete_leave(hf_el_id.Value)
        End If
    End Sub

    Protected Sub delete_leave(ByVal emp_leave_id As String)
        SqlDataSource_Employee_Leaves.DeleteParameters("Emp_Leave_Id").DefaultValue = emp_leave_id
        SqlDataSource_Employee_Leaves.Delete()
        clear_dele_pnl()


    End Sub

    Protected Sub Btn_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Cancel.Click
        clear_dele_pnl()
    End Sub

    Protected Sub clear_dele_pnl()
        hf_el_id.Value = String.Empty
        txt_delete.Text = String.Empty
        lbl_dele_msg.Text = String.Empty
        pnl_app_delete.Visible = False
    End Sub

    Protected Sub CheckBoxList_Dates_Of_Leaves_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_Dates_Of_Leaves.PreRender
        'GetDaysList()
    End Sub

    Protected Sub CheckBoxList_Datces_Of_Leaves_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_Dates_Of_Leaves.SelectedIndexChanged


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
        'For Each row As GridViewRow In GridView4.Rows
        '    If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then

        '        Dim Leave_Name As Label = row.FindControl("lblLeave_Name")
        '        Dim Start_Date As Label = row.FindControl("lblStart_Date")
        '        Dim End_Date As Label = row.FindControl("lblEnd_Date")
        '        Dim sdate As DateTime = Convert.ToDateTime(Start_Date.Text)
        '        Dim eDate As DateTime = Convert.ToDateTime(End_Date.Text)
        '        Dim lDate As DateTime = Convert.ToDateTime(CheckBoxList_Dates_Of_Leaves.SelectedValue)
        '        If Leave_Name.Text = DropDownList_Leave_Name.SelectedItem.Text Then
        '            If lDate >= sdate And lDate <= eDate Then
        '                CheckBoxList_Dates_Of_Leaves.SelectedItem.Selected = False
        '                lblMsg.Visible = True
        '                lblMsg.Text = "Leave Date already Exists!"
        '                lblMsg.ForeColor = Drawing.Color.Red
        '            Else
        '                lblMsg.Visible = False
        '            End If
        '        End If
        '    End If
        'Next row


        'CalculateLeaveDays()
    End Sub


    Private Sub GetDaysListOFPreviousDays()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "uspLeavesCountOfEmployeeDateWise_am"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@startDate", HiddenField_StartDate.Value)
        cmd.Parameters.AddWithValue("@endDate", HiddenField_EndDate.Value)
        cmd.Parameters.AddWithValue("@empid", Request.QueryString("Emp_ID"))
        cmd.Connection = conn
        conn.Open()


        Dim ds As DataSet = New DataSet()

        Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)

        da.Fill(ds)


        CheckBoxList_Dates_Of_Leaves.DataSource = ds.Tables(0)
        CheckBoxList_Dates_Of_Leaves.DataValueField = "leaveDate"
        CheckBoxList_Dates_Of_Leaves.DataTextField = "leavesStatus"
        CheckBoxList_Dates_Of_Leaves.DataBind()


        If ds.Tables(0).Rows.Count > 0 Then
            For index = 0 To ds.Tables(0).Rows.Count
                CheckBoxList_Dates_Of_Leaves.Items(index).Selected = True
                CheckBoxList_Dates_Of_Leaves.Items(index).Enabled = False
            Next

        End If


        conn.Close()

    End Sub

    Private Sub GetMINMAXDates()
        Dim arr As ArrayList
        Dim arr1 As ArrayList
        Dim obj_Leave As New Leave
        If Not Request.QueryString("Emp_ID") Is Nothing Then
            arr = obj_Leave.getEmployeeData(HiddenField_EmpId.Value)
        Else
            arr = obj_Leave.getEmployeeData(Convert.ToInt32(DropDownListEmployee.SelectedValue))
            HiddenField_EmpId.Value = DropDownListEmployee.SelectedValue
        End If

        arr1 = obj_Leave.getLeaveData(Convert.ToInt32(DropDownList_Leave_Name.SelectedValue), Convert.ToInt32(arr(7)))
        'If ((arr(7) = arr1(7)) And ((Convert.ToInt32(arr(6)) >= Convert.ToInt32(arr1(3))) And (Convert.ToInt32(arr(6)) <= Convert.ToInt32(arr1(4)))) And (Convert.ToInt32(arr1(5)) >= Convert.ToInt32((TextBox_Leave_Day.Text))) And (Convert.ToInt32(arr1(6)) <= Convert.ToInt32(arr(6)))) Then


        Dim DateArray(CheckBoxList_Dates_Of_Leaves.Items.Count - 1) As DateTime
        For i As Integer = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
            If CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True Then
                DateArray(i) = CheckBoxList_Dates_Of_Leaves.Items(i).ToString()
            Else
                DateArray(i) = "01/01/2000"
            End If
        Next
        'For i As Integer = 0 To DateArray.Length - 1
        '    TextBox_Description.Text = "\n" + TextBox_Description.Text + DateArray(i) '.GetValue(i)
        'Next
        Dim MinDate As DateTime = DateTime.MaxValue
        Dim MaxDate As DateTime = DateTime.MinValue
        Array.Sort(DateArray)
        For Each CurrentDate As DateTime In DateArray
            If CurrentDate <> "01/01/2000" Then
                If MinDate > CurrentDate Then
                    MinDate = CurrentDate
                End If
                If MaxDate < CurrentDate Then
                    MaxDate = CurrentDate
                End If
            End If

        Next CurrentDate

        HiddenField_From_Date.Value = MinDate ' Convert.ToDateTime(WebDateChooser_Start_Date.Value)
        HiddenField_to_Date.Value = MaxDate 'Convert.ToDateTime(WebDateChooser_End_Date.Value)
    End Sub

    Private Sub Insert_Leave_main()
        Try
            Dim objDbManager As DbManager = New DbManager()

            Dim sqlParams As SqlParameter() = {
            New SqlParameter("@id", SqlDbType.BigInt, 8, ParameterDirection.Output, False, 0, 0, 0, DataRowVersion.Default, 0),
            New SqlParameter("@Emp_Id", HiddenField_EmpId.Value),
            New SqlParameter("@Start_Date", Convert.ToDateTime(HiddenField_From_Date.Value)),
            New SqlParameter("@End_Date", Convert.ToDateTime(HiddenField_to_Date.Value)),
            New SqlParameter("@Description", TextBox_Description.Text),
            New SqlParameter("@Type_Detail_Id", DropDownList_Leave_Name.SelectedValue),
            New SqlParameter("@Office_Ins_Id", "1"),
            New SqlParameter("@Requested_Days", TextBox_Leave_Day.Text),
            New SqlParameter("@Leave_Sub_Category", DropDownList_L_Sub_Cat.SelectedValue),
            New SqlParameter("@Leave_Days", TextBox_Leave_Day.Text),
            New SqlParameter("@Salary_Day", TextBox_Salary_Day.Text),
            New SqlParameter("@EmpSubDeptId", Request.QueryString("SubDeptId"))
            }

            objDbManager.ExecuteNonQuery("Insert_Leave_Request", "Leave_ManagementConnectionString", sqlParams)

            HiddenField_LeaveID.Value = sqlParams(0).Value
        Catch ex As Exception
            lblMsg.Text = ex.Message()

        End Try


    End Sub

    Private Sub ResetFeilds()
        TextBox_Description.Text = ""
        TextBox_Leave_Day.Text = ""
        TextBox_Salary_Day.Text = ""
        WebDateChooser_Start_Date.Value = String.Empty
        WebDateChooser_End_Date.Value = String.Empty
        CheckBoxList_Dates_Of_Leaves.Items.Clear()
        btnSelectAll.Text = "Select All"
        lblMsg.Text = "Save successfully!"
        lblMsg.ForeColor = Drawing.Color.Green
    End Sub

    Private Sub insert_leave()
        If ValidateEmployeeLeavePolicy(HiddenField_EmpId.Value, DropDownList_Leave_Name.SelectedValue) = False Then
            Return
        End If


        Insert_Leave_main()

        If HiddenField_LeaveID.Value = "-1" Then
            lblMsg.Text = "Leave request Already present ..."
            Return
        Else
            AddLeavesDetail()
            UploadDocument()
            ResetFeilds()
        End If
    End Sub


    Private Sub UploadDocument()

        If Fileupload_Document.HasFile Then
            Dim folderPath As String = Server.MapPath("~/Leave_Management/LeaveDocs/")

            'Check whether Directory (Folder) exists.
            If Not Directory.Exists(folderPath) Then
                'If Directory (Folder) does not exists. Create it.
                Directory.CreateDirectory(folderPath)
            End If




            Dim Extension As String = Path.GetExtension(Fileupload_Document.PostedFile.FileName)
            Dim FileName As String = Path.GetFileNameWithoutExtension(Fileupload_Document.PostedFile.FileName) & "_" & HiddenField_EmpId.Value.ToString() & "_" & HiddenField_LeaveID.Value.ToString() & Path.GetExtension(Fileupload_Document.PostedFile.FileName)
            'Save the File to the Directory (Folder).
            Fileupload_Document.SaveAs(folderPath & FileName)
            'Fileupload_Document.SaveAs(folderPath & Path.GetFileNameWithoutExtension(Fileupload_Document.PostedFile.FileName) & "_" & HiddenField_EmpId.Value.ToString() & "_" & HiddenField_LeaveID.Value.ToString() & Path.GetExtension(Fileupload_Document.PostedFile.FileName))
            Dim conn As New SqlConnection(constr)
            Dim cmd As New SqlCommand()
            cmd.CommandText = "INSERT INTO [LeaveDocuments] ([EmpId],[EmpLeaveId],[FileName],[ContentType],[Extension]) VALUES (@EmpId,@EmpLeaveId,@FileName,@ContentType,@Extension)"
            cmd.Parameters.AddWithValue("@EmpId", HiddenField_EmpId.Value)
            cmd.Parameters.AddWithValue("@EmpLeaveId", HiddenField_LeaveID.Value)
            cmd.Parameters.AddWithValue("@FileName", FileName)
            cmd.Parameters.AddWithValue("@ContentType", Fileupload_Document.PostedFile.ContentType)
            cmd.Parameters.AddWithValue("@Extension", Extension)
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()

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
    Private Sub ValidateRemaining()
        If Convert.ToBoolean(HiddenField_HasOpening.Value) Then
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

    Protected Sub FormView1_DataBound(sender As Object, e As EventArgs)
        'Dim ddlType As Label = Nothing
        'Dim lblStatus As Label = Nothing

        'If FormView1.Row IsNot Nothing Then
        '    ddlType = CType(FormView1.Row.FindControl("LabelGender"), Label)
        '    lblStatus = CType(FormView1.Row.FindControl("LabelStatus"), Label)

        '    If ddlType.Text = "Female" And lblStatus.Text = "Married" Then

        '        Dim newListItem As ListItem
        '        newListItem = New ListItem("Maternity Leave", "1007")
        '        ' newListItem.Selected = True
        '        DropDownList_Leave_Name.Items.Add(newListItem)

        '    End If
        'End If
    End Sub

    Private Function ValidateEmployeeLeavePolicy(EmpId As Integer, LeaveTypeId As Integer) As Boolean
        Dim Check As Boolean = False
        Dim msg As String = ""
        Using conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
            Using cmd As New SqlCommand()
                cmd.CommandText = "usp_ValidateEmployeeLeavesPolicy"
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@EmpId", EmpId)
                cmd.Parameters.AddWithValue("@LeaveTypeId", LeaveTypeId)
                cmd.Parameters.AddWithValue("@LeaveDays", TextBox_Leave_Day.Text.Trim())
                cmd.Parameters.AddWithValue("@LeaveStartDate", Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd"))
                cmd.Parameters.Add("@Status", System.Data.SqlDbType.VarChar, 100)
                cmd.Parameters("@Status").Direction = System.Data.ParameterDirection.Output
                cmd.Parameters.Add("@RemainingLeaves", System.Data.SqlDbType.VarChar, 100)
                cmd.Parameters("@RemainingLeaves").Direction = System.Data.ParameterDirection.Output
                cmd.Connection = conn
                conn.Open()
                cmd.ExecuteNonQuery()
                msg = cmd.Parameters("@Status").Value.ToString()
            End Using
            conn.Close()
        End Using
        If msg = "OK" Then
            Check = True
        Else
            Check = False
            lblMsg.Text = msg
            lblMsg.ForeColor = System.Drawing.Color.Red
        End If
        Return Check
    End Function
End Class
