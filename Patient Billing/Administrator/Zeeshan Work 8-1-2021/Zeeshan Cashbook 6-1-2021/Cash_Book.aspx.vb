Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Configuration




Partial Class Patient_Billing_Cash_Book
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim commas As New Coma
    Dim total_amount As Integer = 0
    Dim Advance_amount As Integer = 0
    Dim Bill_amount As Integer = 0
    Dim Refund_amount As Integer = 0
    Dim Total_Amount_Cardiac As Integer = 0
    Dim co As New Coma
    Dim conString As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Page_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            DDL_Employee.DataBind()
            CheckEmployee(DDL_Employee, ID)
            GetCashBookRights()
            WebDateChooser1.Value = Date.Now()
            'WebDateChooser1.MinDate = Date.Now.Date.AddDays(-1)

            HiddenFieldWebChooser.Value = WebDateChooser1.Value
            Load_Grid_counter_close()
            GetCounterType()


        End If


    End Sub

    Protected Sub lnkDetail_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        Dim main_id As String = lnk.CommandArgument
        Dim Path As String = String.Empty
        Dim row As GridViewRow = lnk.NamingContainer
        Dim type As HiddenField = row.FindControl("HiddenFieldType")
        Dim YearlyNo As HiddenField = row.FindControl("HiddenFieldYearlyNo")
        Dim RegNo As HiddenField = row.FindControl("HiddenFieldRegNo")
        Dim SMP_ID As HiddenField = row.FindControl("HiddenFieldSPM_ID")

        Dim Cash_id As HiddenField = row.FindControl("HiddenFieldCashBook_Id")

        Session("YearlyNo") = YearlyNo.Value
        Session("RegistrationNo") = RegNo.Value
        Response.Redirect("~/Patient Billing/PatientAdvancesReport.aspx?SPMID=" + SMP_ID.Value + "&CBID=" + Cash_id.Value)


    End Sub
    Protected Sub DDL_Employee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDL_Employee.SelectedIndexChanged
        Load_Grid_counter_close()
    End Sub

    Sub CheckEmployee(ByVal DDL_Employee As DropDownList, ByVal id As String)
        For Each Item As ListItem In DDL_Employee.Items

            If Item.Value = Session("emp_id") Then

                lblEmployee.Visible = False

            End If

        Next

    End Sub

    Sub GetCashBookRights()
        Dim obj As DbManager = New DbManager
        Dim dt As DataTable
        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpID", Session("emp_id"))
         }

        dt = obj.ExecuteDataTable("GetCashBookRights", "Basic_Data_ConnectionString", sqlParams)
        If dt.Rows.Count > 0 Then
            DDL_Employee.Enabled = True

        Else
            DDL_Employee.SelectedValue = Session("emp_id")
            DDL_Employee.Enabled = False
        End If

        If (lblEmployee.Visible = True) Then

            DDL_Employee.Visible = False
            btn_Export.Visible = False
            Lblselctemp.Visible = False
            GridView_Counter_Close.Visible = False
            lblEmployee.Text = "<b>User Is Not Authorized To View This Page!</b>"
            lblEmployee.ForeColor = System.Drawing.Color.Red
            grdvisiblefalse.Visible = False

        Else
            lblEmployee.Visible = False
        End If

    End Sub

    Protected Sub getSubdept(ByVal emp_id As Integer, ByRef dept_id As Integer, ByRef subdept_id As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "select SubDeptId,DeptId from Employee where empid =" + emp_id.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()
        Dim read As SqlDataReader = mycommand.ExecuteReader()

        While read.Read()
            dept_id = read("DeptId").ToString()
            subdept_id = read("SubDeptId").ToString()

        End While

        con.Close()

    End Sub
    Protected Sub GridView_Counter_Close_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Counter_Close.PreRender

        If GridView_Counter_Close.Rows.Count > 0 Then
            Dim hf_reg As New HiddenField
            Dim Refund_ID As New HiddenField
            Dim Advance_ID As New HiddenField
            Dim lbl_Mr As New LinkButton
            Dim Name As New Label
            Dim TAmount As New Label
            Dim reciept As New Label
            Dim payment_type As New Label
            Dim BalanceAmount As New Label
            Dim panelAmount As New Label
            Dim creditAmount As New Label
            Dim reciveableAmount As New Label
            Dim bankAmount As New Label
            Dim amount As Decimal = 0.0, panel As Decimal = 0.0, credit As Decimal = 0.0, receivable As Decimal = 0.0, bank As Decimal = 0.0
            Dim chkbox As CheckBox

            For Each row As GridViewRow In GridView_Counter_Close.Rows

                hf_reg = row.FindControl("HiddenFieldRegNo")
                BalanceAmount = row.FindControl("LabelBAmount")
                TAmount = row.FindControl("lbl_amount")
                payment_type = row.FindControl("lbl_payment_type")
                reciept = row.FindControl("lbl_reciept")
                Advance_ID = row.FindControl("HiddenFieldAdv_pay_id")
                Refund_ID = row.FindControl("HiddenFieldreturn_id")
                panelAmount = row.FindControl("lblPanel")
                creditAmount = row.FindControl("lblCreditAmount")
                reciveableAmount = row.FindControl("lblReceivableAmount")
                bankAmount = row.FindControl("lblBankAmount")
                chkbox = row.FindControl("chkbox")
                chkbox.Checked = True
                If String.IsNullOrEmpty(TAmount.Text.Trim()) Or TAmount.Text.Trim = "&nbsp;" Then
                    amount = 0
                Else
                    amount = co.Remove_Coma(TAmount.Text.Trim().Replace("(", "").Replace(")", ""))
                End If

                If payment_type.Text.Trim() = "Bill" Then
                    total_amount += CInt(amount)
                    Bill_amount += CInt(amount)
                End If
                If payment_type.Text.Trim() = "Receiveable" Then
                    total_amount += CInt(amount)

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
                panel = panel + Convert.ToDecimal(panelAmount.Text)
                credit = credit + Convert.ToDecimal(creditAmount.Text)
                receivable = receivable + Convert.ToDecimal(reciveableAmount.Text)
                bank = bank + Convert.ToDecimal(bankAmount.Text)
            Next

            Dim Total As Label = GridView_Counter_Close.FooterRow.FindControl("Lbl_Total")
            Total.Text = "Total Balance :"
            'GridView_Counter_Close.FooterRow.Cells(9).HorizontalAlign = HorizontalAlign.Right

            Dim Total_balance As Label = GridView_Counter_Close.FooterRow.FindControl("Lbl_T_Balance") '
            Total_balance.Text = commas.place_Coma(CStr(total_amount))

            Dim gPanelTotal As Label = GridView_Counter_Close.FooterRow.FindControl("lblTPAMount") '
            gPanelTotal.Text = commas.place_Coma(CStr(panel))
            Dim gCreditTotal As Label = GridView_Counter_Close.FooterRow.FindControl("lblTCAMount") '
            gCreditTotal.Text = commas.place_Coma(CStr(credit))
            Dim gReceiveableTotal As Label = GridView_Counter_Close.FooterRow.FindControl("lblTRAMount") '
            gReceiveableTotal.Text = commas.place_Coma(CStr(receivable))
            Dim gBankTotal As Label = GridView_Counter_Close.FooterRow.FindControl("lblTBAMount") '
            gBankTotal.Text = commas.place_Coma(CStr(bank))

            lblTotalPanelAmount.Text = commas.place_Coma(panel)
            lblTotalCreditAmount.Text = commas.place_Coma(credit)
            lblTotalReceiveableAmount.Text = commas.place_Coma(receivable)
            lblTotalBankAmount.Text = commas.place_Coma(bank)

        End If


        HiddenFieldAmount.Value = commas.place_Coma(CInt(total_amount))
        LabelTotal.Text = commas.place_Coma(total_amount)
        LabelAdvance.Text = commas.place_Coma(Advance_amount)
        LabelBill.Text = commas.place_Coma(Bill_amount)
        LabelRefund.Text = commas.place_Coma(Refund_amount)


    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        'Try
        '    SqlDataSource_Discount_Adjustment.Insert()
        'Catch ex As Exception

        'End Try


        Try


            Dim cash_id As New HiddenField
            Dim check As New CheckBox
            Dim CashBookID As String = String.Empty
            HiddenFieldWebChooser.Value = WebDateChooser1.Value
            For Each row As GridViewRow In GridView_Counter_Close.Rows

                check = row.FindControl("chkbox")
                cash_id = row.FindControl("HiddenFieldCashBook_Id")

                If check.Checked = True Then

                    CashBookID = CashBookID + "," + cash_id.Value
                End If

            Next

            SqlDataSource_Counter_Close.InsertParameters("CashBook_ID").DefaultValue = CashBookID
            SqlDataSource_Counter_Close.Insert()
            'SqlDataSource_PatientValueAdjustment.Update()
            GridView_Counter_Close.DataBind()
            Button1.Visible = False
            DropDownListShift.Visible = True
            LabelShift.Visible = False
            ButtonReport.Visible = False
            Load_Grid_counter_close()
        Catch ex As Exception
            Response.Write(ex.Message + "here")
        End Try

    End Sub
    Protected Sub ButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonReport.Click
        '    'If WebDateChooser1.Text = "Null" Then
        Response.Write("<script language='javascript' type='text/javascript'>window.open('../Patient Billing/Cash_Book_report.aspx');</script>")
        '    'End If
        'ShowAllComplaints()

    End Sub
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
        Dim Cash_id As HiddenField = row.FindControl("HiddenFieldCashBook_Id")

        If type.Value = "Advance" Then
            'Path = "../Patient Billing/Indoor_Payment_receipt.aspx?Payment_No=" + main_id + "&PayID=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance"
            Response.Redirect("~/Patient Billing/PatientAdvancesReport.aspx?Payment_No=" + main_id + "&YearlyNo=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance")
        Else

            Dim Consumption_id As Integer = 0
            Consumption_id = check_for_medicine(Cash_id.Value)
            If Consumption_id <> 0 Then
                Response.Redirect("~/pharmacy/Consumed_Medicine_Report.aspx?C_ID=" + Consumption_id.ToString())
            End If


            Session("YearlyNo") = YearlyNo.Value
            Session("RegistrationNo") = RegNo.Value
            If SMP_ID.Value = "0" Then
                Response.Redirect("~/Patient Billing/Patientrefund_Details.aspx?CashBookId=" + Cash_id.Value.Trim() + "&YearlyNo=" + YearlyNo.Value + "&RegNo=" + RegNo.Value)

            End If
            Response.Redirect("~/Patient Billing/DuplicatepatientServices.aspx?SPMID=" + SMP_ID.Value)

        End If
    End Sub
    Protected Sub Load_Grid_counter_close()
        Dim emp_id As Integer = DDL_Employee.SelectedValue
        Dim Dept_id As Integer = 0, Subdept_id As Integer = 0
        getSubdept(emp_id, Dept_id, Subdept_id)
        Dim dbm As DbManager = New DbManager()
        Dim sp As SqlParameter() = {New SqlParameter("@Dept_Id", Dept_id), New SqlParameter("@SubDept_Id", Subdept_id), New SqlParameter("@emp_id", emp_id)}
        Dim ds As DataSet = dbm.ExecuteDataSet("uspGetServicesForCounterClose", "Basic_Data_ConnectionString", sp)

        GridView_Counter_Close.DataSource = ds.Tables(0)
        GridView_Counter_Close.DataBind()
        If GridView_Counter_Close.Rows.Count = 0 Then 'And GridView_Cardiac_Cash_Book.Rows.Count = 0 Then
            Button1.Visible = False
            LabelShift.Visible = False
            DropDownListShift.Visible = False
            ButtonReport.Visible = False
            LabelTotal.Visible = False
            LabelGtotal.Visible = False
            Label2.Visible = False
            WebDateChooser1.Visible = False
        Else
            Button1.Visible = True
            LabelShift.Visible = True
            DropDownListShift.Visible = True
            LabelTotal.Visible = True
            LabelGtotal.Visible = True
            Label2.Visible = True
            WebDateChooser1.Visible = True
        End If
    End Sub

    Protected Sub btn_Export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Cash Activity Report_" & DDL_Employee.SelectedItem.Text & "_" & Date.Now.ToString("yyyy/MM/dd") & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New IO.StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView_Counter_Close
        repAllCustomers.AllowPaging = False
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
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
    Protected Sub chkboxAll_CheckedChanged(sender As Object, e As EventArgs)
        Try
            Dim chkSelectAll As CheckBox = CType(GridView_Counter_Close.HeaderRow.FindControl("chkboxAll"), CheckBox)
            Dim i As Integer = 0
            Do While (i <= (GridView_Counter_Close.Rows.Count - 1))
                Dim chkSelect As CheckBox = CType(GridView_Counter_Close.Rows(i).FindControl("chkbox"), CheckBox)
                chkSelect.Checked = chkSelectAll.Checked
                i = (i + 1)
            Loop

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Private Sub GetCounterType()
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection()

        Try
            con = New SqlConnection(conString)
            con.Open()
            cmd = New SqlCommand("select distinct countertype from Receptionist where Receptionist.Receptionist_id=@EmpId  order by  countertype ", con)
            cmd.CommandType = CommandType.Text
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            cmd.Parameters.AddWithValue("@EmpId", Session("emp_id"))
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            DDL_CounterType.DataSource = dt
            DDL_CounterType.DataTextField = "countertype"
            DDL_CounterType.DataValueField = "countertype"
            DDL_CounterType.DataBind()
        Catch ex As Exception
        Finally
            con.Close()
        End Try
    End Sub
End Class
