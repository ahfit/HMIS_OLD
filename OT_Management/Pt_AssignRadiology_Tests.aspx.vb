Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic

Partial Class Pt_AssignRadiology_Tests_1
    Inherits System.Web.UI.Page

    Dim count As Integer = 0
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""




    'Dim areq As String = "000045"
    'Dim breq As String = "100004"

    Dim flag As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim connew As String = ConfigurationManager.ConnectionStrings("Admin_Rad_ConnectionString").ConnectionString
    Dim conRad As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim BasicdataInfo_constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

    Dim statuscmo As String
    Dim user_authen As New User_page_Authentication
    Dim ds As New Pathology
    Dim ENC As New Encryption
    Dim S_Amount As Integer
    Dim Hospital_Rate As Integer
    Dim Bill_By As String
    Dim S_ID As Integer

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

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        '  Dim row As DataRow

        'For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
        '    Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
        '    Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
        '    Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
        '    Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
        '    Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

        '    row = ds.Tables("PatientTest").NewRow
        '    row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
        '    'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
        '    row.Item("TestName") = Label_TestName.Text
        '    row.Item("Test Type") = Label_TestType.Text
        '    row.Item("Description") = Textbox_Description.Text
        '    'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
        '    'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
        '    row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
        '    row.Item("Charges") = "0"


        '    ds.Tables("PatientTest").Rows.Add(row)
        '    'ds.Tables("Test Type").Rows.Add(row)
        '    'ds.Tables("Description").Rows.Add(row)
        'Next

        '  Session("PatientTest") = ds.Tables("PatientTest")
        'GridView_Tests_For_Confirmation.DataSource = ds.Tables("PatientTest")
        'GridView_Tests_For_Confirmation.DataBind()
        'GridView_Tests_For_Confirmation.Visible = False
        'Button_OK.Visible = True
        'TextBox_Prescription_Code.Visible = True
        'Label_Lbl.Visible = True
        'Panel_Confirm.Visible = True
        '


        '==============================
        InsertRadiologyTests()
        GridView_Radiology0.DataBind()

        lblMessage.Text = "Data is Saved Successfully . . . . "
        lblMessage.Visible = True
    End Sub

    'Protected Sub GridView_Tests_For_Confirmation_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Tests_For_Confirmation.PreRender
    '    Dim Total_Charges As Integer = 0
    '    If GridView_Tests_For_Confirmation.Rows.Count > 0 Then
    '        GridView_Tests_For_Confirmation.HeaderRow.Cells(1).Visible = False
    '        GridView_Tests_For_Confirmation.HeaderRow.Cells(4).Visible = False

    '        For i As Integer = 0 To GridView_Tests_For_Confirmation.Rows.Count - 1
    '            Dim Label_charges As Label = GridView_Tests_For_Confirmation.Rows(i).FindControl("Label_charges")
    '            GridView_Tests_For_Confirmation.Rows(i).Cells(1).Visible = False
    '            GridView_Tests_For_Confirmation.Rows(i).Cells(4).Visible = False

    '            Total_Charges = Total_Charges + Convert.ToInt32(Label_charges.Text)
    '        Next
    '        GridView_Tests_For_Confirmation.FooterRow.Cells(3).Text = "Total Charges"
    '        GridView_Tests_For_Confirmation.FooterRow.Cells(5).Text = Total_Charges.ToString
    '        GridView_Tests_For_Confirmation.FooterRow.Cells(1).Visible = False
    '        GridView_Tests_For_Confirmation.FooterRow.Cells(4).Visible = False

    '    End If
    'End Sub
    Sub InsertRadiologyTests()
        Dim enc As New Encryption
        Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim command As SqlCommand = New SqlCommand("Insert_OT_Procedure_Order_Main", con)
        Dim main_id As Integer

        Try

            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.Parameters.AddWithValue("@Status", 11)
            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
            command.Parameters.AddWithValue("@ModeOfOperation", RadioButtonList_Type.SelectedValue)
            command.Parameters.AddWithValue("@ModeOfAdmission", RadioButtonList_AdmissionType.SelectedValue)
            command.Parameters.AddWithValue("@AnesthesiaOpinion", RadioButtonList_Anesthesia.SelectedValue)
            command.Parameters.AddWithValue("@AnesthesiaType", ddlAnesthsia.SelectedValue)
            command.Parameters.AddWithValue("@RecommendedBy", ddlRecommendedBy.SelectedValue)
            command.Parameters.AddWithValue("@OpinionForInternalMedicine", RadioButtonListInternalMed.SelectedValue)
            command.Parameters.AddWithValue("@ShiftToAfterOperation", RadioButtonList_ShiftTo.SelectedValue)
            command.Parameters.AddWithValue("@BloodRequired", TextBox_Blood.Text.Trim())
            command.Parameters.AddWithValue("@ConsultantName", DropDownListConsultant.SelectedValue)
            command.Parameters.AddWithValue("@AdviceToPatient", TextBox_Instructions.Text.Trim())
            command.Parameters.AddWithValue("@DateOfOperation", WebDateChooser_Date_Of_Operation.Value)
            command.Parameters.AddWithValue("@Date_Of_admission", WebDateChooser_Date_Of_admission.Value)
            command.Parameters.AddWithValue("@Ward", DDL_Wards.SelectedValue)
            command.Parameters.AddWithValue("@Date_Time", DateTime.Now)

            command.Parameters.Add("@Main_Id", SqlDbType.Int)
            command.Parameters("@Main_Id").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()
            main_id = command.Parameters("@Main_Id").Value


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1


            Dim description As TextBox = GridViewTest_Assign.Rows(i).FindControl("TextBox_Description")
            Dim sub_command As SqlCommand = New SqlCommand("uspInsert_OT_Order_Sub", con)
            sub_command.CommandType = CommandType.StoredProcedure
            sub_command.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
            sub_command.Parameters.AddWithValue("@Order_ID", main_id)
            Dim testname As Label = GridViewTest_Assign.Rows(i).FindControl("Label_TestName")
            sub_command.Parameters.AddWithValue("@testName", testname.Text)
            sub_command.Parameters.AddWithValue("@Instructions", description.Text.Trim())
            If String.IsNullOrEmpty(Session("YearlyNo")) Or String.IsNullOrEmpty(Session("registrationNo")) Then
                sub_command.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo"))
                sub_command.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
            Else
                sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))

            End If
            

            sub_command.ExecuteNonQuery()

            Dim constringss As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim cons As SqlConnection = New System.Data.SqlClient.SqlConnection(constringss)
            Dim commandEstimate As SqlCommand = New SqlCommand("SelectProcedurePackages", cons)
            commandEstimate.CommandType = CommandType.StoredProcedure
            commandEstimate.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(commandEstimate)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            If (dt.Rows.Count > 0) Then
                For count As Integer = 0 To dt.Rows.Count - 1

                    Dim constringssEs As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    Dim consEx As SqlConnection = New System.Data.SqlClient.SqlConnection(constringssEs)
                    Dim commandEstimateExecute As SqlCommand = New SqlCommand("UpdateEstimateBill", consEx)
                    commandEstimateExecute.CommandType = CommandType.StoredProcedure
                    commandEstimateExecute.Parameters.AddWithValue("@SID", dt.Rows(count)(0))
                    commandEstimateExecute.Parameters.AddWithValue("@Total_Amount", dt.Rows(count)(1))
                    commandEstimateExecute.Parameters.AddWithValue("@ASP_ID", dt.Rows(count)(2))
                    commandEstimateExecute.Parameters.AddWithValue("@Package_Type", dt.Rows(count)(4))
                    commandEstimateExecute.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
                    commandEstimateExecute.Parameters.AddWithValue("@Order_ID", main_id)
                    If String.IsNullOrEmpty(Session("YearlyNo")) Or String.IsNullOrEmpty(Session("registrationNo")) Then
                        commandEstimateExecute.Parameters.AddWithValue("@YearlyNo", Request.QueryString("YearlyNo"))
                        commandEstimateExecute.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
                    Else
                        commandEstimateExecute.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                        commandEstimateExecute.Parameters.AddWithValue("@RegNo", Session("registrationNo").ToString())

                    End If
                    consEx.Open()
                    commandEstimateExecute.ExecuteNonQuery()
                    consEx.Close()



                Next
              

            End If


        Next

        Dim pckgList As String = ""
        For i As Integer = 0 To CheckBoxList_Packages.Items.Count - 1
            ' Exit condition if the value is three.
            If CheckBoxList_Packages.Items(i).Selected = True Then
                HfPackageList.Value = CheckBoxList_Packages.Items(i).Value
                pckgList = pckgList + "<data><pck_id>" + HfPackageList.Value + "</pck_id></data>"
            End If
        Next

        'For index As Integer = 0 To chkboxPackageName.Items.Count - 1
        '    If chkboxPackageName.Items(index).Selected Then
        Dim command1 As SqlCommand = New SqlCommand("uspInsertOTPatientPackageInfo", con)
        command1.CommandType = CommandType.StoredProcedure

        command1.Parameters.AddWithValue("@VisitNo", Session("YearlyNo"))
        command1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        'command1.Parameters.AddWithValue("@PackageID", chkboxPackageName.Items(index).Value)
        command1.Parameters.AddWithValue("@PackageID", 0)
        command1.Parameters.AddWithValue("@empid", Session("emp_id"))
        command1.Parameters.AddWithValue("@Remarks", "OT")
        command1.Parameters.AddWithValue("@OT_MainID", main_id)
        command1.Parameters.AddWithValue("@PckgList", pckgList)


        command1.ExecuteNonQuery()
        '    End If
        'Next




        con.Close()


        'btnAdd.Visible = False
        GridViewTest_Assign.DataSource = Nothing
        GridViewTest_Assign.DataBind()
        'GridView_Radiology.DataBind()
        CheckBoxList_Rad_Test.DataBind()


    End Sub

    'Protected Sub Button_OK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_OK.Click
    '    ' If IS_Code_Matched(Session("emp_id"), TextBox_Prescription_Code.Text.Trim) Then
    '    Try
    '        Dim enc As New Encryption
    '        Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    '        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '        Dim command As SqlCommand = New SqlCommand("Insert_Radiology_Order_Main", con)
    '        command.CommandType = CommandType.StoredProcedure
    '        command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    '        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
    '        command.Parameters.AddWithValue("@Status", 11)
    '        command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
    '        command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
    '        command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
    '        command.Parameters.AddWithValue("@Clinical_Information", TextBox_Instructions.Text)

    '        If (Convert.ToString(DataList1.SelectedValue) = "") Then
    '            command.Parameters.AddWithValue("@R_ID", 0)
    '        Else
    '            command.Parameters.AddWithValue("@R_ID", DataList1.SelectedValue)
    '        End If

    '        command.Parameters.Add("@Main_Id", SqlDbType.Int)
    '        command.Parameters("@Main_Id").Direction = ParameterDirection.Output
    '        con.Open()
    '        command.ExecuteNonQuery()
    '        Dim main_id As Integer = command.Parameters("@Main_Id").Value

    '        For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
    '            'If CheckBoxList_Projection.Items(i).Selected = True Then
    '            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(i).FindControl("CheckBox_Is_Inside_Hospital")
    '            Dim description As TextBox = GridViewTest_Assign.Rows(i).FindControl("TextBox_Description")
    '            Dim sub_command As SqlCommand = New SqlCommand("Insert_Radiology_Order_sub", con)
    '            sub_command.CommandType = CommandType.StoredProcedure
    '            sub_command.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
    '            sub_command.Parameters.AddWithValue("@Order_ID", main_id)
    '            Dim testname As Label = GridViewTest_Assign.Rows(i).FindControl("Label_TestName")
    '            sub_command.Parameters.AddWithValue("@RadiologyTestName", testname.Text)
    '            sub_command.Parameters.AddWithValue("@Status", "New")
    '            sub_command.Parameters.AddWithValue("@Instructions", description.Text)
    '            sub_command.Parameters.AddWithValue("@Test_Type", GridViewTest_Assign.Rows(i).Cells(4).Text)
    '            sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)
    '            sub_command.ExecuteNonQuery()

    '        Next
    '        con.Close()
    '        Main_Group()
    '        'ds.Tables("PatientTest").Clear()
    '        'GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
    '        'GridViewTest_Assign.DataBind()

    '        'Label_MSG.Text = ""
    '        'Button_OK.Visible = False
    '        'TextBox_Prescription_Code.Visible = False
    '        'Label_Lbl.Visible = False
    '        'GridView_Tests_For_Confirmation.DataSource = Session("PatientTest")
    '        'GridView_Tests_For_Confirmation.DataBind()
    '        'GridView_Tests_For_Confirmation.Visible = True
    '        ds.Tables("PatientTest").Clear()
    '        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
    '        GridViewTest_Assign.DataBind()
    '        'GridView_Radiology.DataBind()
    '        CheckBoxList_Rad_Test.DataBind()





    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try

    '    GridView_Radiology.DataBind()

    '    'Else
    '    'Label_MSG.Text = "Pass Code Not Matched Try Again"
    '    'End If
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

    'Protected Sub ImageButton_Close_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Close.Click
    '    btnAdd.Visible = True
    '    ' Panel_Confirm.Visible = False
    'End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("~/login.aspx")
        End If
    End Sub

    Sub Select_Gender()
        Dim con As SqlConnection = New SqlConnection(constr_reg)
        Dim command As SqlCommand = New SqlCommand("SELECT SexID FROM Patient WHERE RegNo = @RegNo", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            HiddenFieldGender.Value = reader.Item(0).ToString
        End If
        reader.Close()
        con.Close()
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        'If Session("HospitalId") = 248 Then
        '    TextBox_Test.Visible = True
        '    TextBox_testDental.Visible = False
        '    TextBox_TestComplex.Visible = False
        'ElseIf Session("HospitalId") = 242 Or Session("HospitalId") = 246 Then
        '    TextBox_testDental.Visible = True
        '    TextBox_Test.Visible = False
        '    TextBox_TestComplex.Visible = False
        'ElseIf Session("HospitalId") = 244 Then
        '    TextBox_TestComplex.Visible = True
        '    TextBox_testDental.Visible = False
        '    TextBox_Test.Visible = False
        'End If




        If Not IsPostBack Then
            GetWards()
            GetConsultants()
            GetPackages()
            GetAnesthesia()

            Get_Radiology_Test.ContextKey = Session("HospitalId")
            Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Dim obj As New JavaScriptMenu()
            obj.loginvalidate()
            If String.IsNullOrEmpty(Request.QueryString("Type")) Then
                LabelSideMenu.Text = obj.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
                LabelFooter.Text = obj.Footer_String()
            End If


            If Not IsPostBack Then
                RadioButtonList_Type.DataBind()
                RadioButtonList_Type.SelectedIndex = 0
            End If
            Select_Gender()
            'datafields()
            Session.Add("TestStatus", Session("Teststatus"))
            statuscmo = Session("TestStatus")
            Session.Timeout = 60
            WebDateChooser_Date_Of_admission.Value = Date.Now()
            WebDateChooser_Date_Of_Operation.Value = Date.Now()
            'If GridViewTest_Assign.Rows.Count <> 0 Then
            '    btnAdd.Visible = True
            'Else
            '    btnAdd.Visible = False
            'End If
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
        'If GridViewTest_Assign.Rows.Count <> 0 Then
        '    btnAdd.Visible = True
        'Else
        '    btnAdd.Visible = False
        'End If
    End Sub
    Protected Sub Radiology_Test()
        Select_Gender()
        Dim row As DataRow
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = Textbox_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
            row.Item("Charges") = "0"
            row.Item("IS_inside_Hospital_Test") = False

            ds.Tables("PatientTest").Rows.Add(row)
            'ds.Tables("Test Type").Rows.Add(row)
            'ds.Tables("Description").Rows.Add(row)
        Next

        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
            If CheckBoxList_Rad_Test.Items(count).Selected = True Then
                Try

                    row = ds.Tables("PatientTest").NewRow
                    row.Item("TID") = CheckBoxList_Rad_Test.Items(count).Value
                    row.Item("TestName") = CheckBoxList_Rad_Test.Items(count).Text
                    row.Item("Test Type") = RadioButtonList_Type.SelectedItem.Text
                    row.Item("Description") = "" 'TextBox_Instructions.Text
                    row.Item("TestType_ID") = RadioButtonList_Type.SelectedValue
                    row.Item("Charges") = "0"

                    If S_ID = 0 Then
                        row.Item("IS_inside_Hospital_Test") = 0
                    Else
                        row.Item("IS_inside_Hospital_Test") = 1
                    End If

                    ds.Tables("PatientTest").Rows.Add(row)

                    Session("PatientTest") = ds.Tables("PatientTest")

                    GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
                    GridViewTest_Assign.DataBind()

                    'If GridViewTest_Assign.Rows.Count <> 0 Then
                    '    btnAdd.Visible = True
                    'Else
                    '    btnAdd.Visible = False
                    'End If
                Catch ex As Exception

                End Try
            End If
        Next


        Session("PatientTest") = ds.Tables("PatientTest")

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
        GridViewTest_Assign.DataBind()
        'If GridViewTest_Assign.Rows.Count <> 0 Then
        '    btnAdd.Visible = True
        'Else
        '    btnAdd.Visible = False
        'End If
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
        Bill_By = ""
        S_Amount = 0
        Hospital_Rate = 0
        S_ID = 0

        '================================================================================
        Dim result As String = "0"
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(BasicdataInfo_constr)
        Dim command As SqlCommand = New SqlCommand("get_LabService_Rates", con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@TB_ID", T_ID)
        command.Parameters.AddWithValue("@Hospital_Id", CInt(Session("PatientHospital_ID")))
        command.Parameters.AddWithValue("@IPD_OPD", Session("IPDOPD"))
        command.Parameters.AddWithValue("@Patient_Type_Id", CInt(Session("Patient_Type_ID")))
        command.Parameters.AddWithValue("@Billing_Party_Id", Session("PatientBillingParty_Id"))
        command.Parameters.AddWithValue("@LabType", "Radiology")

        '=====================================================================
        command.Parameters.Add("@Bill_By", SqlDbType.VarChar, 20)
        command.Parameters("@Bill_By").Direction = ParameterDirection.Output
        command.Parameters.Add("@Hospital_Rate", SqlDbType.Int)
        command.Parameters("@Hospital_Rate").Direction = ParameterDirection.Output
        command.Parameters.Add("@S_Amount", SqlDbType.Int)
        command.Parameters("@S_Amount").Direction = ParameterDirection.Output
        command.Parameters.Add("@S_Id", SqlDbType.Int)
        command.Parameters("@S_Id").Direction = ParameterDirection.Output
        '===================================================================
        con.Open()
        command.ExecuteNonQuery()
        Bill_By = command.Parameters("@Bill_By").Value
        S_Amount = command.Parameters("@S_Amount").Value
        Hospital_Rate = command.Parameters("@Hospital_Rate").Value
        S_ID = command.Parameters("@S_Id").Value
        Return S_Amount


    End Function
    Protected Sub GridView_Radiology_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Radiology.SelectedIndexChanged

    End Sub

    Protected Sub GridViewTest_Assign_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.SelectedIndexChanged
        Dim row As DataRow
        Dim TID As Integer = GridViewTest_Assign.Rows(GridViewTest_Assign.SelectedRow.RowIndex).Cells(1).Text
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            If TID <> GridViewTest_Assign.Rows(x).Cells(1).Text Then
                Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
                Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
                Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

                row = ds.Tables("PatientTest").NewRow
                row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
                'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
                row.Item("TestName") = Label_TestName.Text
                row.Item("Test Type") = Label_TestType.Text
                row.Item("Description") = Textbox_Description.Text
                'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
                'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
                row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
                row.Item("Charges") = Label_charges.Text
                row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
                ds.Tables("PatientTest").Rows.Add(row)
            Else
                For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
                    If CheckBoxList_Rad_Test.Items(count).Value = GridViewTest_Assign.Rows(x).Cells(1).Text Then
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


            GridView_Radiology.DataBind()
        Else

            TextBox_TBNAme.Text = TextBox_Test.Text
            Panel_Register_Test.Visible = True

        End If


        'CheckBoxList_Rad_Test.DataBind()

    End Sub

    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged

        'HiddenFieldTestSubGroup.Value = DataList1.SelectedValue
        Label2.Text = ""
        Try
            'Dim LinkButton1 As LinkButton = DataList1.SelectedItem
            'HiddenField2.Value = DataList1.SelectedItem.ToString  'hid_GNAme.Value
            'labelGName.Text = HiddenField2.Value
            TextBox_Test.Text = ""
            'TextBox_testDental.Text = ""
            'TextBox_TestComplex.Text = ""
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
        lblMessage.Visible = False
        fillpackages()
        'HiddenFieldTestSubGroup.Value = ""
        'CheckBoxList_Rad_Test.DataBind()
    End Sub
    Protected Sub selecdgrid(ByVal i As Integer)
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("Select ASP_ID from Admin_Service_Package_Sub  where S_ID =@S_ID", con)
        command.Parameters.AddWithValue("@S_ID", i)
        Dim dt As DataTable = New DataTable()
        Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
        sda.Fill(dt)
        If (dt.Rows.Count > 0) Then
            For j As Integer = 0 To dt.Rows.Count


                For count As Integer = 0 To CheckBoxList_Packages.Items.Count - 1
                    Try

                        If CheckBoxList_Packages.Items(count).Value = dt.Rows(j)(0) Then
                            CheckBoxList_Packages.Items(count).Selected = True
                        End If

                    Catch ex As Exception

                    End Try
                Next




            Next
        End If
    End Sub
    Protected Sub fillpackages()
        Dim str As String = String.Empty
        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
            If CheckBoxList_Rad_Test.Items(count).Selected = True Then
                selecdgrid(CheckBoxList_Rad_Test.Items(count).Value)
            End If
        Next

        
    End Sub



    Protected Sub Button_Save_TestBooking_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save_TestBooking.Click

        'SqlDataSource_MG_Name.Insert()
        'TextBox_TBNAme.Text = ""
        'Panel_Register_Test.Visible = False
        'HiddenFieldTestSubGroup.Value = DropDownList_MGName.SelectedValue
        'CheckBoxList_Rad_Test.DataBind()
        'CheckBoxList_Rad_Test.Items(0).Selected = True


        'Radiology_Test()
    End Sub

    Protected Sub Button_Pnl_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Pnl_Cancel.Click
        TextBox_TBNAme.Text = ""
        ' Panel_Register_Test.Visible = False

        Dim row As DataRow
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = Textbox_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
            row.Item("Charges") = Label_charges.Text
            row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked

            ds.Tables("PatientTest").Rows.Add(row)
            'ds.Tables("Test Type").Rows.Add(row)
            'ds.Tables("Description").Rows.Add(row)
        Next

        Session("PatientTest") = ds.Tables("PatientTest")
        'btnAdd.Visible = False
        '==============================


    End Sub

    Protected Sub lbtnImage_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        ' pnl_xrayimg.Visible = True
        Dim lbtn As LinkButton = sender

        Dim webAddress As String = "http://192.168.79.17/Explore.asp?path=/All%20Studies/AccessionNumber=" + lbtn.CommandArgument
        System.Diagnostics.Process.Start(webAddress)

        '  Response.Redirect("~/Radiology/Pt_View_Xray.aspx?RegNo=" + Session("RegistrationNo").ToString() + "&TB_ID=" + lbtn.CommandArgument + "&YearlyNo=" + Session("YearlyNo"))




    End Sub

    Protected Sub DDL_Wards_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles DDL_Wards.SelectedIndexChanged
        Dim str As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("Ward_Census", con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Hospital_id", Session("HospitalId"))
        command.Parameters.AddWithValue("@Ward_Id", DDL_Wards.SelectedValue)
        con.Open()
        'command.ExecuteNonQuery()
        'con.Close()
        Try
            Dim reader As SqlDataReader = command.ExecuteReader
            While reader.Read()

                str = reader.Item(3).ToString
                str = str + " / "
                str = str + reader.Item(1).ToString

            End While
            Label_Ward_Count.Text = str

        Catch ex As Exception
            Response.Write(ex.Message + "Main Insert  ")
        End Try
    End Sub

    Protected Sub CheckBoxList_Diagnosis_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles CheckBoxList_Diagnosis.SelectedIndexChanged
        TextBox_admision_Diagnosis.Text = ""
        For i As Integer = 0 To CheckBoxList_Diagnosis.Items.Count - 1
            If CheckBoxList_Diagnosis.Items(i).Selected = True Then
                If TextBox_admision_Diagnosis.Text <> "" Then
                    TextBox_admision_Diagnosis.Text = TextBox_admision_Diagnosis.Text + ", " + CheckBoxList_Diagnosis.Items(i).Text
                Else
                    TextBox_admision_Diagnosis.Text = TextBox_admision_Diagnosis.Text + CheckBoxList_Diagnosis.Items(i).Text
                End If

            End If
        Next
    End Sub

    'Protected Sub TextBox_TestComplex_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_TestComplex.TextChanged
    '    If Is_exist(TextBox_TestComplex.Text) Then

    '        CheckBoxList_Rad_Test.DataBind()
    '        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
    '            If CheckBoxList_Rad_Test.Items(count).Text = TextBox_TestComplex.Text Then
    '                CheckBoxList_Rad_Test.Items(count).Selected = True
    '            End If

    '        Next

    '        Radiology_Test()
    '        HiddenFieldTestSubGroup.Value = "%"


    '        GridView_Radiology.DataBind()
    '    Else

    '        TextBox_TBNAme.Text = TextBox_TestComplex.Text
    '        Panel_Register_Test.Visible = True

    '    End If
    'End Sub

    'Protected Sub TextBox_testDental_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_testDental.TextChanged
    '    If Is_exist(TextBox_testDental.Text) Then

    '        CheckBoxList_Rad_Test.DataBind()
    '        For count As Integer = 0 To CheckBoxList_Rad_Test.Items.Count - 1
    '            If CheckBoxList_Rad_Test.Items(count).Text = TextBox_testDental.Text Then
    '                CheckBoxList_Rad_Test.Items(count).Selected = True
    '            End If

    '        Next

    '        Radiology_Test()
    '        HiddenFieldTestSubGroup.Value = "%"


    '        GridView_Radiology.DataBind()
    '    Else

    '        TextBox_TBNAme.Text = TextBox_testDental.Text
    '        Panel_Register_Test.Visible = True

    '    End If
    'End Sub

    'Protected Sub btnAdd2_Click(sender As Object, e As System.EventArgs) Handles btnAdd2.Click
    '    Dim row As DataRow
    '    For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
    '        Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
    '        Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
    '        Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
    '        Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
    '        Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

    '        row = ds.Tables("PatientTest").NewRow
    '        row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
    '        'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
    '        row.Item("TestName") = Label_TestName.Text
    '        row.Item("Test Type") = Label_TestType.Text
    '        row.Item("Description") = Textbox_Description.Text
    '        'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
    '        'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
    '        row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
    '        row.Item("Charges") = Label_charges.Text
    '        row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked

    '        ds.Tables("PatientTest").Rows.Add(row)
    '        'ds.Tables("Test Type").Rows.Add(row)
    '        'ds.Tables("Description").Rows.Add(row)
    '    Next

    '    Session("PatientTest") = ds.Tables("PatientTest")
    '    'GridView_Tests_For_Confirmation.DataSource = ds.Tables("PatientTest")
    '    'GridView_Tests_For_Confirmation.DataBind()
    '    'GridView_Tests_For_Confirmation.Visible = False
    '    ''Button_OK.Visible = True
    '    'TextBox_Prescription_Code.Visible = True
    '    'Label_Lbl.Visible = True
    '    'Panel_Confirm.Visible = True
    '    '

    '    btnAdd.Visible = False
    '    '==============================
    '    InsertRadiologyTests()


    'End Sub

    Protected Sub Button1_Click(sender As Object, e As System.EventArgs)
        Dim row As DataRow
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            Dim Textbox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("Textbox_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = Textbox_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
            row.Item("Charges") = Label_charges.Text
            row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked

            ds.Tables("PatientTest").Rows.Add(row)
            'ds.Tables("Test Type").Rows.Add(row)
            'ds.Tables("Description").Rows.Add(row)
        Next

        Session("PatientTest") = ds.Tables("PatientTest")
        'btnAdd.Visible = False
        '==============================

    End Sub


    Private Sub GetWards()
        Dim manager As DbManager = New DbManager()
        DDL_Wards.DataSource = manager.ExecuteDataTableWithQuery("select Ward_id,Ward_Name from admin_Hospital_Wards", "Basic_Data_ConnectionString", New SqlParameter() {})
        DDL_Wards.DataValueField = "Ward_id"
        DDL_Wards.DataTextField = "Ward_Name"
        DDL_Wards.DataBind()
    End Sub


    Private Sub GetConsultants()
        Dim manager As DbManager = New DbManager()
        Dim ds As DataTable = New DataTable()
        ds = manager.ExecuteDataTableWithQuery("select EmpID,ISNULL(EFName,'')+' '+ISNULL(EMName,'')+' '+ISNULL(ELName,'') as Name from Employee where Is_Consultant=1",
                                                                 "Basic_Data_ConnectionString", New SqlParameter() {})
        ddlRecommendedBy.DataSource = ds
        ddlRecommendedBy.DataValueField = "EmpID"
        ddlRecommendedBy.DataTextField = "Name"
        ddlRecommendedBy.DataBind()


        DropDownListConsultant.DataSource = ds
        DropDownListConsultant.DataValueField = "EmpID"
        DropDownListConsultant.DataTextField = "Name"
        DropDownListConsultant.DataBind()

    End Sub
    Private Sub GetPackages()
        Dim manager As DbManager = New DbManager()
        'chkboxPackageName.DataSource = manager.ExecuteDataTableWithQuery("Select  ASP_ID,AP_Name from Admin_Service_Package", "Basic_Data_ConnectionString", New SqlParameter() {})
        'chkboxPackageName.DataValueField = "ASP_ID"
        'chkboxPackageName.DataTextField = "AP_Name"
        'chkboxPackageName.DataBind()
        CheckBoxList_Packages.DataSource = manager.ExecuteDataTableWithQuery("Select  ASP_ID,AP_Name from Admin_Service_Package", "Basic_Data_ConnectionString", New SqlParameter() {})
        CheckBoxList_Packages.DataValueField = "ASP_ID"
        CheckBoxList_Packages.DataTextField = "AP_Name"
        CheckBoxList_Packages.DataBind()

    End Sub


    Private Sub GetAnesthesia()
        Dim manager As DbManager = New DbManager()
        ddlAnesthsia.DataSource = manager.ExecuteDataTableWithQuery("Select   Anesthesia_Id,Anesthesia_Name from Anesthesia_Type",
                                                                    "OT_ManagementConnectionString", New SqlParameter() {})
        ddlAnesthsia.DataValueField = "Anesthesia_Id"
        ddlAnesthsia.DataTextField = "Anesthesia_Name"
        ddlAnesthsia.DataBind()
    End Sub






    <System.Web.Script.Services.ScriptMethod, System.Web.Services.WebMethod>
    Public Shared Function Get_OT_Procedures(prefixText As String, count As Integer) As List(Of String)
        Dim items As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SELECT     Test_Booking.TB_Name as S_Name, Test_Booking.TB_ID FROM   OT_Management.dbo. Test_Booking where TB_Name like '%'+@Search+'%' order by TB_Name "
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
    Private Sub GetOTDays()
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("GetOT_Days", "Basic_Data_ConnectionString", New SqlParameter() {
                                    New SqlParameter("@SubDeptID", Request.QueryString("payid")),
                                    New SqlParameter("@VisitNo", Request.QueryString("payid")),
                                    New SqlParameter("@VisitNo", Request.QueryString("payid"))
                                    })
        grdOTDays.DataSource = dt
       
        grdOTDays.DataBind()


    End Sub
    Protected Sub lnk_OTList_Click(sender As Object, e As EventArgs)

    End Sub
End Class






