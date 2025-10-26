
Partial Class Pathology_Reports_Annual_tests_Data
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        HiddenFieldYear.Value = DropDownListYear.SelectedValue
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("..\login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            CrystalReportSourceForReport.Visible = True
            Session.Timeout = 60
            'loginvalidate(Session("emp_id"), Session("dept_id"))
            Dim str As String = Server.MapPath("")
            str = str + "\annual_test_data1.rpt"
            CrystalReportSourceForReport.Report.FileName = str
            'CrystalReportSourceForReport.ReportDocument.DataSourceConnections.Item(0).SetLogon("sa", "123")
            'CrystalReportSourceForReport.ReportDocument.DataSourceConnections.Item(0).SetConnection("Server", "Admin_Pathology", "sa", "123")
            Dim para As New CrystalDecisions.Web.ControlParameter
            para.ControlID = "DropDownListYear" '"HiddenFieldYear"
            para.ConvertEmptyStringToNull = "False"
            para.DefaultValue = ""
            para.Name = "@year"
            para.PropertyName = "SelectedValue"
            para.ReportName = ""
            CrystalReportSourceForReport.Report.Parameters.Add(para)
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
