Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_Pt_Presenting_Complaint
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Dim ENC As New Encryption
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList

    Protected Sub ButtonSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearch.Click
        ListBox1.DataBind()
        
    End Sub

    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
        
        Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        
        '''''''''''''''''''''
        ''''''''''''''''''''''   for Remarks
        '''''''''''''''''''''

        'for_remarks()
        DataList_remarks.DataBind()

        '''''''''''''''''''''''''
        ''''''''''''''''''''''''
        '''''''''''''''''''''''''
        LabelComplaint.Text = ""
        Panel1.Controls.Clear()
        'loginvalidate(Session("emp_id"), Session("dept_id"))
        HiddenFieldTemplate_id.Value = get_template_id()
        If ((Session("registrationNo") Is Nothing) And (Session("YearlyNo") Is Nothing)) Then
            Session.Add("registrationNo", Request.QueryString("RegNo"))
            Session.Add("YearlyNo", Request.QueryString("PayID"))
        Else
        End If
        If Not Page.IsPostBack = True Then
            If Not HiddenFieldComplaint_ID.Value = "" Then
                Chech_For_Cheif_Complaint()
                Dim Dss As DataSet = Already_Save_Element_for_Color()
                Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
            End If
        Else
            If Not HiddenFieldComplaint_ID.Value = "" Then
                Dim Dss As DataSet = Already_Save_Element_for_Color()
                Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
            End If
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
    Function get_template_id() As Integer
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString.ToString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("SELECT Template_Id FROM Admin_Assign_Template WHERE (Dept_id = @Dept_id) AND (subdept_id = @subdept_id)", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@Dept_id", Session("dept_id"))
            command.Parameters.AddWithValue("@subdept_id", Session("SubDeptID"))
            con.Open()
            Dim b As Integer = command.ExecuteScalar()
            Dim count As Integer = 0
            If b = 0 Then
                count = 0
            Else
                count = b
            End If
            Return count
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Function

    Protected Sub ListBox1_SesslectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged
        Panel1.Controls.Clear()
        Dim X As System.Web.UI.WebControls.ListItem = ListBox1.SelectedItem
        If Not ListBox2.Items.Contains(X) Then
            ListBox2.Items.Add(X)
            ListBox2.SelectedValue = Nothing

        End If
        TextBox_Remarks.Text = ""
    End Sub

    Protected Sub ListBox2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox2.PreRender
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("SELECT DISTINCT Admin_Complaint_MainGroup.Complaint_Name +' '+ isnull(Convert(varchar,Pt_Presenting_Complaint_saveRecord.Duration),'')+' '+ isnull(Pt_Presenting_Complaint_saveRecord.Duration_Time,'') as [Complaint_Name] , Admin_Complaint_MainGroup.Complaint_ID, ISNULL(Pt_Presenting_Complaint_saveRecord.Chief_Complaint, 0) AS Expr1 FROM         Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID  WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            Dim i As Integer = 0
            If Not Page.IsPostBack Then
                ButtonRemove.Visible = False
                ButtonEdit.Visible = False
                While reader.Read
                    Dim Y As New System.Web.UI.WebControls.ListItem
                    Y.Text = reader.Item(0).ToString
                    Y.Value = reader.Item(1).ToString
                    If reader.Item(2) = "1" Then
                        Y.Attributes.Add("style", "color:red")
                    End If
                    ListBox2.Items.Add(Y)
                    'Dim Z As New System.Web.UI.WebControls.DataListItem(i, ListItemType.Item)
                    'Z.DataItem = reader.Item(0).ToString
                    'Z.ID = reader.Item(1).ToString
                    'DataList1.Controls.Add(Z)
                    'DataList1.DataBind()
                    'i += 1
                End While

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub ListBox2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox2.SelectedIndexChanged
        LabelComplaint.Text = ListBox2.SelectedItem.Text
        HiddenFieldComplaint_ID.Value = ListBox2.SelectedValue 'LabelComplaintID.Text
        Label_name.Text = ListBox2.SelectedItem.Text
        Chech_For_Cheif_Complaint()

        Panel1.Controls.Clear()
        Dim Dss As DataSet = Already_Save_Element_for_Color()
        Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
        Try
           

            Dim dv As DataView = DirectCast(SqlDataSource2.Select(DataSourceSelectArguments.Empty), DataView)

            If dv.Table.Rows.Count <> 0 Then
                TextBox_Remarks.Text = dv.Table.Rows(0)(0).ToString

            Else
                TextBox_Remarks.Text = ""

            End If

        Catch ex As Exception

        End Try
        ButtonRemove.Visible = True
        ButtonEdit.Visible = True
    End Sub
    Sub Chech_For_Cheif_Complaint()
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT ISNULL(Chief_Complaint, 0) AS Chief_Complaint FROM Pt_Presenting_Complaint_saveRecord WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Complaint_ID = @Complaint_ID)", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        command.Parameters.AddWithValue("@Complaint_ID", HiddenFieldComplaint_ID.Value)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            While reader.Read
                If reader.Item(0) = True Then
                    CheckBox1.Checked = True
                Else
                    CheckBox1.Checked = False
                End If
            End While
        Else
            CheckBox1.Checked = False
        End If
    End Sub
    Protected Sub ButtonRemove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonRemove.Click
        If ListBox2.SelectedValue <> "" Then
            Panel1.Controls.Clear()
            Remove_Complaint_Detail(ListBox2.SelectedValue)
        End If

    End Sub

    Sub Phy_Elements(ByVal MG_Code As Integer, ByVal Already_Save_Values As DataSet)
        Dim a As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_Hopi_Page_new", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code) 'Session("BMIPayID")
        'Response.Write(HiddenFieldComplaint_ID.Value)
        'mycommand.Parameters.AddWithValue("@templateid", template_id)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        Dim j As Integer = 0
        Dim fl As Boolean = False
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            If i = 0 Then
                fl = True
                Label_For_Table("<table id='Table_Phy_Exam' Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>")
                Label_For_Table("<tr bgcolor='#bebebe' ><td colspan='5' style='color:#990000; font-weight:normal; text-align:left;' ></td></tr>") 'ds.Tables(0).Rows(i).Item(6).ToString font-weight: bold;
                Check_For_Table_Rows(MG_Code, i, j, ds, Already_Save_Values)
            ElseIf i <> 0 Then
                If ds.Tables(0).Rows(i - 1).Item(4).ToString <> ds.Tables(0).Rows(i).Item(4).ToString Then
                    Label_For_Table("</table>")
                    Label_For_Table("<table id='Table_Phy_Exam'  Class='Grid_dynamic' border='0' cellspacing='0' cellpadding='0' width ='100%'>")
                    Label_For_Table("<tr bgcolor='#dcdcdc' font-size: 12pt; style='color: Black; '><td colspan='5' >" & "</td></tr>")

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
                    Label_For_Table("<tr bgcolor='#dcdcdc'>")
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
                    Label_For_Table("<tr bgcolor='#dcdcdc'>")
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
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Sub_Type_ID, Component_Name, priority FROM Admin_Complaint_Elementvalue WHERE  (Sub_Type_ID = @e_Code) and (Complaint_ID=@Complaint_ID) ORDER BY priority", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        'Response.Write(e_code)
        param = mycommand.Parameters.AddWithValue("@e_Code", e_code) 'Session("BMIPayID")
        param = mycommand.Parameters.AddWithValue("@Complaint_ID", MG_Code)
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
            Label_For_Table("<td width='100' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
            Next
            Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, Already_Save_Values, Tooltip)
            ArrayList_RadioButtonList.Clear()
            Label_For_Table("</td>")
        ElseIf e_field = "CheckBoxList" Then
            Label_For_Table("<td width='100' bgcolor='" & Save_Record_Color & "'>" & Test_Date_Time)
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
        Lbl.Width = 100
        Lbl.ToolTip = Tooltip
        Lbl.CssClass = "small_f"
        Panel1.Controls.Add(Lbl)
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal Already_Save_Values As DataSet, ByVal E_Code As Integer, ByVal Tooltip As String, ByVal e_name As String)
        Dim control As New TextBox
        control.ID = "TextBox" & E_Id
        control.EnableViewState = True
        control.Width = 100
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
        control.Width = 100
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
        control.Width = 100
        control.RepeatColumns = 2
	    control.RepeatDirection = RepeatDirection.Horizontal
		control.RepeatLayout = RepeatLayout.Flow
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
        control.Width = 100
        control.EnableViewState = True
        control.RepeatColumns = 2
        control.RepeatDirection = RepeatDirection.Horizontal
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
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT pt_Save_Presenting_Complaints.Complaint_ID, pt_Save_Presenting_Complaints.Sub_Type_ID, pt_Save_Presenting_Complaints.ComponentName,Admin_Complaint_Element.Sub_Type_ID AS Expr1, Admin_Complaint_Element.Control_Field + Admin_Complaint_Element.e_id AS Expr2,Admin_Complaint_Element.Control_Field,CONVERT(varchar, pt_Save_Presenting_Complaints.datetime, 107) AS date, CONVERT(varchar, pt_Save_Presenting_Complaints.datetime, 108) AS time  FROM pt_Save_Presenting_Complaints INNER JOIN Admin_Complaint_Element ON pt_Save_Presenting_Complaints.Sub_Type_ID = Admin_Complaint_Element.Sub_Type_ID WHERE (pt_Save_Presenting_Complaints.YearlyNo = @YearlyNo) AND (pt_Save_Presenting_Complaints.RegNo = @RegNo)", con)
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
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        'mycommand.Parameters.AddWithValue("@Exam_Result", value)
        mycommand.Parameters.AddWithValue("@E_ID", E_ID)
        'mycommand.Parameters.AddWithValue("@Counter", Counter)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()

    End Sub

    Protected Sub Save_Complaint()
        Try
            If CheckBox1.Checked = True Then
                HiddenFieldChief_Complaint.Value = 1
            Else
                HiddenFieldChief_Complaint.Value = 0
            End If
            SqlDataSourceSave.Insert()
            If TextBoxDuration.Text <> "" Then
                SqlDataSource_select_all.Update()
            End If

            'CheckBox1.Checked = False
            'Response.Write(Panel1.Controls.Count)
            Check_Controls()
            'Response.Write(Panel1.Controls.Count)
            If HiddenFieldComplaint_ID.Value <> "" Then
                SqlDataSource2.Insert()
                DataList_remarks.DataBind()
                'ListBox2_SelectedIndexChanged(Nothing, Nothing)
                'ListBox2.SelectedValue = HiddenFieldComplaint_ID.Value
                'for_remarks()
                Panel1.Controls.Clear()
                Dim Dss As DataSet = Already_Save_Element_for_Color()
                Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Save_Complaint()
    End Sub

    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged
        Dim lblcom As LinkButton = DataList1.Items(DataList1.SelectedIndex).FindControl("LinkButtonName")
        LabelComplaint.Text = lblcom.Text
        HiddenFieldComplaint_ID.Value = DataList1.SelectedValue 'LabelComplaintID.Text
        Chech_For_Cheif_Complaint()
        Panel1.Controls.Clear()
        Dim Dss As DataSet = Already_Save_Element_for_Color()
        Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
    End Sub

    Protected Sub LinkButton_Add_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Add.Click
        If LinkButton_Add.Text = "Add" Then
            Try
                Dim da As New SqlDataAdapter
                Dim ds As New DataSet
                Dim ENC As New Encryption
                Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
                Dim con As SqlConnection = New SqlConnection(constr)
                con.Open()
                Dim command As SqlCommand = New SqlCommand("SELECT  distinct Admin_Complaint_MainGroup.Complaint_Name, Admin_Complaint_MainGroup.Complaint_Name +' ' + isnull(Convert(varchar,Pt_Presenting_Complaint_saveRecord.Duration),'') +' '+ isnull(Pt_Presenting_Complaint_saveRecord.Duration_Time,'') as [Complaint Val], Admin_Complaint_MainGroup.Complaint_ID, Admin_Complaint_MainGroup.Pirority FROM Admin_Complaint_MainGroup INNER JOIN Admin_Template_Presenting_Complaints ON Admin_Complaint_MainGroup.Complaint_ID = Admin_Template_Presenting_Complaints.Complaint_Id INNER JOIN Admin_Assign_Template ON Admin_Template_Presenting_Complaints.Template_Id = Admin_Assign_Template.Template_Id INNER JOIN Pt_Presenting_Complaint_saveRecord ON Admin_Complaint_MainGroup.Complaint_ID = Pt_Presenting_Complaint_saveRecord.Complaint_ID   WHERE Admin_Complaint_MainGroup.Complaint_Name = @Name ORDER BY Admin_Complaint_MainGroup.Complaint_Name asc", con)
                command.CommandType = CommandType.Text
                command.Parameters.AddWithValue("@Name", TextBoxComplaint_Name.Text)
                da.SelectCommand = command
                da.Fill(ds)
                con.Close()
                If ds.Tables(0).Rows.Count <> 0 Then
                    For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                        If TextBoxDuration.Text <> "" Then
                            ListBox2.Items.Insert(0, ds.Tables(0).Rows(i).Item(0) + " " + TextBoxDuration.Text + " " + DropDownListDuration.Text)
                            ListBox2.Items(0).Value = ds.Tables(0).Rows(i).Item(2)
                            HiddenFieldComplaint_ID.Value = ds.Tables(0).Rows(i).Item(2)
                        End If
                        Exit For
                    Next
                Else
                    If TextBoxComplaint_Name.Text.Length >= 2 Then
                        If TextBoxDuration.Text <> "" Then
                            SqlDataSource_select_all.Insert()
                            ListBox2.Items.Insert(0, TextBoxComplaint_Name.Text + " " + TextBoxDuration.Text + " " + DropDownListDuration.Text)
                            ListBox2.Items(0).Value = HiddenField_Complaint_new.Value

                        End If
                    End If
                End If


            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            'Response.Write(HiddenFieldComplaint_ID.Value)
            'HiddenFieldComplaint_ID.Value = HiddenField_Complaint_new.Value
            Save_Complaint()
        Else
            Update_Complaint_Detail(ListBox2.SelectedValue)
            ButtonEdit.Visible = True
			 ButtonRemove.Visible = True
        End If

    End Sub

    Protected Sub SqlDataSource_select_all_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_select_all.Inserted
        HiddenField_Complaint_new.Value = e.Command.Parameters("@Complaint_ID_new").Value
        HiddenFieldComplaint_ID.Value = HiddenField_Complaint_new.Value

    End Sub

    Protected Sub DataList_remarks_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_remarks.SelectedIndexChanged
        Try


            Dim hid As HiddenField = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("HiddenField_Complaint_ID")
            Dim lab As Label = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("Complaint_NameLabel")
            Dim lab_detail As LinkButton = DataList_remarks.Items(DataList_remarks.SelectedIndex).FindControl("LinkButton_Description")

            HiddenFieldComplaint_ID.Value = hid.Value
            Label_name.Text = lab.Text
            Chech_For_Cheif_Complaint()

            Panel1.Controls.Clear()
            Dim Dss As DataSet = Already_Save_Element_for_Color()
            Phy_Elements(HiddenFieldComplaint_ID.Value, Dss)
            TextBox_Remarks.Text = lab_detail.Text

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub ButtonEdit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonEdit.Click

        Panel1.Controls.Clear()
        'ListBox2.Items.Remove(ListBox2.SelectedItem)
        Load_Controls(ListBox2.SelectedValue)
    End Sub
    Protected Sub Load_Controls(ByVal selectedVal As Integer)
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim qry As String = "SELECT Pt_Presenting_Complaint_saveRecord.Duration, Pt_Presenting_Complaint_saveRecord.Duration_Time, Admin_Complaint_MainGroup.Complaint_Name FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo) AND (Pt_Presenting_Complaint_saveRecord.Complaint_ID = @Complaint_ID)"
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        command.Parameters.AddWithValue("@Complaint_ID", HiddenFieldComplaint_ID.Value)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            While reader.Read
                TextBoxDuration.Text = reader.Item("Duration")
                DropDownListDuration.DataBind()
                DropDownListDuration.SelectedValue = reader.Item("Duration_Time")
                TextBoxComplaint_Name.Text = reader.Item("Complaint_Name")
                TextBoxComplaint_Name.Enabled = False
                LinkButton_Add.Text = "Update"
                LinkButton_Cancel.Visible = True
                ButtonEdit.Visible = True
            End While
        End If
        con.Close()
    End Sub

    Protected Sub Remove_Complaint_Detail(ByVal complaint_ID As Integer)
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim sp As String = "Remove_Pt_presenting_Complaint"
        Dim command As SqlCommand = New SqlCommand(sp, con)
        command.CommandType = CommandType.StoredProcedure

        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        command.Parameters.AddWithValue("@Complaint_ID", complaint_ID)
        con.Open()
        command.ExecuteNonQuery()
        con.Close()
        ListBox2.DataBind()
        ListBox2.Items.Clear()
        LoadDate_ListBox()


    End Sub
    Protected Sub Update_Complaint_Detail(ByVal complaint_ID As Integer)
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim qry As String = "update Pt_Presenting_Complaint_saveRecord set Duration = @Duration, Duration_Time = @Duration_Time WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo) AND (Complaint_ID = @Complaint_ID)"
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text

        command.Parameters.AddWithValue("@Duration", TextBoxDuration.Text)
        command.Parameters.AddWithValue("@Duration_Time", DropDownListDuration.SelectedValue)
        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        command.Parameters.AddWithValue("@Complaint_ID", complaint_ID)
        con.Open()
        command.ExecuteNonQuery()
        con.Close()
        ListBox2.DataBind()
        ListBox2.Items.Clear()
        LoadDate_ListBox()
        Clear()

    End Sub
    Protected Sub LinkButton_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Cancel.Click
        Clear()
        ButtonEdit.Visible = True
    End Sub
    Protected Sub Clear()
        LinkButton_Cancel.Visible = False
        LinkButton_Add.Text = "Add"
        TextBoxDuration.Text = ""
        DropDownListDuration.DataBind()
        DropDownListDuration.SelectedIndex = 0
        TextBoxComplaint_Name.Text = ""
        TextBoxComplaint_Name.Enabled = True

    End Sub
    Protected Sub LoadDate_ListBox()
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT DISTINCT Admin_Complaint_MainGroup.Complaint_Name +' '+ isnull(Convert(varchar,Pt_Presenting_Complaint_saveRecord.Duration),'')+' '+ isnull(Pt_Presenting_Complaint_saveRecord.Duration_Time,'') as [Complaint_Name] , Admin_Complaint_MainGroup.Complaint_ID, ISNULL(Pt_Presenting_Complaint_saveRecord.Chief_Complaint, 0) AS Expr1 FROM         Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID  WHERE (Pt_Presenting_Complaint_saveRecord.YearlyNo = @YearlyNo) AND (Pt_Presenting_Complaint_saveRecord.RegNo = @RegNo)", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        Dim i As Integer = 0

        While reader.Read
            Dim Y As New System.Web.UI.WebControls.ListItem
            Y.Text = reader.Item(0).ToString
            Y.Value = reader.Item(1).ToString
            If reader.Item(2) = "1" Then
                Y.Attributes.Add("style", "color:red")
            End If
            ListBox2.Items.Add(Y)

        End While

        ButtonRemove.Visible = False
        ButtonEdit.Visible = False
        'HiddenFieldComplaint_ID.Value = ""
    End Sub


End Class
