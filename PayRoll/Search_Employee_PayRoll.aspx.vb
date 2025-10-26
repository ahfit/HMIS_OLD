Imports System.Data
Imports System.Data.SqlClient

Partial Class HR_Search_Employee_PayRoll
    Inherits System.Web.UI.Page

    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        Dropdownlistdepartment.Items.Insert(0, "")
    End Sub

    Protected Sub DropDownList_desg_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.DataBound
        DropDownList_desg.Items.Insert(0, "")
    End Sub


    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        search()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As HiddenField = CType(GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_EmpId"), HiddenField)


        Session.Add("Enter_emp_ID", Enter_Emp_id.Value)
        Session.Add("SelectedEmpId", Enter_Emp_id.Value)
        Response.Redirect(Convert.ToString("Employee_Basic_info_edit.aspx?PName=Edit+Employee&MName=Employee+Info&emp_ID=" + Convert.ToString(GridView1.SelectedValue)))

        ' Response.Write("<script language='javascript' type='text/javascript'>window.open('Reception_Main.aspx', '_top')</script>")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LabelDoctorName.Text = Session("Employee_Name")
        Catch ex As Exception

        End Try
        If Not IsPostBack Then
            GetEmployeeTypes()
            RBL_Employee_Type.SelectedIndex = 0
        End If


    End Sub
    Protected Sub GetEmployeeTypes()
        Dim dbMgr As DbManager = New DbManager()

        Dim sqlParm As SqlParameter() = {}

        RBL_Employee_Type.DataSource = dbMgr.ExecuteDataTableWithQuery("GetEmployeeTypes", "BasicDataInfoConnectionString", sqlParm)
        RBL_Employee_Type.DataBind()
        RBL_Employee_Type.Items.Insert(0, New ListItem("All", "0"))

    End Sub
    Sub search()
        HiddenField_CNIC.Value = TextBox_CNIC.Text

        Dim query As String
        Dim where As String
        Dim orderBy As String
        where = " where  (CONVERT(varchar, Employee.EmpID) LIKE '%') and (Employee.Is_Deleted = 0) and (Employee.ActiveStatus=1) "
        query = "SELECT     ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS EmployeeName, ISNULL(Employee.Relation, '')  + ' ' + ISNULL(Employee.RFName, '') + ' ' + ISNULL(Employee.RMName, ' ') + ' ' + ISNULL(Employee.RLName, ' ') AS RelationName, Employee.CNIC, Employee.EmpID, CONVERT(varchar, Employee.JoinDate, 107) AS [Join Date], Designation.Min_PayScale, Designation.Designation_Name, Department.Dept_Name + ' ( ' + Hospital_Abb + ' ) ' Dept_Name, Employee.Emp_No, Employee.DesignationID, Employee.PayScale, Employee.Employee_Type_ID, Hospital.Hospital_Abb FROM Employee INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Hospital ON Department.Hospital_ID = Hospital.Hospital_ID LEFT OUTER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID"
        If Dropdownlistdepartment.SelectedValue = "" Then

        Else
            where = where + " And (Employee.DeptID = " + Dropdownlistdepartment.SelectedValue + ")"
        End If

        If DropDownList_desg.SelectedValue = "" Then

        Else
            where = where + " And (Employee.DesignationID = " + DropDownList_desg.SelectedValue + ")"
        End If

        If HiddenField_CNIC.Value = "     -       - " Then

        Else
            where = where + " And (Convert(varchar,Employee.CNIC) Like '" + HiddenField_CNIC.Value + "%')"
        End If

        ''''''''''''''''''''''''''

        If TextBox_Employee_name.Text = "" Then

        Else
            Dim str As String = " AND (isnull(Employee.EFName,'') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') Like '%"
            where = where + str.Trim + TextBox_Employee_name.Text.Trim + "%')"
        End If

        If RBL_Employee_Type.SelectedValue <> 0 Then
            where = where + " And (Employee.Emp_Type = " + RBL_Employee_Type.SelectedValue + ")"
        End If

        orderBy = " ORDER BY isnull(Employee.EFName,'') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') "
        'orderBy = " ORDER BY Employee.EmpID DESC"
        query = query + where + orderBy
        SqlDataSourceGrid.SelectCommand = query
        ' Response.Write(query)
        GridView1.DataSourceID = "SqlDataSourceGrid"

        GridView1.DataBind()

        Dim dssa As New DataSourceSelectArguments()
        dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount)
        dssa.RetrieveTotalRowCount = True
        Dim dv As DataView = DirectCast(SqlDataSourceGrid.[Select](dssa), DataView)
        Label1.Text = "<font color=#ff0000>Total Records Found: {" + Convert.ToString(dv.Table.Rows.Count) + "}</font>"

    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "DelEmployee" Then
            'Response.Write(e.CommandArgument)
            HiddenField_Emp_ID.Value = e.CommandArgument
            SqlDataSourceEmpDelStatus.Update()
            search()
        End If
    End Sub

    Protected Sub LinkButton_Education_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + empid.Value))


    End Sub

    Protected Sub LinkButton_Certification_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Skill_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("skills.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_AdditionalInfo_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Relationship_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton_Documents_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + empid.Value))

    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub lnkViewDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lik As LinkButton = sender
        Session.Add("employeeid", lik.CommandArgument)
        Response.Redirect("~/Administrator/participant.aspx")
    End Sub


    Protected Sub DropDownList_Hospital_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_Hospital.SelectedIndexChanged

    End Sub
End Class
