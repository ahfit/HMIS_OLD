Imports System.Data.SqlClient
Imports System.Data
Partial Class Administrator_PatientXRay1
    Inherits System.Web.UI.Page
    Dim AgeDate As String
    Sub loginValidate()
        If Session("emp_id") Is Nothing And Session("dept_id") Is Nothing Then
            Response.Redirect("../login.aspx")
        End If
    End Sub
    Sub Image()
        Dim xid As String = GridView4.SelectedValue  'Request.QueryString("Xray_ID")
        'Response.Write(GridView4.SelectedValue)
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
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT *  FROM [pt_Xray_Images] where TGID = @TGID and RegNo = @RegNo and YearlyNo=@YearlyNo", con)
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
                Dim control As New ImageButton
                control.Attributes.Add("onclick", "return Image_NEw('" & yearlyno & "','" & regno & "','" & CInt(ds.Tables(0).Rows(i).Item(0)) & "')")
                control.ImageUrl = "ptxrayview.aspx?Xray_ID=" & CInt(ds.Tables(0).Rows(i).Item(0)) & "&payId=" & yearlyno & "&rig_no=" & regno
                control.Width = 50
                control.Height = 50
                Panel2.Controls.Add(control)
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
            'CheckBox1.checked = True
            Image()
        End If
        'Response.Write(HiddenField_RegNo.Value)
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        'Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        'Dim con = New System.Data.SqlClient.SqlConnection(constring)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Xray_Image", con)
        'mycommand.CommandType = Data.CommandType.StoredProcedure
        'Dim fileUploadXray As FileUpload
        'Try
        '    fileUploadXray = GridView4.Rows(0).Controls(6)
        '    Dim param As System.Data.SqlClient.SqlParameter
        '    param = mycommand.Parameters.AddWithValue("@RegNo", HiddenField_RegNo.Value)
        '    param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(HiddenField_PayID.Value)) 'Session("BMIPayID")
        '    param = mycommand.Parameters.AddWithValue("@Date_Time", CDate(Today.Date))
        '    param = mycommand.Parameters.AddWithValue("@Image", fileUploadXray.FileBytes)
        '    param = mycommand.Parameters.AddWithValue("@Emp_Id", 8)
        '    Try
        '        mycommand.Connection.Open()
        '        ' abc = CType(mycommand.ExecuteScalar, Integer)
        '        mycommand.ExecuteNonQuery()
        '        mycommand.Connection.Close()
        '    Catch ex As Exception
        '        ' Label1.Text = 
        '        Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        '    End Try
        'Catch ex As Exception
        '    Response.Write(ex.Message + " jhf ghj ")
        'End Try
    End Sub

    Protected Sub GridView4_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView4.RowCommand
        Try
            If e.CommandName = "Final" Then
                Dim Hid_xray_ID As HiddenField = GridView4.Rows(e.CommandArgument).FindControl("HiddenField1")
                HiddenField_XRAYID.Value = Hid_xray_ID.Value
                SqlDataSourceXray.Update()
            End If
        Catch ex As Exception
            Response.Write(ex.Message & "Update")
        End Try
    End Sub

    Protected Sub GridView4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView4.SelectedIndexChanged
        Image()
        Session.Add("bodypart", GridView4.SelectedRow.Cells(1).Text)
        Session.Add("projection", GridView4.SelectedRow.Cells(2).Text)
        LabelXray.Text = Session("bodypart")
        labelpro.Text = Session("projection")
        HiddenField_ID.Value = GridView4.SelectedValue
        Panel1.Visible = True
        'GridView1.databind()
        'Response.Redirect("Ptxrayinsert.aspx?Xray_ID=" + GridView4.SelectedValue.ToString + "&YearlyNO=" + Request.QueryString(0) + "&registrationNo=" + Request.QueryString(1))
    End Sub

    Protected Sub Button_Upload_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Upload.Click
        If FileUpload_image_1.HasFile = True Then
            Upload_File(FileUpload_image_1, DropDownList_Performed_By)
        End If

        If FileUpload_Image_2.HasFile = True Then
            Upload_File(FileUpload_Image_2, DropDownList_Performed_By_2)
        End If

        If FileUpload_Image_3.HasFile = True Then
            Upload_File(FileUpload_Image_3, DropDownList_Performed_By_3)
        End If

        If FileUpload_Images_4.HasFile = True Then

            Upload_File(FileUpload_Images_4, DropDownList_Performed_By_4)
        End If
        Image()
        'GridView1.databind()
    End Sub

    Sub Upload_File(ByVal FU As System.Web.UI.WebControls.FileUpload, ByVal DDL As System.Web.UI.WebControls.DropDownList)
        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Xray_Image", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID")) 'Request.QueryString("Xray_ID"))
        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regNo"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("YearlyNO"))) 'Session("BMIPayID")
        param = mycommand.Parameters.AddWithValue("@Date_Time", CDate(Today.Date))
        param = mycommand.Parameters.AddWithValue("@Image", FU.FileBytes)
        param = mycommand.Parameters.AddWithValue("@Emp_Id", Session("emp_id"))
        param = mycommand.Parameters.AddWithValue("@performed_by", DDL.SelectedValue)
        param = mycommand.Parameters.AddWithValue("@TB_ID", CInt(Request.QueryString("TB_ID")))
        Try
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            'Dim regno As String = Request.QueryString("RegNo")
            'Dim yearlyno As String = CInt(Request.QueryString("YearlyNo"))
            'image_id(yearlyno, regno)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button_Next_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Next.Click
        'Try
        '    If FileUpload_image_1.HasFile = True Then
        '        Upload_File(FileUpload_image_1, DropDownList_Performed_By)
        '    ElseIf FileUpload_Image_2.HasFile = True Then
        '        Upload_File(FileUpload_Image_2, DropDownList_Performed_By_2)
        '    ElseIf FileUpload_Image_3.HasFile = True Then
        '        Upload_File(FileUpload_Image_3, DropDownList_Performed_By_3)
        '    ElseIf FileUpload_Images_4.HasFile = True Then
        '        Upload_File(FileUpload_Images_4, DropDownList_Performed_By_4)
        '    End If
        '    Image()

        '    sqldatasource1.update()
        '    'response.write("Checkbox")
        '    'Response.Redirect("Xray_test_result_entry.aspx?Xray_ID=" & GridView4.SelectedValue & "&YearlyNo=" & Request.QueryString("YearlyNO") & "&RegistrationNo=" & Request.QueryString("regNo"))
        '    'response.redirect("Patient_Search.aspx?DEF=1.0")
        'Catch ex As Exception
        '    response.write(ex.message)
        'End Try
    End Sub
    Protected Sub Button_Next_Patient_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Next_Patient.Click
        'response.redirect("Patient_Search.aspx?DEF=1.0")
    End Sub

    'Protected Sub GridView4_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView4.PreRender
    '    Try
    '        Dim j As Integer = 0
    '        For i As Integer = 0 To GridView4.Rows.Count - 1
    '            Dim lbl_date As Label = GridView4.Rows(i).FindControl("Label_Date")
    '            Dim lbl_Count As Label = GridView4.Rows(i).FindControl("Label_Count")
    '            Dim Hid_xray_ID As HiddenField = GridView4.Rows(i).FindControl("HiddenField1")
    '            'Response.Write(Hid_xray_ID.Value)
    '            Dim coll As Collection = Image_Count(Hid_xray_ID.Value)
    '            lbl_date.Text = coll.Item("Date_Time")
    '            lbl_Count.Text = coll.Item("Count")
    '            Dim count As Integer = coll.Item("Count")
    '            'Response.Write(count)
    '            Dim Status As String = coll.Item("Status")
    '            If count > 0 And Status = "pay" Then
    '                GridView4.Rows(i).BackColor = Drawing.Color.Green
    '                GridView4.Rows(i).ForeColor = Drawing.Color.White
    '                'Dim link_Final As LinkButton = GridView4.Rows(i).FindControl("LinkButton2")
    '                'link_Final.Enabled = True
    '            End If
    '            If Status.Trim = "Final And Report" Then
    '                GridView4.Rows(i).BackColor = Drawing.Color.Blue
    '                GridView4.Rows(i).ForeColor = Drawing.Color.White
    '                Dim link As LinkButton = GridView4.Rows(i).FindControl("LinkButton1")
    '                link.Enabled = False
    '                GridView4.Rows(i).Cells(10).Enabled = False
    '            ElseIf Status.Trim = "Final" Then
    '                GridView4.Rows(i).BackColor = Drawing.Color.Red
    '                GridView4.Rows(i).ForeColor = Drawing.Color.White
    '                Dim link As LinkButton = GridView4.Rows(i).FindControl("LinkButton1")
    '                link.Enabled = False
    '                GridView4.Rows(i).Cells(10).Enabled = False
    '                j = j + 1
    '                'Dim link_Final As LinkButton = GridView4.Rows(i).FindControl("LinkButton2")
    '                'link_Final.Enabled = False
    '            End If
    '        Next
    '        If j = GridView4.Rows.Count Then
    '            Response.Redirect("Patient_Search.aspx?def=1.0")
    '        End If
    '    Catch ex As Exception
    '        ' Response.Write(ex.Message & "  6464rryt ")
    '    End Try
    'End Sub
    'Function Image_Count(ByVal Xray_Id As Integer) As Collection
    '    Dim coll As New Collection
    '    Try
    '        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '        Dim mycommand As New System.Data.SqlClient.SqlCommand("Xray_Image_Count", con)
    '        mycommand.CommandType = Data.CommandType.StoredProcedure
    '        Dim param As System.Data.SqlClient.SqlParameter
    '        param = mycommand.Parameters.AddWithValue("@Xray_ID", Xray_Id) 'Request.QueryString("Xray_ID"))
    '        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regNo"))
    '        param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("YearlyNO")))
    '        mycommand.Connection.Open()
    '        Dim da As New SqlDataAdapter
    '        Dim ds As New DataSet
    '        da.SelectCommand = mycommand
    '        da.Fill(ds)
    '        'Response.Write(ds.Tables(0).Rows(0).Item(0).ToString & " Count " & ds.Tables(0).Rows(0).Item(1))
    '        Dim count As Integer = CInt(ds.Tables(0).Rows(0).Item("Image").ToString)
    '        Dim Date_Time As String = ds.Tables(0).Rows(0).Item("Date_Time").ToString
    '        Dim Status As String = ds.Tables(0).Rows(0).Item("Status").ToString
    '        coll.Add(count, "Count")
    '        coll.Add(Date_Time, "Date_Time")
    '        coll.Add(Status, "Status")
    '        mycommand.Connection.Close()
    '    Catch ex As Exception
    '        'Response.Write(ex.Message & " dfssf ")
    '    End Try
    '    Return coll
    'End Function
End Class