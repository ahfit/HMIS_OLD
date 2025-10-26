Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_Pt_Physical_Examination_Main_HeadForIframe
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim Element_Name As String = ""
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Check_Controls()
        control()
        If HiddenField3.Value <> "" Then
            SqlDataSource_OPD_Encounter_Form_Remarks.Insert()
        End If
        'for_remarks()
        DataList_remarks.DataBind()
        'GridView1.DataBind()
    End Sub
    Sub GetGrowthChartTypes()
        Dim objDbManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {}
        Dim dt As DataTable = objDbManager.ExecuteDataTable("GetGrowthChartTypes", "TreatmentConnectionString", sqlParams)
        dlCharts.DataSource = dt
        dlCharts.DataBind()


    End Sub

    'Protected Sub DataListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListMainGroup.SelectedIndexChanged
    '    Panel1.Controls.Clear()
    '    HiddenField3.Value = DataListMainGroup.SelectedValue
    '    'Dim dss As DataSet = Already_Save_Element_for_Color()
    '    'Phy_Elements(DataListMainGroup.SelectedValue, DataListtemplate.SelectedValue, dss)
    'End Sub

    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal template_id As Integer, ByVal Already_Save_Values As DataSet)
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Physical_Examination_Page_new", con)
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
                Label_For_Table("<table id='Table_Phy_Exam' Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>")
                Label_For_Table("<tr bgcolor='#bebebe' ><td colspan='5'  style='color:#990000; font-weight:normal; text-align:left;'  >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></tr>")
                'Label_For_Table("<tr bgcolor='#bebebe' font-size: 12pt; style='color: Black; font-weight: bold; ' ><strong><td colspan='5' >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></strong></tr>")
                Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values)
            ElseIf i <> 0 Then
                If ds.Tables(0).Rows(i - 1).Item(4).ToString <> ds.Tables(0).Rows(i).Item(4).ToString Then
                    Label_For_Table("</table>")
                    Label_For_Table("<table id='Table_Phy_Exam' Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>")
                    Label_For_Table("<tr bgcolor='#bebebe' ><td colspan='5'  style='color:#990000; font-weight:normal; text-align:left;'  >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></tr>")
                    'Label_For_Table("<tr bgcolor='#bebebe' font-size: 16pt; style='color: Black; font-weight: bold; ><strong><td colspan='5' >" & Return_MG_Name(ds.Tables(0).Rows(i).Item(4).ToString) & "</td></strong></tr>")
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
        'Label_For_Table("</tr>")
        If fl = True Then
            Label_For_Table("</table>")
        End If
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
    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet)
        If MG_Code = 0 Then
            If j Mod 2 = 1 Then
                Label_For_Table("<td>")
                Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Label_For_Table("</td>")
            ElseIf j Mod 2 <> 1 Then
                If i Mod 4 = 0 Then
                    Label_For_Table("<tr bgcolor='#dddce4'>")
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
                    Label_For_Table("<tr bgcolor='#dddce4'>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                Else
                    Label_For_Table("<tr>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString)
                End If
            End If
        End If
    End Sub
    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            'Response.Write(Session("YearlyNo") + "asdsadsa" + Session("registrationNo"))
            'Response.Write(e_code)
            ',(SELECT Exam_result FROM Pt_Physical_Exam_SaveRecord WHERE (e_id = 12345) AND (YearlyNo =" & Session("YearlyNo") & ") AND (RegNo = '" & Session("RegistrationNo") & "')) AS selectedvalue
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT ev_Code, ev_Value, Priority FROM admin_Phy_Exam_ElementValue WHERE (e_Code = @e_Code) AND (MG_Code = @MG_Code) ORDER BY Priority", con)
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
            Make_Control(ds, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, ToolTip, Test_Date_Time)
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Test_Date_Time As String)
        Label_For_Table("<td   bgcolor='" & Save_Record_Color & "'>")
        Make_Label(e_id, e_name, Mg_code, Already_Save_Values, ToolTip)
        Label_For_Table("</td>")
        If e_field = "TextBox" Then
            Label_For_Table("<td bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            Make_TextBox(e_id, Already_Save_Values, E_Code, ToolTip, Mg_code, e_name)
            Label_For_Table("</td>")
        ElseIf e_field = "DropDownList" Then
            Label_For_Table("<td   bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, ToolTip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        ElseIf e_field = "RadioButtonList" Then
            'Label_For_Table("<td width='115' bgcolor='" & Save_Record_Color & "'>")
            Label_For_Table("<td   style='text-align:left;' class='toleft'  bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)

            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, ToolTip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        ElseIf e_field = "CheckBoxList" Then
            Label_For_Table("<td    style='text-align:left;' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            'Label_For_Table("<td width='115' bgcolor='" & Save_Record_Color & "'>")
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next

            Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, ToolTip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")

        End If

    End Sub
    Sub Make_Label(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String)
        Dim Lbl As New Label
        Lbl.ID = "Label" & e_id '& MG_Code
        Lbl.Font.Bold = False
        Lbl.Text = e_name
        Lbl.EnableViewState = True
        Lbl.Width = 200
        Lbl.ToolTip = ToolTip
        Panel1.Controls.Add(Lbl)

    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Mg_code As Integer, ByVal e_name As String)
        Try
            If (e_name <> "Others") And (e_name <> "Other") Then
                Dim control As New TextBox
                control.ID = "TextBox" & E_Id
                control.EnableViewState = True
                control.Width = 200
                control.ToolTip = ToolTip
                Dim hid As New HiddenField
                hid.ID = "HiddenField" + E_Id
                Dim dds As DataSet = Already_Save(E_Code, Mg_code)
                If dds.Tables(0).Rows.Count <> 0 Then
                    control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                    hid.Value = dds.Tables(0).Rows(0).Item(1).ToString.Trim
                End If
                Panel1.Controls.Add(hid)
                Panel1.Controls.Add(control)
            Else
                Dim control As New TextBox
                Dim link As New Label
                Dim hid As New HiddenField
                control.ID = "TextBox" & E_Id
                hid.ID = "HiddenField" & E_Id
                link.ID = "LinkButton" & E_Id
                control.EnableViewState = True
                control.ToolTip = ToolTip
                link.Text = "<img src=""../images/add.png"" onclick=""javascript:ShowPanel('ctl00_ContentPlaceHolder1_" + control.ID + "');"" />"
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
    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal ToolTip As String)
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
        control.Width = 200
        Panel1.Controls.Add(control)
        Panel1.Controls.Add(hid)
    End Sub
    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String)
        Dim control As New RadioButtonList
        control.ID = "RadioButtonList" & E_Id '& MG_Code      
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        control.EnableViewState = True
        control.Width = 200
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
    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal ToolTip As String)
        Dim control As New CheckBoxList
        control.ID = "CheckBoxList" & E_Id '& MG_Code
        For i As Integer = 0 To ArrayList_Radio.Count - 1
            control.Items.Add(ArrayList_Radio.Item(i))
            control.DataTextField = ArrayList_Radio.Item(i)
            control.DataValueField = ArrayList_Radio.Item(i)
        Next
        'control.RepeatLayout = RepeatLayout.Flow
        'control.Width = 200
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
        'control.RepeatLayout = RepeatLayout.Flow
        control.ToolTip = ToolTip
        control.CssClass = "toleft"
        Dim hid As New HiddenField
        hid.ID = "HiddenField" + E_Id
        '=======================================
        Dim link As New Label
        link.ID = "LinkButton" & E_Id
        control.EnableViewState = True
        control.ToolTip = ToolTip
        link.Text = "<img src=""../images_hacims/add.png"" class='hand' onclick=""javascript:ShowPanel('" + control.ID + "');"" />"
        Panel1.Controls.Add(control)
        ' Panel1.Controls.Add(hid)
        Panel1.Controls.Add(link)

        ' Panel1.Controls.Add(control)
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
    End Sub
    Sub Label_For_Table(ByVal Text As String)
        Dim Lbl As New Label
        Lbl.Text = Text
        Lbl.EnableViewState = True
        Panel1.Controls.Add(Lbl)
    End Sub
    Protected Sub DataListtemplate_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListtemplate.SelectedIndexChanged
        Panel1.Controls.Clear()
        'HiddenField2.Value = DataListtemplate.SelectedValue
        'Label_For_Table("<table><br><td>")
        'Dim Dss As DataSet = Already_Save_Element_for_Color()
        'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
        'Dim Hid_ID As HiddenField = DataListMainGroup.Items(i).FindControl("HiddenField1")
        'Phy_Elements(Hid_ID.Value, HiddenField2.Value, Dss)
        'Next
        'HiddenField3.Value = 0
        'Label_For_Table("</td></br></table>")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()

        LabelFooter.Text = obj_menu.Footer_String()
        Dim MG_Code As String
        If Not Request.QueryString("ID") Is Nothing And Not Request.QueryString("Type") Is Nothing Then
            Dim code As String = Request.QueryString("ID")
            MG_Code = code.Substring(3)
            HiddenField3.Value = MG_Code 'Request.QueryString("Type") 'MG_Code.Substring(3)
        End If
        '''''''''''''''''''''
        ''''''''''''''''''''''   for Remarks
        '''''''''''''''''''''

        'for_Remarks()

        'DataList_remarks.DataBind()
        Try
            If Not IsPostBack Then
                'Panel1.Controls.Clear()
                'GetGrowthChartTypes()
                Dim dv As DataView = DirectCast(SqlDataSource_OPD_Encounter_Form_Remarks.Select(DataSourceSelectArguments.Empty), DataView)
                If dv.Table.Rows.Count <> 0 Then
                    TextBox_Remarks.Text = dv.Table.Rows(0)(0).ToString
                Else
                    TextBox_Remarks.Text = ""
                End If
            End If
        Catch ex As Exception

        End Try
        '''''''''''''''''''''''''
        ''''''''''''''''''''''''
        '''''''''''''''''''''''''
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        'loginvalidate(Session("emp_id"), Session("dept_id"))
        Button1.Attributes.Add("OnClick", "Show_Text_Value()")
        Label_message.Text = ""

        'Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        'Dim con As SqlConnection = New SqlConnection(constr)
        'Dim command As SqlCommand = New SqlCommand("SELECT Template_Id FROM Admin_Assign_Template WHERE (Dept_id = @Dept_id) AND (subdept_id = @subdept_id)", con)
        'command.CommandType = CommandType.Text
        'command.Parameters.AddWithValue("@Dept_id", Session("dept_id"))
        'command.Parameters.AddWithValue("@subdept_id", Session("SubDeptID"))
        'con.Open()
        'Dim b As Integer = command.ExecuteScalar()
        'HiddenFieldTemplate_id.Value = b
        'con.Close()
        'Dim a As Integer
        'If ListBox1.Items.Count = 0 Then
        '    a = 0
        'Else
        '    a = ListBox1.SelectedValue
        'End If

        Dim templateId As String = "0"

        If Not HttpContext.Current.Request.QueryString("TemplateId") = Nothing Then

            templateId = HttpContext.Current.Request.QueryString("TemplateId")
            HttpContext.Current.Session.Add("TemplateId", templateId)
            HiddenFieldTemplate_id.Value = templateId

        Else
            If HttpContext.Current.Session("TemplateId") = Nothing Then

                Dim menu As JavaScriptMenu = New JavaScriptMenu()
                HiddenFieldTemplate_id.Value = menu.Template_id()
                HttpContext.Current.Session.Add("TemplateId", HiddenFieldTemplate_id.Value)


            Else
                templateId = HttpContext.Current.Session("TemplateId")
                HiddenFieldTemplate_id.Value = templateId
            End If

        End If

        If HiddenField3.Value <> 0 Then
            Dim constr1 As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            Dim con1 As SqlConnection = New SqlConnection(constr1)
            Dim command1 As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code =" & HiddenField3.Value & ")", con1)
            command1.CommandType = CommandType.Text
            con1.Open()
            Dim reader As SqlDataReader = command1.ExecuteReader()
            While reader.Read
                Dim dss1 As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
                Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss1)
            End While
            con1.Close()
        End If
    End Sub
    'Sub for_remarks()
    '    Try
    '        Label_Select_All.Text = ""
    '        Dim select_all As DataView = DirectCast(SqlDataSource_select_all.Select(DataSourceSelectArguments.Empty), DataView)
    '        If select_all.Table.Rows.Count <> 0 Then
    '            For count As Integer = 0 To select_all.Table.Rows.Count - 1
    '                If count <> 0 Then
    '                    Label_Select_All.Text = Label_Select_All.Text + "<br/>"
    '                End If
    '                Label_Select_All.Text = Label_Select_All.Text + select_all.Table.Rows(count)(1).ToString
    '                Label_Select_All.Text = Label_Select_All.Text + "<br/>"
    '                Label_Select_All.Text = Label_Select_All.Text + select_all.Table.Rows(count)(0).ToString
    '            Next


    '        End If

    '    Catch ex As Exception

    '    End Try
    'End Sub

    'Function Return_MG_Name(ByVal MG_Code As Integer) As String
    '    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    '    Dim con As SqlConnection = New SqlConnection(a)
    '    Dim mycommand As New System.Data.SqlClient.SqlCommand("Select MG_Name from Admin_Phy_Exam_Maingroup where MG_Code = @MG_Code", con)
    '    mycommand.CommandType = Data.CommandType.Text
    '    mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
    '    con.Open()
    '    Return mycommand.ExecuteScalar()
    '    con.Close()
    'End Function
    Sub Insert_Values(ByVal value As String, ByVal E_ID As String)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_insert_phyexam_Last_new", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
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
        For i As Integer = 0 To Panel1.Controls.Count - 1
            If Panel1.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                Dim RBL As RadioButtonList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 16))
                For j As Integer = 0 To RBL.Items.Count - 1
                    If RBL.Items(j).Selected = True Then
                        Dim hid_Rbl As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 16))
                        If hid_Rbl.Value <> RBL.Items(j).Value Then
                            Insert_Values(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16))
                        End If
                    End If
                Next

            ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                For j As Integer = 0 To CBL.Items.Count - 1
                    If CBL.Items(j).Selected = True Then

                        Dim hid_CHK As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 13))
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
                        If hid_Drp.Value <> DDL.Items(j).Value Then
                            Insert_Values(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13))
                        End If
                    End If
                Next
            ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                'Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 8))
                If txt.Text.Trim <> "" Then
                    Dim hid_txt As HiddenField = Panel1.FindControl("HiddenField" + Mid(Panel1.Controls(i).ID.ToString, 8))
                    If hid_txt.Value <> txt.Text Then
                        Insert_Values(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8))
                    End If
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
        mycommand.Parameters.AddWithValue("@mg_Code", ListBox1.SelectedValue)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()
    End Sub
    Function Already_Save_Element_for_Color(ByVal MGCode As Integer) As DataSet
        Dim ds As New DataSet
        Try
            Dim da As New SqlDataAdapter

            'Try
            Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Already_Save_Phy_Elements", con) 'SELECT Pt_physical_exam_saveRecord.body_system_Id, Pt_physical_exam_saveRecord.E_ID, Pt_physical_exam_saveRecord.Exam_Result, admin_Phy_Exam_Elements.e_Code, admin_Phy_Exam_Elements.e_Field_Type + admin_Phy_Exam_Elements.e_ID,admin_Phy_Exam_Elements.e_Field_Type FROM Pt_physical_exam_saveRecord INNER JOIN admin_Phy_Exam_Elements ON Pt_physical_exam_saveRecord.E_ID = admin_Phy_Exam_Elements.e_Code where (Pt_physical_exam_saveRecord.YearlyNo=@YearlyNo) And (Pt_physical_exam_saveRecord.RegNo = @RegNo) ", con)
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
            Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select E_ID,Exam_result from Pt_physical_exam_saveRecord where (E_ID = " & E_ID & ") and (Pt_physical_exam_saveRecord.YearlyNo=@YearlyNo) And (Pt_physical_exam_saveRecord.RegNo = @RegNo) and(Pt_physical_exam_saveRecord.body_system_Id = " & MG_Code & ") AND (Ele_Status = 1)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            Dim da As New SqlDataAdapter

            da.SelectCommand = mycommand
            da.Fill(ds, "abc")

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return ds
    End Function

    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged

        HiddenField3.Value = ListBox1.SelectedValue
        'Response.Write(HiddenField3.Value & " " & DataListtemplate.SelectedValue)
        'Dim dss As New DataSet ' = Already_Save_Element_for_Color()
        ' Phy_Elements(ListBox1.SelectedValue, HiddenFieldTemplate_id.Value, dss)
        control()
    End Sub
    Sub control()
        Panel1.Controls.Clear()
        Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT Admin_Exam_MainHeading_Group.Mg_Code, Admin_Exam_MainHeading_Group.Priority FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code WHERE (Admin_Exam_MainHeading_Group.MH_Code = " + HiddenField3.Value + ") ORDER BY Admin_Exam_MainHeading_Group.Priority", con)
        command.CommandType = CommandType.Text
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        While reader.Read
            Dim dss As DataSet = Already_Save_Element_for_Color(reader.Item("Mg_Code"))
            Phy_Elements(reader.Item("Mg_Code"), HiddenFieldTemplate_id.Value, dss)
        End While
        con.Close()
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(0).Text = Element_Name Then
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
            Response.Redirect("Pt_Physical_Examination_Main_Head.aspx?ID=Phy" + hid.Value + "&Type=" + lab.Text)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub
End Class
