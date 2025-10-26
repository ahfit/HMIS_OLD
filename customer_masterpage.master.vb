Imports System.Data
Imports System.Data.SqlClient

Partial Class customer_masterpage
    Inherits System.Web.UI.MasterPage

    Dim obj As New Draw_Panel
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
    Dim ENC As New Encryption



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        loginvalidate()

        Session.Add("Page_Name", Request.QueryString("Page_Name"))
        Session.Add("Page", Request.QueryString("Page"))
        LabelDoctorName.Text = Session("Company_Name")
    End Sub

    Sub loginvalidate()
        Try
            If ((Session("username") Is Nothing)) Then
                Response.Write("~/login.aspx")
            End If
        Catch ex As Exception
        End Try
    End Sub

End Class

