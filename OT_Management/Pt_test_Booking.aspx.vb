Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_test_Booking
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication

    '==============================
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        'Dim ID As String = GridView1.SelectedValue
        Dim HID_ID As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_ID")
        Dim HID_Name As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Name")
        Dim HID_Sample As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Sample")
        Dim HID_Rate As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Rate")
        Dim HID_Day As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Day")
        Dim HID_Time As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Time")
        Dim date_time As String = DateAdd(DateInterval.Day, CInt(HID_Day.Value), Date.Now.Date) & " " & HID_Time.Value
        Populate_Temp_Grid(HID_Name.Value, HID_Sample.Value, HID_Rate.Value, HID_ID.Value, date_time)
        TotalDiscount()
        Dim count As Integer = 0
        If GridView_TemP_Test.Rows.Count > 0 Then
            For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
                'Response.Write(GridView_TemP_Test.Rows(i).Cells(4).Text & "dfdfds ")
            Next
            TextBox_Grand_total.Text = count + CInt(Label_other_Charges.Text)
            'TextBox_Total_Price.Text = count + CInt(Label_other_Charges.Text)
            'TextBox_Total.Text = count
            GridView_TemP_Test.FooterRow.Cells(4).Text = count
        End If
    End Sub

    Sub Populate_Temp_Grid(ByVal Name As String, ByVal Sample As String, ByVal Rate As String, ByVal Id As String, ByVal Date_Time As String)
        Dim ds As New Pt_Radiology_Test
        Dim row As DataRow

        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            row = ds.Tables("Temp_Test").NewRow
            row.Item("TestName") = GridView_TemP_Test.Rows(x).Cells(1).Text
            row.Item("id") = GridView_TemP_Test.Rows(x).Cells(2).Text
            row.Item("Sample") = GridView_TemP_Test.Rows(x).Cells(3).Text
            row.Item("Rate") = CInt(GridView_TemP_Test.Rows(x).Cells(4).Text)
            row.Item("Date") = GridView_TemP_Test.Rows(x).Cells(5).Text
            ds.Tables("Temp_Test").Rows.Add(row)
        Next
        row = ds.Tables("Temp_Test").NewRow
        row.Item("TestName") = Name
        row.Item("id") = Id
        row.Item("Sample") = Sample
        row.Item("Rate") = Rate
        row.Item("Date") = Date_Time
        ds.Tables("Temp_Test").Rows.Add(row)
        GridView_TemP_Test.DataSource = ds.Tables("Temp_Test")
        GridView_TemP_Test.DataBind()
        Try
            'If GridView_TemP_Test.Rows.Count - 1 Then
            '    GridView_TemP_Test.HeaderRow.Cells(2).Visible = False
            '    GridView_TemP_Test.HeaderRow.Cells(3).Text = "Sample Required By Test"
            '    For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            '        GridView_TemP_Test.Rows(i).Cells(2).Visible = False
            '    Next
            'End If
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub GridView_TemP_Test_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.PreRender
        Try
            If GridView_TemP_Test.Rows.Count - 1 Then
                GridView_TemP_Test.HeaderRow.Cells(2).Visible = False
                GridView_TemP_Test.HeaderRow.Cells(3).Text = "Sample Required By Test"
                GridView_TemP_Test.FooterRow.Cells(2).Visible = False
                GridView_TemP_Test.FooterRow.Cells(3).Text = "Total "
                For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                    GridView_TemP_Test.Rows(i).Cells(2).Visible = False
                Next

            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView_TemP_Test_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.SelectedIndexChanged
        Dim HID_ID As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_ID")
        Dim HID_Name As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Name")
        Dim HID_Sample As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Sample")
        Dim HID_Rate As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Rate")
        Grid_Delete(HID_Name.Value, HID_Sample.Value, HID_Rate.Value, HID_ID.Value)
        Dim count As Integer = 0
        For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
        Next
        GridView_TemP_Test.FooterRow.Cells(4).Text = count
        TextBox_Grand_total.Text = count
        TotalDiscount()
    End Sub

    Sub Grid_Delete(ByVal Name As String, ByVal Sample As String, ByVal Rate As String, ByVal Id As String)
        Dim ds As New Pt_Radiology_Test
        Dim row As DataRow
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            If GridView_TemP_Test.SelectedIndex = x Then
                Continue For
            End If
            row = ds.Tables("Temp_Test").NewRow
            row.Item("TestName") = GridView_TemP_Test.Rows(x).Cells(1).Text
            row.Item("id") = GridView_TemP_Test.Rows(x).Cells(2).Text
            row.Item("Sample") = GridView_TemP_Test.Rows(x).Cells(3).Text
            row.Item("Rate") = GridView_TemP_Test.Rows(x).Cells(4).Text
            row.Item("Date") = GridView_TemP_Test.Rows(x).Cells(5).Text
            ds.Tables("Temp_Test").Rows.Add(row)
        Next
        GridView_TemP_Test.DataSource = ds.Tables("Temp_Test")
        GridView_TemP_Test.DataBind()
    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Dim YearlyNo As Integer = Insert_Payment_table()
        If YearlyNo = 0 Then
            Label_Message.ForeColor = Drawing.Color.Red
            Label_Message.Text = "Record not Save"
            Exit Sub
        End If
        Dim ds As New Pt_Radiology_Test
        For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            Insert_Test_Services(CInt(GridView_TemP_Test.Rows(i).Cells(2).Text), CInt(GridView_TemP_Test.Rows(i).Cells(4).Text))
        Next
        For j As Integer = 0 To GridView12.Rows.Count - 1
            Insert_Pt_Other_Charges(GridView12.Rows(j).Cells(1).Text, GridView12.Rows(j).Cells(2).Text, YearlyNo)
        Next
        Select_Sample_No()
        INsert_Test()
        Session.Remove("RegistrationNo")
        Session.Remove("YearlyNo")
        'Page.ClientScript.RegisterStartupScript("onclick", "Testfeereport.aspx")
        'Response.Write("<script language='javascript'>alert('Current Visit Number of The patient Is ' + " & YearlyNo & ");</script>")
        Response.Redirect("Pt_Test_Booking.aspx")
        'Response.Redirect(Session("MainPage"))
    End Sub

    Function Insert_Payment_table() As Integer
        Dim YearlyNo As Integer = 0
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_registration_Sub", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo")) 'ENC.Encrypt_Main(ENC.TitleCase(textboxpmname.Text), True))
            mycommand.Parameters.AddWithValue("@DeptID", Session("Dept_ID"))
            mycommand.Parameters.AddWithValue("@EmpID", Session("Emp_ID")) 'ENC.Encrypt_Main(ENC.TitleCase(textboxpfname.Text), True))

            mycommand.Parameters.AddWithValue("@Reffered_By", DropDownList_Reffer.SelectedValue) 'ENC.Encrypt_Main(ENC.TitleCase(textboxpmname.Text), True))
            mycommand.Parameters.AddWithValue("@Consultant", DropDownList_Consultant.SelectedValue)
            mycommand.Parameters.AddWithValue("@Lab_ID", Session("Dept_ID")) ' DropDownList_Lab.SelectedValue)
            mycommand.Parameters.AddWithValue("@Sample_Collect_At", RadioButtonList1.SelectedValue)

            mycommand.Parameters.AddWithValue("@paymentid", HiddenField_YearlyNo.Value)
            'mycommand.Parameters("@paymentid").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            Session.Add("YearlyNo", mycommand.Parameters("@paymentid").Value)
            YearlyNo = HiddenField_YearlyNo.Value  'mycommand.Parameters("@paymentid").Value
        Catch ex As Exception
            'Response.Write(ex.Message & "Insert_Payemnt")
        End Try
        Return YearlyNo
    End Function
    Sub Insert_Pt_Other_Charges(ByVal Description As String, ByVal Rate As Integer, ByVal YearlyNo As Integer)
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Other_Charges", con) ' "select RegNo from Patient where (RegNo = @name )", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure

        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo")) 'ENC.Encrypt_Main(ENC.TitleCase(textboxpmname.Text), True))
        mycommand.Parameters.AddWithValue("@YearlyNo", YearlyNo)
        mycommand.Parameters.AddWithValue("@Description", Description)
        mycommand.Parameters.AddWithValue("@Rate", Rate)
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()
    End Sub

    Sub Select_Sample_No()
        TextBox_Sample_number.Text = Session("YearlyNo")
    End Sub

    Sub Insert_Test_Services(ByVal TB_ID As Integer, ByVal Price As Integer)
        Try
            Dim Status As Integer = 1
            If RadioButtonList1.SelectedValue = "Sample To Come" Then
                Status = 2
            End If
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("INsert_Test_Booking_Services", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
            mycommand.Parameters.AddWithValue("@Status", Status)
            mycommand.Parameters.AddWithValue("@Price", Price)
            con.Open()
            mycommand.ExecuteNonQuery()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Insert Test Services ")
        End Try
    End Sub

    Sub INsert_Test()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_ID from Test_Booking_Services Where RegNo = @RegNo and YearlyNo = @YearlyNo ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            ''''''''''''''''Dim ds As New Pt_Radiology_Test
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Insert Test ")
        End Try

        Dim Counter As Integer = 0
        If GridView_TemP_Test.Rows.Count > 0 Then
            Counter = 1
        End If
        If Counter <> 0 Then
            '    Button_Move_Next.Visible = True
            Button_Move_Next_function()
        End If
        Payment_Button_Save()
        'Main_Group()
    End Sub

    Sub Button_Move_Next_function()
        Try
            Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
            HiddenField_Sample_collection.Value = SDate
            If DropDownList1.SelectedValue = "Days" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
            ElseIf DropDownList1.SelectedValue = "Hours" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
            End If
            Insert_Values()
            ''''''''''''''''''''Response.Redirect("Pathology_Payment.aspx")

        Catch ex As Exception
            Response.Write(ex.Message & " Insert Values 826")
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
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", HiddenField_Sample_collection.Value)
        param = mycommand.Parameters.AddWithValue("@Sample_No", TextBox_Sample_number.Text)
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", HiddenField_Report_Date.Value)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", TextBox_Grand_discount.Text)
        param = mycommand.Parameters.AddWithValue("@Description", "")
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", 1)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Sub Payment_Button_Save()
        Try
            Dim RegNo As String = Session("registrationNo")
            Dim YearlyNo As Integer = Session("YearlyNo")
            HiddenFieldTotalAmount.Value = CInt(TextBox_Grand_total.Text)
            HiddenFieldTotalPaid.Value = CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            HiddenFieldTotal_Discount.Value = TotalDiscount()
            HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
            Insert_Test_Info()

            SqlDataSourceInsertSub.Insert()
            Update_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Protected Sub DropDownList_Discount_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Discount_Type.SelectedIndexChanged
        TotalDiscount()
    End Sub

    Function TotalDiscount() As Integer
        Dim count As Integer = 0
        Dim total_Discount As Integer = 0
        Try
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                    count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
                Next
                count = count + CInt(Label_other_Charges.Text)
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then
                    Else
                        total_Discount = CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        total_Discount = CInt(per_discount)
                    End If
                End If
            End If
            If TextBox_Grand_discount.Text = 0 Then
                For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                    count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
                Next
                count = count + CInt(Label_other_Charges.Text)
                TextBox_Grand_total.Text = count
                TextBox_Total_Price.Text = count
            End If
            TextBox_Total_Price.Text = count - total_Discount
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Return total_Discount
    End Function

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update MRI_Save_Patient_Next_App set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "update_status")
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From MRI_Save_Patient_Next_App where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Test_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_ID from Test_Booking_Services Where RegNo = @RegNo and YearlyNo = @YearlyNo ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("Insert_Pt_Pathology_Test_Amount", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@RID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@Reg_No", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Main_ID(Session("registrationNo"), Session("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub loginvalidate()
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            'Label_message.ForeColor = Drawing.Color.Red
            'Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loginvalidate()
        Dim obj As New DrawMenu
        obj.draw_menu(PanelMenu)
        LabelHeader.Text = obj.Employee_Info()
        If Page.IsPostBack = False Then
            Label_VisitNo.Text = ""
            DropDownList_Lab.DataBind()
            Label_VisitNo.Text = "Your Visit Number is <bold>" & Get_Visit_Number() & "</bold>"
            Response.Write("<script language='javascript' type ='text/javascript'> function Other_Charges() {document.getElementById('DIV_Other').style.display='block';})</script>")
        End If
        If Session("RegistrationNo") <> "" Then
            ButtonSave.Visible = True
            Button_Report.Visible = True
        Else
            ButtonSave.Visible = False
            Button_Report.Visible = False
            'Record_Search()
        End If
    End Sub

    Protected Sub TextBox_Grand_discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Grand_discount.TextChanged
        TotalDiscount()
    End Sub

    Protected Sub Button_RegNo_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_RegNo_Search.Click
        Record_Search()
    End Sub
    Sub Record_Search()
        Try
            Dim RegNo As String = ""
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select RegNo From Patient where RegNo= '" & TextBox_RegNo.Text & "'", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            RegNo = mycommand.ExecuteScalar
            If RegNo <> "" Then
                Session("RegistrationNo") = RegNo
                ButtonSave.Visible = True
                Button_Report.Visible = True
                Label_Message.ForeColor = Drawing.Color.Green
                Label_Message.Text = " Record Found "
            Else
                Session.Remove("RegistrationNo")
                Label_Message.ForeColor = Drawing.Color.Red
                Label_Message.Text = " Record Not Found "
                ButtonSave.Visible = False
                Button_Report.Visible = False
            End If
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
    End Sub

    Protected Sub Button_Other_Charges_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub GridView12_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView12.SelectedIndexChanged
        Dim ds As New Pt_Radiology_Test
        Dim row As DataRow
        'Response.Write(Name & Sample & Rate & Id & "dfds fds fsd") 
        For x As Integer = 0 To GridView12.Rows.Count - 1
            If GridView12.SelectedIndex = x Then
                Continue For
            End If
            row = ds.Tables("Temp_Other_Charges").NewRow
            row.Item("Description") = GridView12.Rows(x).Cells(1).Text
            row.Item("Rate") = GridView12.Rows(x).Cells(2).Text
            ds.Tables("Temp_Other_Charges").Rows.Add(row)
        Next
        GridView12.DataSource = ds.Tables("Temp_Other_Charges")
        GridView12.DataBind()
    End Sub
    Sub Populate_Grid(ByVal Description As String, ByVal Rate As String)
        Dim ds As New Pt_Radiology_Test
        Dim row As DataRow
        'Response.Write(Name & Sample & Rate & Id & "dfds fds fsd") 
        For x As Integer = 0 To GridView12.Rows.Count - 1
            row = ds.Tables("Temp_Other_Charges").NewRow
            row.Item("Description") = GridView12.Rows(x).Cells(1).Text
            row.Item("Rate") = GridView12.Rows(x).Cells(2).Text
            ds.Tables("Temp_Other_Charges").Rows.Add(row)
        Next
        row = ds.Tables("Temp_Other_Charges").NewRow
        row.Item("Description") = Description
        row.Item("Rate") = Rate
        ds.Tables("Temp_Other_Charges").Rows.Add(row)
        GridView12.DataSource = ds.Tables("Temp_Other_Charges")
        GridView12.DataBind()
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Populate_Grid(TextBox_Description.Text, TextBox_Rate.Text)
    End Sub

    Protected Sub Button_Done_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Response.Write("fsdgjdfjgfdsj fdsjlksfdjkgl jflkjg")
        Dim count As Integer = 0
        For i As Integer = 0 To GridView12.Rows.Count - 1
            count = count + GridView12.Rows(i).Cells(2).Text
            Label_other_Charges.Text = Label_other_Charges.Text
        Next
        Dim count_total As Integer = 0
        For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            count_total = count_total + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
        Next
        Label_other_Charges.Text = count
        TextBox_Grand_total.Text = count + count_total
        TotalDiscount()

    End Sub

    Protected Sub TextBox_Name_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        ' GridView1.DataBind()
    End Sub

    'Protected Sub DropDownList_Lab_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Label_VisitNo.Text = "Your Visit Number Is " & Get_Visit_Number()
    'End Sub
    Function Get_Visit_Number() As String
        Dim Visit_No As String = ""

        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_Get_Yearly_No", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@DeptID", Session("Dept_ID")) 'DropDownList_Lab.SelectedValue)
        mycommand.Parameters.Add("@YearlyNo", SqlDbType.Int)
        mycommand.Parameters("@YearlyNo").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        Visit_No = mycommand.Parameters("@YearlyNo").Value
        HiddenField_YearlyNo.Value = Visit_No
        mycommand.Connection.Close()
        Return Visit_No
    End Function

    'Protected Sub DropDownList_Lab_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Lab.SelectedIndexChanged
    '    Label_VisitNo.Text = "Your Visit Number Is " & Get_Visit_Number()
    'End Sub

    Protected Sub Button_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim YearlyNo As Integer = Insert_Payment_table()
        If YearlyNo = 0 Then
            Label_Message.ForeColor = Drawing.Color.Red
            Label_Message.Text = "Record not Save"
            Exit Sub
        End If
        Dim ds As New Pt_Radiology_Test
        For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            Insert_Test_Services(CInt(GridView_TemP_Test.Rows(i).Cells(2).Text), CInt(GridView_TemP_Test.Rows(i).Cells(4).Text))
        Next
        For j As Integer = 0 To GridView12.Rows.Count - 1
            Insert_Pt_Other_Charges(GridView12.Rows(j).Cells(1).Text, GridView12.Rows(j).Cells(2).Text, YearlyNo)
        Next
        Select_Sample_No()
        INsert_Test()
        'Session.Remove("RegistrationNo")
        'Session.Remove("YearlyNo")
        'Page.ClientScript.RegisterStartupScript("onclick", "Testfeereport.aspx")

        Response.Redirect("Pathology Reports/Patient_Test_Fee_Report.aspx")
        'Response.Redirect(Session("MainPage"))
    End Sub
End Class
