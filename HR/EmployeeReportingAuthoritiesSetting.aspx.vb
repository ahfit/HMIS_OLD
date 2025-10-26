Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports Microsoft.Reporting.WebForms


Partial Class HR_EmployeeReportingAuthoritiesSetting
    Inherits System.Web.UI.Page
    Dim _dt As New DataTable()


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'BindGrid()
            ddlSubDepartment.DataBind()
            CheckBoxList_Emp.DataBind()

            If Not Request.QueryString("Subdept") Is Nothing Then
                ddlSubDepartment.SelectedValue = Request.QueryString("Subdept").ToString()
                CheckBoxList_Emp.DataBind()
            End If
            If Not Request.QueryString("EmpId") Is Nothing Then
                CheckBoxList_Emp.SelectedValue = Request.QueryString("EmpId").ToString()
            End If
            ShowAuthorities()
        End If

    End Sub

    Private Function get_Levels() As DataTable
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Dim dt As New DataTable()
        Using con As New SqlConnection(constr)
            con.Open()
            Dim query As String = "select LevelNum,Level from HRAuthorityLevel"
            Using cmd As New SqlCommand(query)
                cmd.Connection = con
                Using sda As New SqlDataAdapter()
                    sda.SelectCommand = cmd
                    sda.Fill(dt)
                    cmd.CommandType = CommandType.Text
                    con.Close()
                End Using
            End Using
        End Using
        Return dt
    End Function
    Private Sub BindGrid()
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Dim dt As New DataTable()
        Using con As New SqlConnection(constr)
            Using cmd As New SqlCommand("select Category,CategoryId from HROperationCategory")
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    sda.Fill(dt)

                End Using
            End Using
        End Using
        GridView1.DataSource = dt
        GridView1.DataBind()
    End Sub
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        'Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString

        'If e.Row.RowType = DataControlRowType.DataRow Then
        '    Dim radiobtn2 As RadioButtonList = DirectCast(e.Row.FindControl("radiobtn"), RadioButtonList)
        '    Dim hf_catid As HiddenField = DirectCast(e.Row.FindControl("hiddenfield1"), HiddenField)

        '    Dim dt As New DataTable
        '    dt = get_Levels()
        '    radiobtn2.DataSource = dt
        '    radiobtn2.DataTextField = "Level"
        '    radiobtn2.DataValueField = "LevelNum"
        '    radiobtn2.DataBind()
        '    Dim dt1 As New DataTable
        '    dt1 = get_MaxLevels(hf_catid.Value)
        '    If dt1.Rows.Count > 0 Then
        '        Dim s As String = dt1.Rows(0)("MaxLevel").ToString()

        '        radiobtn2.SelectedValue = s
        '    End If
        'End If
    End Sub
    Protected Sub Button_Save_Click(sender As Object, e As EventArgs)

        'Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        'For i As Integer = 0 To GridView1.Rows.Count - 1
        '    Dim radiobtnNew As RadioButtonList = CType(GridView1.Rows(i).FindControl("radiobtn"), RadioButtonList)
        '    Dim hf_catid As HiddenField = CType(GridView1.Rows(i).FindControl("hiddenfield1"), HiddenField)

        '    Dim con As SqlConnection = New SqlConnection(constr)
        '    con.Open()

        '    Dim command As SqlCommand = New SqlCommand("uspEmployeeMaxAuthorityLevel", con)
        '    command.CommandType = CommandType.StoredProcedure
        '    command.Parameters.AddWithValue("@EmpId", Request.QueryString("Emp_Id"))
        '    command.Parameters.AddWithValue("@CategoryId", hf_catid.Value)
        '    command.Parameters.AddWithValue("@MaxLevel", radiobtnNew.SelectedValue)
        '    command.ExecuteNonQuery()
        '    con.Close()
        'Next

        '    Try
        '        Dim ds As New DataSet
        '        Dim da As New SqlDataAdapter
        '        Dim cmd As New SqlCommand("uspEmployeeAuthoritySettingReport", con)
        '        cmd.CommandType = CommandType.StoredProcedure

        '        ' cmd.Parameters.AddWithValue("@Emp_Id", ddlEmployeeName.SelectedValue)
        '        
        '        da.SelectCommand = cmd
        '        da.Fill(ds)

        '    Dim ReportViewer1 As ReportViewer = New ReportViewer()
        '    Dim rds As New ReportDataSource
        '    rds.Name = "DataSet1"
        '    rds.Value = ds.Tables(0)

        '    ReportViewer1.LocalReport.DataSources.Clear()
        '    ReportViewer1.LocalReport.ReportPath = "./HR/EmployeeAuthorityReport.rdlc"
        '    ReportViewer1.LocalReport.DataSources.Add(rds)
        '    AddHandler ReportViewer1.LocalReport.SubreportProcessing, AddressOf Me.SubreportProcessingEventHandler
        '    ReportViewer1.LocalReport.Refresh()

        '    If (Request.Browser.Browser.Equals("Chrome")) Then
        '        Dim bytes() As Byte = ReportViewer1.LocalReport.Render("PDF")
        '        Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
        '        Response.ContentType = "application/pdf"
        '        Response.BinaryWrite(bytes)
        '        Response.End()
        '    Else
        '        ReportViewer1.Visible = True
        '    End If

        '    Catch ex As Exception
        '    Response.Write(ex.Message)
        '    End Try
    End Sub
    'Protected Sub SubreportProcessingEventHandler(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
    '    e.DataSources.Clear()
    '    Dim dt As DataTable = CType(Session("DynamicHeader"), DataTable)
    '    e.DataSources.Add(New ReportDataSource("DataSet1", dt))
    '    e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
    'End Sub



    Private Function get_MaxLevels(ByVal catid As String) As DataTable
        'Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        'Dim dt As New DataTable()
        'Using con As New SqlConnection(constr)
        '    con.Open()
        '    Dim query As String = "select EmpId,CategoryId,MaxLevel  from  HREmployeeMaxAuthorityLevel where EmpId=@EmpId and CategoryId=@CategoryId"
        '    Using cmd As New SqlCommand(query)
        '        cmd.Connection = con
        '        cmd.CommandType = CommandType.Text
        '        Using sda As New SqlDataAdapter()
        '            sda.SelectCommand = cmd
        '            cmd.Parameters.AddWithValue("@EmpId", Request.QueryString("Emp_Id"))
        '            cmd.Parameters.AddWithValue("@CategoryId", catid.ToString)
        '            sda.Fill(dt)
        '            con.Close()
        '        End Using
        '    End Using
        'End Using
        'Return dt

    End Function
    Private Sub BindGrid1()
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Dim dt3 As New DataTable()
        Using con As New SqlConnection(constr)
            'Using cmd As New SqlCommand("select LevelId,Level from HRAuthorityLevel where LevelId <=" & LevelId)
            Using cmd As New SqlCommand("select 'Authority : ' + AuthorityNo AS Authority, AuthorityNo from HRApprovalAuthorityLevels")
                Using sda As New SqlDataAdapter()
                    cmd.Connection = con
                    sda.SelectCommand = cmd
                    sda.Fill(dt3)
                End Using
            End Using
        End Using
        GridView3.DataSource = dt3
        GridView3.DataBind()


    End Sub
    Private Sub get_dropdown()
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString

        Using con As New SqlConnection(constr)
            con.Open()
            Dim query As String = "select '--None--' As EMPLOYEE_NAME,0 AS EmpID,'' AS Name union SELECT ISNULL(Employee.EFName+' ', '') + ISNULL(Employee.EMName+' ', '')  + ISNULL(Employee.ELName+' ', '') +  Convert(nvarchar,EmpID) +' ('+ ISNULL(d.Designation_Name,'') +')' AS EMPLOYEE_NAME , EmpID,ISNULL(Employee.EFName+' ', '') + ISNULL(Employee.EMName+' ', '')  + ISNULL(Employee.ELName,'') AS Name from Employee left outer join Designation d on d.Designation_ID=Employee.DesignationID where (Employee.ActiveStatus = 1) order by Name ASC"
            Using cmd As New SqlCommand(query)
                cmd.Connection = con
                Using sda As New SqlDataAdapter()
                    sda.SelectCommand = cmd
                    sda.Fill(_dt)
                    cmd.CommandType = CommandType.Text
                    con.Close()
                End Using
            End Using
        End Using

        Return
    End Sub

    Protected Sub gridview3_rowdatabound(sender As Object, e As GridViewRowEventArgs)
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString

        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim ddl_emp As DropDownList = DirectCast(e.Row.FindControl("ddlEmployee"), DropDownList)
            'Dim hf_lev As HiddenField = DirectCast(e.Row.FindControl("hf_level"), HiddenField)
            Dim hf_Auth As HiddenField = CType(e.Row.FindControl("Hf_AuthorityId"), HiddenField)

            ddl_emp.DataSource = _dt
            ddl_emp.DataBind()
            Dim dt1 As New DataTable
            dt1 = get_Authority(hf_catid.Value, hf_level.Value, hf_Auth.Value)
            If dt1.Rows.Count > 0 Then
                Dim s As String = dt1.Rows(0)("approvalauthority").ToString()
                ddl_emp.SelectedValue = s
            End If
        End If
    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        'Dim btn As Button = CType(sender, Button)
        ' Dim CatID As String = btn.CommandArgument

        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Dim EmpIds As String = ""
        Dim con As SqlConnection = New SqlConnection(constr)
        For i As Integer = 0 To GridView3.Rows.Count - 1
            'Dim radioLabel As HiddenField = CType(GridView3.Rows(i).FindControl("hf_level"), HiddenField)
            'Dim catid As LinkButton = CType(GridView3.Rows(i).FindControl("hf_catid"), LinkButton)
            'Dim hf_catid As HiddenField = CType(GridView3.Rows(i).FindControl("hiddenfield1"), HiddenField)
            Dim hf_Auth As HiddenField = CType(GridView3.Rows(i).FindControl("Hf_AuthorityId"), HiddenField)
            Dim ddl_emp As DropDownList = CType(GridView3.Rows(i).FindControl("ddlEmployee"), DropDownList)
            If ddl_emp.SelectedValue <> "0" Then
                con.Open()
                Dim command As SqlCommand = New SqlCommand("usp_InsertEmployeeAuthorities", con)
                command.CommandType = CommandType.StoredProcedure
                command.Parameters.AddWithValue("@Emp_Id", Request.QueryString("Emp_Id"))
                command.Parameters.AddWithValue("@CategoryId", hf_catid.Value)
                command.Parameters.AddWithValue("@LevelId", hf_level.Value)
                command.Parameters.AddWithValue("@ApprovalAuthority", ddl_emp.SelectedValue)
                command.Parameters.AddWithValue("@AuthorityNo", hf_Auth.Value)
                'command.Parameters.AddWithValue("@EmpIDs", EmpIds)
                command.ExecuteNonQuery()
                con.Close()

                'If EmpIds = "0" Then
                '    EmpIds = EmpIds + ddl_emp.SelectedValue
                'Else
                '    EmpIds = "," + ddl_emp.SelectedValue

                'End If
            End If

        Next
        pnlAuthority.Visible = False
        ShowAuthorities()
    End Sub
    Protected Sub lnkAuthority_Click(sender As Object, e As EventArgs)
        Dim link As LinkButton = DirectCast(sender, LinkButton)
        hf_catid.Value = link.CommandArgument
        pnlAuthority.Visible = True
        get_dropdown()
        Dim row As GridViewRow = link.NamingContainer
        Dim radiobtn As RadioButtonList = DirectCast(row.FindControl("radiobtn"), RadioButtonList)

        'Dim leveId As Integer = radiobtn.SelectedValue
        hf_level.Value = radiobtn.SelectedValue
        BindGrid1()
    End Sub
    Protected Sub btnClose_Click(sender As Object, e As EventArgs)
        pnlAuthority.Visible = False

    End Sub
    Private Function get_Authority(ByVal catid As Integer, ByVal levelId As Integer, ByVal AuthNo As Integer) As DataTable
        Dim constr As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        Dim dt As New DataTable()
        Using con As New SqlConnection(constr)
            con.Open()
            Dim query As String = "select ApprovalAuthority FROM HREmployeeAuthoritySub where Emp_Id=@Emp_Id and CategoryId=@CategoryId  and LevelId=@levelId and AuthorityNo = @AuthNo order by AuthorityNo"
            Using cmd As New SqlCommand(query)
                cmd.Connection = con
                cmd.CommandType = CommandType.Text
                Using sda As New SqlDataAdapter()
                    sda.SelectCommand = cmd
                    cmd.Parameters.AddWithValue("@Emp_Id", Request.QueryString("Emp_Id"))
                    cmd.Parameters.AddWithValue("@CategoryId", catid)
                    cmd.Parameters.AddWithValue("@levelId", levelId)
                    cmd.Parameters.AddWithValue("@AuthNo", AuthNo)

                    sda.Fill(dt)
                    con.Close()
                End Using
            End Using
        End Using
        Return dt

    End Function
    Protected Sub radiobtn_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim radiobtn As RadioButtonList = DirectCast(sender, RadioButtonList)
        'Dim link As LinkButton = DirectCast(sender, LinkButton)
        'hf_catid.Value = link.CommandArgument
        pnlAuthority.Visible = True
        get_dropdown()
        Dim row As GridViewRow = radiobtn.NamingContainer
        hf_catid.Value = DirectCast(row.FindControl("hf_CategoryId"), HiddenField).Value
        lblCategory.Text = DirectCast(row.FindControl("lblcategory"), Label).Text + " : "
        'Dim radiobtn As RadioButtonList = DirectCast(row.FindControl("radiobtn"), RadioButtonList)

        'Dim leveId As Integer = radiobtn.SelectedValue
        hf_level.Value = radiobtn.SelectedValue
        lblLevel.Text = radiobtn.SelectedItem.Text
        BindGrid1()
    End Sub
    Private Sub ShowAuthorities()
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString)
        Try
            con.Open()
            cmd = New SqlCommand("usp_GetEmployeeApprovalAuthorities", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@EmpID", ddlApprovalAuthority2.SelectedValue)
            cmd.Parameters.AddWithValue("@SubDeptId", ddlSubDepartment.SelectedValue)
            cmd.Parameters.AddWithValue("@LevelId", ddlLevels.SelectedValue)
            'cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            'cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            gvd_EmployeeAuthorities.DataSource = dt
            gvd_EmployeeAuthorities.DataBind()
            con.Close()
        Catch ex As Exception
            con.Close()
        End Try


    End Sub
    Protected Sub lnk_Delete_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = DirectCast(sender, LinkButton)
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString)
        Try

            cmd = New SqlCommand("delete from HREmployeeAuthoritySub where Id= @Id", con)

            cmd.Parameters.AddWithValue("@Id", lnk.CommandArgument)
            'cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            'cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
        ShowAuthorities()
    End Sub
    Protected Sub ddlSubDepartment_SelectedIndexChanged(sender As Object, e As EventArgs)
        CheckBoxList_Emp.DataBind()
        ShowAuthorities()
    End Sub
    Protected Sub btn_Save_Click(sender As Object, e As EventArgs)
        Dim Emp_List As String = ""
        Dim Auth_List As String = ""

        'If ddlApprovalAuthority.SelectedValue <> "0" And ddlApprovalAuthority2.SelectedValue <> "0" Then
        '    Auth_List = Auth_List + "<data><auth_id>" + ddlApprovalAuthority.SelectedValue + "</auth_id></data>"
        '    Auth_List = Auth_List + "<data><auth_id>" + ddlApprovalAuthority2.SelectedValue + "</auth_id></data>"
        'ElseIf ddlApprovalAuthority.SelectedValue <> "0" And ddlApprovalAuthority2.SelectedValue = "0" Then
        '    Auth_List = Auth_List + "<data><auth_id>" + ddlApprovalAuthority.SelectedValue + "</auth_id></data>"
        'End If

        For i As Integer = 0 To CheckBoxList_Emp.Items.Count - 1
            ' Exit condition if the value is three.
            If CheckBoxList_Emp.Items(i).Selected = True Then
                hfd_employee.Value = CheckBoxList_Emp.Items(i).Value
                Emp_List = Emp_List + "<data><emp_id>" + hfd_employee.Value + "</emp_id></data>"
            End If
        Next
        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
        command.CommandText = "usp_AssignEmployeeAuthorities"
        command.CommandType = CommandType.StoredProcedure
        command.Connection = connection
        command.Parameters.AddWithValue("@EmpList", Emp_List)
        command.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue)
        command.Parameters.AddWithValue("@LevelId", ddlLevels.SelectedValue)
        command.Parameters.AddWithValue("@ApprovalAuthority", ddlApprovalAuthority.SelectedValue)
        command.Parameters.AddWithValue("@ApprovalAuthority2", 0)
        'command.Parameters.AddWithValue("@AuthList", Auth_List)
        connection.Open()
        command.ExecuteNonQuery()
        connection.Close()

        ShowAuthorities()
    End Sub
    Protected Sub cbAll_CheckedChanged(sender As Object, e As EventArgs)
        For index = 0 To CheckBoxList_Emp.Items.Count - 1
            CheckBoxList_Emp.Items(index).Selected = cbAll.Checked
        Next
    End Sub

    Protected Sub ddlApprovalAuthority2_SelectedIndexChanged(sender As Object, e As EventArgs)
        ShowAuthorities()
    End Sub

    Protected Sub ddlLevels_SelectedIndexChanged(sender As Object, e As EventArgs)
        ShowAuthorities()
    End Sub
End Class
