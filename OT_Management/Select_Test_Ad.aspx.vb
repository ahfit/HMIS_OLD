Imports System.Data
Imports System.Data.SqlClient
Partial Class Select_Test_Advance
    Inherits System.Web.UI.Page

    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString

    Protected Sub btnAdd_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        new_Values()
        DataList_For_View.DataBind()
    End Sub
    Protected Sub DataList1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.PreRender
        Try
            'DataList1.Enabled = False
            For i As Integer = 0 To DataList1.Items.Count - 1
                Dim Hid As HiddenField = DataList1.Items(i).FindControl("Hiddenfield1")
                Dim DL As DataList = DataList1.Items(i).FindControl("DataList2")
                DL.Attributes.Add("onClick", "return check(this)")
                HiddenField3.Value = Hid.Value
                DL.DataBind()
                'check_Elements(CBL)
                ' CBL.DataBind()
                For j As Integer = 0 To DL.Items.Count - 1
                    Dim chk As CheckBox = DL.Items(j).Controls(1)
                    If check_Elements(chk.ValidationGroup) = True Then
                        chk.Checked = True
                    End If
                Next

            Next
            ' DataList1.Enabled = True
        Catch ex As Exception
            Label4.Text = ex.Message & "Datalist1 Prerender"
        End Try
    End Sub

    Sub new_Values()
        Try
            For i As Integer = 0 To DataList1.Items.Count - 1
                Dim Hid As HiddenField = DataList1.Items(i).FindControl("Hiddenfield1")
                Dim CBL As CheckBoxList = DataList1.Items(i).FindControl("Checkboxlist1")
                HiddenField3.Value = Hid.Value
                For j As Integer = 0 To CBL.Items.Count - 1
                    If CBL.Items(j).Selected = True Then
                        ' Response.Write(" CBL " & CBL.Items(j).Value.ToString) ' Select_Test_Advance
                        Insert_Values(CBL.Items(j).Value.ToString)
                    End If
                Next
            Next
        Catch ex As Exception
            Label4.Text = ex.Message & "New Values"
        End Try
    End Sub

    Sub Insert_Values(ByVal TSGID As Integer)
        Try
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Test_Advance", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@TSGID", TSGID)
            param = mycommand.Parameters.AddWithValue("@DateTime", Date.Now)
            param = mycommand.Parameters.AddWithValue("@DoctorID", "3")
            param = mycommand.Parameters.AddWithValue("@EMPID", Session("emp_id"))
            param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            'For i As Integer = 0 To DataList1.Items.Count - 1
            '    Dim CBL As CheckBoxList = DataList1.Items(i).FindControl("Checkboxlist1")
            '    CBL.DataBind()
            '    check_Elements(CBL)
            'Next
        Catch ex As Exception
            Label4.Text = ex.Message & "Insert Values"
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Session.Add("registrationNo", "LGH/051220090002")
            'Session.Add("YearlyNo", "201165")
            'Session.Add("emp_id", "203")
            'Session.Add("dept_id", "35")
            loginvalidate(Session("emp_id"), Session("dept_id"))
            Label3.Text = ""
            Dim ClassObj As New PatientBacisInfo
            If Page.IsPostBack = False Then
                TextBox_Sample_number.Text = Session("YearlyNo")
            End If
            Try
                If Session("YearlyNo").ToString Is Nothing Or Session("RegistrationNo").ToString Is Nothing Then
                    Response.Redirect("Login.aspx")
                End If
            Catch ex As Exception
                Response.Redirect("Login.aspx")
            End Try
            LinkButton_View_Test.Attributes.Add("onClick", "return Check_View_Test()")
            Button_Element_Save.Attributes.Add("onClick", "return Uncheck()") 'Button_Element_Cancel
            Button_Element_Cancel.Attributes.Add("onClick", "return Uncheck()")
            ClassObj.PatientInfo(Session("YearlyNo"), Session("registrationNo"), labelPName, LabelPAge, LabelPSex, LabelCNIC, LabelRegNo, LabelDOB)
            ClassObj.PatientInfo_Ward_Refferal(Session("YearlyNo"), Session("registrationNo"), labelWardReferal)
            Label_YearlyNo.Text = Session("YearlyNo")
            Session.Add("TestStatus", Session("Teststatus"))
            Session.Timeout = 60
            'If Page.IsPostBack = False Then
            Main_Group()
            'End If
        Catch ex As Exception
            Label4.Text = ex.Message & "Page Load"
        End Try

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("login.aspx")
        End If
    End Sub

    Protected Sub CheckBoxList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            For i As Integer = 0 To DataList1.Items.Count - 1
                Dim Hid As HiddenField = DataList1.Items(i).FindControl("Hiddenfield1")
                Dim CBL As CheckBoxList = DataList1.Items(i).FindControl("Checkboxlist1")
                HiddenField3.Value = Hid.Value
                For j As Integer = 0 To CBL.Items.Count - 1
                    If CBL.Items(j).Selected = True Then
                        'Response.Write(" CBL " & CBL.Items(j).Value.ToString) ' Select_Test_Advance
                        Panel1.Visible = True
                        'Insert_Values(CBL.Items(j).Value.ToString)
                        HiddenField_Test.Value = CBL.Items(j).Value.ToString
                    End If
                Next
            Next
            Dim CBL2 As CheckBoxList = Panel1.FindControl("CheckBoxList2")
            checkTests(CBL2)
        Catch ex As Exception
            Label4.Text = ex.Message & "CheckBoxList1"
        End Try
    End Sub

    Protected Sub Button_Element_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Element_Save.Click
        Dim CBL2 As CheckBoxList = Panel1.FindControl("CheckBoxList2")
        For i As Integer = 0 To CBL2.Items.Count - 1
            If CBL2.Items(i).Selected = True Then
                Insert_Element_values(CBL2.Items(i).Value)
                'Label4.Text = CBL2.Items(i).Value & "  d  "
            Else
                Delete_Element_Values(CBL2.Items(i).Value)
            End If
        Next
        DataList_For_View.DataBind()
        Main_Group()
        Panel1.Visible = False
    End Sub

    Protected Sub Button_Element_Cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Element_Cancel.Click
        Panel1.Visible = False
    End Sub
    Sub Delete_Element_Values(ByVal TID As Integer)
        Dim abc As Integer
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("test_delete", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
        param = mycommand.Parameters.AddWithValue("@TID", TID)
        param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
        Try
            mycommand.Connection.Open()
            abc = CType(mycommand.ExecuteScalar, Integer)
            mycommand.Connection.Close()
        Catch ex As Exception
            Label1.Text = ex.Message
        End Try
    End Sub
    Sub Insert_Element_values(ByVal TID As Integer)
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("test_Insert", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
        param = mycommand.Parameters.AddWithValue("@TID", TID)
        param = mycommand.Parameters.AddWithValue("@DateTime", Date.Now)
        param = mycommand.Parameters.AddWithValue("@DoctorID", "3")
        param = mycommand.Parameters.AddWithValue("@EMPID", Session("emp_id"))
        param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
        Try
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            'For i As Integer = 0 To DataList1.Items.Count - 1
            '    Dim CBL As CheckBoxList = DataList1.Items(i).FindControl("Checkboxlist1")
            '    CBL.DataBind()
            '    check_Elements(CBL)
            'Next
        Catch ex As Exception
            Label4.Text = ex.Message & "Insert_Element_Values"
        End Try
    End Sub
    Protected Sub Button_Check_ALL_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim CBL2 As CheckBoxList = Panel1.FindControl("CheckBoxList2")
        For i As Integer = 0 To CBL2.Items.Count - 1
            CBL2.Items(i).Selected = True
        Next
    End Sub
    Sub checkTests(ByVal checkbox As CheckBoxList)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select tid From PatientsLabTest Where ((PayID = @payid) and (RegNo = @regno) and (Status = 'Not Done'))", con1)
            mycommand1.CommandType = Data.CommandType.Text
            Dim param1 As System.Data.SqlClient.SqlParameter
            param1 = mycommand1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            param1 = mycommand1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
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
            Label4.Text = ex.Message & "Check Tests"
        End Try
    End Sub
    Function check_Elements(ByVal Check As Integer) As Boolean
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("AlreadY_Assign_Test_Sub_Group", con1)
            mycommand1.CommandType = Data.CommandType.StoredProcedure
            Dim param1 As System.Data.SqlClient.SqlParameter
            param1 = mycommand1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            param1 = mycommand1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            param1 = mycommand1.Parameters.AddWithValue("@TSGID", Check)
            mycommand1.Connection.Open()
            Dim SG As Integer = mycommand1.ExecuteScalar()
            mycommand1.Connection.Close()
            If SG <> 0 Then
                Return True
            ElseIf SG = 0 Then
                Return False
            End If
        Catch ex As Exception
            Label4.Text = ex.Message
        End Try
    End Function

    Protected Sub DataList_For_View_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_For_View.PreRender
        For i As Integer = 0 To DataList_For_View.Items.Count - 1
            Dim Hid As HiddenField = DataList_For_View.Items(i).FindControl("HiddenField4")
            Dim Label_Test_Name As Label = DataList_For_View.Items(i).FindControl("Label_Test")
            Dim Label_Test_Group_Name As Label = DataList_For_View.Items(i).FindControl("TGNameLabel")
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("SELECT Test.TestName FROM  PatientsLabTest INNER JOIN Test ON PatientsLabTest.TID = Test.TID INNER JOIN TestSubGroup ON Test.TSGID = TestSubGroup.TSGID WHERE (TestSubGroup.TSGID = @TSGID) and (PayID=@PayID) and (RegNo=@RegNo)", con1)
            mycommand1.CommandType = Data.CommandType.Text
            Dim param1 As System.Data.SqlClient.SqlParameter
            param1 = mycommand1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            param1 = mycommand1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            param1 = mycommand1.Parameters.AddWithValue("@TSGID", Hid.Value)
            mycommand1.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand1
            da.Fill(ds, "PatientsLabTest")
            Label_Test_Name.Text = ""
            For j As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Label_Test_Name.Text = ds.Tables(0).Rows(j).Item(0).ToString & " , " & Label_Test_Name.Text
            Next
            If i <> 0 Then
                Dim lbl As Label = DataList_For_View.Items(i - 1).FindControl("TGNameLabel")
                If lbl.Text = Label_Test_Group_Name.Text Then
                    Label_Test_Group_Name.Text = ""
                End If
            End If
            mycommand1.Connection.Close()
        Next
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        HiddenField_Test.Value = sender.validationgroup
        sender.checked = True
        Panel1.Visible = True
        Dim CBL2 As CheckBoxList = Panel1.FindControl("CheckBoxList2")
        checkTests(CBL2)
    End Sub
    Sub Main_Group()
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
End Class '
