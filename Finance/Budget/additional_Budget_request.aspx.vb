

Imports System.Data.SqlClient

Partial Class Finance_Budget_additional_Budget_request
    Inherits System.Web.UI.Page

    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs)
        Dim lk As LinkButton = sender
        Dim Hf_E_Code As New HiddenField()
        Dim Hf_E_Name As New HiddenField()

        hf_request_ID.Value = lk.CommandArgument
        Dim row As GridViewRow = lk.NamingContainer
        Hf_E_Code = row.FindControl("hf_E_Code")
        Hf_E_Name = row.FindControl("hf_E_Name")
        lbl_headName.Text = Hf_E_Name.Value + " (" + Hf_E_Code.Value + ")"
        pnl_Request.Visible = True
    End Sub
    Protected Sub btn_Approve_Click(sender As Object, e As EventArgs) Handles btn_Approve.Click
        hf_status.Value = "1"
        save_information()

    End Sub
    Protected Sub btn_reject_Click(sender As Object, e As EventArgs) Handles btn_reject.Click
        hf_status.Value = "0"
        save_information()

    End Sub
    Protected Sub btn_req_cancel_Click(sender As Object, e As EventArgs) Handles btn_req_cancel.Click
        pnl_Request.Visible = False
    End Sub

    Protected Sub save_information()
        Try
            If Not String.IsNullOrEmpty(txt_remarks.Text.Trim()) Then

                sds_record.Update()
                pnl_Request.Visible = False
                gv_Record.DataBind()
            Else
                lbl_req_Msg.Text = "Kindly add remarks First..."
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

End Class
