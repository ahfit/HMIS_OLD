Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Microsoft.Reporting.WebForms
Imports MegaPlus.Finance

Partial Class PurchaseReturnReport
    Inherits System.Web.UI.Page

    Private finConString As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString

    Private ReadOnly Property PartyID() As Integer

        Get
            Try
                Return Integer.Parse(Request.QueryString("PID"))
            Catch ex As Exception
                Return 0
            End Try
        End Get

    End Property
    Protected Sub subReports(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = Session("DynamicHeader")
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
        Catch ex As Exception

        End Try
    End Sub
    Private ReadOnly Property CompanyBranchID() As Integer

        Get
            Try
                Return Integer.Parse(Request.QueryString("CBID"))
            Catch ex As Exception
                Return 0
            End Try
        End Get

    End Property

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HiddenFieldSO_ID.Value = Request.QueryString("QO_ID")

        If Not Page.IsPostBack Then
            Try
                ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
                Dim Ath As String = Request.QueryString("Ath")
                If String.IsNullOrEmpty(Ath) Then
                    Pnl_Ath.Visible = False
                Else
                    Pnl_Ath.Visible = True

                End If
                Dim con As SqlConnection = New SqlConnection(constr)
                Dim cmd As SqlCommand = New SqlCommand("PR_Report", con)
                cmd.CommandType = CommandType.StoredProcedure
                cmd.Parameters.AddWithValue("@QO_ID", HiddenFieldSO_ID.Value)
                con.Open()
                Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
                Dim dt As DataTable = New DataTable()
                da.Fill(dt)
                con.Close()
                Dim reportPath As String = String.Empty
                If String.IsNullOrEmpty(Request.QueryString("RP")) Then
                    reportPath = Server.MapPath("~/store/Reports/PurchaseReturnReport.rdlc")
                Else
                    reportPath = Server.MapPath("~/store/Reports/IPOPriceReport.rdlc")
                End If


                getsetTaxDiscount()


                Dim repParams() As ReportParameter = New ReportParameter(8) {}
                repParams(0) = New ReportParameter("QO_ID", HiddenFieldSO_ID.Value)
                repParams(1) = New ReportParameter("Balance1", "0")
                repParams(2) = New ReportParameter("Balance2", "0")
                repParams(3) = New ReportParameter("Balance3", "0")
                repParams(4) = New ReportParameter("Balance4", "0")
                repParams(5) = New ReportParameter("Balance5", "0")
                repParams(6) = New ReportParameter("CreditLimit", "0")
                repParams(7) = New ReportParameter("LastInvoice", "0")
                repParams(8) = New ReportParameter("LastPayment", "0")
                ReportViewer1.LocalReport.ReportPath = reportPath
                ReportViewer1.LocalReport.SetParameters(repParams)
                ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
                AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
                ReportViewer1.LocalReport.Refresh()


            Catch ex As Exception

            End Try

        End If
        ReportViewer1.LocalReport.EnableHyperlinks = True


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
            'dsTemp.Tables(0).Rows()
            'If dsTemp.Tables(0).Rows.count < rowId Then
            '    retVal = 0
            'Else
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
                    Else
                        retVal = 0
                    End If

                Case 5

                    If dsTemp.Tables(0).Rows(rowId - 1)(0).ToString() = "Earlier" Then

                        retVal = Decimal.Parse(dsTemp.Tables(0).Rows(rowId - 1)("Balance").ToString())

                    Else
                        retVal = 0
                    End If
            End Select
            'End If
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

    Protected Sub getsetTaxDiscount()


    End Sub



    Protected Sub btn_approve_Click(sender As Object, e As System.EventArgs) Handles btn_approve.Click
        Try
            SQL_Finalize_IPO.Update()
            Pnl_Ath.Visible = False

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Btn_Reject_Click(sender As Object, e As System.EventArgs) Handles Btn_Reject.Click
        Try
            Panel_Remarks.Visible = True

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btn_Save_Click(sender As Object, e As System.EventArgs) Handles btn_Save.Click
        Try
            If String.IsNullOrEmpty(TextBox_Remarks.Text.Trim()) Then
                Label.Text = "Please Enter the Remarks First"
            Else
                Sql_Remarks.Update()
                Label.Text = "Remarks Add successfully"
                btn_Save.Visible = False
                Pnl_Ath.Visible = False
            End If

        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btn_Cancel_Click(sender As Object, e As System.EventArgs) Handles btn_Cancel.Click
        Panel_Remarks.Visible = False
        Label.Visible = False

    End Sub
End Class
