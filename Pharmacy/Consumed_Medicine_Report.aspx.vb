Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.IO
Imports System.Diagnostics.CodeAnalysis
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports Microsoft.Reporting.WebForms

Partial Class Pharmacy_Consumed_Medicine_Report
    Inherits System.Web.UI.Page

    Dim obj As New AmountInWords
    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            HF_Consumption_ID.Value = Request.QueryString("C_ID").ToString()

            LoadReport()
        End If
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
    Protected Sub LoadReport()
        Try
            Dim dv As DataView = SqlDataSource1.Select(DataSourceSelectArguments.Empty)
            Dim dt As DataTable = dv.Table
            dt.Columns("regno").ReadOnly = False
            dt.Columns("PFName").ReadOnly = False
            dt.Columns("PMName").ReadOnly = False
            dt.Columns("PLName").ReadOnly = False
            Dim totalamount As Decimal

            For Each row As DataRow In dt.Rows
                row("RegNo") = (row("RegNo").ToString())
                Dim PFname As String = (row("PFName"))
                Dim PMname As String = (row("PMName"))
                Dim PLname As String = (row("PLName"))
                totalamount = totalamount + row("Total") - row("DiscountAmount")
                Dim PatientFullName As String = PFname + " " + PMname + "" + PLname
                row("PatientName") = PatientFullName
                If PatientFullName = "Walkin " Then
                    row("PatientName") = PatientFullName + "(" + row("Contact_Person") + ")"
                End If

            Next
            dt.Columns("AmountInWords").ReadOnly = False
            Dim amontinwords = obj.In_Words(totalamount)
            For Each row As DataRow In dt.Rows
                row("AmountInWords") = amontinwords
            Next

            Dim repDs As New ReportDataSource
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pharmacy/Reports/Report.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()

            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf Subreports
            Response.Write(Request.Browser.Browser)
            If Request.Browser.Browser = "Chrome" Then
                Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            Else
                ReportViewer1.Visible = True
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub



    
End Class
