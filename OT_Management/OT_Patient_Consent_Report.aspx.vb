Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared

Partial Class OT_Patient_Consent_Report
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim ds As New OT_Reports
    Dim da As New OT_ReportsTableAdapters.OT_Consent_ReportTableAdapter
    Dim crdoc As New ReportDocument
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
	
	 Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
	
        'CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = 123456
        'HiddenFieldRegNo.Value = Request.QueryString(0)
        'HiddenFieldPayid.Value = Request.QueryString(1)
        loadreport()
    End Sub
    Sub loadreport()
        'da.Fill(ds.Tables("OT_Consent_Report"), Session("registrationNo"), Session("YearlyNo"))
        da.Fill(ds.Tables("OT_Consent_Report"), "281030204029036092036085050036036099036036036050", 512975)
        For i As Integer = 0 To ds.Tables("OT_Consent_Report").Rows.Count - 1

            ds.Tables("OT_Consent_Report").Rows(i).Item("PatientName") = ds.Tables("OT_Consent_Report").Rows(i).Item("Prefix").ToString + " " + ENC.Encrypt_Main(ds.Tables("OT_Consent_Report").Rows(i).Item("PFName"), False).ToString + " " + ENC.Encrypt_Main(ds.Tables("OT_Consent_Report").Rows(i).Item("PMName"), False).ToString + " " + ENC.Encrypt_Main(ds.Tables("OT_Consent_Report").Rows(i).Item("PLName"), False).ToString
            ds.Tables("OT_Consent_Report").Rows(i).Item("RegNo") = ENC.Encrypt_Main(ds.Tables("OT_Consent_Report").Rows(i).Item("RegNo"), False)
        Next
        crdoc.FileName = Server.MapPath("OT_Consent_Report.rpt")
        crdoc.Database.Tables("OT_Consent_Report").SetDataSource(ds.Tables("OT_Consent_Report"))
        CrystalReportViewer1.ReportSource = crdoc
        CrystalReportViewer1.DataBind()

    End Sub
End Class
