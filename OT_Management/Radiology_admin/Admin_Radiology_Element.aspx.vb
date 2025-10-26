Imports System.Data
Imports System.Data.SqlClient

Partial Class Administrator_Admin_Gestational_Ultrasound
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString
    Protected Sub DropDownListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMainGroup.SelectedIndexChanged
        GridViewMainGroup.DataBind()
    End Sub
    Protected Sub GridViewMainGroup_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridViewMainGroup.RowDataBound
        Try
            If IsPostBack Then
                Dim dropdown As New DropDownList
                Dim con As SqlConnection = New SqlConnection(constr)
                Dim command As SqlCommand = New SqlCommand("SELECT count(Admin_Radiology_Element.Rd_element_id) FROM Admin_Radiology_Element INNER JOIN Admin_Radiology_MainGroup ON Admin_Radiology_Element.Radiology_id = Admin_Radiology_MainGroup.Radiology_id WHERE (Admin_Radiology_Element.Radiology_id = @ID)", con)
                command.CommandType = CommandType.Text
                command.Parameters.AddWithValue("@ID", DropDownListMainGroup.SelectedValue)
                con.Open()
                Dim total As Integer = command.ExecuteScalar()
                For j As Integer = 0 To GridViewMainGroup.Rows.Count - 1
                    dropdown = GridViewMainGroup.Rows(j).Cells(4).FindControl("DropDownList1")
                Next
                For i As Integer = 0 To total - 1
                    dropdown.Items.Add(i + 1)
                Next
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub GridViewMainGroup_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewMainGroup.RowUpdating
        Dim dropdown As DropDownList = GridViewMainGroup.Rows(e.RowIndex).Cells(4).FindControl("DropDownList1")
        HiddenFieldPriority.Value = dropdown.SelectedValue 'GridViewMainGroup.Rows(e.RowIndex).Cells(4).Text
        HiddenFieldToolTip.Value = GridViewMainGroup.Rows(e.RowIndex).Cells(5).Text
        HiddenFieldName.Value = GridViewMainGroup.Rows(e.RowIndex).Cells(3).Text
        'Response.Write(HiddenFieldPriority.Value + "  " + HiddenFieldToolTip.Value)
    End Sub
End Class
