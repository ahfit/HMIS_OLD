
Partial Class TestFeeReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            HiddenFieldRegNo.Value = Session("RegistrationNo")
            HiddenFieldYearlyNo.Value = Session("YearlyNo")
            'HiddenFieldPatientName.Value = "df dsfsd fsdf sd" ' Session("PatientName")
            HiddenFieldPatientName.Value = Session("PatientName")
            'Response.Write(HiddenFieldPatientName.Value)
            'Response.Write(HiddenFieldRegNo.Value & " fsdfdfjkfsdj " & HiddenFieldYearlyNo.Value)
            CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
            'CrystalReportViewer1.reportdocument.printoptions.papersize = crystaldecicions.shared.papersize.defaultpapersize()
            CrystalReportSource2.ReportDocument.PrintOptions.PaperSize = CrystalDecisions.Shared.PaperSize.DefaultPaperSize
            CrystalReportViewer1.Visible = True
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
