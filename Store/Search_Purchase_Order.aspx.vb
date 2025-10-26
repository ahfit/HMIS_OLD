
Partial Class Store_Search_Purchase_Order
    Inherits System.Web.UI.Page

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Search_PO()
        'Label_Rec_found.Text = CStr(GridView1.Rows.Count) + " Record Found"
        'Label_Rec_found.Visible = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
      
        If Not IsPostBack Then
            If Session("Branch_Access") = 0 Then
                DropDownList_subdeprtment.DataBind()
                DropDownList_subdeprtment.SelectedValue = Session("SubDeptID")

                DropDownList_subdeprtment.Enabled = True
            Else
                DropDownList_subdeprtment.SelectedValue = Session("SubDeptID")
                DropDownList_subdeprtment.Enabled = False
            End If

            WebDateChooser_date_From.Value = Date.Today.Date.AddDays(-7)
            WebDateChooser_Date_To.Value = Date.Today.Date
            ddlParty.DataBind()
            DropDownList_subdeprtment.DataBind()
            
            Search_PO()

        End If
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If GridView1.Rows.Count <> 0 Then

            For i As Integer = 0 To GridView1.Rows.Count - 1

                Dim HiddenField_FAC_Complete As HiddenField = GridView1.Rows(i).FindControl("HiddenField_FAC_Complete")

                If HiddenField_FAC_Complete.Value = "True" Then
                    GridView1.Rows(i).Cells(4).Enabled = False
                    GridView1.Rows(i).Cells(4).ToolTip = "Already approved from finance"
                End If

            Next

        End If
    End Sub

    Protected Sub SqlDataSource1_Selected(sender As Object, e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource1.Selected
        Label_Rec_found.Text = e.AffectedRows.ToString() + " Record(s) Found"
    End Sub
    Protected Sub Search_PO()
        Dim dt As DateTime = WebDateChooser_date_From.Value
        Dim datefrom As String = dt.ToString("yyyy-MM-dd")
        HiddenField_from_date.Value = datefrom
        Dim dt2 As DateTime = WebDateChooser_Date_To.Value
        Dim dateto As String = dt.ToString("yyyy-MM-dd")
        HiddenField_to_Date.Value = dateto

        If (String.IsNullOrEmpty(txtPurchaserNo.Text.Trim)) Then
            HiddenFieldPO.Value = "%"
        Else
            HiddenFieldPO.Value = "%" + txtPurchaserNo.Text.Trim + "%"
        End If

        If (String.IsNullOrEmpty(txtItemName.Text.Trim)) Then
            HiddenField_Item.Value = "%"
        Else
            HiddenField_Item.Value = "%" + txtItemName.Text.Trim + "%"
        End If

        If (String.IsNullOrEmpty(txtOrderNo.Text.Trim)) Then
            HiddenFieldOrder.Value = String.Empty
        Else
            HiddenFieldOrder.Value = "%" + txtOrderNo.Text.Trim + "%"
        End If

        If (String.IsNullOrEmpty(Txt_Quotation.Text.Trim)) Then
            HiddenFieldQuo.Value = String.Empty
        Else
            HiddenFieldQuo.Value = "%" + Txt_Quotation.Text.Trim + "%"
        End If

        Try
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)

        End Try

    End Sub
    Protected Sub ddl_Status_SelectedIndexChanged(sender As Object, e As EventArgs)
        Search_PO()
    End Sub
End Class
