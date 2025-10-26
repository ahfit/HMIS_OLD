Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic

Partial Class Patient_Registration_Indoor_Patient_Paymen
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Dim b As String = ""
    Dim c As String = ""
    Dim d As String = ""
    Dim total_amount As Integer = 0
    Dim Bal_Amount As Integer = 0
    Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim conStrReg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim con_path As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
    Dim con_Radiology As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
    Dim con_OT As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
    Dim voucher As New voucher_insertion
    Dim constring1 As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim Procedurename As String = "Temp_insert_Reciept_Voucher_payment"
    Dim Cash_val, Cheque_val, Credit_Card_val As Integer
    Dim co As New Coma
    Dim paid_by As Int32
    Dim isPostBack As Boolean = False
    Dim GridView As Object
    Protected Sub ClearLabels()
        TextBox2.Text = "0"
        Label_Ad_Payment.Text = "0"
        Label_Discount.Text = "0"
        Label_Refund.Text = "0"
        Label_Remaining_Balance.Text = "0"
        Label_Cash.Text = "0"


    End Sub

    Sub getDept(ByVal Reg_No As String, ByVal YearlyNo As Integer)
        Dim con_bal As SqlConnection = New SqlConnection(conStrReg)
        Dim command_bal As SqlCommand = New SqlCommand("SELECT DeptID  FROM Payment where RegNo=@RegNo and PayID=@YearlyNo ", con_bal)
        command_bal.CommandType = CommandType.Text
        command_bal.Parameters.AddWithValue("@RegNo", Reg_No)
        command_bal.Parameters.AddWithValue("@YearlyNo", YearlyNo)
        con_bal.Open()
        HiddenField_Dept_ID.Value = command_bal.ExecuteScalar
        con_bal.Close()
    End Sub
    Protected Sub Button3_Click(sender As Object, e As EventArgs)
        Dim url As String
        Dim sidList As New List(Of String)

        ' Loop through GridView rows
        For Each row As GridViewRow In GridView_For_Services.Rows
            Dim chkBox As CheckBox = TryCast(row.FindControl("CheckBox1"), CheckBox)
            Dim hiddenSID As HiddenField = TryCast(row.FindControl("HiddenField_SID"), HiddenField)

            If chkBox IsNot Nothing AndAlso chkBox.Checked Then
                If hiddenSID IsNot Nothing Then
                    sidList.Add(hiddenSID.Value)
                End If
            End If
        Next

        ' Create comma-separated string of selected SIDs
        Dim sidParam As String = String.Join(",", sidList)

        ' Build final URL
        url = "../Patient Billing/OverallPatientServicesReport.aspx?Registration=" & _
              Request.QueryString("regno") & "&PayId=" & Request.QueryString("Payid") & _
              "&SID=" & sidParam

        ' Open new tab with constructed URL
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" & url & "','_blank');", True)
    End Sub


    Private Function Get_Type(ByVal PayId As Integer)
        Dim type As String = ""
        Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As New SqlConnection(constr_reg)
        Dim qry As String = "SELECT Patient_Type FROM Payment where (PayID = @PayId)"
        Dim cmd As New SqlCommand(qry, con)
        con.Open()
        cmd.Parameters.AddWithValue("@PayId", PayId)
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            type = reader.Item("Patient_Type").ToString()
        End While
        con.Close()
        Return type
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Session("HospitalID").ToString().Equals("1") And Session("Patient_Type_ID").ToString().Equals("1") Then
                Button_Discount.Visible = True
            End If
            If IS_Discount_Forwarded(Request.QueryString("regno"), Request.QueryString("payid")) = 0 Then
                Button_Discount.Enabled = True
            ElseIf IS_Discount_Forwarded(Request.QueryString("regno"), Request.QueryString("payid")) > 0 Then
                Button_Discount.Enabled = False
            End If
            get_subdept_id()
            If HiddenField_Patient_type.Value = "IPD" Then
                RadioButtonList_ReportType.Visible = False
                Button_lab_Test.Visible = True
            Else

            End If

            If Not Page.IsPostBack Then

                txtboxAmount.Visible = False
                If Session("HospitalID") = 1 Then
                    hylk_discount.Visible = False
                Else
                    hylk_discount.NavigateUrl = "~/Patient Billing/Discount.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid")
                End If

                discount()
                ' Due_Payment()
                GridView_For_Services.DataBind()
                ' GridView_Rad_Sample_Recieved.DataBind()
                gvd_advance.DataBind()
                Button_Report.Focus()

                If GridView_For_Services.Rows.Count = 0 Then
                    GridView_For_Services.Visible = False
                Else
                    GridView_For_Services.Visible = True
                End If

                'If GridView_Rad_Sample_Recieved.Rows.Count = 0 Then
                '    pnl_Radiology_Sample.Visible = False
                'Else
                '    pnl_Radiology_Sample.Visible = True
                'End If

                If Session("Patienttype") = "Panel" Then
                    Button_Report.Visible = True
                Else
                    Button_Report.Visible = True
                End If

                Try
                    If GridView_For_Services.Rows.Count = 0 Then
                        HiddenField_chk.Value = 0
                    End If
                    Try
                        Calculation()
                        ClearLabels()
                    Catch ex As Exception

                    End Try

                    If HiddenField_chk.Value = "1" Then
                        Button_Report.Enabled = True
                    Else
                        If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(co.Remove_Coma(Label_Ad_Payment.Text)) <> 0 Then
                            Button_Report.Enabled = True
                        Else
                            Button_Report.Enabled = False
                        End If
                    End If

                Catch ex As Exception

                End Try
            Else
                isPostBack = True
            End If
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub

    Private Function IS_Discount_Forwarded(ByVal RegNo As String, ByVal PayId As Integer) As Integer
        Dim cnt As Integer = 0
        Dim constr_reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As New SqlConnection(constr_reg)
        Dim qry As String = "SELECT count(Reg_No) FROM Forward_To_Sub_Dept WHERE (Reg_No = @Reg_No) AND (yearly_no = @yearly_no) AND (Request_Type_ID = 15) AND (status = 0)"
        Dim cmd As New SqlCommand(qry, con)
        con.Open()
        cmd.Parameters.AddWithValue("@Reg_No", RegNo)
        cmd.Parameters.AddWithValue("@yearly_no", PayId)
        cnt = cmd.ExecuteScalar
        con.Close()
        Return cnt
    End Function


    Sub Calculation()
        If GridView_For_Services.Rows.Count = 0 Then
            Dim rs As Int64 = 0

            Try
                For count As Integer = 0 To gvd_advance.Rows.Count - 1
                    Dim chk As CheckBox = gvd_advance.Rows(count).FindControl("CheckBox_checked")
                    If chk.Checked = True Then
                        rs = rs + Convert.ToDecimal(gvd_advance.Rows(count).Cells(0).Text)

                    End If

                Next
            Catch ex As Exception

            End Try

            Label_Ad_Payment.Text = rs

            TextBox2.Text = 0
            Label_Remaining_Balance.Text = 0
            hfAmount.Value = 0
            Label_Refund.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text)))
            If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(co.Remove_Coma(Label_Ad_Payment.Text)) <> 0 Then
                ' Button1.Enabled = True
                Button_Report.Enabled = True
            Else
                'Button1.Enabled = False
                Button_Report.Enabled = False
            End If
        End If
        If CKFinal.Checked Then
            'Response.Write(Label_Remaining_Balance.Text)
            If Label_Remaining_Balance.Text = "0" Then
                Button_Report.Visible = True
            Else
                Button_Report.Visible = False
            End If
        End If
    End Sub

    Protected Sub GridView_For_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_For_Services.PreRender
        If GridView_For_Services.Rows.Count = 0 Then
            Button_Discount.Enabled = False
        ElseIf GridView_For_Services.Rows.Count <> 0 Then
            Button_Discount.Enabled = True
            Try
                Dim company_Bill As Double = 0
                Dim Patient_Bill As Double = 0

                Dim amount As Integer = 0
                Dim amount_total As Double = 0
                Dim company_total As Double = 0
                Dim patient_total As Double = 0
                Dim systemDiscount_total As Double = 0
                Dim manualDiscount_total As Double = 0


                HiddenField_chk.Value = 0

                For i As Integer = 0 To GridView_For_Services.Rows.Count - 1

                    Dim Ser_Cat_ID As HiddenField
                    GridView_For_Services.FooterRow.Visible = True
                    If Page.IsPostBack = False Then
                        GridView_For_Services.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_For_Services.Rows(i).Cells(1).Text, False)
                        Ser_Cat_ID = GridView_For_Services.Rows(i).FindControl("HF_Service_Cat")

                    Else
                        If GridView_For_Services.Rows(i).Cells(1).Text.Length > 17 Then
                            GridView_For_Services.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_For_Services.Rows(i).Cells(1).Text, False)

                        End If
                    End If

                    Try
                        'Dim per As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_per")                        
                        Dim ServiceAmount As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenFieldAmount")
                        Dim TextBox_company As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_company")
                        Dim txt_Patient As TextBox = GridView_For_Services.Rows(i).FindControl("TextBox_Patient")
                        Dim lbl_SystemDiscount As Label = GridView_For_Services.Rows(i).FindControl("lbl_SystemDiscount")
                        Dim lbl_ManualDiscount As Label = GridView_For_Services.Rows(i).FindControl("lbl_ManualDiscount")


                        Dim chk As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
                        Dim Party_ID As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_Party_ID")
                        Dim Order_id As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_order_ID")

                        HiddenField_Party_ID.Value = Party_ID.Value

                        Try
                            DropDownList_Company.DataBind()
                            'DropDownList_Company.SelectedValue = HiddenField_Party_ID.Value
                        Catch ex As Exception

                        End Try
                        If Not String.IsNullOrEmpty(Order_id.Value) Then
                            GridView_For_Services.Rows(i).BackColor = Drawing.Color.Orange
                            If Not isPostBack Then
                                chk.Checked = False
                            End If


                        End If
                        'discount()
                        Try
                            If chk.Checked = True Then
                                amount_total = amount_total + Convert.ToDouble(ServiceAmount.Value)
                                company_total = company_total + Convert.ToDouble(TextBox_company.Text)
                                patient_total = patient_total + Convert.ToDouble(txt_Patient.Text)
                                manualDiscount_total = manualDiscount_total + Convert.ToDouble(lbl_ManualDiscount.Text)
                                systemDiscount_total = systemDiscount_total + Convert.ToDouble(lbl_SystemDiscount.Text)

                                HiddenField_chk.Value = 1
                            End If
                        Catch ex As Exception
                        End Try

                        'txt_Patient.Text = co.place_Coma(txt_Patient.Text)
                        'txt.Text = co.place_Coma(txt.Text)
                        'GridView_For_Services.Rows(i).Cells(4).Text = co.place_Coma(GridView_For_Services.Rows(i).Cells(4).Text)
                    Catch ex As Exception
                    End Try
                Next

                Dim rs As Int64 = 0
                For count As Integer = 0 To gvd_advance.Rows.Count - 1
                    Dim chk As CheckBox = gvd_advance.Rows(count).FindControl("CheckBox_checked")
                    If chk.Checked = True Then
                        rs = rs + Convert.ToDecimal(gvd_advance.Rows(count).Cells(0).Text)
                    End If
                Next
                Label_Ad_Payment.Text = co.place_Coma(rs)

                Dim lbl_company As Label = GridView_For_Services.FooterRow.Cells(9).FindControl("Label_f_Company")
                Dim lbl_patient As Label = GridView_For_Services.FooterRow.Cells(10).FindControl("Label_f_Patient")
                Dim lblSystemDiscountTotal As Label = GridView_For_Services.FooterRow.Cells(6).FindControl("lblSystemDiscountTotal")
                Dim lblManualDiscountTotal As Label = GridView_For_Services.FooterRow.Cells(7).FindControl("lblManualDiscountTotal")

                GridView_For_Services.FooterRow.Cells(4).Text = co.place_Coma(amount_total)

                lbl_company.Text = co.place_Coma(company_total)
                lbl_patient.Text = co.place_Coma(patient_total)

                lblSystemDiscountTotal.Text = co.place_Coma(systemDiscount_total)
                lblManualDiscountTotal.Text = co.place_Coma(manualDiscount_total)
                Label_Discount.Text = co.place_Coma(Math.Round(manualDiscount_total + systemDiscount_total, 0))

                Try
                    'Dim discount As Decimal = Label_Discount.Text
                    'Dim panelAmount As Decimal = lbl_company.Text - discount
                    TextBox_Panel.Text = co.place_Coma(lbl_company.Text)

                    If TextBox_Credit_Card.Text <> "0" Or TextBox_Cheque.Text <> "0" Then
                        If CInt(co.Remove_Coma(TextBox2.Text)) >= CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text)) Then
                        Else
                            TextBox_Credit_Card.Text = 0
                            TextBox_Cheque.Text = 0
                            TextBox2.Text = lbl_patient.Text
                            Label_Remaining_Balance.Text = co.place_Coma(TextBox2.Text)
                            If Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))) >= Convert.ToDecimal(CInt(co.Remove_Coma(TextBox2.Text))) Then
                                Label_Refund.Text = co.place_Coma(Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text))) + CInt(co.Remove_Coma(Label_Discount.Text)) - Convert.ToDecimal(CInt(co.Remove_Coma(TextBox2.Text))))
                                Label_Remaining_Balance.Text = 0
                            Else
                                If CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - (CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))) >= 0 Then
                                    Label_Remaining_Balance.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - (CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))))
                                Else
                                    Label_Remaining_Balance.Text = 0
                                End If
                                Label_Refund.Text = 0
                            End If
                            If Label_Ad_Payment.Text = "" Then
                                Label_Ad_Payment.Text = 0
                            End If

                            If Convert.ToDecimal(CInt(co.Remove_Coma(lbl_patient.Text))) >= Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) Then
                                If Convert.ToDecimal(CInt(co.Remove_Coma(lbl_patient.Text))) - Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text))) - Convert.ToDecimal(CInt(co.Remove_Coma(Label_Discount.Text))) >= 0 Then
                                    Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)))
                                Else
                                    Label_Cash.Text = 0
                                End If
                            Else
                                If Convert.ToDecimal(CInt(co.Remove_Coma(Label_Remaining_Balance.Text))) - CInt(co.Remove_Coma(Label_Discount.Text)) - Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) > 0 Then
                                    Label_Cash.Text = co.place_Coma(Convert.ToDecimal(CInt(co.Remove_Coma(Label_Remaining_Balance.Text))))
                                Else
                                    Label_Cash.Text = 0
                                End If
                            End If
                        End If
                    Else



                        TextBox2.Text = lbl_patient.Text
                        Label_Remaining_Balance.Text = co.place_Coma(TextBox2.Text)
                        If Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))) >= Convert.ToDecimal(CInt(co.Remove_Coma(TextBox2.Text))) Then
                            Label_Refund.Text = co.place_Coma(Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text))) + CInt(co.Remove_Coma(Label_Discount.Text)) - Convert.ToDecimal(CInt(co.Remove_Coma(TextBox2.Text))))
                            Label_Remaining_Balance.Text = 0
                        Else
                            If CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - (CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))) >= 0 Then
                                Label_Remaining_Balance.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - (CInt(co.Remove_Coma(Label_Ad_Payment.Text)) + CInt(co.Remove_Coma(Label_Discount.Text))))
                            Else
                                Label_Remaining_Balance.Text = 0
                            End If

                            Label_Refund.Text = 0
                        End If
                        If Label_Ad_Payment.Text = "" Then
                            Label_Ad_Payment.Text = 0
                        End If
                        If Convert.ToDecimal(CInt(co.Remove_Coma(lbl_patient.Text))) >= Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) Then
                            If Convert.ToDecimal(CInt(co.Remove_Coma(lbl_patient.Text))) - Convert.ToDecimal(CInt(co.Remove_Coma(Label_Ad_Payment.Text))) - Convert.ToDecimal(CInt(co.Remove_Coma(Label_Discount.Text))) >= 0 Then
                                Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)))
                            Else
                                Label_Cash.Text = 0
                            End If
                        Else
                            If Convert.ToDecimal(CInt(co.Remove_Coma(Label_Remaining_Balance.Text))) - CInt(co.Remove_Coma(Label_Discount.Text)) - Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) > 0 Then
                                Label_Cash.Text = co.place_Coma(Convert.ToDecimal(CInt(co.Remove_Coma(Label_Remaining_Balance.Text))))
                            Else
                                Label_Cash.Text = 0
                            End If
                        End If

                        If txtboxAmount.Text.Trim() <> "" Then

                            Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))

                            hfAmount.Value = Label_Cash.Text

                        End If

                        If Session("Patient_Type_ID") = "4" Then
                            If CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) = 0 Then
                                Label_Refund.Text = "0"
                            End If
                        End If
                    End If
                Catch ex As Exception

                End Try
                If HiddenField_chk.Value = "1" Then
                    Button_Report.Enabled = True
                Else
                    If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(co.Remove_Coma(Label_Ad_Payment.Text)) <> 0 Then
                        Button_Report.Enabled = True
                    Else
                        If CInt(co.Remove_Coma(Label_Discount.Text)) <> 0 Or CInt(Label_Ad_Payment.Text) <> 0 Then
                            Button_Report.Enabled = True
                        Else
                            Button_Report.Enabled = False
                        End If
                    End If

                End If



                If CInt(Label_Refund.Text.Trim().Replace(",", "")) > 0 Then
                    chkboxAmount.Enabled = False
                Else
                    chkboxAmount.Enabled = True
                End If


            Catch ex As Exception

            End Try
        End If
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Label_Amount.Text = ""
        Dim amount As Integer = 0
        For i As Integer = 0 To GridView_For_Services.Rows.Count - 1
            Dim chek As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
            If chek.Checked = True Then
                amount = amount + GridView_For_Services.Rows(i).Cells(4).Text
            End If
        Next
        TextBox2.Text = co.place_Coma(amount)

        Label_Amount.Text = amount

    End Sub
    Protected Sub CheckBox_Header_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chkStatus As Boolean = False
        Dim chekHeader As CheckBox = GridView_For_Services.HeaderRow.FindControl("CheckBox_Header")

        If chekHeader.Checked Then
            chkStatus = True
        End If

        For i As Integer = 0 To GridView_For_Services.Rows.Count - 1

            Dim chek As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
            chek.Checked = chkStatus
        Next
    End Sub

    Protected Sub GridView_View_Payments_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_View_Payments.PreRender
        Try
            For i As Integer = 0 To GridView_View_Payments.Rows.Count - 1
                GridView_View_Payments.Rows(i).Cells(1).Text = ENC.Encrypt_Main(GridView_View_Payments.Rows(i).Cells(1).Text, False)
                Dim lbl_Date As Label = GridView_View_Payments.Rows(i).FindControl("Label1")
            Next
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView_View_Payments_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_View_Payments.RowDataBound

        Try

            If e.Row.RowType = DataControlRowType.DataRow Then

                If (c = "") Then
                    c = e.Row.Cells.Item(3).Text
                    e.Row.Cells.Item(3).Text = c
                ElseIf c = e.Row.Cells.Item(3).Text Then
                    e.Row.Cells.Item(3).Text = ""
                    e.Row.Cells.Item(3).Text = ""
                Else
                    c = e.Row.Cells.Item(3).Text
                    e.Row.Cells.Item(3).Text = c
                End If
            End If
            If e.Row.RowType = DataControlRowType.DataRow Then

                total_amount += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "S_Amount"))
                e.Row.Cells.Item(5).Text = co.place_Coma(e.Row.Cells.Item(5).Text)
                Dim dr As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
                If Not (dr("Status") = "Paid") Then
                    Dim lbtn_cancel As LinkButton = e.Row.FindControl("lbtn_cancel")
                    lbtn_cancel.Enabled = False
                End If
            ElseIf e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(4).Text = "Total Amount:"
                e.Row.Cells(5).Text = co.place_Coma(total_amount)
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridView_View_Payments_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_View_Payments.SelectedIndexChanged


        Try
            Dim Hid_PSID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField1")
            Dim main_ID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_mainID")
            Dim Amount As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_Amount")
            Dim SPM_ID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenField_SPM_ID")
            HiddenField_P_SID.Value = Hid_PSID.Value
            Dim regNo As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenFieldRegNo")
            Dim yearlyNo As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenFieldYearlyNo")
            Dim Discount As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenFieldDiscount")
            Dim S_ID As HiddenField = GridView_View_Payments.Rows(GridView_View_Payments.SelectedIndex).FindControl("HiddenFieldS_id")

            SqlDataSourceRefundRequest.InsertParameters("RegNo").DefaultValue = regNo.Value
            SqlDataSourceRefundRequest.InsertParameters("YearlyNo").DefaultValue = yearlyNo.Value
            SqlDataSourceRefundRequest.InsertParameters("PS_ID").DefaultValue = HiddenField_P_SID.Value
            SqlDataSourceRefundRequest.InsertParameters("S_ID").DefaultValue = S_ID.Value
            SqlDataSourceRefundRequest.InsertParameters("SPM_ID").DefaultValue = SPM_ID.Value
            SqlDataSourceRefundRequest.InsertParameters("Amount").DefaultValue = Amount.Value
            SqlDataSourceRefundRequest.InsertParameters("Discount").DefaultValue = Discount.Value
            SqlDataSourceRefundRequest.Insert()
            SqlDataSource_For_View.Update()

            GridView_View_Payments.DataBind()
            GridView_For_Services.DataBind()

            Calculation()

        Catch ex As Exception

        End Try
    End Sub

    Sub get_subdept_id()
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand(" SELECT     TOP (1) Forward_To_Sub_Dept.to_sub_Dept, Payment.Patient_Type FROM         Forward_To_Sub_Dept INNER JOIN Payment ON Forward_To_Sub_Dept.yearly_no = Payment.PayID WHERE (Reg_No = @reg_no) AND (yearly_no = @Yearly_no) order by forward_date desc", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@Yearly_no", Session("YearlyNo"))
            Dim reader As SqlDataReader = command.ExecuteReader
            If reader.Read Then
                HiddenFieldSubDepartment.Value = reader.Item(0).ToString
                HiddenField_Patient_type.Value = reader.Item(1).ToString
                get_dept_id()
            End If
            con.Close()

        Catch ex As Exception

        End Try
    End Sub

    Sub get_dept_id()
        Dim con1 As SqlConnection = New SqlConnection(constring)
        Dim command As SqlCommand = New SqlCommand("Select Dept_Id from SubDepartment where SubDept_Id=" + HiddenFieldSubDepartment.Value, con1)
        command.CommandType = CommandType.Text

        con1.Open()
        Dim reader1 As SqlDataReader = command.ExecuteReader
        If reader1.Read Then
            HiddenFieldDept_id.Value = reader1.Item(0).ToString
        End If
        con1.Close()
    End Sub

    Protected Sub GridView_For_Services_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_For_Services.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            If (d = "") Then
                d = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = d
            ElseIf d = e.Row.Cells.Item(0).Text Then
                e.Row.Cells.Item(0).Text = ""
                e.Row.Cells.Item(0).Text = ""
            Else
                d = e.Row.Cells.Item(0).Text
                e.Row.Cells.Item(0).Text = d
            End If
            Dim hid As HiddenField = e.Row.Cells(8).FindControl("HiddenField_order_ID")
            HiddenField_Order_ID.Value = hid.Value
        End If
    End Sub

    Protected Sub Button_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Report.Click
        Try
            Dim services As String = String.Empty
            Dim check As New CheckBox
            Dim hf_ID As New HiddenField
            Dim hf_SID As New HiddenField
            Dim txt_company As New TextBox
            Dim txt_patient As New TextBox
            Dim advances As String = String.Empty

            If Label_Refund.Text <> "" Or TextBox_Panel.Text <> "0" Then

                For Each gv As GridViewRow In GridView_For_Services.Rows
                    check = gv.FindControl("CheckBox1")

                    If check.Checked Then
                        hf_ID = gv.FindControl("HiddenField_ID")
                        hf_SID = gv.FindControl("HiddenField_SID")
                        txt_company = gv.FindControl("TextBox_company")
                        HiddenFieldAmount = gv.FindControl("HiddenFieldAmount")
                        If String.IsNullOrEmpty(txt_company.Text.Trim()) Then
                            txt_company.Text = "0"
                        End If
                        If String.IsNullOrEmpty(txt_patient.Text.Trim()) Then
                            txt_patient.Text = "0"
                        End If
                        services = services + "<services><ps_id>" + hf_ID.Value + "</ps_id><s_id>" + hf_SID.Value + "</s_id><company>" + co.Remove_Coma(txt_company.Text.Trim()) + "</company><TotalAmount>" + co.Remove_Coma(HiddenFieldAmount.Value.Trim()) + "</TotalAmount></services>"
                    End If
                Next

                For Each row As GridViewRow In gvd_advance.Rows
                    check = row.FindControl("CheckBox_checked")
                    If check.Checked Then
                        hf_ID = row.FindControl("HiddenField2")
                        advances = advances + "<advances><A_ID>" + hf_ID.Value + "</A_ID></advances>"

                    End If

                Next
                getDept(CStr(Session("RegistrationNo")), CInt(Session("YearlyNo")))

            End If

            HiddenFieldPaymentTpye.Value = "Bill"

            If CInt(co.Remove_Coma(Label_Refund.Text)) > 0 Then
                HiddenFieldPaymentTpye.Value = "Refund"
                If String.IsNullOrEmpty(services) Then
                    HiddenFieldPaymentTpye.Value = "Advance Refund"
                End If


                'HiddenFieldAmount.Value = co.Remove_Coma(CInt(Label_Refund.Text))

                'SDS_Refund.InsertParameters("Advance_payment").DefaultValue = co.Remove_Coma(Label_Ad_Payment.Text)
                'SDS_Refund.InsertParameters("Current_Payment").DefaultValue = co.Remove_Coma(Label_Cash.Text)
                'SDS_Refund.InsertParameters("IsRefund").DefaultValue = rdoRefund.SelectedValue
                'SDS_Refund.Insert()
            End If

            'Insert_bill(services, advances)
            'If CKFinal.Checked Then
            '    Insert_bill_log(txt_remarks.Text.Trim())
            'End If
            Insert_bill(services, advances)
            Dim FinalCk As Boolean = False
            If Session("Patient_Type_ID") = "4" Then
                FinalCk = True
            End If
            If CKFinal.Checked Or FinalCk Then
                Insert_bill_log(txt_remarks.Text.Trim())
            End If

            gvd_advance.DataBind()
            'discount_Update()
            GridView_For_Services.DataBind()
            GridView_View_Payments.DataBind()
            'discount()
            Calculation()


            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript'>")
            Dim url As String = String.Empty
            If Not String.IsNullOrEmpty(HiddenField_smpID.Value) Then

                If CKFinal.Checked Then
                    url = "patientServices.aspx?AP_ID=1&SPMID=" + HiddenField_smpID.Value


                Else
                    If GetPatientSlipType(Convert.ToInt32(HiddenField_smpID.Value)) = True Then
                        url = "OPD_Slip_Report_Private.aspx?SPMID=" + HiddenField_smpID.Value
                    Else
                        url = "patientServices.aspx?SPMID=" + HiddenField_smpID.Value
                    End If

                End If
            Else
                If Not HiddenFieldreturnID.Value = "" Then
                    ' url = Server.MapPath("Indoor_Payment_refund.aspx?Refund_iD=" + HiddenFieldreturnID.Value)
                    url = "Patientrefund_Details.aspx?Refund_iD=" + HiddenFieldreturnID.Value + "&regno=" + CStr(Session("RegistrationNo")) + "&yearlyNo=" + CStr(Session("YearlyNo"))

                End If

            End If
            sb.Append(" window.open('" + url + "')</script>")
            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If

        Catch ex As Exception

        End Try
        ClearLabels()

    End Sub
    Function GetPatientSlipType(spmId As Integer) As Boolean

        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "usp_PatientSlipType"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = Procedurename
        mycommand.Parameters.AddWithValue("@smpId", spmId)
        mycommand.Parameters.Add("@SPM_ID", Data.SqlDbType.Int)
        mycommand.Parameters("@SPM_ID").Direction = Data.ParameterDirection.Output
        con.Open()
        mycommand.ExecuteNonQuery()
        Dim SPM_Id As Integer = mycommand.Parameters("@SPM_ID").Value.ToString()
        mycommand.Connection.Close()
        If SPM_Id > 0 Then
            Return True
        Else
            Return False
        End If

    End Function

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
    End Sub

    Protected Sub TextBox_Credit_Card_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Credit_Card.TextChanged
        If hfAmount.Value = "" Then
            hfAmount.Value = Label_Cash.Text.Trim().Replace(",", "")
        End If
        If txtboxAmount.Text = "" Then
            txtboxAmount.Text = "0"
        End If

        If TextBox_Credit_Card.Text = "" Then
            TextBox_Credit_Card.Text = "0"
        End If
        If txtboxAmount.Text.Trim() <> "0" Then
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text))) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        ElseIf co.Remove_Coma(hfAmount.Value) = "0" Then

            If TextBox_Credit_Card.Text = "" Then
                TextBox_Credit_Card.Text = "0"
            End If
            If TextBox_Cheque.Text = "" Then
                TextBox_Cheque.Text = "0"
            End If
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then

                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        Else
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        End If
    End Sub

    Protected Sub TextBox_Cheque_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Cheque.TextChanged
        If hfAmount.Value = "" Then
            hfAmount.Value = Label_Cash.Text.Trim().Replace(",", "")
        End If
        If TextBox_Cheque.Text = "" Then
            TextBox_Cheque.Text = "0"
        End If
        If txtboxAmount.Text = "" Then
            txtboxAmount.Text = "0"
        End If

        If txtboxAmount.Text.Trim() <> "0" Then
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        ElseIf co.Remove_Coma(hfAmount.Value) = "0" Then
            If TextBox_Credit_Card.Text = "" Then
                TextBox_Credit_Card.Text = "0"
            End If
            If TextBox_Cheque.Text = "" Then
                TextBox_Cheque.Text = "0"
            End If
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        Else
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                hfAmount.Value = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                Label_Cash.Text = hfAmount.Value
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        End If

    End Sub

    Protected Sub TextBox_Panel_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Panel.TextChanged
        hfAmount.Value = co.place_Coma(co.Remove_Coma(Label_Remaining_Balance.Text) - co.Remove_Coma(TextBox_Credit_Card.Text) - co.Remove_Coma(TextBox_Cheque.Text) - co.Remove_Coma(TextBox_Panel.Text) - co.Remove_Coma(Label_Discount.Text))
    End Sub
    Sub Initialize()
        If TextBox_Credit_Card.Text = "" Then
            TextBox_Credit_Card.Text = 0
        End If
        If TextBox_Cheque.Text = "" Then
            TextBox_Cheque.Text = 0
        End If
        If TextBox_Panel.Text = "" Then
            TextBox_Panel.Text = 0
        End If
    End Sub
    Sub set_Advance_Payment()

        hfAmount.Value = "0"

        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim reader As SqlDataReader
        Dim mycommand1 As New System.Data.SqlClient.SqlCommand(" SELECT     ISNULL(SUM(Amount), 0) AS Amount, Payment_Type FROM         Advance_Payment where RegNo = @RegNo and YearlyNo = @YearlyNo and Payment_Status=0 GROUP BY Payment_Type", con)
        mycommand1.CommandType = Data.CommandType.Text
        mycommand1.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand1.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand1.Connection.Open()
        reader = mycommand1.ExecuteReader
        While reader.Read
            If reader.Item(1) = "Cash" Then

            ElseIf reader.Item(1) = "Credit Card" Then
                TextBox_Credit_Card.Text = co.place_Coma(Convert.ToInt32(co.Remove_Coma(TextBox_Credit_Card.Text)) + Convert.ToInt32(reader.Item(0)))
            ElseIf reader.Item(1) = "Cheque" Then
                TextBox_Cheque.Text = co.place_Coma(Convert.ToInt32(co.Remove_Coma(TextBox_Cheque.Text)) + Convert.ToInt32(reader.Item(0)))

            End If

        End While


        reader.Close()
        mycommand1.Connection.Close()

    End Sub
    Protected Sub SqlDataSource_test_Booking_New_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_test_Booking_New.Inserted
        HiddenField_main_ID_patient.Value = e.Command.Parameters("@main_ID_Patient").Value

    End Sub

    Protected Sub Button_lab_Test_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_lab_Test.Click
        'for_OT()
        Dim services As String = String.Empty
        Dim check As New CheckBox
        Dim hf_ID As New HiddenField
        Dim hf_SID As New HiddenField
        Dim txt_company As New TextBox
        Dim txt_patient As New TextBox

        For Each gv As GridViewRow In GridView_For_Services.Rows
            check = gv.FindControl("CheckBox1")
            If check.Checked Then
                hf_ID = gv.FindControl("HiddenField_ID")
                hf_SID = gv.FindControl("HiddenField_SID")
                txt_company = gv.FindControl("TextBox_company")
                txt_patient = gv.FindControl("TextBox_Patient")
                If String.IsNullOrEmpty(txt_company.Text.Trim()) Then
                    txt_company.Text = "0"
                End If
                If String.IsNullOrEmpty(txt_patient.Text.Trim()) Then
                    txt_patient.Text = "0"
                End If
                services = services + "<services><ps_id>" + hf_ID.Value + "</ps_id><s_id>" + hf_SID.Value + "</s_id><company>" + co.Remove_Coma(txt_company.Text.Trim()) + "</company><Patient>" + co.Remove_Coma(txt_patient.Text.Trim()) + "</Patient></services>"
            End If
        Next

        Forward_Services(services)


        GridView_For_Services.DataBind()
    End Sub

    Protected Sub SqlDataSource_test_Booking_Radiology_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_test_Booking_Radiology.Inserted
        HiddenField_Main_ID_Radiology.Value = e.Command.Parameters("@main_ID_Patient").Value
    End Sub

    Sub Payment_Detail(ByVal SPM_ID As Long)
        Dim connection As New SqlConnection
        Dim command As New SqlCommand

        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        command = connection.CreateCommand
        Dim Refund As Long = 0

        If Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) > Convert.ToDecimal(co.Remove_Coma(hfAmount.Value)) Then
            Refund = Convert.ToDecimal(co.Remove_Coma(Label_Ad_Payment.Text)) - Convert.ToDecimal(co.Remove_Coma(hfAmount.Value))
        End If
        command.CommandText = " Insert into Payment_Detail(SPM_ID, Advance, Credit_Card, Cheque, Party, Cash, Refund,Discount,Reg_No,Yearly_No) Values(" + _
            Convert.ToString(SPM_ID) + "," + co.Remove_Coma(Label_Ad_Payment.Text) + "," + co.Remove_Coma(TextBox_Credit_Card.Text) + "," + co.Remove_Coma(TextBox_Cheque.Text) + _
            "," + co.Remove_Coma(TextBox_Panel.Text) + "," + co.Remove_Coma(hfAmount.Value) + "," + co.Remove_Coma(Label_Refund.Text) + "," + co.Remove_Coma(Label_Discount.Text) + _
            ",'" + Session("registrationNo") + "'," + Session("YearlyNo") + ")"
        connection.Open()
        command.ExecuteNonQuery()
        connection.Close()
        '=======================================================






    End Sub
    Sub discount()

        Try
            'If Session("patientType") = "Private" Then


            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
            command = connection.CreateCommand

            command.CommandText = " SELECT     sum(Total_Amount) AS Amount FROM         Discount_Main WHERE     (RegNo ='" + Request.QueryString("regno") + "') AND (YearlyNo =" & Request.QueryString("payid") & ") and Payment_Status=0"
            connection.Open()
            reader = command.ExecuteReader


            Dim Service_Discount As Double = 0

            For Each Row As GridViewRow In GridView_For_Services.Rows
                Dim HF_Discount As HiddenField = Row.FindControl("hf_Service_discount")
                Dim ch As CheckBox = Row.FindControl("CheckBox1")

                If ch.Checked Then
                    Try
                        If String.IsNullOrEmpty(HF_Discount.Value) Then
                            Service_Discount += 0
                        Else
                            If ch.Checked Then
                                Service_Discount += CDbl(HF_Discount.Value)
                            End If

                        End If
                    Catch ex As Exception
                        Service_Discount += 0
                    End Try

                End If

            Next

            If reader.Read Then
                If reader.Item(0) Is DBNull.Value OrElse String.IsNullOrEmpty(reader.Item(0)) Then
                    Label_Discount.Text = co.place_Coma(Service_Discount)
                Else
                    Label_Discount.Text = co.place_Coma(reader.Item(0) + Service_Discount)
                End If

            End If

            reader.Close()
            connection.Close()
            discount_sub()
            'End If

        Catch ex As Exception

        End Try
    End Sub

    Sub discount_sub()

        Try
            If Session("patientType") = "Private" Then


                Dim connection As New SqlConnection
                Dim command As New SqlCommand
                Dim reader As SqlDataReader
                connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
                command = connection.CreateCommand

                command.CommandText = " SELECT    sum(isnull(Discount_Sub.Discount_Sub_Amount,0)) as [Discount_Sub_Amount]  FROM         Discount_Main INNER JOIN Discount_Sub ON Discount_Main.Discount_ID = Discount_Sub.Discount_ID WHERE     (RegNo ='" + Request.QueryString("regno") + "') AND (YearlyNo =" & Request.QueryString("payid") & ") and Payment_Status=0 and Discount_Sub.Doctor_ID <>0 "
                connection.Open()
                reader = command.ExecuteReader


                If reader.Read Then
                    HiddenField_Doctor_Discount.Value = reader.Item(0)
                Else
                    HiddenField_Doctor_Discount.Value = "0"
                End If

                reader.Close()
                connection.Close()
            End If
        Catch ex As Exception

        End Try
    End Sub
    Sub discount_Update()

        Try
            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
            command = connection.CreateCommand

            command.CommandText = "Update Discount_Main set Payment_Status=1 , SPM_ID = " + HiddenField_smpID.Value + " WHERE     (RegNo ='" + Request.QueryString("regno") + "') AND (YearlyNo =" & Request.QueryString("payid") & ") and Payment_Status=0"
            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()
            Label_Discount.Text = 0
        Catch ex As Exception

        End Try
        Dim rs As Int64 = 0
        For count As Integer = 0 To gvd_advance.Rows.Count - 1
            Dim chk As CheckBox = gvd_advance.Rows(count).FindControl("CheckBox_checked")
            If chk.Checked = True Then
                rs = rs + Convert.ToDecimal(gvd_advance.Rows(count).Cells(0).Text)

            End If

        Next
        Label_Ad_Payment.Text = co.place_Coma(rs)
        Label_Refund.Text = co.place_Coma(rs)

    End Sub
    Private Function GetRadQueryStringData(ByVal regno As String, ByVal yearlyNo As Integer) As DataTable
        Dim path_constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim dt As New DataTable
        Dim da As New SqlDataAdapter
        Dim qry As String = "SELECT Order_ID, DeptId, SubDept_Id FROM Radiology_Order_main WHERE (YearlyNo = @YearlyNo) AND (RegNo = @RegNo)"
        Dim con As New SqlConnection(path_constring)
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@YearlyNo", yearlyNo)
        cmd.Parameters.AddWithValue("@RegNo", regno)
        con.Open()
        da.SelectCommand = cmd
        da.Fill(dt)
        con.Close()
        Return dt
    End Function
    Function Select_Rad_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select isnull(max(Main_ID),0) as [Main_ID] From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Rad_Values()
        Dim SDate As Date = Date.Now 'WebDateChooser1.Value & " " & Date.Now.Hour & ":" & Date.Now.Minute & ":" & Date.Now.Second
        Dim report_date As Date = DateAdd(DateInterval.Day, 1, Date.Now)
        Dim a As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Save_alreadeybook_Patient_next_Appointment", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@Reg_no", Session("RegistrationNo"))
        param = mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Sample_Collection_Date", SDate)
        param = mycommand.Parameters.AddWithValue("@Sample_No", Session("YearlyNo"))
        param = mycommand.Parameters.AddWithValue("@Report_Deliverd", report_date)
        param = mycommand.Parameters.AddWithValue("@Grand_Discount", 0)
        param = mycommand.Parameters.AddWithValue("@Description", "")
        param = mycommand.Parameters.AddWithValue("@Test_Type_ID", 1)
        param = mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        param = mycommand.Parameters.AddWithValue("@HospitalOrderNo", HF_Rad_Order_ID.Value)
        param = mycommand.Parameters.AddWithValue("@From_Dept_ID", HF_Rad_FromDept_Id.Value)
        param = mycommand.Parameters.AddWithValue("@From_SubDept_ID", HF_Rad_FromSubDept_ID.Value)
        param = mycommand.Parameters.AddWithValue("@To_Dept_ID", 18)
        param = mycommand.Parameters.AddWithValue("@To_SubDept_ID", 1)
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Label3.Text = mycommand.Parameters("@identity1").Value
        HiddenField_Rad_Main_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Sub Payment_Rad_Button_Save()
        Try
            Dim RegNo As String = Request.QueryString("regno")
            Dim YearlyNo As Integer = Request.QueryString("payid")
            'HiddenFieldTotalAmount.Value = 0 ' CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotalPaid.Value = 0 'CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            'HiddenFieldTotal_Discount.Value = 0 'TotalDiscount()
            HiddenField_Rad_Main_ID.Value = Select_Rad_Main_ID(RegNo, YearlyNo)
            Insert_Rad_Test_Info()
            SqlDataSourceRadInsertSub.Insert()
            '          Update_Rad_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub

    Sub Insert_Rad_Test_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE  (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) and Path_Result_Delivery.Fee_paid=0 and Test_Booking_Services.Main_ID=@Main_ID", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))
            mycommand.Parameters.AddWithValue("@Main_ID", HiddenField_Rad_Main_ID.Value)
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("Insert_Pt_Pathology_Test_Amount", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@Yearly_No", Request.QueryString("payid")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@RID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@Reg_No", Request.QueryString("regno")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Rad_Main_ID(Request.QueryString("regno"), Request.QueryString("payid")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            '  Response.Write(ex.Message)
        End Try
    End Sub
    Public Sub update_Rad_Test_Booking_Status(ByVal Status As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Update_Test_Booking_Status", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Connection.Open()
        mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        mycommand.Parameters.AddWithValue("@Status", Status)
        'mycommand.Parameters.AddWithValue("@Main_ID", HiddenFieldMain_ID.Value)

        mycommand.ExecuteNonQuery()
        mycommand.Connection.Close()


    End Sub

    Protected Sub Button_Discount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Discount.Click
        If Label_Discount.Text = "0" Then
            DropDownList_Hospital.SelectedValue = Session("hospitalid").ToString()
            ' DropDownList_Consultant.DataBind()
            DropDownList_Hospital.Enabled = False
            Panel_Discount.Visible = True
        Else
            Panel_Discount.Visible = True
            '  Response.Redirect("~/Patient Billing/Indoor_Payment_Discount.aspx?Payment_No="+92+"&PayID="+ Request.QueryString("payid").ToString()+"&RegNo="+Request.QueryString("regno").ToString()+"&Type=Discount"
        End If
        'Response.Redirect("Discount.aspx?regno=" + Request.QueryString("regno") + "&payid=" & Request.QueryString("payid"))


    End Sub


    'Protected Sub Button_Rad_For_Payment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Rad_For_Payment.Click

    '    Try
    '        'HiddenFieldMain_ID.Value = Select_Main_ID(Request.QueryString("Reg_No"), Request.QueryString("YearlyNo"))
    '        For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
    '            Dim HF_Order_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_Order_ID")
    '            Dim HiddenField_TB_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HiddenField_TB_ID")
    '            Dim is_checked As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
    '            Dim Label_EmpID As Label = GridView_Rad_Sample_Recieved.Rows(i).FindControl("Label_EmpID")
    '            Dim HF_S_Amount As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_S_Amount")
    '            Dim HF_S_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_S_ID")
    '            Dim HF_Dept_ID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_Dept_ID")
    '            Dim HF_SubDeptID As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_SubDeptID")
    '            Dim HF_ServiceType As HiddenField = GridView_Rad_Sample_Recieved.Rows(i).FindControl("HF_ServiceType")
    '            If is_checked.Checked = True Then
    '                If HF_ServiceType.Value = "Rad" Then
    '                    insert_Into_Rad_Patient_Services(Label_EmpID.Text, HF_S_ID.Value, HF_S_Amount.Value, HF_SubDeptID.Value, HF_Dept_ID.Value, HF_Order_ID.Value, HiddenField_TB_ID.Value)
    '                ElseIf HF_ServiceType.Value = "Path" Then
    '                    insert_Into_Path_Patient_Services(Label_EmpID.Text, HF_S_ID.Value, HF_S_Amount.Value, HF_SubDeptID.Value, HF_Dept_ID.Value, HF_Order_ID.Value, HiddenField_TB_ID.Value)
    '                ElseIf HF_ServiceType.Value = "OT" Then
    '                    insert_Into_OT_Patient_Services(Label_EmpID.Text, HF_S_ID.Value, HF_S_Amount.Value, HF_SubDeptID.Value, HF_Dept_ID.Value, HF_Order_ID.Value, HiddenField_TB_ID.Value)
    '                End If
    '            End If
    '        Next

    '        '            SqlDataSource_Rad_Patient_Services.Insert()
    '    Catch ex As Exception

    '    End Try
    '    GridView_For_Services.DataBind()
    '    GridView_Rad_Sample_Recieved.DataBind()

    '    If Get_Type(Session("YearlyNo")) = "OPD" Then
    '        'GridView_For_Services.DataBind()
    '        If GridView_For_Services.Rows.Count = 0 Then
    '            GridView_For_Services.Visible = False
    '        Else
    '            GridView_For_Services.Visible = True
    '        End If

    '        If GridView_Rad_Sample_Recieved.Rows.Count = 0 Then
    '            pnl_Radiology_Sample.Visible = False
    '        Else
    '            pnl_Radiology_Sample.Visible = True
    '        End If

    '    Else
    '        pnl_Radiology_Sample.Visible = False

    '    End If

    'End Sub
    Private Sub insert_Into_Rad_Patient_Services(ByVal emp_ID As Integer, ByVal S_Id As Integer, ByVal S_Amount As Integer, ByVal subdeptID As Integer, ByVal DeptID As Integer, ByVal Order_ID As Integer, ByVal TB_ID As Integer)
        Dim Rad_constr As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con As New SqlConnection(Rad_constr)
        Dim sp As String = "Insert_Radiology_Patient_Services"
        Dim cmd As New SqlCommand(sp, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
        cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))

        cmd.Parameters.AddWithValue("@empid", emp_ID)
        cmd.Parameters.AddWithValue("@S_ID", S_Id)
        cmd.Parameters.AddWithValue("@Amount", S_Amount)
        cmd.Parameters.AddWithValue("@SubDept_ID", subdeptID)

        cmd.Parameters.AddWithValue("@Dept_ID", DeptID)
        cmd.Parameters.AddWithValue("@Order_ID", Order_ID)
        cmd.Parameters.AddWithValue("@TB_ID", TB_ID)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub
    Private Sub insert_Into_Path_Patient_Services(ByVal emp_ID As Integer, ByVal S_Id As Integer, ByVal S_Amount As Integer, ByVal subdeptID As Integer, ByVal DeptID As Integer, ByVal Order_ID As Integer, ByVal TB_ID As Integer)
        Dim Rad_constr As String = ConfigurationManager.ConnectionStrings("Pathology2ConnectionString").ConnectionString
        Dim con As New SqlConnection(Rad_constr)
        Dim sp As String = "Insert_Pathology_Patient_Services"
        Dim cmd As New SqlCommand(sp, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
        cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))

        cmd.Parameters.AddWithValue("@empid", emp_ID)
        cmd.Parameters.AddWithValue("@S_ID", S_Id)
        cmd.Parameters.AddWithValue("@Amount", S_Amount)
        cmd.Parameters.AddWithValue("@SubDept_ID", subdeptID)

        cmd.Parameters.AddWithValue("@Dept_ID", DeptID)
        cmd.Parameters.AddWithValue("@Order_ID", Order_ID)
        cmd.Parameters.AddWithValue("@TB_ID", TB_ID)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub


    Protected Sub Button_CheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_CheckAll.Click
        'For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
        '    Dim check As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
        '    check.Checked = True
        'Next
    End Sub

    Protected Sub Button_Un_Check_All_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Un_Check_All.Click
        'For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
        '    Dim check As CheckBox = GridView_Rad_Sample_Recieved.Rows(i).FindControl("CheckBox1")
        '    check.Checked = False
        'Next
    End Sub

    Protected Sub Button_ForwardDisReq_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_ForwardDisReq.Click
        Dim objDbManager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("YearlyNo", Session("YearlyNo"))
         }

        Dim dtDiscount As DataTable = objDbManager.ExecuteDataTable("CheckDiscountRequest", "Reg_ConnectionString", sqlParams)

        If (dtDiscount.Rows.Count > 0) Then
            lblDiscountMsg.Text = "Discount request already forward to " + dtDiscount.Rows(0)("Employee")
        Else
            Dim ccc As New SqlConnection(constring)
            Dim query As String = "SELECT SubDeptId FROM   Employee WHERE (EmpID = " + DropDownList_Consultant.SelectedValue + ")"
            Dim ccmd As New SqlCommand(query, ccc)
            ccc.Open()
            HiddenField_SubDeptId.Value = Convert.ToString(ccmd.ExecuteScalar())
            HiddenField_BySubDeptId.Value = Session("SubDeptId")
            ccc.Close()

            SqlDataSource3.Insert()
            Panel_Discount.Visible = False
            Button_Discount.Visible = True
            lblDiscountMsg.Text = ""
            Response.Redirect("~/Patient Billing/PatientSearch.aspx")
        End If


    End Sub

    Protected Sub RadioButtonList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList2.SelectedIndexChanged



    End Sub

    Protected Sub btn_refundReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_refundReport.Click

        'sb.Append("<script language='javascript' type='text/javascript'>window.open('Indoor_Payment_receipt.aspx?Payment_No=" + HiddenFieldMainId.Value + "&PayID=" + Session("YearlyNo") + "&RegNo=" + Session("RegistrationNo") + "&Type=Advance" + "')</script>")
        'HiddenFieldMainId.Value = e.Command.Parameters("@PaymentNo").Value

        'Dim sb As StringBuilder = New StringBuilder
        'sb.Append("<script language='javascript'>")
        'sb.Append(" window.open('Indoor_Payment_refund.aspx')</script>")

        'Dim t As Type = Me.GetType
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        'End If
        '    Response.Redirect("Indoor_Payment_refund.aspx?PayID=" + Convert.ToString(Session("YearlyNo")) + "&RegNo=" + Convert.ToString(Session("RegistrationNo")))


    End Sub

    Protected Sub GridView_Rad_Sample_Recieved_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Rad_Sample_Recieved.PreRender
        'For i As Integer = 0 To GridView_Rad_Sample_Recieved.Rows.Count - 1
        '    GridView_Rad_Sample_Recieved.Rows.Item(i).Cells(0).Text = (i + 1).ToString
        'Next
    End Sub


    Protected Sub gvd_advance_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvd_advance.PreRender

        Calculation()

        'For count As Integer = 0 To gvd_advance.Rows.Count - 1
        '    Dim chk As CheckBox = gvd_advance.Rows(count).FindControl("CheckBox_checked")
        '    Dim hid As HiddenField = gvd_advance.Rows(count).FindControl("HiddenField2")
        '    chk.Checked = False
        '    If chk.Checked = True Then
        '        HiddenField_Payment_No.Value = hid.Value
        '        SqlDataSource2.Update()

        '    End If
        '    chk.Checked = True
        'Next


    End Sub

    Protected Sub SDS_Refund_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SDS_Refund.Inserted

        HiddenFieldreturnID.Value = e.Command.Parameters("@Refund_id").Value
        HiddenFieldMainId.Value = HiddenFieldreturnID.Value
        HiddenFieldAmount.Value = co.Remove_Coma(Label_Refund.Text)
        If String.IsNullOrEmpty(HiddenField_smpID.Value) = True Then

            HiddenFieldPaymentTpye.Value = "Advance Refund"
        Else
            HiddenFieldPaymentTpye.Value = "Refund"
        End If

    End Sub
    Protected Sub Search(ByVal Visit_No As String)
        Dim where As String = "where (PayID = " + Visit_No + ")"
        Dim query As String = ""
        Dim connection As New SqlConnection
        Dim command As New SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        command = connection.CreateCommand

        query = "SELECT Payment.RegNo, Payment.PatientType, Patient.PFName, Patient.PMName,Patient.PLName FROM Payment INNER JOIN Patient ON Payment.RegNo = Patient.RegNo "

        Dim reg As String = ""
        Dim pt_name As String = String.Empty
        Dim Pt_Type As String = String.Empty

        query = query + where
        command.CommandText = query


        connection.Open()
        reader = command.ExecuteReader
        If reader.Read Then
            reg = reader.Item("RegNo").ToString()

            If Not String.IsNullOrEmpty(reader.Item("PFName")) Then
                patient_name(pt_name, reader.Item("PFName"))
            End If
            If Not String.IsNullOrEmpty(reader.Item("PMName")) Then
                patient_name(pt_name, reader.Item("PMName"))
            End If
            If Not String.IsNullOrEmpty(reader.Item("PLName")) Then
                patient_name(pt_name, reader.Item("PLName"))
            End If

            Pt_Type = reader.Item("PatientType").ToString()

        End If



        connection.Close()
        Session.Add("RegistrationNo", reg)
        Session.Add("YearlyNo", Visit_No)
        Session.Add("PatientName", pt_name)
        Session.Add("PatientType", Pt_Type)
        Session.Add("PayId", Visit_No)
        Response.Redirect("~/Patient Billing/Patient_Payment.aspx?regno=" + reg + "&payID=" + Visit_No)
    End Sub

    Protected Sub TXT_Load_patient_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TXT_Load_patient.TextChanged
        If Not String.IsNullOrEmpty(TXT_Load_patient.Text.Trim()) Then
            Search(TXT_Load_patient.Text.Trim())

        End If
    End Sub
    Protected Sub patient_name(ByRef pt_old As String, ByVal pt_new As String)
        If String.IsNullOrEmpty(pt_old) Then
            pt_old = ENC.Encrypt_Main(pt_new, False)
        Else
            pt_old = pt_old + " " + ENC.Encrypt_Main(pt_new, False)
        End If
    End Sub

    Sub IPD_Services_discount_Update()

        Try
            Dim connection As New SqlConnection
            Dim command As New SqlCommand


            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "usp_Insert_IPD_Discount"
            command.Parameters.AddWithValue("@emp_id", Session("emp_id"))
            command.Parameters.AddWithValue("@amount", Label_Discount.Text)
            command.Parameters.AddWithValue("@regNo", Request.QueryString("regno"))
            command.Parameters.AddWithValue("@yearlyNo", Request.QueryString("payid"))
            command.Parameters.AddWithValue("@smp_id", HiddenField_smpID.Value)

            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()

        Catch ex As Exception

        End Try


    End Sub

    Protected Sub CKFinal_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles CKFinal.CheckedChanged

        Dim Ck As New CheckBox
        For Each row As GridViewRow In gvd_advance.Rows
            Ck = row.FindControl("CheckBox_checked")
            Ck.Checked = True

        Next

        For Each row As GridViewRow In GridView_For_Services.Rows
            Ck = row.FindControl("CheckBox1")
            Ck.Checked = True
        Next
        If Ck.Checked Then
            div_final.Style.Remove("display")
        Else
            txt_remarks.Text = String.Empty
            div_final.Style.Add("display", "none")

        End If

        CKFinal.Enabled = False
        'If CKFinal.Checked Then
        '    'Response.Write(Label_Remaining_Balance.Text)
        '    If Label_Remaining_Balance.Text = "0" Then
        '        Button_Report.Visible = True
        '    Else
        '        Button_Report.Visible = False
        '    End If
        'End If
    End Sub

    Protected Sub Btn_Revoke_discount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Revoke_discount.Click
        Dim RegNo As New HiddenField
        Dim YearlyNo As New HiddenField
        For Each row As GridViewRow In GridView_For_Services.Rows
            Dim ck As CheckBox = row.FindControl("CheckBox1")

            If ck.Checked Then
                Dim PSID As HiddenField = row.FindControl("HiddenField_ID")
                Dim D_amount As HiddenField = row.FindControl("hf_Service_discount")
                RegNo = row.FindControl("HF_RegNo")
                YearlyNo = row.FindControl("HF_YearlyNo")

                SDS_Revoke_discount.UpdateParameters("ID").DefaultValue = PSID.Value
                SDS_Revoke_discount.InsertParameters("Reg_No").DefaultValue = RegNo.Value
                SDS_Revoke_discount.InsertParameters("Yearly_No").DefaultValue = YearlyNo.Value
                SDS_Revoke_discount.InsertParameters("PS_ID").DefaultValue = PSID.Value
                SDS_Revoke_discount.InsertParameters("Amount").DefaultValue = D_amount.Value

                SDS_Revoke_discount.Insert()
                SDS_Revoke_discount.Update()
                'discount()


            End If
        Next
        Response.Redirect("~/Patient%20Billing/Indoor_Patient_Paymen.aspx?regno=" + RegNo.Value + "&payid=" + YearlyNo.Value)
    End Sub
    Sub Insert_bill_log(ByVal Remarks As String)

        Try
            Dim connection As New SqlConnection
            Dim command As New SqlCommand


            connection.ConnectionString = ConfigurationManager.ConnectionStrings("PatientBilllingConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandType = CommandType.StoredProcedure
            command.CommandText = "Insert_Patient_final_Bill"

            command.Parameters.AddWithValue("@Reg_no", Request.QueryString("regno"))
            command.Parameters.AddWithValue("@yearlyNo", Request.QueryString("payid"))
            command.Parameters.AddWithValue("@Remarks", Remarks)
            command.Parameters.AddWithValue("@SMPID", HiddenField_smpID.Value)
            command.Parameters.AddWithValue("@emp_id", Session("emp_id"))
            command.Parameters.AddWithValue("@Party_Id", If(DropDownList_Company.SelectedValue = "", "0", DropDownList_Company.SelectedValue))
            command.Parameters.AddWithValue("@Party_Amount", co.Remove_Coma(TextBox_Panel.Text))
            command.Parameters.AddWithValue("@Patient_Amount", co.Remove_Coma(TextBox2.Text))
            command.Parameters.AddWithValue("@CKFinal", CKFinal.Checked)


            connection.Open()
            command.ExecuteNonQuery()
            connection.Close()

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub Btn_Grant_discount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Grant_discount.Click
        Dim discount_amount As Integer = 0
        Dim RegNo As New HiddenField
        Dim YearlyNo As New HiddenField
        For Each row As GridViewRow In GridView_For_Services.Rows
            Dim ck As CheckBox = row.FindControl("CheckBox1")
            Dim discount_per As Integer = 0
            Dim p_m As Integer = 0, C_m As Integer = 0
            If ck.Checked Then
                Dim PSID As HiddenField = row.FindControl("HiddenField_ID")
                Dim C_amount As TextBox = row.FindControl("TextBox_company")
                Dim P_amount As TextBox = row.FindControl("TextBox_Patient")
                RegNo = row.FindControl("HF_RegNo")
                YearlyNo = row.FindControl("HF_YearlyNo")
                If Not String.IsNullOrEmpty(C_amount.Text.Trim()) Then
                    C_m = C_amount.Text.Trim()

                End If
                If Not String.IsNullOrEmpty(P_amount.Text) Then
                    p_m = P_amount.Text.Trim()

                End If
                discount_per = (C_m + p_m) * 0.4

                discount_amount = discount_amount + discount_per
                SDS_Grant_Discount.UpdateParameters("ID").DefaultValue = PSID.Value
                SDS_Grant_Discount.UpdateParameters("Discount").DefaultValue = discount_per

                SDS_Grant_Discount.InsertParameters("Reg_No").DefaultValue = RegNo.Value
                SDS_Grant_Discount.InsertParameters("Yearly_No").DefaultValue = YearlyNo.Value
                SDS_Grant_Discount.InsertParameters("PS_ID").DefaultValue = PSID.Value
                SDS_Grant_Discount.InsertParameters("Amount").DefaultValue = discount_per

                SDS_Grant_Discount.Insert()
                SDS_Grant_Discount.Update()



            End If
        Next

        Response.Redirect("~/Patient%20Billing/Indoor_Patient_Paymen.aspx?regno=" + RegNo.Value + "&payid=" + YearlyNo.Value)

    End Sub
    Private Sub insert_Into_OT_Patient_Services(ByVal emp_ID As Integer, ByVal S_Id As Integer, ByVal S_Amount As Integer, ByVal subdeptID As Integer, ByVal DeptID As Integer, ByVal Order_ID As Integer, ByVal TB_ID As Integer)
        Dim Rad_constr As String = ConfigurationManager.ConnectionStrings("OTConnectionString").ConnectionString
        Dim con As New SqlConnection(Rad_constr)
        Dim sp As String = "Insert_OT_Patient_Services"
        Dim cmd As New SqlCommand(sp, con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@RegNo", Request.QueryString("regno"))
        cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString("payid"))

        cmd.Parameters.AddWithValue("@empid", emp_ID)
        cmd.Parameters.AddWithValue("@S_ID", S_Id)
        cmd.Parameters.AddWithValue("@Amount", S_Amount)
        cmd.Parameters.AddWithValue("@SubDept_ID", subdeptID)

        cmd.Parameters.AddWithValue("@Dept_ID", DeptID)
        cmd.Parameters.AddWithValue("@Order_ID", Order_ID)
        cmd.Parameters.AddWithValue("@TB_ID", TB_ID)
        con.Open()
        cmd.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub
    Sub for_OT()
        'Try


        '    Dim connection As New SqlConnection
        '    Dim command As New SqlCommand
        '    Dim reader As SqlDataReader
        '    connection.ConnectionString = con_OT
        '    command = connection.CreateCommand
        '    command.CommandText = "SELECT     ISNULL(Test_Booking.TB_ID, '') AS Expr1, Patient_Services.S_ID, Test_Booking.MG_ID, TestGroup.Dept_Id, TestGroup.SubDept_Id AS Sub_Dept_ID, Patient_Services.ID FROM Test_Booking INNER JOIN      Patient_Services ON Test_Booking.S_Id = Patient_Services.S_ID INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID INNER JOIN TestGroup ON Test_Booking.MG_ID = TestGroup.TGID inner join Treatment.dbo.OT_Order_Sub OS on OS.Patient_services_billing_id =Patient_Services.ID and Test_Booking.TB_ID = OS.TB_ID WHERE  (Patient_Services.YearlyNo =" + Session("YearlyNo") + ")  and (Patient_Services.Order_Id IS NULL) AND (Patient_Services.Payment_Status = 0) ORDER BY TestGroup.Dept_Id"
        '    connection.Open()
        '    reader = command.ExecuteReader
        '    While reader.Read

        '        HiddenField_TB_ID.Value = reader.Item(0)
        '        HiddenField_S_ID.Value = reader.Item(1)
        '        HiddenField_Mg_ID.Value = reader.Item(2)
        '        Try
        '            HiddenField_To_Dept_ID.Value = reader.Item(3)
        '            HiddenField_To_Sub_Dept_ID.Value = reader.Item(4)
        '            HF_PS_ID.Value = reader.Item(5)
        '        Catch ex As Exception

        '        End Try


        '        SqlDataSource_test_Booking_OT.Insert()

        '    End While
        '    reader.Close()

        '    connection.Close()
        '    SqlDataSource_OT_test_booking.Update()
        'Catch ex As Exception
        '    ' Response.Write(ex.Message)
        'End Try

    End Sub

    Private Sub Insert_bill(ByVal services As String, ByVal advances As String)
        Try


            'usp_Patient_services_payment
            'CStr(, CInt(Session("YearlyNo"))
            Dim con As New SqlConnection(constring)
            Dim sp As String = "usp_Patient_services_payment"
            Dim cmd As New SqlCommand(sp, con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@services", services)
            cmd.Parameters.AddWithValue("@advances", advances)
            cmd.Parameters.AddWithValue("@Bill_Type", HiddenFieldPaymentTpye.Value)
            cmd.Parameters.AddWithValue("@YearlyNo", Request.QueryString("Payid"))
            cmd.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
            cmd.Parameters.AddWithValue("@Emp_ID", CInt(Session("emp_id")))
            cmd.Parameters.AddWithValue("@Discount_Amount", If(Label_Discount.Text = "", "0", Label_Discount.Text.Trim().Replace(",", "")))
            cmd.Parameters.AddWithValue("@SubDept_ID", HiddenFieldSubDepartment.Value)
            cmd.Parameters.AddWithValue("@Dept_ID", HiddenField_Dept_ID.Value)
            cmd.Parameters.AddWithValue("@Cost_Centre", 0)
            cmd.Parameters.AddWithValue("@Card_amount", If(TextBox_Credit_Card.Text = "", "0", TextBox_Credit_Card.Text))
            cmd.Parameters.AddWithValue("@Cheque_amount", If(TextBox_Cheque.Text = "", "0", TextBox_Cheque.Text))
            cmd.Parameters.AddWithValue("@Cheque_Card_No", TextBox_Credit_Card_No.Text.Trim())
            cmd.Parameters.AddWithValue("@Card_Type", DropDownList_Card_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@Bank_Name", TextBox_Bank_Name.Text.Trim())
            cmd.Parameters.AddWithValue("@Approval_No", TextBox_approval_no.Text.Trim())
            cmd.Parameters.AddWithValue("@Card_Service", DropDownList_Card_Service.SelectedValue)
            cmd.Parameters.AddWithValue("@advance_Amount", If(Label_Ad_Payment.Text.Trim() = "", "0", Label_Ad_Payment.Text.Trim().Replace(",", "")))
            cmd.Parameters.AddWithValue("@Company_ID", If(DropDownList_Company.SelectedValue = "", "0", DropDownList_Company.SelectedValue))
            cmd.Parameters.AddWithValue("@Refund_amount", If(Label_Refund.Text.Trim() = "", "0", Label_Refund.Text.Trim().Replace(",", "")))
            cmd.Parameters.AddWithValue("@Cheque_No", TextBox_Cheque_No.Text.Trim())
            cmd.Parameters.AddWithValue("@Cheque_Branch", TextBox_Cheque_Branch.Text.Trim())
            cmd.Parameters.AddWithValue("@check_Date", WebDateChooser_Cheque_Date.Text.ToString())
            cmd.Parameters.AddWithValue("@IsRefund", rdoRefund.SelectedValue)

            cmd.Parameters.AddWithValue("@ReceivableAmount", txtboxAmount.Text)
            cmd.Parameters.AddWithValue("@Receivable", chkboxAmount.Checked)


            cmd.Parameters.AddWithValue("@Cash_amount", Label_Cash.Text.Replace(",", "").Trim())
            cmd.Parameters.AddWithValue("@PartyId", ddlReceivableParties.SelectedValue)


            cmd.Parameters.Add("@SPM_ID", SqlDbType.Int)
            cmd.Parameters("@SPM_ID").Direction = ParameterDirection.Output
            cmd.Parameters.Add("@Refund_ID", SqlDbType.Int)
            cmd.Parameters("@Refund_ID").Direction = ParameterDirection.Output
            con.Open()
            cmd.ExecuteNonQuery()
            Try
                If cmd.Parameters("@SPM_ID").Value Is DBNull.Value Then
                    HiddenFieldreturnID.Value = cmd.Parameters("@Refund_ID").Value
                Else
                    HiddenField_smpID.Value = cmd.Parameters("@SPM_ID").Value
                    If Not cmd.Parameters("@Refund_ID").Value Is DBNull.Value Then
                        HiddenFieldreturnID.Value = cmd.Parameters("@Refund_ID").Value
                    End If
                End If
            Catch ex As Exception

            End Try


            con.Close()
            con.Dispose()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Private Sub Forward_Services(ByVal services As String)
        Dim con As New SqlConnection(constring)
        Try

            Dim sp As String = "usp_Forward_Services1"
            Dim cmd As New SqlCommand(sp, con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@services", services)
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
            con.Dispose()


        Catch ex As Exception
            con.Close()
            con.Dispose()

        End Try

    End Sub

    Protected Sub chkboxAmount_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles chkboxAmount.CheckedChanged
        Dim check As CheckBox = New CheckBox()
        Dim checkAdvancePayment As CheckBox = New CheckBox()
        If chkboxAmount.Checked Then


            If Label_Cash.Text.Replace(",", "").Trim() = "" Then
                Label_Cash.Text = "0"
            End If


            txtboxAmount.Text = CInt(Label_Cash.Text.Replace(",", "").Trim()) + CInt(Label_Refund.Text.Trim().Replace(",", ""))
            hfAmount.Value = Label_Cash.Text.Replace(",", "").Trim()
            trReceivalbe.Visible = True
            txtboxAmount.Visible = True

            If GridView_For_Services.Rows.Count > 0 Then
                Dim CHK As CheckBox = GridView_For_Services.HeaderRow.FindControl("CheckBox_Header")
                CHK.Enabled = False

                For Each gv As GridViewRow In GridView_For_Services.Rows
                    check = gv.FindControl("CheckBox1")
                    check.Enabled = False
                Next
            End If

            For Each gv As GridViewRow In gvd_advance.Rows
                checkAdvancePayment = gv.FindControl("CheckBox_checked")
                checkAdvancePayment.Enabled = False
            Next

            CKFinal.Enabled = False
            If txtboxAmount.Text.Trim() <> "" Then
                If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                    Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                    hfAmount.Value = Label_Cash.Text
                Else

                End If
            End If

        Else
            trReceivalbe.Visible = False
            If GridView_For_Services.Rows.Count > 0 Then
                Dim CHK As CheckBox = GridView_For_Services.HeaderRow.FindControl("CheckBox_Header")
                CHK.Enabled = True

                For Each gv As GridViewRow In GridView_For_Services.Rows
                    check = gv.FindControl("CheckBox1")
                    check.Enabled = True
                Next
            End If


            For Each gv As GridViewRow In gvd_advance.Rows
                checkAdvancePayment = gv.FindControl("CheckBox_checked")
                checkAdvancePayment.Enabled = True
            Next
            txtboxAmount.Visible = False
            CKFinal.Enabled = True

            Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
            hfAmount.Value = Label_Cash.Text
            txtboxAmount.Text = "0"
        End If

    End Sub

    Protected Sub txtboxAmount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtboxAmount.TextChanged

        Dim amount As Integer = 0
        If txtboxAmount.Text.Trim() <> "" Then
            If checksForAmount(TextBox_Credit_Card.Text, TextBox_Cheque.Text, txtboxAmount.Text, chkboxAmount.Checked) Then
                Label_Cash.Text = co.place_Coma(CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) - CInt(co.Remove_Coma(txtboxAmount.Text)) - CInt(co.Remove_Coma(TextBox_Credit_Card.Text)) - CInt(co.Remove_Coma(TextBox_Cheque.Text)))
                hfAmount.Value = Label_Cash.Text
            Else
                ScriptManager.RegisterClientScriptBlock(Me, [GetType](), "function", "Addlabel();", True)
            End If
        End If
    End Sub



    Function checksForAmount(ByVal creditAmount As String, ByVal debitAmout As String, ByVal Receiveable As String, ByVal isCheck As Boolean) As Boolean

        Dim _status As Boolean = True

        If creditAmount = "" Then
            creditAmount = "0"
        End If

        If debitAmout = "" Then
            debitAmout = "0"
        End If

        If Receiveable = "" Then
            Receiveable = "0"
        End If

        Dim _Cash As Integer = CInt(co.Remove_Coma(Label_Remaining_Balance.Text))
        Dim _creditCard As Integer = CInt(co.Remove_Coma(creditAmount))
        Dim _debitCard As Integer = CInt(co.Remove_Coma(debitAmout))
        Dim _receiveAble As Integer = CInt(co.Remove_Coma(Receiveable))

        Dim _CDTotal As Integer = _creditCard + _debitCard
        Dim _AllTotal As Integer = _creditCard + _debitCard + _receiveAble

        If isCheck = True Then
            If _AllTotal > CInt(co.Remove_Coma(Label_Remaining_Balance.Text)) Then
                Label_Cash.Text = Label_Remaining_Balance.Text.Trim().Replace(",", "")
                TextBox_Cheque.Text = "0"
                TextBox_Credit_Card.Text = "0"
                txtboxAmount.Text = "0"
                chkboxAmount.Checked = False
                _status = False
                txtboxAmount.Visible = False

            Else
                _status = True
            End If
        Else

            If _CDTotal > _Cash Then
                _status = False
                Label_Cash.Text = Label_Remaining_Balance.Text.Trim().Replace(",", "")
                TextBox_Cheque.Text = "0"
                TextBox_Credit_Card.Text = "0"
                txtboxAmount.Visible = False
                txtboxAmount.Text = "0"
                chkboxAmount.Checked = False
            End If
        End If


        Return _status


    End Function
    Protected Sub btnRefresh_Click(sender As Object, e As EventArgs)

        Page.Response.Redirect(Page.Request.Url.ToString(), True)

    End Sub

End Class
