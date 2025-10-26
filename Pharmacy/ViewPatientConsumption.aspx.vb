Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Microsoft.Reporting.WebForms


Partial Class Store_ViewPatientConsumption
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            txtStartDate.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd")
            txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd")
            bindGrid()
        End If

    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        bindGrid()
    End Sub
    Protected Sub bindGrid()
        Dim rec_no As Integer
        If String.IsNullOrEmpty(txtReceiptNo.Text) Then
            rec_no = 0
        Else
            rec_no = Convert.ToInt32(txtReceiptNo.Text)
        End If

        Dim dbMgr = New DbManager()
        Dim sqlParm As SqlParameter() = {New SqlParameter("@SubDept_Id", Session("SubDeptID")),
                                         New SqlParameter("@RegNo", txtRegNo.Text),
                                         New SqlParameter("@SMP_id", rec_no),
                                         New SqlParameter("@YearlyNo", txtYearlyNo.Text),
                                         New SqlParameter("@IssueDateFrom", txtStartDate.Text),
                                         New SqlParameter("@IssueDateTo", txtEndDate.Text)}
        'New SqlParameter("@SMP_id", txtReceiptNo.Text)}
        GridView1.DataSource = dbMgr.ExecuteDataTable("usp_ViewPatientConsumption", "STOREConnectionString", sqlParm)
        GridView1.DataBind()

    End Sub
    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim qty As Int32 = 0
        If GridView1.Rows.Count > 0 Then
            For i = 0 To GridView1.Rows.Count - 1
                Dim Return_Item As LinkButton = GridView1.Rows(i).FindControl("Return_Item")

                Dim lblqty As Label = GridView1.Rows(i).FindControl("lblqt")
                qty = Convert.ToInt32(lblqty.Text)

                If qty = 0 Then
                    Return_Item.Visible = False
                Else
                    Return_Item.Visible = True
                End If
            Next
            'Dim lblTotalqty As Label = GridView1.FooterRow.FindControl("lbltotalqty")
            'lblTotalqty.Text = qty
        End If
    End Sub
    'Protected Sub imgDelete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
    '    Dim btnTemp As ImageButton = sender
    '    Dim consumptionID As Double = btnTemp.CommandArgument
    '    SqlDataSource1.DeleteParameters("Consumption_ID").DefaultValue = consumptionID
    '    SqlDataSource1.Delete()
    '    GridView1.DataBind()
    'End Sub

    'Protected Sub ShowReport()
    '    Dim dv As DataView = SDS_Report.Select(DataSourceSelectArguments.Empty)
    '    Dim dt As DataTable = dv.Table
    '    ReportViewer1.LocalReport.DataSources.Clear()
    '    Dim reportPath As String = Server.MapPath("~/Store/Delivery_to_customer_item.rdlc")
    '    ReportViewer1.LocalReport.ReportPath = reportPath

    '    '    ReportViewer1.LocalReport.SetParameters(para);
    '    ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
    '    'ReportViewer1.LocalReport.SubreportProcessing += New SubreportProcessingEventHandler(subReports)
    '    AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
    '    ReportViewer1.LocalReport.Refresh()
    'End Sub


    'Protected Sub subReports(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
    '    Try
    '        e.DataSources.Clear()
    '        Dim dt As DataTable = Session("DynamicHeader")
    '        e.DataSources.Add(New ReportDataSource("DataSet1", dt))
    '        e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
    '    Catch ex As Exception

    '    End Try
    'End Sub


    Protected Sub DDL_item_cat_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_item_cat.SelectedIndexChanged
        DDL_item.DataBind()
    End Sub
    Protected Sub ReturnRepo_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnTemp As LinkButton = CType(sender, LinkButton)
        Dim gvRow As GridViewRow = TryCast(btnTemp.NamingContainer, GridViewRow)
        Dim hdfCID As HiddenField = CType(gvRow.FindControl("hdConsumption_Id"), HiddenField)
        hfdConsumption_Id = hdfCID
        pnlreport.Visible = True
        bindGrid2()
        'Dim path As String = "Demand_Requisition_Report.aspx?RequsitionNo=" & btnTemp.CommandArgument & "&PID=" + hdfCID.Value
        'Page.ClientScript.RegisterStartupScript(Me.[GetType](), "OpenWindow", "window.open('" & path & "','_newtab');", True)
    End Sub
    Protected Sub Return_Item_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim btnTemp1 As LinkButton = CType(sender, LinkButton)
        Dim gvRow As GridViewRow = TryCast(btnTemp1.NamingContainer, GridViewRow)

        Dim path As String = "Pharmacy_ReturnItems.aspx?C_ID=" + btnTemp1.CommandArgument + "&regNO=" + btnTemp1.CommandName + "&payid=" + btnTemp1.ToolTip
        Response.Redirect(path)
        'Page.ClientScript.RegisterStartupScript(Me.[GetType](), "OpenWindow", "window.open('" & path & "','_newtab');", True)
    End Sub


    Protected Sub btnClosePnl_Click(ByVal sender As Object, ByVal e As EventArgs)
        pnlreport.Visible = False
    End Sub
    Protected Sub bindGrid2()
        Dim dbMgr = New DbManager()
        Dim sqlParm As SqlParameter() = {New SqlParameter("@Consumption_Id", hfdConsumption_Id.Value)
                                        }

        GridView2.DataSource = dbMgr.ExecuteDataTable("usp_ViewSaleReturn", "STOREConnectionString", sqlParm)
        GridView2.DataBind()

    End Sub

   
End Class
