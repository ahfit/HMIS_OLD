Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.IO
Imports System.Diagnostics.CodeAnalysis
Imports Microsoft.Reporting.WebForms
Imports System.Drawing
Imports System.Collections.Generic


Partial Class Finance_Trial_Balance_Report_New
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'If Session("Branch_Access") = 1 Then
        '    DropDownList_Companyname.DataBind()
        '    DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
        '    DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
        '    DropDownList_Companyname.Enabled = False
        '    DropDownList_Branchname.Enabled = False
        'End If
        If Not IsPostBack Then
            WebDateChooserSdate.Value = Date.Now
            Webdatechooser_Edate.Value = Date.Now


        Else
            'Show_Report()
        End If




    End Sub
    Protected Sub Show_Report()
        Try
            sdsTrialBalance.SelectParameters("Start_Date").DefaultValue = WebDateChooserSdate.Value.ToString()
            sdsTrialBalance.SelectParameters("End_Date").DefaultValue = Webdatechooser_Edate.Value.ToString()
            Dim dv As DataView = sdsTrialBalance.Select(DataSourceSelectArguments.Empty)
            Dim dt As DataTable = dv.Table
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim reportPath As String = Server.MapPath("~/Finance/Trial_Balance_Report_New.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

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
    <System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()> _
    Public Shared Function SearchHead(prefixText As String, count As Integer) As List(Of String)
        Dim Heads As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SELECT [E_Code], [E_Name], [ESH_Code] FROM [Expenditure] WHERE ([E_Name] LIKE '%' + @Search + '%')"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            Heads.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("E_Name").ToString(), sdr("E_Code").ToString()))
        End While
        Return Heads
    End Function



    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        Show_Report()
    End Sub


End Class
