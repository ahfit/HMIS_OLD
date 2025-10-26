
Partial Class Leave_Time_Period
    Inherits System.Web.UI.Page

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        SqlDataSource_Leave_Time_Period.Insert()
        TextBox_Max_Avail_Days.Text = ""
        TextBox_Ontime_Avail_Days.Text = ""
    End Sub

End Class
