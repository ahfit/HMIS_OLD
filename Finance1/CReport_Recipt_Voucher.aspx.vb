Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.IO
Imports System.Linq
Imports System.Diagnostics.CodeAnalysis
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared


Partial Class Receipt_voucher
    Inherits System.Web.UI.Page
    Dim dbMgr As DbManager = New DbManager()
    Dim rpt As New ReportDocument
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not IsPostBack Then
                LoadReport()
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    



    Sub LoadReport()
        Dim vti As String = ""
        If Request.QueryString("VTI") = "" Then
            vti = Session("VTI")
        Else
            vti = Request.QueryString("VTI")
        End If
        Dim conStr As String = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(conStr)
        Dim cmdMain As SqlCommand = New SqlCommand("usp_CReport_ReciptVoucher_Main", con)
        cmdMain.CommandType = CommandType.StoredProcedure
        cmdMain.Parameters.AddWithValue("@Voucher_Trans_Id", vti)
        Dim cmdSub As SqlCommand = New SqlCommand("usp_CReport_ReciptVoucher_Sub_E", con)
        cmdSub.CommandType = CommandType.StoredProcedure
        cmdSub.Parameters.AddWithValue("@Voucher_Trans_Id", vti)
        con.Open()
        Dim drMain As SqlDataAdapter = New SqlDataAdapter(cmdMain)
        Dim drSub As SqlDataAdapter = New SqlDataAdapter(cmdSub)
        Dim dtMain As DataTable = New DataTable()
        Dim dtSub As DataTable = New DataTable()

        drMain.Fill(dtMain)
        drSub.Fill(dtSub)
        Dim path As String = Server.MapPath("CReport_Receipt_Voucher.rdlc")
        ReportViewer1.LocalReport.ReportPath = path
        ReportViewer1.LocalReport.DataSources.Clear()
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dtMain))
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", dtSub))
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf Subreports
        ReportViewer1.LocalReport.Refresh()
        If Request.Browser.Browser = "Chrome" Then
            Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            Response.ContentType = "application/pdf"
            Response.BinaryWrite(bytes)
            Response.End()
        Else
            ReportViewer1.Visible = True
        End If
        ReportViewer1.LocalReport.Dispose()
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

