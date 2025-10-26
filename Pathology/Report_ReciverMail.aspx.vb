Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.IO

Partial Class Report_Reciver
    Inherits System.Web.UI.Page
    Dim b As String
    Dim ENC As New Encryption
    Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
    Dim test_name As String = String.Empty
    Dim crdoc As New ReportDocument
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            ' =======================================================================================
            '                       Checking If needed to upload
            ' =======================================================================================
            Dim NoOfCheck As Integer = 0
            For Each row As GridViewRow In GridView1.Rows
                Dim check As CheckBox = row.FindControl("CheckBox1")
                If check.Checked Then
                    NoOfCheck += 1
                End If

            Next
            ' =======================================================================================
            '                       main entry
            ' =======================================================================================
            If NoOfCheck > 0 Then
                Dim identity As Integer = 0
                Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Test_Delivery_Reports_main", con)
                mycommand.CommandType = Data.CommandType.StoredProcedure
                Dim param As System.Data.SqlClient.SqlParameter
                param = mycommand.Parameters.AddWithValue("@First_Name", TextBoxRFName.Text)
                param = mycommand.Parameters.AddWithValue("@Last_Name", TextBoxRMName.Text)
                param = mycommand.Parameters.AddWithValue("@R_First_Name", TextBoxRFFName.Text)
                param = mycommand.Parameters.AddWithValue("@R_Last_Name", TextBoxRFMName.Text)
                param = mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedValue)
                param = mycommand.Parameters.AddWithValue("@CNIC", TextBoxRCINIC.Text)
                param = mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                param = mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                param = mycommand.Parameters.AddWithValue("@Main_ID", Request.QueryString("main_id"))
                param = mycommand.Parameters.Add("@identity", SqlDbType.Int)
                mycommand.Parameters("@identity").Direction = ParameterDirection.Output
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()

                identity = mycommand.Parameters("@identity").Value

                mycommand.Connection.Close()
                ' =======================================================================================
                '                       sub entry
                ' =======================================================================================
                Insert_Test(identity)

            End If



            ' Dim counter As Integer = 0
            GridView1.DataBind()
            'If GridView1.Rows.Count = 0 Then
            '    Response.Redirect("Patient_Search.aspx?def=1.3")
            'End If
            'Else
            'Label_Message.Text = "PLease Select The CheckBox First"
            'End If

        Catch ex As Exception
            'Response.Write(ex.Message & "sdfs")
        End Try

    End Sub
    Sub Insert_Test(ByVal Recieve_Main_ID As Integer)
        Try
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")


                If check.Checked = True Then
                    Dim Hid_TBID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                    Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTGID")
                    Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")

                    HiddenField_TG_ID.Value = TG_ID.Value
                    HiddenField_Main_Id.Value = main_ID.Value
                    HiddenField_Report_Reciecer_id.Value = Recieve_Main_ID 'Hid_TCID.Value
                    HiddenField_TBID.Value = Hid_TBID.Value
                    SqlDataSource1.Insert()
                    Try

                        SqlDataSource1.Update()
                    Catch ex As Exception

                    End Try
                    ' Dim url As String = "Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "&Sample_no=" + Request.QueryString("Sample_no") + "&status=8"

                    'newTabs(Me, url, (i + 1).ToString())
                    'Response.Write(HiddenField_TG_ID.Value)
                    ' mycommand.Connection.Close()
                End If
            Next

            'For i As Integer = 0 To GridView1.Rows.Count - 1
            '    Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            '    If check.Checked = True Then
            '        Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTGID")
            '        HiddenField_TG_ID.Value = TG_ID.Value
            '        Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")
            '        Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
            '        HiddenField_TBID.Value = TB_ID.Value
            '        HiddenField_Main_Id.Value = main_ID.Value
            '        '  counter = counter + 1


            '        'GridView1.DataBind()
            '        'Printreport1()
            '        'Response.Redirect("Patient_Search.aspx?def=1.3")
            '        Dim TCID As Integer = 0
            '        'For i As Integer = 0 To GridView1.Rows.Count - 1
            '        '    Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            '        '    Dim Hid_TCID As HiddenField = GridView1.Rows(i).FindControl("HiddenFieldTGID")
            '        '    If check.Checked = True Then
            '        '        TCID = Hid_TCID.Value
            '        '    End If
            '        'Next
            '    End If
            '    Response.Write("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "&Sample_no=" + Request.QueryString("Sample_no") + "&status=10');</script>")


        Catch ex As Exception
            Response.Write(ex.Message & "weqweqw")
        End Try

    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If Page.IsPostBack = False Then
            'GridView1.HeaderRow.Cells(2).Text = "Test Booking ID"
            'GridView1.HeaderRow.Cells(3).Text = "Patient Name"
            GridView1.HeaderRow.Cells(4).Visible = False
            GridView1.HeaderRow.Cells(5).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(0).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(0).Text, False)
                GridView1.Rows(i).Cells(3).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(3).Text, False) + " " + ENC.Encrypt_Main(GridView1.Rows(i).Cells(4).Text, False)
                GridView1.Rows(i).Cells(4).Visible = False
                GridView1.Rows(i).Cells(5).Visible = False
                Dim ck As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                ck.Checked = False

            Next
        End If
    End Sub
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then

                If (b = "") Then
                    b = e.Row.Cells.Item(2).Text
                    'Response.Write(e.Row.Cells.Item(4).Text)
                    e.Row.Cells.Item(2).Text = b
                ElseIf b = e.Row.Cells.Item(2).Text Then
                    e.Row.Cells.Item(2).Text = ""
                    e.Row.Cells.Item(2).Text = ""
                Else
                    b = e.Row.Cells.Item(2).Text
                    e.Row.Cells.Item(2).Text = b
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub LinkButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonReport.Click
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType
        Dim url As String = String.Empty

        If GridView1.Rows.Count > 0 Then

            For i As Integer = 0 To GridView1.Rows.Count - 1

                Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                If chk.Checked = True Then
                    Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTGID")
                    HiddenField_TG_ID.Value = TG_ID.Value
                    Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")

                    Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                    HiddenField_TBID.Value = TB_ID.Value

                    HiddenField_Main_Id.Value = main_ID.Value
                    url = "Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TBID=" + TB_ID.Value + "&Sample_No=" + Request.QueryString("Sample_no") + "&Status=" + Request.QueryString("Status")
                    newTabs(Me, url, (i + 1).ToString())

                End If
            Next

        Else
            sb.Append("<script language='javascript' type='text/javascript'>alert('First Select The Test');</script>")
            If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
            End If

        End If


        'If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
        '    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        'End If

        'For i As Integer = 0 To GridView1.Rows.Count - 1
        '    Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
        '    If chk.Checked = True Then
        '        Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
        '        HiddenField_TG_ID.Value = TG_ID.Value
        '        HiddenField_Main_Id.Value = GridView1.Rows(i).Cells.Item(2).Text
        '        Dim sb As New StringBuilder
        '        Dim t As Type = Me.GetType
        '        sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "');</script>")
        '        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
        '            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        '        End If
        '    Else
        '        Dim sb As New StringBuilder
        '        Dim t As Type = Me.GetType
        '       
        '    End If
        'Next
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            If Request.QueryString("status") = "6" Then
                ButtonSave.Visible = False

            End If


            Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
            ButtonSave.Attributes.Add("onclick", "return Validation()")
            Dim RegNo As String = "RegNo"
            Dim YearlyNo As String = "YearlyNo"
            Label_Message.Text = ""
            If Request.QueryString("status") = 8 Then
                ButtonSave.Visible = True
            End If
            GridView1.DataBind()

        End If


    End Sub

    Sub Printreport1()
        Try
            Dim report As New ReportDocument()
            Dim RegNo As String = Request.QueryString("RegNo").ToString
            Dim YearlyNo As String = Request.QueryString("YearlyNo").ToString
            report.Load("D:\Pathalogy Software\PathologyFeesReport.rpt")  ' Location Of The Report. 
            report.SetDatabaseLogon("sa", "123", "Server1", "Pathology2")
            report.SetParameterValue(0, RegNo)
            report.SetParameterValue(1, YearlyNo)
            'report.SetParameterValue(2, YearlyNo)
            report.PrintToPrinter(1, True, 0, 0)
            report.Close()
            Session("PDT") = Date.Now
        Catch ex As Exception
            'Response.Write(" Crystal Report ok" & ex.Message)
        End Try
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged

    End Sub

    Protected Sub Button_update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_update.Click

        Try

            For Each row As GridViewRow In GridView1.Rows
                Dim ck As CheckBox = row.FindControl("CheckBox1")
                If ck.Checked Then
                    Dim HiddenField_TBID As HiddenField = row.FindControl("HiddenField_TBID")
                    HF_TBID.Value = HiddenField_TBID.Value
                    HiddenField_Edit_Status.Value = DropDownList_Status.SelectedValue
                    SqlDataSource_Status.Update()
                    If DropDownList_Status.SelectedValue = "1" Then
                        SqlDataSource_Booking.Insert()
                        SqlDataSource_Booking.Update()


                    End If
                End If

            Next


            GridView1.DataBind()

        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        pnl_status.Visible = True
        DropDownList_Status.SelectedValue = 1
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        pnl_status.Visible = False
    End Sub

    Protected Sub DropDownList_Status_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Status.SelectedIndexChanged

    End Sub

    Protected Sub btn_back_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_back.Click
        If GridView1.Rows.Count > 0 Then
            Dim TG_ID As HiddenField = GridView1.Rows(0).FindControl("HiddenfieldTGID")
            Response.Redirect("~/pathology/Patient_Search.aspx?def=10&TGID=" + TG_ID.Value)
        End If
    End Sub

    Public Sub newTabs(ByVal page As Page, ByVal fullUrl As String, ByVal key As String)
        Dim script As String = "window.open('" + fullUrl + "', '" + key + "', 'status=1,location=1,menubar=1,resizable=1,toolbar=1,scrollbars=1,titlebar=1');"
        page.ClientScript.RegisterClientScriptBlock(page.GetType(), key, script, True)

    End Sub
    Protected Function getPatientSMSURL(ByRef contact_no As String, ByVal Reg_no As String, ByVal Yealy_no As String, ByVal Main_ID As String) As String
        Dim URL As String = String.Empty
        'static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
        Dim constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ToString()
        Dim qry As String = "SELECT     TOP (1) Isnull(P.Prefix,'') as Prefix, Isnull(P.PFName,'') as PFName, Isnull(P.PMName,'') as PMName,, Isnull(P.PLName,'') as PLName, '92'+right(REPLACE(p.MobilePhone,'-',''),10) as MobilePhone, S.Sample_No FROM Path_Result_Delivery AS M INNER JOIN Test_Booking_Services AS S ON M.Main_ID = S.Main_ID INNER JOIN Patient AS P ON M.Reg_no = P.RegNo WHERE (P.RegNo = '" + Reg_no + "') AND (M.Yearly_No = " + Yealy_no + ") AND (S.Main_ID = " + Main_ID + ")"
        'Response.Write(qry)
        Dim con As New SqlConnection(constr)
        Dim command As New SqlCommand(qry, con)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim prefix As String = String.Empty, Fname As String = String.Empty, Mname As String = String.Empty, Con_no As String = String.Empty, Sample_No As String = String.Empty, name As String = String.Empty

        If reader.HasRows Then



            While reader.Read()

                prefix = reader("Prefix")
                Fname = reader("PFName")
                Try
                    Mname = reader("PLName")
                Catch ex As Exception

                End Try

                Con_no = reader("MobilePhone")
                Sample_No = reader("Sample_No")


            End While

            name = prefix + " " + ENC.Encrypt_Main(Fname, False)
            If Not String.IsNullOrEmpty(Mname) Then
                name = name + " " + ENC.Encrypt_Main(Mname, False)
            End If

            Try

                contact_no = Con_no.Replace("-", "")

            Catch ex As Exception
                Return URL

            End Try

        End If

        URL = "Dear " + name + "  Kindly Collect Your Reports Against Lab No. " + Sample_No + "."

        Return URL
    End Function

    Protected Sub btn_send_sms_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_send_sms.Click
        Dim C_no As String = String.Empty
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType
        Dim url = getPatientSMSURL(C_no, Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"), Request.QueryString("Main_ID"))

        sb.Append("<script language='javascript' type='text/javascript'>window.open('http://api.bizsms.pk/api-send-branded-sms.aspx?username=sharif@bizsms.pk&pass=sharif789&text=" + url + "&masking=SMDC&destinationnum=" + C_no + "&language=English" + "');</script>")
        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        End If
    End Sub

    Protected Sub btnSendEmail_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSendEmail.Click
        pnlSendEmail.Visible = True
    End Sub

    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSend.Click

        If GridView1.Rows.Count > 0 Then

            For i As Integer = 0 To GridView1.Rows.Count - 1

                Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                If chk.Checked = True Then
                    Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTGID")
                    Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")
                    Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                    Dim TB_Name As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBName")
                    Load_Crystal_Report(TG_ID.Value, TB_ID.Value, TB_Name.Value)
                    Send_Email()
                End If
            Next

        Else
            lblEmailMsg.Text = "Kindly Select test first....."
            lblEmailMsg.Visible = False
            lblEmailMsg.ForeColor = Drawing.Color.Red
        End If
    End Sub
    Private Sub Send_Email()
        Dim From As String = "mp.kich@gmail.com"
        Dim ToEmail As String = txtEmail.Text
        Dim password As String = "mpsoftware"
        Try
            Dim mail As New System.Net.Mail.MailMessage()
            Dim client As New SmtpClient("smtp.gmail.com", 587)
            mail.[To].Add(ToEmail)
            Dim at As Attachment = New Attachment("E:\KichApp\Pathology\Email\TestReport.pdf")
            mail.Attachments.Add(at)
            mail.From = New MailAddress(From, "Khyber Institute of Child Health", System.Text.Encoding.UTF8)
            mail.Subject = "Test Result Report_" + Date.Now.ToString("dd-MMM-yyyy")
            mail.SubjectEncoding = System.Text.Encoding.UTF8
            mail.Body = "Email For Test Report.<br/><br/>Dear Sir /Madam , <br /><br />Kindly find the attachments." + "<br /> Regards, <br /> Khyber Institute Of Child Health."

            mail.BodyEncoding = System.Text.Encoding.UTF8
            mail.IsBodyHtml = True
            mail.Priority = MailPriority.High


            client.Credentials = New System.Net.NetworkCredential(From, password)
            client.EnableSsl = True
            Try
                client.Send(mail)
                insertEmailLogs("Email Sent Successfully!!!!!")
                File.Delete("E:\KichApp\Pathology\Email\TestReport.pdf")
            Catch ex As Exception
                insertEmailLogs("Some Error Occured While Email Sending!!!!!")
                File.Delete("E:\KichApp\Pathology\Email\TestReport.pdf")
            End Try
        Catch ex As Exception
        End Try

    End Sub
    Protected Sub insertEmailLogs(ByVal msg As String)
        Try
            Dim conStr As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
            Dim conEmail As SqlConnection = New System.Data.SqlClient.SqlConnection(conStr)
            Dim Procedurename As String = "usp_Insert_Path_Email_Logs"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)

            mycommand.CommandType = CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@SendTo", txtEmail.Text)
            mycommand.Parameters.AddWithValue("@Remarks", msg)

            conEmail.Open()
            mycommand.ExecuteScalar()
            conEmail.Close()


        Catch ex As Exception
        End Try
    End Sub
    Sub Load_Crystal_Report(ByVal tGId As Integer, ByVal tBId As Integer, ByVal tBName As String)

        Try
            Dim ds As DataSet = TestNormalRanges(tBId, tGId, tBName)
            Dim path As String = Server.MapPath(ReportName(tGId, tBId, tBName))


            crdoc.Load(path)
            Dim path_admin As New Pathology
            Dim path_admin_table As New PathologyTableAdapters.pro_Test_RangeValuesTableAdapter
            path_admin_table.Fill(path_admin.Tables("pro_Test_RangeValues"), Session("RegistrationNo"), Request.QueryString("TGID"))
            Try
                Dim status_by As String = String.Empty
                If Request.QueryString("status") = "10" Or Request.QueryString("status") = "8" Then
                    status_by = ""
                Else
                    status_by = "<font color=""gray"">PREL IMI NARY<br>REPORT</font>"
                End If

                For count As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                    For count_sub As Integer = 0 To path_admin.Tables("pro_Test_RangeValues").Rows.Count - 1

                        If ds.Tables("Patient_Result_Report").Rows(count).Item("TCID") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("TCId") Then

                            If IsNumeric(ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue")) = True Then
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then

                                        ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") = "<b style='color:BLACK; font-size: 11pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") + " </b>"

                                    End If
                                Catch ex As Exception
                                    'Response.Write(ex.Message)
                                End Try
                                '===================================
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") <> "" Then
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") = "  [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") + " ]"
                                    End If
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") = " &nbsp;&nbsp;&nbsp;&nbsp; [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + " ]"
                                    End If
                                Catch ex As Exception

                                End Try


                                '' Previous Value 1
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then
                                        If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                            ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = "<u style='color:BLACK; font-size: 50pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") + "</u>" + "&nbsp;&nbsp;&nbsp;&nbsp; " + " [" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + "  ] "

                                        End If

                                    Else

                                        If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                            ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") + "&nbsp;&nbsp;&nbsp;&nbsp; [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + " ]  "

                                        End If
                                        'ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = Replace(ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1"), "[]", "")
                                    End If
                                Catch ex As Exception

                                End Try

                                ' Previous Value 2
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then

                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") = "<u style='color:BLACK; font-size: 50pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") + "</u>" + "&nbsp;&nbsp;&nbsp;&nbsp; " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date")
                                    Else
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") = ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") + "&nbsp;&nbsp;&nbsp;&nbsp; " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date")

                                    End If
                                Catch ex As Exception

                                End Try

                            End If
                        End If
                    Next
                    'ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") = ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") + "  " + ds.Tables("Patient_Result_Report").Rows(count).Item("CompUnits")
                    Try

                        ds.Tables("Patient_Result_Report").Rows(count).Item("Status_by") = status_by

                        ds.Tables("Patient_Result_Report").Rows(count).Item("TC_Range_Unit") = ds.Tables("Patient_Result_Report").Rows(count).Item("TC_Range_Unit")

                    Catch ex As Exception

                    End Try
                Next
            Catch ex As Exception

            End Try


            Try
                test_name = tBName
                If tGId = 12 And InStr(test_name, "Culture", CompareMethod.Text) > 0 Then

                    Dim da_CultureMedicine As New Pt_Path_TestTableAdapters.CultureMedicinesTableAdapter
                    Dim da_CultureResults As New Pt_Path_TestTableAdapters.CultureTestResultsTableAdapter

                    da_CultureMedicine.Fill(ds.Tables("CultureMedicines"), Request.QueryString("Main_Id"), tBId)
                    da_CultureResults.Fill(ds.Tables("CultureTestResults"), Request.QueryString("Main_Id"), tBId)

                    For n As Integer = 0 To ds.Tables("CultureMedicines").Rows.Count - 1
                        ' ds.Tables("CultureMedicines").Rows(n).Item("Organism1") = "love"
                        For q As Integer = 0 To ds.Tables("CultureTestResults").Rows.Count - 1
                            If ds.Tables("CultureMedicines").Rows(n).Item("ComponentName") = ds.Tables("CultureTestResults").Rows(q).Item("ComponentName") Then

                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 1" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism1") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 2" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism2") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 3" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism3") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 4" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism4") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                            End If
                        Next
                    Next
                    crdoc.Database.Tables("CultureMedicines").SetDataSource(ds.Tables("CultureMedicines"))
                End If

            Catch ex As Exception

            End Try
            Dim fName As String = "E:\KichApp\Pathology\Email\TestReport.pdf"
            crdoc.Database.Tables("Patient_Result_Report").SetDataSource(ds.Tables("Patient_Result_Report"))
            crdoc.Database.Tables("Hospital_Header").SetDataSource(Session("Rpt_Header_DT"))
            crdoc.Database.Tables("Simple_Basic_Info").SetDataSource(ds.Tables("Simple_Basic_Info"))
            test_name = tBName
            crdoc.SetParameterValue(0, "Orignal")
            crdoc.ExportToDisk(ExportFormatType.PortableDocFormat, fName)
            'CrystalReportViewer1.ReportSource = crdoc

            'CrystalReportViewer1.ToolPanelView = CrystalDecisions.Web.ToolPanelViewType.None


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Function Pt_Dataset_Fill(ByVal tBID As Integer, ByVal tGId As Integer, ByVal tBName As String) As DataSet
        Dim ds As New Pt_Path_Test
        Dim x, z, y As Integer
        Dim da As New Pt_Path_TestTableAdapters.Patient_Result_ReportTableAdapter
        Dim da_PreviousResults As New Pt_Path_TestTableAdapters.Patient_LabResult_PreviousTableAdapter

        Dim Regno As String = Request.QueryString("RegNo")
        Dim Main_ID As Integer = Request.QueryString("Main_ID")
        Dim Sample_No As String = Request.QueryString("Sample_No")
        Dim Status As Integer = Request.QueryString("Status")
        Dim YearlyNo As Integer = Request.QueryString("YearlyNo")
        Dim TB_ID As Integer = 0
        If Not String.IsNullOrEmpty(tBID) Then
            TB_ID = tBID
        End If
        Dim IS_Group As Integer = 1

        '========================= Basic Data Info =========
        Dim da_Basic_Info As New Pt_Path_TestTableAdapters.Simple_Basic_InfoTableAdapter
        da_Basic_Info.FillBy_SampleNo(ds.Tables("Simple_Basic_Info"), Regno, Main_ID, Sample_No)

        For i As Integer = 0 To ds.Tables("Simple_Basic_Info").Rows.Count - 1

            Dim first_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PFName"), False)
            Dim second_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PMName"), False)
            Dim third_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PLName"), False)
            Dim Pre As String = ds.Tables("Simple_Basic_Info").Rows(i).Item("Prefix")


            ds.Tables("Simple_Basic_Info").Rows(i).Item(0) = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(0), False)
            ds.Tables("Simple_Basic_Info").Rows(i).Item(1) = Pre + " " + first_name + " " + second_name + " " + third_name
        Next

        '========================== Result Report  =========



        If tGId = 12 Then
            'And 
            If InStr(tBName, "Culture", CompareMethod.Text) > 0 Then
                da.FillBy_Cult(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, TB_ID, Status, Sample_No)
            Else
                da.FillBy_TBNameSubGroup(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, Sample_No, TB_ID, Status)

                For n As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                    If ds.Tables("Patient_Result_Report").Rows(n).Item("TestName").ToString = "Specimen" Then
                        ds.Tables("Patient_Result_Report").Rows(n).Item("TSGName") = ""
                        ds.Tables("Patient_Result_Report").Rows(n).Item("TestName") = "<b>" + ds.Tables("Patient_Result_Report").Rows(n).Item("TestName") + "</b>"
                    End If
                Next
            End If

        ElseIf tGId = 98 Or tGId = 94 Or tGId = 122 Or tGId = 124 Or tGId = 123 Or tGId = 125 Or tGId = 10 Then
            da.FillBy_AllBookingServices(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, Sample_No, Status, TB_ID, IS_Group)

        ElseIf tGId = 116 Or tGId = 120 Or tGId = 121 Then
            da.FillBy_Haem_Other(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, Sample_No, Status, TB_ID, IS_Group)

        ElseIf Request.QueryString("TGID") = 126 Then
            da.FillBy_TBNameSubGroup(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, Sample_No, TB_ID, Status)
        Else
            da.FillBy_TestBooking(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, tGId, Main_ID, Sample_No, TB_ID, Status)

        End If
        z = 0

        Return ds

    End Function
    Function TestNormalRanges(ByVal tBID As Integer, ByVal tGId As Integer, ByVal tBName As String) As DataSet
        Dim x, y As Integer
        Dim ds As DataSet = Pt_Dataset_Fill(tBID, tGId, tBName)
        'Dim TB_IDs As String = get_distinct_TB_ID()

        Dim mycommand As SqlCommand = New SqlCommand("SELECT TestReference_values.Possible_Result, TestReference_values.Extra_Comments, TestReference_values.TCID, TestReference_values.ValueStart,TestReference_values.ValueEnd FROM TestReference_values INNER JOIN TestComponent ON TestReference_values.TCID = TestComponent.TCID WHERE     (TestComponent.TGID = @TGID)", con)
        mycommand.CommandType = CommandType.Text
        mycommand.Parameters.AddWithValue("@TGID", tGId) 'HiddenFieldRegNo.Value)
        con.Open()
        Dim ds1 As New DataSet
        Dim sreader As New SqlDataAdapter
        sreader.SelectCommand = mycommand
        sreader.Fill(ds1)
        If ds1.Tables(0).Rows.Count <> 0 Then
            For x = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                For y = 0 To ds1.Tables(0).Rows.Count - 1
                    If ds1.Tables(0).Rows(y).Item("TCID").ToString() = ds.Tables("Patient_Result_Report").Rows(x).Item("TCID").ToString Then
                        If (CDec(ds.Tables("Patient_Result_Report").Rows(x).Item("TCValue")) >= ds1.Tables(0).Rows(y).Item("ValueStart")) And CDec(ds.Tables("Patient_Result_Report").Rows(x).Item("TCValue")) <= ds1.Tables(0).Rows(y).Item("ValueEnd") Then
                            ds.Tables("Patient_Result_Report").Rows(x).Item("Normal_Range") = ds1.Tables(0).Rows(y).Item("Possible_Result").ToString()
                            Exit For
                        End If
                    End If
                Next
            Next
        End If
        con.Close()
        Return ds
    End Function
    Function ReportName(ByVal tgid As Integer, ByVal tsgid As Integer, ByVal tBName As String) As String
        ReportName = String.Empty
        If tgid = 98 Then



            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

            If InStr(tBName, "Stone", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwise_Stone.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If



        ElseIf tgid = 123 Or tgid = 124 Or tgid = 125 Or tgid = 122 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        ElseIf tgid = 10 Then
            If InStr(tBName, "Cross", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem_Cross_Match_Report.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            Else

                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If

        ElseIf tgid = 116 Or tgid = 120 Or tgid = 121 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem_Other.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        ElseIf tgid = 12 Then
            If InStr(tBName, "Culture", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Cult.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(tBName, "SEMEN", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwise_Semen.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            ElseIf InStr(tBName, "Stain", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_SN_Stain.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(tBName, "Milk", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Milk.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(tBName, "Fungal", CompareMethod.Text) > 0 Then
                Try

                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Fungal.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(tBName, "Fluid", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Fluid.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(tBName, "Routine", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Routine.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            ElseIf InStr(tBName, "Stool For Clostridium", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Stool_Clostridium.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            Else
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology.rpt"

            End If
        ElseIf tgid = 12 And tsgid = 1097 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        ElseIf tgid = 94 Then

            ReportName = "Result_Reports\Patient_Result_Report_TBwise_Serology.rpt"
        ElseIf tgid = 115 Then

            ReportName = "Result_Reports\Patient_Result_Report_TBwiseBoneMarrow.rpt"

        ElseIf tgid = 101 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseHisto.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        ElseIf tgid = 126 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_PCR.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try


        ElseIf tgid = 112 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_Culture.rpt"
            Catch ex As Exception
                Response.Write(ex.Message & " jkjk kjk ")
            End Try

        Else
            Try

                Dim mycommand As SqlCommand = New SqlCommand("SELECT rpt_name FROM test_reports WHERE (test_reports.TGID = @TGID) and (test_reports.tb_id = @TSGID)", con)
                mycommand.CommandType = CommandType.Text
                mycommand.Parameters.AddWithValue("@TGID", tgid) 'HiddenFieldRegNo.Value)
                mycommand.Parameters.AddWithValue("@TSGID", tsgid)
                con.Open()
                Dim ds1 As New DataSet
                Dim sreader As New SqlDataAdapter

                Try
                    sreader.SelectCommand = mycommand
                    sreader.Fill(ds1)


                Catch ex As Exception

                End Try
                con.Close()
                If ds1.Tables(0).Rows.Count > 0 Then
                    ReportName = ds1.Tables(0).Rows(0).Item(0).ToString
                Else
                    If "Original" = "Group Wise" Then
                        ReportName = "Result_Reports\Patient_Result_Report_Group_Wise.rpt"
                    ElseIf "Original" = "Sub Group Wise" Then
                        ReportName = "Result_Reports\Patient_Result_Report.rpt"
                    ElseIf "Original" = "SGSW" Then
                        ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup.rpt"

                    Else
                        ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
                    End If
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If

        Return ReportName

    End Function


    Protected Sub btnClosePnl_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClosePnl.Click
        txtEmail.Text = ""
        pnlSendEmail.Visible = False
    End Sub
End Class
