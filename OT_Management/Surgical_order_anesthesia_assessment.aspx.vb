Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Partial Class Surgical_order_anesthesia_assessment
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Dim en As New Encryption
    'Protected Sub CheckBoxList_Diagnosis_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_Diagnosis.SelectedIndexChanged

    '    'TextBox_admision_Diagnosis.Text = ""
    '    'For i As Integer = 0 To CheckBoxList_Diagnosis.Items.Count - 1
    '    '    If CheckBoxList_Diagnosis.Items(i).Selected = True Then
    '    '        If TextBox_admision_Diagnosis.Text <> "" Then
    '    '            TextBox_admision_Diagnosis.Text = TextBox_admision_Diagnosis.Text + ", " + CheckBoxList_Diagnosis.Items(i).Text
    '    '        Else
    '    '            TextBox_admision_Diagnosis.Text = TextBox_admision_Diagnosis.Text + CheckBoxList_Diagnosis.Items(i).Text
    '    '        End If

    '    '    End If
    '    'Next

    'End Sub

   

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        If Page.IsPostBack = False Then
            'DropDownListConsultant.SelectedValue = Session("emp_Id")
            'WebDateChooser_Date_Of_admission.Value = Date.Now()


            Dim obj_menu As New JavaScriptMenu
            LabelFooter.Text = obj_menu.Footer_String()
            LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

            '' Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Button_Save.Attributes.Add("onclick", "return Validation()")
            'WebDateChooser_Date_Of_admission.Value = Now()


        End If
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        HiddenField_Date.Value = Date.Now()
        SqlDataSource_WardAdmission.Insert()
        Label_Message.Text = "Information has been saved"
        Button_Save.Visible = False
    End Sub
End Class
