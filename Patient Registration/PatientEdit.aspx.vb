Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Registration_PatientEdit
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

        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString

        GridViewSearch.DataSource = search1()
        GridViewSearch.AutoGenerateColumns = True
        GridViewSearch.AllowPaging = True
        GridViewSearch.PageIndex = indx
        GridViewSearch.DataBind()


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            '''''''''''''''''''''''' search'''''''''''''''

            Dim Table_Element_Name() As String = {"MR #.", "CNIC #", "Passport #", "Mobile #", "Registration Date", "Name"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "TextBox"}
            Dim Table_Element_ID() As String = {"TextBoxRegNo", "CNIC", "Passport_No", "Mobile_No", "WebDateChooser1", "TextBoxPFName"}



            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            '  form1.DefaultButton = "Button1"
            If Page.IsPostBack = False Then
                'search1(0)
                'HiddenField_Flag.Value = "True"
                'Label1.Text = ""
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Function search1() As DataTable

        Dim TextBoxPFName As String = ""
        Dim TextBoxRegNo As String = ""
        Dim TextBoxPMName As String = ""
        Dim TextBoxAge As Integer = 0
        Dim TextBoxCNIC As String = ""
        Dim TextBox_passport_No As String = ""
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



                If txtbox.ID = "CNIC" Then
                    If txtbox.Text.Trim = "" Then
                        TextBoxCNIC = "%"
                    Else
                        TextBoxCNIC = txtbox.Text.Trim
                    End If
                End If

                If txtbox.ID = "Mobile_No" Then
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
            'If Panel2.Controls(i).GetType().ToString.Contains("webmaskedit") Then
            '    Dim txtbox As TextBox = Panel2.FindControl(Panel2.Controls(i).ID.ToString)

            'End If
        Next

        Dim sqlParams As SqlParameter() =
        {
        New SqlParameter("@PName", TextBoxPFName),
        New SqlParameter("@RegNo", TextBoxRegNo),
        New SqlParameter("@day", dte),
        New SqlParameter("@month", mon),
        New SqlParameter("@year", year),
        New SqlParameter("@SubDeptID", HttpContext.Current.Session("SubDeptID")),
        New SqlParameter("@CNIC", TextBoxCNIC),
        New SqlParameter("@Passport_No", TextBox_passport_No),
        New SqlParameter("@Mobile_phone", TextBoxPhone),
        New SqlParameter("@HospitalID", HttpContext.Current.Session("HospitalID"))
         }

        Dim dtSearchIPDPatients As DataTable = New DataTable()
        Dim objManager As DbManager = New DbManager()

        dtSearchIPDPatients = objManager.ExecuteDataTable("Search_Patient_for_Admission", "Reg_ConnectionString", sqlParams)
        Return dtSearchIPDPatients
    End Function
    Protected Sub GridViewSearch_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridViewSearch.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            HiddenField_Flag.Value = "True"
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        HiddenField_Flag.Value = "True"
        search1(0)
        Panel_Visit_Summary.Visible = False
    End Sub

    Protected Sub GridViewSearch_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.PreRender
        Try

            If HiddenField_Flag.Value = "True" Then
                If GridViewSearch.Rows.Count <> 0 Then

                    GridViewSearch.HeaderRow.Cells(8).Text = "Patient Name"
                    GridViewSearch.HeaderRow.Cells(7).Text = "MR #."
                    GridViewSearch.HeaderRow.Cells(3).Visible = False
                    GridViewSearch.HeaderRow.Cells(5).Visible = False
                    GridViewSearch.HeaderRow.Cells(9).Visible = False
                    GridViewSearch.HeaderRow.Cells(10).Visible = False
                    GridViewSearch.HeaderRow.Cells(6).Visible = False
                    GridViewSearch.HeaderRow.Cells(11).Visible = False

                    GridViewSearch.HeaderRow.Cells(19).Visible = False
                    GridViewSearch.HeaderRow.Cells(20).Visible = False
                    GridViewSearch.HeaderRow.Cells(23).Visible = False

                    For i As Integer = 0 To GridViewSearch.Rows.Count - 1

                        GridViewSearch.Rows(i).Cells(8).Text = GridViewSearch.Rows(i).Cells(9).Text & " " & GridViewSearch.Rows(i).Cells(10).Text
                        GridViewSearch.Rows(i).Cells(3).Visible = False
                        GridViewSearch.Rows(i).Cells(5).Visible = False
                        GridViewSearch.Rows(i).Cells(6).Visible = False
                        GridViewSearch.Rows(i).Cells(9).Visible = False
                        GridViewSearch.Rows(i).Cells(10).Visible = False
                        GridViewSearch.Rows(i).Cells(11).Visible = False
                        GridViewSearch.Rows(i).Cells(19).Visible = False
                        GridViewSearch.Rows(i).Cells(20).Visible = False
                        GridViewSearch.Rows(i).Cells(23).Visible = False

                    Next
                Else

                    'Label1.Text = "NO RECORD FOUND"
                End If
                HiddenField_Flag.Value = "False"
            End If

        Catch ex As Exception

        End Try



        'For index As Integer = 0 To GridViewSearch.Rows.Count - 1

        '    Dim HiddenField_FP As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_FP")

        '    Dim Patient_Type_ID As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_Patient_Type_ID")
        '    Dim ImageButton_FP As ImageButton = GridViewSearch.Rows(index).FindControl("ImageButton_FP")
        '    Dim lnkbNewVisita As LinkButton = GridViewSearch.Rows(index).FindControl("lnkbNewVisit")
        '    ' =========================== To check whether patient is entitled or not ========================
        '    'Finger Print Image  is disabled
        '    If HiddenField_FP.Value = 1 Or Patient_Type_ID.Value = "Private" Or Patient_Type_ID.Value = "Public" Then
        '        ImageButton_FP.Visible = False

        '    End If

        '    '==========To check whether patient is entitled and has fingerprint registered ========================
        '    If Patient_Type_ID.Value <> "Private" And ImageButton_FP.Visible = True Then
        '        ''''''''''''''''''''''''lnkbNewVisita.Visible = False
        '    End If


        'Next



    End Sub

    Protected Sub GridViewSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewSearch.RowCommand

        Try
            Dim YearlyNo As HiddenField = GridViewSearch.Rows(e.CommandArgument).FindControl("HiddenField_YearlyNo")
            ' Dim Ptype As HiddenField = GridViewSearch.Rows(e.CommandArgument).FindControl("HiddenField_Patient_Type")

            Dim HiddenField_RegNo As HiddenField = GridViewSearch.Rows(e.CommandArgument).FindControl("HiddenField_RegNo")
            If e.CommandName = "View" Then
                Response.Redirect("View_PatientDetail.aspx?regno=" & ENC.Encrypt_Main(HiddenField_RegNo.Value, True))
            ElseIf e.CommandName = "Editrecord" Then

                Response.Redirect("Update_Patient.aspx?regno=" & ENC.Encrypt_Main(HiddenField_RegNo.Value, True) & "&YearlyNo=" & Session("YearlyNo"))
            ElseIf e.CommandName = "patienttrack" Then

                Response.Redirect("Update_Patient.aspx?regno=" & ENC.Encrypt_Main(HiddenField_RegNo.Value, True))
            ElseIf e.CommandName = "Admission" Then
                Session("registrationNo") = ENC.Encrypt_Main(HiddenField_RegNo.Value, True)
                '  Session("Patient_Type") = Ptype.Value
                Session("YearlyNo") = YearlyNo.Value
                Session("PatientName") = GridViewSearch.Rows(e.CommandArgument).Cells(8).Text
                Response.Redirect("~/Patient Billing/Patient_Assign_Bed.aspx?regno=" & ENC.Encrypt_Main(HiddenField_RegNo.Value, True) & "&YearlyNo=" & YearlyNo.Value)
            ElseIf e.CommandName = "NoOFVisit" Then

            ElseIf e.CommandName = "Appointment" Then


            End If
        Catch ex As Exception

        End Try


    End Sub


    Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click
        Response.Redirect("PatientSearch_Print.aspx")
    End Sub

    Protected Sub Button_Advance_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Advance_Search.Click
        Response.Redirect("Advance_Search.aspx")
    End Sub

    Protected Sub GridViewSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.SelectedIndexChanged

    End Sub

    Protected Sub ImageButton_Close_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Close.Click
        Panel_Visit_Summary.Visible = False
    End Sub

    Protected Sub ImageButton_FP_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim Mycell As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)

        Dim index As Integer = Mycell.RowIndex
        Dim HiddenField_Reg_No As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_RegNo")
        ThumbFunctionality.FPF(Convert.ToInt32(Session("Emp_Id")), 4, Convert.ToString(ENC.Encrypt_Main(HiddenField_Reg_No.Value, True)))
        Response.Redirect("FPView_Detail.aspx?RegNo=" & Convert.ToString(ENC.Encrypt_Main(HiddenField_Reg_No.Value, True)))
        ' Label1.Text = "<script language ='Javascript'>alert('" & msg & "');</script>"
        Label1.Text = "ConfirmOnDelete()"
        'ThumbFunctionality.FPF(Convert.ToInt32(Session("Emp_Id")), 1, "")
        'Response.Redirect("PatientSearch.aspx")


    End Sub

    Protected Sub lnkbNewVisit_Click(ByVal sender As Object, ByVal e As System.EventArgs)



        Dim ro As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)

        Dim index As Integer = ro.RowIndex
        Dim HiddenField_Patient_Type_ID As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_Patient_Type_ID")

        Dim RegNo As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_RegNo")
        Dim OPDSubdept As HiddenField = GridViewSearch.Rows(index).FindControl("HF_Subdept")
        If HiddenField_Patient_Type_ID.Value = "Private" Or HiddenField_Patient_Type_ID.Value = "Public" Then
            Session.Add("registrationNo", ENC.Encrypt_Main(RegNo.Value, True))

            'Session("YearlyNo") = GridViewSearch.Rows(index).Cells(6).Text
            'Session("PatientName") = GridViewSearch.Rows(index).Cells(8).Text

        Else
            Session.Remove("registrationNo")
            'Session.Remove("YearlyNo")
            'Session.Add("registrationNo", "")
            'Session.Add("YearlyNo", "")

        End If
        Session.Add("OPDSubdeptId", OPDSubdept)
        Session.Add("registrationNo", ENC.Encrypt_Main(RegNo.Value, True))
        Session.Add("Administrator", "False")

        Dim partid As String = 0
        Dim hdPartyid As HiddenField = DirectCast(GridViewSearch.Rows(index).FindControl("HiddenFieldPartyid"), HiddenField)
        Session.Add("PartyID", hdPartyid.Value)

        Response.Redirect("PatientVisit.aspx")



    End Sub

    Protected Sub lnkbNewAdmission_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ro As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim index As Integer = ro.RowIndex
        Dim RegNo As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_RegNo")
        Dim HFDeptID As HiddenField = GridViewSearch.Rows(index).FindControl("HF_Subdept")

        Dim count As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim Command As SqlCommand = New SqlCommand("GetLastIPDVisit", con)
        Command.CommandType = CommandType.StoredProcedure
        Command.Parameters.AddWithValue("@RegNo", RegNo.Value)
        con.Open()
        Dim dt As DataTable = New DataTable()
        Dim adp As SqlDataAdapter = New SqlDataAdapter(Command)
        adp.Fill(dt)
        If dt.Rows.Count > 0 Then

            'ScriptManager.RegisterClientScriptBlock(Page, GetType(Page), "clientscript", "alert('Patient already admitted. Please discharge and then create new Admission')</script>", True)
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript'>")
            sb.Append("alert('Patient already admitted.')</script>")
            Dim t As Type = Me.GetType
            If (Not Page.ClientScript.IsClientScriptBlockRegistered(t, "Popup")) Then
                ClientScript.RegisterStartupScript(t, "Popup", sb.ToString())
            End If

        Else

            Session.Add("registrationNo", ENC.Encrypt_Main(RegNo.Value, True))
            Dim HiddenField_YearlyNo As HiddenField = CType(GridViewSearch.Rows(index).FindControl("HiddenField_YearlyNo"), HiddenField)

            Dim hdPartyid As HiddenField = DirectCast(GridViewSearch.Rows(index).FindControl("HiddenFieldPartyid"), HiddenField)
            Session.Add("PartyID", hdPartyid.Value)

            Session.Add("YearlyNo", HiddenField_YearlyNo.Value)
            Session("PatientName") = GridViewSearch.Rows(index).Cells(6).Text
            Response.Redirect("PatientVisit.aspx?Recomended_Id=999&SubDeptID=" + HFDeptID.Value + "")


        End If



    End Sub


    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim ro As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)

        Dim index As Integer = ro.RowIndex
        Dim RegNo As HiddenField = GridViewSearch.Rows(index).FindControl("HiddenField_RegNo")
        Session("registrationNo") = ENC.Encrypt_Main(RegNo.Value, True)
        DataList_Visit_Summary.DataBind()
        Panel_Visit_Summary.Visible = True
        DataList_Visit_Summary.Visible = True
    End Sub
    Protected Sub GridViewSearch_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridViewSearch.RowDataBound


        'If Session("status") <> Nothing Then
        '    If Session("status").ToString() = "True" Then
        '        GridViewSearch.Columns(1).Visible = True
        '    Else
        '        GridViewSearch.Columns(1).Visible = False
        '    End If

        'Else
        '    GridViewSearch.Columns(1).Visible = False

        'End If



    End Sub
End Class
