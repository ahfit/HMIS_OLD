Imports System.Data.SqlClient
Imports System.Data

Partial Class Leave_Management_LeaveBalanceTransferAndLaps
    Inherits System.Web.UI.Page

    '   ===================================================================================================================================================================
    '                                                       User Method(s)
    '   ===================================================================================================================================================================

    Protected Sub Search()
        HF_Search_Item.Value = 0
        GV_Rec.DataBind()
    End Sub
    Protected Sub getGridRecord()
        Dim data As String = "<Data>"
        If GV_Rec.Rows.Count > 0 Then
            Dim Ck As New CheckBox
            Dim textboxValues As New TextBox
            Dim HF_CYB As New HiddenField
            Dim hfEmpID As New HiddenField
            Dim hfPreviousLeaveBalance As HiddenField
            For Each row As GridViewRow In GV_Rec.Rows
                Ck = row.FindControl("chkboxSelect")
                If Ck.Checked Then
                    textboxValues = row.FindControl("txtboxLapsedLeaves")
                    hfEmpID = row.FindControl("hfEmpID")
                    hfPreviousLeaveBalance = row.FindControl("hfPreviousLeaveBalance")
                    If textboxValues.Text = "" Then
                        textboxValues.Text = "0.0"
                    End If
                    If Not String.IsNullOrEmpty(textboxValues.Text.Trim()) Then
                        data = data + "<row><emp_id>" + hfEmpID.Value + "</emp_id><CLB>" + textboxValues.Text + "</CLB><PLB>" + hfPreviousLeaveBalance.Value + "</PLB></row>"
                    End If
                End If
            Next
            data = data + "</Data>"
            If data = "<Data></Data>" Then
                lblMsg.Text = "Kindly Select any Emmployees first"
            Else
                Insert_record(data, True)
            End If
        End If
    End Sub
    Protected Sub getGridRecordForLeave()
        Dim data As String = "<Data>"

        If GV_Rec.Rows.Count > 0 Then

            Dim Ck As New CheckBox
            Dim textboxValues As New TextBox
            Dim hfEmpID As New HiddenField
            Dim Hf_encashment As HiddenField = GV_Rec.Rows(0).FindControl("HF_is_encashment")
            Dim maxvalue As Double = 0
            If Convert.ToBoolean(Hf_encashment.Value) Then
                For Each row As GridViewRow In GV_Rec.Rows
                    Ck = row.FindControl("chkboxSelect")
                    If Ck.Checked Then
                        textboxValues = row.FindControl("txtboxEncashLeave")
                        hfEmpID = row.FindControl("hfEmpID")

                        If Not String.IsNullOrEmpty(textboxValues.Text.Trim()) Then
                            maxvalue = CDbl(textboxValues.ToolTip().ToString().Replace("Max encashment leave(s) : ", "0"))
                            If CDbl(textboxValues.Text.Trim()) <= maxvalue Then
                                data = data + "<row><emp_id>" + hfEmpID.Value + "</emp_id><EL>" + textboxValues.Text + "</EL></row>"
                            Else
                                textboxValues.BackColor = Drawing.Color.Red
                            End If

                        End If
                    End If
                Next
            End If

            data = data + "</Data>"
            If data = "<Data></Data>" Then
                lblMsg.Text = "Kindly Select any Emmployees first"
            Else
                Insert_record(data, False)
            End If
        End If
    End Sub
    Protected Sub Insert_record(ByVal Data As String, ByVal is_leave As Boolean)
        Try

            Dim con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand()
            cmd.Connection = con
            cmd.CommandType = CommandType.StoredProcedure
            If is_leave Then

                cmd.CommandText = "usp_CreateEmployeeLapseAndForwardLeaves"
                cmd.Parameters.AddWithValue("@Data", Data)
                cmd.Parameters.AddWithValue("@LeaveDetailTypeId", DropDownList_LeaveType.SelectedValue)
                cmd.Parameters.AddWithValue("@OpeningDate", DateTime.Now)
                cmd.Parameters.AddWithValue("@BalanceYear", DDLyearBalance.Text)
                cmd.Parameters.AddWithValue("@empid", Session("emp_id"))

            Else
                Dim BalanceYear As Int16 = 0
                BalanceYear = DDLyearBalance.SelectedValue
                If rdlForYear.SelectedValue = "2" Then
                    BalanceYear = BalanceYear - 1
                End If


                cmd.CommandText = "Insert_Encash_leave"
                cmd.Parameters.AddWithValue("@Data", Data)
                cmd.Parameters.AddWithValue("@LeaveDetailTypeId", DropDownList_LeaveType.SelectedValue)
                cmd.Parameters.AddWithValue("@BalanceYear", BalanceYear)
                cmd.Parameters.AddWithValue("@empid", Session("emp_id"))
                cmd.Parameters.AddWithValue("@EarnedLeaveDate", Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy-MM-dd"))

            End If

            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()

            lblMsg.Text = "Saved Record Successfully.."
        Catch ex As Exception
            lblMsg.Text = "Error while saving..." + ex.Message()
        End Try


    End Sub
    Private Function getEncashPolicy(lblRemainingLeave As Label, lblMaxDay As Label, lblFD As Label, ByRef txtRemainDay As TextBox, ByRef txt_CYB As TextBox, ByRef lblLapsedLeaves As Label) As String
        Dim Encash As String = ""
        Dim val As Double = 0
        Dim RL As Double = CDbl(lblRemainingLeave.Text)
        Dim MD As Double = CDbl(lblMaxDay.Text)
        Dim FD As Double = CDbl(lblFD.Text)

        If RL + MD > FD Then

            val = Math.Floor(((RL + MD) - FD))
            If val > 0 Then
                txtRemainDay.Text = val
                'txtRemainDay.Enabled = False
            End If
        Else
            val = (RL / 2)
        End If

        'If RL + MD > 42 Then

        '    val = Math.Floor(((RL + MD) - 42) / 2)
        '    If val > 0 Then
        '        txtRemainDay.Text = val
        '        txt_CYB.Text = "42"
        '        'txtRemainDay.Enabled = False
        '        lblLapsedLeaves.Text = ((RL + MD) - 42) - val
        '    End If
        'Else
        '    val = 0
        '    txt_CYB.Text = (RL + MD).ToString()
        '    lblLapsedLeaves.Text = "0"
        'End If

        txtRemainDay.Attributes.Add("max", val.ToString())
        txtRemainDay.ToolTip = "Max encashment leave(s) : " + val.ToString()

        Return Encash

    End Function

    '   ===================================================================================================================================================================
    '                                                       EVENT Handling
    '   ===================================================================================================================================================================

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            DDL_Campus.DataBind()
            Dropdownlistdepartment.DataBind()
            DropDownList_SubDepartment.DataBind()
            DropDownList_LeaveType.DataBind()
            Dim year As Integer = DateTime.Now.Year
            For i As Integer = 0 To 10
                DDLyearBalance.Items.Insert(i, Convert.ToString(year + i))
            Next
            DDLyearBalance.SelectedValue = Convert.ToString(DateTime.Now.Year)
            DropDownList_LeaveType.DataBind()
            WebDateChooser_Start_Date.Value = DateTime.Now.Date
            Search()

        End If

        If GV_Rec.Rows.Count > 0 Then
            btnSave.Visible = True
            btn_leave_encashment.Visible = False
        Else
            btnSave.Visible = False
            btn_leave_encashment.Visible = False
        End If

    End Sub

    Protected Sub btnSearch_Click(sender As Object, e As EventArgs)
        Search()

    End Sub

    Protected Sub checkboxSelectAll_CheckedChanged(sender As Object, e As EventArgs)

        Dim chkboxAll As CheckBox = sender
        For index = 0 To GV_Rec.Rows.Count - 1
            Dim chkboxSelect As CheckBox = DirectCast(GV_Rec.Rows(index).FindControl("chkboxSelect"), CheckBox)
            chkboxSelect.Checked = chkboxAll.Checked
        Next

    End Sub

    Protected Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        getGridRecord()
        Search()

    End Sub

    Protected Sub DDL_Campus_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_Campus.SelectedIndexChanged
        Dropdownlistdepartment.DataBind()
        DropDownList_SubDepartment.DataBind()
        DropDownListEmployee.DataBind()
        Search()
    End Sub

    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(sender As Object, e As EventArgs) Handles Dropdownlistdepartment.SelectedIndexChanged
        DropDownList_SubDepartment.DataBind()
        DropDownListEmployee.DataBind()
        Search()
    End Sub

    Protected Sub DropDownList_SubDepartment_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_SubDepartment.SelectedIndexChanged
        DropDownListEmployee.DataBind()
        Search()
    End Sub

    Protected Sub RBL_E_Type_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RBL_E_Type.SelectedIndexChanged
        DropDownListEmployee.DataBind()
        Search()
    End Sub

    Protected Sub DDLyearBalance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDLyearBalance.SelectedIndexChanged
        Search()
    End Sub

    Protected Sub DropDownList_LeaveType_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_LeaveType.SelectedIndexChanged
        If DropDownList_LeaveType.SelectedValue = 3 Then
            rdlForYear.Visible = True
        Else
            rdlForYear.Visible = False
        End If
        Search()
    End Sub

    Protected Sub GV_Rec_PreRender(sender As Object, e As EventArgs) Handles GV_Rec.PreRender
        If GV_Rec.Rows.Count > 0 And HF_Search_Item.Value = 0 Then
            Dim txt_CYB As New TextBox
            Dim HF_CYB As New HiddenField
            Dim hfIsEncash As New HiddenField
            Dim lblRemainingLeave As New Label
            Dim lblMaxDay As New Label
            Dim lblFD As New Label
            Dim txt_Enchashment As New TextBox
            Dim lblLapsedLeaves As New Label


            For Each row As GridViewRow In GV_Rec.Rows
                txt_CYB = row.FindControl("txtboxLapsedLeaves")
                HF_CYB = row.FindControl("HF_CurrentYearLeaveBalance")
                hfIsEncash = row.FindControl("hfIsEncash")
                lblLapsedLeaves = row.FindControl("lblLapsedLeaves")
                txt_CYB.Text = HF_CYB.Value
                If Convert.ToBoolean(hfIsEncash.Value) Then
                    lblRemainingLeave = row.FindControl("lblReLeave")
                    lblMaxDay = row.FindControl("lbl_MAD")
                    lblFD = row.FindControl("lbl_FD")
                    txt_Enchashment = row.FindControl("txtboxEncashLeave")
                    getEncashPolicy(lblRemainingLeave, lblMaxDay, lblFD, txt_Enchashment, txt_CYB, lblLapsedLeaves)



                End If
            Next
            HF_Search_Item.Value = 1
        End If

    End Sub


    Protected Sub btn_leave_encashment_Click(sender As Object, e As EventArgs) Handles btn_leave_encashment.Click
        getGridRecordForLeave()

    End Sub
End Class
