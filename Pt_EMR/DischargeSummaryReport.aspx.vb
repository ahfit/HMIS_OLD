Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data

Partial Class Pt_EMR_DischargeSummaryReport
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Dim abc As ReportDocument = New ReportDocument()

    Private Sub ShowReport()

        Dim ds As Reports = New Reports()

        Dim da As ReportsTableAdapters.PatientFaceSheetReportNewTableAdapter = New ReportsTableAdapters.PatientFaceSheetReportNewTableAdapter()

        Dim path As String = Server.MapPath("~/Pt_EMR/DischargeSummary.rpt")
        abc.FileName = path

        da.Fill(ds.PatientFaceSheetReportNew, Session("RegistrationNo").ToString(), Session("yearlyNo").ToString())

        'Decrypt encrypted information to display in report
        For Each dr As DataRow In ds.Tables("PatientFaceSheetReportNew").Rows
            dr("PFName") = ENC.Encrypt_Main(dr("PFName").ToString(), False)
            dr("PMName") = ENC.Encrypt_Main(dr("PMName").ToString(), False)
            dr("PLName") = ENC.Encrypt_Main(dr("PLName").ToString(), False)
            dr("RegNo") = ENC.Encrypt_Main(dr("RegNo").ToString(), False)
        Next

        abc.Database.Tables("PatientFaceSheetReportNew").SetDataSource(ds.Tables("PatientFaceSheetReportNew"))
        CrystalReportViewer1.ReportSource = abc
        CrystalReportViewer1.DataBind()
        CrystalReportViewer1.Visible = True
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Page.Title = "Patient Discharge Summary Report"
        ShowReport()
    End Sub
End Class
