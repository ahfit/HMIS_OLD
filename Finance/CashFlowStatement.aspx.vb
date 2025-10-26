Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_CashFlowStatement
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            LOADDATE()
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.DataBind()
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")

        End If
    End Sub

    Private Sub ShowReport()
        Try
            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand("GetCashFlow", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@ForCompnay", DropDownList_Companyname.SelectedValue)
            cmd.Parameters.AddWithValue("@ForBranch", DropDownList_Branchname.SelectedValue)
            cmd.Parameters.AddWithValue("@ReportPeriod", "2")
            cmd.Parameters.AddWithValue("@AsOnDate1", txtAsOnDate1.Text)
            cmd.Parameters.AddWithValue("@AsOnDate2", txtAsOnDate2.Text)


            con.Open()
            Dim dr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            dr.Fill(ds)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Finance/CashFlowStatement.rdlc")
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Company", DropDownList_Companyname.SelectedItem.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Branch", DropDownList_Branchname.SelectedItem.Text))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()
            If (Request.Browser.Browser = "Chrome") Then
                Dim bytes() As Byte = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            Else
                ReportViewer1.Visible = True
            End If
        Catch ex As Exception
            Dim d As String = ex.ToString()
        End Try


    End Sub


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        ShowReport()
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


    Private Sub LOADDATE()
        Dim Today As Date = Date.Now
        Dim TMonth As Integer = Date.Now.Month
        Dim TYear As Integer = Date.Now.Year

        If TMonth <= 6 Then
            txtAsOnDate1.Text = (TYear - 1).ToString() + "-06-30"
            txtAsOnDate2.Text = (TYear).ToString() + "-06-30"
        Else
            txtAsOnDate1.Text = (TYear).ToString() + "-06-30"
            txtAsOnDate2.Text = (TYear + 1).ToString() + "-06-30"

        End If

    End Sub

End Class
