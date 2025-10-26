Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Data.SqlDbType

Partial Class Payment_To_Vendor
    Inherits System.Web.UI.Page


    Dim constring As String = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString
    Dim BasicConstring As String = ConfigurationManager.ConnectionStrings("BasicDataConnectionString").ConnectionString
    Dim _SqlAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim _SqlCon As SqlConnection
    Dim _SqlCommand As SqlCommand = New SqlCommand()



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        If Not IsPostBack Then


            WebDateChooser_PODate.Value = DateAndTime.Now

            HF_Expance_Date.Value = Convert.ToDateTime(WebDateChooser_PODate.Value).ToString()
            ddl_Expanse.DataBind()
            If ddl_Expanse.SelectedItem.Text = "Creditor" Then
                DropDownList_Party.Visible = True
                DropDownList_Party.DataBind()
            Else
                DropDownList_Party.Visible = False
            End If


            If Session("Branch_Access") = 1 Then

                HF_Branch_Access.Value = "1"
            Else
                HF_Branch_Access.Value = "%"
            End If
            txt_Famount.Text = hdnFinalAmount.Value

            lblIncomeTax.Text = hdnIncomeTax.Value
            lblGST.Text = hdnGst.Value
            lblOtherTax.Text = hdnOtherTax.Value
            load_head()

        End If
        
    End Sub


    Protected Sub DropDownList3_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Party.SelectedIndexChanged

    End Sub

    Protected Sub BTN_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTN_Save.Click
        Try
            If TXT_Amount.Text.Trim() = "" Or Convert.ToDouble(TXT_Amount.Text.Trim()) <= 0 Then
                LBL_MSG.Text = "Please Select the amount first . . . "
            Else
                'HF_Expance_Date.Value = Convert.ToDateTime(WebDateChooser_PODate.Value).ToString()
                'SDS_GV.Insert()
                savePayment()
                GV_Record.DataBind()
                LBL_MSG.Text = ""
                TXT_Amount.Text = ""
                TXT_Description.Text = ""
                Dim sb As New StringBuilder
                sb.Append("<script language='javascript' type='text/javascript'>window.open('CReport_Recipt_Voucher.aspx')</script>")
                Dim t As Type = Me.GetType()
                If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
                    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
                End If
                'Response.Redirect("~/Finance/CReport_Recipt_Voucher.aspx")
            End If


        Catch ex As Exception
            LBL_MSG.Text = ex.ToString()
        End Try


    End Sub

    Protected Sub TXT_Description_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TXT_Description.TextChanged

    End Sub

    Protected Sub HF_Branch_Access_ValueChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles HF_Branch_Access.ValueChanged

    End Sub


    Protected Sub SDS_GV_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles SDS_GV.Selecting

    End Sub

    'Protected Sub RBL_Am_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RBL_Am_Type.SelectedIndexChanged
    '    If RBL_Am_Type.SelectedValue = "Cash" Then
    '        HF_AC.Value = "33701"
    '        LabelACNO.Visible = False
    '        DDL_AC_NO.Visible = False
    '    Else
    '        HF_AC.Value = DDL_AC_NO.SelectedValue.ToString()
    '        LabelAC.Visible = True
    '        DDL_AC_NO.Visible = True

    '    End If
    'End Sub


    'Protected Sub DDL_AC_NO_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDL_AC_NO.SelectedIndexChanged
    '    HF_AC.Value = DDL_AC_NO.SelectedValue.ToString()
    'End Sub


    Protected Sub TXT_Party_Name_TextChanged(sender As Object, e As System.EventArgs) Handles TXT_Party_Name.TextChanged
        Dim count As Integer = 0
        Dim con_Party As New SqlConnection(BasicConstring)
        con_Party.Open()
        Dim command_Party As New SqlCommand("Select Count(*) from parties where party_name like '%'+@P_Name+'%'", con_Party)
        command_Party.Parameters.AddWithValue("@P_Name", TXT_Party_Name.Text.Trim())

        count = Convert.ToInt32(command_Party.ExecuteScalar())
        If count > 0 Then

            LBL_Rec_MSG.Text = count.ToString() & " Record(s) found "
            Hf_PARTY_NAME.Value = "%" & TXT_Party_Name.Text.Trim() & "%"

        Else
            LBL_Rec_MSG.Text = "No Record Found"

            Hf_PARTY_NAME.Value = "%"
        End If

        con_Party.Close()
    End Sub
    Protected Sub ddl_mode_of_payment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_mode_of_payment.SelectedIndexChanged
        load_head()        
        If ddl_mode_of_payment.SelectedItem.Text = "Cheque" Then
            'trCheckNo.Style.Add(HtmlTextWriterStyle.Display, "block")
            trCheckNo.Visible = True
        Else
            'trCheckNo.Style.Add(HtmlTextWriterStyle.Display, "none")
            trCheckNo.Visible = False
        End If
    End Sub
    Protected Sub savePayment()       
        Try
            Dim vID As Integer = 0
            If ddl_Expanse.SelectedItem.Text = "Creditor" Then
                vID = DropDownList_Party.SelectedValue
            Else
                vID = 0
            End If
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim cmd As SqlCommand = New SqlCommand("insert_Payment_To_Vender", con)
            cmd.CommandType = CommandType.StoredProcedure
            con.Open()

            cmd.Parameters.AddWithValue("@Dr_Ecode", ddl_Expanse.SelectedValue)
            cmd.Parameters.AddWithValue("@Payment_Date", WebDateChooser_PODate.Value)
            cmd.Parameters.AddWithValue("@Amount", TXT_Amount.Text)
            cmd.Parameters.AddWithValue("@GST", hdnGst.Value)
            cmd.Parameters.AddWithValue("@IncomeTax", hdnIncomeTax.Value)
            cmd.Parameters.AddWithValue("@OtherTax", hdnOtherTax.Value)
            cmd.Parameters.AddWithValue("@FinalAmount", hdnFinalAmount.Value)
            cmd.Parameters.AddWithValue("@Vender_Party_Id", vID)
            cmd.Parameters.AddWithValue("@Cr_Ecode", ddl_head.SelectedValue)
            cmd.Parameters.AddWithValue("@Description", TXT_Description.Text)
            cmd.Parameters.AddWithValue("@PaymentType", ddl_mode_of_payment.SelectedValue)
            cmd.Parameters.AddWithValue("@CheckNo", txtCheckNo.Text)
            cmd.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
            cmd.Parameters.AddWithValue("@Add_By_Emp_ID", Session("emp_iD"))
            cmd.Parameters.AddWithValue("@Subdept_ID", Session("SubDeptid"))

            cmd.Parameters.Add("@Voucher_Trans_ID", System.Data.SqlDbType.Int)
            cmd.Parameters("@Voucher_Trans_ID").Direction = System.Data.ParameterDirection.Output


            cmd.ExecuteNonQuery()
            Dim value As String = cmd.Parameters("@Voucher_Trans_ID").Value.ToString()
            Session.Add("VTI", value)

            lblMsg.Visible = True
            lblMsg.Text = "Information saved successfully!"
            lblMsg.ForeColor = Drawing.Color.Green

        Catch ex As Exception
            lblMsg.Visible = True
            lblMsg.Text = "Some error occurred!"
            lblMsg.ForeColor = Drawing.Color.Red

        End Try
        
    End Sub
    Protected Sub load_head()
        Dim Statment As String = "SELECT Expenditure.E_Code, Expenditure.E_Name FROM Head_Master_Table INNER JOIN Expenditure ON Head_Master_Table.E_Code = Expenditure.E_Code WHERE (Head_Master_Table.Head_Type = @Head_Type)"
        Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Head_Type", ddl_mode_of_payment.SelectedValue)
             }
        ddl_head.DataSource = ExecuteDataTable(Statment, "Finance_ConnectionString", sqlParams, "Text")
        ddl_head.DataBind()
    End Sub
    Public Sub ExecuteNonQuery(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter(), ByVal Ptype As String)

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
    Public Sub Openconn(ByVal connStr As String)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings(connStr).ConnectionString
            _SqlCon = New SqlConnection(constr)
            _SqlCon.Open()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Protected Sub ddl_Expanse_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_Expanse.SelectedIndexChanged
        If ddl_Expanse.SelectedItem.Text = "Creditor" Then
            DropDownList_Party.Visible = True
            DropDownList_Party.DataBind()
        Else
            DropDownList_Party.Visible = False
        End If
    End Sub
End Class
