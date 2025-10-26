Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Registration_Services_Page
    Inherits System.Web.UI.Page

    Dim b, c As String
    Dim total As Double = 0, Total_panel As Double = 0
    Dim day_total As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim coma As New Coma
    Dim dontRebind As Boolean = False
    Dim T_S_Dis As Double = 0, T_M_Dis As Double = 0

    Dim PayableTotal As Double = 0
    Dim Enc As New Encryption

    Protected Sub GridView_Date_Wise_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Date_Wise.PreRender
        'GridView_PreRender_For_DropDownList(False)

    End Sub

    Sub GridView_PreRender_For_DropDownList(ByVal Bol As Boolean)
        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim Hid_Status As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenField1")
            Dim Hid_SID As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenField_SID2")
            Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
            Dim HID_DDL As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenField_Doctor_ID")
            GridView_Date_Wise.Rows(i).Cells(3).Text = coma.place_Coma(GridView_Date_Wise.Rows(i).Cells(3).Text)
            HiddenFieldDID.Value = HID_DDL.Value
            If (HiddenField_Flag.Value.ToString = 1) Or (Page.IsPostBack = False) Then
                Drop.Visible = True
                Drop.DataBind()
                If Drop.Items.Count = 1 Then
                    If Drop.Items.Count = 0 Then
                        Drop.Visible = False
                    End If
                    ' update_patient_Service(Drop.SelectedValue)
                Else
                    Drop.Items.Insert(0, New ListItem("", ""))
                    If Drop.Items.Count = 1 Then
                        Drop.Visible = False
                    End If
                End If

                If HiddenFieldDID.Value Is DBNull.Value Then
                Else
                    Drop.SelectedValue = HiddenFieldDID.Value
                End If
            End If



            If Hid_Status.Value = 1 Then
                GridView_Date_Wise.Rows(i).BackColor = Drawing.Color.LightGreen
                GridView_Date_Wise.Rows(i).Cells(4).Text = ""
                ' GridView_Date_Wise.Rows(i).Cells(5).Text = ""
            ElseIf Hid_Status.Value = 2 Then
                GridView_Date_Wise.Rows(i).BackColor = Drawing.Color.LightPink
                GridView_Date_Wise.Rows(i).Cells(4).Text = ""
                ' GridView_Date_Wise.Rows(i).Cells(5).Text = ""
            End If
            'Drop.Items.Insert(0, New ListItem("", ""))
        Next
        HiddenField_Flag.Value = 0
    End Sub

    'Protected Sub GridView_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Services.PreRender
    '    For i As Integer = 0 To GridView_Services.Rows.Count - 1
    '        Dim Hid_Status As HiddenField = GridView_Services.Rows(i).FindControl("HiddenField2")
    '        If Hid_Status.Value = True Then
    '            GridView_Services.Rows(i).BackColor = Drawing.Color.LightGreen
    '        End If
    '    Next
    'End Sub

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
            If (b = "") Then
                b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = b
                day_total = 0

                day_total += Convert.ToInt32(DataBinder.Eval(GridView_Date_Wise.Rows(count).DataItem, "S_Amount"))



            ElseIf b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text Then

                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = ""
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = ""
                day_total += Convert.ToInt32(DataBinder.Eval(GridView_Date_Wise.Rows(count).DataItem, "S_Amount"))



            Else

                b = GridView_Date_Wise.Rows(count).Cells.Item(0).Text
                GridView_Date_Wise.Rows(count).Cells.Item(0).Text = b
                If Convert.ToInt32(count) > Convert.ToInt32(1) Then
                    Dim lb_day As Label = GridView_Date_Wise.Rows(count - 1).FindControl("Label_day")
                    lb_day.Text = day_total
                End If
                day_total = 0

                day_total += Convert.ToInt32(DataBinder.Eval(GridView_Date_Wise.Rows(count).DataItem, "S_Amount"))


            End If
            total += Convert.ToInt32(DataBinder.Eval(GridView_Date_Wise.Rows(count).DataItem, "S_Amount"))
        Next


        GridView_Date_Wise.FooterRow.Cells(2).Text = "Total :"
        GridView_Date_Wise.FooterRow.Cells(3).Text = total
        GridView_Date_Wise.FooterRow.Cells(3).Text = coma.place_Coma(GridView_Date_Wise.FooterRow.Cells(3).Text)



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

            command.CommandText = "Select * From (Select '' Name,0 EmpID,0 Service_ID union  SELECT ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Name, Employee.EmpID, Doctor_Service.Service_ID FROM Doctor_Service INNER JOIN Employee ON Doctor_Service.Doctor_ID = Employee.EmpID WHERE (Doctor_Service.Service_ID = @Service_ID)) a ORDER BY a.Name"
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
                T_S_Dis += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SystemDiscount"))
                T_M_Dis += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ManualDiscount"))


                If Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PanelAmount")) > 0 Then
                    e.Row.Cells(9).Text = coma.place_Coma((Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PanelAmount")) -
                                                          (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SystemDiscount")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ManualDiscount")))).ToString())
                Else
                    e.Row.Cells(9).Text = coma.place_Coma((Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "S_Amount")) -
                                                          (Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "SystemDiscount")) + Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "ManualDiscount")))).ToString())
                End If
                Total_panel += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PanelAmount"))
                total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "S_Amount"))


                Dim ddlDoctor As DropDownList = DirectCast(e.Row.FindControl("DropDownList_Doctor"), DropDownList)
                Dim sId As HiddenField = DirectCast(e.Row.FindControl("HiddenField_SID2"), HiddenField)
                Dim doctorID As HiddenField = DirectCast(e.Row.FindControl("HiddenField_Doctor_ID"), HiddenField)

                Dim dtDoc As DataTable = GetDoctors(sId.Value)
                ddlDoctor.DataSource = dtDoc
                ddlDoctor.DataBind()
                ddlDoctor.SelectedValue = doctorID.Value
                'ddlDoctor.Items.Insert(0, New ListItem("", "0"))
            ElseIf e.Row.RowType = DataControlRowType.Footer Then
                'If Convert.ToInt32(e.Row.RowIndex) > Convert.ToInt32(1) Then

                'End If
                e.Row.Cells(2).Text = "Total :"
                e.Row.Cells(3).Text = total.ToString()
                e.Row.Cells(3).Text = coma.place_Coma(e.Row.Cells(3).Text)
                e.Row.Cells(4).Text = coma.place_Coma(T_S_Dis.ToString())
                e.Row.Cells(5).Text = coma.place_Coma(T_M_Dis.ToString())
                If Total_panel > 0 Then
                    e.Row.Cells(9).Text = coma.place_Coma((Total_panel - (T_M_Dis + T_S_Dis)).ToString())
                Else
                    e.Row.Cells(9).Text = coma.place_Coma(((total + Total_panel) - (T_M_Dis + T_S_Dis)).ToString())
                End If
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'Protected Sub GridView_Services_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Services.RowDataBound
    '    Try
    '        If e.Row.RowType = DataControlRowType.DataRow Then

    '            If (b = "") Then
    '                b = e.Row.Cells.Item(0).Text
    '                e.Row.Cells.Item(0).Text = b
    '            ElseIf b = e.Row.Cells.Item(0).Text Then
    '                e.Row.Cells.Item(0).Text = ""
    '                e.Row.Cells.Item(0).Text = ""
    '            Else
    '                b = e.Row.Cells.Item(0).Text
    '                e.Row.Cells.Item(0).Text = b
    '            End If
    '        End If
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try

    '    Try
    '        If e.Row.RowType = DataControlRowType.DataRow Then

    '            If (c = "") Then
    '                c = e.Row.Cells.Item(1).Text
    '                e.Row.Cells.Item(1).Text = c
    '            ElseIf c = e.Row.Cells.Item(1).Text Then
    '                e.Row.Cells.Item(1).Text = ""
    '                e.Row.Cells.Item(1).Text = ""
    '            Else
    '                c = e.Row.Cells.Item(1).Text
    '                e.Row.Cells.Item(1).Text = c
    '            End If
    '        End If
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try
    'End Sub
    'Sub get_subdept_id()
    '    Try
    '        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    '        Dim con As SqlConnection = New SqlConnection(constr)
    '        con.Open()
    '        Dim command As SqlCommand = New SqlCommand("SELECT TOP (1) to_sub_Dept FROM  Forward_To_Sub_Dept WHERE (Reg_No = @reg_no) AND (yearly_no = @Yearly_no) order by forward_date desc", con)
    '        command.CommandType = CommandType.Text
    '        command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
    '        command.Parameters.AddWithValue("@Yearly_no", Session("YearlyNo"))
    '        Dim reader As SqlDataReader = command.ExecuteReader
    '        If reader.Read Then
    '            HiddenFieldSubDepartment.Value = reader.Item(0).ToString
    '        End If
    '        con.Close()
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try
    'End Sub

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
        hidRegNo.Value = Session("RegistrationNo")
        HidYearlyNo.Value = Session("YearlyNo")
        TextBox_Search_Service.Focus()
        ' GridView2.Focus()
        loginvalidate(Session("emp_id"),
                      Session("dept_id"))
        Try
            grid_r()

        Catch ex As Exception

        End Try


        
        If (Session("dept_id") = 93) Or (Session("dept_id") = 86) Or (Session("dept_id") = 73) Or (Session("dept_id") = 98) Then
            Button_Payment.Visible = False
        Else
            Button_Payment.Visible = True
        End If
           

        If Page.IsPostBack = False Then

            'For index = 0 To GridView_Date_Wise.Rows.Count - 1
            '    GridView_Date_Wise.DeleteRow(index)
            'Next

            If Not String.IsNullOrEmpty(hidRegNo.Value) Then
                lbl_Mr_No.Text = Enc.Encrypt_Main(hidRegNo.Value, False)
            End If
            'AutoComplete_Complaint.ContextKey = GetContextKey()
            DropDownList1.DataBind()
            DropDownList_Admin_Service_Package.DataBind()
            WebDateChooser1.Value = Date.Now
            GridView2.DataBind()

            'If Not IsNothing(Session("IPDOPD")) Then
            '    If Session("IPDOPD") = "OPD" Then
            '        pkg.Style.Add("display", "none")
            '    End If
            'End If
            If Not IsNothing(Session("Patient_Type_ID")) Then

                If (GridView_Date_Wise.Rows.Count > 0) And (Session("Patient_Type_ID") = 16) And (Session("emp_id") = 433) Then
                    pnlAmountDis.Visible = True
                Else
                    pnlAmountDis.Visible = False
                End If
                'DropDownList1.Items(0).Selected = True
            End If

        End If
        'GridView_Date_Wise.DataBind()
        'Response.Write(Session("Patient_type_Id"))
        If Session("Patient_type_Id") = "23" Then
            btnUpdateServices.Visible = True
        End If
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

    Protected Sub GridView_Date_Wise_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Date_Wise.SelectedIndexChanged
        Try
            'Dim Hid_ID As HiddenField = GridView_Date_Wise.Rows(GridView_Date_Wise.SelectedIndex).FindControl("HiddenField2")
            'Dim sb As StringBuilder = New StringBuilder()
            'sb.Append("<script language='javascript' type='text/javascript'>")
            'sb.Append("alert('asdsadsasasa');window.open('Mark_Test_For_Pathology.aspx?S_ID=" + Hid_ID.Value + "&RegNo=" + Session("RegistrationNo").ToString() + "&PayId=" + Session("YearlyNo").ToString() + "');</script>")
            'If Not ClientScript.IsClientScriptBlockRegistered(Me.GetType(), "PopUp") Then
            '    ClientScript.RegisterClientScriptBlock(Me.GetType(), "PopUp", sb.ToString(), False)
            'End If

            'Dim S_ID As HiddenField = GridView_Date_Wise.Rows(GridView_Date_Wise.SelectedIndex).FindControl("HiddenField_SID2")
            'HiddenField_ID.Value = Hid_ID.Value
            'HiddenFieldS_ID.Value = S_ID.Value
            'GridView_Date_Wise.DataBind()
            'SqlDataSource_Grid2.Delete()
            'GridView_Date_Wise.DataBind()
            'HiddenField_Flag.Value = 1


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

    ' ''Protected Sub CheckBoxListProcedure_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxListProcedure.PreRender
    ' ''    Select_Patient_Procedure()
    ' ''End Sub

    ' ''Sub Select_Patient_Procedure()
    ' ''    Dim con_pro As SqlConnection = New SqlConnection(constr_reg)
    ' ''    Dim command_pro As SqlCommand = New SqlCommand("SELECT Pt_Procedure FROM  Pt_Procedure WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)", con_pro)
    ' ''    command_pro.CommandType = CommandType.Text
    ' ''    command_pro.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
    ' ''    command_pro.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    ' ''    con_pro.Open()
    ' ''    Dim reader As SqlDataReader = command_pro.ExecuteReader
    ' ''    While reader.Read
    ' ''        For i As Integer = 0 To CheckBoxListProcedure.Items.Count - 1
    ' ''            If CheckBoxListProcedure.Items(i).Value = reader.Item(0) Then
    ' ''                CheckBoxListProcedure.Items(i).Selected = True
    ' ''            End If
    ' ''        Next
    ' ''    End While
    ' ''    con_pro.Close()
    ' ''    reader.Close()
    ' ''End Sub

    ' ''Sub Insert_Pat_Procedure()
    ' ''    Dim con_Ins As SqlConnection = New SqlConnection(constr_reg)
    ' ''    Dim command_ins As SqlCommand = New SqlCommand("SELECT Pt_Procedure FROM  Pt_Procedure WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo)", con_Ins)
    ' ''    command_ins.CommandType = CommandType.Text
    ' ''    command_ins.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
    ' ''    command_ins.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    ' ''    con_Ins.Open()
    ' ''    Dim reader As SqlDataReader = command_ins.ExecuteReader
    ' ''    While reader.Read
    ' ''        For i As Integer = 0 To CheckBoxListProcedure.Items.Count - 1
    ' ''            If CheckBoxListProcedure.Items(i).Value = reader.Item(0) Then
    ' ''                CheckBoxListProcedure.Items(i).Selected = True
    ' ''            End If
    ' ''        Next
    ' ''    End While
    ' ''    con_Ins.Close()
    ' ''    reader.Close()
    ' ''End Sub



    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        TextBox_Search_Service.Text = ""
        'AutoComplete_Complaint.ContextKey = GetContextKey()
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


            retVal = cat & "@" & regno & "@" & yearlyNo.ToString() & "@" & AttachHospitalID.ToString() & "@" & Patient_type_Id.ToString() & _
                "@" & IPDOPD & "@" & PatientBillingParty_Id.ToString()

        Catch ex As Exception
            retVal = String.Empty
        End Try

        Return retVal
    End Function

    Protected Sub Button_Payment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Payment.Click
        Response.Redirect("Patient_Payment.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
    End Sub




    Protected Sub SqlDataSource_For_Grid_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_For_Grid.Inserted
        Label_msg.Text = e.Command.Parameters("@msg").Value
        Label_msg.ForeColor = System.Drawing.Color.Green
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
        Session.Add("PayId", Visit_No)
        Response.Redirect("~/Patient Billing/Services_Page.aspx?regno=" + reg + "&payid=" + Visit_No)

    End Sub

    Protected Sub TXT_Load_patient_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TXT_Load_patient.TextChanged
        If Not String.IsNullOrEmpty(TXT_Load_patient.Text.Trim()) Then
            Dim reg As String = "SMC-" + Right("000000" + TXT_Load_patient.Text.Trim(), 6) + "-" + Right(Date.Now.Year, 2)

            Search(Enc.Encrypt_Main(reg, True))

        End If
    End Sub

    'Protected Sub TextBox_Amount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Dim txt As TextBox = sender
    '    Dim row As GridViewRow = txt.NamingContainer
    '    Dim index As Integer = row.RowIndex
    '    If HiddenField_Previous_index.Value <> index Then
    '        Insert_services(index)
    '    End If
    'End Sub


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
                Dim Hid_Amount As Label = GridView2.Rows(index).FindControl("HiddenFieldSAmount")
                Dim qty As TextBox = GridView2.Rows(index).FindControl("txtboxQty")
                Dim rpDate As TextBox = GridView2.Rows(index).FindControl("txtboxDate")


                Dim amount As Double = Convert.ToDouble(coma.Remove_Coma(Txt_Amount.Text)) * Convert.ToDouble(qty.Text)


                Hid_Amount.Text = amount

                Dim Hid_SID As Label = GridView2.Rows(index).FindControl("HiddenFieldSID")

                HiddenField_Qty.Value = qty.Text.Trim

                If HiddenField_Qty.Value = 0 Or String.IsNullOrEmpty(HiddenField_Qty.Value) Then
                    HiddenField_Qty.Value = 1
                End If

                HiddenField_Date.Value = rpDate.Text.Trim

                'If HiddenField_Date.Value = 0 Or String.IsNullOrEmpty(HiddenField_Date.Value) Then
                '    HiddenField_Date.Value = 1
                'End If
                HiddenField_amount.Value = amount

                HiddenField_SID.Value = Hid_SID.Text
                If HiddenField_Flag.Value = 0 Then

                    'Response.Write(HiddenFieldSubDepartment.Value)
                    If HiddenField_amount.Value <> "" Then
                        'If Check_Consultant() = True Then
                        SqlDataSource_For_Grid.Insert()
                        'Else
                        'LabelAmountError.Text = "Add Consultant Name"
                        'Exit Sub
                        'End If
                    Else
                        LabelAmountError.Visible = True
                        LabelAmountError.Text = "Enter Amount Zero/Any"
                        'Javascript("Amount Cannot be 0")
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
             Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim I As ImageButton = sender
        Dim Row As GridViewRow = I.NamingContainer
        Dim HF_ID As HiddenField = Row.FindControl("hf_id")
        SqlDataSource_Grid2.DeleteParameters("ID").DefaultValue = HF_ID.Value
        SqlDataSource_Grid2.Delete()

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

    Protected Sub btnSaveCheckedServices_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveCheckedServices.Click


        For index = 0 To GridView2.Rows.Count - 1

            Dim chkbox As CheckBox = GridView2.Rows(index).FindControl("chkbox")
            If chkbox.Checked Then
                Try
                    Dim Hid_Edit As Label = GridView2.Rows(index).FindControl("HiddenField_Edit_Status")
                    Dim Txt_Amount As TextBox = GridView2.Rows(index).FindControl("TextBox_Amount")
                    Dim Hid_Amount As Label = GridView2.Rows(index).FindControl("HiddenFieldSAmount")
                    Dim qty As TextBox = GridView2.Rows(index).FindControl("txtboxQty")
                    Dim rpDate As TextBox = GridView2.Rows(index).FindControl("txtboxDate")


                    Dim amount As Double = Convert.ToDouble(coma.Remove_Coma(Txt_Amount.Text)) * Convert.ToDouble(qty.Text)


                    Hid_Amount.Text = amount

                    Dim Hid_SID As Label = GridView2.Rows(index).FindControl("HiddenFieldSID")

                    HiddenField_Qty.Value = qty.Text.Trim()

                    If HiddenField_Qty.Value = 0 Or String.IsNullOrEmpty(HiddenField_Qty.Value) Then
                        HiddenField_Qty.Value = 1
                    End If
                    HiddenField_Date.Value = rpDate.Text.Trim()
                    HiddenField_amount.Value = amount

                    HiddenField_SID.Value = Hid_SID.Text
                    If HiddenField_Flag.Value = 0 Then

                        'Response.Write(HiddenFieldSubDepartment.Value)
                        If HiddenField_amount.Value <> "" Then

                            SqlDataSource_For_Grid.Insert()

                            LabelAmountError.Text = "Add Consultant Name"


                        Else
                            LabelAmountError.Visible = True
                            LabelAmountError.Text = "Enter Amount Zero/Any"
                            'Javascript("Amount Cannot be 0")
                        End If
                    End If



                    'HiddenField_Flag.Value = 1
                    'Dim Previous_Payment As Integer = 0
                    'For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
                    '    Previous_Payment = Previous_Payment + CInt(GridView_Date_Wise.Rows(i).Cells(3).Text)
                    'Next
                    'grid_r()

                    'dontRebind = True
                    'TextBox_Search_Service.Text = String.Empty
                    'TextBox_Search_Service.Focus()
                    pnlSearchService.Update()
                Catch ex As Exception
                    ' Response.Write(ex.Message)
                End Try


            End If
        Next
        GridView_Date_Wise.DataBind()


    End Sub
    Protected Sub lnkPackage_Click(sender As Object, e As EventArgs) Handles lnkPackage.Click
        panel_Package.Visible = True
    End Sub
    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        Dim Constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim conn As SqlConnection = New SqlConnection(Constr)
        Try

            Dim sc As SqlCommand = New SqlCommand("Insert_Patient_Package", conn)
            sc.CommandType = CommandType.StoredProcedure
            sc.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
            sc.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))
            sc.Parameters.AddWithValue("@PackageID", DDL_Package.SelectedValue)
            sc.Parameters.AddWithValue("@EmpId", Session("emp_id"))
            conn.Open()
            sc.ExecuteNonQuery()
            panel_Package.Visible = True
            DropDownList_Admin_Service_Package.DataBind()
        Catch ex As Exception
            lblMsg.ForeColor = Drawing.Color.Red
            lblMsg.Text = "Package Already Selected"
            'Response.Write(ex.Message)
        Finally
            conn.Close()
        End Try

    End Sub

    Protected Sub btnPrevious_Click(sender As Object, e As EventArgs) Handles btnPrevious.Click
        Response.Redirect("Services_Page.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
    End Sub
    Protected Sub DropDownList_Admin_Service_Package_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_Admin_Service_Package.SelectedIndexChanged
        GridView2.DataBind()
        btnSaveCheckedServices.Visible = True
    End Sub

    Protected Sub chkboxAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim chkSelectAll As CheckBox = CType(GridView2.HeaderRow.FindControl("chkboxAll"), CheckBox)
            Dim i As Integer = 0
            Do While (i <= (GridView2.Rows.Count - 1))
                Dim chkSelect As CheckBox = CType(GridView2.Rows(i).FindControl("chkbox"), CheckBox)
                chkSelect.Checked = chkSelectAll.Checked
                i = (i + 1)
            Loop

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub btnDivide_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDivide.Click
        If (txtAmountDis.Text <> "") Then
            Dim db As DbManager = New DbManager()
            Dim sp As SqlParameter() = {New SqlParameter("@regNo", Request.QueryString("regno")),
                                        New SqlParameter("@yearlyNo", Request.QueryString("payid")),
                                      New SqlParameter("@totalAmountDis", txtAmountDis.Text)}
            db.ExecuteNonQuery("uspUpdatePanelPatientServicesNew", "Basic_Data_ConnectionString", sp)
            GridView_Date_Wise.DataBind()
        End If
        
    End Sub
End Class