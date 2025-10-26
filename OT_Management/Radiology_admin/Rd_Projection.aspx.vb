
Partial Class Rd_Projection
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            loginvalidate(Session("emp_id"), Session("dept_id"))
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                'Response.Redirect("loginnew.aspx")
            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
       
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            SqlDataSourceSaveInfo.Insert()
            GridViewRdProjection.DataBind()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Protected Sub GridViewRdProjection_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewRdProjection.RowUpdating
        Try
            Dim textboxProj As New TextBox
            textboxProj = GridViewRdProjection.Rows.Item(e.RowIndex).FindControl("TextBoxProjections")
            HiddenFieldProjection.Value = textboxProj.Text
            Dim textboxAlies As New TextBox
            textboxAlies = GridViewRdProjection.Rows.Item(e.RowIndex).FindControl("TextBoxAlias")
            HiddenFieldAlias.Value = TextBoxAlias.Text
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub



End Class
