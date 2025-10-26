Imports System.Data
Imports System.Data.SqlClient
Partial Class Admin_main_group
    Inherits System.Web.UI.Page
    Dim e_id As String
    Dim Element_ID As String
    Dim ev_id As String
    Dim ElementCode As String
    Dim Elementvalues_ID As String
    Dim constr As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            If TextBoxMainGroup.Text <> "" Then
                SqlDataSourceMainGroup.Insert()
                DropDownListMainGroup.DataBind()
                TextBoxMainGroup.Text = ""
            Else
                LabelMainGroup.Text = "Enter Group Name"
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Try
            If TextBoxElement.Text <> "" Then
                InsertValues_Element()
                DropDownListElement.DataBind()
                TextBoxElement.Text = ""
                GridViewMain.DataBind()
            Else
                Labelelement.Text = "Enter Element Name"
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Try
            InsertValues_Element_Value()
            TextBoxElementValue.Text = ""
            GridViewMain.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    


    Protected Sub DropDownListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMainGroup.SelectedIndexChanged
        DropDownListElement.DataBind()
        GridViewMain.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'DropDownListElement.DataBind()
        GridViewMain.DataBind()
    End Sub
    Sub InsertValues_Element()
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Admin_Insert_Radiology_Element", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@MG_Code", DropDownListMainGroup.SelectedValue) 'Session("BMIPayID")
            mycommand.Parameters.AddWithValue("@e_Name", TextBoxElement.Text)
            mycommand.Parameters.AddWithValue("@e_Field_Type", DropDownListType.SelectedValue)
            mycommand.Parameters.Add("@e_ID", Data.SqlDbType.VarChar, 100)
            mycommand.Parameters("@e_ID").Direction = Data.ParameterDirection.Output
            Try
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()
                e_id = mycommand.Parameters("@e_ID").Value.ToString
                mycommand.Connection.Close()
                If (e_id.Length = 1) Then
                    Element_ID = "E0000" & e_id
                ElseIf (e_id.Length = 2) Then
                    Element_ID = "E000" & e_id
                ElseIf (e_id.Length = 3) Then
                    Element_ID = "E00" & e_id
                ElseIf (e_id.Length = 4) Then
                    Element_ID = "E0" & e_id
                ElseIf (e_id.Length = 5) Then
                    Element_ID = "E" & e_id
                End If
                'Response.Write(Element_ID)
            Catch ex As Exception
                Response.Write(ex.Message)
                'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            End Try
            'Response.Write("code" & e_id & "Element " & Element_ID)
            UpdateE_ID_Element(e_id, Element_ID)
        Catch ex As Exception
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub
    Sub UpdateE_ID_Element(ByVal ecode As Integer, ByVal eid As String)
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Admin_Update_radiology_Element", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@e_ID", eid)
            mycommand.Parameters.AddWithValue("@e_Code", ecode)
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
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

    Protected Sub DropDownListElement_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListElement.SelectedIndexChanged
        GridViewMain.DataBind()
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
        Response.Redirect("Admin_Radiology_Exam_Element.aspx")
    End Sub
End Class
