
Partial Class Pathology_Reports_Annual_Pt_Free_Paid
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            HiddenFieldYear.Value = DropDownListYear.SelectedValue.ToString
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            'CrystalReportViewerForReport.RefreshReport()
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("..\login.aspx")
            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub

    'Protected Sub DropDownListYear_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListYear.PreRender
    '    HiddenFieldYear.Value = DropDownListYear.SelectedValue.ToString
    'End Sub

    Protected Sub DropDownListYear_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListYear.SelectedIndexChanged
        HiddenFieldYear.Value = DropDownListYear.SelectedValue.ToString
    End Sub
End Class
