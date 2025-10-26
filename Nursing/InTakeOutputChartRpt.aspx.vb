Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration


Partial Class Patient_RegistrationInTakeOutputChartRpt
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            showReport()
        End If

    End Sub


    Private Sub showReport()

        Dim Dt As DataTable = New DataTable()

        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
        Dim cmd As SqlCommand = New SqlCommand("Select_Patient_Intake_Output_Report1", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Yearly_No", 10755)
        cmd.Parameters.AddWithValue("@Registration_No", "FY-016518-17")
        cmd.Parameters.AddWithValue("@dt", "11 / 14 / 2017 10: 05:14 AM")
        Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
        sda.Fill(Dt)

        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Nursing/InTakeOutTakerpt.rdlc")
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim repDs As ReportDataSource = New ReportDataSource
        repDs.Name = "DataSet1"
        repDs.Value = Dt
        ReportViewer1.LocalReport.DataSources.Add(repDs)
    End Sub


End Class
