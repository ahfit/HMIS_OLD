Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections
Partial Class Waiting_Leaves_Application_for_Approval
    Inherits System.Web.UI.Page
    Dim user_constr As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Leave_ManagementConnectionString").ConnectionString



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        GridView1.DataBind()



        If IsPostBack Then


        End If

    End Sub

    Protected Sub Button_approve_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_approve.Click
        Try


            HiddenField_Approved_Rejected.Value = True
            HiddenField_From_Date0.Value = WebDateChooser_Start_Date0.Value
            HiddenField_to_Date0.Value = WebDateChooser_End_Date0.Value
            SqlDataSource_Leaves_For_Approval.Update()
            Button_approve.Visible = False
            ButtonRejected.Visible = False
            'Show()
            Panel2.Visible = False
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub
    Protected Sub ButtonRejected_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonRejected.Click


        Try

            HiddenField_Approved_Rejected.Value = False
            HiddenField_From_Date0.Value = WebDateChooser_Start_Date0.Value
            HiddenField_to_Date0.Value = WebDateChooser_End_Date0.Value
            SqlDataSource_Leaves_For_Approval.Update()
            ButtonRejected.Visible = False
            Button_approve.Visible = False
            Panel2.Visible = False
            GridView1.DataBind()
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim lik As LinkButton = sender
            Button_approve.CommandArgument = lik.CommandArgument
            ButtonRejected.CommandArgument = lik.CommandArgument
            HiddenField_Emp_Leave_ID.Value = lik.CommandArgument
            Dim row As GridViewRow = lik.NamingContainer
            Dim hfdEmpID As HiddenField = row.FindControl("hfdEmpID")
            SqlDataSource1.SelectParameters("Emp_Leave_Id").DefaultValue = Convert.ToInt32(lik.CommandArgument.ToString())
            HiddenField_EmpId.Value = hfdEmpID.Value
            GridView6.DataBind()
            DDL_Recommended_To.DataBind()
            Load_Data(lik.CommandArgument)
            Panel2.Visible = True
        Catch ex As Exception
            Response.Write("err" + ex.Message)
        End Try
    End Sub
    Protected Sub Load_Data(ByVal Emp_Leave_ID As Integer)
        Dim con As New SqlConnection(constr)
        Dim qry As String = "SELECT     Start_Date, End_Date, Leave_Days, ISNULL(Description, '') AS Description, Salary_Day, Requested_Days, Type_Detail_Id, Leave_Cat_Id FROM  Employee_Leaves WHERE (Emp_Leave_Id = @Emp_Leave_Id)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@Emp_Leave_Id", Emp_Leave_ID)
        con.Open()
        DropDownList_Leave_Name0.DataBind()
        Dim reader As SqlDataReader = cmd.ExecuteReader()
        While reader.Read
            WebDateChooser_Start_Date0.Value = reader.Item("Start_Date")
            WebDateChooser_End_Date0.Value = reader.Item("End_Date")
            TextBox_Leave_Day0.Text = reader.Item("Leave_Days")
            TextBox_Salary_Day0.Text = reader.Item("Salary_Day")
            TextBox_Description0.Text = reader.Item("Description")
            DropDownList_Leave_Name0.SelectedValue = Convert.ToInt32(reader.Item("Type_Detail_Id"))
            TextBox_Requested_Leave.Text = reader.Item("Requested_Days")
            If TextBox_Requested_Leave.Text = "0" Then
                TextBox_Requested_Leave.Text = "1"
            End If
            DropDownList_L_Sub_Cat0.SelectedValue = reader.Item("Leave_Cat_Id")
        End While
        con.Close()
    End Sub
    Protected Sub buttonCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles buttonCancel.Click
        Try
            Panel2.Visible = False
            'Response.Redirect("~/HR/Employee_Leaves.aspx?Emp_ID=" + (Request.QueryString("Emp_ID").ToString()))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub ButtonRecommend_Click(sender As Object, e As EventArgs)
        Try
            SqlDataSource_Leaves_For_Approval.UpdateParameters("Recommend_Id").DefaultValue = DDL_Recommended_To.SelectedValue
            SqlDataSource_Leaves_For_Approval.Update()
            HiddenField_From_Date0.Value = WebDateChooser_Start_Date0.Value
            HiddenField_to_Date0.Value = WebDateChooser_End_Date0.Value
            ' SqlDataSource_Leaves_For_Approval.Update()
            Button_approve.Visible = False
            ButtonRejected.Visible = False
            ButtonRecommend.Visible = False
            'Show()
            Panel2.Visible = False
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
       
    End Sub
End Class
