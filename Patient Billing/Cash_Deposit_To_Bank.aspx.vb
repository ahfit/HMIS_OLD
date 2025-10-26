Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Partial Class Patient_Billing_Cash_Deposit_To_Bank
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim commas As New Coma
    Dim total_amount As Integer = 0
    Dim Advance_amount As Integer = 0
    Dim Bill_amount As Integer = 0
    Dim Refund_amount As Integer = 0
    Dim Total_Amount_Cardiac As Integer = 0
    Dim co As New Coma
    Protected Sub Page_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.ispostback() Then
            'Load_Grid()
            GridView_Counter_Close.DataBind()
         
          
        End If
        
    End Sub
    Protected Sub GridView_Counter_Close_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Counter_Close.PreRender

        If GridView_Counter_Close.Rows.Count > 0 Then
            Dim prefix As New HiddenField
            Dim PFname As New HiddenField
            Dim PMname As New HiddenField
            Dim PLname As New HiddenField
            Dim hf_reg As New HiddenField
            Dim Refund_ID As New HiddenField
            Dim Advance_ID As New HiddenField
            Dim lbl_Mr As New LinkButton
            Dim Name As New Label
            Dim TAmount As New Label
            Dim reciept As New Label
            Dim payment_type As New Label
            Dim BalanceAmount As New Label

            Dim amount As Decimal = 0.0


            For Each row As GridViewRow In GridView_Counter_Close.Rows
                prefix = row.FindControl("HiddenFieldPrefix")
                PFname = row.FindControl("HiddenFieldFName")
                PLname = row.FindControl("HiddenFieldLName")
                PMname = row.FindControl("HiddenFieldMName")
                Name = row.FindControl("lbl_name")
                lbl_Mr = row.FindControl("lnkbtnAdv")
                hf_reg = row.FindControl("HiddenFieldRegNo")
                BalanceAmount = row.FindControl("LabelBAmount")
                TAmount = row.FindControl("lbl_amount")
                payment_type = row.FindControl("lbl_payment_type")
                reciept = row.FindControl("lbl_reciept")
                Advance_ID = row.FindControl("HiddenFieldAdv_pay_id")
                Refund_ID = row.FindControl("HiddenFieldreturn_id")
                Name.Text = ""
                If Not String.IsNullOrEmpty(prefix.Value) Then
                    Name.Text = prefix.Value
                End If
                If Not String.IsNullOrEmpty(PFname.Value) Then
                    Name.Text = Name.Text.Trim() + " " + ENC.Encrypt_Main(PFname.Value, False)
                End If
                If Not String.IsNullOrEmpty(PMname.Value) Then
                    Name.Text = Name.Text.Trim() + " " + ENC.Encrypt_Main(PMname.Value, False)
                End If
                If Not String.IsNullOrEmpty(PLname.Value) Then
                    Name.Text = Name.Text.Trim() + " " + ENC.Encrypt_Main(PLname.Value, False)
                End If
                lbl_Mr.Text = ENC.Encrypt_Main(hf_reg.Value, False)

                If String.IsNullOrEmpty(TAmount.Text.Trim()) Or TAmount.Text.Trim = "&nbsp;" Then
                    amount = 0
                Else
                    amount = co.Remove_Coma(TAmount.Text.Trim().Replace("(", "").Replace(")", ""))
                End If

                If payment_type.Text.Trim() = "Bill" Or payment_type.Text.Trim() = "Receiveable" Then
                    total_amount += CInt(amount)
                    Bill_amount += CInt(amount)
                End If
                If payment_type.Text.Trim() = "Advance" Then
                    total_amount += CInt(amount)
                    Advance_amount += CInt(amount)
                End If
                If payment_type.Text.Trim() = "Refund" Or payment_type.Text.Trim() = "Advance Refund" Then
                    total_amount -= CInt(amount.ToString().Replace("(", "").Replace(",", "").Replace(")", ""))
                    Refund_amount += CInt(amount.ToString().Replace("(", "").Replace(",", "").Replace(")", ""))
                    BalanceAmount.Text = commas.place_Coma(CStr(total_amount))

                    TAmount.Text = "( " + commas.place_Coma(amount.ToString()) + " )"
                    row.BackColor = Drawing.Color.FromArgb(&H78FFE0E0)
                End If
                If payment_type.Text.Trim() = "RemainingAmount" Then
                    total_amount += CInt(amount)
                End If
                If payment_type.Text.Trim() <> "Refund" Then
                    TAmount.Text = commas.place_Coma(amount.ToString())
                End If
                BalanceAmount.Text = commas.place_Coma(CStr(total_amount))
                If String.IsNullOrEmpty(reciept.Text) Then
                    If payment_type.Text.Trim() = "Advance" Then
                        reciept.Text = "Adv-" + Right("00000" + Advance_ID.Value, 5)
                    ElseIf payment_type.Text.Trim() = "Refund" Then
                        reciept.Text = "Ref-" + Right("00000" + Refund_ID.Value, 5)
                    End If


                End If
            Next

            Dim Total As Label = GridView_Counter_Close.FooterRow.FindControl("Lbl_Total")
            Total.Text = "Total Balance :"
            'GridView_Counter_Close.FooterRow.Cells(9).HorizontalAlign = HorizontalAlign.Right

            Dim Total_balance As Label = GridView_Counter_Close.FooterRow.FindControl("Lbl_T_Balance") '
            Total_balance.text = commas.place_Coma(CStr(total_amount))



        End If


        HiddenFieldAmount.Value = commas.place_Coma(CInt(total_amount))
        LabelTotal.Text = commas.place_Coma(total_amount)
        LabelAdvance.Text = commas.place_Coma(Advance_amount)
        lblTotalCash.Text = commas.place_Coma(total_amount)
        LabelRefund.Text = commas.place_Coma(Refund_amount)

    End Sub
    'Protected Sub GridView_Counter_Close_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Counter_Close.PreRender
    '    'If Page.IsPostBack = False Then
    '    If GridView_Counter_Close.Rows.Count <> 0 Then
    '        GridView_Counter_Close.HeaderRow.Cells(4).Visible = False
    '        GridView_Counter_Close.HeaderRow.Cells(5).Visible = False
    '        GridView_Counter_Close.HeaderRow.Cells(12).Visible = False
    '        GridView_Counter_Close.HeaderRow.Cells(13).Visible = False
    '        GridView_Counter_Close.FooterRow.Cells(4).Visible = False
    '        GridView_Counter_Close.FooterRow.Cells(5).Visible = False
    '        GridView_Counter_Close.FooterRow.Cells(12).Visible = False
    '        GridView_Counter_Close.FooterRow.Cells(13).Visible = False
    '        GridView_Counter_Close.HeaderRow.Cells(3).Text = "Patient Name"
    '        For i As Integer = 0 To GridView_Counter_Close.Rows.Count - 1
    '            GridView_Counter_Close.Rows(i).Cells(3).Text = GridView_Counter_Close.Rows(i).Cells(3).Text + " " + ENC.Encrypt_Main(GridView_Counter_Close.Rows(i).Cells(4).Text, False) + " " + ENC.Encrypt_Main(GridView_Counter_Close.Rows(i).Cells(5).Text, False)
    '            GridView_Counter_Close.Rows(i).Cells(4).Visible = False
    '            GridView_Counter_Close.Rows(i).Cells(5).Visible = False
    '            GridView_Counter_Close.Rows(i).Cells(12).Visible = False
    '            GridView_Counter_Close.Rows(i).Cells(13).Visible = False

    '            Dim mrno As LinkButton = GridView_Counter_Close.Rows(i).FindControl("lnkbtnAdv")
    '            mrno.Text = ENC.Encrypt_Main(mrno.Text, False)
    '            'GridView_Counter_Close.Rows(i).Cells(0).Text = ENC.Encrypt_Main(GridView_Counter_Close.Rows(i).Cells(0).Text, False)
    '            Dim label_amount As Label = GridView_Counter_Close.Rows(i).FindControl("LabelAmount")

    '            If GridView_Counter_Close.Rows(i).Cells(8).Text = "Bill" Then
    '                If Not String.IsNullOrEmpty(GridView_Counter_Close.Rows(i).Cells(9).Text) Then
    '                    If GridView_Counter_Close.Rows(i).Cells(9).Text.Trim = "&nbsp;;" Then
    '                        total_amount += 0
    '                        Bill_amount += 0
    '                    Else
    '                        total_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text.Trim)
    '                        Bill_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text.Trim)

    '                    End If
    '                  End If
    '            End If
    '            If GridView_Counter_Close.Rows(i).Cells(8).Text = "Advance" Then
    '                total_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '                Advance_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '            End If
    '            If GridView_Counter_Close.Rows(i).Cells(8).Text = "Refund" Then
    '                total_amount -= CInt(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '                Refund_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '                label_amount.Text = commas.place_Coma(CStr(total_amount))
    '                GridView_Counter_Close.Rows(i).Cells(9).Text = commas.place_Coma(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '                GridView_Counter_Close.Rows(i).Cells(9).Text = "( " + GridView_Counter_Close.Rows(i).Cells(9).Text + " )"
    '                GridView_Counter_Close.Rows(i).BackColor = Drawing.Color.FromArgb(&H78FFE0E0)
    '            End If
    '            If GridView_Counter_Close.Rows(i).Cells(8).Text = "RemainingAmount" Then
    '                total_amount += CInt(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '            End If
    '            If GridView_Counter_Close.Rows(i).Cells(8).Text <> "Refund" Then
    '                GridView_Counter_Close.Rows(i).Cells(9).Text = commas.place_Coma(GridView_Counter_Close.Rows(i).Cells(9).Text)
    '            End If
    '            label_amount.Text = commas.place_Coma(CStr(total_amount))
    '        Next
    '        GridView_Counter_Close.FooterRow.Cells(9).Text = "Total Balance :"
    '        GridView_Counter_Close.FooterRow.Cells(9).HorizontalAlign = HorizontalAlign.Right

    '        GridView_Counter_Close.FooterRow.Cells(10).Text = commas.place_Coma(CStr(total_amount))
    '        GridView_Counter_Close.FooterRow.Cells(10).HorizontalAlign = HorizontalAlign.Right




    '        'End If
    '        HiddenFieldAmount.Value = commas.place_Coma(CInt(total_amount))

    '        btn_export.Visible = True
    '    Else
    '        btn_export.Visible = False

    '    End If
    '    LabelTotal.Text = commas.place_Coma(total_amount)
    '    LabelAdvance.Text = commas.place_Coma(Advance_amount)
    '    LabelBill.Text = commas.place_Coma(Bill_amount)
    '    LabelRefund.Text = commas.place_Coma(Refund_amount)

    'End Sub

   

    

    Protected Sub lnkbtnAdv_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnk As LinkButton = sender
        Dim main_id As String = lnk.CommandArgument
        Dim Path As String = String.Empty
        Dim row As GridViewRow = lnk.NamingContainer
        Dim type As HiddenField = row.FindControl("HiddenFieldType")
        Dim YearlyNo As HiddenField = row.FindControl("HiddenFieldYearlyNo")
        Dim RegNo As HiddenField = row.FindControl("HiddenFieldRegNo")
        Dim SMP_ID As HiddenField = row.FindControl("HiddenFieldSPM_ID")
        Dim Refund_ID As HiddenField = row.FindControl("HiddenFieldreturn_id")
        Dim MedicineReturn As HiddenField = row.FindControl("HiddenFieldPaymentCategory")
        Dim Cash_id As HiddenField = row.FindControl("HiddenFieldCashBook_Id")
        If type.Value = "Advance" Then
            'Path = "../Patient Billing/Indoor_Payment_receipt.aspx?Payment_No=" + main_id + "&PayID=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance"
            Response.Redirect("~/Patient Billing/PatientAdvancesReport.aspx?Payment_No=" + main_id + "&YearlyNo=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance")
        Else
            If MedicineReturn.Value = "Medicine Return" Then
                Dim ConsumptionReturnID As Integer = 0
                Dim Consumption_idf As Integer = 0
                ConsumptionReturnID = check_for_medicineReturn(main_id.ToString())
                Dim returnId As Integer = check_for_medicineSaleReturnID(main_id)
                Response.Redirect("~/Pharmacy/PatientSaleReturnReport.aspx?C_ID=" + ConsumptionReturnID.ToString() + "&Rtn_ID=" + returnId.ToString())
                Return
            End If
            Dim Consumption_id As Integer = 0
            Consumption_id = check_for_medicine(Cash_id.Value)
            If Consumption_id <> 0 Then
                Response.Redirect("~/pharmacy/Consumed_Medicine_Report.aspx?C_ID=" + Consumption_id.ToString())
            End If
            'Session.Abandon("YearlyNo")
            'Session.Abandon("RegistrationNo")

            Session("YearlyNo") = YearlyNo.Value
            Session("RegistrationNo") = RegNo.Value

            If SMP_ID.Value = "0" Then
                Response.Redirect("~/Patient Billing/Patientrefund_Details.aspx?CashBookId=" + Cash_id.Value.Trim() + "&YearlyNo=" + YearlyNo.Value + "&RegNo=" + RegNo.Value)

            End If
            Response.Redirect("~/Patient Billing/DuplicatepatientServices.aspx?SPMID=" + SMP_ID.Value)

        End If
        'Session("YearlyNo") = YearlyNo.Value
        'Session("RegistrationNo") = RegNo.Value
        'If String.IsNullOrEmpty(SMP_ID.Value) Then
        '    Response.Redirect("~/Patient Billing/Patientrefund_Details.aspx?Refund_id=" + Refund_ID.Value.Trim() + "&YearlyNo=" + YearlyNo.Value + "&RegNo=" + RegNo.Value)

        'End If
        ''Path = "../Patient Billing/patientServices.aspx?SPMID=" + SMP_ID.Value
        'Response.Redirect("~/Patient Billing/DuplicatepatientServices.aspx?SPMID=" + SMP_ID.Value)

        ' End If

        'Dim sb As StringBuilder = New StringBuilder
        'sb.Append("<script language='javascript'>  window.open('" + Path + "')</script>")
        'Dim t As Type = Me.GetType
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        'End If
    End Sub

    Protected Sub Load_Grid()
        'Dim D
        'Dim da1 As New CashBookTableAdapters.Room_AssignedTableAdapter
        'Dim Ds As DataView = SqlDataSourceForGrid.Select(DataSourceSelectArguments.Empty)

        'da1.Fill(Ds.Tables("Room_Assigned"))
        'For k As Integer = 0 To Ds.Tables("0").Rows.Count - 1

        '    Ds.Tables("0").Rows(k).Item("Room") = "OPD"
        'Next
        'For i As Integer = 0 To Ds.Tables("Room_Assigned").Rows.Count - 1
        '    For j As Integer = 0 To Ds.Tables("0").Rows.Count - 1

        '        If Ds.Tables("Room_Assigned").Rows(i).Item("Yearly_No") = Ds.Tables("0").Rows(j).Item("YearlyNo") Then
        '            Ds.Tables("0").Rows(j).Item("Room") = Ds.Tables("Room_Assigned").Rows(i).Item("Room")

        '        End If
        '    Next
        'Next
        'GridView_Counter_Close.DataSource = Ds
        'GridView_Counter_Close.DataBind()

    End Sub

    Private Sub ShowAllComplaints()
        Dim fileName As String = "Counter_Close_Detail.xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView_Counter_Close
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'base.VerifyRenderingInServerForm(control);
    End Sub

    Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub

    Protected Function check_for_medicine(ByVal cash_id As Integer) As Integer
        Dim consuption_id As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "SELECT ISNULL(Consumption_Id,0) FROM STORE.DBO.StoreItem_Consumption_Main WHERE Cashbook_ID =" + cash_id.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()
        consuption_id = mycommand.ExecuteScalar()

        con.Close()


        Return consuption_id
    End Function
    Protected Function check_for_medicineReturn(ByVal MainID As Integer) As Integer
        Dim consuption_id As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "SELECT ISNULL(ConsumptionId,0),* FROM BasicDataInfo.dbo.Patient_Refund_Amount WHERE Refund_ID =" + MainID.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()
        consuption_id = mycommand.ExecuteScalar()

        con.Close()


        Return consuption_id
    End Function
    Protected Function check_for_medicineSaleReturnID(ByVal MainID As Integer) As Integer
        Dim consuption_id As Integer = 0
        Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "SELECT ISNULL(Sale_Return_Id,0),* FROM BasicDataInfo.dbo.Patient_Refund_Amount WHERE Refund_ID =" + MainID.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()
        consuption_id = mycommand.ExecuteScalar()

        con.Close()


        Return consuption_id
    End Function
End Class
