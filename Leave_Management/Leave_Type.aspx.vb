
Partial Class Leave_Type
    Inherits System.Web.UI.Page

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        If TextBox_Type_Name.Text = "" And txtAbb.Text = "" Then
            Label3.Text = "Please Enter First Leave Type and Abb"
            Label3.ForeColor = Drawing.Color.Red

        Else

            If Button_Save.Text = "Update" Then
                'Response.Write(RadioButtonList_Carries_Forward.SelectedValue)
                Try
                    SqlDataSource_Leave_Type.UpdateParameters("Leave_Type_Id").DefaultValue = HF_LeaveTypeID.Value
                    SqlDataSource_Leave_Type.Update()

                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

                Clear_Controls()
                Button_Save.Text = "Save"
            Else
                SqlDataSource_Leave_Type.Insert()
            End If
            GridView4.DataBind()
            TextBox_Type_Name.Text = ""
            txtAbb.Text = ""
        End If

    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            GridView4.DataBind()
        End If

    End Sub

    Protected Sub GridView4_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridView4.RowEditing
        Dim HF_Leave_Type_Id As HiddenField = GridView4.Rows(e.NewEditIndex).FindControl("HiddenField_Type_id")
        HF_LeaveTypeID.Value = HF_Leave_Type_Id.Value
        GridView4.EditIndex = e.NewEditIndex

    End Sub

    Private Sub Clear_Controls()
        TextBox_Type_Name.Text = ""
        RadioButtonList_Encashment.SelectedIndex = "0"
        RadioButtonList_Gender.SelectedIndex = "0"
        RadioButtonList_Carries_Forward.SelectedValue = "0"
        TextBox_Description.Text = ""
        Button_Save.Text = "Save"
        HF_LeaveTypeID.Value = ""
    End Sub
    Private Sub Load_Controls(ByVal Index As Integer)
        Dim lbl_type As Label = GridView4.Rows(Index).FindControl("Label1")
        TextBox_Type_Name.Text = lbl_type.Text
        Dim Chk_Encash As CheckBox = GridView4.Rows(Index).FindControl("Chk_Encash")
        If Chk_Encash.Checked Then
            RadioButtonList_Encashment.SelectedValue = "true"
        Else
            RadioButtonList_Encashment.SelectedValue = "false"
        End If
        Dim hf_abb As HiddenField = GridView4.Rows(Index).FindControl("HiddenField_Abb")
        txtAbb.Text = hf_abb.Value

        Dim HF_Gender_ID As HiddenField = GridView4.Rows(Index).FindControl("HF_Gender_ID")
        RadioButtonList_Gender.SelectedValue = HF_Gender_ID.Value
        Dim Chk_CarriesFrd As CheckBox = GridView4.Rows(Index).FindControl("Chk_CarriesFrd")
        If Chk_CarriesFrd.Checked Then
            RadioButtonList_Carries_Forward.SelectedValue = "true"
        Else
            RadioButtonList_Carries_Forward.SelectedValue = "false"
        End If

        Dim lbl_Desc As Label = GridView4.Rows(Index).FindControl("lbl_Desc")
        TextBox_Description.Text = lbl_Desc.Text
        Dim HF_Leave_Type_Id As HiddenField = GridView4.Rows(Index).FindControl("HiddenField_Type_id")
        HF_LeaveTypeID.Value = HF_Leave_Type_Id.Value
        Button_Save.Text = "Update"

    End Sub
    Protected Sub GridView4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView4.SelectedIndexChanged
        Load_Controls(GridView4.SelectedIndex)
        Button_Cancel.Visible = True
    End Sub

    Protected Sub Button_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Cancel.Click
        Button_Save.Text = "Save"
        Button_Cancel.Visible = False
        TextBox_Type_Name.Text = ""
        TextBox_Description.Text = ""
        RadioButtonList_Encashment.SelectedValue = "true"
        RadioButtonList_Gender.SelectedValue = "1"
        RadioButtonList_Carries_Forward.SelectedValue = "true"

        GridView4.DataBind()
    End Sub

    Protected Sub LinkButton_Edit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim lk As LinkButton = sender
        'HF_LeaveTypeID.Value = lk.CommandArgument
        'SqlDataSource_Leave_Type.Update()
        'GridView4.DataBind()
    End Sub

    Protected Sub GridView4_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView4.RowUpdating
        
    End Sub
End Class


