
Partial Class Nursing_Pt_Blood_Sugar_Chart
    Inherits System.Web.UI.Page

    Protected Sub TextBoxsugar_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBoxsugar.TextChanged
        If TextBoxsugar.Text <> "" Then
            TextBoxQty.Text = (CInt(TextBoxsugar.Text) / 20) - 5
        End If
    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            HiddenFieldDateTime.Value = WebDateChooserDateTime.Value
            SqlDataSourceInsert.Insert()
            TextBoxsugar.Text = ""
            TextBoxQty.Text = ""
            'Chart1.DataBind()
            'Chart1.Visible = True
            Dim obj As New XML_For_Graph
            obj.Create_XML_SugarChart(Session("registrationNo"), Session("YearlyNo"))
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'ButtonSave.Attributes.Add("OnClick", "return CheckRequirment()")
        Page.Header.DataBind()
        Dim obj As New XML_For_Graph
        obj.Create_XML_SugarChart(Session("registrationNo"), Session("YearlyNo"))
        If Not Page.IsPostBack Then
            WebDateChooserDateTime.Value = Date.Now
        End If
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
    End Sub
End Class
