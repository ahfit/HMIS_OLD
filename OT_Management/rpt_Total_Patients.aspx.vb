
Partial Class Radiology_rpt_Total_Patients
    Inherits System.Web.UI.Page

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        Dim i As Integer = 0
        Dim total_Adv As Long = 0
        Dim total_Bill As Long = 0
        Dim YearlyNo As Long = 0
        Dim Hospital_Id As Long = 0
        Dim PatientType_Id As Long = 0
        Dim RegNo As String = "%"
        Hospital_Id = DropDownList_Hospital_Id.SelectedValue
       
        Hospital_Id = DropDownList_Hospital_Id.SelectedValue
        'PatientType_Id = DropDownList_Pt_Type.SelectedValue
        'If TextBox_MRNO.Text <> "" Then
        '    RegNo = ENC.Encrypt_Main(TextBox_MRNO.Text, True)
        'End If
        'Try
        '    If TextBox_VisitNo.Text <> "" Then
        '        YearlyNo = CLng(TextBox_VisitNo.Text)
        '    End If
        'Catch ex As Exception

        'End Try


        '=============================
        Dim ds As New Radiology
        Dim da As New RadiologyTableAdapters.usp_Radiology_Patient_SummaryTableAdapter
        da.Fill(ds.Tables("usp_Radiology_Patient_Summary"), DropDownList_Month.SelectedValue, DropDownList_Year.SelectedValue, DropDownList_Hospital_Id.SelectedValue, DropDownList_TGID.SelectedValue)

        Dim path As String = Server.MapPath("Radiology_TotalPatient_Report.rdlc")

        ReportViewer_radiologyPatient.LocalReport.DataSources.Clear()
        ReportViewer_radiologyPatient.LocalReport.ReportPath = path
        ReportViewer_radiologyPatient.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("Radiology_Total_Patients", ds.Tables("usp_Radiology_Patient_Summary")))
        ReportViewer_radiologyPatient.LocalReport.Refresh()
    End Sub

End Class
