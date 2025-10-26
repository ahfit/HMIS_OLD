Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data.SqlClient
Imports System.Data

Partial Class Indoor_Payment_Discount
    Inherits System.Web.UI.Page
    Dim crdoc As New ReportDocument
    Dim obj As New AmountInWords
    Dim ENC As New Encryption


    Dim _SqlAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim _SqlCon As SqlConnection
    Dim _SqlCommand As SqlCommand = New SqlCommand()
    Dim _dataTable As DataTable = New DataTable()
    Dim _dataSet As DataSet = New DataSet()


    Dim conStr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim dbmgr As DbManager = New DbManager()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            loadReport()
        End If
    End Sub


    Private Sub loadReport()

        Try
            Dim param As SqlParameter() = New SqlParameter() {New SqlParameter("@RegNo", Request.QueryString("RegNo")),
                                           New SqlParameter("@Payment_No", Request.QueryString("Payment_No")),
                                           New SqlParameter("@PayID", Request.QueryString("PayID"))}

            ReportViewer1.LocalReport.DataSources.Clear()

            Dim ds As New DataSet()
            ds = ExecuteDataSet("usp_indoor_Payment_Discount", "Basic_Data_ConnectionString", param)


            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                For j As Integer = 0 To ds.Tables(1).Rows.Count - 1
                    If ds.Tables(0).Rows(i).Item("PayID") = ds.Tables(1).Rows(j).Item("Yearly_No") Then
                        ds.Tables(0).Rows(i).Item("RoomNo") = ds.Tables(1).Rows(j).Item("Room")
                    End If
                Next
                ds.Tables(0).Rows(i).Item("Prefix") = ds.Tables(0).Rows(i).Item("Prefix").ToString.Trim + " " + ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("PFName"), False).Trim + " " + ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("PMName"), False).Trim + " " + ENC.Encrypt_Main(ds.Tables(0).Rows(i).Item("PLName"), False).Trim


            Next
            ds.Tables(0).Rows(0).Item("RegNo") = ENC.Encrypt_Main(ds.Tables(0).Rows(0).Item("RegNo"), False)

            Dim reportPath As String = Server.MapPath("Indoor_Payment_Discount.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("AmountWords", obj.In_Words(CInt(ds.Tables(0).Rows(0).Item("Amount")))))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables(1)))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()



            If Request.Browser.Browser = "Chrome" Then
                Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.[End]()
            Else

                ReportViewer1.Visible = True
            End If
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub


    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload

    End Sub
    Public Sub Openconn(ByVal connStr As String)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings(connStr).ConnectionString
            _SqlCon = New SqlConnection(constr)
            _SqlCon.Open()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function ExecuteDataSet(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter()) As DataSet
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next


            _SqlAdapter.SelectCommand = _SqlCommand
            _SqlAdapter.Fill(_dataSet)

            _SqlCon.Close()
            _SqlCommand.Dispose()

        Catch ex As Exception
            Throw ex
        End Try

        Return _dataSet
    End Function

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
