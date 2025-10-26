Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic

Partial Class OT_Management_OT_Services_Page
    Inherits System.Web.UI.Page
    Dim b, c As String
    Dim total As Integer = 0
    Dim day_total As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim constr_bas As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString

    Dim coma As New Coma

    Dim dontRebind As Boolean = False
    Dim Enc As New Encryption
    Protected Sub lnkPackage_Click(sender As Object, e As EventArgs) Handles lnkPackage.Click
        panel_Package.Visible = True
        btnSearch_Click(sender, e)
        txtHeadName.Attributes.Add("style", "left: 1")
    End Sub
    Protected Sub btnPrevious_Click(sender As Object, e As EventArgs) Handles btnPrevious.Click
        panel_Package.Visible = False
        'Response.Redirect("Services_Page.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
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
    Protected Sub SelectPatientPackages()
        Dim Constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim conn As SqlConnection = New SqlConnection(Constr)

        Try
            Dim sc As SqlCommand = New SqlCommand("Select_Patient_Package", conn)
            sc.CommandType = CommandType.StoredProcedure
            sc.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
            sc.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))
            Dim sda As SqlDataAdapter = New SqlDataAdapter(sc)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            If (dt.Rows.Count > 0) Then
                ddlLevels.SelectedValue = dt.Rows(0)(0)
            Else
                ddlLevels.SelectedValue = "1"
            End If
        Catch ex As Exception
        End Try
    End Sub
    Protected Sub GridView_Date_Wise_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Date_Wise.PreRender
        'GridView_PreRender_For_DropDownList(False)
        Dim com As Coma = New Coma()
        Dim Grid As GridView = DirectCast(sender, GridView)
        Dim lblPackageName As Label = Nothing
        Dim prev As String = Nothing
        Dim PkgName As String = Nothing
        If Grid.Rows.Count > 0 Then
            Dim Disc_Label As Label = Nothing
            Dim Amt_Label As Label = Nothing
            Dim totalcharges_Label As Label = Nothing
             
            Dim Total_Discount As Integer = 0
            Dim Total_Amount As Integer = 0
            Dim Total_charges As Integer = 0


            For Each row As GridViewRow In Grid.Rows


                Disc_Label = DirectCast(row.FindControl("lblDiscount"), Label)
                Amt_Label = DirectCast(row.FindControl("lblAmount"), Label)
                totalcharges_Label = DirectCast(row.FindControl("lbltotalcharges"), Label)


                lblPackageName = DirectCast(row.FindControl("lblPackageName"), Label)
                PkgName = lblPackageName.Text
                If Not String.IsNullOrEmpty(prev) Then
                    If prev = lblPackageName.Text Then
                        lblPackageName.Text = ""
                    End If
                End If
                prev = PkgName
                Try

                    Total_Discount += Convert.ToInt32(Disc_Label.Text)
                    Total_Amount += Convert.ToInt32(Amt_Label.Text)
                    Total_charges += Convert.ToInt32(totalcharges_Label.Text)

                Catch ex As Exception

                End Try

            Next

            Dim Discount_Label As Label = DirectCast(Grid.FooterRow.FindControl("Discount_Label"), Label)
            Dim Amount_Label As Label = DirectCast(Grid.FooterRow.FindControl("Amount_Label"), Label)
            Dim lblsumtotalcharges As Label = DirectCast(Grid.FooterRow.FindControl("lblsumtotalcharges"), Label)


            Discount_Label.Text = com.place_Coma(Total_Discount.ToString())
            lblsumtotalcharges.Text = com.place_Coma(Total_charges.ToString())

            GridView_Date_Wise.FooterRow.Cells(5).Font.Bold = True

            GridView_Date_Wise.FooterRow.Cells(5).ForeColor = Drawing.Color.Red


            ' Amount_Label.Text = com.place_Coma(Total_Amount.ToString())

        End If
    End Sub

    Private Sub loadCostCenter()
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim cmd As SqlCommand
        Try
            con.Open()
            cmd = New SqlCommand(" SELECT     CostCenter.CostCenterID, CostCenter.CostCenterName FROM  CostCenter LEFT OUTER JOIN SubDepartment ON CostCenter.CostCenterID = SubDepartment.CostCentre_Id --where SubDepartment.SubDept_Id=@SubDeptId ORDER BY CostCenter.CostCenterName ", con)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable
            cmd.Parameters.AddWithValue("@SubDeptId", Session("SubDeptID"))
            da.Fill(dt)
            DDLCostCenter.DataSource = dt
            DDLCostCenter.DataValueField = "CostCenterID"
            DDLCostCenter.DataTextField = "CostCenterName"
            DDLCostCenter.DataBind()
        Catch ex As Exception

        Finally
            con.Close()
        End Try

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
        
        GridView_Date_Wise.FooterRow.Cells(2).Text = " Total :"
        GridView_Date_Wise.FooterRow.Cells(5).Text = coma.place_Coma(total)
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
    Private Sub loadOTConsultant()
        Dim con As SqlConnection = New SqlConnection(constr_bas)
        Dim cmd As SqlCommand
        Try
            con.Open()
            cmd = New SqlCommand("select EmpID, isnull(efname,'') +' '+ isnull(EMName,'') +' '+ isnull(ELName,'') as EmpName from Employee where activestatus=1 order by EmpName  ", con)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable
            da.Fill(dt)
            DDLConsultant.DataSource = dt
            DDLConsultant.DataValueField = "EmpID"
            DDLConsultant.DataTextField = "EmpName"
            DDLConsultant.DataBind()
        Catch ex As Exception

        Finally
            con.Close()
        End Try

    End Sub
    Protected Sub GridView_Date_Wise_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_Date_Wise.RowDataBound
        Try

            If e.Row.RowType = DataControlRowType.DataRow Then

                Dim hfServiceCategory As HiddenField = e.Row.FindControl("Hf_ServiceCategory")
                Dim HfIsForwarded As HiddenField = e.Row.FindControl("Hf_IsForwarded")
                Dim HfOrderId As HiddenField = e.Row.FindControl("Hf_OrderId")

                If (HfOrderId.Value <> "0") Then
                    e.Row.BackColor = Drawing.Color.Orange
                End If

                ' Dim lblAmount As Label = DirectCast(e.Row.FindControl("lblAmount"), Label)
                Dim lblSAmount As Label = DirectCast(e.Row.FindControl("lblSAmount"), Label)
                Dim lblAmount As Label = DirectCast(e.Row.FindControl("lblSAmount"), Label)

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
                e.Row.Cells(3).Text = " Total :"

                e.Row.Cells(5).Text = coma.place_Coma(total.ToString)
                e.Row.Cells(5).BackColor = Drawing.Color.Azure
            End If
        Catch ex As Exception
            ' Response.Write(ex.Message)
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
            Hid_Amount.Enabled = c.Text
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
        If (hfdBindStatus.Value = "1") Then
            'Response.Write("<script>alert('Patient has been Discharged');</script>")
            errorlbl.Text = "Patient has been Discharged"
        Else
            errorlbl.Text = ""
            If HiddenField_Previous_index.Value <> index Then
                Insert_services(index)

            End If
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
    Protected Sub BindCostCenter()

        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (S_ID = @S_ID)", con)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select isnull(CostCentre_Id,0) as CostCenterID from SubDepartment where SubDept_Id=@subdeptid", con)

        mycommand.CommandType = Data.CommandType.Text
        'mycommand.Parameters.AddWithValue("RegNo", Request.QueryString("regno"))
        'mycommand.Parameters.AddWithValue("yearlyno", Request.QueryString("payid"))
        mycommand.Parameters.AddWithValue("subdeptid", Session("Subdeptid"))
        Dim sda As SqlDataAdapter = New SqlDataAdapter(mycommand)
        Dim dt As DataTable = New DataTable()
        sda.Fill(dt)
        If (Convert.ToInt32(dt.Rows.Count > 0)) Then
            DDLCostCenter.SelectedValue = Convert.ToString(dt.Rows(0)(0))

            DropDownList1.DataBind()

        End If
    End Sub

    Protected Sub BindGridRestrictions()

        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand("UPDATE Patient_Services SET Doctor_ID =@Doctor_ID WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (S_ID = @S_ID)", con)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT  [Status] FROM [Registration].[dbo].[Forward_To_Sub_Dept] where Reg_No=@RegNo and yearly_no=@yearlyno and to_sub_Dept=@subdeptid ", con)

        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("RegNo", Request.QueryString("regno"))
        mycommand.Parameters.AddWithValue("yearlyno", Request.QueryString("payid"))
        mycommand.Parameters.AddWithValue("@subdeptid", Session("Subdeptid"))
        Dim sda As SqlDataAdapter = New SqlDataAdapter(mycommand)
        Dim dt As DataTable = New DataTable()
        sda.Fill(dt)
        If (dt.Rows.Count > 0) Then
            If dt.Rows(0)(0) = "1" Then
                hfdBindStatus.Value = 1
            End If
        End If

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Session("PatientBillingParty_Id"))
        'Response.End()

        hidRegNo.Value = Session("RegistrationNo")
        HidYearlyNo.Value = Session("YearlyNo")
        TextBox_Search_Service.Focus()
        'GridView2.Focus()
        loginvalidate(Session("emp_id"), Session("dept_id"))
        Try
            grid_r()

        Catch ex As Exception

        End Try

        If Page.IsPostBack = False Then
            loadCostCenter()
            DropDownList1.DataBind()


            loadOTConsultant()
            ' TextBox_Timein.Text = Convert.ToString(Convert.ToString(Convert.ToInt32(DateTime.Now.Hour) - 1).ToString().PadLeft(2, "0") + ":" + DateTime.Now.Minute.ToString())
            'Dim Search As String= "1".PadLeft(2, '0')
            'Dim Search As String = "".PadLeft(5, "0"c)

            'Dim d As DateTime = DateTime.Parse("05:00 PM")
            'Dim s As String = d.ToString("HH:mm")
            TextBox_Timein.Text = DateTime.Now.AddHours(-1).ToString("HH:mm")

            TextBox_Timeout.Text = DateTime.Now.ToString("HH:mm")

            If Not String.IsNullOrEmpty(hidRegNo.Value) Then
                lbl_Mr_No.Text = Enc.Encrypt_Main(hidRegNo.Value, False)
            End If
            GridView2.Visible = False
            AutoComplete_Complaint.ContextKey = GetContextKey()
            DropDownList1.DataBind()
            DropDownList_Admin_Service_Package.DataBind()
            WebDateChooser1.Value = Date.Now
            Try
                GridView2.DataBind()
            Catch ex As Exception

            End Try

            DropDownList_Refer_By.DataBind()
            getDoctorFromPayment()

            ddlCategory.DataBind()
            GridView_Date_Wise.DataBind()
            ddlLevels.DataBind()
        End If
        If (Not Page.IsPostBack) Then
            BindGridRestrictions()
            btnSearch_Click(sender, e)
            BindCostCenter()
            SelectPatientPackages()
            DDLCostCenter.SelectedValue = "1021"
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
            'Response.Write(ex.Message)
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
            ' Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Write("<script language ='javascript' type ='text/javascript'>window.open('../MainPage.aspx','_top');</script>")
    End Sub

    Function Check_Consultant() As Boolean
        Dim check As Boolean = True
        'If GridView_Date_Wise.Rows.Count <> 0 Then
        '    For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
        '        Dim Drop As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")
        '        If Drop.Visible = True Then
        '            If Drop.SelectedValue = "" Then
        '                GridView_Date_Wise.DataBind()
        '                LabelAmountError.Visible = True
        '                LabelAmountError.Text = "Add Consultant Name"
        '                Drop.DataBind()
        '                HiddenField_Flag.Value = 1
        '                check = False
        '                errorlbl.Text = "Please Select Doctor First"
        '            Else
        '                check = True
        '                errorlbl.Text = ""
        '                LabelAmountError.Visible = False
        '            End If
        '        Else
        '            check = True
        '        End If
        '    Next
        'Else
        '    check = True
        'End If
        Return check
    End Function

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged
        TextBox_Search_Service.Text = ""
        DropDownList_Admin_Service_Package_SelectedIndexChanged(sender, e)
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
        'Response.Redirect("Patient_Payment.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))


        Response.Redirect("Patient_Payment.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
    End Sub


    Protected Sub SqlDataSource_For_Grid_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_For_Grid.Inserted
        Label_msg.Text = e.Command.Parameters("@msg").Value
        Label_msg.ForeColor = System.Drawing.Color.Green
    End Sub



    Protected Sub DropDownList_Admin_Service_Package_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Admin_Service_Package.SelectedIndexChanged
        If Convert.ToInt32(DropDownList_Admin_Service_Package.SelectedValue) > 0 Then

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
            searchbtn_Click(sender, e)
            GridView2.DataBind()
            btnSaveCheckedServices.Visible = True


        Else
            Label_Amount.Text = ""
        End If
        

        If Convert.ToInt32(DropDownList_Admin_Service_Package.SelectedValue) > 0 Then
            If GridView2.Rows.Count > 0 Then

                chckallgridbx(sender, e)

            End If
        End If
    End Sub
    Protected Sub chckallgridbx(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim chkSelectAll As CheckBox = CType(GridView2.HeaderRow.FindControl("chkboxAll"), CheckBox)
            chkSelectAll.Checked = True
            chkboxAll_CheckedChanged(sender, e)
        Catch ex As Exception

        End Try

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
    <System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()>
    Public Shared Function SearchPackages(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim customers As List(Of String) = New List(Of String)()
        Dim conn As SqlConnection = New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "SELECT     Admin_Service_Package.ASP_ID, Admin_Service_Package.AP_Name AS AP_Name  FROM         Admin_Service_Package  where   (Admin_Service_Package.AP_Name like '%'+@pretext+'%' )"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@pretext", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()

        While sdr.Read()
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("AP_Name").ToString(), (sdr("ASP_ID").ToString())))
        End While

        Return customers

    End Function
    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As EventArgs)

        Dim ConnectionString As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim conn As SqlConnection = New SqlConnection(ConnectionString)
        Dim cmd As SqlCommand = New SqlCommand("uspSelectProcedure", conn)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@pretext", txtHeadName.Text)
        cmd.Parameters.AddWithValue("@regno", Request.QueryString("regno"))
        cmd.Parameters.AddWithValue("@yearlyno", Request.QueryString("payid"))
        Dim dt As DataTable = New DataTable()
        Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
        sda.Fill(dt)
        DropDownList_Admin_Service_Package.DataSource = dt
        DropDownList_Admin_Service_Package.DataBind()

        'DDL_Package.DataSource = dt
        'DDL_Package.DataBind()

    End Sub


    'Protected Sub TextBox_Search_Service_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Search_Service.TextChanged
    '    If dontRebind Then Return
    '    GridView2.DataBind()
    'End Sub

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
                Dim ddlPrePost As DropDownList = GridView2.Rows(index).FindControl("ddlPrePost")
                Hid_Amount.Text = coma.Remove_Coma(Hid_Amount.Text)

                Dim Hid_SID As Label = GridView2.Rows(index).FindControl("HiddenFieldSID")

                HiddenField_Qty.Value = txtqty.Text
                HiddenField_amount.Value = Convert.ToInt32(coma.Remove_Coma(Txt_Amount.Text)) * Convert.ToDouble(txtqty.Text)
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
                            ' For index = 1 To qty
                            SqlDataSource_For_Grid.InsertParameters("PrePost").DefaultValue = ddlPrePost.SelectedValue
                            SqlDataSource_For_Grid.Insert()
                            ' Next


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
                'Dim Previous_Payment As Integer = 0
                'For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
                '    Previous_Payment = Previous_Payment + CInt(GridView_Date_Wise.Rows(i).Cells(3).Text)
                'Next
                grid_r()

                dontRebind = True
                TextBox_Search_Service.Text = String.Empty
                TextBox_Search_Service.Focus()
                pnlSearchService.Update()
                Button_lab_Test.Visible = False
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
        SelectPatientPackages()

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
    Protected Sub Insert_PatientServices()
        Dim connection As New SqlConnection
        Dim command As New SqlCommand

        Try

            connection.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "Insert_Patient_Adminservices"
            command.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo").ToString())
            command.Parameters.AddWithValue("@YearlyNo", Request.QueryString("PayID").ToString())
            command.Parameters.AddWithValue("@empid", Session("Emp_ID").ToString())
            command.Parameters.AddWithValue("@SubdeptID", Session("Subdeptid").ToString())

            command.Parameters.AddWithValue("@TimeIn", TextBox_Timein.Text.ToString())
            command.Parameters.AddWithValue("@TimeOut", TextBox_Timeout.Text.ToString())
            command.Parameters.AddWithValue("@BedNo", TextBox_BedNo.Text.Trim())
            command.Parameters.AddWithValue("@Consultant", DDLConsultant.SelectedItem.Text)
            command.Parameters.AddWithValue("@SerubPerson", TextBox_SerubPerson.Text)
            command.Parameters.AddWithValue("@Circulator", TextBox_Circulator.Text)
            command.Parameters.AddWithValue("@OTNumber", txtOTNumber.Text)




            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()


        Catch ex As Exception
            connection.Close()

        End Try


    End Sub

    Protected Sub Label_Amount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Label_Amount.Click
        If (GridView2.Rows.Count > 0) Then
            Insert_package(DropDownList_Admin_Service_Package.SelectedValue)
            GridView_Date_Wise.DataBind()
        End If
    End Sub
    Protected Sub btnUpdateServices_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnUpdateServices.Click

        Dim count As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        con.Open()

        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim PSId As HiddenField = GridView_Date_Wise.Rows(i).FindControl("HiddenFieldID")
            Dim panelAmount As Label = GridView_Date_Wise.Rows(i).FindControl("lbltotalcharges")
            Dim consultant As DropDownList = GridView_Date_Wise.Rows(i).FindControl("DropDownList_Doctor")



            Dim Command As SqlCommand = New SqlCommand("UpdatePatientBill", con)
            Command.CommandType = CommandType.StoredProcedure
            Command.Parameters.AddWithValue("@PsId", PSId.Value)
            Command.Parameters.AddWithValue("@PanelAmount", panelAmount.Text)
            Command.Parameters.AddWithValue("@consultant", consultant.SelectedValue)

            Command.ExecuteNonQuery()

        Next
        con.Close()
        Insert_PatientServices()
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
                txtboxQty.Enabled = True
                txtboxAmount.Enabled = True

            Else
                txtboxQty.Enabled = True
                txtboxAmount.Enabled = True

            End If


        End If

    End Sub
    <System.Web.Script.Services.ScriptMethod, System.Web.Services.WebMethod>
    Public Shared Function SearchItems(prefixText As String, count As Integer) As List(Of String)
        Dim items As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select S_Name from Admin_Services where S_Name like '%'+@Search+'%'"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("S_Name").ToString(), sdr("S_Name").ToString()))
        End While
        Return items
    End Function





    Protected Sub searchbtn_Click(sender As Object, e As EventArgs)
        Try

            GridView2.DataBind()
            GridView2.Visible = True

        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Button3_Click(sender As Object, e As EventArgs)

        Dim url As String
        url = "../pharmacy/PatientServicesReport.aspx?Registration=" + Request.QueryString("regno") + "&PayId=" + Request.QueryString("payid") + ""

        Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)

        'Response.Redirect("~/pharmacy/PatientServicesReport.aspx?Registration=" + Request.QueryString("regno") + "&PayId=" + Request.QueryString("payid") + "")
    End Sub

    Protected Sub TextBox_Search_Service_TextChanged(sender As Object, e As EventArgs) Handles TextBox_Search_Service.TextChanged
        'GridView2.DataBind()
        'GridView2.Visible = True
    End Sub

    Protected Sub ddlCategory_SelectedIndexChanged(sender As Object, e As EventArgs)
        GridView_Date_Wise.DataBind()
    End Sub

    Protected Sub Button_lab_Test_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_lab_Test.Click
        'for_OT()
        Dim services As String = String.Empty
        Dim check As New CheckBox
        Dim hf_ID As New HiddenField
        Dim hf_SID As New HiddenField
        Dim txt_company As New TextBox
        Dim txt_patient As New Label

        For Each gv As GridViewRow In GridView_Date_Wise.Rows
            check = gv.FindControl("CheckBox1")
            If check.Checked Then
                hf_ID = gv.FindControl("hf_id")
                hf_SID = gv.FindControl("hf_SID")
                txt_company = gv.FindControl("txtPanelAmount")
                txt_patient = gv.FindControl("lblAmount")
                If String.IsNullOrEmpty(txt_company.Text.Trim()) Then
                    txt_company.Text = "0"
                End If
                If String.IsNullOrEmpty(txt_patient.Text.Trim()) Then
                    txt_patient.Text = "0"
                End If
                services = services + "<services><ps_id>" + hf_ID.Value + "</ps_id><s_id>" + hf_SID.Value + "</s_id><company>" + coma.Remove_Coma(txt_company.Text.Trim()) + "</company><Patient>" + coma.Remove_Coma(txt_patient.Text.Trim()) + "</Patient></services>"
            End If
        Next

        Forward_Services(services)


        GridView_Date_Wise.DataBind()
    End Sub
    Private Sub Forward_Services(ByVal services As String)
        Dim con As New SqlConnection(constr_bas)
        Try

            Dim sp As String = "usp_Forward_Services1"
            Dim cmd As New SqlCommand(sp, con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@services", services)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()


        Catch ex As Exception
            con.Close()
            con.Dispose()

        End Try

    End Sub


    Protected Sub CheckBox_Header_CheckedChanged(sender As Object, e As EventArgs)
        Dim chkStatus As Boolean = False
        Dim chekHeader As CheckBox = GridView_Date_Wise.HeaderRow.FindControl("CheckBox_Header")

        If chekHeader.Checked Then
            chkStatus = True
        End If

        For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
            Dim chek As CheckBox = GridView_Date_Wise.Rows(i).FindControl("CheckBox1")
            chek.Checked = chkStatus
        Next
    End Sub

    Protected Sub CheckBox1_CheckedChanged(sender As Object, e As EventArgs)
        'Label_Amount.Text = ""
        'Dim amount As Integer = 0
        'For i As Integer = 0 To GridView_Date_Wise.Rows.Count - 1
        '    Dim chek As CheckBox = GridView_Date_Wise.Rows(i).FindControl("CheckBox1")
        '    If chek.Checked = True Then
        '        amount = amount + GridView_Date_Wise.Rows(i).Cells(4).Text
        '    End If
        'Next
        'TextBox2.Text = co.place_Coma(amount)

        'Label_Amount.Text = amount
    End Sub
    Protected Sub btnSaveCheckedServices_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveCheckedServices.Click


        For index = 0 To GridView2.Rows.Count - 1

            Dim chkbox As CheckBox = GridView2.Rows(index).FindControl("chkbox")
            If chkbox.Checked Then
                Try
                    Dim Hid_Edit As Label = GridView2.Rows(index).FindControl("HiddenField_Edit_Status")
                    Dim Txt_Amount As TextBox = GridView2.Rows(index).FindControl("TextBox_Amount")
                    Dim Hid_Amount As Label = GridView2.Rows(index).FindControl("HiddenFieldSAmount")
                    Dim qty As TextBox = GridView2.Rows(index).FindControl("txtQty")


                    Dim amount As Double = Convert.ToDouble(coma.Remove_Coma(Txt_Amount.Text)) * Convert.ToDouble(qty.Text)


                    Hid_Amount.Text = amount

                    Dim Hid_SID As Label = GridView2.Rows(index).FindControl("HiddenFieldSID")

                    HiddenField_Qty.Value = qty.Text.Trim()

                    If HiddenField_Qty.Value = 0 Or String.IsNullOrEmpty(HiddenField_Qty.Value) Then
                        HiddenField_Qty.Value = 1
                    End If
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

                    'pnlSearchService.Update()
                Catch ex As Exception
                    ' Response.Write(ex.Message)
                End Try


            End If
        Next
        ' SelectPatientPackages()
        SelectPatientPackages()
        GridView_Date_Wise.DataBind()
        txtHeadName.Text = ""
        'DropDownList_Admin_Service_Package.SelectedValue = 0
        ' btnSearch_Click(sender, e)

    End Sub

    Protected Sub lnkrpt_Click(sender As Object, e As EventArgs)
        Dim url As String = "ConsultantCommendedAdmissionReport.aspx?regno=" + Request.QueryString("regno") + "&yearlyno=" + Request.QueryString("payid")
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)

    End Sub
End Class