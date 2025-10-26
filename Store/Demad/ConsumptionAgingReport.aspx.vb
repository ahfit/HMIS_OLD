Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports MegaPlus.Finance
Imports System.Data.SqlClient

Partial Class Store_ConsumptionAgingReport
    Inherits System.Web.UI.Page
    Private finConString As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString
    Protected Sub Requsition_Report()
        Try
            Dim rqId As String = "", iCode As String = ""
            If Not String.IsNullOrEmpty(Request.QueryString("RQ_ID")) Then
                rqId = Request.QueryString("RQ_ID")
            Else
                rqId = ""
            End If
            If Not String.IsNullOrEmpty(Request.QueryString("ICode")) Then
                iCode = Request.QueryString("ICode")
            Else
                iCode = ""
            End If
            Dim dbMgr As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {New SqlParameter("@RQ_ID", rqId), New SqlParameter("@Item_Code", iCode)}
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim reportPath As String = Server.MapPath("ConsumptionAgingReport.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dbMgr.ExecuteDataTable("uspGetItemsConsumptionsAging", "STOREConnectionString", sqlParams)))
            'AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            AddHandler ReportViewer1.LocalReport.SubreportProcessing, AddressOf Me.subReports
            ReportViewer1.LocalReport.Refresh()


        Catch ex As Exception
            Response.Write(ex.Message)
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
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Requsition_Report()
        End If


    End Sub
End Class
