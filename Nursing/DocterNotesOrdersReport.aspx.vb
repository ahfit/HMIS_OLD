Imports System.Data

Partial Class Nursing_DocterNotesOrdersReport
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim obj_menu As New JavaScriptMenu
            obj_menu.loginvalidate()
            LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            
            hdfReg_NO.Value = Session("RegistrationNo")
            hdfYearlyNum.Value = Session("YearlyNo")
            LoadReport()
        End If
    End Sub

    Public Sub subReports(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = CType(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub LoadReport()
        Dim dv1 As DataView = TryCast(sdsDoctorOrdersNotes.[Select](DataSourceSelectArguments.Empty), DataView)
        Dim dt1 As DataTable = dv1.Table
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet.Copy())
        ReportViewer1.LocalReport.DataSources.Clear()
        ReportViewer1.ProcessingMode = ProcessingMode.Local
        Dim reportPath As String = Server.MapPath("~/Nursing/DocterNotesOrdersReport.rdlc")
        ReportViewer1.LocalReport.ReportPath = reportPath
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt1))
        AddHandler ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        ReportViewer1.LocalReport.Refresh()
    End Sub
End Class
