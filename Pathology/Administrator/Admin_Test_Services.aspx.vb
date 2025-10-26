Imports System.Data
Imports System.Data.SqlClient
Partial Class Administrator_Admin_Test_Services
    Inherits System.Web.UI.Page

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            SqlDataSource_MG_Name.Insert()
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            If DropDownList_Assign_Group.Items.Count > 0 And DropDownList_BName.Items.Count > 0 Then
                For i As Integer = 0 To CheckBoxList_Test.Items.Count - 1
                    HiddenField_TID.Value = CheckBoxList_Test.Items(i).Value
                    If CheckBoxList_Test.Items(i).Selected = True Then
                        HiddenField_TName.Value = CheckBoxList_Test.Items(i).Text
                        SqlDataSource_Test.Insert()
                    Else
                        SqlDataSource_Test.Delete()
                    End If
                Next
            Else
                Label_message.ForeColor = Drawing.Color.Red
                Label_message.Text = "Select Name And Main Group "
            End If
            Check_For_Test()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        GridView_ServicesTest.DataBind()
    End Sub

    Protected Sub DropDownList_BName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_BName.SelectedIndexChanged
        Check_For_Test()
        GridView_ServicesTest.DataBind()
    End Sub

    Sub Check_For_Test()
        CheckBoxList_Test.ClearSelection()
        Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Services.Test_ID FROM  Test_Services INNER JOIN Test_Booking ON Test_Services.TB_ID = Test_Booking.TB_ID WHERE (Test_Booking.MG_ID = " & DropDownList_Assign_Group.SelectedValue & ") AND (Test_Services.TB_ID = " & DropDownList_BName.SelectedValue & ")", con1)
        mycommand.CommandType = Data.CommandType.Text
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds)
        For i As Integer = 0 To CheckBoxList_Test.Items.Count - 1
            For j As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If CheckBoxList_Test.Items(i).Value = ds.Tables(0).Rows(j).Item(0) Then
                    CheckBoxList_Test.Items(i).Selected = True
                End If
            Next
        Next
    End Sub


    Protected Sub DropDownList_Assign_Group_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Assign_Group.SelectedIndexChanged
        Check_For_Test()
    End Sub
    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim text_private As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox1")
        Dim text_public As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox2")
        Dim text_TBName As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox_TBName")

        HiddenField_Private_fee.Value = 0
        HiddenField_Public_Fee.Value = 0
        ' HiddenField_TName.Value = text_TBName.Text

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub


    Protected Sub TextBox_TestNames_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_TestNames.TextChanged

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HiddenField_TestName.Value = "%" + TextBox_TestNames.Text + "%"
    End Sub

    Protected Sub GridView_ServicesTest_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView_ServicesTest.RowDeleted
        Check_For_Test()
    End Sub

    Protected Sub Button_Refresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Refresh.Click

    End Sub
End Class
