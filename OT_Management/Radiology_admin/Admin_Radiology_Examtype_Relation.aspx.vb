
Partial Class Administrator_Admin_Radiology_Examtype_Relation
    Inherits System.Web.UI.Page

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            SqlDataSourceSaveInfo.Insert()
            GridView1.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonHome.Click
        Try
            Response.Redirect("../Administrator/RadiologyMain.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub ImageButtonlogout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonLogOut.Click
        Try
            Session.RemoveAll()
            Response.Redirect("../Loginnew.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub ImageButtonback_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonBack.Click
        Try
            Response.Redirect("../Administrator/RadiologyMain.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("../Rd_Body_part.aspx")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("../Rd_Projection.aspx")
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Response.Redirect("../Rd_Xray_entry.aspx")
    End Sub

    Protected Sub Button4_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button4.Click
        Response.Redirect("Admin_Radiology_MainGroup.aspx")
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button5.Click
        Response.Redirect("Admin_Radiology_Exam_Element.aspx")
    End Sub

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button6.Click
        Response.Redirect("Admin_Radiology_Exam_Element_Values.aspx")
    End Sub

    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button7.Click
        Response.Redirect("../Radiology/RadiologyGroup.aspx")
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button8.Click
        Response.Redirect("../Radiology/RadiologySubGroup.aspx")
    End Sub

    Protected Sub Button9_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button9.Click
        Response.Redirect("../Radiology/RadiologyEnteries.aspx")
    End Sub

    Protected Sub Button10_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button10.Click
        Response.Redirect("Admin_Radiology_Examtype_Relation.aspx")
    End Sub



    'Protected Sub DropDownListSGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListSGName.SelectedIndexChanged
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub DropDownListRadiology_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListRadiology.SelectedIndexChanged
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub DropDownListMGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMGName.SelectedIndexChanged
    '    GridView1.DataBind()
    'End Sub
End Class
