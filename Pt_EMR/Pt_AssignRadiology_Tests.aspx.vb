Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_AssignRadiology_Tests_1
    Inherits System.Web.UI.Page

    Dim count As Integer = 0
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = "LGH/251120060019"
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim connew As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString
    Dim conRad As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString

    Dim statuscmo As String
    Dim user_authen As New User_page_Authentication
    Dim ds As New Pathology
    Dim ENC As New Encryption
    'Protected Sub GVTSGName_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GVTSGName.RowCommand
    ' If e.CommandName.ToString = "ABC" Then
    '    Label3.Text = "HI AJAAX IS IN WORKING "
    ' End If
    ' End Sub


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

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        lblMsg.Text = ""

        Try
            Dim enc As New Encryption
            Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim command As SqlCommand = New SqlCommand("Insert_Radiology_Order_Main", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@Status", 11)
            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
            command.Parameters.AddWithValue("@Clinical_Information", TextBox_Instructions.Text)

            If (Convert.ToString(DataList1.SelectedValue) = "") Then
                command.Parameters.AddWithValue("@R_ID", 0)
            Else
                command.Parameters.AddWithValue("@R_ID", DataList1.SelectedValue)
            End If

            command.Parameters.Add("@Main_Id", SqlDbType.Int)
            command.Parameters("@Main_Id").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()
            Dim main_id As Integer = command.Parameters("@Main_Id").Value

            For b As Integer = 0 To GridViewTest_Assign.Rows.Count - 1

                Dim hdnTID As HiddenField = GridViewTest_Assign.Rows(b).FindControl("hdnTID")
                Dim TextBox_Description As TextBox = GridViewTest_Assign.Rows(b).FindControl("TextBox_Description")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(b).FindControl("Label_charges")

                Dim Label_TestName As Label = GridViewTest_Assign.Rows(b).FindControl("Label_TestName")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(b).FindControl("CheckBox_Is_Inside_Hospital")
                Dim chkUrgent As CheckBox = GridViewTest_Assign.Rows(b).FindControl("chkUrgent")


                Dim TestType As String = "1"
                If chkUrgent.Checked Then
                    TestType = "2"
                End If


                Dim sub_command As SqlCommand = New SqlCommand("Insert_Radiology_Order_sub", con)

                sub_command.CommandType = CommandType.StoredProcedure
                sub_command.Parameters.AddWithValue("@TB_ID", hdnTID.Value)
                sub_command.Parameters.AddWithValue("@Order_ID", main_id)
                sub_command.Parameters.AddWithValue("@RadiologyTestName", Label_TestName.Text)
                sub_command.Parameters.AddWithValue("@Status", "New")
                sub_command.Parameters.AddWithValue("@Instructions", TextBox_Description.Text)
                sub_command.Parameters.AddWithValue("@Test_Type", TestType)
                sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)

                sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                sub_command.Parameters.AddWithValue("@empid", Session("emp_id"))
                'sub_command.Parameters.AddWithValue("@S_ID", hdnTID.Value)
                sub_command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
                sub_command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
                sub_command.Parameters.Add("@PS_ID", Data.SqlDbType.Int, 100)
                sub_command.Parameters("@PS_ID").Direction = Data.ParameterDirection.Output
                sub_command.ExecuteNonQuery()

            Next
            con.Close()
            'Main_Group()

            ds.Tables("PatientTest").Clear()
            GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
            GridViewTest_Assign.DataBind()

            GetPatientAssignedTests()

            ClearSelectedTest()
            btnAdd.Visible = False

            lblMsg.Text = "Saved successfully"
            lblMsg.ForeColor = Drawing.Color.Green

            Session.Remove("PatientTest")

        Catch ex As Exception
            lblMsg.Text = "Some error occured"
            lblMsg.ForeColor = Drawing.Color.Red
        End Try


    End Sub

    Protected Sub ClearSelectedTest()
        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
            Try
                CheckBoxList_Rad_Test.Items(count).Selected = False
            Catch ex As Exception
            End Try
        Next
    End Sub
    Protected Sub GetPatientAssignedTests()

        Dim objManager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@YearlNo", Session("YearlyNo")),
        New SqlParameter("@RegNo", Session("registrationNo"))
        }

        GridView_PatientAssignedTests.DataSource = objManager.ExecuteDataTable("Investigation_GetPatientAssignedTests", "TreatmentConnectionString", sqlParams)
        GridView_PatientAssignedTests.DataBind()
    End Sub


    'Protected Sub Button_OK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_OK.Click
    '    If IS_Code_Matched(Session("emp_id"), TextBox_Prescription_Code.Text.Trim) Then
    '        Try
    '            Dim enc As New Encryption
    '            Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    '            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '            Dim command As SqlCommand = New SqlCommand("Insert_Radiology_Order_Main", con)
    '            command.CommandType = CommandType.StoredProcedure
    '            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    '            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
    '            command.Parameters.AddWithValue("@Status", 11)
    '            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
    '            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
    '            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
    '            command.Parameters.AddWithValue("@Clinical_Information", TextBox_Instructions.Text)

    '            If (Convert.ToString(DataList1.SelectedValue) = "") Then
    '                command.Parameters.AddWithValue("@R_ID", 0)
    '            Else
    '                command.Parameters.AddWithValue("@R_ID", DataList1.SelectedValue)
    '            End If

    '            command.Parameters.Add("@Main_Id", SqlDbType.Int)
    '            command.Parameters("@Main_Id").Direction = ParameterDirection.Output
    '            con.Open()
    '            command.ExecuteNonQuery()
    '            Dim main_id As Integer = command.Parameters("@Main_Id").Value

    '            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
    '                'If CheckBoxList_Projection.Items(i).Selected = True Then
    '                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(i).FindControl("CheckBox_Is_Inside_Hospital")
    '                Dim description As TextBox = GridViewTest_Assign.Rows(i).FindControl("TextBox_Description")
    '                Dim sub_command As SqlCommand = New SqlCommand("Insert_Radiology_Order_sub", con)
    '                sub_command.CommandType = CommandType.StoredProcedure
    '                sub_command.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
    '                sub_command.Parameters.AddWithValue("@Order_ID", main_id)
    '                Dim testname As Label = GridViewTest_Assign.Rows(i).FindControl("Label_TestName")
    '                sub_command.Parameters.AddWithValue("@RadiologyTestName", testname.Text)
    '                sub_command.Parameters.AddWithValue("@Status", "New")
    '                sub_command.Parameters.AddWithValue("@Instructions", description.Text)
    '                sub_command.Parameters.AddWithValue("@Test_Type", GridViewTest_Assign.Rows(i).Cells(4).Text)
    '                sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)
    '                sub_command.ExecuteNonQuery()

    '            Next
    '            con.Close()
    '            Main_Group()
    '            'ds.Tables("PatientTest").Clear()
    '            'GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
    '            'GridViewTest_Assign.DataBind()

    '            Label_MSG.Text = ""
    '            Button_OK.Visible = False
    '            TextBox_Prescription_Code.Visible = False
    '            Label_Lbl.Visible = False
    '            GridView_Tests_For_Confirmation.DataSource = Session("PatientTest")
    '            GridView_Tests_For_Confirmation.DataBind()
    '            GridView_Tests_For_Confirmation.Visible = True
    '            ds.Tables("PatientTest").Clear()
    '            GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
    '            GridViewTest_Assign.DataBind()
    '            'GridView_Radiology.DataBind()
    '            CheckBoxList_Rad_Test.DataBind()





    '        Catch ex As Exception
    '            Response.Write(ex.Message)
    '        End Try

    '        GridView_Radiology.DataBind()

    '    Else
    '        Label_MSG.Text = "Pass Code Not Matched Try Again"
    '    End If
    'End Sub
    Protected Function IS_Code_Matched(ByVal emp_ID As Integer, ByVal p_code As String) As Boolean

        Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim is_Matched As Boolean = False
        Dim qry As String = "SELECT Password FROM Login WHERE (EmpID = @EmpID)"
        con.Open()
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@EmpID", emp_ID)
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            If ENC.Encrypt_Main(reader.Item("Password").ToString(), False) = p_code Then
                is_Matched = True
            End If
        End While
        Return is_Matched
    End Function


    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("~/login.aspx")
        End If
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        Dim obj As New JavaScriptMenu()
        obj.loginvalidate()
        LabelSideMenu.Text = obj.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj.Footer_String()



        If Not IsPostBack Then

            'Dim objCommn As CommonDBFunctions = New CommonDBFunctions()

            'If objCommn.IsPreviousVisit(Session("YearlyNo")) Then
            '    Session.Add("IsPrevVisit", "True")
            'Else
            '    Session.Add("IsPrevVisit", "False")
            'End If

            DataList1.DataBind()
            CheckBoxList_Rad_Test.DataBind()
            GetPatientAssignedTests()
        End If


        'datafields()
        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
        Main_Group()

        If Not IsPostBack Then
            DataList1.DataBind()
            CheckBoxList_Rad_Test.DataBind()
            'gvdData.DataBind()
            If GridViewTest_Assign.Rows.Count <> 0 Then
                btnAdd.Visible = True
            Else
                btnAdd.Visible = False
            End If
        End If

    End Sub


    Sub Main_Group()
        Try
            'Response.Write(Session("RegistrationNo"))
            'Response.Write("sdfsdfd" + Session("YearlyNo"))
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command1 As SqlCommand = New SqlCommand("Select_Main_Group_For_Assign_Test", con)
            command1.CommandType = CommandType.StoredProcedure
            command1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            command1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            'HttpContext.Current.Response.Write(Session("YearlyNo"))
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
                'Response.Write(ds.Tables(0).Rows(i).Item(2) + "asdasddas")
                Tests(CInt(ds.Tables(0).Rows(i).Item(2)), obj)
            Next
            'TreeView1.ExpandAll()
            TreeView1.CollapseAll()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub Tests(ByVal cat_ID As Integer, ByVal obj As TreeNode)
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command1 As SqlCommand = New SqlCommand("Select_Sub_Group_For_Assign_Test", con)
            command1.CommandType = CommandType.StoredProcedure
            command1.Parameters.AddWithValue("@Order_id", cat_ID)
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


    Protected Sub GridViewTest_Assign_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles GridViewTest_Assign.RowEditing

        GridViewTest_Assign.EditIndex = e.NewEditIndex
        'Dim rbl As RadioButtonList = GridViewTest_Assign.Rows(GridViewTest_Assign.EditIndex).FindControl("RadioButtonList_TypeG")
        'rbl.DataBind()
        If GridViewTest_Assign.Rows.Count <> 0 Then

            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
                'Response.Write(GridViewTest_Assign.Rows(i).Cells(6).Text)
                'Response.Write(GridViewTest_Assign.Rows(i).Cells(4).Text)
                GridViewTest_Assign.Rows(i).Cells(6).Visible = False
            Next
        End If
        GridViewTest_Assign.Rows(e.NewEditIndex).Cells(6).Visible = False
        BindData()

    End Sub
    Private Sub BindData()

        GridViewTest_Assign.DataSource = Session("PatientTest")
        GridViewTest_Assign.DataBind()
        If GridViewTest_Assign.Rows.Count <> 0 Then
            btnAdd.Visible = True
        Else
            btnAdd.Visible = False
        End If
    End Sub
    Protected Sub Radiology_Test()

        Dim row As DataRow


        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
            If CheckBoxList_Rad_Test.Items(count).Selected = True Then
                Try

                    row = ds.Tables("PatientTest").NewRow
                    row.Item("TID") = CheckBoxList_Rad_Test.Items(count).Value
                    row.Item("TestName") = CheckBoxList_Rad_Test.Items(count).Text
                    row.Item("TestType_ID") = "1"
                    row.Item("Charges") = Get_Charges(CheckBoxList_Rad_Test.Items(count).Value)
                    row.Item("IS_inside_Hospital_Test") = IS_inside_Test(CheckBoxList_Rad_Test.Items(count).Value)
                    ds.Tables("PatientTest").Rows.Add(row)

                    Session("PatientTest") = ds.Tables("PatientTest")


                Catch ex As Exception

                End Try
            End If
        Next


        Session("PatientTest") = ds.Tables("PatientTest")

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
        GridViewTest_Assign.DataBind()
        If GridViewTest_Assign.Rows.Count <> 0 Then
            btnAdd.Visible = True

        Else
            btnAdd.Visible = False
        End If
    End Sub

    Protected Function IS_inside_Test(ByVal T_ID As Integer) As Boolean
        Dim qry As String = "SELECT case when S_Id = 0 then 0 else 1 end as is_Inside_Test FROM Test_Booking where (TB_ID = @TB_ID)"
        Dim IS_inside_Hospital_Test As Boolean = 1
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(conRad)
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
        '    GridViewTest_Assign.HeaderRow.Cells(3).Visible = False

        '    For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
        '        GridViewTest_Assign.Rows(i).Cells(1).Visible = False
        '        GridViewTest_Assign.Rows(i).Cells(4).Visible = False
        '        GridViewTest_Assign.Rows(i).Cells(3).Visible = False
        '        Dim Label_charges As Label = GridViewTest_Assign.Rows(i).FindControl("Label_charges")
        '        If Not Label_charges Is Nothing Then

        '            Total_Charges = Total_Charges + Convert.ToInt32(Label_charges.Text)

        '        End If
        '    Next
        '    GridViewTest_Assign.FooterRow.Cells(3).Text = "Total Charges"
        '    Dim Label_Total_Charges As Label = GridViewTest_Assign.FooterRow.FindControl("Label_Total_Charges")

        '    Label_Total_Charges.Text = Total_Charges.ToString
        '    GridViewTest_Assign.FooterRow.Cells(1).Visible = False
        '    GridViewTest_Assign.FooterRow.Cells(4).Visible = False
        '    GridViewTest_Assign.FooterRow.Cells(3).Visible = False

        'End If
        'If GridViewTest_Assign.Rows.Count <> 0 Then
        '    btnAdd.Visible = True
        'Else
        '    btnAdd.Visible = False
        'End If




        'If GridViewTest_Assign.Rows.Count > 0 Then
        '    GridViewTest_Assign.HeaderRow.Cells(1).Visible = False
        '    GridViewTest_Assign.HeaderRow.Cells(4).Visible = False
        '    For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
        '        GridViewTest_Assign.Rows(i).Cells(1).Visible = False
        '        GridViewTest_Assign.Rows(i).Cells(4).Visible = False
        '    Next
        'End If
        'If GridViewTest_Assign.Rows.Count <> 0 Then
        '    btnAdd.Visible = True
        'Else
        '    btnAdd.Visible = False
        'End If
    End Sub

    Protected Sub GridViewTest_Assign_RowCancelingEdit(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCancelEditEventArgs) Handles GridViewTest_Assign.RowCancelingEdit
        'Reset the edit index.
        GridViewTest_Assign.EditIndex = -1
        'Bind data to the GridView control.
        BindData()


    End Sub
    Protected Function Get_Charges(ByVal T_ID As Integer) As String
        Dim qry As String = "SELECT     ISNULL(Admin_Hospital_Services_Rates.S_Amount, 0) AS S_Amount FROM Test_Booking INNER JOIN Admin_Services ON Test_Booking.S_Id = Admin_Services.S_ID INNER JOIN Admin_Hospital_Services_Rates ON Admin_Services.S_ID = Admin_Hospital_Services_Rates.S_Id WHERE (Test_Booking.TB_ID = @TB_ID)and Admin_Hospital_Services_Rates.Hospital_Id=@Hospital_Id and Admin_Hospital_Services_Rates.Patient_Type_Id=@Patient_Type_Id and Admin_Hospital_Services_Rates.IPD_OPD=@IPD_OPD"
        Dim result As String = "0"
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(conRad)
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


    Protected Sub GridViewTest_Assign_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.SelectedIndexChanged
        Dim row As DataRow
        Dim hdnTID As HiddenField = GridViewTest_Assign.Rows(GridViewTest_Assign.SelectedRow.RowIndex).FindControl("hdnTID")

        Dim TID As Integer = hdnTID.Value

        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim hdnTID1 As HiddenField = GridViewTest_Assign.Rows(x).FindControl("hdnTID")

            If TID <> hdnTID1.Value Then
                Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
                Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
                Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

                row = ds.Tables("PatientTest").NewRow
                row.Item("TID") = hdnTID1.Value
                row.Item("TestName") = Label_TestName.Text
                row.Item("Description") = Textbox_Description.Text
                row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
                row.Item("Charges") = Label_charges.Text
                row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
                ds.Tables("PatientTest").Rows.Add(row)
            Else
                For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
                    If CheckBoxList_Rad_Test.Items(count).Value = hdnTID1.Value Then
                        CheckBoxList_Rad_Test.Items(count).Selected = False
                    End If
                Next
            End If
        Next

        Session("PatientTest") = ds.Tables("PatientTest")

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
        GridViewTest_Assign.DataBind()
    End Sub

    Protected Sub GridViewTest_Assign_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewTest_Assign.RowUpdating

        Dim dt = Session("PatientTest")
        Dim row = GridViewTest_Assign.Rows(e.RowIndex)
        Dim txt As TextBox = GridViewTest_Assign.Rows(e.RowIndex).FindControl("TextBox_Description")
        Dim rbl As RadioButtonList = row.FindControl("RadioButtonList_TypeG")
        dt.Rows(row.DataItemIndex)("Description") = txt.Text
        dt.Rows(row.DataItemIndex)("Test Type") = rbl.SelectedItem.Text
        dt.Rows(row.DataItemIndex)("TestType_ID") = rbl.SelectedValue
        'Reset the edit index.
        GridViewTest_Assign.EditIndex = -1

        BindData()
    End Sub

    Function Is_exist(ByVal TB_Name As String) As Boolean
        Dim flag As Boolean = False
        Dim con As New SqlConnection(conRad)
        Dim qry As String = "SELECT TB_Name, TB_ID FROM Test_Booking where (TB_Name = @TB_Name)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@TB_Name", TB_Name)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            flag = True
        End While
        con.Close()
        Return flag
    End Function

    Protected Sub TextBox_Test_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Test.TextChanged



        If Is_exist(TextBox_Test.Text) Then

            CheckBoxList_Rad_Test.DataBind()
            For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
                If CheckBoxList_Rad_Test.Items(count).Text = TextBox_Test.Text Then
                    CheckBoxList_Rad_Test.Items(count).Selected = True
                End If

            Next

            Radiology_Test()
            HiddenFieldTestSubGroup.Value = "%"


            'GridView_Radiology.DataBind()
        Else

            TextBox_TBNAme.Text = TextBox_Test.Text
            Panel_Register_Test.Visible = True

        End If


        'CheckBoxList_Rad_Test.DataBind()

    End Sub

    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged

        HiddenFieldTestSubGroup.Value = DataList1.SelectedValue
        Label2.Text = ""
        Try
            'Dim LinkButton1 As LinkButton = DataList1.SelectedItem
            'HiddenField2.Value = DataList1.SelectedItem.ToString  'hid_GNAme.Value
            'labelGName.Text = HiddenField2.Value
            TextBox_Test.Text = ""
            HiddenFieldTestSubGroup.Value = DataList1.SelectedValue
            CheckBoxList_Rad_Test.DataBind()
            'btnAdd.Visible = True
        Catch ex As Exception
            labelGName.Text = ""
        End Try
        ' checkTests(CheckBoxListTest)
    End Sub

    Protected Sub CheckBoxList_Rad_Test_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_Rad_Test.SelectedIndexChanged
        Radiology_Test()
        'HiddenFieldTestSubGroup.Value = ""
        'CheckBoxList_Rad_Test.DataBind()
    End Sub

    Protected Sub Button_Save_TestBooking_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        SqlDataSource_MG_Name.Insert()
        TextBox_TBNAme.Text = ""
        Panel_Register_Test.Visible = False
        HiddenFieldTestSubGroup.Value = DropDownList_MGName.SelectedValue
        CheckBoxList_Rad_Test.DataBind()
        CheckBoxList_Rad_Test.Items(0).Selected = True


        Radiology_Test()
    End Sub

    Protected Sub Button_Pnl_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        TextBox_TBNAme.Text = ""
        Panel_Register_Test.Visible = False
    End Sub

    Protected Sub lbtnImage_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        ' pnl_xrayimg.Visible = True
        Dim lbtn As LinkButton = sender

        Response.Redirect("~/Radiology/Pt_View_Xray.aspx?RegNo=" + Session("RegistrationNo").ToString() + "&TB_ID=" + lbtn.CommandArgument + "&YearlyNo=" + Session("YearlyNo"))




    End Sub



    Protected Sub binDatalist()

    End Sub




    '    Protected Sub gvdData_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvdData.RowDataBound


    '        'Dim HiddenField_TGID As HiddenField = DataList_Radiology.Items(i).FindControl("HiddenField_TGID")
    '        If e.Row.RowType = DataControlRowType.DataRow Then

    '            Dim datalistSub As DataList = e.Row.FindControl("DataListPreviousTest_Sub")

    '            Dim Label_Date As Label = e.Row.FindControl("Label_Date")
    '            Dim regno As String = Session("RegistrationNo").ToString()
    '            Dim yearlyNo As HiddenField = e.Row.FindControl("yearlyNO")
    '            Dim dbmanager As New DbManager
    '            Dim dt As DataTable = dbmanager.ExecuteDataTable("uspGetPreviousRadiologyTests", "TreatmentConnectionString",
    '                                                         New SqlParameter() {New SqlParameter("@regno", regno.Trim()), New SqlParameter("@date", Label_Date.Text),
    '                                                         New SqlParameter("@yearlyNO", yearlyNo.Value.Trim())})
    '            datalistSub.DataSource = dt
    '            datalistSub.DataBind()
    '        End If

    '    End Sub
    '    Protected Sub gvdData_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
    '        gvdData.PageIndex = e.NewPageIndex
    '        gvdData.DataBind()
    '    End Sub
End Class






