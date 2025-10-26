
Partial Class Pathology_CashBook
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim total As Integer = 0
    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        If GridView2.Rows.Count <> 0 Then
            GridView2.HeaderRow.Cells(4).Visible = False
            GridView2.HeaderRow.Cells(5).Visible = False
            GridView2.HeaderRow.Cells(6).Visible = False
            GridView2.FooterRow.Cells(4).Visible = False
            GridView2.FooterRow.Cells(5).Visible = False
            GridView2.FooterRow.Cells(6).Visible = False
            For i As Integer = 0 To GridView2.Rows.Count - 1
                Dim lbl As Label = GridView2.Rows(i).FindControl("Label1")
                lbl.Text = CStr(i + 1)
                GridView2.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView2.Rows(i).Cells(1).Text, False)
                GridView2.Rows(i).Cells(3).Text = GridView2.Rows(i).Cells(3).Text + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(4).Text, False) + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(5).Text, False)
                GridView2.Rows(i).Cells(4).Visible = False
                GridView2.Rows(i).Cells(5).Visible = False
                GridView2.Rows(i).Cells(6).Visible = False
            Next
        End If
    End Sub

    Protected Sub GridView2_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Total_Paid"))
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(7).Text = "Total Amount"
            e.Row.Cells(8).Text = total.ToString
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            Dim Total_Amount As Integer = 0
            For i As Integer = 0 To GridView2.Rows.Count - 1
                Dim Hid_payment As HiddenField = GridView2.Rows(i).FindControl("HiddenField_Payment")
                Total_Amount = Total_Amount + CInt(Hid_payment.Value)
            Next
            If GridView2.Rows.Count > 0 And HiddenField_Check.Value = 0 Then
                HiddenField_Pay.Value = Total_Amount
                HiddenField_PS_ID.Value = 46
                HiddenFieldDate.Value = WebDateChooser1.Value
                SqlDataSourceSaveInfo.Insert()
                For j As Integer = 0 To GridView2.Rows.Count - 1
                    Dim Hid_Ammount As HiddenField = GridView2.Rows(j).FindControl("HiddenField_Payment")
                    HiddenFieldAmount.Value = Hid_Ammount.Value
                    HiddenField_Reg_No.Value = ENC.Encrypt_Main(GridView2.Rows(j).Cells(1).Text, True)
                    HiddenField_YearlyNo.Value = GridView2.Rows(j).Cells(2).Text
                    SqlDataSource_Save_SUb.Insert()
                Next
                HiddenField_Check.Value = 1
            Else
                Button1.Visible = False
            End If
            GridView2.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSourceSaveInfo_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourceSaveInfo.Inserted
        HiddenField_Recieve_Amount_ID.Value = e.Command.Parameters("@Identity").Value
    End Sub
End Class
