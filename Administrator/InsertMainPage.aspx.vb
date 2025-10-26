
Partial Class Administrator_InsertMainPage
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub BtnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSave.Click
        SqlDataSource1.InsertParameters("pagename").DefaultValue = tbxpagename.Text
        SqlDataSource1.InsertParameters("pageurl").DefaultValue = tbxpageurl.Text
        SqlDataSource1.Insert()
        GridView1.DataBind()
    End Sub
End Class
