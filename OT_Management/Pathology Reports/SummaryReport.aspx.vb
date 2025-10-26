Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Pathology_Reports_SummaryReport
    Inherits System.Web.UI.Page

    Sub Load_Crystal_Report()
        Try
            Dim crdoc As New ReportDocument
            Dim ds As DataSet = Pt_Dataset_Fill()
            Dim path As String = Server.MapPath("SummeryReports.rpt")
            crdoc.Load(path)
            crdoc.Database.Tables("TestSummery").SetDataSource(ds.Tables("TestSummery"))
            CrystalReportViewerSummary.ReportSource = crdoc
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Function Pt_Dataset_Fill() As DataSet
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.TestSummeryTableAdapter
        da.Fill(ds.Tables("TestSummery"))
        Return ds
    End Function

    Protected Sub ButtonSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearch.Click
        Load_Crystal_Report()
    End Sub
End Class
