
Partial Class Administrator_Admin_shift
    Inherits System.Web.UI.Page

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click

        Try
            If TextBoxShiftName.Text = "" And TextBoxDescription.Text = "" Then
                lblMsg.Text = "Please Fill Reequired Field"
            Else
                SqlDataSourceShift.Insert()
                GridView1.DataBind()
                TextBoxShiftName.Text = ""
                TextBoxDescription.Text = ""

            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
