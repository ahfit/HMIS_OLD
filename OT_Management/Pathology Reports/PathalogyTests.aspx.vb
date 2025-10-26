
Partial Class Pathology_Reports_PathalogyTests
    Inherits System.Web.UI.Page

    Protected Sub Button_Submit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Submit.Click
        Try
            report()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            HiddenFieldYear.Value = DropDownListYear.SelectedValue
            HiddenFieldMonth.Value = DropDownListMonth.SelectedValue
            If IsPostBack Then
                report()
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("..\login.aspx")
            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub
    Sub report()
        Try
            CrystalReportSourceForReport.Visible = True
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            Dim str As String = Server.MapPath("")
            str = str + "\PathologyTests.rpt"
            CrystalReportSourceForReport.Report.FileName = str
            Dim para, para1 As New CrystalDecisions.Web.ControlParameter
            '////////////////////////
            para.ControlID = "HiddenFieldMonth"
            para.ConvertEmptyStringToNull = "False"
            para.DefaultValue = ""
            para.Name = "@month"
            para.PropertyName = "Value"
            para.ReportName = ""
            '///////////////////////////
            para1.ControlID = "HiddenFieldYear"
            para1.ConvertEmptyStringToNull = "False"
            para1.DefaultValue = ""
            para1.Name = "@year"
            para1.PropertyName = "Value"
            para1.ReportName = ""
            '/////////////////////////
            CrystalReportSourceForReport.Report.Parameters.Add(para)
            CrystalReportSourceForReport.Report.Parameters.Add(para1)
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
