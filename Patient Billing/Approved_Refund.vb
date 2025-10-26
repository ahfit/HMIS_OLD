Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_Approved_Refund
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            GridView_Record.DataBind()
        End If

    End Sub

    Protected Sub GridView_Record_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Record.PreRender
        If GridView_Record.Rows.Count > 0 Then

            Dim lbl_regNo As Label
            Dim lbl_Name As Label
            Dim hf_reg_no As HiddenField
            Dim hf_Prefix As HiddenField
            Dim hf_EFName As HiddenField
            Dim hf_EMName As HiddenField
            Dim hf_ELName As HiddenField


            For Each row As GridViewRow In GridView_Record.Rows
                lbl_regNo = row.FindControl("lbl_reg")
                lbl_Name = row.FindControl("lbl_Name")
                hf_reg_no = row.FindControl("hf_reg")
                hf_Prefix = row.FindControl("hf_prefix")
                hf_EFName = row.FindControl("hf_EFName")
                hf_EMName = row.FindControl("hf_EMName")
                hf_ELName = row.FindControl("HF_ELName")


                lbl_regNo.Text = Verify_Decript(hf_reg_no.Value)
                lbl_Name.Text = Verify_Decript(hf_Prefix.Value) + " " + Verify_Decript(hf_EFName.Value) + " " + Verify_Decript(hf_EMName.Value) + " " + Verify_Decript(hf_ELName.Value)

            Next
        End If
    End Sub
    Protected Function Verify_Decript(ByVal name As String) As String
        Dim enc As New Encryption

        Dim value As String = ""
        If Not String.IsNullOrEmpty(name) Then
            value = enc.Encrypt_Main(name, False)
        End If

        Return value
    End Function

    Protected Sub lbtn_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lB As LinkButton = sender
        hf_refund_id.Value = lB.CommandArgument
        txt_heading.Text = lB.Text
        If txt_heading.Text = "Approve" Then
            hf_status.Value = "Cancel"
        Else
            hf_status.Value = "Paid"
        End If

        Dim gv As GridViewRow = lB.NamingContainer
        Dim regno As HiddenField = gv.FindControl("hf_reg")
        Dim lnkSPMID As LinkButton = gv.FindControl("LinkButton1")


        Dim a As String = ConfigurationManager.ConnectionStrings("PatientBillingConnectionString").ConnectionString
        Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim procedurename As String = "SelectPatientRecievable"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = procedurename
        mycommand.Parameters.AddWithValue("@spmid", lnkSPMID.Text) 'Session("registrationNo")
        mycommand.Parameters.AddWithValue("@regno", regno.Value)
        Dim da As New SqlDataAdapter
        Dim dt As New DataTable
        da.SelectCommand = mycommand
        da.Fill(dt)
        If dt.Rows.Count > 0 Then

            If dt.Rows(0)(0) > "0" Then
                cbok.Visible = True
                lblnotice.Text = "This Patient has already " + dt.Rows(0)(0).ToString() + " Recievable, Do you want to adjust in Recievable?Adjust with Payables"
                hf_receveableamount.Value = dt.Rows(0)(0).ToString()
            End If

        End If
        HiddenFieldrno.Value = regno.Value
        HiddenFieldsmpid.Value = lnkSPMID.Text
        pnl_input.Visible = True
    End Sub

    Protected Sub Btn_Approve_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Approve.Click

        Try


            If Validate_remarks() Then
                If cbok.Checked Then
                    hfok.Value = "1"
                Else
                    hfok.Value = "0"
                End If
                hfok.Value = "0"
                SDS_Record.Insert()
                GridView_Record.DataBind()
                pnl_input.Visible = False
            End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Function Validate_remarks() As Boolean

        Dim flag As Boolean
        If Not String.IsNullOrEmpty(txt_Remarks.Text.Trim()) Then
            flag = True
        Else

            lbl_MSG.Text = "Please Enter The Remarks first."
        End If

        Return flag
    End Function

    Protected Sub Btn_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Cancel.Click
        pnl_input.Visible = False
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lk As LinkButton = sender
        Dim row As GridViewRow = lk.NamingContainer
        Dim reg As HiddenField = row.FindControl("hf_reg")
        Dim yearly As HiddenField = row.FindControl("hf_yearlyNo")
        Session("YearlyNo") = yearly.Value
        Session("RegistrationNo") = reg.Value
        Dim sb As StringBuilder = New StringBuilder
        sb.Append("<script language='javascript'>")
        Dim url = "patientServices.aspx?AP_ID=1&SPMID=" + lk.Text
        sb.Append(" window.open('" + url + "')</script>")
        Dim t As Type = Me.GetType
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        End If


    End Sub

    Protected Sub btnApprove_Click(sender As Object, e As EventArgs)
        Dim count As Int32 = 0
        Dim hfdrequests As HiddenField
        If GridView_Record.Rows.Count > 0 Then

            For Each row As GridViewRow In GridView_Record.Rows

                ' Dim _str As String = TryCast(row.FindControl("cksingle"), Label).Text
                Dim ckbox As CheckBox = row.FindControl("cksingle")
                If (ckbox.Checked) Then
                    hfdrequests = row.FindControl("hfdrequests")
                    If count > 0 Then
                        hf_refund_id.Value = hf_refund_id.Value + "," + hfdrequests.Value
                    Else
                        hf_refund_id.Value = hfdrequests.Value
                    End If


                    count = count + 1
                End If
            Next

            If hf_refund_id.Value.Length > 0 Then
                hfok.Value = "0"
                SDS_Record.Insert()
                GridView_Record.DataBind()
            End If

        End If

    End Sub

    Protected Sub ckall_CheckedChanged(sender As Object, e As EventArgs)
        Dim ckMain As CheckBox = sender
        Dim ck As New CheckBox

        For Each row As GridViewRow In GridView_Record.Rows
            ck = row.FindControl("cksingle")
            ck.Checked = ckMain.Checked
        Next
    End Sub
End Class
