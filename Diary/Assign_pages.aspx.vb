Imports System.Data
Imports System.Data.SqlClient
Partial Class Assign_pages
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
    Dim Flag_uncheck As Boolean = False
    Protected Sub Button_CheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_CheckAll.Click
        For i As Integer = 0 To CheckBoxListPages.Items.Count - 1
            If CheckBoxListPages.Items(i).Selected = False Then
                CheckBoxListPages.Items(i).Selected = True
            End If
        Next
    End Sub

    Protected Sub ButtonUnCheck_All_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonUnCheck_All.Click
        For i As Integer = 0 To CheckBoxListPages.Items.Count - 1
            If CheckBoxListPages.Items(i).Selected = True Then
                CheckBoxListPages.Items(i).Selected = False
            End If
        Next
        Flag_uncheck = True
    End Sub

    Protected Sub CheckBoxListPages_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxListPages.PreRender   
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            Dim command As SqlCommand = New SqlCommand(" SELECT [Page_ID] FROM [Admin_Employee_Module_Pages] where Emp_ID=@User_ID ", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@User_ID", DropDownListUsers.SelectedValue)
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            If Flag_uncheck = False Then
                While reader.Read
                    For i As Integer = 0 To CheckBoxListPages.Items.Count - 1
                        If reader.Item(0).ToString = CheckBoxListPages.Items(i).Value Then
                            CheckBoxListPages.Items(i).Selected = True
                        End If
                    Next
                End While
            End If
        Catch ex As Exception
        Finally
            con.close()
        End Try
    End Sub

    Protected Sub DropDownListUsers_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListUsers.SelectedIndexChanged
        CheckBoxListPages.DataBind()
       drop_down_item()
    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            For i As Integer = 0 To CheckBoxListPages.Items.Count - 1
                If CheckBoxListPages.Items(i).Text = DropDownList1.SelectedItem.Text Then
                    CheckBoxListPages.Items(i).Selected = True
                End If
                If CheckBoxListPages.Items(i).Selected = True Then
                    HiddenFieldPage_ID.Value = CheckBoxListPages.Items(i).Value
                    'Response.Write(HiddenFieldPage_ID.Value)
                    If checkAlreadtSave(HiddenFieldPage_ID.Value, DropDownListUsers.SelectedValue) = 0 Then
                        SqlDataSourcePages.Insert()
                    End If
                Else
                    HiddenFieldPage_ID.Value = CheckBoxListPages.Items(i).Value
                    If checkAlreadtSave(HiddenFieldPage_ID.Value, DropDownListUsers.SelectedValue) >= 1 Then
                        SqlDataSourcePages.Delete()
                    End If
                End If
            Next
            'SqlDataSourceUpdateMainPage.Update()
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
        End Try
    End Sub
    Function checkAlreadtSave(ByVal page_id As Integer, ByVal user_id As Integer) As Integer
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim count As Integer = 0
        Try
            Dim command As SqlCommand = New SqlCommand("SELECT count(*) FROM [Admin_Employee_Module_Pages] where Emp_ID=@User_ID and Page_ID=@Page_ID", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@User_ID", user_id)
            command.Parameters.AddWithValue("@Page_ID", page_id)
            con.Open()
            count = command.ExecuteScalar
        Catch ex As Exception
        Finally
            con.Close()
        End Try
        Return count
    End Function

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Try
            GridView1.HeaderRow.Cells(4).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(4).Visible = False
            Next
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        HiddenFieldPriority.Value = GridView1.Rows(e.RowIndex).Cells(4).Text
    End Sub

    Protected Sub drop_down_item()
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select MainPage_ID from Login where EmpID=@User_Id", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@User_Id", DropDownListUsers.SelectedValue)
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            While reader.Read
                If Not reader.Item(0).ToString.Equals("") Then
                    DropDownList1.SelectedValue = reader.Item(0).ToString
                End If

            End While

        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
   
 End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loginvalidate()
        If Not Page.IsPostBack Then
            FillHospital()
            ddl_Hospital.SelectedValue = Session("HospitalID")
            ddl_Hospital.Enabled = False
        End If

    End Sub
    Sub loginvalidate()
        Try
            If (Session("emp_id") Is Nothing) Then
                Response.Redirect("~/login.aspx")
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Add_Module_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Add_Module.Click
        SqlDataSource_Module.Insert()
        DropDownList_Module.DataBind()
        Label_Module.Visible = True
        Label_Module.Text = "Module Name has been Saved"

    End Sub
    Protected Sub FillHospital()
        Dim conststr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

        Using con As SqlConnection = New SqlConnection(conststr)
            Dim command As SqlCommand = New SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            ddl_Hospital.DataValueField = "Hospital_ID"
            ddl_Hospital.DataTextField = "Hospital_Name"
            ddl_Hospital.DataSource = dt
            ddl_Hospital.DataBind()
        End Using
    End Sub

    Protected Sub Button_Add_Page_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Add_Page.Click
        SqlDataSource_Page.Insert()
        Label_Page.Visible = True
        Label_Page.Text = "Page Name has been Saved"
        TextBox_Page.Text = ""
        TextBox_Url.Text = ""
        GridView_Page.DataBind()

    End Sub

    Protected Sub DropDownList_Module_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Module.SelectedIndexChanged
        GridView_Page.DataBind()

    End Sub

    Protected Sub SqlDataSourceUpdateMainPage_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles SqlDataSourceUpdateMainPage.Selecting

    End Sub
End Class
