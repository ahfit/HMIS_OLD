Imports System.Data
Imports System.Data.SqlClient
Partial Class MRI_Test_Medicine
    Inherits System.Web.UI.Page




    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    'this function check alll the items of the selected list one by one 
    'Which items are checked the Function Insert the Values in the database 
    'Which Items of the selected checkboxlist are Unchecked That are Delete From the Database 
    Sub Checkboxlistcheck(ByVal checkboxlist As CheckBoxList)
        Try
            Dim b As Integer
            Dim abc As String
            Dim array(checkboxlist.Items.Count - 1) As String
            For b = 0 To checkboxlist.Items.Count - 1
                If checkboxlist.Items(b).Selected = True Then
                    ' if condition use to Inser t the Values in the  db
                    array(b) = checkboxlist.Items(b).Value
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Mri_Insert_MEdicines", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure

                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@Med_Code", checkboxlist.Items(b).Value)
                    param = mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_id"))
                    param = mycommand.Parameters.AddWithValue("@Registration_NO", Session("registrationNo")) 'Session("EMORegNo")
                    Try
                        mycommand.Connection.Open()
                        'abc = CType(mycommand.ExecuteScalar, Integer)
                        mycommand.ExecuteNonQuery()
                        mycommand.Connection.Close()
                    Catch ex As Exception
                        Label1.Text = ex.Message
                    End Try
                Else
                    ' Else Condition is used to delete the Values  that are Unchecked 
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Mri_Delete_MEdicines", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure
                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@Med_Code", checkboxlist.Items(b).Value)
                    param = mycommand.Parameters.AddWithValue("@Registration_NO", Session("registrationNo")) 'Session("EMORegNo")
                    Try
                        mycommand.Connection.Open()
                        abc = CType(mycommand.ExecuteScalar, Integer)
                        mycommand.Connection.Close()

                    Catch ex As Exception
                        Label1.Text = ex.Message
                    End Try
                End If

            Next
        Catch ex As Exception
            '    Label1.Text = ex.Message
        End Try
    End Sub
    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Try
            Checkboxlistcheck(CheckBoxListForRadiologySG)
            Response.Redirect("MRI_Radiology_test_Price.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        
    End Sub

    Protected Sub BTNcheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNcheckAll.Click
        CheckAll(CheckBoxListForRadiologySG)
    End Sub
    ' This function check all the items of the selected chechboxlist.

    Sub CheckAll(ByVal CheckBoxAll As CheckBoxList)
        Dim b As Integer
        Dim array(CheckBoxAll.Items.Count - 1) As String
        For b = 0 To CheckBoxAll.Items.Count - 1
            CheckBoxAll.Items(b).Selected = True
        Next
    End Sub
    ' This function Uncheck all the items of the selected chechboxlist.

    Sub UncheckAll(ByVal UncheckboxAll As CheckBoxList)
        Dim b As Integer
        Dim array(UncheckboxAll.Items.Count - 1) As String
        For b = 0 To UncheckboxAll.Items.Count - 1
            UncheckboxAll.Items(b).Selected = False
        Next
    End Sub

    Protected Sub BtnUncheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnUncheckAll.Click
        UncheckAll(CheckBoxListForRadiologySG)
    End Sub

End Class
