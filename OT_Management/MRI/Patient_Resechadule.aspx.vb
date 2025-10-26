
Partial Class Patient_Resechadule
    Inherits System.Web.UI.Page

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click
        GridView_Patient_resch.DataBind()

        For i As Integer = 0 To GridView_Patient_resch.Rows.Count - 1
            HiddenField_Select_Date.Value = WebDateChooser1.Value
            HiddenField_Reg_No.Value = GridView_Patient_resch.Rows(i).Cells(0).Text
            HiddenField_Yearly_No.Value = GridView_Patient_resch.Rows(i).Cells(1).Text
            'Response.Write(HiddenField_Yearly_No.Value & " YearlyNo " & HiddenField_Reg_No.Value & " fds ")
            SqlDataSource_For_Grid.Update()
        Next
        GridView_Patient_resch.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        WebDateChooser1.MinDate = Date.Now.Date
        If Page.IsPostBack = False Then
            WebDateChooser1.Value = Date.Now.Date
        End If
        'Dim pt As Collection
        'pt = Session("PT_Col")
        'For i As Integer = 1 To pt.Count
        '    Dim Pt_info() As String = pt.Item(i)
        '    Response.Write(Pt_info.GetValue(0))
        'Next
    End Sub
End Class
