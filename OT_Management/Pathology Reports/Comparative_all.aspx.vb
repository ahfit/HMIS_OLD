
Partial Class Pathology_Reports_Comparative_Cash
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            HiddenFieldFromYear.Value = DropDownListFromYear.SelectedValue.ToString
            HiddenFieldToYear.Value = DropDownListToYear.SelectedValue.ToString
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        Try
            CrystalReportSourceForReport.Visible = True
            Session.Timeout = 60
            Dim str As String = Server.MapPath("")
            str = str + "\Compartive_cash.rpt"
            CrystalReportSourceForReport.Report.FileName = str
            Dim para1, para2, para3, para4, para5, para6 As New CrystalDecisions.Web.ControlParameter
            '////////////////////////
            para1.ControlID = "HiddenFieldFromYear"
            para1.ConvertEmptyStringToNull = "False"
            para1.DefaultValue = ""
            para1.Name = "@year"
            para1.PropertyName = "Value"
            para1.ReportName = ""
            '///////////////////////////
            para2.ControlID = "HiddenFieldToYear"
            para2.ConvertEmptyStringToNull = "False"
            para2.DefaultValue = ""
            para2.Name = "@year1"
            para2.PropertyName = "Value"
            para2.ReportName = ""
            '/////////////////////////
            para3.ControlID = "HiddenFieldFromYear"
            para3.ConvertEmptyStringToNull = "False"
            para3.DefaultValue = ""
            para3.Name = "@From_Year"
            para3.PropertyName = "Value"
            para3.ReportName = "Comparative_tests.rpt"
            '///////////////////////////
            para4.ControlID = "HiddenFieldToYear"
            para4.ConvertEmptyStringToNull = "False"
            para4.DefaultValue = ""
            para4.Name = "@To_Year"
            para4.PropertyName = "Value"
            para4.ReportName = "Comparative_tests.rpt"
            '///////////////////////////
            para5.ControlID = "HiddenFieldFromYear"
            para5.ConvertEmptyStringToNull = "False"
            para5.DefaultValue = ""
            para5.Name = "@FromYear"
            para5.PropertyName = "Value"
            para5.ReportName = "Compartive_patients.rpt"
            '///////////////////////////
            para6.ControlID = "HiddenFieldToYear"
            para6.ConvertEmptyStringToNull = "False"
            para6.DefaultValue = ""
            para6.Name = "@ToYear"
            para6.PropertyName = "Value"
            para6.ReportName = "Compartive_patients.rpt"
            '///////////////////////////
            CrystalReportSourceForReport.Report.Parameters.Add(para1)
            CrystalReportSourceForReport.Report.Parameters.Add(para2)
            CrystalReportSourceForReport.Report.Parameters.Add(para3)
            CrystalReportSourceForReport.Report.Parameters.Add(para4)
            CrystalReportSourceForReport.Report.Parameters.Add(para5)
            CrystalReportSourceForReport.Report.Parameters.Add(para6)
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
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
