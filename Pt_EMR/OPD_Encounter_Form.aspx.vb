Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Services
Imports System.Web.Script.Serialization
Imports Infragistics.WebUI.WebSchedule
Imports DBClass
Imports DbManager

Partial Class OPD_Encounter_Form
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim Alternate_Row_Color As String
    Dim ArrayList_RadioButtonList, ArrayList_RadioButtonList_ID As New ArrayList
    Dim Element_Name As String

    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim conStore As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Dim constr_TreatmentAdmin As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
    Dim Path_constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim conRad As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString

    Sub child(ByVal chap_No As Integer)
        'Try
        '    Dim str As String
        '    Dim conn As New SqlConnection
        '    Dim con As SqlCommand
        '    Dim reader As SqlDataReader
        '    conn.ConnectionString = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
        '    con = conn.CreateCommand

        '    con.CommandText = "SELECT DISTINCT Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL,Admin_User_Module_Pages.Priority,Admin_Employee_Module_Pages.Page_ID FROM Admin_Employee_Module_Pages INNER JOIN Admin_User_Module_Pages ON Admin_Employee_Module_Pages.Page_ID = Admin_User_Module_Pages.Page_ID join Admin_User_Module on Admin_User_Module.Module_ID=Admin_User_Module_Pages.Module_ID WHERE  (Admin_Employee_Module_Pages.Emp_ID = " + chap_No.ToString + ") and Admin_User_Module.Module_Name in('Treatment') ORDER BY Admin_User_Module_Pages.Priority "

        '    str = con.CommandText

        '    conn.Open()
        '    reader = con.ExecuteReader

        'While reader.Read

        '    If reader.Item(0).ToString = "Examination" Then
        '        'HiddenField_root.Value = "Examination"
        '        Dim childTreeNode As New TreeNode
        '        childTreeNode.Text = reader.Item(0)
        '        childTreeNode.Value = ""
        '        Subchild(childTreeNode, reader.Item(1), "Phy")
        '        TreeView1.Nodes.Add(childTreeNode)
        '    ElseIf reader.Item(0).ToString = "History" Then
        '        'HiddenField_root.Value = "History"
        '        Dim childTreeNode As New TreeNode
        '        childTreeNode.Text = reader.Item(0)
        '        childTreeNode.Value = ""
        '        Subchild(childTreeNode, reader.Item(1), "His")
        '        TreeView1.Nodes.Add(childTreeNode)
        '    End If
        'End While
        'reader.Close()
        '    conn.Close()

        'Catch ex As Exception

        'End Try

    End Sub

    Sub Subchild(ByVal childTreeNode As TreeNode, ByVal Section As String, ByVal type As String)
        Try

            Dim str As String
            Dim conn As New SqlConnection
            Dim con As SqlCommand
            Dim reader As SqlDataReader
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
            con = conn.CreateCommand
            If type = "His" Then
                con.CommandText = "SELECT DISTINCT Admin_History_Main_Heading.MH_Heading, Admin_History_Main_Heading.Priority, Admin_History_Main_Heading.MH_Code FROM Admin_History_Main_Heading INNER JOIN Admin_History_MainHeading_Group ON Admin_History_Main_Heading.MH_Code = Admin_History_MainHeading_Group.MH_Code WHERE (Admin_History_Main_Heading.TemplateId = @Template_Id)"
            ElseIf type = "Phy" Then
                con.CommandText = "SELECT DISTINCT Admin_Exam_Main_Heading.MH_Heading, Admin_Exam_Main_Heading.Priority, Admin_Exam_Main_Heading.MH_Code FROM Admin_Exam_Main_Heading INNER JOIN Admin_Exam_MainHeading_Group ON Admin_Exam_Main_Heading.MH_Code = Admin_Exam_MainHeading_Group.MH_Code  WHERE Admin_Exam_Main_Heading.TemplateId = @Template_Id and Admin_Exam_Main_Heading.Type=1 ORDER BY Admin_Exam_Main_Heading.Priority"
            End If
            Dim templateId As Integer
            Dim objTemp As JavaScriptMenu = New JavaScriptMenu()
            templateId = objTemp.Template_id()
            con.Parameters.AddWithValue("@Template_Id", templateId)

            str = con.CommandText

            conn.Open()
            reader = con.ExecuteReader
            While reader.Read
                Dim subchildTreeNode As New TreeNode
                subchildTreeNode.Text = reader.Item(0)
                subchildTreeNode.Value = reader.Item(2)
                childTreeNode.ChildNodes.Add(subchildTreeNode)
            End While
            reader.Close()
            conn.Close()

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'this.Header.Controls.Add(new LiteralControl(js.ToString()));

        Dim Obj_Menu As New JavaScriptMenu

        Obj_Menu.loginvalidate()



        Dim xml_val As New GenerateXML
        xml_val.ConStr = "TreatmentConnectionString"
        xml_val.OPD_Encounter_Medication(Session("registrationNo"), Session("YearlyNo"), "OPD_Encounter_Medication")
        XmlDataSource_Medicine.DataBind()


        LabelFooter.Text = Obj_Menu.Footer_String()
        WebDateChooserStartDate.Value = Date.Now.ToString("yyyy-MM-dd")
        WebDateChooserEndDate.Value = Date.Now.AddDays(1).ToString("yyyy-MM-dd")
        ''''''''''''''''''''''''''''''''''''''
        GridView_Medicine.DataBind()

        If Not IsPostBack Then
            If ((Session("registrationNo") Is Nothing) And (Session("YearlyNo") Is Nothing)) Then
                Session.Add("registrationNo", Request.QueryString("RegNo"))
                Session.Add("YearlyNo", Request.QueryString("PayID"))
            End If

            SideMenu.Text = Obj_Menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
            ' LabelSideMenu.Text = Obj_Menu.SideMenuForEncounterForm(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

            'labaelExamination.Text = Obj_Menu.SideMenuForExaminatin(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

            txtboxDate.Text = DateTime.Now.ToString("yyyy-MM-dd")
            txtboxStart.Text = DateTime.Now.ToString("hh:mm")
            txtboxEnd.Text = DateTime.Now.ToString("hh:mm")



            getConsultant()
            getPatientGeneralInformation()
            getDepartmentWiseDiagnosis()
            getMedinceDepartmentWise()
            child(Session("emp_id"))

            get_pt_Treatment_Pan()
            get_pt_Treatment_PlanForReferals()

            DataList_Test.DataBind()

            DataList_Radiology.DataBind()
            getPatientPreviousMedicine()
            DataListPreviousTestParent.DataBind()
            GetddlDept()
            GetddlEMPL()
        End If

        get_Color()
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        GridView_Medicine.DataBind()

        DataList_CurrentVisitDiagnosis.DataBind()
        Fill_Grid()
    End Sub

    Sub Fill_Grid()
        Dim ds As New PatientVital
        Dim da As New PatientVitalTableAdapters.Patient_VitalsTableAdapter
        Dim da1 As New PatientVitalTableAdapters.VitalGridTableAdapter
        da.Fill(ds.Tables("Patient_Vitals"), Session("registrationNo"), Session("YearlyNo"))
        da1.Fill(ds.Tables("vitalGrid"), Session("registrationNo"), Session("YearlyNo"))
        For i As Integer = 0 To ds.Tables("Patient_Vitals").Rows.Count - 1
            For j As Integer = 0 To ds.Tables("vitalGrid").Rows.Count - 1
                If ds.Tables("Patient_Vitals").Rows(i).Item("Date") = ds.Tables("vitalGrid").Rows(j).Item("Date") And ds.Tables("Patient_Vitals").Rows(i).Item("Time") = ds.Tables("vitalGrid").Rows(j).Item("Time") Then
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 8 Then
                        ds.Tables("vitalGrid").Rows(j).Item("Pluse") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 6 Then
                        ds.Tables("vitalGrid").Rows(j).Item("BPHigh") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 7 Then
                        ds.Tables("vitalGrid").Rows(j).Item("BPLow") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 9 Then
                        ds.Tables("vitalGrid").Rows(j).Item("RR") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    'If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 4 Then
                    '    ds.Tables("vitalGrid").Rows(j).Item("Temp(F)") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    'End If
                End If
            Next
        Next
        GridViewVitals.DataSource = ds.Tables("vitalGrid")
        GridViewVitals.DataBind()
    End Sub

    Protected Sub TreeView1_SelectedNodeChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TreeView1.SelectedNodeChanged
        HiddenField_MH_Code.Value = TreeView1.SelectedValue
        HiddenField_root.Value = TreeView1.SelectedNode.Parent.Text

        HiddenField_Mg_Code.Value = TreeView1.SelectedValue
        lblRemarkCategory.Text = TreeView1.SelectedNode.Text
        If Not TreeView1.SelectedValue = "" Then

            Dim dv As DataView = DirectCast(SqlDataSource_OPD_Encounter_Form_Remarks.Select(DataSourceSelectArguments.Empty), DataView)
            If dv.Table.Rows.Count <> 0 Then
                TextBox_Remarks.Text = dv.Table.Rows(0)(0).ToString
            Else
                TextBox_Remarks.Text = ""
            End If

            'If TreeView1.SelectedNode.Parent.Text = "History" Then
            '    ' HiddenField_root.Value = "His"
            'ElseIf TreeView1.SelectedNode.Parent.Text = "Examination" Then

            '    'HiddenField_root.Value = "Phy"
            'End If

            Panel1.Controls.Clear()
            Panel_history.Controls.Clear()


        End If
        get_Color()
    End Sub

    Sub get_data()
        Button1.Attributes.Add("OnClick", "Show_Text_Value()")
        HiddenFieldTemplate_ID.Value = Session("TemplateId")
        If HiddenField_root.Value = "History" Then
            Dim obj_draw_Template As New Draw_Template
            Dim pal As New Panel
            pal.ID = "val"
            Try
                Dim Dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color(Session("YearlyNo"), Session("registrationNo"), "HIS", "")
                obj_draw_Template.Phy_Elements(HiddenField_Mg_Code.Value, Dss, Panel1, "HIS", "")
            Catch ex As Exception

            End Try

        ElseIf HiddenField_root.Value = "Examination" Then

            If HiddenField_Mg_Code.Value <> "" Then
                HiddenField3.Value = HiddenField_Mg_Code.Value
                If HiddenField_Mg_Code.Value <> "0" Then

                    Dim obj_draw_Template As New Draw_Template
                    Dim dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color(Session("YearlyNo"), Session("registrationNo"), "PHY", HiddenField_Mg_Code.Value)
                    obj_draw_Template.Phy_Elements(HiddenField_Mg_Code.Value, dss, Panel1, "PHY", HiddenFieldTemplate_ID.Value)

                End If
            End If
        End If
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        ' HiddenField_Count.Value = "1"
        'If HiddenField_root.Value = "History of Present Illness" Then
        '    Check_Controls()
        '    control_HOPI()
        'ElseIf HiddenField_root.Value = "Examination" Then
        '    Check_Controls()
        '    control()
        'ElseIf HiddenField_root.Value = "History" Then
        '    Check_Controls_history()
        '    control_history()
        'Else
        '    Try
        '        SqlDataSourceSave.Insert()
        '        HiddenField_count_val.Value = 1

        '        Check_Controls()
        '        Panel1.Controls.Clear()
        '        Dim obj_draw_Template As New Draw_Template
        '        Dim dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color(Session("YearlyNo"), Session("registrationNo"), "Presenting_Complaint", HiddenField_Mg_Code.Value)
        '        obj_draw_Template.Phy_Elements(HiddenField_Mg_Code.Value, dss, Panel1, "Presenting_Complaint", HiddenFieldTemplate_ID.Value)

        '    Catch ex As Exception

        '    End Try

        'End If

        If HiddenField_MH_Code.Value <> "" Then
            Dim objDbManager As DbManager = New DbManager()

            Dim sqlParams As SqlParameter() = {
                 New SqlParameter("@Reg_No", Session("registrationNo")),
                 New SqlParameter("@Yearly_No", Session("Yearlyno")),
                 New SqlParameter("@MH_Code", HiddenField_MH_Code.Value.TrimEnd(",")),
                 New SqlParameter("@Remarks", TextBox_Remarks.Text),
                New SqlParameter("@type", HiddenField_root.Value.TrimEnd(","))
        }

            objDbManager.ExecuteNonQuery("OPD_Encounter_Form_Remarks_Insert", "Treatment_AdminConnectionString", sqlParams)

        End If

        dataListPreviousRemarks.DataBind()

    End Sub

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
                        ''Response.Write(Mid(panel_History.Controls(i).ID.ToString, 13) + "  ")
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

    Sub control_HOPI()
        Try
            Panel1.Controls.Clear()
            Dim obj_draw_Template As New Draw_Template
            Dim treatment_constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Panel_history.Visible = False
            Panel1.EnableViewState = False
            Dim con_treatment As SqlConnection = New SqlConnection(treatment_constr)
            Dim command_treatment As SqlCommand = New SqlCommand("SELECT Admin_Complaint_MainGroup.Complaint_ID FROM Pt_Presenting_Complaint_saveRecord INNER JOIN Admin_Complaint_MainGroup ON Pt_Presenting_Complaint_saveRecord.Complaint_ID = Admin_Complaint_MainGroup.Complaint_ID WHERE  (Pt_Presenting_Complaint_saveRecord.YearlyNo = " + Session("YearlyNo") + ") AND (Pt_Presenting_Complaint_saveRecord.RegNo = '" + Session("registrationNo") + "')", con_treatment)
            command_treatment.CommandType = CommandType.Text
            con_treatment.Open()
            Dim reader_HOPI As SqlDataReader = command_treatment.ExecuteReader
            While reader_HOPI.Read
                Dim Dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color(Session("YearlyNo"), Session("registrationNo"), "HIS", "") 'reader_HOPI.Item("Complaint_ID"))
                obj_draw_Template.Phy_Elements(HiddenField_Mg_Code.Value, Dss, Panel1, "HIS", "")
            End While
            con_treatment.Close()
        Catch ex As Exception
        End Try
    End Sub

    Sub control_history()

        Try
            Panel_history.Controls.Clear()
            Dim obj_draw_Template As New Draw_Template
            Dim dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color_history(HiddenField_Mg_Code.Value, Session("YearlyNo"), Session("registrationNo"))
            obj_draw_Template.Phy_Elements_history(HiddenField_Mg_Code.Value, HiddenFieldTemplate_ID.Value, dss, Panel_history)
            'End While
            'con.Close()
        Catch ex As Exception

        End Try
    End Sub
    Sub Insert_Values(ByVal value As String, ByVal E_ID As String, ByVal Counter As Integer)
        If HiddenField_root.Value = "History" Then
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
                '  'Response.Write(ex.Message)
            End Try
        ElseIf HiddenField_root.Value = "Examination" Then
            Try
                Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                Dim con As SqlConnection = New SqlConnection(a)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("pt_insert_phyexam_Last_new", con)
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
                '  'Response.Write(ex.Message)
            End Try
        Else

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
                '  'Response.Write(ex.Message)
            End Try
        End If

    End Sub

    Sub Check_Controls()
        If HiddenField_root.Value = "History" Then
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
                ' 'Response.Write(ex.Message)
            End Try
        ElseIf HiddenField_root.Value = "Examination" Then
            Try
                For i As Integer = 0 To Panel1.Controls.Count - 1
                    If Panel1.Controls(i).GetType().ToString.Contains("RadioButtonList") = True Then
                        Dim RBL As RadioButtonList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)

                        For j As Integer = 0 To RBL.Items.Count - 1
                            If RBL.Items(j).Selected = True Then
                                Insert_Values(RBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 16), j)
                            End If
                        Next
                    ElseIf Panel1.Controls(i).GetType().ToString.Contains("CheckBoxList") = True Then
                        Dim CBL As CheckBoxList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)

                        For j As Integer = 0 To CBL.Items.Count - 1
                            If CBL.Items(j).Selected = True Then
                                Insert_Values(CBL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                            End If
                        Next
                    ElseIf Panel1.Controls(i).GetType().ToString.Contains("DropDownList") = True Then
                        Dim DDL As DropDownList = Panel1.FindControl(Panel1.Controls(i).ID.ToString)

                        For j As Integer = 0 To DDL.Items.Count - 1
                            If DDL.Items(j).Selected = True And DDL.Items(j).Text <> "" Then
                                Insert_Values(DDL.Items(j).Value, Mid(Panel1.Controls(i).ID.ToString, 13), j)
                            End If
                        Next
                    ElseIf Panel1.Controls(i).GetType().ToString.Contains("TextBox") = True Then
                        Dim txt As TextBox = Panel1.FindControl(Panel1.Controls(i).ID.ToString)

                        If txt.Text.Trim <> "" Then
                            Insert_Values(txt.Text, Mid(Panel1.Controls(i).ID.ToString, 8), 0)
                        End If
                    End If
                Next
            Catch ex As Exception
                '  'Response.Write(ex.Message)
            End Try
        Else
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
                '  'Response.Write(ex.Message)
            End Try
        End If
    End Sub

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
    Sub control()
        Panel1.Controls.Clear()
        Dim obj_draw_Template As New Draw_Template
        Dim dss As DataSet = obj_draw_Template.Already_Save_Element_for_Color(Session("YearlyNo"), Session("registrationNo"), "PHY", HiddenField_Mg_Code.Value)
        obj_draw_Template.Phy_Elements(HiddenField_Mg_Code.Value, dss, Panel1, "PHY", HiddenFieldTemplate_ID.Value)

    End Sub


    Protected Sub GridView_Medicine_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Medicine.PreRender
        Dim a As String
        Dim b As String
        a = ""
        b = ""
        Try
            For i As Integer = 0 To GridView_Medicine.Rows.Count - 1

                If (a = "") Then
                    a = GridView_Medicine.Rows(i).Cells(0).Text
                ElseIf (a = GridView_Medicine.Rows(i).Cells(0).Text) Then
                    GridView_Medicine.Rows(i).Cells(0).Text = ""

                Else
                    a = GridView_Medicine.Rows(i).Cells(0).Text
                End If
                If (b = "") Then
                    b = GridView_Medicine.Rows(i).Cells(1).Text
                ElseIf (b = GridView_Medicine.Rows(i).Cells(1).Text) Then
                    GridView_Medicine.Rows(i).Cells(1).Text = ""
                Else
                    b = GridView_Medicine.Rows(i).Cells(1).Text
                End If

            Next
        Catch ex As Exception
            '   'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button_phy_Notes_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_phy_Notes.Click
        Dim con As New SqlConnection
        con.ConnectionString = constr

        Try

            If hdnPhyNotesId.Value = "" Then

                con.Open()
                Dim command As SqlCommand = New SqlCommand("insert into pt_Treatment_Plan (Reg_No,Yearly_No,Plan_Detail,emp_id,Dept_ID,Type,FollowUpDays)Values(@reg_no,@Yearly_no,@Plan_Detail,@emp_id,@Dept_ID,'Phy',@FollowUpDays)", con)
                command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
                command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))
                command.Parameters.AddWithValue("@Plan_Detail", txtPhycicianNotes.Text.ToString())
                command.Parameters.AddWithValue("@emp_id", Session("emp_id"))
                command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
                command.Parameters.AddWithValue("@FollowUpDays", txtFUDays.Text.ToString())
                 
                command.ExecuteNonQuery()
                con.Close()


            Else

                Dim command1 As New SqlCommand
                command1.CommandType = CommandType.Text
                command1 = con.CreateCommand
                command1.CommandText = "UPdate pt_Treatment_Plan set Plan_Detail=@Plan_Detail where Plan_id=@Plan_id"
                command1.Parameters.AddWithValue("@Plan_Detail", txtPhycicianNotes.Text.ToString())
                command1.Parameters.AddWithValue("@Plan_id", hdnPhyNotesId.Value)
                con.Open()
                command1.ExecuteNonQuery()

                con.Close()




            End If


            DataList_Test.DataBind()
            'GridView1.DataBind()
            '  End If
        Catch ex As Exception
            '  'Response.Write(ex.Message)
        Finally
            con.Close()
            con.Dispose()
        End Try
    End Sub
    Sub get_Color()
        Dim row As Integer = 0
        Dim col As Integer = 0

        For row = 0 To TreeView1.Nodes.Count - 1
            For col = 0 To TreeView1.Nodes(row).ChildNodes.Count - 1

                If TreeView1.Nodes(row).Text = "History" Then

                    Dim con_tem As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString)
                    Dim command As SqlCommand = New SqlCommand(" SELECT     admin_History_MainGroup.MG_Code, admin_History_MainGroup.MG_Name, admin_History_MainGroup.Priority, Admin_History_MainHeading_Group.MH_Code FROM         admin_History_MainGroup INNER JOIN Admin_History_MainHeading_Group ON admin_History_MainGroup.MG_Code = Admin_History_MainHeading_Group.Mg_Code WHERE     (Admin_History_MainHeading_Group.MH_Code = " + TreeView1.Nodes(row).ChildNodes(col).Value + ")", con_tem)
                    command.CommandType = CommandType.Text

                    con_tem.Open()
                    Dim count As Integer = 0
                    Dim reader As SqlDataReader = command.ExecuteReader()

                    While reader.Read

                        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                        Dim con As SqlConnection = New SqlConnection(constr)
                        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Already_Save_Elements", con) '"SELECT Pt_history_SaveRecord.MG_Code, Pt_history_SaveRecord.e_Code,Pt_history_SaveRecord.ev_Code,admin_History_Elements.e_Code,admin_History_Elements.e_Field_Type + admin_History_Elements.e_ID,admin_History_Elements.e_Field_Type FROM Pt_history_SaveRecord INNER JOIN admin_History_Elements ON Pt_history_SaveRecord.e_Code = admin_History_Elements.e_Code where (Pt_history_SaveRecord.YearlyNo=@YearlyNo) And (Pt_history_SaveRecord.RegNo = @RegNo) ", con)
                        Dim reader_val As SqlDataReader
                        mycommand.CommandType = Data.CommandType.StoredProcedure
                        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                        mycommand.Parameters.AddWithValue("@MG_Code", reader.Item(0))
                        con.Open()
                        reader_val = mycommand.ExecuteReader()
                        If reader_val.Read Then

                            If TreeView1.Nodes(row).ChildNodes(col).Text.ToString.Contains("<div") Then
                            Else
                                TreeView1.Nodes(row).ChildNodes(col).Text = "<div class='treeselect'>" + TreeView1.Nodes(row).ChildNodes(col).Text + "</div>"
                            End If

                        End If
                        reader_val.Close()
                        con.Close()
                        con.Dispose()
                    End While
                    reader.Close()
                    con_tem.Close()
                    con_tem.Dispose()
                ElseIf TreeView1.Nodes(row).Text = "Physical Examination" Then
                    Dim con_tem As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString)
                    Dim command As SqlCommand = New SqlCommand(" SELECT DISTINCT admin_Phy_Exam_MainGroup.MG_Code, admin_Phy_Exam_MainGroup.MG_Name, Admin_Exam_MainHeading_Group.MH_Code FROM         Admin_Exam_MainHeading_Group INNER JOIN admin_Phy_Exam_MainGroup ON Admin_Exam_MainHeading_Group.Mg_Code = admin_Phy_Exam_MainGroup.MG_Code WHERE     (Admin_Exam_MainHeading_Group.MH_Code = " + TreeView1.Nodes(row).ChildNodes(col).Value + ")", con_tem)
                    command.CommandType = CommandType.Text
                    con_tem.Open()
                    Dim count As Integer = 0
                    Dim reader As SqlDataReader = command.ExecuteReader()
                    While reader.Read
                        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                        Dim con As SqlConnection = New SqlConnection(constr)
                        Dim reader_val As SqlDataReader
                        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Already_Save_Phy_Elements", con)
                        mycommand.CommandType = Data.CommandType.StoredProcedure
                        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                        mycommand.Parameters.AddWithValue("@MG_Code", reader.Item(0))
                        con.Open()
                        reader_val = mycommand.ExecuteReader()
                        If reader_val.Read Then

                            If TreeView1.Nodes(row).ChildNodes(col).Text.ToString.Contains("<div") Then
                            Else
                                TreeView1.Nodes(row).ChildNodes(col).Text = "<div class='treeselect'>" + TreeView1.Nodes(row).ChildNodes(col).Text + "</div>"
                            End If

                        End If
                        reader_val.Close()
                        con.Close()
                        con.Dispose()
                    End While
                    reader.Close()
                    con_tem.Close()
                    con_tem.Dispose()

                End If

            Next
        Next

    End Sub
    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Try
            SqlDataSource_OPD_Encounter_Form_Remarks.Insert()
            TextBox_Remarks.Text = String.Empty
            dataListPreviousRemarks.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Dim b, c, d As String

    Protected Sub ImageButton_Frequency_ShowHide_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        If DataList_Frequency.Visible = True Then
            DataList_Frequency.Visible = False
        Else
            DataList_Frequency.Visible = True
        End If
    End Sub




    Protected Sub ImageButton_Frequency_ShowHideForPreviousMedicine_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim img As ImageButton = sender
        Dim datalist As DataListItem = DirectCast(img.NamingContainer, DataListItem)
        Dim frequencyDatalist As DataList = datalist.FindControl("DataList_FrequencyForPreviousMedicine")
        If frequencyDatalist.Visible = True Then
            frequencyDatalist.Visible = False
        Else
            frequencyDatalist.Visible = True
        End If
    End Sub

    Protected Sub ButtonSaveMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSaveMedicine.Click
        Try
            ' If Label1.Text <> "" Then

            HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))

            HiddenField_MedCode.Value = hfName.Value

            Dim start_Date As Date
            Dim end_date As Date

            HiddenFieldStartDate.Value = WebDateChooserStartDate.Value
            Dim days As String = TextBox_days.Text
            If days = "" Then
                days = 2
            End If
            HiddenFieldEndDate.Value = Convert.ToDateTime(WebDateChooserStartDate.Value).AddDays(days - 1)

            HiddenField_dosage.Value = TextBox_dosage.Text + DropDownList_dosage.SelectedValue
            If TextBox_dilution.Text = "" Then
                HiddenField_Dilution.Value = "XX"
            Else
                HiddenField_Dilution.Value = TextBox_dilution.Text
            End If
            'HiddenFieldDose.Value = WebMaskEdit1.Text

            If CheckBox_CT.Checked = True Then
                HiddenField_CT.Value = "Continue Treatment"
            Else
                HiddenField_CT.Value = ""
            End If

            start_Date = Convert.ToDateTime(WebDateChooserStartDate.Value)
            end_date = Convert.ToDateTime(WebDateChooserEndDate.Value)


            Try
                If ButtonSaveMedicine.Text = "Save" Then
                    HiddenField_priscription_id.Value = ""



                    SqlDataSource_Prescription.Insert()
                    Update_Confirmation(HiddenField_Prescription_Id.Value)
                ElseIf ButtonSaveMedicine.Text = "Update" Then
                    'HiddenField_priscription_id.Value = ""
                    ''Response.Write(start_Date)
                    ''Response.Write(end_date)
                    ''Response.Write(HiddenField_priscription_id.Value)
                    HiddenField_end_date.Value = end_date
                    HiddenField_start_date.Value = start_Date
                    SqlDataSource_Prescription.Update()
                End If
                DataList_ConfirmedPrescriptions.DataBind()
                LabelMessageMedicine.Text = Label1.Text + " " + " added sussessfully..."
            Catch ex As Exception
                LabelMessageMedicine.Text = ex.Message
            End Try

            GridView_Template_Medicine.DataBind()

            GridView2.DataBind()
            gen_xml(Date.Now)
            TextBox_dilution.Text = ""
            TextBox_dosage.Text = "1"
            Label1.Text = ""
            DataList_new.DataBind()
            DataList_old.DataBind()


            'ElseIf HiddenField_flag.Value = 1 Then
            'HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))

            'Dim start_Date As Date
            'Dim end_date As Date

            'start_Date = Convert.ToDateTime(WebDateChooserStartDate.Value)
            'end_date = Convert.ToDateTime(WebDateChooserEndDate.Value)


            'HiddenFieldStartDate.Value = Convert.ToString(start_Date.Month) + "/" + Convert.ToString(start_Date.Day) + "/" + Convert.ToString(start_Date.Year) + " 00:00"
            'HiddenFieldEndDate.Value = Convert.ToString(end_date.Month) + "/" + Convert.ToString(end_date.Day) + "/" + Convert.ToString(end_date.Year) + " 00:00"

            'HiddenField_dosage.Value = TextBox_dosage.Text + DropDownList_dosage.SelectedValue
            'If TextBox_dilution.Text = "" Then
            '    HiddenField_Dilution.Value = "XX"
            'Else
            '    HiddenField_Dilution.Value = TextBox_dilution.Text
            'End If
            ''HiddenFieldDose.Value = WebMaskEdit1.Text

            'If CheckBox_CT.Checked = True Then
            '    HiddenField_CT.Value = "Continue Treatment"
            'Else
            '    HiddenField_CT.Value = ""
            'End If

            'If ButtonSaveMedicine.Text = "Save" Then
            '    SqlDataSource_Prescription.Insert()
            'ElseIf ButtonSaveMedicine.Text = "Update" Then
            '    HiddenField_end_date.Value = end_date
            '    HiddenField_start_date.Value = start_Date
            '    SqlDataSource_Prescription.Update()
            'End If
            ''SqlDataSource_Prescription.Insert()
            'DataList_new.DataBind()
            'DataList_old.DataBind()
            'DataList_ConfirmedPrescriptions.DataBind()
            'HiddenField_flag.Value = 0

            'End If
            '   End If
            'DataList_Frequency.DataBind()
            For i As Integer = 0 To DataList_Frequency.Items.Count - 1

                Dim HF_F_S_Id As HiddenField = DataList_Frequency.Items(i).FindControl("HF_F_S_Id")
                HiddenField_Frequency_Sub_Id.Value = HF_F_S_Id.Value
                ''Response.Write(HiddenField_Frequency_Sub_Id.Value)
                Dim TextBox_dosage1 As TextBox = DataList_Frequency.Items(i).FindControl("TextBox_dosage2")
                HiddenField_DL_Dosage.Value = TextBox_dosage1.Text

                Try
                    SqlDataSource_Frequency_detail.Insert()
                Catch ex As Exception
                    'Response.Write(ex.Message)
                End Try

            Next
            ButtonSaveMedicine.Text = "Save"
            HiddenField_priscription_id.Value = ""
            LabelMessageMedicine.Text = Label1.Text + " " + " added sussessfully..."
            hfName.Value = ""
            'DataList_ConfirmedPrescriptions.DataBind()
            'Clear()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
        '  Response.Redirect("~/Pt_EMR/OPD_Encounter_Form.aspx?CallFrom=Medicine")

    End Sub
    Sub gen_xml(ByVal get_date As DateTime)

    End Sub
    Protected Sub Button_UpdateMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Button_UpdateMedicine.Visible = False
    End Sub

    Protected Sub TextBox_specificMedicine_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_specificMedicine.TextChanged
        HiddenField_flag.Value = 0
        search(0, TextBox_specificMedicine.Text)
    End Sub

    Sub search(ByVal a As Integer, ByVal MedSearch As String)
        Try
            Dim Med_name As String
            Dim spec As String
            Dim item_code As String
            Dim cat As String
            Dim Hospital_Id As Integer = 0

            If RadioButtonList_HospitalMed.SelectedValue = 1 Then
                Hospital_Id = Session("HospitalId")
            End If
            'Label_Stock.Text = ""
            Dim con As SqlConnection = New SqlConnection(conStore)
            Dim reader As SqlDataReader
            Dim command As SqlCommand = New SqlCommand("Medicine_outside_select", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@mgname", MedSearch)
            command.Parameters.AddWithValue("@Hospital_Id", Hospital_Id)


            con.Open()
            reader = command.ExecuteReader()
            If reader.Read Then
                Med_name = reader.Item("Item_Full_Name")
                'Label_Stock.Text = reader.Item("Stock")
                spec = reader.Item(1)
                item_code = reader.Item(2)
                cat = reader.Item(3)

            Else
                Med_name = TextBox_specificMedicine.Text
                spec = ""
                item_code = ""
                cat = ""
                'Label_Stock.Text = ""
            End If

            Medicine_Route(cat.Trim)
            'Medicine_Frequency(item_code.Trim)
            Label1.Text = ""

            Dim medicineName As String = Med_name.Trim
            Dim medicineCode As String = item_code.Trim
            HiddenField_MedCode.Value = medicineCode

            '---------------------------------------------------------------    

            If cat.Trim = "INJ" Then
                TextBox_dilution.Visible = True
                DropDownList_diution.Visible = True
                Label_Dilution.Visible = True
            Else
                TextBox_dilution.Visible = False
                DropDownList_diution.Visible = False
                Label_Dilution.Visible = False
            End If

            '----------------------------------------------------------------

            Label1.Text = medicineName
            TextBox_Medicine.Text = medicineCode

            HiddenField_MedCode.Value = TextBox_Medicine.Text
            'LabelMessage.Text = HiddenField_MedCode.Value

            con.Close()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Sub Medicine_Route(ByVal Category As String)
        Dim con As SqlConnection = New SqlConnection(conStore)
        Dim command As SqlCommand = New SqlCommand("SELECT DISTINCT isnull( Category,'') FROM Assign_Medicine_Route", con)
        command.CommandType = CommandType.Text
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read()
            If Category.Contains(reader.Item(0).ToString.Trim) Then
                HiddenField_Medicine_Category.Value = reader.Item(0).ToString
                Exit While
            Else
                HiddenField_Medicine_Category.Value = ""
            End If
        End While
    End Sub


    Protected Sub SqlDataSource_Prescription_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Prescription.Inserted
        HiddenField_Prescription_Id.Value = e.Command.Parameters("@Prescription_Id").Value

        If String.IsNullOrEmpty(HiddenField_MedCode.Value) Then
            Try


                HiddenField_MedCode.Value = e.Command.Parameters("@med_code_Out").Value
            Catch ex As Exception

            End Try
        End If

    End Sub

    Protected Sub Update_Confirmation(ByVal Prescription_ID As Integer)
        Dim qry As String = "UPDATE Pt_Prescription_Detail SET ConfirmedBy = @ConfirmedBy, ConfirmedDate = GETDATE() WHERE (priscription_id = @priscription_id)"
        Dim con As SqlConnection = New SqlConnection(constr)
        con.Open()
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@ConfirmedBy", Session("emp_id"))
        command.Parameters.AddWithValue("@priscription_id", Prescription_ID)
        command.ExecuteNonQuery()
        con.Close()


    End Sub

    Protected Sub btnAddDiagnosis_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddDiagnosis.Click
        Try

            If TextBox_Diagnosis_search.Text <> "" Then
                HiddenFieldPast.Value = "False"
                HiddenFieldProvisional.Value = "true"
                HiddenFieldFinal.Value = "False"
                HiddenFieldDisease.Value = TextBox_Diagnosis_search.Text
                HiddenFieldDiagnosis.Value = ICDCode(TextBox_Diagnosis_search.Text)
                SqlDataSourceDiagnosis.Insert()
                'DataList_CurrentVisitDiagnosis.DataBind()
                'DataList1.DataBind()
                TextBox_Diagnosis_search.Text = String.Empty
                'GridView3.DataBind()
                DataList_CurrentVisitDiagnosis.DataBind()
            Else
                For index = 0 To chkboxDepartmentDiagnoses.Items.Count - 1
                    If chkboxDepartmentDiagnoses.Items(index).Selected Then
                        HiddenFieldPast.Value = "False"
                        HiddenFieldProvisional.Value = "true"
                        HiddenFieldFinal.Value = "False"
                        HiddenFieldDisease.Value = chkboxDepartmentDiagnoses.Items(index).Text
                        HiddenFieldDiagnosis.Value = ICDCode(chkboxDepartmentDiagnoses.Items(index).Text)
                        SqlDataSourceDiagnosis.Insert()
                        chkboxDepartmentDiagnoses.Items(index).Selected = False
                    End If
                Next
                TextBox_Diagnosis_search.Text = String.Empty

                DataList_CurrentVisitDiagnosis.DataBind()

            End If

        Catch ex As Exception

        End Try
    End Sub
    Public Function GetNavigateURL(ByVal regNo As Object, ByVal yearlyNo As Object) As String
        Dim url As String = "~/Patient Billing/PatientFaceSheet.aspx?RegNo={0}&YearlyNo={1}"
        url = String.Format(url, regNo, yearlyNo)
        Return url
    End Function
    Function ICDCode(ByVal disease_Name As String) As String

        Dim ICDCode2 As String = ""
        Try
            Dim con As SqlConnection = New SqlConnection(constr_TreatmentAdmin)
            Dim command As SqlCommand = New SqlCommand(" SELECT     distinct sectionID FROM dbo.ICD10_DiseaseSection where dbo.ICD10_DiseaseSection.Title=@DiseaseTitle ", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@DiseaseTitle", disease_Name)
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            While reader.Read

                ICDCode2 = (reader.Item(0))
            End While
            con.Close()
        Catch ex As Exception
            Return ""
        End Try
        If ICDCode2 <> "" Then
            Return ICDCode2
        Else
            Return ""
        End If

    End Function

    Protected Sub DataList_CurrentVisitDiagnosis_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_CurrentVisitDiagnosis.ItemCommand
        If e.CommandName = "remove" Then
            HF_Diagnosis_ID.Value = e.CommandArgument
            SqlDataSource_UpdateDiagnosis.Delete()
            DataList_CurrentVisitDiagnosis.DataBind()
        End If
    End Sub

    Protected Sub btnAddPathology_Click(sender As Object, e As EventArgs)
        Dim strTestId As String = String.Empty
        If Is_exist(TextBox_Test.Text, strTestId) Then
            Book_Path_Test(TextBox_Test.Text, strTestId)
            HiddenField_MG_ID.Value = "%"
        End If
    End Sub
    Protected Function Get_Charges(ByVal T_ID As Integer) As String
        'Dim qry As String = "SELECT ISNULL(Admin_Services.S_Amount, 0) AS S_Amount FROM Test_Booking INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID WHERE (Test_Booking.TB_ID = @TB_ID)"
        Dim qry As String = "SELECT     ISNULL(Admin_Hospital_Services_Rates.S_Amount, 0) AS S_Amount FROM Test_Booking INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID INNER JOIN Admin_Hospital_Services_Rates ON Admin_Services.S_ID = Admin_Hospital_Services_Rates.S_Id WHERE (Test_Booking.TB_ID = @TB_ID)and Admin_Hospital_Services_Rates.Hospital_Id=@Hospital_Id and Admin_Hospital_Services_Rates.Patient_Type_Id=@Patient_Type_Id and Admin_Hospital_Services_Rates.IPD_OPD=@IPD_OPD"

        Dim result As String = "0"
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(Path_constr)
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@TB_ID", T_ID)
        command.Parameters.AddWithValue("@Hospital_Id", CInt(Session("PatientHospital_ID")))
        command.Parameters.AddWithValue("@IPD_OPD", Session("IPDOPD"))
        command.Parameters.AddWithValue("@Patient_Type_Id", CInt(Session("Patient_Type_ID")))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read
            result = reader.Item("S_Amount").ToString
        End While
        Return result
    End Function

    Protected Sub Book_Path_Test(ByVal testName As String, ByVal testId As String)

        Select_Gender()
        Dim tId As Integer = testId
        Dim tName As String = testName
        Dim testTypeName As String = "Routine"
        Dim testDesc As String = ""
        Dim testTypeId As Integer = 1
        Dim charges As String = Get_Charges(testId)
        Dim isInsideHospitalTest As Boolean = IS_inside_Test(testId)
        Dim main_id As Integer

        Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        con.Open()


        If HiddenField_Order_ID.Value = 0 Then
            Dim command As SqlCommand = New SqlCommand("Insert_Investigation_Order_Main", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@Status", 11)
            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
            command.Parameters.AddWithValue("@Clinical_Information", String.Empty)

            command.Parameters.Add("@Main_Id", SqlDbType.Int)
            command.Parameters("@Main_Id").Direction = ParameterDirection.Output

            command.ExecuteNonQuery()

            main_id = command.Parameters("@Main_Id").Value
            HiddenField_Order_ID.Value = main_id
        Else
            main_id = HiddenField_Order_ID.Value
        End If


        Dim sub_command As SqlCommand = New SqlCommand("Insert_Investigation_Order_sub", con)
        sub_command.CommandType = CommandType.StoredProcedure
        sub_command.Parameters.AddWithValue("@TB_ID", tId)
        sub_command.Parameters.AddWithValue("@Description", testDesc)
        sub_command.Parameters.AddWithValue("@TestType_ID", testTypeId)
        sub_command.Parameters.AddWithValue("@Status", "New")
        sub_command.Parameters.AddWithValue("@Investigation_Order_ID", main_id)
        sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", isInsideHospitalTest)

        sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        sub_command.Parameters.AddWithValue("@empid", Session("emp_id"))
        sub_command.Parameters.AddWithValue("@S_ID", tId)
        sub_command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
        sub_command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
        sub_command.Parameters.Add("@PS_ID", Data.SqlDbType.Int, 100)
        sub_command.Parameters("@PS_ID").Direction = Data.ParameterDirection.Output

        sub_command.ExecuteNonQuery()
        'Next
        con.Close()
        'GridView1.DataBind()
        DataList_Test.DataBind()
        TextBox_Test.Text = String.Empty
    End Sub

    Protected Function IS_inside_Test(ByVal T_ID As Integer) As Boolean
        Dim qry As String = "SELECT case when S_Id = 0 then 0 else 1 end as is_Inside_Test FROM Test_Booking where (TB_ID = @TB_ID)"
        Dim IS_inside_Hospital_Test As Boolean = 1
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(Path_constr)
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@TB_ID", T_ID)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read
            IS_inside_Hospital_Test = reader.Item("is_Inside_Test")
        End While
        Return IS_inside_Hospital_Test
    End Function

    Sub Select_Gender()
        Dim con As SqlConnection = New SqlConnection(constr_reg)
        Dim command As SqlCommand = New SqlCommand("SELECT SexID FROM Patient WHERE RegNo = @RegNo", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            HiddenFieldGender.Value = reader.Item(0).ToString
        End If
        reader.Close()
        con.Close()
    End Sub

    Function Is_exist(ByVal TB_Name As String, ByRef tb_Id As String) As Boolean
        Dim flag As Boolean = False
        Dim con As New SqlConnection(Path_constr)
        Dim qry As String = "SELECT TB_Name, TB_ID FROM Test_Booking where (TB_Name = @TB_Name)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@TB_Name", TB_Name)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            flag = True
            tb_Id = reader("TB_ID").ToString()
        End While
        con.Close()
        Return flag
    End Function
    Function IsRadiologyExist(ByVal TB_Name As String, ByRef testId As String) As Boolean
        Dim flag As Boolean = False
        Dim con As New SqlConnection(conRad)
        'Dim qry As String = "SELECT TB_Name, TB_ID FROM Test_Booking where (TB_Name like '%" + TB_Name + "%')"
        Dim qry As String = "SELECT TB_Name, TB_ID FROM Test_Booking where (TB_Name =@TB_Name)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@TB_Name", TB_Name.Trim())
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            flag = True
            testId = reader("TB_ID").ToString()
        End While
        con.Close()
        Return flag
    End Function

    Protected Sub btnAddRadiologyTest_Click(sender As Object, e As EventArgs)
        Dim strTestId As String = String.Empty
        If IsRadiologyExist(TextBox_TestRadiology.Text, strTestId) Then

            Radiology_Test(TextBox_TestRadiology.Text, strTestId)
        End If
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "CallMyFunction", "HidePreviousTest()", True)
    End Sub
    Protected Sub Radiology_Test(ByVal testName As String, ByVal testId As String)
        Select_Gender()
        Try
            Dim enc As New Encryption
            Dim main_id As Integer
            Dim isInsideHospitalTest As Boolean = IS_inside_Test(testId)
            Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            con.Open()

            If HiddenField_Radiology_Order_ID.Value = 0 Then
                Dim command As SqlCommand = New SqlCommand("Insert_Radiology_Order_Main", con)
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                command.Parameters.AddWithValue("@Status", 11)
                command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
                command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
                command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
                command.Parameters.AddWithValue("@Clinical_Information", String.Empty)
                command.Parameters.AddWithValue("@R_ID", 0)
                command.Parameters.Add("@Main_Id", SqlDbType.Int)
                command.Parameters("@Main_Id").Direction = ParameterDirection.Output
                'con.Open()
                command.ExecuteNonQuery()
                main_id = command.Parameters("@Main_Id").Value
                HiddenField_Radiology_Order_ID.Value = main_id
            Else
                main_id = HiddenField_Radiology_Order_ID.Value
            End If


            'For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            'If CheckBoxList_Projection.Items(i).Selected = True Then
            Dim sub_command As SqlCommand = New SqlCommand("Insert_Radiology_Order_sub", con)
            sub_command.CommandType = CommandType.StoredProcedure
            sub_command.Parameters.AddWithValue("@TB_ID", testId)
            sub_command.Parameters.AddWithValue("@Order_ID", main_id)
            sub_command.Parameters.AddWithValue("@RadiologyTestName", testName)
            sub_command.Parameters.AddWithValue("@Status", "New")
            sub_command.Parameters.AddWithValue("@Instructions", String.Empty)
            sub_command.Parameters.AddWithValue("@Test_Type", "1")
            sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", isInsideHospitalTest)

            sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            sub_command.Parameters.AddWithValue("@empid", Session("emp_id"))
            'sub_command.Parameters.AddWithValue("@S_ID", testId)
            sub_command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
            sub_command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
            sub_command.Parameters.Add("@PS_ID", Data.SqlDbType.Int, 100)
            sub_command.Parameters("@PS_ID").Direction = Data.ParameterDirection.Output
            sub_command.ExecuteNonQuery()

            'Next
            con.Close()
            'GridViewRadiology.DataBind()
            DataList_Radiology.DataBind()
            TextBox_TestRadiology.Text = String.Empty
            TextBox_TestRadiology.Focus()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

        'GridView_Radiology.DataBind()

        'Else
        'Label_MSG.Text = "Pass Code Not Matched Try Again"
        'End If

    End Sub

    Protected Sub DataList_Test_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_Test.PreRender
        For i As Integer = 0 To DataList_Test.Items.Count - 1

            Dim SqlDataSource_Test_Sub As SqlDataSource = DataList_Test.Items(i).FindControl("SqlDataSource_Test_Sub")
            Dim Label_TestDate As Label = DataList_Test.Items(i).FindControl("Label_TestDate")

            SqlDataSource_Test_Sub.SelectParameters("Date").DefaultValue = Label_TestDate.Text
            SqlDataSource_Test_Sub.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString()
            SqlDataSource_Test_Sub.SelectParameters("YearlyNo").DefaultValue = Session("YearlyNo").ToString()
        Next

    End Sub
    Protected Sub DataListForPreviousTestPathology_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListForPreviousTestPathology.PreRender
        For i As Integer = 0 To DataListForPreviousTestPathology.Items.Count - 1


            Dim Label_TestDate As Label = DataListForPreviousTestPathology.Items(i).FindControl("Label_TestDate")

            Dim regno As String = Session("RegistrationNo").ToString()
            Dim yearlyNo As HiddenField = DataListForPreviousTestPathology.Items(i).FindControl("hfForPathologyYearlyNo")
            Dim datalistSub As DataList = DataListForPreviousTestPathology.Items(i).FindControl("DataListPreviousTestOfPathology_Sub")

            Dim dbmanager As New DbManager
            Dim dt As DataTable = dbmanager.ExecuteDataTable("previousTestForPathology", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("@regno", regno.Trim()), New SqlParameter("@date", Label_TestDate.Text),
                                                         New SqlParameter("@yearlyNO", yearlyNo.Value.Trim())})
            datalistSub.DataSource = dt
            datalistSub.DataBind()

        Next

    End Sub






    Protected Sub DataList_Radiology_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_Radiology.PreRender
        For i As Integer = 0 To DataList_Radiology.Items.Count - 1
            'Dim HiddenField_TGID As HiddenField = DataList_Radiology.Items(i).FindControl("HiddenField_TGID")
            Dim Label_Date As Label = DataList_Radiology.Items(i).FindControl("Label_Date")
            Dim SqlDataSource_Radiology_Sub As SqlDataSource = DataList_Radiology.Items(i).FindControl("SqlDataSource_Radiology_Sub")
            SqlDataSource_Radiology_Sub.SelectParameters("Date").DefaultValue = Label_Date.Text
            SqlDataSource_Radiology_Sub.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString()
            SqlDataSource_Radiology_Sub.SelectParameters("YearlyNo").DefaultValue = Session("YearlyNo").ToString()
        Next

    End Sub

    Protected Sub DataListPreviousTestParent_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListPreviousTestParent.PreRender
        For i As Integer = 0 To DataListPreviousTestParent.Items.Count - 1
            'Dim HiddenField_TGID As HiddenField = DataList_Radiology.Items(i).FindControl("HiddenField_TGID")

            Dim Label_Date As Label = DataListPreviousTestParent.Items(i).FindControl("Label_Date")
            Dim regno As String = Session("RegistrationNo").ToString()
            Dim yearlyNo As HiddenField = DataListPreviousTestParent.Items(i).FindControl("yearlyNO")
            Dim datalistSub As DataList = DataListPreviousTestParent.Items(i).FindControl("DataListPreviousTest_Sub")

            Dim dbmanager As New DbManager
            Dim dt As DataTable = dbmanager.ExecuteDataTable("uspGetPreviousRadiologyTests", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("@regno", regno.Trim()), New SqlParameter("@date", Label_Date.Text),
                                                         New SqlParameter("@yearlyNO", yearlyNo.Value.Trim())})
            datalistSub.DataSource = dt
            datalistSub.DataBind()
        Next

    End Sub








    Protected Sub LinkButton_Add_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If LinkButton_Add.Text = "Save" Then
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
                            HiddenFieldComplaint_ID.Value = ds.Tables(0).Rows(i).Item(2)
                        End If
                        Exit For
                    Next
                Else
                    If TextBoxComplaint_Name.Text.Length >= 2 Then
                        If TextBoxDuration.Text <> "" Then
                            SqlDataSource_select_all.Insert()
                        End If
                    End If
                End If


            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
            ''Response.Write(HiddenFieldComplaint_ID.Value)
            'HiddenFieldComplaint_ID.Value = HiddenField_Complaint_new.Value
            Save_Complaint()
            Update_Complaint_Detail(HiddenFieldComplaint_ID.Value)

            TextBoxComplaint_Name.Text = String.Empty
            TextBoxDuration.Text = String.Empty
            DropDownListDuration.SelectedIndex = 0
            HiddenFieldComplaint_ID.Value = "0"
            dataListComplaints.DataBind()
        Else

        End If


    End Sub
    Protected Sub Save_Complaint()
        Try
            SqlDataSourceSaveComplaints.Insert()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
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

    End Sub



    Protected Sub dataListPreviousRemarks_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dataListPreviousRemarks.SelectedIndexChanged
        Try


            Dim hid As HiddenField = dataListPreviousRemarks.Items(dataListPreviousRemarks.SelectedIndex).FindControl("HiddenField_Complaint_ID")
            Dim lab As Label = dataListPreviousRemarks.Items(dataListPreviousRemarks.SelectedIndex).FindControl("Complaint_NameLabel")
            Dim lab_detail As LinkButton = dataListPreviousRemarks.Items(dataListPreviousRemarks.SelectedIndex).FindControl("LinkButton_Description")
            TextBox_Remarks.Text = lab_detail.Text
            HiddenField_MH_Code.Value = hid.Value
            Dim tNode As TreeNode = GetNodeByValue(hid.Value)
            If tNode IsNot Nothing Then
                tNode.Selected = True
                tNode.Parent.Expand()
            End If
            lblRemarkCategory.Text = TreeView1.SelectedNode.Text
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try


    End Sub

    Private Function GetNodeByValue(ByVal val As String) As TreeNode

        Dim rootNode As TreeNode = Nothing
        Dim selNode As TreeNode = Nothing

        For Each node As TreeNode In TreeView1.Nodes
            If node.Text = "Examination" Then
                rootNode = node
                Exit For
            End If
        Next

        If rootNode IsNot Nothing Then
            For Each node As TreeNode In rootNode.ChildNodes
                If node.Value = val Then
                    selNode = node
                    Exit For
                End If
            Next
        End If

        Return selNode

    End Function

    Protected Sub AddVital(ByVal t As TextBox, ByVal ID As Integer)
        If t.Text <> "" Then
            HiddenFieldVitalID.Value = ID
            HiddenFieldVital_Value.Value = t.Text
            SqlDataSourcevitals.Insert()
            t.Text = ""

        End If
    End Sub

    Protected Sub btn_delete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim Ibtn As ImageButton = sender
        HiddenField_Prescription_Id.Value = Ibtn.CommandArgument()

        SqlDataSource_Confirmed_Prescriptions.Delete()
        LabelMessageMedicine.Text = "Medicine deleted successfully ..."
        DataList_ConfirmedPrescriptions.DataBind()
    End Sub

    Protected Sub btnSaveReferal_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveReferal.Click
        Dim con As New SqlConnection
        con.ConnectionString = constr
        Try
            If Page.IsValid Then
                If hdnReferalNotes.Value = "" Then
                    con.Open()
                    Dim command As SqlCommand = New SqlCommand("insert into pt_Treatment_Plan (Reg_No,Yearly_No,Plan_Detail,Dept_ID,Type,Phyci_id,emp_id)Values(@reg_no,@Yearly_no,@Plan_Detail,@Dept_ID,'RefDoctor',@Phyci_id,@emp_id)", con)
                    command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
                    command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))
                    command.Parameters.AddWithValue("@Plan_Detail", txtReferalNotes.Text.ToString())
                    command.Parameters.AddWithValue("@Phyci_id", ddlConsultant.SelectedValue)
                    command.Parameters.AddWithValue("@Dept_ID", ddlDept.SelectedValue)
                    command.Parameters.AddWithValue("@emp_id", Session("emp_id"))
                    command.ExecuteNonQuery()
                    con.Close()


                Else

                    Dim command1 As New SqlCommand
                    command1.CommandType = CommandType.Text
                    command1 = con.CreateCommand
                    command1.CommandText = "UPdate pt_Treatment_Plan set Plan_Detail=@Plan_Detail ,Phyci_id=@Phyci_id,Dept_ID=@Dept_ID,emp_id=@emp_id  where Plan_id=@Plan_id and Type='RefDoctor'"
                    command1.Parameters.AddWithValue("@Plan_Detail", txtReferalNotes.Text.ToString())
                    command1.Parameters.AddWithValue("@Plan_id", hdnReferalNotes.Value)
                    command1.Parameters.AddWithValue("@Phyci_id", ddlConsultant.SelectedValue)
                    command1.Parameters.AddWithValue("@Dept_ID", ddlDept.SelectedValue)
                    command1.Parameters.AddWithValue("@emp_id", Session("emp_id"))
                    con.Open()
                    command1.ExecuteNonQuery()

                    con.Close()




                End If
            End If

            DataList_Test.DataBind()
            'GridView1.DataBind()
            '  End If
        Catch ex As Exception
            '  'Response.Write(ex.Message)
        Finally
            con.Close()
            con.Dispose()
        End Try

    End Sub

    Protected Sub ddlDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlDept.SelectedIndexChanged
        GetddlEMPL()
    End Sub

    Sub get_pt_Treatment_PlanForReferals()
        Dim con As New SqlConnection
        con.ConnectionString = constr

        Try
            con.Open()
            Dim command As SqlCommand = New SqlCommand("select plan_id,plan_detail,type,Dept_ID,Phyci_id from pt_Treatment_Plan where  Reg_No=@reg_no and Yearly_No=@yearly_no and type='RefDoctor'", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))

            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim palnid As String = ""
            Dim palnDetail As String = ""
            While reader.Read()
                palnid = reader("plan_id").ToString()
                palnDetail = reader("plan_detail").ToString()
                ddlConsultant.SelectedValue = reader("Phyci_id").ToString()
                ddlDept.SelectedValue = reader("Dept_ID").ToString()
            End While

            hdnReferalNotes.Value = palnid.ToString()
            txtReferalNotes.Text = palnDetail.ToString()


        Catch ex As Exception

        End Try

    End Sub

    Sub GetddlDept()
        Dim constr As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim con As New SqlConnection
        con.ConnectionString = constr
        con.Open()
        Dim command As SqlCommand = New SqlCommand("select dept_ID,dept_name from department", con)

        command.CommandType = CommandType.Text

        Dim da As SqlDataAdapter = New SqlDataAdapter(command)
        Dim ds As DataSet = New DataSet()
        da.Fill(ds)
        con.Close()
        ddlDept.DataSource = ds
        ddlDept.DataValueField = "dept_ID"
        ddlDept.DataTextField = "dept_name"
        ddlDept.DataBind()



    End Sub
    Sub GetddlEMPL()
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
            Dim con As New SqlConnection
            con.ConnectionString = constr
            con.Open()
            Dim command As SqlCommand = New SqlCommand("select EmpID,ISNULL(e.Prefix,'')+' '+ISNULL(e.EFName,'')+' '+ISNULL(e.EMName,'')+' '+ISNULL(e.ELName,'') as name from Employee e where e.DeptID=" + ddlDept.SelectedValue + " and e.Is_Consultant=1", con)
            command.CommandType = CommandType.Text

            Dim da As SqlDataAdapter = New SqlDataAdapter(command)
            Dim ds As DataSet = New DataSet()
            da.Fill(ds)
            con.Close()
            ddlConsultant.DataSource = ds
            ddlConsultant.DataValueField = "EmpID"
            ddlConsultant.DataTextField = "name"
            ddlConsultant.DataBind()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub imgDeletRadiology_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim imageBtn As ImageButton = sender
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            Dim command As SqlCommand = New SqlCommand("Delete from Radiology.dbo.Radiology_Order_Sub where Radiology_SubId=" + imageBtn.CommandArgument + " ", con)
            command.CommandType = CommandType.Text
            command.ExecuteNonQuery()
            con.Close()
            DataList_Radiology.DataBind()
            'DataList_Radiology_Sub.DataBind()
        Catch ex As Exception
            'delete from Radiology.dbo.Radiology_Order_Main where Order_ID=" + imageBtn.CommandArgument + ";
        Finally
            con.Close()
        End Try
    End Sub

    Sub get_pt_Treatment_Pan()
        Dim con As New SqlConnection
        con.ConnectionString = constr

        Try
            con.Open()
            Dim command As SqlCommand = New SqlCommand("select plan_id,plan_detail,type from pt_Treatment_Plan where  Reg_No=@reg_no and Yearly_No=@yearly_no and Type='Phy'", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))

            Dim reader As SqlDataReader = command.ExecuteReader()
            Dim palnid As String = ""
            Dim palnDetail As String = ""
            While reader.Read()
                palnid = reader("plan_id").ToString()
                palnDetail = reader("plan_detail").ToString()
            End While

            hdnPhyNotesId.Value = palnid.ToString()
            txtPhycicianNotes.Text = palnDetail.ToString()

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub imgDeletePath_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim imageBtn As ImageButton = sender
        Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            Dim command As SqlCommand = New SqlCommand("Delete from Investigation_Order_Sub where TB_ID=" + imageBtn.CommandArgument + " ", con)
            command.CommandType = CommandType.Text
            command.ExecuteNonQuery()
            con.Close()
            DataList_Test.DataBind()
        Catch ex As Exception

        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub SqlDataSource_select_all_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_select_all.Inserted
        HiddenFieldComplaint_ID.Value = e.Command.Parameters("@Complaint_ID").Value.ToString()
    End Sub


    Public Sub getConsultant()
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("GetConsultant", "Basic_Data_ConnectionString", New SqlParameter() {})
        ddlDiabetologistName.DataSource = dt
        ddlDiabetologistName.DataValueField = "EmpID"
        ddlDiabetologistName.DataTextField = "Name"
        ddlDiabetologistName.DataBind()

        ddlAssistant.DataSource = dt
        ddlAssistant.DataValueField = "EmpID"
        ddlAssistant.DataTextField = "Name"
        ddlAssistant.DataBind()

    End Sub


    Public Sub getMedinceDepartmentWise()
        Dim subDeptID As String
        If Session("SubDeptID") Is Nothing Then
            subDeptID = "0"
        Else
            subDeptID = Session("SubDeptID")
        End If
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("usp_GetDepartmentWisePatietnMedicines", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("subdeptID", subDeptID)})
        ddlDepartmentMedicines.DataSource = dt
        ddlDepartmentMedicines.DataValueField = "Item_Code"
        ddlDepartmentMedicines.DataTextField = "Item_Name"
        ddlDepartmentMedicines.DataBind()
        ddlDepartmentMedicines.Items.Insert(0, New ListItem("Select", "0"))



    End Sub

    Public Sub getDepartmentWiseDiagnosis()
        Dim subDeptID As String
        If Session("SubDeptID") Is Nothing Then
            subDeptID = "0"
        Else
            subDeptID = Session("SubDeptID")
        End If
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("usp_GetDepartmentWisePatietnDiagnoses", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("subdeptID", subDeptID)})
        chkboxDepartmentDiagnoses.DataSource = dt
        chkboxDepartmentDiagnoses.DataValueField = "ID"
        chkboxDepartmentDiagnoses.DataTextField = "Name"
        chkboxDepartmentDiagnoses.DataBind()

    End Sub

    Public Sub getPatientPreviousMedicine()

        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("Select_Med_Presc_Urdu_PreviousMedication", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("@RegNo", Session("registrationNo"))})
        datalistForPreviousMedicine.DataSource = dt
        datalistForPreviousMedicine.DataBind()



    End Sub

    Public Sub getPatientGeneralInformation()
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTableWithQuery("select * from PatientGeneralInformation where yearlyno=@yearlyno ", "TreatmentConnectionString", New SqlParameter() {New SqlParameter("yearlyno", HttpContext.Current.Session("YearlyNo"))})

        If dt.Rows.Count > 0 Then

            For index = 1 To dt.Rows.Count
                ddlConsultant.SelectedValue = dt.Rows(0)("DiabetologistConsultant").ToString()
                txtboxStart.Text = dt.Rows(0)("Stime").ToString()
                txtboxEnd.Text = dt.Rows(0)("Etime").ToString()
                ddlAssistant.SelectedValue = dt.Rows(0)("Assistant").ToString()
                ddlDiabetiesType.SelectedValue = dt.Rows(0)("DiabetesType").ToString()
                txtboxDate.Text = Convert.ToDateTime(dt.Rows(0)("DiagnosedDate").ToString()).ToString("yyyy-MM-dd")
                txtboxAge.Text = dt.Rows(0)("AgeAtDiagnosed").ToString()
                txtboxDuration.Text = dt.Rows(0)("Duration").ToString()

            Next




        End If


    End Sub

    <WebMethod()>
    Public Shared Function Save(ByVal consultant As String, ByVal stime As String, ByVal etime As String, ByVal assistant As String,
    ByVal diabetiesType As String, ByVal diagnosedTime As String, ByVal duration As String, ByVal age As String) As String
        Dim sstatus As String = ""
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand("uspSaveDiabetiesGeneralInformation", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@DiabetologistConsultant", consultant)
            command.Parameters.AddWithValue("@Stime", stime)
            command.Parameters.AddWithValue("@Etime", etime)
            command.Parameters.AddWithValue("@Assistant", assistant)
            command.Parameters.AddWithValue("@DiabetesType", diabetiesType)
            command.Parameters.AddWithValue("@DiagnosedDate", diagnosedTime)
            command.Parameters.AddWithValue("@AgeAtDiagnosed", age)
            command.Parameters.AddWithValue("@Duration", duration)
            command.Parameters.AddWithValue("@CreatedDate", DateTime.Now.ToString())
            command.Parameters.AddWithValue("@CreatedBy", HttpContext.Current.Session("emp_id"))
            command.Parameters.AddWithValue("@regNo", HttpContext.Current.Session("registrationNo"))
            command.Parameters.AddWithValue("@YearlyNo", HttpContext.Current.Session("YearlyNo"))

            command.ExecuteNonQuery()

            con.Close()
            sstatus = "Successfully Saved"
        Catch ex As Exception
            sstatus = "Something went wrong"
        End Try

        Return sstatus

    End Function


    Protected Sub DropDownList_frequencyNameForPreviousMedicine_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = sender
        Dim datalist As DataListItem = DirectCast(ddl.NamingContainer, DataListItem)
        Dim frequencyDropDown As DropDownList = DirectCast(datalist.FindControl("DropDownList_frequencyNameForPreviousMedicine"), DropDownList)
        Dim frequencyDatalist As DataList = DirectCast(datalist.FindControl("DataList_FrequencyForPreviousMedicine"), DataList)

        Dim db As DbManager = New DbManager()
        Dim dt As DataTable = db.ExecuteDataTable("uspGetFrequencyList", "TreatmentConnectionString", New SqlParameter() {New SqlParameter("id", frequencyDropDown.SelectedValue)})
        frequencyDatalist.DataSource = dt
        frequencyDatalist.DataBind()

    End Sub



    Protected Sub btnSavePreviousMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            For index = 0 To datalistForPreviousMedicine.Items.Count - 1


                Dim CheckboxForSelection As CheckBox = datalistForPreviousMedicine.Items(index).FindControl("assign")
                If CheckboxForSelection.Checked = True Then
                    Dim MedicineName As HiddenField = datalistForPreviousMedicine.Items(index).FindControl("hfMedicine_Name")
                    Dim MedicineCode As HiddenField = datalistForPreviousMedicine.Items(index).FindControl("hfMedicine_Code")
                    Dim ddlRoute As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_routeForPreviousMedicine")
                    Dim ddlFrequency As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_frequencyNameForPreviousMedicine")
                    Dim txtboxFrequency As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBox_FrequencyForPreviousMedicine")
                    Dim datalistFrequency As DataList = datalistForPreviousMedicine.Items(index).FindControl("DataList_FrequencyForPreviousMedicine")
                    Dim ddlMeal As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_Meal")
                    Dim txtboxDays As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBox_daysForPreviousMedicine")
                    Dim StartDate As WebDateChooser = datalistForPreviousMedicine.Items(index).FindControl("WebDateChooserPreviousStartDate")
                    Dim txtboxBeforeMeal As TextBox = datalistForPreviousMedicine.Items(index).FindControl("txtboxBeforeMealForPreviousMedicine")
                    Dim txtboxAfterMeal As TextBox = datalistForPreviousMedicine.Items(index).FindControl("txtboxAfterMealForPreviousMedicine")
                    Dim txtboxInstruction As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBoxInstructionForPreviousMedicine")
                    Dim ddlMedicineType As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("ddlMedicineTypeForPreviousMedicine")

                    HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))
                    HiddenField_MedCode.Value = MedicineCode.Value


                    Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    Dim con As SqlConnection = New SqlConnection(a)
                    Dim mycommand As New SqlCommand("Insert_Patient_Prescription_Detail", con)
                    mycommand.CommandType = CommandType.StoredProcedure
                    mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@Med_Code", MedicineCode.Value)
                    mycommand.Parameters.AddWithValue("@Registration_NO", Session("registrationNo"))
                    mycommand.Parameters.AddWithValue("@Route_ID", ddlRoute.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Dilution", "")
                    mycommand.Parameters.AddWithValue("@Meal", "")
                    mycommand.Parameters.AddWithValue("@Frequency_ID", ddlFrequency.SelectedValue)
                    mycommand.Parameters.AddWithValue("@days", txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@Instruction", txtboxInstruction.Text.ToString())
                    mycommand.Parameters.AddWithValue("@StartDate", StartDate.Value)

                    Dim d As String = Convert.ToDateTime(StartDate.Value).Date.AddDays(txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@EndDate", d)
                    mycommand.Parameters.AddWithValue("@Dose", "")
                    mycommand.Parameters.AddWithValue("@Dosage", "")
                    mycommand.Parameters.AddWithValue("@CT", "")
                    mycommand.Parameters.AddWithValue("@Duration", "")
                    mycommand.Parameters.AddWithValue("@Medicine_Advice_Category_ID", "")
                    mycommand.Parameters.AddWithValue("@BeforeMeal", txtboxBeforeMeal.Text.Trim().ToString())
                    mycommand.Parameters.AddWithValue("@AfterMeal", txtboxAfterMeal.Text.Trim().ToString())
                    mycommand.Parameters.AddWithValue("@MedicineType", ddlMedicineType.SelectedValue)

                    mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_id"))
                    mycommand.Parameters.Add("@Prescription_Id", SqlDbType.Int)
                    mycommand.Parameters("@Prescription_Id").Direction = ParameterDirection.Output

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    HiddenField_Prescription_Id.Value = mycommand.Parameters("@Prescription_Id").Value
                    con.Close()

                    Update_Confirmation(HiddenField_Prescription_Id.Value)
                    DataList_ConfirmedPrescriptions.DataBind()
                    LabelMessageMedicine.Text = Label1.Text + " " + " added sussessfully..."

                    GridView_Template_Medicine.DataBind()
                    GridView2.DataBind()
                    gen_xml(Date.Now)
                    TextBox_dilution.Text = ""
                    TextBox_dosage.Text = "1"
                    Label1.Text = ""
                    DataList_new.DataBind()
                    DataList_old.DataBind()

                    For i As Integer = 0 To datalistFrequency.Items.Count - 1
                        Dim HF_F_S_Id As HiddenField = datalistFrequency.Items(i).FindControl("HF_F_S_IdForPreviousMedicine")
                        HiddenField_Frequency_Sub_Id.Value = HF_F_S_Id.Value
                        Dim TextBox_dosage1 As TextBox = datalistFrequency.Items(i).FindControl("TextBox_dosage2ForPreviousMedicine")
                        HiddenField_DL_Dosage.Value = TextBox_dosage1.Text
                        HiddenField_priscription_id.Value = HiddenField_Prescription_Id.Value
                        Try
                            SqlDataSource_Frequency_detail.Insert()
                        Catch ex As Exception
                            'Response.Write(ex.Message)
                        End Try
                    Next
                End If
            Next

            DataList_ConfirmedPrescriptions.DataBind()
            getPatientPreviousMedicine()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub datalistForPreviousMedicine_ItemDataBound(sender As Object, e As DataListItemEventArgs)
        Dim datee As WebDateChooser = e.Item.FindControl("WebDateChooserPreviousStartDate")
        datee.Value = DateTime.Now.Date

    End Sub
    Protected Sub TextBox_Test_TextChanged(sender As Object, e As EventArgs) Handles TextBox_Test.TextChanged
        'Dim strTestId As String = String.Empty
        'If Is_exist(TextBox_Test.Text, strTestId) Then
        '    Book_Path_Test(TextBox_Test.Text, strTestId)
        '    HiddenField_MG_ID.Value = "%"
        'End If
    End Sub
    Protected Sub TextBox_TestRadiology_TextChanged(sender As Object, e As EventArgs) Handles TextBox_TestRadiology.TextChanged
        'Dim strTestId As String = String.Empty
        'If IsRadiologyExist(TextBox_TestRadiology.Text, strTestId) Then

        '    Radiology_Test(TextBox_TestRadiology.Text, strTestId)
        'End If
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "CallMyFunction", "HidePreviousTest()", True)
    End Sub
    Protected Sub btnreport_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/pt_EMR/OPD_Encounter_FormReport.aspx")
    End Sub

    
End Class
