
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class HR_DocumentsUpload
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillGridView()

        End If
    End Sub


    Private Sub FillGridView()

        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString

        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr)

        Using connection As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("select * from DocumentsUpload", connection)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
            command.CommandType = CommandType.Text

            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            gdImage.DataSource = dt
            gdImage.DataBind()


        End Using
    End Sub


    Protected Sub Button1_Click(sender As Object, e As EventArgs)

        Dim fileName As String = Path.GetFileName(FileUpload1.PostedFile.FileName)
        If (fileName <> "") Then
            Dim filePath As String = "~/Hr/images/" & fileName
            Dim Name As String = TextBox1.Text.ToString()
            FileUpload1.PostedFile.SaveAs(Server.MapPath(filePath))

            Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
            Using conn As SqlConnection = New SqlConnection(constr)
                Dim sql As String = "INSERT INTO DocumentsUpload VALUES(@Name, @fileName, @Path)"
                Using cmd As SqlCommand = New SqlCommand(sql, conn)
                    cmd.Parameters.AddWithValue("@Name", Name)
                    cmd.Parameters.AddWithValue("@fileName", fileName)
                    cmd.Parameters.AddWithValue("@Path", filePath)
                    conn.Open()
                    cmd.ExecuteNonQuery()
                    conn.Close()
                End Using
                Label1.Visible = True
                Label1.Text = "Image Uploaded successfully"
                TextBox1.Text = ""
            End Using


        End If

        Label1.Visible = True
        Label1.Text = "Plz upload the image!!!!"

        Response.Redirect(Request.Url.AbsoluteUri)
        FillGridView()
    End Sub


    Protected Sub Download_Click(sender As Object, e As EventArgs)
        Dim btn As LinkButton = CType((sender), LinkButton)
        Dim yourValue As String = btn.CommandArgument
        Dim Filename As String = MapPath("~/Hr/images/" & yourValue)
        Response.AppendHeader("content-disposition", "attachment; filename=" & Path.GetFileName(Filename))
        Response.ContentType = "Application/pdf"
        Response.WriteFile(Filename)
    End Sub
    Protected Sub Delete_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btn As LinkButton = CType((sender), LinkButton)
        Dim Id As String = btn.CommandArgument


        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Using conn As SqlConnection = New SqlConnection(constr)
            Dim sql As String = ("Delete from DocumentsUpload where DocumentId=" & Id & "")
            Using cmd As SqlCommand = New SqlCommand(sql, conn)
                conn.Open()
                cmd.ExecuteNonQuery()
                conn.Close()
                FillGridView()
            End Using
        End Using

        Response.Redirect(Request.Url.AbsoluteUri)
    End Sub



End Class
