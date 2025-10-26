Imports System.Data.SqlClient
Imports System.Data

Partial Class Assign_Duty_To_EmployeeGrid
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            WebDateChooser1.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            WebDateChooser2.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.DaysInMonth(DateTime.Now.Year, DateTime.Now.Month))
            DropDownListSubDepartment.DataBind()
            fillemployeedropdown()
        End If
    End Sub
    Protected Sub fillemployeedropdown()
        Try

            Dim cnString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim conn As SqlConnection = New SqlConnection(cnString)


            Dim cmd As SqlCommand = New SqlCommand("SELECT ISNULL(Employee.EFName, ' ') + ' ' + ISNULL(Employee.EMName, ' ') + ' ' + ISNULL(Employee.ELName, ' ') + ' '+ Convert(nvarchar,EmpID) +' ('+ ISNULL(d.Designation_Name,'') +')' AS EMPLOYEE_NAME , EmpID from Employee left outer join Designation d on d.Designation_ID=Employee.DesignationID where (SubDeptid=@subdeptid) And (Employee.ActiveStatus = 1) order by EFName ASC", conn)
            cmd.CommandType = Data.CommandType.Text
            cmd.Parameters.AddWithValue("@subdeptid", DropDownListSubDepartment.SelectedValue)
        
            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            DDLEmployee.DataSource = dt
            DDLEmployee.DataTextField = "EMPLOYEE_NAME"
            DDLEmployee.DataValueField = "EmpID"
            DDLEmployee.DataBind()
        Catch ex As Exception

        End Try

    End Sub
    Private Function RetrnGridData() As DataTable
        Dim cnString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim conn As SqlConnection = New SqlConnection(cnString)


        Dim cmd As SqlCommand = New SqlCommand("usp_SelectdutyFromEmpRoaster", conn)
        cmd.CommandType = Data.CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@stDate", WebDateChooser1.Value)
        cmd.Parameters.AddWithValue("@edate", WebDateChooser2.Value)
        cmd.Parameters.AddWithValue("@empid", DDLEmployee.SelectedValue)
        Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable()
        sda.Fill(dt)
        Return dt

    End Function

    Protected Sub LoadGrid()
        Try
            Dim dt As DataTable = New DataTable()
            dt = RetrnGridData()
            GridViewEmployeeShift.DataSource = dt
            GridViewEmployeeShift.DataBind()
        Catch ex As Exception

        End Try
    End Sub



    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click

        Try
            LoadGrid()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

       
    End Sub

    Protected Sub WebDateChooser1_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser1.ValueChanged
        Try
            HiddenField_Date_Start.Value = WebDateChooser1.Value
            WebDateChooser2.MinDate = WebDateChooser1.Value
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub WebDateChooser2_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooser2.ValueChanged
        Try
            HiddenField_Date_End.Value = WebDateChooser2.Value
            GridViewEmployeeShift.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub






    Protected Sub DropDownListSubDepartment_SelectedIndexChanged1(sender As Object, e As EventArgs)
        fillemployeedropdown()
    End Sub

    Protected Sub Btnsave_Click(sender As Object, e As EventArgs)

        Try

            For Each row In GridViewEmployeeShift.Rows


                Dim cnString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                Dim conn As SqlConnection = New SqlConnection(cnString)


                Dim cmd As SqlCommand = New SqlCommand("UpdateEmpDutyRoaster", conn)
                cmd.CommandType = Data.CommandType.StoredProcedure
                Dim DDLshift As DropDownList = DirectCast(row.FindControl("DDLgridShift"), DropDownList)
                Dim SubDeptId As HiddenField = DirectCast(row.FindControl("SubDeptId"), HiddenField)

                Dim Roasterid As HiddenField = DirectCast(row.FindControl("Roasterid"), HiddenField)
                Dim emproasterid As HiddenField = DirectCast(row.FindControl("emproasterid"), HiddenField)
                Dim HFDForEmpID As HiddenField = DirectCast(row.FindControl("HFDForEmpID"), HiddenField)
                Dim HFDForDate As HiddenField = DirectCast(row.FindControl("HFDForDate"), HiddenField)

                If DDLshift.SelectedValue = 0 Then
                    cmd.Parameters.AddWithValue("@offday", 1)
                Else
                    cmd.Parameters.AddWithValue("@offday", 0)
                End If
                cmd.Parameters.AddWithValue("@deptid", SubDeptId.Value)
                cmd.Parameters.AddWithValue("@shidtid", DDLshift.SelectedValue)
                cmd.Parameters.AddWithValue("@HFDForEmpID", HFDForEmpID.Value)
                cmd.Parameters.AddWithValue("@HFDForDate", HFDForDate.Value)
                cmd.Parameters.AddWithValue("@emprosterid", emproasterid.Value)
                cmd.Parameters.AddWithValue("@rosterid", Roasterid.Value)
                cmd.Parameters.AddWithValue("@PreparedBy", Session("Emp_ID"))
                conn.Open()
                cmd.ExecuteNonQuery()
                Dim message As String = "Saved Successfully !!!!!"

                Dim sb As New System.Text.StringBuilder()

                sb.Append("<script type = 'text/javascript'>")

                sb.Append("window.onload=function(){")

                sb.Append("alert('")

                sb.Append(message)

                sb.Append("')};")

                sb.Append("</script>")

                ClientScript.RegisterClientScriptBlock(Me.GetType(), "alert", sb.ToString())
                conn.Close()

            Next
        Catch ex As Exception

        End Try
        Try
            LoadGrid()
        Catch ex As Exception

        End Try


    End Sub

    Protected Sub btnReport_Click(sender As Object, e As EventArgs)


        Response.Redirect("~/Duty_Rouster/Duty_Rouster_ReportMonthWise.aspx?id=0&Sdate=" + WebDateChooser1.Value + " &EDate=" + WebDateChooser2.Value + "&Dept=0&SubDept=0&EmpID=" + DDLEmployee.SelectedValue)
    End Sub

    Protected Sub GridViewEmployeeShift_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim cnString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim conn As SqlConnection = New SqlConnection(cnString)

            Dim ShiftID As HiddenField = DirectCast(e.Row.FindControl("ShiftID"), HiddenField)
            Dim SubDeptId As HiddenField = DirectCast(e.Row.FindControl("SubDeptId"), HiddenField)

            Dim HFDIsApproved As HiddenField = DirectCast(e.Row.FindControl("HFDIsApproved"), HiddenField)
            Dim HFDEmpid As HiddenField = DirectCast(e.Row.FindControl("HFDEmpid"), HiddenField)
            Dim DDLgridShift As DropDownList = DirectCast(e.Row.FindControl("DDLgridShift"), DropDownList)
            Dim cmd As SqlCommand = New SqlCommand("Select 0 as ShiftID, 'Off Day' as ShiftName UNION Select ShiftID,ShiftName from Admin_Shift inner join Admin_DutyRoster on Admin_DutyRoster.Shift_ID=Admin_Shift.ShiftID  where SubDeptId =@subdeptid ORDER BY ShiftName", conn)
            cmd.CommandType = Data.CommandType.Text

            cmd.Parameters.AddWithValue("@subdeptid", SubDeptId.Value)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            DDLgridShift.DataSource = dt
            DDLgridShift.DataValueField = "ShiftID"
            DDLgridShift.DataTextField = "ShiftName"
            DDLgridShift.DataBind()
            DDLgridShift.SelectedValue = ShiftID.Value
            If HFDIsApproved.Value = "True" And Not (HFDEmpid.Value = Session("Emp_ID")) Then
                DDLgridShift.Enabled = False

            End If

        End If
    End Sub
    Protected Sub GridViewEmployeeShift_Sorting(sender As Object, e As GridViewSortEventArgs)
        Try
            Dim dt As DataTable = New DataTable()

            dt = RetrnGridData()
            If dt.Rows.Count > 0 Then
                Dim dataView As DataView = New DataView(dt)
                dataView.Sort = e.SortExpression + "" + ConvertSortDirectionToSql(e.SortExpression)
                GridViewEmployeeShift.DataSource = dataView

                ' GridViewEmployeeShift.DataSource = dt

                GridViewEmployeeShift.DataBind()
            End If
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub GridViewEmployeeShift_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        GridViewEmployeeShift.PageIndex = e.NewPageIndex
        LoadGrid()
    End Sub
    Private Property GridViewSortDirection As String
        Get
            Return If(TryCast(ViewState("SortDirection"), String), "DESC")
        End Get
        Set(ByVal value As String)
            ViewState("SortDirection") = value
        End Set
    End Property

    Private Function ConvertSortDirectionToSql(ByVal sortDirection As SortDirection) As String
        Select Case GridViewSortDirection
            Case "ASC"
                GridViewSortDirection = "DESC"
            Case "DESC"
                GridViewSortDirection = "ASC"
        End Select

        Return GridViewSortDirection
    End Function

End Class
