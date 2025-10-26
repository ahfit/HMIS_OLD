Imports System.Data
Imports System.Data.SqlClient

Partial Class Finance_DoctorSharePayment

    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim _SqlAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim _SqlCon As SqlConnection
    Dim _SqlCommand As SqlCommand = New SqlCommand()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ' GetConsultants() 
            load_head()

            hdnPaymentType.Value = Request.QueryString("PaymentType")
            GetDoctorShare(hdnPaymentType.Value)
        Else

            txtRTax.Text = hdnTaxAmount.Value
            txtNetAmount.Text = hdnPayableAmount.Value
            lblTotalAmount.Text = hdnTotalPayment.Value
        End If

    End Sub
    Sub GetDoctorShare(ByVal paymentType As String)
        
        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@DoctorId", Request.QueryString("DoctorId")),
        New SqlParameter("@PaymentType", paymentType),
        New SqlParameter("@S_Date", Request.QueryString("DateFrom")),
            New SqlParameter("@E_Date", Request.QueryString("DateTo"))
         }

        grdDoctorShare.DataSource = ExecuteDataTable("GetDoctorShare", "Finance_ConnectionString", sqlParams)
        grdDoctorShare.DataBind()
       
    End Sub
    Protected Sub grdDoctorShare_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles grdDoctorShare.RowDataBound

        If e.Row.RowType = ListItemType.Header Then
            If Request.QueryString("PaymentType") = "Cash" Then
                e.Row.Cells(5).Visible = False
                e.Row.Cells(7).Visible = False
            Else
                ' e.Row.Cells(4).Visible = False
            End If

        End If


        If e.Row.RowType = ListItemType.Item Then

            Dim lblPatName As Label = e.Row.FindControl("lblPatientName")
            Dim lblRalName As Label = e.Row.FindControl("lblRelationName")


            Dim row As LinkButton = e.Row.FindControl("linkbtnPrint")

            Dim dr As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
            lblPatName.Text = dr("PFName") + " " + dr("PMName") + " " + dr("PLName")



            If Request.QueryString("PaymentType") = "Cash" Then
                e.Row.Cells(5).Visible = False
                e.Row.Cells(7).Visible = False

            Else
                'e.Row.Cells(4).Visible = False
            End If

            Dim lblSrNo As Label = e.Row.FindControl("lblSrNo")
            lblSrNo.Text = e.Row.RowIndex + 1
        End If







    End Sub

    Protected Sub btnSavePayment_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSavePayment.Click
        Try
            WebDateChooser_ChequeDate.Value = DateTime.Now
            txtNetAmount.Text = hdnTotalPayment.Value
            Dim paymentType = Request.QueryString("PaymentType")
            If paymentType = "Bank" Then
                lbl_amount.Text = hdnTotalPayment.Value
                pnl_Deposit.Visible = True
            Else
                Dim Id As String = AddDoctorMainPayment(Request.QueryString("DoctorId"), hdnTotalPayment.Value)



                For i As Integer = 0 To grdDoctorShare.Rows.Count - 1
                    Dim chkSelected As CheckBox = grdDoctorShare.Rows(i).FindControl("chkSelected")

                    If chkSelected.Checked Then
                        Dim sId As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnSid")
                        Dim yearlyNo As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnYearlyNo")
                        Dim regNo As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnRegNo")
                        Dim lblCashAmount As Label = grdDoctorShare.Rows(i).FindControl("lblCashAmount")
                        If lblCashAmount.Text <> "0" Then
                            If paymentType = "Cash" Then
                                UpdateDoctorShare(Id, yearlyNo.Value, Request.QueryString("DoctorId"), sId.Value, "DPM_ID")
                            End If
                        End If
                    End If
                Next

                Response.Redirect("~/Finance/DoctorShareSummary.aspx")


            End If

        Catch ex As Exception

        End Try
    End Sub

    Function AddDoctorMainPayment(ByVal doctId As String, ByVal amount As String) As String


        Dim conn As New SqlConnection
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString

        Dim cmd As New SqlCommand("AddDoctorMainPayment", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@DoctorId", doctId)
        cmd.Parameters.AddWithValue("@EmpBy", Session("emp_id"))
        cmd.Parameters.AddWithValue("@TotalAmount", amount)
        cmd.Parameters.AddWithValue("@DPMID", 0)
        cmd.Parameters("@DPMID").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return cmd.Parameters("@DPMID").Value
    End Function
    Sub UpdateDoctorShare(ByVal Id As String, ByVal yearlyNo As String, ByVal doctId As String, ByVal sId As String, ByVal columnName As String)
        'Dim objDbManager As DbManager = New DbManager()

        'Dim db As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Id", Id),
            New SqlParameter("@YearlyNo", yearlyNo),
            New SqlParameter("@DoctorId", doctId),
            New SqlParameter("@SId", sId),
            New SqlParameter("@ColumnName", columnName)
         }

        ExecuteNonQuery("UpdateDoctorShare_PMID", "Finance_ConnectionString", sqlParams)

    End Sub



    Protected Sub linkbtnPrint_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim linkButton As LinkButton = New LinkButton()
        linkButton = CType(sender, LinkButton)

        Dim doctorid As String = linkButton.CommandArgument

        Response.Redirect("./DocotrShareReportPage.aspx?doctorid=" + doctorid + "")
    End Sub

    Protected Sub grdDoctorShare_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles grdDoctorShare.PreRender


        For Each item As GridViewRow In grdDoctorShare.Rows
            If Request.QueryString("PaymentType") = "Cash" Then
                Dim btn As LinkButton = item.FindControl("linkbtnPrint")

                btn.Visible = False
                btn.Parent.Visible = False

            Else
                btn.Visible = True
            End If
        Next
    End Sub
    Public Sub Openconn(ByVal connStr As String)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings(connStr).ConnectionString
            _SqlCon = New SqlConnection(constr)
            _SqlCon.Open()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function ExecuteDataTable(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter()) As DataTable
        Dim _dataTable As DataTable = New DataTable()
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next


            _SqlAdapter.SelectCommand = _SqlCommand
            _SqlAdapter.Fill(_dataTable)

            _SqlCon.Close()
            _SqlCommand.Dispose()

        Catch ex As Exception
            Throw ex
        End Try

        Return _dataTable
    End Function
    Public Sub ExecuteNonQuery(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter())
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next

            _SqlCommand.ExecuteNonQuery()

            _SqlCon.Close()
            _SqlCommand.Dispose()



        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function ExecuteDataTable(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter(), ByVal Ptype As String) As DataTable
        Dim _dataTable As DataTable = New DataTable()
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            If Ptype = "Text" Then
                _SqlCommand.CommandType = CommandType.Text
            Else
                _SqlCommand.CommandType = CommandType.StoredProcedure
            End If
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next


            _SqlAdapter.SelectCommand = _SqlCommand
            _SqlAdapter.Fill(_dataTable)

            _SqlCon.Close()
            _SqlCommand.Dispose()

        Catch ex As Exception
            Throw ex
        End Try

        Return _dataTable
    End Function
    Protected Sub ck_all_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ck_all As CheckBox = sender
        Dim ck As New CheckBox
        Dim total As Integer = 0
        Dim lbl_amount As New Label
        For Each row As GridViewRow In grdDoctorShare.Rows
            ck = row.FindControl("chkSelected")
            ck.Checked = ck_all.Checked
            If ck.Checked Then
                lbl_amount = row.FindControl("lblBankAmount")
                total = total + CInt(lbl_amount.Text)
            End If

        Next
        hdnTotalPayment.Value = total
        lblTotalAmount.Text = total

        'ScriptManager.RegisterStartupScript(Me, Page.GetType, "Script", "setPayment();", True)
    End Sub


    Protected Sub ddl_mode_of_payment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_mode_of_payment.SelectedIndexChanged
        load_head()
        If ddl_mode_of_payment.SelectedItem.Text = "Cash" Then
            txtChequeNo.Enabled = False
            WebDateChooser_ChequeDate.Enabled = False
        ElseIf ddl_mode_of_payment.SelectedItem.Text = "Bank" Then

            txtChequeNo.Enabled = True
            WebDateChooser_ChequeDate.Enabled = True
        Else
            'lbl_payment.Text = "Cheque # :"
        End If
    End Sub

    Protected Sub load_head()
        Dim Statment As String = "SELECT Expenditure.E_Code, Expenditure.E_Name FROM Head_Master_Table INNER JOIN Expenditure ON Head_Master_Table.E_Code = Expenditure.E_Code WHERE (Head_Master_Table.Head_Type=@Head_Type)"
        Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Head_Type", ddl_mode_of_payment.SelectedValue)
             }
        ddl_head.DataSource = ExecuteDataTable(Statment, "Finance_ConnectionString", sqlParams, "Text")
        ddl_head.DataBind()
    End Sub

    Protected Sub Btn_Post_voucher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Post_voucher.Click


        Try

            Dim Id As String = PostVoucher()



            For i As Integer = 0 To grdDoctorShare.Rows.Count - 1
                Dim chkSelected As CheckBox = grdDoctorShare.Rows(i).FindControl("chkSelected")

                If chkSelected.Checked Then
                    Dim sId As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnSid")
                    Dim yearlyNo As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnYearlyNo")
                    Dim regNo As HiddenField = grdDoctorShare.Rows(i).FindControl("hdnRegNo")
                    Dim lblBankAmount As Label = grdDoctorShare.Rows(i).FindControl("lblBankAmount")
                    If lblBankAmount.Text <> "0" Then

                        UpdateDoctorShare(Id, yearlyNo.Value, Request.QueryString("DoctorId"), sId.Value, "pay_VoucherId")

                    End If
                End If
            Next

            Response.Redirect("~/DoctorShare/DoctorShareSummary.aspx")



        Catch ex As Exception

        End Try
    End Sub

    Function PostVoucher() As String


        Dim conn As New SqlConnection
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString

        Dim cmd As New SqlCommand("JV_Doctor_pay", conn)
        cmd.CommandType = CommandType.StoredProcedure

        cmd.Parameters.AddWithValue("@By_Emp_Id", Session("emp_id"))
        cmd.Parameters.AddWithValue("@SubDept_Id", Session("subdeptid"))
        cmd.Parameters.AddWithValue("@Dept_Id", Session("dept_id"))

        cmd.Parameters.AddWithValue("@IncomeTaxCode", ddl_tax.SelectedValue)
        cmd.Parameters.AddWithValue("@IncomeTaxAmount", hdnTaxAmount.Value)
        cmd.Parameters.AddWithValue("@PayableCode", ddl_Deduction.SelectedValue)
        cmd.Parameters.AddWithValue("@PayableAmount", txtDeduction.Text)
        cmd.Parameters.AddWithValue("@mode_payment", ddl_mode_of_payment.SelectedItem.Text)
        cmd.Parameters.AddWithValue("@payment_head", ddl_head.SelectedValue)
        cmd.Parameters.AddWithValue("@CheckNo", txtChequeNo.Text)

        cmd.Parameters.AddWithValue("@pay_As", lbl_payment.Text)
        cmd.Parameters.AddWithValue("@pay_remarks", txt_Description.Text)
        cmd.Parameters.AddWithValue("@amount", lbl_amount.Text)
        cmd.Parameters.AddWithValue("@doctor_ID", Request.QueryString("doctorid").ToString())

        cmd.Parameters.AddWithValue("@Voucher_Trans_Id", 0)
        cmd.Parameters("@Voucher_Trans_Id").Direction = ParameterDirection.Output
        conn.Open()
        cmd.ExecuteNonQuery()
        conn.Close()

        Return cmd.Parameters("@Voucher_Trans_Id").Value
    End Function

    Protected Sub btn_close_pnl_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_close_pnl.Click
        pnl_Deposit.Visible = False
    End Sub

    Protected Sub ddl_head_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_head.SelectedIndexChanged

    End Sub
End Class
