Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Pathology_Reports_DailyTestReport
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = True Then
            Load_Crystal_Report()
        End If
    End Sub
    Sub Load_Crystal_Report()
        Try
            Dim crdoc As New ReportDocument
            Dim ds As DataSet = Pt_Dataset_Fill()
            For i As Integer = 0 To ds.Tables("Pt_Daily_Test_Report").Rows.Count - 1
                ds.Tables("Pathology_Test").Rows(i).Item("Prefix") = ds.Tables("Pathology_Test").Rows(i).Item("Prefix").ToString & " " & ENC.Encrypt_Main(ds.Tables("Pathology_Test").Rows(i).Item("pfname").ToString, False) & " " & ENC.Encrypt_Main(ds.Tables("Pathology_Test").Rows(i).Item("pmname").ToString, False) & " " & ENC.Encrypt_Main(ds.Tables("Pathology_Test").Rows(i).Item("plname").ToString, False)
                ds.Tables("Pathology_Test").Rows(i).Item("Registration No") = ENC.Encrypt_Main(ds.Tables("Pathology_Test").Rows(i).Item("Registration No").ToString, False)
            Next
            Dim path As String = Server.MapPath("Today_Patient_Report.rpt")
            crdoc.Load(path)
            crdoc.Database.Tables("Pathology_Test").SetDataSource(ds.Tables("Pathology_Test"))
            CrystalReportViewer1.ReportSource = crdoc
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Function Pt_Dataset_Fill() As DataSet
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.Pathology_TestTableAdapter
        Dim Select_Date As Date = CDate(WebDateChooser1.Value)
        If RadioButtonList1.SelectedValue = 0 Then
            da.FillBy(ds.Tables("Pathology_Test"), Select_Date.Day & "/" & Select_Date.Month & "/" & Select_Date.Year)
        Else
            da.Fill(ds.Tables("Pathology_Test"), Select_Date.Day & "/" & Select_Date.Month & "/" & Select_Date.Year, RadioButtonList1.SelectedValue)
        End If
        Return ds
    End Function

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList1.SelectedIndexChanged
        Load_Crystal_Report()
    End Sub

    Protected Sub WebDateChooser1_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser1.ValueChanged
        Load_Crystal_Report()
    End Sub
End Class
