Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports MegaPlus.Finance
Imports System.Data.SqlClient

Partial Class Store_Demand_Requisition_Report
    Inherits System.Web.UI.Page
    Private finConString As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString
    Protected Sub Requsition_Report()
        Try
            Dim dbMgr As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {New SqlParameter("@IB_ID", Request.QueryString("RequsitionNo"))}
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim reportPath As String = Server.MapPath("Demand_Requsition.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            Dim Str As String = Request.QueryString("RequsitionNo")
            Dim check As String = Str.Substring(0, 1)
            Dim para As ReportParameter()

            If (check = "S") Then

                para = New ReportParameter() {
                    New ReportParameter("Service", "Service Requisition")
                  }
            Else

                para = New ReportParameter() {
                    New ReportParameter("Service", "Demand Requisition")
                  }


            End If
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dbMgr.ExecuteDataTable("usp_Demand_Req_Report", "STOREConnectionString", sqlParams)))
            AddHandler ReportViewer1.LocalReport.SubreportProcessing, AddressOf Me.subReports
            ReportViewer1.LocalReport.SetParameters(para)
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
