
Partial Class Pathology_Cancel_Test
    Inherits System.Web.UI.Page

    Protected Sub GridViewMain_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewMain.SelectedIndexChanged
        Panel1.Visible = True
        Dim hid_TGID As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenField6")
        Dim hid_Main_Id As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenField8")
        Dim hid_TBID As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenFieldTBID")

        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TBID.Value = hid_TBID.Value
      
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            SqlDataSource_Status1.Update()
            SqlDataSource_Status.Update()

            SqlDataSource_Status.Insert()
            TextBox_Remarks.Text = ""
            Panel1.Visible = False
        Catch ex As Exception

        End Try
        
    End Sub
End Class
