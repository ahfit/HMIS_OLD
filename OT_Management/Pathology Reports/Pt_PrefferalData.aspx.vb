
Partial Class Pathology_Reports_Pt_PrefferalData
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            HiddenFieldYear.Value = DropDownListYear.SelectedValue.ToString
            If Page.IsPostBack Then
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

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            report()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub report()
        Try
            CrystalReportSourceForReport.Visible = True
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            Dim str As String = Server.MapPath("")
            str = str + "\Pt_Prefferal_data.rpt"
            CrystalReportSourceForReport.Report.FileName = str
            Dim para As New CrystalDecisions.Web.ControlParameter
            para.ControlID = "HiddenFieldYear"
            para.ConvertEmptyStringToNull = "False"
            para.DefaultValue = ""
            para.Name = "@year"
            para.PropertyName = "Value"
            para.ReportName = ""
            CrystalReportSourceForReport.Report.Parameters.Add(para)
            CrystalReportViewerReport.ReportSource = CrystalReportSourceForReport
            CrystalReportViewerReport.LogOnInfo.Item(0).ConnectionInfo.Password = "123456"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
End Class
