Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_View_Work_List
    Inherits System.Web.UI.Page
    Dim dt As New DataTable
    Sub Working_list()
        dt.Clear()
        Dim col As System.Data.DataColumn
        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Path_BookingTestName_Group", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@TGID", DropDownListMain.SelectedValue)
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        con.Open()
        mycommand.ExecuteNonQuery()
        da.SelectCommand = mycommand
        da.Fill(ds)
        If ds.Tables(0).Rows.Count = 0 Then
            Exit Sub
        End If
        ''''''''''''''''Dim ds As New Pt_Radiology_Test
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            col = New System.Data.DataColumn(ds.Tables(0).Rows(i).Item(0).ToString)
            dt.Columns.Add(New System.Data.DataColumn(ds.Tables(0).Rows(i).Item(0).ToString))
        Next


        '==============================================
        Dim con2 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand2 As New System.Data.SqlClient.SqlCommand("Path_Tests_Booked", con2)
        mycommand2.CommandType = Data.CommandType.StoredProcedure
        Dim param2 As System.Data.SqlClient.SqlParameter
        param2 = mycommand2.Parameters.AddWithValue("@TGID", DropDownListMain.SelectedValue)
        Dim da2 As New SqlDataAdapter
        Dim ds2 As New DataSet
        con2.Open()
        mycommand2.ExecuteNonQuery()
        da2.SelectCommand = mycommand2
        da2.Fill(ds2)
        Dim y As Integer = 0
        Dim tid As Integer = 0

        tid = ds2.Tables(0).Rows(0).Item("tid")

        For x As Integer = 0 To ds2.Tables(0).Rows.Count - 1

            If tid <> ds2.Tables(0).Rows(y).Item(2) Then
                y = 0
                tid = ds2.Tables(0).Rows(x).Item("tid")
            End If
            If (dt.Rows.Count - 1) <= y Then
                Dim dr As DataRow = dt.NewRow()
                dr(ds2.Tables(0).Rows(y).Item(0).ToString) = ds2.Tables(0).Rows(x).Item(1).ToString + "        "
                dt.Rows.Add(dr)

            Else
                dt.Rows(y).Item(ds2.Tables(0).Rows(x).Item(0).ToString) = ds2.Tables(0).Rows(y).Item(1).ToString + "        "
            End If
            y = y + 1
        Next

        GridView_WorkingList.DataSource = dt
        GridView_WorkingList.DataBind()

    End Sub

  

    Protected Sub DropDownListMain_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMain.SelectedIndexChanged
        Working_list()
    End Sub
End Class
