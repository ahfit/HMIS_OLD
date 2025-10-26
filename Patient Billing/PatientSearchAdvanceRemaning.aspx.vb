Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Billing_patientsearchAdvanceRemaning
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim prefix As String = ""
    Dim pgindex As Integer = 0
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'This page is use for searching a patient record, On this page CMO can also view   '
    'Patient Movement Histroy,Patient Detail ,can Edit Record of a Patient                 '
    ' by using QueryString "regno","payid"                                             '
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
    Dim userAuthen As New User_page_Authentication
    Dim searchpanel1 As New SearchPanel
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'this function use to chck that it is a  valid user or not ' 
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
                'Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message & " Validate ")
        End Try
    End Sub
    Sub search1(ByVal indx As Integer)
        'Try
        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        'Dim dtaset As DataSet = searchpanel1.search1(Panel2, "Search_Patient_UnpaidAdvance", constring)
        'Response.Write(Session("SubDeptID"))
        'Dim dtaset As DataSet = searchpanel1.search1(Panel2, "Search_Patient_UnpaidAdvance", constring)

        Dim dtaset As DataSet = search(Panel2, "Search_Patient_UnpaidAdvance", constring)
        GridViewSearch.DataSource = dtaset.Tables(0)
        ' GridViewSearch.DataSource = dtaset.Tables("Search_Patient_for_Admission_indoor")
        GridViewSearch.AutoGenerateColumns = True
        GridViewSearch.AllowPaging = True
        GridViewSearch.PageSize = 500
        GridViewSearch.PageIndex = indx
        GridViewSearch.DataBind()
        '    Session.Add("PayId", Convert.ToString(dtaset.Tables("Search_Patient_For_Receptionist").Rows(0)("Visit No")))
        'Catch ex As Exception
        '    Response.Write(ex.Message + "dasfsdfdss")
        'End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            searchpanel1.search_Panel(Panel2)
            Session.Timeout = 60
            'Response.Write(Session("SubDeptID"))
            'GridViewSearch.DataBind()
            loginvalidate(Session("emp_id"), Session("dept_id"))
            ' form1.DefaultButton = "Button1"
            If Page.IsPostBack = False Then
                'search1(0)
            End If
        Catch ex As Exception
            Response.Write(ex.Message & "Load")
        End Try

    End Sub

    Protected Sub GridViewSearch_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridViewSearch.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        search1(0)
    End Sub

    Protected Sub GridViewSearch_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.PreRender
        Try
            'Dim patientname As String = String.Empty
            ''If Not Page.IsPostBack Then
            'If GridViewSearch.Rows.Count <> 0 Then
            '    'GridViewSearch.HeaderRow.Cells(7).Text = "Visit No."
            '    'GridViewSearch.HeaderRow.Cells(9).Text = "Patient Name"
            '    'GridViewSearch.HeaderRow.Cells(23).Text = "Bed No."
            '    'GridViewSearch.HeaderRow.Cells(23).Text = "Patient Type"

            '    ' GridViewSearch.HeaderRow.Cells(8).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(10).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(11).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(12).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(18).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(19).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(20).Visible = False
            '    'GridViewSearch.HeaderRow.Cells(21).Visible = False
            '    For i As Integer = 0 To GridViewSearch.Rows.Count - 1
            '        If Page.IsPostBack = True Then
            '            Dim prefix As String = ""
            '        Else
            '            prefix = GridViewSearch.Rows(i).Cells(9).Text
            '            GridViewSearch.Rows(i).Cells(9).Text = GridViewSearch.Rows(i).Cells(9).Text 'prefix & " " &
            '        End If
            '        '     GridViewSearch.Rows(i).Cells(23).Enabled = False
            '        If GridViewSearch.Rows(i).Cells(22).Text = "paid" Then
            '            GridViewSearch.Rows(i).Cells(6).Enabled = False

            '            GridViewSearch.Rows(i).Cells(4).Enabled = False
            '            GridViewSearch.Rows(i).Cells(4).ToolTip = "Final Payment Paid"
            '            GridViewSearch.Rows(i).Cells(4).ForeColor = Drawing.Color.Gray

            '            If GridViewSearch.Rows(i).Cells(23).Text <> "Insurance" Then
            '                GridViewSearch.Rows(i).Cells(6).Enabled = False
            '                GridViewSearch.Rows(i).Cells(6).ForeColor = Drawing.Color.Gray
            '                GridViewSearch.Rows(i).Cells(6).ToolTip = "Final Paid"
            '            End If


            '        Else

            '            If GridViewSearch.Rows(i).Cells(23).Text <> "Insurance" Then
            '                GridViewSearch.Rows(i).Cells(6).Enabled = True
            '                GridViewSearch.Rows(i).Cells(6).ForeColor = Drawing.Color.Gray
            '                GridViewSearch.Rows(i).Cells(6).ToolTip = "Not an Entitled Patient"
            '            End If

            '        End If
            '        'GridViewSearch.Rows(i).Cells(22).Visible = False

            '        GridViewSearch.Rows(i).Cells(9).Text = GridViewSearch.Rows(i).Cells(9).Text & " " & GridViewSearch.Rows(i).Cells(10).Text & " " & GridViewSearch.Rows(i).Cells(11).Text & " " & GridViewSearch.Rows(i).Cells(12).Text

            '        GridViewSearch.Rows(i).Cells(10).Visible = False
            '        GridViewSearch.Rows(i).Cells(11).Visible = False
            '        GridViewSearch.Rows(i).Cells(12).Visible = False
            '        GridViewSearch.Rows(i).Cells(18).Visible = False
            '        GridViewSearch.Rows(i).Cells(19).Visible = False
            '        GridViewSearch.Rows(i).Cells(20).Visible = False
            '        GridViewSearch.Rows(i).Cells(21).Visible = False
            '        'GridViewSearch.Rows(i).Cells(22).Visible = False
            '    Next
            'End If
        Catch ex As Exception
            Response.Write(ex.Message & "Prerender ")
        End Try
    End Sub

    Function Check_For_Services(ByVal reg_no As String, ByVal yearly_no As Integer, ByVal sub_dept_id As Integer) As Integer
        Dim count As Integer = 0
        Try
            Dim con_str As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con_basic As SqlConnection = New SqlConnection(con_str)
            Dim command_basic As SqlCommand = New SqlCommand("SELECT Count(*) FROM Patient_Services where RegNo=@RegNo and YearlyNo=@YearlyNo and SubDept_ID=@SubDept_ID", con_basic)
            command_basic.Parameters.AddWithValue("@RegNo", reg_no)
            command_basic.Parameters.AddWithValue("@YearlyNo", yearly_no)
            command_basic.Parameters.AddWithValue("@SubDept_ID", sub_dept_id)
            con_basic.Open()
            Dim reader As SqlDataReader = command_basic.ExecuteReader
            While reader.Read
                count = reader.GetInt32(0)
            End While
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return count
    End Function

    Protected Sub GridViewSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewSearch.RowCommand
        If e.CommandName = "Payment" Then

            Dim regNo As String = GridViewSearch.Rows(e.CommandArgument).Cells(1).Text
            Dim YearlyNo As String = GridViewSearch.Rows(e.CommandArgument).Cells(2).Text
            Dim URL As String = "../Patient Billing/Indoor_Patient_Paymen.aspx?regno=" + regNo + "&payid=" + YearlyNo
            Session.Add("registrationNo", regNo)
            Session.Add("YearlyNo", YearlyNo)
            Dim sb As New StringBuilder
            sb.Append("<script language='javascript' type='text/javascript'>window.open('" + URL + "','_blank');</Script>")
            Dim t As Type = Me.GetType()
            If Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp") Then
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
            End If

        End If
    End Sub
    Function Get_DeptID(ByVal regno As String, ByVal payid As Integer) As Integer
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @DeptID = deptid from payment where regNo = @RegNo and payid = @payid", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            mycommand.Parameters.Add("@DeptID", SqlDbType.Int)
            mycommand.Parameters("@DeptID").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Session.Add("Dept_Service", mycommand.Parameters("@DeptID").Value)
            Dim yearly As Integer = mycommand.Parameters("@DeptID").Value
            mycommand.Connection.Close()
            Return yearly
        Catch ex As Exception
            Return 0
            Response.Write(ex.Message)
        End Try

    End Function

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub
    Function search(ByVal pnl As Panel, ByVal procedure As String, ByVal constr As String) As DataSet
        Dim YearlyNo As Int64
        Dim TextBoxPFName As String = ""
        Dim TextBoxRegNo As String = ""
        Dim TextBoxPMName As String = ""
        Dim TextBoxAge As Integer = 0
        Dim TextBoxRelation As String = ""
        Dim TextBoxFName As String = ""
        Dim TextBoxFMName As String = ""
        Dim TextBoxCNIC As String = ""
        Dim TextBoxPhone As String = ""
        Dim WebDate As String = ""
        Dim dte As Integer = 0
        Dim mon As Integer = 0
        Dim year As Integer = 0
        Dim Shift As Integer = 0
        For i As Integer = 0 To pnl.Controls.Count - 1
            If pnl.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txtbox As TextBox = pnl.FindControl(pnl.Controls(i).ID.ToString)
                If txtbox.ID = "TextBoxYearlyNo" Then
                    If txtbox.Text.Trim = "" Then
                        YearlyNo = 0
                    Else
                        YearlyNo = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxPFName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxPFName = "%"
                    Else
                        txtbox.Text.Trim.ToLower()
                        TextBoxPFName = ENC.Encrypt_Main(ENC.TitleCase(txtbox.Text.Trim), True)
                    End If
                End If
                If txtbox.ID = "TextBoxRegNo" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxRegNo = "%"
                    Else
                        TextBoxRegNo = ENC.Encrypt_Main(txtbox.Text.Trim, True)
                    End If
                End If
                If txtbox.ID = "TextBoxPMName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxPMName = "%"
                    Else
                        txtbox.Text.Trim.ToLower()
                        TextBoxPMName = ENC.Encrypt_Main(ENC.TitleCase(txtbox.Text.Trim), True)
                    End If
                End If
                If txtbox.ID = "TextBoxAge" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxAge = 0
                    Else
                        TextBoxAge = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxRelation" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxRelation = "%"
                    Else
                        TextBoxRelation = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxFName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxFName = "%"
                    Else
                        TextBoxFName = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxFMName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxFMName = "%"
                    Else
                        TextBoxFMName = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxCNIC" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxCNIC = "%"
                    Else
                        TextBoxCNIC = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxPhone" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxPhone = "%"
                    Else
                        TextBoxPhone = txtbox.Text.Trim
                    End If
                End If


            End If
            ''''''''''''''''''''''''''''''''
            ' If pnl.Controls(i).GetType().ToString.Contains("RadioButtonList_Shift") Then
            'Dim list As RadioButtonList = pnl.FindControl("RadioButtonList_Shift")
            '' HttpContext.Current.Response.Write(list.SelectedValue)
            'If list.ID = "RadioButtonList_Shift" Then
            '    If list.SelectedValue = "" Then
            '        Shift = 0
            '        '  HttpContext.Current.Response.Write(Shift)
            '    Else
            '        Shift = list.SelectedValue
            '        '   HttpContext.Current.Response.Write(Shift)
            '    End If
            'End If
            ' End If
            '''''''''''''''''''''''''''''''''''''''''

            If pnl.Controls(i).GetType().ToString.Contains("WebDateChooser") Then
                Dim WebDateChooser As Infragistics.WebUI.WebSchedule.WebDateChooser = pnl.FindControl(pnl.Controls(i).ID.ToString)
                If WebDateChooser.Text = "Null" Then 'Month Then '& "/" & Date.Now.Day & "/" & Date.Now.Year Then
                    dte = 0
                    mon = 0
                    year = 0
                Else
                    WebDate = WebDateChooser.Value
                    Dim aw As DateTime = CDate(WebDate)
                    dte = aw.Day
                    mon = aw.Month
                    year = aw.Year
                End If
            End If
        Next
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand(procedure, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        If procedure = "Search_Emg_Dept_Patient_New" Then
            '   param = mycommand.Parameters.AddWithValue("@SubDeptNo", Session("SubDeptId"))
            param = mycommand.Parameters.AddWithValue("@Status", "false")
            param = mycommand.Parameters.AddWithValue("@Request_type_ID", 1)
        End If
        param = mycommand.Parameters.AddWithValue("@YearlyNo", YearlyNo)
        param = mycommand.Parameters.AddWithValue("@PFName", TextBoxPFName)
        param = mycommand.Parameters.AddWithValue("@PMName", TextBoxPMName)
        param = mycommand.Parameters.AddWithValue("@RFName", TextBoxFName)
        param = mycommand.Parameters.AddWithValue("@RMName", TextBoxFMName)
        param = mycommand.Parameters.AddWithValue("@Relation", TextBoxRelation)
        param = mycommand.Parameters.AddWithValue("@age", TextBoxAge)
        param = mycommand.Parameters.AddWithValue("@RegNo", TextBoxRegNo)
        param = mycommand.Parameters.AddWithValue("@Day", dte)
        param = mycommand.Parameters.AddWithValue("@month", mon)
        param = mycommand.Parameters.AddWithValue("@year", year)
        param = mycommand.Parameters.AddWithValue("@Shift", Shift)
        param = mycommand.Parameters.AddWithValue("@CNIC", TextBoxCNIC)
        param = mycommand.Parameters.AddWithValue("@Mobile_phone", TextBoxPhone)
        param = mycommand.Parameters.AddWithValue("@HospitalId", HttpContext.Current.Session("HospitalId"))
        mycommand.Connection.Open()

        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "ABC")
        mycommand.ExecuteNonQuery()
        'For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
        '    ds.Tables(0).Rows(i).Item("Pfname") = ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("Pfname").ToString(), False)
        '    ds.Tables(0).Rows(i).Item("Pmname") = ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("Pmname").ToString(), False)
        '    ds.Tables(0).Rows(i).Item("Plname") = ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("Plname").ToString(), False)
        '    ds.Tables(0).Rows(i).Item("Registration No") = ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("Registration No").ToString(), False)
        'Next
        mycommand.Connection.Close()
        Return ds
    End Function

    'Function Get_DeptID(ByVal regno As String, ByVal payid As Integer) As Integer
    '    Try
    '        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '        Dim mycommand As New System.Data.SqlClient.SqlCommand("", con)
    '        mycommand.CommandType = Data.CommandType.Text
    '        mycommand.Parameters.AddWithValue("@RegNo", regno)
    '        mycommand.Parameters.AddWithValue("@payid", payid)
    '        mycommand.Parameters.Add("@DeptID", SqlDbType.Int)
    '        mycommand.Parameters("@DeptID").Direction = ParameterDirection.Output
    '        mycommand.Connection.Open()
    '        mycommand.ExecuteNonQuery()
    '        Session.Add("Dept_Service", mycommand.Parameters("@DeptID").Value)
    '        Dim yearly As Integer = mycommand.Parameters("@DeptID").Value
    '        mycommand.Connection.Close()
    '        Return yearly
    '    Catch ex As Exception
    '        Return 0
    '        Response.Write(ex.Message)
    '    End Try

    'End Function
End Class
