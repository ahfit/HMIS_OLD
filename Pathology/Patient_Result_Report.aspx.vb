Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing.Printing
Imports System.IO

Partial Class Pathology_Patient_Result_Report_HTML
    Inherits System.Web.UI.Page
    Dim a As String = ConfigurationManager.ConnectionStrings("Admin_Path_ConnStr").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
    Dim ENC As New Encryption
    Dim test_name As String = String.Empty
    Dim crdoc As New ReportDocument


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            Employee_Info()
            DropDownList_TB_ID.DataBind()
            hdnTGId.Value = Request.QueryString("TGID")
            If DropDownList_TB_ID.Visible = True Then
                If String.IsNullOrEmpty(DropDownList_TB_ID.SelectedItem.Text) Then
                    test_name = ""
                Else
                    If Not String.IsNullOrEmpty(Request.QueryString("TBID")) Then
                        DropDownList_TB_ID.SelectedValue = Request.QueryString("TBID")
                    End If
                    test_name = DropDownList_TB_ID.SelectedItem.Text

                End If

            End If
            If DropDownList_TB_ID.SelectedValue = "4089" Or DropDownList_TB_ID.SelectedValue = "4102" Then
                Load_Crystal_Report()
            End If
        End If
        If DropDownList_TB_ID.SelectedValue <> "4089" And DropDownList_TB_ID.SelectedValue <> "4102" Then
            Employee_Info()
            Load_Crystal_Report()
        End If

    End Sub

    Sub Employee_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name from Employee WHERE (Employee.EmpID = @Emp_ID)", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            Dim reader As System.Data.SqlClient.SqlDataReader = mycommand.ExecuteReader()
            If reader.Read = True Then
                Session("emp_Name") = reader.Item(0).ToString

            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Load_Crystal_Report()

        Try


            'Dim sementest As Boolean = False

            'Dim ds_semen_report As New DataSet
            'If CInt(Request.QueryString("TGID")) = 103 Then
            '    Dim ds_check_report As New Pt_Path_Test
            '    Dim da_check_report As New Pt_Path_TestTableAdapters.Patient_Result_ReportTableAdapter
            '    da_check_report.Fill(ds_check_report.Tables("Patient_Result_Report"), Request.QueryString("RegNo"), Request.QueryString("YearlyNo"), Request.QueryString("TGID"), Request.QueryString("Main_Id"))
            '    For i As Integer = 0 To ds_check_report.Tables("Patient_Result_Report").Rows.Count - 1
            '        If ds_check_report.Tables("Patient_Result_Report").Rows(i).Item("TSGName") = "SPERM MOTALITY" Then
            '            sementest = True
            '            Exit For
            '        End If
            '    Next

            'End If
            '''''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''

            Dim ds As DataSet = TestNormalRanges(CInt(Request.QueryString("TGID")))
            Dim path As String = Server.MapPath(ReportName(CInt(Request.QueryString("TGID")), DropDownList_TB_ID.SelectedValue))

            ''''''''''''''''''''''''''
            ''''''''''''''''''''''''
            ''''''''''''''
            'If sementest = True Then

            '    ds_semen_report = Semen_Sub_Report()

            'End If


            If path.Contains("QCodeCovidReport.rdlc") Then

            Else
                crdoc.Load(path)
            End If


            Dim path_admin As New Pathology
            Dim path_admin_table As New PathologyTableAdapters.pro_Test_RangeValuesTableAdapter
            path_admin_table.Fill(path_admin.Tables("pro_Test_RangeValues"), Session("RegistrationNo"), Request.QueryString("TGID"))
            Try
                Dim status_by As String = String.Empty
                If Request.QueryString("status") = "10" Or Request.QueryString("status") = "8" Then
                    status_by = ""
                Else
                    status_by = "<b color=""#E0E0E0"">PREL IMI NARY<br>REPORT</b>"
                    ' status_by = ""
                End If

                For count As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                    For count_sub As Integer = 0 To path_admin.Tables("pro_Test_RangeValues").Rows.Count - 1

                        If ds.Tables("Patient_Result_Report").Rows(count).Item("TCID") = path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("TCId") Then

                            If IsNumeric(ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue")) = True Then
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then

                                        ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") = "<b style='color:Red; font-size: 13pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") + " </b>"

                                    End If
                                Catch ex As Exception
                                    'Response.Write(ex.Message)
                                End Try
                                '===================================
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") <> "" Then
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") = "  [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date") + " ]"
                                    End If
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") = " &nbsp;&nbsp;&nbsp;&nbsp; [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + " ]"
                                    End If
                                Catch ex As Exception

                                End Try


                                '' Previous Value 1
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then
                                        If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                            ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = "<u style='color:BLACK; font-size: 50pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") + "</u>" + "&nbsp;&nbsp;&nbsp;&nbsp; " + " [" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + "  ] "

                                        End If

                                    Else

                                        If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") <> "" Then
                                            ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") + "&nbsp;&nbsp;&nbsp;&nbsp; [ " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1_Date") + " ]  "

                                        End If
                                        'ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1") = Replace(ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result1"), "[]", "")
                                    End If
                                Catch ex As Exception

                                End Try

                                ' Previous Value 2
                                Try
                                    If ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") > path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("EndValue") Or ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") < path_admin.Tables("pro_Test_RangeValues").Rows(count_sub).Item("StartValue") Then

                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") = "<u style='color:BLACK; font-size: 50pt;'>" + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") + "</u>" + "&nbsp;&nbsp;&nbsp;&nbsp; " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date")
                                    Else
                                        ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") = ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2") + "&nbsp;&nbsp;&nbsp;&nbsp; " + ds.Tables("Patient_Result_Report").Rows(count).Item("Previous_Result2_Date")

                                    End If
                                Catch ex As Exception

                                End Try

                            End If
                        End If
                    Next
                    'ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") = ds.Tables("Patient_Result_Report").Rows(count).Item("TCValue") + "  " + ds.Tables("Patient_Result_Report").Rows(count).Item("CompUnits")
                    Try

                        ds.Tables("Patient_Result_Report").Rows(count).Item("Status_by") = status_by

                        ds.Tables("Patient_Result_Report").Rows(count).Item("TC_Range_Unit") = ds.Tables("Patient_Result_Report").Rows(count).Item("TC_Range_Unit")

                    Catch ex As Exception

                    End Try
                Next
            Catch ex As Exception

            End Try


            Try
                If DropDownList_TB_ID.Visible = True Then
                    If String.IsNullOrEmpty(DropDownList_TB_ID.SelectedItem.Text) Then
                        test_name = ""
                    Else


                        test_name = DropDownList_TB_ID.SelectedItem.Text

                    End If
                End If
                If Request.QueryString("TGID") = 12 And InStr(test_name, "Culture", CompareMethod.Text) > 0 Then

                    Dim da_CultureMedicine As New Pt_Path_TestTableAdapters.CultureMedicinesTableAdapter
                    Dim da_CultureResults As New Pt_Path_TestTableAdapters.CultureTestResultsTableAdapter

                    da_CultureMedicine.Fill(ds.Tables("CultureMedicines"), Request.QueryString("Main_Id"), DropDownList_TB_ID.SelectedValue)
                    da_CultureResults.Fill(ds.Tables("CultureTestResults"), Request.QueryString("Main_Id"), DropDownList_TB_ID.SelectedValue)

                    For n As Integer = 0 To ds.Tables("CultureMedicines").Rows.Count - 1
                        ' ds.Tables("CultureMedicines").Rows(n).Item("Organism1") = "love"
                        For q As Integer = 0 To ds.Tables("CultureTestResults").Rows.Count - 1
                            If ds.Tables("CultureMedicines").Rows(n).Item("ComponentName") = ds.Tables("CultureTestResults").Rows(q).Item("ComponentName") Then

                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 1" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism1") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 2" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism2") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 3" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism3") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                                If ds.Tables("CultureTestResults").Rows(q).Item("TestName") = "Sensitivity 4" Then
                                    ds.Tables("CultureMedicines").Rows(n).Item("Organism4") = ds.Tables("CultureTestResults").Rows(q).Item("TCValue")
                                End If
                            End If
                        Next
                    Next
                    crdoc.Database.Tables("CultureMedicines").SetDataSource(ds.Tables("CultureMedicines"))
                End If

            Catch ex As Exception

            End Try

            If path.Contains("QCodeCovidReport.rdlc") Then

                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Pathology/QCodeCovidReport.rdlc")
                ReportViewer1.LocalReport.DataSources.Clear()
                ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet1", ds.Tables("Simple_Basic_Info")))
                ReportViewer1.LocalReport.DataSources.Add(New ReportDataSource("DataSet2", ds.Tables("Patient_Result_Report")))

                AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

                Dim qrCode As String = ds.Tables("Simple_Basic_Info").Rows(0)("QCode")
                ' Dim rpt As New ReportParameter("QRCode", qrCode)


                ReportViewer1.LocalReport.EnableExternalImages = True
                Dim imagePath As String = New Uri(Server.MapPath(qrCode)).AbsoluteUri
                Dim parameter As New ReportParameter("QRCode", imagePath)
                ReportViewer1.LocalReport.SetParameters(parameter)

                ReportViewer1.LocalReport.Refresh()
                ReportViewer1.Visible = True
                Dim fileName As String = String.Empty, root As String = String.Empty
                If Not String.IsNullOrEmpty(Request.QueryString("name")) Then
                    root = Server.MapPath("~\pathology\Patientlabreports\")
                    fileName = Request.QueryString("name").ToString() + ".pdf"
                    'crdoc.ExportToDisk(ExportFormatType.PortableDocFormat, root + fileName)
                    Dim Bytes() As Byte = ReportViewer1.LocalReport.Render("PDF", "", Nothing, Nothing, Nothing, Nothing, Nothing)
                    Using Stream As New FileStream(root + fileName, FileMode.Create)
                        Stream.Write(Bytes, 0, Bytes.Length)
                    End Using

                End If

            Else

                crdoc.Database.Tables("Patient_Result_Report").SetDataSource(ds.Tables("Patient_Result_Report"))
                ' crdoc.Database.Tables("Hospital_Header").SetDataSource(Session("Rpt_Header_DT"))
                crdoc.Database.Tables("Simple_Basic_Info").SetDataSource(ds.Tables("Simple_Basic_Info"))
                If DropDownList_TB_ID.Visible = True Then
                    If String.IsNullOrEmpty(DropDownList_TB_ID.SelectedItem.Text) Then
                        test_name = ""
                    Else
                        test_name = DropDownList_TB_ID.SelectedItem.Text

                    End If
                End If

                crdoc.SetParameterValue(0, DropDownList_Report_Type.SelectedValue)
                CrystalReportViewer1.ReportSource = crdoc


                Dim fileName As String = String.Empty, root As String = String.Empty
                root = Server.MapPath("~\pathology\Patientlabreports\")

                'fileName = Request.QueryString("YearlyNo").ToString() + Request.QueryString("Main_ID") + DropDownList_TB_ID.SelectedValue + ".pdf"

                If Not String.IsNullOrEmpty(Request.QueryString("name")) Then
                    fileName = Request.QueryString("name").ToString() + ".pdf"
                    crdoc.ExportToDisk(ExportFormatType.PortableDocFormat, root + fileName)

                End If

            End If



            'If Request.QueryString("TGID") = 12 And InStr(test_name, "Culture", CompareMethod.Text) > 0 Then

            '    crdoc.Database.Tables("CultureMedicines").SetDataSource(ds.Tables("CultureMedicines"))
            'End If
            ' crdoc.Subreports(1).Database.Tables("Simple_Basic_Info").SetDataSource(ds.Tables("Simple_Basic_Info"))

            'If CInt(Request.QueryString("TGID")) = 103 Then
            '    crdoc.Subreports(1).Database.Tables("Semen").SetDataSource(ds_semen_report.Tables("Semen"))
            'End If
            'crdoc.PrintToPrinter(1, False, 0, 0)
            'Dim printerName As String = GetDefaultPrinter()
            ''Response.Write(printerName)
            'printerName = "Samsung Universal Print Driver 2"

            'PrintReport(printerName, crdoc)


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
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
    Private Function GetDefaultPrinter() As String
        Dim objSettings As New PrinterSettings
        Dim strPrinter As String

        Try
            For Each strPrinter In PrinterSettings.InstalledPrinters
                objSettings.PrinterName = strPrinter
                If objSettings.IsDefaultPrinter Then
                    Return strPrinter
                End If
            Next
            Return "No printer installed!!!"
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Function
    Private Sub PrintReport(ByVal printerName As String, ByVal reportDocument As ReportDocument)
        Dim margins As PageMargins

        ' Get the PageMargins structure and set the 
        ' margins for the report.
        margins = reportDocument.PrintOptions.PageMargins
        margins.bottomMargin = 350
        margins.leftMargin = 350
        margins.rightMargin = 350
        margins.topMargin = 350
        ' Apply the page margins.DropDownList_TB_ID
        reportDocument.PrintOptions.ApplyPageMargins(margins)

        ' Select the printer.
        reportDocument.PrintOptions.PrinterName = printerName

        ' Print the report. Set the startPageN and endPageN
        ' parameters to 0 to print all pages.
        reportDocument.PrintToPrinter(1, False, 0, 0)
    End Sub
    Function Semen_Sub_Report() As DataSet

        Dim ds_semen As New Pt_Path_Test
        Dim da As New Pt_Path_TestTableAdapters.SemenTableAdapter
        da.Fill(ds_semen.Tables("Semen"), Request.QueryString("RegNo"), Request.QueryString("YearlyNo"))
        For i As Integer = 0 To ds_semen.Tables("Semen").Rows.Count - 1
            Dim comName As String = ds_semen.Tables("Semen").Rows(i).Item("ComponentName").ToString
            If comName.Contains("Active") Then
                If ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "Immediate" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Active") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 30 Minutes" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Active") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 6 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Active") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 12 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Active") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                End If
            ElseIf comName.Contains("Immotile") Then
                If ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "Immediate" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Immotile") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 30 Minutes" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Immotile") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 6 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Immotile") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 12 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Immotile") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                End If
            ElseIf comName.Contains("Sluggish") Then
                If ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "Immediate" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Sluggish") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 30 Minutes" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Sluggish") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 6 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Sluggish") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 12 Hours" Then
                    ds_semen.Tables("Semen").Rows(i).Item("Sluggish") = ds_semen.Tables("Semen").Rows(i).Item("TCValue")
                End If
            End If
        Next

        For i As Integer = 0 To ds_semen.Tables("Semen").Rows.Count - 1
            Try


                Dim comName As String = ds_semen.Tables("Semen").Rows(i).Item("ComponentName").ToString
                If ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "Immediate" Then
                    If comName.Contains("Active") Then
                        Dim Active As String = ds_semen.Tables("Semen").Rows(i).Item("Active").ToString
                        For j As Integer = i To i + 2
                            ds_semen.Tables("Semen").Rows(j).Item("Active") = Active
                        Next
                    ElseIf comName.Contains("Sluggish") Then
                        Dim Sluggish As String = ds_semen.Tables("Semen").Rows(i).Item("Sluggish").ToString
                        For j As Integer = i - 1 To i + 1
                            ds_semen.Tables("Semen").Rows(j).Item("Sluggish") = Sluggish
                        Next
                    ElseIf comName.Contains("Immotile") Then
                        Dim Immotile As String = ds_semen.Tables("Semen").Rows(i).Item("Immotile").ToString
                        For j As Integer = i - 2 To i
                            ds_semen.Tables("Semen").Rows(j).Item("Immotile") = Immotile
                        Next
                    End If
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 30 Minutes" Then
                    If comName.Contains("Active") Then
                        Dim Active As String = ds_semen.Tables("Semen").Rows(i).Item("Active").ToString
                        For j As Integer = i To i + 2
                            ds_semen.Tables("Semen").Rows(j).Item("Active") = Active
                        Next
                    ElseIf comName.Contains("Sluggish") Then
                        Dim Sluggish As String = ds_semen.Tables("Semen").Rows(i).Item("Sluggish").ToString
                        For j As Integer = i - 1 To i + 1
                            ds_semen.Tables("Semen").Rows(j).Item("Sluggish") = Sluggish
                        Next
                    ElseIf comName.Contains("Immotile") Then
                        Dim Immotile As String = ds_semen.Tables("Semen").Rows(i).Item("Immotile").ToString
                        For j As Integer = i - 2 To i
                            ds_semen.Tables("Semen").Rows(j).Item("Immotile") = Immotile
                        Next
                    End If
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 6 Hours" Then
                    If comName.Contains("Active") Then
                        Dim Active As String = ds_semen.Tables("Semen").Rows(i).Item("Active").ToString
                        For j As Integer = i To i + 2
                            ds_semen.Tables("Semen").Rows(j).Item("Active") = Active
                        Next
                    ElseIf comName.Contains("Sluggish") Then
                        Dim Sluggish As String = ds_semen.Tables("Semen").Rows(i).Item("Sluggish").ToString
                        For j As Integer = i - 1 To i + 1
                            ds_semen.Tables("Semen").Rows(j).Item("Sluggish") = Sluggish
                        Next
                    ElseIf comName.Contains("Immotile") Then
                        Dim Immotile As String = ds_semen.Tables("Semen").Rows(i).Item("Immotile").ToString
                        For j As Integer = i - 2 To i
                            ds_semen.Tables("Semen").Rows(j).Item("Immotile") = Immotile
                        Next
                    End If
                ElseIf ds_semen.Tables("Semen").Rows(i).Item("TestName").ToString = "After 12 Hours" Then
                    If comName.Contains("Active") Then
                        Dim Active As String = ds_semen.Tables("Semen").Rows(i).Item("Active").ToString
                        For j As Integer = i To i + 2
                            ds_semen.Tables("Semen").Rows(j).Item("Active") = Active
                        Next
                    ElseIf comName.Contains("Sluggish") Then
                        Dim Sluggish As String = ds_semen.Tables("Semen").Rows(i).Item("Sluggish").ToString
                        For j As Integer = i - 1 To i + 1
                            ds_semen.Tables("Semen").Rows(j).Item("Sluggish") = Sluggish
                        Next
                    ElseIf comName.Contains("Immotile") Then
                        Dim Immotile As String = ds_semen.Tables("Semen").Rows(i).Item("Immotile").ToString
                        For j As Integer = i - 2 To i
                            ds_semen.Tables("Semen").Rows(j).Item("Immotile") = Immotile
                        Next
                    End If
                End If
            Catch ex As Exception

            End Try
        Next
        Return ds_semen
    End Function
    Function Pt_Dataset_Fill() As DataSet
        Dim ds As New Pt_Path_Test
        Dim x, z, y As Integer
        Dim da As New Pt_Path_TestTableAdapters.Patient_Result_ReportTableAdapter
        Dim da_PreviousResults As New Pt_Path_TestTableAdapters.Patient_LabResult_PreviousTableAdapter

        Dim TGID As Integer = Request.QueryString("TGID")
        Dim Regno As String = Request.QueryString("RegNo")
        Dim Main_ID As Integer = Request.QueryString("Main_ID")
        Dim Sample_No As String = Request.QueryString("Sample_No")
        Dim Status As Integer = Request.QueryString("Status")
        Dim YearlyNo As Integer = Request.QueryString("YearlyNo")
        Dim TB_ID As Integer = 0
        If Not String.IsNullOrEmpty(DropDownList_TB_ID.SelectedValue) Then
            TB_ID = DropDownList_TB_ID.SelectedValue
        End If
        Dim IS_Group As Integer = RBL_group.SelectedValue

        '========================= Basic Data Info =========
        Dim da_Basic_Info As New Pt_Path_TestTableAdapters.Simple_Basic_InfoTableAdapter
        'da_Basic_Info.FillBy(ds.Tables("Simple_Basic_Info"), Request.QueryString("RegNo"), Request.QueryString("Main_ID"), Request.QueryString("Sample_No"))
        da_Basic_Info.FillBy_SampleNo(ds.Tables("Simple_Basic_Info"), Regno, Main_ID, Sample_No)

        For i As Integer = 0 To ds.Tables("Simple_Basic_Info").Rows.Count - 1
            If Status <= 6 Then
                ds.Tables("Simple_Basic_Info").Rows(i).Item("PFName") = ""
                ds.Tables("Simple_Basic_Info").Rows(i).Item("PMName") = ""
                ds.Tables("Simple_Basic_Info").Rows(i).Item("PLName") = ""
                ds.Tables("Simple_Basic_Info").Rows(i).Item("StreetAddress") = ""
            Else


                Dim first_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PFName"), False)
                Dim second_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PMName"), False)
                Dim third_name As String = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item("PLName"), False)
                ds.Tables("Simple_Basic_Info").Rows(i).Item("StreetAddress") = "Note: This is computer generated report duly verified by a pathologist,therefore signatures are not required."
                Dim Pre As String = ds.Tables("Simple_Basic_Info").Rows(i).Item("Prefix")



                ds.Tables("Simple_Basic_Info").Rows(i).Item(0) = ENC.Encrypt_Main(ds.Tables("Simple_Basic_Info").Rows(i).Item(0), False)
                ' ds.Tables("Simple_Basic_Info").Rows(i).Item(1) = Pre + " " + first_name + " " + second_name + " " + third_name
            End If
        Next

        '========================== Result Report  =========

        Dim name As String = ""

        If TGID = 12 Then
            'And 
            If InStr(DropDownList_TB_ID.SelectedItem.Text, "Culture", CompareMethod.Text) > 0 Then
                da.FillBy_Cult(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, TB_ID, Status, Sample_No)
            Else
                da.FillBy_TBNameSubGroup(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, Sample_No, TB_ID, Status)

                For n As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                    If ds.Tables("Patient_Result_Report").Rows(n).Item("TestName").ToString = "Specimen" Then
                        ds.Tables("Patient_Result_Report").Rows(n).Item("TSGName") = ""
                        ds.Tables("Patient_Result_Report").Rows(n).Item("TestName") = "<b>" + ds.Tables("Patient_Result_Report").Rows(n).Item("TestName") + "</b>"


                    End If
                Next
            End If


            'DropDownList_TB_ID.Visible = True

        ElseIf TGID = 98 Or TGID = 94 Or TGID = 122 Or TGID = 124 Or TGID = 123 Or TGID = 125 Or TGID = 10 Then
            da.FillBy_AllBookingServices(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, Sample_No, Status, TB_ID, IS_Group)

        ElseIf TGID = 116 Or TGID = 120 Or TGID = 121 Then
            da.FillBy_Haem_Other(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, Sample_No, Status, TB_ID, IS_Group)

        ElseIf Request.QueryString("TGID") = 126 Then
            da.FillBy_TBNameSubGroup(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, Sample_No, TB_ID, Status)
            ' DropDownList_TB_ID.Visible = True
        Else
            da.FillBy_TestBooking(ds.Tables("Patient_Result_Report"), Regno, YearlyNo, TGID, Main_ID, Sample_No, TB_ID, Status)
            ' DropDownList_TB_ID.Visible = True

        End If

        If Status <= 6 Then

            If ds.Tables("Patient_Result_Report").Rows.Count > 0 Then
                ds.Tables("Simple_Basic_Info").Rows(0).Item("PFName") = ds.Tables("Patient_Result_Report").Rows(0).Item("EFName") + " " + ds.Tables("Patient_Result_Report").Rows(0).Item("EMName") + " " + ds.Tables("Patient_Result_Report").Rows(0).Item("ELName")
                ds.Tables("Simple_Basic_Info").Rows(0).Item("PMName") = "Technologist"
                ds.Tables("Simple_Basic_Info").Rows(0).Item("PLName") = ""

            End If

        End If
        'ds.Tables("Simple_Basic_Info").Rows(0).Item("StreetAddress") = ds.Tables("Simple_Basic_Info").Rows(0).Item("StreetAddress").ToString() + "_ " + DateTime.Now.ToString() + "_" + Session("emp_name")
        ds.Tables("Patient_Result_Report").Rows(0).Item("Referred_by") = "Print by: " + Session("emp_name") + "   " + "DateTime: " + DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt")
        'Dim bed As Integer = 0
        'If Request.QueryString("TGID") = 101 Then
        '    For n As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
        '        If ds.Tables("Patient_Result_Report").Rows(n).Item("TestName").ToString = "Specimen" Then
        '            ds.Tables("Simple_Basic_Info").Rows(0).Item("ReferFrom") = ds.Tables("Patient_Result_Report").Rows(n).Item("TCValue").ToString
        '            ds.Tables("Patient_Result_Report").Rows(n).Item("TestName") = ""
        '            ds.Tables("Patient_Result_Report").Rows(n).Item("TCValue") = ""
        '        End If
        '    Next
        '    bed = InStr(ds.Tables("Simple_Basic_Info").Rows(0).Item("Patient_Type"), "/", CompareMethod.Text)
        '    ds.Tables("Simple_Basic_Info").Rows(0).Item("StreetAddress") = Right(ds.Tables("Simple_Basic_Info").Rows(0).Item("Patient_Type"), Len(ds.Tables("Simple_Basic_Info").Rows(0).Item("Patient_Type")) - bed)
        '    Dim L_Size As Integer = 0
        '    If bed > 0 Then
        '        L_Size = bed - 1
        '    End If


        '    ds.Tables("Simple_Basic_Info").Rows(0).Item("Patient_Type") = Left(ds.Tables("Simple_Basic_Info").Rows(0).Item("Patient_Type"), L_Size)
        'End If

        '=====================================================




        ' ============by New Code========================
        Dim ResultNo As Integer = 0
        Dim strDate1 As String = ""
        Dim strDate2 As String = ""

        da_PreviousResults.Fill(ds.Tables("Patient_LabResult_Previous"), Request.QueryString("RegNo"), Request.QueryString("TGID"), Request.QueryString("Main_Id"))
        For m As Integer = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
            ResultNo = 0
            For n As Integer = 0 To ds.Tables("Patient_LabResult_Previous").Rows.Count - 1
                If ds.Tables("Patient_Result_Report").Rows(m).Item("TCid").ToString = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCid").ToString Then



                    If ResultNo = 0 Then
                        '  ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")

                        Try
                            ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                            ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("Date_Time").ToString

                            If m < 1 Then
                                'Response.Write(ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1").ToString)
                                ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                                ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("Date_Time").ToString
                                strDate1 = ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date")
                                ' Response.Write(ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1").ToString)

                            Else
                                If ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date").ToString = strDate1 Then
                                    ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date") = "" 'ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue").ToString
                                    ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                                Else
                                    strDate1 = ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date")

                                End If
                                ' ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1_Date")

                            End If
                        Catch ex As Exception

                        End Try

                        ResultNo = ResultNo + 1

                    ElseIf ResultNo = 1 Then

                        Try
                            ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                            ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("Date_Time").ToString

                            If m < 1 Then
                                'Response.Write(ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result1").ToString)

                                ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                                ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("Date_Time").ToString
                                strDate2 = ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date")

                            Else
                                If ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date").ToString = strDate2 Then
                                    ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date") = "" 'ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue").ToString
                                    ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2") = ds.Tables("Patient_LabResult_Previous").Rows(n).Item("TCValue")
                                Else
                                    strDate2 = ds.Tables("Patient_Result_Report").Rows(m).Item("Previous_Result2_Date")

                                End If
                            End If
                        Catch ex As Exception

                        End Try

                        ResultNo = ResultNo + 1

                    End If

                End If
            Next
        Next
        z = 0

        Return ds

    End Function

    Function TestNormalRanges(ByVal tgid As Integer) As DataSet
        Dim x, y As Integer
        Dim ds As DataSet = Pt_Dataset_Fill()
        'Dim TB_IDs As String = get_distinct_TB_ID()

        Dim mycommand As SqlCommand = New SqlCommand("SELECT TestReference_values.Possible_Result, TestReference_values.Extra_Comments, TestReference_values.TCID, TestReference_values.ValueStart,TestReference_values.ValueEnd FROM TestReference_values INNER JOIN TestComponent ON TestReference_values.TCID = TestComponent.TCID WHERE     (TestComponent.TGID = @TGID)", con)
        mycommand.CommandType = CommandType.Text
        mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID")) 'HiddenFieldRegNo.Value)
        con.Open()
        Dim ds1 As New DataSet
        Dim sreader As New SqlDataAdapter
        sreader.SelectCommand = mycommand
        sreader.Fill(ds1)
        If ds1.Tables(0).Rows.Count <> 0 Then
            For x = 0 To ds.Tables("Patient_Result_Report").Rows.Count - 1
                For y = 0 To ds1.Tables(0).Rows.Count - 1
                    If ds1.Tables(0).Rows(y).Item("TCID").ToString() = ds.Tables("Patient_Result_Report").Rows(x).Item("TCID").ToString Then
                        If (CDec(ds.Tables("Patient_Result_Report").Rows(x).Item("TCValue")) >= ds1.Tables(0).Rows(y).Item("ValueStart")) And CDec(ds.Tables("Patient_Result_Report").Rows(x).Item("TCValue")) <= ds1.Tables(0).Rows(y).Item("ValueEnd") Then
                            ds.Tables("Patient_Result_Report").Rows(x).Item("Normal_Range") = ds1.Tables(0).Rows(y).Item("Possible_Result").ToString()
                            Exit For
                        End If
                    End If
                Next
            Next
        End If
        con.Close()
        Return ds
    End Function
    Function ReportName(ByVal tgid As Integer, ByVal tsgid As Integer) As String
        ReportName = String.Empty
        'Dim x As Integer = 0
        'Dim mycommand As SqlCommand = New SqlCommand("SELECT rpt_name FROM test_reports WHERE (test_reports.TGID = @TGID) and (test_reports.tb_id = @TSGID)", con)
        'mycommand.CommandType = CommandType.Text
        'mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID")) p'HiddenFieldRegNo.Value)
        'mycommand.Parameters.AddWithValue("@TSGID", tsgid)
        'con.Open()
        'Dim ds1 As New DataSet
        'Dim sreader As New SqlDataAdapter
        'sreader.SelectCommand = mycommand
        'sreader.Fill(ds1)
        If tsgid = "4089" Or tsgid = "4102" Then
            Try
                ReportName = "Result_Reports\QCodeCovidReport.rdlc"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        ElseIf tgid = 98 Then



            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

            If InStr(DropDownList_TB_ID.SelectedItem.Text, "Stone", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwise_Stone.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If



        ElseIf tgid = 123 Or tgid = 124 Or tgid = 125 Or tgid = 122 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        ElseIf tgid = 10 Then
            If InStr(DropDownList_TB_ID.SelectedItem.Text, "Cross", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem_Cross_Match_Report.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            Else

                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If

        ElseIf tgid = 116 Or tgid = 120 Or tgid = 121 Or tgid = 129 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseHaem_Other.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        ElseIf tgid = 12 Then
            If InStr(DropDownList_TB_ID.SelectedItem.Text, "Culture", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Cult.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "SEMEN", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwise_Semen.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Stain", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_SN_Stain.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Milk", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Milk.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Fungal", CompareMethod.Text) > 0 Then
                Try

                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Fungal.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Fluid", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Fluid.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Routine", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology_Routine.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            ElseIf InStr(DropDownList_TB_ID.SelectedItem.Text, "Stool For Clostridium", CompareMethod.Text) > 0 Then
                Try
                    ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Stool_Clostridium.rpt"
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try

            Else
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_Microbiology.rpt"

            End If
        ElseIf tgid = 12 And DropDownList_TB_ID.SelectedValue = 1097 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        ElseIf tgid = 94 Then

            ReportName = "Result_Reports\Patient_Result_Report_TBwise_Serology.rpt"
        ElseIf tgid = 115 Then

            ReportName = "Result_Reports\Patient_Result_Report_TBwiseBoneMarrow.rpt"

        ElseIf tgid = 101 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseHisto.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        ElseIf tgid = 126 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup_PCR.rpt"
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try


        ElseIf tgid = 112 Then
            Try
                ReportName = "Result_Reports\Patient_Result_Report_Culture.rpt"
            Catch ex As Exception
                Response.Write(ex.Message & " jkjk kjk ")
            End Try

        Else
            Try

                Dim mycommand As SqlCommand = New SqlCommand("SELECT rpt_name FROM test_reports WHERE (test_reports.TGID = @TGID) and (test_reports.tb_id = @TSGID)", con)
                mycommand.CommandType = CommandType.Text
                mycommand.Parameters.AddWithValue("@TGID", Request.QueryString("TGID")) 'HiddenFieldRegNo.Value)
                mycommand.Parameters.AddWithValue("@TSGID", tsgid)
                con.Open()
                Dim ds1 As New DataSet
                Dim sreader As New SqlDataAdapter

                Try
                    sreader.SelectCommand = mycommand
                    sreader.Fill(ds1)


                Catch ex As Exception

                End Try
                con.Close()
                If ds1.Tables(0).Rows.Count > 0 Then
                    ReportName = ds1.Tables(0).Rows(0).Item(0).ToString
                Else
                    If DropDownList_rpt_type.SelectedValue = "Group Wise" Then
                        ReportName = "Result_Reports\Patient_Result_Report_Group_Wise.rpt"
                    ElseIf DropDownList_rpt_type.SelectedValue = "Sub Group Wise" Then
                        ReportName = "Result_Reports\Patient_Result_Report.rpt"
                    ElseIf DropDownList_rpt_type.SelectedValue = "SGSW" Then
                        ReportName = "Result_Reports\Patient_Result_Report_TBwiseSubGroup.rpt"

                    Else
                        ReportName = "Result_Reports\Patient_Result_Report_TBwise.rpt"
                    End If
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If

        Return ReportName

    End Function



    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_rpt_type.SelectedIndexChanged
        'If DropDownList_rpt_type.SelectedValue = "Service Wise" Or DropDownList_rpt_type.SelectedValue = "SGSW" Then
        '    Label_TB.Visible = True
        '    DropDownList_TB_ID.Visible = True

        'Else
        '    Label_TB.Visible = False
        '    DropDownList_TB_ID.Visible = False

        'End If
    End Sub

    Sub get_msg()
        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        command = connection.CreateCommand
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
        command.CommandText = "SELECT     COUNT(RegNo) AS RegNo         FROM Patient_Services WHERE     (RegNo ='" + Request.QueryString("RegNo").ToString + "') AND (YearlyNo = " + Request.QueryString("YearlyNo").ToString + ") AND (Payment_Status = 0) and Order_Id=" + Request.QueryString("Main_ID").ToString
        connection.Open()
        Dim da As Integer
        da = command.ExecuteScalar
        If da > 0 Then
            Label_error.Text = "Payment Due"
        Else
            Label_error.Text = ""
        End If
        connection.Close()
    End Sub

    'Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBox1.CheckedChanged
    '    CrystalReportViewer1.DisplayToolbar = CheckBox1.Checked

    'End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBL_group.SelectedIndexChanged

    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        crdoc.Close()
    End Sub
    Protected Sub Set_header()
        RBL_group.SelectedValue = 1
        RBL_group.Enabled = False
    End Sub

    'Protected Function get_distinct_TB_ID() As String
    '    Dim TB_ID As String
    '    Dim statement As String = "SELECT DISTINCT Test_Booking.TB_ID FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no =" + Request.QueryString("RegNo") + " AND (Path_Result_Delivery.Yearly_No =  " + Request.QueryString("@YearlyNo") + " AND (Path_Result_Delivery.Main_ID = " + Request.QueryString("@Main_ID") + " AND (Test_Booking_Services.Status =" + Request.QueryString("@Status")
    '    Dim mycommand As New SqlCommand(statement, con)
    '    con.Open()
    '    Dim reader As SqlDataReader = mycommand.ExecuteReader
    '    If reader.HasRows Then
    '        While reader.Read()
    '            If InStr(TB_ID, reader.Item("TB_ID"), CompareMethod.Text) <= 0 Then

    '                If String.IsNullOrEmpty(TB_ID) Then
    '                    TB_ID = reader.Item("TB_ID")
    '                Else
    '                    TB_ID = TB_ID + "," + reader.Item("TB_ID")
    '                End If

    '            End If

    '        End While
    '    End If
    '    Return TB_ID
    'End Function

    Protected Sub DropDownList_TB_ID_SelectedIndexChanged(sender As Object, e As EventArgs)
        Load_Crystal_Report()
    End Sub
End Class
