Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_Path_Test_New
    Inherits System.Web.UI.Page

    Dim count As Integer = 0
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = "LGH/251120060019"
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim Path_constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
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

        Dim row As DataRow
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            'Dim Label_Description As Label = GridViewTest_Assign.Rows(x).FindControl("Label_Description")
            Dim TextBox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("TextBox_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = TextBox_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = GridViewTest_Assign.Rows(x).Cells(4).Text
            row.Item("Charges") = Label_charges.Text
            row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
            ds.Tables("PatientTest").Rows.Add(row)

            'ds.Tables("Test Type").Rows.Add(row)0
            'ds.Tables("Description").Rows.Add(row)
        Next
        Session("PatientTest") = ds.Tables("PatientTest")       
        btnAdd.Visible = False
        SaveTests()
        gvdData.DataBind()

        lblMsg.Text = "Saved successfully"
        lblMsg.ForeColor = Drawing.Color.Green


    End Sub





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
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))

        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()

        If Not IsPostBack Then

            RadioButtonList_Type.DataBind()
            RadioButtonList_Type.SelectedIndex = 0
            DropDownList2.DataBind()
            DropDownList2.Items.Insert(0, "All")
            DropDownList2.Items(0).Value = "%"

        End If
        gvdData.DataBind()
        Select_Gender()
        'datafields()
        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
        Main_Group()
        If Not IsPostBack Then
            If GridViewTest_Assign.Rows.Count <> 0 Then
                btnAdd.Visible = True
            Else
                btnAdd.Visible = False
            End If
            gvdData.DataBind()
        End If
        TestStatus.Visible = False
        panel.Visible = False
        repater.Visible = False
        GridView1.DataBind()
        'Response.Write("Reg No :- " + Session("registrationNo").ToString() + "Yearly no :- " + Session("YearlyNo"))
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        ''''' change on 23-02-2009 after the structure change booking style change at doctor end 
        HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
        Label2.Text = ""
        Try
            HiddenField2.Value = DropDownList2.SelectedItem.Text  'hid_GNAme.Value
            labelGName.Text = HiddenField2.Value
            btnAdd.Visible = True
        Catch ex As Exception
            labelGName.Text = ""
        End Try
        ' checkTests(CheckBoxListTest)
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

    Protected Sub GridView_Test_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Test.PreRender
        If GridView_Test.Rows.Count > 0 Then
            GridView_Test.HeaderRow.Cells(1).Visible = False
            GridView_Test.HeaderRow.Cells(2).Visible = False
            For i As Integer = 0 To GridView_Test.Rows.Count - 1
                GridView_Test.Rows(i).Cells(1).Visible = False
                GridView_Test.Rows(i).Cells(2).Visible = False
            Next
        End If
    End Sub

    Protected Sub GridView_Test_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Test.SelectedIndexChanged
        Select_Gender()
        Dim row As DataRow

        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            Dim Label_Description As Label = GridViewTest_Assign.Rows(x).FindControl("Label_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim hid_type As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField1")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")


            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = Label_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = hid_type
            row.Item("Charges") = Label_charges.Text
            row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
            ds.Tables("PatientTest").Rows.Add(row)
            'ds.Tables("Test Type").Rows.Add(row)
            'ds.Tables("Description").Rows.Add(row)
        Next
        row = ds.Tables("PatientTest").NewRow
        row.Item("TID") = GridView_Test.Rows(GridView_Test.SelectedIndex).Cells(2).Text
        row.Item("TestName") = GridView_Test.Rows(GridView_Test.SelectedIndex).Cells(1).Text
        row.Item("Test Type") = RadioButtonList_Type.SelectedItem.Text
        row.Item("Description") = TextBoxDescription.Text
        row.Item("TestType_ID") = RadioButtonList_Type.SelectedValue
        row.Item("Charges") = Get_Charges(GridView_Test.Rows(GridView_Test.SelectedIndex).Cells(2).Text)
        row.Item("IS_inside_Hospital_Test") = IS_inside_Test(CheckBoxList_LabTest.Items(count).Value)
        ds.Tables("PatientTest").Rows.Add(row)

        Session("PatientTest") = ds.Tables("PatientTest")

        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
        GridViewTest_Assign.DataBind()

        If GridViewTest_Assign.Rows.Count <> 0 Then
            btnAdd.Visible = True
        Else
            btnAdd.Visible = False
        End If

    End Sub


    Protected Sub GridViewTest_Assign_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.PreRender
        Dim Total_Charges As Integer = 0
        If GridViewTest_Assign.Rows.Count > 0 Then
            GridViewTest_Assign.HeaderRow.Cells(1).Visible = False
            GridViewTest_Assign.HeaderRow.Cells(4).Visible = False
            'GridViewTest_Assign.HeaderRow.Cells(3).Visible = False

            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
                GridViewTest_Assign.Rows(i).Cells(1).Visible = False
                GridViewTest_Assign.Rows(i).Cells(4).Visible = False
                'GridViewTest_Assign.Rows(i).Cells(3).Visible = False

                Dim Label_charges As Label = GridViewTest_Assign.Rows(i).FindControl("Label_charges")
                If Not Label_charges Is Nothing Then

                    Total_Charges = Total_Charges + Convert.ToInt32(Label_charges.Text)

                End If
            Next
            GridViewTest_Assign.FooterRow.Cells(3).Text = "Total Charges"
            Dim Label_Total_Charges As Label = GridViewTest_Assign.FooterRow.FindControl("Label_Total_Charges")

            Label_Total_Charges.Text = Total_Charges.ToString
            GridViewTest_Assign.FooterRow.Cells(1).Visible = False
            GridViewTest_Assign.FooterRow.Cells(4).Visible = False
            GridViewTest_Assign.FooterRow.Cells(3).Visible = False

        End If
        If GridViewTest_Assign.Rows.Count <> 0 Then
            btnAdd.Visible = True
        Else
            btnAdd.Visible = False
        End If
    End Sub

    Protected Sub GridViewTest_Assign_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest_Assign.SelectedIndexChanged
        Dim row As DataRow
        Dim TID As Integer = GridViewTest_Assign.Rows(GridViewTest_Assign.SelectedRow.RowIndex).Cells(1).Text
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            If TID <> GridViewTest_Assign.Rows(x).Cells(1).Text Then
                Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
                Dim Label_Description As Label = GridViewTest_Assign.Rows(x).FindControl("Label_Description")
                Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
                Dim hid_type As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField1")
                Dim HF_TestType_ID As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField3")
                Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")

                row = ds.Tables("PatientTest").NewRow
                row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
                'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
                row.Item("TestName") = Label_TestName.Text
                row.Item("Test Type") = Label_TestType.Text
                row.Item("Description") = Label_Description.Text
                'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
                'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
                row.Item("TestType_ID") = HF_TestType_ID.Value
                row.Item("Charges") = Label_charges.Text
                row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
                ds.Tables("PatientTest").Rows.Add(row)
            Else
                For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
                    If CheckBoxList_LabTest.Items(count).Value = GridViewTest_Assign.Rows(x).Cells(1).Text Then
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
    Private Sub BindData()

        GridViewTest_Assign.DataSource = Session("PatientTest")
        GridViewTest_Assign.DataBind()
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







    Function Is_exist(ByVal TB_Name As String) As Boolean
        Dim flag As Boolean = False
        Dim con As New SqlConnection(Path_constr)
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

            CheckBoxList_LabTest.DataBind()


            For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
                If CheckBoxList_LabTest.Items(count).Text = TextBox_Test.Text Then
                    CheckBoxList_LabTest.Items(count).Selected = True
                End If
            Next


            Book_Path_Test()
            HiddenField_MG_ID.Value = "%"

            GridView_Test.DataBind()
        Else

            TextBox_TBNAme.Text = TextBox_Test.Text
            Panel_Register_Test.Visible = True
            'Panel_Message.Visible = True
            'Dim strMessage = "Please go to File "
            'Dim sb As New StringBuilder

            ''sb.Append("<script language='javascript' type='text/javascript'>window.Alert('" & strMessage & "')</script>")
            'sb.Append("<script language='javascript' type='text/javascript'>MsgBox ""Hello there"",64,""Greetings From JK""</script>")
            'Dim t As Type = Me.GetType()
            'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
            'End If
            'Response.Write("<script language='javascript' type='text/javascript'>MsgBox ""Hello there"",64,""Greetings From JK""</script>")



            'Page.RegisterClientScriptBlock("ClientScript", script)

            ' Response.Redirect("../login.aspx")

            'MsgBox "Hello there",64,"Greetings From JK"

            'strScript = "<script language='javascript' type='text/javascript'>window.Alert('" & strMessage & "');</script>"
            'If (Not Page.IsStartupScriptRegistered("clientScript")) Then
            '    Page.RegisterStartupScript("clientScript", strScript)
            'End If

        End If

    End Sub

    Protected Sub Button_record_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_record.Click
        Book_Path_Test()
    End Sub

    Protected Sub Book_Path_Test()
        Select_Gender()
        Dim row As DataRow
        For x As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
            Dim Label_TestType As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestType")
            'Dim Label_Description As Label = GridViewTest_Assign.Rows(x).FindControl("Label_Description")
            Dim TextBox_Description As TextBox = GridViewTest_Assign.Rows(x).FindControl("TextBox_Description")
            Dim Label_TestName As Label = GridViewTest_Assign.Rows(x).FindControl("Label_TestName")
            Dim Label_charges As Label = GridViewTest_Assign.Rows(x).FindControl("Label_charges")
            Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(x).FindControl("CheckBox_Is_Inside_Hospital")
            Dim HF_TestType_ID As HiddenField = GridViewTest_Assign.Rows(x).FindControl("HiddenField3")

            row = ds.Tables("PatientTest").NewRow
            row.Item("TID") = GridViewTest_Assign.Rows(x).Cells(1).Text
            'row.Item("TestName") = GridViewTest_Assign.Rows(x).Cells(0).Text
            row.Item("TestName") = Label_TestName.Text
            row.Item("Test Type") = Label_TestType.Text
            row.Item("Description") = TextBox_Description.Text
            'row.Item("Test Type") = GridViewTest_Assign.Rows(x).Cells(2).Text
            'row.Item("Description") = GridViewTest_Assign.Rows(x).Cells(3).Text
            row.Item("TestType_ID") = HF_TestType_ID.Value
            row.Item("Charges") = Label_charges.Text
            row.Item("IS_inside_Hospital_Test") = CheckBox_Is_Inside_Hospital.Checked
            ds.Tables("PatientTest").Rows.Add(row)

            'ds.Tables("Test Type").Rows.Add(row)
            'ds.Tables("Description").Rows.Add(row)
        Next
        For count As Integer = 0 To CheckBoxList_LabTest.Items.Count - 1
            If CheckBoxList_LabTest.Items(count).Selected = True Then
                Try
                    row = ds.Tables("PatientTest").NewRow
                    If Not Already_Exist(CheckBoxList_LabTest.Items(count).Value) Then
                        row.Item("TID") = CheckBoxList_LabTest.Items(count).Value
                        row.Item("TestName") = CheckBoxList_LabTest.Items(count).Text
                        row.Item("Test Type") = RadioButtonList_Type.SelectedItem.Text
                        row.Item("Description") = "" 'TextBoxDescription.Text
                        row.Item("TestType_ID") = RadioButtonList_Type.SelectedValue
                        row.Item("Charges") = Get_Charges(CheckBoxList_LabTest.Items(count).Value)
                        row.Item("IS_inside_Hospital_Test") = IS_inside_Test(CheckBoxList_LabTest.Items(count).Value)
                        ds.Tables("PatientTest").Rows.Add(row)

                        Session("PatientTest") = ds.Tables("PatientTest")
                        GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
                        GridViewTest_Assign.DataBind()
                        If GridViewTest_Assign.Rows.Count <> 0 Then
                            btnAdd.Visible = True
                        Else
                            btnAdd.Visible = False
                        End If
                    End If

                Catch ex As Exception
                    Response.Write(ex.Message)
                End Try
            End If
        Next
    End Sub
    Private Function Already_Exist(ByVal T_ID As Integer) As Boolean
        Dim is_exist As Boolean = False
        For i As Integer = 0 To ds.Tables("PatientTest").Rows.Count - 1
            If Convert.ToInt32(ds.Tables("PatientTest").Rows(i).Item("TID")) = T_ID Then
                is_exist = True
            End If
        Next
        Return is_exist
    End Function
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

        ' Response.Write(HiddenField_MG_ID.Value)
        'GridView_Test.DataBind()
    End Sub



    Private Function Get_Type(ByVal PayId As Integer)
        Dim type As String = ""
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
    Sub Insert_Values()
        Dim SDate As Date = Date.Now 'WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        Dim report_date As Date = DateAdd(DateInterval.Day, 1, Date.Now)
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_alreadeybook_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("Reg_No"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", SDate)
        param = mycommand.Parameters.AddWithValue("@Sample_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", report_date)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", 0)
        param = mycommand.Parameters.AddWithValue("@Description", "")
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", 1)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", HiddenField_Order_ID.Value)
        param = mycommand.Parameters.AddWithValue("@From_Dept_ID", Session("dept_Id"))
        param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", Session("SubDeptID"))
        'Lab dept 10 subdept 14
        param = mycommand.Parameters.AddWithValue("@To_Dept_ID", 10)
        param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", 14)
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub
    Public Sub update_Test_Booking_Status(ByVal Status As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Update_Test_Booking_Status", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Connection.Open()
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@Status", Status)
        mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMain_ID.Value)

        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()


    End Sub

    Private Sub Insert_For_Payment()
        GridView_Sample_Recieved.DataBind()
        If GridView_Sample_Recieved.Rows.Count <> 0 Then
            Insert_Values()
        End If
        Try


            For i As Integer = 0 To GridView_Sample_Recieved.Rows.Count - 1
                Dim check As CheckBox = GridView_Sample_Recieved.Rows(i).FindControl("CheckBox1")
                Dim Hid_TB_ID As HiddenField = GridView_Sample_Recieved.Rows(i).FindControl("HiddenField_TB_ID")
                If check.Checked = True Then
                    Insert_Test_Services(Hid_TB_ID.Value)

                    Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    ' GridView_Sample_Recieved.DataBind()

                    Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & Hid_TB_ID.Value, con)
                    mycommand1.CommandType = Data.CommandType.Text
                    con.Open()
                    Dim da1 As New SqlDataAdapter
                    Dim ds1 As New DataSet
                    mycommand1.ExecuteNonQuery()
                    da1.SelectCommand = mycommand1
                    da1.Fill(ds1)
                    For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                        Dim mycommand2 As New System.Data.SqlClient.SqlCommand("test_insert", con)
                        mycommand2.CommandType = Data.CommandType.StoredProcedure
                        mycommand2.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                        mycommand2.Parameters.AddWithValue("@TID", ds1.Tables(0).Rows(j).Item(0))
                        mycommand2.Parameters.AddWithValue("@DateTime", Date.Now)
                        mycommand2.Parameters.AddWithValue("@DoctorID", "3")
                        mycommand2.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                        mycommand2.Parameters.AddWithValue("@RegNo", Session("registrationno")) 'Session("EMORegNo")
                        mycommand2.Parameters.AddWithValue("@Biopsy_description", "")
                        mycommand2.ExecuteNonQuery()
                    Next
                    con.Close()
                End If
            Next


            ' Main_Group()

            Try
                'HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
                SqlDataSource_PatientServices.Insert()
            Catch ex As Exception

            End Try
            Payment_Button_Save()
            update_Test_Booking_Status(13)
            'SqlDataSourceUpdate.Update()
            Try
                'SqlDataSourceUpdate.Update()
            Catch ex As Exception

            End Try
            'GridView_Sample_Recieved.DataBind()

            'Response.Write("")
            'Response.Redirect("Pathology_Payment.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Insert Test ")
        End Try
    End Sub

    Sub Payment_Button_Save()
        Try
            Dim RegNo As String = Session("registrationno")
            Dim YearlyNo As Integer = Session("YearlyNo")
            'HiddenFieldTotalAmount.Value = 0 ' CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotalPaid.Value = 0 'CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotal_Discount.Value = 0 'TotalDiscount()
            HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
            Insert_Test_Info()
            SqlDataSourceInsertSub.Insert()
            Update_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
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
            Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE  (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) and Path_Result_Delivery.Fee_paid=0 and Test_Booking_Services.Main_ID=@Main_ID", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationno"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMain_ID.Value)
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
                    mycommand2.Parameters.AddWithValue("@Reg_No", Session("registrationno")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Main_ID(Session("registrationno"), Session("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select max(Main_ID) as [Main_ID] From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Test_Services(ByVal TB_ID As Integer)
        Try
            Dim Status As Integer = 1
            'If RadioButtonList1.SelectedValue = "Sample To Come" Then
            '    Status = 2
            'End If
            Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Test_Booking_Services", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationno"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
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
            Response.Write(ex.Message & " Insert Test Services ")
        End Try
    End Sub
    Protected Sub SaveTests()
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
            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
                Dim sub_command As SqlCommand = New SqlCommand("Insert_Investigation_Order_sub", con)
                'Dim description As Label = GridViewTest_Assign.Rows(i).FindControl("Label_Description")
                Dim description As TextBox = GridViewTest_Assign.Rows(i).FindControl("TextBox_Description")
                Dim testtype As HiddenField = GridViewTest_Assign.Rows(i).FindControl("HiddenField3")
                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(i).FindControl("CheckBox_Is_Inside_Hospital")

                sub_command.CommandType = CommandType.StoredProcedure
                sub_command.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
                sub_command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                sub_command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
                sub_command.Parameters.AddWithValue("@Investigation_Order_ID", main_id)
                sub_command.Parameters.AddWithValue("@TestType_ID", testtype.Value)
                sub_command.Parameters.AddWithValue("@Description", description.Text)
                sub_command.Parameters.AddWithValue("@Status", "New")
                sub_command.Parameters.AddWithValue("@EmpID", Session("emp_id"))
                sub_command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
                sub_command.Parameters.AddWithValue("@Dept_Id", Session("dept_id"))
                sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)
                sub_command.Parameters.Add("@PS_ID", SqlDbType.BigInt)
                sub_command.Parameters("@PS_ID").Direction = ParameterDirection.Output
                sub_command.ExecuteNonQuery()
            Next
            con.Close()
            Main_Group()

            ' ds.Tables("PatientTest").Clear()
            GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
            GridViewTest_Assign.DataBind()
            CheckBoxList_LabTest.DataBind()
            DataList_InvestigationOrderMain.DataBind()
            GridView1.DataBind()


        Catch ex As Exception
            lblMsg.Text = "some error occurred"
            lblMsg.ForeColor = Drawing.Color.Red
        End Try

    End Sub
    'Protected Sub Button_OK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Pnl_OK.Click
    '    If IS_Code_Matched(Session("emp_id"), TextBox_Prescription_Code.Text.Trim) Then
    '        Try
    '            Dim constring As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    '            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    '            Dim command As SqlCommand = New SqlCommand("Insert_Investigation_Order_Main", con)
    '            command.CommandType = CommandType.StoredProcedure
    '            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
    '            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))


    '            'If Get_Type(Session("YearlyNo")) = "OPD" Then
    '            '    command.Parameters.AddWithValue("@Status", 1)

    '            'Else
    '            command.Parameters.AddWithValue("@Status", 11)
    '            '                End If

    '            command.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
    '            command.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
    '            command.Parameters.AddWithValue("@DeptId", Session("dept_id"))
    '            command.Parameters.AddWithValue("@Clinical_Information", TextBoxDescription.Text)

    '            command.Parameters.Add("@Main_Id", SqlDbType.Int)
    '            command.Parameters("@Main_Id").Direction = ParameterDirection.Output
    '            con.Open()
    '            command.ExecuteNonQuery()

    '            Dim main_id As Integer = command.Parameters("@Main_Id").Value
    '            HiddenField_Order_ID.Value = main_id
    '            For i As Integer = 0 To GridViewTest_Assign.Rows.Count - 1
    '                Dim sub_command As SqlCommand = New SqlCommand("Insert_Investigation_Order_sub", con)
    '                'Dim description As Label = GridViewTest_Assign.Rows(i).FindControl("Label_Description")
    '                Dim description As TextBox = GridViewTest_Assign.Rows(i).FindControl("TextBox_Description")
    '                Dim testtype As HiddenField = GridViewTest_Assign.Rows(i).FindControl("HiddenField3")
    '                Dim CheckBox_Is_Inside_Hospital As CheckBox = GridViewTest_Assign.Rows(i).FindControl("CheckBox_Is_Inside_Hospital")

    '                sub_command.CommandType = CommandType.StoredProcedure
    '                sub_command.Parameters.AddWithValue("@TB_ID", GridViewTest_Assign.Rows(i).Cells(1).Text)
    '                sub_command.Parameters.AddWithValue("@Description", description.Text)
    '                sub_command.Parameters.AddWithValue("@TestType_ID", testtype.Value)
    '                sub_command.Parameters.AddWithValue("@Status", "New")
    '                sub_command.Parameters.AddWithValue("@Investigation_Order_ID", main_id)
    '                sub_command.Parameters.AddWithValue("@Is_Inside_Hospital", CheckBox_Is_Inside_Hospital.Checked)
    '                sub_command.ExecuteNonQuery()
    '            Next
    '            con.Close()
    '            Main_Group()



    '            Label_MSG.Text = ""
    '            Button_Pnl_OK.Visible = False
    '            TextBox_Prescription_Code.Visible = False
    '            Label_Lbl.Visible = False
    '            GridView_Tests_For_Confirmation.DataSource = Session("PatientTest")
    '            GridView_Tests_For_Confirmation.DataBind()
    '            GridView_Tests_For_Confirmation.Visible = True
    '            ds.Tables("PatientTest").Clear()
    '            GridViewTest_Assign.DataSource = ds.Tables("PatientTest")
    '            GridViewTest_Assign.DataBind()
    '            GridView1.DataBind()
    '            CheckBoxList_LabTest.DataBind()
    '            DataList_InvestigationOrderMain.DataBind()
    '            'If Get_Type(Session("YearlyNo")) = "OPD" Then
    '            '    Insert_For_Payment()
    '            'End If


    '        Catch ex As Exception
    '            Response.Write(ex.Message & " Insert Test ")
    '        End Try

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



    Protected Sub Button_Pnl_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        TextBox_TBNAme.Text = ""
        Panel_Register_Test.Visible = False

    End Sub




    Protected Sub Button_Save_TestBooking_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        SqlDataSource_MG_Name.Insert()
        TextBox_TBNAme.Text = ""
        Panel_Register_Test.Visible = False
        HiddenField_MG_ID.Value = DropDownList_MGName.SelectedValue
        CheckBoxList_LabTest.DataBind()
        CheckBoxList_LabTest.Items(0).Selected = True
        Book_Path_Test()
    End Sub

    Protected Sub DataList_InvestigationOrderMain_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Response.Redirect("Pathology_Test_Report.aspx?Inv_Order_ID=" + DataList_InvestigationOrderMain.SelectedValue.ToString())
    End Sub

    Protected Sub gvdData_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvdData.RowDataBound


        'Dim HiddenField_TGID As HiddenField = DataList_Radiology.Items(i).FindControl("HiddenField_TGID")
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim datalistSub As DataList = e.Row.FindControl("DataListPreviousTestOfPathology_Sub")

            Dim Label_Date As Label = e.Row.FindControl("Label_Date")
            Dim regno As String = Session("RegistrationNo").ToString()
            Dim yearlyNo As HiddenField = e.Row.FindControl("yearlyNO")
            Dim dbmanager As New DbManager

            Dim dt As DataTable = dbmanager.ExecuteDataTable("previousTestForPathology", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("@regno", regno.Trim()), New SqlParameter("@date", Label_Date.Text),
                                                         New SqlParameter("@yearlyNO", yearlyNo.Value.Trim())})
            datalistSub.DataSource = dt
            datalistSub.DataBind()
        End If

    End Sub

    Protected Sub gvdData_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        gvdData.PageIndex = e.NewPageIndex
        gvdData.DataBind()
    End Sub


    Protected Sub TB_NameLabel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim dbmanager As New DbManager
        Dim linkbtn As LinkButton = sender


        Dim regno As String = Session("RegistrationNo").ToString()
        Dim dt As DataTable = dbmanager.ExecuteDataTable("Pathology_GetTestResultByTestIdAndPayID", "Pathology2ConnectionString",
                                                         New SqlParameter() {New SqlParameter("@RegNo", regno.Trim()), New SqlParameter("@testID", Convert.ToInt32(linkbtn.ToolTip.ToString().Trim())),
                                                         New SqlParameter("@payid", linkbtn.CommandName.Trim())})

        If dt.Rows.Count > 0 Then
            repater.DataSource = dt
            repater.DataBind()
            panel.Visible = True
            repater.Visible = True
        Else
            TestStatus.Visible = True
            panel.Visible = True
            repater.Visible = False
        End If


    End Sub

    Protected Sub lnkbtnReport_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = CType(sender, LinkButton)
        Dim row As GridViewRow = CType(lnk.NamingContainer, GridViewRow)

        Dim regNo As HiddenField = row.FindControl("hfRegNo")
        Dim IOrderId As HiddenField = row.FindControl("hfInvestigation_Order_ID")
        Dim TBId As HiddenField = row.FindControl("hfTBId")
        Dim statusId As HiddenField = row.FindControl("hfStatusId")
        Dim status As String = row.Cells(6).Text.ToString()
        If statusId.Value <> "" Then


            Dim url As String = "../Pathology/Patient_Result_Report.aspx?RegNo=" + regNo.Value + "&YearlyNo=" + lnk.CommandName + "&TGID=" + row.Cells(0).Text.ToString() + "&Main_ID=" + lnk.CommandArgument + "&Sample_No=" + row.Cells(5).Text.ToString() + "&Status=" + statusId.Value

            Dim sb As New StringBuilder()

            sb.Append("<script type = 'text/javascript'>")

            sb.Append("window.open('")

            sb.Append(url)

            sb.Append("');")

            sb.Append("</script>")

            ClientScript.RegisterStartupScript(Me.GetType(), "script", sb.ToString())

            Dim constring As String = ""
            Dim con As SqlConnection
            Dim mycommand As SqlCommand

            Try
                constring = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
                con = New System.Data.SqlClient.SqlConnection(constring)
                mycommand = New System.Data.SqlClient.SqlCommand("if exists(select * from Path_PatientTestResult_Main where Main_ID = @Main_ID) select 'true' else select 'false' AS val", con)
                mycommand.CommandType = Data.CommandType.Text
                mycommand.Parameters.AddWithValue("@Main_ID", lnk.CommandArgument)
                Dim dr As SqlDataReader
                con.Open()
                dr = mycommand.ExecuteReader()
                While dr.Read
                    status = dr(0).ToString()
                End While
                dr.Close()
                con.Close()


                If status = "true" Then
                    constring = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    con = New System.Data.SqlClient.SqlConnection(constring)
                    mycommand = New System.Data.SqlClient.SqlCommand("update Investigation_Order_Sub set IsSeenbyDoctor = @status where Investigation_Order_ID = @Investigation_Order_ID And TB_ID = @TB_ID", con)
                    mycommand.CommandType = Data.CommandType.Text
                    mycommand.Parameters.AddWithValue("@Investigation_Order_ID", IOrderId.Value)
                    mycommand.Parameters.AddWithValue("@TB_ID", TBId.Value)
                    mycommand.Parameters.AddWithValue("@status", status)

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    con.Close()
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try

        End If
    End Sub

End Class






