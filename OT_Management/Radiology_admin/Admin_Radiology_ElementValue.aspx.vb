Imports System.Data
Imports System.Data.SqlClient

Partial Class Administrator_Radiology_ElementValues

    Inherits System.Web.UI.Page
    Dim e_id As String
    Dim Element_ID As String
    Dim ev_id As String
    Dim ElementCode As String
    Dim Elementvalues_ID As String
    Dim constr As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString



    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            InsertValues_Element_Value()
            'Hiddenfieldforsubgroup.value = DropDownListSubGroup.selectedvalue
            ' SqlDataSourceElementValue.Insert()
            ' DropDownListSubGroup.selectedvalue = Hiddenfieldforsubgroup.value
            ' GridViewElementValue.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub InsertValues_Element_Value()
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Admin_Insert_Radiology_ElementValue", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@MG_Code", DropDownListMainGroup.SelectedValue) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@e_Code", DropDownListElement.SelectedValue)
            mycommand.Parameters.AddWithValue("@ev_Value", TextBoxElementValue.Text)
            mycommand.Parameters.Add("@ev_ID", Data.SqlDbType.VarChar, 100)
            mycommand.Parameters("@ev_ID").Direction = Data.ParameterDirection.Output
            Try
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()
                ev_id = mycommand.Parameters("@ev_ID").Value.ToString
                mycommand.Connection.Close()
                'Response.Write(ev_id)
                'Response.Write(DropDownListEGroup.SelectedValue)
                ElementCode = DropDownListElement.SelectedValue
                If (ElementCode.Length = 1) Then
                    If (ev_id.Length = 1) Then
                        Elementvalues_ID = "E0000" & ElementCode & "0000" & ev_id
                    ElseIf (ev_id.Length = 2) Then
                        Elementvalues_ID = "E0000" & ElementCode & "000" & ev_id
                    ElseIf (ev_id.Length = 3) Then
                        Elementvalues_ID = "E0000" & ElementCode & "00" & ev_id
                    ElseIf (ev_id.Length = 4) Then
                        Elementvalues_ID = "E0000" & ElementCode & "0" & ev_id
                    ElseIf (ev_id.Length = 5) Then
                        Elementvalues_ID = "E0000" & ElementCode & ev_id
                    End If
                ElseIf (ElementCode.Length = 2) Then
                    If (ev_id.Length = 1) Then
                        Elementvalues_ID = "E000" & ElementCode & "0000" & ev_id
                    ElseIf (ev_id.Length = 2) Then
                        Elementvalues_ID = "E000" & ElementCode & "000" & ev_id
                    ElseIf (ev_id.Length = 3) Then
                        Elementvalues_ID = "E000" & ElementCode & "00" & ev_id
                    ElseIf (ev_id.Length = 4) Then
                        Elementvalues_ID = "E000" & ElementCode & "0" & ev_id
                    ElseIf (ev_id.Length = 5) Then
                        Elementvalues_ID = "E000" & ElementCode & ev_id
                    End If


                ElseIf (ElementCode.Length = 3) Then
                    If (ev_id.Length = 1) Then
                        Elementvalues_ID = "E00" & ElementCode & "0000" & ev_id
                    ElseIf (ev_id.Length = 2) Then
                        Elementvalues_ID = "E00" & ElementCode & "000" & ev_id
                    ElseIf (ev_id.Length = 3) Then
                        Elementvalues_ID = "E00" & ElementCode & "00" & ev_id
                    ElseIf (ev_id.Length = 4) Then
                        Elementvalues_ID = "E00" & ElementCode & "0" & ev_id
                    ElseIf (ev_id.Length = 5) Then
                        Elementvalues_ID = "E00" & ElementCode & ev_id
                    End If

                ElseIf (ElementCode.Length = 4) Then
                    If (ev_id.Length = 1) Then
                        Elementvalues_ID = "E0" & ElementCode & "0000" & ev_id
                    ElseIf (ev_id.Length = 2) Then
                        Elementvalues_ID = "E0" & ElementCode & "000" & ev_id
                    ElseIf (ev_id.Length = 3) Then
                        Elementvalues_ID = "E0" & ElementCode & "00" & ev_id
                    ElseIf (ev_id.Length = 4) Then
                        Elementvalues_ID = "E0" & ElementCode & "0" & ev_id
                    ElseIf (ev_id.Length = 5) Then
                        Elementvalues_ID = "E0" & ElementCode & ev_id
                    End If

                ElseIf (ElementCode.Length = 5) Then
                    If (ev_id.Length = 1) Then
                        Elementvalues_ID = "E" & ElementCode & "0000" & ev_id
                    ElseIf (ev_id.Length = 2) Then
                        Elementvalues_ID = "E" & ElementCode & "000" & ev_id
                    ElseIf (ev_id.Length = 3) Then
                        Elementvalues_ID = "E" & ElementCode & "00" & ev_id
                    ElseIf (ev_id.Length = 4) Then
                        Elementvalues_ID = "E" & ElementCode & "0" & ev_id
                    ElseIf (ev_id.Length = 5) Then
                        Elementvalues_ID = "E" & ElementCode & ev_id
                    End If
                End If
            Catch ex As Exception
                'Label1.Text = ex.Message
                Response.Write(ex.Message & "ABC")
            End Try
            UpdateE_ID_Element_Value(ev_id, Elementvalues_ID)
        Catch ex As Exception
            Response.Write(ex.Message & "Def")
        End Try
    End Sub
    Sub UpdateE_ID_Element_Value(ByVal evcode As Integer, ByVal evid As String)
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Admin_Update_Radiology_ElementValue", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@ev_ID", evid)
            mycommand.Parameters.AddWithValue("@ev_Code", evcode)
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)


            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
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
                DropDownListElement.DataBind()
            Else
                DropDownListMainGroup.DataBind()
                DropDownListElement.DataBind()
                'Response.Write(Request.QueryString("ElementID"))
                'Response.Write(Request.QueryString("RadiologyID"))
                DropDownListMainGroup.SelectedValue = Request.QueryString("RadiologyID")
                DropDownListElement.SelectedValue = Request.QueryString("ElementID")
                'SqlDataSourceElementValue.SelectCommand = "SELECT Rd_element_name, Rd_element_id FROM Admin_Rd_Exam_type WHERE (Radiology_id = @id) And (Rd_element_id =" & Request.QueryString("ElementID") & ")"
                'DropDownListSubGroup.SelectedValue = Request.QueryString("ElementID")
            End If
        End If
    End Sub

    Protected Sub DropDownListSubGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListElement.SelectedIndexChanged

        'Response.Redirect("admin_radiology_exam_element_values.aspx?ElementID=" & DropDownListSubGroup.SelectedValue)
    End Sub

    


End Class
