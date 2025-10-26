Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class Diagnosis
    Inherits System.Web.UI.Page
    Dim ClassObj As New PatientBasicInfo
    Dim userAuthen As New User_page_Authentication
    Dim agedate As String
    Dim constr_TreatmentAdmin As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString


    Protected Sub SearchButton_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SearchButton.Click
        GridView1.DataSourceID = "SqlDataSource2"
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            'For i As Integer = 0 To GridView1.Rows.Count - 1
            '    Dim CheckPast As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            '    Dim CheckProvisonal As CheckBox = GridView1.Rows(i).FindControl("CheckBox2")
            '    Dim CheckFinal As CheckBox = GridView1.Rows(i).FindControl("CheckBox3")
            '    HiddenFieldDisease.Value = GridView1.Rows(i).Cells(2).Text
            '    If CheckPast.Checked = True And CheckProvisonal.Checked = True And CheckFinal.Checked = True Then
            '        HiddenFieldPast.Value = "True"
            '        HiddenFieldProvisional.Value = "True"
            '        HiddenFieldFinal.Value = "True"
            '        HiddenFieldDiagnosis.Value = GridView1.Rows(i).Cells(0).Text
            '        Session("ExpectedDisease") = HiddenFieldDiagnosis.Value
            '        Session("DiseaseName") = GridView1.Rows(i).Cells(2).Text
            '        SqlDataSourceDiagnosis.Insert()
            '    ElseIf CheckPast.Checked = True Then
            '        HiddenFieldPast.Value = "True"
            '        HiddenFieldProvisional.Value = "False"
            '        HiddenFieldFinal.Value = "False"
            '        HiddenFieldDiagnosis.Value = GridView1.Rows(i).Cells(0).Text
            '        Session("ExpectedDisease") = HiddenFieldDiagnosis.Value
            '        Session("DiseaseName") = GridView1.Rows(i).Cells(2).Text
            '        SqlDataSourceDiagnosis.Insert()
            '    ElseIf CheckProvisonal.Checked = True Then
            '        HiddenFieldPast.Value = "False"
            '        HiddenFieldProvisional.Value = "True"
            '        HiddenFieldFinal.Value = "False"
            '        HiddenFieldDiagnosis.Value = GridView1.Rows(i).Cells(0).Text
            '        Session("ExpectedDisease") = HiddenFieldDiagnosis.Value
            '        Session("DiseaseName") = GridView1.Rows(i).Cells(2).Text
            '        SqlDataSourceDiagnosis.Insert()
            '    ElseIf CheckFinal.Checked = True Then
            '        HiddenFieldPast.Value = "False"
            '        HiddenFieldProvisional.Value = "False"
            '        HiddenFieldFinal.Value = "True"
            '        HiddenFieldDiagnosis.Value = GridView1.Rows(i).Cells(0).Text
            '        Session("ExpectedDisease") = HiddenFieldDiagnosis.Value
            '        Session("DiseaseName") = GridView1.Rows(i).Cells(2).Text
            '        SqlDataSourceDiagnosis.Insert()
            '    End If
            'Next
            HiddenFieldPast.Value = "False"
            HiddenFieldProvisional.Value = "true"
            HiddenFieldFinal.Value = "False"
            HiddenFieldDisease.Value = TextBox_Diagnosis_search.Text
            HiddenFieldDiagnosis.Value = ICDCode(TextBox_Diagnosis_search.Text)
            SqlDataSourceDiagnosis.Insert()
            DataList_CurrentVisitDiagnosis.DataBind()
            GridView3.DataBind()
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            'For i As Integer = 0 To CheckBoxListDiagnosis.Items.Count - 1
            '    If CheckBoxListDiagnosis.Items(i).Selected = True Then
            '        If CheckBoxListDiagnosis.Items(i).Text = "Past" Then
            '            HiddenFieldPastNew.Value = 1
            '        End If
            '        If CheckBoxListDiagnosis.Items(i).Text = "Provisional" Then
            '            HiddenFieldProvisionalNew.Value = 1
            '        End If
            '        If CheckBoxListDiagnosis.Items(i).Text = "Final" Then
            '            HiddenFieldFinalNew.Value = 1
            '        End If
            '    End If
            'Next
            If TextBox_Diagnosis_search.Text <> "" Then
                HiddenFieldPast.Value = "False"
                HiddenFieldProvisional.Value = "true"
                HiddenFieldFinal.Value = "False"
                HiddenFieldDisease.Value = TextBox_Diagnosis_search.Text
                HiddenFieldDiagnosis.Value = ICDCode(TextBox_Diagnosis_search.Text)
                SqlDataSourceDiagnosis.Insert()
                DataList_CurrentVisitDiagnosis.DataBind()
                DataList1.DataBind()
                GridView3.DataBind()
            End If

            'SqlDataSourceNew.Insert()
            'GridView3.DataBind()
            TextBoxDiagnosis.Text = ""
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Protected Sub ListBox1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ListBox1.SelectedIndexChanged
        TextBoxDiagnosis.Text = ListBox1.SelectedItem.Text
    End Sub

    Protected Sub gridview3_rowupdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView3.RowUpdating
        Dim checkpast1 As CheckBox = GridView3.Rows(e.RowIndex).FindControl("CheckBox4")
        Dim checkprovisonal1 As CheckBox = GridView3.Rows(e.RowIndex).FindControl("CheckBox5")
        Dim checkfinal1 As CheckBox = GridView3.Rows(e.RowIndex).FindControl("CheckBox6")

        If checkpast1.checked = True Then
            HiddenFieldPastUpdate.Value = "True"
        Else
            HiddenFieldPastUpdate.Value = "False"
        End If
        If checkprovisonal1.checked = True Then
            hiddenfieldprovisonalupdate.value = "true"
        Else
            hiddenfieldprovisonalupdate.value = "false"
        End If
        If checkfinal1.checked = True Then
            hiddenfieldfinalupdate.value = "true"
        Else
            hiddenfieldfinalupdate.value = "false"
        End If
    End Sub

    Protected Sub GridView3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView3.SelectedIndexChanged

    End Sub


    Protected Sub TextBox_Diagnosis_search_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Diagnosis_search.TextChanged

        'Dim constr As String = ConfigurationManager.ConnectionStrings("Treatment_AdminConnectionString").ConnectionString
        'Dim con As SqlConnection = New SqlConnection(constr)
        'con.Open()
        'Dim Sp_Insert As String = "admin_insert_Diagnosis_For_Department"
        'Dim command As SqlCommand = New SqlCommand(Sp_Insert, con)
        'command.CommandType = CommandType.StoredProcedure
        'command.Parameters.AddWithValue("@Diagnosis_Name", TextBox_Diagnosis_search.Text)

        'command.Parameters.AddWithValue("@Dept_id", HttpContext.Current.Session("Dept_id"))
        'command.Parameters.AddWithValue("@SudDept_id", HttpContext.Current.Session("SubDeptID"))

        'command.ExecuteNonQuery()
        'con.Close()
        'con.Dispose()
    End Sub
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

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()

        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
    End Sub

    Protected Sub DataList_CurrentVisitDiagnosis_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_CurrentVisitDiagnosis.SelectedIndexChanged
        Panel_Update_Dignosis.Visible = True

    End Sub

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click

        If CheckBoxList_ProvisionFinal.Items(1).Selected = True Then
            SqlDataSource_UpdateDiagnosis.Update()
            DataList_CurrentVisitDiagnosis.DataBind()
            Panel_Update_Dignosis.Visible = False
            CheckBoxList_ProvisionFinal.Items(1).Selected = False
        End If

        'Response.Write()
        'If CheckBoxList_ProvisionFinal.Items(1).Text Then
        '    SqlDataSource_DataListCurrnentDiagnosis.Update()

    End Sub


    Protected Sub ImageButton_Pnl_Close_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Pnl_Close.Click
        'ImageButton_Pnl_Close
        Panel_Update_Dignosis.Visible = False
    End Sub

    Protected Sub DataList_CurrentVisitDiagnosis_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_CurrentVisitDiagnosis.ItemCommand
        If e.CommandName = "remove" Then
            HF_Diagnosis_ID.Value = e.CommandArgument
            SqlDataSource_UpdateDiagnosis.Delete()
            DataList_CurrentVisitDiagnosis.DataBind()
        End If
    End Sub
End Class
