Imports System.Data

Partial Class RecordManagement_ViewPatientRecodIssueHistory
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
                Response.Redirect("~/login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub search1(ByVal indx As Integer)
        If indx = 0 Then
            Try
                Dim constring As String = ConfigurationManager.ConnectionStrings("Record_ManagementConnectionString").ConnectionString
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_All_Record_Management_Patients", constring)
                GridViewSearch.DataSource = dtaset.Tables(0)
                GridViewSearch.AutoGenerateColumns = True
                GridViewSearch.AllowPaging = True
                GridViewSearch.PageSize = 25
                GridViewSearch.PageIndex = indx
                GridViewSearch.DataBind()
                Session.Add("Query", searchpanel1.qstring)
            Catch ex As Exception
                Response.Write(ex.Message + ": Search1")
            End Try
        Else
            Try

                Dim constring As String = ConfigurationManager.ConnectionStrings("Record_ManagementConnectionString").ConnectionString
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_All_Record_Management_Patients", constring)
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
            Dim Table_Element_Name() As String = {"Visit #.", "First Name", "MR # :", "Middle Name", "Age", "Relation", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration Date", "Shift", "CNIC", "Passport No", "Mobile No", "File #"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "Radiobuttonlist", "webmaskedit", "TextBox", "webmaskedit", "TextBox"}
            Dim Table_Element_ID() As String = {"TextBoxYearlyNo", "TextBoxPFName", "TextBoxRegNo", "TextBoxPMName", "TextBoxAge", "TextBoxRelation", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxFLName", "WebDateChooser1", "RadioButtonListShift", "CNIC", "Passport_No", "Mobile_No", "TextBoxFileNo"}

            'Dim Table_Element_Name() As String = {"Registration No.", "Registration Date", "CNIC", "Passport No", "Mobile No"}
            'Dim Table_Element_Type() As String = {"TextBox", "WebDateChooser", "webmaskedit", "TextBox", "webmaskedit"}
            'Dim Table_Element_ID() As String = {"TextBoxRegNo", "WebDateChooser1", "CNIC", "Passport_No", "Mobile_No"}



            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New_Advance_search(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            ' form1.DefaultButton = "Button1"
            If Page.IsPostBack = False Then
                LoadEmployees()
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
                GridViewSearch.HeaderRow.Cells(4).Text = "MR No."
                GridViewSearch.HeaderRow.Cells(5).Visible = False
                GridViewSearch.HeaderRow.Cells(6).Visible = False
                GridViewSearch.HeaderRow.Cells(13).Visible = False
                GridViewSearch.HeaderRow.Cells(1).Visible = False
                'GridViewSearch.HeaderRow.Cells(8).Visible = False
                'GridViewSearch.HeaderRow.Cells(9).Visible = False
                'GridViewSearch.HeaderRow.Cells(10).Visible = False
                'GridViewSearch.HeaderRow.Cells(17).Visible = False
                'GridViewSearch.HeaderRow.Cells(10).Visible = False
                'GridViewSearch.HeaderRow.Cells(11).Visible = False
                'GridViewSearch.HeaderRow.Cells(17).Visible = False
                'GridViewSearch.HeaderRow.Cells(18).Visible = False
                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    GridViewSearch.Rows(i).Cells(5).Visible = False
                    GridViewSearch.Rows(i).Cells(6).Visible = False
                    GridViewSearch.Rows(i).Cells(13).Visible = False
                    GridViewSearch.Rows(i).Cells(1).Visible = False
                    'GridViewSearch.Rows(i).Cells(9).Visible = False
                    ' GridViewSearch.Rows(i).Cells(10).Visible = False
                    'GridViewSearch.Rows(i).Cells(17).Visible = False
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

        'If e.CommandName = "patienttrack" Then
        '    Session("RegistrationNo") = GridViewSearch.Rows(e.CommandArgument).Cells(13).Text
        '    Session("YearlyNo") = GridViewSearch.Rows(e.CommandArgument).Cells(1).Text
        '    Response.Redirect("ViewPatientDocuments.aspx")

        'End If

    End Sub


    'Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click
    '    Response.Redirect("PatientSearch_Print.aspx")
    'End Sub

    Protected Sub GridViewSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.SelectedIndexChanged

    End Sub

    Protected Sub chkSelect_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chkTmp As CheckBox = CType(sender, CheckBox)
        Dim chkT As CheckBox = Nothing

        For Each row As GridViewRow In GridViewSearch.Rows
            chkT = CType(row.FindControl("chkSelect"), CheckBox)
            If chkT IsNot Nothing Then
                chkT.Checked = chkTmp.Checked
            End If
        Next

    End Sub

    Private Sub LoadEmployees()
        'ddlEmployee.DataBind()
        'ddlEmployee.Items.Insert(0, New ListItem(" --- Select --- ", "0"))
    End Sub

    Protected Sub btnIssueFile_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnTemp As Button = CType(sender, Button)
        sqlDs_FileIssueHistory.SelectParameters("Patient_Record_File_Id").DefaultValue = btnTemp.CommandArgument

        GridView1.DataBind()
    End Sub

End Class
