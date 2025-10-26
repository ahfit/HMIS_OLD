
Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class Path_Test
    Inherits System.Web.UI.Page
    Dim count As Integer = 0
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = "LGH/251120060019"
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim statuscmo As String


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


    ' on selected index changed All Test of The main Group are displayed 
    ' Protected Sub GVTSGName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GVTSGName.SelectedIndexChanged
    ' '' '' '' '' '' '' '' '' ''CheckBoxListForTestSG.Visible = False
    ' '' '' '' '' '' '' '' '' ''CheckBoxListTest.Visible = True
    ' '' '' '' '' '' '' '' '' ''HiddenFieldTestSubGroup.Value = GVTSGName.SelectedValue
    ' '' '' '' '' '' '' '' '' ''Label2.Text = ""
    ' '' '' '' '' '' '' '' '' ''CheckBoxListTest.Focus()
    ' '' '' '' '' '' '' '' '' ''Try
    ' '' '' '' '' '' '' '' '' ''    Dim hid_GNAme As HiddenField = GVTSGName.Rows.Item(GVTSGName.SelectedIndex).FindControl("HiddenField_GNAme")
    ' '' '' '' '' '' '' '' '' ''    HiddenField2.Value = hid_GNAme.Value
    ' '' '' '' '' '' '' '' '' ''    'labelGName Display The Name of the Main test Group that are selected 
    ' '' '' '' '' '' '' '' '' ''    labelGName.Text = hid_GNAme.Value
    ' '' '' '' '' '' '' '' '' ''    BTNcheckAll.Visible = True
    ' '' '' '' '' '' '' '' '' ''    btnAdd.Visible = True
    ' '' '' '' '' '' '' '' '' ''    BtnUncheckAll.Visible = True
    ' '' '' '' '' '' '' '' '' ''Catch ex As Exception
    ' '' '' '' '' '' '' '' '' ''    labelGName.Text = ""
    ' '' '' '' '' '' '' '' '' ''End Try
    '' '' '' '' '' '' '' '' '' '' call the checkTest function for the checkboxlistTest 
    ' '' '' '' '' '' '' '' '' ''checkTests(CheckBoxListTest)
    'End Sub
    ' This function which test are already recommended to the patient and dispalyed The Checked item of the checkboxlist
    ' 
    Sub checkTests(ByVal checkbox As CheckBoxList)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Admin_Radiology_ConnStr").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select tid From PatientsLabTest Where ((PayID = @payid) and (RegNo = @regno) and (Status = 'Not Done'))", con1)
            mycommand1.CommandType = Data.CommandType.Text
            Dim param1 As System.Data.SqlClient.SqlParameter
            param1 = mycommand1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            'param1.Value = "196985" 'Session("BMIPayID")
            param1 = mycommand1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            'param1 = mycommand1.Parameters.Add("@tid", Data.SqlDbType.VarChar)
            'param1.Value = "29"
            mycommand1.Connection.Open()
            Dim b As Integer
            Dim sqlreader As SqlDataReader = mycommand1.ExecuteReader
            checkbox.DataBind()

            While (sqlreader.Read())
                For b = 0 To checkbox.Items.Count - 1
                    If (sqlreader.Item(0) = checkbox.Items(b).Value) Then
                        checkbox.Items(b).Selected = True
                    End If
                Next
            End While

            mycommand1.Connection.Close()

        Catch ex As Exception

        End Try


    End Sub
    ' this function check alll the items of the selected list one by one 
    ' Which items are checked the Function Insert the Values in the database 
    ' Which Items of the selected checkboxlist are Unchecked That are Delete From the Database 
    Sub Checkboxlistcheck(ByVal checkboxlist As CheckBoxList)
        Try
            Dim b As Integer
            Dim abc As String
            Dim array(checkboxlist.Items.Count - 1) As String
            Label3.Text = ""
            For b = 0 To checkboxlist.Items.Count - 1
                If checkboxlist.Items(b).Selected = True Then
                    ' if condition use to Inser t the Values in the  db
                    array(b) = checkboxlist.Items(b).Value
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("test_Insert", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure
                    Test_Counter = Test_Counter + 1
                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@TID", checkboxlist.Items(b).Value)
                    param = mycommand.Parameters.AddWithValue("@DateTime", Date.Now)
                    param = mycommand.Parameters.AddWithValue("@DoctorID", "3")
                    param = mycommand.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    param = mycommand.Parameters.AddWithValue("@Biopsy_description", "")
                    Try
                        mycommand.Connection.Open()
                        mycommand.ExecuteNonQuery()
                        mycommand.Connection.Close()
                    Catch ex As Exception
                        Label1.Text = ex.Message
                    End Try
                Else
                    ' Else Condition is used to delete the Values  that are Unchecked 
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("test_delete", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure
                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@TID", checkboxlist.Items(b).Value)
                    'Label3.Text = checkboxlist.Items(b).Value & " jkljklj " & Label3.Text
                    param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    Try
                        mycommand.Connection.Open()
                        abc = CType(mycommand.ExecuteScalar, Integer)
                        mycommand.Connection.Close()

                    Catch ex As Exception
                        HttpContext.Current.Response.Write(ex.Message)
                        Label1.Text = ex.Message
                    End Try
                End If

            Next
        Catch ex As Exception
            Label1.Text = ex.Message
        End Try
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        'inserts tests for patients in database
        ' check that which checboxlist is active and send the value to checkboxlistcheck function.

        Dim Counter As Integer = 0
        For i As Integer = 0 To GridGorSubGroup.Rows.Count - 1
            HiddenField_for_test.Value = ""
            Dim check As CheckBox = GridGorSubGroup.Rows(i).FindControl("CheckBox1")
            Dim Hid_TGSID As HiddenField = GridGorSubGroup.Rows(i).FindControl("HiddenField1")
            If check.Checked = True Then
                Counter = 1
                ' Label3.Text += Hid_TGSID.Value
                HiddenField_for_test.Value = Hid_TGSID.Value
                'Label3.Text = Session("RegistrationNo") & " dfsd " & Session("YearlyNo")
                CheckBoxListForTestSG.DataBind()
                CheckAll(CheckBoxListForTestSG)
                Checkboxlistcheck(CheckBoxListForTestSG)
                check.Checked = False
            Else
            End If
        Next
        If Counter = 0 Then
            If CheckBoxListTest.Visible = True Then
                Checkboxlistcheck(CheckBoxListTest)
            Else
                CheckBoxListForTestSG.DataBind()
                Checkboxlistcheck(CheckBoxListForTestSG)
            End If
        End If
        'If CheckBoxListTest.Visible = True Then
        '    Checkboxlistcheck(CheckBoxListTest)
        'Else
        '    Checkboxlistcheck(CheckBoxListForTestSG)
        'End If

        'Response.Redirect("main_services.aspx")
        If Test_Counter <> 0 Then
            Button_Move_Next.Visible = True
            'Button6.Visible = True
        End If
        ' Insert_Values()
        Main_Group()
    End Sub

    Protected Sub BTNcheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNcheckAll.Click
        If CheckBoxListTest.Visible = True Then
            CheckAll(CheckBoxListTest)
        Else
            CheckAll(CheckBoxListForTestSG)
        End If

    End Sub
    Protected Sub BtnUncheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnUncheckAll.Click
        If CheckBoxListTest.Visible = True Then
            UncheckAll(CheckBoxListTest)
        Else
            UncheckAll(CheckBoxListForTestSG)
        End If

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("login.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim user_authen As New User_page_Authentication
        Session("Module_id") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        loginvalidate(Session("emp_id"), Session("dept_id"))
        Label3.Text = ""
        'Dim ClassObj As New PatientBacisInfo
        If Page.IsPostBack = False Then
            Select_Sample_No()
            CheckBoxListForTestSG.Visible = False
            CheckBoxListTest.Visible = True
            HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
            Label2.Text = ""
            CheckBoxListTest.Focus()
            'labelGName.Text = DropDownList2.SelectedItem.Text
        End If
        Try

            If Session("YearlyNo").ToString Is Nothing Or Session("RegistrationNo").ToString Is Nothing Then
            Else
                Session.Add("YearlyNo", Request.QueryString("YearlyNo").ToString)
                Session.Add("RegistrationNo", Request.QueryString("RegNo").ToString)
                HiddenFieldRegNo.Value = Session("registrationNo")
                HiddenFieldYearlyNo.Value = Session("YearlyNo")
                'Response.Redirect("Login.aspx")
            End If
        Catch ex As Exception
            'Response.Redirect("Login.aspx")
        End Try


        'Try
        '    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        '    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        '    Dim cmd1 As String = "select max(payid) from payment where regno = @regno"
        '    Dim mycommand1 As New System.Data.SqlClient.SqlCommand(cmd1, con)
        '    mycommand1.CommandType = Data.CommandType.Text
        '    mycommand1.Parameters.AddWithValue("@regno", Session("registrationNo")) 'HiddenFieldRegNo.Value)
        '    mycommand1.Connection.Open()
        '    Dim sreader1 As SqlDataReader = mycommand1.ExecuteReader
        '    If sreader1.Read = True Then
        '        Session("YearlyNo") = sreader1.Item(0).ToString
        '    End If
        'Catch ex As Exception

        'End Try
        'ClassObj.PatientInfo(Session("YearlyNo"), Session("registrationNo"), labelPName, LabelPAge, LabelPSex, LabelCNIC, LabelRegNo, LabelDOB)
        'ClassObj.PatientInfo_Ward_Refferal(Session("YearlyNo"), Session("registrationNo"), labelWardReferal)
        'Label_YearlyNo.Text = Session("YearlyNo")
        datafields()
        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
        Main_Group()
        Button6.Attributes.Add("onclick", "return OpenNewPage()")
    End Sub
    Sub datafields()
        Dim b As Integer
        b = isVitalenter()
        If (b = 0) Then

        Else
            populatevalue()

        End If
    End Sub

    Function isVitalenter() As Integer
        'checks vitals are entered
        Dim abc As Integer
        Dim resultcount As Integer
        abc = 0
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim abcd As String = "isExistBMInformation"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(abcd, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = abcd
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.Add("@RecordExist", Data.SqlDbType.Int) ', hiddenregno.Value)
            mycommand.Parameters("@RecordExist").Direction = Data.ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            resultcount = mycommand.Parameters("@RecordExist").Value
            con.Close()
        Catch ex As Exception
        End Try
        Return resultcount
    End Function
    ' This function popullate the information about the Patient displayed at the right side of the page 

    Sub populatevalue()
        'Try
        'Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        ' ''Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        ' ''            Dim procedurename As String = "pt_basic_info"
        ''Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
        ''mycommand.CommandType = Data.CommandType.StoredProcedure
        ''mycommand.CommandText = procedurename
        ''mycommand.Parameters.AddWithValue("@PayId", Session("YearlyNo"))
        ''mycommand.Parameters.AddWithValue("@regno", Session("registrationNo"))
        ''con.Open()
        ''Dim da As New SqlDataAdapter
        ''Dim ds As New DataSet
        ''da.SelectCommand = mycommand
        ''da.Fill(ds, mycommand.ExecuteNonQuery)
        '            ds.Tables(0).Rows.Count()
        'LabelBP.Text = ds.Tables(0).Rows(0).Item(1).ToString
        'labelPName.Text = ds.Tables(0).Rows(0).Item(1).ToString
        'LabelRelation.Text = ds.Tables(0).Rows(0).Item(2).ToString
        ' LabelRName.Text = ds.Tables(0).Rows(0).Item(3).ToString
        ' LabelPAge.Text = ds.Tables(0).Rows(0).Item(4).ToString
        'LabelAge.Text = ds.Tables(0).Rows(0).Item(4).ToString
        ' LabelPType.Text = ds.Tables(0).Rows(0).Item(5).ToString
        '  LabelBP.Text = ds.Tables(0).Rows(0).Item(6).ToString
        ' LabelBPLow.Text = ds.Tables(0).Rows(0).Item(7).ToString
        ' LabelPulse.Text = ds.Tables(0).Rows(0).Item(8).ToString
        ' LabelRR.Text = ds.Tables(0).Rows(0).Item(9).ToString
        '  LabelTemp.Text = ds.Tables(0).Rows(0).Item(10).ToString
        ' LabelAge.Text = ds.Tables(0).Rows(0).Item(16).ToString
        'con.Close()
        'Catch ex As Exception
        '    ' Response.Write(ex.Message)
        'End Try
    End Sub
    ' This function check all the items of the selected chechboxlist.

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

    'Protected Sub RadioButtonListTestSubgroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListTestSubgroup.SelectedIndexChanged
    '    checkTests(CheckBoxListForTestSG)
    '    CheckBoxListForTestSG.Visible = True
    '    CheckBoxListTest.Visible = False
    '    Try
    '        labelGName.Text = GVTSGName.Rows.Item(GVTSGName.SelectedIndex).Cells.Item(1).Text & "(" & RadioButtonListTestSubgroup.SelectedItem.Text & ")"
    '    Catch ex As Exception
    '        labelGName.Text = ""
    '    End Try
    'End Sub

    'Protected Sub ImageButtonback_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonback.Click
    '  Try

    'Response.Redirect("EMOPatientInfo.aspx?a=a&b=b&c=c")
    '   If (statuscmo <> "") Then
    '     Session.Add("TestStatus", statuscmo)
    '   End If
    ' Response.Redirect("EMOPatientInfo.aspx")
    '  Catch ex As Exception

    '   End Try
    '   Response.Redirect("EMOPatientInfo.aspx")
    '  End Sub

    'Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
    ' Response.Redirect(Session("mainpage"))
    ' End Sub

    ' Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
    '   Session.RemoveAll()
    '   Response.Redirect("Login.aspx")
    ' End Sub



    Protected Sub Button_Move_Next_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Move_Next.Click
        Try
            Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
            HiddenField_Sample_collection.Value = SDate
            If DropDownList1.SelectedValue = "Days" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
            ElseIf DropDownList1.SelectedValue = "Hours" Then
                HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
            End If
            Insert_Values()
            Response.Redirect("Pathology_Test_Fee_Payment.aspx")
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Sub Insert_Values()
        Dim SDate As Date = WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        HiddenField_Sample_collection.Value = SDate
        If DropDownList1.SelectedValue = "Days" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Day, CInt(TextBox_next_Date.Text), SDate)
        ElseIf DropDownList1.SelectedValue = "Hours" Then
            HiddenField_Report_Date.Value = DateAdd(DateInterval.Hour, CInt(TextBox_next_Date.Text), SDate)
        End If
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
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub
    Sub Select_Sample_No()
        ' ''Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        ' ''Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT @identity1 = isnull(Max(Sample_No),0) FROM MRI_Save_Patient_Next_App", con)
        ' ''mycommand.CommandType = Data.CommandType.Text
        ' ''Dim param As System.Data.SqlClient.SqlParameter
        ' ''param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        ' ''mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        ' ''mycommand.Connection.Open()
        ' ''mycommand.ExecuteNonQuery()
        TextBox_Sample_number.Text = Session("YearlyNo") '(mycommand.Parameters("@identity1").Value) + 1
        ''' mycommand.Connection.Close()
    End Sub


    'Protected Sub GridGorSubGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GVTSGName.SelectedIndexChanged
    '    checkTests(CheckBoxListForTestSG)
    '    CheckBoxListForTestSG.Visible = True
    '    CheckBoxListTest.Visible = False
    '    Try
    '        ' labelGName.Text = GVTSGName.Rows.Item(GVTSGName.SelectedIndex).Cells.Item(1).Text & "(" & RadioButtonListTestSubgroup.SelectedItem.Text & ")"
    '    Catch ex As Exception
    '        labelGName.Text = ""
    '    End Try
    'End Sub

    Protected Sub GridGorSubGroup_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs)
        HiddenField_for_test.Value = GridGorSubGroup.SelectedValue
        CheckBoxListForTestSG.DataBind()
        checkTests(CheckBoxListForTestSG)
        CheckBoxListForTestSG.Visible = True
        CheckBoxListTest.Visible = False
        ' Label3.Text = GridGorSubGroup.SelectedValue
        Try
            Dim Hid_SGNAME As HiddenField = GridGorSubGroup.Rows.Item(GridGorSubGroup.SelectedIndex).FindControl("HiddenField_SG_Name")
            Dim Hid_GNAME As HiddenField = GridGorSubGroup.Rows.Item(GridGorSubGroup.SelectedIndex).FindControl("HiddenField3")
            labelGName.Text = Hid_GNAME.Value & "(" & Hid_SGNAME.Value & ")"
        Catch ex As Exception
            labelGName.Text = "dddsds" & ex.Message
        End Try
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList2.SelectedIndexChanged
        Try
            If DropDownList2.SelectedItem.Text = "Biopsy" Then
                Response.Redirect("Path_Test_Biopsy.aspx?YearlyNo=" & Request.QueryString("YearlyNo").ToString & "&RegNo=" & Request.QueryString("RegNo").ToString)
            End If
        Catch ex As Exception

        End Try
        CheckBoxListForTestSG.Visible = False
        CheckBoxListTest.Visible = True
        HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue
        Label2.Text = ""
        CheckBoxListTest.Focus()
        Try
            'Dim hid_GNAme As HiddenField = GVTSGName.Rows.Item(GVTSGName.SelectedIndex).FindControl("HiddenField_GNAme")
            HiddenField2.Value = DropDownList2.SelectedItem.Text  'hid_GNAme.Value
            'labelGName Display The Name of the Main test Group that are selected  
            labelGName.Text = HiddenField2.Value 'hid_GNAme.Value
            btnAdd.Visible = True
            BtnUncheckAll.Visible = True
        Catch ex As Exception
            labelGName.Text = ""
        End Try
        ' call the checkTest function for the checkboxlistTest 
        checkTests(CheckBoxListTest)
    End Sub
    Sub Main_Group()
        'Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
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
        'TreeView1.ExpandAll()
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

    Protected Sub TextBox1_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Test_NAme.TextChanged
        CheckBoxListTest.DataBind()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Test_Booking.aspx")
    End Sub
End Class





