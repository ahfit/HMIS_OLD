Imports System.Data
Imports System.Data.SqlClient
'Imports CrystalDecisions.CrystalReports.Engine
'Imports CrystalDecisions.Shared
Imports System.Drawing.Printing

Partial Class Patient_Billing_PatientServices
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim unit As Integer
    Dim obj As New AmountInWords
    Dim position(100) As String
    Dim totalamount As Integer = 0


    '-----------DataSet for AmountWords
    Dim _SqlAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim _SqlCon As SqlConnection
    Dim _SqlCommand As SqlCommand = New SqlCommand()
    Dim _dataTable As DataTable = New DataTable()
    Dim _dataSet As DataSet = New DataSet()


    'Dim crdoc As New ReportDocument
    Dim strCon As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
    Dim dbmgr As DbManager = New DbManager()
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''resp

        'this function use to chck that it is a  valid user or not ' .
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
                'Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            loginvalidate(Session("emp_id"), Session("dept_id"))
            If Not Page.IsPostBack Then
                ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
                loadReport()
            End If

        Catch ex As Exception
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
    Protected Sub loadReport()
        Try
            Dim con As SqlConnection = New SqlConnection(strCon)
            Dim cmd As SqlCommand = New SqlCommand("usp_PatientBioDataService", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            cmd.Parameters.AddWithValue("@SPM_ID", Request.QueryString("SPMID"))
            cmd.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))

            con.Open()
            Dim sdr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            sdr.Fill(ds)
            con.Close()
            cmd.Dispose()

            Dim Report_name As String = String.Empty
            If String.IsNullOrEmpty(Request.QueryString("AP_ID")) Then
                Report_name = "Patient Receipt" 'ReportName parameter name
            Else
                Report_name = "Patient Bill"
            End If
            Dim reportPath As String = Server.MapPath("~/Patient Billing/PatientServices.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath

            ReportViewer1.LocalReport.DataSources.Clear()
            Dim para As ReportParameter = New ReportParameter("ReportName", Report_name)
            ReportViewer1.LocalReport.SetParameters(New ReportParameter() {para})
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables(1)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet3", ds.Tables(2)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet4", ds.Tables(3)))
            ' ReportViewer1.LocalReport.SetParameters(New ReportParameter("AmountWords", obj.In_Words(CInt(ds.Tables(0).Rows(0).Item("Amount")))))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

            If Request.Browser.Browser = "Chrome" Then
                Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            Else
                ReportViewer1.Visible = True
            End If


        Catch ex As Exception

        End Try
    End Sub
    Protected Sub btnDuplicate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDuplicate.Click
        Response.Redirect("../Patient%20Registration/OPD_Slip_Report_Private.aspx?PS=1&regno=" + Session("RegistrationNo") + "&payid=" + Session("YearlyNo"))
    End Sub
    Public Sub Openconn(ByVal connStr As String)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings(connStr).ConnectionString
            _SqlCon = New SqlConnection(constr)
            _SqlCon.Open()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function ExecuteDataSet(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter()) As DataSet
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next


            _SqlAdapter.SelectCommand = _SqlCommand
            _SqlAdapter.Fill(_dataSet)

            _SqlCon.Close()
            _SqlCommand.Dispose()

        Catch ex As Exception
            Throw ex
        End Try

        Return _dataSet
    End Function
End Class
