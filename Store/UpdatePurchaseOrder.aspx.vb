Imports System.Data.SqlClient
Imports System.Data

Partial Class Store_UpdatePurchaseOrder
    Inherits System.Web.UI.Page
    Dim Store_constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If GridView1.Rows.Count <> 0 Then
            GridView1.HeaderRow.Cells(1).Visible = False
            'GridView1.HeaderRow.Cells(7).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(1).Visible = False
                'GridView1.Rows(i).Cells(7).Visible = False
            Next
        End If

    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Approve" Then
            Dim POID As String = GridView1.Rows(e.CommandArgument).Cells(1).Text
            HiddenFieldPO_ID.Value = POID
            HiddenField_FAC.Value = 1
            'UpdateStoreItemTagNo(POID)
            SqlDataSourceUpdatePurchaseOrder.Update()
            'SqlDataSource_PurchaseOrderDiscount.Update()
            'SqlDataSourceUpdatePurchaseOrder.Insert()

            GridView1.DataBind()
        ElseIf e.CommandName = "Reject" Then
            Dim POID As String = GridView1.Rows(e.CommandArgument).Cells(1).Text
            HiddenFieldPO_ID.Value = POID


            GridView1.DataBind()
        ElseIf e.CommandName = "Purchase" Then
            Dim POID As String = GridView1.Rows(e.CommandArgument).Cells(1).Text
            HiddenFieldPO_ID.Value = POID
            GridViewPurchaseDetail.Visible = True
            '   ImageButton1.Visible = True
            ' Panel1.Visible = True
            GridViewPurchaseDetail.DataBind()
        ElseIf e.CommandName = "Tender" Then
            Dim sb As New StringBuilder
            Dim t As Type = Me.GetType()
            Dim Tender_Id As String = CStr(GridView1.Rows(e.CommandArgument).Cells(7).Text)
            sb.Append("<script type='text/javascript' language='javascript'>window.open('Show_Bidding_Text.aspx?Tender_ID=" + Tender_Id + "&Identity_id=0','_blank');</script>")
            If Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp") Then
                ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
            End If
        End If
    End Sub
    Protected Sub UpdateStoreItemTagNo(ByVal POID As Integer)
        Dim con As New SqlConnection(Store_constr)
        Dim SP As String = "usp_Insert_Store_Item_TagNo"
        Dim command As New SqlCommand(SP, con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Emp_Id", Session("emp_id"))
        command.Parameters.AddWithValue("@PO_ID", POID)
        con.Open()
        command.ExecuteNonQuery()
        con.Close()
        con.Dispose()
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        ' Panel1.Visible = False
    End Sub

    Protected Sub GridViewPurchaseDetail_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewPurchaseDetail.SelectedIndexChanged

    End Sub

  
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GridView1.DataBind()
        End If
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click

    End Sub
    Protected Sub btnSave_Click(sender As Object, e As EventArgs)
        lblMsg.Visible = False
        If btnSave.Text = "Approve" Then
            HiddenField_FAC.Value = 1
            SqlDataSourceUpdatePurchaseOrder.UpdateParameters("Approval_Remarks").DefaultValue = "Approved"
            SqlDataSourceUpdatePurchaseOrder.UpdateParameters("Subject").DefaultValue = txtRemarks.Text
            SqlDataSourceUpdatePurchaseOrder.Update()
            lblMsg.Text = "Purchase Order approved successfully!!!!!"
            lblMsg.ForeColor = Drawing.Color.Green
            lblMsg.Visible = True
        End If
        If btnSave.Text = "Reject" Then
            If Not String.IsNullOrEmpty(txtRemarks.Text.Trim()) Then

                HiddenField_FAC.Value = 0
                SqlDataSourceUpdatePurchaseOrder.UpdateParameters("Approval_Remarks").DefaultValue = "Rejected"
                SqlDataSourceUpdatePurchaseOrder.UpdateParameters("Subject").DefaultValue = txtRemarks.Text
                SqlDataSourceUpdatePurchaseOrder.Update()
                lblMsg.Text = "Purchase Order is rejected!!!!!"
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Visible = True
            Else
                lblMsg.Text = "Enter remarks first !!!!!"
                lblMsg.ForeColor = Drawing.Color.Red
                lblMsg.Visible = True
            End If

        End If
        GridView1.DataBind()
    End Sub
    Protected Sub btnClose_Click(sender As Object, e As EventArgs)
        pnlRemarks.Visible = False
        txtRemarks.Text = ""
        lblMsg.Text = ""
    End Sub
    Protected Sub lnkApprove_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        HiddenFieldPO_ID.Value = lnk.CommandArgument
        lblPanelHeading.Text = "Approve Purchase Order"
        lblPONo.Text = lnk.CommandArgument
        pnlRemarks.Visible = True
        btnSave.Text = "Approve"
    End Sub
    Protected Sub lnkReject_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        HiddenFieldPO_ID.Value = lnk.CommandArgument
        lblPanelHeading.Text = "Reject Purchase Order"
        lblPONo.Text = lnk.CommandArgument
        pnlRemarks.Visible = True
        btnSave.Text = "Reject"
    End Sub
    Protected Sub lnkEditPO_Click(sender As Object, e As EventArgs)
        Response.Redirect("PurchaseOrder.aspx?PO_ID=" + HiddenFieldPO_ID.Value)
    End Sub
End Class
