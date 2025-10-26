Imports System.Data
Imports System.Collections.Generic

Partial Class Store_IssueItemsExternal
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        DefaultValues()
        If Not Page.IsPostBack() Then

            btnIssuetoCustomer.Visible = False
            dlist_info.DataBind()
            loadCustomerInfo()


            HiddenField_RequisitionID.Value = Request.QueryString("RequisitionID")
            DataList_DataList.DataBind()
            If (gvReservedItems.Rows.Count > 0) Then
                btnIssuetoCustomer.Visible = True
            End If

        End If

    End Sub

    Protected Sub LinkButton_Subject_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim lnkBtn As LinkButton = CType(sender, LinkButton)
        Dim itemCode As String = lnkBtn.CommandArgument
        Dim Demand_QtyLabel As Label = lnkBtn.NamingContainer.FindControl("Demand_QtyLabel")
        Dim CB_Serial As CheckBox = lnkBtn.NamingContainer.FindControl("CB_Serial")
        lblSelectedItem.Text = "( " + lnkBtn.CommandArgument + " - " + lnkBtn.Text + " )"
        txtDemandQty.Text = Demand_QtyLabel.Text
        sqlDs_ItemStockData.SelectParameters("Item_Code").DefaultValue = itemCode
        If CB_Serial.Checked Then
            sqlDs_ItemStockSerialData.SelectParameters("Item_Code").DefaultValue = itemCode
            gvStockSerialData.DataBind()
        Else
            sqlDs_ItemStockData.SelectParameters("Item_Code").DefaultValue = itemCode
            gvItemDetail.DataBind()
        End If
        gvReservedItems.DataBind()

    End Sub

    Protected Sub gvItemDetail_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvItemDetail.RowDataBound
        Dim lblRemainingBalance As Label
        Dim txtIssueQty As TextBox

        If e.Row.RowType = DataControlRowType.DataRow Then
            lblRemainingBalance = CType(e.Row.FindControl("lblRemainingBalance"), Label)
            txtIssueQty = CType(e.Row.FindControl("txtIssueQty"), TextBox)
            txtIssueQty.Attributes.Add("onkeyup", "CheckQuantityLimit('" + lblRemainingBalance.Text + "','" + txtIssueQty.ClientID + "','" + txtDemandQty.ClientID + "')")
        End If

    End Sub

    Private ReadOnly Property RequisitionID() As String
        Get
            Return Request.QueryString("RequisitionID")
        End Get
    End Property


    Protected Sub btnSaveTemp_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveTemp.Click
        Dim hfld_SubId As HiddenField, hfld_Item_Code As HiddenField, hfld_BatchNo As HiddenField, hfld_PK_ID As HiddenField
        Dim hfld_Receive_Date As HiddenField, hfld_Exp As HiddenField
        Dim txtIssueQty As TextBox
        Dim requisitionId As String = Request.QueryString("RequisitionID")
        Dim isValidQty As Boolean

        isValidQty = ValidateItemCount()

        If isValidQty = False Then
            lblMsgs.Text = "Selected Items are more than demanded."
            lblMsgs.Visible = True
            Return
        Else
            lblMsgs.Visible = False
        End If

        For Each gvRow As GridViewRow In gvItemDetail.Rows

            Try
                hfld_SubId = CType(gvRow.FindControl("hfld_SubId"), HiddenField)
                hfld_Item_Code = CType(gvRow.FindControl("hfld_Item_Code"), HiddenField)
                hfld_BatchNo = CType(gvRow.FindControl("hfld_BatchNo"), HiddenField)
                hfld_PK_ID = CType(gvRow.FindControl("hfld_PK_ID"), HiddenField)
                hfld_Receive_Date = CType(gvRow.FindControl("hfld_Receive_Date"), HiddenField)
                hfld_Exp = CType(gvRow.FindControl("hfld_Exp"), HiddenField)
                txtIssueQty = CType(gvRow.FindControl("txtIssueQty"), TextBox)

                If Not String.IsNullOrEmpty(txtIssueQty.Text.Trim()) AndAlso Integer.Parse(txtIssueQty.Text) > 0 Then
                    sqlDs_SaveStockData.InsertParameters("PK_ID").DefaultValue = hfld_PK_ID.Value
                    sqlDs_SaveStockData.InsertParameters("Sub_Id").DefaultValue = hfld_SubId.Value
                    sqlDs_SaveStockData.InsertParameters("Item_Code").DefaultValue = hfld_Item_Code.Value
                    sqlDs_SaveStockData.InsertParameters("BatchNo").DefaultValue = hfld_BatchNo.Value
                    sqlDs_SaveStockData.InsertParameters("Qty").DefaultValue = txtIssueQty.Text
                    sqlDs_SaveStockData.InsertParameters("Requisition_ID").DefaultValue = requisitionId
                    sqlDs_SaveStockData.InsertParameters("Receive_Date").DefaultValue = hfld_Receive_Date.Value
                    sqlDs_SaveStockData.InsertParameters("Exp").DefaultValue = hfld_Exp.Value
                    sqlDs_SaveStockData.InsertParameters("ReservedBy").DefaultValue = Session("emp_id")
                    sqlDs_SaveStockData.Insert()

                End If

            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try

        Next

        gvItemDetail.DataBind()
        gvReservedItems.DataBind()
        btnIssuetoCustomer.Visible = True

    End Sub

    Private Function ValidateItemCount() As Boolean

        Dim dv As DataView
        Dim dt As DataTable
        Dim hfld_SubId As HiddenField, hfld_Item_Code As HiddenField, hfld_BatchNo As HiddenField, hfld_PK_ID As HiddenField
        Dim hfld_Receive_Date As HiddenField, hfld_Exp As HiddenField
        Dim txtIssueQty As TextBox, previousSum As Integer, newItemCount As Integer = 0
        Dim requisitionId As String = Request.QueryString("RequisitionID")
        Dim subIdCounts As New Dictionary(Of Integer, Integer)

        For Each gvRow As GridViewRow In gvItemDetail.Rows

            Try
                hfld_SubId = CType(gvRow.FindControl("hfld_SubId"), HiddenField)
                hfld_Item_Code = CType(gvRow.FindControl("hfld_Item_Code"), HiddenField)
                hfld_BatchNo = CType(gvRow.FindControl("hfld_BatchNo"), HiddenField)
                hfld_PK_ID = CType(gvRow.FindControl("hfld_PK_ID"), HiddenField)
                hfld_Receive_Date = CType(gvRow.FindControl("hfld_Receive_Date"), HiddenField)
                hfld_Exp = CType(gvRow.FindControl("hfld_Exp"), HiddenField)
                txtIssueQty = CType(gvRow.FindControl("txtIssueQty"), TextBox)

                If Not String.IsNullOrEmpty(txtIssueQty.Text.Trim()) AndAlso Integer.Parse(txtIssueQty.Text) > 0 Then
                    newItemCount += Integer.Parse(txtIssueQty.Text)
                End If

                sqlDs_ReservedItemCount.SelectParameters("Sub_Id").DefaultValue = hfld_SubId.Value
                sqlDs_ReservedItemCount.SelectParameters("Requisition_ID").DefaultValue = requisitionId
                dv = CType(sqlDs_ReservedItemCount.Select(DataSourceSelectArguments.Empty), DataView)
                dt = dv.Table
                If Integer.Parse(dt.Rows(0)(0).ToString()) > 0 Then
                    subIdCounts.Add(hfld_SubId.Value, Integer.Parse(dt.Rows(0)(0).ToString()))
                End If

            Catch ex As Exception

            End Try

        Next

        For Each dicItem As KeyValuePair(Of Integer, Integer) In subIdCounts
            previousSum += dicItem.Value
        Next

        If newItemCount + previousSum > Integer.Parse(txtDemandQty.Text) Then
            Return False
        End If
        Return True

    End Function

    Protected Sub imgBtnDelete_Click(ByVal sender As Object, ByVal e As ImageClickEventArgs)
        Dim imgBtn As ImageButton = CType(sender, ImageButton)
        Dim recordId As Long = Long.Parse(imgBtn.CommandArgument)
        sqlDs_ReservedStockData.DeleteParameters("PK_ID").DefaultValue = recordId.ToString()
        sqlDs_ReservedStockData.DeleteParameters("UnmarkSerial").DefaultValue = "TRUE"
        sqlDs_ReservedStockData.Delete()
        gvItemDetail.DataBind()
        gvReservedItems.DataBind()
        gvStockSerialData.DataBind()
    End Sub

    Protected Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click

        Dim hfld_Sub_Id As HiddenField, hfld_Item_Code As HiddenField, hfld_Item_Qty As HiddenField, hfld_BatchNo As HiddenField
        Dim hfld_PK_ID As HiddenField
        Dim reqID As String
        reqID = RequisitionID
        Dim isFirstPass As Boolean = True

        For Each gvRow As GridViewRow In gvReservedItems.Rows

            hfld_Sub_Id = CType(gvRow.FindControl("hfld_Sub_Id"), HiddenField)
            hfld_Item_Code = CType(gvRow.FindControl("hfld_Item_Code"), HiddenField)
            hfld_Item_Qty = CType(gvRow.FindControl("hfld_Item_Qty"), HiddenField)
            hfld_BatchNo = CType(gvRow.FindControl("hfld_BatchNo"), HiddenField)
            hfld_PK_ID = CType(gvRow.FindControl("hfld_PK_ID"), HiddenField)

            If isFirstPass Then
                sqlDs_Store_Item_Issue_Main.InsertParameters("Store_Item_Issue_Id").DefaultValue = "0"
                sqlDs_Store_Item_Issue_Main.InsertParameters("IB_ID").DefaultValue = reqID
                sqlDs_Store_Item_Issue_Main.InsertParameters("Issue_By").DefaultValue = Session("emp_id")
                sqlDs_Store_Item_Issue_Main.InsertParameters("Issue_By_Dept_ID").DefaultValue = Session("dept_id")
                sqlDs_Store_Item_Issue_Main.InsertParameters("Issue_By_Sub_Dept_ID").DefaultValue = Session("SubDeptID")
                sqlDs_Store_Item_Issue_Main.Insert()
                isFirstPass = False
            End If

            sqlDs_Store_Item_Issue_Sub.InsertParameters("Store_Item_Issue_Id").DefaultValue = hfld_Store_Item_Issue_MainID.Value
            sqlDs_Store_Item_Issue_Sub.InsertParameters("Item_Code").DefaultValue = hfld_Item_Code.Value
            sqlDs_Store_Item_Issue_Sub.InsertParameters("Item_Qty").DefaultValue = hfld_Item_Qty.Value
            sqlDs_Store_Item_Issue_Sub.InsertParameters("BatchNo").DefaultValue = hfld_BatchNo.Value
            sqlDs_Store_Item_Issue_Sub.InsertParameters("Sub_Id").DefaultValue = hfld_Sub_Id.Value
            sqlDs_Store_Item_Issue_Sub.InsertParameters("Requisition_ID").DefaultValue = reqID
            sqlDs_Store_Item_Issue_Sub.Insert()

            sqlDs_ReservedStockData.DeleteParameters("PK_ID").DefaultValue = hfld_PK_ID.Value
            sqlDs_ReservedStockData.DeleteParameters("UnmarkSerial").DefaultValue = "FALSE"
            sqlDs_ReservedStockData.Delete()

        Next

        gvItemDetail.DataBind()
        gvReservedItems.DataBind()

        Response.Redirect("Issue_Wise_Items.aspx?Issue_id=" + hfld_Store_Item_Issue_MainID.Value)

    End Sub

    Protected Sub sqlDs_Store_Item_Issue_Main_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sqlDs_Store_Item_Issue_Main.Inserted
        hfld_Store_Item_Issue_MainID.Value = e.Command.Parameters("@Store_Item_Issue_Id").Value
    End Sub

    Protected Sub chkSerialSelectAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim chkAll As CheckBox = CType(sender, CheckBox)
        Dim chkSerialSelect As CheckBox
        For Each gvRow As GridViewRow In gvStockSerialData.Rows
            chkSerialSelect = CType(gvRow.FindControl("chkSerialSelect"), CheckBox)
            chkSerialSelect.Checked = chkAll.Checked
        Next

    End Sub

    Protected Sub btnSaveSerial_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSaveSerial.Click
        Dim chkSerialSelect As CheckBox
        Dim hfld_SubId As HiddenField
        Dim hfld_Serial_No_ID As HiddenField
        Dim hfld_Tag_ID As HiddenField
        Dim IsValidSelection As Boolean

        IsValidSelection = ValidateSerialSelection()

        If IsValidSelection = False Then
            lblMsgs.Text = "Selected Items are more than demanded."
            Return
        End If

        For Each gvRow As GridViewRow In gvStockSerialData.Rows
            chkSerialSelect = CType(gvRow.FindControl("chkSerialSelect"), CheckBox)
            hfld_SubId = CType(gvRow.FindControl("hfld_SubId"), HiddenField)
            hfld_Serial_No_ID = CType(gvRow.FindControl("hfld_Serial_No_ID"), HiddenField)
            hfld_Tag_ID = CType(gvRow.FindControl("hfld_Tag_ID"), HiddenField)
            If chkSerialSelect.Checked Then

                sqlDs_StoreItemReceivedSerialNo.UpdateParameters("SubId").DefaultValue = hfld_SubId.Value
                sqlDs_StoreItemReceivedSerialNo.UpdateParameters("Serial_No_ID").DefaultValue = hfld_Serial_No_ID.Value
                sqlDs_StoreItemReceivedSerialNo.UpdateParameters("RQ_ID").DefaultValue = RequisitionID
                sqlDs_StoreItemReceivedSerialNo.UpdateParameters("By_Emp_ID").DefaultValue = Session("emp_id")
                sqlDs_StoreItemReceivedSerialNo.UpdateParameters("Tag_ID").DefaultValue = hfld_Tag_ID.Value
                sqlDs_StoreItemReceivedSerialNo.Update()

            End If

        Next

        gvStockSerialData.DataBind()
        gvReservedItems.DataBind()
        gvItemDetail.DataBind()

    End Sub

    Private Function ValidateSerialSelection() As Boolean
        Dim chkSerialSelect As CheckBox
        Dim hfld_SubId As New HiddenField
        Dim count As Integer = 0, previousSum As Integer = 0
        Dim dv As DataView
        Dim dt As DataTable
        Dim subIdCounts As New Dictionary(Of Integer, Integer)

        hfld_SubId.Value = "0"

        For Each gvRow As GridViewRow In gvStockSerialData.Rows
            chkSerialSelect = CType(gvRow.FindControl("chkSerialSelect"), CheckBox)
            hfld_SubId = CType(gvRow.FindControl("hfld_SubId"), HiddenField)

            Try
                sqlDs_ReservedItemCount.SelectParameters("Sub_Id").DefaultValue = hfld_SubId.Value
                dv = CType(sqlDs_ReservedItemCount.Select(DataSourceSelectArguments.Empty), DataView)
                dt = dv.Table
                If Integer.Parse(dt.Rows(0)(0).ToString()) > 0 Then
                    subIdCounts.Add(hfld_SubId.Value, Integer.Parse(dt.Rows(0)(0).ToString()))
                    'count = count + Integer.Parse(dt.Rows(0)(0).ToString())
                End If
            Catch ex As Exception

            End Try

            If chkSerialSelect.Checked Then
                count = count + 1
            End If
        Next

        For Each dicItem As KeyValuePair(Of Integer, Integer) In subIdCounts
            previousSum += dicItem.Value
        Next

        If count + previousSum > Integer.Parse(txtDemandQty.Text) Then
            Return False
        End If
        Return True
    End Function

    Private Sub DefaultValues()
        lblMsgs.Text = String.Empty
        If String.IsNullOrEmpty(Session("RegistrationNo")) Then
            btnIssuetoCustomer.Text = "Issue Stock"
        Else
            btnIssuetoCustomer.Text = "Issue Stock"
        End If
    End Sub

    Protected Sub btnIssuetoCustomer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnIssuetoCustomer.Click
        Dim hfld_Company_Id As HiddenField
        Dim reqID As String
        reqID = RequisitionID
        Dim lblDelSite As Label, lblDelAdd As Label, lblCPerson As Label, lblPhone As Label

        'For Each dtl As DataListItem In dlist_info.Items
        '    lblDelSite = dtl.FindControl("SiteLabel")
        '    lblDelAdd = dtl.FindControl("Lbl_D_Add")
        '    lblCPerson = dtl.FindControl("lbl_C_Per")
        '    lblPhone = dtl.FindControl("lbl_phone")
        '    hfld_Company_Id = dtl.FindControl("HF_Company_ID")
        If (gvReservedItems.Rows.Count > 0) Then



            sqlDs_StoreItem_Consumption_Main.InsertParameters("Consumption_Id").DefaultValue = "0"
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Consumed_By").DefaultValue = Session("emp_id")
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Dept_iD").DefaultValue = Session("dept_id")
            sqlDs_StoreItem_Consumption_Main.InsertParameters("SubDept_Id").DefaultValue = Session("SubDeptID")
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Requisition_Id").DefaultValue = RequisitionID
            sqlDs_StoreItem_Consumption_Main.InsertParameters("SO_Id").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Company_Id").DefaultValue = 0
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Delivery_Method").DefaultValue = txt_delivery_method.Text
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Delivery_No").DefaultValue = txt_delivery_m_No.Text
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Delivery_Person_Info").DefaultValue = txt_delivery_p_info.Text
            sqlDs_StoreItem_Consumption_Main.InsertParameters("DC_NO").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Delivery_Site").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Delivery_Address").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Contact_Person").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Phone_No").DefaultValue = ""
            sqlDs_StoreItem_Consumption_Main.InsertParameters("Received_By").DefaultValue = "0"

            sqlDs_StoreItem_Consumption_Main.Insert()

            'Next

            Response.Redirect("Search_Order_Wise.aspx?C_ID=" + hfld_StoreItem_Consumption_Main.Value)
            gvItemDetail.DataBind()
            gvReservedItems.DataBind()
        End If

    End Sub

    Protected Sub sqlDs_StoreItem_Consumption_Main_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles sqlDs_StoreItem_Consumption_Main.Inserted
        hfld_StoreItem_Consumption_Main.Value = e.Command.Parameters("@Consumption_Id").Value
    End Sub
    Protected Sub loadCustomerInfo()
        If dlist_info.Items.Count > 1 Then
            Dim LabelCompany As Label = dlist_info.Items(0).FindControl("LabelCompany")
            Dim l1 As Label = dlist_info.Items(0).FindControl("lbl_site")
            Dim SiteLabel As Label = dlist_info.Items(0).FindControl("SiteLabel")
            Dim l3 As Label = dlist_info.Items(0).FindControl("Label12")
            Dim Lbl_D_Add As Label = dlist_info.Items(0).FindControl("Lbl_D_Add")
            Dim l5 As Label = dlist_info.Items(0).FindControl("Label13")
            Dim l6 As Label = dlist_info.Items(0).FindControl("Label14")
            Dim lbl_C_Per As Label = dlist_info.Items(0).FindControl("lbl_C_Per")
            Dim l8 As Label = dlist_info.Items(0).FindControl("Label16")
            Dim lbl_phone As Label = dlist_info.Items(0).FindControl("lbl_phone")
            Dim com_ID As HiddenField = dlist_info.Items(0).FindControl("HF_Company_ID")
            'LBL_FC_Company.Text = LabelCompany.Text
            l1.Visible = True
            SiteLabel.Visible = True
            'TXT_Delivery_Site.Text = SiteLabel.Text
            l3.Visible = True
            Lbl_D_Add.Visible = True
            'TXT_Delivery_Add.Text = Lbl_D_Add.Text
            l5.Visible = True
            l6.Visible = True
            lbl_C_Per.Visible = True
            'txt_delivery_C_Person.Text = lbl_C_Per.Text
            l8.Visible = True
            lbl_phone.Visible = True
            'txt_delivery_ph_no.Text = lbl_phone.Text
            'PNL_ForCustomer.Visible = True

        End If

    End Sub
    Protected Sub imgBtnDetail_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim pk_id As ImageButton = sender
        sdsSerialsDetail.SelectParameters("PK_ID").DefaultValue = pk_id.CommandArgument
        gvSerialsDetail.DataBind()
        gvSerialsDetail.Visible = True
    End Sub
End Class
