
Partial Class Pathology_Insert_Pathology_Templates
    Inherits System.Web.UI.Page
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Server.Transfer("../login.aspx")
            End If
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        loginvalidate(Session("emp_id"), Session("dept_id"))

    End Sub

 
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        SqlDataSource_Insert_Template.Insert()
        TextBox_Template.Text = ""
        TextBox_Template_Name.Text = ""
        GridView_Template.DataBind()
    End Sub
End Class
