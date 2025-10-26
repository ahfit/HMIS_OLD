
Partial Class LeavesView_Reject
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        GridView1.DataBind()


    End Sub


    Protected Sub btnSearch_Click(sender As Object, e As System.EventArgs) Handles btnSearch.Click
        Try
            GridView1.DataBind()
        Catch ex As Exception

        End Try

    End Sub
End Class
