Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_General_Examination_Languages
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            If IsPostBack Then
                Dim dropdown As New DropDownList
                Dim con As SqlConnection = New SqlConnection(constr)
                Dim command As SqlCommand = New SqlCommand("SELECT count(Admin_Radiology_Element.Rd_element_id) FROM Admin_Radiology_Element INNER JOIN Admin_Radiology_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_MainGroup.Radiology_id WHERE (Admin_Radiology_Element.Radiology_id = @ID)", con)
                command.CommandType = CommandType.Text
                command.Parameters.AddWithValue("@ID", DropDownListMainGroup.SelectedValue)
                con.Open()
                Dim total As Integer = command.ExecuteScalar()
                For j As Integer = 0 To GridView1.Rows.Count - 1
                    dropdown = GridView1.Rows(j).Cells(3).FindControl("DropDownList_Priority")
                Next
                For i As Integer = 0 To total - 1
                    dropdown.Items.Add(i + 1)
                Next
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Try

        
            Dim txtbefore As TextBox = GridView1.Rows(e.RowIndex).Cells(4).FindControl("TextBox1")
            Dim txtafter As TextBox = GridView1.Rows(e.RowIndex).Cells(5).FindControl("TextBox2")
            Dim txtAlias As TextBox = GridView1.Rows(e.RowIndex).Cells(11).FindControl("TextBox3")
            HiddenFieldBefore.Value = txtbefore.Text
            HiddenFieldAfter.Value = txtafter.Text
            HiddenField_Alias.Value = txtAlias.Text 'GridView1.Rows(e.RowIndex).Cells(10).Text.ToString
            HiddenField_RDID.Value = GridView1.Rows(e.RowIndex).Cells(11).Text
            HiddenField_GroupPara.Value = GridView1.Rows(e.RowIndex).Cells(7).Text
            HiddenField_ReportSubGroup.Value = GridView1.Rows(e.RowIndex).Cells(8).Text
            Dim txtcheck As CheckBox = GridView1.Rows(e.RowIndex).Cells(6).FindControl("Checkbox1")
            Dim ddl_priority As DropDownList = GridView1.Rows(e.RowIndex).Cells(3).FindControl("DropDownList_Priority")
            HiddenField_Priority.Value = ddl_priority.SelectedValue
            If txtcheck.Checked = True Then
                HiddenField_ElementValueReq.Value = 1
            ElseIf txtcheck.Checked = False Then
                HiddenField_ElementValueReq.Value = 0
            End If
            SqlDataSource_Element.Update()
        Catch ex As Exception
            Response.Write(ex.Message)

        End Try
    End Sub

    Protected Sub DropDownListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMainGroup.SelectedIndexChanged
        GridView1.DataBind()

    End Sub
End Class
