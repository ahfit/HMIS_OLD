Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_ProfitandLoss_MOR_Details
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ShowReport()
        End If
    End Sub

    Private Sub ShowReport()
        Try
            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand("GetProfitLoss_MOR_DetailbyNotes", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ForCompnay", Request.QueryString("CID"))
            cmd.Parameters.AddWithValue("@ForBranch", Request.QueryString("BID"))
            cmd.Parameters.AddWithValue("@CostCenterID", Request.QueryString("CCID"))
            cmd.Parameters.AddWithValue("@ReportPeriod", "1")

            cmd.Parameters.AddWithValue("@StartDate1", Request.QueryString("StartDate1"))
            cmd.Parameters.AddWithValue("@EndDate1", Request.QueryString("EndDate1"))

            cmd.Parameters.AddWithValue("@StartDate2", Request.QueryString("StartDate2"))
            cmd.Parameters.AddWithValue("@EndDate2", Request.QueryString("EndDate2"))
            cmd.Parameters.AddWithValue("@Notes", Request.QueryString("N"))

            con.Open()
            Dim dr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            dr.Fill(ds)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Finance/ProfitLossSheetCross_MOR_bynotes - Copy.rdlc")
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Company", Request.QueryString("CID")))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Branch", Request.QueryString("branch")))
            'ReportViewer1.LocalReport.SetParameters(New ReportParameter("StartDate", txtToDate1.Text))
            'ReportViewer1.LocalReport.SetParameters(New ReportParameter("EndDate", txtToDate2.Text))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            'ReportViewer1.LocalReport.Refresh()

            'If Request.Browser.Browser = "Chrome" Then
            '    Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
            '    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            '    Response.ContentType = "application/pdf"
            '    Response.BinaryWrite(bytes)
            '    Response.End()
            'Else
            ReportViewer1.Visible = True
            'End If

        Catch ex As Exception

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
