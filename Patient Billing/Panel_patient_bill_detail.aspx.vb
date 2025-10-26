Imports System.Data.SqlClient
Imports System.IO
Imports System.Data

Partial Class Patient_Billing_Panel_patient_bill_detail
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim TotalPartyAmount As Decimal = 0
    Dim TotalPatientAmount As Decimal = 0
    Dim TotalRefundAmount As Decimal = 0
    Dim TotalBillAmount As Decimal = 0
    Protected Sub gv_bill_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gv_bill.PreRender
        TotalPartyAmount = 0
        TotalPatientAmount = 0
        TotalRefundAmount = 0
        TotalBillAmount = 0
        If gv_bill.Rows.Count > 0 Then
            For Each row As GridViewRow In gv_bill.Rows
                Dim reg_no As HiddenField = row.FindControl("hf_reg")
                Dim regno As LinkButton = row.FindControl("lbl_reg")

                Dim P_Name As Label = row.FindControl("lbl_name")
                Dim P_Prefix As HiddenField = row.FindControl("hf_Prefix")
                Dim P_PFName As HiddenField = row.FindControl("hf_PFName")
                Dim P_PMName As HiddenField = row.FindControl("hf_PMName")
                Dim hf_PLName As HiddenField = row.FindControl("hf_PLName")

                regno.Text = ENC.Encrypt_Main(reg_no.Value, False)
                P_Name.Text = ENC.Encrypt_Main(P_Prefix.Value, False) + " " + ENC.Encrypt_Main(P_PFName.Value, False) + " " + ENC.Encrypt_Main(P_PMName.Value, False) + " " + ENC.Encrypt_Main(hf_PLName.Value, False)


            Next
        End If
    End Sub

    Protected Sub lbl_reg_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnk As LinkButton = sender
        Dim row As GridViewRow = lnk.NamingContainer
        Dim sb As StringBuilder = New StringBuilder

        Dim comandArgument = lnk.CommandArgument

        If comandArgument = "ViewReport" Then

            Dim reg_no As HiddenField = row.FindControl("hf_reg")
            Dim Yearly_no As HiddenField = row.FindControl("hf_yearlyNo")
            Dim SMP_ID As HiddenField = row.FindControl("hf_smp_id")
            Session("YearlyNo") = Yearly_no.Value
            Session("RegistrationNo") = reg_no.Value


            sb.Append("<script language='javascript'>")
            Dim url As String = "../Patient%20Billing/pt_DischargeBillNew.aspx"
            sb.Append(" window.open('" + url + "')</script>")

            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If

        Else
            sb.Append("<script language='javascript'>")
            Dim Company_Name As HiddenField = row.FindControl("hf_Company_Name")
            Dim Invoice_Date As HiddenField = row.FindControl("hf_InvoiceDate")

            Dim url As String = "../Patient Billing/GetPanalInvoice.aspx?InvoiceNo=" + lnk.Text +
                               "&PartyName=" + HttpUtility.UrlEncode(Company_Name.Value)

            ' Safely add InvoiceDate if available
            If Invoice_Date.Value IsNot Nothing AndAlso Not String.IsNullOrEmpty(Invoice_Date.Value.ToString()) Then
                Try
                    url += "&InvoiceDate=" + HttpUtility.UrlEncode(Convert.ToDateTime(Invoice_Date.Value).ToString("yyyy-MM-dd"))
                Catch ex As Exception
                    ' If date conversion fails, skip the date parameter
                End Try
            End If

            sb.Append(" window.open('" + url + "')</script>")

        Dim t As Type = Me.GetType
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        End If

        End If

    End Sub



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            SDS_Hospital.DataBind()
            'WebDateChooser_Sdate.Value = DateTime.Now.Date
            WebDateChooser_Sdate.Value = New DateTime(DateTime.Now.Year, DateTime.Now.Month, 1)
            WebDateChooser_Date.Value = DateTime.Now.Date

            WebDateChooser_Invoicedate.Value = DateTime.Now.Date
            DropDownList_Parties.DataBind()
            gv_bill.DataBind()
        End If
    End Sub

    Protected Sub CK_PanalInvoicemain_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ckMain As CheckBox = sender
        Dim ck As New CheckBox

        For Each row As GridViewRow In gv_bill.Rows
            ck = row.FindControl("CK_PanalInvoiceSub")
            ck.Checked = ckMain.Checked
        Next
    End Sub


    Protected Sub CK_main_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ckMain As CheckBox = sender
        Dim ck As New CheckBox

        For Each row As GridViewRow In gv_bill.Rows
            ck = row.FindControl("Ck_Sub")
            ck.Checked = ckMain.Checked
        Next
    End Sub

    Protected Sub Btn_Payable_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Payable.Click

        Dim Count As Integer = 0
        Dim SPM_ID As New HiddenField, Reg_No As New HiddenField, YearlyNo As New HiddenField, Company_ID As New HiddenField, Compamy_Name As New HiddenField
        Dim ck As New CheckBox

        For Each row As GridViewRow In gv_bill.Rows

            ck = row.FindControl("Ck_Sub")
            If ck.Checked Then
                Count = Count + 1
                SPM_ID = row.FindControl("hf_smp_id")
                Reg_No = row.FindControl("hf_reg")
                YearlyNo = row.FindControl("hf_yearlyNo")
                Company_ID = row.FindControl("hf_Company_ID")
                Compamy_Name = row.FindControl("hf_Company_Name")

                sds_bill.InsertParameters("SMP_ID").DefaultValue = SPM_ID.Value
                sds_bill.InsertParameters("Company_Id").DefaultValue = Company_ID.Value
                sds_bill.InsertParameters("CompanyName").DefaultValue = Compamy_Name.Value
                sds_bill.InsertParameters("Reg_No").DefaultValue = Reg_No.Value
                sds_bill.InsertParameters("Yearly_No").DefaultValue = YearlyNo.Value
                sds_bill.Insert()
            End If
        Next
        If Count = 0 Then
            LBL_Message.Text = "Please Select any bill first"
            LBL_Message.ForeColor = Drawing.Color.Red
        Else
            LBL_Message.Text = CStr(Count) + " Voucher(s) Posted"
            LBL_Message.ForeColor = Drawing.Color.Green
            gv_bill.DataBind()
        End If

    End Sub

    Protected Sub btnShowReport_Click(sender As Object, e As EventArgs) Handles btnShowReport.Click

        gv_bill.Visible = True
        sds_bill.SelectParameters("StartDate").DefaultValue = WebDateChooser_Sdate.Value
        sds_bill.SelectParameters("EndDate").DefaultValue = WebDateChooser_Date.Value

        gv_bill.DataBind()

        If gv_bill.Rows.Count > 0 Then
            ' Btn_Payable.Visible = true
            btnGenerateInvoice.Visible = True
        Else
            Btn_Payable.Visible = False
            btnGenerateInvoice.Visible = False
        End If
    End Sub

    Protected Sub btnGenerateInvoice_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnGenerateInvoice.Click
        LBL_Message.Text = ""

        If txtboxInvoiceNo.Text.Trim = "" Then
            LBL_Message.Text = "Please enter Invoice #"
            LBL_Message.ForeColor = Drawing.Color.Red
        Else

            Dim Count As Integer = 0

            Dim SPM_ID As New HiddenField, Reg_No As New HiddenField, YearlyNo As New HiddenField, Company_ID As New HiddenField,
                Compamy_Name As New HiddenField, partyAmount As New HiddenField, patient_final_bill_id As New HiddenField, TotalBill As New HiddenField
            Dim ck As New CheckBox

            Dim constring As String = ConfigurationManager.ConnectionStrings("PatientBillingConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            con.Open()
            Dim finalBillId As String = String.Empty

            For Each row As GridViewRow In gv_bill.Rows
                ck = row.FindControl("CK_PanalInvoiceSub")
                If ck.Checked Then
                    Count = Count + 1
                    SPM_ID = row.FindControl("hf_smp_id")
                    Reg_No = row.FindControl("hf_reg")
                    YearlyNo = row.FindControl("hf_yearlyNo")
                    Company_ID = row.FindControl("hf_Company_ID")
                    partyAmount = row.FindControl("hf_PartyAmount")
                    TotalBill = row.FindControl("hfd_TotalBill")
                    patient_final_bill_id = row.FindControl("hf_Patient_final_bill_id")

                    Dim Command As SqlCommand = New SqlCommand("AddPanelInvoice", con)
                    Command.CommandType = CommandType.StoredProcedure
                    Command.Parameters.AddWithValue("@Patient_final_bill_id", patient_final_bill_id.Value)
                    Command.Parameters.AddWithValue("@YearlyNo", YearlyNo.Value)
                    Command.Parameters.AddWithValue("@SPMId", SPM_ID.Value)
                    Command.Parameters.AddWithValue("@PartyId", Company_ID.Value)
                    Command.Parameters.AddWithValue("@Amount", partyAmount.Value)
                    Command.Parameters.AddWithValue("@EmpId", Session("emp_ID"))
                    Command.Parameters.AddWithValue("@invoiceNo", txtboxInvoiceNo.Text)
                    Command.Parameters.AddWithValue("@invoiceDate", WebDateChooser_Invoicedate.Value)
                    Command.Parameters.AddWithValue("@totalbill", TotalBill.Value)
                    Command.ExecuteNonQuery()
                    finalBillId += patient_final_bill_id.Value + ","

                End If

            Next
            con.Close()

            If Count = 0 Then
                LBL_Message.Text = "Please Select any bill first"
                LBL_Message.ForeColor = Drawing.Color.Red
            Else
                Dim conn As SqlConnection = New SqlConnection(constring)
                Dim Cmd As SqlCommand = New SqlCommand("UspupdatePatient_final_Bill", conn)


                Cmd.CommandType = CommandType.StoredProcedure
                Cmd.Parameters.AddWithValue("@finalBillID", finalBillId)
                Cmd.Parameters.AddWithValue("@invoiceNo", txtboxInvoiceNo.Text)
                Cmd.Parameters.AddWithValue("@invoiceDate", WebDateChooser_Invoicedate.Value)
                Cmd.Parameters.AddWithValue("@invoiceBy", Session("emp_ID"))
                conn.Open()
                Cmd.ExecuteNonQuery()
                conn.Close()


                LBL_Message.Text = CStr(Count) + " Invoices Generated"
                LBL_Message.ForeColor = Drawing.Color.Green
                'Dim url As String = "../Patient Billing/GetPanalInvoice.aspx?InvoiceNo=" + txtboxInvoiceNo.Text.Trim()
                Dim url As String = "../Patient Billing/GetPanalInvoice.aspx?InvoiceNo=" + txtboxInvoiceNo.Text.Trim() +
                   "&PartyName=" + HttpUtility.UrlEncode(DropDownList_Parties.SelectedItem.Text) +
                   "&InvoiceDate=" + HttpUtility.UrlEncode(WebDateChooser_Invoicedate.Value.ToString("yyyy-MM-dd"))
                Dim sb As New StringBuilder()
                sb.Append("<script type = 'text/javascript'>")
                sb.Append("window.open('")
                sb.Append(url)
                sb.Append("');")
                sb.Append("</script>")
                ClientScript.RegisterStartupScript(Me.[GetType](), "script", sb.ToString())

                gv_bill.DataBind()
                txtboxInvoiceNo.Text = ""
                WebDateChooser_Invoicedate.Value = DateTime.Now

            End If
        End If
    End Sub

    Protected Sub Lbl_Voucher_Click(sender As Object, e As EventArgs)

        Dim lnk As LinkButton = sender
        Dim row As GridViewRow = lnk.NamingContainer
        Dim sb As StringBuilder = New StringBuilder

        Dim comandArgument = lnk.CommandArgument

        'If comandArgument = "ViewReport" Then

        '    Dim reg_no As HiddenField = row.FindControl("hf_reg")
        '    Dim Yearly_no As HiddenField = row.FindControl("hf_yearlyNo")
        '    Dim SMP_ID As HiddenField = row.FindControl("hf_smp_id")
        '    Session("YearlyNo") = Yearly_no.Value
        '    Session("RegistrationNo") = reg_no.Value


        '    sb.Append("<script language='javascript'>")
        '    Dim url As String = "../Patient%20Billing/pt_DischargeBillNew.aspx"
        '    sb.Append(" window.open('" + url + "')</script>")

        '    Dim t As Type = Me.GetType
        '    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        '    End If

        'Else
        sb.Append("<script language='javascript'>")
        Dim url As String = "../Finance/CReport_Recipt_Voucher.aspx?Voucher_Trans_ID=" + lnk.Text
        sb.Append(" window.open('" + url + "')</script>")

        Dim t As Type = Me.GetType
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        End If

        'End If



    End Sub
    Protected Sub lnkEditDates_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim lnk As LinkButton = sender
        Dim hfAddDate As HiddenField
        Dim hfRegNo As HiddenField
        Dim hfYearlyNo As HiddenField
        Dim gvRow As GridViewRow = lnk.NamingContainer
        hfAddDate = gvRow.FindControl("hfAdmissionDate")
        hfRegNo = gvRow.FindControl("hf_reg")
        hfYearlyNo = gvRow.FindControl("hf_yearlyNo")
        pnlEditDates.Visible = True
        wdcDischargeDate.Value = DateTime.Parse(lnk.CommandArgument.ToString())
        wdcAdmissionDate.Value = DateTime.Parse(hfAddDate.Value.ToString())
        lblRegNo.Text = hfRegNo.Value
        lblYearlyNo.Text = hfYearlyNo.Value
    End Sub
    Protected Sub btnUpdateDates_Click(ByVal sender As Object, ByVal e As EventArgs)
        Dim dbMgr As DbManager = New DbManager
        Dim sqlParam As SqlParameter() = {New SqlParameter("@DateTime", wdcAdmissionDate.Value),
                                          New SqlParameter("@DischargeDateTime", wdcDischargeDate.Value),
                                          New SqlParameter("@YearlyNo", lblYearlyNo.Text),
                                          New SqlParameter("@RegNo", lblRegNo.Text),
                                          New SqlParameter("@EntryBy", Session("Emp_ID"))}
        dbMgr.ExecuteNonQuery("uspUpdatePanelDates", "BasicDataInfoConnectionString", sqlParam)
        gv_bill.DataBind()
    End Sub
    Protected Sub btnClose_Click(ByVal sender As Object, ByVal e As EventArgs)
        pnlEditDates.Visible = False
    End Sub
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        gv_bill.Visible = False
        Dim constr As String = ConfigurationManager.ConnectionStrings("PatientBillingConnectionString").ConnectionString

        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try

            con.Open()
            cmd = New SqlCommand("Patient_Panel_BillingDetailReport", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@HospitalID", DDL_Hospital.SelectedValue)
            cmd.Parameters.AddWithValue("@StartDate", WebDateChooser_Sdate.Value)
            cmd.Parameters.AddWithValue("@EndDate", WebDateChooser_Date.Value)
            cmd.Parameters.AddWithValue("@Party_Id", DropDownList_Parties.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            con.Close()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Patient Billing/Patient_Panel_BillingDetailReport.rdlc")
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


    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub
    Protected Sub gv_bill_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gv_bill.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            'Calculate running totals
            Dim PartyAmount As Decimal = 0
            Dim PatientAmount As Decimal = 0
            Dim RefundAmount As Decimal = 0
            Dim TotalBill As Decimal = 0

            'Safely get the values
            If DataBinder.Eval(e.Row.DataItem, "Party_Amount") IsNot DBNull.Value Then
                PartyAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Party_Amount"))
            End If
            If DataBinder.Eval(e.Row.DataItem, "Patient_Amount") IsNot DBNull.Value Then
                PatientAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Patient_Amount"))
            End If
            If DataBinder.Eval(e.Row.DataItem, "Refund_Amount") IsNot DBNull.Value Then
                RefundAmount = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Refund_Amount"))
            End If
            If DataBinder.Eval(e.Row.DataItem, "TotalBill") IsNot DBNull.Value Then
                TotalBill = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "TotalBill"))
            End If

            TotalPartyAmount += PartyAmount
            TotalPatientAmount += PatientAmount
            TotalRefundAmount += RefundAmount
            TotalBillAmount += TotalBill

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            'Display totals in footer - find columns by header text
            For Each cell As TableCell In e.Row.Cells
                cell.Text = "" 'Clear all cells first
            Next

            'Find the correct column indexes by header text
            Dim partyAmountColIndex As Integer = -1
            Dim patientAmountColIndex As Integer = -1
            Dim refundAmountColIndex As Integer = -1
            Dim totalBillColIndex As Integer = -1

            'Get header row to find column positions
            Dim headerRow As GridViewRow = gv_bill.HeaderRow
            If headerRow IsNot Nothing Then
                For i As Integer = 0 To headerRow.Cells.Count - 1
                    Dim headerText As String = headerRow.Cells(i).Text.Trim()
                    If headerText = "Party Amount" Then
                        partyAmountColIndex = i
                    ElseIf headerText = "Patient Amount" Then
                        patientAmountColIndex = i
                    ElseIf headerText = "Refund Amount" Then
                        refundAmountColIndex = i
                    ElseIf headerText = "Total Bill" Then
                        totalBillColIndex = i
                    End If
                Next
            End If

            'Set totals in the correct columns
            If partyAmountColIndex >= 0 Then
                e.Row.Cells(partyAmountColIndex).Text = TotalPartyAmount.ToString("N2")
                e.Row.Cells(partyAmountColIndex).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(partyAmountColIndex).Font.Bold = True
            End If

            If patientAmountColIndex >= 0 Then
                e.Row.Cells(patientAmountColIndex).Text = TotalPatientAmount.ToString("N2")
                e.Row.Cells(patientAmountColIndex).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(patientAmountColIndex).Font.Bold = True
            End If

            If refundAmountColIndex >= 0 Then
                e.Row.Cells(refundAmountColIndex).Text = TotalRefundAmount.ToString("N2")
                e.Row.Cells(refundAmountColIndex).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(refundAmountColIndex).Font.Bold = True
            End If

            If totalBillColIndex >= 0 Then
                e.Row.Cells(totalBillColIndex).Text = TotalBillAmount.ToString("N2")
                e.Row.Cells(totalBillColIndex).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(totalBillColIndex).Font.Bold = True
            End If

            'Add "TOTAL" label in first column
            If e.Row.Cells.Count > 0 Then
                e.Row.Cells(0).Text = "TOTAL:"
                e.Row.Cells(0).HorizontalAlign = HorizontalAlign.Right
                e.Row.Cells(0).Font.Bold = True
            End If
        End If
    End Sub

End Class

