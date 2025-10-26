Imports System.IO
Partial Class Pathology_rpt_LabTestStatus_Detail
    Inherits System.Web.UI.Page

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        Dim StartDate As String = ""
        Dim EndDate As String = ""

        StartDate = CStr(CDate(WebDateChooser_StartDate.Value).Year)
        StartDate = StartDate + Right("0" + CStr(CDate(WebDateChooser_StartDate.Value).Month), 2)
        StartDate = StartDate + Right("0" + CStr(CDate(WebDateChooser_StartDate.Value).Day), 2)
        HiddenField_StartDate.Value = StartDate

        EndDate = CStr(CDate(WebDateChooser_EndDate.Value).Year)
        EndDate = EndDate + Right("0" + CStr(CDate(WebDateChooser_EndDate.Value).Month), 2)
        EndDate = EndDate + Right("0" + CStr(CDate(WebDateChooser_EndDate.Value).Day), 2)
        HiddenField_EndDate.Value = EndDate
        GridView_LabTestStatus.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            WebDateChooser_StartDate.Value = Date.Now.Date
            WebDateChooser_EndDate.Value = Date.Now.Date
        End If
    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonx.Click

        Response.Clear()
        Response.ContentType = "application/vnd.xls"
        Response.AddHeader("content-disposition", "attachment;filename=filename.xls")

        Dim swriter As New StringWriter()
        Dim hwriter As New HtmlTextWriter(swriter)

        Dim frm As New HtmlForm()
        Me.GridView_LabTestStatus.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(Me.GridView_LabTestStatus)
        frm.RenderControl(hwriter)

        Response.Write(swriter.ToString())
        Response.End()
    End Sub
End Class
