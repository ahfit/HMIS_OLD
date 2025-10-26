Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_NewProfitandLossReportDetail
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            txtFromDate.Text = Date.Now.ToString("yyyy-MM-dd")
            txtToDate.Text = Date.Now.ToString("yyyy-MM-dd")
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.DataBind()
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
            'DropDownList_Companyname.Enabled = False
            'DropDownList_Branchname.Enabled = False
            bindCostCenters()
            ShowReport()
        End If
    End Sub

    Private Sub ShowReport()
        Try
            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString)
            Dim cmd As SqlCommand = New SqlCommand("uspGetProfitLossReportDetail", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@StartDate", txtFromDate.Text)
            cmd.Parameters.AddWithValue("@EndDate", txtToDate.Text)
            cmd.Parameters.AddWithValue("@ForCompnay", DropDownList_Companyname.SelectedValue)
            cmd.Parameters.AddWithValue("@ForBranch", DropDownList_Branchname.SelectedValue)
            cmd.Parameters.AddWithValue("@CostCenterID", ddlCostCenter.SelectedValue)
            con.Open()
            Dim dr As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim ds As DataSet = New DataSet()
            dr.Fill(ds)
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Finance/NewProfitandLossReportDetail.rdlc")
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Company", DropDownList_Companyname.SelectedItem.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("Branch", DropDownList_Branchname.SelectedItem.Text))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("StartDate", Convert.ToDateTime(txtFromDate.Text).ToString("dd-MMMM-yyyy")))
            ReportViewer1.LocalReport.SetParameters(New ReportParameter("EndDate", Convert.ToDateTime(txtToDate.Text).ToString("dd-MMMM-yyyy")))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", ds.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", ds.Tables(1)))

        Catch ex As Exception

        End Try


    End Sub


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        ShowReport()
    End Sub
    Protected Sub bindCostCenters()
        Try
            Dim dbm As DbManager = New DbManager()
            Dim query As String = "Select 0 CostCenterID,'ALL' CostCenterName union Select CostCenterID,CostCenterName From CostCenter"
            ddlCostCenter.DataSource = dbm.ExecuteDataTableWithQuery_WithOutParm(query, "Finance_ConnectionString")
            ddlCostCenter.DataBind()
        Catch ex As Exception

        End Try
    End Sub
End Class
