Imports System.IO
Imports System.Data

Partial Class Radiology_rpt_XRAY_Consumption
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        Dim i As Integer = 0
        Dim total_Adv As Long = 0
        Dim total_Bill As Long = 0
        Dim YearlyNo As Long = 0
        Dim Hospital_Id As Long = 0
        Dim PatientType_Id As Long = 0
        Dim RegNo As String = "%"
        Hospital_Id = DropDownList_Hospital_Id.SelectedValue
        PatientType_Id = DropDownList_Pt_Type.SelectedValue
        If TextBox_MRNO.Text <> "" Then
            RegNo = ENC.Encrypt_Main(TextBox_MRNO.Text, True)
        End If
        Try
            If TextBox_VisitNo.Text <> "" Then
                YearlyNo = CLng(TextBox_VisitNo.Text)
            End If
        Catch ex As Exception

        End Try

        '=============================
        HiddenField_StartDate.Value = Year(WebDateChooser_start_Date.Value).ToString + Right("00" + Month(WebDateChooser_start_Date.Value).ToString, 2) + Right("00" + Day(WebDateChooser_start_Date.Value).ToString, 2)
        HiddenField_EndDate.Value = Year(WebDateChooser_End_Date.Value).ToString + Right("00" + Month(WebDateChooser_End_Date.Value).ToString, 2) + Right("00" + Day(WebDateChooser_End_Date.Value).ToString, 2)

        '=============================
        Dim ds As New Store_Consumptions
        Dim da As New Store_ConsumptionsTableAdapters.ups_XRAY_ConsumptionTableAdapter 'Store_Consumption ups_XRAY_Consumption AdminReportsTableAdapters.Admission_Discharge_RegisterTableAdapter

        Dim StartDate As String = ""
        Dim EndDate As String = ""

        '' StartDate = DateTime.Parse(WebDateChooser_start_Date.Text.ToString()).ToString("yyyy-dd-MM HH:mm:ss")
        ''EndDate = DateTime.Parse(WebDateChooser_End_Date.Text.ToString()).ToString("yyyy-dd-MM HH:mm:ss")

        StartDate = Convert.ToDateTime(WebDateChooser_start_Date.Text, System.Globalization.CultureInfo.GetCultureInfo("hi-IN").DateTimeFormat)

        EndDate = Convert.ToDateTime(WebDateChooser_End_Date.Text, System.Globalization.CultureInfo.GetCultureInfo("hi-IN").DateTimeFormat)


       

        ''''''''''''  da.Fill(ds.Tables("ups_XRAY_Consumption"), 0, RegNo, CInt(YearlyNo), CStr(HiddenField_StartDate.Value), CStr(HiddenField_EndDate.Value), CInt(DropDownList_Pt_Type.SelectedValue), CInt(DropDownList_Hospital_Id.SelectedValue), RadioButtonList_IPDOPD.SelectedValue, RadioButtonList_SpecificDate.SelectedValue, CInt(DropDownList_TestGroup.SelectedValue))
        da.Fill(ds.Tables("ups_XRAY_Consumption"), 0, RegNo, CInt(YearlyNo), CStr(StartDate), CStr(EndDate), CInt(DropDownList_Pt_Type.SelectedValue), CInt(DropDownList_Hospital_Id.SelectedValue), RadioButtonList_IPDOPD.SelectedValue, RadioButtonList_SpecificDate.SelectedValue, CInt(DropDownList_TestGroup.SelectedValue))

        '''[ups_OtherTest_RadiologyRegister]
        '======================================================


        For i = 0 To ds.Tables("ups_XRAY_Consumption").Rows.Count - 1
            ds.Tables("ups_XRAY_Consumption").Rows(i).Item("Prefix") = ds.Tables("ups_XRAY_Consumption").Rows(i).Item("Prefix") + ENC.Encrypt_Main(ds.Tables("ups_XRAY_Consumption").Rows(i).Item("PFName"), False) + " " + ENC.Encrypt_Main(ds.Tables("ups_XRAY_Consumption").Rows(i).Item("PMName"), False) + " " + ENC.Encrypt_Main(ds.Tables("ups_XRAY_Consumption").Rows(i).Item("PLName"), False)


            ds.Tables("ups_XRAY_Consumption").Rows(i).Item("Reg_No") = ENC.Encrypt_Main(ds.Tables("ups_XRAY_Consumption").Rows(i).Item("Reg_No"), False)

        Next

        '------------------------------------------Adding Record Num
        '''''''Dim table As DataTable = ds.Tables("ups_XRAY_Consumption")
        '' ''table.Columns.Add("SNo")
        '' ''table.Columns("SNo").SetOrdinal(0)
        '' ''Dim intSno As Integer = 1
        '' ''For Each row As DataRow In table.Select()

        '' ''    row("SNo") = intSno
        '' ''    intSno = intSno + 1
        '' ''Next
        '------------------------------------------Adding Record Num
        GridView_Adt_Discharge.DataSource = ds.Tables("ups_XRAY_Consumption")
        ''''''ds.Tables("ups_XRAY_Consumption")

        GridView_Adt_Discharge.DataBind()

    End Sub

    'Protected Sub GridView_Adt_Discharge_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView_Adt_Discharge.RowCommand

    '    Dim index As Integer = Convert.ToInt32(e.CommandArgument)
    '    Dim selectedRow As GridViewRow = GridView_Adt_Discharge.Rows(index)
    '    Dim RegNO As TableCell = selectedRow.Cells(1)
    '    Dim YearlyNo As TableCell = selectedRow.Cells(2)

    '    Session("Patient_type") = DropDownList_Pt_Type.SelectedItem.Text
    '    Session("Patienttype") = DropDownList_Pt_Type.SelectedItem.Text
    '    Session("RegistrationNo") = ENC.Encrypt_Main(RegNO.Text, True)
    '    Session("YearlyNo") = YearlyNo.Text
    '    Dim sb As StringBuilder = New StringBuilder
    '    sb.Append("<script language='javascript'>")
    '    sb.Append(" window.open('PatientRunningBill.aspx?type=1')</script>")

    '    Dim t As Type = Me.GetType
    '    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
    '        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
    '    End If
    'End Sub

    Protected Sub DropDownList_Hospital_Id_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Hospital_Id.SelectedIndexChanged
        DropDownList_Pt_Type.DataBind()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '  DropDownList_Pt_Type.DataBind()
    End Sub

    Protected Sub GridView_Adt_Discharge_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Adt_Discharge.PreRender
        'Dim Total_Advances, Total_Consession, Total_Paid, Total_Bill, Total_Receiable, Total_Refund As Long
        'For i As Integer = 0 To GridView_Adt_Discharge.Rows.Count - 1
        '    Dim Label_Advance As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_Advance")
        '    Dim Label_Consession As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_Consession")
        '    Dim Label_PPaid As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_PPaid")
        '    Dim Label_Bill As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_Bill")
        '    Dim Label_Receiable As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_Receiable")
        '    Dim Label_Refund As Label = GridView_Adt_Discharge.Rows(i).FindControl("Label_Refund")
        '    Total_Advances = Total_Advances + Label_Advance.Text
        '    Total_Consession = Total_Consession + Label_Consession.Text
        '    Total_Paid = Total_Paid + Label_PPaid.Text
        '    Total_Bill = Total_Bill + Label_Bill.Text
        '    Total_Receiable = Total_Receiable + Label_Receiable.Text
        '    Total_Refund = Total_Refund + Label_Refund.Text
        'Next
        'If GridView_Adt_Discharge.Rows.Count > 0 Then
        '    GridView_Adt_Discharge.FooterRow.Cells(9).Text = Total_Advances
        '    GridView_Adt_Discharge.FooterRow.Cells(10).Text = Total_Consession
        '    GridView_Adt_Discharge.FooterRow.Cells(11).Text = Total_Paid
        '    GridView_Adt_Discharge.FooterRow.Cells(12).Text = Total_Bill
        '    GridView_Adt_Discharge.FooterRow.Cells(13).Text = Total_Receiable
        '    GridView_Adt_Discharge.FooterRow.Cells(14).Text = Total_Refund

        'End If





    End Sub

    Protected Sub LinkButton3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonx.Click
        Response.Clear()
        Response.ContentType = "application/vnd.xls"
        Response.AddHeader("content-disposition", "attachment;filename=filename.xls")

        Dim swriter As New StringWriter()
        Dim hwriter As New HtmlTextWriter(swriter)

        Dim frm As New HtmlForm()
        Me.GridView_Adt_Discharge.Parent.Controls.Add(frm)
        frm.Attributes("runat") = "server"
        frm.Controls.Add(Me.GridView_Adt_Discharge)
        frm.RenderControl(hwriter)

        Response.Write(swriter.ToString())
        Response.End()
    End Sub
End Class
