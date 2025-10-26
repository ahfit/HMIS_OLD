
Partial Class Rd_Body_Part
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            loginvalidate(Session("emp_id"), Session("dept_id"))
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                'Response.Redirect("loginnew.aspx")

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Response.Write(TextBox1.Text + " " + TextBox2.Text)
            SqlDataSourceSave.Insert()
            GridView_BodyPart.databind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
