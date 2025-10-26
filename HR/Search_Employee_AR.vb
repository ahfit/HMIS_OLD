Imports System.Data.SqlClient
Imports System.Data
Partial Class Search_Employee_AR
    Inherits System.Web.UI.Page

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As String = GridView1.Rows(GridView1.SelectedIndex).Cells(5).Text
        Session.Add("Enter_emp_ID", GridView1.SelectedValue)
        Response.Redirect("Application.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GetLeaves()
        End If
    End Sub

    Protected Sub GetLeaves()
        Dim db As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {New SqlParameter("@EmpId", Session("emp_id"))}

        GridView1.DataSource = db.ExecuteDataTable("uspSelectEmployeeForLeave", "Leave_ManagementConnectionString", sqlParams)
        GridView1.DataBind()
    End Sub
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs)
        GetLeaves()
    End Sub
End Class
