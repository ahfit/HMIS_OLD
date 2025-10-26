Imports System.Data
Imports System.Data.SqlClient

Partial Class RecordManagement_IssuePatientRecord
    Inherits System.Web.UI.Page


    Dim ENC As New Encryption
    Dim pgindex As Integer = 0
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
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_Record_Management_Patients", constring)
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
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_Record_Management_Patients", constring)
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
            If Not Page.IsPostBack Then
                ddlSubDept.DataBind()


            End If
            
            Dim Table_Element_Name() As String = {"Visit #.", "First Name", "MR # :", "Middle Name", "Age", "Relation", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration Date", "Shift", "CNIC", "Passport No", "Mobile No", "File #"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "Radiobuttonlist", "webmaskedit", "TextBox", "webmaskedit", "TextBox"}
            Dim Table_Element_ID() As String = {"TextBoxYearlyNo", "TextBoxPFName", "TextBoxRegNo", "TextBoxPMName", "TextBoxAge", "TextBoxRelation", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxFLName", "WebDateChooser1", "RadioButtonListShift", "CNIC", "Passport_No", "Mobile_No", "TextBoxFileNo"}

            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New_Advance_search(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))

            If Page.IsPostBack = False Then
                ddlSubDept.DataBind()
                LoadEmployees()
                ddlIssuedBy.DataBind()
                ddlIssuedBy.SelectedValue = Session("Emp_Id").ToString()
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
                GridViewSearch.HeaderRow.Cells(6).Text = "Patient Name"
                GridViewSearch.HeaderRow.Cells(5).Visible = False
                GridViewSearch.HeaderRow.Cells(6).Visible = True
                GridViewSearch.HeaderRow.Cells(13).Visible = False
                GridViewSearch.HeaderRow.Cells(1).Visible = False
             
                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    GridViewSearch.Rows(i).Cells(5).Visible = False
                    GridViewSearch.Rows(i).Cells(6).Visible = True
                    GridViewSearch.Rows(i).Cells(13).Visible = False
                    GridViewSearch.Rows(i).Cells(1).Visible = False
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

    Protected Sub btnRecieveRecord_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecieveRecord.Click

        Try
            sqlDs_PatientRecordIssue.InsertParameters("Patient_Record_File_Issue_Id").DefaultValue = "0"
            sqlDs_PatientRecordIssue.InsertParameters("Patient_Record_File_Id").DefaultValue = hfldFileId.Value
            sqlDs_PatientRecordIssue.InsertParameters("Request_By_SubDept_Id").DefaultValue = ddlSubDept.SelectedValue
            sqlDs_PatientRecordIssue.InsertParameters("Request_By_Consultant_Id").DefaultValue = ddlConsultant.SelectedValue
            sqlDs_PatientRecordIssue.InsertParameters("Issued_To_Emp_Id").DefaultValue = ddlIssuedTo.SelectedValue
            sqlDs_PatientRecordIssue.InsertParameters("Issued_By_Emp_Id").DefaultValue = ddlIssuedBy.SelectedValue
            sqlDs_PatientRecordIssue.InsertParameters("Remarks").DefaultValue = txtRemarks.Text
            sqlDs_PatientRecordIssue.InsertParameters("Issue_Date").DefaultValue = DateTime.Now.ToString("yyyy MMMM dd hh:mm")
            sqlDs_PatientRecordIssue.InsertParameters("Issued_Status").DefaultValue = "1"
            sqlDs_PatientRecordIssue.Insert()
            GridViewSearch.DataBind()
            btnPrint.Visible = True
        Catch ex As Exception
            Console.Write(ex.Message)
        End Try

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
        Dim fileId As Long = Long.Parse(btnTemp.CommandArgument)
        hfldFileId.Value = fileId
        pnlIssueFile.Visible = True


    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        pnlIssueFile.Visible = False
    End Sub

    Protected Sub btnRecordActivity_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnTemp As Button = CType(sender, Button)
        Dim fileId As Long = Long.Parse(btnTemp.CommandArgument)
        Response.Redirect("Patient_Record_File_Activity.aspx?File_Id=" + fileId.ToString())

    End Sub
    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnTemp As Button = CType(sender, Button)
        Dim fileId As Long = Long.Parse(btnTemp.CommandArgument)
        Response.Redirect("Patient_File_Activity_Report.aspx?File_Id=" + fileId.ToString())

    End Sub
    Protected Sub btnPrint_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPrint.Click
        Response.Redirect("~/RecordManagement/Issue_Patient_Record_Report.aspx?File_ID=" + hfldFileId.Value.ToString())
        pnlIssueFile.Visible = False
    End Sub

    Protected Sub ddlSubDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSubDept.SelectedIndexChanged
        ddlConsultant.DataBind()
    End Sub
End Class
