Imports System.Data
Imports System.Data.SqlClient
Partial Class Update_Patient
    Inherits System.Web.UI.Page
    Dim AgeDate As String
    Dim enc As New Encryption
    Sub Patient_Info()
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("PatientCompleteDetail", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString(0))
            Session.Add("registrationNO", Request.QueryString(0))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "Patient")
            Prefix.SelectedValue = ds.Tables(0).Rows(0).Item(1).ToString
            TextBox_PFName.Text = enc.Encrypt_Main(ds.Tables(0).Rows(0).Item(2).ToString, False)
            TextBox_PLName.Text = enc.Encrypt_Main(ds.Tables(0).Rows(0).Item(3).ToString, False)
            RadioButtonList_Relation.SelectedValue = ds.Tables(0).Rows(0).Item(5).ToString
            TextBox_RFName.Text = ds.Tables(0).Rows(0).Item(6).ToString
            TextBox_RLName.Text = ds.Tables(0).Rows(0).Item(7).ToString
            DropDownList_Gender.SelectedValue = ds.Tables(0).Rows(0).Item(9).ToString
            TextBox_CNIC1.Text = ds.Tables(0).Rows(0).Item(25).ToString
            DropDownList_Country.SelectedValue = ds.Tables(0).Rows(0).Item(12).ToString
            DropDownList_Province.SelectedValue = ds.Tables(0).Rows(0).Item(13).ToString
            DropDownList_District.SelectedValue = ds.Tables(0).Rows(0).Item(14).ToString
            DropDownList_Tehsil.SelectedValue = ds.Tables(0).Rows(0).Item(15).ToString
            TextBox_Street_Block.Text = ds.Tables(0).Rows(0).Item(17).ToString
            TextBox_Town.Text = ds.Tables(0).Rows(0).Item(18).ToString
            TextBox_House_No.Text = ds.Tables(0).Rows(0).Item(28).ToString
            TextBox_Postal_Code.Text = ds.Tables(0).Rows(0).Item(16).ToString
            TextBox_PHone_No.Text = ds.Tables(0).Rows(0).Item(22).ToString
            TextBox_Mobile_No.Text = ds.Tables(0).Rows(0).Item(23).ToString
            AgeDate = ds.Tables(0).Rows(0).Item(26).ToString
            If ds.Tables(0).Rows(0).Item(29).ToString <> "" Then
                Image1.Visible = True
                Image1.ImageUrl = "~" & ds.Tables(0).Rows(0).Item(29).ToString
            Else
                Image1.Visible = False
            End If
            Calculate_DOB(AgeDate)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Calculate_DOB(ByVal AgeDate As String)
        Dim Total_Days As Integer = DateDiff(DateInterval.Day, CDate(AgeDate), Date.Now.Date)
        If Total_Days < 31 Then
            TextBox5.Text = Total_Days
            DropDownList_BIndicator.SelectedValue = "Days"
        ElseIf Total_Days > 31 And Total_Days < 365 Then
            TextBox5.Text = CInt(Total_Days / 31)
            DropDownList_BIndicator.SelectedValue = "Month"
        ElseIf Total_Days > 365 Then
            TextBox5.Text = CInt(Total_Days / 365)
            DropDownList_BIndicator.SelectedValue = "Years"
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Add("emp_id", Session("emp_id"))
        If Page.IsPostBack = False Then
            DropDownList_Country.DataBind()
            DropDownList_Province.DataBind()
            DropDownList_Department.DataBind()
            DropDownList_District.DataBind()
            DropDownList_Gender.DataBind()
            DropDownList_Tehsil.DataBind()
            DropDownList_BIndicator.DataBind()
            Patient_Info()
        End If
    End Sub

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click
        Try
            DateOfBirth()
            HiddenFieldPFName.Value = enc.Encrypt_Main(TextBox_PFName.Text, True)
            HiddenFieldPMName.Value = enc.Encrypt_Main(TextBox_PLName.Text, True)
            SqlDataSourceUpdate.Update()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub DateOfBirth()
        Try
            If TextBox5.Text = "" Then
                Response.Write("Please Enter Age")
                Exit Sub
            Else
                If DropDownList_BIndicator.SelectedItem.Text = "Years" Then
                    HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Year, -(CInt(TextBox5.Text)), Date.Now)
                ElseIf DropDownList_BIndicator.SelectedItem.Text = "Months" Then
                    HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Month, -(CInt(TextBox5.Text)), Date.Now)
                ElseIf DropDownList_BIndicator.SelectedItem.Text = "Days" Then
                    HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Day, -(CInt(TextBox5.Text)), Date.Now)
                ElseIf DropDownList_BIndicator.SelectedItem.Text = "Hours" Then
                    HiddenField_Date_Of_Birth.Value = DateAdd(DateInterval.Hour, -(CInt(TextBox5.Text)), Date.Now)
                End If
            End If
        Catch ex As Exception
            'Response.Write("PLease Enter Age")
        End Try
    End Sub
End Class
