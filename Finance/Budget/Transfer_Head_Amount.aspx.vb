Imports System.Data.SqlClient

Partial Class Finance_Transfer_Head_Amount
    Inherits System.Web.UI.Page
    Dim constring As String = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack Then
            reset()
        End If
    End Sub
    Protected Sub txt_TF_TextChanged(sender As Object, e As EventArgs) Handles txt_TF.TextChanged
        Text_change(HFD_TF, DDL_TF, lbl_TF, txt_TF)

    End Sub


    Protected Sub txt_TT_TextChanged(sender As Object, e As EventArgs) Handles txt_TT.TextChanged
        Text_change(HFD_TT, DDL_TT, lbl_TT, txt_TT)


    End Sub


    Protected Sub DDL_TF_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_TF.SelectedIndexChanged
        Get_value(DDL_TF, lbl_TF)

    End Sub


    Protected Sub DDL_TT_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_TT.SelectedIndexChanged
        Get_value(DDL_TT, lbl_TT)

    End Sub

    Protected Sub txt_TA_TextChanged(sender As Object, e As EventArgs) Handles txt_TA.TextChanged
        Dim t_amount As Integer = 0, B_Amount As Integer = 0
        If Not String.IsNullOrEmpty(txt_TA.Text.Trim()) Then
            t_amount = CInt(txt_TA.Text.Trim())
        End If

        B_Amount = CInt(lbl_TF.Text)

        If B_Amount - t_amount < 0 Then
            lbl_TA.Text = "Transfer amount enter is greater then Tranferable Amount."
            Btn_T.Visible = False

        Else
            lbl_TA.Text = String.Empty
            Btn_T.Visible = True
        End If
        txt_TA.Focus()
    End Sub

    Protected Sub Btn_T_Click(sender As Object, e As EventArgs) Handles Btn_T.Click
        Try
            SDS_TF.Insert()
            lbl_Msg.Text = "Transfer Successfully ...."
            reset()
        Catch ex As Exception
            lbl_Msg.Text = "Error While Transfering :" + ex.Message
        End Try
    End Sub
    '  ===========================================================================================================================
    '                                   METHOD DEFINED
    '  ===========================================================================================================================

    Protected Sub reset()
        txt_TF.Text = String.Empty
        txt_TT.Text = String.Empty
        txt_TA.Text = String.Empty
        DDL_TT.DataBind()
        DDL_TF.DataBind()
        Get_value(DDL_TT, lbl_TT)
        Get_value(DDL_TF, lbl_TF)

    End Sub


    Protected Sub Text_change(ByRef hd As HiddenField, ByRef ddl As DropDownList, ByRef lbl As Label, ByVal txt As TextBox)
        If String.IsNullOrEmpty(txt.Text.Trim) Then
            hd.Value = "%"
        Else
            hd.Value = "%" + txt.Text.Trim() + "%"
            ddl.DataBind()
        End If
        Get_value(ddl, lbl)


    End Sub

    Protected Sub Get_value(ByVal DDL As DropDownList, ByRef lbl As Label)
        Dim cmd As New SqlCommand
        Dim con As New SqlConnection(constring)
        Dim qry As String = "Select case when D.Revise_Amount is null or D.Revise_Amount =0 then D.Estimated_Amount else D.Revise_Amount end  from Budget_Detail D where D.E_Code = @E_Code and D.B_ID = @B_ID"

        cmd.CommandType = Data.CommandType.Text
        cmd.CommandText = qry
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@E_Code", DDL.SelectedValue)
        cmd.Parameters.AddWithValue("@B_ID", Request.QueryString("B_ID"))

        con.Open()

        lbl.Text = cmd.ExecuteScalar()

        If String.IsNullOrEmpty(lbl.Text.Trim) Then
            lbl.Text = "0"
        End If

        con.Close()
        If DDL.ID = "DDL_TF" Then
            txt_TA.Attributes.Add("max", lbl.Text)
        End If



    End Sub


    

End Class
