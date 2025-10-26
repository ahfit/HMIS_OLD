Imports System.Data
Imports System.Data.SqlClient
Partial Class PharmacyPatientSearch_IPD_Requests_ForCheck
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

        GridViewSearch.DataSource = search_DataSet_Pharmacy()
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
            Dim patientname As String = String.Empty
            'If Not Page.IsPostBack Then
            If GridViewSearch.Rows.Count <> 0 Then
                GridViewSearch.HeaderRow.Cells(7).Text = "Visit No."
                GridViewSearch.HeaderRow.Cells(9).Text = "Patient Name"
                GridViewSearch.HeaderRow.Cells(23).Text = "Bed No."
                GridViewSearch.HeaderRow.Cells(23).Text = "Patient Type"

                ' GridViewSearch.HeaderRow.Cells(8).Visible = False
                GridViewSearch.HeaderRow.Cells(10).Visible = False
                GridViewSearch.HeaderRow.Cells(11).Visible = False
                GridViewSearch.HeaderRow.Cells(12).Visible = False
                GridViewSearch.HeaderRow.Cells(18).Visible = False
                GridViewSearch.HeaderRow.Cells(19).Visible = False
                GridViewSearch.HeaderRow.Cells(20).Visible = False
                GridViewSearch.HeaderRow.Cells(21).Visible = False
                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    If Page.IsPostBack = True Then
                        Dim prefix As String = ""
                    Else
                        prefix = GridViewSearch.Rows(i).Cells(9).Text
                        GridViewSearch.Rows(i).Cells(9).Text = GridViewSearch.Rows(i).Cells(9).Text 'prefix & " " &
                    End If
                    '     GridViewSearch.Rows(i).Cells(23).Enabled = False
                    If GridViewSearch.Rows(i).Cells(22).Text = "paid" Then
                        GridViewSearch.Rows(i).Cells(6).Enabled = False

                        GridViewSearch.Rows(i).Cells(4).Enabled = False
                        GridViewSearch.Rows(i).Cells(4).ToolTip = "Final Payment Paid"
                        GridViewSearch.Rows(i).Cells(4).ForeColor = Drawing.Color.Gray

                        If GridViewSearch.Rows(i).Cells(23).Text <> "Insurance" Then
                            GridViewSearch.Rows(i).Cells(6).Enabled = False
                            GridViewSearch.Rows(i).Cells(6).ForeColor = Drawing.Color.Gray
                            GridViewSearch.Rows(i).Cells(6).ToolTip = "Final Paid"
                        End If


                    Else

                        If GridViewSearch.Rows(i).Cells(23).Text <> "Insurance" Then
                            GridViewSearch.Rows(i).Cells(6).Enabled = True
                            GridViewSearch.Rows(i).Cells(6).ForeColor = Drawing.Color.Gray
                            GridViewSearch.Rows(i).Cells(6).ToolTip = "Not an Entitled Patient"
                        End If

                    End If
                    'GridViewSearch.Rows(i).Cells(22).Visible = False

                    GridViewSearch.Rows(i).Cells(9).Text = GridViewSearch.Rows(i).Cells(9).Text & " " & GridViewSearch.Rows(i).Cells(10).Text & " " & GridViewSearch.Rows(i).Cells(11).Text & " " & GridViewSearch.Rows(i).Cells(12).Text

                    GridViewSearch.Rows(i).Cells(10).Visible = False
                    GridViewSearch.Rows(i).Cells(11).Visible = False
                    GridViewSearch.Rows(i).Cells(12).Visible = False
                    GridViewSearch.Rows(i).Cells(18).Visible = False
                    GridViewSearch.Rows(i).Cells(19).Visible = False
                    GridViewSearch.Rows(i).Cells(20).Visible = False
                    GridViewSearch.Rows(i).Cells(21).Visible = False
                    'GridViewSearch.Rows(i).Cells(22).Visible = False
                Next
            End If
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
        If e.CommandName = "View" Then
            'Dim gvRow As GridViewRow = CType((CType(e.CommandSource, Control)).NamingContainer, GridViewRow)
            'Dim rowind As Int32 = gvRow.RowIndex
            'Dim val As String = (CType(GridViewSearch.Rows(rowind).FindControl("hdfPatientType"), HiddenField)).Value.ToString()

            ''Dim row As GridViewRow = CType(((CType(e.CommandSource, Control)).NamingContainer), GridViewRow)
            ''Dim hdfType As HiddenField = row.FindControl("hdfPatientType")
            'Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx?RegNo=" + GridViewSearch.Rows(e.CommandArgument).Cells(8).Text + "&yearlyno=" + GridViewSearch.Rows(e.CommandArgument).Cells(7).Text + "&patienttypeid=" + val + "")
            'Dim sb As New StringBuilder
            'sb.Append("<script language='javascript' type='text/javascript'>window.open('../Pharmacy/Medicine_issue_item_wise.aspx','_blank');</Script>")
            'Dim t As Type = Me.GetType()
            'If Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp") Then
            '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
            'End If
            'Response.Write("<script language='javascript' type='text/javascript'>window.open('pt_DischargeBill.aspx','_blank');</Script>")
            'Response.Redirect("View_PatientDetail.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(5).Text, True))
        ElseIf e.CommandName = "Editrecord" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Response.Redirect("Update_Patient.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
        ElseIf e.CommandName = "patienttrack" Then
            Response.Redirect("PatientHistory.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
        ElseIf e.CommandName = "Services" Then
            Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(7).Text))
            'Response.Write(Session("Dept_Service") & "dfsdfsfd")
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            'Response.Write(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            'Response.End()
            If Session("Dept_id") = 51 Then
                Response.Redirect("Services_Page.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            Else
                Response.Redirect("Services_Page.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            End If
            'ElseIf e.CommandName = "Package" Then
            '    Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
            '    'Response.Write(Session("Dept_Service") & "dfsdfsfd")
            '    Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
            '    Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
            '    Response.Redirect("Patient_Package_Service.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
        ElseIf e.CommandName = "IPDSLIP" Then
            ' Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
            'Response.Write(Session("Dept_Service") & "dfsdfsfd")
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True))
            'Session.Add("Administrator", "False")
            Session.Add("PayId", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            'Response.Redirect("~/Patient Registration/PatientVisit.aspx")
            Response.Redirect("~/Patient Registration/IPD_Regisration_Report_New.aspx")
        ElseIf e.CommandName = "PT_Change_Room" Then

            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            Session.Add("Patient_Type", GridViewSearch.Rows(e.CommandArgument).Cells(23).Text)
            Response.Redirect("~/PAtient Billing/ChangeRoom.aspx?PT=" + GridViewSearch.Rows(e.CommandArgument).Cells(23).Text)


        ElseIf e.CommandName = "Cencel" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            Response.Redirect("CencelRegistration.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
        ElseIf e.CommandName = "AddLetter" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            Response.Redirect("~/Patient Billing/Party_Letter.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(8).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)


            'Session.Add("registrationNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
            'Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            'Response.Redirect("~/Patient Billing/Party_Letter.aspx?regno=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)

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
            Response.Write(ex.Message)
        End Try

    End Function

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim lbn As LinkButton = sender
        'Response.Redirect("~/Patient Registration/OPD_Slip_Report_Private.aspx?regno=" + Convert.ToString(Session("registrationNo")))
        'Dim t_Linkbutton As LinkButton
        't_Linkbutton = CType(sender, LinkButton)
        'Dim gvRow As GridViewRow = CType(t_Linkbutton.NamingContainer, GridViewRow)
        'Dim t_HiddenField As HiddenField

        't_HiddenField = CType(gvRow.FindControl("hfld_RegNo"), HiddenField)
        'Session("RegistrationNo") = t_HiddenField.Value
        't_HiddenField = CType(gvRow.FindControl("hfld_YearlyNo"), HiddenField)
        'Session("PayId") = t_HiddenField.Value
        'Response.Redirect("~/Patient Registration/OPD_Slip_Report_Private.aspx")
    End Sub
    Protected Sub lnkMedicine_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        Dim row As GridViewRow = lnk.NamingContainer

        Dim patientTypeID As HiddenField = row.FindControl("hfdpatienttype")
        'Session.Add("registrationNo", reg.Text)
        'Session.Add("Yearlyno", yearlyNo.Text)
        'Session.Add("Patient_Type_Id", patientTypeID.Value)

        Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx?RegNo=" + row.Cells(8).Text + "&yearlyno=" + row.Cells(7).Text + "&patienttypeid=" + patientTypeID.Value + "")
    End Sub
    Function search_DataSet_Pharmacy() As DataTable
        Dim YearlyNo As Int64 = 0
        Dim TextBoxPFName As String = ""
        Dim TextBoxRegNo As String = ""
        Dim TextBoxPMName As String = ""
        Dim TextBoxAge As Integer = 0
        Dim TextBoxPLName As String = ""
        Dim TextBoxRFName As String = ""
        Dim TextBoxRMName As String = ""
        Dim TextBoxRLName As String = ""
        Dim TextBoxCNIC As String = ""
        Dim TextBoxPhone As String = ""
        Dim DropDownListAgeType As String = ""
        Dim WebDate As String = ""
        Dim dte As Integer = 0
        Dim mon As Integer = 0
        Dim year As Integer = 0
        Dim consul As String = ""
        For i As Integer = 0 To Panel2.Controls.Count - 1
            If Panel2.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txtbox As TextBox = Panel2.FindControl(Panel2.Controls(i).ID.ToString)
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

                If txtbox.ID = "TextBoxAge" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxAge = 0
                    Else
                        TextBoxAge = txtbox.Text.Trim
                    End If
                End If

                If txtbox.ID = "TextBoxRFName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxRFName = "%"
                    Else
                        TextBoxRFName = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxRMName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxRMName = "%"
                    Else
                        TextBoxRMName = txtbox.Text.Trim
                    End If
                End If
                If txtbox.ID = "TextBoxRLName" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxRLName = "%"
                    Else
                        TextBoxRLName = txtbox.Text.Trim
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
            If Panel2.Controls(i).GetType().ToString.Contains("WebDateChooser") Then
                Dim WebDateChooser As Infragistics.WebUI.WebSchedule.WebDateChooser = Panel2.FindControl(Panel2.Controls(i).ID.ToString)
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
            If Panel2.Controls(i).GetType().ToString.Contains("DropDownList") Then
                'Dim dropconsultant As DropDownList = Panel2.FindControl(Panel2.Controls(i).ID.ToString)
                Dim dropdownlist As DropDownList = Panel2.FindControl(Panel2.Controls(i).ID.ToString)

                If dropdownlist.ID = "dropconsultant" Then

                    If dropdownlist.SelectedValue <> "" Then
                        consul = CStr(dropdownlist.SelectedValue)
                    End If
                End If
                'DropDownListAgeType

                If dropdownlist.ID = "DropDownListAgeType" Then
                    DropDownListAgeType = dropdownlist.SelectedValue
                End If
            End If
        Next


        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@YearlyNo", YearlyNo),
        New SqlParameter("@PFName", TextBoxPFName),
        New SqlParameter("@PMName", TextBoxPMName),
        New SqlParameter("@PLName", TextBoxPLName),
        New SqlParameter("@RegNo", TextBoxRegNo),
        New SqlParameter("@RFName", TextBoxRFName),
        New SqlParameter("@RMName", TextBoxRMName),
        New SqlParameter("@RLName", TextBoxRLName),
        New SqlParameter("@Age", TextBoxAge),
        New SqlParameter("@AgeType", DropDownListAgeType),
        New SqlParameter("@day", dte),
        New SqlParameter("@month", mon),
        New SqlParameter("@year", year),
        New SqlParameter("@SubDeptNo", HttpContext.Current.Session("SubDeptID")),
        New SqlParameter("@Emp_ID", HttpContext.Current.Session("Emp_ID")),
        New SqlParameter("@request_type_id", 1),
        New SqlParameter("@Status", 0),
        New SqlParameter("@CNIC", TextBoxCNIC),
        New SqlParameter("@Mobile_phone", TextBoxPhone),
        New SqlParameter("@HospitalID", HttpContext.Current.Session("HospitalID"))
         }

        Dim search_DSPharmacy As DataTable = New DataTable()
        Dim objManager As DbManager = New DbManager()

        search_DSPharmacy = objManager.ExecuteDataTable("Search_Patient_For_Pharmacy_IPD", "Reg_ConnectionString", sqlParams)
        Return search_DSPharmacy
    End Function
End Class
