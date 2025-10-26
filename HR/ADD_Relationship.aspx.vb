Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class Medical_Reimbursement_ADD_Relationship
    Inherits System.Web.UI.Page
    Dim DT, DateBirth As Date
    Protected Sub Button_save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_save.Click
        Try
            DateOfBirth()
            SqlDataSourceSaveInfo.Insert()
            GridView1.DataBind()
            RadioButtonListPrefix.SelectedIndex = 0
            TextBoxFName.Text = ""
            TextBoxMName.Text = ""
            TextBoxLName.Text = ""
            RadioButtonListRelation.SelectedIndex = 0
            TextBoxRFName.Text = ""
            TextBoxRMName.Text = ""
            TextBoxRLName.Text = ""
            RadioButtonList_Relation_with_patient.SelectedIndex = 0
            textboxage.Text = ""
            DropDownListBIndicator.SelectedIndex = 0
            Dropdownlistsex.SelectedIndex = 0
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub DateOfBirth()
        Try
            If textboxage.Text = "" Then
                Response.Write("Please Enter Age")
                Exit Sub
            Else
                If DropDownListBIndicator.SelectedItem.Text = "Years" Then
                    DateBirth = DateAdd(DateInterval.Year, -(CInt(textboxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Months" Then
                    DateBirth = DateAdd(DateInterval.Month, -(CInt(textboxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Days" Then
                    DateBirth = DateAdd(DateInterval.Day, -(CInt(textboxage.Text)), Date.Now)
                ElseIf DropDownListBIndicator.SelectedItem.Text = "Hours" Then
                    DateBirth = DateAdd(DateInterval.Hour, -(CInt(textboxage.Text)), Date.Now)
                End If
            End If
            HiddenField_DOB.Value = DateBirth
        Catch ex As Exception
            'Response.Write("PLease Enter Age")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("emp_ID") Is Nothing Then

            Response.Redirect("~/login.aspx")
        End If

        If Not Page.IsPostBack Then
            If Request.QueryString("Emp_Id") Is Nothing Then
                Response.Redirect("Search_Employee.aspx?PName=Edit Employee&MName=Employee Info")
            End If
        End If
    End Sub

    'Protected Sub Button_Back_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Back.Click
    '    Response.Redirect("../hr/Employee_Basic_info_edit.aspx?emp_ID=" + Request.QueryString("Emp_Id"))
    'End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim hid As HiddenField = gv.FindControl("HiddenField_id")
        HiddenField_SelectedID.Value = hid.Value

        FormFill()


    End Sub
    Protected Sub FormFill()
        Dim qry As String = "SELECT Medical_Reimbursement_ID, emp_ID, Prefix, FName, MName, LName, Relation, RFName, RMame, RLName, Relationship_with_Patient, Age, AgeType, DOB, Gender FROM  Medical_Reimbursement_master WHERE (Medical_Reimbursement_ID = @Medical_Reimbursement_ID)"
        Dim conect As String = Convert.ToString(ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString"))
        Dim con As New SqlConnection(conect)
        Dim cmd As New SqlCommand(qry, con)
        Try
            con.Open()
            cmd.Parameters.AddWithValue("@Medical_Reimbursement_ID", HiddenField_SelectedID.Value)
            Dim r As SqlDataReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            Dim dt As New DataTable()
            dt.Load(r)

            HiddenField_Emp_Id.Value = Convert.ToString(dt.Rows(0)(1).ToString())
            RadioButtonListPrefix.SelectedValue = Convert.ToString(dt.Rows(0)(2).ToString())
            TextBoxFName.Text = Convert.ToString(dt.Rows(0)(3).ToString())
            TextBoxMName.Text = Convert.ToString(dt.Rows(0)(4).ToString())
            TextBoxLName.Text = Convert.ToString(dt.Rows(0)(5).ToString())
            RadioButtonListRelation.SelectedValue = Convert.ToString(dt.Rows(0)(6).ToString())
            TextBoxRFName.Text = Convert.ToString(dt.Rows(0)(7).ToString())
            TextBoxRMName.Text = Convert.ToString(dt.Rows(0)(8).ToString())
            TextBoxRLName.Text = Convert.ToString(dt.Rows(0)(9).ToString())
            RadioButtonList_Relation_with_patient.SelectedValue = Convert.ToString(dt.Rows(0)(10).ToString())
            textboxage.Text = Convert.ToString(dt.Rows(0)(11).ToString())
            DropDownListBIndicator.SelectedValue = Convert.ToString(dt.Rows(0)(12).ToString())
            Dropdownlistsex.SelectedValue = Convert.ToString(dt.Rows(0)(14).ToString())



        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
        Button_Update.Visible = True
        ButtonCancel.Visible = True
        Button_save.Visible = False

    End Sub

    Protected Sub ButtonCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonCancel.Click
        Button_Update.Visible = False
        ButtonCancel.Visible = False
        Button_save.Visible = True


        RadioButtonListPrefix.SelectedIndex = 0
        TextBoxFName.Text = ""
        TextBoxMName.Text = ""
        TextBoxLName.Text = ""
        RadioButtonListRelation.SelectedIndex = 0
        TextBoxRFName.Text = ""
        TextBoxRMName.Text = ""
        TextBoxRLName.Text = ""
        RadioButtonList_Relation_with_patient.SelectedIndex = 0
        textboxage.Text = ""
        DropDownListBIndicator.SelectedIndex = 0
        Dropdownlistsex.SelectedIndex = 0
    End Sub

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click

        DateOfBirth()
        SqlDataSourceSaveInfo.Update()

        RadioButtonListPrefix.SelectedIndex = 0
        TextBoxFName.Text = ""
        TextBoxMName.Text = ""
        TextBoxLName.Text = ""
        RadioButtonListRelation.SelectedIndex = 0
        TextBoxRFName.Text = ""
        TextBoxRMName.Text = ""
        TextBoxRLName.Text = ""
        RadioButtonList_Relation_with_patient.SelectedIndex = 0
        textboxage.Text = ""
        DropDownListBIndicator.SelectedIndex = 0
        Dropdownlistsex.SelectedIndex = 0
        GridView1.DataBind()
        Button_Update.Visible = False
        ButtonCancel.Visible = False
        Button_save.Visible = True
    End Sub
End Class
