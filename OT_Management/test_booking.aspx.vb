Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Infragistics.WebUI.WebDataInput
Imports Infragistics.WebUI.WebSchedule

Partial Class Test_Booking
    Inherits System.Web.UI.Page
    Dim PAtient_Type As String = ""
    Dim Total_Amount As Integer = 0
    Dim count As Integer = 0
    Dim ENC As New Encryption
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = "LGH/251120060019"
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim statuscmo As String
    Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    Dim b As String = ""
    Dim total_amount_val As Integer
    '=====================********======================================'
    ' Developer Name            Imran Ahmed Awan, Muhammad Aun Abbas
    ' Design Approved  by       Muhammad Tariq
    ' Web Designed By           Imran Sharif
    ' Date Started              October 20 ,2006
    ' Description               This Is for the Test Select Module for the patient that a doctor
    '                           recommend for the patient if tests are already assigned 
    '                           its tests are shown and vitals of patients are displayed on left 
    '                           side of the page.
    ' This form is used for patient Test in Emergency.
    ' Completed date          October 30 , 2006
    '====================*********======================================


    ' this function check alll the items of the selected list one by one 
    ' Which items are checked the Function Insert the Values in the database 
    ' Which Items of the selected checkboxlist are Unchecked That are Delete From the Database 

    Sub Show_Amount()
        Dim RegNo As String = Session("registrationNo")
        Dim YearlyNo As Integer = Session("YearlyNo")
        Dim Count As Integer = 0
        If Pt_Type(RegNo, YearlyNo) = "OPD" Then

            Dim da_Private As New Pt_Radiology_TestTableAdapters.Pt_PaymentTableAdapter
            Dim ds_Private As New Pt_Radiology_Test
            da_Private.Fill_Private(ds_Private.Tables("Pt_Payment"), RegNo, YearlyNo)
            For i As Integer = 0 To ds_Private.Tables("Pt_Payment").Rows.Count - 1
                ds_Private.Tables("Pt_Payment").Rows(i).Item("Reg_No") = ENC.Encrypt_Main(ds_Private.Tables("Pt_Payment").Rows(i).Item("Reg_No"), False)
                Total_Amount = Total_Amount + CInt(ds_Private.Tables("Pt_Payment").Rows(i).Item("Fee"))
            Next
            GridView2.DataSource = ds_Private.Tables("Pt_Payment")
            GridView2.DataBind()
        Else

            Dim da_Public As New Pt_Radiology_TestTableAdapters.Pt_PaymentTableAdapter
            Dim ds_Public As New Pt_Radiology_Test
            da_Public.Fill_Public(ds_Public.Tables("Pt_Payment"), RegNo, YearlyNo)
            'Response.Write("<br />" & ds_Public.Tables("Pt_Payment").Rows.Count)
            For i As Integer = 0 To ds_Public.Tables("Pt_Payment").Rows.Count - 1
                ds_Public.Tables("Pt_Payment").Rows(i).Item("Reg_No") = ENC.Encrypt_Main(ds_Public.Tables("Pt_Payment").Rows(i).Item("Reg_No"), False)
                ds_Public.Tables("Pt_Payment").Rows(i).Item("Fee") = 0
                Total_Amount = 0
            Next
            GridView2.DataSource = ds_Public.Tables("Pt_Payment")
            GridView2.DataBind()
        End If
        'TotalDiscount()
        TextBox_Grand_total.Text = Total_Amount
        TextBox_Total_Price.Text = Total_Amount - TextBox_Grand_discount.Text
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        'inserts tests for patients in database
        ' check that which checboxlist is active and send the value to checkboxlistcheck function.
        ADD()
    End Sub
    Public Sub ADD()
        Try
            add_AppointmentDate()
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Fee_paid = 0)", con)
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
        Dim Counter As Integer = 0
        If GridView_Services.Rows.Count > 0 Then
            Counter = 1
        End If
        If Counter <> 0 Then
            'Button_Move_Next.Visible = True
        End If
        Main_Group()

        Try
            HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
            SqlDataSource_PatientServices.Insert()
        Catch ex As Exception

        End Try

        Show_Amount()
        Save_Payment()
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType()
        sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Payment_report.aspx?Main_Id=" + HiddenFieldMain_ID.Value + "');window.open('PatientRegistration.aspx','_self');</script>")
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("login.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        TextBox6.Focus()
        Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
        'Response.Write(Session("RegistrationNo") & "        " & Session("YearlyNo"))
        Dim user_authen As New User_page_Authentication
        Session("Module_id") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        loginvalidate(Session("emp_id"), Session("dept_id"))
        Label3.Text = ""
        If Page.IsPostBack = False Then
            Select_Sample_No()
            HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
            DropDownList_Main_Group.DataBind()
            HiddenField_Flag.Value = False
            GridView_Booking.DataBind()
            Label2.Text = ""
        End If
        Try
            If Session("YearlyNo").ToString Is Nothing Or Session("RegistrationNo").ToString Is Nothing Then

            Else
                Session.Add("YearlyNo", Request.QueryString("YearlyNo").ToString)
                Session.Add("RegistrationNo", Request.QueryString("Reg_No").ToString)
                HiddenFieldRegNo.Value = Session("registrationNo")
                HiddenFieldYearlyNo.Value = Session("YearlyNo")
            End If
        Catch ex As Exception

        End Try
        datafields()
        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
        Main_Group()
        Button6.Attributes.Add("onclick", "return OpenNewPage()")
    End Sub

    Sub datafields()

    End Sub
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

    Sub Save_Payment()
        Dim RegNo As String = Session("registrationNo")
        Dim YearlyNo As Integer = Session("YearlyNo")
        HiddenFieldTotalAmount.Value = CInt(TextBox_Grand_total.Text)
        HiddenFieldTotalPaid.Value = CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
        HiddenFieldTotal_Discount.Value = TotalDiscount()
        HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
        Insert_Test_Info()
        SqlDataSourceInsertSub.Insert()
        Update_Status()
    End Sub

    Sub Update_Status()
        Try
            Response.Write(HiddenFieldMain_ID.Value)
            'Response.End()
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update Path_Result_Delivery set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "update_status")
        End Try
    End Sub

    Sub Insert_Test_Info()
        Try
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Fee_paid = 0)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
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
            Response.Write("tOW" & ex.Message)
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo & " AND (fee_paid = 0)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function


    Protected Sub Button_Move_Next_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Move_Next.Click
        Try
            'Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
            'HiddenField_Sample_collection.Value = SDate
            'If DropDownList1.SelectedValue = "Days" Then
            'HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
            'ElseIf DropDownList1.SelectedValue = "Hours" Then
            'HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
            'End If
            'Insert_Values()
            'Response.Redirect("Pathology_Payment.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Patient_Dept()
        Try
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim command As SqlCommand = New SqlCommand("SELECT Payment.DeptID, Forward_To_Sub_Dept.to_sub_Dept FROM Payment INNER JOIN Forward_To_Sub_Dept ON Payment.PayID = Forward_To_Sub_Dept.yearly_no AND Payment.RegNo = Forward_To_Sub_Dept.Reg_No WHERE (Payment.PayID = @PayID) AND (Payment.RegNo = @RegNo)", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            While reader.Read
                Session.Add("Refferal_Dept", reader.Item(0).ToString)
                Session.Add("Refferal_SubDept", reader.Item(1).ToString)
            End While
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Insert_Values()
        Patient_Dept()
        Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        HiddenField_Sample_collection.Value = SDate
        If DropDownList1.SelectedValue = "Days" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
        ElseIf DropDownList1.SelectedValue = "Hours" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
        End If
        Try
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
            param = mycommand.Parameters.AddWithValue("@Description", TextBoxDescription.Text)
            param = mycommand.Parameters.AddWithValue("@Test_Type_ID", RadioButtonList_Type.SelectedValue)
            param = mycommand.Parameters.AddWithValue("@From_Dept_ID", Session("Refferal_Dept"))
            param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", Session("Refferal_SubDept"))
            param = mycommand.Parameters.AddWithValue("@To_Dept_ID", Session("dept_id"))
            param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", Session("SubDeptID"))
            param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
            mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
            param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", 0)
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            'Label3.Text = mycommand.Parameters("@identity1").Value
            HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)

        End Try

    End Sub
    Sub Select_Sample_No()
        Try
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_SampleNo", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.Add("@Sample", SqlDbType.Int)
            mycommand.Parameters("@Sample").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            TextBox_Sample_number.Text = mycommand.Parameters("@Sample").Value
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList2.SelectedIndexChanged
        Try
            If DropDownList2.SelectedItem.Text = "Biopsy" Then
                Response.Redirect("Path_Test_Biopsy.aspx?YearlyNo=" & Request.QueryString("YearlyNo").ToString & "&RegNo=" & Request.QueryString("RegNo").ToString)
            End If
        Catch ex As Exception

        End Try
        HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
        Label2.Text = ""
        Try
            HiddenField2.Value = DropDownList2.SelectedItem.Text
            labelGName.Text = HiddenField2.Value
            btnAdd.Visible = True
            BtnUncheckAll.Visible = True
        Catch ex As Exception
            labelGName.Text = ""
        End Try
        ' call the checkTest function for the checkboxlistTest 
    End Sub
    Sub Main_Group()
        'Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString


        'Response.Write(Session("YearlyNo"))
        'Response.End()

        Dim con As SqlConnection = New SqlConnection(a)
        con.Open()
        Dim command1 As SqlCommand = New SqlCommand("Select_Main_Group_For_Assign_Test", con)
        command1.CommandType = CommandType.StoredProcedure
        command1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
        command1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = command1
        da.Fill(ds, "ABC")
        TreeView1.Nodes.Clear()
        For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
            Dim obj As TreeNode = New TreeNode(ds.Tables(0).Rows(i).Item(1).ToString, ds.Tables(0).Rows(i).Item(0))
            TreeView1.NodeStyle.ForeColor = Drawing.Color.Green
            TreeView1.NodeStyle.Font.Bold = True
            TreeView1.Nodes.Add(obj)
            Tests(ds.Tables(0).Rows(i).Item(0), obj)
        Next
        TreeView1.CollapseAll()
        con.Close()
    End Sub
    Sub Tests(ByVal cat_ID As Integer, ByVal obj As TreeNode)
        Try
            Dim con As SqlConnection = New SqlConnection(a)
            con.Open()
            Dim command1 As SqlCommand = New SqlCommand("Select_Sub_Group_For_Assign_Test", con)
            command1.CommandType = CommandType.StoredProcedure
            command1.Parameters.AddWithValue("@TGID", cat_ID)
            command1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            command1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            Dim reader As SqlDataReader = command1.ExecuteReader()
            While reader.Read
                Dim obj1 As TreeNode = New TreeNode(reader.GetString(1), reader.GetInt32(0))
                obj.ChildNodes.Add(obj1)
                TreeView1.LeafNodeStyle.Font.Bold = False
                TreeView1.LeafNodeStyle.ForeColor = Drawing.Color.Blue
            End While
            reader.Close()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "RET ")
        End Try
    End Sub


    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button6.Click
        Button6.Attributes.Add("onclick", "return OpenNewPage()")
    End Sub

    Protected Sub GridView_Booking_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Booking.PreRender
        'For i As Integer = 0 To GridView_Booking.Rows.Count - 1
        '    If i = 0 Then
        '    Else
        '        If GridView_Booking.Rows(i).Cells(2).Text = GridView_Booking.Rows(i - 1).Cells(2).Text Then
        '            GridView_Booking.Rows(i).Cells(2).Text = ""
        '        End If
        '    End If
        'Next
        Dim ENC As New Encryption
        ENC.Grid_prerender(GridView_Booking, 2)
    End Sub

    Protected Sub GridView_Booking_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Booking.RowDataBound

    End Sub

    Protected Sub GridView_Booking_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Booking.SelectedIndexChanged
        Try
            Dim Hid_TB_ID As HiddenField = GridView_Booking.Rows(GridView_Booking.SelectedIndex).FindControl("HiddenField_TB_ID")
            HiddenField_TBID.Value = Hid_TB_ID.Value
            Insert_Values()
            SqlDataSource_Booking.Insert()
            GridView_Services.DataBind()
            'GridView_Services.FooterRow.Visible = True

            footer()
            Select_Date()
            'Button_Save.Visible = True
        Catch ex As Exception
            Response.Write(ex.Message & "kjkkj")
        End Try
    End Sub

    Public Sub Select_Date()
        Try
            'Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim qry As String = "SELECT Test_Booking_Services.ID, isnull(convert(varchar,Test_Booking_Services.Appointment_Date,103),'') as Appointment_Date,isnull(convert(varchar,Test_Booking_Services.Appointment_Date,108),'') as Appointment_Time, isnull(convert(varchar,Test_Booking_Services.Report_Date,103),'') Report_Date,isnull(convert(varchar,Test_Booking_Services.Report_Date,103),'') Report_Time FROM Test_Booking_Services INNER JOIN Test_Booking ON Test_Booking_Services.TB_ID = Test_Booking.TB_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID INNER JOIN Test_Status ON Test_Booking_Services.Status = Test_Status.Status_ID WHERE (Path_Result_Delivery.Yearly_No = @YearlyNo) AND (Path_Result_Delivery.Reg_no = @RegNo)"
            Dim cmd_SelectDate As SqlCommand = New SqlCommand(qry, con)
            cmd_SelectDate.CommandType = CommandType.Text
            con.Open()
            cmd_SelectDate.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            cmd_SelectDate.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            Dim reader As SqlDataReader = cmd_SelectDate.ExecuteReader
            While reader.Read
                For i As Integer = 0 To GridView_Services.Rows.Count - 1
                    If reader.Item("ID").ToString = GridView_Services.Rows(i).Cells(6).Text Then
                        Dim WebDateChooser_Appointment As WebDateChooser = GridView_Services.Rows(i).FindControl("WebDateChooser_Appointment")
                        Dim WebDateTimeEdit_Appointment As WebDateTimeEdit = GridView_Services.Rows(i).FindControl("WebDateTimeEdit_Appointment")
                        Dim WebDateChooser_Report As WebDateChooser = GridView_Services.Rows(i).FindControl("WebDateChooser_Report")
                        Dim WebDateTimeEdit_Report As WebDateTimeEdit = GridView_Services.Rows(i).FindControl("WebDateTimeEdit_Report")

                        If reader.Item("Appointment_Date").ToString = "" Then
                            WebDateChooser_Appointment.Value = Date.Now
                        Else
                            WebDateChooser_Appointment.Value = reader.Item("Appointment_Date").ToString
                        End If

                        If reader.Item("Appointment_Time").ToString = "" Then
                            WebDateTimeEdit_Appointment.Value = Date.Now.TimeOfDay
                        Else
                            WebDateTimeEdit_Appointment.Value = reader.Item("Appointment_Time").ToString
                        End If


                        If reader.Item("Report_Date").ToString = "" Then
                            WebDateChooser_Report.Value = Date.Now.AddDays(2)
                        Else
                            WebDateChooser_Report.Value = reader.Item("Report_Date").ToString
                        End If


                        If reader.Item("Report_Time").ToString = "" Then
                            WebDateTimeEdit_Report.Value = Date.Now.TimeOfDay
                        Else
                            WebDateTimeEdit_Report.Value = reader.Item("Report_Time").ToString
                        End If


                    End If
                Next


            End While

            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim sb As New StringBuilder
        Dim t As Type = Me.GetType()
        sb.Append("<script language='javascript' type='text/javascript'>window.open('PatientRegistration.aspx','_self');</script>")
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If
        'Response.Redirect("Path_test.aspx?YearlyNo=" & Session("YearlyNo") & "&RegNO=" & Session("RegistrationNo"))
    End Sub

    Protected Sub TextBox_Test_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Test.TextChanged
        HiddenField_Flag.Value = True
    End Sub

    Protected Sub DropDownList_Main_Group_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Main_Group.SelectedIndexChanged
        HiddenField_Flag.Value = False
        GridView_Booking.DataBind()
    End Sub

    Protected Sub GridView_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Services.PreRender
        Dim ENC As New Encryption
        'ENC.Grid_prerender(GridView_Services, 1)
        If (GridView_Services.Rows.Count <> 0) Then


            For i As Integer = 0 To GridView_Services.Rows.Count - 1
                'Response.Write(GridView_Services.Rows(i).Cells(3).Text)
                If GridView_Services.Rows(i).Cells(3).Text = "Received Sample" Then
                    'GridView_Services.Rows(i).Cells(3).Visible = True
                    ' GridView_Services.Rows(i).Cells(2).Enabled = True
                Else
                    GridView_Services.Rows(i).Cells(3).Visible = True
                    'GridView_Services.Rows(i).Cells(2).Text = GridView_Services.Rows(i).Cells(3).Text
                    ' GridView_Services.Rows(i).Cells(2).Enabled = False
                    '  GridView_Services.Rows(i).Cells(3).Visible = False
                End If
                GridView_Services.Rows(i).Cells(6).Visible = False
                GridView_Services.Rows(i).Cells(3).Visible = False

                GridView_Services.FooterRow.Cells(3).Visible = False
                GridView_Services.HeaderRow.Cells(3).Visible = False
                GridView_Services.FooterRow.Cells(6).Visible = False
            Next
            GridView_Services.HeaderRow.Cells(6).Visible = False
        End If
    End Sub

    Protected Sub TextBox5_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        TotalDiscount()
    End Sub

    Function TotalDiscount() As Integer
        Dim count As Integer = 0
        Dim total_Discount As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView2.Rows.Count - 1
                    count = count + CInt(GridView2.Rows(i).Cells(6).Text)
                Next
                'Response.Write(count)
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
            TextBox_Total_Price.Text = count - total_Discount
        Catch ex As Exception
            Response.Write("ONE" & ex.Message)
        End Try
        Return total_Discount
    End Function

    Function Pt_Type(ByVal RegNo As String, ByVal yearlyno As Integer) As String
        Dim da_Basic As New Pt_Radiology_TestTableAdapters.Pt_Basic_DataTableAdapter
        Dim ds_Basic As New Pt_Radiology_Test
        da_Basic.Fill(ds_Basic.Tables("Pt_Basic_Data"), RegNo, yearlyno)
        PAtient_Type = ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("Patient_Type")
        Return PAtient_Type
    End Function

    Protected Sub DropDownList_Discount_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Discount_Type.SelectedIndexChanged
        TotalDiscount()
    End Sub

    Protected Sub TextBox6_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox6.TextChanged
        Dim TestName As String = ""
        HiddenField_Flag.Value = True
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select TB_Name From Test_Booking where TB_ID= " & TextBox6.Text, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            TestName = mycommand.ExecuteScalar
            mycommand.Connection.Close()
            TextBox_Test.Text = TestName
            If TextBox_Test.Text = "" Then

            Else

                Try

                    '           Response.Write(HiddenField_TBID.Value & " check Test Name")

                    HiddenField_TBID.Value = TextBox6.Text

                    Insert_Values()
                    SqlDataSource_Booking.Insert()
                    GridView_Services.DataBind()
                    TextBox6.Text = ""

                Catch ex As Exception

                End Try
            End If


        Catch ex As Exception
            '   Response.Write(ex.Message & " Select Test Name")
        End Try
    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        add_AppointmentDate()
    End Sub

    Public Sub add_AppointmentDate()

        Try
            'Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim qry As String = "Udate_Appointment_Report_Date"
            For i As Integer = 0 To GridView_Services.Rows.Count - 1

                Dim WebDateChooser_Appointment As WebDateChooser = GridView_Services.Rows(i).FindControl("WebDateChooser_Appointment")
                Dim WebDateTimeEdit_Appointment As WebDateTimeEdit = GridView_Services.Rows(i).FindControl("WebDateTimeEdit_Appointment")
                Dim WebDateChooser_Report As WebDateChooser = GridView_Services.Rows(i).FindControl("WebDateChooser_Report")
                Dim WebDateTimeEdit_Report As WebDateTimeEdit = GridView_Services.Rows(i).FindControl("WebDateTimeEdit_Report")


                Dim cmd_insertDate As SqlCommand = New SqlCommand(qry, con)
                cmd_insertDate.CommandType = CommandType.StoredProcedure
                con.Open()


                Dim AppointmentDate As DateTime = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_Appointment.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_Appointment.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_Appointment.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_Appointment.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Appointment.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Appointment.Value).Second.ToString)
                Dim ReportDate As DateTime = Convert.ToDateTime(Convert.ToDateTime(WebDateChooser_Report.Value).Year.ToString + "-" + Convert.ToDateTime(WebDateChooser_Report.Value).Month.ToString + "-" + Convert.ToDateTime(WebDateChooser_Report.Value).Day.ToString + " " + Convert.ToDateTime(WebDateTimeEdit_Report.Value).Hour.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Report.Value).Minute.ToString + ":" + Convert.ToDateTime(WebDateTimeEdit_Report.Value).Second.ToString)

                cmd_insertDate.Parameters.AddWithValue("@Appointment_Date", AppointmentDate)
                'cmd_insertDate.Parameters.AddWithValue("@Appointment_Time", WebDateTimeEdit_Appointment.Value)

                cmd_insertDate.Parameters.AddWithValue("@Report_Date", ReportDate)
                'cmd_insertDate.Parameters.AddWithValue("@Report_Time", WebDateTimeEdit_Report.Value)

                cmd_insertDate.Parameters.AddWithValue("@ID", GridView_Services.Rows(i).Cells(6).Text)

                cmd_insertDate.ExecuteNonQuery()

                con.Close()
            Next

            Button_Save.Visible = False

        Catch ex As Exception
            Response.Write(ex.Message)
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


    Protected Sub Button_ForAppointment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_ForAppointment.Click
        ADD()
        update_Test_Booking_Status(14)
    End Sub

    Protected Sub Button_ForPayment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_ForPayment.Click
        ADD()
        update_Test_Booking_Status(13)
    End Sub

    Protected Sub GridView_Services_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Services.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lb As Label = e.Row.FindControl("Label1")

            total_amount_val = total_amount_val + Convert.ToInt32(lb.Text)
        End If
    End Sub

    Protected Sub GridView_Services_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Services.SelectedIndexChanged

    End Sub

    Protected Sub GridView_Services_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs)
        GridView_Services.DataBind()
        footer()
    End Sub
    Sub footer()
        Dim lb As Label = GridView_Services.FooterRow.FindControl("Label_amount")
        Dim lb_total As Label = GridView_Services.FooterRow.FindControl("Label_total")

        lb.Text = Convert.ToString(total_amount_val)
        lb_total.Text = "Total :"

    End Sub

    Protected Sub GridView_Services_RowDeleted1(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView_Services.RowDeleted
        GridView_Services.DataBind()
        footer()
    End Sub
End Class