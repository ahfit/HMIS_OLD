Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Microsoft.Reporting.WebForms


Partial Class Store_Delivery_To_Customer
    Inherits System.Web.UI.Page


    Protected Sub LBN_Invoice_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Try


            Dim lb As LinkButton = sender
            HF_C_ID.Value = lb.CommandArgument
            Invoice_DC()

            Response.Redirect("SaleOrder.aspx?SO_ID=" + Hf_SO_No.Value)
        Catch ex As Exception
            Response.Write("Insert error " + ex.ToString())
        End Try

    End Sub
    Protected Sub Invoice_DC()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("StoreConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Procedurename As String = "Insert_SaleInvoice_By_DC"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename

            mycommand.Parameters.AddWithValue("@Consumption_Id", HF_C_ID.Value)
            mycommand.Parameters.Add("@SO_ID", Data.SqlDbType.Int, 100)
            mycommand.Parameters("@SO_ID").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.AddWithValue("PreparedBy", Session("Emp_Id"))

            con.Open()
            mycommand.ExecuteNonQuery()
            Hf_SO_No.Value = Convert.ToString(mycommand.Parameters("@SO_ID").Value)
            con.Close()
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            DDL_Company.DataBind()
            DDL_Branch.DataBind()
            'DDL_Company.SelectedValue = Session("Financial_Company_Id")
            DDL_Branch.SelectedValue = Session("Subdeptid")
            If Session("Branch_Access") = 1 Then
                DDL_Company.Enabled = False
                DDL_Branch.Enabled = False
            End If
            If Session("emp_id") = "5015" Then
                DDL_Branch.Enabled = True
            End If
            WebDateChooser_date_From.Value = DateTime.Now.AddDays(-3)
            WebDateChooser_Date_To.Value = DateTime.Now
            hfld_PartyName.Value = "%" + "" + "%"
            hfld_RequisitionNo.Value = "%" + txtRequistionNo.Text + "%"
            hfld_IssueDateFrom.Value = WebDateChooser_date_From.Value.ToString()
            hfld_IssueDateTo.Value = WebDateChooser_Date_To.Value.ToString()
        End If

    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        GridView1.Visible = True
        ReportViewer1.Visible = False
        fillforSearch()

        GridView1.DataBind()
    End Sub

    Protected Sub LBN_View_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim Bth_View As LinkButton = sender, invoiceID As String = String.Empty
        If Not String.IsNullOrEmpty(Bth_View.CommandArgument) Then
            invoiceID = Bth_View.CommandArgument
            Response.Redirect("SaleOrderReport.aspx?SO_ID=" + invoiceID)
        End If

    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim qty As Double = 0
        If GridView1.Rows.Count > 0 Then
            For Each grv As GridViewRow In GridView1.Rows
                Dim lnkGen As LinkButton = grv.FindControl("LBN_Invoice")
                Dim lnkupdate As LinkButton = grv.FindControl("LBN_Update")
                Dim chkboxGenerate As CheckBox = grv.FindControl("chkboxGenerate")
                Dim lblqty As Label = grv.FindControl("lblqty")
                qty = qty + Convert.ToDouble(lblqty.Text)
                If lnkGen.Visible = True Then
                    lnkupdate.Visible = True
                    chkboxGenerate.Visible = True
                Else
                    lnkupdate.Visible = False
                    chkboxGenerate.Visible = False
                End If
            Next
            Dim lblTotalqty As Label = GridView1.FooterRow.FindControl("lbltotalqty")
            lblTotalqty.Text = qty
        End If
    End Sub

    Protected Sub LBN_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        PnlUpdateInvoice.Visible = True
        Dim lnk As LinkButton = sender

        hdfConsumptionID.Value = lnk.CommandArgument
    End Sub

    Protected Sub tbxInvoiceNo_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles tbxInvoiceNo.TextChanged
        Dim dv As DataView = SqlDataSource2.Select(DataSourceSelectArguments.Empty)
        If dv.Count > 0 Then
            lblSOID.Text = dv.Item(0)(0).ToString()
            lblQtyval.Text = "Quantity : " + dv.Item(0)(1).ToString()
            lblAmount.Visible = True
            lblQtyval.Visible = True
            lblAmount.Text = "Amount : " + dv.Item(0)(2).ToString()
            btnUpdateInvoice.Enabled = True
        End If

    End Sub

    Protected Sub btnUpdateInvoice_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdateInvoice.Click
        SqlDataSource2.Update()
        lblmsg.Text = "Updated Successfuly!"
        lblmsg.ForeColor = System.Drawing.Color.Green
        lblmsg.Font.Bold = True
        lblmsg.Visible = True
        hdfConsumptionID.Value = ""
    End Sub

    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClose.Click
        PnlUpdateInvoice.Visible = False
        GridView1.DataBind()
        lblmsg.Visible = False
        tbxInvoiceNo.Text = ""
        lblAmount.Visible = False
        lblQtyval.Visible = False
    End Sub

    Protected Sub chkboxGenerate_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cbox As CheckBox = sender
        If cbox.Checked = True Then
            btnGenerate.Visible = True
        End If
        For Each gvr As GridViewRow In GridView1.Rows
            Dim chkbox As CheckBox = gvr.FindControl("chkboxGenerate")
            chkbox.Attributes.Remove("oncheckedchanged")
            chkbox.AutoPostBack = False
        Next
    End Sub
    Protected Sub GenerateInvoice()
        Dim CustomerIdList As List(Of String) = New List(Of String)
        Dim ReqIdList As List(Of String) = New List(Of String)
        Dim ConsumptionIdList As List(Of Integer) = New List(Of Integer)
        Dim flag As Boolean = False
        Dim maxConsumptionId As Integer = 0
        Dim cidSub As String = String.Empty
        Dim req As String = String.Empty
        For Each gvr As GridViewRow In GridView1.Rows
            Dim ckbox As CheckBox = gvr.FindControl("chkboxGenerate")
            If ckbox.Checked = True And ckbox.Visible = True Then
                Dim customerId As HiddenField = gvr.FindControl("hdfCustomerId")
                Dim consumptionId As HiddenField = gvr.FindControl("hdfConsumptionId")
                Dim reqid As Label = gvr.FindControl("lblReqID")
                CustomerIdList.Add(customerId.Value)
                ConsumptionIdList.Add(consumptionId.Value)
                ReqIdList.Add(reqid.Text)
            End If
        Next
        For i As Int32 = 0 To ReqIdList.Count - 1
            For j As Int32 = 0 To i
                If ReqIdList.Item(i).ToString().Substring(0, 3) = ReqIdList.Item(j).ToString().Substring(0, 3) Then
                    flag = False
                Else
                    flag = True
                    lblmsgGen.Text = "Please Select IPO or Requisitions."
                    lblmsgGen.Visible = True
                    GoTo ExitLoops
                End If
            Next
        Next

       
        For i As Int32 = 0 To CustomerIdList.Count - 1
            For j As Int32 = 0 To i
                If CustomerIdList.Item(i) = CustomerIdList.Item(j) Then
                    flag = False
                Else
                    flag = True
                    lblmsgGen.Text = "Selected customers are not same."
                    lblmsgGen.Visible = True
                    GoTo ExitLoops
                End If
            Next
        Next
ExitLoops:
        If flag = False Then
            For i As Int32 = 0 To ConsumptionIdList.Count - 1
                maxConsumptionId = Math.Max(maxConsumptionId, ConsumptionIdList.Item(i))
                If String.IsNullOrEmpty(cidSub) Then
                    cidSub = cidSub + Convert.ToString(ConsumptionIdList.Item(i))
                Else
                    cidSub = cidSub + "," + Convert.ToString(ConsumptionIdList.Item(i))
                End If
            Next
            For i As Int32 = 0 To ReqIdList.Count - 1

                If ReqIdList.Item(i).ToString.Substring(0, 3) = "IPO" Then
                    If String.IsNullOrEmpty(req) Then
                        req = ReqIdList.Item(i).ToString()
                    Else
                        req = req + "," + ReqIdList.Item(i).ToString()
                    End If
                End If
            Next
            ' req = req + "'"

            Try
                Dim constring As String = ConfigurationManager.ConnectionStrings("StoreConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim Procedurename As String = "Usp_GenerateSaleInvoice_By_MultiDC"
                Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
                mycommand.CommandType = Data.CommandType.StoredProcedure
                mycommand.CommandText = Procedurename
                mycommand.Parameters.AddWithValue("@Consumption_Id", maxConsumptionId)
                mycommand.Parameters.Add("@SO_ID", Data.SqlDbType.Int, 100)
                mycommand.Parameters("@SO_ID").Direction = Data.ParameterDirection.Output
                mycommand.Parameters.AddWithValue("@C_ID_Sub", cidSub)
                mycommand.Parameters.AddWithValue("@ReqList", req)
                con.Open()
                mycommand.ExecuteNonQuery()
                Hf_SO_No.Value = Convert.ToString(mycommand.Parameters("@SO_ID").Value)
                con.Close()
            Catch ex As Exception
            End Try
            Response.Redirect("SaleOrder.aspx?SO_ID=" + Hf_SO_No.Value)
        End If
    End Sub
    Protected Sub btnGenerate_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnGenerate.Click
        GenerateInvoice()

    End Sub

    Protected Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        

    End Sub

    Protected Sub imgDelete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim btnTemp As ImageButton = sender
        Dim consumptionID As Double = btnTemp.CommandArgument
        SqlDataSource1.DeleteParameters("Consumption_ID").DefaultValue = consumptionID
        SqlDataSource1.Delete()
        GridView1.DataBind()
    End Sub

    Protected Sub ShowReport()
        Dim dv As DataView = SDS_Report.Select(DataSourceSelectArguments.Empty)
        Dim dt As DataTable = dv.Table
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim reportPath As String = Server.MapPath("~/Store/Delivery_to_customer_item.rdlc")
        ReportViewer1.LocalReport.ReportPath = reportPath

        '    ReportViewer1.LocalReport.SetParameters(para);
        ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
        'ReportViewer1.LocalReport.SubreportProcessing += New SubreportProcessingEventHandler(subReports)
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        ReportViewer1.LocalReport.Refresh()
    End Sub


    Protected Sub subReports(ByVal sender As Object, ByVal e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = Session("DynamicHeader")
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btn_Report_Click(sender As Object, e As EventArgs) Handles btn_Report.Click
        GridView1.Visible = False
        ReportViewer1.Visible = True
        fillforSearch()
        ShowReport()
    End Sub

    Private Sub fillforSearch()
        hfld_IssueDateFrom.Value = WebDateChooser_date_From.Value.ToString()
        hfld_IssueDateTo.Value = WebDateChooser_Date_To.Value.ToString()
        If String.IsNullOrEmpty(txtRequistionNo.Text.Trim()) Then
            hfld_RequisitionNo.Value = "%"
        Else
            hfld_RequisitionNo.Value = "%" + txtRequistionNo.Text.Trim() + "%"
        End If
        If DDL_Branch0.SelectedValue = 0 Then
            hfld_PartyName.Value = "%"
        Else
            hfld_PartyName.Value = "%" + DDL_Branch0.SelectedItem.Text.Trim() + "%"
        End If

    End Sub

    Protected Sub DDL_item_cat_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_item_cat.SelectedIndexChanged
        DDL_item.DataBind()
    End Sub
End Class
