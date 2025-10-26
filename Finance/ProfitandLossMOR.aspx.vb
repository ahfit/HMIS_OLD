Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_ProfitandLossMOR
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LOADDATE()
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.DataBind()
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
            'DropDownList_Companyname.Enabled = False
            'DropDownList_Branchname.Enabled = False
            bindCostCenters()
            ' ShowReport()
        End If
    End Sub

    Private Sub LOADDATE()
        Dim Today As Date = Date.Now
        Dim TMonth As Integer = Date.Now.Month
        Dim TYear As Integer = Date.Now.Year

        If TMonth <= 6 Then
            txtFromDate1.Text = (TYear - 1).ToString() + "-07-01"
            txtToDate1.Text = (TYear).ToString() + "-06-30"
            txtFromDate2.Text = (TYear - 2).ToString() + "-07-01"
            txtToDate2.Text = (TYear - 1).ToString() + "-06-30"
        Else
            txtFromDate1.Text = (TYear).ToString() + "-07-01"
            txtToDate1.Text = (TYear + 1).ToString() + "-06-30"
            txtFromDate2.Text = (TYear - 1).ToString() + "-07-01"
            txtToDate2.Text = (TYear).ToString() + "-06-30"
        End If

        'If TMonth <= 6 Then
        '    txtFromDate1.Text = (TYear - 1).ToString() + "-07-01"
        '    txtToDate1.Text = (TYear).ToString() + "-06-30"
        'Else
        '    txtFromDate1.Text = (TYear - 1).ToString() + "-07-01"
        '    txtToDate1.Text = (TYear).ToString() + "-06-30"
        'End If

    End Sub

    Private Sub ShowReport()
        Try

            ReportViewer1.LocalReport.EnableHyperlinks = True

            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand("GetProfitLoss_MOR_Report", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ForCompnay", DropDownList_Companyname.SelectedValue)
            cmd.Parameters.AddWithValue("@ForBranch", DropDownList_Branchname.SelectedValue)
            cmd.Parameters.AddWithValue("@CostCenterID", ddlCostCenter.SelectedValue)
            cmd.Parameters.AddWithValue("@ReportPeriod", "2")

            cmd.Parameters.AddWithValue("@StartDate1", txtFromDate1.Text)
            cmd.Parameters.AddWithValue("@EndDate1", txtToDate1.Text)

            cmd.Parameters.AddWithValue("@StartDate2", txtFromDate2.Text)
            cmd.Parameters.AddWithValue("@EndDate2", txtToDate2.Text)

            con.Open()
            Dim dr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            dr.Fill(ds)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Finance/ProfitLossCrossProductMOR.rdlc")
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Company", DropDownList_Companyname.SelectedItem.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Branch", DropDownList_Branchname.SelectedItem.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("SDOne", txtFromDate1.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("EDOne", txtToDate1.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("SDTwo", txtFromDate2.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("EDTwo", txtToDate2.Text))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("BaseUrl", GetSiteUrl()))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            'ReportViewer1.LocalReport.Refresh()

            'If Request.Browser.Browser = "Chrome" Then
            '    Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
            '    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
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
    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub
    Public Shared Function GetSiteUrl() As String
        Dim url As String = String.Empty
        Dim request As HttpRequest = HttpContext.Current.Request

        If request.IsSecureConnection Then
            url = "https://"
        Else
            url = "http://"
        End If

        url += request("HTTP_HOST") & "/HMIS"
        Return url
    End Function

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        ShowReport()
    End Sub
    Protected Sub bindCostCenters()
        Try
            Dim dbm As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {}
            Dim query As String = "Select 0 CostCenterID,'ALL' CostCenterName union Select CostCenterID,CostCenterName+' --> ' + MainCostCenter From CostCenter"
            ddlCostCenter.DataSource = dbm.ExecuteDataTableWithQuery(query, "Finance_ConnectionString", sqlParams)
            ddlCostCenter.DataBind()
        Catch ex As Exception

        End Try
    End Sub
End Class
