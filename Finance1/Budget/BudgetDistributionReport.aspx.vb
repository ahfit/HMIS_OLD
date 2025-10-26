Imports System
Imports System.Data
Imports Microsoft.Reporting.WebForms

Partial Class Finance_BudgetDistributionReport
    Inherits System.Web.UI.Page
    Public Sub LOAD_REPORT()
        Dim ds As DataView = SDS_Report.Select(DataSourceSelectArguments.Empty)
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~\Finance\Budget\BudgetDistribution.rdlc")
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim repDs As New ReportDataSource()
        repDs.Name = "Budget"
        repDs.Value = ds

        ReportViewer1.LocalReport.DataSources.Add(repDs)
        'ReportViewer1.LocalReport.SubreportProcessing += New SubreportProcessingEventHandler(subReports)
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            LOAD_REPORT()
        End If

    End Sub
    Public Sub subReports(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = CType(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
        Catch __unusedException1__ As Exception
        End Try
    End Sub
    ' private void ShowReport()
    '{
    '    SqlCommand cmd = default(SqlCommand);
    '    SqlConnection con = new SqlConnection(conString);
    '    try
    '    {
    '        con.Open();
    '        cmd = new SqlCommand("usp_getExpiredPatient", con);
    '        cmd.CommandType = CommandType.StoredProcedure;
    '        cmd.Parameters.AddWithValue("@start_date", Start_date_datechooser.Value.ToString());
    '        cmd.Parameters.AddWithValue("@end_date", End_date_datechooser.Value.ToString());

    '        SqlDataAdapter da = new SqlDataAdapter(cmd);
    '        DataTable dt = new DataTable();
    '        da.Fill(dt);
    '        ReportViewer1.LocalReport.ReportPath = Server.MapPath("Expired_Patient.rdlc");
    '        ReportViewer1.LocalReport.DataSources.Clear();
    '        ReportDataSource repDs = new ReportDataSource();
    '        repDs.Name = "DataSet1";
    '        repDs.Value = dt;
    '        ReportViewer1.LocalReport.DataSources.Add(repDs);
    '        if (Request.Browser.Browser == "Chrome")
    '        {
    '            Byte[] bytes = ReportViewer1.LocalReport.Render("PDF");
    '            Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf");
    '            Response.ContentType = "application/pdf";
    '            Response.BinaryWrite(bytes);
    '            Response.End();
    '        }

    '        else
    '            ReportViewer1.Visible = true;
    '        con.Close();
    '    }
    '    catch (Exception ex)
    '    {
    '        con.Close();
    '    }



End Class
