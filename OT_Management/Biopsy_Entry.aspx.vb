Imports System.Data
Imports System.Data.SqlClient
Partial Class Biopsy_Entry
    Inherits System.Web.UI.Page
    Dim TrmID As Integer
    Dim constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            HiddenField_Diagnosis.Value = WebHtmlEditor_Diagnosis.Text
            HiddenField_Gross_Exam.Value = WebHtmlEditor_Gross_Examination.Text
            HiddenField_Microscopic_Exam.Value = WebHtmlEditor_Micro_Exam.Text
            HiddenField_Sepecimen.Value = WebHtmlEditor_Specimen.Text
            InsertMain(HiddenFieldMainID.Value)
            'Response.Write(HiddenField_TB_ID.Value)
            SqlDataSource_Save_Value.Insert()
            HiddenField_Diagnosis.Value = ""
            HiddenField_Gross_Exam.Value = ""
            HiddenField_Microscopic_Exam.Value = ""
            If Patient_Calculate_Test() = True Then
                Button_Final.Visible = True
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub InsertMain(ByVal Max_Main_Id As Integer)
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim procedurename As String = "Path_PatientResult_Main"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            mycommand.Parameters.AddWithValue("@trDate", Date.Now)
            mycommand.Parameters.AddWithValue("@DeptId", Session("Dept_ID"))
            mycommand.Parameters.AddWithValue("@SubDeptId", Session("SubDeptID"))
            mycommand.Parameters.AddWithValue("@Main_ID", Max_Main_Id)
            mycommand.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value) 'Request.QueryString("TestMainGroup").ToString)
            mycommand.Parameters.Add("@trmid", SqlDbType.Int)
            mycommand.Parameters("@trmid").Direction = ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            HiddenFieldTRMID.Value = mycommand.Parameters("@trmid").Value
            'Response.Write(HiddenFieldTRMID.Value)
            'Response.End()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message + "Main")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Add("RegistrationNO", Request.QueryString("RegNo").ToString)
            Session.Add("YearlyNo", Request.QueryString("YearlyNo").ToString)
            'If Patient_Calculate_Test() = True Then
            'Button_Final.Visible = True
            'End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button_Final_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Final.Click
        Try
            SqlDataSource_Update_Status.Update()
            SqlDataSourceUpdate.Update()
            SqlDataSource_UpdateStatus.Update()
            GridView_Test_Status.DataBind()
            If GridView_Test_Status.Rows.Count = 0 Then
                Response.Redirect("Patient_Search.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Function Patient_Calculate_Test() As Boolean
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("PT_Show_All_Test_Done", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
        mycommand.Parameters.Add("@Value", SqlDbType.Bit)
        mycommand.Parameters("@Value").Direction = ParameterDirection.Output
        con.Open()
        mycommand.ExecuteNonQuery()
        Return mycommand.Parameters("@Value").Value
        con.Close()
    End Function

    Sub Populate_Value()
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT ISNULL(PT_Biopsy_Save_Record.Specimen, '') AS Specimen, ISNULL(PT_Biopsy_Save_Record.Gross_Exam, '') AS Gross_Exam,ISNULL(PT_Biopsy_Save_Record.Micro_Exam, '') AS Micro_Exam, ISNULL(PT_Biopsy_Save_Record.Diagnosis, '') AS Diagnosis,Path_PatientTestResult_Main.TGID FROM PT_Biopsy_Save_Record INNER JOIN Path_PatientTestResult_Main ON PT_Biopsy_Save_Record.trmid = Path_PatientTestResult_Main.trmId WHERE (Path_PatientTestResult_Main.Main_ID = @Main_ID) AND (Path_PatientTestResult_Main.TGID = @TGID) AND (PT_Biopsy_Save_Record.TID = @TID)", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@Main_ID", HiddenFieldMainID.Value)
        command.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value)
        command.Parameters.AddWithValue("@TID", HiddenField_TB_ID.Value)
        'command.Parameters.AddWithValue("@TID", DropDownList_Test.SelectedValue)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            WebHtmlEditor_Specimen.Text = reader.Item(0).ToString
            WebHtmlEditor_Gross_Examination.Text = reader.Item(1).ToString
            WebHtmlEditor_Micro_Exam.Text = reader.Item(2).ToString
            WebHtmlEditor_Diagnosis.Text = reader.Item(3).ToString
        End If
        con.Close()
    End Sub

    Protected Sub GridView_Test_Status_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView_Test_Status.RowUpdating
        Dim Drop As DropDownList = GridView_Test_Status.Rows(e.RowIndex).FindControl("DropDownList_Status")
        Dim Hid_ID As HiddenField = GridView_Test_Status.Rows(e.RowIndex).FindControl("HiddenField_ID")
        HiddenField_Edit_ID.Value = Hid_ID.Value
        HiddenField_Edit_Status.Value = Drop.SelectedValue
    End Sub

    Protected Sub GridView_Test_Status_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Test_Status.SelectedIndexChanged
        Dim hid_Main_Id As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenFieldMain_ID")
        Dim hid_TG_ID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenField_TG_ID")
        Dim hid_TB_ID As HiddenField = GridView_Test_Status.Rows(GridView_Test_Status.SelectedIndex).FindControl("HiddenFieldTBID")
        HiddenField_TGID.Value = hid_TG_ID.Value
        HiddenFieldMainID.Value = hid_Main_Id.Value
        HiddenField_TB_ID.Value = hid_TB_ID.Value
        'Response.Write(HiddenField_TB_ID.Value)
    End Sub
End Class
