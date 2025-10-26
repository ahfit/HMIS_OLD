Imports System.Data
Imports System.Data.SqlClient

Partial Class HR_EmployeeAttendanceSummary
    Inherits System.Web.UI.Page

    Dim conString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            WebDateChooser_Start_Date.Value = Date.Now()
            HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
            WebDateChooser_end_Date.Value = Date.Now()
            HiddenField_end_Date.Value = WebDateChooser_end_Date.Value
           
            'DDL_Company.DataBind()
            'DDL_Company.SelectedValue = Session("Hospital_Id")
            'DDL_Branch.DataBind()
            'DDL_Branch.SelectedValue = Session("Dept_Id")
            'DDL_Sold_By.DataBind()
            'DDL_Sold_By.SelectedValue = Session("emp_id")

            'DDL_Company.Enabled = False
            'DDL_Branch.Enabled = False
            'DDL_Sold_By.Enabled = False
            'ShowReport()
        End If

    End Sub

    Private Sub ShowReport()
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("uspEmployeeAttendanceSummary", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")

            cmd.Parameters.AddWithValue("@DateFrom", dateFrom)
            cmd.Parameters.AddWithValue("@DateTo", dateTo)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@Dept_ID", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@Hospital_ID", DDL_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@E_status", RBL_Emp_stat.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpNo", txtbox_EmpNo.Text)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("Report.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repParams As ReportParameter() = New ReportParameter(3) {}
            repParams(0) = New ReportParameter("Hospital_Name", DDL_Company.SelectedItem.ToString())
            repParams(1) = New ReportParameter("DeptName", DDL_Branch.SelectedItem.ToString())
            repParams(2) = New ReportParameter("FromDate", HiddenField_Start_Date.Value.ToString())
            repParams(3) = New ReportParameter("ToDate", HiddenField_end_Date.Value.ToString())
            Dim repDs As ReportDataSource = New ReportDataSource()
            ReportViewer1.LocalReport.SetParameters(repParams)
            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)

            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            'If Request.Browser.Browser = "Chrome" Then
            '    Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
            '    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            '    Response.ContentType = "application/pdf"
            '    Response.BinaryWrite(bytes)
            '    Response.[End]()
            'Else

            ReportViewer1.Visible = True
            'End If
            con.Close()
        Catch ex As Exception
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


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
        HiddenField_end_Date.Value = WebDateChooser_end_Date.Value
        'If String.IsNullOrEmpty(TextBox_Emp.Text.Trim()) Then
        '    HiddenField_empNo.Value = "%"
        'Else
        '    HiddenField_empNo.Value = TextBox_Emp.Text.Trim()

        'End If
        ShowReport()
    End Sub

    Private Sub ReportParameter()
        Throw New NotImplementedException
    End Sub

    Private Sub repParams()
        Throw New NotImplementedException
    End Sub


End Class
