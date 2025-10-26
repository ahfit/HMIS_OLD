Imports System.Data
Imports System.Data.SqlClient
Imports QRCoder
Imports System.IO
Imports System.Drawing

Partial Class Pathology_Patient_Sample
    Inherits System.Web.UI.Page
    Dim cnic As String, name As String, Result As String, deliverytime As String, Passport_No As String, LabNo As Integer
    Dim Path_ConnectionString As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString)
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click


        If HfSaveStatus.Value = "RS" Then
            For count As Integer = 0 To GridView2.Rows.Count - 1
                Dim status As CheckBox = GridView2.Rows(count).FindControl("CheckBox_Status")
                Dim TB_ID As HiddenField = GridView2.Rows(count).FindControl("HiddenField_TB_ID")
                Dim ID As HiddenField = GridView2.Rows(count).FindControl("HiddenField_ID")
                If status.Checked Then
                    Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Update Test_Booking_Services set Status = 17 where (ID = @Id); INSERT INTO [dbo].[Lab_Status_Record] ([TB_ID],[Order_ID],[Enter_Date_time],[Status] ,[Detail],[Entry_By]) VALUES (@TBId,@Main_Id,Getdate(),1,'Sample Received',@emp_id);", con)
                    mycommand.Parameters.AddWithValue("@Id", ID.Value)
                    mycommand.Parameters.AddWithValue("@Main_Id", Request.QueryString("Main_ID"))
                    mycommand.Parameters.AddWithValue("@TBId", TB_ID.Value)
                    mycommand.Parameters.AddWithValue("@emp_id", Session("emp_id"))
                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()
                End If

            Next
            Response.Redirect("~/Pathology/Patient_Search.aspx?def=1")

        ElseIf HfSaveStatus.Value = "RB" Then
            Response.Redirect("~/Pathology/Patient_Search.aspx?def=12")
        Else
            Try
                HiddenField_Reference_Sample.Value = DropDownList_PreRefrenceNo.SelectedValue


                Dim val As Integer = 0

                Dim TemTable As String = "<sample>"
                Dim isCovidTest As Boolean = False

                For count As Integer = 0 To GridView2.Rows.Count - 1
                    Dim status As CheckBox = GridView2.Rows(count).FindControl("CheckBox_Status")
                    Dim TB_ID As HiddenField = GridView2.Rows(count).FindControl("HiddenField_TB_ID")
                    Dim ID As HiddenField = GridView2.Rows(count).FindControl("HiddenField_ID")
                    Dim S_ID As HiddenField = GridView2.Rows(count).FindControl("HiddenField_S_ID")
                    Dim CH_Other_Lab As CheckBox = GridView2.Rows(count).FindControl("CH_Other_Lab")
                    Dim TG_ID As HiddenField = GridView2.Rows(count).FindControl("HfTGID")

                    HiddenField_ID.Value = ID.Value
                    HiddenField_TB_ID.Value = TB_ID.Value
                    HiddenField_S_ID.Value = S_ID.Value
                    HfTGID.Value = TG_ID.Value

                    TemTable = TemTable + "<row> <ID>" + HiddenField_ID.Value + "</ID><TB_ID>" + HiddenField_TB_ID.Value + "</TB_ID><S_ID>" + HiddenField_S_ID.Value + "</S_ID><CH_Other_Lab>" + CH_Other_Lab.Checked.ToString() + "</CH_Other_Lab><status>" + status.Checked.ToString() + "</status></row>"
                    If status.Checked Then
                        val = val + 1

                    End If
                    'If TB_ID.Value = "4089" Then
                    '    isCovidTest = True
                    'End If
                Next
                TemTable = TemTable + "</sample>"
                hf_Data.Value = TemTable
                If val > 0 Then
                    SqlDataSource_insert_test_Sample.Insert()
                Else

                End If


                'If Request.QueryString("status") = "12" And isCovidTest = True Then
                '    GenerateQRCode()
                'End If



                'If val = 1 Then
                '    Dim sb As StringBuilder = New StringBuilder
                '    sb.Append("<script language='javascript'>")
                '    sb.Append(" window.open('Sample_Slip.aspx?Main_ID=" + Request.QueryString("Main_ID") + "' )</script>")
                '    Dim t As Type = Me.GetType
                '    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                '        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                '    End If
                'End If
                GridView1.DataBind()
                GridView2.DataBind()
                hf_Data.Value = String.Empty
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If

    End Sub
    Public Function GetQRCode(ByVal codes As String) As String
        'Dim img As Byte() = Nothing
        Dim code As String = codes

        Dim qrPath = "http://110.39.56.131/hmis2/pathology/Patientlabreports/" & Request.QueryString("YearlyNo").ToString().Replace(")", "") & Request.QueryString("Main_ID").Replace(")", "").ToString() & "4089" & Date.Now.ToString("ddMMyyyy") & ".pdf"

        Dim qrGenerator As QRCodeGenerator = New QRCodeGenerator()
        Dim qrCode As QRCodeGenerator.QRCode = qrGenerator.CreateQrCode(code, QRCodeGenerator.ECCLevel.L)
        Dim imgBarCode As System.Web.UI.WebControls.Image = New System.Web.UI.WebControls.Image()
        imgBarCode.Height = 100
        imgBarCode.Width = 100
        Dim bitMap As Bitmap = qrCode.GetGraphic(70)
        Dim ms As MemoryStream = New MemoryStream()
        bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png)
        Dim byteImage As Byte() = ms.ToArray()
        imgBarCode.ImageUrl = "data:image/png;base64," & Convert.ToBase64String(byteImage)
        'img = New Byte(ms.ToArray().Length - 1) {}
        'img = ms.ToArray()

        qrPath = "~/QRCode/" + Request.QueryString("YearlyNo") + Request.QueryString("Main_ID") + "4089" + Date.Now.ToString("ddMMyyyy") + ".jpeg"


        'bitMap.Save("~\QRCode\", Drawing.Imaging.ImageFormat.Jpeg)
        bitMap.Save(Server.MapPath(qrPath), Drawing.Imaging.ImageFormat.Jpeg)

        Return qrPath

    End Function
    Protected Sub GenerateQRCode()
        Path_ConnectionString.Open()
        PatientOtherInfo(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"), Request.QueryString("Main_Id"))
        Dim qrcodess As String = "Patient Name :" + name.ToString() + " : " + "CNIC # :" + Convert.ToString(cnic) + " : " + "Report Date :" + Convert.ToString(deliverytime) + ":" + "Passport # :" + Passport_No.ToString() + ":" + "Lab # :" + LabNo.ToString()
        Dim command As SqlCommand = New SqlCommand("usp_Update_Qrcode", Path_ConnectionString)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Main_ID", Request.QueryString("Main_ID"))
        command.Parameters.AddWithValue("@Qr_Code", GetQRCode(qrcodess))

        command.ExecuteNonQuery()
    End Sub
    Protected Sub MarkTestByGroup()
        Dim Group As String = ""
        If txtbox_BarCode.Text.Trim().Contains("-") Then
            If txtbox_BarCode.Text.Trim().Split("-")(1) <> "" Then
                Group = txtbox_BarCode.Text.Trim().Split("-")(1)
            End If
        End If

        If Group <> "" Then
            For count As Integer = 0 To GridView2.Rows.Count - 1
                Dim status As CheckBox = GridView2.Rows(count).FindControl("CheckBox_Status")
                Dim TG_ID As HiddenField = GridView2.Rows(count).FindControl("HfTGID")
                If Group = TG_ID.Value Then
                    status.Checked = True
                Else
                    status.Checked = False
                End If
            Next
        Else
            For count As Integer = 0 To GridView2.Rows.Count - 1
                Dim status As CheckBox = GridView2.Rows(count).FindControl("CheckBox_Status")
                Dim TG_ID As HiddenField = GridView2.Rows(count).FindControl("HfTGID")

                status.Checked = True
            Next
        End If

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            HfStatus.Value = Request.QueryString("Status")
            Get_Patient_Diagnosis()


            If Not Request.QueryString("Status") Is Nothing Then
                If Request.QueryString("Status") = "1" Then
                    HfStatus.Value = Request.QueryString("Status")
                    Button_Save.Text = "Receive Sample"
                    HfSaveStatus.Value = "RS"
                    Button_Save.Width = 150
                    GridView2.Columns(3).Visible = False

                ElseIf Request.QueryString("Status") = "1O" Then
                    HfStatus.Value = 1
                    Button_Save.Text = "Return"
                    HfSaveStatus.Value = "RB"
                    Button_Save.Width = 80
                    GridView2.Columns(3).Visible = False

                End If
            End If
            'If Not Request.QueryString("BarCodeStatus") Is Nothing Then
            '    If Request.QueryString("BarCodeStatus") = "1" Then
            '        Button_Save.Text = "Return"
            '        HfSaveStatus.Value = "RT"
            '        Button_Save.Width = 80
            '        GridView2.Columns(3).Visible = False
            '    End If
            'End If
        End If
        Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
        TextBox_Sample_no.Text = Request.QueryString("Main_Id")
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        UploadTest(2, Request.QueryString("Main_ID"), 3)
    End Sub
    Sub UploadTest(ByVal Machine_Id As Integer, ByVal Main_Id As Integer, ByVal SequenceNo As Integer)

        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("UploadMachineTest", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@Machine_Id", Machine_Id)
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Dim x, z As Integer
        Dim str1 = "O|1|"
        Dim str2 = Main_Id.ToString
        Dim strSequence = Right(Main_Id, 1) + 1
        Dim str3 = "|" + strSequence.ToString + "^50001^"
        Dim str4 = "001" '+ SequenceNo.ToString
        ' str4 = Right(str2, 3)
        Dim str5 = "^^S1^SC|"
        Dim str6 = ""
        Dim str8 = ""
        For z = 0 To ds.Tables(0).Rows.Count - 1

            If z = 0 Then
                str6 = "^^^" + ds.Tables(0).Rows(z).Item("Machine_Test_Code").ToString.Trim + "^"
                str8 = ds.Tables(0).Rows(z).Item("Sample_Collection_Date").ToString.Trim
            Else
                str6 = str6 + "\^^^" + ds.Tables(0).Rows(z).Item("Machine_Test_Code").ToString.Trim + "^"
            End If

        Next
        Dim str7 = "|R||"
        Dim str9 = "||||A||||1||||||||||O"
        Dim strMessage = str1 + str2 + str3 + str4 + str5 + str6 + str7 + str8 + str9
        If ds.Tables(0).Rows.Count > 0 Then
            HiddenField_StrMessage.Value = strMessage
            SqlDataSourceMachineMessage.Insert()

        End If
        con.Close()
    End Sub

    Protected Sub TextBox_Sample_no_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Sample_no.TextChanged

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        For count As Integer = 0 To GridView2.Rows.Count - 1


            Dim status As CheckBox = GridView2.Rows(count).FindControl("CheckBox_Status")
            status.Checked = True
        Next
    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList1.SelectedIndexChanged

        HiddenField_TestStatus.Value = 1

        If RadioButtonList1.SelectedValue = "Collected at Lab" Then
            DropDownList_Outlet.Visible = False
            DropDownList_OutSideLab.Visible = False
            TextBox_Out_Side_Lab_No.Visible = False
        ElseIf RadioButtonList1.SelectedValue = "Outside the Lab" Then
            DropDownList_Outlet.Visible = False
            DropDownList_OutSideLab.Visible = True
            TextBox_Out_Side_Lab_No.Visible = True
        ElseIf RadioButtonList1.SelectedValue = "Send to Outside Lab" Then
            DropDownList_Outlet.Visible = False
            DropDownList_OutSideLab.Visible = True
            HiddenField_TestStatus.Value = 15

        Else
            DropDownList_Outlet.Visible = True
            DropDownList_OutSideLab.Visible = False
            TextBox_Out_Side_Lab_No.Visible = False
        End If
        If RadioButtonList1.SelectedValue = "Main Lab" Then
            DropDownList_Outlet.Visible = False
        Else
            DropDownList_Outlet.Visible = True
        End If


    End Sub


    Protected Sub SqlDataSource_insert_test_Sample_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_insert_test_Sample.Inserted
        HiddenField_Sample_No.Value = e.Command.Parameters("@Sample_No").Value.ToString()
        If Not String.IsNullOrEmpty(HiddenField_Sample_No.Value) Then
            hf_Data.Value = String.Empty
            pnl_Lab_No.Visible = True
            lbl_Sample.Text = HiddenField_Sample_No.Value
            btn_Return.Focus()

        End If
    End Sub

    Protected Sub DropDownList_PreRefrenceNo_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_PreRefrenceNo.DataBound
        DropDownList_PreRefrenceNo.Items.Insert(0, "All")
        DropDownList_PreRefrenceNo.Items(0).Value = "%"

    End Sub

    Protected Sub Get_Patient_Diagnosis()
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        '===================================================================
        Dim mycommand As New SqlCommand("SELECT pd.DiseaseName FROM pt_Diagnosis pd WHERE pd.YearlyNo = @YearlyNo AND pd.RegNo = @RegNo", con)
        Try

            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@YearlyNo", Convert.ToInt32(Request.QueryString("YearlyNo")))
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No"))
            mycommand.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds)
            mycommand.Connection.Close()

            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Dim strResult As String = ""
                    For count As Integer = 0 To ds.Tables(0).Rows.Count - 1
                        If count = 0 Then
                            strResult = strResult & ds.Tables(0).Rows(0)("DiseaseName").ToString()
                        Else
                            strResult = strResult & ", " & ds.Tables(0).Rows(0)("DiseaseName").ToString()
                        End If
                    Next
                    TextBox_Description.Text = strResult
                End If
            End If
        Catch ex As Exception
            Response.Write(ex.Message & " regNo")
        End Try
    End Sub

    Protected Sub LinkButton_Show_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Show_Report.Click
        'Response.Redirect("LabBarCode.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&Sample_No=" + HiddenField_Sample_No.Value)
    End Sub


    'Protected Sub linkButton_PrintBarCode_Click(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Dim lb As LinkButton = DirectCast(sender, LinkButton)
    'End Sub
    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lnk As LinkButton = e.Row.FindControl("lnkPrintBarCode")
            If HfSaveStatus.Value = "RS" Or HfSaveStatus.Value = "RB" Then
                lnk.Visible = True
            End If
        End If

    End Sub
    Protected Sub lnkPrintBarCode_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkBarcode As LinkButton = DirectCast(sender, LinkButton)

        Dim url As String = "LabBarCode.aspx?RegNo=" + Request.QueryString("Reg_No") + "&YearlyNo=" + Request.QueryString("YearlyNo") + "&Sample_No=" + Request.QueryString("sample_No") + "&TG_ID=" + lnkBarcode.CommandName + "&TB_ID=" + lnkBarcode.CommandArgument + ""

        Dim sb As New StringBuilder()

        sb.Append("<script type = 'text/javascript'>")

        sb.Append("window.open('")

        sb.Append(url)

        sb.Append("');")

        sb.Append("</script>")

        ClientScript.RegisterStartupScript(Me.GetType(), "script", sb.ToString())

        'Dim s As String = "window.open('" & url & "', '_blank');"
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "alertscript", s, True)
        'Response.Redirect("<script>window.open ('LabBarCode.aspx?RegNo=" + Request.QueryString("Reg_No") + "&YearlyNo=" + Request.QueryString("YearlyNo") + "&Sample_No=" + Request.QueryString("sample_No") + "&TB_ID=" + lnkBarcode.CommandArgument + "','_blank');</script>")
        'Response.Redirect("LabBarCode.aspx?RegNo=" + Request.QueryString("Reg_No") + "&YearlyNo=" + Request.QueryString("YearlyNo") + "&Sample_No=" + Request.QueryString("sample_No") + "&TB_ID=" + lnkBarcode.CommandArgument)
    End Sub

    Protected Sub btn_Return_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Return.Click
        pnl_Lab_No.Visible = False

        Response.Redirect(Request.Url.ToString().Split("?")(0) + "?Reg_No=" + Request.QueryString("Reg_No") + "&YearlyNo=" + Request.QueryString("YearlyNo") + "&Main_ID=" + Request.QueryString("Main_ID") + "&sample_No=" + lbl_Sample.Text.Trim() + "&status=1O&BarCodeStatus=1")

    End Sub

    Protected Sub lnkSearch_Click(sender As Object, e As EventArgs)
        MarkTestByGroup()
    End Sub
    Sub PatientOtherInfo(ByVal regno As String, ByVal payid As String, ByVal Main_Id As Integer)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("QrCode_Information", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            mycommand.Parameters.AddWithValue("@Main_ID", Main_Id)

            con.Open()
            Dim reader As SqlDataReader = mycommand.ExecuteReader
            While (reader.Read())
                cnic = reader.Item("CNICNO")
                name = reader.Item("Name")
                deliverytime = reader.Item("ReportTime")
                Passport_No = reader.Item("Passport_No")
                LabNo = reader.Item("LabNo")

            End While
            con.Close()
        Catch ex As Exception

            Response.Write(ex.Message)
        End Try

    End Sub
End Class
