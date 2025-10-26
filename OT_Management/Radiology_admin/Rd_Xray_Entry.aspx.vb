
Partial Class Rd_Xray_Entry
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            If Request.QueryString("BodyPart") Is Nothing Then
            Else
                DropDownListBodyPart.DataBind()
                DropDownListProjection.DataBind()
                DropDownListBodyPart.SelectedValue = Request.QueryString("BodyPart")
                DropDownListProjection.SelectedValue = Request.QueryString("Projection")
            End If
        End If

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
            response.write(ex.message)
        End Try
       
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try

            SqlDataSourceSaveInfo.Insert()
            Label1.Text = "Your Information Has Been Saved"

        Catch ex As Exception
            Label1.Text = "Your Information Has Not Been Saved"
        End Try

    End Sub




End Class
