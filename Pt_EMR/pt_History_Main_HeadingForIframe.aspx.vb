Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_pt_History_Main_HeadingForIframe
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim Element_Name As String
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            If HiddenField3.Value = "History of Present Illness" Then
                Check_Controls()
                control_HOPI()
            Else
                Check_Controls_history()
                control_history()
                GridViewSaveValue.DataBind()
            End If
            If HiddenField_MG_CODE.Value <> "" Then
                SqlDataSource_OPD_Encounter_Form_Remarks.Insert()
            End If
            DataList_remarks.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        ' for_remarks()
    End Sub

    Sub Phy_Elements_history(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_History_Page", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@templateid", template_id)
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            ds.Reset()
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            Dim j As Integer = 0
            Dim fl As Boolean = False
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    fl = True
                    Label_For_Table_history("<table id='Table_Phy_Exam' border='0' width ='100%' cellspacing='0' cellpadding='0' Class='Grid_dynamic'>")
                    Label_For_Table_history("<tr bgcolor='#d3d3d3' font-size: 16pt; style='color: Black; '><td colspan='5'  style='color:#990000; text-align:left;'><strong>" & ds.Tables(0).Rows(i).Item(6).ToString & "</strong></td></tr>")
                    Check_For_Table_Rows_History(MG_Code, i, j, ds, Already_Save_Values)
                ElseIf i <> 0 Then
                    If ds.Tables(0).Rows(i - 1).Item(4).ToString <> ds.Tables(0).Rows(i).Item(4).ToString Then
                        Label_For_Table_history("</table>")
                        Label_For_Table_history("<table id='Table_Phy_Exam' border='0' cellspacing='0' cellpadding='0' width='100%' Class='Grid_dynamic'>")
                        Label_For_Table_history("<tr bgcolor='#d3d3d3' font-size: 16pt; style='color: Black; '><strong><td colspan='5'  style='color:#990000; text-align:left;'>" & ds.Tables(0).Rows(i).Item(6).ToString & "</td></strong></tr>")
                        j = 0
                        Check_For_Table_Rows_History(MG_Code, i, j, ds, Already_Save_Values)
                        j = 1
                        Continue For
                    Else
                        Check_For_Table_Rows_History(MG_Code, i, j, ds, Already_Save_Values)
                    End If
                End If
                j = j + 1
            Next
            If fl = True Then
                Label_For_Table_history("</table>")
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Check_For_Table_Rows_History(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet)
        If MG_Code = 0 Then
            If j Mod 2 = 1 Then
                Label_For_Table_history("<td width='25%'>")
                Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Label_For_Table_history("</td>")
            ElseIf j Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table_history("<tr >")
                    Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Else
                    Label_For_Table_history("<tr>")
                    Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                End If
            End If
        Else
            If i Mod 2 = 1 Then
                Label_For_Table_history("")
                Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Label_For_Table_history(" ")
            ElseIf i Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table_history("<tr >")
                    Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Else
                    Label_For_Table_history("<tr>")
                    Phy_Elements_Values_history(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                End If
            End If
        End If
    End Sub
    Sub Phy_Elements_Values_history(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select ev_code,ev_value from admin_History_ElementValue where e_code = @e_Code and MG_Code=@MG_Code order by Priority", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@e_Code", e_code)
            param = mycommand.Parameters.AddWithValue("@mg_Code", MG_Code)
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
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
            Make_Control_History(ds, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, Tooltip, Test_Date_Time)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_Control_History(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Test_Date_Time As String)

        Dim colsSoan As String = "2"

        If Not e_name.Trim() = "" Then
            Label_For_Table_history("<td width='25%'  bgcolor='" & Save_Record_Color & "'>")
            Make_Label_history(e_id, e_name, Mg_code, Already_Save_Values, Tooltip)
            Label_For_Table_history("</td>")
            colsSoan = "0"
        End If


        If e_field = "TextBox" Then
            Label_For_Table_history("<td width='25%' colspan='" + colsSoan + "'  bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            Make_TextBox_history(e_id, Already_Save_Values, E_Code, Tooltip, e_name)
            Label_For_Table_history("</td>")
        ElseIf e_field = "DropDownList" Then
            Label_For_Table_history("<td width='25%'  colspan='" + colsSoan + "'    bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_DropDownList_history(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table_history("</td>")
        ElseIf e_field = "RadioButtonList" Then
            Label_For_Table_history("<td width='25%'  colspan='" + colsSoan + "'    bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_RadioButtonList_history(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table_history("</td>")
        ElseIf e_field = "CheckBoxList" Then
            Label_For_Table_history("<td width='25%'  colspan='" + colsSoan + "'   bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_CheckBoxLIst_history(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table_history("</td>")
        End If
    End Sub
    Sub Make_Label_history(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim Lbl As New Label
        Lbl.ID = "Label" & e_id '& MG_Code
        Lbl.Font.Bold = False
        Lbl.Text = e_name
        Lbl.EnableViewState = True
        ''Lbl.Width = 150
        Lbl.ToolTip = Tooltip
        Panel_history.Controls.Add(Lbl)
    End Sub
    Sub Make_TextBox_history(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal e_name As String)
        If (e_name <> "Other") Then 'Or (e_name <> "Other")
            Dim control As New TextBox
            control.ID = "TextBox" & E_Id
            control.EnableViewState = True
            '  control.Width = 200
            control.ToolTip = Tooltip
            Dim dds As DataSet = Already_Save_history(E_Code)
            Dim hid As New HiddenField
            hid.ID = "HiddenField" & E_Id
            If dds.Tables(0).Rows.Count <> 0 Then
                control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                hid.Value = dds.Tables(0).Rows(0).Item(1).ToString.Trim
            End If
            Panel_history.Controls.Add(hid)
            Panel_history.Controls.Add(control)
        Else
            Dim control As New TextBox
            Dim link As New Label
            control.ID = "TextBox" & E_Id
            control.EnableViewState = True
            '  control.Width = 200
            control.ToolTip = Tooltip
            link.ID = "LinkButton" & E_Id
            link.Text = "<img src=""../images_hacims/add.png"" class='hand' onclick=""javascript:ShowPanel('" + control.ID + "');"" />" '"<a href=""javascript:void(0);""onclick=""ShowPanel('" + control.ID + "');"">Add More</a>"
            'link.Width = 50
            Dim dds As DataSet = Already_Save_history(E_Code)
            Dim hid As New HiddenField
            hid.ID = "HiddenField" & E_Id
            If dds.Tables(0).Rows.Count <> 0 Then
                control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                hid.Value = dds.Tables(0).Rows(0).Item(1).ToString.Trim
            End If
            Panel_history.Controls.Add(hid)
            Panel_history.Controls.Add(control)
            Panel_history.Controls.Add(link)
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
        End If
    End Sub
    Sub Make_DropDownList_history(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String)
        Dim control As New DropDownList
        control.ID = "DropDOwnList" & E_Id '& MG_Code
        control.Items.Add("")
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.ToolTip = Tooltip
        Dim hid As New HiddenField
        hid.ID = "HiddenField" & E_Id
        Dim dds As DataSet = Already_Save_history(E_Code)
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
        ' control.Width = 200
        Panel_history.Controls.Add(hid)
        Panel_history.Controls.Add(control)
    End Sub
    Sub Make_RadioButtonList_history(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim control As New RadioButtonList
        control.ID = "RadioButtonList" & E_Id '& MG_Code      
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.EnableViewState = True
        ' control.Width = 200
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = Tooltip
        Dim hid As New HiddenField
        control.CssClass = "toleft"
        hid.ID = "HiddenField" & E_Id
        'Dim dss As DataSet = Already_Save_Element_for_Color_history()
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
        Panel_history.Controls.Add(hid)
        Panel_history.Controls.Add(control)
    End Sub
    Sub Make_CheckBoxLIst_history(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim control As New CheckBoxList
        control.ID = "CheckBoxList" & E_Id '& MG_Code
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        ' control.Width = 200
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = Tooltip
        Dim hid As New HiddenField
        control.CssClass = "toleft"
        hid.ID = "HiddenField" & E_Id
        ' Dim dss As DataSet = Already_Save_Element_for_Color_history()
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
        Panel_history.Controls.Add(hid)
        Panel_history.Controls.Add(control)
    End Sub
    Sub Label_For_Table_history(ByVal Text As String)
        Dim Lbl As New Label
        Lbl.Text = Text
        Lbl.EnableViewState = True
        Panel_history.Controls.Add(Lbl)
    End Sub

    'Protected Sub DataListtemplate_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListtemplate.SelectedIndexChanged
    '    panel_History.Controls.Clear()
    '    HiddenField2.Value = DataListtemplate.SelectedValue
    '    Label_For_Table_history("<table><br><td>")
    '    Dim Dss As DataSet = Already_Save_Element_for_Color_history()
    '    'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
    '    'Dim Hid_ID As HiddenField = DataListMainGroup.Items(i).FindControl("HiddenField1")
    '    'Phy_Elements_history(Hid_ID.Value, HiddenField2.Value, Dss)
    '    'Next
    '    HiddenField3.Value = 0
    '    Label_For_Table_history("</td></br></table>")
    'End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("../login.aspx")
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim Obj_Menu As New JavaScriptMenu
        Obj_Menu.loginvalidate()

        LabelFooter.Text = Obj_Menu.Footer_String()
        Dim MG_Code As String
        If Not Request.QueryString("ID") Is Nothing And Not Request.QueryString("Type") Is Nothing Then
            Dim code As String = Request.QueryString("ID")
            MG_Code = code.Substring(3)
            HiddenField_MG_CODE.value = MG_Code
            HiddenField3.Value = Request.QueryString("Type") 'MG_Code.Substring(3)
        End If

        '''''''''''''''''''''
        ''''''''''''''''''''''   for Remarks
        '''''''''''''''''''''
        DataList_remarks.DataBind()
        'for_remarks()

        '''''''''''''''''''''''''
        ''''''''''''''''''''''''
        '''''''''''''''''''''''''
        Button1.Attributes.Add("OnClick", "Show_Text_Value()")
        If Panel1.Controls.Count = 0 Then
            Button_Save.Visible = False
        Else
            Button_Save.Visible = True
        End If
        If Request.QueryString("type") = "History of Present Illness" Then

        Else

        End If
        Try
            If Not IsPostBack Then
                Dim dv As DataView = DirectCast(SqlDataSource_OPD_Encounter_Form_Remarks.Select(DataSourceSelectArguments.Empty), DataView)
                If dv.Table.Rows.Count <> 0 Then
                    TextBox_Remarks.Text = dv.Table.Rows(0)(0).ToString
                Else
                    TextBox_Remarks.Text = ""
                End If
            End If
        Catch ex As Exception
        End Try

        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        'loginvalidate(Session("emp_id"), Session("dept_id"))
        Label_message.Text = ""

        Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim treatment_constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)

        Dim templateId = 0
        'Try
        '    templateId = Session("PatientTemplateId").ToString()
        'Catch ex As Exception
        '    Response.Redirect("~/login.aspx")
        'End Try

        'HiddenFieldTemplate_ID.Value = templateId
        If Not HttpContext.Current.Request.QueryString("TemplateId") = Nothing Then

            templateId = HttpContext.Current.Request.QueryString("TemplateId")
            HttpContext.Current.Session.Add("TemplateId", templateId)
            HiddenFieldTemplate_ID.Value = templateId

        Else
            If HttpContext.Current.Session("TemplateId") = Nothing Then

                Dim menu As JavaScriptMenu = New JavaScriptMenu()
                HiddenFieldTemplate_ID.Value = menu.Template_id()
                HttpContext.Current.Session.Add("TemplateId", HiddenFieldTemplate_ID.Value)


            Else
                templateId = HttpContext.Current.Session("TemplateId")
                HiddenFieldTemplate_ID.Value = templateId
            End If

        End If

        If HiddenField3.Value <> "" Then

            If HiddenField3.Value = "History of Present Illness" Then

                Dim con_treatment As SqlConnection = New SqlConnection(treatment_constr)
                Dim command_Hopi As SqlCommand = New SqlCommand("SELECT Admin_Complaint_MainGroup.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE  (Pt_Presenting_Complaint_saveRecord.YearlyNo = " & Session("YearlyNo") & ") AND (Pt_Presenting_Complaint_saveRecord.RegNo = '" & Session("registrationNO") & "')", con_treatment)
                command_Hopi.CommandType = CommandType.Text
                con_treatment.Open()
                Dim reader As SqlDataReader = command_Hopi.ExecuteReader()
                While reader.Read
                    Dim Dss As DataSet = Already_Save_Element_for_Color()
                    Phy_Elements(reader.Item("Complaint_id"), Dss)
                End While
                con_treatment.Close()
            Else

                Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_History_MainHeading_Group.Mg_Code FROM Admin_History_Main_Heading INNER JOIN Admin_History_MainHeading_Group ON Admin_History_Main_Heading.MH_Code = Admin_History_MainHeading_Group.MH_Code WHERE (Admin_History_MainHeading_Group.MH_Code =" & MG_Code & ") ORDER BY Admin_History_MainHeading_Group.Priority", con)
                command1.CommandType = CommandType.Text
                con.Open()
                Dim reader As SqlDataReader = command1.ExecuteReader()
                While reader.Read
                    Dim Dss As DataSet = Already_Save_Element_for_Color_history(reader.Item("Mg_Code"))
                    Phy_Elements_history(reader.Item("Mg_Code"), HiddenFieldTemplate_ID.Value, Dss)
                End While
                con.Close()
            End If
        End If
    End Sub

    Dim flag As Boolean = False
    Sub Make_Label_history(ByVal value As String, ByVal E_ID As String, ByVal Counter As Integer)
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_insert_History_Last", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@Exam_Result", value)
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        mycommand.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))


        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()


    End Sub

    Sub Check_Controls_history()
        For i As Integer = 0 To Panel_history.Controls.Count - 1
            If Panel_history.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                Dim RBL As RadioButtonList = Panel_history.FindControl(Panel_history.Controls(i).ID.ToString)
                'Delete_Values_history(Mid(Panel_history.Controls(i).ID.ToString, 16))
                For j As Integer = 0 To RBL.Items.Count - 1
                    If RBL.Items(j).Selected = True Then
                        Dim hid_Rbl As HiddenField = Panel_history.FindControl("HiddenField" + Mid(Panel_history.Controls(i).ID.ToString, 16))
                        If hid_Rbl.Value <> RBL.Items(j).Value Then
                            Make_Label_history(RBL.Items(j).Value, Mid(Panel_history.Controls(i).ID.ToString, 16), j)
                        End If
                    End If
                Next
            ElseIf Panel_history.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                Dim CBL As CheckBoxList = Panel_history.FindControl(Panel_history.Controls(i).ID.ToString)
                'Delete_Values_history(Mid(Panel_history.Controls(i).ID.ToString, 13))
                For j As Integer = 0 To CBL.Items.Count - 1
                    If CBL.Items(j).Selected = True Then
                        'Response.Write(Mid(panel_History.Controls(i).ID.ToString, 13) + "  ")
                        Dim hid_CHK As HiddenField = Panel_history.FindControl("HiddenField" + Mid(Panel_history.Controls(i).ID.ToString, 13))
                        If CBL.Items(j).Value <> hid_CHK.Value Then
                            Make_Label_history(CBL.Items(j).Value, Mid(Panel_history.Controls(i).ID.ToString, 13), j)
                        End If
                    End If
                Next
            ElseIf Panel_history.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                Dim DDL As DropDownList = Panel_history.FindControl(Panel_history.Controls(i).ID.ToString)
                'Delete_Values_history(Mid(Panel_history.Controls(i).ID.ToString, 13))
                For j As Integer = 0 To DDL.Items.Count - 1
                    If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                        Dim hid_Drop As HiddenField = Panel_history.FindControl("HiddenField" + Mid(Panel_history.Controls(i).ID.ToString, 13))
                        If DDL.Items(j).Value <> hid_Drop.Value Then
                            Make_Label_history(DDL.Items(j).Value, Mid(Panel_history.Controls(i).ID.ToString, 13), j)
                        End If
                    End If
                Next
            ElseIf Panel_history.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txt As TextBox = Panel_history.FindControl(Panel_history.Controls(i).ID.ToString)
                'Delete_Values_history(Mid(Panel_history.Controls(i).ID.ToString, 8))
                If txt.Text.Trim <> "" Then
                    Dim hid_text As HiddenField = Panel_history.FindControl("HiddenField" + Mid(Panel_history.Controls(i).ID.ToString, 8))
                    If txt.Text <> hid_text.Value Then
                        Make_Label_history(txt.Text, Mid(Panel_history.Controls(i).ID.ToString, 8), 0)
                    End If
                End If
            End If
        Next
    End Sub

    Function Already_Save_Element_for_Color_history(ByVal Mg_Code As Integer) As DataSet
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Already_Save_Elements", con) '"SELECT Pt_history_SaveRecord.MG_Code, Pt_history_SaveRecord.e_Code,Pt_history_SaveRecord.ev_Code,admin_History_Elements.e_Code,admin_History_Elements.e_Field_Type + admin_History_Elements.e_ID,admin_History_Elements.e_Field_Type FROM Pt_history_SaveRecord INNER JOIN admin_History_Elements ON Pt_history_SaveRecord.e_Code = admin_History_Elements.e_Code where (Pt_history_SaveRecord.YearlyNo=@YearlyNo) And (Pt_history_SaveRecord.RegNo = @RegNo) ", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@MG_Code", Mg_Code)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Function Already_Save_history(ByVal E_ID As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select e_Code,ev_Code from Pt_history_SaveRecord where (e_Code = " & E_ID & ") and (Pt_history_SaveRecord.YearlyNo=@YearlyNo) And (Pt_history_SaveRecord.RegNo = @RegNo)AND (Ele_Status = 1)", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Sub Delete_Values_history(ByVal E_ID As String)

        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Delete_History_saveRecord", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        'mycommand.Parameters.AddWithValue("@Exam_Result", value)
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        mycommand.Parameters.AddWithValue("@MG_Code", ListBox1.SelectedValue)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()
    End Sub

    Sub control_HOPI()
        Try
            Panel1.Controls.Clear()
            Dim treatment_constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Panel_history.Visible = False
            Panel1.EnableViewState = False
            Dim con_treatment As SqlConnection = New SqlConnection(treatment_constr)
            Dim command_treatment As SqlCommand = New SqlCommand("SELECT Admin_Complaint_MainGroup.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE  (Pt_Presenting_Complaint_saveRecord.YearlyNo = " + Session("YearlyNo") + ") AND (Pt_Presenting_Complaint_saveRecord.RegNo = '" + Session("registrationNo") + "')", con_treatment)
            command_treatment.CommandType = CommandType.Text
            con_treatment.Open()
            Dim reader_HOPI As SqlDataReader = command_treatment.ExecuteReader
            While reader_HOPI.Read
                Dim Dss As DataSet = Already_Save_Element_for_Color() 'reader_HOPI.Item("Complaint_ID"))
                Phy_Elements(reader_HOPI.Item("Complaint_ID"), Dss)
            End While
            con_treatment.Close()
        Catch ex As Exception
        End Try
    End Sub

    Sub control_history()
        Try
            Panel_history.Controls.Clear()
            Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Panel_history.Visible = True
            Panel_history.EnableViewState = False
            Dim con As SqlConnection = New SqlConnection(constr)
            'Response.Write(ListBox1.SelectedValue)
            Dim Mg_Code As String = Request.QueryString("ID")
            Dim command As SqlCommand = New SqlCommand("SELECT Admin_History_MainHeading_Group.Mg_Code FROM Admin_History_Main_Heading INNER JOIN Admin_History_MainHeading_Group ON Admin_History_Main_Heading.MH_Code = Admin_History_MainHeading_Group.MH_Code WHERE (Admin_History_MainHeading_Group.MH_Code =" + Mg_Code.Substring(3) + ") Order by Admin_History_MainHeading_Group.Priority", con)
            command.CommandType = CommandType.Text
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader()
            While reader.Read
                Dim dss As DataSet = Already_Save_Element_for_Color_history(reader.Item("Mg_Code"))
                Phy_Elements_history(reader.Item("Mg_Code"), HiddenFieldTemplate_ID.Value, dss)
            End While
            con.Close()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged
        Button_Save.Visible = True
        Panel_history.Controls.Clear()
        Dim obj As New JavaScriptMenu
        Dim MG_Code As String = obj.Mg_Code
        HiddenField3.Value = MG_Code.Substring(3) 'ListBox1.SelectedItem.Text
        If ListBox1.SelectedItem.Text.Trim = "History of Present Illness" Then
            control_HOPI()
        Else
            control_history()
        End If
    End Sub
    ''///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet)
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_Hopi_Page_new", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Dim j As Integer = 0
        Dim fl As Boolean = False
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            If i = 0 Then
                fl = True
                'Label_For_Table_history("<table id='Table_Phy_Exam' border='1' width ='550' style='text-align:left' Class='dtable'>")
                'Label_For_Table_history("<tr bgcolor='#d3d3d3' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='5'  style='color:#990000; font-weight:bold; text-align:left;'>" & ds.Tables(0).Rows(i).Item(6).ToString & "</td></strong></tr>")
                Label_For_Table("<table id='Table_Phy_Exam' border='0' width ='100%' cellspacing='0' cellpadding='0' Class='Grid_dynamic'>")
                Label_For_Table("<tr bgcolor='#d3d3d3' font-size: 16pt; style='color: Black; '><strong><td colspan='5' >" & ds.Tables(0).Rows(i).Item(6).ToString & "</td></strong></tr>")
                Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values)
            ElseIf i <> 0 Then
                If ds.Tables(0).Rows(i - 1).Item(4).ToString <> ds.Tables(0).Rows(i).Item(4).ToString Then
                    Label_For_Table("</table>")
                    Label_For_Table("<table id='Table_Phy_Exam'  border='0' width ='100%' cellspacing='0' cellpadding='0' Class='Grid_dynamic'>")
                    Label_For_Table("<tr bgcolor='#d3d3d3' font-size: 16pt; style='color: Black;'><strong><td colspan='5' >" & ds.Tables(0).Rows(i).Item(6).ToString & "</td></strong></tr>")
                    'Response.Write(ds.Tables(0).Rows(i).Item(6).ToString)
                    j = 0
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values)
                    j = 1
                    Continue For
                Else
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values)
                End If
            End If
            j = j + 1
        Next
        If fl = True Then
            Label_For_Table("</table>")
        End If
    End Sub

    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet)
        If MG_Code = 0 Then
            If j Mod 2 = 1 Then
                Label_For_Table("<td>")
                Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Label_For_Table("</td>")
            ElseIf j Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table("<tr >")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Else
                    Label_For_Table("<tr>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                End If
            End If
        Else
            If i Mod 2 = 1 Then
                Label_For_Table("")
                Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Label_For_Table("")
            ElseIf i Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table("<tr >")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Else
                    Label_For_Table("<tr>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                End If
            End If
        End If
    End Sub

    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        ',(SELECT ev_code FROM Pt_history_SaveRecord WHERE (e_Code = 12345) AND (YearlyNo = " & Session("YearlyNo") & ") AND (RegNo = '" & Session("registrationNo") & "')) AS selectedvalue
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Sub_Type_ID, Component_Name FROM Admin_Complaint_Elementvalue WHERE  (Sub_Type_ID = @e_Code) and (Complaint_ID=@Complaint_ID)", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        'Response.Write(e_code)
        param = mycommand.Parameters.AddWithValue("@e_Code", e_code) 'Session("BMIPayID")
        param = mycommand.Parameters.AddWithValue("@Complaint_ID", MG_Code)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Dim Test_Date_Time As String = ""
        'Dim DataS As DataSet = Already_Save_Element_for_Color()
        Dim Save_Record_Color As String = ""
        If ds.Tables(0).Rows.Count > 0 Then
            For i As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
                If e_code = CInt(Already_Save_Values.Tables(0).Rows(i).Item(1).ToString) Then
                    Test_Date_Time = Already_Save_Values.Tables(0).Rows(i).Item("Date").ToString & " " & Already_Save_Values.Tables(0).Rows(i).Item("Time").ToString & "<br />"
                    Test_Date_Time = "<span style='text-align:left; color:#CC0000; font-size:9px;'>" & Test_Date_Time & "</span>"
                    Save_Record_Color = "#ffccff"
                End If
            Next
        End If
        Make_Control(ds, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, Tooltip, Test_Date_Time)
    End Sub

    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Test_Date_Time As String)
        Label_For_Table("<td width ='100' bgcolor='" & Save_Record_Color & "'>")
        Make_Label(e_id, e_name, Mg_code, Already_Save_Values, Tooltip)
        Label_For_Table("</td>")
        If e_field = "TextBox" Then
            Label_For_Table("<td width='100' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            Make_TextBox(e_id, Already_Save_Values, E_Code, Tooltip, e_name)
            Label_For_Table("</td>")
        ElseIf e_field = "DropDownList" Then
            Label_For_Table("<td width='100' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        ElseIf e_field = "RadioButtonList" Then
            Label_For_Table("<td  bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        ElseIf e_field = "CheckBoxList" Then
            Label_For_Table("<td  bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        End If
    End Sub

    Sub Make_Label(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim Lbl As New Label
        Lbl.ID = "Label" & e_id '& MG_Code
        Lbl.Font.Bold = False
        Lbl.Text = e_name
        Lbl.EnableViewState = True
        ' Lbl.Width = 100
        Lbl.ToolTip = Tooltip
        Lbl.CssClass = "small_f"
        Panel1.Controls.Add(Lbl)
    End Sub

    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal e_name As String)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        '  control.Width = 100
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code)
        If dds.Tables(0).Rows.Count <> 0 Then
            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        Panel1.Controls.Add(control)
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
    End Sub

    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String)
        Dim control As New DropDownList
        control.ID = "DropDOwnList" & E_Id '& MG_Code
        control.Items.Add("")
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code)
        For j As Integer = 0 To dds.Tables(0).Rows.Count - 1
            For i As Integer = 0 To control.Items.Count - 1
                If control.Items(i).Value.Trim = dds.Tables(0).Rows(j).Item(1).ToString.Trim Then
                    control.Items(i).Selected = True
                    'Response.Write("fsfsd fsd sddsfds ")
                End If
            Next
        Next
        control.EnableViewState = True
        '  control.Width = 100
        Panel1.Controls.Add(control)
    End Sub

    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim control As New RadioButtonList
        control.ID = "RadioButtonList" & E_Id '& MG_Code      
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.EnableViewState = True
        '  control.Width = 100
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = Tooltip
        Panel1.Controls.Add(control)
        For j As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
            If Already_Save_Values.Tables(0).Rows(j).Item(4).ToString = control.ID Then
                For k As Integer = 0 To control.Items.Count - 1
                    If control.Items(k).Value = Already_Save_Values.Tables(0).Rows(j).Item(2).ToString Then
                        control.Items(k).Selected = True
                    End If
                Next
            End If
        Next
    End Sub

    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String)
        Dim control As New CheckBoxList
        control.ID = "CheckBoxList" & E_Id '& MG_Code
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        '  control.Width = 100
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = Tooltip
        Panel1.Controls.Add(control)
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
    End Sub

    Sub Label_For_Table(ByVal Text As String)
        Dim Lbl As New Label
        Lbl.Text = Text
        Lbl.EnableViewState = True
        Panel1.Controls.Add(Lbl)
    End Sub

    Sub Insert_Values(ByVal value As String, ByVal E_ID As String, ByVal Counter As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_insert_Hopi", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@Exam_Result", value)
            mycommand.Parameters.AddWithValue("@E_ID", E_ID)
            mycommand.Parameters.AddWithValue("@empid", Session("emp_id"))
            con.Open()
            mycommand.ExecuteNonQuery()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Check_Controls()
        Try
            For i As Integer = 0 To Panel1.Controls.Count - 1
                If Panel1.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                    Dim RBL As RadioButtonList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 16))
                    For j As Integer = 0 To RBL.Items.Count - 1
                        If RBL.Items(j).Selected = True Then
                            Insert_Values(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                    Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                    For j As Integer = 0 To CBL.Items.Count - 1
                        If CBL.Items(j).Selected = True Then
                            Insert_Values(CBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                    Dim DDL As DropDownList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                    For j As Integer = 0 To DDL.Items.Count - 1
                        If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                            Insert_Values(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                    Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 8))
                    If txt.Text.Trim <> "" Then
                        Insert_Values(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                    End If
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Function Already_Save_Element_for_Color() As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT pt_Save_Presenting_Complaints.Complaint_ID, pt_Save_Presenting_Complaints.Sub_Type_ID, pt_Save_Presenting_Complaints.ComponentName,Admin_Complaint_Element.Sub_Type_ID AS Expr1, Admin_Complaint_Element.Control_Field + Admin_Complaint_Element.e_id AS Expr2,Admin_Complaint_Element.Control_Field,CONVERT(varchar, pt_Save_Presenting_Complaints.datetime, 107) AS date, CONVERT(varchar, pt_Save_Presenting_Complaints.datetime , 108) AS time FROM pt_Save_Presenting_Complaints INNER JOIN Admin_Complaint_Element ON pt_Save_Presenting_Complaints.Sub_Type_ID = Admin_Complaint_Element.Sub_Type_ID WHERE (pt_Save_Presenting_Complaints.YearlyNo = @YearlyNo) AND (pt_Save_Presenting_Complaints.RegNo = @RegNo)", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function
    Function Already_Save(ByVal E_ID As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Sub_Type_ID,ComponentName from pt_Save_Presenting_Complaints where (Sub_Type_ID = " & E_ID & ") and (pt_Save_Presenting_Complaints.YearlyNo=@YearlyNo) And (pt_Save_Presenting_Complaints.RegNo = @RegNo)", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Sub Delete_Values(ByVal E_ID As String)
        Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Delete_PresentingComplaint_saveRecord", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()
    End Sub

    Protected Sub GridViewSaveValue_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridViewSaveValue.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If Element_Name = e.Row.Cells(0).Text Then
                e.Row.Cells(0).Text = ""
            Else
                Element_Name = e.Row.Cells(0).Text
            End If
        End If
    End Sub


    Protected Sub DataList_remarks_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_remarks.SelectedIndexChanged
        Try


            Dim hid As HiddenField = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("HiddenField_Complaint_ID")
            Dim lab As Label = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("Complaint_NameLabel")
            Dim lab_detail As LinkButton = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("LinkButton_Description")
            Response.Redirect("pt_History_Main_Heading.aspx?ID=His" + hid.Value + "&Type=" + lab.Text)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

End Class
