
Partial Class Pathology_Update_Component_Max_length
    Inherits System.Web.UI.Page

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        HiddenFieldMaxLength.Value = GridView1.Rows(e.RowIndex).Cells(5).Text
        HiddenFieldMinValue.Value = GridView1.Rows(e.RowIndex).Cells(6).Text
        HiddenFieldMaxValue.Value = GridView1.Rows(e.RowIndex).Cells(7).Text
    End Sub
End Class
