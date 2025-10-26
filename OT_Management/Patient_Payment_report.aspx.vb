Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Patient_Payment_report
    Inherits System.Web.UI.Page

    Dim Patient_Type As String = ""
    Dim Total_Price As Integer = 0
    Dim Total_Discount As Integer = 0
    Dim Final_Price As Integer = 0
    Dim ENC As New Encryption
    Dim RegNo As String = ""
    Dim YearlyNo As Integer = 0

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim RegNo As String = Session("RegistrationNo")
        Dim YearlyNo As Integer = Session("YearlyNo")
        Dim Main_Id As Integer = Request.QueryString("Main_ID")
        '===========================  dataset for sub report (patient test and price information ) =========
        Dim da_Basic_Detail As New Pt_Radiology_TestTableAdapters.Pt_Test_TemplateTableAdapter
        Dim ds_Basic_Detail As New Pt_Radiology_Test
        da_Basic_Detail.Fill(ds_Basic_Detail.Tables("Pt_Test_Template"), YearlyNo, RegNo, Main_Id)
        '===========================  dataset for Discount (patient Discount information ) =================
        Dim da_Discount As New Pt_Radiology_TestTableAdapters.Pt_DiscountTableAdapter
        Dim ds_Discount As New Pt_Radiology_Test
        da_Discount.Fill(ds_Discount.Tables("Pt_Discount"), RegNo, YearlyNo, Main_Id)
        '=========================== dataset for the  main report (get the patient basic info)==============
        Dim da_Basic As New Pt_Radiology_TestTableAdapters.Pt_Basic_DataTableAdapter
        Dim ds_Basic As New Pt_Radiology_Test
        da_Basic.Fill(ds_Basic.Tables("Pt_Basic_Data"), RegNo, YearlyNo)
        Patient_Type = ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("Patient_Type")
        ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("PATIENTNAME") = ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("Prefix") & ENC.Encrypt_Main(ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("PFName"), False) & " " & ENC.Encrypt_Main(ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("PMNAme"), False)
        '===========================  for diffreentiate free and opd patient ===============================
        If (Patient_Type <> "OPD") Then
            For i As Integer = 0 To ds_Basic_Detail.Tables("Pt_Test_Template").Rows.Count - 1
                ds_Basic_Detail.Tables("Pt_Test_Template").Rows(i).Item("Price") = 0
                Total_Price = Total_Price + ds_Basic_Detail.Tables("Pt_Test_Template").Rows(i).Item("Price")
            Next

        Else
            For i As Integer = 0 To ds_Basic_Detail.Tables("Pt_Test_Template").Rows.Count - 1
                Total_Price = Total_Price + ds_Basic_Detail.Tables("Pt_Test_Template").Rows(i).Item("Price")
            Next
            If CInt(ds_Discount.Tables("Pt_Discount").Rows.Count > 0) Then
                Total_Discount = ds_Discount.Tables("Pt_Discount").Rows(0).Item("TOtal_Discount")
            Else
                Total_Discount = 0
            End If
        End If
            '======================= set the final price of the patient ====================================
            ds_Basic_Detail.Tables("Pt_Test_Template").Rows(ds_Basic_Detail.Tables("Pt_Test_Template").Rows.Count - 1).Item("Total_Price") = Total_Price
            ds_Basic_Detail.Tables("Pt_Test_Template").Rows(ds_Basic_Detail.Tables("Pt_Test_Template").Rows.Count - 1).Item("Discount") = Total_Discount
            ds_Basic_Detail.Tables("Pt_Test_Template").Rows(ds_Basic_Detail.Tables("Pt_Test_Template").Rows.Count - 1).Item("Final_Price") = Total_Price - Total_Discount

            '===========================  create report object =================================================
        Dim crdoc As New ReportDocument
            Dim ds As DataSet = ds_Basic
            Dim ds_detail As DataSet = ds_Basic_Detail
            Dim path As String = Server.MapPath("Pt_Payment_Report.rpt")

        crdoc.Load(path)


            '=========================== Give the two dataset in the report ====================================

        crdoc.Database.Tables("Pt_Basic_Data").SetDataSource(ds.Tables("Pt_Basic_Data"))
            crdoc.Database.Tables("Pt_Test_Template").SetDataSource(ds_detail.Tables("Pt_Test_Template"))
        crdoc.PrintOptions.PaperSize = PaperSize.DefaultPaperSize
        CrystalReportViewer1.ReportSource = crdoc

    End Sub

End Class
