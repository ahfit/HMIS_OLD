Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration

Partial Class PayRoll_Single_Employee_SalaryRptRDLC
    Inherits System.Web.UI.Page
    '  Dim crdoc As New ReportDocument

    Dim conString As String = ConfigurationManager.ConnectionStrings("PayRoll_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            If (Request.QueryString("Employee") = 0) Then
                getLatestalaryDetail()
            End If
            Show_Report()
            End If
    End Sub


    Sub Show_Report()

        Try

            Dim ds As New Salary_report

            Dim da As New Salary_reportTableAdapters.pro_select_emp_salaryTableAdapter
            Dim da_loan As New Salary_reportTableAdapters.Loan_DetailTableAdapter
            ds.Tables("Loan_Detail").Clear()
            ds.Tables("pro_select_emp_salary").Clear()

            If Request.QueryString("Status") <> Nothing And Request.QueryString("month") <> Nothing And Request.QueryString("year") <> Nothing Then
                da.Fill(ds.Tables("pro_select_emp_salary"), "%", "%", -1, Request.QueryString("month").ToString(), Request.QueryString("year"))
            ElseIf (Request.QueryString("Employee") = 0) Then
                da.Fill(ds.Tables("pro_select_emp_salary"), "%", "%", Session("emp_id"), Session("month"), Session("year"))
            Else
                da.Fill(ds.Tables("pro_select_emp_salary"), "%", "%", Request.QueryString("Employee"), Session("month"), Session("year"))
            End If


            da_loan.Fill(ds.Tables("Loan_Detail"))

            ''Dim path As String = Server.MapPath("~/PayRoll/Rpt_Permanent_SalaryRDLC.rpt")
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/PayRoll/Single_Salary_Rpt.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repDs As New ReportDataSource
            repDs.Name = "DataSet1"
            repDs.Value = ds.Tables("pro_select_emp_salary")
            ReportViewer1.LocalReport.DataSources.Add(repDs)
            Dim repDs2 As New ReportDataSource
            repDs2.Name = "DataSet2"
            repDs2.Value = ds.Tables("Loan_Detail")
            Dim repDs3 As New ReportDataSource
            repDs3.Name = "DataSet3"
            repDs3.Value = getSalaryDetail()

            '  Dim repDs4 As New ReportDataSource
            ' repDs4.Name = "DataSet4"
            ' repDs4.Value = getLatestalaryDetail()


            ReportViewer1.LocalReport.DataSources.Add(repDs2)
            ReportViewer1.LocalReport.DataSources.Add(repDs3)
            '  ReportViewer1.LocalReport.DataSources.Add(repDs4)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

            If Request.Browser.Browser = "Chrome" Then
                Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.[End]()
            Else
                ReportViewer1.Visible = True
            End If

            'crdoc.FileName = path

            'crdoc.Database.Tables("pro_select_emp_salary").SetDataSource(ds.Tables("pro_select_emp_salary"))
            'crdoc.Database.Tables("Loan_Detail").SetDataSource(ds.Tables("Loan_Detail"))
            ''crdoc.Subreports("Loan_Detail").Database.Tables("Loan_Detail").SetDataSource(ds.Tables("Loan_Detail"))
            'crdoc.SetParameterValue("dr", "2")
            'crdoc.SetParameterValue("cr", "1")
            'CrystalReportViewer3.ReportSource = crdoc
            'CrystalReportViewer3.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
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

    Private Function getSalaryDetail() As DataTable
        Dim con As SqlConnection = New SqlConnection(conString)
        Dim cmd As SqlCommand
        Dim dt As DataTable = New DataTable
        Try
            con.Open()
            cmd = New SqlCommand("UspGetEmployeeSalaryDetail", con)
            cmd.CommandType = CommandType.StoredProcedure
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)

            If (Request.QueryString("Employee") = 0) Then

                cmd.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))

            Else
                cmd.Parameters.AddWithValue("@Emp_ID", Request.QueryString("Employee"))

            End If

            cmd.Parameters.AddWithValue("@month", Session("month"))
            cmd.Parameters.AddWithValue("@year", Session("year"))

            da.Fill(dt)

        Catch ex As Exception

        Finally
            con.Close()
        End Try

        Return dt

    End Function

    Private Function getLatestalaryDetail() As DataTable
        Dim con As SqlConnection = New SqlConnection(conString)
        Dim cmd As SqlCommand
        Dim dt As DataTable = New DataTable
        Try
            con.Open()
            cmd = New SqlCommand("usp_getEmployee_LastSalary", con)
            cmd.CommandType = CommandType.StoredProcedure
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            cmd.Parameters.AddWithValue("@Emp_ID", Session("emp_id"))

            da.Fill(dt)

        Catch ex As Exception

        Finally
            con.Close()
        End Try
        If (dt.Rows.Count > 0) Then
            Session.Add("month", dt.Rows(0)("salarymonth").ToString())
            Session.Add("year", dt.Rows(0)("salaryYear").ToString())
        End If
        Return dt

    End Function
End Class
