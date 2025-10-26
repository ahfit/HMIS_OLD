Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_Select_Test_old
    Inherits System.Web.UI.Page
    Dim TrmID As Integer
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim constr_path As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    'Dim main_id As Integer = 0
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            'If HiddenField_TBID.Value = 4 Then
            'Response.Write(HiddenFieldMainID.Value)
            InsertMain(HiddenFieldMainID.Value)
            Check_Controls()
            Panel1.Controls.Clear()
            If Patient_Calculate_Test() = True Then
                ButtonFinal.Visible = True
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'Response.Redirect("PatientTestReportMain.aspx?YearlyNo=" + Request.QueryString("YearlyNo").ToString + "&RegNo=" + Request.QueryString("RegNo").ToString)
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
        Dim hid_TBID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenFieldTBID")

        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TBID.Value = hid_TBID.Value
        'main_id = HiddenFieldMainID.Value
        'Response.Write(main_id)
        'Response.Write(HiddenFieldMainID.Value)
        'Next
        Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value, HiddenField_TBID.Value)
        HiddenField_MS_TGID.Value = DataListMainGroup.SelectedValue
        Phy_Elements(DataListMainGroup.SelectedValue, 38, dss, HiddenFieldMainID.Value, HiddenField_TBID.Value) '("TestMainGroup"), DataListtemplate.SelectedValue, dss)
        TextBox_Description.Visible = True
        Label_Description.Visible = True
    End Sub
    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer, ByVal TB_ID As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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
            mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            Dim j As Integer = 0
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Label_For_Table("<table id='Table_Phy_Exam' border='1' width ='100%' class='mytbl'  ")
                    Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id, TB_ID)
                ElseIf i <> 0 Then
                    If ds.Tables(0).Rows(i - 1).Item(7).ToString <> ds.Tables(0).Rows(i).Item(7).ToString Then
                        Label_For_Table("</table>")
                        Label_For_Table("<table id='Table_Phy_Exam' border='1' width='100%' class='mytbl'>")
                        Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' style='text-align:left; font-weight:bold;'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                        j = 0
                        ' Check_For_Table_Rows checks the table row and column , and color the altenate row of the table 
                        ' i is the no of element ,j is the no of the element of the main group 
                        ' when main group changed j becomes zero and start once agin from zero 
                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id, TB_ID)
                        j = 1
                        Continue For
                    Else
                        Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id, TB_ID)
                    End If
                End If
                j = j + 1
            Next
            Label_For_Table("</table>")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
            If IsPostBack Then
                Panel1.Controls.Clear()
            End If
            Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            'loginvalidate(Session("emp_id"), Session("dept_id"))
            Label_message.Text = ""
            If Patient_Calculate_Test() = True Then
                ButtonFinal.Visible = True
            End If
            If Page.IsPostBack Then
                Image(Convert.ToInt32(HiddenField_new_TGID.Value))
            End If
            If Page.IsPostBack Then
                'Response.Write(Panel1.Controls.Count)
                'Panel1.Controls.Clear()
                'Response.Write(Panel1.Controls.Count)
                'If Panel1.Controls.Count > 0 Then
                'Panel1.Controls.Clear()
                'End If
                Dim Dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value, HiddenField_TBID.Value)
                Phy_Elements(DataListtemplate.SelectedValue, 38, Dss, HiddenFieldMainID.Value, HiddenField_TBID.Value)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer, ByVal TB_ID As Integer)
        Try
            If MG_Code <> 0 Then
                If j Mod 2 = 1 Then
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    Label_For_Table("</td>")
                ElseIf j Mod 2 <> 1 Then
                    If j Mod 4 = 0 Then
                        Label_For_Table("<tr bgcolor='#f8ffe0'>") '#f8fff7'>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    Else
                        Label_For_Table("</tr><tr>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    End If
                End If
            Else
                If i Mod 2 = 1 Then
                    Label_For_Table("<td class='text_titles_01'>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    Label_For_Table("</td>")
                ElseIf i Mod 2 <> 1 Then
                    If i Mod 4 = 0 Then
                        Label_For_Table("<tr bgcolor='#f8ffe0'>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    Else
                        Label_For_Table("</tr><tr>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id, ds.Tables(0).Rows(i).Item(14), TB_ID)
                    End If
                End If
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_Value As String, ByVal main_id As Integer, ByVal Max_Length As Integer, ByVal TB_ID As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Radiology_ConnStr").ConnectionString
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
                If e_code = CInt(Already_Save_Values.Tables(0).Rows(i).Item(1).ToString) Then
                    Test_Date_Time = Already_Save_Values.Tables(0).Rows(i).Item("Date").ToString & " " & Already_Save_Values.Tables(0).Rows(i).Item("Time").ToString & "<br />"
                    Test_Date_Time = "<span style='text-align:left; color:#CC0000; font-size:9px;'>" & Test_Date_Time & "</span>"
                    Save_Record_Color = "#ffccff"
                End If
            Next
            'End If
            Make_Control(ds1, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, Tooltip, Range_Value, main_id, Test_Date_Time, TB_ID)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal TB_ID As Integer)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        control.Width = 100%
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code, main_id, TB_ID)
        If dds.Tables(0).Rows.Count <> 0 Then
            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        control.Attributes.Add("onchange", "return CheckRequiredField('" + "TextBox" & E_Id + "','" + HiddenField_TBID.Value + "')")
        control.CssClass = "text_titles_01"
        Panel1.Controls.Add(control)
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal Test_Date_Time As String, ByVal TB_ID As Integer)
        Try
            Label_For_Table("<td width ='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
            Make_Label(e_id, e_name, Mg_code, Already_Save_Values, Tooltip)
            Label_For_Table("</td>")
            If e_field = "TextBox" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01' style='text-align:left;'>" & Test_Date_Time)
                Make_TextBox(e_id, Already_Save_Values, E_Code, Tooltip, Range_value, main_id, TB_ID)
                Label_For_Table("</td>")
            ElseIf e_field.ToLower = "html" Then
                Label_For_Table("<td  bgcolor='" & Save_Record_Color & "' class='text_titles_01' style='text-align:left;'>" & Test_Date_Time)
                Draw_web(e_id, Already_Save_Values, E_Code, Tooltip, Range_value, main_id, TB_ID)
                Label_For_Table("</td>")

            ElseIf e_field = "DropDownList" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, Tooltip, Range_value, main_id, TB_ID)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "RadioButtonList" Then
                Label_For_Table("<td width='10%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                'Response.Write("radiobuttonkist")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip, Range_value, TB_ID)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "CheckBoxList" Then
                Label_For_Table("<td width='15%' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>" & Test_Date_Time)
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip, Range_value, TB_ID)
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
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal Max_Length As Integer, ByVal TB_ID As Integer)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        control.Width = 150
        control.ToolTip = Tooltip
        control.MaxLength = Max_Length
        Dim dds As DataSet = Already_Save(E_Code, main_id, TB_ID)
        If dds.Tables(0).Rows.Count <> 0 Then
            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        'Dim validator As New RangeValidator
        'validator.ID = "RangeValidator" & E_Id
        'validator.Type = ValidationDataType.Integer
        'validator.MinimumValue = 5
        'validator.MaximumValue = 20
        'validator.ErrorMessage = "Enter Correct Value"
        'validator.EnableViewState = True
        'validator.ControlToValidate = "TextBox" & E_Id
        'control.Attributes.Add("onchange", "return CheckRequiredField('" + "TextBox" & E_Id + "')")
        control.CssClass = "text_titles_01"
        Panel1.Controls.Add(control)
        'Panel1.Controls.Add(validator)
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal TB_ID As Integer)
        Dim control As New DropDownList
        control.ID = "DropDOwnList" & E_Id '& MG_Code
        control.Items.Add("")
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code, main_id, TB_ID)
        For j As Integer = 0 To dds.Tables(0).Rows.Count - 1
            For i As Integer = 0 To control.Items.Count - 1
                If control.Items(i).Value.Trim = dds.Tables(0).Rows(j).Item(1).ToString.Trim Then
                    control.Items(i).Selected = True
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
    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_value As String, ByVal TB_ID As Integer)
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
            If Already_Save_Values.Tables(0).Rows(j).Item(4).ToString = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString Then
                        control.Items(k).Selected = True
                    End If
                Next
            End If
        Next
        Label_For_Range_Values(Range_value)
    End Sub
    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_value As String, ByVal TB_ID As Integer)
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
            If Already_Save_Values.Tables(0).Rows(j).Item(4).ToString = control.ID Then
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
    Sub Draw_web(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer, ByVal TB_ID As Integer)


        Dim control As New Infragistics.WebUI.WebHtmlEditor.WebHtmlEditor
        Dim count_total As Integer = control.Toolbar.Items.Count - 1
        Dim flag As Integer = 0

        Try
            For count1 As Integer = 0 To count_total
                If control.Toolbar.Items(flag).type.ToString = "Bold" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "Italic" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "Underline" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "Strikethrough" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "JustifyLeft" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "JustifyCenter" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "JustifyRight" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "JustifyFull" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "UnorderedList" Then
                    flag = count1 + 1
                ElseIf control.Toolbar.Items(flag).type.ToString = "OrderedList" Then
                    flag = count1 + 1
                Else
                    Try
                        control.Toolbar.Items.Remove(control.Toolbar.Items(flag))

                        count_total = count_total - 1

                    Catch ex As Exception

                    End Try

                End If


            Next
        Catch ex As Exception

        End Try
        control.ID = "WebHtmlEditor" & E_Id

        control.Width = 100
        control.Height = 100

        Dim dds As DataSet = Already_Save(E_Code, main_id, TB_ID)
        If dds.Tables(0).Rows.Count <> 0 Then
            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        Panel1.Controls.Add(control)


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
        Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Radiology_ConnStr").ConnectionString
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
            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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
            mycommand.Parameters.Add("@trmid", SqlDbType.Int)
            mycommand.Parameters("@trmid").Direction = ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            TrmID = mycommand.Parameters("@trmid").Value
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message + "Main")
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

            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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
            mycommand.Parameters.AddWithValue("@TCValue", E_ID)
            mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            mycommand.ExecuteNonQuery()
            ' HiddenField_TID.Value = arraylisttestid(abc)
            '  SqlDataSourceDoctor.Update()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message + "Main2")
        End Try
        'Next
        'InsertDoctorRecord()
        ' Response.Redirect("PatientTestReportMain.aspx?yearlyNo=" & Request.QueryString("YearlyNo") & "&RegNo=" & Request.QueryString("RegNo"))
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
                        If HiddenField_TBID.Value = 4 Then
                            If Check_Value() <> 100 Then
                                Dim SB As New StringBuilder
                                Dim t As Type = Me.GetType
                                SB.Append("<script language='javascript' type='text/javascript'>alert('Enter Correct Value of D.L.C');</script>")
                                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                                    ClientScript.RegisterClientScriptBlock(t, "popup", SB.ToString())
                                End If
                            Else
                                InsertTest(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                            End If
                        Else
                            InsertTest(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                        End If
                    End If
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message & "check_control()")
        End Try
    End Sub

    Function Check_Value() As Integer
        Dim total As Integer = 0

        For i As Integer = 0 To Panel1.Controls.Count - 1
            If Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                If txt.Text <> "" Then
                    total = total + Convert.ToInt32(txt.Text)
                End If
            End If
        Next

        Return total
    End Function

    Function Already_Save_Element_for_Color(ByVal Main_Id As Integer, ByVal TB_ID As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Pathalogy_Already_save_For_Controls", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)
        mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Function Already_Save(ByVal E_ID As Integer, ByVal Main_Id As Integer, ByVal TB_ID As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Test_Result_for_Table", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)
        mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
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
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Function

    Protected Sub ButtonFinal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonFinal.Click
        Try
            'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
            '    Dim hid_TGID As HiddenField = DataListMainGroup.Items(i).FindControl("HiddenField1")
            '    HiddenField_TG_ID.Value = hid_TGID.Value
            'Next
            If Check_Insert(HiddenField_TBID.Value) = True Then
                SqlDataSource_Update_Status.Update()
                SqlDataSourceUpdate.Update()
                'SqlDataSource_UpdateStatus.Update()
                GridView_Test_Status.DataBind()
                If GridView_Test_Status.Rows.Count = 0 Then
                    Response.Redirect("Patient_Search.aspx")
                End If
            Else
                Dim Sb As New StringBuilder
                Sb.Append("<script language='javascript' type='text/javascript'>alert('Enter the Test Result First');</script>")
                Dim t As Type = Me.GetType
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", Sb.ToString())
                End If
            End If
            'SqlDataSourceUpdateTreatment.Update()
            'Response.Redirect("Patient_Search.aspx?def=1.2")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Function Patient_Calculate_Test() As Boolean
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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
    Protected Sub GridView_Test_Status_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView_Test_Status.RowUpdating
        Dim Drop As DropDownList = GridView_Test_Status.Rows(e.RowIndex).FindControl("DropDownList_Status")
        Dim Hid_ID As HiddenField = GridView_Test_Status.Rows(e.RowIndex).FindControl("HiddenField_ID")
        HiddenField_Edit_ID.Value = Hid_ID.Value
        HiddenField_Edit_Status.Value = Drop.SelectedValue
    End Sub

    Protected Sub GridView_Test_Status_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Test_Status.SelectedIndexChanged
        Try
            Panel1.Controls.Clear()
            HiddenField_new_TGID.Value = GridView_Test_Status.SelectedValue
            Image(Convert.ToInt32(HiddenField_new_TGID.Value))
        Catch ex As Exception

        End Try

        Dim hid_main_group As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField7")
        HiddenFieldCategory.Value = GridView_Test_Status.SelectedValue
        'Response.Write(hid_main_group.Value & "fdsf")
        'Response.End()
        Dim hid_TGID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField6")
        Dim hid_Main_Id As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField8")
        Dim hid_TBID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenFieldTBID")
        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TBID.Value = hid_TBID.Value

        If hid_main_group.Value.Trim = "Histopathology" Then
            Response.Redirect("Biopsy_Entry.aspx?RegNo=" & Session("registrationNo") & "&YearlyNo=" & Session("YearlyNo") & "&Main_Id=" & HiddenFieldMainID.Value)
        End If
        HiddenField3.Value = DataListMainGroup.SelectedValue
        'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
        'Response.Write(HiddenField_TBID.Value)
        'Response.End()
        'Next
        Dim dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value, HiddenField_TBID.Value)
        HiddenField_MS_TGID.Value = GridView_Test_Status.SelectedValue
        'Response.Write(HiddenField_MS_TGID.Value)
        Phy_Elements(HiddenField_MS_TGID.Value, 38, dss, HiddenFieldMainID.Value, HiddenField_TBID.Value) '("TestMainGroup"), DataListtemplate.SelectedValue, dss)
        TextBox_Description.Visible = True
        Label_Description.Visible = True

    End Sub
    Sub Image(ByVal TGID As Int32)

        Dim regno As String = Request.QueryString("Reg_No")
        Dim yearlyno As String = CInt(Request.QueryString("YearlyNo"))
        image_id(yearlyno, regno, TGID)
    End Sub
    Sub image_id(ByVal yearlyno As Integer, ByVal regno As String, ByVal TGID As Integer)
        Try
            Panel2.Controls.Clear()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT *  FROM [pt_Xray_Images] where TGID = @TGID and RegNo = @RegNo and YearlyNo=@YearlyNo", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@TGID", TGID)
            param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No"))
            param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("YearlyNo")))
            con.Open()

            da.SelectCommand = mycommand
            da.Fill(ds)
            con.Close()
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Table_Label("<Table border = '1' align='center'><tr><td>")
                ElseIf i Mod 7 = 0 Then
                    Table_Label("</tr><tr><td>")
                Else
                    Table_Label("<td>")
                End If
                Dim control As New ImageButton
                control.Attributes.Add("onclick", "return Image_NEw('" & yearlyno & "','" & regno & "','" & CInt(ds.Tables(0).Rows(i).Item(0)) & "')")
                control.ImageUrl = "ptxrayview.aspx?Xray_ID=" & CInt(ds.Tables(0).Rows(i).Item(0)) & "&payId=" & yearlyno & "&rig_no=" & regno

                control.Width = 50
                control.Height = 50
                Panel2.Controls.Add(control)
                If i = ds.Tables(0).Rows.Count - 1 Then
                    Table_Label("</td></tr></table>")
                Else
                    Table_Label("</td>")
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Sub Table_Label(ByVal Lbl As String)
        Dim lbl_tbl As New Label
        lbl_tbl.Text = Lbl
        Panel2.Controls.Add(lbl_tbl)
    End Sub
End Class
