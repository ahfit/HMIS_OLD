Imports System.Data
Imports System.Data.SqlClient
Imports System.Configuration
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Omer_Reports_Cash_Book_report
    Inherits System.Web.UI.Page
    Dim Enc As New Encryption
    Dim conStr As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
        If Not Page.IsPostBack Then

            Load_employee()
            DDL_Employee.SelectedValue = Request.QueryString("emp_id")
            DDL_Employee.DataBind()
            CheckEmployee(DDL_Employee, ID)
            GetCashBookRights()
            'DDL_Employee.DataBind()
            'DDL_Employee.SelectedValue = Session("emp_ID")
            cash_report()
        End If
    End Sub

    Sub CheckEmployee(ByVal DDL_Employee As DropDownList, ByVal id As String)
        For Each Item As ListItem In DDL_Employee.Items

            If Item.Value = Session("emp_id") Then

                lblEmployee.Visible = False

            End If

        Next

    End Sub
    Sub GetCashBookRights()
        Dim obj As DbManager = New DbManager
        Dim dt As DataTable
        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpID", Session("emp_id"))
         }

        dt = obj.ExecuteDataTable("GetCashBookRights", "Basic_Data_ConnectionString", sqlParams)
        If dt.Rows.Count > 0 Then
            DDL_Employee.Enabled = True

        Else
            DDL_Employee.SelectedValue = Session("emp_id")
            DDL_Employee.Enabled = False

        End If

        If (lblEmployee.Visible = True) Then

            DDL_Employee.Visible = False
            Lblselctemp.Visible = False
            lblEmployee.Text = "<b>User Is Not Authorized To View This Page!</b>"
            lblEmployee.ForeColor = System.Drawing.Color.Red
            grdvisiblefalse.Visible = False

        Else
        End If


    End Sub

    Protected Sub cash_report()
        Try
            Dim emp_id As Integer = DDL_Employee.SelectedValue
            Dim Dept_id As Integer = 0, Subdept_id As Integer = 0

            getSubdept(emp_id, Dept_id, Subdept_id)
            Dim con As SqlConnection = New SqlConnection(conStr)
            Dim cmd As SqlCommand = New SqlCommand("uspCashBookReport", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Dept_Id", Dept_id)
            cmd.Parameters.AddWithValue("@SubDept_Id", Subdept_id)
            cmd.Parameters.AddWithValue("@emp_id", emp_id)

            con.Open()
            Dim sdr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            sdr.Fill(ds)
            sdr.Dispose()
            con.Close()
            cmd.Dispose()

            Dim reportPath As String = Server.MapPath("~/Patient Billing/Indoor_Cash_Book.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables(1)))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

            'If Request.Browser.Browser = "Chrome" Then
            '    Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
            '    Response.AddHeader("Content-Disposition", "inline; filename=Cash Book Report.pdf")
            '    Response.ContentType = "application/pdf"
            '    Response.BinaryWrite(bytes)
            '    Response.End()
            'Else
            ReportViewer1.Visible = True
            'End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub DDL_Employee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDL_Employee.SelectedIndexChanged
        cash_report()
    End Sub
    Protected Sub getSubdept(ByVal emp_id As Integer, ByRef dept_id As Integer, ByRef subdept_id As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "select SubDeptId,DeptId from Employee where empid =" + emp_id.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename
        con.Open()
        Dim read As SqlDataReader = mycommand.ExecuteReader()

        While read.Read()
            dept_id = read("DeptId").ToString()
            subdept_id = read("SubDeptId").ToString()

        End While

        con.Close()

    End Sub
    Protected Sub Load_employee()
        Dim Emp_ID As String = String.Empty
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "SELECT Receptionist_id FROM Receptionist where Receptionist_id = " + Session("Emp_ID").ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()

        Emp_ID = mycommand.ExecuteScalar

        con.Close()

        If Not String.IsNullOrEmpty(Emp_ID) Then
            DDL_Employee.SelectedValue = Session("emp_id").ToString()
            DDL_Employee.Enabled = False

        Else
            If Session("Dept_ID").ToString <> 32 And Session("Dept_ID").ToString <> 181 Then
                ' DDL_Employee.SelectedValue = Session("emp_id").ToString()

                'Response.Redirect("~/Login.aspx")
            End If

        End If
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
End Class
