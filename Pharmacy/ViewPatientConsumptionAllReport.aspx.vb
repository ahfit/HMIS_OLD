Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Microsoft.Reporting.WebForms


Partial Class Store_ViewPatientConsumptionAllReport
    Inherits System.Web.UI.Page
    Dim SString As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            txtStartDate.Text = DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd")
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd")
            loadDepartments()
            loadPatientType()
            LoadReport()
        End If

    End Sub
    <System.Web.Script.Services.ScriptMethod, System.Web.Services.WebMethod>
    Public Shared Function SearchItems(prefixText As String, count As Integer) As List(Of String)
        Dim items As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("Item_Name").ToString(), sdr("Item_Code").ToString()))
        End While
        Return items
    End Function
    Protected Sub LoadReport()
        Dim con As New SqlConnection(SString)
        Dim cmd As SqlCommand
        Try
            con.Open()
            cmd = New SqlCommand("ViewPatientSaleReturnReportForAllFilters", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@Consumption_ID", txtReceiptNo.Text)
            cmd.Parameters.AddWithValue("@IssueDateFrom", txtStartDate.Text)
            cmd.Parameters.AddWithValue("@IssueDateTo", txtEndDate.Text)
            cmd.Parameters.AddWithValue("@ItemName", txtItemName.Text)
            cmd.Parameters.AddWithValue("@RegNo ", txtRegNo.Text)
            cmd.Parameters.AddWithValue("@YearlyNo", txtYearlyNo.Text)
            cmd.Parameters.AddWithValue("@SubDept_Id", ddlDepartment.SelectedValue)
            cmd.Parameters.AddWithValue("@PatientType", DropDownList_PatientType.SelectedValue)
            cmd.Parameters.AddWithValue("@type", DropDownTypeWise.SelectedItem.Text)


            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            Dim rds As New ReportDataSource()
            rds.Name = "DataSet1"
            rds.Value = dt
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim reportPath As String = Server.MapPath("~/Pharmacy/PatientSaleReturnAllReport.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.DataSources.Add(rds)

            Dim rp(1) As ReportParameter
            rp(0) = New ReportParameter("ReportParameter1", txtStartDate.Text.ToString())
            rp(1) = New ReportParameter("ReportParameter2", txtEndDate.Text.ToString())
            'rp ReportParameter("ReportParameter1", txtStartDate.Text.ToString()),
            '  ReportParameter("ReportParameter2", txtEndDate.Text.ToString())

            ReportViewer1.LocalReport.SetParameters(rp)

            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

            ReportViewer1.LocalReport.Refresh()


        Catch ex As Exception
        Finally
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
  Private Sub loadPatientType()
        Dim cmd As SqlCommand
        Dim con As New SqlConnection()
        Try
            con = New SqlConnection(SString)
            con.Open()
            cmd = New SqlCommand("Select 0 as ID, ' ALL' Patient_Type UNION select ID, Patient_Type from [Registration].[dbo].[Patient_Type] where Active=1 order by Patient_Type ", con)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            DropDownList_PatientType.DataSource = dt
            DropDownList_PatientType.DataTextField = "Patient_type"
            DropDownList_PatientType.DataValueField = "ID"

            DropDownList_PatientType.DataBind()
        Catch ex As Exception

            con.Close()
        End Try
    End Sub
    Private Sub loadDepartments()

        Dim con As New SqlConnection(SString)
        Dim cmd As SqlCommand
        Try
            con.Open()
            cmd = New SqlCommand("Select 0 SubDept_Id, '----- ALL -----' SubDept_Name UNION SELECT  [SubDept_Id]  ,[SubDept_Name]  FROM [STORE].[dbo].[SubDepartment]", con)
            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            ddlDepartment.DataSource = dt
            ddlDepartment.DataBind()
        Catch ex As Exception
        Finally
            con.Close()
        End Try

    End Sub
   


    Protected Sub btn_Report_Click(sender As Object, e As EventArgs) Handles btn_Report.Click
        LoadReport()
    End Sub
End Class
