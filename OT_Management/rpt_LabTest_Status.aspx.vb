Imports System.IO
Partial Class Pathology_rpt_LabTest_Status
    Inherits System.Web.UI.Page

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Try

            StartDate = CStr(CDate(WebDateChooser_StartDate.Value).Year)
            StartDate = StartDate + Right("0" + CStr(CDate(WebDateChooser_StartDate.Value).Month), 2)
            StartDate = StartDate + Right("0" + CStr(CDate(WebDateChooser_StartDate.Value).Day), 2)
            HiddenField_StartDate.Value = StartDate

            EndDate = CStr(CDate(WebDateChooser_EndDate.Value).Year)
            EndDate = EndDate + Right("0" + CStr(CDate(WebDateChooser_EndDate.Value).Month), 2)
            EndDate = EndDate + Right("0" + CStr(CDate(WebDateChooser_EndDate.Value).Day), 2)
            HiddenField_EndDate.Value = EndDate
            GridView_LabTestStatus.DataBind()


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

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
    Dim total1 As Integer = 0
    Dim total2 As Integer = 0
    Dim total3 As Integer = 0
    Dim total4 As Integer = 0
    Dim total5 As Integer = 0
    Dim total6 As Integer = 0
    Dim total7 As Integer = 0


    Protected Sub GridView_LabTestStatus_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_LabTestStatus.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            total1 += Convert.ToInt32(e.Row.Cells(1).Text)
            total2 += Convert.ToInt32(e.Row.Cells(2).Text)
            total3 += Convert.ToInt32(e.Row.Cells(3).Text)
            total4 += Convert.ToInt32(e.Row.Cells(4).Text)
            total5 += Convert.ToInt32(e.Row.Cells(5).Text)
            total6 += Convert.ToInt32(e.Row.Cells(6).Text)
            total7 += Convert.ToInt32(e.Row.Cells(7).Text)


        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(1).Text = total1.ToString("N0")
            e.Row.Cells(2).Text = total2.ToString("N0")
            e.Row.Cells(3).Text = total3.ToString("N0")
            e.Row.Cells(4).Text = total4.ToString("N0")
            e.Row.Cells(5).Text = total5.ToString("N0")
            e.Row.Cells(6).Text = total6.ToString("N0")
            e.Row.Cells(7).Text = total7.ToString("N0")
            Dim totalPercent As Integer = total1 + total2 + total3 + total4 + total5 + total6 + total7
            If totalPercent = 0 Then
                totalPercent = 1
            End If
            Dim DelvrUndelvr As Integer = total6 + total7
            Dim average As Double = 0
            average = DelvrUndelvr / totalPercent
            average = average * 100
            average = Fix(average)
        
            e.Row.Cells(8).Text = average.ToString() + "%"
        End If




    End Sub
End Class
