Imports System.Data
Imports System.Data.SqlClient
Partial Class Teat_Booking
    Inherits System.Web.UI.Page

    Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)

    Protected Sub GridView_Booking_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Booking.SelectedIndexChanged
        Try
            Dim Hid_TB_ID As HiddenField = GridView_Booking.Rows(GridView_Booking.SelectedIndex).FindControl("HiddenField_TB_ID")
            HiddenField_TBID.Value = Hid_TB_ID.Value
            SqlDataSource_Booking.Insert()
            GridView_Services.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_ID from Test_Booking_Services Where RegNo = @RegNo and YearlyNo = @YearlyNo ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()

                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
