
Partial Class Admin_Radiology_MainGroup_Relation
    Inherits System.Web.UI.Page




    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            SqlDataSourceSaveInfo.Insert()
            GridView1.DataBind()
        Catch ex As Exception

        End Try
    End Sub


    Protected Sub DropDownListSGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListSGName.SelectedIndexChanged
        GridView1.DataBind()
    End Sub

    Protected Sub DropDownListRadiology_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListRadiology.SelectedIndexChanged
        GridView1.DataBind()
    End Sub

    Protected Sub DropDownListMGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMGName.SelectedIndexChanged
        GridView1.DataBind()
    End Sub
End Class
