Imports System.Data
Imports System.IO

Partial Class Administrator_UserDetailPageAccessLog
    Inherits System.Web.UI.Page

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        'sqlDs_UserPageAccessLog.SelectParameters("").DefaultValue = DropDownList_Employee.SelectedValue
        'sqlDs_UserPageAccessLog.SelectParameters("").DefaultValue = WebDateChooser_FromDate.Text
        'sqlDs_UserPageAccessLog.SelectParameters("").DefaultValue = WebDateChooser_ToDate.Text
        'sqlDs_UserPageAccessLog.Select(DataSourceSelectArguments.Empty)
        grdUserPageAccessLog.DataBind()


    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            WebDateChooser_FromDate.Text = Date.Now.ToString("yyyy-MM-dd")
            WebDateChooser_ToDate.Text = Date.Now.ToString("yyyy-MM-dd")
        End If
    End Sub

    Protected Sub btn_export_Click(sender As Object, e As EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = ("User Page Access Details" + ".xls")
        Response.ClearContent()
        Response.AddHeader("content-disposition", ("attachment;filename=" + fileName))
        Response.ContentType = "application/excel"
        Dim sw As StringWriter = New StringWriter
        Dim htm As HtmlTextWriter = New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.grdUserPageAccessLog
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
