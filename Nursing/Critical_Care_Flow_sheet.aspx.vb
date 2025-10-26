Imports System.Data
Imports System.Data.SqlClient
Partial Class Critical_Care_Flow_sheet
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim Element_Name As String = ""
    Dim chart As New GenerateXML
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click

        ' If HiddenField3.Value = 146 Then
        Check_Controls(Panel1)
        control(Panel1)

        Load_Entry_Form(146, 190)
        
        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 146)

    End Sub

    'ByRef Panel1 As Panel

    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet, ByRef Panel1 As Panel)
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Physical_Examination_Page_new", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code) 'Session("BMIPayID")
        mycommand.Parameters.AddWithValue("@templateid", template_id)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        ds.Clear()
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Dim j As Integer = 0
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            If i = 0 Then
                Label_For_Table("<table id='Table_Phy_Exam' Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>", Panel1)
                Label_For_Table("<tr bgcolor='#bebebe' ><td colspan='5'  style='color:#990000; font-weight:normal; text-align:left;'  >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></tr>", Panel1)
                'Label_For_Table("<tr bgcolor='#bebebe' font-size: 12pt; style='color: Black; font-weight: bold; ' ><strong><td colspan='5' >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></strong></tr>")
                Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, Panel1)
            ElseIf i <> 0 Then
                If ds.Tables(0).Rows(i - 1).Item(4).ToString <> ds.Tables(0).Rows(i).Item(4).ToString Then
                    Label_For_Table("</table>", Panel1)
                    Label_For_Table("<table id='Table_Phy_Exam' Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>", Panel1)
                    Label_For_Table("<tr bgcolor='#bebebe' ><td colspan='5'  style='color:#990000; font-weight:normal; text-align:left;'  >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></tr>", Panel1)
                    'Label_For_Table("<tr bgcolor='#bebebe' font-size: 16pt; style='color: Black; font-weight: bold; ><strong><td colspan='5' >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></strong></tr>")
                    j = 0
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, Panel1)
                    j = 1
                    Continue For
                Else
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, Panel1)
                End If
            End If
            j = j + 1
        Next
        Label_For_Table("</table>", Panel1)
    End Sub
    Function Return_MG_Name(ByVal MG_Code As Integer) As String
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select MG_Name from Admin_Phy_Exam_Maingroup where MG_Code = @MG_Code", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
        con.Open()
        Return mycommand.ExecuteScalar()
        con.Close()
    End Function
    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet, ByRef Panel1 As Panel)
        If MG_Code = 0 Then
            If j Mod 2 = 1 Then
                Label_For_Table("<td>", Panel1)
                Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                Label_For_Table("</td>", Panel1)
            ElseIf j Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table("<tr bgcolor='#dddce4'>", Panel1)
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                Else
                    Label_For_Table("<tr>", Panel1)
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                End If
            End If
        Else
            If i Mod 2 = 1 Then
                Label_For_Table("", Panel1)
                Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                Label_For_Table("", Panel1)
            ElseIf i Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table("<tr bgcolor='#dddce4'>", Panel1)
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                Else
                    Label_For_Table("<tr>", Panel1)
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, Panel1)
                End If
            End If
        End If
    End Sub
    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String, ByRef Panel1 As Panel)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            'Response.Write(Session("YearlyNo") + "asdsadsa" + Session("registrationNo"))
            'Response.Write(e_code)
            ',(SELECT Exam_result FROM Pt_Physical_Exam_SaveRecord WHERE (e_id = 12345) AND (YearlyNo =" & Session("YearlyNo") & ") AND (RegNo = '" & Session("RegistrationNo") & "')) AS selectedvalue
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT ev_Code, ev_Value, Priority,Image_Path FROM admin_Phy_Exam_ElementValue WHERE (e_Code = @e_Code) AND (MG_Code = @MG_Code) ORDER BY Priority", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@e_Code", e_code) 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code) 'Session("BMIPayID")
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            'Dim DataS As DataSet = Already_Save_Element_for_Color()
            Dim Save_Record_Color As String = ""
            Dim Test_Date_Time As String = ""
            If ds.Tables(0).Rows.Count > 0 Then

                For i As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
                    If e_code = CInt(Already_Save_Values.Tables(0).Rows(i).Item(1).ToString) Then
                        Test_Date_Time = Already_Save_Values.Tables(0).Rows(i).Item("Date").ToString & " " & Already_Save_Values.Tables(0).Rows(i).Item("Time").ToString & "<br />"

                        Test_Date_Time = "<span style='text-align:left; color:#CC0000; font-size:9px;'>" & Test_Date_Time & "</span>"
                        Save_Record_Color = "#ffccff"
                    End If
                Next
            End If
            Make_Control(ds, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, ToolTip, Test_Date_Time, Panel1)
        Catch ex As Exception
            'Response.Write(ex.Message & "Hello Asif")
        End Try
    End Sub
    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Test_Date_Time As String, ByRef Panel1 As Panel)
        Label_For_Table("<td  bgcolor='" & Save_Record_Color & "'>", Panel1)
        Make_Label(e_id, e_name, Mg_code, Already_Save_Values, ToolTip, Panel1)
        Label_For_Table("</td>", Panel1)
        If e_field = "TextBox" Then

            Label_For_Table("<td bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time, Panel1)

            Make_TextBox(e_id, Already_Save_Values, E_Code, ToolTip, Mg_code, e_name, Panel1)

            Label_For_Table("</td>", Panel1)
        ElseIf e_field = "DropDownList" Then

            Label_For_Table("<td   bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time, Panel1)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, ToolTip, Panel1)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>", Panel1)
        ElseIf e_field = "RadioButtonList" Then

            Label_For_Table("<td    style='text-align:left;' class='toleft'  bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time, Panel1)
            Dim list As New ArrayList
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1

                list.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                If ds.Tables(0).Rows(i).Item(3).ToString Is Nothing Or ds.Tables(0).Rows(i).Item(3).ToString = "" Then
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                Else
                    ArrayList_RadioButtonList.Add("<Img runat='server' src='" & ds.Tables(0).Rows(i).Item(3).ToString & "'/>")

                End If
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, ToolTip, list, Panel1)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>", Panel1)
        ElseIf e_field = "CheckBoxList" Then

            Label_For_Table("<td    style='text-align:left;' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time, Panel1)
            'Label_For_Table("<td width='115' bgcolor='" & Save_Record_Color & "'>")
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, ToolTip, Panel1)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>", Panel1)
        End If
    End Sub
    Sub Make_Label(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String, ByRef Panel1 As Panel)
        Dim Lbl As New Label
        Lbl.ID = "Label" & e_id '& MG_Code
        Lbl.Font.Bold = False
        Lbl.Text = e_name
        Lbl.EnableViewState = True
        Lbl.Width = 150
        Lbl.ToolTip = ToolTip
        Panel1.Controls.Add(Lbl)
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Mg_code As Integer, ByVal e_name As String, ByRef Panel1 As Panel)
        Try
            If (e_name <> "Others") And (e_name <> "Other") Then
                Dim control As New TextBox
                control.ID = "TextBox" & E_Id

                control.EnableViewState = True
                control.Width = 195
                control.ToolTip = ToolTip
                Dim hid As New HiddenField
                hid.ID = "HiddenField" + E_Id
                Dim dds As DataSet = Already_Save(E_Code, Mg_code)
                If dds.Tables(0).Rows.Count <> 0 Then
                    'Response.Write(control.ID)
                    control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                    hid.Value = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                End If

                Panel1.Controls.Add(control)
                Panel1.Controls.Add(hid)
            Else
                Dim control As New TextBox
                Dim link As New Label
                Dim hid As New HiddenField
                control.ID = "TextBox" & E_Id
                hid.ID = "HiddenField" & E_Id
                link.ID = "LinkButton" & E_Id
                control.EnableViewState = True
                control.ToolTip = ToolTip
                link.Text = "<img src=""../images/add.png"" onclick=""javascript:ShowPanel('" + control.ID + "');"" />"
                Dim dds As DataSet = Already_Save(E_Code, Mg_code)
                If dds.Tables(0).Rows.Count <> 0 Then
                    control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                    hid.Value = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                End If
                Panel1.Controls.Add(control)
                Panel1.Controls.Add(link)
                Panel1.Controls.Add(hid)
            End If
            If e_name = "Duration" Then
                Dim auto As New AjaxControlToolkit.AutoCompleteExtender
                auto.TargetControlID = "TextBox" & E_Id
                auto.ID = "AutoCompleteExtender" & E_Id
                auto.MinimumPrefixLength = "3"
                auto.ServicePath = "../AutoComplete.asmx"
                auto.ServiceMethod = "GetDay"
                auto.CompletionInterval = "5"
                auto.CompletionSetCount = "12"
                auto.EnableCaching = True
                Panel1.Controls.Add(auto)

            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try

    End Sub
    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String, ByRef Panel1 As Panel)
        Dim control As New DropDownList
        control.ID = "DropDOwnList" & E_Id '& MG_Code
        control.Items.Add("")
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        Dim hid As New HiddenField
        hid.ID = "HiddenField" + E_Id
        'Response.Write(E_Code & "  " & MG_Code)
        Dim dds As DataSet = Already_Save(E_Code, MG_Code)
        control.ToolTip = ToolTip

        For j As Integer = 0 To dds.Tables(0).Rows.Count - 1
            For i As Integer = 0 To control.Items.Count - 1
                If control.Items(i).Value.Trim = dds.Tables(0).Rows(j).Item(1).ToString.Trim Then
                    control.Items(i).Selected = True
                    hid.Value = dds.Tables(0).Rows(j).Item(1).ToString.Trim
                    'Response.Write("fsfsd fsd sddsfds ")
                End If
            Next
        Next
        control.EnableViewState = True
        control.Width = 195
        Panel1.Controls.Add(control)
        Panel1.Controls.Add(hid)
    End Sub
    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String, ByVal List As ArrayList, ByRef Panel1 As Panel)
        Dim control As New RadioButtonList
        control.ID = "RadioButtonList" & E_Id '& MG_Code      
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            'control.Items.Add(ArrayList_Radio.Item(i))
            'control.DataTextField = List.Item(i)
            'control.DataValueField = List.Item(i)

            Dim val As String = ""
            If control.ID = "RadioButtonListE00142G23" Then
                If ArrayList_Radio.Item(i) = "Spontaneous" Then
                    val = "4"
                ElseIf ArrayList_Radio.Item(i) = "To Loud Voice" Then
                    val = "3"
                ElseIf ArrayList_Radio.Item(i) = "To Pain" Then
                    val = "2"
                ElseIf ArrayList_Radio.Item(i) = "No Response" Then
                    val = "1"
                End If
                control.Items.Insert(i, ArrayList_Radio.Item(i))
                control.Items(i).Value = val
            ElseIf control.ID = "RadioButtonListE00143G23" Then
                If ArrayList_Radio.Item(i) = "Oriented" Then
                    val = "5"
                ElseIf ArrayList_Radio.Item(i) = "Confused, Disoriented" Then
                    val = "4"
                ElseIf ArrayList_Radio.Item(i) = "Inappropriate Words" Then
                    val = "3"
                ElseIf ArrayList_Radio.Item(i) = "Incomprehensible Sounds" Then
                    val = "2"
                ElseIf ArrayList_Radio.Item(i) = "No Response" Then
                    val = "1"
                End If
                control.Items.Insert(i, ArrayList_Radio.Item(i))
                control.Items(i).Value = val

            ElseIf control.ID = "RadioButtonListE00144G23" Then
                If ArrayList_Radio.Item(i) = "Obeys Command" Then
                    val = "6"
                ElseIf ArrayList_Radio.Item(i) = "Localizes Pain" Then
                    val = "5"
                ElseIf ArrayList_Radio.Item(i) = "Withdraws(flexion)" Then
                    val = "4"
                ElseIf ArrayList_Radio.Item(i) = "Abnormal flexion posturing" Then
                    val = "3"
                ElseIf ArrayList_Radio.Item(i) = "Extension posturing" Then
                    val = "2"     '"Abnormal flexion posturing"
                ElseIf ArrayList_Radio.Item(i) = "No Response" Then
                    val = "1"
                End If
                control.Items.Insert(i, ArrayList_Radio.Item(i))
                control.Items(i).Value = val
            Else
                control.Items.Insert(i, ArrayList_Radio.Item(i))
                control.Items(i).Value = List.Item(i)
            End If

            If MG_Code = 288 Then
                If ArrayList_Radio.Item(i) = "S (Strong)" Then
                    val = "S"
                ElseIf ArrayList_Radio.Item(i) = "M (Moderate)" Then
                    val = "M"
                ElseIf ArrayList_Radio.Item(i) = "W (Weak)" Then
                    val = "W"
                ElseIf ArrayList_Radio.Item(i) = "A (Absent)" Then
                    val = "A"
                End If
                control.Items.Insert(i, ArrayList_Radio.Item(i))
                control.Items(i).Value = val
            End If


        Next
        control.EnableViewState = True
        control.Width = 195
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = ToolTip
        control.CssClass = "toleft"
        Dim hid As New HiddenField
        hid.ID = "HiddenField" + E_Id
        'Dim dss As DataSet = Already_Save_Element_for_Color()
        For j As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
            If Already_Save_Values.Tables(0).Rows(j).Item(4).ToString = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString Then
                        control.Items(k).Selected = True
                        hid.Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString
                    End If
                Next
            End If
        Next
        Panel1.Controls.Add(control)
        Panel1.Controls.Add(hid)
    End Sub
    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String, ByRef Panel1 As Panel)
        Dim control As New CheckBoxList
        control.ID = "CheckBoxList" & E_Id '& MG_Code
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        'control.RepeatLayout = RepeatLayout.Flow
        control.Width = 195
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = ToolTip
        control.CssClass = "toleft"
        Dim hid As New HiddenField
        hid.ID = "HiddenField" & E_Id
        'Dim dss As DataSet = Already_Save_Element_for_Color()
        For j As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
            If Already_Save_Values.Tables(0).Rows(j).Item(4).ToString = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value.Trim = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString.Trim Then
                        control.Items(k).Selected = True
                        hid.Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString.Trim
                    End If
                Next
            End If
        Next
        Panel1.Controls.Add(control)
        Panel1.Controls.Add(hid)
    End Sub
    Sub Label_For_Table(ByVal Text As String, ByRef Panel1 As Panel)
        Dim Lbl As New Label
        Lbl.Text = Text
        Lbl.EnableViewState = True
        Panel1.Controls.Add(Lbl)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
     
	    'Dim obj_menu As New JavaScriptMenu
'        obj_menu.loginvalidate()
       ' LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))))
'        LabelFooter.Text = obj_menu.Footer_String()
		
		Dim obj_menu As New JavaScriptMenu
obj_menu.loginvalidate()
LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
LabelFooter.Text = obj_menu.Footer_String()
		
		
        'Dim MG_Code As String
        'If Not Request.QueryString("ID") Is Nothing And Not Request.QueryString("Type") Is Nothing Then
        '    Dim code As String = Request.QueryString("ID")
        '    MG_Code = code.Substring(3)
        '    HiddenField3.Value = MG_Code 'Request.QueryString("Type") 'MG_Code.Substring(3)

        'HiddenField3.Value = 146 'MH Code for Critical care sheet
        'HiddenField3.Value = 147 'MH Code for Critical care sheet

        'End If
        '''''''''''''''''''''
        ''''''''''''''''''''''   for Remarks
        '''''''''''''''''''''
        '''''''''''''''''''''''''
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        'loginvalidate(Session("emp_id"), Session("dept_id"))
        Button1.Attributes.Add("OnClick", "Show_Text_Value()")
        Label_message.Text = ""

        

        Try
            If Not IsPostBack Then
                HiddenField3.Value = 146
                HiddenFieldTemplate_id.Value = 190 'Critical Care Flow Sheet
                'HiddenFieldTemplate_id.Value = 165 'Critical Care Flow Sheet
                HiddenField_SelectedDate.Value = Date.Now
                Label_Date_1.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
                load_CC_FlowSheet(HiddenField_SelectedDate.Value, 146)
                'load_Shift_Summary()
                'load_CC_FlowSheet(147)

                If HiddenField3.Value <> 0 Then
                    Dim constr1 As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
                    Dim con1 As SqlConnection = New SqlConnection(constr1)
                    Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code =" & HiddenField3.Value & ")", con1)
                    command1.CommandType = CommandType.Text
                    con1.Open()
                    Dim reader As SqlDataReader = command1.ExecuteReader()
                    While reader.Read
                        Dim dss1 As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
                        Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss1, Panel1)
                    End While
                    con1.Close()
                End If
                Label_Date_4.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)

                Try
                    chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
                Catch ex As Exception
                    Response.Write(ex.Message.ToString)
                End Try


                'chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), "2011-06-03 12:00:00.000")


            End If


            If HiddenField3.Value = 146 Then
                Load_Entry_Form(146, 190)
            ElseIf HiddenField3.Value = 147 Then
                Load_Entry_Form(147, 165)
            ElseIf HiddenField3.Value = 127 Then
                Load_Entry_Form(127, 165)
            End If



        Catch ex As Exception

        End Try
    End Sub
    Dim ds_Nurse As New Nursing
    
    Protected Sub load_CC_FlowSheet(ByVal date_Time As DateTime, ByVal MH_Code As Integer)
        ds_Nurse.Clear()
        Dim da_Main As New NursingTableAdapters.CC_FlowSheet_MainTableAdapter
        Dim da_sub As New NursingTableAdapters.CC_FlowSheet_SubTableAdapter
        da_Main.Fill(ds_Nurse.Tables("CC_FlowSheet_Main"), MH_Code)
        'HiddenField3.Value = MH_Code
        'Dim dtetime As Date = Date.Now.AddDays(-2) '"2011-05-29 12:00:00 AM"
        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), 100113, "036043036071043043043036092036043036036078071", "2011-05-29 12:00:00.000")  
        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), 100113, "036043036071043043043036092036043036036078071", "2011-05-29 12:00:00.000")

        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), Session("YearlyNo"), Session("registrationNo"), "2011-05-29 12:00:00.000")

        Dim datetime As String
        If date_Time.Hour < 8 Then
            Dim dte As Date = date_Time.AddDays(-1)
            datetime = dte.Year.ToString() + "-" + dte.Month.ToString() + "-" + dte.Day.ToString() + " 12:00:00.000"
        Else
            Dim dte As Date = date_Time
            datetime = dte.Year.ToString() + "-" + dte.Month.ToString() + "-" + dte.Day.ToString() + " 12:00:00.000"
        End If


        'DateTime = "2011-05-29 12:00:00.000"

        da_sub.Fill(ds_Nurse.Tables("CC_FlowSheet_Sub"), Session("registrationNo"), Session("YearlyNo"), MH_Code, datetime)
        For i As Integer = 0 To ds_Nurse.Tables("CC_FlowSheet_Main").Rows.Count - 1
            For j As Integer = 0 To ds_Nurse.Tables("CC_FlowSheet_Sub").Rows.Count - 1
                If ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("e_Code").ToString() = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("e_Code").ToString() And ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("Mg_Code").ToString() = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Mg_Code").ToString() And ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("MH_Code").ToString() = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("MH_Code").ToString() Then
                    If ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 8 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0800") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 9 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0900") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 10 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1000") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 11 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1100") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 12 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1200") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 13 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1300") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 14 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1400") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 15 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1500") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 16 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1600") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 17 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1700") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 18 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1800") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 19 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1900") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 20 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2000") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 21 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2100") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 22 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2200") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 23 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2300") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 0 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2400") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 1 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0100") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 2 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0200") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 3 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0300") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 4 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0400") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 5 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0500") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 6 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0600") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("time") = 7 Then
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0700") = ds_Nurse.Tables("CC_FlowSheet_Sub").Rows(j).Item("Exam_Result")
                    End If
                End If
            Next
        Next

        If MH_Code = 146 Then

            Try
                If ds_Nurse.Tables("CC_FlowSheet_Main").Rows.Count > 2 Then
                    Dim drow As DataRow
                    drow = ds_Nurse.Tables("CC_FlowSheet_Main").NewRow()

                    drow.Item("MH_Heading") = "Critical Care Flow Sheet"
                    drow.Item("e_Name") = "GCS Total"
                    drow.Item("e_Code") = 0
                    drow.Item("MH_Code") = 0
                    drow.Item("Mg_Code") = 0
                    ds_Nurse.Tables("CC_FlowSheet_Main").Rows.InsertAt(drow, 3)


                    For i As Integer = 0 To 2

                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0800") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0800")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0800"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0900") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0900")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0900"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1000") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1000")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1000"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1100") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1100")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1100"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1200") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1200")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1200"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1300") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1300")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1300"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1400") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1400")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1400"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1500") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1500")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1500"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1600") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1600")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1600"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1700") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1700")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1700"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1800") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1800")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1800"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1900") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("1900")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("1900"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2000") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2000")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2000"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2100") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2100")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2100"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2200") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2200")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2200"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2300") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2300")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2300"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2400") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("2400")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("2400"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0100") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0100")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0100"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0200") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0200")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0200"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0300") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0300")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0300"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0400") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0400")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0400"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0500") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0500")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0500"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0600") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0600")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0600"))
                        ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0700") = Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(3).Item("0700")) + Convert.ToInt32(ds_Nurse.Tables("CC_FlowSheet_Main").Rows(i).Item("0700"))
                    Next


                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            GridView_CC_FlowSheet.DataSource = ds_Nurse.Tables("CC_FlowSheet_Main")
            GridView_CC_FlowSheet.AutoGenerateColumns = True
            GridView_CC_FlowSheet.DataBind()
        ElseIf MH_Code = 127 Then

            GridView_Routine_Care.DataSource = ds_Nurse.Tables("CC_FlowSheet_Main")
            GridView_Routine_Care.AutoGenerateColumns = True
            GridView_Routine_Care.DataBind()
        End If

    End Sub


    
    Protected Sub load_Shift_Summary(ByVal date_Time As DateTime)
        ds_Nurse.Clear()
        Dim da_Main As New NursingTableAdapters.Shift_Schedule_MainTableAdapter
        Dim da_sub As New NursingTableAdapters.Shift_Schedule_SubTableAdapter
        da_Main.Fill(ds_Nurse.Tables("Shift_Schedule_Main"))
        'Dim dtetime As Date = Date.Now.AddDays(-2) '"2011-05-29 12:00:00 AM"
        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), 100113, "036043036071043043043036092036043036036078071", "2011-05-29 12:00:00.000")  
        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), 100113, "036043036071043043043036092036043036036078071", "2011-05-29 12:00:00.000")

        'da_sub.Fill(ds.Tables("CC_FlowSheet_Sub"), Session("YearlyNo"), Session("registrationNo"), "2011-05-29 12:00:00.000")

        Dim datetime As String
        If date_Time.Hour < 7 Then
            Dim dte As Date = date_Time.AddDays(-1)
            datetime = dte.Year.ToString() + "-" + dte.Month.ToString() + "-" + dte.Day.ToString() + " 12:00:00.000"
        Else
            Dim dte As Date = date_Time
            datetime = dte.Year.ToString() + "-" + dte.Month.ToString() + "-" + dte.Day.ToString() + " 12:00:00.000"
        End If


        'DateTime = "2011-05-29 12:00:00.000"

        da_sub.Fill(ds_Nurse.Tables("Shift_Schedule_Sub"), Session("YearlyNo"), Session("registrationNo"), datetime)

        For i As Integer = 0 To ds_Nurse.Tables("Shift_Schedule_Main").Rows.Count - 1
            For j As Integer = 0 To ds_Nurse.Tables("Shift_Schedule_Sub").Rows.Count - 1
                If ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("e_Code").ToString() = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("e_Code").ToString() And ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("Mg_Code").ToString() = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Mg_Code").ToString() And ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("MH_Code").ToString() = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("MH_Code").ToString() Then
                    If ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Shift") = 1 Then
                        ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("MORNING") = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Shift") = 2 Then
                        ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("EVENING") = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Exam_Result")
                    ElseIf ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Shift") = 3 Then
                        ds_Nurse.Tables("Shift_Schedule_Main").Rows(i).Item("NIGHT") = ds_Nurse.Tables("Shift_Schedule_Sub").Rows(j).Item("Exam_Result")
                    End If
                End If
            Next
        Next


        GridView_Shift_Schedule.DataSource = ds_Nurse.Tables("Shift_Schedule_Main")
        GridView_Shift_Schedule.AutoGenerateColumns = True
        GridView_Shift_Schedule.DataBind()
    End Sub


    Sub Insert_Values(ByVal value As String, ByVal E_ID As String)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_insert_Critical_Care_Flow_Sheet", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@Exam_Result", value)
            mycommand.Parameters.AddWithValue("@E_ID", E_ID)
            mycommand.Parameters.AddWithValue("@empid", Session("emp_id"))
            mycommand.Parameters.AddWithValue("@Time", Date.Now())
            con.Open()
            mycommand.ExecuteNonQuery()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Check_Controls(ByRef Panel1 As Panel)
        For i As Integer = 0 To Panel1.Controls.Count - 1
            If Panel1.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                Dim RBL As RadioButtonList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 16))
                For j As Integer = 0 To RBL.Items.Count - 1
                    If RBL.Items(j).Selected = True Then
                        Dim hid_Rbl As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 16))
                        '    If hid_Rbl.Value <> RBL.Items(j).Value Then
                        Insert_Values(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16))
                        'End If
                    End If
                Next
            ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                For j As Integer = 0 To CBL.Items.Count - 1
                    If CBL.Items(j).Selected = True Then
                        Dim hid_CHK As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 13))
                        'Response.Write(hid_CHK.Value)
                        'If hid_CHK.Value <> CBL.Items(j).Value Then
                        Insert_Values(CBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13))
                        'End If
                    End If
                Next
            ElseIf Panel1.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                Dim DDL As DropDownList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                For j As Integer = 0 To DDL.Items.Count - 1
                    If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                        Dim hid_Drp As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 13))
                        'If hid_Drp.Value <> DDL.Items(j).Value Then
                        Insert_Values(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13))
                        'End If
                    End If
                Next
            ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 8))
                If txt.Text.Trim <> "" Then
                    Dim hid_txt As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 8))
                    'If hid_txt.Value <> txt.Text Then
                    Insert_Values(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8))
                    'End If
                End If
            End If
        Next
    End Sub
    Sub Delete_Values(ByVal E_ID As String)
        'Response.Write(E_ID + "    " + ListBox1.SelectedValue)
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Delete_Phy_exam_saveRecord_new", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        'mycommand.Parameters.AddWithValue("@Exam_Result", value)
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        'mycommand.Parameters.AddWithValue("@mg_Code", ListBox1.SelectedValue)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()
    End Sub
    Function Already_Save_Element_for_Color(ByVal MGCode As Integer) As DataSet
        Dim ds As New DataSet
        Try
            Dim da As New SqlDataAdapter

            'Try
            Dim a As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Already_Save_Phy_Elements_Nurse", con) 'SELECT Pt_physical_exam_saveRecord.body_system_Id, Pt_physical_exam_saveRecord.E_ID, Pt_physical_exam_saveRecord.Exam_Result, admin_Phy_Exam_Elements.e_Code, admin_Phy_Exam_Elements.e_Field_Type + admin_Phy_Exam_Elements.e_ID,admin_Phy_Exam_Elements.e_Field_Type FROM Pt_physical_exam_saveRecord INNER JOIN admin_Phy_Exam_Elements ON Pt_physical_exam_saveRecord.E_ID = admin_Phy_Exam_Elements.e_Code where (Pt_physical_exam_saveRecord.YearlyNo=@YearlyNo) And (Pt_physical_exam_saveRecord.RegNo = @RegNo) ", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@MG_Code", MGCode)
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            'Catch ex As Exception
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            'End Try

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return ds
    End Function
    Function Already_Save(ByVal E_ID As Integer, ByVal MG_Code As Integer) As DataSet
        Dim ds As New DataSet
        Try

            Dim a As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select E_ID,Exam_result from Pt_physical_exam_saveRecord_Nurse where (E_ID = " & E_ID & ") and (Pt_physical_exam_saveRecord_Nurse.YearlyNo=@YearlyNo) And (Pt_physical_exam_saveRecord_Nurse.RegNo = @RegNo) and(Pt_physical_exam_saveRecord_Nurse.body_system_Id = " & MG_Code & ") AND (Ele_Status = 1)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            Dim da As New SqlDataAdapter

            da.SelectCommand = mycommand
            da.Fill(ds, "abc")

        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
        Return ds
    End Function



    Sub control(ByRef Panel1 As Panel)
        Panel1.Controls.Clear()
        Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code, Admin_Exam_MainHeading_Group.Priority FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code = " + HiddenField3.Value + ") ORDER BY Admin_Exam_MainHeading_Group.Priority", con)
        command.CommandType = CommandType.Text
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        While reader.Read
            Dim dss As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
            Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss, Panel1)
        End While
        con.Close()
    End Sub

    
    Protected Sub GridView_CC_FlowSheet_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_CC_FlowSheet.PreRender
        Dim mainheading As String = ""
        Dim mainGroup As String = ""
        If GridView_CC_FlowSheet.Rows.Count <> 0 Then

            For i As Integer = 0 To GridView_CC_FlowSheet.Rows.Count - 1
                If i = 0 Then
                    mainheading = GridView_CC_FlowSheet.Rows(i).Cells(0).Text
                    mainGroup = GridView_CC_FlowSheet.Rows(i).Cells(1).Text
                Else
                    If mainheading = GridView_CC_FlowSheet.Rows(i).Cells(0).Text Then
                        GridView_CC_FlowSheet.Rows(i).Cells(0).Text = ""
                    Else
                        mainheading = GridView_CC_FlowSheet.Rows(i).Cells(0).Text
                    End If

                    If mainGroup = GridView_CC_FlowSheet.Rows(i).Cells(1).Text Then
                        GridView_CC_FlowSheet.Rows(i).Cells(1).Text = ""
                    Else
                        mainGroup = GridView_CC_FlowSheet.Rows(i).Cells(1).Text
                    End If
                End If

                'GridView_CC_FlowSheet.Rows(i).Cells(2).Visible = False
                GridView_CC_FlowSheet.Rows(i).Cells(3).Visible = False
                GridView_CC_FlowSheet.Rows(i).Cells(4).Visible = False
                GridView_CC_FlowSheet.Rows(i).Cells(5).Visible = False
            Next
            GridView_CC_FlowSheet.HeaderRow.Cells(0).Text = ""
            GridView_CC_FlowSheet.HeaderRow.Cells(1).Text = ""
            GridView_CC_FlowSheet.HeaderRow.Cells(2).Text = ""
            GridView_CC_FlowSheet.HeaderRow.Cells(3).Visible = False
            GridView_CC_FlowSheet.HeaderRow.Cells(4).Visible = False
            GridView_CC_FlowSheet.HeaderRow.Cells(5).Visible = False

        End If

    End Sub



    Protected Sub Load_Entry_Form(ByVal MH_CODE As Integer, ByVal Template_Id As Integer)

        'HiddenField3.Value = 146 'MH Code for Critical care sheet
        'HiddenField3.Value = 147 'MH Code for Critical care sheet


        If MH_CODE = 146 Then
            Panel1.Controls.Clear()
            HiddenField3.Value = MH_CODE

            'HiddenFieldTemplate_id.Value = 190 'Critical Care Flow Sheet
            'HiddenFieldTemplate_id.Value = 165 'Critical Care Flow Sheet
            HiddenFieldTemplate_id.Value = Template_Id

            load_CC_FlowSheet(HiddenField_SelectedDate.Value, MH_CODE)
            'load_Shift_Summary()

            If HiddenField3.Value <> 0 Then
                Dim constr1 As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
                Dim con1 As SqlConnection = New SqlConnection(constr1)
                Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code =" & HiddenField3.Value & ")", con1)
                command1.CommandType = CommandType.Text
                con1.Open()
                Dim reader As SqlDataReader = command1.ExecuteReader()
                While reader.Read
                    Dim dss1 As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
                    Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss1, Panel1)
                End While
                con1.Close()
            End If
        ElseIf MH_CODE = 147 Then
            Panel1b.Controls.Clear()
            HiddenField3.Value = MH_CODE

            'HiddenFieldTemplate_id.Value = 190 'Critical Care Flow Sheet
            'HiddenFieldTemplate_id.Value = 165 'Critical Care Flow Sheet
            HiddenFieldTemplate_id.Value = Template_Id

            'load_CC_FlowSheet(MH_CODE)
            load_Shift_Summary(HiddenField_SelectedDate.Value)

            If HiddenField3.Value <> 0 Then
                Dim constr1 As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
                Dim con1 As SqlConnection = New SqlConnection(constr1)
                Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code =" & HiddenField3.Value & ")", con1)
                command1.CommandType = CommandType.Text
                con1.Open()
                Dim reader As SqlDataReader = command1.ExecuteReader()
                While reader.Read
                    Dim dss1 As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
                    Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss1, Panel1b)
                End While
                con1.Close()
            End If

        ElseIf MH_CODE = 127 Then
            Panel1c.Controls.Clear()
            HiddenField3.Value = MH_CODE

            'HiddenFieldTemplate_id.Value = 190 'Critical Care Flow Sheet
            'HiddenFieldTemplate_id.Value = 165 'Critical Care Flow Sheet
            HiddenFieldTemplate_id.Value = Template_Id

            load_CC_FlowSheet(HiddenField_SelectedDate.Value, MH_CODE)
            'load_Shift_Summary()

            If HiddenField3.Value <> 0 Then
                Dim constr1 As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
                Dim con1 As SqlConnection = New SqlConnection(constr1)
                Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code =" & HiddenField3.Value & ")", con1)
                command1.CommandType = CommandType.Text
                con1.Open()
                Dim reader As SqlDataReader = command1.ExecuteReader()
                While reader.Read
                    Dim dss1 As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
                    Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss1, Panel1c)
                End While
                con1.Close()
            End If

        End If

    End Sub



    Protected Sub LinkButton_CC_FlowSheet_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_CC_FlowSheet.Click
        HiddenField_SelectedDate.Value = Date.Now
        Label_Date_1.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
        Load_Entry_Form(146, 190)

        'Panel_CC_FlowSheet.Visible = True
        'Panel_Shift_Schedule.Visible = False
        'Panel_Routine_Care.Visible = False
    End Sub

    Protected Sub LinkButton_Shift_Schedule_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Shift_Schedule.Click
        HiddenField_SelectedDate.Value = Date.Now
        Label_Date_2.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
        Load_Entry_Form(147, 165)

        'Panel_Shift_Schedule.Visible = True
        'Panel_CC_FlowSheet.Visible = False
        'Panel_Routine_Care.Visible = False
    End Sub

    Protected Sub GridView_Shift_Schedule_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Shift_Schedule.PreRender
        Dim mainheading As String = ""
        Dim mainGroup As String = ""
        If GridView_Shift_Schedule.Rows.Count <> 0 Then

            For i As Integer = 0 To GridView_Shift_Schedule.Rows.Count - 1
                If i = 0 Then
                    mainheading = GridView_Shift_Schedule.Rows(i).Cells(0).Text
                    mainGroup = GridView_Shift_Schedule.Rows(i).Cells(1).Text
                Else
                    If mainheading = GridView_Shift_Schedule.Rows(i).Cells(0).Text Then
                        GridView_Shift_Schedule.Rows(i).Cells(0).Text = ""
                    Else
                        mainheading = GridView_Shift_Schedule.Rows(i).Cells(0).Text
                    End If

                    If mainGroup = GridView_Shift_Schedule.Rows(i).Cells(1).Text Then
                        GridView_Shift_Schedule.Rows(i).Cells(1).Text = ""
                    Else
                        mainGroup = GridView_Shift_Schedule.Rows(i).Cells(1).Text
                    End If
                End If

                'GridView_Shift_Schedule.Rows(i).Cells(2).Visible = False
                GridView_Shift_Schedule.Rows(i).Cells(3).Visible = False
                GridView_Shift_Schedule.Rows(i).Cells(4).Visible = False
                GridView_Shift_Schedule.Rows(i).Cells(5).Visible = False
            Next
            GridView_Shift_Schedule.HeaderRow.Cells(0).Text = ""
            GridView_Shift_Schedule.HeaderRow.Cells(1).Text = ""
            GridView_Shift_Schedule.HeaderRow.Cells(2).Text = ""
            GridView_Shift_Schedule.HeaderRow.Cells(3).Visible = False
            GridView_Shift_Schedule.HeaderRow.Cells(4).Visible = False
            GridView_Shift_Schedule.HeaderRow.Cells(5).Visible = False

        End If

    End Sub

    Protected Sub LinkButton_Routine_Care_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Routine_Care.Click
        HiddenField_SelectedDate.Value = Date.Now
        Label_Date_3.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
        Load_Entry_Form(127, 165)

        'Panel_Shift_Schedule.Visible = False
        'Panel_CC_FlowSheet.Visible = False
        'Panel_Routine_Care.Visible = True
    End Sub

    Protected Sub GridView_Routine_Care_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Routine_Care.PreRender
        Dim mainheading As String = ""
        Dim mainGroup As String = ""
        If GridView_Routine_Care.Rows.Count <> 0 Then

            For i As Integer = 0 To GridView_Routine_Care.Rows.Count - 1
                If i = 0 Then
                    mainheading = GridView_Routine_Care.Rows(i).Cells(0).Text
                    mainGroup = GridView_Routine_Care.Rows(i).Cells(1).Text
                Else
                    If mainheading = GridView_Routine_Care.Rows(i).Cells(0).Text Then
                        GridView_Routine_Care.Rows(i).Cells(0).Text = ""
                    Else
                        mainheading = GridView_Routine_Care.Rows(i).Cells(0).Text
                    End If

                    If mainGroup = GridView_Routine_Care.Rows(i).Cells(1).Text Then
                        GridView_Routine_Care.Rows(i).Cells(1).Text = ""
                    Else
                        mainGroup = GridView_Routine_Care.Rows(i).Cells(1).Text
                    End If
                End If

                'GridView_Routine_Care.Rows(i).Cells(2).Visible = False
                GridView_Routine_Care.Rows(i).Cells(3).Visible = False
                GridView_Routine_Care.Rows(i).Cells(4).Visible = False
                GridView_Routine_Care.Rows(i).Cells(5).Visible = False
            Next
            GridView_Routine_Care.HeaderRow.Cells(0).Text = ""
            GridView_Routine_Care.HeaderRow.Cells(1).Text = ""
            GridView_Routine_Care.HeaderRow.Cells(2).Text = ""
            GridView_Routine_Care.HeaderRow.Cells(3).Visible = False
            GridView_Routine_Care.HeaderRow.Cells(4).Visible = False
            GridView_Routine_Care.HeaderRow.Cells(5).Visible = False

        End If
    End Sub

    Protected Sub Button_Save2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save2.Click
        'ElseIf HiddenField3.Value = 147 Then
        Check_Controls(Panel1b)
        control(Panel1b)

        Load_Entry_Form(147, 165)
        load_Shift_Summary(HiddenField_SelectedDate.Value)
        
    End Sub

    Protected Sub Button_Save3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save3.Click
        'ElseIf HiddenField3.Value = 127 Then
        Check_Controls(Panel1c)
        control(Panel1c)

        Load_Entry_Form(127, 165)
 

        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 127)

    End Sub

   
    Protected Sub ImageButton_Forward_1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward_1.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(1)
        Label_Date_1.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)

        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_1.ForeColor = Drawing.Color.Black
            Label_Date_1.BackColor = Drawing.Color.Transparent
            GridView_CC_FlowSheet.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_1.ForeColor = Drawing.Color.Black
            Label_Date_1.BackColor = Drawing.Color.Azure

            GridView_CC_FlowSheet.BackColor = Drawing.Color.GreenYellow
        End If

        'load_Shift_Summary(HiddenField_SelectedDate.Value)
        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 146)
    End Sub

    Protected Sub ImageButton_Previous_1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous_1.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(-1)
        Label_Date_1.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)

        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_1.ForeColor = Drawing.Color.Black
            Label_Date_1.BackColor = Drawing.Color.Transparent
            GridView_CC_FlowSheet.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_1.ForeColor = Drawing.Color.Black
            Label_Date_1.BackColor = Drawing.Color.Azure

            GridView_CC_FlowSheet.BackColor = Drawing.Color.GreenYellow
        End If

        'load_Shift_Summary(HiddenField_SelectedDate.Value)
        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 146)
    End Sub

    Protected Sub ImageButton_Previous_2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous_2.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(-1)
        Label_Date_2.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)

        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_2.ForeColor = Drawing.Color.Black
            Label_Date_2.BackColor = Drawing.Color.Transparent
            GridView_Shift_Schedule.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_2.ForeColor = Drawing.Color.Black
            Label_Date_2.BackColor = Drawing.Color.Azure

            GridView_Shift_Schedule.BackColor = Drawing.Color.GreenYellow
        End If

        load_Shift_Summary(HiddenField_SelectedDate.Value)
        'load_CC_FlowSheet(HiddenField_SelectedDate.Value, 147)
    End Sub
    Protected Sub ImageButton_Forward_2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward_2.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(1)
        Label_Date_2.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_2.ForeColor = Drawing.Color.Black
            Label_Date_2.BackColor = Drawing.Color.Transparent
            GridView_Shift_Schedule.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_2.ForeColor = Drawing.Color.Black
            Label_Date_2.BackColor = Drawing.Color.Azure

            GridView_Shift_Schedule.BackColor = Drawing.Color.Wheat
        End If

        load_Shift_Summary(HiddenField_SelectedDate.Value)
        'load_CC_FlowSheet(HiddenField_SelectedDate.Value, 146)

    End Sub
    Protected Sub ImageButton_Forward_3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward_3.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(1)
        Label_Date_3.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)

    
        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_3.ForeColor = Drawing.Color.Black
            Label_Date_3.BackColor = Drawing.Color.Transparent
            GridView_Routine_Care.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_3.ForeColor = Drawing.Color.Black
            Label_Date_3.BackColor = Drawing.Color.Azure

            GridView_Routine_Care.BackColor = Drawing.Color.GreenYellow
        End If

        'load_Shift_Summary(HiddenField_SelectedDate.Value)
        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 127)

    End Sub

    Protected Sub ImageButton_Previous_3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous_3.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(-1)
        Label_Date_3.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_3.ForeColor = Drawing.Color.Black
            Label_Date_3.BackColor = Drawing.Color.Transparent
            GridView_Routine_Care.BackColor = Drawing.Color.Transparent
        Else
            Label_Date_3.ForeColor = Drawing.Color.Black
            Label_Date_3.BackColor = Drawing.Color.Azure

            GridView_Routine_Care.BackColor = Drawing.Color.GreenYellow
        End If
        'load_Shift_Summary(HiddenField_SelectedDate.Value)
        load_CC_FlowSheet(HiddenField_SelectedDate.Value, 127)

    End Sub

    Protected Sub ImageButton_Previous_4_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous_4.Click

        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(-1)
        Label_Date_4.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_4.ForeColor = Drawing.Color.Black
            Label_Date_4.BackColor = Drawing.Color.Transparent

        Else
            Label_Date_4.ForeColor = Drawing.Color.Black
            Label_Date_4.BackColor = Drawing.Color.BlanchedAlmond


        End If


        chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")

        '"2011-06-03 12:00:00.000"
    End Sub

    Protected Sub ImageButton_Forward_4_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward_4.Click

        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(1)
        Label_Date_4.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_4.ForeColor = Drawing.Color.Black
            Label_Date_4.BackColor = Drawing.Color.Transparent

        Else
            Label_Date_4.ForeColor = Drawing.Color.Black
            Label_Date_4.BackColor = Drawing.Color.BlanchedAlmond


        End If


        chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
    End Sub

    Protected Sub LinkButton_ChartInOut_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_ChartInOut.Click
        HiddenField_SelectedDate.Value = Date.Now
        Label_Date_4.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
        chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
    End Sub

    Protected Sub LinkButton_Chartvitals_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Chartvitals.Click
        HiddenField_SelectedDate.Value = Date.Now
        Label_Date_5.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)
        chart.Generate_Patient_Vital_Chart(CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
    End Sub

    Protected Sub ImageButton_Previous_5_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Previous_5.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(-1)
        Label_Date_5.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_5.ForeColor = Drawing.Color.Black
            Label_Date_5.BackColor = Drawing.Color.Transparent

        Else
            Label_Date_5.ForeColor = Drawing.Color.Black
            Label_Date_5.BackColor = Drawing.Color.BlanchedAlmond


        End If

        chart.Generate_Patient_Vital_Chart(CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
        'chart.Create_XML_For_INOutChart(Session("registrationNo"), Session("YearlyNo"), CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")

    End Sub

    Protected Sub ImageButton_Forward_5_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Forward_5.Click
        HiddenField_SelectedDate.Value = Convert.ToDateTime(HiddenField_SelectedDate.Value).AddDays(1)
        Label_Date_5.Text = CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year)


        If Convert.ToDateTime(HiddenField_SelectedDate.Value).Date = Date.Now.Date Then
            Label_Date_5.ForeColor = Drawing.Color.Black
            Label_Date_5.BackColor = Drawing.Color.Transparent

        Else
            Label_Date_5.ForeColor = Drawing.Color.Black
            Label_Date_5.BackColor = Drawing.Color.BlanchedAlmond


        End If

        chart.Generate_Patient_Vital_Chart(CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Year) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Month) + "-" + CStr(Convert.ToDateTime(HiddenField_SelectedDate.Value).Day) + " 12:00:00.000")
    End Sub
End Class
