Imports System
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.Collections.Generic
Imports System.Data.SqlClient

Partial Class Budget_Reconcile_Report
    Inherits System.Web.UI.Page
    Public Sub LOAD_REPORT()
        If TXT_Financial_Head.Text.Equals("") Then
            HFD_F_Head.Value = ""

        End If

        'Dim d() As String = DropDownList_FinancialCompany.SelectedItem.Text.Split("--")

        ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)
        Dim ds As DataView = SDS_Report.Select(DataSourceSelectArguments.Empty)
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~\Finance\Budget_reconcile_Report.rdlc")
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim repDs As New ReportDataSource()
        repDs.Name = "Budget"
        repDs.Value = ds
        ReportViewer1.LocalReport.DataSources.Add(repDs)


    End Sub
    <Services.WebMethod()> _
    Public Shared Function SearchFinacial_Head(ByVal prefixText As String, ByVal count As Integer) As String()
        If (count = 0) Then
            count = 10
        End If


        Dim items As New List(Of String)
        Try
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            Dim ENC As New Encryption
            Dim constr As String = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand("Select isnull(E_Code,'') +' '+ ISnull(E_Name,'') as Name,E_Code from Expenditure where isnull(E_Code,'') + isnull(E_Name,'') like '%" + prefixText.Trim() + "%'", con)
            command.CommandType = CommandType.Text
            da.SelectCommand = command
            da.Fill(ds)
            con.Close()
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables(0).Rows(i).Item(0), ds.Tables(0).Rows(i).Item(1)))
            Next
        Catch ex As Exception
            HttpContext.Current.Response.Write(ex.Message)
        End Try
        Return items.ToArray()
    End Function

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not IsPostBack() Then
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)

            DropDownList_FinancialCompany.DataBind()
            DropDownList_CompanyBranches.DataBind()
            load_financial_dates()


        End If

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


    Protected Sub load_financial_dates()
        'Dim month As Integer = Date.Now.Month
        'If month < 7 Then
        '    'Txt_S_date.Text = Convert.ToString(Date.Now.AddYears(-1).Year) + "- 07-01"
        '    'Txt_E_date.Text = Convert.ToString(Date.Now.Year) + "- 06-30"
        'Else
        '    'Txt_S_date.Text = Convert.ToString(Date.Now.Year) + "-07-01"
        '    Txt_E_date.Text = Convert.ToString(Date.Now.AddYears(1).Year) + "-06-30"
        'End If
    End Sub
    Protected Sub DropDownList_FinancialCompany_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_FinancialCompany.SelectedIndexChanged
        DropDownList_CompanyBranches.DataBind()
    End Sub

    Protected Sub Btn_view_Click(sender As Object, e As EventArgs) Handles Btn_view.Click
        LOAD_REPORT()
    End Sub
End Class
