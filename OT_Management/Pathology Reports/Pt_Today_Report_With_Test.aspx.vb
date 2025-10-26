Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Reports_Pt_Today_Report_With_Test
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = True Then
            Load_Crystal_Report()
        End If
    End Sub
    Sub Load_Crystal_Report()
        Try
            Dim ds_Sub As New Pt_Radiology_Test
            Dim da_sub As New Pt_Radiology_TestTableAdapters.Pt_Daily_Ot_Test_Report_SubTableAdapter
            Dim Select_Date As Date = CDate(WebDateChooser1.Value)
            da_sub.Fill(ds_Sub.Tables("Pt_Daily_Ot_TestSub_Report"), Select_Date.Day & "/" & Select_Date.Month & "/" & Select_Date.Year)

            Dim crdoc As New ReportDocument
            Dim ds As DataSet = Pt_Dataset_Fill()
            For i As Integer = 0 To ds.Tables("Pt_Daily_Ot_Test_Report").Rows.Count - 1
                Dim Count As Integer = 0
                For j As Integer = 0 To ds_Sub.Tables("Pt_Daily_Ot_TestSub_Report").Rows.Count - 1
                    If ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("RegNo") = ds_Sub.Tables("Pt_Daily_Ot_TestSub_Report").Rows(j).Item("RegNo") Then
                        If Count = 0 Then
                            ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("TB_NAme") = ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("TB_NAme") & "" & ds_Sub.Tables("Pt_Daily_Ot_TestSub_Report").Rows(j).Item("TB_Name")
                            Count = Count + 1
                        Else
                            ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("TB_NAme") = ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("TB_NAme") & ", " & ds_Sub.Tables("Pt_Daily_Ot_TestSub_Report").Rows(j).Item("TB_Name")
                        End If
                    End If
                Next
                ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("Prefix") = ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("Prefix").ToString & " " & ENC.Encrypt_Main(ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("pfname").ToString, False) & " " & ENC.Encrypt_Main(ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("pmname").ToString, False) & " " & ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("Relation").ToString & " " & ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("Rfname").ToString & " " & ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("Rmname").ToString
                ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("RegNo") = ENC.Encrypt_Main(ds.Tables("Pt_Daily_Ot_Test_Report").Rows(i).Item("RegNo").ToString, False)
            Next
            Dim path As String = Server.MapPath("Pt_Daily_Test_Report.rpt") '("Pt_Test_Report.rpt")
            crdoc.Load(path)
            crdoc.Database.Tables("Pt_Daily_Test_Report").SetDataSource(ds.Tables("Pt_Daily_Test_Report"))
            CrystalReportViewer1.ReportSource = crdoc
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Function Pt_Dataset_Fill() As DataSet
        Dim ds As New Pt_Radiology_Test
        'Dim da As New Pt_Radiology_TestTableAdapters.Pt_Daily_Test_ReportTableAdapter
        Dim da As New Pt_Radiology_TestTableAdapters.Pt_Daily_Ot_Test_ReportTableAdapter
        Dim Select_Date As Date = CDate(WebDateChooser1.Value)
        If RadioButtonList1.SelectedValue = 0 Then
            da.Fill(ds.Tables("Pt_Daily_Ot_Test_Report"), Select_Date.Day & "/" & Select_Date.Month & "/" & Select_Date.Year)
        Else
            da.Fill_Shift(ds.Tables("Pt_Daily_Ot_Test_Report"), RadioButtonList1.SelectedValue, Select_Date.Day & "/" & Select_Date.Month & "/" & Select_Date.Year)
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
