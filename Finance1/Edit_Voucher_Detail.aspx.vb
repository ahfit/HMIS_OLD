Imports System.Data

Partial Class Finance_Edit_Voucher_Detail
    Inherits System.Web.UI.Page

    Private isPrerenderNeeded As Boolean = False

    Private ReadOnly Property Voucher_Trans_Id() As Integer
        Get
            Dim retVal As Integer
            Try
                retVal = Integer.Parse(Request.QueryString("voucher_trans_id"))
            Catch ex As Exception
                retVal = 0
            End Try
            Return retVal
        End Get
    End Property



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

      
        If Not Page.IsPostBack Then

            DropDownList_Companyname.DataBind()
            LoadVoucherDetail()
            DropDownList_Branchname.DataBind()

            If Session("Company_Branch_Id") = 1 Or Session("Company_Branch_Id") = 2 Then

                DropDownList_Companyname.Enabled = True
                DropDownList_Branchname.Enabled = True
            Else
                DropDownList_Companyname.Enabled = False
                DropDownList_Branchname.Enabled = False


            End If
        End If
    End Sub

    Private Sub LoadVoucherDetail()
        sds_For_Date.SelectParameters("Voucher_Trans_Id").DefaultValue = Voucher_Trans_Id
        Dim dv As DataView
        dv = sds_For_Date.Select(DataSourceSelectArguments.Empty)
        Dim dt As DataTable
        dt = dv.Table
        wdc_For_Date.Value = dt.Rows(0)(0).ToString()
        sqlDs_VoucherDetail.SelectParameters("Voucher_Trans_Id").DefaultValue = Voucher_Trans_Id
        gvVoucherDetail.DataBind()
        isPrerenderNeeded = True

        If dt.Rows.Count > 0 Then
            LoadCompanyBranch(dt.Rows(0)("Financial_Company_Id").ToString(), dt.Rows(0)("Company_Branch_Id").ToString())
        End If
    End Sub

    Protected Sub gvVoucherDetail_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvVoucherDetail.PreRender
        
        If Not isPrerenderNeeded Or gvVoucherDetail.Rows.Count = 0 Then
            Return
        End If
        coutTotal()
        
        'For Each gvRow As GridViewRow In gvVoucherDetail.Rows
        '    Dim ddlParty As DropDownList = gvRow.FindControl("ddlParty")
        '    ddlParty.DataBind()

        'Next
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim lblVoucherDetailId As HiddenField = Nothing
        Dim ddlAccountHead As DropDownList = Nothing
        Dim txtDescription As TextBox = Nothing
        Dim txtDebit As TextBox = Nothing
        Dim txtCredit As TextBox = Nothing
        Dim lblTotalDebit As Label = gvVoucherDetail.FooterRow.FindControl("lblTotalDebit")
        Dim lblTotalCredit As Label = gvVoucherDetail.FooterRow.FindControl("lblTotalCredit")
        If lblTotalDebit.Text = lblTotalCredit.Text Then

            lblMsg.Visible = False
            For Each itm As GridViewRow In gvVoucherDetail.Rows
                lblVoucherDetailId = CType(itm.FindControl("hfldVoucherDetailId"), HiddenField)
                ddlAccountHead = CType(itm.FindControl("ddlAccountHead"), DropDownList)
                txtDescription = CType(itm.FindControl("txtDescription"), TextBox)
                txtDebit = CType(itm.FindControl("txtDebit"), TextBox)
                txtCredit = CType(itm.FindControl("txtCredit"), TextBox)

                sqlDs_VoucherDetail.UpdateParameters("Reciept_Disbursement_Detail_Id").DefaultValue = lblVoucherDetailId.Value
                sqlDs_VoucherDetail.UpdateParameters("Account_Head_id").DefaultValue = ddlAccountHead.SelectedValue
                sqlDs_VoucherDetail.UpdateParameters("Description").DefaultValue = txtDescription.Text
                If txtDebit.Enabled = True Then
                    sqlDs_VoucherDetail.UpdateParameters("Amount").DefaultValue = txtDebit.Text
                End If
                If txtCredit.Enabled = True Then
                    sqlDs_VoucherDetail.UpdateParameters("Amount").DefaultValue = txtCredit.Text
                End If

                sqlDs_VoucherDetail.Update()
            Next
            sds_For_Date.UpdateParameters("For_Date").DefaultValue = wdc_For_Date.Value.ToString()
            sds_For_Date.UpdateParameters("Voucher_Trans_Id").DefaultValue = Voucher_Trans_Id()
            sds_For_Date.Update()
        Else
            lblMsg.Visible = True
        End If
    End Sub

    Protected Sub btnFinalizeVoucher_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnFinalizeVoucher.Click
        sqlDs_FinalizeVoucher.UpdateParameters("Voucher_Trans_Id").DefaultValue = Voucher_Trans_Id
        sqlDs_FinalizeVoucher.Update()
    End Sub

    Protected Sub gvVoucherDetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvVoucherDetail.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then

                Dim ddl As DropDownList = CType(e.Row.FindControl("ddlAccountHead"), DropDownList)
                Dim hfld As HiddenField = CType(e.Row.FindControl("hfldAccountHeadId"), HiddenField)
                Dim hdfActionId As HiddenField = CType(e.Row.FindControl("hdfCrDrActionID"), HiddenField)
                Dim ddlCostCenter As DropDownList = CType(e.Row.FindControl("ddlCostCenter"), DropDownList)
                Dim ddlParty As DropDownList = CType(e.Row.FindControl("ddlParty"), DropDownList)
                Dim hfCostCenter As HiddenField = CType(e.Row.FindControl("hfCostCenter"), HiddenField)
                Dim hfldPartyId As HiddenField = CType(e.Row.FindControl("hfldPartyId"), HiddenField)

                Dim txtDr As TextBox = CType(e.Row.FindControl("txtDebit"), TextBox)
                Dim txtCr As TextBox = CType(e.Row.FindControl("txtCredit"), TextBox)

                ddlCostCenter.SelectedValue = hfCostCenter.Value
                If ddl IsNot Nothing AndAlso hfld.Value <> "0" Then
                    ddl.DataBind()
                    ddl.SelectedValue = hfld.Value
                End If
                If Convert.ToInt32(hdfActionId.Value) = 1 Then
                    txtCr.Enabled = False
                    txtDr.Enabled = True
                End If
                If Convert.ToInt32(hdfActionId.Value) = 2 Then
                    txtCr.Enabled = True
                    txtDr.Enabled = False
                End If
                'ddl = CType(e.Row.FindControl("ddlParty"), DropDownList)
                'hfld = CType(e.Row.FindControl("hfldPartyId"), HiddenField)
                'If ddl IsNot Nothing AndAlso hfld.Value <> "0" Then
                If hfldPartyId.Value <> "0" Then

                    ddlParty.SelectedValue = hfldPartyId.Value
                End If

            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btnChangeCompany_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim btnTemp As LinkButton = sender
        Dim VID As Double = Convert.ToDouble(btnTemp.CommandArgument)
        Dim gvRow As GridViewRow = btnTemp.NamingContainer
        Dim ddlParty As DropDownList = gvRow.FindControl("ddlParty")
        Dim ddlCostCenter As DropDownList = gvRow.FindControl("ddlCostCenter")
        If btnTemp.Text = "Update Company" Then
            ddlParty.Enabled = True
            btnTemp.Text = "Update"

            sqlCost_Center.UpdateParameters("CostCenter").DefaultValue = ddlCostCenter.SelectedValue
            sqlCost_Center.UpdateParameters("Reciept_Disbursement_Detail_Id").DefaultValue = VID
            sqlCost_Center.Update()

        Else
            If btnTemp.Text = "Update" And ddlParty.SelectedValue >= 0 Then
                sqlDs_Party.UpdateParameters("Party_ID").DefaultValue = ddlParty.SelectedValue
                sqlDs_Party.UpdateParameters("Reciept_Disbursement_Detail_Id").DefaultValue = VID
                sqlDs_Party.Update()

                sqlCost_Center.UpdateParameters("CostCenter").DefaultValue = ddlCostCenter.SelectedValue
                sqlCost_Center.UpdateParameters("Reciept_Disbursement_Detail_Id").DefaultValue = VID
                sqlCost_Center.Update()


                btnTemp.Text = "Update Company"


                ' gvVoucherDetail.DataBind()
            End If
        End If


    End Sub

    Protected Sub SQL_Companyname_Selecting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceSelectingEventArgs) Handles SQL_Companyname.Selecting

    End Sub
    Private Sub LoadCompanyBranch(ByVal companyId As String, ByVal branchId As String)
        'Response.Write(companyId)
        'Response.Write(branchId)
        'Response.End()
        DropDownList_Companyname.SelectedValue = companyId.Trim()
        DropDownList_Branchname.SelectedValue = branchId.Trim()


    End Sub
    Protected Sub coutTotal()
        Dim totalDebit As Decimal = 0
        Dim totalCredit As Decimal = 0

        Dim lblDebit As TextBox = Nothing
        Dim lblCredit As TextBox = Nothing

        Dim lblTotalDebit As Label = Nothing
        Dim lblTotalCredit As Label = Nothing

        For Each itm As GridViewRow In gvVoucherDetail.Rows
            lblDebit = CType(itm.FindControl("txtDebit"), TextBox)
            lblCredit = CType(itm.FindControl("txtCredit"), TextBox)

            If Not lblDebit Is Nothing AndAlso lblDebit.Text.Trim().Length > 0 Then
                totalDebit += Decimal.Parse(lblDebit.Text)
            End If

            If Not lblCredit Is Nothing AndAlso lblCredit.Text.Trim().Length > 0 Then
                totalCredit += Decimal.Parse(lblCredit.Text)
            End If

        Next

        lblTotalDebit = CType(gvVoucherDetail.FooterRow.FindControl("lblTotalDebit"), Label)
        lblTotalCredit = CType(gvVoucherDetail.FooterRow.FindControl("lblTotalCredit"), Label)

        If Not lblTotalCredit Is Nothing Then
            lblTotalCredit.Text = totalCredit.ToString("#,#")
        End If

        If Not lblTotalDebit Is Nothing Then
            lblTotalDebit.Text = totalDebit.ToString("#,#")
        End If
    End Sub

    Protected Sub txtDebit_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        coutTotal()
    End Sub

    Protected Sub txtCredit_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        coutTotal()
    End Sub
End Class
