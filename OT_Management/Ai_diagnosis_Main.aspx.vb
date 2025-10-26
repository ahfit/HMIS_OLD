Imports System.Data.SqlClient
Imports System.Data
Partial Class Ai_diagnosis_Main
    Inherits System.Web.UI.Page
    Protected Sub DropDownListCategory_Name_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListCategory_Name.SelectedIndexChanged
        Try

            If DropDownListCategory_Name.SelectedValue = "Histories" Then
                DropDownListMainGroup.DataSourceID = ""
                DropDownListElement.DataSourceID = ""
                SqlDataSourceMainGroup.SelectCommand = "Select Mg_Code,MG_Name From admin_History_MainGroup"
                DropDownListMainGroup.DataSourceID = "SqlDataSourceMainGroup"
                DropDownListMainGroup.DataTextField = "MG_Name"
                DropDownListMainGroup.DataValueField = "MG_Code"
                DropDownListMainGroup.DataBind()
                SqlDataSourceElement.SelectCommand = "Select e_Code,E_Name from admin_History_Elements where MG_Code =" & DropDownListMainGroup.Items(0).Value & ""
                DropDownListElement.DataSourceID = "SqlDataSourceElement"
                DropDownListElement.DataTextField = "e_Name"
                DropDownListElement.DataValueField = "e_Code"
                DropDownListCategory_Name.AutoPostBack = True
            ElseIf DropDownListCategory_Name.SelectedValue = "Physical Examination" Then
                DropDownListMainGroup.DataSourceID = ""
                DropDownListElement.DataSourceID = ""
                SqlDataSourceMainGroup.SelectCommand = "Select Mg_Code,MG_Name From Admin_Dmc_Phy_MainGroup"
                DropDownListMainGroup.DataSourceID = "SqlDataSourceMainGroup"
                DropDownListMainGroup.DataTextField = "MG_Name"
                DropDownListMainGroup.DataValueField = "MG_Code"
                DropDownListMainGroup.DataBind()
                SqlDataSourceElement.SelectCommand = "Select e_Code,E_Name from Admin_dmc_Phy_Elements where MG_Code =" & DropDownListMainGroup.Items(0).Value & ""
                DropDownListElement.DataSourceID = "SqlDataSourceElement"
                DropDownListElement.DataTextField = "e_Name"
                DropDownListElement.DataValueField = "e_Code"
                DropDownListCategory_Name.AutoPostBack = True
            ElseIf DropDownListCategory_Name.SelectedValue = "Investigations" Then
                DropDownListMainGroup.DataSourceID = ""
                DropDownListElement.DataSourceID = ""
                SqlDataSourceMainGroup.SelectCommand = "select TGID,TGName from TestGroup"
                DropDownListMainGroup.DataSourceID = "SqlDataSourceMainGroup"
                DropDownListMainGroup.DataTextField = "TGName"
                DropDownListMainGroup.DataValueField = "TGID"
                DropDownListMainGroup.DataBind()
                SqlDataSourceElement.SelectCommand = "select TCID,ComponentName from testcomponent where TGID =" & DropDownListMainGroup.Items(0).Value & ""
                DropDownListElement.DataSourceID = "SqlDataSourceElement"
                DropDownListElement.DataTextField = "ComponentName"
                DropDownListElement.DataValueField = "TCID"
                DropDownListCategory_Name.AutoPostBack = True
            Else

            End If
            DropDownListElement.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub DropDownListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMainGroup.SelectedIndexChanged
        If DropDownListCategory_Name.SelectedValue = "Histories" Then
            SqlDataSourceElement.SelectCommand = "Select e_Code,E_Name from admin_History_Elements where MG_Code =" & DropDownListMainGroup.SelectedValue & ""
            DropDownListElement.DataSourceID = "SqlDataSourceElement"
            DropDownListElement.DataTextField = "e_Name"
            DropDownListElement.DataValueField = "e_Code"
        ElseIf DropDownListCategory_Name.SelectedValue = "Physical Examination" Then
            SqlDataSourceElement.SelectCommand = "Select e_Code,E_Name from Admin_dmc_Phy_Elements where MG_Code =" & DropDownListMainGroup.SelectedValue & ""
            DropDownListElement.DataSourceID = "SqlDataSourceElement"
            DropDownListElement.DataTextField = "e_Name"
            DropDownListElement.DataValueField = "e_Code"
        ElseIf DropDownListCategory_Name.SelectedValue = "Investigations" Then
            SqlDataSourceElement.SelectCommand = "select TCID,ComponentName from testcomponent where TGID =" & DropDownListMainGroup.SelectedValue & ""
            DropDownListElement.DataSourceID = "SqlDataSourceElement"
            DropDownListElement.DataTextField = "ComponentName"
            DropDownListElement.DataValueField = "TCID"
        End If
        DropDownListElement.DataBind()
        'Response.Write(DropDownListMainGroup.SelectedIndex) '(DropDownListMainGroup.SelectedIndex))
    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "Admin_Insert_AI_Diagnosis"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@D_ID", DropDownListDisease.Text)
            mycommand.Parameters.AddWithValue("@emp_ID", Session("Emp_ID"))
            mycommand.Parameters.AddWithValue("@Dept_ID", Session("Dept_ID"))
            mycommand.Parameters.Add("@AI_ID", Data.SqlDbType.Int)
            mycommand.Parameters("@AI_ID").Direction = Data.ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            HiddenFieldDisease.Value = mycommand.Parameters("@AI_ID").Value.ToString

            Dim operator1 As String = ""
            Dim value1 As String = ""
            Dim operator2 As String = ""
            Dim value2 As String = ""
            If RadioButtonList1.SelectedIndex = 0 Then
                HiddenFieldOperator.Value = "="
                HiddenFieldValue.Value = TextBoxEqual1.Text
            ElseIf RadioButtonList1.SelectedIndex = 1 Then
                HiddenFieldOperator.Value = "Like"
                HiddenFieldValue.Value = TextBoxLike1.Text
            ElseIf RadioButtonList1.SelectedIndex = 2 Then
                HiddenFieldOperator.Value = ">"
                HiddenFieldValue.Value = TextBoxGreater1.Text
            ElseIf RadioButtonList1.SelectedIndex = 3 Then
                HiddenFieldOperator.Value = "<"
                HiddenFieldValue.Value = TextBoxLess1.Text
            End If



            If RadioButtonList2.SelectedIndex = 0 Then
                operator2 = "="
                value2 = "'" & TextBoxEqual2.Text & "'"
            ElseIf RadioButtonList2.SelectedIndex = 1 Then
                operator2 = "Like"
                value2 = "'%" & TextBoxLike2.Text & "%'"
            ElseIf RadioButtonList2.SelectedIndex = 2 Then
                operator2 = ">"
                value2 = TextBoxGreater2.Text
            ElseIf RadioButtonList2.SelectedIndex = 3 Then
                operator2 = "<"
                value2 = TextBoxLess2.Text
            End If

            If DropDownListCategory_Name.SelectedValue = "Histories" Then
                HiddenFieldExam_Type.Value = "(Payment.PayID in (Select yearlyno from Pt_history_SaveRecord where (Payment.PayID=Pt_history_SaveRecord.yearlyno)and (Pt_history_SaveRecord.e_code=" & DropDownListElement.SelectedValue & ")and (Pt_history_SaveRecord.ev_code " & operator1 & " " & value1 & ")))"
            ElseIf DropDownListCategory_Name.SelectedValue = "Physical Examination" Then
                HiddenFieldExam_Type.Value = "(Payment.PayID in (Select yearlyno from Pt_dmc_Phy_SaveRecord where (Payment.PayID=Pt_dmc_Phy_SaveRecord.yearlyno)and (Pt_dmc_Phy_SaveRecord.e_id=" & DropDownListElement.SelectedValue & ")and (Pt_history_SaveRecord.ev_code " & operator1 & " " & value1 & ")))"
            End If

            SqlDataSourceSaveInfo.Insert()
            Ai_Diagnosis()
        Catch ex As Exception
            Response.Write(ex.Message + "Hello")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack = False Then
            DropDownListMainGroup.DataSourceID = ""
            DropDownListElement.DataSourceID = ""
            SqlDataSourceMainGroup.SelectCommand = "Select Mg_Code,MG_Name From admin_History_MainGroup"
            DropDownListMainGroup.DataSourceID = "SqlDataSourceMainGroup"
            DropDownListMainGroup.DataTextField = "MG_Name"
            DropDownListMainGroup.DataValueField = "MG_Code"
            DropDownListMainGroup.DataBind()
            SqlDataSourceElement.SelectCommand = "Select e_Code,E_Name from admin_History_Elements where MG_Code =" & DropDownListMainGroup.Items(0).Value & ""
            DropDownListElement.DataSourceID = "SqlDataSourceElement"
            DropDownListElement.DataTextField = "e_Name"
            DropDownListElement.DataValueField = "e_Code"
            DropDownListCategory_Name.AutoPostBack = True
        End If
    End Sub

    Sub Ai_Diagnosis()
        Try

            Dim var_String As String = "SELECT distinct  Admin_DMC_Disease.Disease_Name, Admin_DMC_Disease.Disease_Category FROM Admin_AI_Diagnosis_Sub INNER JOIN Admin_AI_Diagnosis_Main ON Admin_AI_Diagnosis_Sub.AI_ID = Admin_AI_Diagnosis_Main.AI_ID INNER JOIN Admin_DMC_Disease ON Admin_AI_Diagnosis_Main.D_ID = Admin_DMC_Disease.ID  Where"
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "Select * from Admin_AI_Diagnosis_Sub"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.CommandText = Procedurename
            con.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "abc")
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                If ds.Tables(0).Rows(i).Item(0) = "Histories" Then
                    Response.Write(ds.Tables(0).Rows(i).Item(3) & "Value")
                    If ds.Tables(0).Rows(i).Item(3) = "=" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_Histories.ev_Code" & ds.Tables(0).Rows(i).Item(3) & "'" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_Histories.ev_Code" & ds.Tables(0).Rows(i).Item(3) & "'" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If

                    ElseIf ds.Tables(0).Rows(i).Item(3) = ">" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_Histories.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_Histories.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    ElseIf ds.Tables(0).Rows(i).Item(3) = "<" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_Histories.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_Histories.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    ElseIf ds.Tables(0).Rows(i).Item(3) = "Like" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_Histories.ev_Code " & ds.Tables(0).Rows(i).Item(3) & "'%" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_Histories  WHERE(Patient_Diagnosis_Histories.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_Histories.ev_Code " & ds.Tables(0).Rows(i).Item(3) & "'%" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_Histories.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    End If
                    ''''''''''Main If Condition For the Main Category Like Hiostory , Examination , Vitals''''''''''''''''''''''''''''''''''''''''''''''
                    ''''''''''This Is For Physical Examination '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                ElseIf ds.Tables(0).Rows(i).Item(0) = "Physical Examination" Then
                    If ds.Tables(0).Rows(i).Item(3) = "=" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_PhysicalExam.ev_Code" & ds.Tables(0).Rows(i).Item(3) & "'" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_PhysicalExam.ev_Code" & ds.Tables(0).Rows(i).Item(3) & "'" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If

                    ElseIf ds.Tables(0).Rows(i).Item(3) = ">" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_PhysicalExam.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_PhysicalExam.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    ElseIf ds.Tables(0).Rows(i).Item(3) = "<" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_PhysicalExam.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (convert(int,Patient_Diagnosis_PhysicalExam.ev_Code)" & ds.Tables(0).Rows(i).Item(3) & "" & ds.Tables(0).Rows(i).Item(4) & ") and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    ElseIf ds.Tables(0).Rows(i).Item(3) = "Like" Then
                        If i = 0 Then
                            var_String = var_String & "(Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code =" & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_PhysicalExam.ev_Code " & ds.Tables(0).Rows(i).Item(3) & "'%" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        Else
                            var_String = var_String & "or (Admin_AI_Diagnosis_Sub.Element_ID IN (SELECT E_code FROM Patient_Diagnosis_PhysicalExam  WHERE(Patient_Diagnosis_PhysicalExam.e_code= " & ds.Tables(0).Rows(i).Item(2) & ") AND (Patient_Diagnosis_PhysicalExam.ev_Code " & ds.Tables(0).Rows(i).Item(3) & "'%" & ds.Tables(0).Rows(i).Item(4) & "') and Patient_Diagnosis_PhysicalExam.yearlyno=" + """&" + " Pt_Yearly_No " + "&""" + "))"
                        End If
                    End If

                End If
            Next
            con.Close()
            'Response.Write(var_String)
            Insert_Query(var_String)
        Catch ex As Exception
            Response.Write(ex.Message & "Hello 1")
        End Try

    End Sub
    Sub Insert_Query(ByVal Query As String)
        Dim var_String As String = ""
        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "Admin_Insert_Ai_Diagnosis_Query"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = Procedurename
        mycommand.Parameters.AddWithValue("@Query_Value", Query)
        con.Open()
        mycommand.ExecuteNonQuery()
        con.Close()
    End Sub
End Class
