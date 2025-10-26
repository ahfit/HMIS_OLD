Imports System.Data
Imports System.Data.SqlClient
Partial Class ptXrayView
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loginvalidate(Session("emp_id"), Session("dept_id"))
        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT [Image],Image_Content_Type FROM [pt_Xray_Images] where Xray_ID = @Xray_ID", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim sqlreader As System.Data.SqlClient.SqlDataReader

        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Xray_ID", Request.QueryString("Xray_ID"))
        'param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("rig_no"))
        'param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId")))
        Try
            mycommand.Connection.Open()
            sqlreader = mycommand.ExecuteReader
            Dim byt As Byte()
            If sqlreader.Read() Then
                byt = sqlreader.Item(0)
                Response.OutputStream.Write(byt, 0, byt.Length)


                ' dReader.Read()

                Response.BinaryWrite(sqlreader.Item("Image"))
                Response.ContentType = sqlreader.Item("Image_Content_Type").ToString()
                sqlreader.Close()

            End If
            mycommand.Connection.Close()
            'onPageLoad()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.write(ex.message)
        End Try

    End Sub
    'Sub onPageLoad()
    '    Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    '    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '    Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Xray_Description from Rd_Xray_Report Where ((YearlyNo= @YearlyNo)and(RegNo=@RegNo)and(Xray_ID=@Xray_ID))", con)
    '    mycommand.CommandType = Data.CommandType.Text
    '    Dim param As System.Data.SqlClient.SqlParameter
    '    param = mycommand.Parameters.AddWithValue("@Xray_ID", Request.QueryString("Xray_ID"))
    '    param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("rig_no"))
    '    param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
    '    Try
    '        Dim da As New SqlDataAdapter
    '        Dim ds As New DataSet
    '        mycommand.Connection.Open()
    '        da.SelectCommand = mycommand
    '        da.Fill(ds, "a")
    '        ' abc = CType(mycommand.ExecuteScalar, Integer)
    '        Dim abc As String = ds.Tables(0).Rows(0).Item(0)
    '        mycommand.ExecuteNonQuery()
    '        mycommand.Connection.Close()
    '        TextBoxXrayDescription.Text = abc
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try
    ' End Sub
End Class