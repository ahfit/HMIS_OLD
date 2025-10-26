
Imports System.Collections.Generic
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO


Partial Class Finance_Budget_BudgetHead_distribution
    Inherits System.Web.UI.Page



    <System.Web.Script.Services.ScriptMethod>
    <System.Web.Services.WebMethod>
    Public Shared Function SearchItems(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim items As List(Of String) = New List(Of String)()
        Dim conn As SqlConnection = New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand()
        cmd.CommandText = "Select S_Name from Admin_Services where S_Name like '%'+@Search+'%'"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()

        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("S_Name").ToString(), sdr("S_Name").ToString()))
        End While

        Return items
    End Function
    Protected Sub get_service_info()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "select S_ID, S_Amount from Admin_services where S_Name = '" + TextBox_Search_Service.Text.Trim() + "'"
        cmd.CommandType = CommandType.Text
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        If sdr.HasRows() Then
            While sdr.Read()
                HF_S_ID.Value = sdr.Item("S_ID").ToString()
                Txt_Rate.Text = sdr.Item("S_Amount").ToString()
            End While
        Else
            ClearField()
        End If
        conn.Close()

    End Sub
    Protected Sub calc()
        If String.IsNullOrEmpty(Txt_Rate.Text.Trim()) Then
            Txt_Rate.Text = "0"
        Else
            txt_Rate.Text = txt_Rate.Text.Trim()
        End If
        If String.IsNullOrEmpty(Txt_Qty.Text.Trim()) Then
            Txt_Qty.Text = "1"
        Else
            Txt_Qty.Text = Txt_Qty.Text.Trim()
        End If

        lbl_Total_value.Text = Txt_Rate.Text * Txt_Qty.Text
    End Sub

    Private Sub SaveRecord()
        Try
            Dim conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
            Dim cmd As New SqlCommand()
            Dim Statement As String = "insert_Budget_head_Detail"
            cmd.CommandText = Statement
            cmd.Parameters.AddWithValue("@B_ID", Request.QueryString("B_ID"))
            cmd.Parameters.AddWithValue("@E_Code", Request.QueryString("E_Code"))
            cmd.Parameters.AddWithValue("@Services_name", TextBox_Search_Service.Text.Trim())
            cmd.Parameters.AddWithValue("@S_ID", HF_S_ID.Value)
            cmd.Parameters.AddWithValue("@Qty", Txt_Qty.Text)
            cmd.Parameters.AddWithValue("@Rate", Txt_Rate.Text)
            cmd.Parameters.AddWithValue("@emp_ID", Session("emp_ID"))
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Private Sub ClearField()
        HF_S_ID.Value = String.Empty
        Txt_Qty.Text = String.Empty
        Txt_Rate.Text = String.Empty
        lbl_Total_value.Text = String.Empty

    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            gv_detail.DataBind()
        End If
    End Sub
    Protected Sub TextBox_Search_Service_TextChanged(sender As Object, e As EventArgs)
        If Not String.IsNullOrEmpty(TextBox_Search_Service.Text.Trim()) Then
            get_service_info()
            calc()
        Else
            ClearField()

        End If

    End Sub
    Protected Sub TextBox_Qty_TextChanged(sender As Object, e As EventArgs) Handles Txt_Qty.TextChanged
        calc()
    End Sub
    Protected Sub Txt_Rate_TextChanged(sender As Object, e As EventArgs) Handles Txt_Rate.TextChanged
        calc()
    End Sub
    Protected Sub Btn_Add_Click(sender As Object, e As EventArgs) Handles Btn_add.Click
        SaveRecord()
        gv_detail.DataBind()

    End Sub


    Protected Sub gv_detail_PreRender(sender As Object, e As EventArgs) Handles gv_detail.PreRender
        Dim Total As Double = 0
        Dim lbltotal As New Label
        If gv_detail.Rows.Count > 0 Then
            For Each row As GridViewRow In gv_detail.Rows
                lbltotal = row.FindControl("lbl_total")
                Total = Total + Convert.ToDouble(lbltotal.Text)
            Next

            lbl_Month_Total.Text = Total.ToString("##,##")
        Else
            lbl_Month_Total.Text = String.Empty
        End If


    End Sub

    Protected Sub btn_clr_Click(sender As Object, e As EventArgs) Handles btn_clr.Click
        ClearField()
    End Sub
    Protected Sub btn_rtn_Click(sender As Object, e As EventArgs) Handles btn_rtn.Click

        Dim B_ID As String = ""
        If Not String.IsNullOrEmpty(Request.QueryString("B_ID")) Then
            B_ID = Request.QueryString("B_ID").ToString()
        End If
        Dim E_date As String = ""
        If Not String.IsNullOrEmpty(Request.QueryString("B_ID")) Then
            E_date = Request.QueryString("Date_End").ToString()
        End If
        Dim url As String = "budget_detail.aspx?B_ID=" + B_ID + "&Date_End=" + E_date
        Response.Redirect(url)

    End Sub
    Protected Sub btn_finalized_Click(sender As Object, e As EventArgs) Handles btn_finalized.Click
        Try
            Dim conn As New SqlConnection()
            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
            Dim cmd As New SqlCommand()
            Dim Statement As String = "insertEstimateBudgetApprove"
            cmd.CommandText = Statement
            cmd.Parameters.AddWithValue("@B_ID", Request.QueryString("B_ID"))
            cmd.Parameters.AddWithValue("@E_code", Request.QueryString("E_code"))
            cmd.Parameters.AddWithValue("@Amount", CDbl(lbl_Month_Total.Text.Trim().Replace(",", "")))
            cmd.Parameters.AddWithValue("@emp_ID", Session("emp_ID"))
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Connection = conn
            conn.Open()
            cmd.ExecuteNonQuery()
            conn.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
