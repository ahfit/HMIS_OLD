Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.SqlClient
Partial Class Deliverd_Reports
    Inherits System.Web.UI.Page
    Dim b As String
    Dim ENC As New Encryption

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If Page.IsPostBack = False Then
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(0).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(0).Text, False)
            Next
        End If
    End Sub

    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then

                If (b = "") Then
                    b = e.Row.Cells.Item(2).Text
                    'Response.Write(e.Row.Cells.Item(4).Text)
                    e.Row.Cells.Item(2).Text = b
                ElseIf b = e.Row.Cells.Item(2).Text Then
                    e.Row.Cells.Item(2).Text = ""
                    e.Row.Cells.Item(2).Text = ""
                Else
                    b = e.Row.Cells.Item(2).Text
                    e.Row.Cells.Item(2).Text = b
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub

    Protected Sub LinkButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonReport.Click
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                HiddenField_TG_ID.Value = TG_ID.Value
            End If
        Next
        'Response.Redirect("testpagepathology.aspx?&RegNo=" + Request.QueryString("RegNo").ToString + "&YearlyNo= " + Request.QueryString("YearlyNo").ToString + "&TGID" + HiddenField_TG_ID.Value)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' ButtonSave.Attributes.Add("onclick", "return Validation()") 'getQueryVariable
        Dim RegNo As String = "RegNo"
        Dim YearlyNo As String = "YearlyNo"
        LinkButtonReport.Attributes.Add("onclick", "return getQueryVariable('" & RegNo & "','" & YearlyNo & "')")
        Label_Message.Text = ""
        ' Response.Write(Request.QueryString("RegNo").ToString + "&YearlyNo= " + Request.QueryString("YearlyNo").ToString)
    End Sub

    Sub Printreport1()
        Try
            Dim report As New ReportDocument()
            Dim RegNo As String = Request.QueryString("RegNo").ToString
            Dim YearlyNo As String = Request.QueryString("YearlyNo").ToString
            report.Load("D:\Pathalogy Software\PathologyFeesReport.rpt")  ' Location Of The Report. 
            report.SetDatabaseLogon("sa", "123", "Server1", "Pathology2")
            report.SetParameterValue(0, RegNo)
            report.SetParameterValue(1, YearlyNo)
            'report.SetParameterValue(2, YearlyNo)
            report.PrintToPrinter(1, True, 0, 0)
            report.Close()
            Session("PDT") = Date.Now
        Catch ex As Exception
            Response.Write(" Crystal Report ok" & ex.Message)
        End Try
    End Sub

End Class
