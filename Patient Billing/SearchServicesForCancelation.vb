Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_SearchServicesForCancelation

    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Dim c As String = ""
    Dim co As New Coma
    Dim total_amount As Integer = 0


    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
          

        End If
    End Sub
  
    Private Sub FillGridView()
        Dim _strt As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(_strt)

        If True Then
            Dim command As SqlCommand = New SqlCommand("Search_cancel_Services", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@Regno", txtRegNo.Text.Trim())
            command.Parameters.AddWithValue("@YearlyNo", txtYearlyNo.Text.Trim())
            command.Parameters.AddWithValue("@MobileNo", txtMobileNo.Text.Trim())

            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            GridView_View_Payments.DataSource = dt
            GridView_View_Payments.DataBind()
        End If
    End Sub


    Protected Sub Btn_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Search.Click
        FillGridView()
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

                total_amount += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "S_Amount"))
                ' e.Row.Cells.Item(5).Text = co.place_Coma(e.Row.Cells.Item(5).Text)
                Dim dr As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
                If Not (dr("Status") = "Paid") Then
                    Dim lbtn_cancel As LinkButton = e.Row.FindControl("lbtn_cancel")
                    lbtn_cancel.Enabled = False
                End If
            ElseIf e.Row.RowType = DataControlRowType.Footer Then
                e.Row.Cells(4).Text = "Total Amount:"
                'e.Row.Cells(5).Text = co.place_Coma(total_amount)
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
            FillGridView()

        Catch ex As Exception
        End Try
    End Sub
    Protected Sub GridView_View_Payments_PageIndexChanging(sender As Object, e As GridViewPageEventArgs)
        GridView_View_Payments.PageIndex = e.NewPageIndex
        BindGridView()
    End Sub

    Private Sub BindGridView()
        GridView_View_Payments.DataBind()
    End Sub

End Class
