Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration


Partial Class Patient_RegistrationPreOperativeCheckListRpt
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            showReport()
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
    Private Sub showReport()
        Try


            Dim Dt As DataTable = New DataTable()

            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd As SqlCommand = New SqlCommand("SelectCheckList", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@yearlyno", Session("YearlyNo"))
            cmd.Parameters.AddWithValue("@regno", Session("RegistrationNo"))

            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            sda.Fill(Dt)

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Nursing/PreOperativeCheckListRpt.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim ReportDataSource As ReportDataSource = New ReportDataSource
            ReportDataSource.Name = "DataSet1"
            ReportDataSource.Value = Dt
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.DataSources.Add(ReportDataSource)


            'ReportParameter rp = new ReportParameter("ReportParameter1", hfIStartDate.Value);
            'ReportParameter rp2 = new ReportParameter("ReportParameter2", hfEndDate.Value);

            ' ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { rp, rp2 });
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

            'ReportViewer1.LocalReport.DataSources.Add(new Microsoft.Reporting.WebForms.ReportDataSource("Po_Item_Stock_Report", ds.Tables["usp_Po_Item_Stock"]));
            ReportViewer1.LocalReport.Refresh()
            'if (Request.Browser.Browser == "Chrome")
            '{
            '    Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
            '    Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
            '    Response.ContentType = "application/pdf";
            '    Response.BinaryWrite(bytes);
            '    Response.End();
            '}

            'else
            ReportViewer1.Visible = True
        Catch ex As Exception

        End Try
    End Sub


End Class
