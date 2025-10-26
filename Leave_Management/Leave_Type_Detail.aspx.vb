
Imports System.Data
Imports System.Data.SqlClient

Partial Class Leave_Type_Detail
    Inherits System.Web.UI.Page
    Dim con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString)
    Protected Sub GridView4_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView4.SelectedIndexChanged

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            DropDownList_Leave_Type.DataBind()
            LeaveLimit.DataBind()
            Gender.DataBind()

            GridView4.DataBind()

        End If

    End Sub



    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click

        Try
            HiddenField_date.Value = WebDateChooser_Start_date.Value
            If DropDownList_Min_Service_Day.Text = "Year" Then
                HiddenField_days.Value = Convert.ToInt32(TextBox_min_Service_Day.Text) * 365
            ElseIf DropDownList_Min_Service_Day.Text = "Month" Then
                HiddenField_days.Value = Convert.ToInt32(TextBox_min_Service_Day.Text) * 30
            ElseIf DropDownList_Min_Service_Day.Text = "Day" Then
                HiddenField_days.Value = TextBox_min_Service_Day.Text
            End If
            If Button_Save.Text = "Save" Then
                SqlDataSource_Leave_Type_Detail.Insert()
            ElseIf Button_Save.Text = "Update" Then
                Upate()
                IsFrwd.SelectedValue = "1"
                HasOpening.SelectedValue = "1"
                RBT_Salary.SelectedValue = "1"
                IsDocumentRequired.SelectedValue = "1"
                RBT_HasOpening.SelectedValue = "1"
            End If

            TextBox_Avail_Time_Limit.Text = ""
            TextBox_Leave_Rule_Text.Text = ""
            TextBox_min_Service_Day.Text = ""
            OTAT.Text = ""
            TextBox_Type_Name.Text = ""
            txtboxAvailDays.Text = ""
            Txt_FDays.Text = ""

            lblMsg.Text = "Save successfully!"
            GridView4.DataBind()
            EnableAllControls()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Private Sub Upate()
        Try
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("sp_Update_Leave_Type_Detail", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Type_Detail_id", HiddenField_ID.Value)
            cmd.Parameters.AddWithValue("@Leave_Type_id", DropDownList_Leave_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@Leave_Name", TextBox_Type_Name.Text.Trim())
            cmd.Parameters.AddWithValue("@Pay", DropDownList_pay.SelectedValue)
            cmd.Parameters.AddWithValue("@Avail_Time_Limit", TextBox_Avail_Time_Limit.Text.Trim())
            cmd.Parameters.AddWithValue("@Rule_Text", TextBox_Leave_Rule_Text.Text.Trim())
            cmd.Parameters.AddWithValue("@ForwardableLeave", Txt_FDays.Text.Trim())
            cmd.Parameters.AddWithValue("@MaximumAvailDays", txtboxAvailDays.Text.Trim())
            cmd.Parameters.AddWithValue("@OneTimeAvailLimit", OTAT.Text.Trim())
            cmd.Parameters.AddWithValue("@Gender", Gender.SelectedValue)
            cmd.Parameters.AddWithValue("@IsFrwd", IsFrwd.SelectedValue)
            cmd.Parameters.AddWithValue("@Salary_Day", RBT_Salary.SelectedValue)
            cmd.Parameters.AddWithValue("@HasOpening", HasOpening.Text.Trim())
            cmd.Parameters.AddWithValue("@LeaveLimit", LeaveLimit.Text.Trim())
            cmd.Parameters.AddWithValue("@IsDocumentRequired", IsDocumentRequired.SelectedValue)
            cmd.ExecuteNonQuery()
            lblMsg.Text = cmd.Parameters("@Remarks").Value.ToString()
            cmd.Dispose()
            HiddenField_ID.Value = "-1"
        Catch __unusedException1__ As Exception
            lblMsg.Text = "Update fail"
            Return
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub ddlHospital_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlHospital.SelectedIndexChanged
        DropDownList_Leave_Type.DataBind()
    End Sub



    Protected Sub lnk_UpdateRecord_Click(sender As Object, e As EventArgs)
        Dim lik As LinkButton = CType(sender, LinkButton)
        Dim id As String = lik.CommandArgument
        Dim dt As DataTable = GetRecord(id)
        Try
            HiddenField_ID.Value = id
            Gender.SelectedValue = dt.Rows(0)("GenderId").ToString()
            LeaveLimit.SelectedValue = dt.Rows(0)("LeaveLimit").ToString()
            OTAT.Text = dt.Rows(0)("OneTimeAvailLimit").ToString()
            TextBox_Type_Name.Text = dt.Rows(0)("Leave_Name").ToString()
            txtboxAvailDays.Text = dt.Rows(0)("MaximumAvailDays").ToString()
            Txt_FDays.Text = dt.Rows(0)("ForwardableLeave").ToString()
            Gender.SelectedValue = dt.Rows(0)("GenderId").ToString()
            IsFrwd.SelectedValue = dt.Rows(0)("IS_forward").ToString()
            HasOpening.SelectedValue = dt.Rows(0)("Has_Opening").ToString()
            RBT_Salary.SelectedValue = dt.Rows(0)("Salary_Day").ToString()
            IsDocumentRequired.SelectedValue = dt.Rows(0)("IsDocumentRequired").ToString()
            RBT_HasOpening.SelectedValue = dt.Rows(0)("Has_Opening").ToString()
            TextBox_Leave_Rule_Text.Text = dt.Rows(0)("Rule_Text").ToString()
            Button_Save.Text = "Update"
            ddlHospital.Enabled = False
            DropDownList_Leave_Type.Enabled = False
            DropDownList_Leave_Type.SelectedValue = dt.Rows(0)("Leave_Type_id").ToString()

        Catch ex As Exception
            Response.Write(ex.Message)

        End Try

    End Sub



    Public Function GetRecord(ByVal id As String) As DataTable
        Dim dt As DataTable = New DataTable()
        Dim da As SqlDataAdapter = New SqlDataAdapter()
        Try
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("sp_Leave_Type_Detail", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@id", id)
            da.SelectCommand = cmd
            da.Fill(dt)
            cmd.Dispose()
        Catch ex As Exception
            dt = Nothing
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try

        Return dt
    End Function

    Private Sub EnableAllControls()
        Button_Save.Text = "Save"
        'DDL_Campus.Enabled = True
        'Dropdownlistdepartment.Enabled = True
        'DropDownList_SubDepartment.Enabled = True
        'DropDownListEmployee.Enabled = True
        'DropDownList_LeaveType.Enabled = True
        'DDLyearBalance.Enabled = True
    End Sub
    Protected Sub lnk_DeleteRecord_Click(sender As Object, e As EventArgs)


        Dim lik As LinkButton = CType(sender, LinkButton)
        Dim _id As String = lik.CommandArgument
        Dim dt As DataTable = DeleteRecord(_id)

    End Sub

    Public Function DeleteRecord(ByVal id As String) As DataTable
        Dim dt As DataTable = New DataTable()
        Try
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("sp_Delete_Leave_Type_Detail", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@id", id)
            cmd.ExecuteNonQuery()
            GridView4.DataBind()
        Catch Ex As Exception
            Response.Write(Ex.Message)
        Finally
            con.Close()
        End Try

        Return dt
    End Function


End Class
