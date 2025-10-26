
Partial Class PatientAppointmentwise
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        If Not IsPostBack Then
            WebDateChooserDate.Value = Now
            WebDateChooserEndDate.Value = Now
        End If
        'HiddenFieldDate.Value = WebDateChooserDate.Value
        'HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
        CrystalReportViewerReport.Visible = False
    End Sub

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        HiddenFieldDate.Value = WebDateChooserDate.Value
        HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
        CrystalReportViewerReport.Visible = True
    End Sub

    'Protected Sub WebDateChooserDate_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooserDate.ValueChanged
    '    HiddenFieldDate.Value = WebDateChooserDate.Value
    'End Sub

    'Protected Sub WebDateChooserEndDate_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooserEndDate.ValueChanged
    '    HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
    'End Sub
End Class
