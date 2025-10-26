Imports System.Data
Imports System.Data.SqlClient
Partial Class Administrator_ptxrayinsert
    Inherits System.Web.UI.Page


    Dim AgeDate As String
    Dim classObj As New PatientBasicInfo
    Protected Sub page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = True Then
            HiddenFieldDiscription.Value = TextBoxXrayReport.Text
            TextBoxXrayReport.Text = HiddenFieldDiscription.Value
        End If
        LabelXray.Text = Session("bodypart")
        labelpro.Text = Session("projection")
        onPageLoad()
        Vitals()
        PatientName()
    End Sub

    Protected Sub ImageButtonBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonBack.Click
        Response.Redirect("PatientXRay.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=cancel")
    End Sub

    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Response.Redirect("xrayReception.aspx")
    End Sub
    Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonLogOut.Click
        Response.Redirect("../login.aspx")
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        'FileUploadXray.FileName = ImageXray.ImageUrl
        Dim a As Integer = 0
        If TextBoxXrayReport.Text.Trim <> "" Then
            a = 1
        End If
        If FileUploadXray.HasFile Then
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Xray_Image", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@Xray_ID", Request.QueryString("Xray_ID"))
            param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("reg_no"))
            param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@Date_Time", CDate(Today.Date))
            param = mycommand.Parameters.AddWithValue("@Image", FileUploadXray.FileBytes)
            param = mycommand.Parameters.AddWithValue("@Emp_Id", 8)
            Try
                mycommand.Connection.Open()
                ' abc = CType(mycommand.ExecuteScalar, Integer)
                mycommand.ExecuteNonQuery()
                mycommand.Connection.Close()
                'SqlDataSourceXray.Insert()
                'response.redirect("PatientXRay.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=success")
            Catch ex As Exception
                ' Label1.Text = 
                Response.Write(ex.Message)
            End Try
        End If


        Try
            If a = 1 Then
                SqlDataSourceXray.Insert()
            Else
            End If
        Catch ex As Exception

        End Try
        Response.Redirect("PatientXRay.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=success")
    End Sub
    Sub onPageLoad()
        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Xray_Description from Rd_Xray_Report Where ((YearlyNo= @YearlyNo)and(RegNo=@RegNo)and(Xray_ID=@Xray_ID))", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Xray_ID", Request.QueryString("Xray_ID"))
        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("reg_no"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", CInt(Request.QueryString("payId"))) 'Session("BMIPayID")
        Try



            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            mycommand.Connection.Open()
            da.SelectCommand = mycommand
            da.Fill(ds, "a")
            ' abc = CType(mycommand.ExecuteScalar, Integer)
            Dim abc As String = ds.Tables(0).Rows(0).Item(0)
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            TextBoxXrayReport.Text = abc
            If abc <> "" Then
                ButtonUpdate.Visible = True
                'TextBoxXrayReport.Text = HiddenFieldDiscription.Value
            End If
            'SqlDataSourceXray.Insert()
            'response.redirect("PatientXRay.aspx?payId=" + Request.QueryString(1) + "&reg_no=" + Request.QueryString(2) + "&message=success")
        Catch ex As Exception
            ' Label1.Text = 
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub ButtonUpdate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonUpdate.Click
        Try

            'Response.Write(TextBoxXrayReport.Text)
            Dim a As Integer = SqlDataSourceUpdate.Update()
            'Response.Write(a)
            onPageLoad()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub Vitals()
        Dim abc As Integer
        abc = 0
        'Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        'Dim abcd As String = "pt_basic_info_vitals"
        'Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
        'mycommand.CommandType = Data.CommandType.StoredProcedure
        'mycommand.Parameters.AddWithValue("@PayId", Request.QueryString("payid"))
        'mycommand.Parameters.AddWithValue("@regno", Request.QueryString("reg_no"))
        Try
            ' mycommand.Connection.Open()
            Dim sreader As SqlDataReader = classObj.Patient_Vital_Info(Request.QueryString("payid"), Request.QueryString("reg_no")) 'mycommand.ExecuteReader
            If sreader.Read = True Then
                labelPName.Text = sreader.Item(1).ToString
                LabelRelation.Text = sreader.Item(2).ToString
                LabelRName.Text = sreader.Item(3).ToString
                AgeDate = sreader.Item(8).ToString
                'date1()
                classObj.date1(LabelPAge, LabelAge, AgeDate)
                LabelBP.Text = sreader.Item(11).ToString
                LabelBPLow.Text = sreader.Item(12).ToString
                LabelPulse.Text = sreader.Item(13).ToString
                LabelRR.Text = sreader.Item(14).ToString
                LabelTemp.Text = sreader.Item(10).ToString
            End If
            'mycommand.Connection.Close()
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
        'Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        'Dim abcd As String = "pt_basic_info"
        'Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
        'mycommand.CommandType = Data.CommandType.StoredProcedure
        'mycommand.Parameters.AddWithValue("@PayId", Request.QueryString("payid"))
        'mycommand.Parameters.AddWithValue("@regno", Request.QueryString("reg_no"))
        Try
            'mycommand.Connection.Open()
            Dim sreader As SqlDataReader = classObj.Patient_Basic_Info(Request.QueryString("payid"), Request.QueryString("reg_no")) 'mycommand.ExecuteReader
            If sreader.Read = True Then
                labelPName.Text = sreader.Item(1).ToString
                LabelRelation.Text = sreader.Item(2).ToString
                LabelRName.Text = sreader.Item(3).ToString
                'agedate = sreader.Item(8).ToString
                AgeDate = sreader.Item(13).ToString
                classObj.date1(LabelPAge, LabelAge, AgeDate)
                'date1()
            End If
            'mycommand.Connection.Close()
        Catch ex As Exception
        End Try
    End Sub
    'Sub date1()
    '    Dim split As String() = AgeDate.Split(New [Char]() {"/"})
    '    Dim date1, date10 As Date
    '    date1 = split(1) & "/" & split(0) & "/" & split(2)
    '    Dim day, date3, month1 As Integer : Dim month As Decimal
    '    month = DateDiff(DateInterval.Month, date1, Date.Now)
    '    Dim year2 As String
    '    year2 = month / 12
    '    month1 = month Mod 12
    '    day = DateDiff(DateInterval.DayOfYear, date1, Date.Now)
    '    Dim split1 As String() = year2.Split(New [Char]() {"."})
    '    date10 = DateAdd(DateInterval.Month, month, date1)
    '    date3 = DateDiff(DateInterval.DayOfYear, date10, Date.Now)
    '    If date3 < 0 Then
    '        If month1 = 0 Then
    '            If split1(0) = 0 Then
    '                date3 = date3 + 30
    '                month1 = 11
    '            Else
    '                split1(0) = split1(0) - 1
    '                date3 = date3 + 30
    '                month1 = 11
    '            End If
    '        Else
    '            month1 = month1 - 1
    '            date3 = date3 + 30
    '        End If
    '    End If
    '    LabelPAge.Text = split1(0) & " Year " & month1 & " Month " & date3 & " Days"
    '    LabelAge.Text = AgeDate
    'End Sub




End Class
