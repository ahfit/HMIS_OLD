Imports System.Data
Imports System.Data.SqlClient
Partial Class PharmacyPatients
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
    Dim searchpanel1 As New Search_Panel_New
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
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim dtaset As DataSet = searchpanel1.search_Pharmacy(Panel2, "Search_Patient_Pharmacy_Dashboard", constring)

            GridViewSearch.DataSource = dtaset.Tables(0)
            Label1.Text = Convert.ToString(dtaset.Tables(0).Rows.Count) + " Record Found"

            GridViewSearch.AllowPaging = True
            'GridViewSearch.PageSize = 10
            GridViewSearch.PageIndex = indx
            GridViewSearch.DataBind()
            Session.Add("Query", searchpanel1.qstring)
        Catch ex As Exception
            ' Response.Write(ex.Message + "dasfsdfdss")
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            '''''''''''''''''''''''' search'''''''''''''''

            Dim Table_Element_Name() As String = {"MR #.", "Visit #", "CNIC #", "Mobile #", "Registration Date", "Name"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "webmaskedit", "webmaskedit", "WebDateChooser", "TextBox"}
            Dim Table_Element_ID() As String = {"TextBoxRegNo", "Visit_No", "CNIC", "Mobile_No", "WebDateChooser1", "TextBoxPFName"}

            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            Session.Timeout = 120
            loginvalidate(Session("emp_id"), Session("dept_id"))


            If Not IsPostBack Then
                'WebDateChooser1.Value = Date.Now.ToString()
                'search1(0)
            End If
            If Page.IsPostBack = False Then
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub lnkbIssueMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)



        Dim ro As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)

        Dim index As Integer = ro.RowIndex


        Dim RegNo As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_RegNo")
        Dim VisitNo As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_YearlyNo")
        Dim HiddenField_Patient_Type_ID As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_Patient_Type_ID")


        Dim OPDSubdept As HiddenField = GridViewSearch.Rows(index).FindControl("HF_Subdept")

        Session.Add("registrationNo", RegNo.Value)
        Session.Add("Yearlyno", VisitNo.Value)
        Session.Add("Patient_Type_Id", HiddenField_Patient_Type_ID.Value)

        Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx?RegNo=" + RegNo.Value + "&YearlyNo=" + VisitNo.Value + "&PType=" + HiddenField_Patient_Type_ID.Value)


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
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Session.Add("Payid", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            Response.Redirect("~/Patient Billing/Opd_Slip_Report_Private.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)

        ElseIf e.CommandName = "Editrecord" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
            Response.Redirect("Update_Patient.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(5).Text, True))
        ElseIf e.CommandName = "patienttrack" Then
            Response.Redirect("PatientHistory.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(5).Text, True))
        ElseIf e.CommandName = "Medicine" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Session.Add("Yearlyno", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            Session.Add("Patient_Type_Id", GridViewSearch.Rows(e.CommandArgument).Cells(23).Text)

            Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx")
        ElseIf e.CommandName = "Services" Then
            Session.Add("Dept_Service", Get_DeptID(ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True), GridViewSearch.Rows(e.CommandArgument).Cells(6).Text))
            'Response.Write(Session("Dept_Service") & "dfsdfsfd")
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            'Response.Write(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            'Response.End()
            If Session("Dept_id") = 51 Then
                Response.Redirect("Services_Page.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            Else
                Response.Redirect("Services_Page.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
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
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Session.Add("Administrator", "False")

            Response.Redirect("~/Patient Registration/PatientVisit.aspx")
        ElseIf e.CommandName = "Cencel" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
            Response.Redirect("CencelRegistration.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(6).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(5).Text)
        ElseIf e.CommandName = "AddLetter" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)
            Response.Redirect("~/Patient Billing/Party_Letter.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(7).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(6).Text)


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



End Class
