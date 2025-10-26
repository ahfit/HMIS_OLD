Imports System.Data
Imports System.Data.SqlClient
Partial Class PanelComparisionReport
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString




    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            DropDownList2.DataBind()

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

    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try

            con.Open()
            cmd = New SqlCommand("usp_PanelComparisionReport", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Company_ID", DropDownList_Company.SelectedValue)
            cmd.Parameters.AddWithValue("@C_Name", DropDownList2.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            con.Close()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Administrator/PanelComparisionReport.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repDs As New ReportDataSource
            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        Catch ex As Exception
            con.Close()
        End Try

    End Sub


End Class
