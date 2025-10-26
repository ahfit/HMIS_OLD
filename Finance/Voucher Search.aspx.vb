Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web
Imports Microsoft.Reporting.WebForms


Partial Class Finace_GeneralLedger
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        HiddenFieldEdate.Value = CStr(CDate(WebDateChooserEDate.Value).Year) + Right(("00" + CStr(CDate(WebDateChooserEDate.Value).Month)), 2) + Right("00" + CStr(CDate(WebDateChooserEDate.Value).Day), 2)
        HiddenFieldSdate.Value = CStr(CDate(WebDateChooserSdate.Value).Year) + Right(("00" + CStr(CDate(WebDateChooserSdate.Value).Month)), 2) + Right("00" + CStr(CDate(WebDateChooserSdate.Value).Day), 2)
        GridView1.DataBind()
        GridView1.Visible = True
        If DDLVoucher.SelectedValue = 0 Then
            btnPost.Visible = True
            btnUnpost.Visible = False
          
        ElseIf DDLVoucher.SelectedValue = 1 Then
            btnUnpost.Visible = True
            btnPost.Visible = False
        ElseIf DDLVoucher.SelectedValue = 2 Then
            btnPost.Visible = False
            btnUnpost.Visible = False
        End If

        '  Response.Write(HiddenFieldSdate.Value + "    " + HiddenFieldSdate.Value)
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim Drbal As Long = 0
        Dim Crbal As Long = 0
        Dim lblTemp As Label = Nothing


        If GridView1.Rows.Count <> 0 Then
            Dim count As Integer = 0
            For i As Integer = 0 To GridView1.Rows.Count - 1
                'GridView1.Rows(i).Cells(5).Visible = False
                Dim Label_Sr_No As Label = GridView1.Rows(i).FindControl("Label_Sr_No")
                count = count + 1
                Label_Sr_No.Text = count

                lblTemp = CType(GridView1.Rows(i).FindControl("lblDescription"), Label)
                If Not lblTemp Is Nothing AndAlso lblTemp.Text.Length > 40 Then
                    lblTemp.ToolTip = lblTemp.Text
                    lblTemp.Text = lblTemp.Text.Substring(0, 40) + "...."
                End If

                lblTemp = CType(GridView1.Rows(i).FindControl("lblParty"), Label)
                If Not lblTemp Is Nothing AndAlso lblTemp.Text.Length > 40 Then
                    lblTemp.ToolTip = lblTemp.Text
                    lblTemp.Text = lblTemp.Text.Substring(0, 40) + "...."
                End If
            Next
            'GridView1.HeaderRow.Cells(5).Visible = False
            For Each row As GridViewRow In GridView1.Rows
                Dim HfCr As HiddenField = row.FindControl("Cr")
                Dim HFDr As HiddenField = row.FindControl("Dr")
                If String.IsNullOrEmpty(HFDr.Value) Then
                    HFDr.Value = "0"
                End If
                Drbal += CLng(HFDr.Value)
                If String.IsNullOrEmpty(HfCr.Value) Then
                    HfCr.Value = "0"
                End If
                Crbal += CLng(HfCr.Value)
            Next
            GridView1.FooterRow.Cells(10).Text = Crbal.ToString("#,#")
            GridView1.FooterRow.Cells(11).Text = Drbal.ToString("#,#")
            GridView1.FooterRow.Cells(10).CssClass = "AmountAlign"
            GridView1.FooterRow.Cells(11).CssClass = "AmountAlign"
            GridView1.FooterRow.Cells(8).Text = "Total :"

        End If
        

    End Sub

    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        GridView1.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("Branch_Access") = 1 Then
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
            DropDownList_Companyname.Enabled = False
            DropDownList_Branchname.Enabled = False

        End If
        If Not Page.IsPostBack Then



            WebDateChooserSdate.Value = DateAdd(DateInterval.Day, -1, Date.Now)
            WebDateChooserEDate.Value = DateAdd(DateInterval.Day, 1, Date.Now)

        End If



        'Session.Add("ECode", DropDownList1.SelectedValue)
        'Session.Add("Sdate", WebDateChooserSdate.Value)
        'Session.Add("Edate", WebDateChooserEDate.Value)

        'Session.Add("LT", "PL")
        'Dim sb As New StringBuilder
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('rptGeneralLedgerExpenditure.aspx')</script>")
        'Dim t As Type = Me.GetType()
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        'End If
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged

        Session.Add("VTI", GridView1.SelectedValue)
        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open('CReport_Recipt_Voucher.aspx')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If
        'Session.Remove("VTI")
    End Sub

    Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click

        Session("SDate") = HiddenFieldSdate.Value
        Session("EDate") = HiddenFieldEdate.Value
        'Request.QueryString("EDate") = HiddenFieldEdate.Value
        Session("Financial_Company_Id") = DropDownList_Companyname.SelectedValue
        Session("Company_Branch_Id") = DropDownList_Branchname.SelectedValue
        Session("PartyId") = ddlParty.SelectedValue
        Session("voucherNo") = txtVoucherNo.Text

        Response.Redirect("~/Finance/Voucher_Search_Report.aspx")
        'Dim sb As New StringBuilder
        'HiddenFieldEdate.Value = WebDateChooserEDate.Text
        'HiddenFieldSdate.Value = WebDateChooserSdate.Text
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('Print_Voucher_Search.aspx?StartDate=" + HiddenFieldSdate.Value + "&EndDate=" + HiddenFieldEdate.Value + "');</script>")
        'Dim t As Type = Me.GetType
        'If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
        '    ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        'End If
    End Sub
    Protected Sub select_Dropdowns(ByVal dept As Integer, ByVal subdep As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("StoreConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT Financial_Company_Id, Company_Branch_Id FROM SubDepartment WHERE (SubDept_Id = @SubDept_Id) AND (Dept_Id = @Dept_Id)", con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Parameters.AddWithValue("@Dept_Id", dept)
        mycommand.Parameters.AddWithValue("@SubDept_Id", subdep)
        con.Open()
        Dim reader As SqlDataReader = mycommand.ExecuteReader
        While (reader.Read())
            DropDownList_Companyname.SelectedValue = reader("Financial_Company_Id").ToString
            DropDownList_Branchname.SelectedValue = reader("Company_Branch_Id").ToString
        End While
    End Sub

    Protected Sub lnkEditVoucherDetail_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim linkTemp As LinkButton = CType(sender, LinkButton)
        Response.Redirect("~/Finance/Edit_Voucher_Detail.aspx?Voucher_Trans_Id=" + linkTemp.CommandArgument)
    End Sub
    
    Protected Sub chkApprovedAll_CheckedChanged(sender As Object, e As EventArgs)
        Dim ck As CheckBox = DirectCast(TryCast(sender, Control), CheckBox)

        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            chinner.Checked = ck.Checked
        Next
    End Sub

    Protected Sub btnPost_Click(sender As Object, e As EventArgs)
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            If chinner.Checked = True Then
                Dim constring As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("Update Receipt_Disbursement_AccountHeads set Approval_Status='true' where Voucher_Trans_Id=@vid", con)
                mycommand.CommandType = Data.CommandType.Text
                mycommand.Parameters.AddWithValue("@vid", chinner.ToolTip)
                con.Open()
                mycommand.ExecuteNonQuery()
                con.Close()

            End If
        Next

       
    End Sub

    Protected Sub btnUnpost_Click(sender As Object, e As EventArgs)
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chinner As CheckBox = DirectCast(GridView1.Rows(i).FindControl("chkBoxSelect"), CheckBox)
            If chinner.Checked = True Then
                Dim constring As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("Update Receipt_Disbursement_AccountHeads set Approval_Status='false' where Voucher_Trans_Id=@vid", con)
                mycommand.CommandType = Data.CommandType.Text
                mycommand.Parameters.AddWithValue("@vid", chinner.ToolTip)
                con.Open()
                mycommand.ExecuteNonQuery()
                con.Close()

            End If
        Next

    End Sub
    Protected Sub lnkAttachment_Click(sender As Object, e As EventArgs)

    End Sub
End Class
