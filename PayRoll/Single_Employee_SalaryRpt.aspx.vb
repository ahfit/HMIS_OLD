Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Partial Class PayRoll_Single_Employee_SalaryRpt
    Inherits System.Web.UI.Page
    Dim crdoc As New ReportDocument
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Show_Report()
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
            Else

                da.Fill(ds.Tables("pro_select_emp_salary"), "%", "%", Request.QueryString("Employee"), Session("month"), Session("year"))
            End If


            da_loan.Fill(ds.Tables("Loan_Detail"))

            Dim path As String = Server.MapPath("~/PayRoll/Rpt_Permanent_Salary.rpt")
            crdoc.FileName = path

            crdoc.Database.Tables("pro_select_emp_salary").SetDataSource(ds.Tables("pro_select_emp_salary"))
            crdoc.Database.Tables("Loan_Detail").SetDataSource(ds.Tables("Loan_Detail"))
            'crdoc.Subreports("Loan_Detail").Database.Tables("Loan_Detail").SetDataSource(ds.Tables("Loan_Detail"))
            crdoc.SetParameterValue("dr", "2")
            crdoc.SetParameterValue("cr", "1")
            CrystalReportViewer3.ReportSource = crdoc
            CrystalReportViewer3.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
