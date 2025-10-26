Imports System.Data
Imports System.Data.SqlClient
Partial Class Report_Reciver
    Inherits System.Web.UI.Page

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Test_Delivery_Reports_main", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@First_Name", TextBoxRFName.Text)
        param = mycommand.Parameters.AddWithValue("@Middle_Name", TextBoxRMName.Text)
        param = mycommand.Parameters.AddWithValue("@Last_Name", TextBoxRLName.Text)
        param = mycommand.Parameters.AddWithValue("@R_First_Name", TextBoxRFFName.Text)
        param = mycommand.Parameters.AddWithValue("@R_Middle_Name", TextBoxRFMName.Text)
        param = mycommand.Parameters.AddWithValue("@R_Last_Name", TextBoxRFLName.Text)
        param = mycommand.Parameters.AddWithValue("@CNIC", TextBox_RCINIC1.Text + TextBox_RCNIC2.Text + TextBox_RCINC3.Text)
        param = mycommand.Parameters.AddWithValue("@Description", TextBoxDescription.Text)
        param = mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("PayID"))
        param = mycommand.Parameters.AddWithValue("@Relation", RadioButtonList_Relation.SelectedValue)
        param = mycommand.Parameters.Add("@identity", SqlDbType.Int)
        mycommand.Parameters("@identity").Direction = ParameterDirection.Output
        Try
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Dim identity As Integer = mycommand.Parameters("@identity").Value
            Insert_Test(identity)
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        GridView_MRI.DataBind()
        Response.Redirect("Delivery_Report.aspx")
    End Sub
    Sub Insert_Test(ByVal Main_ID As Integer)
        For i As Integer = 0 To GridView_MRI.Rows.Count - 1
            Dim check As CheckBox = GridView_MRI.Rows(i).FindControl("CheckBox1")
            Dim Hid_TCID As HiddenField = GridView_MRI.Rows(i).FindControl("Hiddenfield1")
            If check.Checked = True Then
                HiddenFieldRID.Value = Hid_TCID.Value
                Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("INSERT INTO Report_Receiver_Sub (Main_ID, Test_ID) VALUES (" & Main_ID & "," & Hid_TCID.Value & ")", con)
                mycommand.CommandType = Data.CommandType.Text
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()
                mycommand.Connection.Close()
                SqlDataSourceSaveInfo.Update()
            End If

        Next
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ButtonSave.Attributes.Add("onClick", "return Check_Validates()")
    End Sub
End Class
