Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_Select_Test
    Inherits System.Web.UI.Page
    Dim TrmID As Integer
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim constr_path As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    'Dim main_id As Integer = 0
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        'Response.Write(Panel1.Controls.Count).
        Try
            'Dim con As SqlConnection = New SqlConnection(constr_path)
            'Dim command As SqlCommand = New SqlCommand("SELECT Max(Main_ID) FROM MRI_Save_Patient_Next_App where Reg_no=@Reg_no and Yearly_No=@Yearly_No", con)
            'command.CommandType = CommandType.Text
            'con.Open()
            'command.Parameters.AddWithValue("@Reg_no", Session("registrationNo"))
            'command.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
            'Dim Max_Main_Id As Integer = command.ExecuteScalar
            'Response.Write(HiddenFieldMainID.Value)
            'Response.End()
            InsertMain(HiddenFieldMainID.Value)
            Check_Controls()
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
            Response.Redirect("Biopsy_Entry.aspx?RegNo=" & Request.QueryString("RegNo").ToString & "&YearlyNo=" & Request.QueryString("YearlyNo").ToString)
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
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            Dim j As Integer = 0
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Label_For_Table("<table id='Table_Phy_Exam' border='1' width ='850' style='text-align:left'>")
                    Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold; ' ><strong><td colspan='7' class='text_heading_01'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                    Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values, main_id)
                ElseIf i <> 0 Then
                    If ds.Tables(0).Rows(i - 1).Item(7).ToString <> ds.Tables(0).Rows(i).Item(7).ToString Then
                        Label_For_Table("</table>")
                        Label_For_Table("<table id='Table_Phy_Exam' border='1' width='850' style='text-align:left'>")
                        Label_For_Table("<tr bgcolor='#ffcc66' font-size: 16pt; style='color: Black; font-weight: bold;'><strong><td colspan='7' class='text_heading_01'>" & ds.Tables(0).Rows(i).Item(8).ToString & "</td></strong></tr>")
                        j = 0
                        ' Check_For_Table_Rows checks the table row and column , and color the altenate row of the table 
                        ' i is the no of element ,j is the no of the element of the main group 
                        ' when main group changed j becomes zero and start once agin from zero 
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
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Response.Write(Request.QueryString("Reg_No"))
            'Response.End()
            Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
            'If Session("YearlyNo") Is Nothing Or Session("RegistrationNo") Is Nothing Then
            'Response.Redirect("Login.aspx")
            'End If
            Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            'loginvalidate(Session("emp_id"), Session("dept_id"))
            Label_message.Text = ""
            If Patient_Calculate_Test() = True Then
                ButtonFinal.Visible = True
            End If
            If Page.IsPostBack Then
                'Response.Write(Panel1.Controls.Count)
                Panel1.Controls.Clear()
                'Response.Write(Panel1.Controls.Count)
                If Panel1.Controls.Count > 0 Then
                    Panel1.Controls.Clear()
                End If
                Dim Dss As DataSet = Already_Save_Element_for_Color(HiddenFieldMainID.Value)
                Phy_Elements(DataListtemplate.SelectedValue, 38, Dss, HiddenFieldMainID.Value)
            End If
        Catch ex As Exception
        End Try
    End Sub
    Sub Check_For_Table_Rows(ByVal MG_Code As Integer, ByVal i As Integer, ByVal j As Integer, ByVal ds As DataSet, ByVal Already_Save_Values As DataSet, ByVal main_id As Integer)
        Try
            If MG_Code <> 0 Then
                If j Mod 2 = 1 Then
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    Label_For_Table("</td>")
                ElseIf j Mod 2 <> 1 Then
                    If j Mod 4 = 0 Then
                        Label_For_Table("<tr bgcolor='#f8ffe0'>") '#f8fff7'>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    Else
                        Label_For_Table("<tr>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    End If
                End If
            Else
                If i Mod 2 = 1 Then
                    Label_For_Table("<td class='text_titles_01'>")
                    Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    Label_For_Table("</td>")
                ElseIf i Mod 2 <> 1 Then
                    If i Mod 4 = 0 Then
                        Label_For_Table("<tr bgcolor='#f8ffe0'>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    Else
                        Label_For_Table("<tr>")
                        Phy_Elements_Values(ds.Tables(0).Rows(i).Item(0).ToString, ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(2).ToString, ds.Tables(0).Rows(i).Item(3).ToString, MG_Code, Already_Save_Values, ds.Tables(0).Rows(i).Item(5).ToString, ds.Tables(0).Rows(i).Item(6).ToString, main_id)
                    End If
                End If
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet, ByVal Tooltip As String, ByVal Range_Value As String, ByVal main_id As Integer)
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
            For i As Integer = 0 To Already_Save_Values.Tables(0).Rows.Count - 1
                If e_code = CInt(Already_Save_Values.Tables(0).Rows(i).Item(1).ToString) Then
                    Save_Record_Color = "#ffccff"
                End If
            Next
            'End If
            Make_Control(ds1, e_id, e_name, MG_Code, e_field, Save_Record_Color, Already_Save_Values, e_code, Tooltip, Range_Value, main_id)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer)
        Try
            Label_For_Table("<td width ='150' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
            Make_Label(e_id, e_name, Mg_code, Already_Save_Values, Tooltip)
            Label_For_Table("</td>")
            If e_field = "TextBox" Then
                Label_For_Table("<td width='150' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
                Make_TextBox(e_id, Already_Save_Values, E_Code, Tooltip, Range_value, main_id)
                Label_For_Table("</td>")
            ElseIf e_field = "DropDownList" Then
                Label_For_Table("<td width='150' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, E_Code, Tooltip, Range_value, main_id)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "RadioButtonList" Then
                Label_For_Table("<td width='150' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
                'Response.Write("radiobuttonkist")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip, Range_value)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "CheckBoxList" Then
                Label_For_Table("<td width='150' bgcolor='" & Save_Record_Color & "' class='text_titles_01'>")
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
            Lbl.Text = e_name
            Lbl.EnableViewState = True
            Lbl.Width = 150
            Lbl.ToolTip = Tooltip
            Panel1.Controls.Add(Lbl)
        Catch ex As Exception

        End Try
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal Range_value As String, ByVal main_id As Integer)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        control.Width = 150
        control.ToolTip = Tooltip
        Dim dds As DataSet = Already_Save(E_Code, main_id)
        If dds.Tables(0).Rows.Count <> 0 Then
            control.Text = dds.Tables(0).Rows(0).Item(1).ToString.Trim
        End If
        control.CssClass = "text_titles_01"
        Panel1.Controls.Add(control)
        Label_For_Range_Values(Range_value)
    End Sub
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
        Dim dds As DataSet = Already_Save(E_Code, main_id)
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
        Lbl.Text = "<td width = 75' class ='text_titles_01'>" & Value & "</td>"
        Lbl.Width = 50
        Lbl.EnableViewState = True
        Lbl.CssClass = "text_titles_01"
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
            mycommand.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value) 'Request.QueryString("TestMainGroup").ToString)
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
                        '  Response.Write("textbox before")
                        InsertTest(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                        'Response.Write("textbox End")
                    End If
                End If
            Next

        Catch ex As Exception
            Response.Write(ex.Message & "check_control()")
        End Try
    End Sub
    Function Already_Save_Element_for_Color(ByVal Main_Id As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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

    Function Already_Save(ByVal E_ID As Integer, ByVal Main_Id As Integer) As DataSet
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Test_Result_for_Table", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        mycommand.Parameters.AddWithValue("@Main_Id", Main_Id)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Return ds
    End Function

    Protected Sub ButtonFinal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonFinal.Click
        Try
            'For i As Integer = 0 To DataListMainGroup.Items.Count - 1
            '    Dim hid_TGID As HiddenField = DataListMainGroup.Items(i).FindControl("HiddenField1")
            '    HiddenField_TG_ID.Value = hid_TGID.Value
            'Next
            SqlDataSource_Update_Status.Update()
            SqlDataSourceUpdate.Update()
            SqlDataSourceUpdateStstus.Update()
            SqlDataSourceUpdateTreatment.Update()
            Response.Redirect("Patient_Search.aspx?def=1.2")
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
End Class
