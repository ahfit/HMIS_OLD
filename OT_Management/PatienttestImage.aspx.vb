Imports System.Data
Imports System.Data.SqlClient
Imports System.Io
Imports System.DirectoryServices
Partial Class PatienttestImage
    Inherits System.Web.UI.Page
    Dim AgeDate As String
    Sub loginValidate()
        If Session("emp_id") Is Nothing And Session("dept_id") Is Nothing Then
            Response.Redirect("../login.aspx")
        End If
    End Sub
    Sub Image()

        Dim regno As String = Request.QueryString("RegNo")
        Dim yearlyno As String = CInt(Request.QueryString("YearlyNo"))
        image_id(yearlyno, regno)

    End Sub
    Sub image_id(ByVal yearlyno As Integer, ByVal regno As String)

        Try
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT *  FROM [pt_Path_Images] where TGID = @TGID and RegNo = @RegNo and YearlyNo=@YearlyNo", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID"))
            param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
            param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("YearlyNo")))
            con.Open()

            da.SelectCommand = mycommand
            da.Fill(ds)
            con.Close()
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If i = 0 Then
                    Table_Label("<Table border = '1' align='center'><tr><td>")
                ElseIf i Mod 7 = 0 Then
                    Table_Label("</tr><tr><td>")
                Else
                    Table_Label("<td>")
                End If
                '************************************** Comment By Imran 23-04-2012 *********************************************
                'Dim control As New HyperLink
                ''  control.Attributes.Add("onclick", "return Image_NEw('" & yearlyno & "','" & regno & "','" & CInt(ds.Tables(0).Rows(i).Item(0)) & "')")

                'control.Target = "_blank"
                ''control.ImageUrl = ds.Tables(0).Rows(i).Item(9)
                'control.Text = ds.Tables(0).Rows(i).Item(10)
                'control.NavigateUrl = ds.Tables(0).Rows(i).Item(9) '"ptxrayview.aspx?Path_ID=" & CInt(ds.Tables(0).Rows(i).Item(0)) & "&payId=" & yearlyno & "&rig_no=" & regno
                'Panel2.Controls.Add(control)
                '************************************** Comment By Imran 23-04-2012 End *********************************************
                Table_Label("<a href ='" & ds.Tables(0).Rows(i).Item(9).ToString() & "' target='_blank'")
                Dim control As New Image
                control.ImageUrl = ds.Tables(0).Rows(i).Item(9)
                control.Width = 65
                control.Height = 65
                Panel2.Controls.Add(control)
                Table_Label("</a>")
                If i = ds.Tables(0).Rows.Count - 1 Then
                    Table_Label("</td></tr></table>")
                Else
                    Table_Label("</td>")
                End If
            Next
        Catch ex As Exception

        End Try

    End Sub
    Sub Table_Label(ByVal Lbl As String)
        Dim lbl_tbl As New Label
        lbl_tbl.Text = Lbl
        Panel2.Controls.Add(lbl_tbl)
    End Sub


    Protected Sub page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
        Session.Add("registrationNo", Request.QueryString("RegNo"))
        loginValidate()
        'response.write(Session("YearlyNo") & "  YearlyNo  " & Session("registrationNo"))
        Label_message.Text = ""
        If Request.QueryString("message") = "success" Then
            LabelAttach.Text = "Xray of " + Session("bodypart") + " with " + Session("projection") + " is attached."
        End If
        HiddenField_PayID.Value = Request.QueryString("YearlyNo")
        HiddenField_RegNo.Value = Request.QueryString("RegNo")
        If Not Page.IsPostBack Then

            Image()
        End If

    End Sub


    Protected Sub Button_Upload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Upload.Click
        If FileUpload_image_1.HasFile = True And TextBox_Image1.Text <> "" Then
            Upload_File(FileUpload_image_1, DropDownList_Performed_By, TextBox_Image1.Text)
            TextBox_Image1.Text = ""
        End If

        If FileUpload_Image_2.HasFile = True And TextBox_Image2.Text <> "" Then
            Upload_File(FileUpload_Image_2, DropDownList_Performed_By_2, TextBox_Image2.Text)
            TextBox_Image2.Text = ""
        End If

        If FileUpload_Image_3.HasFile = True And TextBox_Image3.Text <> "" Then
            Upload_File(FileUpload_Image_3, DropDownList_Performed_By_3, TextBox_Image3.Text)
            TextBox_Image3.Text = ""
        End If

        If FileUpload_Images_4.HasFile = True And TextBox_Image4.Text <> "" Then

            Upload_File(FileUpload_Images_4, DropDownList_Performed_By_4, TextBox_Image4.Text)
            TextBox_Image4.Text = ""
        End If
        Image()

    End Sub

    Sub Upload_File(ByVal FU As System.Web.UI.WebControls.FileUpload, ByVal DDL As System.Web.UI.WebControls.DropDownList, ByVal data1 As String)




        Dim Path_ID As Int64

        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Pro_Insert_path_Image", con)
        mycommand.CommandType = data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID"))
        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regNo"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("YearlyNO")))
        param = mycommand.Parameters.AddWithValue("@Date_Time", CDate(Today.Date))
        param = mycommand.Parameters.AddWithValue("@Emp_Id", Session("emp_id"))
        param = mycommand.Parameters.AddWithValue("@performed_by", DDL.SelectedValue)
        param = mycommand.Parameters.AddWithValue("@TB_ID", CInt(Request.QueryString("TB_ID")))
        param = mycommand.Parameters.AddWithValue("@data", data1)
        mycommand.Parameters.Add("@path_ID", data.SqlDbType.Decimal)
        mycommand.Parameters("@path_ID").Direction = data.ParameterDirection.Output
        Try
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Path_ID = mycommand.Parameters("@path_ID").Value.ToString.Trim
            mycommand.Connection.Close()

            ''''''''''''''''''''''''''''''''''''''''''
            ''''''''''''''''''''''''''''''''''''''''''
            ''''''''''''''''''''''''''''''''''''''''''
            'Response.Write(Path_ID)
            Dim fileName As String
            Dim url As String
            '  HiddenField_fileName.Value = FU.FileName
            fileName = Path_ID.ToString + FU.FileName

            url = "Path_Images/" + fileName
            If System.IO.File.Exists(fileName) Then
                System.IO.File.Delete(fileName)
            End If

            Dim fs As FileStream = New FileStream(Server.MapPath("") + "/Path_Images/" + fileName, FileMode.CreateNew)

            fs.Write(FU.FileBytes, 0, FU.FileBytes.Length)
            fs.Close()


            '''''''''''''''''''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''''''''''''''''''





            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("update [Pt_Path_Images] set [Image]='" + url + "' where Path_ID=" + Path_ID.ToString, con)
            mycommand1.CommandType = CommandType.Text
            'Dim SQL As String = 

            con.Open()
            mycommand1.ExecuteNonQuery()
            con.Close()


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try





    End Sub

    
    
End Class