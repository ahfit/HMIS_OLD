Imports System.Data
Imports System.Data.SqlClient
Partial Class Nursing_NurseServices_Page
    Inherits System.Web.UI.Page
    Dim b, c As String
    Dim total As Integer = 0
    Dim day_total As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim coma As New Coma
    Dim dontRebind As Boolean = False
    Dim Enc As New Encryption

    Protected Sub GridView_Date_Wise_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Date_Wise.PreRender
        'GridView_PreRender_For_DropDownList(False)
        Dim com As Coma = New Coma()
        Dim Grid As GridView = DirectCast(sender, GridView)

        If Grid.Rows.Count > 0 Then
            Dim Disc_Label As Label = Nothing
            Dim Amt_Label As Label = Nothing

            Dim Total_Discount As Integer = 0
            Dim Total_Amount As Integer = 0

            For Each row As GridViewRow In Grid.Rows

                Disc_Label = DirectCast(row.FindControl("lblDiscount"), Label)
                Amt_Label = DirectCast(row.FindControl("lblAmount"), Label)

                Total_Discount += Convert.ToInt32(Disc_Label.Text)
                Total_Amount += Convert.ToInt32(Amt_Label.Text)

            Next

            Dim Discount_Label As Label = DirectCast(Grid.FooterRow.FindControl("Discount_Label"), Label)
            Dim Amount_Label As Label = DirectCast(Grid.FooterRow.FindControl("Amount_Label"), Label)

            Discount_Label.Text = com.place_Coma(Total_Discount.ToString())
            Amount_Label.Text = com.place_Coma(Total_Amount.ToString())
        End If
    End Sub



    Protected Sub GridView_Date_Wise_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView_Date_Wise.RowCommand

        If e.CommandName = "Cancel" Then

            Dim Hid_ID As HiddenField = GridView_Date_Wise.Rows(e.CommandArgument).FindControl("HiddenFieldID")
            Dim S_ID As HiddenField = GridView_Date_Wise.Rows(e.CommandArgument).FindControl("HiddenField_SID2")
            HiddenField_ID.Value = Hid_ID.Value
            HiddenFieldS_ID.Value = S_ID.Value
            GridView_Date_Wise.DataBind()
            SqlDataSource_Grid2.Delete()
            GridView_Date_Wise.DataBind()
            totaldata()
            HiddenField_Flag.Value = 1
        End If
    End Sub
    Sub totaldata()
        day_total = 0
        total = 0

        For count As Integer = 0 To GridView_Date_Wise.Rows.Count - 1

            Dim partyId As HiddenField = DirectCast(GridView_Date_Wise.Rows(count).FindControl("HiddenField_PartyId"), HiddenField)
            Dim patientValue As HiddenField = DirectCast(GridView_Date_Wise.Rows(count).FindControl("HiddenField_Patient_Value"), HiddenField)
            Dim amount As String = 0

            If partyId.Value <> 0 Then
                amount = patientValue.Value

            Else
                amount = DataBinder.Eval(GridView_Date_Wise.Rows(count).DataItem, "S_Amount")
            End If


            If (b = "") Then
                b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = b
                day_total = 0

                day_total += Convert.ToInt32(amount)



            ElseIf b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text Then

                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = ""
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = ""
                day_total += Convert.ToInt32(amount)

            Else

                b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = b
                If Convert.ToInt32(count) > Convert.ToInt32(1) Then
                    Dim lb_day As Label = GridView_Date_Wise.Rows(count - 1).FindControl("Label_day")
                    lb_day.Text = day_total
                End If
                day_total = 0
                day_total += Convert.ToInt32(amount)
            End If
            total += Convert.ToInt32(amount)
        Next
        GridView_Date_Wise.FooterRow.Cells(2).Text = "Total :"
        GridView_Date_Wise.FooterRow.Cells(4).Text = coma.place_Coma(total)
    End Sub
    Protected Function GetDoctors(ByVal sId As String) As DataTable

        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim adpt As New SqlDataAdapter

        Dim dt As DataTable = New DataTable()
        Try

            connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataConnectionString").ConnectionString
            command.Connection = connection
            command.CommandType = CommandType.Text

            command.CommandText = "SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID, Doctor_Service.Service_ID FROM Doctor_Service INNER JOIN Employee ON Doctor_Service.Doctor_ID = Employee.EmpID WHERE (Doctor_Service.Service_ID = @Service_ID) ORDER BY Employee.EFName"
            command.Parameters.AddWithValue("@Service_ID", sId)
            adpt = New SqlDataAdapter(command)
            connection.Open()
            adpt.Fill(dt)
            connection.Close()

        Catch ex As Exception
            connection.Close()

        End Try
        Return dt
    End Function
    Protected Sub GridView_Date_Wise_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Date_Wise.RowDataBound
        Try

            If e.Row.RowType = DataControlRowType.DataRow Then


                Dim lblAmount As Label = DirectCast(e.Row.FindControl("lblAmount"), Label)
                Dim lblSAmount As Label = DirectCast(e.Row.FindControl("lblSAmount"), Label)

                Dim lblCharges As Label = DirectCast(e.Row.FindControl("lblCharges"), Label)
                Dim partyId As HiddenField = DirectCast(e.Row.FindControl("HiddenField_PartyId"), HiddenField)
                Dim patientValue As HiddenField = DirectCast(e.Row.FindControl("HiddenField_Patient_Value"), HiddenField)
                Dim ServiceAmount As HiddenField = DirectCast(e.Row.FindControl("HiddenField_SAmount"), HiddenField)

                Dim ddlDoctor As DropDownList = DirectCast(e.Row.FindControl("DropDownList_Doctor"), DropDownList)
                Dim sId As HiddenField = DirectCast(e.Row.FindControl("HiddenField_SID2"), HiddenField)

                Dim dtDoc As DataTable = GetDoctors(sId.Value)
                ddlDoctor.DataSource = dtDoc
                ddlDoctor.DataBind()


                Dim dr As DataRowView = DirectCast(e.Row.DataItem, DataRowView)

                Dim selectedDoct As String = dr("Doctor_ID").ToString()
                If Not selectedDoct = "0" Then
                    ddlDoctor.SelectedValue = selectedDoct
                End If

                If ddlDoctor.Items.Count > 0 Then
                    ddlDoctor.Items.Insert(0, New ListItem("", ""))
                    ddlDoctor.Visible = True
                Else
                    ddlDoctor.Visible = False
                End If

                Dim amount As String = patientValue.Value

                'If partyId.Value <> 0 Then
                '    If patientValue.Value = 0 Then
                '        amount = ServiceAmount.Value
                '    End If

                '    lblAmount.Text = amount
                '    lblCharges.Text = amount
                '    lblSAmount.Text = amount
                'End If

                total += Convert.ToInt32(lblAmount.Text)

                If (b = "") Then
                    b = e.Row.Cells.Item(0).Text
                    e.Row.Cells.Item(0).Text = b
                    day_total = 0

                    day_total += Convert.ToInt32(lblAmount.Text)

                ElseIf b = e.Row.Cells.Item(0).Text Then

                    e.Row.Cells.Item(0).Text = ""
                    e.Row.Cells.Item(0).Text = ""
                    day_total += Convert.ToInt32(lblAmount.Text)

                Else

                    b = e.Row.Cells.Item(0).Text
                    e.Row.Cells.Item(0).Text = b
                    If Convert.ToInt32(e.Row.RowIndex) > Convert.ToInt32(1) Then
                        Dim lb_day As Label = GridView_Date_Wise.Rows(e.Row.RowIndex - 1).FindControl("Label_day")
                        lb_day.Text = day_total
                    End If
                    day_total = 0

                    day_total += Convert.ToInt32(lblAmount.Text)


                End If
            End If

            If e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(2).Text = "Total :"
                e.Row.Cells(4).Text = coma.place_Coma(total.ToString)

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        For i As Integer = 0 To GridView2.Rows.Count - 1

            Dim a As Label = GridView2.Rows(i).FindControl("HiddenFieldSAmount")
            Dim b As Label = GridView2.Rows(i).FindControl("HiddenFieldSID")
            Dim c As Label = GridView2.Rows(i).FindControl("HiddenField_Edit_Status")
            a.Visible = False
            b.Visible = False
            c.Visible = False

            'Dim Hid_Edit As HiddenField = GridView2.Rows(i).FindControl("HiddenField_Edit_Status")

            'Dim HFSAmount As HiddenField = GridView2.Rows(i).FindControl("HiddenFieldSAmount")
            Dim Hid_Amount As TextBox = GridView2.Rows(i).FindControl("TextBox_Amount")
            Dim Hid_lbl As Label = GridView2.Rows(i).FindControl("Label1")

            Hid_Amount.Text = coma.place_Coma(Hid_lbl.Text)


            Hid_Amount.Visible = True
            Hid_lbl.Visible = False

        Next


    End Sub




    Sub Javascript(ByVal msg As String)
        Response.Write("<script language ='Javascript'>alert('" & msg & "');</script>")
    End Sub


    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.SelectedIndexChanged
        Dim index As Integer = GridView2.SelectedIndex
        If HiddenField_Previous_index.Value <> index Then
            Insert_services(index)
        End If
    End Sub
    Sub Search_data()
        Dim count As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim reader As SqlDataReader
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT   Count(Test_Services.Test_ID) FROM         Patient_Services INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID INNER JOIN Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id INNER JOIN Test_Services ON Test_Booking.TB_ID = Test_Services.TB_ID Where Admin_Services.S_ID=@S_ID and RegNo=@RegNo and  YearlyNo=@YearlyNo and Test_Services.Test_ID  in (SELECT     Test_Services.Test_ID FROM         Patient_Services INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID INNER JOIN Test_Booking ON Admin_Services.S_ID = Test_Booking.S_Id INNER JOIN Test_Services ON Test_Booking.TB_ID = Test_Services.TB_ID INNER JOIN Test ON Test_Services.Test_ID = Test.TID WHERE     (Admin_Services.S_ID = @S_ID) AND (Patient_Services.RegNo = @RegNo) AND (Patient_Services.YearlyNo = @YearlyNo) )  ", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@S_ID", HiddenField_SID.Value)
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Connection.Open()
        reader = mycommand.ExecuteReader
        If reader.Read() Then

            count = reader.Item(0)


        Else

            count = 0


        End If

        If count <> 0 Then

        End If

        reader.Close()
        mycommand.Connection.Close()

    End Sub

    Sub grid_r()
        Try
            If GridView_Date_Wise.Rows.Count > 1 Then
                Dim lb_day As Label = GridView_Date_Wise.Rows(GridView_Date_Wise.Rows.Count - 1).FindControl("Label_day")
                lb_day.Text = day_total
                lb_day.Text = coma.place_Coma(lb_day.Text)
            End If


        Catch ex As Exception

        End Try
    End Sub
    Protected Sub DropDownList_Doctor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim Hid_ID As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenFieldID")
            Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
            Try

                Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                'Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (S_ID = @S_ID)", con)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (ID = @ID)", con)
                mycommand.CommandType = Data.CommandType.Text
                If Drop.SelectedItem.Text.Trim <> "" Then
                    mycommand.Parameters.AddWithValue("@Doctor_ID", Drop.SelectedValue)
                    mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                    mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@ID", Hid_ID.Value)
                    mycommand.Connection.Open()
                    mycommand.ExecuteNonQuery()
                    mycommand.Connection.Close()
                    LabelAmountError.Visible = False
                ElseIf Drop.SelectedItem.Text.Trim = "" Then
                    mycommand.Parameters.AddWithValue("@Doctor_ID", DBNull.Value)
                    mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                    mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@ID", Hid_ID.Value)
                    mycommand.Connection.Open()
                    mycommand.ExecuteNonQuery()
                    mycommand.Connection.Close()
                    LabelAmountError.Visible = False
                End If
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        Next
    End Sub
    Sub update_patient_Service(ByVal Doctor_ID As Int32)
        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim Hid_ID As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenFieldID")
            Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
            Try

                Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                'Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (S_ID = @S_ID)", con)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (ID = @ID)", con)
                mycommand.CommandType = Data.CommandType.Text
                If Drop.SelectedItem.Text.Trim <> "" Then
                    mycommand.Parameters.AddWithValue("@Doctor_ID", Doctor_ID)
                    mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                    mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@ID", Hid_ID.Value)
                    mycommand.Connection.Open()
                    mycommand.ExecuteNonQuery()
                    mycommand.Connection.Close()
                    LabelAmountError.Visible = False
                ElseIf Drop.SelectedItem.Text.Trim = "" Then
                    mycommand.Parameters.AddWithValue("@Doctor_ID", DBNull.Value)
                    mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                    mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@ID", Hid_ID.Value)
                    mycommand.Connection.Open()
                    mycommand.ExecuteNonQuery()
                    mycommand.Connection.Close()
                    LabelAmountError.Visible = False
                End If
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try
        Next
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Session("PatientBillingParty_Id"))
        'Response.End()
        Dim obj_menu As New JavaScriptMenu()
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Request.PhysicalPath.Substring(0, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        'LabelSideMenu.Text = obj_menu.SideMenu(string. (Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)));
        LabelFooter.Text = obj_menu.Footer_String()

        hidRegNo.Value = Session("RegistrationNo")
        HidYearlyNo.Value = Session("YearlyNo")
        TextBox_Search_Service.Focus()
        ' GridView2.Focus()
        loginvalidate(Session("emp_id"), Session("dept_id"))
        Try
            grid_r()

        Catch ex As Exception

        End Try

        If Page.IsPostBack = False Then

            If Not String.IsNullOrEmpty(hidRegNo.Value) Then
                lbl_Mr_No.Text = hidRegNo.Value
            End If
            AutoComplete_Complaint.ContextKey = GetContextKey()
            DropDownList1.DataBind()
            DropDownList_Admin_Service_Package.DataBind()
            WebDateChooser1.Value = Date.Now
            GridView2.DataBind()
            DropDownList_Refer_By.DataBind()
            getDoctorFromPayment()
        End If
    End Sub
    Sub getDoctorFromPayment()
        Try
            Dim dbMgr As New DbManager()
            Dim para As SqlParameter() = {New SqlParameter("payID", Request.QueryString("payid"))}
            Dim dt As DataTable = dbMgr.ExecuteDataTable("usp_GetDoctorFromPayment", "Basic_Data_ConnectionString", para)
            If dt.Rows.Count > 0 Then
                DropDownList_Refer_By.SelectedValue = dt.Rows(0)("DoctorID")

            End If

        Catch ex As Exception

        End Try
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'this function use to chck that it is a  valid user or not ' 
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
                'Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub



    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Try
            For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
                Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
                If Drop.Visible = True Then
                    If Drop.SelectedValue = "" Then
                        GridView_Date_Wise.DataBind()
                        LabelAmountError.Visible = True
                        LabelAmountError.Text = "Add Consultant Name"
                        Drop.DataBind()
                        HiddenField_Flag.Value = 1
                        Exit Sub
                    Else
                        '  Response.Write("<script language ='javascript' type ='text/javascript'>window.open('../MainPage.aspx','_top');</script>")
                        LabelAmountError.Visible = False

                    End If
                Else
                    ' Response.Write("<script language ='javascript' type ='text/javascript'>window.open('../MainPage.aspx','_top');</script>")
                End If
            Next
            grid_r()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Write("<script language ='javascript' type ='text/javascript'>window.open('../MainPage.aspx','_top');</script>")
    End Sub

    Function Check_Consultant() As Boolean
        Dim check As Boolean = False
        If GridView_Date_Wise.Rows.Count <> 0 Then
            For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
                Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
                If Drop.Visible = True Then
                    If Drop.SelectedValue = "" Then
                        GridView_Date_Wise.DataBind()
                        LabelAmountError.Visible = True
                        LabelAmountError.Text = "Add Consultant Name"
                        Drop.DataBind()
                        HiddenField_Flag.Value = 1
                        check = False
                    Else
                        check = True
                        LabelAmountError.Visible = False
                    End If
                Else
                    check = True
                End If
            Next
        Else
            check = True
        End If
        Return check
    End Function

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        TextBox_Search_Service.Text = ""
        AutoComplete_Complaint.ContextKey = GetContextKey()
    End Sub

    Private Function GetContextKey() As String
        Dim retVal As String = String.Empty

        Try

            Dim cat As String, regno As String, yearlyNo As Integer, AttachHospitalID As Integer, Patient_type_Id As Integer, IPDOPD As String, PatientBillingParty_Id As Integer

            If DropDownList1.SelectedValue = String.Empty Then
                cat = "%"
            Else
                cat = DropDownList1.SelectedValue
            End If

            If Request.QueryString("regno") IsNot Nothing Then
                regno = Request.QueryString("regno").ToString()
            Else
                regno = String.Empty
            End If

            If Request.QueryString("payid") IsNot Nothing Then
                yearlyNo = Request.QueryString("payid").ToString()
            Else
                yearlyNo = 0
            End If

            If Session("AttachHospitalID") IsNot Nothing Then
                AttachHospitalID = Session("AttachHospitalID").ToString()
            Else
                AttachHospitalID = 0
            End If

            If Session("Patient_type_Id") IsNot Nothing Then
                Patient_type_Id = Session("Patient_type_Id")
            Else
                Patient_type_Id = 0
            End If

            If Session("IPDOPD").ToString() IsNot Nothing Then
                IPDOPD = Session("IPDOPD").ToString()
            Else
                IPDOPD = "OPD"
            End If

            If Session("IPDOPD").ToString() IsNot Nothing Then
                PatientBillingParty_Id = Session("PatientBillingParty_Id")
            Else
                PatientBillingParty_Id = 0
            End If


            retVal = cat & "@" & regno & "@" & yearlyNo.ToString() & "@" & AttachHospitalID.ToString() & "@" & Patient_type_Id.ToString() &
                "@" & IPDOPD & "@" & PatientBillingParty_Id.ToString()

        Catch ex As Exception
            retVal = String.Empty
        End Try

        Return retVal
    End Function

    Protected Sub Button_Payment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Payment.Click
        'Response.Redirect("Patient_Payment.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))


        Response.Redirect("Indoor_Patient_Paymen.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
    End Sub


    Protected Sub SqlDataSource_For_Grid_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_For_Grid.Inserted
        Label_msg.Text = e.Command.Parameters("@msg").Value
        Label_msg.ForeColor = System.Drawing.Color.Green
    End Sub



    Protected Sub DropDownList_Admin_Service_Package_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Admin_Service_Package.SelectedIndexChanged
        Try
            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandText = " SELECT     Total_Amount FROM         Admin_Service_Package where ASP_ID= " + DropDownList_Admin_Service_Package.SelectedValue
            connection.Open()
            reader = command.ExecuteReader
            If reader.Read Then
                Label_Amount.Text = coma.place_Coma(reader.Item(0))
            End If
            reader.Close()
            connection.Close()

        Catch ex As Exception

        End Try
    End Sub


    Protected Sub TextBox_Search_Service_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Search_Service.TextChanged
        If dontRebind Then Return
        GridView2.DataBind()
    End Sub

    Sub Get_Services(ByVal regno As String, ByVal payid As Integer)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @DeptID = deptid from payment where regNo = @RegNo and payid = @payid", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            mycommand.Parameters.Add("@DeptID", SqlDbType.Int)
            mycommand.Parameters("@DeptID").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Session.Add("Dept_Service", mycommand.Parameters("@DeptID").Value)
            Dim yearly As Integer = mycommand.Parameters("@DeptID").Value
            mycommand.Connection.Close()

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub Search(ByVal reg As String)


        Dim Visit_No As String = ""


        Try



            Dim where As String = " where (RegNo = '" + reg + "')"
            Dim query As String = ""
            Dim order As String = "ORDER BY PayID DESC"
            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            command = connection.CreateCommand

            query = "SELECT top(1)PayID FROM Payment  "



            query = query + where + order
            command.CommandText = query


            connection.Open()
            reader = command.ExecuteReader
            If reader.Read Then

                Visit_No = reader.Item(0).ToString

            End If

            connection.Close()

        Catch ex As Exception

        End Try


        Try

            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @DeptID = deptid from payment where regNo = @RegNo and payid = @payid", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", reg)
            mycommand.Parameters.AddWithValue("@payid", Visit_No)
            mycommand.Parameters.Add("@DeptID", SqlDbType.Int)
            mycommand.Parameters("@DeptID").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Session.Add("Dept_Service", mycommand.Parameters("@DeptID").Value)

            mycommand.Connection.Close()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Session.Add("registrationNo", reg)
        Session.Add("YearlyNo", Visit_No)
        Response.Redirect("~/Patient Billing/Services_Page.aspx?regno=" + reg + "&payid=" + Visit_No)

    End Sub

    Protected Sub TXT_Load_patient_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TXT_Load_patient.TextChanged
        If Not String.IsNullOrEmpty(TXT_Load_patient.Text.Trim()) Then
            Dim reg As String = "SMC-" + Right("000000" + TXT_Load_patient.Text.Trim(), 6) + "-" + Right(Date.Now.Year, 2)

            Search(Enc.Encrypt_Main(reg, True))

        End If
    End Sub


    Protected Sub Insert_services(ByVal index As Integer)
        Try

            If HiddenField_Previous_index.Value <> index Then

                HiddenField_Previous_index.Value = index
                If TextBox_refer_other.Text = "" Then

                    HiddenField_Refer_Other.Value = DropDownList_Refer_By.SelectedItem.Text
                Else
                    HiddenField_Refer_Other.Value = TextBox_refer_other.Text
                End If

                LabelAmountError.Visible = False
                HiddenField_Flag.Value = 0
                HiddenFieldServiceDate.Value = WebDateChooser1.Value

                Dim Hid_Edit As Label = GridView2.Rows(index).FindControl("HiddenField_Edit_Status")
                Dim Txt_Amount As TextBox = GridView2.Rows(index).FindControl("TextBox_Amount")
                Dim txtqty As TextBox = GridView2.Rows(index).FindControl("txtQty")
                Dim Hid_Amount As Label = GridView2.Rows(index).FindControl("HiddenFieldSAmount")
                Dim hdnCompanyId As HiddenField = GridView2.Rows(index).FindControl("hdnCompanyId")

                Hid_Amount.Text = coma.Remove_Coma(Hid_Amount.Text)

                Dim Hid_SID As Label = GridView2.Rows(index).FindControl("HiddenFieldSID")

                HiddenField_Qty.Value = 1
                HiddenField_amount.Value = Convert.ToInt32(coma.Remove_Coma(Txt_Amount.Text)) '* Convert.ToDouble(txt_qty.Text)
                Dim qty As Integer
                If txtqty.Text <> "" Then
                    qty = Convert.ToInt32(txtqty.Text)
                Else
                    qty = 1
                End If

                If Session("Patient_type_Id") = 4 Then
                    HiddenField_PanelAmount.Value = HiddenField_amount.Value

                Else
                    HiddenField_PanelAmount.Value = 0
                End If

                HiddenField_SID.Value = Hid_SID.Text
                If HiddenField_Flag.Value = 0 Then
                    If HiddenField_amount.Value <> "" Then
                        If Check_Consultant() = True Then
                            For index = 1 To qty
                                SqlDataSource_For_Grid.Insert()
                            Next


                        Else
                            LabelAmountError.Text = "Add Consultant Name"
                            Exit Sub
                        End If
                    Else
                        LabelAmountError.Visible = True
                        LabelAmountError.Text = "Enter Amount Zero/Any"
                    End If
                End If
                GridView_Date_Wise.DataBind()

                HiddenField_Flag.Value = 1
                Dim Previous_Payment As Integer = 0
                For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
                    Previous_Payment = Previous_Payment + CInt(GridView_Date_Wise.Rows(i).Cells(3).Text)
                Next
                grid_r()

                dontRebind = True
                TextBox_Search_Service.Text = String.Empty
                TextBox_Search_Service.Focus()
                pnlSearchService.Update()
            End If
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim I As ImageButton = sender
        Dim Row As GridViewRow = I.NamingContainer
        Dim HF_ID As HiddenField = Row.FindControl("hf_id")
        SqlDataSource_Grid2.DeleteParameters("ID").DefaultValue = HF_ID.Value
        SqlDataSource_Grid2.Delete()

    End Sub

    Protected Sub chkDiscount_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub chkDiscount_CheckedChanged1(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chek As CheckBox = sender
        Dim gvr As GridViewRow = chek.NamingContainer
        Dim lblsid As Label = gvr.FindControl("lblS_ID")
        Dim HF_id As HiddenField = gvr.FindControl("HiddenFieldID")
        hdfS_ID.Value = lblsid.Text
        If chek.Checked Then
            Dim lblAmount As Label = gvr.FindControl("lblSAmount")
            sdsForDiscountUpdate.InsertParameters("ID").DefaultValue = HF_id.Value
            sdsForDiscountUpdate.InsertParameters("S_ID").DefaultValue = hdfS_ID.Value
            sdsForDiscountUpdate.InsertParameters("Amount").DefaultValue = lblAmount.Text
            sdsForDiscountUpdate.Insert()

        Else
            sdsForDiscountUpdate.UpdateParameters("ID").DefaultValue = HF_id.Value
            sdsForDiscountUpdate.Update()

        End If
        GridView_Date_Wise.DataBind()
    End Sub
    Protected Sub Insert_package(ByVal ASP_ID As Integer)
        Dim connection As New SqlConnection
        Dim command As New SqlCommand

        Try

            connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "Insert_Patient_services_package_wise"
            command.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo").ToString())
            command.Parameters.AddWithValue("@YearlyNo", Request.QueryString("PayID").ToString())
            command.Parameters.AddWithValue("@empid", Session("Emp_ID").ToString())
            command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID").ToString())
            command.Parameters.AddWithValue("@Dept_ID", Session("Dept_ID").ToString())
            command.Parameters.AddWithValue("@ASP_ID", DropDownList_Admin_Service_Package.SelectedValue)

            command.Parameters.Add("@msg", SqlDbType.VarChar, 100)
            command.Parameters("@msg").Direction = ParameterDirection.Output
            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()


        Catch ex As Exception
            connection.Close()

        End Try


    End Sub

    Protected Sub Label_Amount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Label_Amount.Click
        Insert_package(DropDownList_Admin_Service_Package.SelectedValue)
        GridView_Date_Wise.DataBind()
    End Sub
    Protected Sub btnUpdateServices_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpdateServices.Click

        Dim count As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        con.Open()

        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim PSId As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenFieldID")
            Dim panelAmount As TextBox = GridView_Date_Wise.Rows(i).FindControl("txtPanelAmount")

            Dim Command As SqlCommand = New SqlCommand("UpdatePatientBill", con)
            Command.CommandType = CommandType.StoredProcedure
            Command.Parameters.AddWithValue("@PsId", PSId.Value)
            Command.Parameters.AddWithValue("@PanelAmount", panelAmount.Text)
            Command.ExecuteNonQuery()

        Next
        con.Close()
        Label_msg.Text = "Updated successfully"
        Label_msg.ForeColor = System.Drawing.Color.Green
        GridView_Date_Wise.DataBind()
    End Sub

    Protected Sub GridView2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles GridView2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblstatus As Label = e.Row.FindControl("HiddenField_Edit_Status")
            Dim txtboxQty As TextBox = e.Row.FindControl("txtQty")
            Dim txtboxAmount As TextBox = e.Row.FindControl("TextBox_Amount")

            If lblstatus.Text = "False" Then
                txtboxQty.Enabled = False
                txtboxAmount.Enabled = False

            Else
                txtboxQty.Enabled = True
                txtboxAmount.Enabled = True

            End If


        End If

    End Sub
End Class