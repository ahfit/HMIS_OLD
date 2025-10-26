
Imports System.Data
Imports System.Data.SqlClient
Partial Class Store_PurchaseOrderReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
            loadReport()
        End If
    End Sub
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString
    Protected Sub getsetTaxDiscount()
        Dim con As New SqlConnection(constr)
        con.Open()
        Dim qry As String = "SELECT PO_Tax_Discount.PO_ID, Tax_Discount_HeadDetail.Tax_Name, PO_Tax_Discount.Amount FROM PO_Tax_Discount INNER JOIN Tax_Discount_HeadDetail ON PO_Tax_Discount.Tax_ID = Tax_Discount_HeadDetail.Tax_Id WHERE (PO_Tax_Discount.PO_ID = @PO_ID)"
        Dim command As New SqlCommand(qry, con)
        command.Parameters.AddWithValue("@PO_ID", Request.QueryString("PO_ID"))
        Dim reader As SqlDataReader
        Try
            HiddenField_Tax.Value = 0
            HiddenField_Discount.Value = 0

            reader = command.ExecuteReader()
            While reader.Read
                If reader.Item("Tax_Name").ToString() = "Tax" Then
                    HiddenField_Tax.Value = reader.Item("Amount")

                ElseIf reader.Item("Tax_Name").ToString() = "Discount" Then
                    HiddenField_Discount.Value = reader.Item("Amount")

                End If
            End While

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub loadReport()
        Dim dbMgr As DbManager = New DbManager()
        Dim dbMgr1 As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {New SqlParameter("@PO_Id", Request.QueryString("PO_ID"))}
        '' Dim sqlParams1 As SqlParameter() = {New SqlParameter("@PO_Id", Request.QueryString("PO_ID"))}
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim reportPath As String = Server.MapPath("PurchaseOrderRpt.rdlc")
        ReportViewer1.LocalReport.ReportPath = reportPath
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("PurchaseOrder", dbMgr.ExecuteDataTable("usp_SelectPurchaseOrder", "STOREConnectionString", sqlParams)))
        ''ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dbMgr1.ExecuteDataTable("usp_GetPOExpenses", "STOREConnectionString", sqlParams1)))
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        If Request.Browser.Browser = "Chrome" Then
            Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            Response.ContentType = "application/pdf"
            Response.BinaryWrite(bytes)
            Response.[End]()
        Else

            ReportViewer1.Visible = True
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
End Class
