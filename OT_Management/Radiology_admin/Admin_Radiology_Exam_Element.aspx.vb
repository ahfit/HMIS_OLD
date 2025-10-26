
Partial Class Administrator_Admin_Gestational_Ultrasound
    Inherits System.Web.UI.Page

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            SqlDataSourceGUMainGroup.Insert()
            GridViewMainGroup.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridViewMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewMainGroup.SelectedIndexChanged
        SqlDataSourceGUMainGroup.Delete()
    End Sub
    Protected Sub ImageButtonHome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Try
            Response.Redirect("radiologymain.aspx")
        Catch ex As Exception
            'Response.Write(ex.Message & "fwrw")
        End Try

    End Sub

    Protected Sub ImageButtonBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonback.Click
        Response.Redirect("radiologymain.aspx")
    End Sub

    Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
        Session.RemoveAll()
        Response.Redirect("../Loginnew.aspx")
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


End Class
