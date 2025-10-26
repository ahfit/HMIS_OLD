' Author              Imran Ahmed Awan 
' Created date        05 December 2006
' Description         Create the Employee Login and Check That No User Name is replicated 
Imports System.Data
Imports System.Data.SqlClient
Partial Class ChangePassword
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("EmpPassword", con1)
            mycommand1.CommandType = Data.CommandType.StoredProcedure
            mycommand1.Parameters.AddWithValue("@UserName", Session("UserName"))
            mycommand1.Parameters.AddWithValue("@Password", ENC.Encrypt_Main(TextBoxOldPass.Text, True))
            mycommand1.Parameters.AddWithValue("@NewPassword", ENC.Encrypt_Main(TextBoxPassword.Text, True))
            mycommand1.Parameters.AddWithValue("@IPAddress", Request.ServerVariables("Remote_Addr"))
            mycommand1.Parameters.Add("@Flag", SqlDbType.Bit)
            mycommand1.Parameters("@Flag").Direction = ParameterDirection.Output
            mycommand1.Connection.Open()
            mycommand1.ExecuteNonQuery()
            Dim flag As Boolean = mycommand1.Parameters("@Flag").Value
            mycommand1.Connection.Close()
            If flag = True Then
                Label1.Text = "Your Information Has Been saved "
            Else
                Label1.Text = "Your Login Information is not correct"
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Label_user_name.Text = Session("UserName")
    End Sub
End Class
