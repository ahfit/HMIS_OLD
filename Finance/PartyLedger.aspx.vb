Imports Microsoft.Reporting.WebForms
Imports MegaPlus.Finance
Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_PartyLedgerReportNew
    Inherits System.Web.UI.Page
    Private conString As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'wdcFromDate.Value = New Date(2013, 7, 1)
            wdcFromDate.Value = DateTime.Now.AddMonths(-1)
            wdcToDate.Value = DateTime.Now
            ddlCompanyBranch.DataBind()
            ddlParty.DataBind()
            ' If Request.UrlReferrer.Segments(Request.UrlReferrer.Segments.Length - 1).Contains("CID=") Then
            If Not String.IsNullOrEmpty(Request.QueryString("CID")) Then
                ddlCompanyBranch.SelectedValue = Request.QueryString("CID")
                ddlCompanyBranch.Enabled = False
            End If
            'End If
            If Not String.IsNullOrEmpty(Request.QueryString("PID")) Then

                ddlParty.SelectedValue = Request.QueryString("PID")
                ddlCompanyBranch.Enabled = False
                ddlParty.Enabled = False
            End If
        End If

    End Sub

    Protected Sub btnViewReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewReport.Click
        Dim reportPath As String = String.Empty
        'If Convert.ToInt32(ddlCompanyBranch.SelectedValue) >= 5 Then
        '    reportPath = Server.MapPath("~/Finance/PartyLedgerReportNew.rdlc")
        'Else
        reportPath = Server.MapPath("~/Finance/MP_PartyLedgerReportNew.rdlc")
        'End If
        ShowReport(reportPath)
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
    Private Sub ShowReport(ByVal rptPath As String)

        ReportViewer1.LocalReport.DataSources.Clear()
        Dim ds As Finance = New Finance()
        Dim reportPath As String = rptPath

        Dim dbMgr As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {New SqlParameter("@PO_Id", Request.QueryString("PO_ID"))}
        Dim sqlParam() As SqlParameter = New SqlParameter() _
        {
          New SqlParameter("@CompanyBranchId", ddlCompanyBranch.SelectedValue),
          New SqlParameter("@PartyId", ddlParty.SelectedValue),
          New SqlParameter("@FromDate", wdcFromDate.Value.ToString()),
          New SqlParameter("@ToDate", wdcToDate.Value.ToString()),
            New SqlParameter("@postedUnposted", DDLVoucher.SelectedValue)
        }
        Dim dt As DataTable = New DataTable()
        dt = dbMgr.ExecuteDataTable("usp_rpt_PartyLedgerReport", "Finance_ConnectionString", sqlParam)
        
        Dim finManager As New FinanceDBManager(conString)

        Dim dsBalance As DataSet = finManager.GetPartyBalancePeriodData(Convert.ToDateTime(wdcToDate.Value), Integer.Parse(ddlParty.SelectedValue), Integer.Parse(ddlCompanyBranch.SelectedValue))
        Dim dsCompanyPay As DataSet = finManager.GetPartyAndPaymentData(Integer.Parse(ddlParty.SelectedValue))

        UpdateBalanceData(dsBalance)

        Dim params(10) As ReportParameter
        params(0) = New ReportParameter("CompanyName", ddlParty.SelectedItem.Text)
        params(1) = New ReportParameter("FromDate", Convert.ToDateTime(wdcFromDate.Value).ToString("dd MMMM yyyy"))
        params(2) = New ReportParameter("ToDate", Convert.ToDateTime(wdcToDate.Value).ToString("dd MMMM yyyy"))
        params(3) = New ReportParameter("Balance1", GetBalance(dsBalance, 1))
        params(4) = New ReportParameter("Balance2", GetBalance(dsBalance, 2))
        params(5) = New ReportParameter("Balance3", GetBalance(dsBalance, 3))
        params(6) = New ReportParameter("Balance4", GetBalance(dsBalance, 4))
        params(7) = New ReportParameter("Balance5", GetBalance(dsBalance, 5))
        params(8) = New ReportParameter("CreditLimit", GetCompanyInvoicePayData(dsCompanyPay, "CR"))
        params(9) = New ReportParameter("LastInvoice", GetCompanyInvoicePayData(dsCompanyPay, "INV"))
        params(10) = New ReportParameter("LastPayment", GetCompanyInvoicePayData(dsCompanyPay, "PAY"))

        ReportViewer1.LocalReport.ReportPath = reportPath
        ReportViewer1.LocalReport.SetParameters(params)
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        ReportViewer1.LocalReport.Refresh()

    End Sub

    Private Sub UpdateBalanceData(ByRef data As DataSet)
        Dim runTotal As Decimal = 0.0, currentValue As Decimal = 0.0
        Dim isFirstPass As Boolean = True

        If data.Tables(0).Rows.Count = 0 Then
            Return
        End If

        runTotal = Convert.ToDecimal(data.Tables(0).Rows(0)("Balance").ToString())

        For Each dt As DataTable In data.Tables
            For Each dr As DataRow In dt.Rows
                If isFirstPass = True Then
                    isFirstPass = False
                    Continue For
                End If

                currentValue = Math.Abs(Convert.ToDecimal(dr("Balance").ToString()))

                If runTotal < 0 Then
                    dr("Balance") = 0
                ElseIf currentValue = 0 Then
                    Continue For
                ElseIf runTotal - currentValue < 0 Then
                    dr("Balance") = runTotal
                    runTotal = 0
                ElseIf runTotal = 0 Then
                    dr("Balance") = 0
                ElseIf runTotal - currentValue > 0 Then
                    runTotal = runTotal - currentValue
                End If

            Next
        Next

    End Sub

    Private Function GetBalance(ByVal dsTemp As DataSet, ByVal rowId As Integer) As Decimal
        Dim retVal As Decimal = 0.0
        Try
            Select Case rowId
                Case 1
                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "Current" Then
                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())
                    End If
                Case 2
                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "30 Days" Then
                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())
                    End If

                Case 3
                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "60 Days" Then
                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())
                    End If
                Case 4
                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "90 Days" Then
                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())
                    End If
                Case 5
                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "Earlier" Then
                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())
                    End If
            End Select

        Catch ex As Exception
            retVal = 0.0
        End Try

        Return retVal
    End Function

    Private Function GetCompanyInvoicePayData(ByRef data As DataSet, ByVal field As String) As String
        Dim retVal As String = String.Empty

        If field = "CR" Then
            Return Convert.ToDecimal(data.Tables(0).Rows(0)("Credit_Limit").ToString()).ToString("#,#")
        ElseIf field = "INV" Then
            If Convert.ToDateTime(data.Tables(0).Rows(0)("Invoice_Date").ToString()).ToString("yyyy-MM-dd") = "9999-09-09" Then
                retVal = String.Empty
            Else
                retVal = Convert.ToDecimal(data.Tables(0).Rows(0)("Invoice_Amount").ToString()).ToString("#,#") + " ( " + Convert.ToDateTime(data.Tables(0).Rows(0)("Invoice_Date").ToString()).ToString("dd MMM yyyy") + " ) "
            End If
        ElseIf field = "PAY" Then
            If Convert.ToDateTime(data.Tables(0).Rows(0)("Payment_Date").ToString()).ToString("yyyy-MM-dd") = "9999-09-09" Then
                retVal = String.Empty
            Else
                retVal = Convert.ToDecimal(data.Tables(0).Rows(0)("Pay_Amount").ToString()).ToString("#,#") + " ( " + Convert.ToDateTime(data.Tables(0).Rows(0)("Payment_Date").ToString()).ToString("dd MMM yyyy") + " ) "
            End If
        End If

        Return retVal
    End Function

End Class
