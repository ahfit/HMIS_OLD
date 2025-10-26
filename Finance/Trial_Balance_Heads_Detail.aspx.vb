Imports System.Data
Imports System.Data.SqlClient
Imports System.IO

Partial Class audit_GeneralLedger
    Inherits System.Web.UI.Page

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
        'mycommand.Parameters.AddWithValue("@SDate", Session("SDate"))
        'mycommand.Parameters.AddWithValue("@E_Code", Request.QueryString("E_Code"))

        ''declare output parameter
        'mycommand.Parameters.Add("@Obalance", Data.SqlDbType.Int)
        'mycommand.Parameters("@Obalance").Direction = Data.ParameterDirection.Output

        ''Connection opened
        'con.open()
        ''Execute command
        'mycommand.ExecuteNonQuery()

        'Return values
        oBalacne = 0 'Convert.ToInt64(mycommand.Parameters("@Obalance").Value.ToString)

        If (oBalacne < 0) Then
            lbl_Cr.Visible = True
            lblOBCr.Visible = True
            lblOBCr.Text = oBalacne * -1
            lblOBCr.ForeColor = Drawing.Color.Red
            Session.Add("OpB", lblOBCr.Text)
            Session.Add("OpDC", 2)
        ElseIf (oBalacne > 0) Then
            lblOBDr.Visible = True
            lbl_Dr.Visible = True
            lblOBDr.Text = oBalacne
            lblOBDr.ForeColor = Drawing.Color.Green
            Session.Add("OpB", lblOBDr.Text)
            Session.Add("OpDC", 1)
        Else
            lblOBDr.Text = oBalacne
            lblOBCr.Text = oBalacne
            Session.Add("OpB", lblOBDr.Text)
            Session.Add("OpDC", 0)


            Label1.Visible = False
            lblOBDr.Visible = False
            lbl_Cr.Visible = False
            lbl_Dr.Visible = False
            lblOBCr.Visible = False
        End If




    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender

        setGridBalance(GridView1)

    End Sub

    Private Sub setGridBalance(GV As GridView)
        Dim Drbal As Decimal = 0, Crbal As Decimal = 0, DifBal As Decimal = 0

        If GV.Rows.Count <> 0 Then


            For Each row As GridViewRow In GV.Rows
                Dim labelDr As New Label
                Dim labelCr As New Label
                Dim labelBl As New Label
                labelDr = row.FindControl("LabelDr")
                labelCr = row.FindControl("LabelCr")
                labelBl = row.FindControl("lblbal")

                Drbal = Drbal + ValidateText(labelDr.Text.Trim())
                Crbal = Crbal + ValidateText(labelCr.Text.Trim())
                DifBal = Drbal - Crbal

                labelBl.Text = DisplayNumber(DifBal)
            Next

            Using Frow As GridViewRow = GV.FooterRow
                Dim lblDr As Label = Frow.FindControl("lblDr")
                Dim lblCr As Label = Frow.FindControl("lblCr")
                Dim lblBal As Label = Frow.FindControl("lblTBal")
                lblCr.Text = DisplayNumber(Crbal)
                lblDr.Text = DisplayNumber(Drbal)
                lblBal.Text = DisplayNumber(Drbal - Crbal)
            End Using


        End If
    End Sub

    Private Function DisplayNumber(Amount As Decimal) As String
        Dim Result As String = "-"
        Select Case Amount
            Case Is < 0
                Result = "(" + (Amount * (-1)).ToString("##,##") + ")"
            Case Is > 0
                Result = Amount.ToString("##,##")
        End Select
        Return Result
    End Function

    Private Function ValidateText(Amount As String) As Decimal
        Dim Result As Decimal = 0
        If Not String.IsNullOrEmpty(Amount) Then
            If Left(Amount, 1) = "(" Then
                Amount = Amount.Replace("(", "").Replace(")", "")
                Result = Amount * (-1)
            Else
                Result = Amount
            End If
        End If
        Return Result
    End Function


    Protected Sub Btn_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Print.Click

        Session.Add("ECode", Request.QueryString("E_Code"))
        If lblOBDr.Visible = True Then
            Session.Add("OpB", lblOBDr.Text)
            Session.Add("OpDC", 1)

        ElseIf lblOBCr.Visible = True Then
            Session.Add("OpB", lblOBCr.Text)
            Session.Add("OpDC", 2)
        ElseIf lblOBDr.Visible = False And lblOBCr.Visible = False Then
            Session.Add("OpB", 0)
            Session.Add("OpDC", 0)
        End If


        Session.Add("LT", "EL")
        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open('rptGeneralLedgerExpenditure.aspx')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        'WebDateChooserEDate.Value = Session("Edate")
        'WebDateChooserSdate.Value = Session("Sdate")

        'HiddenFieldEdate.Value = WebDateChooserEDate.Value
        'HiddenFieldSdate.Value = WebDateChooserSdate.Value
        Dim sdate As String = ""
        Dim edate As String = ""
        If Not IsPostBack() Then
            LoadDate(HiddenFieldEdate, Session("Edate"), Request.QueryString("EDate"), "E")
            LoadDate(HiddenFieldSdate, Session("Sdate"), Request.QueryString("Sdate"), "S")
            'HiddenFieldEdate.Value = Session("Edate")
            'HiddenFieldSdate.Value = Session("Sdate")
            loadhead()
            DDL_Party.DataBind()
            GridView1.DataBind()
            GridView1.Visible = True
            If GridView1.Rows.Count <> 0 Then
                'setopeningBalance()
                If oBalacne <> 0 Then
                    Label1.Visible = True
                Else
                    Label1.Visible = False
                End If

                'lblOBDr.Visible = True
                Btn_Print.Visible = True
                btnEExcel.Visible = True
            Else
                Label1.Visible = False
                lblOBDr.Visible = False
                lbl_Cr.Visible = False
                lbl_Dr.Visible = False
                lblOBCr.Visible = False
            End If


        End If
    End Sub

    Private Sub LoadDate(ByRef hF As HiddenField, Session As Object, QueryStr As String, Type As String)
        If String.IsNullOrEmpty(QueryStr) Then
            If Not String.IsNullOrEmpty(Session) Then
                hF.Value = Convert.ToDateTime(Session).ToString("yyyy-MM-dd")
            Else
                If Type = "S" Then
                    hF.Value = Date.Now.AddYears(-5).ToString("yyyy-MM-dd")
                Else
                    hF.Value = Date.Now.ToString("yyyy-MM-dd")
                End If

            End If
        Else
            hF.Value = Convert.ToDateTime(QueryStr).ToString("yyyy-MM-dd")
        End If

    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Session.Add("VTI", GridView1.SelectedValue)
        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open('CReport_Recipt_Voucher.aspx')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If
    End Sub

    Protected Sub btnEExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEExcel.Click
        Dim Drbal As Integer = lblOBDr.Text
        Dim Crbal As Integer = lblOBCr.Text
        If GridView1.Rows.Count <> 0 Then
            'Lbl_mg.Visible = False
            Try
                Dim form As New HtmlForm()
                Response.Clear()
                Response.Buffer = True
                Response.Charset = ""
                Response.AddHeader("content-disposition", String.Format("attachment;filename={0}", "HeadsDetailLeadger" & Date.Now.ToShortDateString() & ".xls"))
                Response.ContentType = "application/ms-excel"
                Dim sw As New StringWriter()
                Dim hw As New HtmlTextWriter(sw)
                GridView1.AllowPaging = False
                GridView1.Columns(11).Visible = False
                GridView1.DataBind()
                setGridBalance(GridView1)
                form.Attributes("runat") = "server"
                form.Controls.Add(GridView1)
                Me.Controls.Add(form)
                form.RenderControl(hw)
                Dim style As String = "<!--mce:2-->"
                Response.Write(style)
                Response.Output.Write(sw.ToString())
                Response.Flush()
                Response.[End]()

            Catch ex As Exception

            End Try
        Else
            'Lbl_mg.Text = "There is no data to export."
            'Lbl_mg.Visible = True
        End If
    End Sub
    Protected Sub loadhead()

        Dim constring As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)


        'Enter procedure name
        Dim Procedurename As String = "select E_name from Finance.dbo.Expenditure where E_Code =@E_Code"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename
        mycommand.Parameters.AddWithValue("@E_Code", Request.QueryString("E_Code"))


        'Connection opened
        con.Open()
        'Execute command
        lbl_head_name.Text = mycommand.ExecuteScalar()

        con.Close()
        lbl_dates.Text = CDate(HiddenFieldSdate.Value).ToString("dd/MM/yyyy") + " - " + CDate(HiddenFieldEdate.Value).ToString("dd/MM/yyyy")
    End Sub


    Protected Sub DDL_Party_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DDL_Party.SelectedIndexChanged
        GridView1.DataBind()
    End Sub
End Class
