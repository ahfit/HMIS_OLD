' Author                    Imran Ahmed Awan 
' Created Date              08-12-2006
' Description               Select main group of tests for a sepecific patient 

Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.data
Partial Class Administrator_Test_Administrator_PatientTestReportMain
    Inherits System.Web.UI.Page
    Dim b, c As String
    Dim AgeDate As String
    'Dim ClassObj As New PatientBasicInfo
    Sub SelectTestMainGroup()
        'If (RadioButtonListTestMainGroup.Items.Count = 0) Then
        '    LabelMessage.Text = "No record found"
        'End If


    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ' Response.Write(Request.QueryString("RegNo"))
        Dim RegNo As String = "RegNo"
        Dim YearlyNo As String = "YearlyNo"
        LinkButtonReport.Attributes.Add("onclick", "return getQueryVariable('" & RegNo & "','" & YearlyNo & "')")
        HiddenFieldYearlyNo.Value = Request.QueryString("YearlyNo")
        HiddenFieldRegNo.Value = Request.QueryString("RegNo")
        'Response.Write(HiddenFieldYearlyNo.Value + " " + HiddenFieldRegNo.Value)
        SelectTestMainGroup()
        'populatevalue()
        'Vitals()
        'PatientName()
        Check_Count_Test()
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        LabelMessage.Text = ""
        RadioButtonListTestMainGroup.DataBind()
        SelectTestMainGroup()
    End Sub

    Protected Sub ButtonSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSubmit.Click
        Try

            Dim b As Int64
            b = HiddenFieldYearlyNo.Value
            'Session.Add("TestMainGroupID", RadioButtonListTestMainGroup.SelectedValue)
            Dim ab As Integer = RadioButtonListTestMainGroup.SelectedValue
            LabelMessage.Text = RadioButtonListTestMainGroup.SelectedValue
            Session.Add("registrationNo", Request.QueryString("regno"))
            Session.Add("YearlyNo", HiddenFieldYearlyNo.Value)
            Response.Redirect("pt_select_test.aspx?TestMainGroup=" & ab & "&YearlyNo=" & b & "&RegNo=" & Request.QueryString("regno"))
        Catch ex As Exception
            LabelMessage.Text = "Please Check The Test Group "
        End Try

    End Sub
    Protected Sub ImageButtonHome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonHome.Click
        Response.Redirect("~/" & Session("mainpage"))
    End Sub
    Protected Sub ImageButtonlogout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
        session.removeall()
        Response.Redirect("~/Login.aspx")
    End Sub
    Protected Sub ImageButtonBack_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonBack.Click
        Response.Redirect("Pathology_Reception.aspx")
    End Sub
    'Sub populatevalue()
    '    Try

    '        Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    '        Dim con As New System.Data.SqlClient.SqlConnection(a)
    '        Dim procedurename As String = "pathology_select_PatientBasicInfo"
    '        Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
    '        mycommand.CommandType = Data.CommandType.StoredProcedure
    '        mycommand.CommandText = procedurename
    '        mycommand.Parameters.AddWithValue("@nPayId", Request.QueryString("YearlyNo"))
    '        con.open()
    '        Dim da As New SqlDataAdapter
    '        Dim ds As New Data.DataSet
    '        da.SelectCommand = mycommand
    '        da.Fill(ds, mycommand.ExecuteNonQuery)
    '        HiddenFieldregno.Value = (ds.Tables(0).Rows(0).Item(4).ToString)
    '        con.close()
    '    Catch ex As Exception
    '        ' Response.Write(ex.Message)
    '    End Try
    'End Sub

    Protected Sub RadioButtonListTestMainGroup_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonListTestMainGroup.SelectedIndexChanged
        Try
            GridView_TestResult.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        ' Response.Write(GridView_TestResult.DataKeys(0))
        'Response.Write(GridView_TestResult.DataKeyNames("TID").ToString)
    End Sub

    Protected Sub GridView_TestResult_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_TestResult.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (b = "") Then
                b = e.Row.Cells.Item(0).Text
                'response.write(e.row.cells.item(2).text)
                e.Row.Cells.Item(0).Text = b
            ElseIf b = e.Row.Cells.Item(0).Text Then
                e.Row.Cells.Item(0).Text = ""
            Else
                b = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = b
            End If
        End If
        ''=================================
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (c = "") Then
                c = e.Row.Cells.Item(1).Text
                e.Row.Cells.Item(1).Text = c
            ElseIf c = e.Row.Cells.Item(1).Text Then
                e.Row.Cells.Item(1).Text = ""
            Else
                c = e.Row.Cells.Item(1).Text
                e.Row.Cells.Item(1).Text = c
            End If
        End If
    End Sub

    Protected Sub GridView_TestResult_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView_TestResult.RowUpdating
        'Dim TextBoxGroupName As New TextBox
        'TextBoxGroupName = GridView_TestResult.Rows(e.RowIndex).FindControl("TextBox2")
        'HiddenFieldValue.Value = TextBoxGroupName.Text
        ''HiddenFieldTRMID.Value = GridView_TestResult.Rows(e.RowIndex).Cells(7).Text
        ''HiddenFieldTestID.Value = GridView_TestResult.DataKeys(1).Values
        ''HiddenFieldTestComponent.Value = GridView_TestResult.DataKeys(2).Values
    End Sub

    Sub Check_Count_Test()

        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim procedurename As String = "Pathalogy_Test_Count"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@YearlyNO", Request.QueryString("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
            mycommand.Parameters.Add("@Result", Data.SqlDbType.Int)
            mycommand.Parameters("@Result").Direction = ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()
            Dim result As Integer
            result = mycommand.Parameters("@Result").Value
            If result = 1 Then
                ButtonSubmit.Visible = False
                UpdateStatus()
            ElseIf result = 0 Then
                ButtonSubmit.Visible = True
            End If
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub UpdateStatus()
        Try
            Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
            Dim procedurename As String = "Path_Update_status"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = procedurename
            mycommand.Parameters.AddWithValue("@YearlyNO", Request.QueryString("YearlyNo"))
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
            mycommand.Parameters.AddWithValue("@Status", 1)
            'mycommand.Parameters("@Result").Direction = ParameterDirection.Output
            con.open()
            mycommand.ExecuteNonQuery()
            con.close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub LinkButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonReport.Click
        Response.Redirect("~/testpagepathology.aspx?RegNo=" & Request.QueryString("RegNo") & "&YearlyNo=" & Request.QueryString("YearlyNo"))
    End Sub
End Class
