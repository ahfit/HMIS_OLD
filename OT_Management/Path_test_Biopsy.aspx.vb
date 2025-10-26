Imports System.Data
Imports System.Data.SqlClient
Partial Class Path_test_Biopsy
    Inherits System.Web.UI.Page
    Dim Test_Counter As Integer = 0
    Dim Constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ToString()
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        For i As Integer = 0 To GridView2.Rows.Count - 1
            Dim check As CheckBox = GridView2.Rows(i).FindControl("CheckBox1")
            If check.Checked = True Then
                Dim txt As TextBox = GridView2.Rows(i).FindControl("TextBox1")
                Dim hid As HiddenField = GridView2.Rows(i).FindControl("HiddenField1")
                Dim con As SqlConnection = New SqlConnection(Constr)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("test_Insert", con)
                mycommand.CommandType = Data.CommandType.StoredProcedure
                Dim param As System.Data.SqlClient.SqlParameter
                param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
                param = mycommand.Parameters.AddWithValue("@TID", hid.Value)
                param = mycommand.Parameters.AddWithValue("@DateTime", Date.Now)
                param = mycommand.Parameters.AddWithValue("@DoctorID", "3")
                param = mycommand.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                param = mycommand.Parameters.AddWithValue("@Biopsy_description", txt.Text)
                Try
                    mycommand.Connection.Open()
                    mycommand.ExecuteNonQuery()
                    mycommand.Connection.Close()
                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
                Test_Counter += 1
            End If
        Next
        If Test_Counter <> 0 Then
            Button_Move_Next.Visible = True
            Button6.Visible = True
        End If
    End Sub
    Protected Sub Button_Move_Next_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Move_Next.Click
        Try
            Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
            HiddenField_Sample_collection.Value = SDate
            If DropDownList1.SelectedValue = "Days" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
            ElseIf DropDownList1.SelectedValue = "Hours" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
            End If
            Insert_Values()
            Response.Redirect("main_services.aspx")

        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Sub Insert_Values()
        Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        HiddenField_Sample_collection.Value = SDate
        If DropDownList1.SelectedValue = "Days" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
        ElseIf DropDownList1.SelectedValue = "Hours" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
        End If
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(Constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", HiddenField_Sample_collection.Value)
        param = mycommand.Parameters.AddWithValue("@Sample_No", TextBox_Sample_number.Text)
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", HiddenField_Report_Date.Value)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", TextBox_Grand_discount.Text)
        param = mycommand.Parameters.AddWithValue("@Description", TextBoxDescription.Text)
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", RadioButtonList_Type.SelectedValue)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Session.Add("RegistrationNo", Request.QueryString("RegNo").ToString)
        'Session.Add("YearlyNo", Request.QueryString("YearlyNo").ToString)
    End Sub

End Class
