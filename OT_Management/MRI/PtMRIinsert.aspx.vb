Imports System.Data
Imports System.Data.SqlClient
Partial Class PtMRIinsert
    Inherits System.Web.UI.Page
    Dim AgeDate As String
    Dim classObj As New PatientBasicInfo
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")

            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    Protected Sub page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = True Then
            HiddenFieldDiscription.Value = TextBoxXrayReport.Text
            TextBoxXrayReport.Text = HiddenFieldDiscription.Value
        Else
            onPageLoad()
        End If
        Label_Description.Text = ""
        Label_message.Text = ""
        loginvalidate(Session("emp_id"), Session("dept_id"))
        LabelXray.Text = Session("bodypart")
        labelpro.Text = Session("projection")
        Vitals()
        PatientName()
    End Sub

    'Protected Sub ImageButtonBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonBack.Click
    '    Response.Redirect("PatientMRI.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=cancel")
    'End Sub

    'Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
    '    Response.Redirect("MRIReception.aspx")
    'End Sub
    'Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonLogOut.Click
    '    Response.Redirect("login.aspx")
    'End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        '    'FileUploadXray.FileName = ImageXray.ImageUrl
        Dim a As Integer = 0
        If TextBoxXrayReport.Text.Trim <> "" Then
            a = 1
        End If
        '    If FileUploadXray.HasFile Then
        '        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        '        Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_MRI_Image", con)
        '        mycommand.CommandType = Data.CommandType.StoredProcedure
        '        mycommand.Parameters.AddWithValue("@Pt_test_Id", Request.QueryString("RID"))
        '        mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
        '        mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
        '        'mycommand.Parameters.AddWithValue("@Date_Time", CDate(Today.Date))
        '        mycommand.Parameters.AddWithValue("@Image", FileUploadXray.FileBytes)
        '        mycommand.Parameters.AddWithValue("@Emp_Id", Session("Emp_ID"))
        Try
            '            mycommand.Connection.Open()
            '            ' abc = CType(mycommand.ExecuteScalar, Integer)
            '            mycommand.ExecuteNonQuery()
            '            mycommand.Connection.Close()
            SqlDataSourceXray.Insert()
            HiddenFieldDiscription.Value = ""
            Label_Description.Text = "Description Has  Been Saved"
            '            'SqlDataSourceUpdateStatus.Update()
            '            'response.redirect("PatientXRay.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=success")
        Catch ex As Exception
            '            ' Label1.Text = 
            Label_Description.ForeColor = Drawing.Color.Red
            Label_Description.Text = "Description Has Not Been Saved"
            Response.Write(ex.Message & "imran")
        End Try
        '    End If


        '    Try
        '        If a = 1 Then
        '            SqlDataSourceXray.Insert()
        '        Else

        '        End If
        '        'onPageLoad()
        '    Catch ex As Exception
        '        Response.Write(ex.Message)
        '    End Try
        '    'Response.Redirect("PatientMRI.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=success")
    End Sub
    Sub onPageLoad()
        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @a = Isnull(MRI_Description,' ') from Rd_MRI_Report Where (YearlyNo= YearlyNo) and(RegNo=@RegNo)and(Pt_Test_ID=@Pt_Test_ID)", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Pt_Test_ID", Request.QueryString("RID"))
        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
        mycommand.Parameters.Add("@a", SqlDbType.VarChar, 5000)
        mycommand.Parameters("@a").Direction = ParameterDirection.Output
        Session.Add("RID", Request.QueryString("RID"))
        Try
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Dim abc As String = mycommand.Parameters("@a").Value
            mycommand.Connection.Close()
            TextBoxXrayReport.Text = abc
            If abc <> "" Then
                'SqlDataSourceUpdate.Update()
            End If
        Catch ex As Exception
        End Try
    End Sub
    Sub Vitals()
        Dim abc As Integer
        abc = 0
        Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim abcd As String = "pt_basic_info_vitals"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@PayId", Request.QueryString("Payid"))
        mycommand.Parameters.AddWithValue("@regno", Request.QueryString("Regno"))
        Try
            mycommand.Connection.Open()
            Dim sreader As SqlDataReader = mycommand.ExecuteReader
            If sreader.Read = True Then
                'labelPName.Text = sreader.Item(1).ToString
                'LabelRelation.Text = sreader.Item(2).ToString
                'LabelRName.Text = sreader.Item(3).ToString
                AgeDate = sreader.Item(8).ToString
                date1()
                LabelBP.Text = sreader.Item(11).ToString
                LabelBPLow.Text = sreader.Item(12).ToString
                LabelPulse.Text = sreader.Item(13).ToString
                LabelRR.Text = sreader.Item(14).ToString
                LabelTemp.Text = sreader.Item(10).ToString
            End If
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        If abc <> 0 Then
            Session("BMIPayID") = abc
        End If
    End Sub

    Sub PatientName()
        Dim abc As Integer
        abc = 0
        Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim abcd As String = "pt_basic_info"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@PayId", Request.QueryString("payid"))
        mycommand.Parameters.AddWithValue("@regno", Request.QueryString("regno"))
        Try
            mycommand.Connection.Open()
            Dim sreader As SqlDataReader = mycommand.ExecuteReader
            If sreader.Read = True Then
                'labelPName.Text = sreader.Item(1).ToString
                'LabelRelation.Text = sreader.Item(2).ToString
                'LabelRName.Text = sreader.Item(3).ToString
                'agedate = sreader.Item(8).ToString
                AgeDate = sreader.Item(13).ToString
                date1()
            End If
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub date1()
        Dim split As String() = AgeDate.Split(New [Char]() {"/"})
        Dim date1, date10 As Date
        date1 = split(1) & "/" & split(0) & "/" & split(2)
        Dim day, date3, month1 As Integer : Dim month As Decimal
        month = DateDiff(DateInterval.Month, date1, Date.Now)
        Dim year2 As String
        year2 = month / 12
        month1 = month Mod 12
        day = DateDiff(DateInterval.DayOfYear, date1, Date.Now)
        Dim split1 As String() = year2.Split(New [Char]() {"."})
        date10 = DateAdd(DateInterval.Month, month, date1)
        date3 = DateDiff(DateInterval.DayOfYear, date10, Date.Now)
        If date3 < 0 Then
            If month1 = 0 Then
                If split1(0) = 0 Then
                    date3 = date3 + 30
                    month1 = 11
                Else
                    split1(0) = split1(0) - 1
                    date3 = date3 + 30
                    month1 = 11
                End If
            Else
                month1 = month1 - 1
                date3 = date3 + 30
            End If
        End If
        'LabelPAge.Text = split1(0) & " Year " & month1 & " Month " & date3 & " Days"
        'LabelAge.Text = AgeDate
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Session.Add("RID", Request.QueryString(0))
        Session.Add("reg_no", Request.QueryString(2))
        Session.Add("payId", Request.QueryString(1))
        Session.Add("PRadiologyID", Request.QueryString(3))
        Response.Redirect("MriReport.aspx")
        'Response.Redirect("MriReport.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=cancel" + "&xray_id=")
    End Sub

    Protected Sub Button_Complete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Complete.Click
        Try
            SqlDataSourceUpdateStatus.Update()
            Response.Redirect("patientMRI.aspx?PayID=" & Request.QueryString("PayID") & "&RegNo=" & Request.QueryString("RegNo"))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Button_File_save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_File_save.Click
        If FileUploadXray.HasFile = True Then
            ' HttpContext.Current.Response.Write("sdfdfsdgfsd gsg sfg")
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_MRI_Image", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@Pt_test_Id", Request.QueryString("RID"))
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
            mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@Image", FileUploadXray.FileBytes)
            mycommand.Parameters.AddWithValue("@Emp_Id", Session("Emp_ID"))
            Try
                'Response.Write("image")
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()
                mycommand.Connection.Close()
                Label_message.Text = "Image Has Been Saved"
                GridView4.DataBind()
            Catch ex As Exception
                Label_message.ForeColor = Drawing.Color.Red
                Label_message.Text = "Image Has Not Been Saved"
                Response.Write(ex.Message & "")
            End Try
        End If
        HiddenFieldDiscription.Value = ""

    End Sub
End Class
