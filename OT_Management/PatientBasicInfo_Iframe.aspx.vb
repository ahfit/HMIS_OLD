
Partial Class PatientBasicInfo_Iframe
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Session("RegistrationNo") + "  " + Session("YearlyNo"))
        'Response.End()
        HiddenField_regNo.Value = Session("RegistrationNo")
        HiddenField_Payis.Value = Session("YearlyNo")

    End Sub

    'Protected Sub PatientBasicInfo_Iframe_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
    '    Dim lbl_name As Label = patientbasicinfo_ifram
    'End Sub 
    Protected Sub FormView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView2.PreRender
        '''''''encrypt Data
        Try
            Dim lbl_Prefix As Label = FormView2.Row.FindControl("PatientNameLabel")
            Dim lbl_RegNo As Label = FormView2.Row.FindControl("RegistrationNo")
            Dim hid_pfname As HiddenField = FormView2.Row.FindControl("HiddenField_pfname")
            Dim hid_pmname As HiddenField = FormView2.Row.FindControl("HiddenField_pmname")
            lbl_RegNo.Text = ENC.Encrypt_Main(lbl_RegNo.Text, False)
            lbl_Prefix.Text = lbl_Prefix.Text & " " & ENC.Encrypt_Main(hid_pfname.Value, False) & " " & ENC.Encrypt_Main(hid_pmname.Value, False)
            Session.Add("PatientName", lbl_Prefix.Text)
        Catch ex As Exception
            Response.Write("<br />" & ex.Message & " FormPrerender ")
        End Try
    End Sub
    Function Decrypt_String(ByVal Txt As String, ByVal Key As Integer, ByVal Default_Space As Boolean) As String
        Dim First_Space As Boolean = Default_Space
        Dim st As String = ""
        For i As Integer = 0 To Txt.Length - 1
            If Txt(i) = " " Then
                st = st & Convert.ToChar(Asc(Txt(i))).ToString
                First_Space = True
            ElseIf First_Space = False Then
                st = st & Convert.ToChar(Asc(Txt(i))).ToString
            Else
                st = st & Convert.ToChar(Asc(Txt(i)) - Key).ToString
            End If
        Next
        Return st
    End Function
End Class
