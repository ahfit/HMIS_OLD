Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Recieve_Sample
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Protected Sub GridView_Sample_Recieved_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Sample_Recieved.PreRender
        For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
            Dim lbl As Label = GridView_Sample_Recieved.Rows(i).FindControl("Label_SrNo")
            lbl.Text = i + 1
        Next
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        If GridView_Sample_Recieved.Rows.Count <> 0 Then
            Insert_Values()
        End If
        For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            Dim Hid_TB_ID As HiddenField = GridView_Sample_Recieved.Rows(i).FindControl("HiddenField_TB_ID")
            If check.Checked = True Then
                Insert_Test_Services(Hid_TB_ID.Value)
            End If
        Next
        '----------------------------
        ' Response.Write(HiddenFieldMain_ID.Value)
        Try
            SqlDataSource_Integration.Insert()
        Catch ex As Exception

        End Try

        GridView_Sample_Recieved.DataBind()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT     Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN  Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No")) 'Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo")) ' Session("YearlyNo"))
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
                    mycommand2.Parameters.AddWithValue("@PayID", Request.QueryString("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()

            Try
                HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
                SqlDataSource_PatientServices.Insert()
            Catch ex As Exception

            End Try
            Payment_Button_Save()
            update_Test_Booking_Status(13)

            'Response.Write("<Script language='Janvascript' type='text/javascript'>window.open('../adminmain.aspx','_top');</script>")
            'Response.Redirect("Pathology_Payment.aspx")
        Catch ex As Exception
            'Response.Write(ex.Message & " Insert Test ")
        End Try

    End Sub
    Public Sub update_Test_Booking_Status(ByVal Status As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Update_Test_Booking_Status", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Connection.Open()
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@Status", Status)

        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()


    End Sub
    Sub Button_Move_Next_function()
        Try
            Dim SDate As Date = Date.Now
            'Insert_Values()
        Catch ex As Exception
            '  Response.Write(ex.Message & " Insert Values 826")
        End Try
    End Sub

    Sub Insert_Values()
        Dim SDate As Date = Date.Now 'WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        Dim report_date As Date = DateAdd(DateInterval.Day, 1, Date.Now)
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Request.QueryString("Reg_No"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Request.QueryString("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", SDate)
        param = mycommand.Parameters.AddWithValue("@Sample_No", Request.QueryString("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", report_date)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", 0)
        param = mycommand.Parameters.AddWithValue("@Description", "")
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", 1)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", Session("Order_ID"))
        param = mycommand.Parameters.AddWithValue("@From_Dept_ID", Request.QueryString("FromDept_Id"))
        param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", Request.QueryString("FromSubDept_ID"))
        param = mycommand.Parameters.AddWithValue("@To_Dept_ID", Session("Dept_ID"))
        param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", Session("SubDeptID"))
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Sub Payment_Button_Save()
        Try
            Dim RegNo As String = Request.QueryString("Reg_No")
            Dim YearlyNo As Integer = Request.QueryString("YearlyNo")
            HiddenFieldTotalAmount.Value = 0 ' CInt(TextBox_Grand_total.Text)
            HiddenFieldTotalPaid.Value = 0 'CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            HiddenFieldTotal_Discount.Value = 0 'TotalDiscount()
            HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
            Insert_Test_Info()
            SqlDataSourceInsertSub.Insert()
            Update_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            ' Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update Path_Result_Delivery set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            '  Response.Write(ex.Message & "update_status")
        End Try
    End Sub

    Sub Insert_Test_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE  (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo"))
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
                    mycommand2.Parameters.AddWithValue("@Yearly_No", Request.QueryString("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@RID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@Reg_No", Request.QueryString("Reg_No")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            '  Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Test_Services(ByVal TB_ID As Integer)
        Try
            Dim Status As Integer = 1
            'If RadioButtonList1.SelectedValue = "Sample To Come" Then
            '    Status = 2
            'End If
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("INsert_Test_Booking_Services", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo"))
            mycommand.Parameters.AddWithValue("@TB_ID", TB_ID)
            mycommand.Parameters.AddWithValue("@Status", Status)
            mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMain_ID.Value)
            con.Open()
            mycommand.ExecuteNonQuery()
            con.Close()
            '==========================================================
            HiddenField_integrationMain_Id.Value = HiddenFieldMain_ID.Value
        Catch ex As Exception
            ' Response.Write(ex.Message & " Insert Test Services ")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Add("registrationNo", Request.QueryString("Reg_No"))
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
        Session.Add("Order_ID", Request.QueryString("Order_id"))
        TextBox_Sample_number.Text = Request.QueryString("YearlyNo")
    End Sub

    Protected Sub Button_Check_All_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Check_All.Click
        For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            check.Checked = True
        Next
    End Sub

    Protected Sub Button_Uncheck_All_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Uncheck_All.Click
        For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            check.Checked = False
        Next
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If GridView_Sample_Recieved.Rows.Count <> 0 Then
            Insert_Values()
        End If
        For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            Dim Hid_TB_ID As HiddenField = GridView_Sample_Recieved.Rows(i).FindControl("HiddenField_TB_ID")
            If check.Checked = True Then
                Insert_Test_Services(Hid_TB_ID.Value)
            End If
        Next
        '----------------------------
        ' Response.Write(HiddenFieldMain_ID.Value)
        Try
            SqlDataSource_Integration.Insert()
        Catch ex As Exception

        End Try

        GridView_Sample_Recieved.DataBind()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT     Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN  Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No")) 'Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo")) ' Session("YearlyNo"))
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
                    mycommand2.Parameters.AddWithValue("@PayID", Request.QueryString("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Request.QueryString("Reg_No")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()

            Try
                HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
                SqlDataSource_PatientServices.Insert()
            Catch ex As Exception

            End Try
            Payment_Button_Save()
            update_Test_Booking_Status(14)

            'Response.Write("<Script language='Janvascript' type='text/javascript'>window.open('../adminmain.aspx','_top');</script>")
            'Response.Redirect("Pathology_Payment.aspx")
        Catch ex As Exception
            'Response.Write(ex.Message & " Insert Test ")
        End Try

    End Sub
End Class
