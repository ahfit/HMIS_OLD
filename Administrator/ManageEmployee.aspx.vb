Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Common
Imports System.IO

Partial Class Administrator_ManageEmployee

    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim con As New SqlConnection




    'Protected Sub lnkBtnActivateDeactivate_Click(ByVal sender As Object, ByVal e As EventArgs)
    '    Dim x As Integer = 9
    '    Dim lnkTemp As LinkButton
    '    lnkTemp = CType(sender, LinkButton)
    '    Dim status As Boolean

    '    If lnkTemp.Text.Equals("Activate") Then
    '        status = True
    '    Else
    '        status = False
    '    End If

    '    sqlDs_EmployeeList.UpdateParameters("EmpID").DefaultValue = lnkTemp.CommandArgument
    '    sqlDs_EmployeeList.UpdateParameters("Status").DefaultValue = status
    '    sqlDs_EmployeeList.Update()

    '    GridView1.DataBind()

    'End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender

        'Dim lnkTemp As LinkButton
        'Dim chkTemp As CheckBox

        'For Each roww As GridViewRow In GridView1.Rows
        '    lnkTemp = CType(roww.FindControl("lnkBtnActivateDeactivate"), LinkButton)
        '    If lnkTemp IsNot Nothing Then
        '        chkTemp = CType(roww.Cells(14).Controls(0), CheckBox)
        '        If chkTemp.Checked Then
        '            lnkTemp.Text = "Deactivate"
        '        Else
        '            lnkTemp.Text = "Activate"
        '        End If
        '    End If
        'Next

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub ddlLoginName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlLoginName.SelectedIndexChanged
        Try
            con.ConnectionString = constr
            Dim command As SqlCommand = New SqlCommand("SELECT EFName FROM Employee WHERE EmpID=@EmpID", con)
            'Dim command1 As SqlCommand = New SqlCommand("SELECT EMName  FROM Employee WHERE EmpID=@EmpID", con)

            command.CommandType = CommandType.Text
            'command.CommandType = CommandType.Text

            con.Open()
            command.Parameters.AddWithValue("@EmpID", ddlLoginName.SelectedValue)
            'command1.Parameters.AddWithValue("@EmpID", ddlLoginName.SelectedValue)
            Dim fName As String = command.ExecuteScalar()
            lblFirstName.Text = fName
            'Dim EMName As String = command1.ExecuteScalar()
            'lblMiddleName.Text = EMName



            con.Close()
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub lnkBtnActivateDeactivate_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkbtn As LinkButton = sender
        hf_emp_id.Value = lnkbtn.CommandArgument
        If lnkbtn.Text = "Active" Then
            HF_Status.Value = "False"
            sqlDs_EmployeeList.Update()
            GridView1.DataBind()
        ElseIf lnkbtn.Text = "Deactive" Then
            HF_Status.Value = "True"
            sqlDs_EmployeeList.Update()
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub ddlHospital_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlHospital.SelectedIndexChanged
        ddlDept.DataBind()
        GridView1.DataBind()



    End Sub

    Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Active Employee" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        'repAllCustomers.Columns(0).Visible = false;
        'repAllCustomers.Columns(1).Visible = false;
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'base.VerifyRenderingInServerForm(control);
    End Sub

    Protected Sub TextBox_EmpName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_EmpName.TextChanged
        'TextBox_EmpName.Text = String.Empty

        TextBox_EmpName.Focus()




    End Sub

    Protected Sub TextBox_EmpID_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_EmpID.TextChanged
        TextBox_EmpID.Text = TextBox_EmpID.Text.Trim()
    End Sub
End Class
