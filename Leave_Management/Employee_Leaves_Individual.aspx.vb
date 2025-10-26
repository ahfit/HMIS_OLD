Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Collections
Partial Class Leave_Management_Employee_Leaves_Individual
    Inherits System.Web.UI.Page
    Dim user_constr As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
    ' Dim crdoc As New ReportDocument

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            Dim msg As String = String.Empty

            If isLeaveValid(msg) = False Then
                Dim sb As New System.Text.StringBuilder()
                Dim Alert As String = String.Format("Attendance is marked for {0} Day(s).", msg)
                sb.Append("<script language='javascript' type='text/javascript'>alert('" + Alert + "');</script>")
                Dim t As Type = Me.GetType()
                If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                End If
                lblMsg.Text = String.Format("Attendance is marked for {0} Day(s).", msg)
                If DropDownList_L_Sub_Cat.SelectedValue = 1 Then
                    Return
                End If


            End If

            Dim arr As ArrayList
            Dim arr1 As ArrayList
            Dim obj_Leave As New Leave
            'If Not Request.QueryString("Emp_ID") Is Nothing Then
            arr = obj_Leave.getEmployeeData(HiddenField_EmpId.Value)
            'Else
            '    arr = obj_Leave.getEmployeeData(Convert.ToInt32(DropDownListEmployee.SelectedValue))
            '    HiddenField_EmpId.Value = DropDownListEmployee.SelectedValue
            'End If

            arr1 = obj_Leave.getLeaveData(Convert.ToInt32(DropDownList_Leave_Name.SelectedValue), Convert.ToInt32(arr(7)))
            'If ((arr(7) = arr1(7)) And ((Convert.ToInt32(arr(6)) >= Convert.ToInt32(arr1(3))) And (Convert.ToInt32(arr(6)) <= Convert.ToInt32(arr1(4)))) And (Convert.ToInt32(arr1(5)) >= Convert.ToInt32((TextBox_Leave_Day.Text))) And (Convert.ToInt32(arr1(6)) <= Convert.ToInt32(arr(6)))) Then

            'For Each item As ListItem In CheckBoxList_Dates_Of_Leaves.Items
            '    If item.Selected Then

            '        Dim MinDate As DateTime
            '        Dim MaxDate As DateTime
            '        MinDate = item.Value
            '        MaxDate = item.Value
            '        hdfFinalMinDate.Value = item.Value
            '        hdfFinalMaxDate.Value = item.Value
            '        If hdfFinalMinDate.Value >= MinDate Then
            '            hdfFinalMinDate.Value = item.Value
            '        End If
            '        If hdfFinalMaxDate.Value <= MaxDate Then
            '            hdfFinalMaxDate.Value = item.Value
            '        End If



            '    End If
            'Next

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
            SqlDataSource_Employee_Leaves.InsertParameters("Leave_Days").DefaultValue = TextBox_Leave_Day.Text
            SqlDataSource_Employee_Leaves.InsertParameters("Salary_Day").DefaultValue = TextBox_Salary_Day.Text

            For Each row As GridViewRow In GridView6.Rows


                Dim Leave_Name As Label = row.FindControl("lblLeave_Name")
                Dim Remaining As Label = row.FindControl("lblRemaining")
                If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then
                    Dim lDate As DateTime = Convert.ToDateTime(CheckBoxList_Dates_Of_Leaves.SelectedValue)
                    If Leave_Name.Text = DropDownList_Leave_Name.SelectedItem.Text Then
                        If Convert.ToDecimal(Remaining.Text) >= Convert.ToDecimal(TextBox_Leave_Day.Text) Then
                            SqlDataSource_Employee_Leaves.Insert()

                            TextBox_Description.Text = ""
                            TextBox_Leave_Day.Text = ""
                            TextBox_Salary_Day.Text = ""
                            WebDateChooser_Start_Date.Value = String.Empty
                            WebDateChooser_End_Date.Value = String.Empty
                            CheckBoxList_Dates_Of_Leaves.Items.Clear()
                            btnSelectAll.Text = "Select All"
                            lblMsg.Text = "Save successfully!"
                            lblMsg.ForeColor = Drawing.Color.Green
                        Else
                            lblMsg.Text = "Remaining Leaves are too Short!"
                            lblMsg.Visible = True
                            lblMsg.ForeColor = Drawing.Color.Red
                        End If

                    End If
                End If


            Next row






            ' End If
            '=============================


            WebDateChooser_Start_Date.Value = Date.Now
            WebDateChooser_End_Date.Value = Date.Now
            DrawLeave()
        Catch ex As Exception
            lblMsg.Text = "Fail to save."
            lblMsg.ForeColor = Drawing.Color.Red
            Response.Write(ex.Message)
        End Try
        GridView6.DataBind()
    End Sub
    Private Sub GetDaysList()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "usp_WorkingDaysFind"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@StartDate", HiddenField_StartDate.Value)
        cmd.Parameters.AddWithValue("@EndDate", HiddenField_EndDate.Value)
        cmd.Parameters.AddWithValue("@Dept_Id", Session("Dept_Id"))
        cmd.Parameters.AddWithValue("@EmpId", Session("Emp_ID"))
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
                    CheckBoxList_Dates_Of_Leaves.Items(var).Attributes.Add("style", "color: red; font-weight:bold;")
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
            days = 0

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Then
                days = 0.3333333
            ElseIf DropDownList_L_Sub_Cat.SelectedValue = 3 Then
                days = 0.5
            Else
                For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
                    If CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True Then
                        days = days + 1
                    End If
                Next
            End If






            TextBox_Leave_Day.Text = Convert.ToString(days)
            TextBox_Salary_Day.Text = Convert.ToString(days)
        Catch ex As Exception

        End Try
    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Session("Emp_ID") Is Nothing Then
            Panel1.Visible = False
            HiddenField_EmpId.Value = Session("Emp_ID").ToString()
        End If




        If Not IsPostBack Then
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
        DrawLeave()

    End Sub
    Protected Sub Check_Status()
        Dim connection As New SqlConnection
        Dim command As SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString
        command = connection.CreateCommand
        command.CommandText = " SELECT     Leave_Type_Id, Carries_Forward FROM Leave_Types"
        connection.Open()
    End Sub

    Protected Sub WebDateChooser_End_Date_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser_End_Date.ValueChanged
        DrawLeave()

    End Sub

    Sub DrawLeave()
        Try

            If DropDownList_L_Sub_Cat.SelectedValue = 2 Then
                WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            End If

            If Not String.IsNullOrEmpty(WebDateChooser_Start_Date.Value) And Not String.IsNullOrEmpty(WebDateChooser_End_Date.Value) Then
                HiddenField_StartDate.Value = Convert.ToString(WebDateChooser_Start_Date.Value)

                HiddenField_EndDate.Value = Convert.ToString(WebDateChooser_End_Date.Value)
                GetDaysList()

            End If
            CalculateLeaveDays()


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
                CheckBoxList_Dates_Of_Leaves.Items(i).Selected = True
            Next
            btnSelectAll.Text = "Un Select All"
        Else
            For i = 0 To CheckBoxList_Dates_Of_Leaves.Items.Count - 1
                CheckBoxList_Dates_Of_Leaves.Items(i).Selected = False
            Next
            btnSelectAll.Text = "Select All"
        End If


        CalculateLeaveDays()
    End Sub

    Protected Sub SqlDataSource_InsertLeaveDetail_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs)

    End Sub

    Protected Sub SqlDataSource_Employee_Leaves_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs)

    End Sub

    Protected Sub SqlDataSource_Employee_Leaves_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Employee_Leaves.Inserted
        HiddenField_LeaveID.Value = e.Command.Parameters("@id").Value
        AddLeavesDetail()
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
        If DropDownList_L_Sub_Cat.SelectedValue = 2 Then
            WebDateChooser_End_Date.Value = WebDateChooser_Start_Date.Value
            WebDateChooser_End_Date.Enabled = False
        Else
            WebDateChooser_End_Date.Enabled = True
        End If
        DrawLeave()
    End Sub


    Protected Sub DropDownList_Leave_Name_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Leave_Name.SelectedIndexChanged
        If DropDownList_Leave_Name.SelectedValue = "1" Or DropDownList_Leave_Name.SelectedValue = "9" Then
            DropDownList_L_Sub_Cat.Enabled = True
        Else
            DropDownList_L_Sub_Cat.Enabled = False
            DropDownList_L_Sub_Cat.SelectedValue = "1"
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

        For Each row As GridViewRow In GridView4.Rows
            If CheckBoxList_Dates_Of_Leaves.SelectedValue <> "" Then

                Dim Leave_Name As Label = row.FindControl("lblLeave_Name")
                Dim Start_Date As Label = row.FindControl("lblStart_Date")
                Dim End_Date As Label = row.FindControl("lblEnd_Date")
                Dim sdate As DateTime = Convert.ToDateTime(Start_Date.Text)
                Dim eDate As DateTime = Convert.ToDateTime(End_Date.Text)
                Dim lDate As DateTime = Convert.ToDateTime(CheckBoxList_Dates_Of_Leaves.SelectedValue)
                If Leave_Name.Text = DropDownList_Leave_Name.SelectedItem.Text Then
                    If lDate >= sdate And lDate <= eDate Then
                        CheckBoxList_Dates_Of_Leaves.SelectedItem.Selected = False
                        lblMsg.Visible = True
                        lblMsg.Text = "Leave Date already Exists!"
                        lblMsg.ForeColor = Drawing.Color.Red
                    Else
                        lblMsg.Visible = False
                    End If
                End If
            End If
        Next row


        CalculateLeaveDays()
    End Sub

    Protected Sub GridView4_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lbl As Label = e.Row.FindControl("Label1")
            Dim lnkbtn As LinkButton = e.Row.FindControl("lb_delete")
            If lbl.Text = "Pending" Then

                lnkbtn.Visible = True

            Else
                lnkbtn.Visible = False
            End If

        End If


    End Sub
End Class
