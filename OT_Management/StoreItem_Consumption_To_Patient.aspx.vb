Imports System.Data
Imports System.Data.SqlClient
Partial Class Pharmacy_StoreItem_Consumption_To_Patient
    Inherits System.Web.UI.Page
    Dim total_Stock As Integer = 0
    Dim voucher As New voucher_insertion
    Dim constring1 As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim unit_amount As Double
    Dim Vou_main_Id As String
    Dim qty_Remain As Integer
    Dim Batch_qty As Integer
    Dim constr As String = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
    Dim constr_Basic As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim constr_Store As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
    Protected Sub GridViewMedicine_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewMedicine.SelectedIndexChanged
        Try
            Button_Consumption.Visible = True
            Dim hid_med_Code As HiddenField = GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).FindControl("HiddenFieldMedCode")
            Dim txt_qty As TextBox = GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).FindControl("TextBox_Qty")
            'Dim TextBox_RetailPrice As TextBox = GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).FindControl("TextBox_RetailPrice")
            ' Dim txt_BatchNo As DropDownList = GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).FindControl("DropDownList1")
            Dim HiddenField_MedName As HiddenField = GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).FindControl("HiddenField_MedName")
            Dim medName As String = HiddenField_MedName.Value
            ' txt_BatchNo.Text = "000"


            HiddenField_MedCode.Value = hid_med_Code.Value
            HiddenField_Qty.Value = CInt(txt_qty.Text)
            HiddenFieldBatchNo.Value = "000" 'txt_BatchNo.SelectedValue

            'HiddenField_s_ID.Value = S_ID.Value
            'HiddenField_Reg_No.Value = reg_NO.Value
            'If isnumeric(GridViewMedicine.Rows(GridViewMedicine.SelectedIndex).cells(6).text.trim) Then

            'End If
            'HiddenField_amount.Value = Convert.ToInt64(txt_qty.Text) * 100
            If HiddenField_Qty.Value > 0 Then '            And Check_For_Stock(hid_med_Code.Value) >= 1 Then

                'SqlDataSourceInsertMain.Insert()
                'SqlDataSourceInsertSub.Insert()
                'SqlDataSource1.Insert()
                'GridViewMedicineIssue.DataBind()

                Dim date_time As String = DateTime.Now


                Populate_Temp_Grid(HiddenField_MedCode.Value, medName, "000", HiddenField_Qty.Value, 0, date_time)




            Else
                Dim sb As StringBuilder = New StringBuilder
                sb.Append("<Script language='javascript' type='text/javascript'>alert('Medicine Not in Stock');</Script>")
                Dim t As Type = Me.GetType
                If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                End If
            End If






            'Dim HID_ID As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_ID")
            'Dim HID_Name As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Name")
            'Dim HID_Sample As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Sample")
            'Dim HID_Rate As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Rate")
            'Dim HID_Day As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Day")
            'Dim HID_Time As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Time")

            'Dim date_time As String = DateAdd(DateInterval.Day, CInt(HID_Day.Value), Date.Now.Date) & " " & HID_Time.Value
            'Populate_Temp_Grid(HID_Name.Value, HID_Sample.Value, HID_Rate.Value, HID_ID.Value, date_time)

            'TotalDiscount()
            'Dim count As Integer = 0
            'If GridView_TemP_Test.Rows.Count > 0 Then
            '    For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            '        count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
            '        'Response.Write(GridView_TemP_Test.Rows(i).Cells(4).Text & "dfdfds ")
            '    Next
            '    TextBox_Grand_total.Text = count + CInt(Label_other_Charges.Text)
            '    'TextBox_Total_Price.Text = count + CInt(Label_other_Charges.Text)
            '    'TextBox_Total.Text = count
            '    GridView_TemP_Test.FooterRow.Cells(4).Text = count
            'End If




        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Dim ds As New Store
    Function Alread_Inserted(ByVal MedCode As String, ByVal MedName As String, ByVal BatchNO As String, ByVal Qty As String, ByVal Rate As String, ByVal Date_Time As String) As Boolean
        Dim f As Boolean = False
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            If GridView_TemP_Test.Rows(x).Cells(1).Text = MedCode And GridView_TemP_Test.Rows(x).Cells(3).Text = BatchNO And GridView_TemP_Test.Rows(x).Cells(4).Text = Qty And GridView_TemP_Test.Rows(x).Cells(5).Text = Rate Then
                f = True
                Exit For
            End If
        Next
        Return f
    End Function

    Sub Populate_Temp_Grid(ByVal MedCode As String, ByVal MedName As String, ByVal BatchNO As String, ByVal Qty As String, ByVal Rate As String, ByVal Date_Time As String)

        Dim row As DataRow
        ds.Tables("TempMedicine").Clear()
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1

            row = ds.Tables("TempMedicine").NewRow
            row.Item("MedCode") = GridView_TemP_Test.Rows(x).Cells(1).Text
            row.Item("MedName") = CStr(GridView_TemP_Test.Rows(x).Cells(2).Text).Replace("&quot;", """")
            row.Item("BatchNO") = GridView_TemP_Test.Rows(x).Cells(3).Text
            row.Item("Qty") = CInt(GridView_TemP_Test.Rows(x).Cells(4).Text)
            row.Item("Rate") = GridView_TemP_Test.Rows(x).Cells(5).Text
            row.Item("Total") = GridView_TemP_Test.Rows(x).Cells(6).Text
            row.Item("Date_Time") = GridView_TemP_Test.Rows(x).Cells(7).Text

            ds.Tables("TempMedicine").Rows.Add(row)
        Next
        If Not Alread_Inserted(MedCode, MedName, BatchNO, Qty, Rate, Date_Time) Then

            row = ds.Tables("TempMedicine").NewRow

            row.Item("MedCode") = MedCode
            row.Item("MedName") = MedName.Trim
            row.Item("BatchNO") = BatchNO
            row.Item("Qty") = Qty
            row.Item("Rate") = Rate
            row.Item("Total") = Qty * Rate
            row.Item("Date_Time") = Date_Time

            ds.Tables("TempMedicine").Rows.Add(row)
        Else
            'Print already inserted
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<Script language='javascript' type='text/javascript'>alert('Already inserted');</Script>")
            Dim t As Type = Me.GetType
            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            End If
        End If
        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
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


    Function Check_For_Stock(ByVal MedCode As String) As Integer
        Dim con As SqlConnection = New SqlConnection(constr_Store)
        'Response.Write(Session("ShiftID") & Session("dept_id"))
        'Response.End()
        Dim command As SqlCommand = New SqlCommand("Select_Stock_For_Medicine_Issue", con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Item_Code", MedCode)
        'command.Parameters.AddWithValue("@Dept_ID", 33)
        'command.Parameters.AddWithValue("@SubDept_ID", 47)
        'command.Parameters.AddWithValue("@ShiftID", 1)
        command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
        command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
        command.Parameters.AddWithValue("@ShiftID", Session("ShiftID"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        Dim stock As Integer = 0
        If reader.HasRows Then
            reader.Read()
            stock = reader.Item(0)
        End If
        'Response.Write(stock)
        'Response.End()
        Return stock
    End Function

    Protected Sub SqlDataSourceInsertMain_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourceInsertMain.Inserted
        HiddenField_MainId.Value = e.Command.Parameters("@Issue_By_Main_Id").Value
        'Response.Write(HiddenField_MainId.Value)
    End Sub

    Protected Sub TextBox_CODNo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_CODNo.TextChanged
        'GridViewMedicineIssue.DataBind()
        Select_Department()
    End Sub
    Sub Select_Department()
        Dim con As SqlConnection = New SqlConnection(constr_Store)
        Dim command As SqlCommand = New SqlCommand("SELECT TOP (1) Issue_To_Dept_Id FROM Store_Item_Issue_Main WHERE (YearlyNo = @YearlyNo) order by Store_Item_Issue_Id desc", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@YearlyNo", TextBox_CODNo.Text)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            DropDownList_Department.SelectedValue = reader.Item(0)
        End If
        con.Close()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        'Response.Write("Dept" + DropDownList_Department.SelectedValue)
        'Response.Write("Radio " + RadioButtonList_medkind.SelectedValue)
        'Response.Write("Text " + TextBox_specificMedicine.Text)
        Try
            SqlDataSourceGridMedicine.DataBind()
            GridViewMedicine.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Session.Add("Regno", Request.QueryString("YearlyNo"))
        If Not IsPostBack Then
            Session.Add("Regno", Request.QueryString("Reg_No"))
            Session.Add("YearlyNo", Request.QueryString("YearlyNo"))


            TextBox_CODNo.Text = Request.QueryString("YearlyNo")
            GridViewMedicine.DataBind()
            GridView_Consumed.DataBind()
            'GridViewMedicineIssue.DataBind()
            Select_Department()
            Load_Temp_Grid_For_Patient_Consumption()
            If Session("dept_id") = 18 Then
                RadioButtonList_Medicine_OF.SelectedValue = "D"
                RadioButtonList_Medicine_OF.Enabled = False

                Button_Print.Visible = False
                'DataList1.Visible = True
                'DataList1.DataBind()
                ds.Tables("TempMedicine").Clear()
                GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
                GridView_TemP_Test.DataBind()
                GridViewMedicine.DataBind()
            End If

        End If


    End Sub
    Sub Grid_Delete()
        Dim ds As New Store
        Dim row As DataRow
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            If GridView_TemP_Test.SelectedIndex = x Then
                Continue For
            End If
            row = ds.Tables("TempMedicine").NewRow
            row.Item("MedCode") = GridView_TemP_Test.Rows(x).Cells(1).Text
            row.Item("MedName") = GridView_TemP_Test.Rows(x).Cells(2).Text
            row.Item("BatchNO") = GridView_TemP_Test.Rows(x).Cells(3).Text
            row.Item("Qty") = GridView_TemP_Test.Rows(x).Cells(4).Text
            row.Item("Rate") = GridView_TemP_Test.Rows(x).Cells(5).Text
            row.Item("Total") = GridView_TemP_Test.Rows(x).Cells(6).Text
            row.Item("Date_Time") = GridView_TemP_Test.Rows(x).Cells(7).Text

            ds.Tables("TempMedicine").Rows.Add(row)

        Next

        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
        GridView_TemP_Test.DataBind()
    End Sub
    Protected Sub GridView_TemP_Test_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.SelectedIndexChanged
        'Dim HID_ID As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_ID")
        'Dim HID_Name As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Name")
        'Dim HID_Sample As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Sample")
        'Dim HID_Rate As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_Rate")
        Grid_Delete()
        'Dim count As Integer = 0
        'For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
        '    count = count + CInt(GridView_TemP_Test.Rows(i).Cells(4).Text)
        'Next
        'GridView_TemP_Test.FooterRow.Cells(4).Text = count
        'TextBox_Grand_total.Text = count
        'TotalDiscount()
    End Sub

    Protected Sub GridView_TemP_Test_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.PreRender
        If GridView_TemP_Test.Rows.Count <> 0 Then
            Dim total As Double = 0
            For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                total = total + CDbl(GridView_TemP_Test.Rows(i).Cells(6).Text)
            Next
            GridView_TemP_Test.FooterRow.Cells(6).Text = total
            GridView_TemP_Test.FooterRow.Cells(6).Font.Bold = True
        End If


    End Sub

    Function select_Batch_Qty(ByVal BatchNo As String, ByVal Item_Code As String) As Integer
        Dim con As SqlConnection = New SqlConnection(constr_Store)
        Dim command As SqlCommand = New SqlCommand("Select_Item_Qty_Batch_Wise", con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@BatchNo", BatchNo)
        command.Parameters.AddWithValue("@Item_Code", Item_Code)
        command.Parameters.AddWithValue("@Dept_Id", Session("dept_id"))
        command.Parameters.AddWithValue("@Subdept_Id", Session("SubDeptID"))
        con.Open()
        Dim count As Integer = command.ExecuteScalar
        con.Close()
        Return count
    End Function

    Protected Sub Button_Consumption_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Consumption.Click
        Try
            Dim count As Integer = 0
            Dim flag As Int32 = 0
            Dim main_ID As Int64
            Dim Consumed As New Store_Consumed
            'row = ds.Tables("TempMedicine").NewRow
            'row.Item("MedCode") = GridView_TemP_Test.Rows(x).Cells(1).Text
            'row.Item("MedName") = GridView_TemP_Test.Rows(x).Cells(2).Text
            'row.Item("BatchNO") = GridView_TemP_Test.Rows(x).Cells(3).Text
            'row.Item("Qty") = GridView_TemP_Test.Rows(x).Cells(4).Text
            'row.Item("Rate") = GridView_TemP_Test.Rows(x).Cells(5).Text
            'row.Item("Total") = GridView_TemP_Test.Rows(x).Cells(6).Text
            'row.Item("Date_Time") = GridView_TemP_Test.Rows(x).Cells(7).Text

            For count = 0 To GridView_TemP_Test.Rows.Count - 1
                Dim TextBox_Consumed As String = GridView_TemP_Test.Rows(count).Cells(4).Text
                Dim HiddenField_Item_Code As String = GridView_TemP_Test.Rows(count).Cells(1).Text

                'Dim HiddenField_Dept As HiddenField = GridView3.Rows(count).FindControl("HiddenField_Dept")
                'Dim HiddenField_Sub_Dept As HiddenField = GridView3.Rows(count).FindControl("HiddenField_Sub_Dept")
                'Dim HiddenField_BatchNo As HiddenField = GridView3.Rows(count).FindControl("HiddenField_BatchNo")
                Dim BatchNo As String = GridView_TemP_Test.Rows(count).Cells(3).Text
                'Dim HiddenField_Stock As HiddenField = GridView3.Rows(count).FindControl("HiddenField_Stock")

                If TextBox_Consumed <> "0" Then


                    ' If Convert.ToDouble(HiddenField_Stock.Value) >= Convert.ToDouble(TextBox_Consumed.Text) Then
                    unit_amount = Consumed.item_Amount(HiddenField_Item_Code.ToString, Convert.ToInt32(Session("Dept_ID")), Convert.ToInt32(Session("SubDeptID")))

                    'Response.Write(BatchNo + " ICode " + HiddenField_Item_Code)


                    'If select_Batch_Qty(BatchNo, HiddenField_Item_Code) >= TextBox_Consumed Then
                    '    If flag = 0 Then
                    '        flag = 1
                    '   main_ID = Consumed.Insert_Main_Patient(Convert.ToInt32(Session("Emp_ID")), Convert.ToInt32(Session("Dept_ID")), Convert.ToInt32(Session("SubDeptID")), Convert.ToInt32(Session("ShiftID")), Convert.ToInt32(Session("YearlyNo")), Convert.ToString(Session("RegNo")))
                    'If unit_amount > 0 Then
                    '    Vou_main_Id = voucher.insert_Main_Payment("", constring1, "", Date.Today, "", "", Date.Now.Millisecond.ToString, 1, "0", 1, Session("dept_id"), Session("emp_id"), Session("emp_id"), Session("emp_id"), 0)
                    '    'End If
                    'End If
                    ''HiddenField_Med_Qty.Value = TextBox_Consumed
                    HiddenFieldBatchNo.Value = "000" ' BatchNo
                    '      SqlDataSource_Issue_Item_Sub.Insert()
                    'Consumed.Insert_Sub(main_ID, Convert.ToString(HiddenField_Item_Code), Convert.ToString(HiddenFieldBatchNo.Value), Convert.ToDouble(TextBox_Consumed))
                    'Response.Write(TextBox_Consumed)

                    If TextBox_Consumed <> "0" Then
                        Try
                            Dim tbId As Integer = 0

                            If Not DropDownList_Testbooking.SelectedValue = "" Then
                                tbId = DropDownList_Testbooking.SelectedValue
                            End If
                            main_ID = Consumed.Insert_Main_PatientXRAY(Convert.ToInt32(Session("Emp_ID")), Convert.ToInt32(Session("Dept_ID")), Convert.ToInt32(Session("SubDeptID")), Convert.ToInt32(Session("ShiftID")), Request.QueryString("YearlyNo"), Request.QueryString("Reg_No"), tbId, Request.QueryString("Main_Id"))
                            Consumed.Insert_Sub_Patient(main_ID, Convert.ToString(HiddenField_Item_Code), Convert.ToString(HiddenFieldBatchNo.Value), Convert.ToDouble(TextBox_Consumed), Convert.ToDouble(unit_amount * Convert.ToDouble(TextBox_Consumed)), GridView_TemP_Test.Rows(count).Cells(6).Text)
                        Catch ex As Exception
                            Response.Write(ex.Message + "Textbox Consume <> 0")
                        End Try

                    End If

                    ' End If


                    '                    If unit_amount > 0 Then

                    'voucher.Insert_payment(Vou_main_Id, 0, Consumed.GetConsumptionHead(HiddenField_Item_Code, 33, 47), Convert.ToString(Get_Amt(Convert.ToString(HiddenField_Item_Code)) * Convert.ToDouble(TextBox_Consumed)), 1, 0, "Consumption Of Department " + Consumed.getDeptName(Session("Dept_ID")), constring1, "0", "", "0", Session("SubDeptID"), 0)
                    'voucher.Insert_payment(Vou_main_Id, 0, Consumed.GetHead(HiddenField_Item_Code, 33, 47), Convert.ToString(Get_Amt(Convert.ToString(HiddenField_Item_Code)) * Convert.ToDouble(TextBox_Consumed)), 2, 0, "Stock Of Department " + Consumed.getDeptName(Session("Dept_ID")), constring1, "0", "", "0", Session("SubDeptID"), 0)


                    '    voucher.Insert_payment(Vou_main_Id, 0, Consumed.GetConsumptionHead(HiddenField_Item_Code, Session("Dept_ID"), Session("SubDeptID")), Convert.ToString(unit_amount * Convert.ToDouble(TextBox_Consumed)), 1, 0, "Consumption Of Department " + Consumed.getDeptName(Session("Dept_ID")), constring1, "0", "", "0", Session("SubDeptID"), 0)
                    '    voucher.Insert_payment(Vou_main_Id, 0, Consumed.GetHead(HiddenField_Item_Code, Session("Dept_ID"), Session("SubDeptID")), Convert.ToString(unit_amount * Convert.ToDouble(TextBox_Consumed)), 2, 0, "Stock Of Department " + Consumed.getDeptName(Session("Dept_ID")), constring1, "0", "", "0", Session("SubDeptID"), 0)
                End If

                '               End If

            Next

            If Session("dept_id") = 18 Then
                insert_Bill(GridView_TemP_Test.FooterRow.Cells(6).Text)
            End If
            GridView_Consumed.DataBind()
            Grid_Delete()

            Button_Consumption.Visible = False
            '=========================================
            Dim ds As New Store
            ds.Tables("TempMedicine").Clear()
            GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
            GridView_TemP_Test.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'GridView3.DataBind()
    End Sub
    Protected Function Get_Amt(ByVal Item_code As String) As Double
        Dim amt As Double
        Dim qry As String = "SELECT  Avg_Price FROM Store_Item_Department_Wise WHERE (Dept_Id = 33) AND (SubDept_Id = 47) AND (Item_code = @Item_code)"
        Dim con As SqlConnection = New SqlConnection(constr_Store)
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@Item_code", Item_code)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        While reader.Read
            amt = reader.Item("Avg_Price")
        End While
        con.Close()
        Return amt

    End Function

    Protected Sub insert_Bill(ByVal Amount As Integer)

        Dim con As SqlConnection = New SqlConnection(constr_Basic)
        Dim qry As String = "INSERT INTO Patient_Services (RegNo, YearlyNo, sdatetime, empid, S_ID, Amount, Payment_Status, SubDept_ID, Doctor_Payment, Dept_ID, Qty) VALUES (@RegNo,@YearlyNo,getdate(),@empid,25812,@Amount,0,@SubDept_ID,0,@Dept_ID, 1)"
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text

        command.Parameters.AddWithValue("@RegNo", Convert.ToString(Session("registrationNo")))
        command.Parameters.AddWithValue("@YearlyNo", Convert.ToInt32(Session("YearlyNo")))
        command.Parameters.AddWithValue("@empid", Session("Emp_ID"))
        command.Parameters.AddWithValue("@Amount", Amount)
        command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
        command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))

        con.Open()
        command.ExecuteScalar()
        con.Close()

    End Sub

    Sub Load_Temp_Grid_For_Patient_Consumption()



        Try
            Dim con As SqlConnection = New SqlConnection(constr_Store)
            Dim command As SqlCommand = New SqlCommand("Select_Medicine_For_Selcted_Patient_Consumption", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@Reg_No", Convert.ToString(Session("registrationNo")))
            command.Parameters.AddWithValue("@Yearly_NO", Convert.ToInt32(Session("YearlyNo")))
            command.Parameters.AddWithValue("@DeptID", Session("dept_id"))
            command.Parameters.AddWithValue("@subdeptID", Session("SubDeptID"))
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader

            While reader.Read
                Dim date_time As String = DateTime.Now


                Populate_Temp_Grid(reader.Item("MedCode"), reader.Item("Medicine_Name"), reader.Item("BatchNo"), reader.Item("Default_Qty"), reader.Item("Retail_Unit_Price"), date_time)


            End While
            con.Close()

            'Else
            '    Dim sb As StringBuilder = New StringBuilder
            '    sb.Append("<Script language='javascript' type='text/javascript'>alert('Medicine Not in Stock');</Script>")
            '    Dim t As Type = Me.GetType
            '    If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            '        ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            '    End If
            'End If


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub RadioButtonList_Medicine_OF_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Medicine_OF.SelectedIndexChanged
        If RadioButtonList_Medicine_OF.SelectedValue = "D" Then
            'DataList_Patient_Consumption.Visible = False
            Button_Print.Visible = False
            'DataList1.Visible = True
            'DataList1.DataBind()
            ds.Tables("TempMedicine").Clear()
            GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
            GridView_TemP_Test.DataBind()
            GridViewMedicine.DataBind()

        Else

            GridView_Consumed.DataBind()
            GridView_Consumed.Visible = True
            Button_Print.Visible = True
            'DataList1.Visible = False
            'GridViewMedicine.DataBind()
            Load_Temp_Grid_For_Patient_Consumption()
        End If
    End Sub

    Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click
        Dim sb As StringBuilder = New StringBuilder
        sb.Append("<Script language='javascript' type='text/javascript'>window.open('Consumed_Medicine_Report.aspx');</Script>")
        Dim t As Type = Me.GetType
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If
    End Sub

    Protected Sub Button_Final_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Final.Click
        Try
            SqlDataSource_Update_Status.Update()
            Response.Redirect("Patient_Search.aspx?def=1.2")
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub LinkButton_AppDate_Click(sender As Object, e As System.EventArgs) Handles LinkButton_AppDate.Click
        Response.Redirect("Sample_slip.aspx?Main_ID=" + Request.QueryString("Main_ID").ToString)
    End Sub
    
End Class
