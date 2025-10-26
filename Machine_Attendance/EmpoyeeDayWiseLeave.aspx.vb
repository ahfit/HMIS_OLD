Imports System.Data
Imports System.Data.SqlClient
Imports Microsoft.Reporting.WebForms
Partial Class HR_EmpoyeeDayWiseLeave
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            HFEmpid.Value = Request.QueryString("Emp_ID")
            HFmonth.Value = Request.QueryString("month")
            HFyear.Value = Request.QueryString("year")
            
            GridView_Date_Wise.DataBind()
            
            'ShowReport()
        End If

    End Sub

    Private Sub ShowReport()
       


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
    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        Response.Redirect("~/Machine_Attendance/Employee_LeaveApproval.aspx")
    End Sub

    Private Sub ReportParameter()
        Throw New NotImplementedException
    End Sub

    Private Sub repParams()
        Throw New NotImplementedException
    End Sub


    Protected Sub IBtn_Cancel_Click(sender As Object, e As ImageClickEventArgs)
        Response.Redirect("~/Machine_Attendance/Employee_OverTime.aspx")

    End Sub
End Class
