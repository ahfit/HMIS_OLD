Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Partial Class MriRevenueReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CrystalReportViewer1.ReportSourceID = "CrystalReportSourceBetweenDate_TestReport"
        CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = 123
        'CrystalReportViewer1.RefreshReport()
        'CrystalReportViewer1.BackColor = Drawing.Color.LightCyan
        'CrystalReportViewer1.ControlStyle.BorderColor = Drawing.Color.GreenYellow
        'HiddenFieldStartDate.Value = WebDateChooserStartDate.Value
        'HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
        'HiddenFieldScanType.Value = RadioButtonListCategory.SelectedValue
    End Sub

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        HiddenFieldStartDate.Value = WebDateChooserStartDate.Value
        HiddenFieldEndDate.Value = WebDateChooserEndDate.Value
        'HiddenFieldScanType.Value = DropDownListScanType.SelectedValue
        HiddenFieldScanType.Value = RadioButtonListCategory.SelectedValue
        CrystalReportViewer1.Visible = True
    End Sub

    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad

    End Sub
End Class
