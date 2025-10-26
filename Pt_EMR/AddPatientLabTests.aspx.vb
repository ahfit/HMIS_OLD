Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_AddPatientLabTests
    Inherits System.Web.UI.Page

    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim Path_constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
    Dim ds As New Pathology
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim Obj_Menu As New JavaScriptMenu

        Obj_Menu.loginvalidate()
        Session.Add("TestStatus", Session("Teststatus"))


             If Not IsPostBack Then
                LabelSideMenu.Text = Obj_Menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

                'If GridViewTest_Assign.Rows.Count <> 0 And Session("IsPrevVisit") = "False" Then
                '    btnAdd.Visible = True
                'Else
                '    btnAdd.Visible = False
                'End If
                GetPatientAssignedTests()

            End If
    End Sub
   
    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged
        Try
            'Response.Write(DataList1.SelectedIndex)
            HiddenField_MG_ID.Value = DataList1.SelectedValue
            CheckBoxList_LabTest.DataBind()

            'GridView_Test.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub CheckBoxList_LabTest_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_LabTest.SelectedIndexChanged
        Book_Path_Test()
        HiddenField_MG_ID.Value = DataList1.SelectedValue
    End Sub
    Protected Sub GetPatientAssignedTests()

        Dim objManager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@YearlNo", Session("YearlyNo")),
        New SqlParameter("@RegNo", Session("registrationNo"))
        }

        GridView_PatientAssignedTests.DataSource = objManager.ExecuteDataTable("Pathology_GetPatientAssignedTests", "TreatmentConnectionString", sqlParams)
        GridView_PatientAssignedTests.DataBind()
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        lblMsg.Text = ""
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim command As SqlCommand = New SqlCommand("Insert_Investigation_Order_Main", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@Status", 11)

            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
            command.Parameters.AddWithValue("@Clinical_Information", TextBoxDescription.Text)

            command.Parameters.Add("@Main_Id", SqlDbType.Int)
            command.Parameters("@Main_Id").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()

            Dim main_id As Integer = command.Parameters("@Main_Id").Value
            HiddenField_Order_ID.Value = main_id

            For b As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
                Dim hdnTID As HiddenField = GridViewTest_Assign.Rows(b).FindControl("hdnTID")
                Dim TextBox_Description As TextBox = GridViewTest_Assign.Rows(b).FindControl("TextBox_Description")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(b).FindControl("Label_charges")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(b).FindControl("CheckBox_Is_Inside_Hospital")
                Dim chkUrgent As CheckBox = GridViewTest_Assign.Rows(b).FindControl("chkUrgent")

                Dim sub_command As SqlCommand = New SqlCommand("Insert_Investigation_Order_sub", con)
                Dim TestType As String = "1"
                If chkUrgent.Checked Then
                    TestType = "2"
                End If

                sub_command.CommandType = CommandType.StoredProcedure
                sub_command.Parameters.AddWithValue("@TB_ID", hdnTID.Value)
                sub_command.Parameters.AddWithValue("@Description", TextBox_Description.Text)
                sub_command.Parameters.AddWithValue("@TestType_ID", TestType)
                sub_command.Parameters.AddWithValue("@Status", "New")
                sub_command.Parameters.AddWithValue("@Investigation_Order_ID", main_id)
                sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)

                sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                sub_command.Parameters.AddWithValue("@empid", Session("emp_id"))
                sub_command.Parameters.AddWithValue("@S_ID", hdnTID.Value)
                sub_command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
                sub_command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
                sub_command.Parameters.Add("@PS_ID", Data.SqlDbType.Int, 100)
                sub_command.Parameters("@PS_ID").Direction = Data.ParameterDirection.Output

                sub_command.ExecuteNonQuery()
            Next
            con.Close()


            ds.Tables("PatientTest").Clear()
            GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
            GridViewTest_Assign.DataBind()

            btnAdd.Visible = True

            lblMsg.Text = "Saved successfully"
            lblMsg.ForeColor = Drawing.Color.Green

            Session.Remove("PatientTest")
            GetPatientAssignedTests()
            ClearSelectedTest()
            'Updatepatientstatus()
        Catch ex As Exception
            lblMsg.Text = "Some error occured"
            'lblMsg.Text = ex.Message
            lblMsg.ForeColor = Drawing.Color.Red
        End Try
    End Sub
    Protected Sub Updatepatientstatus()
        Dim con As SqlConnection = New SqlConnection(constr_reg)
        Try
            Dim check As Boolean = False
            Dim command As SqlCommand = New SqlCommand("UpdatePatientLabStatus", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))

            con.Open()
            command.ExecuteNonQuery()


        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub
    Protected Sub ClearSelectedTest()
        For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
            Try
                CheckBoxList_LabTest.Items(count).Selected = False
            Catch ex As Exception
            End Try
        Next
    End Sub


    Protected Sub Book_Path_Test()

        Dim row As DataRow
        For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
            If CheckBoxList_LabTest.Items(count).Selected = True Then
                Try
                    row = ds.Tables("PatientTest").NewRow
                    If Not Already_Exist(CheckBoxList_LabTest.Items(count).Value) Then
                        row.Item("TID") = CheckBoxList_LabTest.Items(count).Value
                        row.Item("TestName") = CheckBoxList_LabTest.Items(count).Text
                        row.Item("TestType_ID") = "1"
                        row.Item("Charges") = Get_Charges(CheckBoxList_LabTest.Items(count).Value)
                        row.Item("IS_inside_Hospital_Test") = IS_inside_Test(CheckBoxList_LabTest.Items(count).Value)
                        ds.Tables("PatientTest").Rows.Add(row)

                        Session("PatientTest") = ds.Tables("PatientTest")


                    End If

                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If
        Next

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
        GridViewTest_Assign.DataBind()


        If GridViewTest_Assign.Rows.Count <> 0 And Session("IsPrevVisit") = "False" Then
            btnAdd.Visible = True
        Else
            btnAdd.Visible = True
        End If

    End Sub
    Protected Function Get_Charges(ByVal T_ID As Integer) As String
        'Dim qry As String = "SELECT ISNULL(Admin_Services.S_Amount, 0) AS S_Amount FROM Test_Booking INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID WHERE (Test_Booking.TB_ID = @TB_ID)"
        Dim qry As String = "SELECT     ISNULL(Admin_Hospital_Services_Rates.S_Amount, 0) AS S_Amount FROM Test_Booking INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID INNER JOIN Admin_Hospital_Services_Rates ON Admin_Services.S_ID = Admin_Hospital_Services_Rates.S_Id WHERE (Test_Booking.TB_ID = @TB_ID)and Admin_Hospital_Services_Rates.Hospital_Id=@Hospital_Id and Admin_Hospital_Services_Rates.Patient_Type_Id=@Patient_Type_Id and Admin_Hospital_Services_Rates.IPD_OPD=@IPD_OPD"

        Dim result As String = "0"
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(Path_constr)
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@TB_ID", T_ID)
        command.Parameters.AddWithValue("@Hospital_Id", CInt(Session("PatientHospital_ID")))
        command.Parameters.AddWithValue("@IPD_OPD", Session("IPDOPD"))
        command.Parameters.AddWithValue("@Patient_Type_Id", CInt(Session("Patient_Type_ID")))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read
            result = reader.Item("S_Amount").ToString
        End While
        Return result
    End Function

    Private Function Already_Exist(ByVal T_ID As Integer) As Boolean
        Dim is_exist As Boolean = False
        For i As Integer = 0 To ds.Tables("PatientTest").Rows.Count - 1
            If Convert.ToInt32(ds.Tables("PatientTest").Rows(i).Item("TID")) = T_ID Then
                is_exist = True
            End If
        Next
        Return is_exist
    End Function
    Protected Function IS_inside_Test(ByVal T_ID As Integer) As Boolean
        Dim qry As String = "SELECT case when S_Id = 0 then 0 else 1 end as is_Inside_Test FROM Test_Booking where (TB_ID = @TB_ID)"
        Dim IS_inside_Hospital_Test As Boolean = 1
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(Path_constr)
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@TB_ID", T_ID)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read
            IS_inside_Hospital_Test = reader.Item("is_Inside_Test")
        End While
        Return IS_inside_Hospital_Test
    End Function
    Protected Sub GridViewTest_Assign_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.PreRender
        'Dim Total_Charges As Integer = 0
        'If GridViewTest_Assign.Rows.Count > 0 Then
        '    GridViewTest_Assign.HeaderRow.Cells(1).Visible = False
        '    GridViewTest_Assign.HeaderRow.Cells(4).Visible = False
        '    'GridViewTest_Assign.HeaderRow.Cells(3).Visible = False

        '    For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
        '        GridViewTest_Assign.Rows(i).Cells(1).Visible = False
        '        GridViewTest_Assign.Rows(i).Cells(4).Visible = False
        '        'GridViewTest_Assign.Rows(i).Cells(3).Visible = False

        '        Dim Label_charges As Label = GridViewTest_Assign.Rows(i).FindControl("Label_charges")
        '        If Not Label_charges Is Nothing Then

        '            Total_Charges = Total_Charges + Convert.ToInt32(Label_charges.Text)

        '        End If
        '    Next
        '    GridViewTest_Assign.FooterRow.Cells(3).Text = "Total Charges"
        '    Dim Label_Total_Charges As Label = GridViewTest_Assign.FooterRow.FindControl("Label_Total_Charges")

        '    'Label_Total_Charges.Text = Total_Charges.ToString
        '    'GridViewTest_Assign.FooterRow.Cells(1).Visible = False
        '    'GridViewTest_Assign.FooterRow.Cells(4).Visible = False
        '    'GridViewTest_Assign.FooterRow.Cells(3).Visible = False

        'End If
        'If GridViewTest_Assign.Rows.Count <> 0 Then
        '    btnAdd.Visible = True
        'Else
        '    btnAdd.Visible = False
        'End If

    End Sub

    Protected Sub GridViewTest_Assign_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.SelectedIndexChanged
        Dim row As DataRow
        Dim hdnTID As HiddenField = GridViewTest_Assign.Rows(GridViewTest_Assign.SelectedRow.RowIndex).FindControl("hdnTID")
        Dim TID As Integer = hdnTID.Value
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1

            Dim hdnTID1 As HiddenField = GridViewTest_Assign.Rows(x).FindControl("hdnTID")

            If TID <> hdnTID1.Value Then
                Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
                Dim Label_Description As Label = GridViewTest_Assign.Rows(x).FindControl("Label_Description")
                Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
                Dim hid_type As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField1")
                Dim HF_TestType_ID As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField3")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

                row = ds.Tables("PatientTest").NewRow
                row.Item("TID") = hdnTID1.Value
                'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
                row.Item("TestName") = Label_TestName.Text
                row.Item("Description") = Label_Description.Text
                row.Item("TestType_ID") = HF_TestType_ID.Value
                row.Item("Charges") = Label_charges.Text
                row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
                ds.Tables("PatientTest").Rows.Add(row)
            Else
                For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
                    If CheckBoxList_LabTest.Items(count).Value = hdnTID1.Value Then
                        CheckBoxList_LabTest.Items(count).Selected = False
                    End If
                Next

            End If
        Next

        Session("PatientTest") = ds.Tables("PatientTest")

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")

        GridViewTest_Assign.DataBind()
        HiddenField_MG_ID.Value = DataList1.SelectedValue
        'CheckBoxList_LabTest.DataBind()
        'HiddenField_MG_ID.Value
    End Sub


    Private Sub BindData()

        GridViewTest_Assign.DataSource = Session("PatientTest")
        GridViewTest_Assign.DataBind()
    End Sub
    Protected Sub GridViewTest_Assign_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridViewTest_Assign.RowEditing

        GridViewTest_Assign.EditIndex = e.NewEditIndex
        'Dim rbl As RadioButtonList = GridViewTest_Assign.Rows(GridViewTest_Assign.EditIndex).FindControl("RadioButtonList_TypeG")
        'rbl.DataBind()
        If GridViewTest_Assign.Rows.Count <> 0 Then

            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
                '  Response.Write(GridViewTest_Assign.Rows(i).Cells(6).Text)
                ' Response.Write(GridViewTest_Assign.Rows(i).Cells(4).Text)
                GridViewTest_Assign.Rows(i).Cells(6).Visible = False
            Next
        End If
        GridViewTest_Assign.Rows(e.NewEditIndex).Cells(6).Visible = False
        BindData()

    End Sub
    Protected Sub GridViewTest_Assign_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewTest_Assign.RowUpdating

        Dim dt = Session("PatientTest")
        Dim row = GridViewTest_Assign.Rows(e.RowIndex)
        Dim txt As TextBox = GridViewTest_Assign.Rows(e.RowIndex).FindControl("TextBox_Description")
        Dim rbl As RadioButtonList = row.FindControl("RadioButtonList_TypeG")
        Dim chkl As CheckBox = row.FindControl("CheckBox_Is_Inside_Hospital_Edit")
        dt.Rows(row.DataItemIndex)("Description") = txt.Text
        dt.Rows(row.DataItemIndex)("Test Type") = rbl.SelectedItem.Text
        dt.Rows(row.DataItemIndex)("TestType_ID") = rbl.SelectedValue
        dt.Rows(row.DataItemIndex)("IS_inside_Hospital_Test") = chkl.Checked

        'Reset the edit index.
        GridViewTest_Assign.Rows(GridViewTest_Assign.EditIndex).Cells(6).Visible = True
        GridViewTest_Assign.EditIndex = -1

        BindData()

    End Sub


    Protected Sub GridViewTest_Assign_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridViewTest_Assign.RowCancelingEdit
        'Reset the edit index.
        GridViewTest_Assign.EditIndex = -1
        'Bind data to the GridView control.
        BindData()

    End Sub
End Class
