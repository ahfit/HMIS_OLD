
Partial Class MriReport
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        HiddenFieldRegistrationNo.Value = Session("reg_no")
        HiddenFieldYearlyNo.Value = Session("payId") 'Session("BMIPayID")
        HiddenFieldTestId.Value = Session("RID")
        HiddenFieldRadiologyId.Value = Session("PRadiologyID")
        'Response.Write(Session("RID"))
        'Response.Write(Session("PRadiologyID"))
        'Response.Write(Session("reg_no") + "r ")
        'Response.Write(Session("payId") + "p ")
        'Response.Write(Session("RID") + "welcome")
        'Response.Write(Session("PRadiologyID") + "radiology ")
        CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        'Response.Write(HiddenFieldRegistrationNo.Value + HiddenFieldYearlyNo.Value + HiddenFieldTestId.Value)
        'CrystalReportSource1.Report.Parameters.Item(0).DefaultValue = Session("registrationNo")
        'CrystalReportSource1.Report.Parameters.Item(1).DefaultValue = Session("YearlyNo")
        'CrystalReportViewer1.RefreshReport()
    End Sub
End Class
