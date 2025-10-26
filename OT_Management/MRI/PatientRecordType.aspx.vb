
Partial Class PatientRecordTypeaspx
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CrystalReportViewer1.ReportSourceID = "CrystalReportSource1"
        CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = 123
    End Sub

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        HiddenFieldStartDate.Value = WebDateChooserStartDate.Value
        HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
        'HiddenFieldScanType.Value = DropDownListScanType.SelectedValue
        HiddenFieldPatientType.Value = RadioButtonListPatientType.SelectedValue
        CrystalReportViewer1.Visible = True
    End Sub
End Class
