Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.IO

Partial Class Finance_GeneralLedgerExpenditureByHeadReport
    Inherits System.Web.UI.Page

    Dim strCon As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Branch_Access") = 1 Then
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
            DropDownList_Companyname.Enabled = False
            DropDownList_Branchname.Enabled = False

        End If
        If Not IsPostBack() Then

            WebDateChooserSdate.Value = DateAdd(DateInterval.Day, -1, Date.Now)

            WebDateChooserEDate.Value = DateAdd(DateInterval.Day, 1, Date.Now)

        End If
    End Sub


    Protected Sub loadReport()
        Try
            If txtHeadName.Text.Trim() = "" Then
                hfE_Code.Value = "-1"
            End If
            Dim con As SqlConnection = New SqlConnection(strCon)
            Dim cmd As SqlCommand = New SqlCommand("Select_General_Voucher_SearchReport", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@S_Date", WebDateChooserSdate.Value)
            cmd.Parameters.AddWithValue("@E_Date", WebDateChooserEDate.Value)
            cmd.Parameters.AddWithValue("@Financial_Company_Id", DropDownList_Companyname.SelectedValue)
            cmd.Parameters.AddWithValue("@Company_Branch_ID", DropDownList_Branchname.SelectedValue)
            cmd.Parameters.AddWithValue("@Emp_ID", Session("Emp_Id"))
            cmd.Parameters.AddWithValue("@partyID", 0)
            cmd.Parameters.AddWithValue("@CC", DropDownList_CostCentre.SelectedValue)
            cmd.Parameters.AddWithValue("@postedUnposted", DDLVoucher.SelectedValue)
            cmd.Parameters.AddWithValue("@E_Code", hfE_Code.Value)

            con.Open()
            Dim sdr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            sdr.Fill(ds)
            con.Close()
            cmd.Dispose()

            Dim reportPath As String = Server.MapPath("~/Finance/FinancialHeadLedgerReport.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath

            ReportViewer1.LocalReport.DataSources.Clear()
            Dim rp1 As ReportParameter = New ReportParameter("SDate", WebDateChooserSdate.Value.ToString())
            Dim rp2 As ReportParameter = New ReportParameter("EndDate", WebDateChooserEDate.Value.ToString())
            ReportViewer1.LocalReport.SetParameters(New ReportParameter() {rp1, rp2})

            'ReportViewer1.LocalReport.SetParameters(New ReportParameter("SDate", Convert.ToDateTime(WebDateChooserSdate.Text).ToString("dd-MMMM-yyyy")))
            'ReportViewer1.LocalReport.SetParameters(New ReportParameter("EndDate", Convert.ToDateTime(WebDateChooserEDate.Text).ToString("dd-MMMM-yyyy")))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))

            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

            'If Request.Browser.Browser = "Chrome" Then
            '    Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
            '    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            '    Response.ContentType = "application/pdf"
            '    Response.BinaryWrite(bytes)
            '    Response.End()
            'Else
            '    ReportViewer1.Visible = True
            'End If


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

    Public Sub ShowErrorMessage(ByVal pnl As Panel, ByVal lbl As Label, ByVal msg As String)
        pnl.CssClass = "errorMsg"
        lbl.Text = msg
    End Sub

    Public Sub ShowSuccessMessage(ByVal pnl As Panel, ByVal lbl As Label, ByVal msg As String)
        pnl.CssClass = "successMsg"
        lbl.Text = msg
    End Sub

    Protected Sub Btn_Print_Click(sender As Object, e As EventArgs) Handles Btn_Print.Click
        loadReport()
    End Sub

    <System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()>
    Public Shared Function SearchHead(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim items As List(Of String) = New List(Of String)()
        Dim conn As SqlConnection = New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "select E_Code,E_Name+' --> ' + E_Code As E_Name from expenditure where E_Code<>'0' and (E_Name like '%'+@pretext+'%' or E_Code like '%'+@pretext+'%')"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@pretext", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()

        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("E_Name").ToString(), sdr("E_Code").ToString()))
        End While

        Return items
    End Function
End Class
