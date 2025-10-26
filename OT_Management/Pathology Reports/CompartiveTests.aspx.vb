
Partial Class Pathology_Reports_CompartiveTests
    Inherits System.Web.UI.Page

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        Try
            Dim str As String = Server.MapPath("")
            str = str + "\Comparative_tests.rpt"
            CrystalReportSourceForReport.Report.FileName = str
            Dim para, para1 As New CrystalDecisions.Web.ControlParameter
            '////////////////para//////////////////////////////////
            para.ControlID = "HiddenFieldFromYear"
            para.ConvertEmptyStringToNull = "False"
            para.DefaultValue = ""
            para.Name = "@From_Year"
            para.PropertyName = "Value"
            para.ReportName = ""
            '////////////////para1///////////////////////////////////
            para1.ControlID = "HiddenFieldToYear"
            para1.ConvertEmptyStringToNull = "False"
            para1.DefaultValue = ""
            para1.Name = "@To_Year"
            para1.PropertyName = "Value"
            para1.ReportName = ""
            '////////////////////////////////////////////////////////
            CrystalReportSourceForReport.Report.Parameters.Add(para)
            CrystalReportSourceForReport.Report.Parameters.Add(para1)
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            HiddenFieldFromYear.Value = DropDownListFromYear.SelectedValue.ToString
            HiddenFieldToYear.Value = DropDownListToYear.SelectedValue.ToString
            loginvalidate(Session("emp_id"), Session("dept_id"))
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

End Class
