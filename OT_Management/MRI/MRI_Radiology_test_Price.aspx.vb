Imports System.Data
Imports System.Data.SqlClient
Partial Class MRI_Radiology_test_Price
    Inherits System.Web.UI.Page
    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim Grand_total As Integer = 0
            For i As Integer = 0 To GridView5.Rows.Count - 1
                Grand_total = Grand_total + CInt(GridView5.Rows(i).Cells(5).Text)
            Next
            TextBox_Grand_total.Text = Grand_total
            Check_Discount()
            Try
                Label_Message.Text = ""
                If TextBox_Grand_discount.Text <> 0 Then
                    Dim count As Integer = 0
                    For i As Integer = 0 To GridView5.Rows.Count - 1
                        count = count + CInt(GridView5.Rows(i).Cells(5).Text)
                        'CInt(TextBox_Grand_discount.Text)
                    Next
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    End If
                    TextBox_Grand_total.Text = count - CInt(TextBox_Grand_discount.Text)
                End If
            Catch ex As Exception
                Label_Message.Text = "Enter Integer in Discount "
                Exit Sub
            End Try
            'If TextBoxDescription.Text = "" Then
            '    Label_Message.Text = "Please Enter Description "
            '    Exit Sub
            'End If
            'HiddenField_Appointment_Date.Value = WebDateChooser_Select_Date.Text
            'HiddenFieldAppointment_Time.Value = WebDateTimeEdit1.Text
            'Dim Date_Report As Date = HiddenField_Appointment_Date.Value
            'HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CType(TextBox_next_Date.Text, Double), Date_Report)
            Insert_Values()
            For i As Integer = 0 To GridView5.Rows.Count - 1
                Dim hid_fee As HiddenField = GridView5.Rows(i).FindControl("HiddenFieldPrice")
                Dim hid_RID As HiddenField = GridView5.Rows(i).FindControl("HiddenField_RID")
                Dim txt_fee As TextBox = GridView5.Rows(i).FindControl("TextBox_Discount")
                ' Response.write(hid_fee.value) '& txt_fee.text)
                If (hid_fee.Value = "") Then
                    hid_fee.Value = 0
                End If
                If (txt_fee.Text = "") Then
                    txt_fee.Text = 0
                End If
       
                If CType(hid_fee.Value, Double) < CType(txt_fee.Text, Double) Then
                    Label_Message.Text = "Discount Amount  Is greater Then The Original Fee "
                    Exit Sub
                Else
                    HiddenField_Radiology_ID.Value = hid_RID.Value
                    HiddenField_Total_Fee.Value = hid_fee.Value
                    HiddenField_Discount.Value = txt_fee.Text
                    HiddenField_Fee_Paid.Value = CType(hid_fee.Value, Double) - CType(txt_fee.Text, Double)
                    'Response.Write(HiddenField_Fee_Paid.Value)
                    Try
                        If CInt(TextBox_Grand_discount.Text = 0) Or TextBox_Grand_discount.Text.Trim = "" Then

                        Else
                            HiddenField_Discount.Value = 0
                            HiddenField_Fee_Paid.Value = HiddenField_Total_Fee.Value
                        End If
                        HiddenField2.Value = HiddenField1.Value - HiddenField3.Value
                        SqlDataSourceForGrid.Insert()

                        'SqlDataSource_aPPONTMENT.Insert()
                    Catch ex As Exception
                        Response.Write(ex.Message & "one")
                    End Try
                End If

            Next
            SqlDataSource1.Insert()
            Update_Status()
            Today_Amount_total()
            Response.Redirect("TestFeeRep.aspx")
            'Response.Redirect("Patient_Search.aspx?DEF=1.1")
        Catch ex As Exception
            Response.Write(ex.Message & "TWO")
        End Try

    End Sub
    Function Check() As Boolean
        Try
            If TextBox_Grand_discount.Text <> 0 Then
                Dim i As Integer = CInt(TextBox_Grand_discount.Text)
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "

        End Try

    End Function
    Sub Insert_Values()
        Try
            'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            'Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_Patient_next_Appointment", con)
            'mycommand.CommandType = Data.CommandType.StoredProcedure
            'Dim param As System.Data.SqlClient.SqlParameter
            'param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
            'param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
            'param = mycommand.Parameters.AddWithValue("@Next_App_Date", HiddenField_Appointment_Date.Value)
            'param = mycommand.Parameters.AddWithValue("@Next_App_Time", HiddenFieldAppointment_Time.Value)
            'param = mycommand.Parameters.AddWithValue("@Report_Deliverd", HiddenField_Report_Date.Value)
            'param = mycommand.Parameters.AddWithValue("@Grand_Discount", TextBox_Grand_discount.Text)
            'param = mycommand.Parameters.AddWithValue("@Description", TextBoxDescription.Text)
            'param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
            'mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
            'mycommand.Connection.Open()
            'mycommand.ExecuteNonQuery()
            'HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
            'mycommand.Connection.Close()


            '''''''''''''''===================================''''''''''''''''''''
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_Select_ID", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@Reg_No", Session("RegistrationNo"))
            mycommand.Parameters.Add("@identity1", SqlDbType.Int)
            mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            ' Response.Write(mycommand.Parameters("@identity1").Value & "Value ")
            HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
            mycommand.Connection.Close()
            '''''''''''''''===================================''''''''''''''''''''
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Add("YearlyNo", Request.QueryString("PayID"))
            Session.Add("RegistrationNo", Request.QueryString("RegNo"))
            Session.Add("Main_Id", HiddenFieldMain_ID.Value)

            Insert_Values()
            'Response.Write(Session("RegistrationNo") & Session("YearlyNo"))
            Today_Amount_total()
            ' ButtonSave.Attributes.Add("onClick", "return Check_Validation()")
            If Page.IsPostBack = False Then
                GridView5.DataBind()
                Dim Grand_total As Integer = 0
                For i As Integer = 0 To GridView5.Rows.Count - 1
                    Grand_total = Grand_total + CInt(GridView5.Rows(i).Cells(5).Text)
                Next
                TextBox_Grand_total.Text = Grand_total
                HiddenField1.Value = Grand_total
                WebDateTimeEdit1.Value = Date.Now
                'WebDateChooser_Select_Date.Value = Date.Now
                'WebDateChooser_Select_Date.MinDate = Date.Now
            End If

        Catch ex As Exception
            Response.Write(ex.Message & "fdsfsdfs")
        End Try

        'ButtonSave.Attributes.Add("onClick", "return Checks()")
    End Sub

    Protected Sub TextBox_Grand_discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Grand_discount.TextChanged
        Dim count As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView5.Rows.Count - 1
                    count = count + CInt(GridView5.Rows(i).Cells(5).Text)
                Next
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - per_discount
                    End If
                End If

            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
            Exit Sub
        End Try
        'If DropDownList_Discount_Type.SelectedValue = "Rs." Then
        '    TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - CInt(TextBox_Grand_discount.Text)
        'ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
        '    Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
        '    TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - per_discount
        'End If
    End Sub

    Sub Check_Discount()
        If TextBox_Grand_discount.Text <> 0 Then
            TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - CInt(TextBox_Grand_discount.Text)
            HiddenField3.Value = TextBox_Grand_total.Text
        ElseIf TextBox_Grand_discount.Text.Trim = "" Or TextBox_Grand_discount.Text = 0 Then
            Dim discount As Double = 0
            For i As Integer = 0 To GridView5.Rows.Count - 1
                Dim txt_fee As TextBox = GridView5.Rows(i).FindControl("TextBox_Discount")
                discount = discount + CType(txt_fee.Text, Double)
            Next
            TextBox_Grand_total.Text = CType(TextBox_Grand_total.Text, Double) - discount
            HiddenField3.Value = TextBox_Grand_total.Text
        End If
    End Sub

    Protected Sub GridView5_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView5.RowDeleted
        GridView5.DataBind()
        Dim Grand_total As Integer = 0
        For i As Integer = 0 To GridView5.Rows.Count - 1
            Grand_total = Grand_total + CInt(GridView5.Rows(i).Cells(5).Text)
        Next
        TextBox_Grand_total.Text = Grand_total
    End Sub
    'SELECT MRI_Finance.TOtal_Discount, MRI_Finance.Total_Paid, MRI_Finance.Total_AMount FROM MRI_Save_Patient_Next_App INNER JOIN MRI_Finance ON MRI_Save_Patient_Next_App.Main_Id = MRI_Finance.Main_ID WHERE (CONVERT(varchar, MRI_Save_Patient_Next_App.Visit_Date, 107) = CONVERT(Varchar, GETDATE(), 107))
    Sub Today_Amount_total()
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Sum(MRI_Finance.TOtal_Discount), Sum(MRI_Finance.Total_Paid), Sum(MRI_Finance.Total_AMount) FROM MRI_Save_Patient_Next_App INNER JOIN MRI_Finance ON MRI_Save_Patient_Next_App.Main_Id = MRI_Finance.Main_ID WHERE (CONVERT(varchar, MRI_Save_Patient_Next_App.Visit_Date, 107) = CONVERT(Varchar, GETDATE(), 107))", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Connection.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "abc")
        TextBox_Total_Discount.Text = ds.Tables(0).Rows(0).Item(0).ToString
        TextBox_Total_Recieve.Text = ds.Tables(0).Rows(0).Item(1).ToString
        TextBox_Amount.Text = ds.Tables(0).Rows(0).Item(2).ToString
        mycommand.Connection.Close()

    End Sub

    Sub Update_Status()
        Try
            ' Response.Write("sfdfds jsidflkjdsl jdskl flksjklfjdlkdsj lkdsjfdls ")
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update MRI_Save_Patient_Next_App set fee_paid = 1 where (Main_ID = " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub ButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonReport.Click
        'CrystalReportViewer1.LogOnInfo.Item(0).ConnectionInfo.Password = "123"
        ''CrystalReportSource1.Report.Parameters.Item(0).DefaultValue = Session("registrationNo")
        ''CrystalReportSource1.Report.Parameters.Item(1).DefaultValue = Session("YearlyNo")
        'HiddenField_Reg.value = Session("registrationNo")
        'HiddenField_Yearly.value = Session("YearlyNo")
        'response.write(HiddenField_Reg.value)
        'response.write(HiddenField_Yearly.value)
        ''CrystalReportViewer1.RefreshReport()
        response.redirect("TestFeeRep.aspx")
    End Sub

    Protected Sub DropDownList_Discount_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Discount_Type.SelectedIndexChanged
        Dim count As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView5.Rows.Count - 1
                    count = count + CInt(GridView5.Rows(i).Cells(5).Text)
                Next
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - per_discount
                    End If
                End If
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
            Exit Sub
        End Try
    End Sub
End Class
