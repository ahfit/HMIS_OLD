Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.IO
Partial Class audit_GeneralLedger
    Inherits System.Web.UI.Page

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            If Not Convert.ToString(Session("Company_Branch_ID")) = "1" Or Convert.ToString(Session("Company_Branch_ID")) = "5" Then

               
            End If
            HiddenFieldEdate.Value = WebDateChooserEDate.Value
            HiddenFieldSdate.Value = WebDateChooserSdate.Value
            GridView1.DataBind()
            GridView1.Visible = True
            If GridView1.Rows.Count <> 0 Then
                ' setopeningBalance()
                'If oBalacne <> 0 Then
                '    Label1.Visible = True
                'Else
                '    Label1.Visible = False
                'End If

                'lblOBDr.Visible = True
                Btn_Print.Visible = True
                'Else
                '    Label1.Visible = False
                '    lblOBDr.Visible = False
                '    'lbl_Cr.Visible = False
                '    'lbl_Dr.Visible = False
                '    '  lblOBCr.Visible = False
            End If
        Catch ex As Exception

        End Try


    End Sub

    Dim oBalacne As Long
    Sub setopeningBalance()

        'Dim constring As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
        'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)


        ''Enter procedure name
        'Dim Procedurename As String = "LedgerOpeningBalance"
        'Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        'mycommand.CommandType = Data.CommandType.StoredProcedure
        'mycommand.CommandText = Procedurename
        ''Declar User Name and password as input parameter
        'mycommand.Parameters.AddWithValue("@SDate", WebDateChooserSdate.Value)
        'mycommand.Parameters.AddWithValue("@E_Code", hfPaymentToId.Value)

        ''declare output parameter
        'mycommand.Parameters.Add("@Obalance", Data.SqlDbType.Int)
        'mycommand.Parameters("@Obalance").Direction = Data.ParameterDirection.Output

        ''Connection opened
        'con.Open()
        ''Execute command
        'mycommand.ExecuteNonQuery()

        ''Return values
        'oBalacne = Convert.ToInt64(mycommand.Parameters("@Obalance").Value.ToString)

        'If (oBalacne < 0) Then
        '    lbl_Cr.Visible = True
        '    lblOBCr.Visible = True
        '    lblOBCr.Text = oBalacne * -1
        '    lblOBCr.ForeColor = Drawing.Color.Red
        '    Session.Add("OpB", lblOBCr.Text)
        '    Session.Add("OpDC", 2)
        'ElseIf (oBalacne > 0) Then
        '    lblOBDr.Visible = True
        '    lbl_Dr.Visible = True
        '    lblOBDr.Text = oBalacne
        '    lblOBDr.ForeColor = Drawing.Color.Green
        '    Session.Add("OpB", lblOBDr.Text)
        '    Session.Add("OpDC", 1)
        'Else
        '    lblOBDr.Text = oBalacne
        '    lblOBCr.Text = oBalacne
        '    Session.Add("OpB", lblOBDr.Text)
        '    Session.Add("OpDC", 0)


        '    Label1.Visible = False
        '    lblOBDr.Visible = False
        '    lbl_Cr.Visible = False
        '    lbl_Dr.Visible = False
        '    lblOBCr.Visible = False
        'End If




    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Dim Drbal As Integer = 0 'lblOBDr.Text
        Dim Crbal As Integer = 0 'lblOBCr.Text
        'Dim Drbal As Integer = 0
        'Dim Crbal As Integer = 0
        If GridView1.Rows.Count <> 0 Then


            For i As Integer = 0 To GridView1.Rows.Count - 1

                ' If CInt(GridView1.Rows(i).Cells(4).Text) <> 0 Then
                Dim labelDr As Label = GridView1.Rows(i).FindControl("LabelDr")
                Dim labelCr As Label = GridView1.Rows(i).FindControl("LabelCr")
                If labelDr.Text.Trim().Length > 0 Then
                    Drbal = Drbal + labelDr.Text
                End If
                ' End If
                'If CInt(GridView1.Rows(i).Cells(5).Text) <> 0 Then
                If labelCr.Text.Trim().Length > 0 Then
                    Crbal = Crbal + labelCr.Text
                End If
                ' End If

                Dim lbl As Label = GridView1.Rows(i).FindControl("lblbal")

                If Drbal - Crbal < 0 Then
                    lbl.Text = "( " + ((Drbal - Crbal) * -1).ToString("#,#") + " )"
                Else
                    lbl.Text = (Drbal - Crbal).ToString("#,#")
                End If
                'GridView1.Rows(i).Cells(1).Visible = False
                'GridView1.Rows(i).Cells(2).Visible = False
                'GridView1.Rows(i).Cells(3).Visible = False
            Next
            'GridView1.HeaderRow.Cells(1).Visible = False
            'GridView1.HeaderRow.Cells(2).Visible = False
            'GridView1.HeaderRow.Cells(3).Visible = False

            'GridView1.FooterRow.Cells(1).Visible = False
            'GridView1.FooterRow.Cells(2).Visible = False
            'GridView1.FooterRow.Cells(3).Visible = False

            Dim lblDr As Label = GridView1.FooterRow.FindControl("lblDr")
            Dim lblCr As Label = GridView1.FooterRow.FindControl("lblCr")
            lblCr.Text = Crbal.ToString("#,#")
            lblDr.Text = Drbal.ToString("#,#")

            lblCr.Text = Crbal
            lblDr.Text = Drbal



        End If
    End Sub

    Protected Sub Btn_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Print.Click

        'Session.Add("ECode", DropDownList1.SelectedValue)
        'Session.Add("Sdate", WebDateChooserSdate.Value)
        'Session.Add("Edate", WebDateChooserEDate.Value)
        'Session.Add("finCompId", DropDownList_Companyname.SelectedValue)
        'Session.Add("compBranchId", DropDownList_Branchname.SelectedValue)
        'Session("PartyID") = "0"
        ''Session.Add("OpB", lblOBDr.Text)
        'Session.Add("LT", "EL")
        'Dim sb As New StringBuilder
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('rptGeneralLedgerExpenditure.aspx')</script>")
        'Dim t As Type = Me.GetType()
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        'End If
        'GridView1.AllowPaging = False
        GridView1.Columns(10).Visible = False
        'GridView1.DataBind()
        Dim sw As New StringWriter()
        Dim hw As New HtmlTextWriter(sw)

        GridView1.RenderControl(hw)
        Dim gridHTML As String = sw.ToString().Replace("""", "'").Replace(System.Environment.NewLine, "")
        Dim sb As New StringBuilder()
        sb.Append("<script type = 'text/javascript'>")
        sb.Append("window.onload = new function(){")
        sb.Append("var printWin = window.open('', '', 'left=0")
        sb.Append(",top=0,width=1000,height=1000,status=0');")
        sb.Append("printWin.document.write(""")
        sb.Append(gridHTML)
        sb.Append(""");")
        sb.Append("printWin.document.close();")
        sb.Append("printWin.focus();")
        sb.Append("printWin.print();")
        sb.Append("printWin.close();};")
        sb.Append("</script>")
        ClientScript.RegisterStartupScript(Me.[GetType](), "GridPrint", sb.ToString())
        'GridView1.AllowPaging = True
        GridView1.DataBind()
        GridView1.Columns(10).Visible = True

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("Branch_Access") = 1 Then
            DropDownList_Companyname.DataBind()
            DropDownList_Companyname.SelectedValue = Session("Financial_Company_Id")
            DropDownList_Branchname.SelectedValue = Session("Company_Branch_Id")
            DDL_Other_Currency.DataBind()
            DDL_Other_Currency.SelectedItem.Text = "PKR"
            DropDownList_Companyname.Enabled = False
            DropDownList_Branchname.Enabled = False

        End If
        If Not IsPostBack() Then

            WebDateChooserSdate.Value = DateAdd(DateInterval.Day, -1, Date.Now)
            WebDateChooserEDate.Value = DateAdd(DateInterval.Day, 1, Date.Now)
        End If
    End Sub
    Public Overloads Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        ' Verifies that the control is rendered
    End Sub
    Public Sub ShowErrorMessage(ByVal pnl As Panel, ByVal lbl As Label, ByVal msg As String)
        pnl.CssClass = "errorMsg"
        lbl.Text = msg
    End Sub

    Public Sub ShowSuccessMessage(ByVal pnl As Panel, ByVal lbl As Label, ByVal msg As String)
        pnl.CssClass = "successMsg"
        lbl.Text = msg
    End Sub



    Protected Sub GridView1_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Session.Add("VTI", GridView1.SelectedValue)
        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open('CReport_Recipt_Voucher.aspx')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If
    End Sub


    <System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()> _
    Public Shared Function SearchHead(prefixText As String, count As Integer) As List(Of String)
        Dim Heads As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SELECT [E_Code], [E_Name], [ESH_Code] FROM [Expenditure] WHERE ([E_Name] LIKE '%' + @Search + '%')"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            Heads.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("E_Name").ToString(), sdr("E_Code").ToString()))
        End While
        Return Heads
    End Function

    Protected Sub btn_export_Click(sender As Object, e As EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "General Ledger Head Sheet" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        'repAllCustomers.Columns(0).Visible = false;
        'repAllCustomers.Columns(1).Visible = false;
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub
End Class
