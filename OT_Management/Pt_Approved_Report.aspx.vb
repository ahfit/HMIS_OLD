Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_Approved_Report
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim constr As String = ConfigurationManager.ConnectionStrings("Admin_Radiology_ConnStr").ConnectionString
    Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            SqlDataSource_For_DataList.Update()
            SqlDataSource_For_Grid.Update()
            SqlDataSourceupdatestatus.Update()
            'Response.Write(Right(Request.RawUrl, Request.RawUrl.Length - (Request.ApplicationPath.Length - 1)))
            Response.Redirect("Patient_Search.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub Populate_Description(ByVal TGID As Integer)
        Dim Description As String = ""
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT ISNULL(Report, '') AS Report FROM  Path_PatientTestResult_Main WHERE (RegNo = @RegNo) AND (YearlyNo = @YearlyNo) AND (Main_ID = @Main_ID) AND (TGID = @TGID)", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value)
        param = mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMainID.Value)
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.Connection.Open()
        da.SelectCommand = mycommand
        da.Fill(ds)
        mycommand.Connection.Close()
        TextBox_Description.Text = ds.Tables(0).Rows(0).Item("Report").ToString
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(Session("RegistrationNo"))
        Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))

        'Dim obj As New DrawMenu
        'obj.draw_menu(PanelMenu)
        'LabelHeader.Text = obj.Employee_Info() 
        'Page.ClientScript.RegisterStartupScript([GetType], "onload", "<script language ='javascript'>window.document.title='" & obj.Page_Title & "';</script>")
        ' Dim ds As New Pt_Radiology_Test
        ' Dim da As New Pt_Radiology_TestTableAdapters.Pt_Approved_ReportTableAdapter
        'Response.Write(Session("RegistrationNo") & "  " & Session("YearlyNo"))
        'da.Fill(ds.Tables("Pt_Approved_Report"), Session("RegistrationNo"), Session("YearlyNo"))
        Populate_Values()

        loginvalidate(Session("emp_id"), Session("dept_id"))
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("../login.aspx")

            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try

    End Sub
    'Protected Sub DataListMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListMainGroup.SelectedIndexChanged
    '    Response.Write(DataListMainGroup.SelectedValue)
    '    TextBox_Description.Visible = True
    '    Label_Description.Visible = True
    '    Populate_Description(DataListMainGroup.SelectedValue)
    'End Sub

    Protected Sub GridView_Test_Status_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Test_Status.PreRender

        For i As Integer = 0 To GridView_Test_Status.Rows.Count - 1
            Dim chckbox As CheckBox = GridView_Test_Status.Rows(i).FindControl("CheckBox1")
            Dim lbl_sr As Label = GridView_Test_Status.Rows(i).FindControl("Label_Sr")
            lbl_sr.Text = CStr(i + 1) & ". "
            Dim hid_TCID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_TCID")
            'Response.Write(CInt(GridView_Test_Status.Rows(i).Cells(3).Text))
            'Response.End()
            'If CheckValue(hid_TCID.Value, CInt(GridView_Test_Status.Rows(i).Cells(3).Text)) = True Then
            'chckbox.Checked = True
            ''Drawing.Color.Red
            'GridView_Test_Status.Rows(i).Cells(3).ForeColor = Drawing.Color.Red
            'GridView_Test_Status.Rows(i).Cells(3).Font.Bold = True
            'End If
        Next
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
            HiddenFieldGender_ID.Value = reader.Item(0).ToString
        End If
        reader.Close()
        con.Close()
    End Sub

    Function CheckValue(ByVal TCID As Integer, ByVal Value As Integer) As Boolean
        Select_Gender()
        Dim Check As Boolean = False
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT StartValue, EndValue FROM Test_RangeValues WHERE (TCId = @TCId) AND (Gender_ID = @Gender_ID)", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@TCId", TCID)
        command.Parameters.AddWithValue("@Gender_ID", HiddenFieldGender_ID.Value)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            If Value < CInt(reader.Item(0)) Or Value > CInt(reader.Item(1)) Then
                Check = True
            End If
        End If
        Return Check
    End Function

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        For i As Integer = 0 To GridView_Test_Status.Rows.Count - 1
            Dim Check As CheckBox = GridView_Test_Status.Rows(i).FindControl("CheckBox1")
            Dim Hid_TID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_TID")
            Dim Hid_TCID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_TCID")
            Dim Hid_TrmID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_trm_id")
            If Check.Checked = True Then
                Dim Update_Str As String = "UPDATE path_PatientTestResult SET AbNormal = 1 WHERE (trmID = " & Hid_TrmID.Value & ") AND (TId = " & Hid_TID.Value & ") AND (TCId = " & Hid_TCID.Value & ")"
                Update_Result(Update_Str)
            Else
                Dim Update_Str As String = "UPDATE path_PatientTestResult SET AbNormal = 0 WHERE (trmID = " & Hid_TrmID.Value & ") AND (TId = " & Hid_TID.Value & ") AND (TCId = " & Hid_TCID.Value & ")"
                Update_Result(Update_Str)
            End If
        Next
    End Sub

    Protected Sub TextBox2_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        For i As Integer = 0 To GridView_Test_Status.Rows.Count - 1
            Dim txt_Remark As TextBox = GridView_Test_Status.Rows(i).FindControl("TextBox2")
            Dim Hid_TID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_TID")
            Dim Hid_TCID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_TCID")
            Dim Hid_TrmID As HiddenField = GridView_Test_Status.Rows(i).FindControl("HiddenField_trm_id")
            If txt_Remark.Text.Trim <> "" Then
                Dim Update_Str As String = "UPDATE path_PatientTestResult SET Remark = '" & txt_Remark.Text & "' WHERE (trmID = " & Hid_TrmID.Value & ") AND (TId = " & Hid_TID.Value & ") AND (TCId = " & Hid_TCID.Value & ")"
                Update_Result(Update_Str)
            End If
        Next
    End Sub

    Sub Update_Result(ByVal Cmd As String)
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Cmd, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()
    End Sub
    Sub Populate_Values()
        Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select_Pt_approved_report", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        mycommand.Connection.Open()
        da.SelectCommand = mycommand
        da.Fill(ds)
        Label_Init_Date.Text = ds.Tables(0).Rows(0).Item("Collection_Date").ToString
        Label_Reg_No.Text = ENC.Encrypt_Main(ds.Tables(0).Rows(0).Item("Reg_no").ToString, False)
        Label_YearlyNo.Text = ds.Tables(0).Rows(0).Item("Yearly_No").ToString
        Label_Status.Text = ds.Tables(0).Rows(0).Item("Status").ToString
        Label_Suggested_by.Text = ds.Tables(0).Rows(0).Item("Suggested_By").ToString
        Label_Rep_Date.Text = ds.Tables(0).Rows(0).Item("Delivered_Date").ToString
        mycommand.Connection.Close()
    End Sub

    Protected Sub GridViewMain_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewMain.RowUpdating
        Dim Drop As DropDownList = GridViewMain.Rows(e.RowIndex).FindControl("DropDownList_Status")
        Dim Hid_ID As HiddenField = GridViewMain.Rows(e.RowIndex).FindControl("HiddenField_ID")
        HiddenField_Edit_ID.Value = Hid_ID.Value
        HiddenField_Edit_Status.Value = Drop.SelectedValue
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewMain.SelectedIndexChanged
        Dim hid_TGID As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenField6")
        Dim hid_Main_Id As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenField8")
        Dim hid_TBID As HiddenField = GridViewMain.Rows(GridViewMain.SelectedIndex).FindControl("HiddenFieldTBID")
        HiddenField_TGID.Value = hid_TGID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TBID.Value = hid_TBID.Value
        TextBox_Description.Visible = True
        Label_Description.Visible = True
        Populate_Description(GridViewMain.SelectedValue)
    End Sub
End Class