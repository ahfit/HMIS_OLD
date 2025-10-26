Imports System.Data
Imports System.Data.SqlClient

Partial Class PayRoll_MakeSalaryGov
    Inherits System.Web.UI.Page
    Dim _conStr As String = ConfigurationManager.ConnectionStrings("PayRoll_ConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try


            HiddenField_Emp_ID.Value = Session("emp_id")
            If Not IsPostBack Then
                ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
                btn_Allslips.Visible = False
                dropdownlist_Hospital.SelectedValue = Session("Hospital_ID")
                DropDownList_desg.DataBind()
                Dropdownlistdepartment.DataBind()
                DropDownList_JobType.DataBind()
                DropDownList_year.Items.Clear()
                DropDownList_Month.SelectedValue = Date.Today.Month
                dropdownlist_Hospital.DataBind()

                Dim count As Integer = 0
                For count = 0 To 9
                    DropDownList_year.Items.Insert(count, Date.Today.Year + count - 1)
                Next
                DropDownList_year.SelectedValue = Date.Today.Year

            End If
            GridView_Employees.Visible = True
        Catch ex As Exception

        End Try




    End Sub
    Sub color()
        Try

            For count As Integer = 0 To GridView_Employees.Rows.Count - 1
                Dim hid As HiddenField = GridView_Employees.Rows(count).FindControl("HiddenField2")
                Dim Label_Allowance As Label = GridView_Employees.Rows(count).FindControl("Label_Allowance")
                'Dim Label_Deduction As Label = GridView_Employees.Rows(count).FindControl("Label_Deduction")
                'Dim Label_Transfer As Label = GridView_Employees.Rows(count).FindControl("Label_Transfer")
                Dim linkRpt As LinkButton = GridView_Employees.Rows(count).FindControl("LinkButton_Rpt")
                'Try
                '    Label_Transfer.Text = Label_Allowance.Text - Label_Deduction.Text
                'Catch ex As Exception
                '    Label_Transfer.Text = "0"
                'End Try
                'Label_Transfer.Text = Label_Allowance.Text - Label_Deduction.Text

                'If Label_Allowance.Text.Trim.Length = 0 Then
                '    Label_Allowance.Text = "0"
                'End If

                'If Label_Deduction.Text.Trim.Length = 0 Then
                '    Label_Deduction.Text = "0"
                'End If

                'Label_Transfer.Text = Convert.ToDecimal(Label_Allowance.Text) - Convert.ToDecimal(Label_Deduction.Text)

                Dim connection As New SqlConnection
                Dim command As New SqlCommand
                Dim reader As SqlDataReader
                connection.ConnectionString = ConfigurationManager.ConnectionStrings("PayRollConnectionString").ConnectionString
                command = connection.CreateCommand
                command.CommandText = "SELECT DISTINCT  Salary_ID FROM Employee_Salary where Salary_ID='" + hid.Value + "-" + Convert.ToString(DropDownList_Month.SelectedValue).PadLeft(2, "0") + "-" + DropDownList_year.SelectedValue + "' and Is_Approve = 1 "
                connection.Open()
                reader = command.ExecuteReader
                If reader.Read Then
                    GridView_Employees.Rows(count).BackColor = System.Drawing.Color.Cyan
                    linkRpt.Visible = True
                End If


                reader.Close()
                connection.Close()
                connection.Dispose()
                ' Sub Grid Bind
                'Dim HD_empid As HiddenField = GridView1.Rows(count).FindControl("HiddenField_EmpidAllow")
                'HD_empid.Value = hid.Value

                ''Dim HD_SalaryYear As HiddenField = GridView1.Rows(count).FindControl("HiddenField_SalaryYearAllow")
                ''Dim HD_SalaryMonth As HiddenField = GridView1.Rows(count).FindControl("HiddenField_SalaryMonthAllow")
                'Dim SubGridView3 As GridView = GridView_Employees.Rows(count).FindControl("GridView3")
                'SubGridView3.DataBind()

                'Dim HD_empidDed As HiddenField = GridView_Employees.Rows(count).FindControl("HiddenField_EmpidAllow")
                'Dim HD_SalaryYearDed As HiddenField = GridView_Employees.Rows(count).FindControl("HiddenField_SalaryYearAllow")
                'Dim HD_SalaryMonthDed As HiddenField = GridView_Employees.Rows(count).FindControl("HiddenField_SalaryMonthAllow")
                'Dim HD_SalaryEmpidDedu As HiddenField = GridView_Employees.Rows(count).FindControl("HiddenField_EmployeeIDDed")
                'Dim SubGridView_Ded As GridView = GridView_Employees.Rows(count).FindControl("GridView4")
                'HD_SalaryEmpidDedu.Value = hid.Value
                'SubGridView3.DataBind()
            Next
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

        HiddenField_CNIC.Value = TextBox_CNIC.Text
        Dim query As String = ""
        Dim where As String = ""
        Dim orderBy As String = ""
        If HiddenField_CNIC.Value = "     -       - " Then
            HiddenField_CNIC.Value = String.Empty
        End If
        HiddenField_NTN.Value = txtNTNnumber.Text.Trim()
        HiddenField_CNICNumber.Value = HiddenField_CNIC.Value
        HiddenField_Name.Value = TextBox_Employee_name.Text.Trim()

        GridView_Employees.DataBind()
        Session.Add("back_Month", DropDownList_Month.SelectedValue)
        Session.Add("back_Year", DropDownList_year.SelectedValue)
        color()

    End Sub
    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        ' Dropdownlistdepartment.Items.Insert(0, "All")
    End Sub
    Protected Sub DropDownList_desg_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_desg.DataBound
        ' DropDownList_desg.Items.Insert(0, "All")
    End Sub
    Protected Sub GridView1_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBound
        color()
    End Sub
    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging

        GridView1.DataSourceID = "SqlDataSource_For_Grid"

    End Sub
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Session.Add("month", DropDownList_Month.SelectedValue)
        Session.Add("year", DropDownList_year.SelectedValue)
        Dim hid As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField1")
        Response.Redirect("~/payroll/Administration_view.aspx?Employee=" + GridView1.SelectedValue.ToString + "&Emp_Type=" + hid.Value.ToString)

    End Sub
    Protected Sub LinkButton_Rpt_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim gv As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim EID As HiddenField = CType(gv.FindControl("HiddenField2"), HiddenField)
        Dim ET As HiddenField = CType(gv.FindControl("HiddenField1"), HiddenField)
        Session.Add("month", DropDownList_Month.SelectedValue)
        Session.Add("year", DropDownList_year.SelectedValue)

        Dim url As String = "Single_Employee_SalaryRptRDLC.aspx?Employee=" + EID.Value + "&status=0"""


        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open(' " + url + " ')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If
    End Sub
    Sub MakeSalaryAll()
        Dim Emp_List As String = ""
        Dim hfd_employee As New HiddenField
        Dim StringBuilders = New StringBuilder()

        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("PayRollConnectionString").ConnectionString
        connection.Open()
        For count As Integer = 0 To GridView_Employees.Rows.Count - 1
            Dim chk As CheckBox = GridView_Employees.Rows(count).FindControl("chkApprove")
            If chk.Checked Then
                
                hfd_employee = GridView_Employees.Rows(count).FindControl("HiddenField2")
                Emp_List = Emp_List + "<data><emp_id>" + hfd_employee.Value + "</emp_id></data>"

                Emp_Incometax(hfd_employee.Value, StringBuilders)

            End If

        Next

        execute_qury(StringBuilders)
        command = connection.CreateCommand
        command.CommandType = CommandType.StoredProcedure
        command.CommandText = "usp_All_Employee_month_Salary"

        command.Parameters.AddWithValue("@EmpLIst", Emp_List)
        command.Parameters.AddWithValue("@SalaryMonth", DropDownList_Month.SelectedValue)
        command.Parameters.AddWithValue("@SalaryYear", DropDownList_year.SelectedValue)
        command.ExecuteNonQuery()

        connection.Close()
        connection.Dispose()

        'If Emp_List <> "<data></data>" Then


        '    Dim connection As New SqlConnection
        '    Dim command As New SqlCommand
        '    connection.ConnectionString = ConfigurationManager.ConnectionStrings("PayRollConnectionString").ConnectionString
        '    command = connection.CreateCommand
        '    command.CommandType = CommandType.StoredProcedure
        '    command.CommandText = "usp_All_Employee_month_Salary"

        '    command.Parameters.AddWithValue("@EmpLIst", Emp_List)
        '    command.Parameters.AddWithValue("@SalaryMonth", DropDownList_Month.SelectedValue)
        '    command.Parameters.AddWithValue("@SalaryYear", DropDownList_year.SelectedValue)

        '    connection.Open()
        '    command.ExecuteNonQuery()
        '    connection.Close()
        '    connection.Dispose()
        'End If


    End Sub
    Protected Sub Button_MakeSalary_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_MakeSalary.Click
        Try
            MakeSalaryAll()
            GridView_Employees.DataBind()
            lblMsg.Text = "All Employee's Salary Made."
            lblMsg.ForeColor = Drawing.Color.Green
        Catch ex As Exception
            lblMsg.Text = "Salary creating error."
            lblMsg.ForeColor = Drawing.Color.Red
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridView1_DataBinding(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.DataBinding

    End Sub

    Protected Sub chkApprovedAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim HeaderChk As CheckBox = sender

        If HeaderChk.Checked Then
            For index = 0 To GridView_Employees.Rows.Count - 1
                Dim chk As CheckBox = GridView_Employees.Rows(index).FindControl("chkApprove")
                chk.Checked = True
            Next
        Else
            For index = 0 To GridView_Employees.Rows.Count - 1
                Dim chk As CheckBox = GridView_Employees.Rows(index).FindControl("chkApprove")
                chk.Checked = False
            Next
        End If
    End Sub

    Protected Sub btnApprove_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnApprove.Click
        Dim empids As String
        empids = String.Empty
        For index = 0 To GridView_Employees.Rows.Count - 1
            Dim chk As CheckBox = GridView_Employees.Rows(index).FindControl("chkApprove")
            If chk.Checked Then
                Dim hid As HiddenField = GridView_Employees.Rows(index).FindControl("HiddenField2")
                empids += Convert.ToString(hid.Value) + ","
            End If
        Next

        If empids.Length > 0 Then
            empids = empids.Substring(0, empids.Length - 1)
            HiddenField_EmpidsFinalSalary.Value = empids.Trim()
            SqlDataSource_FinalSalary.Update()
        End If
        color()
    End Sub

    Protected Sub GridView_Employees_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Employees.PreRender

    End Sub

    Protected Sub GridView_Employees_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Employees.SelectedIndexChanged

    End Sub

    Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Active Employee" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New IO.StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView_Employees
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

    Protected Sub RBL_Status_SelectedIndexChanged(sender As Object, e As EventArgs) Handles RBL_Status.SelectedIndexChanged
        'GridView_Employees.DataBind()

        If RBL_Status.SelectedValue.Equals("true") Then
            btn_Allslips.Visible = False
            btnApprove.Visible = True
        Else
            btn_Allslips.Visible = False
            btnApprove.Visible = False
        End If

        color()

    End Sub

    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click

        LoadReport()
    End Sub
    Private Sub LoadReport()
        GridView_Employees.Visible = False
        Dim con As New SqlConnection(_conStr)
        Try



            Dim cnin As String = TextBox_CNIC.Text            
            If cnin = "     -       - " Then
                cnin = String.Empty
            End If

            con.Open()
            Dim cmd As New SqlCommand("usp_AllSalariedEmployeeGov", con)
            cmd.CommandType = CommandType.StoredProcedure
            'cmd.Parameters.AddWithValue("@EmpLIst", Emp_List)
            cmd.Parameters.AddWithValue("@DeptID", Dropdownlistdepartment.SelectedValue)
            cmd.Parameters.AddWithValue("@hospitalID", dropdownlist_Hospital.SelectedValue)
            cmd.Parameters.AddWithValue("@designationID", DropDownList_desg.SelectedValue)

            '  If txtNTNnumber.Text.Trim() = "" Then
            cmd.Parameters.AddWithValue("@NTN", DBNull.Value)
            'Else
            'cmd.Parameters.AddWithValue("@NTN", txtNTNnumber.Text.Trim())
            'End If

            If TextBox_CNIC.Text = "     -       - " Then
                cmd.Parameters.AddWithValue("@CNIC", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@CNIC", TextBox_CNIC.Text.Trim)
            End If

            If TextBox_Employee_name.Text.Trim() = "" Then
                cmd.Parameters.AddWithValue("@name", DBNull.Value)
            Else
                cmd.Parameters.AddWithValue("@name", TextBox_Employee_name.Text.Trim)
            End If

            cmd.Parameters.AddWithValue("@SalaryMonth", DropDownList_Month.SelectedValue)
            cmd.Parameters.AddWithValue("@SalaryYear", DropDownList_year.SelectedValue)
            cmd.Parameters.AddWithValue("@Salary_status", RBL_Status.SelectedValue)
            'If txtNTNnumber.Text.Trim() = "" Then
            '    cmd.Parameters.AddWithValue("@Job_Type", DBNull.Value)
            'Else
            cmd.Parameters.AddWithValue("@Job_Type", DropDownList_JobType.SelectedValue)
            'End If
            Dim da As New SqlDataAdapter(cmd)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim rds As New ReportDataSource()
            rds.Name = "DataSet1"
            rds.Value = ds.Tables(0)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("EmployeeMakeSalaryReport.rdlc")
            ReportViewer1.LocalReport.DataSources.Add(rds)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

            ReportViewer1.LocalReport.Refresh()
            If (Request.Browser.Browser = "Chrome") Then
                Dim bytes() As Byte = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            End If



        Catch ex As Exception
        Finally
            con.Close()
        End Try

    End Sub

    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub


    Protected Sub btn_Allslips_Click(sender As Object, e As System.EventArgs) Handles btn_Allslips.Click

        Response.Redirect("Single_Employee_SalaryRpt.aspx?month=" + DropDownList_Month.SelectedValue + "&year=" + DropDownList_year.SelectedValue + "&status=1")
    End Sub

    Protected Sub Emp_Incometax(ByVal emp_id As Integer, ByRef StringBuilders As StringBuilder)

       


        StringBuilders.Append("exec dbo.usp_update_employee_tax " + emp_id.ToString() + " ")


    End Sub

    Protected Sub execute_qury(ByVal qury As StringBuilder)
        Try
            Dim command As New SqlCommand
            Dim connection As New SqlConnection
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PayRollConnectionString").ConnectionString

            connection.Open()
            command.CommandText = qury.ToString()
            command.Connection = connection

            command.ExecuteNonQuery()
            connection.Close()

        Catch ex As Exception


        End Try

    End Sub

    Protected Sub btn_RollBack_Click(sender As Object, e As EventArgs)
        'Dim btn As Button = DirectCast(sender, Button)
        'Dim row As GridViewRow = DirectCast(btn.NamingContainer, GridViewRow)

        Dim strBuilder As StringBuilder = New StringBuilder()
        Dim str As String = ""

        For i As Integer = 0 To GridView_Employees.Rows.Count - 1
            Dim c As CheckBox = DirectCast(GridView_Employees.Rows(i).FindControl("chkApprove"), CheckBox)
            Dim EmpId As HiddenField = DirectCast(GridView_Employees.Rows(i).FindControl("HiddenField2"), HiddenField)



            If c.Checked Then
                strBuilder.Append(EmpId.Value.ToString() + ",").ToString()

            End If

        Next

        Dim finalString As String = strBuilder.ToString().TrimEnd(",")

        Dim connection As New SqlConnection
        Dim command As New SqlCommand

        connection.ConnectionString = ConfigurationManager.ConnectionStrings("PayRollConnectionString").ConnectionString
        command = connection.CreateCommand
        command.CommandText = "Usp_SalaryRollback"
        command.Parameters.AddWithValue("@Emp_ID", finalString.ToString())
        command.Parameters.AddWithValue("@salarymonth", DropDownList_Month.SelectedValue)
        command.Parameters.AddWithValue("@salaryyear", DropDownList_year.SelectedValue)
        command.Parameters.Add("@Result", SqlDbType.VarChar, 100)
        command.Parameters("@Result").Direction = ParameterDirection.Output

        command.CommandType = CommandType.StoredProcedure

        connection.Open()
        command.ExecuteNonQuery()
        Dim RES As String = command.Parameters("@Result").Value

      
        If RES = "Exist" Then
            lblRoll.Visible = True

            lblRoll.Text = "RollBack Bank Letter first..."
            lblRoll.ForeColor = System.Drawing.Color.Red
        Else
            lblRoll.Visible = True
            lblRoll.Text = "RollBack Successfully..."


            lblRoll.ForeColor = System.Drawing.Color.Green

        End If
















    End Sub
End Class





