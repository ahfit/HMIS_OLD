Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Registration_Advance_Search
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
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
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub search1(ByVal indx As Integer)
        If indx = 0 Then
            Try
                Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search_new(Panel2, "Search_Patient_For_Receptionist_advance_Search_new", constring)
                GridViewSearch.DataSource = dtaset.Tables(0)
                GridViewSearch.AutoGenerateColumns = True
                GridViewSearch.AllowPaging = True
                GridViewSearch.PageSize = 25
                GridViewSearch.PageIndex = indx
                GridViewSearch.DataBind()
                Session.Add("Query", searchpanel1.qstring)
            Catch ex As Exception
                Response.Write(ex.Message + "dasfsdfdss")
            End Try
        Else
            Try

                Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
                Dim dtaset As DataSet = searchpanel1.search1(Panel2, "Search_Patient_For_Receptionist", constring)
                GridViewSearch.DataSource = dtaset.Tables(0)
                GridViewSearch.AutoGenerateColumns = True
                GridViewSearch.AllowPaging = True
                GridViewSearch.PageSize = 25
                GridViewSearch.PageIndex = indx
                GridViewSearch.DataBind()
                Session.Add("Query", searchpanel1.qstring)
            Catch ex As Exception
                Response.Write(ex.Message + "dasfsdfdss")
            End Try
        End If

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            '''''''''''''''''''''''' serach'''''''''''''''
            Session.Add("RegistrationNo", Request.QueryString("Reg_no"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
            Dim Table_Element_Name() As String = {"Yearly No.", "First Name", "Registration No.", "Middle Name", "Age", "Relation", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration Date", "Shift", "CNIC", "Passport No", "Mobile No"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "Radiobuttonlist", "webmaskedit", "TextBox", "webmaskedit"}
            Dim Table_Element_ID() As String = {"TextBoxYearlyNo", "TextBoxPFName", "TextBoxRegNo", "TextBoxPMName", "TextBoxAge", "TextBoxRelation", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxFLName", "WebDateChooser1", "RadioButtonListShift", "CNIC", "Passport_No", "Mobile_No"}

            'Dim Table_Element_Name() As String = {"Registration No.", "Registration Date", "CNIC", "Passport No", "Mobile No"}
            'Dim Table_Element_Type() As String = {"TextBox", "WebDateChooser", "webmaskedit", "TextBox", "webmaskedit"}
            'Dim Table_Element_ID() As String = {"TextBoxRegNo", "WebDateChooser1", "CNIC", "Passport_No", "Mobile_No"}



            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New_Advance_search(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
           ' form1.DefaultButton = "Button1"
            If Page.IsPostBack = False Then
                search1(0)
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
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
            If GridViewSearch.Rows.Count <> 0 Then
                GridViewSearch.HeaderRow.Cells(4).Text = "Patient Name"
                GridViewSearch.HeaderRow.Cells(5).Visible = False
                GridViewSearch.HeaderRow.Cells(6).Visible = False
                GridViewSearch.HeaderRow.Cells(7).Visible = False
                GridViewSearch.HeaderRow.Cells(13).Visible = False
                GridViewSearch.HeaderRow.Cells(14).Visible = False
                ' GridViewSearch.HeaderRow.Cells(13).Visible = False
                'GridViewSearch.HeaderRow.Cells(10).Visible = False
                'GridViewSearch.HeaderRow.Cells(11).Visible = False
                'GridViewSearch.HeaderRow.Cells(17).Visible = False
                'GridViewSearch.HeaderRow.Cells(18).Visible = False
                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    GridViewSearch.Rows(i).Cells(4).Text = GridViewSearch.Rows(i).Cells(4).Text & " " & GridViewSearch.Rows(i).Cells(5).Text '& " " & GridViewSearch.Rows(i).Cells(9).Text
                    GridViewSearch.Rows(i).Cells(5).Visible = False
                    GridViewSearch.Rows(i).Cells(6).Visible = False
                    GridViewSearch.Rows(i).Cells(7).Visible = False
                    GridViewSearch.Rows(i).Cells(13).Visible = False
                    GridViewSearch.Rows(i).Cells(14).Visible = False
                    '    GridViewSearch.Rows(i).Cells(13).Visible = False
                    ''GridViewSearch.Rows(i).Cells(10).Visible = False
                    'GridViewSearch.Rows(i).Cells(11).Visible = False
                    'GridViewSearch.Rows(i).Cells(17).Visible = False
                    'GridViewSearch.Rows(i).Cells(18).Visible = False
                    'GridViewSearch.Rows(i).Cells(6).ToolTip = "Visit No. is " & GridViewSearch.Rows(i).Cells(4).Text & " And Registration No. is  " & GridViewSearch.Rows(i).Cells(5).Text
                Next
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridViewSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewSearch.RowCommand
        If e.CommandName = "OPD" Then
            ' Dim hid_yearlyNo As HiddenField = GridViewSearch.Rows(e.CommandArgument).Cells(1).FindControl("HiddenField_YearlyNo")
            'Dim hid_RegNO As HiddenField = GridViewSearch.Rows(e.CommandArgument).Cells(1).FindControl("HiddenField_RegNo")
            Session.Add("RegistrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(3).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(2).Text)
            Response.Redirect("Test_Booking.aspx?Reg_No=" + ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(3).Text, True) + "&YearlyNo=" + GridViewSearch.Rows(e.CommandArgument).Cells(2).Text)
        End If
    End Sub


    Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click
        Response.Redirect("PatientSearch_Print.aspx")
    End Sub

    Protected Sub GridViewSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.SelectedIndexChanged
        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "enter_patient"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = Procedurename
        'Declar User Name and password as input parameter
        mycommand.Parameters.AddWithValue("@RegNo", GridViewSearch.SelectedValue)
        
        mycommand.Parameters.Add("@YearlyNo", Data.SqlDbType.Int)
        mycommand.Parameters("@YearlyNo").Direction = Data.ParameterDirection.Output
        con.Open()
        'Execute command
        mycommand.ExecuteNonQuery()
        'Response.Write("hellow")
        'Return values
        Session.Add("YearlyNo", mycommand.Parameters("@YearlyNo").Value.ToString())
        
        Session.Timeout = 60
        
        con.Close()
        Response.Redirect("Test_Booking.aspx?Reg_No=" + GridViewSearch.SelectedValue + "&YearlyNo=" + Session("YearlyNo"))
    End Sub
End Class
