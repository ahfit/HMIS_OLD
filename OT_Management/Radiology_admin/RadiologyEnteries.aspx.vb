
Partial Class RadiologyEnteries
    Inherits System.Web.UI.Page
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("../loginnew.aspx")

            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub

    Protected Sub page_load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Page.IsPostBack = False Then
                If Request.QueryString("subgroup") Is Nothing Then
                Else
                    DropDownListGName.DataBind()
                    DropDownListSGName.DataBind()
                    DropDownListGName.SelectedValue = Request.QueryString("maingroup")
                    DropDownListSGName.SelectedValue = Request.QueryString("subgroup")
                End If
            End If
            'GridViewSubGroup.selectedindex = 1
            'GridViewSubGroup.SelectedIndex = 1
            loginvalidate(Session("emp_id"), Session("dept_id"))
            btnSave.Attributes.Add("onClick", "return requireValue();")

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
       
    End Sub
    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Try
            SqlDataSourceGNameSave.Insert()
            GridViewEnteries.DataBind()
            LabelMessage.text = "Your Information is saved"
        Catch ex As Exception
            LabelMessage.text = "Your Information is not saved"
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub GridViewEnteries_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewEnteries.RowUpdating
        Try
            HiddenFieldName.Value = GridViewEnteries.Rows(e.RowIndex).Cells(2).Text
            HiddenFieldFee.Value = GridViewEnteries.Rows(e.RowIndex).Cells(3).Text
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
