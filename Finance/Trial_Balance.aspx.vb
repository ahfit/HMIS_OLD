Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.IO

Imports System.Diagnostics.CodeAnalysis
Imports System.Drawing


Partial Class Finance_Trial_Balance
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Load_FinancialYear(StartDate_Search, EndDate_Search)
        End If
    End Sub
    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub
    Protected Sub Show_Report()
        Try
            sdsTrialBalance.SelectParameters("Start_Date").DefaultValue = StartDate_Search.Text.ToString()
            sdsTrialBalance.SelectParameters("End_Date").DefaultValue = EndDate_Search.Text.ToString()
            Dim dv As DataView = sdsTrialBalance.Select(DataSourceSelectArguments.Empty)
            Dim dt As DataTable = dv.Table
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repParams As ReportParameter() = New ReportParameter(1) {}
            repParams(0) = New ReportParameter("SDate", StartDate_Search.Text.ToString())
            repParams(1) = New ReportParameter("EDate", EndDate_Search.Text.ToString())


            'Dim reportPath As String = Server.MapPath("~/Finance/Trial_Balance_Report1.rdlc")
            Dim reportPath As String = Server.MapPath("~/Finance/Trial_Balance_ReportMonthly.rdlc")
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.SetParameters(repParams)
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dt))
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.Refresh()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub Load_Trail_Balance(ByVal Financial_Year As String)
        Try


            'Dim ds As New Finance
            'Dim da As New FinanceTableAdapters.Trial_BalanceTableAdapter

            'da.Fill(ds.Tables("Trial_Balance"), StartDate_Search.text.ToString(), EndDate_Search.text.ToString(), DropDownList_Companyname.SelectedValue, DropDownList_Branchname.SelectedValue)
            Dim connection1 As [String] = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ToString()
            Dim con As New SqlConnection(connection1)
            con.Open()
            Dim command As [String] = "usp_Trial_Balance"
            Dim cmd As New SqlCommand(command, con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@Start_Date", StartDate_Search.text.ToString())
            cmd.Parameters.AddWithValue("@vouchertype", DDLVoucher.SelectedValue)
            cmd.Parameters.AddWithValue("@End_Date", EndDate_Search.text.ToString())
            cmd.Parameters.AddWithValue("@Financial_Company_Id", DropDownList_Companyname.SelectedValue)

            cmd.Parameters.AddWithValue("@Company_Branch_Id", DropDownList_Branchname.SelectedValue)
            cmd.Parameters.AddWithValue("@CCID", DropDownList_CostCentre.SelectedValue)
            Dim ds As New DataSet
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            da.Fill(ds, "Trial_Balance")


            If ds.Tables("Trial_Balance").Rows.Count <> 0 Then

                Dim main_heading As String = ds.Tables("Trial_Balance").Rows(0).Item("EM_Name").ToString()
                Dim EH_Name As String = ds.Tables("Trial_Balance").Rows(0).Item("EH_Name").ToString()
                Dim ESH_Name As String = ds.Tables("Trial_Balance").Rows(0).Item("ESH_Name").ToString()

                If ds.Tables("Trial_Balance").Rows(0).Item("Dr") - ds.Tables("Trial_Balance").Rows(0).Item("Cr") < 0 Then
                    ' ds.Tables("Trial_Balance").Rows(0).Item("Balance") = "( " + Convert.ToString(-1 * (ds.Tables("Trial_Balance").Rows(0).Item("Dr") - ds.Tables("Trial_Balance").Rows(0).Item("Cr"))) + " )"
                Else
                    ' ds.Tables("Trial_Balance").Rows(0).Item("Balance") = ds.Tables("Trial_Balance").Rows(0).Item("Dr") - ds.Tables("Trial_Balance").Rows(0).Item("Cr")
                End If

                For i As Integer = 1 To ds.Tables("Trial_Balance").Rows.Count - 1
                    If main_heading = ds.Tables("Trial_Balance").Rows(i).Item("EM_Name").ToString() Then
                        ds.Tables("Trial_Balance").Rows(i).Item("EM_Name") = ""
                    Else
                        main_heading = ds.Tables("Trial_Balance").Rows(i).Item("EM_Name").ToString()
                    End If

                    If EH_Name = ds.Tables("Trial_Balance").Rows(i).Item("EH_Name").ToString() Then
                        ds.Tables("Trial_Balance").Rows(i).Item("EH_Name") = ""
                    Else
                        EH_Name = ds.Tables("Trial_Balance").Rows(i).Item("EH_Name").ToString()
                    End If

                    If ESH_Name = ds.Tables("Trial_Balance").Rows(i).Item("ESH_Name").ToString() Then
                        ds.Tables("Trial_Balance").Rows(i).Item("ESH_Name") = ""
                    Else
                        ESH_Name = ds.Tables("Trial_Balance").Rows(i).Item("ESH_Name").ToString()
                    End If

                    If ds.Tables("Trial_Balance").Rows(i).Item("Dr") - ds.Tables("Trial_Balance").Rows(i).Item("Cr") < 0 Then
                        'ds.Tables("Trial_Balance").Rows(i).Item("Balance") = "( " + Convert.ToString(-1 * (ds.Tables("Trial_Balance").Rows(i).Item("Dr") - ds.Tables("Trial_Balance").Rows(i).Item("Cr"))) + " )"
                    Else
                        'ds.Tables("Trial_Balance").Rows(i).Item("Balance") = ds.Tables("Trial_Balance").Rows(i).Item("Dr") - ds.Tables("Trial_Balance").Rows(i).Item("Cr")
                    End If

                Next

            End If

            GridView_Trial_Balance.DataSource = ds.Tables("Trial_Balance")
            'GridView_Trial_Balance.AutoGenerateColumns = True
            GridView_Trial_Balance.DataBind()
            'GridView_Trial_Balance.AllowPaging = True
            'GridView_Trial_Balance.PageSize = 50
        Catch ex As Exception
            Response.Write(ex)
        End Try
    End Sub


    Protected Sub GridView_Trial_Balance_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Trial_Balance.PreRender
        If GridView_Trial_Balance.Rows.Count <> 0 Then
            'GridView_Trial_Balance.HeaderRow.Cells(0).Text = "Level I"
            'GridView_Trial_Balance.HeaderRow.Cells(1).Text = "Level II"
            'GridView_Trial_Balance.HeaderRow.Cells(2).Text = "Level III"
            'GridView_Trial_Balance.HeaderRow.Cells(3).Text = "Level IV"
            'GridView_Trial_Balance.HeaderRow.Cells(4).Text = "Code"
            Dim sum_Dr As Double = 0
            Dim sum_Cr As Double = 0
            Dim Sum_Balace As Double = 0
            Dim drTemp As Double = 0
            Dim crTemp As Double = 0
            Dim BalaceTemp As Double = 0
            For i As Integer = 0 To GridView_Trial_Balance.Rows.Count - 1
                Dim dr As Label = GridView_Trial_Balance.Rows(i).FindControl("Label_Dr")
                Dim cr As Label = GridView_Trial_Balance.Rows(i).FindControl("Label_Cr")
                Dim Balance As Label = GridView_Trial_Balance.Rows(i).FindControl("Label_Balance")
                If dr.Text = "" Then
                    dr.Text = 0
                End If
                If cr.Text = "" Then
                    cr.Text = 0
                End If
                If Balance.Text = "" Then
                    Balance.Text = 0
                End If
                sum_Dr = sum_Dr + Convert.ToDouble(dr.Text)

                sum_Cr = sum_Cr + Convert.ToDouble(cr.Text)

                Sum_Balace = Sum_Balace + Convert.ToDouble(Balance.Text).ToString("c")

                drTemp = Convert.ToDouble(dr.Text)
                crTemp = Convert.ToDouble(cr.Text)
                BalaceTemp = Convert.ToDouble(Balance.Text)
                dr.Text = drTemp.ToString("#,##.##")
                cr.Text = crTemp.ToString("#,##.##")
                Balance.Text = BalaceTemp.ToString("#,##.##")
            Next
            Dim Label_Dr_Footer As Label = GridView_Trial_Balance.FooterRow.FindControl("Label_Dr_Footer")
            Dim Label_Cr_Footer As Label = GridView_Trial_Balance.FooterRow.FindControl("Label_Cr_Footer")
            Dim Label_Balance_Footer As Label = GridView_Trial_Balance.FooterRow.FindControl("Label_Balance_Footer")

            Label_Dr_Footer.Text = sum_Dr.ToString("#,##.##")
            Label_Cr_Footer.Text = sum_Cr.ToString("#,##.##")
            Label_Balance_Footer.Text = Sum_Balace.ToString("#,##.##")

        End If

    End Sub

    Protected Sub GridView_Trial_Balance_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Trial_Balance.SelectedIndexChanged

        'Response.Redirect("Trial_Balance_Heads_Detail.aspx?E_Code=" + GridView_Trial_Balance.SelectedValue)
        'Dim sb As New StringBuilder
        'sb.Append("<script language='javascript' type='text/javascript'>window.open('Trial_Balance_Heads_Detail.aspx?E_Code='" + GridView_Trial_Balance.SelectedValue + ")</script>")



        'Dim t As Type = Me.GetType()
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
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

    Protected Sub Button_search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_search.Click 'Handles Button_search.Click
        ReportViewer1.Visible = False
        GridView_Trial_Balance.Visible = True
        Load_Trail_Balance(DDL_Sel_Financial_Year.SelectedValue)
        Session.Add("Sdate", StartDate_Search.text.ToString())
        Session.Add("Edate", EndDate_Search.text.ToString())
        Session.Add("FCID", Convert.ToInt32(DropDownList_Companyname.SelectedValue))
        Session.Add("CBID", Convert.ToInt32(DropDownList_Branchname.SelectedValue))
        'Response.Write("S=" + Session("SDate") + " E=" + Session("EDate"))
    End Sub

    Protected Sub Button_search_Click1(ByVal sender As Object, ByVal e As System.EventArgs)

    End Sub

    Protected Sub lnkbtnControlAccount_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnkbtn As LinkButton = sender
        Dim grv As GridViewRow = lnkbtn.NamingContainer
        Dim hdfcontrolaccount As HiddenField = grv.FindControl("hdfcontrolaccountval")
        Dim hdfECode As HiddenField = grv.FindControl("hdfE_Code")
        Dim URL As String = String.Empty
        'If hdfcontrolaccount.Value = "C" Or hdfcontrolaccount.Value = "V" Or hdfcontrolaccount.Value = "E" Then
        '    URL = String.Format("PartyPayableReciveablesNew.aspx?cid={0}&bid={1}&ECode={2}&sdate={3}&edate={4}", DropDownList_Companyname.SelectedValue, DropDownList_Branchname.SelectedValue, hdfECode.Value, StartDate_Search.Text, EndDate_Search.Text)
        'Else
        '    URL = "Trial_Balance_Heads_Detail.aspx?E_Code=" + hdfECode.Value
        'End If
        URL = "Trial_Balance_Heads_Detail.aspx?E_Code=" + hdfECode.Value
        Dim sb As New StringBuilder
        sb.Append("<script language='javascript' type='text/javascript'>window.open('" + URL + "')</script>")
        Dim t As Type = Me.GetType()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopUp")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUp", sb.ToString())
        End If
    End Sub

    Protected Sub btnExportToExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExportToExcel.Click
        ShowAllComplaints()

    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Trial Balance" & Date.Now() & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView_Trial_Balance
        repAllCustomers.AllowPaging = False
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()

    End Sub

    Protected Sub Load_FinancialYear(ByRef SDate As TextBox, ByRef EDate As TextBox)
        Dim month As Integer = Date.Now.Month
        Dim Year As Integer = Date.Now.Year
        If month < 7 Then
            SDate.Text = CStr(Year - 1) + "-" + "07-01"
            EDate.Text = CStr(Year) + "-06-30"
        Else
            SDate.Text = CStr(Year) + "-07-01"
            EDate.Text = CStr(Year + 1) + "-06-30"
        End If
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        
    End Sub

    Protected Sub ButtonReport_Click(sender As Object, e As EventArgs) Handles ButtonReport.Click
        GridView_Trial_Balance.Visible = False
        ReportViewer1.Visible = True
        Show_Report()
    End Sub
End Class
