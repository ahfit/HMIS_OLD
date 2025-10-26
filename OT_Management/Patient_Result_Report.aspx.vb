Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Result_Report
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Page.ClientScript.RegisterStartupScript([GetType], "onload", "<script language ='javascript'>window.document.title='" & obj.Page_Title & "';</script>")
        Try
            Load_Crystal_Report()
        Catch ex As Exception

        End Try


    End Sub

    Sub Load_Crystal_Report()
        Try
            Dim crdoc As New ReportDocument
            Dim ds As DataSet = Pt_Dataset_Fill()

            Dim path As String
            'If Request.QueryString("TGID") = 17 Then
            'path = Server.MapPath("Patient_Result_Report_Para.rpt")

            'Else

            path = Server.MapPath("Patient_Result_Report_Para.rpt")

            '   End If

            crdoc.Load(path)
            crdoc.Database.Tables("Hospital_Header").SetDataSource(Session("Rpt_Header_DT"))
            crdoc.Database.Tables("Patient_Result_Report").SetDataSource(ds.Tables("Patient_Result_Report"))
            crdoc.Database.Tables("Simple_Basic_Info").SetDataSource(ds.Tables("Simple_Basic_Info"))
            CrystalReportViewer1.ReportSource = crdoc
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Function Pt_Dataset_Fill() As DataSet
        Try

        
            Dim ds As New Pt_Radiology_Test
            Dim da As New Pt_Radiology_TestTableAdapters.Patient_Result_ReportTableAdapter
            '========================= Basic Data Info =========

            Dim da_Basic_Info As New Pt_Radiology_TestTableAdapters.Simple_Basic_InfoTableAdapter
            'ds.Tables("Simple_Basic_Info").Rows(0).


            da_Basic_Info.Fill(ds.Tables("Simple_Basic_Info"), Session("RegistrationNo"), CInt(Request.QueryString("Main_ID")))

            For i As Integer = 0 To ds.Tables("Simple_Basic_Info").Rows.Count - 1
                'Response.Write(ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(0), False) & " this encrypt")

                ds.Tables("Simple_Basic_Info").Rows(i).Item(0) = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(0).ToString.Trim, False)
                ds.Tables("Simple_Basic_Info").Rows(i).Item(1) = Convert.ToString(ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(15).ToString.Trim, False)) + " " + Convert.ToString(ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(13).ToString.Trim, False)) + " " + Convert.ToString(ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(14).ToString.Trim, False))
            Next

            '===================================================
            'da.Fill(ds.Tables("Patient_Result_Report"), Session("RegistrationNo"), Session("YearlyNo"), 10)
            da.Fill(ds.Tables("Patient_Result_Report"), Request.QueryString("RegNo"), Request.QueryString("YearlyNo"), Request.QueryString("TGID"), Request.QueryString("Main_ID"), CInt(Request.QueryString("TB_ID")))
            Return ds
        Catch ex As Exception

        End Try
    End Function
End Class
