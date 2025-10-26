Imports System.Data.SqlClient
Imports System.Data
Partial Class Search_Employee_AR
    Inherits System.Web.UI.Page

    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound

    End Sub

    


    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        HiddenField_CNIC.Value = TextBox_CNIC.Text

        Dim db As DbManager = New DbManager()


        Dim sqlParams As SqlParameter() = {
                             New SqlParameter("@DesignationID", Session("DesignationID")),
                             New SqlParameter("SubDeptID", Dropdownlistdepartment.SelectedValue),
                             New SqlParameter("@EmployeeName", TextBox_Employee_name.Text),
                             New SqlParameter("@Cnic", TextBox_CNIC.Text),
                             New SqlParameter("@Month", DDLMonth.SelectedValue),
                             New SqlParameter("@Year", DDLYear.SelectedValue),
                             New SqlParameter("@AuthorityId", Session("emp_id")),
                             New SqlParameter("@LevelId", 1),
                             New SqlParameter("@Status", DDL_Status.SelectedValue)
     }

        GridView1.DataSource = db.ExecuteDataTable("uspSelectEmployeeForLeave", "Leave_ManagementConnectionString", sqlParams)
        GridView1.DataBind()


        Label1.Text = "Total Records Found: {" + Convert.ToString(GridView1.Rows.Count) + "}"
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As String = GridView1.Rows(GridView1.SelectedIndex).Cells(5).Text
        Session.Add("Enter_emp_ID", GridView1.SelectedValue)
        Response.Redirect("Application.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            DDLMonth.SelectedValue = DateTime.Now.Month
            DDLYear.SelectedValue = DateTime.Now.Year
        End If
        Dim conn As New SqlConnection
        Dim con As New SqlCommand
        Dim reader As SqlDataReader
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("job ApplicationConnectionString").ConnectionString
        Try
            Dim Procedurename As String = "get_Pages_ech"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, conn)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_ID"))
            conn.Open()
            reader = mycommand.ExecuteReader
            While reader.Read

                Dim link As New LinkButton
                link.Text = reader.Item(0)
                link.PostBackUrl = "~/" + reader.Item(1)

                Panel6.Controls.Add(link)

            End While



        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        'If GridView1.Rows.Count <> 0 Then
        '    If DDL_Status.SelectedValue = "NULL" Then
        '        GridView1.Columns(7).Visible = True
        '    Else
        '        GridView1.Columns(7).Visible = False
        '    End If

        'End If
    End Sub
    Protected Sub btn_ViewApprovedLeaves_Click(sender As Object, e As EventArgs)
        Dim sb As StringBuilder = New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.open('")
        sb.Append("../Leave_Management/EmployeeApprovedLeavesByHODReport.aspx?SubdeptId=" + Dropdownlistdepartment.SelectedValue + "&Month=" + DDLMonth.SelectedValue + "&Year=" + DDLYear.SelectedValue)
        sb.Append("');")
        sb.Append("</script>")


        ClientScript.RegisterStartupScript(Me.GetType(), "script", sb.ToString())
    End Sub
End Class
