Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports Microsoft.ReportingServices

Partial Class PayRoll_IncomeTaxReport
    Inherits System.Web.UI.Page


    ' ========================================================================================================================================================================
    '                                                   User Defined Function
    ' ========================================================================================================================================================================


    Private Sub LoadYearsList()

        For i As Integer = 2010 To 2050
            ddlYear.Items.Add(i)
        Next

        ddlYear.SelectedValue = DateTime.Now.Year.ToString()

        ddlMonth.DataBind()
        ddlMonth.SelectedValue = DateTime.Now.Month.ToString()


    End Sub

    Private Sub AssignReportParameters()
        Try
            Dim repParams(7) As ReportParameter
            repParams(0) = New ReportParameter("Year", ddlYear.SelectedValue)
            repParams(1) = New ReportParameter("Month", ddlMonth.SelectedItem.Text)
            repParams(2) = New ReportParameter("AccountHead", "Income Tax")
            repParams(3) = New ReportParameter("Designation", ddlDesign.SelectedItem.Text)
            repParams(4) = New ReportParameter("Department", ddlDepartment.SelectedItem.Text)
            repParams(5) = New ReportParameter("Employee", ddlEmployee.SelectedItem.Text)
            repParams(6) = New ReportParameter("AllowanceDeduction", "Allowance")
            repParams(7) = New ReportParameter("hospitalID", DropDownList_Hospital.SelectedValue)
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet.Copy())
            ReportViewer1.LocalReport.SetParameters(repParams)
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ShowReport()
        Try

            Dim path As String = Server.MapPath("~/payroll/Reports/IncomeTaxSummery.rdlc")
            sqlDsSalaryReport.SelectParameters("Year").DefaultValue = ddlYear.SelectedValue
            sqlDsSalaryReport.SelectParameters("Month").DefaultValue = ddlMonth.SelectedValue
            sqlDsSalaryReport.SelectParameters("DesignationID").DefaultValue = ddlDesign.SelectedValue
            sqlDsSalaryReport.SelectParameters("Dept_Id").DefaultValue = ddlDepartment.SelectedValue
            sqlDsSalaryReport.SelectParameters("Emp_Id").DefaultValue = ddlEmployee.SelectedValue
            sqlDsSalaryReport.SelectParameters("hospitalID").DefaultValue = DropDownList_Hospital.SelectedValue
            sqlDsSalaryReport.SelectParameters("Emp_No").DefaultValue = txtbox_EmpNo.Text.Trim()

            Dim dt As DataTable = CType(sqlDsSalaryReport.Select(DataSourceSelectArguments.Empty), DataView).Table
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = path
            AssignReportParameters()
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("dsSalaryDetails", dt))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

        Catch ex As Exception

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

    Private Function GetIncomeTaxHead() As String
        Dim rtn As String = ""

        Return rtn
    End Function

    ' ========================================================================================================================================================================
    '                                                   System Define Function
    ' ========================================================================================================================================================================

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            DropDownList_Hospital.SelectedValue = "1"
            DropDownList_Hospital.DataBind()
            ddlDepartment.DataBind()
            ddlEmployee.DataBind()
            LoadYearsList()

        End If
    End Sub

    Protected Sub btnViewReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewReport.Click
        ShowReport()
    End Sub

    Protected Sub ddlDepartment_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDepartment.SelectedIndexChanged
        ddlEmployee.DataBind()
    End Sub



End Class
