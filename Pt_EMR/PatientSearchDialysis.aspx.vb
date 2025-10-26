Imports System.Data
Imports System.Data.SqlClient
Imports DrawPatientSearchPanel
Partial Class PatientSearchDialysis
    Inherits System.Web.UI.Page
    Dim prefix As String = ""
    Dim pgindex As Integer = 0
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'This page is use for searching a patient record, On this page CMO can also view   '
    'Patient Movement Histroy,Patient Detail ,can Edit Record of a Patient                 '
    ' by using QueryString "regno","payid"                                             '
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
    Dim userAuthen As New User_page_Authentication
    Dim searchpanel1 As New SearchPanel
    Dim sp As New DrawPanel
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
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            'Dim dtaset As DataSet = searchpanel1.search1(Panel2, "Search_Patient_For_Receptionist", constring)
            'Response.Write(Session("SubDeptID"))
            Dim dtaset As DataSet = sp.getDataSet(Panel2, "Search_Patient_For_Dialysis", constring)
            GridViewSearch.DataSource = dtaset.Tables(0)
            GridViewSearch.DataBind()
            GridViewSearch.PageIndex = indx
            ViewState("dt") = dtaset.Tables(0)
            Session.Add("PayId", Convert.ToString(dtaset.Tables(0).Rows(0)("VisitNo")))
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            'searchpanel1.search_Panel(Panel2)
            sp.SearchPanelPatient(Panel2)
            For i As Integer = 0 To Panel2.Controls.Count - 1
                If Panel2.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                    Dim txt As TextBox = Panel2.FindControl(Panel2.Controls(i).ID.ToString())
                    If txt.ID = "txtRegNo" Then
                        txt.Attributes.Add("onkeypress", "txtChangeMR()")
                        txt.MaxLength = 8
                    End If
                    If txt.ID = "txtOPDNo" Then

                    End If
                End If
            Next
            Session.Timeout = 60
            '    'Response.Write(Session("SubDeptID"))
            '    'GridViewSearch.DataBind()
            loginvalidate(Session("emp_id"), Session("dept_id"))
            'form1.DefaultButton = "Button1"
            '    If Page.IsPostBack = False Then
            '        'search1(0)
            '    End If
        Catch ex As Exception
            '   Response.Write(ex.Message & "Load")
        End Try

    End Sub

    Protected Sub GridViewSearch_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridViewSearch.PageIndexChanging
        Try
            GridViewSearch.PageIndex = e.NewPageIndex
            If Not IsNothing(Session("SortGrid")) Then
                GridViewSearch.DataSource = Session("SortGrid")
                GridViewSearch.DataBind()
            Else
                search1(GridViewSearch.PageIndex)
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        search1(0)
    End Sub

    Protected Sub GridViewSearch_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.PreRender

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
        If e.CommandName <> "Sort" Then

            Dim rowIndex As Integer = Convert.ToInt32(e.CommandArgument)
            Dim row As GridViewRow = GridViewSearch.Rows(rowIndex)
            Dim regNo As Label = row.FindControl("lblRegNo")
            Dim opdNo As Label = row.FindControl("lblOPDNo")
            Dim yearlyNo As Label = row.FindControl("lblVisitNo")
            Dim hfDialysisID As HiddenField = row.FindControl("hfDialysisID")


            'If e.CommandName = "View" Then
            '    Dim reg As String = String.Empty
            '    If regNo.Text.Length > 0 Then
            '        reg = regNo.Text
            '    Else
            '        reg = opdNo.Text
            '    End If
            '    Session.Add("registrationNo", reg)
            '    Session.Add("Payid", yearlyNo.Text)
            '    Response.Redirect("~/Patient Billing/Opd_Slip_Report_Private.aspx?regno=" & reg & "&payid=" & yearlyNo.Text)
            'ElseIf e.CommandName = "Editrecord" Then
            '    Session.Add("registrationNo", regNo.Text)
            '    Response.Redirect("Update_Patient.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
            'ElseIf e.CommandName = "patienttrack" Then
            '    Response.Redirect("PatientHistory.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
            'ElseIf e.CommandName = "Medicine" Then
            '    Dim reg As String = String.Empty
            '    If regNo.Text.Length > 0 Then
            '        reg = regNo.Text
            '    Else
            '        reg = opdNo.Text
            '    End If
            '    Session.Add("registrationNo", reg)
            '    Session.Add("Yearlyno", yearlyNo.Text)

            '    Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx")
            If e.CommandName = "Create" Then
                Session.Add("DialysisID", hfDialysisID.Value)
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("~/Pt_EMR/AddEditDialysisPatient.aspx?RegNo=" + regNo.Text)

            ElseIf e.CommandName = "StartSession" Then
                Session.Add("DialysisID", hfDialysisID.Value)
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("~/Pt_EMR/DialysisSessionStart.aspx?RegNo=" + regNo.Text)


            ElseIf e.CommandName = "Services" Then
                Dim reg As String = String.Empty
                If regNo.Text.Length > 0 Then
                    reg = regNo.Text
                Else
                    reg = opdNo.Text
                End If
                Session.Add("Dept_Service", Get_DeptID(reg, yearlyNo.Text))
                'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                Session.Add("registrationNo", reg)
                Session.Add("YearlyNo", reg)
                'Response.Write(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
                'Response.End()
                If Session("Dept_id") = 51 Then
                    Response.Redirect("Services_Page.aspx?regno=" & reg & "&payid=" & yearlyNo.Text)
                Else
                    Response.Redirect("Services_Page.aspx?regno=" & reg & "&payid=" & yearlyNo.Text)
                End If
                'ElseIf e.CommandName = "Package" Then
                '    Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
                '    'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                '    Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
                '    Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
                '    Response.Redirect("Patient_Package_Service.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
            ElseIf e.CommandName = "OPDSLIP" Then
                ' Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
                'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                Session.Add("registrationNo", regNo.Text)
                Session.Add("Administrator", "False")

                Response.Redirect("~/Patient Registration/PatientVisit.aspx")
            ElseIf e.CommandName = "Cencel" Then
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("CencelRegistration.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
            ElseIf e.CommandName = "AddLetter" Then
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("~/Patient Billing/Party_Letter.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)


                'Session.Add("registrationNo", GridViewSearch.Rows(e.CommandArgument).Cells(7).Text)
                'Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
                'Response.Redirect("~/Patient Billing/Party_Letter.aspx?regno=" & GridViewSearch.Rows(e.CommandArgument).Cells(7).Text & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)

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
    Protected Sub GridViewSearch_Sorting(sender As Object, e As GridViewSortEventArgs)
        Dim dtGridData As DataTable = TryCast(ViewState("dt"), DataTable)
        Dim dvGridDataView As DataView = dtGridData.DefaultView
        Dim strSortOrder As String = ""
        If ViewState("SortOrder") Is Nothing Then
            ViewState("SortOrder") = "asc"
        End If
        If ViewState("SortOrder").ToString() = "asc" Then
            ViewState("SortOrder") = "desc"
            strSortOrder = "desc"
        ElseIf ViewState("SortOrder").ToString() = "desc" Then
            ViewState("SortOrder") = "asc"
            strSortOrder = "asc"
        End If
        dvGridDataView.Sort = Convert.ToString(e.SortExpression + " ") & strSortOrder
        dtGridData = dvGridDataView.ToTable()

        GridViewSearch.DataSource = dtGridData
        GridViewSearch.DataBind()
        Session("SortGrid") = dtGridData
    End Sub

End Class
