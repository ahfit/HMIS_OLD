Imports System
Imports System.IO

Partial Class Administrator_UserLoginAccessLog
    Inherits System.Web.UI.Page

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSearch.Click
        LoadUserLog()

    End Sub
    Private Sub LoadUserLog()
        Try

            Dim x As Integer = 9

            sqlDs_UserLoginAccessLog.SelectParameters("UseDateFrom").DefaultValue = WebDateChooser_FromDate.Value
            sqlDs_UserLoginAccessLog.SelectParameters("UseDateTo").DefaultValue = WebDateChooser_ToDate.Value
            sqlDs_UserLoginAccessLog.SelectParameters("EmpId").DefaultValue = DropDownList_Employee.SelectedValue

            grdUserLoginAccessLog.DataBind()
            grdUserLoginAccessLog.Visible = True
        Catch ex As Exception

        End Try
    End Sub

    
    Public Function GetStartOfMonth() As DateTime
        Return New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            DropDownList_Employee.DataBind()
            DDL_SubDept.DataBind()
            DropDownList_Employee.SelectedValue = Request.QueryString("EmpID")
            ' DropDownList_Employee.Enabled = False
            WebDateChooser_FromDate.Value = GetStartOfMonth()
            WebDateChooser_ToDate.Value = DateTime.Now.ToString(Utility.DateFormat)

        End If
    End Sub

    Protected Sub btn_export_Click(sender As Object, e As EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = ("User Login Access Detail" + ".xls")
        Response.ClearContent()
        Response.AddHeader("content-disposition", ("attachment;filename=" + fileName))
        Response.ContentType = "application/excel"
        Dim sw As StringWriter = New StringWriter
        Dim htm As HtmlTextWriter = New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.grdUserLoginAccessLog
        repAllCustomers.AllowPaging = False
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString)
        Response.End()
        ' HF_is_Report.Value = "0";
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' base.VerifyRenderingInServerForm(control);
    End Sub

    Protected Sub DDL_SubDept_SelectedIndexChanged(sender As Object, e As EventArgs)

    End Sub
End Class
