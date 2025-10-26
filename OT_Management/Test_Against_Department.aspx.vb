
Partial Class Test_Against_Department
    Inherits System.Web.UI.Page

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            For i As Integer = 0 To GridGorSubGroup.Rows.Count - 1
                Dim hid_SGID As HiddenField = GridGorSubGroup.Rows(i).FindControl("HiddenField1")
                Dim ckeck As CheckBox = GridGorSubGroup.Rows(i).FindControl("CheckBox1")
                If ckeck.Checked = True Then
                    HiddenField_SGID.Value = hid_SGID.Value
                    ForTestGroup.Insert()
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
