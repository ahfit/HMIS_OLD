Imports System.Data.SqlClient
Imports System.Data
Partial Class Patient_Attach_Result
    Inherits System.Web.UI.Page


    Dim AgeDate As String
    Protected Sub page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.QueryString("message") = "success" Then
            LabelAttach.Text = "MRI of " + Session("bodypart") + " with " + Session("projection") + " is attached."
        End If
        HiddenField_PayID.Value = Request.QueryString(0)
        HiddenField_RegNo.Value = Request.QueryString(1)
        Vitals()
        PatientName()
    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub GridView4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView4.SelectedIndexChanged

    End Sub


    Sub Vitals()
        Dim abc As Integer
        abc = 0
        Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim abcd As String = "pt_basic_info_vitals"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@PayId", Request.QueryString(0))
        mycommand.Parameters.AddWithValue("@regno", Request.QueryString(1))

        Try
            mycommand.Connection.Open()
            Dim sreader As SqlDataReader = mycommand.ExecuteReader
            If sreader.Read = True Then
                labelPName.Text = sreader.Item(1).ToString
                LabelRelation.Text = sreader.Item(2).ToString
                LabelRName.Text = sreader.Item(3).ToString
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
            Response.Write(ex.Message & "Farhat")
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
                labelPName.Text = sreader.Item(1).ToString
                LabelRelation.Text = sreader.Item(2).ToString
                LabelRName.Text = sreader.Item(3).ToString
                'agedate = sreader.Item(8).ToString
                AgeDate = sreader.Item(13).ToString
                date1()
            End If
            mycommand.Connection.Close()
        Catch ex As Exception
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
        LabelPAge.Text = split1(0) & " Year " & month1 & " Month " & date3 & " Days"
        LabelAge.Text = AgeDate
    End Sub
End Class


