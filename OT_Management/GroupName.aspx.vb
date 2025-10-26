Partial Class GroupName
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            loginvalidate(Session("emp_id"), Session("dept_id"))
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                'Response.Redirect("loginnew.aspx")

            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
        
    End Sub
    Protected Sub SAVE_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles SAVE.Click
        Try
            Session("TestTGID") = DropDownListGName.SelectedItem.Value
            Session("testTSGID") = DropDownListSGName.SelectedItem.Value
            SqlDataSourceGNameSave.Insert()
        Catch ex As Exception
            response.write(ex.message)
        End Try
       
    End Sub

    Protected Sub DropDownListGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListGName.SelectedIndexChanged
        Try
            HiddenFieldGroupName.Value = DropDownListGName.SelectedValue
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    Protected Sub ImageButtonlogout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
        Try
            session.removeall()
            'Response.Redirect("loginnew.aspx")
        Catch ex As Exception
            response.write(ex.message)
        End Try
       
    End Sub
    Protected Sub ImageButtonBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonBack.Click
        Try
            Response.Redirect("Administrator/Pathalogymain.aspx")
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    Protected Sub ImageButtonHome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonHome.Click
        Try
            'Response.Redirect("loginnew.aspx")
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub

	
    '	    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '        Response.Redirect("TestGroup.aspx")
    '    End Sub

    '    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
    'Response.Redirect("TestSubGroup.aspx")
    '    End Sub

    '    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
    'Response.Redirect("GroupName.aspx")
    '    End Sub

    '    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
    'Response.Redirect("Administrator/Test Administrator/UnitForTest.aspx")
    '    End Sub

    '    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button5.Click
    'Response.Redirect("Administrator/Test Administrator/TestComponent.aspx")
    '    End Sub
	


End Class
