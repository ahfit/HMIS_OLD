Imports System.Collections.Generic
Imports System.Linq
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Data
Imports System.IO
Imports Ionic.Zip


Partial Class RecordManagement_View_Document_Detail
    Inherits System.Web.UI.Page
    Dim FileUpload1 As New FileUpload()

    Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
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

                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_Patients_For_Record_Management", constring)
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

                Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
                Dim dtaset As DataSet = searchpanel1.search1_advance_Search(Panel2, "Search_Patients_For_Record_Management", constring)
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

            Dim Table_Element_Name() As String = {"Visit #.", "First Name", "MR # :", "Middle Name", "Age", "Relation", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration Date", "Shift", "CNIC", "Passport No", "Mobile No"}
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
                LoadEmployees()
                ddlEmployee.SelectedValue = Session("Emp_ID").ToString()
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

            Dim constring As String = ConfigurationManager.ConnectionStrings("Record_ManagementConnectionString").ConnectionString

            'Code Added for Download button visibility check

            For Each rows As GridViewRow In GridViewSearch.Rows




                Try
                    Dim hf As HiddenField = DirectCast(rows.FindControl("hfvisits_ID"), HiddenField)
                    getVisit_ID.Value = hf.Value
                    Dim newid As Integer = getVisit_ID.Value
                    Using con As New SqlConnection(constring)
                        Using cmd As New SqlCommand()
                            cmd.CommandText = "select FileName,FilePath from Patient_Record_File where YearlyNo=@Id"
                            cmd.Parameters.AddWithValue("@Id", newid)
                            cmd.Connection = con
                            con.Open()


                            Using sdr As SqlDataReader = cmd.ExecuteReader()
                                sdr.Read()
                                If sdr.HasRows Then
                                    rows.FindControl("btnDocument").Visible = True
                                Else
                                    rows.FindControl("btnDocument").Visible = False
                                End If
                            End Using


                            con.Close()



                        End Using
                    End Using

                Catch ex As Exception

                End Try


            Next


            'Code End






            Dim Patient_Name As String = String.Empty

            If GridViewSearch.Rows.Count <> 0 Then
                GridViewSearch.HeaderRow.Cells(4).Text = "Patient Name"
                GridViewSearch.HeaderRow.Cells(5).Visible = False
                GridViewSearch.HeaderRow.Cells(6).Visible = False
                GridViewSearch.HeaderRow.Cells(7).Visible = False
                GridViewSearch.HeaderRow.Cells(13).Visible = False
                'GridViewSearch.HeaderRow.Cells(8).Visible = False
                'GridViewSearch.HeaderRow.Cells(9).Visible = False
                'GridViewSearch.HeaderRow.Cells(10).Visible = False
                'GridViewSearch.HeaderRow.Cells(17).Visible = False
                'GridViewSearch.HeaderRow.Cells(10).Visible = False
                'GridViewSearch.HeaderRow.Cells(11).Visible = False
                'GridViewSearch.HeaderRow.Cells(17).Visible = False
                'GridViewSearch.HeaderRow.Cells(18).Visible = False
                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    Patient_Name = GridViewSearch.Rows(i).Cells(5).Text + GridViewSearch.Rows(i).Cells(6).Text + GridViewSearch.Rows(i).Cells(7).Text
                    GridViewSearch.Rows(i).Cells(5).Visible = False
                    GridViewSearch.Rows(i).Cells(6).Visible = False
                    GridViewSearch.Rows(i).Cells(7).Visible = False
                    GridViewSearch.Rows(i).Cells(13).Visible = False
                    GridViewSearch.Rows(i).Cells(4).Text = Patient_Name
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

    Protected Sub btnAssignFileNo_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAssignFileNo.Click
        pnlReceivingDetail.Visible = True
    End Sub

    Protected Sub btnRecieveRecord_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRecieveRecord.Click
        Dim chkT As CheckBox = Nothing
        Dim IDs As String = String.Empty
        For Each row As GridViewRow In GridViewSearch.Rows
            chkT = CType(row.FindControl("chkSelect"), CheckBox)
            If chkT.Checked = True And ddlEmployee.SelectedIndex <> "0" Then
                'IDs += "," + row.Cells(1).Text
                sqlDs_PatientRecord.InsertParameters("Patient_File_ID").DefaultValue = "0"
                sqlDs_PatientRecord.InsertParameters("YearlyNo").DefaultValue = row.Cells(1).Text
                sqlDs_PatientRecord.InsertParameters("FileNo").DefaultValue = "A0001"
                sqlDs_PatientRecord.InsertParameters("EmpId").DefaultValue = Session("Emp_ID")
                sqlDs_PatientRecord.InsertParameters("FileNoAlotDate").DefaultValue = DateTime.Now.ToString("yyyy MMMM dd hh:mm")
                sqlDs_PatientRecord.Insert()
                pnlReceivingDetail.Visible = False
                search1(0)
            End If
        Next
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

    Protected Sub txtEmployee_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtEmployee.TextChanged
        LoadEmployees()
    End Sub

    Private Sub LoadEmployees()
        If txtEmployee.Text.Trim().Length = 0 Then
            SqlDs_Employee.SelectParameters("empName").DefaultValue = "%"
        Else
            SqlDs_Employee.SelectParameters("empName").DefaultValue = txtEmployee.Text
        End If
        ddlEmployee.DataBind()
        ddlEmployee.Items.Insert(0, New ListItem(" --- Select --- ", "0"))
    End Sub



    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        pnlReceivingDetail.Visible = False
        lbl_Msg.Visible = False

    End Sub

    Protected Sub UploadFile(ByVal sender As Object, ByVal e As EventArgs)
        Dim btn As Button = DirectCast(sender, Button)
        Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)
        FileUpload2 = row.FindControl("FileUpload1")


        Dim constring As String = ConfigurationManager.ConnectionStrings("Record_ManagementConnectionString").ConnectionString


        If FileUpload2.PostedFile IsNot Nothing Then
            For Each postedfile As HttpPostedFile In FileUpload2.PostedFiles
                Dim filename As String = Path.GetFileName(postedfile.FileName)
                If filename <> String.Empty Then
                    If (postedfile.ContentLength > 5242880) Then


                        Response.Write("<script language='javascript' type='text/javascript'> alert('File: " + postedfile.FileName + ". Exceeds Size Limit.Max size allowed 5 Mb  ')</script>")

                    Else

                        postedfile.SaveAs((Server.MapPath("~/RecordManagement//File/" + postedfile.FileName)))
                        Dim con As New SqlConnection(constring)
                        Dim strQuery As String = "INSERT INTO Patient_Record_File (YearlyNo,FileName,FilePath) VALUES(@YearlyNo,@FileName,@FilePath)"
                        Dim cmd As New SqlCommand(strQuery)
                        cmd.Parameters.AddWithValue("@YearlyNo", btn.ToolTip)
                        cmd.Parameters.AddWithValue("@FileName", postedfile.FileName)
                        cmd.Parameters.AddWithValue("@FilePath", "~/RecordManagement/File/" & postedfile.FileName)
                        cmd.CommandType = CommandType.Text
                        cmd.Connection = con
                        Try
                            con.Open()
                            cmd.ExecuteNonQuery()
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        Finally
                            con.Close()
                            con.Dispose()
                        End Try


                    End If

                End If
            Next
            'Dim FileName As String = Path.GetFileName(FileUpload2.PostedFile.FileName)

            'Save files to disk
            ' FileUpload2.SaveAs(Server.MapPath("~/RecordManagement//File/" & FileName))

            'Add Entry to DataBase
            ' Dim btn As Button = DirectCast(sender, Button)


        End If
    End Sub

    Protected Sub lnkDownload_Click(sender As Object, e As EventArgs)
        'Dim id As Integer = Integer.Parse(TryCast(sender, LinkButton).CommandArgument)
        Dim btn As LinkButton = DirectCast(sender, LinkButton)
        Dim FileName As String, FilePath As String
        Dim constring As String = ConfigurationManager.ConnectionStrings("Record_ManagementConnectionString").ConnectionString
        If btn.ToolTip Is Nothing Then

        Else
            Try
                Using con As New SqlConnection(constring)
                    Using cmd As New SqlCommand()
                        cmd.CommandText = "select FileName,FilePath from Patient_Record_File where YearlyNo=@Id"
                        cmd.Parameters.AddWithValue("@Id", btn.ToolTip)
                        cmd.Connection = con

                        Dim sdr As New SqlDataAdapter(cmd)
                        Dim dt As New DataTable
                        sdr.Fill(dt)

                        Using zip As New ZipFile()
                            zip.AlternateEncodingUsage = ZipOption.AsNecessary
                            zip.AddDirectoryByName("File")
                            For Each row As DataRow In dt.Rows

                                Dim Fpath As String = Server.MapPath(row("FilePath"))
                                zip.AddFile(Fpath, " File " + btn.ToolTip)
                            Next
                            Response.Clear()
                            Response.BufferOutput = False
                            Dim zipName As String = [String].Format("Zip_{0}.zip", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"))
                            Response.ContentType = "application/zip"
                            Response.AddHeader("content-disposition", "attachment; filename=" + zipName)
                            zip.Save(Response.OutputStream)
                            Response.End()
                        End Using



                    End Using
                        con.Close()
                    End Using




                ' Response.Charset = ""
                'Response.Cache.SetCacheability(HttpCacheability.NoCache)

                'Response.TransmitFile(Server.MapPath(FilePath))

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        End If

    End Sub





End Class
