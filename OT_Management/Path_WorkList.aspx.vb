Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Path_WorkList
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim Reg_No As String = ""
    Dim Yearly_No As String = ""
    Dim Main_Id As String = ""
    Dim sub_group As String = ""
    Dim constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Protected Sub GridViewTest_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest.PreRender
        For i As Integer = 0 To GridViewTest.Rows.Count - 1
            GridViewTest.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridViewTest.Rows(i).Cells(1).Text, False)
        Next
    End Sub

    Protected Sub DropDownListMain_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListMain.SelectedIndexChanged
        DropDownListTest.DataBind()
    End Sub

    Protected Sub DropDownListTest_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListTest.SelectedIndexChanged
        GridViewTest.DataBind()
    End Sub

    Protected Sub DropDownListTestName_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListTestName.PreRender
        If DropDownListTestName.Items.Count > 1 Then
            DropDownListTestName.Items.RemoveAt(0)
            DropDownListTestName.Items.Insert(0, New ListItem("", "0"))
        End If
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListTestName.SelectedIndexChanged
        GridViewTest.DataBind()
    End Sub


    Protected Sub GridViewTest_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridViewTest.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If (Reg_No = "") Then
                Reg_No = e.Row.Cells.Item(1).Text
                e.Row.Cells.Item(1).Text = Reg_No
            ElseIf Reg_No = e.Row.Cells.Item(1).Text Then
                e.Row.Cells.Item(1).Text = ""
                e.Row.Cells.Item(1).Text = ""
            Else
                Reg_No = e.Row.Cells.Item(1).Text
                e.Row.Cells.Item(1).Text = Reg_No
            End If

            Dim btn As Button = e.Row.FindControl("Button1")
            If (Main_Id = "") Then
                Main_Id = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = Main_Id
            ElseIf Main_Id = e.Row.Cells.Item(0).Text Then
                e.Row.Cells.Item(0).Text = ""
                e.Row.Cells.Item(0).Text = ""
            Else
                Main_Id = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = Main_Id
            End If

            If (Yearly_No = "") Then
                Yearly_No = e.Row.Cells.Item(2).Text
                e.Row.Cells.Item(2).Text = Yearly_No
            ElseIf Yearly_No = e.Row.Cells.Item(2).Text Then
                e.Row.Cells.Item(2).Text = ""
                e.Row.Cells.Item(2).Text = ""
                btn.Visible = False
            Else
                Yearly_No = e.Row.Cells.Item(2).Text
                e.Row.Cells.Item(2).Text = Yearly_No
            End If

            If (sub_group = "") Then
                sub_group = e.Row.Cells.Item(3).Text
                e.Row.Cells.Item(3).Text = sub_group
            ElseIf sub_group = e.Row.Cells.Item(3).Text Then
                e.Row.Cells.Item(3).Text = ""
                e.Row.Cells.Item(3).Text = ""
            Else
                sub_group = e.Row.Cells.Item(3).Text
                e.Row.Cells.Item(3).Text = sub_group
            End If
        End If
    End Sub

    Sub Save_Values(ByVal regNo As String, ByVal YearlyNo As Integer, ByVal Main_Id As Integer, ByVal Dept_Id As Integer, ByVal SubDeptID As Integer, ByVal TGID As Integer, ByVal TCID As Integer, ByVal TID As Integer, ByVal TCValue As String)
        Try
            'Response.Write(Session("Emp_ID") & "asdas")
            Dim con_main As SqlConnection = New SqlConnection(constr)
            Dim command_main As SqlCommand = New SqlCommand("Path_PatientResult_Main", con_main)
            command_main.CommandType = CommandType.StoredProcedure
            command_main.Parameters.AddWithValue("@RegNo", regNo)
            command_main.Parameters.AddWithValue("@YearlyNo", YearlyNo)
            command_main.Parameters.AddWithValue("@trDate", Date.Now)
            command_main.Parameters.AddWithValue("@DeptId", Dept_Id)
            command_main.Parameters.AddWithValue("@SubDeptId", SubDeptID)
            command_main.Parameters.AddWithValue("@TGID", TGID)
            command_main.Parameters.Add("@TrmID", SqlDbType.Int)
            command_main.Parameters("@TrmID").Direction = ParameterDirection.Output
            command_main.Parameters.AddWithValue("@Main_ID", Main_Id)
            con_main.Open()
            command_main.ExecuteNonQuery()
            Dim TrmId As Integer = command_main.Parameters("@TrmID").Value
            Dim command_sub As SqlCommand = New SqlCommand("Insert_TestResult_Sub", con_main)
            command_sub.CommandType = CommandType.StoredProcedure
            command_sub.Parameters.AddWithValue("@TrmID", TrmId)
            command_sub.Parameters.AddWithValue("@TId", TID)
            command_sub.Parameters.AddWithValue("@TCId", TCID)
            command_sub.Parameters.AddWithValue("@TCValue", TCValue)
            command_sub.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))
            command_sub.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridViewTest_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewTest.SelectedIndexChanged
        If DropDownListTest.SelectedItem.Text = "D.L.C" Or DropDownListTestName.SelectedItem.Text = "D.L.C" Then
            Dim total As Integer = 0
            Dim check As Boolean = True
            For i As Integer = GridViewTest.SelectedIndex To GridViewTest.Rows.Count - 1
                Dim hid_main As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldMainID")
                If GridViewTest.Rows(GridViewTest.SelectedIndex).Cells(0).Text = hid_main.Value Then
                    Dim txt As TextBox = GridViewTest.Rows(i).FindControl("TextBox1")
                    total = total + CInt(txt.Text)
                End If
            Next
            If total <> 100 Then
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>alert('Total Value Must be equal to 100');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                End If
            Else
                For i As Integer = GridViewTest.SelectedIndex To GridViewTest.Rows.Count - 1
                    Dim hid_main As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldMainID")
                    If GridViewTest.Rows(GridViewTest.SelectedIndex).Cells(0).Text = hid_main.Value Then
                        Dim txt As TextBox = GridViewTest.Rows(i).FindControl("TextBox1")
                        Dim hid_RegNo As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldRegNo")
                        Dim hid_VisitNo As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldVisitNo")
                        Dim hid_TGID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTGID")
                        Dim hid_DeptID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldDeptID")
                        Dim hid_SubDeptID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldSubDeptID")
                        Dim hid_TCID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTCID")
                        Dim hid_TID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTID")
                        Save_Values(hid_RegNo.Value, hid_VisitNo.Value, hid_main.Value, hid_DeptID.Value, hid_SubDeptID.Value, hid_TGID.Value, hid_TCID.Value, hid_TID.Value, txt.Text)
                    End If
                Next
            End If
        Else
            For i As Integer = GridViewTest.SelectedIndex To GridViewTest.Rows.Count - 1
                Dim hid_main As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldMainID")
                If GridViewTest.Rows(GridViewTest.SelectedIndex).Cells(0).Text = hid_main.Value Then
                    Dim txt As TextBox = GridViewTest.Rows(i).FindControl("TextBox1")
                    Dim hid_RegNo As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldRegNo")
                    Dim hid_VisitNo As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldVisitNo")
                    Dim hid_TGID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTGID")
                    Dim hid_DeptID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldDeptID")
                    Dim hid_SubDeptID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldSubDeptID")
                    Dim hid_TCID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTCID")
                    Dim hid_TID As HiddenField = GridViewTest.Rows(i).FindControl("HiddenFieldTID")
                    Save_Values(hid_RegNo.Value, hid_VisitNo.Value, hid_main.Value, hid_DeptID.Value, hid_SubDeptID.Value, hid_TGID.Value, hid_TCID.Value, hid_TID.Value, txt.Text)
                End If
            Next
            GridViewTest.DataBind()
        End If
    End Sub
End Class
