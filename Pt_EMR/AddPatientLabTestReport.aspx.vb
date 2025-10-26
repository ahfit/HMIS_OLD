Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_AddPatientLabTestReport
    Inherits System.Web.UI.Page
    Dim Conster As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ToString()
    Protected Sub btnReport_Click1(sender As Object, e As EventArgs)
        'Dim dsReports As New Reports
        'Dim dad As New ReportsTableAdapters.usp_AdminServicesRatesTableAdapter



        'ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pt_EMR/AddPatientLabTestReport.rdlc")
        'ReportViewer1.LocalReport.DataSources.Clear()
        'Dim repDs As New ReportDataSource
        'repDs.Name = "DataSet1"
        'repDs.Value = dsReports.Tables("Pathology_GetTestResultComparsionReportNew")
        'ReportViewer1.LocalReport.DataSources.Add(repDs)
        'AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

        Dim conn As SqlConnection = New SqlConnection(Conster)
        Dim dt As DataTable = New DataTable()

        Try
            Dim sc As SqlCommand = New SqlCommand("Pathology_GetTestResultComparsionReportNew", conn)
            sc.CommandType = CommandType.StoredProcedure
            sc.Parameters.AddWithValue("@RegNo", Convert.ToString(TextBox_Reg.Text))
            Dim sda As SqlDataAdapter = New SqlDataAdapter(sc)
            sda.Fill(dt)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pt_EMR/AddPatientLabTestReport.rdlc")
            ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", dt))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()
            ReportViewer1.Visible = True
            pnlReport.Visible = True

        Catch ex As Exception
        Finally
        End Try
    End Sub



    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub
End Class
