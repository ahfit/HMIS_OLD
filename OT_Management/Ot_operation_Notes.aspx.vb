Imports System.Data
Imports System.Data.SqlClient
Partial Class Operation_Theater_Ot_operation_Notes
    Inherits System.Web.UI.Page
    Dim Table_Size As Integer = 700
    Dim No_Of_Columns As Integer = 2
    Dim Table_Border As Integer = 1
    Dim Table_ID As String = "Table_Physical_Exam"
    Dim Table_Text_Align As String = "Left"
    Dim Table_Header_Back_Color As String = "#ffcc66"
    Dim Table_Header_Font_Size As Integer = 11
    Dim Table_Row_Color As String = "#ffffff"
    Dim Table_Alternate_row_Color As String = "#ffffcc"
    Dim Already_Save_Element_Color As String = "#d3e1dc"
    Dim List_No_of_Columns As Integer = 2
    Dim Table_Header_Col_Span As Integer = No_Of_Columns * 2
    Dim Control_Size As Integer = Table_Size / (No_Of_Columns * 2)
    Dim Label_Width As Integer = Table_Size / (No_Of_Columns * 2.33)
    Dim Procedure_For_Main As String
    Dim Procedure_For_Main_Group As String = "pt_OT_Page"
    Dim Procedure_For_Sub As String = "Select ev_code,ev_value from admin_OT_ElementValues where e_code = @e_Code and MG_Code=@MG_Code"
    Dim Procedure_For_Insert_Values As String = "Pt_Insert_OT"
    Dim Procedure_for_delete As String = "Delete_OT_saveRecord"
    Dim Procedure_For_Already_Save_Values As String = "OT_Already_Save_Values"
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim dummy As String = ""
    Dim Admin_ConStr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
    Dim ConStr As String = ConfigurationManager.ConnectionStrings("OperationTheaterConnectionString").ConnectionString
    Dim con_admin As New SqlConnection
    Dim con_ot As New SqlConnection
    Dim user_authen As New User_page_Authentication
    Dim classObj As New Draw_Controls
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Check_Controls()
    End Sub
    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged
        Panel1.Controls.Clear()
        HiddenField3.Value = ListBox1.SelectedValue
        Main(HiddenField3.Value, Session("Operation_ID"))

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("~/login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub
  
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Response.Write(Session("Operation_List_Id").ToString())
        'Dim obj_menu As New JavaScriptMenu
        'obj_menu.loginvalidate()
        'LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        'LabelFooter.Text = obj_menu.Footer_String()
        'Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        'loginvalidate(Session("emp_id"), Session("dept_id"))
       
        'HiddenFieldDeptID.Value = 74
        'HiddenFieldSubDeptID.Value = 113

        If Not IsPostBack() Then

            Session("RegistrationNo") = Request.QueryString("RegNo")
            Session("YearlyNo") = Request.QueryString("VisitNo")

            WebDateChooser_date.Text = Convert.ToDateTime(Request.QueryString("DateofOperation")).ToString("yyyy-MM-dd")
            getSlotStartTime()
            ddlSlotTimeStartTime.SelectedItem.Text = Request.QueryString("TimeSlot")
            getAppointmnetSlot(ddlSlotTimeStartTime.SelectedItem.Text)
            getWards()
            Dim str As String = getProcedureAndPackages()
            TextBox_Procedure.Text = str
            'WebDateTimeEdit_Start_Time.Value = Date.Now
            'WebDateTimeEdit_End_Time.Value = Date.Now

            DropDownList_Department.SelectedValue = Session("dept_id")

        End If
        'Response.Write(Session("Operation_ID"))
        'Main(HiddenField3.Value, Session("Operation_ID"))
    End Sub
    

    Sub Main(ByVal MG_Code As Integer, ByVal Template_ID As Integer)
        Try
            con_admin.ConnectionString = Admin_ConStr
            Dim Procedurename As String = Procedure_For_Main_Group
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con_admin)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
            mycommand.Parameters.AddWithValue("@TemplateID", Template_ID)
            con_admin.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds)
            Dim Save_Values As DataSet = Check_Save_Values()
            Check_For_Table_Rows(ds, Save_Values)
        Catch ex As Exception
            Response.Write(ex.Message + "Main Function")
        Finally
            con_admin.Close()
        End Try
    End Sub
    Sub Check_For_Table_Rows(ByVal Elements As DataSet, ByVal Save_Values As DataSet)
        Try
            Dim J As Integer = 0
            For i As Integer = 0 To Elements.Tables(0).Rows.Count - 1
                Dim E_Code As Integer = CInt(Elements.Tables(0).Rows(i).Item("E_Code"))
                Dim E_Name As String = Elements.Tables(0).Rows(i).Item("E_Name")
                Dim MG_Code As Integer = CInt(Elements.Tables(0).Rows(i).Item("MG_Code"))
                Dim Field_Type As String = Elements.Tables(0).Rows(i).Item("e_Field_Type")
                Dim E_ID As String = Elements.Tables(0).Rows(i).Item("E_ID")
                Dim ToolTip As String = Elements.Tables(0).Rows(i).Item("Tooltip")
                Dim Flag As Boolean = False
                Dim Header_Name As String = Return_MG_Name(MG_Code)
                If J = 0 Then
                    Label_For_Table("<table id='" & Table_ID & "' Class='dtable' width ='" & Table_Size & "'><tr bgcolor='" & Table_Header_Back_Color & "'><td colspan='" & Table_Header_Col_Span & "'> <span style=font-size:" & Table_Header_Font_Size & "pt;>" & Header_Name & "</span></td></tr>")
                    Label_For_Table("<tr bgcolor='" & Table_Row_Color & "'>")
                    Phy_Elements_Values(E_Code, E_Name, Field_Type, E_ID, MG_Code, ToolTip, Save_Values)
                ElseIf CInt(Elements.Tables(0).Rows(i - 1).Item("MG_Code") <> Elements.Tables(0).Rows(i).Item("MG_Code")) Then
                    J = 0
                    Label_For_Table("</table><table id='" & Table_ID & "' Class='dtable' width ='" & Table_Size & "'><tr bgcolor='" & Table_Header_Back_Color & "'><td colspan='" & Table_Header_Col_Span & "'> <span style=font-size:" & Table_Header_Font_Size & "pt;>" & Header_Name & "</span></td></tr>")
                    Label_For_Table("<tr bgcolor='" & Table_Row_Color & "'>")
                    Phy_Elements_Values(E_Code, E_Name, Field_Type, E_ID, MG_Code, ToolTip, Save_Values)
                Else
                    If J Mod No_Of_Columns = 0 Then
                        If J Mod (No_Of_Columns * 2) = 0 Then
                            Label_For_Table("</tr><tr bgcolor='" & Table_Row_Color & "'>")
                            Phy_Elements_Values(E_Code, E_Name, Field_Type, E_ID, MG_Code, ToolTip, Save_Values)

                        Else
                            Label_For_Table("</tr><tr bgcolor='" & Table_Alternate_row_Color & "'>")
                            Phy_Elements_Values(E_Code, E_Name, Field_Type, E_ID, MG_Code, ToolTip, Save_Values)
                        End If
                    Else
                        Phy_Elements_Values(E_Code, E_Name, Field_Type, E_ID, MG_Code, ToolTip, Save_Values)
                    End If
                End If
                J += 1
            Next
            Label_For_Table("</table>")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Label_For_Table(ByVal Txt As String)
        Try
            Dim lbl As New Label
            lbl.Text = Txt
            dummy = dummy & Txt
            Panel1.Controls.Add(lbl)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Phy_Elements_Values(ByVal e_code As Integer, ByVal e_name As String, ByVal e_field As String, ByVal e_id As String, ByVal MG_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet)
        Try
            'Dim con As SqlConnection = New SqlConnection(Admin_ConStr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedure_For_Sub, con_admin)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@e_Code", e_code)
            param = mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            Dim Save_Record_Color As String = ""
            Dim coll As Collection = Check_Values(Save_Values, e_code, MG_Code)
            If coll.Item("flag") = True Then
                Save_Record_Color = Already_Save_Element_Color
            End If
            Dim value As String = coll.Item("value")
            Make_Control(ds, e_id, e_name, MG_Code, e_field, Save_Record_Color, e_code, ToolTip, Save_Values, value)
        Catch ex As Exception
            Response.Write(ex.Message & "Hello Asif")
        End Try
    End Sub

    Sub Make_Control(ByVal ds As DataSet, ByVal e_id As String, ByVal e_name As String, ByVal Mg_code As Integer, ByVal e_field As String, ByVal Save_Record_Color As String, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet, ByVal Already_Value As String)
        Try
            Label_For_Table("<td width ='150' bgcolor='" & Save_Record_Color & "'>")
            Make_Label(e_id, e_name, Mg_code, ToolTip)
            Label_For_Table("</td>")
            If e_field = "TextBox" Then
                Label_For_Table("<td width='225' bgcolor='" & Save_Record_Color & "'>")
                Make_TextBox(e_id, E_Code, ToolTip, Save_Values, Already_Value)
                Label_For_Table("</td>")
            ElseIf e_field = "DropDownList" Then
                Label_For_Table("<td width='225' bgcolor='" & Save_Record_Color & "'>")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_DropDownList(ArrayList_RadioButtonList, e_id, Mg_code, E_Code, ToolTip, Save_Values, Already_Value)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "RadioButtonList" Then
                Label_For_Table("<td width='225' bgcolor='" & Save_Record_Color & "'>")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_RadioButtonList(ArrayList_RadioButtonList, e_id, Mg_code, ToolTip, Save_Values, Already_Value)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            ElseIf e_field = "CheckBoxList" Then
                Label_For_Table("<td width='225' bgcolor='" & Save_Record_Color & "'>")
                For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    ArrayList_RadioButtonList.Add(ds.Tables(0).Rows(i).Item(1).ToString)
                    ArrayList_RadioButtonList_ID.Add(ds.Tables(0).Rows(i).Item(0).ToString)
                Next
                Make_CheckBoxLIst(ArrayList_RadioButtonList, e_id, Mg_code, ToolTip, Save_Values, E_Code)
                ArrayList_RadioButtonList.Clear()
                Label_For_Table("</td>")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_Label(ByVal e_id As String, ByVal e_name As String, ByVal MG_Code As Integer, ByVal ToolTip As String)
        Try
            Dim Lbl As New Label
            Lbl.ID = "Label" & e_id
            Lbl.Font.Bold = True
            Lbl.Text = e_name
            Lbl.EnableViewState = True
            Lbl.Width = Control_Size - (No_Of_Columns * 5)
            Lbl.ToolTip = ToolTip
            Panel1.Controls.Add(Lbl)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_TextBox(ByVal E_Id As String, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet, ByVal Already_Value As String)
        Try
            Dim control As New TextBox
            control.ID = "TextBox" & E_Id
            control.EnableViewState = True
            control.Width = Control_Size - 5
            control.ToolTip = ToolTip
            control.Text = Already_Value
            Panel1.Controls.Add(control)
        Catch ex As Exception
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub Make_DropDownList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal E_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet, ByVal Already_Value As String)
        Try
            Dim control As New DropDownList
            control.ID = "DropDOwnList" & E_Id
            control.Items.Add("")
            For i As Integer = 0 To ArrayList_Radio.Count - 1
                control.Items.Add(ArrayList_Radio.Item(i))
                control.DataTextField = ArrayList_Radio.Item(i)
                control.DataValueField = ArrayList_Radio.Item(i)
            Next
            control.ToolTip = ToolTip
            control.SelectedValue = Already_Value
            control.EnableViewState = True
            control.Width = Control_Size
            Panel1.Controls.Add(control)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_RadioButtonList(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet, ByVal Already_Value As String)
        Try
            Dim control As New RadioButtonList
            control.ID = "RadioButtonList" & E_Id
            For i As Integer = 0 To ArrayList_Radio.Count - 1
                control.Items.Add(ArrayList_Radio.Item(i))
                control.DataTextField = ArrayList_Radio.Item(i)
                control.DataValueField = ArrayList_Radio.Item(i)
            Next
            control.EnableViewState = True
            control.Width = Control_Size
            control.RepeatColumns = List_No_of_Columns
            control.RepeatDirection = RepeatDirection.Horizontal
            control.ToolTip = ToolTip
            control.SelectedValue = Already_Value
            Panel1.Controls.Add(control)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Make_CheckBoxLIst(ByVal ArrayList_Radio As ArrayList, ByVal E_Id As String, ByVal MG_Code As Integer, ByVal ToolTip As String, ByVal Save_Values As DataSet, ByVal E_Code As Integer)
        Try
            Dim control As New CheckBoxList
            control.ID = "CheckBoxList" & E_Id
            For i As Integer = 0 To ArrayList_Radio.Count - 1
                control.Items.Add(ArrayList_Radio.Item(i))
                control.DataTextField = ArrayList_Radio.Item(i)
                control.DataValueField = ArrayList_Radio.Item(i)
            Next
            control.Width = Control_Size
            control.EnableViewState = True
            control.RepeatColumns = List_No_of_Columns
            control.RepeatDirection = RepeatDirection.Horizontal
            control.ToolTip = ToolTip
            Panel1.Controls.Add(control)
            Dim value As String = ""
            For i As Integer = 0 To Save_Values.Tables(0).Rows.Count - 1
                Dim ecode As Integer = Save_Values.Tables(0).Rows(i).Item("E_ID")
                Dim mgcode As Integer = Save_Values.Tables(0).Rows(i).Item("body_system_Id")
                If E_Code = ecode And MG_Code = mgcode Then
                    value = Save_Values.Tables(0).Rows(i).Item("Exam_Result")
                    For j As Integer = 0 To control.Items.Count - 1
                        If control.Items(j).Value = value Then
                            control.Items(j).Selected = True
                        End If
                    Next
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Function Return_MG_Name(ByVal MG_Code As Integer) As String
        Dim result As String = ""
        Try
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select MG_Name from Admin_OT_Maingroup where MG_Code = @MG_Code", con_admin)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@MG_Code", MG_Code)
            result = mycommand.ExecuteScalar()
        Catch ex As Exception
            Response.Write(ex.Message + "Return_MG_Name")
        Finally
        End Try
        Return result
    End Function
    Sub Insert_Values(ByVal value As String, ByVal E_ID As String)
        Try
            'Dim con As SqlConnection = New SqlConnection(ConStr)
            con_ot.ConnectionString = ConStr
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedure_For_Insert_Values, con_ot)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo")) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            '------------------------------------------------------------------------------------------
            mycommand.Parameters.AddWithValue("@From_Time", Date.Today)
            mycommand.Parameters.AddWithValue("@To_Time", Date.Today)
            mycommand.Parameters.AddWithValue("@OT_Recommended_ID", Session("Operation_List_Id"))
            'mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            '------------------------------------------------------------------------------------------
            mycommand.Parameters.AddWithValue("@EV_Code", value)
            mycommand.Parameters.AddWithValue("@E_ID", E_ID)
            mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_id"))
            'mycommand.Parameters.AddWithValue("@Counter", Counter)
            con_ot.Open()
            mycommand.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message + "Insert_Values(")
        Finally
            con_ot.Close()
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
                            Insert_Values(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16))
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                    Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                    For j As Integer = 0 To CBL.Items.Count - 1
                        If CBL.Items(j).Selected = True Then
                            Insert_Values(CBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13))
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                    Dim DDL As DropDownList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 13))
                    For j As Integer = 0 To DDL.Items.Count - 1
                        If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                            Insert_Values(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13))
                        End If
                    Next
                ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                    Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)
                    Delete_Values(Mid(Panel1.Controls(i).ID.ToString, 8))
                    If txt.Text.Trim <> "" Then
                        Insert_Values(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8))
                    End If
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Delete_Values(ByVal E_ID As String)
        Try
            con_ot.ConnectionString = ConStr
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedure_for_delete, con_ot)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@E_ID", E_ID)
            con_ot.Open()
            mycommand.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message + "Delete_Values")
        Finally
            con_ot.Close()
        End Try
    End Sub

    Function Check_Save_Values() As DataSet
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        Try
            con_ot.ConnectionString = ConStr
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedure_For_Already_Save_Values, con_ot)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            con_ot.Open()
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con_ot.Close()
        End Try
        Return ds
    End Function
    Function Check_Values(ByVal ds As DataSet, ByVal E_Code As Integer, ByVal Mg_Code As Integer) As Collection
        Dim coll As New Collection
        Dim flag As Boolean = False
        Dim value As String = ""
        Try
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim ecode As Integer = ds.Tables(0).Rows(i).Item("E_Code")
                Dim mgcode As Integer = ds.Tables(0).Rows(i).Item("MG_Code")
                If E_Code = ecode And Mg_Code = mgcode Then
                    flag = True
                    value = ds.Tables(0).Rows(i).Item("EV_Code").ToString
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        coll.Add(value, "value")
        coll.Add(flag, "flag")
        Return coll
    End Function

    Protected Sub dtlOpeartionNotes_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dtlOpeartionNotes.SelectedIndexChanged
        Session.Add("Operation_Id", dtlOpeartionNotes.SelectedValue)
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        SqlDataSource_ot_Pt_Staff.Insert()
        GridView_Ot_Pt_Staff.DataBind()
        lblMessage.Text = "Staff Detail is Added"
        ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "showModal();", True)
    End Sub

    
    Protected Sub Button_Noting_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Noting.Click
        
        SaveOTPerformed()

        TextBox_Closure.Text = ""
        TextBox_Complication.Text = ""
        TextBox_Description.Text = ""
        TextBox_Drain.Text = ""
        TextBox_Fluids_Infused.Text = ""
        TextBox_Operation_Findings.Text = ""
        TextBox_Procedure.Text = ""
        TextBox_Specimen_Collected.Text = ""


    End Sub
    Protected Sub TextBox_Operation_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Operation.TextChanged
        Try


            Dim count As Integer = 0
            Dim flag As Integer = 0
            If get_ID(TextBox_Operation.Text.Trim) <> 0 Then


                If ListBox_OperationName.Items.Count = 0 Then
                    ListBox_OperationName.Items.Add(TextBox_Operation.Text.Trim)
                    ListBox_OperationName.Items(count).Value = get_ID(TextBox_Operation.Text.Trim)
                End If

                For count = 1 To ListBox_OperationName.Items.Count
                    If (ListBox_OperationName.Items(count - 1).Text.Trim = TextBox_Operation.Text.Trim) Then
                        flag = 1
                    End If
                Next

                If flag <> 1 Then
                    ListBox_OperationName.Items.Add(TextBox_Operation.Text.Trim)
                    ListBox_OperationName.Items(ListBox_OperationName.Items.Count - 1).Value = get_ID(TextBox_Operation.Text.Trim)
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub
    Function get_ID(ByVal str As String) As Integer
        Try

            Dim id As Integer
            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("OperationTheaterConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandText = "SELECT Procedure_id FROM Procedure_Name WHERE Procedure_Name ='" + str + "'"
            connection.Open()
            reader = command.ExecuteReader()
            If reader.Read Then
                id = reader.Item(0)
            Else
                id = 0
            End If
            reader.Close()
            connection.Close()
            Return id
        Catch ex As Exception
        End Try
    End Function
    Sub insert()

        Try


            Dim constr As String = ConfigurationManager.ConnectionStrings("OperationTheaterConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("SELECT Op_Recommended_Id  FROM OT_Operation_List WHERE (Operation_List_Id = @Operation_List_ID)", con)
            command.CommandType = CommandType.Text

            command.Parameters.AddWithValue("@Operation_List_ID", Session("Operation_List_Id"))
            
            con.Open()

            Dim reader As SqlDataReader = command.ExecuteReader()
            While reader.Read
                HiddenField_OP_Recommended_Id.Value = reader.Item("Op_Recommended_Id").ToString()
            End While

            con.Close()


            For count As Integer = 0 To ListBox_OperationName.Items.Count - 1
                Dim command1 As SqlCommand = New SqlCommand("pro_Pt_Recommended_Procedures", con)
                command1.CommandType = CommandType.StoredProcedure
                con.Open()
                command1.Parameters.AddWithValue("@OP_Recommended_Id", HiddenField_OP_Recommended_Id.Value)
                command1.Parameters.AddWithValue("@Procedure_id", ListBox_OperationName.Items(count).Value)
                command1.ExecuteNonQuery()
                con.Close()
            Next



        Catch ex As Exception
            Response.Write(ex.Message.ToString())
        End Try

    End Sub
    Protected Sub Button_Save_Proceedure_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save_Proceedure.Click
        Try
            insert()
            'SqlDataSource_Save_Info.Insert()
            Label_Message.ForeColor = Drawing.Color.Blue
            Label_Message.Text = "Your Information Saved"

        Catch ex As Exception
            Label_Message.ForeColor = Drawing.Color.Red
            Label_Message.Text = "Your Information Not Saved"
            Response.Write(ex.Message)
        End Try
    End Sub

    Private Sub getSlotStartTime()
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("select convert(nvarchar,CAST(timeslot as time),100) as TimeSlot,TimeSlotID from timeslot_forot", con)

            command.CommandType = CommandType.Text

            Dim da As SqlDataAdapter = New SqlDataAdapter(command)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)

            ddlSlotTimeStartTime.DataSource = dt
            ddlSlotTimeStartTime.DataTextField = "TimeSlot"
            ddlSlotTimeStartTime.DataValueField = "TimeSlotID"
            ddlSlotTimeStartTime.DataBind()
        Catch ex As Exception

        End Try


    End Sub



    Private Sub getAppointmnetSlot(ByRef slotTime As String)
        Dim constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("uspGetOT_TimeSlots_ForOT_Performed_am", con)

        command.CommandType = CommandType.StoredProcedure

        command.Parameters.AddWithValue("@datetime", Convert.ToDateTime(WebDateChooser_date.Text))
        command.Parameters.AddWithValue("@timeslotStart", slotTime)
        Dim da As SqlDataAdapter = New SqlDataAdapter(command)
        Dim dt As DataTable = New DataTable()
        da.Fill(dt)

        ddlTimeSlot.DataSource = dt
        ddlTimeSlot.DataTextField = "TimeSlot"
        ddlTimeSlot.DataValueField = "TimeSlotID"
        ddlTimeSlot.DataBind()

        con.Open()
    End Sub

    Private Function getProcedureAndPackages() As String
        Dim str As String = ""
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("OT_Select_Appointment_For_OTPerformed_am", con)

        command.CommandType = CommandType.StoredProcedure

        command.Parameters.AddWithValue("@Order_ID", Request.QueryString("OrderId"))
        command.Parameters.AddWithValue("@regno", Request.QueryString("RegNo"))
        command.Parameters.AddWithValue("@yearlyno", Request.QueryString("VisitNo"))
        Dim da As SqlDataAdapter = New SqlDataAdapter(command)
        Dim dt As DataTable = New DataTable()
        da.Fill(dt)

        If dt.Rows.Count > 0 Then
            For index = 0 To dt.Rows.Count - 1
                str += dt.Rows(index)("Procedure").ToString()
            Next

        End If
        Return str
    End Function





    Protected Sub ddlSlotTimeStartTime_SelectedIndexChanged(sender As Object, e As EventArgs)
        getAppointmnetSlot(ddlSlotTimeStartTime.SelectedItem.Text)
    End Sub

    Private Sub getWards()
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("select ward_id,ward_name from admin_Hospital_Wards", con)
        command.CommandType = CommandType.Text
        Dim da As SqlDataAdapter = New SqlDataAdapter(command)
        Dim dt As DataTable = New DataTable()
        da.Fill(dt)

        DropDownList_Shift_To.DataSource = dt
        DropDownList_Shift_To.DataTextField = "ward_name"
        DropDownList_Shift_To.DataValueField = "ward_id"
        DropDownList_Shift_To.DataBind()


    End Sub

    Private Sub SaveOTPerformed()
        Try


            Dim constr As String = ConfigurationManager.ConnectionStrings("OperationTheaterConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("uspSaveOTPerformed_am", con)
            con.Open()
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@OrderID", Request.QueryString("OrderId"))
            command.Parameters.AddWithValue("@Performed_Datetime", DateTime.Now)
            command.Parameters.AddWithValue("@OT_Finding", TextBox_Operation_Findings.Text)
            command.Parameters.AddWithValue("@OT_Procedure", TextBox_Procedure.Text)
            command.Parameters.AddWithValue("@OT_Complication", TextBox_Complication.Text)
            command.Parameters.AddWithValue("@OT_Closure", TextBox_Closure.Text)
            command.Parameters.AddWithValue("@OT_Drain", TextBox_Drain.Text)
            command.Parameters.AddWithValue("@OT_OtherInfo", "")
            command.Parameters.AddWithValue("@OT_DataEntry_By", Session("emp_id"))
            command.Parameters.AddWithValue("@Specimen_Collected", TextBox_Specimen_Collected.Text)
            command.Parameters.AddWithValue("@Fluids_Infused", TextBox_Fluids_Infused.Text)
            command.Parameters.AddWithValue("@Operation_List_Id", Convert.ToInt32(Request.QueryString("OrderId")))
            command.Parameters.AddWithValue("@Opertion_StartTime", ddlSlotTimeStartTime.SelectedItem.Text)
            command.Parameters.AddWithValue("@Operation_EndTime", ddlTimeSlot.SelectedItem.Text)
            command.Parameters.AddWithValue("@Anesthesia_Type", DropDownList_Anesthesia_Type.SelectedItem.Text)
            command.Parameters.AddWithValue("@Shift_To", DropDownList_Shift_To.SelectedItem.Text)

            command.ExecuteNonQuery()
            con.Close()
            lblMessage.Text = "Patient OT Performed"
            ScriptManager.RegisterStartupScript(Me, Me.GetType(), "Pop", "showModal();", True)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub



    Protected Sub btnReport_Click(sender As Object, e As EventArgs)
        Response.Redirect("OTNotesReport.aspx?OrderId=" + Request.QueryString("OrderId") + "&VisitNo=" + Request.QueryString("VisitNo") + "&RegNo=" + Request.QueryString("RegNo") + "")
    End Sub
End Class
