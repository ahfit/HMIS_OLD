Imports System.Data.Sql
Imports System.Data.SqlClient
Imports Infragistics.WebUI.WebSchedule
Imports Infragistics.WebUI.WebDataInput
Partial Class Nursing_AddPatientCondition
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Dim obj_menu As New JavaScriptMenu
'        LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))))

Dim obj_menu As New JavaScriptMenu
obj_menu.loginvalidate()
LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
LabelFooter.Text = obj_menu.Footer_String()
		
        If Not IsPostBack Then

            HiddenField_RegNo.Value = Session("RegistrationNo")
            HiddenField_YearlyNo.Value = Session("YearlyNo")
            WebDateChooser_Start.Value = Date.Now
            WebDateChooser_End.Value = Date.Now
            WebDateTimeEdit_Start.Value = Date.Now.TimeOfDay
            WebDateTimeEdit_End.Value = Date.Now.TimeOfDay

            GridView_Record.DataBind()
            DataList_PatientINfo.DataBind()
        End If
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim SP As String = "Insert_Patient_Condition_Type"
        Dim cmd As SqlCommand = New SqlCommand(SP, con)
        cmd.CommandType = Data.CommandType.StoredProcedure
        con.Open()

        Dim frmDate As DateTime = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_Start.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_Start.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_Start.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_Start.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Start.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Start.Value).Second.ToString)
        Dim todate As DateTime
        If WebDateChooser_End.Value Is Nothing Then
            'Response.Write("Null")
            todate = WebDateChooser_End.Value
        Else
            todate = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_End.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_End.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_End.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_End.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_End.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_End.Value).Second.ToString)
            'Response.Write("NotNull")
        End If

        cmd.Parameters.AddWithValue("@FromDate", frmDate)
        If WebDateChooser_End.Value Is Nothing Then
            cmd.Parameters.AddWithValue("@ToDate", System.DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@ToDate", todate)
        End If

        cmd.Parameters.AddWithValue("@Condition", DropDownList_Condition.SelectedItem.Text)
        cmd.Parameters.AddWithValue("@Condition_ID", DropDownList_Condition.SelectedValue)
        cmd.Parameters.AddWithValue("@InformToDoctor", DropDownList_Doctors.SelectedValue)
        cmd.Parameters.AddWithValue("@Counseling", TextBox_Counseling.Text)
        cmd.Parameters.AddWithValue("@Comments", TextBox_Comments.Text)
        cmd.Parameters.AddWithValue("@RegNo", HiddenField_RegNo.Value)
        cmd.Parameters.AddWithValue("@YearlyNo", HiddenField_YearlyNo.Value)
        cmd.Parameters.AddWithValue("@Activity_Level_ID", DropDownList_Arrival_Status.SelectedValue)
        cmd.Parameters.AddWithValue("@Emp_id", Session("Emp_Id"))
        Dim str As String = ""
        For count As Integer = 0 To CheckBoxList_Canulas.Items.Count - 1


            If CheckBoxList_Canulas.Items(count).Selected = True Then
                If str = "" Then
                    str = CheckBoxList_Canulas.Items(count).Value
                Else
                    str = str & "," & CheckBoxList_Canulas.Items(count).Value
                End If


            End If

        Next
        cmd.Parameters.AddWithValue("@Canulas", str)

        'cmd.Parameters.AddWithValue("@SubDept_Inout_Id", 1)
        cmd.Parameters.AddWithValue("@ID", 0)

        cmd.ExecuteNonQuery()
        con.Close()
        GridView_Record.DataBind()
    End Sub




    Protected Sub GridView_Record_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Record.PreRender
        If GridView_Record.Rows.Count <> 0 Then

            For i As Integer = 0 To GridView_Record.Rows.Count - 1
                'Dim HiddenField_FromDate As HiddenField = GridView_Record.Rows(i).FindControl("HiddenField_FromDate")
                'Dim FromDate As WebDateChooser = GridView_Record.Rows(i).FindControl("WebDateChooser_FromDate")
                'Dim WebDateTimeEdit_FromTime As WebDateTimeEdit = GridView_Record.Rows(i).FindControl("WebDateTimeEdit_FromTime")
                'If HiddenField_FromDate.Value <> "" Then
                '    Dim frmDate As DateTime = Convert.ToDateTime(HiddenField_FromDate.Value)
                '    FromDate.Value = frmDate.Date

                '    WebDateTimeEdit_FromTime.Value = frmDate.TimeOfDay

                'End If

                'Dim HiddenField_ToDate As HiddenField = GridView_Record.Rows(i).FindControl("HiddenField_ToDate")
                'Dim Todate As WebDateChooser = GridView_Record.Rows(i).FindControl("WebDateChooser_ToDate")
                'Dim WebDateTimeEdit_ToDate As WebDateTimeEdit = GridView_Record.Rows(i).FindControl("WebDateTimeEdit_ToDate")
                'If HiddenField_ToDate.Value <> "" Then
                '    Dim Todte As DateTime = Convert.ToDateTime(HiddenField_ToDate.Value)
                '    Todate.Value = Todte.Date
                '    WebDateTimeEdit_ToDate.Value = Todte.TimeOfDay
                'End If
                GridView_Record.Rows(i).Cells(0).Visible = False
                GridView_Record.Rows(i).Cells(1).Visible = False
            Next
            GridView_Record.HeaderRow.Cells(0).Visible = False
            GridView_Record.HeaderRow.Cells(1).Visible = False
        End If
    End Sub

    Protected Sub GridView_Record_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Record.SelectedIndexChanged
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim SP As String = "Insert_Patient_Condition_Type"
        Dim cmd As SqlCommand = New SqlCommand(SP, con)
        cmd.CommandType = Data.CommandType.StoredProcedure
        con.Open()
        Dim RegNo As String = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).Cells(0).Text
        Dim YrlyNo As String = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).Cells(1).Text
        Dim WebDateChooser_FromDate As WebDateChooser = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("WebDateChooser_FromDate")
        Dim WebDateTimeEdit_FromTime As WebDateTimeEdit = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("WebDateTimeEdit_FromTime")
        Dim WebDateChooser_ToDate As WebDateChooser = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("WebDateChooser_ToDate")
        Dim WebDateTimeEdit_ToDate As WebDateTimeEdit = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("WebDateTimeEdit_ToDate")

        Dim DropDownList_Condition As DropDownList = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("DropDownList_Condition")
        Dim DropDownList_Doctor As DropDownList = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("DropDownList_Doctor")
        Dim TextBox_Counseling As TextBox = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("TextBox_Counseling")
        Dim TextBox_Comment As TextBox = GridView_Record.Rows(GridView_Record.SelectedRow.RowIndex).FindControl("TextBox_Comment")

        Dim frmDate As DateTime = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_FromDate.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_FromDate.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_FromDate.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Second.ToString)
        Dim todate As DateTime
        If WebDateChooser_ToDate.Value Is Nothing Then
            'Response.Write("Null")
            todate = WebDateChooser_ToDate.Value
        Else
            todate = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_ToDate.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_ToDate.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_ToDate.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Second.ToString)
            'Response.Write("NotNull")
        End If

        cmd.Parameters.AddWithValue("@FromDate", frmDate)
        If WebDateChooser_ToDate.Value Is Nothing Then
            cmd.Parameters.AddWithValue("@ToDate", System.DBNull.Value)
        Else
            cmd.Parameters.AddWithValue("@ToDate", todate)
        End If

        cmd.Parameters.AddWithValue("@Condition", DropDownList_Condition.SelectedItem.Text)
        cmd.Parameters.AddWithValue("@Condition_ID", DropDownList_Condition.SelectedValue)
        cmd.Parameters.AddWithValue("@InformToDoctor", DropDownList_Doctor.SelectedValue)
        cmd.Parameters.AddWithValue("@Counseling", TextBox_Counseling.Text)
        cmd.Parameters.AddWithValue("@Comments", TextBox_Comment.Text)
        cmd.Parameters.AddWithValue("@RegNo", RegNo)
        cmd.Parameters.AddWithValue("@YearlyNo", YrlyNo)
        'cmd.Parameters.AddWithValue("@SubDept_Inout_Id", 1)
        cmd.Parameters.AddWithValue("@ID", GridView_Record.SelectedValue)

        cmd.ExecuteNonQuery()
        con.Close()
        GridView_Record.DataBind()
    End Sub

   
    Protected Sub GridView_Record_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView_Record.RowUpdating
        'Response.Write("Rowupdating calls")
        'Response.Write(e.RowIndex)

        Try
            Dim i As Integer = e.RowIndex
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim SP As String = "Insert_Patient_Condition_Type"
            Dim cmd As SqlCommand = New SqlCommand(SP, con)
            cmd.CommandType = Data.CommandType.StoredProcedure
            con.Open()
            Dim RegNo As String = GridView_Record.Rows(i).Cells(0).Text
            If RegNo = "" Then
                RegNo = "0 "
            End If
            Dim YrlyNo As String = GridView_Record.Rows(i).Cells(1).Text
            If YrlyNo = "" Then
                YrlyNo = 0
            End If
            Dim WebDateChooser_FromDate As WebDateChooser = GridView_Record.Rows(i).FindControl("WebDateChooser_FromDate")
            Dim WebDateTimeEdit_FromTime As WebDateTimeEdit = GridView_Record.Rows(i).FindControl("WebDateTimeEdit_FromTime")
            Dim WebDateChooser_ToDate As WebDateChooser = GridView_Record.Rows(i).FindControl("WebDateChooser_ToDate")
            Dim WebDateTimeEdit_ToDate As WebDateTimeEdit = GridView_Record.Rows(i).FindControl("WebDateTimeEdit_ToDate")

            Dim DropDownList_Condition As DropDownList = GridView_Record.Rows(i).FindControl("DropDownList_Condition")
            Dim DropDownList_Doctor As DropDownList = GridView_Record.Rows(i).FindControl("DropDownList_Doctor")
            Dim TextBox_Counseling As TextBox = GridView_Record.Rows(i).FindControl("TextBox_Counseling")
            Dim TextBox_Comment As TextBox = GridView_Record.Rows(i).FindControl("TextBox_Comment")

            Dim HiddenField_ID As HiddenField = GridView_Record.Rows(i).FindControl("HiddenField_ID")

            Dim HiddenField_Activity_Level_ID As DropDownList = GridView_Record.Rows(i).FindControl("DropDownList_Arrival_Status")
            'Dim TextBox_canulas As TextBox = GridView_Record.Rows(i).FindControl("TextBox_canulas")
        


            Dim frmDate As DateTime = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_FromDate.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_FromDate.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_FromDate.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_FromTime.Value).Second.ToString)
            Dim todate As DateTime
            If WebDateChooser_ToDate.Value Is Nothing Then
                'Response.Write("Null")
                todate = WebDateChooser_ToDate.Value
            Else
                todate = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_ToDate.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_ToDate.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_ToDate.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_ToDate.Value).Second.ToString)
                'Response.Write("NotNull")
            End If

            cmd.Parameters.AddWithValue("@FromDate", frmDate)
            If WebDateChooser_ToDate.Value Is Nothing Then
                cmd.Parameters.AddWithValue("@ToDate", System.DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@ToDate", todate)
            End If

            cmd.Parameters.AddWithValue("@Condition", DropDownList_Condition.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@Condition_ID", DropDownList_Condition.SelectedValue)
            cmd.Parameters.AddWithValue("@InformToDoctor", DropDownList_Doctor.SelectedValue)
            cmd.Parameters.AddWithValue("@Counseling", TextBox_Counseling.Text)
            cmd.Parameters.AddWithValue("@Comments", TextBox_Comment.Text)
            cmd.Parameters.AddWithValue("@RegNo", RegNo)
            cmd.Parameters.AddWithValue("@YearlyNo", YrlyNo)
            cmd.Parameters.AddWithValue("@Activity_Level_ID", HiddenField_Activity_Level_ID.SelectedValue)
            'cmd.Parameters.AddWithValue("@SubDept_Inout_Id", 1)
            cmd.Parameters.AddWithValue("@Canulas", "")
            cmd.Parameters.AddWithValue("@ID", HiddenField_ID.Value)

            cmd.ExecuteNonQuery()
            con.Close()
            GridView_Record.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    

    

 
End Class
