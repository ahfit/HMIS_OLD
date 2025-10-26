Imports System.Data
Imports System.Data.SqlClient

Partial Class HR_Search_Employee
    Inherits System.Web.UI.Page

    Dim conString As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        search()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As String = GridView1.Rows(GridView1.SelectedIndex).Cells(7).Text
        Session.Add("Enter_emp_ID", Enter_Emp_id)
        Response.Redirect(Convert.ToString("Employee_Basic_info_edit.aspx?emp_ID=" + Convert.ToString(GridView1.SelectedValue)))

        ' Response.Write("<script language='javascript' type='text/javascript'>window.open('Reception_Main.aspx', '_top')</script>")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LabelDoctorName.Text = Session("Employee_Name")
        Catch ex As Exception

        End Try
        If Not IsPostBack Then
            Dropdownlistdepartment.DataBind()
            RBL_Employee_Type.DataBind()
            RBL_Employee_Type.SelectedIndex = 0
            DDL_Campus.DataBind()
            Dropdownlistdepartment.DataBind()
            search()

        End If


    End Sub
    Sub search()
        HiddenField_CNIC.Value = TextBox_CNIC.Text.Trim()

        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(conString)
        Try

            cmd = New SqlCommand("usp_SearchEmployeeFromSubDepartment", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@SubDeptId", Dropdownlistdepartment.SelectedValue)
            cmd.Parameters.AddWithValue("@CNIC", HiddenField_CNIC.Value)
            cmd.Parameters.AddWithValue("@EmpNo", TextBox_EmpNo.Text.Trim())
            cmd.Parameters.AddWithValue("@Name", TextBox_Employee_name.Text.Trim())
            cmd.Parameters.AddWithValue("@AuthorityId", Session("emp_id"))
            cmd.Parameters.AddWithValue("@LevelId", 2)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            'con.Open()
            da.Fill(dt)
            'con.Close()

            GridView1.DataSource = dt
            GridView1.DataBind()

            '    Dim dssa As New DataSourceSelectArguments()
            'dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount)
            'dssa.RetrieveTotalRowCount = True
            'Dim dv As DataView = DirectCast(SqlDataSourceGrid.[Select](dssa), DataView)
            Label1.Text = "<font color=#ff0000>Total Records Found: {" + Convert.ToString(dt.Rows.Count) + "}</font>"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "DelEmployee" Then
            'Response.Write(e.CommandArgument)
            HiddenField_Emp_ID.Value = e.CommandArgument
            SqlDataSourceEmpDelStatus.Update()
            search()
        End If
    End Sub


End Class
