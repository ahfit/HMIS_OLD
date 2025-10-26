Imports System.Data
Imports System.Data.SqlClient
Partial Class Indoor_Patient_Payment_For_Nurse
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim b As String = ""
    Dim c As String = ""
    Dim d As String = ""
    Dim total_amount As Integer = 0
    Dim Bal_Amount As Integer = 0
    Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim conStrReg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim con_path As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
    Dim con_Radiology As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
    Dim voucher As New voucher_insertion
    Dim constring1 As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim Procedurename As String = "Temp_insert_Reciept_Voucher_payment"
    Dim Cash_val, Cheque_val, Credit_Card_val As Integer
    Dim co As New Coma
    Dim paid_by As Int32

    Sub for_xray()

        Try


            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = con_Radiology
            command = connection.CreateCommand
            command.CommandText = " SELECT     ISNULL(Test_Booking.TB_ID, '') AS Expr1, Patient_Services.S_ID, Test_Booking.MG_ID, TestGroup.Dept_Id, TestGroup.SubDept_Id as Sub_Dept_ID, Patient_Services.ID FROM         Test_Booking INNER JOIN Patient_Services ON Test_Booking.S_Id = Patient_Services.S_ID INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE     (Patient_Services.YearlyNo =" + Session("YearlyNo") + ") AND (Patient_Services.Order_Id IS NULL) AND (Patient_Services.Payment_Status = 0) order by TestGroup.Dept_Id "
            connection.Open()
            reader = command.ExecuteReader
            While reader.Read

                HiddenField_TB_ID.Value = reader.Item(0)
                HiddenField_S_ID.Value = reader.Item(1)
                HiddenField_Mg_ID.Value = reader.Item(2)
                Try
                    HiddenField_To_Dept_ID.Value = reader.Item(3)
                    HiddenField_To_Sub_Dept_ID.Value = reader.Item(4)
                    HiddenField_P_SID.Value = reader.Item(5)
                Catch ex As Exception

                End Try


                SqlDataSource_test_Booking_Radiology.Insert()

            End While
            reader.Close()

            connection.Close()
            SqlDataSource_Radiology_test_booking.Update()
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub

    Sub for_lab()
        Try


            Dim connection As New SqlConnection
            For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
                Dim hid_order_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_order_ID")
                Dim hid_TB_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_TB_ID")
                Dim CheckBox1 As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")
                Dim doctor_Id As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_Refer_By_ID")
                Dim refer_by As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_Refer_By_Other")
                Dim Consultant_Remarks As HiddenField = GridView_For_Services.Rows(count).FindControl("hf_Consultant_Remarks")
                HiddenField_Doctor_ID.Value = doctor_Id.Value
                HiddenField_Refer_From.Value = refer_by.Value
                HiddenField_TB_ID.Value = hid_TB_ID.Value
                HiddenField_Consultant_Remarks.Value = Consultant_Remarks.Value
                If ((HiddenField_TB_ID.Value <> "") And (CheckBox1.Checked = True)) Then

                    Dim command As New SqlCommand
                    Dim reader As SqlDataReader
                    connection.ConnectionString = con_path
                    command = connection.CreateCommand
                    command.CommandText = "SELECT     ISNULL(Test_Booking.TB_ID, '') AS Expr1, Patient_Services.S_ID, Test_Booking.MG_ID, TestGroup.Dept_Id, TestGroup.SubDept_Id FROM Test_Booking INNER JOIN Patient_Services ON Test_Booking.S_Id = Patient_Services.S_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID WHERE     (Patient_Services.YearlyNo =" + Session("YearlyNo") + ") AND (Patient_Services.Order_Id IS NULL) AND (Patient_Services.Payment_Status = 0) AND (Test_Booking.TB_ID =" + hid_TB_ID.Value + ")"
                    connection.Open()
                    reader = command.ExecuteReader
                    While reader.Read
                        Try
                            Select_Sample_No()
                            HiddenField_TB_ID.Value = reader.Item(0)
                            HiddenField_S_ID.Value = reader.Item(1)
                            HiddenField_Mg_ID.Value = reader.Item(2)
                            HiddenField_Inves_SubDept_Id.Value = reader.Item(4)
                            HiddenField_Inves_Dept_Id.Value = reader.Item(3)
                            SqlDataSource_test_Booking_New.Insert()
                            Test_insert()
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        End Try

                    End While

                    reader.Close()

                    connection.Close()
                End If

            Next
            For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
                Dim hid_order_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_order_ID")
                Dim hid_TB_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_TB_ID")
                Dim CheckBox1 As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")

                HiddenField_Order_ID.Value = hid_order_ID.Value
                HiddenField_TB_ID.Value = hid_TB_ID.Value

                If ((HiddenField_TB_ID.Value <> "") And (CheckBox1.Checked = True)) Then
                    SqlDataSource_Booking.Insert()
                End If

            Next

            SqlDataSource_test_Booking_New.Update()

        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Sub Test_insert()
        Try
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(con_Radiology)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT     Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Patient_Services ON Path_Result_Delivery.Main_ID = Patient_Services.Order_Id WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Patient_Services.Order_Id IS NULL) AND (Path_Result_Delivery.Fee_paid = 0)", con)
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
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()

                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Test_insert_Radiology()
        Try
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(con_path)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Patient_Services ON Path_Result_Delivery.Main_ID = Patient_Services.Order_Id WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Fee_paid = 0)  AND (Patient_Services.Order_Id IS NULL)", con)
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
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
                    mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                    mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                    mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                    mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                    mycommand2.ExecuteNonQuery()

                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub insert_data()
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''''' for patients ''''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'Dim total_val As Double = 0.0
        'Dim sub_dept As String
        'Dim Account_Head_ID As String
        'Dim RegNo As String
        'Dim YearlyNo As String
        'Dim Amount As Double = 0.0
        'Dim main_Id As String
        'Dim Original_Amount As Int32
        'Try

        '    Dim acc_head As String = ""
        '    Dim acc_head_Cradit_Card As String = ""
        '    Dim acc_head_Cheque As String = ""
        '    Dim acc_head_panel As String = ""

        '    Dim dept As Integer
        '    If HiddenField_Patient_type.Value = "IPD" Then
        '        acc_head = "33015010001"
        '        acc_head_Cradit_Card = "33015012005"
        '        acc_head_Cheque = "33015012005"
        '        acc_head_panel = "33015008005"
        '        dept = 88


        '    Else
        '        acc_head = "33015010001"
        '        acc_head_Cradit_Card = "33015012005"
        '        acc_head_Cheque = "33015012005"
        '        acc_head_panel = "33015008005"
        '        dept = 69

        '    End If
        '    Initialize()
        '    'main_Id = voucher.insert_Main_Payment(Procedurename, constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, Session("YearlyNo"), 1, dept, Session("emp_id"), Session("emp_id"), Session("emp_id"), DropDownList_Cost_Centre.SelectedValue)
        '    Dim connection As New SqlConnection
        '    Dim command_val As New SqlCommand
        '    Dim reader As SqlDataReader
        '    Dim count_val_main As Integer

        '    connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        '    command_val = connection.CreateCommand
        '    Try


        '        If co.Remove_Coma(TextBox_Panel.Text) <> "0" Or co.Remove_Coma(TextBox_Cradit_Card.Text) <> "0" Then
        '            command_val.CommandText = " SELECT    distinct Patient_Services.SubDept_ID, Admin_Services_AccountHeads.E_Code AS Account_Head_ID, Patient_Services.RegNo, Patient_Services.YearlyNo, Patient_Services.Amount, Patient_Services.empid, Doctor_Service.Bank_Payment, Admin_Services_AccountHeads.S_Id, Patient_Services.Amount AS val FROM         Service_Payment_Main INNER JOIN Service_Payment_Sub ON Service_Payment_Main.SPM_ID = Service_Payment_Sub.SPM_ID INNER JOIN Patient_Services INNER JOIN Admin_Services_AccountHeads ON Patient_Services.S_ID = Admin_Services_AccountHeads.S_Id ON Service_Payment_Sub.S_ID = Patient_Services.S_ID LEFT OUTER JOIN Doctor_Service ON Patient_Services.Doctor_ID = Doctor_Service.Doctor_ID AND Patient_Services.S_ID = Doctor_Service.Service_ID  where Patient_Services.YearlyNo = " + Session("YearlyNo").ToString + " and Admin_Services_AccountHeads.Dept_Type='" + HiddenField_Patient_type.Value + "' and Service_Payment_Main.SPM_ID =" + HiddenField_smpID.Value

        '        Else

        '            command_val.CommandText = " SELECT     distinct Patient_Services.SubDept_ID, Admin_Services_AccountHeads.E_Code AS Account_Head_ID, Patient_Services.RegNo, Patient_Services.YearlyNo, CASE WHEN bank_payment IS NULL THEN Patient_Services.Amount ELSE (Patient_Services.Amount - Doctor_Service.charges) + Doctor_Service.Bank_Payment END AS Amount, Patient_Services.empid, Doctor_Service.Bank_Payment, Admin_Services_AccountHeads.S_Id, Patient_Services.Amount AS val FROM         Patient_Services INNER JOIN Admin_Services_AccountHeads ON Patient_Services.S_ID = Admin_Services_AccountHeads.S_Id INNER JOIN                       Service_Payment_Sub ON Patient_Services.S_ID = Service_Payment_Sub.S_ID INNER JOIN Service_Payment_Main ON Service_Payment_Sub.SPM_ID = Service_Payment_Main.SPM_ID LEFT OUTER JOIN Doctor_Service ON Patient_Services.Doctor_ID = Doctor_Service.Doctor_ID AND Patient_Services.S_ID = Doctor_Service.Service_ID   where Patient_Services.YearlyNo = " + Session("YearlyNo").ToString + " and Admin_Services_AccountHeads.Dept_Type='" + HiddenField_Patient_type.Value + "'  and Service_Payment_Main.SPM_ID =" + HiddenField_smpID.Value

        '        End If


        '        connection.Open()
        '        reader = command_val.ExecuteReader()
        '        'total_val = 0
        '        If co.Remove_Coma((TextBox2.Text)) <> "0" Or co.Remove_Coma(TextBox_Panel.Text) <> "0" Then

        '            While reader.Read
        '                sub_dept = reader.Item(0)
        '                Account_Head_ID = reader.Item(1)
        '                RegNo = reader.Item(2)
        '                YearlyNo = reader.Item(3)
        '                Amount = reader.Item(4)

        '                HiddenField_Service_ID.Value = reader.Item(7)
        '                Original_Amount = reader.Item(8)
        '                total_val = total_val + Amount
        '                If Amount <> 0 And total_val <> 0 Then
        '                    If count_val_main = 0 Then
        '                        main_Id = voucher.insert_Main_Payment(Procedurename, constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, Session("YearlyNo"), 1, dept, Session("emp_id"), Session("emp_id"), Session("emp_id"), 0)
        '                        count_val_main = 1
        '                    End If

        '                    voucher.Insert_payment(main_Id, 0, Account_Head_ID, Amount, 2, 0, " Amount of Rupees " + Convert.ToString(Amount) + " Paid by the Patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))) + " For the Service " + Convert.ToString(voucher.get_Account_Head(Account_Head_ID)), constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)

        '                End If


        '            End While
        '            reader.Close()
        '            connection.Close()
        '        End If
        '    Catch ex As Exception

        '    End Try
        '    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''refund  '''''''''''''''''''''''''''''''''''''''''''''''
        '    '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '    Dim adv As Long = 0
        '    Dim Adv_cash As Long = 0
        '    Try

        '        For count As Integer = 0 To GridView1.Rows.Count - 1
        '            Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox_checked")
        '            Dim hid_amount As HiddenField = GridView1.Rows(count).FindControl("HiddenField_Amount")
        '            Dim type As HiddenField = GridView1.Rows(count).FindControl("HiddenField_type")

        '            If chk.Checked = True Then
        '                If type.Value <> "Cash" Then
        '                    adv = adv + Convert.ToInt64(hid_amount.Value)
        '                    Dim id As String = voucher.insert_Main_Payment(Procedurename, constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, Session("YearlyNo"), 1, Session("dept_id"), Session("emp_id"), Session("emp_id"), Session("emp_id"), 0)
        '                    voucher.Insert_payment(id, 0, "22005009001", hid_amount.Value, 1, 0, " Advance of Rupees " + Convert.ToString(hid_amount.Value) + " Paid by the Patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", Session("RegistrationNo"), Session("YearlyNo"), Session("SubDeptID"), 0)
        '                    voucher.Insert_payment(id, 0, "22005009001", hid_amount.Value, 2, 0, " Advance of Rupees " + Convert.ToString(hid_amount.Value) + " Paid by the Patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", Session("RegistrationNo"), Session("YearlyNo"), Session("SubDeptID"), 0)
        '                    voucher.Update_Main_Payment("Temp_update_Reciept_Voucher_payment", constring1, id, "Advance of Rupees " + Convert.ToString(hid_amount.Value) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))))
        '                    voucher.update_amount(id, hid_amount.Value)
        '                End If
        '            End If
        '        Next
        '    Catch ex As Exception

        '    End Try
        '    If Convert.ToInt64(co.Remove_Coma(Label_Refund.Text)) - (Convert.ToInt64(co.Remove_Coma(Label_Ad_Payment.Text)) - adv) > 0 Then
        '        Dim val As Long = Convert.ToInt64(co.Remove_Coma(Label_Refund.Text)) - (Convert.ToInt64(co.Remove_Coma(Label_Ad_Payment.Text)) - adv)

        '        Dim id As String = voucher.insert_Main_Payment(Procedurename, constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, Session("YearlyNo"), 1, Session("dept_id"), Session("emp_id"), Session("emp_id"), Session("emp_id"), 0)
        '        voucher.Insert_payment(id, 0, "22005009002", val, 1, 0, " Refund of Rupees " + Convert.ToString(val), constring1, "", Session("RegistrationNo"), Session("YearlyNo"), Session("SubDeptID"), 0)
        '        voucher.Insert_payment(id, 0, "22005009002", val, 2, 0, " Refund of Rupees " + Convert.ToString(val), constring1, "", Session("RegistrationNo"), Session("YearlyNo"), Session("SubDeptID"), 0)
        '        voucher.Update_Main_Payment("Temp_update_Reciept_Voucher_payment", constring1, id, "Refund of Rupees " + Convert.ToString(val) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))))
        '        voucher.update_amount(id, val)
        '    End If

        '    If Convert.ToInt64(co.Remove_Coma(Label_Ad_Payment.Text)) - Convert.ToInt64(co.Remove_Coma(Label_Refund.Text)) > 0 Then
        '        Adv_cash = Convert.ToInt64(co.Remove_Coma(Label_Ad_Payment.Text)) - Convert.ToInt64(co.Remove_Coma(Label_Refund.Text))
        '    Else
        '        Adv_cash = 0
        '    End If



        '    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        '    Dim doctorpayable As Long = 0
        '    If (Convert.ToInt64(co.Remove_Coma(TextBox2.Text)) + Convert.ToInt64(co.Remove_Coma(TextBox_Panel.Text))) >= total_val Then
        '        doctorpayable = (Convert.ToInt64(co.Remove_Coma(TextBox2.Text)) + Convert.ToInt64(co.Remove_Coma(TextBox_Panel.Text))) - total_val
        '    End If

        '    If co.Remove_Coma(TextBox_Panel.Text) <> "0" Or co.Remove_Coma(TextBox_Cradit_Card.Text) <> "0" Or Convert.ToInt64(co.Remove_Coma(TextBox_Cheque.Text)) <> 0 Or Convert.ToInt64(co.Remove_Coma(Label_Cash.Text)) <> 0 Or Adv_cash <> 0 Then
        '        Dim cash As Long = Convert.ToInt64(co.Remove_Coma(Label_Cash.Text))


        '        If doctorpayable > cash Then
        '            doctorpayable = doctorpayable - cash
        '            cash = 0
        '        Else
        '            cash = cash - doctorpayable
        '            doctorpayable = 0
        '        End If
        '        If Convert.ToInt64(co.Remove_Coma(Label_Discount.Text)) > 0 Then

        '            voucher.Insert_payment(main_Id, 0, "44004003002", (Convert.ToInt64(co.Remove_Coma(Label_Discount.Text)) - Convert.ToInt64(HiddenField_Doctor_Discount.Value)), 1, 0, "Discount of Rs." + co.Remove_Coma((Convert.ToInt64(co.Remove_Coma(Label_Discount.Text)) - Convert.ToInt64(HiddenField_Doctor_Discount.Value))) + " Given To ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If

        '        If Convert.ToInt64(co.Remove_Coma(cash)) > 0 Then


        '            voucher.Insert_payment(main_Id, 0, acc_head, Convert.ToInt64(co.Remove_Coma(cash)) + Convert.ToInt64(HiddenField_Doctor_Discount.Value), 1, 0, "Final Bill Rs." + Convert.ToString(co.Remove_Coma(cash)) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If

        '        If Convert.ToInt64(co.Remove_Coma(TextBox_Cradit_Card.Text)) > 0 Then

        '            voucher.Insert_payment(main_Id, 0, acc_head_Cradit_Card, co.Remove_Coma(TextBox_Cradit_Card.Text), 1, 0, "Final Bill Rs." + Convert.ToString(co.Remove_Coma(TextBox_Cradit_Card.Text)) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If
        '        If Convert.ToInt64(co.Remove_Coma(TextBox_Cheque.Text)) > 0 Then
        '            voucher.Insert_payment(main_Id, 0, acc_head_Cheque, co.Remove_Coma(TextBox_Cheque.Text), 1, 0, "Final Bill Rs." + Convert.ToString(co.Remove_Coma(TextBox_Cheque.Text)) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If
        '        If Convert.ToInt64(co.Remove_Coma(TextBox_Panel.Text)) > 0 Then
        '            voucher.Insert_payment(main_Id, DropDownList_Company.SelectedValue, acc_head_panel, co.Remove_Coma(TextBox_Panel.Text), 1, 0, "Final Bill Rs." + Convert.ToString(co.Remove_Coma(TextBox_Panel.Text)) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If

        '        If doctorpayable > Adv_cash Then
        '            doctorpayable = doctorpayable - Adv_cash
        '            Adv_cash = 0
        '        Else
        '            Adv_cash = Adv_cash - doctorpayable
        '            doctorpayable = 0
        '        End If

        '        If Convert.ToInt64(co.Remove_Coma(Adv_cash)) > 0 Then

        '            voucher.Insert_payment(main_Id, 0, "22005009001", Adv_cash, 1, 0, "Amount of Rs." + Convert.ToString(co.Remove_Coma(Adv_cash)) + " Deducted from Advance", constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If


        '        If doctorpayable > 0 Then
        '            voucher.Insert_payment(main_Id, 0, "22005009002", Convert.ToString(doctorpayable), 2, 0, "Refund of Rs." + Convert.ToString(doctorpayable) + " Given To ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)
        '        End If

        '    Else
        '        If Convert.ToInt64(co.Remove_Coma(Label_Cash.Text)) > 0 Then

        '            voucher.Insert_payment(main_Id, 0, acc_head, total_val, 1, 0, "Final Bill Rs." + Convert.ToString(co.Remove_Coma(total_val)) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, Session("SubDeptID"), HiddenField_Service_ID.Value)

        '        End If


        '    End If



        '    'voucher.Insert_payment(main_Id, 0, acc_head, total_val, 1, 0, "Final Bill Rs." + Convert.ToString(total_val) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))), constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)

        '    voucher.Update_Main_Payment("Temp_update_Reciept_Voucher_payment", constring1, main_Id, "Final Bill Rs." + Convert.ToString(total_val) + " ( Visit # " + Convert.ToString(YearlyNo) + " Dated " + Convert.ToString(Date.Today.Date) + ")" + " Paid by patient " + Convert.ToString(voucher.Patient(Session("RegistrationNo"))))
        '    'voucher.Insert_payment(main_Id, 0, "33001001001", total_val, 1, 0, "", constring1, "", RegNo, YearlyNo, sub_dept)
        '    voucher.update_amount(main_Id, total_val)
        '    total_val = 0


        'Catch ex As Exception

        'End Try




        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''''''' for doctor '''''''''''''''''''''''''''''''''''''''''''''''''''
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''


        ''Try
        ''    Dim total_doc_amount As Integer
        ''    Dim total As Integer
        ''    Dim count_val As Integer = 0
        ''    Dim connection As New SqlConnection
        ''    Dim command_val As New SqlCommand
        ''    Dim party As Int32
        ''    Dim reader As SqlDataReader

        ''    connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        ''    command_val = connection.CreateCommand
        ''    If co.Remove_Coma(TextBox_Panel.Text) <> "0" Or co.Remove_Coma(TextBox_Cradit_Card.Text) <> "0" Then
        ''        command_val.CommandText = " SELECT     Patient_Services.SubDept_ID, Admin_Services_AccountHeads.E_Code AS Account_Head_ID, Patient_Services.RegNo, Patient_Services.YearlyNo,  Doctor_Service.Charges as [Amount], Patient_Services.S_ID, Patient_Services.empid, Patient_Services.Doctor_ID FROM         Patient_Services INNER JOIN Admin_Services_AccountHeads ON Patient_Services.S_ID = Admin_Services_AccountHeads.S_Id INNER JOIN Doctor_Service ON Patient_Services.Doctor_ID = Doctor_Service.Doctor_ID AND Patient_Services.S_ID = Doctor_Service.Service_ID where Patient_Services.YearlyNo = " + Session("YearlyNo").ToString + " and Admin_Services_AccountHeads.Dept_Type='" + HiddenField_Patient_type.Value + "' and not(Patient_Services.Doctor_ID is null) order by Doctor_ID "
        ''    Else
        ''        command_val.CommandText = " SELECT     Patient_Services.SubDept_ID, Admin_Services_AccountHeads.E_Code AS Account_Head_ID, Patient_Services.RegNo, Patient_Services.YearlyNo, Doctor_Service.Bank_Payment as [Amount], Patient_Services.S_ID, Patient_Services.empid, Patient_Services.Doctor_ID FROM         Patient_Services INNER JOIN Admin_Services_AccountHeads ON Patient_Services.S_ID = Admin_Services_AccountHeads.S_Id INNER JOIN Doctor_Service ON Patient_Services.Doctor_ID = Doctor_Service.Doctor_ID AND Patient_Services.S_ID = Doctor_Service.Service_ID where Patient_Services.YearlyNo = " + Session("YearlyNo").ToString + " and Admin_Services_AccountHeads.Dept_Type='" + HiddenField_Patient_type.Value + "' and not(Patient_Services.Doctor_ID is null) order by Doctor_ID "
        ''    End If
        ''    'command_val.CommandText = " SELECT     Patient_Services.SubDept_ID, Admin_Services_AccountHeads.E_Code AS Account_Head_ID, Patient_Services.RegNo, Patient_Services.YearlyNo, Doctor_Service.Bank_Payment as [Amount], Patient_Services.S_ID, Patient_Services.empid, Patient_Services.Doctor_ID FROM         Patient_Services INNER JOIN Admin_Services_AccountHeads ON Patient_Services.S_ID = Admin_Services_AccountHeads.S_Id INNER JOIN Doctor_Service ON Patient_Services.Doctor_ID = Doctor_Service.Doctor_ID AND Patient_Services.S_ID = Doctor_Service.Service_ID where Patient_Services.YearlyNo = " + Session("YearlyNo").ToString + " and Admin_Services_AccountHeads.Dept_Type='" + HiddenField_Patient_type.Value + "' and not(Patient_Services.Doctor_ID is null) order by Doctor_ID "

        ''    connection.Open()
        ''    reader = command_val.ExecuteReader()
        ''    While reader.Read



        ''        sub_dept = reader.Item(0)
        ''        Account_Head_ID = reader.Item(1)
        ''        RegNo = reader.Item(2)
        ''        YearlyNo = reader.Item(3)
        ''        Amount = reader.Item(4)

        ''        HiddenField_Service_ID.Value = reader.Item(5)

        ''        total_val = total_val + Amount
        ''        total = total + Amount
        ''        If Amount <> 0 And total_val <> 0 Then

        ''            If count_val = 0 Then
        ''                main_Id = voucher.insert_Main_Payment(Procedurename, constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, Session("YearlyNo"), 1, Session("dept_id"), Session("emp_id"), Session("emp_id"), Session("emp_id"), DropDownList_Cost_Centre.SelectedValue)

        ''                count_val = 1
        ''            End If

        ''            ' If TextBox_Cheque.Text <> "0" Or TextBox_Cradit_Card.Text <> "0" Then
        ''            voucher.Insert_payment(main_Id, Convert.ToInt32(reader.Item(7)), Account_Head_ID, Amount, 1, 0, "Amount of Rupees " + Convert.ToString(total_val) + " Transfer to Doctor " + Convert.ToString(voucher.Party(Convert.ToInt32(reader.Item(7)))) + " Ledger" + " For the Service " + Convert.ToString(voucher.get_Account_Head(Account_Head_ID)), constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)

        ''            Try
        ''                party = Convert.ToInt32(reader.Item(7))

        ''                total_doc_amount = Convert.ToInt32(total_doc_amount) + Convert.ToInt32(total_val)
        ''            Catch ex As Exception

        ''            End Try


        ''            voucher.Insert_payment(main_Id, Convert.ToInt32(voucher.get_Account_Titles(party)), "33001001002", total_val, 2, 0, "Amount of Rupees " + Convert.ToString(total_val) + " Transfer to Doctor " + Convert.ToString(voucher.Party(party)) + " Ledger", constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)



        ''            total_val = 0
        ''            'Else
        ''            '    voucher.Insert_payment(main_Id, Convert.ToInt32(reader.Item(7)), Account_Head_ID, Amount, 1, 0, "Amount of Rupees " + Convert.ToString(total_val) + " Transfer to Doctor " + Convert.ToString(voucher.Party(Convert.ToInt32(reader.Item(7)))) + " Ledger" + " For the Service " + Convert.ToString(voucher.get_Account_Head(Account_Head_ID)), constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)

        ''            '    Try
        ''            '        party = Convert.ToInt32(reader.Item(7))

        ''            '        total_doc_amount = Convert.ToInt32(total_doc_amount) + Convert.ToInt32(total_val)
        ''            '    Catch ex As Exception

        ''            '    End Try


        ''            '    voucher.Insert_payment(main_Id, Convert.ToInt32(voucher.get_Account_Titles(party)), "33001001002", total_val, 2, 0, "Amount of Rupees " + Convert.ToString(total_val) + " Transfer to Doctor " + Convert.ToString(voucher.Party(party)) + " Ledger", constring1, "", RegNo, YearlyNo, sub_dept, HiddenField_Service_ID.Value)



        ''            '    total_val = 0
        ''            'End If

        ''        End If

        ''    End While
        ''    voucher.Update_Main_Payment("Temp_update_Reciept_Voucher_payment", constring1, main_Id, "Amount of Rupees " + Convert.ToString(total_doc_amount) + " Transfer to Doctors Ledger from Patient" + Convert.ToString(voucher.Patient(Session("RegistrationNo"))))
        ''    voucher.update_amount(main_Id, total)
        ''    reader.Close()
        ''    connection.Close()




        ''Catch ex As Exception

        ''End Try

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

    End Sub


    Sub Check_For_Remaining_Balance(ByVal Reg_No As String, ByVal YearlyNo As Integer)
        Dim con_bal As SqlConnection = New SqlConnection(constring)
        Dim command_bal As SqlCommand = New SqlCommand("SELECT SUM(Amount) AS Balance FROM Advance_Payment where RegNo=@RegNo and YearlyNo=@YearlyNo GROUP BY RegNo, YearlyNo", con_bal)
        command_bal.CommandType = CommandType.Text
        command_bal.Parameters.AddWithValue("@RegNo", Reg_No)
        command_bal.Parameters.AddWithValue("@YearlyNo", YearlyNo)
        con_bal.Open()
        Bal_Amount = command_bal.ExecuteScalar
        con_bal.Close()
    End Sub

    Sub getDept(ByVal Reg_No As String, ByVal YearlyNo As Integer)
        Dim con_bal As SqlConnection = New SqlConnection(conStrReg)
        Dim command_bal As SqlCommand = New SqlCommand("SELECT DeptID  FROM Payment where RegNo=@RegNo and PayID=@YearlyNo ", con_bal)
        command_bal.CommandType = CommandType.Text
        command_bal.Parameters.AddWithValue("@RegNo", Reg_No)
        command_bal.Parameters.AddWithValue("@YearlyNo", YearlyNo)
        con_bal.Open()
        'HiddenField_Dept_ID.Value = command_bal.ExecuteScalar
        con_bal.Close()
    End Sub
    Sub Select_Sample_No()
        Try
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(con_path)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_SampleNo", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.Add("@Sample", SqlDbType.Int)
            mycommand.Parameters("@Sample").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            HiddenField_Sample_number.Value = mycommand.Parameters("@Sample").Value
        Catch ex As Exception

        End Try

    End Sub
    Sub Insert_Main_Function(ByVal Print As Boolean)

        'Try

        '    Dim FlAG As Integer = 0
        '    Dim SPM_ID As Integer = 0
        '    get_subdept_id()
        '    For i As Integer = 0 To GridView_For_Services.Rows.Count - 1
        '        Dim check As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
        '        Dim Hid_SID As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_SID")
        '        Dim Hid_ID As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_ID")
        '        Dim Hid_Amount As HiddenField
        '        Dim Amount As Integer = 0
        '        If RadioButtonList1.SelectedItem.Text = "Paid" Then

        '            Dim txt As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_company")
        '            Dim txt1 As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_Patient")
        '            If txt.Text = "" Then
        '                txt.Text = "0"
        '            End If
        '            If txt1.Text = "" Then
        '                txt1.Text = "0"
        '            End If
        '            If txt1.Text = "0" Or txt1.Text = "" Then
        '                paid_by = 1
        '                HiddenField_paid_by.Value = paid_by
        '            Else
        '                paid_by = 0
        '                HiddenField_paid_by.Value = paid_by

        '            End If
        '            Amount = CInt(txt1.Text) + CInt(txt.Text)
        '            'Amount = CInt(Hid_Amount.Value)
        '        Else
        '            Amount = 0
        '        End If
        '        HiddenFieldID.Value = Hid_ID.Value
        '        If check.Checked = True Then
        '            If FlAG = 0 Then
        '                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        '                Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Patient_Payment_Info_main", con)
        '                mycommand.CommandType = Data.CommandType.StoredProcedure
        '                mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        '                mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        '                mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
        '                mycommand.Parameters.AddWithValue("@Discount_Amount", TextBox_Discount.Text)
        '                mycommand.Parameters.AddWithValue("@Discount_By", TextBox_Discount_By.Text)
        '                mycommand.Parameters.AddWithValue("@SubDept_ID", HiddenFieldSubDepartment.Value) 'Session("SubDeptID"))
        '                mycommand.Parameters.AddWithValue("@Dept_ID", HiddenFieldDept_id.Value)
        '                mycommand.Parameters.AddWithValue("@PS_ID", HiddenFieldID.Value)
        '                mycommand.Parameters.AddWithValue("@Cost_Centre", DropDownList_Cost_Centre.SelectedValue)
        '                'Session("Dept_ID"))
        '                mycommand.Parameters.Add("@SPM_ID", SqlDbType.Int)


        '                mycommand.Parameters("@SPM_ID").Direction = ParameterDirection.Output
        '                mycommand.Parameters.Add("@MainId", SqlDbType.Int)
        '                mycommand.Parameters("@MainId").Direction = ParameterDirection.Output
        '                mycommand.Connection.Open()
        '                mycommand.ExecuteNonQuery()
        '                SPM_ID = mycommand.Parameters("@SPM_ID").Value
        '                Payment_Detail(SPM_ID)


        '                HiddenField_smpID.Value = SPM_ID


        '                Try



        '                    If Convert.ToInt32(co.Remove_Coma(TextBox_Cradit_Card.Text)) > 0 Then
        '                        Dim con_bal As SqlConnection = New SqlConnection(constring1)
        '                        Dim command_bal As SqlCommand = New SqlCommand("INSERT INTO [Payment_Card_Cheque] ([SPM_ID], [Mode_of_Payment], [Cheque_Card_No], [Card_Type], [Bank_Name], [Approval_No], [Card_Service],[Amount],[Card_Check_Date]) VALUES (@SPM_ID, @Mode_of_Payment, @Cheque_Card_No, @Card_Type, @Bank_Name, @Approval_No, @Card_Service,@Amount,@Card_Check_Date)", con_bal)
        '                        command_bal.CommandType = CommandType.Text
        '                        con_bal.Open()
        '                        command_bal.Parameters.AddWithValue("@SPM_ID", HiddenField_smpID.Value)
        '                        command_bal.Parameters.AddWithValue("@Mode_of_Payment", "Cradit Card")
        '                        command_bal.Parameters.AddWithValue("@Cheque_Card_No", TextBox_Cradit_Card_No.Text)
        '                        command_bal.Parameters.AddWithValue("@Card_Type", DropDownList_Card_Type.SelectedValue)
        '                        command_bal.Parameters.AddWithValue("@Bank_Name", TextBox_Bank_Name.Text)
        '                        command_bal.Parameters.AddWithValue("@Approval_No", TextBox_approval_no.Text)
        '                        command_bal.Parameters.AddWithValue("@Card_Service", TextBox_Card_Service.Text)
        '                        command_bal.Parameters.AddWithValue("@Amount", co.Remove_Coma(TextBox_Cradit_Card.Text))
        '                        command_bal.Parameters.AddWithValue("@Card_Check_Date", Date.Now)
        '                        command_bal.ExecuteNonQuery()
        '                        con_bal.Close()
        '                    End If
        '                    If Convert.ToInt32(co.Remove_Coma(TextBox_Cheque.Text)) > 0 Then
        '                        Dim con_bal As SqlConnection = New SqlConnection(constring1)
        '                        Dim command_bal As SqlCommand = New SqlCommand("INSERT INTO [Payment_Card_Cheque] ([SPM_ID], [Mode_of_Payment], [Cheque_Card_No], [Card_Type], [Bank_Name], [Approval_No], [Card_Service],[Amount],[Card_Check_Date]) VALUES (@SPM_ID, @Mode_of_Payment, @Cheque_Card_No, @Card_Type, @Bank_Name, @Approval_No, @Card_Service,@Amount,@Card_Check_Date)", con_bal)
        '                        command_bal.CommandType = CommandType.Text
        '                        con_bal.Open()
        '                        command_bal.Parameters.AddWithValue("@SPM_ID", HiddenField_smpID.Value)
        '                        command_bal.Parameters.AddWithValue("@Mode_of_Payment", "Cheque")
        '                        command_bal.Parameters.AddWithValue("@Cheque_Card_No", TextBox_Cheque_No.Text)
        '                        command_bal.Parameters.AddWithValue("@Card_Type", "")
        '                        command_bal.Parameters.AddWithValue("@Bank_Name", TextBox_Cheque_Branch.Text)
        '                        command_bal.Parameters.AddWithValue("@Approval_No", "")
        '                        command_bal.Parameters.AddWithValue("@Card_Service", "")
        '                        command_bal.Parameters.AddWithValue("@Amount", co.Remove_Coma(TextBox_Cheque.Text))
        '                        command_bal.Parameters.AddWithValue("@Card_Check_Date", WebDateChooser_Cheque_Date.Value)
        '                        command_bal.ExecuteNonQuery()
        '                        con_bal.Close()
        '                    End If

        '                Catch ex As Exception

        '                End Try

        '                HiddenFieldMainId.Value = mycommand.Parameters("@MainId").Value
        '                mycommand.Connection.Close()
        '                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Insert_Patient_Payment_Info", con)
        '                mycommand1.CommandType = Data.CommandType.StoredProcedure
        '                mycommand1.Parameters.AddWithValue("@S_ID", Hid_SID.Value)
        '                mycommand1.Parameters.AddWithValue("@P_SID", Hid_ID.Value)
        '                mycommand1.Parameters.AddWithValue("@SPM_ID", SPM_ID)
        '                mycommand1.Parameters.AddWithValue("@Amnt", CInt(Amount))
        '                mycommand1.Connection.Open()
        '                mycommand1.ExecuteNonQuery()
        '                mycommand1.Connection.Close()
        '                FlAG = FlAG + 1

        '                SqlDataSource1.Update()
        '            ElseIf FlAG > 0 Then

        '                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        '                Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Patient_Payment_Info", con)
        '                mycommand.CommandType = Data.CommandType.StoredProcedure
        '                mycommand.Parameters.AddWithValue("@S_ID", Hid_SID.Value)
        '                mycommand.Parameters.AddWithValue("@P_SID", Hid_ID.Value)
        '                mycommand.Parameters.AddWithValue("@SPM_ID", SPM_ID)
        '                mycommand.Parameters.AddWithValue("@Amnt", CInt(Amount))
        '                mycommand.Connection.Open()
        '                mycommand.ExecuteNonQuery()
        '                mycommand.Connection.Close()
        '                SqlDataSource1.Update()
        '            End If

        '        End If
        '    Next

        '    If HiddenFieldDept_id.Value = "8" Or HiddenFieldDept_id.Value = "52" Then
        '        Dim da As New SqlDataAdapter
        '        Dim ds As New DataSet
        '        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        '        Dim con As SqlConnection = New SqlConnection(constr)
        '        Dim command As SqlCommand = New SqlCommand("SELECT COUNT(Admin_Service_Head.SH_Name) AS [Service_Taken], SUM(Patient_Services.Amount) AS Amount, Admin_Service_Head.SH_Name AS S_Name, Admin_Service_Category.Asc_Name, Patient_Services.RegNo, Patient_Services.YearlyNo, ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Employee, Admin_Service_Head.SH_Id, ISNULL(Employee.EmpID,0) as empid FROM Admin_Services INNER JOIN Patient_Services ON Admin_Services.S_ID = Patient_Services.S_ID INNER JOIN Admin_Service_Category ON Admin_Services.S_Category = Admin_Service_Category.Asc_id INNER JOIN Admin_Service_Head ON Admin_Services.SH_ID = Admin_Service_Head.SH_Id LEFT OUTER JOIN Employee ON Patient_Services.Doctor_ID = Employee.EmpID WHERE (Patient_Services.YearlyNo = @YearlyNo) and (Patient_Services.RegNo=@RegNo) AND (Patient_Services.Dept_ID <> 51) GROUP BY Patient_Services.RegNo, Patient_Services.YearlyNo, Admin_Service_Head.SH_Name, Admin_Service_Category.Main_Category, Employee.Prefix, Employee.EFName, Employee.EMName, Employee.ELName, Admin_Service_Category.Asc_Name, Admin_Service_Head.SH_Id, Employee.EmpID", con)
        '        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        '        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        '        command.CommandType = CommandType.Text
        '        con.Open()
        '        da.SelectCommand = command
        '        da.Fill(ds)
        '        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
        '            Inser_Main_Sub(CInt(ds.Tables(0).Rows(i).Item("Sh_ID").ToString), CInt(ds.Tables(0).Rows(i).Item("Amount").ToString), CInt(ds.Tables(0).Rows(i).Item("EmpID").ToString), CInt(ds.Tables(0).Rows(i).Item("Service_Taken").ToString))
        '        Next
        '        con.Close()
        '        SqlDataSourceUpdatePayment.Update()
        '    End If
        '    GridView_For_Services.DataBind()
        '    ' GridView1.DataBind()
        '    GridView_View_Payments.DataBind()
        '    Try
        '        If CInt(co.Remove_Coma(Label_Refund.Text)) > 0 Then
        '            SqlDataSource1.Insert()
        '        End If

        '    Catch ex As Exception

        '    End Try

        '    TextBox_approval_no.Text = ""
        '    TextBox_Bank_Name.Text = ""
        '    TextBox_Card_Service.Text = ""
        '    TextBox_Cheque_Branch.Text = ""
        '    TextBox_Cheque_No.Text = ""
        '    TextBox_Cradit_Card_No.Text = ""

        'Catch ex As Exception
        '    Response.Write(ex.Message)
        'End Try
    End Sub



    Sub Inser_Main_Sub(ByVal H_Id As Integer, ByVal Amount As Integer, ByVal Doctor_id As Integer, ByVal Service_Taken As Integer)
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("Insert_Patient_Final_Bill_Load", con)
        command.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        command.Parameters.AddWithValue("@H_ID", H_Id)
        command.Parameters.AddWithValue("@Amount", Amount)
        command.Parameters.AddWithValue("@Doctor_ID", Doctor_id)
        command.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
        command.Parameters.AddWithValue("@SPS_ID", "")
        command.Parameters.AddWithValue("@Service_Taken", Service_Taken)
        command.CommandType = CommandType.StoredProcedure
        con.Open()
        command.ExecuteNonQuery()
        con.Close()
    End Sub
    Private Function Get_Type(ByVal PayId As Integer)
        Dim type As String = ""
        Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As New SqlConnection(constr_reg)
        Dim qry As String = "SELECT Patient_Type FROM Payment where (PayID = @PayId)"
        Dim cmd As New SqlCommand(qry, con)
        con.Open()
        cmd.Parameters.AddWithValue("@PayId", PayId)
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            type = reader.Item("Patient_Type").ToString()
        End While
        con.Close()
        Return type
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim obj_menu As New JavaScriptMenu()
            obj_menu.loginvalidate()
            LabelSideMenu.Text = obj_menu.SideMenu(Request.PhysicalPath.Substring(0, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
            'LabelSideMenu.Text = obj_menu.SideMenu(string. (Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)));
            LabelFooter.Text = obj_menu.Footer_String()
            'Request.QueryString("regno")

            If Session("registrationNo") Is Nothing And Session("YearlyNo") Is Nothing Then
                'Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
                Session.Add("registrationNo", Request.QueryString("regno"))
                Session.Add("YearlyNo", Request.QueryString("payid"))
            End If
            If Not Request.QueryString("regno") Is Nothing And Not Request.QueryString("payid") Is Nothing Then
                Session.Add("registrationNo", Request.QueryString("regno"))
                Session.Add("YearlyNo", Request.QueryString("payid"))
            End If

            get_subdept_id()
            'If HiddenField_Patient_type.Value = "IPD" Then
            '    RadioButtonList_ReportType.Visible = False
            'Else

            'End If

            If Page.IsPostBack = False Then


                discount()
                ' Due_Payment()
                GridView_For_Services.DataBind()
                GridView_Rad_Sample_Recieved.DataBind()

            End If







            'If Get_Type(Session("YearlyNo")) = "OPD" Then
            'GridView_For_Services.DataBind()
            If GridView_For_Services.Rows.Count = 0 Then
                GridView_For_Services.Visible = False
            Else
                GridView_For_Services.Visible = True
            End If

            If GridView_Rad_Sample_Recieved.Rows.Count = 0 Then
                pnl_Radiology_Sample.Visible = False
            Else
                pnl_Radiology_Sample.Visible = True
            End If

            'Else
            'pnl_Radiology_Sample.Visible = False

            'End If



            'End If
            'If Session("Patienttype") = "Panel" Then
            '    Button_Report.Visible = False
            'Else
            '    Button_Report.Visible = True
            'End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Try
            If GridView_For_Services.Rows.Count = 0 Then
                HiddenField_chk.Value = 0
            End If
            Try
                'Calculation()
            Catch ex As Exception

            End Try

            'If HiddenField_chk.Value = "1" Then
            '    Button1.Enabled = True
            '    Button_Report.Enabled = True
            'Else
            '    If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(co.Remove_Coma(Label_Ad_Payment.Text)) <> 0 Then
            '        Button1.Enabled = True
            '        Button_Report.Enabled = True
            '    Else
            '        Button1.Enabled = False
            '        Button_Report.Enabled = False
            '    End If
            'End If

        Catch ex As Exception

        End Try

    End Sub
    'Sub Calculation()
    '    If GridView_For_Services.Rows.Count = 0 Then
    '        Dim rs As Int64 = 0

    '        Try
    '            For count As Integer = 0 To GridView1.Rows.Count - 1
    '                Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox_checked")
    '                If chk.Checked = True Then
    '                    rs = rs + Convert.ToDecimal(GridView1.Rows(count).Cells(0).Text)

    '                End If

    '            Next
    '        Catch ex As Exception

    '        End Try

    '        Label_Ad_Payment.Text = rs

    '        TextBox2.Text = 0
    '        Label_Remaining_Balance.Text = 0
    '        Label_Cash.Text = 0
    '        Label_Refund.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text)))
    '        If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(co.Remove_Coma(Label_Ad_Payment.Text)) <> 0 Then
    '            Button1.Enabled = True
    '            Button_Report.Enabled = True
    '        Else
    '            Button1.Enabled = False
    '            Button_Report.Enabled = False
    '        End If
    '    End If
    'End Sub
    'Sub Due_Payment()
    '    Try


    '        Label_Amount.Text = ""
    '        TextBox2.Text = ""
    '        Dim amount As Integer = 0

    '        For i As Integer = 0 To GridView_For_Services.Rows.Count - 1
    '            Dim chek As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
    '            Dim patient_amount As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_Patient")


    '            If chek.Checked = True Then
    '                If patient_amount.Text = "" Then
    '                Else

    '                    amount = amount + Convert.ToDecimal(patient_amount.Text)

    '                End If


    '            End If
    '        Next
    '        TextBox2.Text = co.place_Coma(amount)
    '        Label_Amount.Text = amount
    '        Ad_Payment()
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try
    'End Sub

    'Sub Ad_Payment()
    '    Dim Ad_Amount As Integer = 0
    '    Try

    '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '        Dim mycommand As New System.Data.SqlClient.SqlCommand("View_Details_Patient_Bill_Payments", con)
    '        mycommand.CommandType = Data.CommandType.StoredProcedure
    '        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
    '        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    '        mycommand.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
    '        mycommand.Parameters.Add("@Bill_Paied", SqlDbType.Int)
    '        mycommand.Parameters("@Bill_Paied").Direction = ParameterDirection.Output
    '        mycommand.Connection.Open()
    '        mycommand.ExecuteNonQuery()
    '        Label_Bill_Payed.Text = mycommand.Parameters("@Bill_Paied").Value
    '        mycommand.Connection.Close()

    '        Dim rs As Int64 = 0
    '        For count As Integer = 0 To GridView1.Rows.Count - 1
    '            Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox_checked")
    '            If chk.Checked = True Then
    '                rs = rs + Convert.ToDecimal(GridView1.Rows(count).Cells(0).Text)

    '            End If

    '        Next
    '        Label_Ad_Payment.Text = co.place_Coma(rs)


    '        Dim mycommand2 As New System.Data.SqlClient.SqlCommand("SELECT isnull(SUM(Refund_Amount),0) FROM Patient_Refund_Amount where (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)", con)
    '        mycommand2.CommandType = Data.CommandType.Text
    '        mycommand2.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
    '        mycommand2.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    '        mycommand2.Connection.Open()
    '        Label_Refund.Text = mycommand2.ExecuteScalar()
    '        mycommand2.Connection.Close()
    '        Dim remaining As Integer
    '        If HiddenField_Patient_type.Value = "IPD" Then
    '            If CInt(co.Remove_Coma(TextBox2.Text)) = 0 Then
    '                remaining = 0
    '            Else
    '                remaining = (CInt(co.Remove_Coma(TextBox2.Text)) - CInt(co.Remove_Coma(Label_Ad_Payment.Text)) - CInt(co.Remove_Coma(Label_Discount.Text)))
    '                Response.Write(remaining)
    '            End If


    '        Else


    '            Label_Refund.Visible = True
    '            Label_refund_pay.Visible = True
    '            If CInt(co.Remove_Coma(TextBox2.Text)) = 0 Then
    '                remaining = 0
    '            Else
    '                remaining = (CInt(co.Remove_Coma(TextBox2.Text)) - CInt(co.Remove_Coma(Label_Ad_Payment.Text)) - CInt(co.Remove_Coma(Label_Discount.Text)))
    '                Response.Write(remaining)
    '            End If


    '        End If


    '        If remaining < 0 Then
    '            Label_Refund.Text = remaining * -1
    '            set_Advance_Payment()
    '            Label_Remaining_Balance.Text = 0

    '            Label_Cash.Text = co.place_Coma(Convert.ToInt32(Label_Cash.Text) + Convert.ToInt32(co.Remove_Coma(Label_Remaining_Balance.Text)) - Convert.ToInt32(co.Remove_Coma(Label_Discount.Text)))
    '        ElseIf remaining >= 0 Then

    '            Label_Remaining_Balance.Text = co.place_Coma(remaining)


    '            set_Advance_Payment()
    '            Label_Cash.Text = co.place_Coma(Convert.ToInt32(co.Remove_Coma(Label_Cash.Text)) + Convert.ToInt32(remaining))


    '            Label_Refund.Text = 0
    '        End If
    '    Catch ex As Exception

    '    End Try

    'End Sub
    Protected Sub GridView_For_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_For_Services.PreRender
        If GridView_For_Services.Rows.Count <> 0 Then


            Dim company_Bill As Double = 0
            Dim Patient_Bill As Double = 0

            Dim amount As Integer = 0
            Dim amount_total As Double = 0
            Dim company_total As Double = 0
            Dim patient_total As Double = 0
            HiddenField_chk.Value = 0

            For i As Integer = 0 To GridView_For_Services.Rows.Count - 1


                GridView_For_Services.FooterRow.Visible = True
                If Page.IsPostBack = False Then
                    GridView_For_Services.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_For_Services.Rows(i).Cells(1).Text, False)

                Else
                    If GridView_For_Services.Rows(i).Cells(1).Text.Length > 17 Then

                        GridView_For_Services.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_For_Services.Rows(i).Cells(1).Text, False)

                    End If
                End If

                Try
                    Dim per As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_per")
                    Dim amountval As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_amountval")
                    Dim txt As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_company")
                    Dim txt_Patient As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_Patient")



                    Dim chk As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
                    Dim Party_ID As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_Party_ID")
                    Try
                        'HiddenField_Party_ID.Value = Party_ID.Value

                    Catch ex As Exception

                    End Try


                    Try
                        'DropDownList_Company.DataBind()
                        'DropDownList_Company.SelectedValue = HiddenField_Party_ID.Value

                    Catch ex As Exception

                    End Try




                    If per.Value = "0" Then
                        txt_Patient.Text = amountval.Value

                    Else
                        txt.Text = amountval.Value

                    End If
                    If txt_Patient.Text = "" Then
                        txt_Patient.Text = "0"
                    End If

                    If txt.Text = "" Then
                        txt.Text = "0"
                    End If

                    Try
                        If chk.Checked = True Then
                            amount_total = amount_total + Convert.ToDouble(GridView_For_Services.Rows(i).Cells(4).Text)
                            company_total = company_total + Convert.ToDouble(txt.Text)
                            patient_total = patient_total + Convert.ToDouble(txt_Patient.Text)
                            HiddenField_chk.Value = 1



                        End If


                    Catch ex As Exception

                    End Try

                    Try

                        txt_Patient.Text = co.place_Coma(txt_Patient.Text)

                        txt.Text = co.place_Coma(txt.Text)
                        GridView_For_Services.Rows(i).Cells(4).Text = co.place_Coma(GridView_For_Services.Rows(i).Cells(4).Text)

                        '''''''''''''''''''''''''''''''''''''
                        '''''''''''''''''''''''''''''''''''''''
                    Catch ex As Exception

                    End Try
                Catch ex As Exception

                End Try





            Next

            Dim rs As Int64 = 0

            Dim lbl_company As Label = GridView_For_Services.FooterRow.Cells(9).FindControl("Label_f_Company")
            Dim lbl_patient As Label = GridView_For_Services.FooterRow.Cells(10).FindControl("Label_f_Patient")

            lbl_company.Text = company_total
            lbl_patient.Text = patient_total
            lbl_company.Text = co.place_Coma(lbl_company.Text)
            lbl_patient.Text = co.place_Coma(lbl_patient.Text)
            GridView_For_Services.FooterRow.Cells(4).Text = co.place_Coma(amount_total)




        End If


    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        'Label_Amount.Text = ""
        'Dim amount As Integer = 0
        'For i As Integer = 0 To GridView_For_Services.Rows.Count - 1
        '    Dim chek As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
        '    If chek.Checked = True Then
        '        amount = amount + GridView_For_Services.Rows(i).Cells(4).Text
        '    End If
        'Next
        'TextBox2.Text = co.place_Coma(amount)

        'Label_Amount.Text = amount
        ''Ad_Payment()
    End Sub

    Protected Sub GridView_View_Payments_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_View_Payments.PreRender
        Try
            For i As Integer = 0 To GridView_View_Payments.Rows.Count - 1
                GridView_View_Payments.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_View_Payments.Rows(i).Cells(1).Text, False)
            Next
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView_View_Payments_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_View_Payments.RowDataBound

        Try
            If e.Row.RowType = DataControlRowType.DataRow Then


            End If
            If e.Row.RowType = DataControlRowType.DataRow Then

                If (c = "") Then
                    c = e.Row.Cells.Item(3).Text
                    e.Row.Cells.Item(3).Text = c
                ElseIf c = e.Row.Cells.Item(3).Text Then
                    e.Row.Cells.Item(3).Text = ""
                    e.Row.Cells.Item(3).Text = ""
                Else
                    c = e.Row.Cells.Item(3).Text
                    e.Row.Cells.Item(3).Text = c
                End If
            End If
            If e.Row.RowType = DataControlRowType.DataRow Then

                total_amount += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "S_Amount"))
                e.Row.Cells.Item(5).Text = co.place_Coma(e.Row.Cells.Item(5).Text)

            ElseIf e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(4).Text = "Total Amount:"
                e.Row.Cells(5).Text = co.place_Coma(total_amount)
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView_View_Payments_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_View_Payments.SelectedIndexChanged

        Try

            Dim Hid_PSID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField1")
            Dim main_ID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_mainID")
            Dim Amount As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_Amount")
            Dim SPM_ID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_SPM_ID")
            HiddenField_P_SID.Value = Hid_PSID.Value
            SqlDataSource_For_View.Update()
            'HiddenFieldPaymentTpye.Value = "Advance"
            'HiddenFieldAmount.Value = CInt(Amount.Value)
            'HiddenField_Cancel_Amount.Value = CInt(Amount.Value)
            'HiddenFieldMainId.Value = main_ID.Value



            SqlDataSource_Payment.Insert()

            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            'Dim connection As New SqlConnection
            'Dim command As New SqlCommand
            'connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            'command = connection.CreateCommand
            'command.CommandText = " Insert into Payment_Detail(SPM_ID, Advance, Credit_Card, Cheque, Party, Cash, Refund,Reg_No,Yearly_No) Values(" + Convert.ToString(SPM_ID.Value) + "," + co.Remove_Coma(0) + "," + co.Remove_Coma(0) + "," + co.Remove_Coma(0) + "," + co.Remove_Coma(0) + "," + co.Remove_Coma(0) + "," + co.Remove_Coma(HiddenFieldAmount.Value) + ",'" + Session("registrationNo") + "'," + Session("YearlyNo") + ")"
            'connection.Open()
            'command.ExecuteNonQuery()
            'connection.Close()

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

            GridView_View_Payments.DataBind()
            GridView_For_Services.DataBind()


        Catch ex As Exception

        End Try
    End Sub



    Sub get_subdept_id()
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand(" SELECT     TOP (1) Forward_To_Sub_Dept.to_sub_Dept, Payment.Patient_Type FROM         Forward_To_Sub_Dept INNER JOIN Payment ON Forward_To_Sub_Dept.yearly_no = Payment.PayID WHERE (Reg_No = @reg_no) AND (yearly_no = @Yearly_no) order by forward_date desc", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@Yearly_no", Session("YearlyNo"))
            Dim reader As SqlDataReader = command.ExecuteReader
            If reader.Read Then
                HiddenFieldSubDepartment.Value = reader.Item(0).ToString
                'HiddenField_Patient_type.Value = reader.Item(1).ToString
                get_dept_id()
            End If
            con.Close()

        Catch ex As Exception

        End Try
    End Sub

    Sub get_dept_id()
        Dim con1 As SqlConnection = New SqlConnection(constring)
        Dim command As SqlCommand = New SqlCommand("Select Dept_Id from SubDepartment where SubDept_Id=" + HiddenFieldSubDepartment.Value, con1)
        command.CommandType = CommandType.Text

        con1.Open()
        Dim reader1 As SqlDataReader = command.ExecuteReader
        If reader1.Read Then
            HiddenFieldDept_id.Value = reader1.Item(0).ToString
        End If
        con1.Close()
    End Sub

    Protected Sub GridView_For_Services_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_For_Services.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (d = "") Then
                d = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = d
            ElseIf d = e.Row.Cells.Item(0).Text Then
                e.Row.Cells.Item(0).Text = ""
                e.Row.Cells.Item(0).Text = ""
            Else
                d = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = d
            End If
            Dim hid As HiddenField = e.Row.Cells(8).FindControl("HiddenField_order_ID")
            If Not String.IsNullOrEmpty(hid.Value) Then
                e.Row.BackColor = Drawing.Color.Orange
            End If
            'HiddenField_Order_ID.Value = hid.Value
        End If
    End Sub

    'Protected Sub Button_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Report.Click

    '    If TextBox2.Text <> "0" Or TextBox_Panel.Text <> "0" Then
    '        for_lab()
    '        for_xray()

    '        Check_For_Remaining_Balance(CStr(Session("RegistrationNo")), CInt(Session("YearlyNo")))
    '        getDept(CStr(Session("RegistrationNo")), CInt(Session("YearlyNo")))
    '        If CInt(co.Remove_Coma(TextBox2.Text)) - Bal_Amount = 0 Then
    '            LabelAmountInsert.Visible = False
    '            Insert_Main_Function(False)
    '        Else
    '            If RadioButtonList1.SelectedItem.Text = "Remaining" Then
    '                Insert_Main_Function(False)
    '                HiddenFieldAmount.Value = CInt(co.Remove_Coma(Label_Cash.Text))
    '                SqlDataSourcePendingAmount.Insert()
    '            Else
    '                LabelAmountInsert.Visible = False
    '                Insert_Main_Function(False)

    '                If Label_Refund.Text = "0" Then
    '                    HiddenFieldPaymentTpye.Value = "Bill"
    '                    If RadioButtonList1.SelectedItem.Text = "Free" Then
    '                        HiddenFieldAmount.Value = CInt(0)
    '                    Else
    '                        HiddenFieldAmount.Value = CInt(co.Remove_Coma(Label_Cash.Text))
    '                    End If
    '                Else
    '                    HiddenFieldPaymentTpye.Value = "Refund"
    '                    HiddenFieldAmount.Value = co.Remove_Coma(CInt(Label_Refund.Text))
    '                End If
    '                SqlDataSourceCounterClose.Insert()

    '                If GridView_For_Services.Rows.Count - 1 Then

    '                End If
    '            End If

    '        End If
    '        Try
    '            insert_data()
    '        Catch ex As Exception

    '        End Try


    '        Try
    '            Try

    '                For count As Integer = 0 To GridView1.Rows.Count - 1
    '                    Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox_checked")
    '                    Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField2")
    '                    If chk.Checked = True Then
    '                        HiddenField_Payment_No.Value = hid.Value
    '                        SqlDataSource2.Update()

    '                    End If
    '                Next


    '            Catch ex As Exception

    '            End Try
    '            GridView1.DataBind()
    '            discount_Update()
    '            discount()
    '            Calculation()
    '        Catch ex As Exception

    '        End Try
    '    Else
    '        If CInt(co.Remove_Coma(Label_Discount.Text)) >= 0 Then
    '            Try

    '                HiddenFieldAmount.Value = co.Remove_Coma(CInt(Label_Refund.Text))
    '                HiddenFieldPaymentTpye.Value = "Refund"

    '                '''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '                ''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '                Dim connection As New SqlConnection
    '                Dim command As New SqlCommand

    '                connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    '                command = connection.CreateCommand

    '                command.CommandText = " Insert into Payment_Detail(SPM_ID, Advance, Credit_Card, Cheque, Party, Cash, Refund,Discount,Reg_No,Yearly_No) Values(0," + co.Remove_Coma(Label_Ad_Payment.Text) + "," + co.Remove_Coma(TextBox_Cradit_Card.Text) + "," + co.Remove_Coma(TextBox_Cheque.Text) + "," + co.Remove_Coma(TextBox_Panel.Text) + "," + co.Remove_Coma(Label_Cash.Text) + "," + co.Remove_Coma(Label_Refund.Text) + "," + co.Remove_Coma(Label_Discount.Text) + ",'" + Session("registrationNo") + "'," + Session("YearlyNo") + ")"
    '                connection.Open()
    '                command.ExecuteNonQuery()
    '                connection.Close()

    '                SqlDataSourceCounterClose.Insert()


    '                Try
    '                    insert_data()
    '                Catch ex As Exception

    '                End Try

    '                For count As Integer = 0 To GridView1.Rows.Count - 1
    '                    Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox_checked")
    '                    Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField2")
    '                    If chk.Checked = True Then
    '                        HiddenField_Payment_No.Value = hid.Value
    '                        SqlDataSource2.Update()

    '                    End If
    '                Next
    '                GridView1.DataBind()
    '                discount_Update()
    '                discount()
    '                Calculation()


    '                ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    '                ''''''''''''''''''''''''''''''''''''''''''''''''''''''''


    '            Catch ex As Exception

    '            End Try
    '        End If

    '        LabelAmountInsert.Visible = True
    '        LabelAmountInsert.Text = "Can't Insert the Zero Amount"
    '    End If
    '    Try

    '        SqlDataSource_Radiology_test_booking.Update()
    '    Catch ex As Exception

    '    End Try


    '    If RadioButtonList_ReportType.SelectedValue = 1 Then

    '        If HiddenFieldDept_id.Value = "51" Then

    '            Response.Redirect("pt_DischargeBill.aspx")
    '        Else
    '            Dim sb As StringBuilder = New StringBuilder
    '            sb.Append("<script language='javascript'>")
    '            sb.Append(" window.open('patientServices.aspx')</script>")
    '            Dim t As Type = Me.GetType
    '            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
    '                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
    '            End If

    '        End If

    '    ElseIf RadioButtonList_ReportType.SelectedValue = 2 Then

    '        Dim sb As StringBuilder = New StringBuilder
    '        sb.Append("<script language='javascript'>")
    '        sb.Append(" window.open('PatientConsultationServices.aspx')</script>")

    '        Dim t As Type = Me.GetType
    '        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
    '            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
    '        End If

    '    End If



    'End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
    End Sub

    Protected Sub GridView_For_Services_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_For_Services.SelectedIndexChanged

    End Sub




    Protected Sub SqlDataSource_test_Booking_New_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_test_Booking_New.Inserted
        HiddenField_main_ID_patient.Value = e.Command.Parameters("@main_ID_Patient").Value

    End Sub

    Protected Sub Button_lab_Test_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_lab_Test.Click
        for_lab()
        for_xray()
        GridView_For_Services.DataBind()
        Response.Write(HiddenField_main_ID_patient.Value)
        Response.Redirect("../Pathology/Patient_Sample.aspx?Reg_No=" & Session("registrationNo") & "&YearlyNo=" & Session("YearlyNo") & "&Main_ID=" & HiddenField_main_ID_patient.Value & " &sample_No=&nbsp;&status=12")

    End Sub

    Protected Sub SqlDataSource_test_Booking_Radiology_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_test_Booking_Radiology.Inserted
        'HiddenField_Main_ID_Radiology.Value = e.Command.Parameters("@main_ID_Patient").Value
    End Sub


    Sub discount()

        Try
            If Session("patientType") = "Private" Then


                Dim connection As New SqlConnection
                Dim command As New SqlCommand
                Dim reader As SqlDataReader
                connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
                command = connection.CreateCommand

                command.CommandText = " SELECT     sum(Total_Amount) AS Amount FROM         Discount_Main WHERE     (RegNo ='" + Session("registrationNo") + "') AND (YearlyNo =" & Session("YearlyNo") & ") and Payment_Status=0"
                connection.Open()
                reader = command.ExecuteReader


                If reader.Read Then
                    ' Label_Discount.Text = co.place_Coma(reader.Item(0))
                End If

                reader.Close()
                connection.Close()
                discount_sub()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Sub discount_sub()

        Try
            If Session("patientType") = "Private" Then


                Dim connection As New SqlConnection
                Dim command As New SqlCommand
                Dim reader As SqlDataReader
                connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
                command = connection.CreateCommand

                command.CommandText = " SELECT    sum(isnull(Discount_Sub.Discount_Sub_Amount,0)) as [Discount_Sub_Amount]  FROM         Discount_Main INNER JOIN Discount_Sub ON Discount_Main.Discount_ID = Discount_Sub.Discount_ID WHERE     (RegNo ='" + Session("registrationNo") + "') AND (YearlyNo =" & Session("YearlyNo") & ") and Payment_Status=0 and Discount_Sub.Doctor_ID <>0 "
                connection.Open()
                reader = command.ExecuteReader


                If reader.Read Then
                    HiddenField_Doctor_Discount.Value = reader.Item(0)
                Else
                    HiddenField_Doctor_Discount.Value = "0"
                End If

                reader.Close()
                connection.Close()
            End If
        Catch ex As Exception

        End Try
    End Sub


    Sub discount_Update()

        Try
            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
            command = connection.CreateCommand

            command.CommandText = "Update Discount_Main set Payment_Status=1 WHERE     (RegNo ='" + Session("registrationNo") + "') AND (YearlyNo =" & Session("YearlyNo") & ") and Payment_Status=0"
            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()
            'Label_Discount.Text = 0
        Catch ex As Exception

        End Try
        Dim rs As Int64 = 0

    End Sub
    Private Function GetRadQueryStringData(ByVal regno As String, ByVal yearlyNo As Integer) As DataTable
        Dim path_constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim dt As New DataTable
        Dim da As New SqlDataAdapter
        Dim qry As String = "SELECT Order_ID, DeptId, SubDept_Id FROM Radiology_Order_main WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)"
        Dim con As New SqlConnection(path_constring)
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@YearlyNo", yearlyNo)
        cmd.Parameters.AddWithValue("@RegNo", regno)
        con.Open()
        da.SelectCommand = cmd
        da.Fill(dt)
        con.Close()
        Return dt
    End Function



    Function Select_Rad_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select isnull(max(Main_ID),0) as [Main_ID] From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Rad_Values()
        Dim SDate As Date = Date.Now 'WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        Dim report_date As Date = DateAdd(DateInterval.Day, 1, Date.Now)
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_alreadeybook_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", SDate)
        param = mycommand.Parameters.AddWithValue("@Sample_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", report_date)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", 0)
        param = mycommand.Parameters.AddWithValue("@Description", "")
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", 1)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", HF_Rad_Order_ID.Value)
        param = mycommand.Parameters.AddWithValue("@From_Dept_ID", HF_Rad_FromDept_Id.Value)
        param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", HF_Rad_FromSubDept_ID.Value)
        param = mycommand.Parameters.AddWithValue("@To_Dept_ID", 18)
        param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", 1)
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenField_Rad_Main_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Sub Payment_Rad_Button_Save()
        Try
            Dim RegNo As String = Session("registrationNo")
            Dim YearlyNo As Integer = Session("YearlyNo")
            'HiddenFieldTotalAmount.Value = 0 ' CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotalPaid.Value = 0 'CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotal_Discount.Value = 0 'TotalDiscount()
            HiddenField_Rad_Main_ID.Value = Select_Rad_Main_ID(RegNo, YearlyNo)
            Insert_Rad_Test_Info()
            SqlDataSourceRadInsertSub.Insert()
            '          Update_Rad_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Sub Insert_Rad_Test_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE  (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) and Path_Result_Delivery.Fee_paid=0 and Test_Booking_Services.Main_ID=@Main_ID", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@Main_ID", HiddenField_Rad_Main_ID.Value)
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
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Rad_Main_ID(Session("registrationNo"), Session("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Public Sub update_Rad_Test_Booking_Status(ByVal Status As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Update_Test_Booking_Status", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Connection.Open()
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@Status", Status)
        'mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMain_ID.Value)

        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()


    End Sub



    Protected Sub Button_Rad_For_Payment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Rad_For_Payment.Click

        Try
            'HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
            For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
                Dim HF_Order_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_Order_ID")
                Dim HiddenField_TB_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HiddenField_TB_ID")
                Dim is_checked As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
                Dim Label_EmpID As Label = GridView_Rad_Sample_Recieved.Rows(i).FindControl("Label_EmpID")
                Dim HF_S_Amount As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_S_Amount")
                Dim HF_S_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_S_ID")
                Dim HF_Dept_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_Dept_ID")
                Dim HF_SubDeptID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_SubDeptID")
                Dim HF_ServiceType As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_ServiceType")
                If is_checked.Checked = True Then
                    If HF_ServiceType.Value = "Rad" Then
                        insert_Into_Rad_Patient_Services(Label_EmpID.Text, HF_S_ID.Value, HF_S_Amount.Value, HF_SubDeptID.Value, HF_Dept_ID.Value, HF_Order_ID.Value, HiddenField_TB_ID.Value)
                    ElseIf HF_ServiceType.Value = "Path" Then
                        insert_Into_Path_Patient_Services(Label_EmpID.Text, HF_S_ID.Value, HF_S_Amount.Value, HF_SubDeptID.Value, HF_Dept_ID.Value, HF_Order_ID.Value, HiddenField_TB_ID.Value)
                    End If

                End If
            Next

            '            SqlDataSource_Rad_Patient_Services.Insert()
        Catch ex As Exception

        End Try
        GridView_For_Services.DataBind()
        GridView_Rad_Sample_Recieved.DataBind()

        'If Get_Type(Session("YearlyNo")) = "OPD" Then
        'GridView_For_Services.DataBind()
        If GridView_For_Services.Rows.Count = 0 Then
            GridView_For_Services.Visible = False
        Else
            GridView_For_Services.Visible = True
        End If

        If GridView_Rad_Sample_Recieved.Rows.Count = 0 Then
            pnl_Radiology_Sample.Visible = False
        Else
            pnl_Radiology_Sample.Visible = True
        End If

        'Else
        'pnl_Radiology_Sample.Visible = False

        'End If

    End Sub
    Private Sub insert_Into_Rad_Patient_Services(ByVal emp_ID As Integer, ByVal S_Id As Integer, ByVal S_Amount As Integer, ByVal subdeptID As Integer, ByVal DeptID As Integer, ByVal Order_ID As Integer, ByVal TB_ID As Integer)
        Dim Rad_constr As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con As New SqlConnection(Rad_constr)
        Dim sp As String = "Insert_Radiology_Patient_Services"
        Dim cmd As New SqlCommand(sp, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        cmd.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        cmd.Parameters.AddWithValue("@empid", emp_ID)
        cmd.Parameters.AddWithValue("@S_ID", S_Id)
        cmd.Parameters.AddWithValue("@Amount", S_Amount)
        cmd.Parameters.AddWithValue("@SubDept_ID", subdeptID)
        cmd.Parameters.AddWithValue("@Dept_ID", DeptID)
        cmd.Parameters.AddWithValue("@Order_ID", Order_ID)
        cmd.Parameters.AddWithValue("@TB_ID", TB_ID)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub
    Private Sub insert_Into_Path_Patient_Services(ByVal emp_ID As Integer, ByVal S_Id As Integer, ByVal S_Amount As Integer, ByVal subdeptID As Integer, ByVal DeptID As Integer, ByVal Order_ID As Integer, ByVal TB_ID As Integer)
        Dim Rad_constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
        Dim con As New SqlConnection(Rad_constr)
        Dim sp As String = "Insert_Pathology_Patient_Services"
        Dim cmd As New SqlCommand(sp, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        cmd.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))

        cmd.Parameters.AddWithValue("@empid", emp_ID)
        cmd.Parameters.AddWithValue("@S_ID", S_Id)
        cmd.Parameters.AddWithValue("@Amount", S_Amount)
        cmd.Parameters.AddWithValue("@SubDept_ID", subdeptID)

        cmd.Parameters.AddWithValue("@Dept_ID", DeptID)
        cmd.Parameters.AddWithValue("@Order_ID", Order_ID)
        cmd.Parameters.AddWithValue("@TB_ID", TB_ID)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub


    Protected Sub Button_CheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_CheckAll.Click
        For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            check.Checked = True
        Next
    End Sub

    Protected Sub Button_Un_Check_All_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Un_Check_All.Click
        For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
            Dim check As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
            check.Checked = False
        Next
    End Sub


End Class
