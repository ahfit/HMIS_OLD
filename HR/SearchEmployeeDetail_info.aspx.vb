Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Imports System.IO

Partial Class HR_SearchEmployeeDetail_info
    Inherits System.Web.UI.Page

    Public conn As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ToString()

    'Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
    '    Dropdownlistdepartment.Items.Insert(0, "")
    'End Sub

    Protected Sub DropDownList_desg_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.DataBound
        ' DropDownList_desg.Items.Insert(0, "")
        search()

    End Sub


    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        search()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Dim Enter_Emp_id As HiddenField = CType(GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField_EmpId"), HiddenField)


        Session.Add("Enter_emp_ID", Enter_Emp_id.Value)
        Session.Add("SelectedEmpId", Enter_Emp_id.Value)
        Response.Redirect(Convert.ToString("Employee.aspx?PName=Edit+Employee&MName=Employee+Info&emp_ID=" + Convert.ToString(GridView1.SelectedValue)))

        ' Response.Write("<script language='javascript' type='text/javascript'>window.open('Reception_Main.aspx', '_top')</script>")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LabelDoctorName.Text = Session("Employee_Name")
            ' wdc_JoiningDate.Value = DateAndTime.Now.AddDays(-1)

        Catch ex As Exception

        End Try
        If IsPostBack Then
            search()
        Else
            RBL_Employee_Type.DataBind()
            RBL_Employee_Type.SelectedIndex = 0
        End If

    End Sub
    Sub search()

        Dim joindate As String = ""
        If wdc_JoiningDate.Value Is Nothing Or IsDBNull(wdc_JoiningDate.Value) Then
        Else
            joindate = Convert.ToDateTime(wdc_JoiningDate.Value).ToString("MM/dd/yyyy")
        End If

        HiddenField_CNIC.Value = TextBox_CNIC.Text

        Dim con As SqlConnection = New SqlConnection(conn)
        con.Open()
        Dim Procedurename As String = "Usp_Get_SearchEmployeeDetail_info"
        Dim cmd As New SqlCommand(Procedurename, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.CommandText = Procedurename
        cmd.Parameters.AddWithValue("@hospital_id", ddlHospital.SelectedValue)
        cmd.Parameters.AddWithValue("@deptid", Dropdownlistdepartment.SelectedValue)
        cmd.Parameters.AddWithValue("@Designation_ID", DropDownList_desg.SelectedValue)
        cmd.Parameters.AddWithValue("@Employee_Type_ID", RBL_Employee_Type.SelectedValue)
        cmd.Parameters.AddWithValue("@employeename", TextBox_Employee_name.Text)
        cmd.Parameters.AddWithValue("@cnic", TextBox_CNIC.Text)
        cmd.Parameters.AddWithValue("@mobile_number", TextBox_Phone.Text)
        cmd.Parameters.AddWithValue("@joindate", joindate)
        Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
        Dim dt As DataTable = New DataTable()
        sda.Fill(dt)
        GridView1.DataSource = dt
        GridView1.DataBind()

        'Dim dssa As New DataSourceSelectArguments()
        'dssa.AddSupportedCapabilities(DataSourceCapabilities.RetrieveTotalRowCount)
        'dssa.RetrieveTotalRowCount = True
        'Dim dv As DataView = DirectCast(SqlDataSourceGrid.[Select](dssa), DataView)
        'Label1.Text = "<font color=#ff0000>Total Records Found: {" + Convert.ToString(dv.Table.Rows.Count) + "}</font>"
        con.Close()
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
        Response.Redirect(Convert.ToString("HR_Performs.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + Request.QueryString(empid.Value)))

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

    Protected Sub lbtnEmpBenifit_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim empid As HiddenField = CType(gv.FindControl("HiddenField_EmpId"), HiddenField)
        Session.Add("Enter_emp_ID", empid.Value)
        Session.Add("SelectedEmpId", empid.Value)
        Response.Redirect(Convert.ToString("~/Operation_Theater/EmployeeBenifit.aspx?emp_id=" + empid.Value))


    End Sub

    Protected Sub lbtnGenrateID_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbtn As LinkButton = sender
        Response.Redirect("~/hr/Consultantcard.aspx?empid=" + lbtn.CommandArgument)




    End Sub

    Protected Sub Dropdownlistdepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.SelectedIndexChanged
        DropDownList_desg.DataBind()
        DropDownList_desg.DataBind()


        search()
    End Sub

    Protected Sub ddlHospital_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlHospital.SelectedIndexChanged
        Dropdownlistdepartment.DataBind()

    End Sub

    Protected Sub DropDownList_desg_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.TextChanged
        GridView1.DataBind()


    End Sub

    Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click

        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "SearchActive Employee Info" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        'Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        'Dim cell As New TableHeaderCell()
        'cell.Text = "Search Employee Detail info"
        'cell.ColumnSpan = 51
        'row.Controls.Add(cell)
        'row.BackColor = ColorTranslator.FromHtml("#19efec")
        'row.Font.Bold = True
        'GridView1.HeaderRow.Parent.Controls.AddAt(0, row)
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
    Protected Sub ddl_DesgMain_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim a As String = ddl_DesgMain.SelectedValue.ToString()
        DropDownList_desg.DataBind()
    End Sub
    Protected Sub GridView1_DataBound(sender As Object, e As EventArgs)
        Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        Dim cell As New TableHeaderCell()
        cell.Text = "Search Employee Detail info"
        cell.ColumnSpan = 25
        row.Controls.Add(cell)
        row.BackColor = ColorTranslator.FromHtml("#19efec")
        row.Font.Bold = True
        GridView1.HeaderRow.Parent.Controls.AddAt(0, row)
    End Sub
End Class
