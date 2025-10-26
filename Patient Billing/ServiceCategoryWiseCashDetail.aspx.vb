
Imports System.Data
Imports Microsoft.Reporting.WebForms
Imports System.Data.SqlClient
Imports System.IO
Imports System.Collections.Generic
Imports Microsoft.Reporting.WinForms


Partial Class ServiceCategoryWiseCashDetail
    Inherits System.Web.UI.Page

    Shared idd As String
    Dim ENC As New Encryption
    Dim commas As New Coma
    Dim total_amount As Integer = 0
    Dim total_Paid As Integer = 0
    Dim total_Refund As Integer = 0
    Dim Advance_amount As Integer = 0
    Dim Bill_amount As Integer = 0
    Dim Refund_amount As Integer = 0
    Dim Total_Amount_Cardiac As Integer = 0
    Dim co As New Coma
    Protected Sub Page_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack() Then
            GridView_Counter_Close.DataBind()
        End If
        Dim id As String = Request.QueryString("CId")
        idd = id

    End Sub

    Protected Sub GridView_Counter_Close_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Counter_Close.PreRender

        'If Page.IsPostBack = False Then
        Dim total_amount As Double
        Dim total_Discount As Double = 0
        Dim total_Refund As Double = 0


        total_amount = 0
        If GridView_Counter_Close.Rows.Count <> 0 Then

            Dim PFName, PMName, PLName As HiddenField
            Dim Patient_name, regNo, Amount As Label, Paid As Label, Refund As Label, Discount As Label




            For Each row As GridViewRow In GridView_Counter_Close.Rows
                PFName = row.FindControl("HF_F_Name")
                PMName = row.FindControl("HF_M_Name")
                PLName = row.FindControl("HF_L_Name")
                Patient_name = row.FindControl("LBL_Patient_Name")

                regNo = row.FindControl("lbl_reg")

                If Not String.IsNullOrEmpty(PFName.Value.Trim()) Then
                    Patient_name.Text = ENC.Encrypt_Main(PFName.Value, False) + " "
                End If
                If Not String.IsNullOrEmpty(PMName.Value.Trim()) Then
                    Patient_name.Text = Patient_name.Text + ENC.Encrypt_Main(PMName.Value, False) + " "
                End If
                If Not String.IsNullOrEmpty(PLName.Value.Trim()) Then
                    Patient_name.Text = Patient_name.Text + ENC.Encrypt_Main(PLName.Value, False)
                End If

                regNo.Text = ENC.Encrypt_Main(regNo.Text, False)

                Amount = row.FindControl("LBL_Amount")
                Paid = row.FindControl("LBL_Paid")

                Discount = row.FindControl("LBL_Discount")
                Refund = row.FindControl("LBL_RefundAmount")
              
                'Refund = row.FindControl("Lbl_RefundRequest")





                total_amount += Double.Parse(Amount.Text)
                total_Paid += Double.Parse(Paid.Text)
                'total_Refund += Double.Parse(Refund.Text)
                total_Discount += Double.Parse(Discount.Text)
                total_Refund += Double.Parse(Refund.Text)

                Amount.Text = commas.place_Coma(Amount.Text)
                Paid.Text = commas.place_Coma(Paid.Text)
                Discount.Text = commas.place_Coma(Discount.Text)
                Refund.Text = commas.place_Coma(Refund.Text)


            Next

            Dim Gtotal As Label = GridView_Counter_Close.FooterRow.FindControl("total_Remain")
            Dim Ptotal As Label = GridView_Counter_Close.FooterRow.FindControl("total_Paid")
            Dim GtotalDiscount As Label = GridView_Counter_Close.FooterRow.FindControl("total_Discount")
            Dim PtotalRefund As Label = GridView_Counter_Close.FooterRow.FindControl("total_RefundAmount")

            'Dim Rtotal As Label = GridView_Counter_Close.FooterRow.FindControl("total_refund")

            Try
                btn_export.Visible = True
                Gtotal.Text = total_amount
                Ptotal.Text = total_Paid
                GtotalDiscount.Text = total_Discount
                PtotalRefund.Text = total_Refund
                'Rtotal.Text = total_Refund


            Catch ex As Exception

            End Try

        Else
            btn_export.Visible = False

        End If


        '  End If


    End Sub


    Protected Sub lnkbtnAdv_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lnk As LinkButton = sender
        Dim main_id As String = lnk.CommandArgument
        Dim Path As String = String.Empty
        Dim row As GridViewRow = lnk.NamingContainer
        Dim type As HiddenField = row.FindControl("HiddenFieldType")
        Dim YearlyNo As HiddenField = row.FindControl("HiddenFieldYearlyNo")
        Dim RegNo As HiddenField = row.FindControl("HiddenFieldRegNo")
        Dim SMP_ID As HiddenField = row.FindControl("HiddenFieldSMP_ID")
        If type.Value = "Advance" Then
            'Path = "../Patient Billing/Indoor_Payment_receipt.aspx?Payment_No=" + main_id + "&PayID=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance"
            Response.Redirect("~/Patient Billing/Indoor_Payment_receipt.aspx?Payment_No=" + main_id + "&PayID=" + YearlyNo.Value + "&RegNo=" + RegNo.Value + "&Type=Advance")
        Else
            Session("YearlyNo") = YearlyNo.Value
            Session("RegistrationNo") = RegNo.Value
            If String.IsNullOrEmpty(SMP_ID.Value) Then
                Response.Redirect("~/Patient Billing/Indoor_Payment_refund.aspx?PayID=" + YearlyNo.Value + "&RegNo=" + RegNo.Value)

            End If
            'Path = "../Patient Billing/patientServices.aspx?SPMID=" + SMP_ID.Value
            Response.Redirect("~/Patient Billing/patientServices.aspx?SPMID=" + SMP_ID.Value)

        End If

        'Dim sb As StringBuilder = New StringBuilder
        'sb.Append("<script language='javascript'>  window.open('" + Path + "')</script>")
        'Dim t As Type = Me.GetType
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        'End If
    End Sub

    Private Sub ShowAllComplaints()
        Dim fileName As String = "Head Wise Total Collection.xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView_Counter_Close
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub

    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'base.VerifyRenderingInServerForm(control);
    End Sub

    'Protected Sub btn_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_export.Click
    '    ShowAllComplaints()
    'End Sub

    Protected Sub btnEToExcel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnEToExcel.Click
        ShowAllComplaints()
    End Sub
   


    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click

        

            Dim a As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)


            '========================================================================
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Cash_Submitted_Details_BySericeName", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            Dim id As String = Request.QueryString("CId")
            Dim DateFrom As String = Request.QueryString("DateFrom")
        Dim DateTo As String = Request.QueryString("DateTo")
        Dim Type As String = Request.QueryString("Type")

            idd = id

            mycommand.Parameters.AddWithValue("@ServiceCategoryId", id)
            mycommand.Parameters.AddWithValue("@DateFrom", DateFrom)
            mycommand.Parameters.AddWithValue("@DateTo", DateTo)
        mycommand.Parameters.AddWithValue("@ServiceName", txtboxServiceName.Text)
        mycommand.Parameters.AddWithValue("@Type", Type)
        mycommand.Parameters.AddWithValue("@hospitalID", Request.QueryString("HospitalID"))


        ReportViewer1.LocalReport.DataSources.Clear()
            Dim da As SqlDataAdapter = New SqlDataAdapter(mycommand)
            Dim ds As DataSet = New DataSet
            da.Fill(ds)

            txtboxServiceName.Text = ""

            Dim rds As New ReportDataSource()
            rds.Name = "DataSet1"
        rds.Value = ds.Tables(0)

       





        ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.ReportPath = "./Patient Billing/CashSubmittedDetailsCategoryWiseByServiceName.rdlc"
            ReportViewer1.LocalReport.DataSources.Add(rds)
        Dim repParams As ReportParameter() = New ReportParameter(2) {}

        repParams(0) = New ReportParameter("FromDate", Request.QueryString("DateFrom"))
        repParams(1) = New ReportParameter("ToDate", Request.QueryString("DateTo"))
        repParams(2) = New ReportParameter("CatName", Request.QueryString("CatName"))
        ReportViewer1.LocalReport.SetParameters(repParams)
        'ReportViewer1.LocalReport.su += New SubreportProcessingEventHandler(subReports)
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

        ReportViewer1.LocalReport.Refresh()

            If Request.Browser.Browser = "Chrome" Then

                Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            Else

                ReportViewer1.Visible = True
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


    <System.Web.Script.Services.ScriptMethod(), System.Web.Services.WebMethod()> _
    Public Shared Function SearchNames(ByVal prefixText As String, ByVal count As Integer) As List(Of String)


        Dim customers As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "uspSerivesName"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@ServiceCategoryId ", idd)
        cmd.Parameters.AddWithValue("@text", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            customers.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("S_Name").ToString(), sdr("S_ID").ToString()))
        End While
        Return customers


    End Function

    Protected Sub txtboxServiceName_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtboxServiceName.TextChanged

        If txtboxServiceName.Text = "" Then
            GridView_Counter_Close.DataSourceID = "SqlDataSourceForGrid"
            GridView_Counter_Close.DataBind()

        Else
            Dim a As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)


            '========================================================================
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Cash_Submitted_Details_BySericeName", con) ' "select RegNo from Patient where (RegNo = @name )", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            Dim id As String = Request.QueryString("CId")
            Dim DateFrom As String = Request.QueryString("DateFrom")
            Dim DateTo As String = Request.QueryString("DateTo")

            idd = id

            mycommand.Parameters.AddWithValue("@ServiceCategoryId", id)
            mycommand.Parameters.AddWithValue("@DateFrom", DateFrom)
            mycommand.Parameters.AddWithValue("@DateTo", DateTo)
            mycommand.Parameters.AddWithValue("@ServiceName", txtboxServiceName.Text)
            mycommand.Parameters.AddWithValue("@hospitalID", Session("Hospital_ID"))


            Dim da As SqlDataAdapter = New SqlDataAdapter(mycommand)
            Dim ds As DataSet = New DataSet
            da.Fill(ds)

            GridView_Counter_Close.DataSourceID = ""
            GridView_Counter_Close.DataSource = ds

            GridView_Counter_Close.DataBind()
        End If


    End Sub

   

End Class
