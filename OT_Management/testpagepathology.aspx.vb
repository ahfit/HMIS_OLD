


Partial Class testpagepathology
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Dim Object_View_Page As New Employee_View_Pages
            'Object_View_Page.viewPage(Session("emp_id"), Request.ServerVariables("Remote_Addr"), Page.Request.PhysicalPath.ToString, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length)
            HiddenField_YearlyNo.Value = Request.QueryString("YearlyNo").ToString 'Request.QueryString(1).ToString
            HiddenField_RegNo.Value = Request.QueryString("RegNo").ToString 'Request.QueryString(0).ToString
            HiddenFieldTGID.Value = Request.QueryString("TGID").ToString
            HiddenFieldPatientName.Value = Session("PatientName")
            HiddenFieldRegisrationNo.Value = Request.QueryString("RegNo").ToString 'Session("Reg_No")
            'Response.Write(Session("PatientName") & " dasdsadjsadhahda" & Session("Reg_No"))
            'Response.Write(HiddenField_YearlyNo.Value + "gstjsy ")
            'Response.Write(HiddenField_RegNo.Value + Request.QueryString("YearlyNo").ToString)
            CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
            ' CrystalReportViewer1.SelectionFormula = "{command.RegNo}= '" & Request.QueryString(0).ToString & "'"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
