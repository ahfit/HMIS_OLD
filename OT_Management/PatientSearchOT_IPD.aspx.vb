Imports System.Data
Imports System.Data.SqlClient
Imports DrawPatientSearchPanel
Partial Class OT_Management_patientsearchOT_IPD
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
        'Try
        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        'Dim dtaset As DataSet = searchpanel1.search1(Panel2, "Search_Patient_For_Receptionist", constring)
        'Response.Write(Session("SubDeptID"))
        Dim dtaset As DataSet = sp.getDataSet(Panel2, "Search_Patient_For_ReceptionistIPD", constring)
        GridViewSearch.DataSource = dtaset.Tables(0)
        ' GridViewSearch.DataSource = dtaset.Tables("Search_Patient_for_Admission_indoor")
        GridViewSearch.AutoGenerateColumns = False
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
            'searchpanel1.search_Panel(Panel2)
            sp.SearchPanelPatient(Panel2)
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
            If e.CommandName = "View" Then
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("AddPreDefinedDiscount.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
                'Dim sb As New StringBuilder
                'sb.Append("<script language='javascript' type='text/javascript'>window.open('../Patient Billing/PatientSummaryCollection.aspx','_blank');</Script>")
                'Dim t As Type = Me.GetType()
                'If Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp") Then
                '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
                'End If
                'Response.Write("<script language='javascript' type='text/javascript'>window.open('pt_DischargeBill.aspx','_blank');</Script>")
                'Response.Redirect("View_PatientDetail.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(5).Text, True))
            ElseIf e.CommandName = "Editrecord" Then

                Response.Redirect("Update_Patient.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)

            ElseIf e.CommandName = "patienttrack" Then
                Response.Redirect("PatientHistory.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
            ElseIf e.CommandName = "Services" Then
                Session.Add("Dept_Service", Get_DeptID(regNo.Text, yearlyNo.Text))
                'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                Response.Redirect("~/OT_Management/OT_Services_Page.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)

                'If Session("Patient_Type_Id") = 18 Then
                '    Response.Redirect("Services_Page_Panel.aspx?regno=" & regNo.Text & "&payid=" & yearlyNo.Text)
                'Else

                ' End If
                'ElseIf e.CommandName = "Package" Then
                '    Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
                '    'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                '    Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
                '    Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
                '    Response.Redirect("Patient_Package_Service.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
            ElseIf e.CommandName = "IPDSLIP" Then
                ' Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(5).Text))
                'Response.Write(Session("Dept_Service") & "dfsdfsfd")
                Session.Add("registrationNo", regNo.Text)
                'Session.Add("Administrator", "False")
                Session.Add("PayId", yearlyNo.Text)
                'Response.Redirect("~/Patient Registration/PatientVisit.aspx")
                Response.Redirect("~/Patient Registration/IPD_Regisration_Report_New.aspx")
            ElseIf e.CommandName = "PT_Change_Room" Then

                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Session.Add("Patient_Type", GridViewSearch.Rows(e.CommandArgument).Cells(16).Text)
                Response.Redirect("~/PAtient Billing/ChangeRoom.aspx?PT=" + GridViewSearch.Rows(e.CommandArgument).Cells(16).Text)


            ElseIf e.CommandName = "Cencel" Then
                Session.Add("registrationNo", regNo.Text)
                Session.Add("YearlyNo", yearlyNo.Text)
                Response.Redirect("../Pharmacy/OT_Medicine_issue_item_wise.aspx?regno=" & regNo.Text & "&YearlyNo=" & yearlyNo.Text)
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
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @DeptID = deptid,@Patient_Type_ID=Patient_Type_ID,@Billing_party_id=Billing_party_id from payment where regNo = @RegNo and payid = @payid", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            mycommand.Parameters.Add("@DeptID", SqlDbType.Int)
            mycommand.Parameters("@DeptID").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@Patient_Type_ID", SqlDbType.Int)
            mycommand.Parameters("@Patient_Type_ID").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@Billing_party_id", SqlDbType.Int)
            mycommand.Parameters("@Billing_party_id").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Session.Add("Dept_Service", mycommand.Parameters("@DeptID").Value)
            Session.Add("Patient_Type_ID", mycommand.Parameters("@Patient_Type_ID").Value)
            Session.Add("BillingParty_Id", mycommand.Parameters("@Billing_party_id").Value)
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
End Class
