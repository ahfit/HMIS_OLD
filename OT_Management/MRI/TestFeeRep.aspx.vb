
Partial Class TestFeeRep
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        'CrystalReportSource1.Report.Parameters.Item(0).DefaultValue = Session("registrationNo")
        'CrystalReportSource1.Report.Parameters.Item(1).DefaultValue = Session("YearlyNo")
        HiddenField_Reg.value = Session("registrationNo")
        HiddenField_Yearly.Value = Session("YearlyNo")
        HiddenFieldMainId.Value = Session("Main_ID")
        'Response.Write(HiddenField_Reg.Value + "  " + HiddenField_Yearly.Value + " " + HiddenFieldMainId.Value)
        'CrystalReportViewer1.RefreshReport()
    End Sub
End Class
