
Partial Class Administrator_Admin_Gestational_Ultrasound_ElementValues
    Inherits System.Web.UI.Page

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Hiddenfieldforsubgroup.value = DropDownListSubGroup.selectedvalue
            SqlDataSourceElementValue.Insert()
            DropDownListSubGroup.selectedvalue = Hiddenfieldforsubgroup.value
            GridViewElementValue.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridViewElementValue_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewElementValue.SelectedIndexChanged
        Try
            SqlDataSourceForGrid.Delete()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        form1.DefaultButton = "ButtonSave"
        If Page.IsPostBack = False Then


            If Request.QueryString("ElementID") Is Nothing Then
                ' Response.Write(Request.QueryString("ElementID"))
                DropDownListMainGroup.DataBind()
                DropDownListSubGroup.DataBind()
            Else
                DropDownListMainGroup.DataBind()
                DropDownListSubGroup.DataBind()
                'Response.Write(Request.QueryString("ElementID"))
                'Response.Write(Request.QueryString("RadiologyID"))
                DropDownListMainGroup.SelectedValue = Request.QueryString("RadiologyID")
                DropDownListSubGroup.SelectedValue = Request.QueryString("ElementID")
                'SqlDataSourceElementValue.SelectCommand = "SELECT Rd_element_name, Rd_element_id FROM Admin_Rd_Exam_type WHERE (Radiology_id = @id) And (Rd_element_id =" & Request.QueryString("ElementID") & ")"
                'DropDownListSubGroup.SelectedValue = Request.QueryString("ElementID")
            End If
        End If
    End Sub

    Protected Sub DropDownListSubGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListSubGroup.SelectedIndexChanged

        'Response.Redirect("admin_radiology_exam_element_values.aspx?ElementID=" & DropDownListSubGroup.SelectedValue)
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
