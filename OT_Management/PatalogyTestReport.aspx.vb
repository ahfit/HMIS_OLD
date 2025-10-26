
Partial Class PatalogyTestReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            HiddenFieldRegistrationNo.Value = Session("registrationNo")
            HiddenFieldYearlyNo.Value = Session("YearlyNo")
            CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
            'response.write(Session("registrationNo"))
            'response.write(Session("YearlyNo"))
            'CrystalReportSource1.Report.Parameters.Item(0).DefaultValue = Session("registrationNo")
            'CrystalReportSource1.Report.Parameters.Item(1).DefaultValue = Session("YearlyNo")
            CrystalReportViewer1.RefreshReport()
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub
End Class
