Imports System.Data
Imports System.Data.SqlClient
Imports System.Net.Mail
Imports System.IO
Imports System.Net
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports CrystalDecisions.Shared
'Imports EASendMail
Imports QRCoder
Imports DBClass
Imports System.Drawing

Partial Class Pt_Select_Test_Consultant
    Inherits System.Web.UI.Page
    Dim Path_ConnectionString As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString)
    Dim cnic As String, name As String, Result As String, deliverytime As String, Passport_No As String, LabNo As Integer
    Dim TrmID As Integer
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim constr_path As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
    Dim ENC As New Encryption

    'Dim main_id As Integer = 0
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try

            InsertMain(HiddenFieldMainID.Value)
            Check_Controls()
            If Patient_Calculate_Test() = True Then
                ButtonFinal.Visible = True
            End If

            GridView_Track.DataBind()
            LinkButton_Show_Report.Visible = True
            GridView_Missing_Component.DataBind()
            If HiddenField_Flag.Value = 0 Then
                Panel_Missing_Component.Visible = True
            End If
            Load_Test_Panel(DataList1.SelectedIndex)
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
        'Response.Redirect("PatientTestReportMain.aspx?YearlyNo=" + Request.QueryString("YearlyNo").ToString + "&RegNo=" + Request.QueryString("RegNo").ToString)
    End Sub
    Public Function GetQRCode(ByVal codes As String) As String
        'Dim img As Byte() = Nothing
        Dim code As String = codes

        Dim qrPath = "http://203.99.181.197/hmis/pathology/Patientlabreports/" & Request.QueryString("YearlyNo").ToString().Replace(")", "") & Request.QueryString("Main_ID").Replace(")", "").ToString() & HiddenField_TBID.Value & Date.Now.ToString("ddMMyyyy") & ".pdf"

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

        qrPath = "~/QRCode/" + Request.QueryString("YearlyNo") + Request.QueryString("Main_ID") + HiddenField_TBID.Value + Date.Now.ToString("ddMMyyyy") + ".jpeg"

        bitMap.Save(Server.MapPath(qrPath), Drawing.Imaging.ImageFormat.Jpeg)

        Return qrPath

    End Function
    Protected Sub GenerateQRCode()
        Path_ConnectionString.Open()
        PatientOtherInfo(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"), Request.QueryString("Main_Id"), HiddenField_TBID.Value)
        Dim result As String = String.Empty

        If HiddenField_TBID.Value = "4102" Then
            Dim txtresultAntigen As DropDownList = Panel1.FindControl("TextBoxT05738-4102")
            result = txtresultAntigen.SelectedValue

            If HiddenField_TBID.Value = "4102" Then
                Dim DropresultAntigen As DropDownList = Panel1.FindControl("TextBoxT05738-4102")
                result = DropresultAntigen.SelectedValue
            End If

        Else
            Dim txtresult As TextBox = Panel1.FindControl("TextBoxT05738-4102")
            result = getResult(txtresult.Text)
        End If
        Dim qrcodess As String = "Patient Name :" + name.ToString() + System.Environment.NewLine + "CNIC # :" + Convert.ToString(cnic) + System.Environment.NewLine + "Report Date :" + Convert.ToString(deliverytime) + System.Environment.NewLine + "Lab # :" + LabNo.ToString() + System.Environment.NewLine + "Result :" + result

        '        Dim qrcodess As String = "Patient Name :" + name.ToString() + System.Environment.NewLine + "CNIC # :" + Convert.ToString(cnic) + System.Environment.NewLine + "Report Date :" + Convert.ToString(deliverytime) + System.Environment.NewLine + "Passport # :" + Passport_No.ToString() + System.Environment.NewLine + "Lab # :" + LabNo.ToString() + System.Environment.NewLine + "Result :" + result
        Dim command As SqlCommand = New SqlCommand("usp_Update_Qrcode", Path_ConnectionString)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Main_ID", Request.QueryString("Main_ID"))
        command.Parameters.AddWithValue("@Qr_Code", GetQRCode(qrcodess))

        command.ExecuteNonQuery()
        Path_ConnectionString.Close()
    End Sub
    Sub PatientOtherInfo(ByVal regno As String, ByVal payid As String, ByVal Main_Id As Integer, ByVal TB_ID As Integer)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("QrCode_Information", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            mycommand.Parameters.AddWithValue("@Main_ID", Main_Id)
            mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)

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

    Protected Sub DataListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListMainGroup.SelectedIndexChanged
        Panel1.Controls.Clear()
        Dim hid_main_group As HiddenField = DataListMainGroup.Items(DataListMainGroup.SelectedIndex).FindControl("HiddenField4")
        HiddenFieldCategory.Value = DataListMainGroup.SelectedItem.ToString
        'Response.Write(hid_main_group.Value & "fdsf")
        If hid_main_group.Value.Trim = "Histopathology" Then
            Response.Redirect("Biopsy_Entry.aspx?RegNo=" & Session("registrationNo") & "&YearlyNo=" & Session("YearlyNo"))
        End If

        HiddenField3.Value = DataListMainGroup.SelectedValue
        'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
        Dim hid_TGID As HiddenField = DataListMainGroup.Items(DataListMainGroup.SelectedIndex).FindControl("HiddenField1")
        Dim hid_Main_Id As HiddenField = DataListMainGroup.Items(DataListMainGroup.SelectedIndex).FindControl("HiddenField5")
        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        'main_id = HiddenFieldMainID.Value
        'Response.Write(main_id)
        'Response.Write(HiddenFieldMainID.Value)
        'Next
        Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
        HiddenField_MS_TGID.Value = DataListMainGroup.SelectedValue
        Phy_Elements(DataListMainGroup.SelectedValue, 38, dss, HiddenFieldMainID.Value) '("TestMainGroup"), DataListtemplate.SelectedValue, dss)
        TextBox_Description.Visible = True
        Label_Description.Visible = True
    End Sub
    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer)

        Try


            Dim path_admin As New Pathology
            Dim path_admin_table As New PathologyTableAdapters.pro_Test_RangeValuesTableAdapter
            path_admin_table.Fill(path_admin.Tables("pro_Test_RangeValues"), Session("RegistrationNo"), HiddenField_MS_TGID.Value)

            Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Pathology_select_TestforReport_new", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@TGID", MG_Code)
            mycommand.Parameters.AddWithValue("@MS_TGID", HiddenField_MS_TGID.Value) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@template_id", template_id)
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@Main_ID", main_id)
            mycommand.Parameters.AddWithValue("@Status", Request.QueryString("Status"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")

            'If ds.Tables("abc").Rows.Count > 0 And TextBox_Description.Text = "" Then
            '    TextBox_Description.Text = ds.Tables("abc").Rows(0).Item("Report")
            'End If

            'Try
            '    For count As Integer = 0 To ds.Tables("abc").Rows.Count - 1
            '        For count_sub As Integer = 0 To path_admin.Tables("pro_Test_RangeValues").Rows.Count - 1

            '            If ds.Tables("abc").Rows(count).Item("TCID") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("TCId") Then
            '                ds.Tables("abc").Rows(count).Item("TC_Range_Unit") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("Range Values")
            '            End If
            '        Next

            '    Next
            'Catch ex As Exception

            'End Try


            Dim j As Integer = 0
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Label_For_Table("<table id='Table_Phy_Exam' border='0' width ='100%' class='Grid_dynamic'  ")
                    Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                ElseIf i <> 0 Then
                    If ds.Tables(0).Rows(i - 1).Item(7).ToString <> ds.Tables(0).Rows(i).Item(7).ToString Then
                        Label_For_Table("</table>")
                        Label_For_Table("<table id='Table_Phy_Exam' border='0' width='100%' class='Grid_dynamic'>")
                        Label_For_Table("<tr bgcolor='#ffcc66' font-size: 13pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                        j = 0

                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                        j = 1
                        Continue For
                    Else
                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                    End If
                End If
                j = j + 1
            Next
            Label_For_Table("</table>")
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Response.Write(Request.QueryString("Main_ID"))
            'Response.End()
            Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
            'Response.Write(Session("RegistrationNo"))
            'Response.Write("YearlyNo" + Session("YearlyNo"))
            'If Session("YearlyNo") Is Nothing Or Session("RegistrationNo") Is Nothing Then
            'Response.Redirect("Login.aspx")
            'End If
            If Session("emp_Type").ToString.Contains("Consultant") Or Request.QueryString("status") = "6" Then
                Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
                'loginvalidate(Session("emp_id"), Session("dept_id"))
                Label_message.Text = ""
                If Patient_Calculate_Test() = True Then
                    ButtonFinal.Visible = True
                End If
                If Page.IsPostBack Then
                    'Response.Write(Panel1.Controls.Count)
                    Panel1.Controls.Clear()
                    SqlDataSource_machines_main_ID.Update()
                    'Response.Write(Panel1.Controls.Count)
                    If Panel1.Controls.Count > 0 Then
                        Panel1.Controls.Clear()
                    End If
                    Dim Dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
                    If DropDownList_TestName.Text = "All" Or DropDownList_TestName.Text = "0" Then
                        HiddenField_TBID.Value = ""
                    End If
                    HiddenField_Description.Value = TextBox_Description.Text
                    If HiddenField_TBID.Value = "" Then
                        Phy_Elements(DataListtemplate.SelectedValue, 38, Dss, HiddenFieldMainID.Value)
                    Else
                        Phy_Elements_TB_ID(DataListtemplate.SelectedValue, 38, Dss, HiddenFieldMainID.Value, HiddenField_TBID.Value)
                    End If
                End If
            Else
                Response.Redirect("pt_select_test.aspx?Reg_No=" + Request.QueryString("Reg_No").ToString + "&YearlyNo=" + Request.QueryString("YearlyNo").ToString + "&Main_ID=" + Request.QueryString("Main_ID").ToString + "&sample_No=" + Request.QueryString("sample_No").ToString + "&status=" + Request.QueryString("status"))

            End If
            If Page.IsPostBack = False Then
                HiddenField_Description.Value = "1"
            End If
        Catch ex As Exception
        End Try



    End Sub
    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer)
        Try
            If HiddenField_Page_type.Value = "new" Then

                Try

                    Label_For_Table("</tr><tr>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))

                Catch ex As Exception
                    'Response.Write(ex.Message)
                End Try
            ElseIf HiddenField_Page_type.Value = "old" Then

                If MG_Code <> 0 Then
                    If j Mod 2 = 1 Then
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        Label_For_Table("</td>")
                    ElseIf j Mod 2 <> 1 Then
                        If j Mod 4 = 0 Then
                            Label_For_Table("<tr bgcolor='#f8ffe0'>") '#f8fff7'>")
                            Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        Else
                            Label_For_Table("</tr><tr>")
                            Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        End If
                    End If
                Else
                    If i Mod 2 = 1 Then
                        Label_For_Table("<td >")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        Label_For_Table("</td>")
                    ElseIf i Mod 2 <> 1 Then
                        If i Mod 4 = 0 Then
                            Label_For_Table("<tr bgcolor='#f8ffe0'>")
                            Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        Else
                            Label_For_Table("</tr><tr>")
                            Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), ds.Tables(0).Rows(i).Item(20))
                        End If
                    End If
                End If
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_Value As String, ByVal main_id As Integer, ByVal Max_Length As Integer, ByVal TID As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            ',(SELECT ev_code FROM Pt_history_SaveRecord WHERE (e_Code = 12345) AND (YearlyNo = " & Session("YearlyNo") & ") AND (RegNo = '" & Session("registrationNo") & "')) AS selectedvalue
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TC_Value_ID,TC_Value from TestCOmponent_value where TCID = @e_Code", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            'Response.Write(e_code & "  fdg  ")
            param = mycommand.Parameters.AddWithValue("@e_Code", e_code) 'Session("BMIPayID")
            Dim da1 As New SqlDataAdapter
            Dim ds1 As New DataSet
            da1.SelectCommand = mycommand
            da1.Fill(ds1, "abc")
            'Response.Write(ds1.Tables(0).Rows.Count & " count ")
            Dim Save_Record_Color As String = ""
            'For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
            '    Response.Write(ds1.Tables(0).Rows(j).Item(1).ToString & " fdsf dssd ")
            'Next
            'If ds1.Tables(0).Rows.Count > 0 Then
            Dim Test_Date_Time As String = ""
            For i As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1

                ' And (HiddenField_TBID.Value = Already_Save_Values.Tables(0).Rows(i).Item(9).ToString) 
                If e_code = CInt(Already_Save_Values.Tables(0).Rows(i).Item(1).ToString) And (e_id = Already_Save_Values.Tables(0).Rows(i).Item(9).ToString) Then

                    Test_Date_Time = Already_Save_Values.Tables(0).Rows(i).Item("Date").ToString & " " & Already_Save_Values.Tables(0).Rows(i).Item("Time").ToString & "<br />"
                    Test_Date_Time = "<span style='text-align:left; color:#CC0000; font-size:9px;'>" & Test_Date_Time & "</span>"
                    Save_Record_Color = "#ffccff"
                End If
            Next
            'End If
            Make_Control(ds1, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, Tooltip, Range_Value, main_id, Test_Date_Time, TID)

        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal TID As Integer)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        If HiddenField_Page_type.Value = "new" Then
            control.TextMode = TextBoxMode.MultiLine
            control.Width = 600
            control.Height = 100
        End If
        control.TextMode = TextBoxMode.MultiLine

        control.ToolTip = Tooltip
        control.ValidationGroup = TID
        Dim dds As DataSet = Already_Save(E_Code, main_id, E_Id)

        If dds.Tables(0).Rows.Count <> 0 Then

            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        control.Attributes.Add("onchange", "return CheckRequiredField('" + "TextBox" & E_Id + "','" + HiddenField_TBID.Value + "')")
        control.CssClass = "text_titles_01"
        Panel1.Controls.Add(control)
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal Test_Date_Time As String, ByVal TID As Integer)
        Try
            Label_For_Table("<td width ='10%' bgcolor='" & Save_Record_Color & "' align='right'>")
            Make_Label(e_id, e_name, Mg_code, Already_Save_Values, Tooltip)
            Label_For_Table("</td>")
            If e_field = "TextBox" Or e_field = "3" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01' style='text-align:left;'>" & Test_Date_Time)
                Make_TextBox(e_id, Already_Save_Values, E_Code, Tooltip, Range_value, main_id, TID)
                Label_For_Table("</td>")
            ElseIf e_field = "DropDownList" Or e_field = "8" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, Tooltip, Range_value, main_id)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "RadioButtonList" Or e_field = "4" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                'Response.Write("radiobuttonkist")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip, Range_value)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "CheckBoxList" Or e_field = "5" Then
                Label_For_Table("<td width='15%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip, Range_value)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            End If
        Catch ex As Exception

        End Try
    End Sub
    Sub Make_Label(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Try
            Dim Lbl As New Label
            Lbl.ID = "Label" & e_id '& MG_Code
            Lbl.Font.Bold = True
            Lbl.Text = e_name + "&nbsp;:&nbsp;"
            Lbl.EnableViewState = True
            Lbl.Width = 150
            Lbl.ToolTip = Tooltip
            Panel1.Controls.Add(Lbl)
        Catch ex As Exception

        End Try
    End Sub
    'Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal Max_Length As Integer)
    '    Dim control As New TextBox
    '    control.ID = "TextBox" & E_Id
    '    control.EnableViewState = True
    '    control.Width = 150
    '    control.ToolTip = Tooltip
    '    control.MaxLength = Max_Length
    '    Dim dds As DataSet = Already_Save(E_Code, main_id, E_Id)
    '    If dds.Tables(0).Rows.Count <> 0 Then
    '        control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
    '    End If
    '    'Dim validator As New RangeValidator
    '    'validator.ID = "RangeValidator" & E_Id
    '    'validator.Type = ValidationDataType.Integer
    '    'validator.MinimumValue = 5
    '    'validator.MaximumValue = 20
    '    'validator.ErrorMessage = "Enter Correct Value"
    '    'validator.EnableViewState = True
    '    'validator.ControlToValidate = "TextBox" & E_Id
    '    'control.Attributes.Add("onchange", "return CheckRequiredField('" + "TextBox" & E_Id + "')")
    '    control.CssClass = "small_f"
    '    Panel1.Controls.Add(control)
    '    'Panel1.Controls.Add(validator)
    '    Label_For_Range_Values(Range_value)
    'End Sub
    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer)
        Dim control As New DropDownList
        control.ID = "DropDOwnList" & E_Id '& MG_Code
        control.Items.Add("")
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code, main_id, E_Id)
        For j As Integer = 0 To dds.Tables(0).Rows.Count - 1
            For i As Integer = 0 To control.Items.Count - 1
                If control.Items(i).Value.Trim = dds.Tables(0).Rows(j).Item(1).ToString.Trim Then
                    Try
                        control.SelectedValue = Convert.ToString(control.Items(i).Value.Trim)
                        'control.Items(i).Selected = True
                        ' control.Items(i).SelectedValue = Convert.ToString(control.Items(i).Value.Trim)
                    Catch ex As Exception

                    End Try
                    'Response.Write("fsfsd fsd sddsfds ")
                End If
            Next
        Next
        control.CssClass = "text_titles_01"
        control.EnableViewState = True
        control.Width = 150
        Panel1.Controls.Add(control)
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_value As String)
        Dim control As New RadioButtonList
        control.ID = "RadioButtonList" & E_Id '& MG_Code      
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            'Response.Write(ArrayList_Radio.Item(i).ToString & " Imran ")
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.EnableViewState = True
        control.Width = 225
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        control.CssClass = "text_titles_01"
        control.ToolTip = Tooltip
        Panel1.Controls.Add(control)
        'For k As Integer = 0 To control.Items.Count - 1
        '    Response.Write(control.Items(k).ToString & "  Ahmed ")
        'Next
        'Dim dss As DataSet = Already_Save_Element_for_Color()
        For j As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
            If ("RadioButtonList" + Already_Save_Values.Tables(0).Rows(j).Item(9).ToString) = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString Then
                        control.Items(k).Selected = True
                    End If
                Next
            End If
        Next
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_value As String)
        Dim control As New CheckBoxList
        control.ID = "CheckBoxList" & E_Id '& MG_Code
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.Width = 225
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        control.ToolTip = Tooltip
        Panel1.Controls.Add(control)
        control.CssClass = "text_titles_01"
        ' Dim dss As DataSet = Already_Save_Element_for_Color()
        For j As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
            If ("CheckBoxList" + Already_Save_Values.Tables(0).Rows(j).Item(9).ToString) = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value.Trim = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString.Trim Then
                        control.Items(k).Selected = True
                    End If
                Next
            End If
        Next
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Label_For_Table(ByVal Text As String)
        Dim Lbl As New Label
        Lbl.Text = Text '+ "(" + HiddenFieldCategory.Value + ")"
        'Lbl.Width = 75
        Lbl.EnableViewState = True
        Panel1.Controls.Add(Lbl)
    End Sub
    Sub Label_For_Range_Values(ByVal Value As String)
        Dim Lbl As New Label
        If Value <> "" Then
            Lbl.Text = "<td style='text-align:left; '>" & Value & "</td>"
        Else
            Lbl.Text = "<td style='text-align:left; font-size:10px; '  > Range Not Defined</td>"
        End If
        Lbl.Width = 50
        Lbl.EnableViewState = True
        Panel1.Controls.Add(Lbl)
    End Sub

    Protected Sub DataListtemplate_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListtemplate.SelectedIndexChanged
        ' ''Panel1.Controls.Clear()
        '' ''HiddenField2.Value = DataListtemplate.SelectedValue
        '' ''Label_For_Table("<table><br><td>")
        ' ''Dim Dss As DataSet = Already_Save_Element_for_Color()
        '' ''For i As Integer = 0 To DataListMainGroup.Items.Count - 1
        '' ''    Dim Hid_ID As HiddenField = DataListMainGroup.Items(i).FindControl("HiddenField1")
        ' ''Phy_Elements(Request.QueryString("TestMainGroup").ToString, DataListtemplate.SelectedValue, Dss)
        '' ''Next
        ' ''TextBox_Description.Visible = True
        ' ''Label_Description.Visible = True
        '' ''HiddenField3.Value = 0
        '' ''Label_For_Table("</td></br></table>")
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub
    Function Return_MG_Name(ByVal MG_Code As Integer) As String
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TGName from TestGroup where TGID = @MG_Code", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
        con.Open()
        Return mycommand.ExecuteScalar()
        con.Close()
    End Function
    'Sub Insert_Values(ByVal value As String, ByVal E_ID As String, ByVal Counter As Integer)
    '    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    '    Dim con As SqlConnection = New SqlConnection(a)
    '    Dim mycommand As New System.Data.SqlClient.SqlCommand("Path_Insert_TestResult", con)
    '    mycommand.CommandType = Data.CommandType.StoredProcedure
    '    mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
    '    mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
    '    mycommand.Parameters.AddWithValue("@Exam_Result", value)
    '    mycommand.Parameters.AddWithValue("@E_ID", E_ID)
    '    con.Open()
    '    mycommand.ExecuteNonQuery()
    '    con.Close()
    'End Sub
    Sub InsertMain(ByVal Max_Main_Id As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim procedurename As String = "Path_PatientResult_Main"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            mycommand.Parameters.AddWithValue("@trDate", Date.Now)
            mycommand.Parameters.AddWithValue("@DeptId", Session("Dept_ID"))
            mycommand.Parameters.AddWithValue("@SubDeptId", Session("SubDeptID"))
            mycommand.Parameters.AddWithValue("@Main_ID", Max_Main_Id)
            mycommand.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value)
            mycommand.Parameters.AddWithValue("@Description", TextBox_Description.Text)
            mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_ID"))
            mycommand.Parameters.AddWithValue("@Referred_by", "")
            mycommand.Parameters.AddWithValue("@Refer_By_ID", Session("emp_ID"))
            mycommand.Parameters.Add("@trmid", SqlDbType.Int)
            mycommand.Parameters("@trmid").Direction = ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            TrmID = mycommand.Parameters("@trmid").Value
            HiddenField_trim_ID.Value = TrmID
            con.Close()
        Catch ex As Exception
            'Response.Write(ex.Message + "Main")
        End Try
    End Sub
    ' '' '' Insert the Each test Entry in the database 
    ' '' '' the textboxes that have no value that value is not stored in the database 
    Sub InsertTest(ByVal value As String, ByVal E_ID As String, ByVal Counter As Integer)
        'Response.Write("insert test s")
        'Dim abc As Integer
        'For abc = 0 To arrValues.Count - 1
        Try
            '    If arraylisttest(abc) = "" Then
            'Continue For
            'End If
            ' Response.Write("Value " & value & "<br /> " & " E_ID " & E_ID & "<br />" & " Counter " & Counter & "<br />" & "RRMID" & TrmID)

            Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)

            Dim procedurename As String = "Path_Insert_TestResult"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@TrmID", TrmID)
            'mycommand.Parameters.AddWithValue("@TID", arraylisttestid(abc))
            mycommand.Parameters.AddWithValue("@VAlue", value)
            ' mycommand.Parameters.AddWithValue("@TCID", E_ID)
            'mycommand.Parameters.AddWithValue("@TCID", E_ID)
            mycommand.Parameters.AddWithValue("@TCValue", E_ID.Substring(0, E_ID.LastIndexOf("-")))
            mycommand.Parameters.AddWithValue("@Report", TextBox_Description.Text)

            mycommand.Parameters.AddWithValue("@TB_ID", E_ID.Substring(E_ID.LastIndexOf("-") + 1, (E_ID.Length - (E_ID.LastIndexOf("-") + 1))))
            mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            mycommand.ExecuteNonQuery()

            con.Close()
        Catch ex As Exception

        End Try

        Try
            If DropDownList_TestName.Text <> "All" Then

                Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                Dim procedurename As String = "insert_Test_Booking_Remarks"
                Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
                mycommand.CommandType = Data.CommandType.StoredProcedure
                mycommand.CommandText = procedurename
                mycommand.Parameters.AddWithValue("@TrmID", TrmID)
                mycommand.Parameters.AddWithValue("@Remarks", TextBox_Description.Text)
                mycommand.Parameters.AddWithValue("@TB_ID", DropDownList_TestName.SelectedValue)
                con.Open()
                mycommand.ExecuteNonQuery()
                con.Close()
            End If


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    ' '' '' Insert the doctor record that are marked 
    '' ''Sub InsertDoctorRecord()
    '' ''    Try
    '' ''        Dim b As Integer
    '' ''        Dim abc As String = ""
    '' ''        Dim array(CheckBoxListDoctorList.Items.Count - 1) As String
    '' ''        For b = 0 To CheckBoxListDoctorList.Items.Count - 1
    '' ''            If CheckBoxListDoctorList.Items(b).Selected = True Then
    '' ''                array(b) = CheckBoxListDoctorList.Items(b).Value
    '' ''                Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    '' ''                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
    '' ''                Dim mycommand As New System.Data.SqlClient.SqlCommand("Path_Insert_Doctor", con)
    '' ''                mycommand.CommandType = Data.CommandType.StoredProcedure
    '' ''                Dim param As System.Data.SqlClient.SqlParameter
    '' ''                param = mycommand.Parameters.AddWithValue("@trmID", TrmID) 'Session("BMIPayID")
    '' ''                param = mycommand.Parameters.AddWithValue("@DoctorID", CheckBoxListDoctorList.Items(b).Value)
    '' ''                Try
    '' ''                    mycommand.Connection.Open()
    '' ''                    mycommand.ExecuteNonQuery()
    '' ''                    mycommand.Connection.Close()
    '' ''                Catch ex As Exception
    '' ''                    Response.Write(ex.Message)
    '' ''                End Try
    '' ''            End If
    '' ''        Next
    '' ''    Catch ex As Exception
    '' ''        '    Label1.Text = ex.Message
    '' ''    End Try
    '' ''End Sub

    Sub Check_Controls()
        Try
            ' Response.Write(Panel1.Controls.Count)
            For i As Integer = 0 To Panel1.Controls.Count - 1
                If Panel1.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                    Dim RBL As RadioButtonList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    For j As Integer = 0 To RBL.Items.Count - 1
                        If RBL.Items(j).Selected = True Then
                            InsertTest(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                    Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    For j As Integer = 0 To CBL.Items.Count - 1
                        If CBL.Items(j).Selected = True Then
                            InsertTest(CBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                    Dim DDL As DropDownList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    For j As Integer = 0 To DDL.Items.Count - 1
                        If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                            InsertTest(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                    Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    If txt.Text.Trim <> "" Then
                        If txt.ValidationGroup = 4 Then
                            If Check_Value() <> 100 Then
                                Dim SB As New StringBuilder
                                Dim t As Type = Me.GetType
                                SB.Append("<script language='javascript' type='text/javascript'>alert('Enter Correct Value of Differential Leukocyte Count DLC');</script>")
                                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                                    ClientScript.RegisterClientScriptBlock(t, "popup", SB.ToString())
                                    HiddenField_Flag.Value = 1
                                End If
                            Else
                                InsertTest(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                                HiddenField_Flag.Value = 0
                            End If
                        Else
                            InsertTest(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                            HiddenField_Flag.Value = 0
                        End If
                    End If
                End If
            Next
        Catch ex As Exception
            ' Response.Write(ex.Message & "check_control()")
        End Try
    End Sub

    Function Check_Value() As Integer
        Dim total As Double = 0

        For i As Integer = 0 To Panel1.Controls.Count - 1
            If Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                If txt.Text <> "" Then
                    If txt.ValidationGroup = 4 Then
                        total = total + Convert.ToDouble(txt.Text)
                    End If

                End If
            End If
        Next

        Return total
    End Function

    Function Already_Save_Element_for_Color(ByVal Main_Id As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Pathalogy_Already_save_For_Controls", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)

        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Function Already_Save(ByVal E_ID As Integer, ByVal Main_Id As Integer, ByVal Eval As String) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Test_Result_for_Table", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)
        mycommand.Parameters.AddWithValue("@Eval", Eval)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function
    Function InsertSMS(ByVal URL As String, ByVal SMS As String) As Boolean
        Dim con As SqlConnection = New SqlConnection(constr_path)

        Try
            Dim check As Boolean = False
            Dim command As SqlCommand = New SqlCommand("INSERT INTO [dbo].[SentSMS]([FullURL],[SMS])     VALUES  (@URL,@SMS)", con)
            'command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@URL", URL)
            command.Parameters.AddWithValue("@SMS", SMS)

            con.Open()
            command.ExecuteNonQuery()


        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
        Return True
    End Function
    Function Check_Insert(ByVal TB_ID As Integer) As Boolean
        Dim con As SqlConnection = New SqlConnection(constr_path)

        Try
            Dim check As Boolean = False
            Dim command As SqlCommand = New SqlCommand("Count_Total_Test_Result_Add_For_Patient", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@Main_ID", Request.QueryString("Main_Id"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@TB_ID", TB_ID)
            command.Parameters.Add("@Total", SqlDbType.Int)
            command.Parameters("@Total").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()
            Dim total As Integer = 0
            total = command.Parameters("@Total").Value
            If total > 0 Then
                check = True
            End If
            Return check
        Catch ex As Exception
            ' Response.Write(ex.Message)
        Finally
            con.Close()
        End Try

    End Function

    Protected Sub ButtonFinal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonFinal.Click
        Try
            If (lblTestHeading.Text.Length > 0 And Not String.IsNullOrEmpty(lblTestHeading.Text)) Then


                If Check_Insert(HiddenField_TBID.Value) = True Then
                    SqlDataSource_Update_Status.Update()
                    SqlDataSourceUpdate.Update()
                    sdsTestApprovedBy.Update()
                    DataList1.DataBind()
                    TextBox_Description.Text = ""

                    '================== Covid test Code
                    Dim isCovidTest As Boolean = False
                    If HiddenField_TBID.Value = "4089" Or HiddenField_TBID.Value = "4102" Then
                        isCovidTest = True
                    End If
                    If Request.QueryString("status") = "6" And isCovidTest = True Then
                        ' GenerateQRCode()
                    End If
                    '===================================
                    Panel1.Controls.Clear()
                    LinkButton_Show_Report0.Visible = True
                    LinkButton_Show_Report.Visible = False
                    If is_completed() Then
                        ButtonFinal.Visible = False


                    End If


                    Dim fileName As String = String.Empty

                    Dim C_no As String = String.Empty
                    Dim email As String = String.Empty
                    Dim sb As New StringBuilder
                    Dim t As Type = Me.GetType
                    Dim url = getPatientSMSURL(C_no, email, Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"), Request.QueryString("Main_ID"), fileName)
                    Dim urlPath = savefilePath(fileName)
                    Try
                        If Not String.IsNullOrEmpty(C_no) And C_no <> "92" Then
                            Dim finalurl As String = "http://opencodes.pk/api/medver.php/sendsms/url?id=cd1186aklisb&pass=raazi126&mask=AKLISB&to=" + C_no + "&lang=English&msg=" + url.ToString() + "&type=xml"
                            'Dim finalurl As String = "https://bsms.telecard.com.pk/SMSportal/Customer/apikey.aspx?apikey=5ddfc590d97f41b1b27999650b567b91&msg=" + url.ToString() + "&mobileno=" + C_no + ""
                            ' Dim finalurl As String = "http://app.smsportal.pk/app/smsapi/index.php?key=5d35cdbddd751&type=text&title=&senderid=Raazi Hosp&msg=" + url.ToString() + "&contacts=" + C_no + ""

                            InsertSMS(finalurl, url)
                            'email = "azubair458@gmail.com"
                            Dim EmailID As String = email
                            Dim msg As String = url.ToString()
                            If Not String.IsNullOrEmpty(EmailID) Or EmailID <> "" Then
                                Send_Email(EmailID, msg)
                            End If

                            '  SendMailMessage()
                            'iframe_message.Src = finalurl 
                            'iframe_print.Src = urlPath
                            iframe_message.Attributes.Add("Src", finalurl)
                            iframe_print.Attributes.Add("Src", urlPath)
                            'newTabs(Me, finalurl, "0")
                            'newTabs(Me, urlPath, "1")

                            'ScriptManager.RegisterStartupScript(Me, [GetType](), "open", "openWin('" + finalurl + "');", True)
                            'ScriptManager.RegisterStartupScript(Me, [GetType](), "open", "openWin('" + urlPath + "');", True)
                        End If
                        'create the mail message

                    Catch ex As Exception
                        Response.Write(ex.Message)
                    End Try

                Else
                    Dim Sb As New StringBuilder
                    Sb.Append("<script language='javascript' type='text/javascript'>alert('Enter the Test Result First');</script>")
                    Dim t As Type = Me.GetType
                    If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                        ClientScript.RegisterClientScriptBlock(t, "popup", Sb.ToString())
                    End If
                End If
            Else
                Dim Sb As New StringBuilder
                Sb.Append("<script language='javascript' type='text/javascript'>alert('Enter the Test Result First');</script>")
                Dim t As Type = Me.GetType
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", Sb.ToString())
                End If
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Private Sub Send_Email(ByVal emailAddress As String, ByVal msg As String)


        Try
            Dim conStr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
            Dim conEmail As SqlConnection = New System.Data.SqlClient.SqlConnection(conStr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Isnull(P.Prefix,'') as Prefix, Isnull(P.PFName,'') as PFName, Isnull(P.PMName,'') as PMName, Isnull(P.PLName,'') as PLName, '92'+right(REPLACE(p.MobilePhone,'-',''),10) as MobilePhone, p.email_address, S.Sample_No,S.Report_name FROM Path_Result_Delivery AS M INNER JOIN Test_Booking_Services AS S ON M.Main_ID = S.Main_ID INNER JOIN Patient AS P ON M.Reg_no = P.RegNo where M.Reg_no = @Regno and M.Yearly_No = @YearlyNo and M.Main_ID = @MainId", conEmail)
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo"))
            mycommand.Parameters.AddWithValue("@MainId", Request.QueryString("Main_ID"))


            Dim emailSender As String = ConfigurationManager.AppSettings("username").ToString()
            ' Dim emailSender As String = "azubair458@gmail.com"
            'Dim emailSenderPassword As String = "inamulhasan1"
            Dim emailSenderPassword As String = ConfigurationManager.AppSettings("password").ToString()
            Dim emailSenderHost As String = ConfigurationManager.AppSettings("smtp").ToString()
            Dim emailSenderPort As Integer = Convert.ToInt16(ConfigurationManager.AppSettings("portnumber"))
            Dim emailIsSSL As Boolean = Convert.ToBoolean(ConfigurationManager.AppSettings("IsSSL"))
            Dim mail As MailMessage = New MailMessage()
            Dim SmtpServer As SmtpClient = New SmtpClient("smtp.gmail.com")
            mail.From = New MailAddress(emailSender)
            mail.To.Add(emailAddress)


            conEmail.Open()
            Dim reader As SqlDataReader = mycommand.ExecuteReader()
            While reader.Read
                'HfEmailAddress.Value = reader("email_Address").ToString()
                'HfReportAddress.Value = reader("Report_name").ToString()
                'Dim CreateName As String = HfReportAddress.Value
                Dim subject As String = "Please find Lab Report"
                mail.Subject = subject
                mail.Body = msg
                ' mail.Attachments.Add(New Attachment("E:\HMIS (02-07-19)\App\Pathology\Patientlabreports\"))
                SmtpServer.Port = 587
                SmtpServer.UseDefaultCredentials = False
                SmtpServer.Credentials = New NetworkCredential(emailSender, emailSenderPassword)
                SmtpServer.EnableSsl = True

            End While

            SmtpServer.Send(mail)
            conEmail.Close()


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try



    End Sub

    Function Patient_Calculate_Test() As Boolean
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("PT_Show_All_Test_Done", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.Add("@Value", SqlDbType.Bit)
        mycommand.Parameters("@Value").Direction = ParameterDirection.Output
        con.Open()
        mycommand.ExecuteNonQuery()
        Return mycommand.Parameters("@Value").Value
        con.Close()
    End Function


    'Protected Sub LinkButton_Show_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Show_Report.Click
    '    Dim sb As New StringBuilder
    '    Dim t As Type = Me.GetType
    '    Dim url As String = "Patient_Result_Report.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&TGID=" + HiddenField_MS_TGID.Value + "&Main_ID=" + Request.QueryString("Main_ID") + "&Sample_No=" + Request.QueryString("Sample_No") + "&Status=" + Request.QueryString("Status")
    '    sb.Append("<script language='javascript' type='text/javascript'>window.open('" + url + "');</script>")
    '    If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
    '        ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
    '    End If
    '    ' Response.Redirect("Patient_Result_Report.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&TGID=" + HiddenField_MS_TGID.Value + "&Main_ID=" + Request.QueryString("Main_ID") + "&Sample_No=" + Request.QueryString("Sample_No") + "&Status=" + Request.QueryString("Status"))
    'End Sub


    Sub Phy_Elements_TB_ID(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer, ByVal TB_ID As Integer)

        Try


            Dim path_admin As New Pathology
            Dim path_admin_table As New PathologyTableAdapters.pro_Test_RangeValuesTableAdapter
            path_admin_table.Fill(path_admin.Tables("pro_Test_RangeValues"), Session("RegistrationNo"), HiddenField_MS_TGID.Value)

            Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Pathology_select_TestforReport_new_TB_ID", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@TGID", MG_Code)
            mycommand.Parameters.AddWithValue("@MS_TGID", HiddenField_MS_TGID.Value) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@template_id", template_id)
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@Main_ID", main_id)
            mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
            mycommand.Parameters.AddWithValue("@Status", Request.QueryString("Status"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            If ds.Tables("abc").Rows.Count > 0 And TextBox_Description.Text = "" And HiddenField_Description.Value <> "" Then
                TextBox_Description.Text = ds.Tables("abc").Rows(0).Item("Report")
                HiddenField_Description.Value = TextBox_Description.Text
            End If
            'Try
            '    For count As Integer = 0 To ds.Tables("abc").Rows.Count - 1
            '        For count_sub As Integer = 0 To path_admin.Tables("pro_Test_RangeValues").Rows.Count - 1

            '            If ds.Tables("abc").Rows(count).Item("TCID") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("TCId") Then
            '                ds.Tables("abc").Rows(count).Item("TC_Range_Unit") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("Range Values")
            '            End If
            '        Next

            '    Next
            'Catch ex As Exception

            'End Try


            Dim j As Integer = 0
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Label_For_Table("<table id='Table_Phy_Exam' border='0' width ='100%' class='Grid_dynamic'  ")
                    Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                ElseIf i <> 0 Then
                    If ds.Tables(0).Rows(i - 1).Item(7).ToString <> ds.Tables(0).Rows(i).Item(7).ToString Then
                        Label_For_Table("</table>")
                        Label_For_Table("<table id='Table_Phy_Exam' border='0' width='100%' class='Grid_dynamic'>")
                        Label_For_Table("<tr bgcolor='#ffcc66' font-size: 13pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                        j = 0

                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                        j = 1
                        Continue For
                    Else
                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                    End If
                End If
                j = j + 1
            Next
            Label_For_Table("</table>")
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Button1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If DropDownList_machine.SelectedValue = "1" Then
            Sysmax()
        ElseIf DropDownList_machine.SelectedValue = "2" Then
            cobas311()
        ElseIf DropDownList_machine.SelectedValue = "3" Then
            cobas411()
        ElseIf DropDownList_machine.SelectedValue = "4" Then
            cobas121()
        ElseIf DropDownList_machine.SelectedValue = "5" Then
            UriSys()
        End If
        upload_result()

    End Sub
    Sub UriSys()
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT [Pt_Message_Id] ,[Sample_No] ,[Received_Message] ,[Received_Message],[Status_Id] ,[Machine_id] FROM [PT_TestMessages] where Machine_id=5 and  Status_Id=1  and [Sample_No]=" + Request.QueryString("Main_ID"), con)
        mycommand.CommandType = Data.CommandType.Text
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Dim x, z As Integer

        For z = 0 To ds.Tables(0).Rows.Count - 1
            Dim strMessage As String = ds.Tables(0).Rows(z).Item(3).ToString
            Dim str As String = ""
            '==================================================
            Dim mycommand2 As New System.Data.SqlClient.SqlCommand("SELECT [Lab_M_Id] ,[Component_Id] ,[Machine_Id] ,[start_index],[End_index] ,[Machine_Comp_Name],result_conversion FROM [Lab_Machine_Tests] where machine_id=5 ", con)
            mycommand2.CommandType = Data.CommandType.Text
            Dim da_Sysmax As New SqlDataAdapter
            Dim ds_Sysmax As New DataSet
            mycommand2.ExecuteNonQuery()
            da_Sysmax.SelectCommand = mycommand2
            da_Sysmax.Fill(ds_Sysmax)
            '===============================================
            Dim i, m As Integer
            Dim result As String
            For i = 0 To ds_Sysmax.Tables(0).Rows.Count - 1
                If strMessage.Contains(ds_Sysmax.Tables(0).Rows(i).Item("Machine_Comp_Name")) = True Then
                    m = InStr(strMessage, ds_Sysmax.Tables(0).Rows(i).Item("Machine_Comp_Name"), CompareMethod.Text)
                    result = strMessage.Substring(m + 3, 6)
                    If result <> "" Then
                        HiddenField_Component_Id.Value = ds_Sysmax.Tables(0).Rows(i).Item("Component_Id")
                        result = Replace(result, "neg", "Negative")
                        result = Replace(result, "norm", "Normal")
                        HiddenField_Component_Value.Value = result
                        HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item("Sample_No").ToString
                        SqlDataSource_MachineResults.Insert()
                    End If
                End If


            Next
            SqlDataSource_machine_Status.Update()
        Next
    End Sub

    Sub cobas121()
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT [Pt_Message_Id] ,[Sample_No] ,[Sent_Message] ,[Received_Message],[Status_Id] ,[Machine_id] FROM [PT_TestMessages] where machine_id=4 and Status_Id=1 and not ([Sample_No] is null) and [Sample_No]=" + Request.QueryString("Main_ID"), con)
        mycommand.CommandType = Data.CommandType.Text
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Dim x, y, z, Component_Id As Integer
        Component_Id = 0
        For z = 0 To ds.Tables(0).Rows.Count - 1
            Dim strMessage As String = ds.Tables(0).Rows(z).Item(3).ToString
            Dim strMessage2 As String = ds.Tables(0).Rows(z).Item(3).ToString

            Dim str As String = ""
            Dim strCode As String = ""
            For i As Integer = 1 To 120
                str = "R|" + i.ToString + "|"
                x = InStr(strMessage, str, CompareMethod.Text)
                If x <> 0 Then
                    strMessage2 = strMessage.Substring(x + 5, strMessage.Length - (x + 5))
                    y = InStr(strMessage2, "|", CompareMethod.Text)
                    strCode = strMessage.Substring(x + 5, y - 1)
                    x = x + y + 5
                    y = InStrRev(strCode, "^")
                    strCode = strCode.Substring(y, strCode.Length - y)

                    str = strMessage.Substring(x, 10)
                    y = InStr(str, "|", CompareMethod.Text)
                    str = Left(str, y - 1)
                    'strCode = strCode.Replace("^", "")
                    'x = InStr(str, "|", CompareMethod.Text)
                    'str = str.Substring(x)
                    'x = InStr(str, "|", CompareMethod.Text)
                    'str = str.Substring(0, x - 1)
                    '==================================
                    HiddenField_Component_Id.Value = ComponentId(CInt(strCode), "", 4)
                    If HiddenField_Component_Id.Value <> 0 Then
                        HiddenField_Component_Value.Value = str
                        HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item(1).ToString
                        SqlDataSource_MachineResults.Insert()
                    End If

                    '=====================================
                    y = 0
                End If
            Next
            SqlDataSource_machine_Status.Update()
        Next
    End Sub
    Sub cobas411()
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT [Pt_Message_Id] ,[Sample_No] ,[Sent_Message] ,[Received_Message],[Status_Id] ,[Machine_id] FROM [PT_TestMessages] where machine_id=3 and Status_Id=1 and not ([Sample_No] is null) and [Sample_No]=" + Request.QueryString("Main_ID"), con)
        mycommand.CommandType = Data.CommandType.Text
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Dim x, y, z, Component_Id As Integer
        Component_Id = 0
        For z = 0 To ds.Tables(0).Rows.Count - 1
            Dim strMessage As String = ds.Tables(0).Rows(z).Item(3).ToString
            Dim str As String = ""
            Dim strCode As String = ""
            For i As Integer = 1 To 120
                str = "R|" + i.ToString + "|"
                x = InStr(strMessage, str, CompareMethod.Text)
                If x <> 0 Then
                    str = strMessage.Substring(x + 4, 15)
                    y = InStr(str, "/", CompareMethod.Text)
                    strCode = str.Substring(0, y - 1)

                    strCode = strCode.Replace("^", "")


                    x = InStr(str, "|", CompareMethod.Text)
                    str = str.Substring(x)
                    x = InStr(str, "|", CompareMethod.Text)
                    str = str.Substring(0, x - 1)
                    ' Response.Write(str + "   <br>     ")

                    '=======================================
                    '==================================

                    HiddenField_Component_Id.Value = ComponentId(CInt(strCode), "", 2)
                    If HiddenField_Component_Id.Value <> 0 Then
                        HiddenField_Component_Value.Value = str
                        HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item(1).ToString
                        SqlDataSource_MachineResults.Insert()
                    End If

                    '=====================================
                    y = 0
                End If
            Next
            SqlDataSource_machine_Status.Update()
        Next
    End Sub
    Sub cobas311()
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT [Pt_Message_Id] ,[Sample_No] ,[Sent_Message] ,[Received_Message],[Status_Id] ,[Machine_id] FROM [PT_TestMessages] where machine_id=2 and Status_Id=1 and not ([Sample_No] is null) and [Sample_No]=" + Request.QueryString("Main_ID"), con)
        mycommand.CommandType = Data.CommandType.Text
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Dim x, y, z, Component_Id As Integer
        Component_Id = 0
        For z = 0 To ds.Tables(0).Rows.Count - 1
            Dim strMessage As String = ds.Tables(0).Rows(z).Item(3).ToString
            Dim str As String = ""
            Dim strCode As String = ""
            For i As Integer = 1 To 120
                str = "R|" + i.ToString + "|"
                x = InStr(strMessage, str, CompareMethod.Text)
                If x <> 0 Then
                    str = strMessage.Substring(x + 4, 15)
                    y = InStr(str, "/", CompareMethod.Text)
                    strCode = str.Substring(0, y - 1)

                    strCode = strCode.Replace("^", "")


                    x = InStr(str, "|", CompareMethod.Text)
                    str = str.Substring(x)
                    x = InStr(str, "|", CompareMethod.Text)
                    str = str.Substring(0, x - 1)
                    ' Response.Write(str + "   <br>     ")

                    '=======================================
                    '==================================

                    HiddenField_Component_Id.Value = ComponentId(CInt(strCode), "", 2)
                    If HiddenField_Component_Id.Value <> 0 Then
                        HiddenField_Component_Value.Value = str
                        HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item(1).ToString
                        SqlDataSource_MachineResults.Insert()
                    End If

                    '=====================================
                    y = 0
                End If
            Next
            SqlDataSource_machine_Status.Update()
        Next
    End Sub
    Sub upload_result()
        Dim count As Integer = 0
        Dim val As Long

        '''''''''''''''''''''''''''''''''''''''''''''''''''   get Component_Id

        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = constr_path
        command = connection.CreateCommand
        command.CommandText = " SELECT     TestComponent.TC_Value, PT_Machine_Results.Sample_No, PT_Machine_Results.Component_Value, PT_Machine_Results.Status_Id, PT_Machine_Results.Result_Datetime, TestComponent.TGID, PT_Machine_Results.Component_Id, Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No FROM         PT_Machine_Results INNER JOIN TestComponent ON PT_Machine_Results.Component_Id = TestComponent.TCID INNER JOIN Path_Result_Delivery ON PT_Machine_Results.Sample_No = Path_Result_Delivery.Main_ID WHERE     (PT_Machine_Results.Status_Id = 0) and PT_Machine_Results.Sample_No= " + Request.QueryString("Main_ID") + "Order by PT_Machine_Results.Sample_No "
        'PT_Machine_Results.Sample_No=" & Request.QueryString("Main_ID").ToString & " and TestComponent.TGID=" & HiddenField_TGID.Value.ToString & " and
        connection.Open()
        reader = command.ExecuteReader
        While reader.Read
            If count = 0 Then
                ''''''''''''''''''''''''''''''''' insert main '''''''''''''''''''''''''''''''''''''''''''''''''''
                Dim connection1 As New SqlConnection
                Dim command1 As New System.Data.SqlClient.SqlCommand("Path_PatientResult_Main", connection1)
                connection1.ConnectionString = constr_path
                command1.CommandType = Data.CommandType.StoredProcedure
                command1.CommandText = "Path_PatientResult_Main"
                command1.Parameters.AddWithValue("@YearlyNo", reader.Item(8))
                command1.Parameters.AddWithValue("@RegNo", reader.Item(7))
                command1.Parameters.AddWithValue("@trDate", Date.Now)
                command1.Parameters.AddWithValue("@DeptId", Session("Dept_ID"))
                command1.Parameters.AddWithValue("@SubDeptId", Session("SubDeptID"))
                command1.Parameters.AddWithValue("@Main_ID", reader.Item(1))
                command1.Parameters.AddWithValue("@TGID", reader.Item(5)) 'Request.QueryString("TestMainGroup").ToString)
                'command1.Parameters.AddWithValue("@Referred_by", TextBox_Refered_By.Text)
                command1.Parameters.AddWithValue("@emp_ID", Session("emp_ID"))
                'command1.Parameters.AddWithValue("@Refrence_No", TextBox_Refrence_No.Text)
                command1.Parameters.Add("@trmid", SqlDbType.Int)
                command1.Parameters("@trmid").Direction = ParameterDirection.Output
                connection1.Open()
                command1.ExecuteNonQuery()
                val = command1.Parameters("@trmid").Value
                connection1.Close()
                connection1.Dispose()
                count = 1
            End If
            '''''''''''''''''''''''''' insert data in sub ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''' 
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr_path)
            Dim procedurename As String = "Path_Insert_TestResult"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@TrmID", val)
            mycommand.Parameters.AddWithValue("@VAlue", reader.Item(2))
            mycommand.Parameters.AddWithValue("@TCValue", reader.Item(0))
            mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            mycommand.ExecuteNonQuery()
            con.Close()
            con.Dispose()
            Dim con_status As SqlConnection = New System.Data.SqlClient.SqlConnection(constr_path)
            Dim query As String = "Update PT_Machine_Results set Status_Id=1 where Component_Id=" & reader.Item(6) & " and Sample_No=" & reader.Item(1)
            Dim mycommand_status As New System.Data.SqlClient.SqlCommand(query, con_status)
            mycommand_status.CommandText = query
            con_status.Open()
            mycommand_status.ExecuteNonQuery()
            con_status.Close()
            con_status.Dispose()
        End While
        connection.Close()
        connection.Dispose()
        'GridView2.DataBind()
    End Sub
    Sub Sysmax()
        'Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        'Dim con As SqlConnection = New SqlConnection(a)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand(" SELECT [Pt_Message_Id] ,[Sample_No] ,[Sent_Message] ,[Received_Message],[Status_Id] ,[Machine_id] FROM [PT_TestMessages] where Machine_id=1 and  Status_Id=1 and Sample_No='" + Request.QueryString("Sample_No") + "'", con)
        'mycommand.CommandType = Data.CommandType.Text
        'con.Open()
        'Dim da As New SqlDataAdapter
        'Dim ds As New DataSet
        'mycommand.ExecuteNonQuery()
        'da.SelectCommand = mycommand
        'da.Fill(ds)
        'Dim x, z As Integer

        'For z = 0 To ds.Tables(0).Rows.Count - 1
        '    Dim strMessage As String = ds.Tables(0).Rows(z).Item(3).ToString
        '    Dim str As String = ""
        '    strMessage = Replace(strMessage, "*", "0")

        '    '==================================================
        '    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("SELECT [Lab_M_Id] ,[Component_Id] ,[Machine_Id] ,[start_index],[End_index] ,[Machine_Comp_Name],Comp_DataType,Float_Digit,result_conversion FROM [Lab_Machine_Tests] where machine_id=1 ", con)
        '    mycommand2.CommandType = Data.CommandType.Text
        '    Dim da_Sysmax As New SqlDataAdapter
        '    Dim ds_Sysmax As New DataSet
        '    mycommand2.ExecuteNonQuery()
        '    da_Sysmax.SelectCommand = mycommand2
        '    da_Sysmax.Fill(ds_Sysmax)
        '    Dim comassep As New Coma
        '    '===============================================
        '    Dim i As Integer
        '    Dim result As Double
        '    For i = 0 To ds_Sysmax.Tables(0).Rows.Count - 1
        '        str = strMessage.Substring(ds_Sysmax.Tables(0).Rows(i).Item("start_index"), ds_Sysmax.Tables(0).Rows(i).Item("End_index"))
        '        ' Response.Write("<br>")
        '        ' Response.Write(str)
        '        result = Convert.ToInt16(str) / ds_Sysmax.Tables(0).Rows(i).Item("result_conversion")


        '        If str <> "" Then
        '            HiddenField_Component_Id.Value = ComponentId(0, ds_Sysmax.Tables(0).Rows(i).Item("Machine_Comp_Name"), 1, Request.QueryString("Main_ID"))

        '            HiddenField_Component_Id.Value = ds_Sysmax.Tables(0).Rows(i).Item("Component_Id")
        '            If ds_Sysmax.Tables(0).Rows(i).Item("Comp_DataType") = "int" Then
        '                HiddenField_Component_Value.Value = comassep.place_Coma(CInt(Math.Floor(result)))
        '            Else
        '                HiddenField_Component_Value.Value = Math.Round(result, 1)

        '            End If
        '            HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item("Sample_No").ToString
        '            SqlDataSource_MachineResults.Insert()
        '        End If
        '    Next

        '    str = strMessage.Substring(74, 5)
        '    result = Convert.ToInt16(str) / 100
        '    If result < 10 Then
        '        Dim Result30 As Double = (result * 30) / 100
        '        Dim Result70 As Double = (result * 70) / 100

        '        If str <> "" Then
        '            HiddenField_Component_Id.Value = 24
        '            HiddenField_Component_Value.Value = CInt(Math.Round(Result70, 1))
        '            HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item("Sample_No").ToString
        '            SqlDataSource_MachineResults.Insert()
        '        End If
        '        If str <> "" Then
        '            HiddenField_Component_Id.Value = 25
        '            HiddenField_Component_Value.Value = CInt(Math.Round(Result30, 1))
        '            HiddenField_SampleNo.Value = ds.Tables(0).Rows(z).Item("Sample_No").ToString
        '            SqlDataSource_MachineResults.Insert()
        '        End If
        '    End If



        '    SqlDataSource_machine_Status.Update()
        'Next
    End Sub

    Function ComponentId(ByVal code As Integer, ByVal strCompName As String, ByVal Machine_Id As Integer) As Integer
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim strCmd As String = ""
        If strCompName = "" Then
            strCmd = "SELECT [Component_Id] FROM [Lab_Machine_Tests] where [Machine_Id] =" & Machine_Id & "  and Machine_Test_Code =" & code & ""
        Else
            strCmd = "SELECT [Component_Id] FROM [Lab_Machine_Tests] where [Machine_Id] =" & Machine_Id & "  and Machine_Comp_Name ='" & strCompName & "'"

        End If
        Dim mycommand As New System.Data.SqlClient.SqlCommand(strCmd, con)
        mycommand.CommandType = Data.CommandType.Text
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        If ds.Tables(0).Rows.Count > 0 Then
            ComponentId = ds.Tables(0).Rows(0).Item(0)
        Else
            ComponentId = 0
        End If

    End Function

    Protected Sub Button_Draw_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Draw.Click
        TextBox_Description.Text = ""
        HiddenField_Page_type.Value = RadioButtonList1.SelectedValue
        If DropDownList_TestName.SelectedItem.Text = "All" Then
            Panel1.Controls.Clear()
            ' Dim hid_main_group As HiddenField
            ' hid_main_group.Value = DropDownList_Test_Group.SelectedItem.Text

            HiddenFieldCategory.Value = DropDownList_Test_Group.SelectedValue
            'Dim hid_pageType As RadioButtonList = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("RadioButtonList1")


            'Response.Write(hid_main_group.Value & "fdsf")
            'Response.End()

            ' Dim hid_TGID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField6")
            'Dim hid_Main_Id As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField8")
            'Dim hid_TBID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenFieldTBID")
            HiddenField_TGID.Value = DropDownList_Test_Group.SelectedValue
            HiddenFieldMainID.Value = Request.QueryString("Main_ID")
            HiddenField_TBID.Value = DropDownList_TestName.SelectedValue

            HiddenField3.Value = DataListMainGroup.SelectedValue

            Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
            HiddenField_MS_TGID.Value = DropDownList_Test_Group.SelectedValue

            Phy_Elements(HiddenField_MS_TGID.Value, 38, dss, HiddenFieldMainID.Value)
            TextBox_Description.Visible = True
            Label_Description.Visible = True

        Else

            Panel1.Controls.Clear()

            HiddenField_TGID.Value = DropDownList_Test_Group.SelectedValue
            'HiddenFieldCategory.Value = hid_TGID.V
            HiddenFieldMainID.Value = Request.QueryString("Main_ID")
            HiddenField_TBID.Value = DropDownList_TestName.SelectedValue

            HiddenField3.Value = DataListMainGroup.SelectedValue

            Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
            HiddenField_MS_TGID.Value = DropDownList_Test_Group.SelectedValue

            Phy_Elements_TB_ID(HiddenField_MS_TGID.Value, 38, dss, HiddenFieldMainID.Value, HiddenField_TBID.Value)
            TextBox_Description.Visible = True
            Label_Description.Visible = True

        End If
        ListBox_Template.DataBind()
    End Sub

    Protected Sub Button_update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_update.Click
        Try
            If DropDownList_TestName.SelectedItem.Text = "All" Then

            Else
                HiddenField_Edit_Status.Value = DropDownList_Status.SelectedValue
                SqlDataSource_Status.Update()
                If DropDownList_Status.SelectedValue = "12" Then
                    SqlDataSource_Booking.Insert()
                    SqlDataSource_Booking.Update()
                    DataList1.DataBind()
                    TextBox_Description.Text = ""
                    Panel1.Controls.Clear()

                End If
                DataList1.DataBind()

            End If


        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub DropDownList_TestName_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_TestName.DataBound
        DropDownList_TestName.Items.Insert(0, "All")
        DropDownList_TestName.Items(0).Value = "0"
    End Sub

    Protected Sub Button_Sesch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Sesch.Click

        Search(TextBox_Mr_No.Text, TextBox_Visit_No.Text, TextBox_Sample_No.Text)

    End Sub
    Protected Sub Search(ByVal Mr_No As String, ByVal Visit_No As String, ByVal Sample_No As String)
        Dim where As String = "Where  (Test_Booking_Services.Status = 1) "
        Dim query As String = " "
        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        command = connection.CreateCommand

        query = "SELECT     Path_Result_Delivery.Reg_no, Path_Result_Delivery.Yearly_No, Path_Result_Delivery.Main_ID, Test_Booking_Services.TB_ID, Test_Booking_Services.Status, Test_Booking_Services.Sample_No FROM         Path_Result_Delivery INNER JOIN Test_Booking_Services ON Path_Result_Delivery.Main_ID = Test_Booking_Services.Main_ID   "

        If Mr_No = "" Then
        Else
            where = where + "And (Path_Result_Delivery.Reg_no ='" + ENC.Encrypt_Main(Mr_No, True).ToString + "') "
        End If

        If Visit_No = "" Then
        Else
            where = where + "  AND (Path_Result_Delivery.Yearly_No ='" + Visit_No.ToString + "') "
        End If

        If Sample_No = "" Then

        Else

            where = where + "And Test_Booking_Services.Sample_No='" + Sample_No.ToString + "'"

        End If

        query = query + where
        command.CommandText = query


        connection.Open()
        reader = command.ExecuteReader
        If reader.Read Then

            Response.Redirect("pt_select_test.aspx?Reg_No=" + reader.Item(0).ToString + "&YearlyNo=" + reader.Item(1).ToString + "&Main_ID=" + reader.Item(2).ToString + "&sample_no=" + reader.Item(5).ToString)

        End If

        connection.Close()

    End Sub




    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged
        TextBox_Description.Text = ""
        Dim index As Integer

        index = DataList1.SelectedIndex

        For count As Integer = 0 To DataList1.Items.Count - 1
            Dim lbtn_TB_ID As LinkButton = DataList1.Items(count).FindControl("LinkButton_TB_ID")

            If index <> DataList1.Items(count).ItemIndex Then
                lbtn_TB_ID.ForeColor = Drawing.Color.Blue
            Else
                lblTestHeading.Text = lbtn_TB_ID.Text
                lbtn_TB_ID.ForeColor = Drawing.Color.Red
            End If
        Next

        Load_Test_Panel(index)
        'LinkButton_Show_Report0.Visible = True
        LinkButton_Show_Report.Visible = True
        ' btn_DSC.Visible = True
        'Panel1.Controls.Clear()

        'HiddenField_Page_type.Value = RadioButtonList1.SelectedValue

        'Dim hid_main_group As HiddenField = DataList1.Items(index).FindControl("HiddenField7")
        'Dim hid_TGID As HiddenField = DataList1.Items(index).FindControl("HiddenField6")
        'Dim hid_Main_Id As HiddenField = DataList1.Items(index).FindControl("HiddenField8")
        'DropDownList_Test_Group.SelectedValue = hid_TGID.Value


        'Dim hid_TBID As HiddenField = DataList1.Items(index).FindControl("HiddenFieldTBID")
        'HiddenField_TGID.Value = hid_TGID.Value
        'HiddenFieldCategory.Value = hid_TGID.Value
        'HiddenFieldMainID.Value = hid_Main_Id.Value
        'HiddenField_TBID.Value = hid_TBID.Value
        'DropDownList_TestName.SelectedValue = HiddenField_TBID.Value
        'HiddenField3.Value = DataListMainGroup.SelectedValue

        'Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
        'HiddenField_MS_TGID.Value = hid_TGID.Value

        'Phy_Elements_TB_ID(HiddenField_MS_TGID.Value, 38, dss, HiddenFieldMainID.Value, HiddenField_TBID.Value)
        'TextBox_Description.Visible = True
        'Label_Description.Visible = True
        'ListBox_Template.DataBind()
    End Sub

    Protected Sub LinkButton_Track_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Track.Click
        Panel_Track.Visible = True
        GridView_Track.DataBind()
    End Sub

    Protected Sub Button_Track_Close_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Track_Close.Click
        Panel_Track.Visible = False
    End Sub

    Protected Sub Button_Missing_Component_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Missing_Component.Click
        Panel_Missing_Component.Visible = False
    End Sub

    Protected Sub LinkButton_Attach_Image_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Attach_Image.Click
        If DropDownList_TestName.SelectedItem.Text <> "All" Then
            'TGID, Reg_no, Yearly_No, TB_ID
            'PatienttestImage.aspx?TGID={0}&RegNo={1}&YearlyNo={2}&TB_ID={3}

            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript'>")
            sb.Append(" window.open(' PatienttestImage.aspx?TGID=" + DropDownList_Test_Group.SelectedValue + "&RegNo=" + Request.QueryString("Reg_No") + "&YearlyNo=" + Request.QueryString("YearlyNo") + "&TB_ID=" + DropDownList_TestName.SelectedValue + "', '_Blank')</script>")
            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If
        End If
    End Sub

    Protected Sub ListBox_Template_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox_Template.SelectedIndexChanged
        TextBox_Description.Text = TextBox_Description.Text + ListBox_Template.Text
    End Sub

    Protected Sub LinkButton_Show_Report0_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Show_Report0.Click
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType
        Dim url As String = "Patient_Result_Report.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&TGID=" + HiddenField_MS_TGID.Value + "&Main_ID=" + Request.QueryString("Main_ID") + "&Sample_No=" + Request.QueryString("Sample_No") + "&Status=10"
        sb.Append("<script language='javascript' type='text/javascript'>window.open('" + url + "');</script>")
        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        End If
        'Response.Redirect("Patient_Result_Report.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&TGID=" + HiddenField_MS_TGID.Value + "&Main_ID=" + Request.QueryString("Main_ID") + "&Sample_No=" + Request.QueryString("Sample_No") + "&Status=10")

    End Sub

    Protected Sub btn_return_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_return.Click
        Dim url = "~/pathology/Patient_Search.aspx?def=6&TGID=" + DropDownList_Test_Group.SelectedValue

        Response.Redirect(url)

    End Sub

    Protected Sub DropDownList_TestName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_TestName.SelectedIndexChanged
        DataList1.DataBind()

    End Sub

    Protected Sub btn_DSC_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Pnl_Delete_com.Visible = True
        gv_del_component.DataBind()
    End Sub
    Protected Sub Btn_close_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_close.Click
        Pnl_Delete_com.Visible = False
        Load_Test_Panel(DataList1.SelectedIndex)
    End Sub
    Protected Sub Load_Test_Panel(ByVal index As Integer)
        Panel1.Controls.Clear()

        HiddenField_Page_type.Value = RadioButtonList1.SelectedValue

        Dim hid_main_group As HiddenField = DataList1.Items(index).FindControl("HiddenField7")
        Dim hid_TGID As HiddenField = DataList1.Items(index).FindControl("HiddenField6")
        Dim hid_Main_Id As HiddenField = DataList1.Items(index).FindControl("HiddenField8")

        Dim hid_TBID As HiddenField = DataList1.Items(index).FindControl("HiddenFieldTBID")
        DropDownList_Test_Group.SelectedValue = hid_TGID.Value
        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldCategory.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TBID.Value = hid_TBID.Value
        DropDownList_TestName.SelectedValue = HiddenField_TBID.Value
        HiddenField3.Value = DataListMainGroup.SelectedValue

        Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
        HiddenField_MS_TGID.Value = hid_TGID.Value

        Phy_Elements_TB_ID(HiddenField_MS_TGID.Value, 38, dss, HiddenFieldMainID.Value, HiddenField_TBID.Value)
        TextBox_Description.Visible = True
        Label_Description.Visible = True
        ListBox_Template.DataBind()
    End Sub



    Protected Sub btn_DSC_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_DSC.Click
        Pnl_Delete_com.Visible = True
        gv_del_component.DataBind()
    End Sub


    Protected Function is_completed() As Boolean
        Dim result As Boolean = False
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim Statement As String = "select convert(bit,case when abc.complete_test =abc.total_test then 1 else 0 end) from(Select Count(*) total_test,(select COUNT(*) from Test_Booking_Services t where t.Sample_No = ts.Sample_No and t.Status >8) as complete_test from Test_Booking_Services TS where Sample_No='" + Request.QueryString("sample_No").ToString() + "' group by Sample_No)abc "
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Statement, con)
            mycommand.CommandType = Data.CommandType.Text

            con.Open()

            result = mycommand.ExecuteScalar

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


        Return result
    End Function
    Protected Function getPatientSMSURL(ByRef contact_no As String, ByRef email As String, ByVal Reg_no As String, ByVal Yealy_no As String, ByVal Main_ID As String, ByRef fileName As String) As String

        Dim URL As String = String.Empty, File_path As String = String.Empty
        getfileName(fileName, File_path)

        'static string connection1 = ConfigurationManager.ConnectionStrings["STOREConnectionString"].ToString();
        Dim Sampleno As String = Request.QueryString("sample_No")
        Dim constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ToString()
        Dim qry As String = "SELECT     TOP (1) P.RegNo,P.email_address, P.Prefix, Isnull(P.PFName,'') as PFName, Isnull(P.PMName,'') as PMName, Isnull(P.PLName,'') as PLName, '92'+right(REPLACE(p.MobilePhone,'-',''),10) as MobilePhone, S.Sample_No FROM Path_Result_Delivery AS M INNER JOIN Test_Booking_Services AS S ON M.Main_ID = S.Main_ID INNER JOIN Patient AS P ON M.Reg_no = P.RegNo WHERE (P.RegNo = '" + Reg_no + "') AND (M.Yearly_No = " + Yealy_no + ") AND (S.Main_ID = " + Main_ID + ") AND ( S.Sample_No='" + Sampleno + "')"
        'Response.Write(qry)
        Dim con As New SqlConnection(constr)
        Dim command As New SqlCommand(qry, con)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        Dim prefix As String = String.Empty, Fname As String = String.Empty, Mname As String = String.Empty, Con_no As String = String.Empty, Sample_No As String = String.Empty, name As String = String.Empty
        Dim RegistrationNo As String = String.Empty, Lname As String = String.Empty, emailID As String = String.Empty
        If reader.HasRows Then
            Try


                While reader.Read()
                    prefix = reader("Prefix")
                    emailID = reader("email_address")
                    Fname = reader("PFName")
                    Mname = reader("PMName")
                    Lname = reader("PLName")
                    Con_no = reader("MobilePhone")
                    Sample_No = reader("Sample_No")
                    RegistrationNo = reader("RegNo")


                End While
            Catch ex As Exception

            End Try

            name = prefix + " " + ENC.Encrypt_Main(Fname, False)
            If Not String.IsNullOrEmpty(Mname) Then
                name = name + " " + ENC.Encrypt_Main(Mname, False)
            End If
            If Not String.IsNullOrEmpty(Lname) Then
                name = name + " " + ENC.Encrypt_Main(Lname, False)
            End If
            name = name + " ( " + ENC.Encrypt_Main(RegistrationNo, False) + " )"
            Try

                contact_no = Con_no
                email = emailID

            Catch ex As Exception
                'Response.Write(ex.message)

                Return URL

            End Try

        End If
        URL = "(" + name + "), view your report online,click  " + File_path + ".pdf"

        ' URL = "Patient (" + name + ")  , your " + lblTestHeading.Text + " report is ready. Please collect the report from Reception Against Sample No. " + Sample_No + ". Alkhidmat Lab Blood Bank and Thalassemia Center, Lahore. 042-37301356-7, 0300-0771604. To View click " + File_path + ".pdf"
        ' URL = "Dear " + name + "  Kindly Collect Your Report Against Sample No. " + Sample_No + "."
        Dim urls As String = Replace(URL, "&", "")
        Return urls
    End Function

    Protected Sub LinkButton_Show_Report_Click1(sender As Object, e As EventArgs)
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType
        Dim url As String = "Patient_Result_Report.aspx?RegNo=" + Session("RegistrationNo") + "&YearlyNo=" + Session("YearlyNo") + "&TGID=" + HiddenField_MS_TGID.Value + "&Main_ID=" + Request.QueryString("Main_ID") + "&Sample_No=" + Request.QueryString("Sample_No") + "&Status=" + Request.QueryString("Status") + "&tb_id=" + HiddenField_TBID.Value
        sb.Append("<script language='javascript' type='text/javascript'>window.open('" + url + "');</script>")
        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        End If
    End Sub

    Private Sub getfileName(ByRef fileName As String, ByRef File_path As String)
        Dim path As String = "http://203.99.181.197/hmis/Pathology/Patientlabreports/", CreateName As String
        CreateName = Request.QueryString("Main_ID") + HiddenField_TBID.Value
        File_path = path + CreateName
        fileName = CreateName

    End Sub

    Private Function savefilePath(ByVal file_name As String) As String

        Dim path As String = String.Empty
        Dim RegNo As String = Request.QueryString("Reg_No"),
            YearlyNo As String = Request.QueryString("YearlyNo"),
            TG_ID As String = HiddenField_TGID.Value,
            Main_ID As String = Request.QueryString("Main_ID"),
            Sample_No As String = Request.QueryString("Sample_No"),
            Status As String = "10",
            Tb_ID As String = HiddenField_TBID.Value

        SaveFiletoDB(Main_ID, Tb_ID, file_name)


        path = "Patient_Result_Report.aspx?RegNo=" + RegNo + "&YearlyNo=" + YearlyNo + "&TGID=" + TG_ID + "&Main_ID=" + Main_ID + "&Sample_No=" + Sample_No + "&Status=" + Status + "&tb_id=" + Tb_ID + "&name=" + file_name

        Return path


    End Function

    Private Sub SaveFiletoDB(Main_ID As String, Tb_ID As String, file_name As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ToString()
        Dim qry As String = "update Test_Booking_Services set Report_name =@Report_name where Main_ID = @Main_ID and TB_ID =@TB_ID;"

        Dim con As New SqlConnection(constr)
        Dim command As New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@Report_name", file_name + ".pdf")
        command.Parameters.AddWithValue("@Main_ID", Main_ID)
        command.Parameters.AddWithValue("@TB_ID", Tb_ID)
        con.Open()
        command.ExecuteNonQuery()
        con.Close()


    End Sub

    Public Sub newTabs(ByVal page As Page, ByVal fullUrl As String, ByVal key As String)
        Dim script As String = "window.open('" + fullUrl + "', '" + key + "', 'status=1,location=1,menubar=1,resizable=1,toolbar=1,scrollbars=1,titlebar=1,Timeout(function () { Me.close() }, 6000)');"
        page.ClientScript.RegisterClientScriptBlock(page.GetType(), key, script, True)

    End Sub

    Private Function getResult(value As String) As String
        Dim result As String = "Negitive", DVal As Decimal
        If Not String.IsNullOrEmpty(value) Then
            DVal = Convert.ToDecimal(value)
            If DVal >= 1 Then
                result = "Positive"
            End If
        End If
        Return result
    End Function

End Class
