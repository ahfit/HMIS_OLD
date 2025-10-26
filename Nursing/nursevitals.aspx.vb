Imports System.Data
Imports System.Data.SqlClient
Imports Infragistics.WebUI.WebSchedule

Partial Class Nursing_nursevitals1
    Inherits System.Web.UI.Page
    Dim ClassObj As New PatientBasicInfo
    Dim userAuthen As New User_page_Authentication
    Dim agedate As String
    Dim ENC As New Encryption
    Dim GenXml As New GenerateXML


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim obj_menu As New JavaScriptMenu

        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()


        WebDateChooser1.MaxDate = Date.Now
        'Response.Write(Session("registrationNo") & "dsfsd" & Session("YearlyNo"))
        'Session.Add("registrationNo", ENC.Encrypt_Main(Session("registrationNo"), True))
        loginvalidate(Session("emp_id"), Session("dept_id"))
        ButtonSave.Attributes.Add("onClick", "return validates()")
        'CrystalReportViewerBP.LogOnInfo(0).ConnectionInfo.Password = "123"
        'CrystalReportViewerBP.SelectionFormula = "{Pt_Stages_Vitals.RegNo}='" & Session("registrationNo") & "' and {Pt_Stages_Vitals.PayID} = " & Session("YearlyNo") ' CInt(199834)
        'CrystalReportViewerBP.RefreshReport()
        Try
            '''''''''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''''''''''
            '  Fill_Grid()
            Dim vital As New XML_For_Graph
            vital.Create_XML_vitals_bplow(Session("registrationNo"), Session("YearlyNo"))
            vital.Create_XML_vitals_forBphight(Session("registrationNo"), Session("YearlyNo"))
            vital.Create_XML_vitals_pulse(Session("registrationNo"), Session("YearlyNo"))
            vital.Create_XML_vitals_temp(Session("registrationNo"), Session("YearlyNo"))
            vital.Create_XML_vitals_RR(Session("registrationNo"), Session("YearlyNo"))

            vital.Create_XML_vitals_Comp(Session("registrationNo"), Session("YearlyNo"))


            '''''''''''''''''''''''''''''''''
            '''''''''''''''''''''''''''''''''
        Catch ex As Exception

        End Try
        If Not Page.IsPostBack Then
            WebDateChooser1.Value = Date.Now
            WebDateTimeEdit1.Value = Date.Now
            ValidateControls()
        End If
        Fill_Grid()
    End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("../login.aspx")
            'response.write(Session("emp_id"))
            'response.write(Session("dept_id"))
        End If
    End Sub
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Page.Validate()
            HiddenFieldVitalTakeDate.Value = Convert.ToDateTime(WebDateChooser1.Value).Date + " " + WebDateTimeEdit1.Text

            'Response.Write(HiddenFieldVitalTakeDate.Value)

            '8/27/2011 12:28:14 AM 
            SqlDataSourcevitals_Remarks.Insert() ''''================== Insert The Vital Remarks =====================
            If (Basic_Checks._Textbox1_LessThan_Textbox2(TextBox_Bplow, TextBox_Bphigh, Label_Message, "") = True) Then
                '  If (Page.IsValid) Then
                If TextBox_Pulse.Text <> "" Then
                    HiddenFieldVitalID.Value = 8
                    HiddenFieldVital_Value.Value = TextBox_Pulse.Text
                    SqlDataSourcevitals.Insert()
                End If
                If TextBox_Bphigh.Text <> "" Then
                    HiddenFieldVitalID.Value = 6
                    HiddenFieldVital_Value.Value = TextBox_Bphigh.Text
                    SqlDataSourcevitals.Insert()
                End If
                If TextBox_Bplow.Text <> "" Then
                    HiddenFieldVitalID.Value = 7
                    HiddenFieldVital_Value.Value = TextBox_Bplow.Text
                    SqlDataSourcevitals.Insert()
                End If

                If TextBox_Resp_beats.Text <> "" Then
                    HiddenFieldVitalID.Value = 9
                    HiddenFieldVital_Value.Value = TextBox_Resp_beats.Text
                    SqlDataSourcevitals.Insert()
                End If

                If TextBox_Temp_F.Text <> "" Then
                    HiddenFieldVitalID.Value = 4
                    HiddenFieldVital_Value.Value = TextBox_Temp_F.Text
                    SqlDataSourcevitals.Insert()
                End If
                If txtCVP.Text <> "" Then
                    HiddenFieldVitalID.Value = 11
                    HiddenFieldVital_Value.Value = txtCVP.Text
                    SqlDataSourcevitals.Insert()
                End If
                Fill_Grid()
                ' GenXml.Generate_Patient_Chart()
                TextBox_Bphigh.Text = ""
                TextBox_Bplow.Text = ""
                TextBox_Pulse.Text = ""
                TextBox_Resp_beats.Text = ""
                TextBox_Temp_F.Text = ""
                txtCVP.Text = ""
                txtRemarks.Text = ""
                'CrystalReportViewerBP.Visible = True
            End If
            '                GridViewVitals.DataBind()

            'Else
            'Label_Message.Text = "Please Enter BP in Correct Format"

            'End If

        Catch ex As Exception
            ''  Response.Write(ex.Message + " " + HiddenFieldVitalTakeDate.Value)
        End Try
    End Sub

    Sub Fill_Grid()
        Dim ds As New PatientVital
        Dim da As New PatientVitalTableAdapters.Patient_VitalsTableAdapter
        Dim da1 As New PatientVitalTableAdapters.VitalGridTableAdapter
        da.Fill(ds.Tables("Patient_Vitals"), Session("registrationNo"), Session("YearlyNo"))
        da1.Fill_Remarks(ds.Tables("vitalGrid"), Session("registrationNo"), Session("YearlyNo"))
        For i As Integer = 0 To ds.Tables("Patient_Vitals").Rows.Count - 1
            For j As Integer = 0 To ds.Tables("vitalGrid").Rows.Count - 1
                If ds.Tables("Patient_Vitals").Rows(i).Item("Date") = ds.Tables("vitalGrid").Rows(j).Item("Date") And ds.Tables("Patient_Vitals").Rows(i).Item("Time") = ds.Tables("vitalGrid").Rows(j).Item("Time") Then
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 8 Then
                        ds.Tables("vitalGrid").Rows(j).Item("Pluse") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 6 Then
                        ds.Tables("vitalGrid").Rows(j).Item("BPHigh") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 7 Then
                        ds.Tables("vitalGrid").Rows(j).Item("BPLow") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 9 Then
                        ds.Tables("vitalGrid").Rows(j).Item("RR") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 4 Then
                        ds.Tables("vitalGrid").Rows(j).Item("Temp_F") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                    If ds.Tables("Patient_Vitals").Rows(i).Item("VitalID") = 11 Then
                        ds.Tables("VitalGrid").Rows(j).Item("CVP") = ds.Tables("Patient_Vitals").Rows(i).Item("Result")
                    End If
                End If
            Next
        Next
        GridViewVitals.DataSource = ds.Tables("vitalGrid")
        'Chart1.DataSource = ds.Tables("vitalGrid")
        'Chart1.DataBind()
        'Chart1.Visible = True
        'Chart2.DataSource = ds.Tables("vitalGrid")
        'Chart2.DataBind()
        'Chart2.Visible = True
        'Chart3.DataSource = ds.Tables("vitalGrid")
        'Chart3.DataBind()
        'Chart3.Visible = True
        'Chart4.DataSource = ds.Tables("vitalGrid")
        'Chart4.DataBind()
        'Chart4.Visible = True
        GridViewVitals.DataBind()
    End Sub
    'Protected Sub GridViewVitals_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewVitals.PreRender
    '    Dim a As String
    '    Dim b As String
    '    a = ""
    '    b = ""
    '    Try
    '        For i As Integer = 0 To GridViewVitals.Rows.Count - 1
    '            If (a = "") Then
    '                a = GridViewVitals.Rows(i).Cells(0).Text
    '            ElseIf (a = GridViewVitals.Rows(i).Cells(0).Text) Then
    '                GridViewVitals.Rows(i).Cells(0).Text = ""
    '            Else
    '                a = GridViewVitals.Rows(i).Cells(0).Text
    '            End If
    '            If (b = "") Then
    '                b = GridViewVitals.Rows(i).Cells(1).Text
    '            ElseIf (b = GridViewVitals.Rows(i).Cells(1).Text) Then
    '                GridViewVitals.Rows(i).Cells(1).Text = ""
    '            Else
    '                b = GridViewVitals.Rows(i).Cells(1).Text
    '            End If
    '        Next
    '    Catch ex As Exception
    '        Response.Write(ex.Message)
    '    End Try
    'End Sub



    Protected Sub ButtonBPreport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonBPreport.Click
        Response.Redirect("BloodPressure_report.aspx")
    End Sub

    Protected Sub ButtonPulse_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonPulse.Click
        Response.Redirect("Pulse_report.aspx")
    End Sub

    Protected Sub ButtonTemperature_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonTemperature.Click
        Response.Redirect("Temperature_report.aspx")
    End Sub

    'Protected Sub GridViewVitals_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridViewVitals.RowUpdating
    '    Dim hid_date As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("Textboxdate")
    '    Dim hid_Time As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxTime")
    '    Dim hid_Temp As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxTemp")
    '    Dim hid_Pulse As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxPulse")
    '    Dim hid_RR As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxRR")
    '    Dim hid_BpHigh As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxBPHigh")
    '    Dim hid_Bplow As TextBox = GridViewVitals.Rows(e.RowIndex).FindControl("TextboxBPLow")
    '    HiddenFieldDateTime.Value = hid_date.Text & " " & hid_Time.Text
    '    HiddenFieldTemp.Value = hid_Temp.Text
    '    HiddenFieldPulse.Value = hid_Pulse.Text
    '    HiddenFieldRR.Value = hid_RR.Text
    '    HiddenFieldBPHigh.Value = hid_BpHigh.Text
    '    HiddenFieldBPLow.Value = hid_Bplow.Text
    '    HiddenFieldTempC.Value = (5 / 9) * (hid_Temp.Text - 32)
    'End Sub


    Protected Sub LinkButton_Chart_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Chart.Click
        Response.Redirect("~/chart_icu.aspx")
    End Sub
    Sub ValidateControls()

        'Dim daSelectRanges As New NursingTableAdapters.SelectParameterRefrenceRangesTableAdapter
        'Dim dt As New DataTable
        'dt = daSelectRanges.GetData(Session("RegistrationNo").ToString())
        'For i As Integer = 0 To dt.Rows.Count - 1
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "8" Then
        '        'pulse
        '        RangeValidatorPulse.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorPulse.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorPulse.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()

        '    End If
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "11" Then
        '        'cvp
        '        RangeValidatorCVP.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorCVP.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorCVP.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()

        '    End If
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "6" Then
        '        'bp high
        '        RangeValidatorBPHigh.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorBPHigh.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorBPHigh.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()
        '    End If
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "9" Then
        '        'rr
        '        RangeValidatorResp.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorResp.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorResp.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()
        '    End If
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "4" Then
        '        'Temp f
        '        RangeValidatorTemp.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorTemp.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorTemp.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()
        '    End If
        '    If dt.Rows(i).Item("Vital_ID").ToString() = "7" Then
        '        'bp Low
        '        RangeValidatorBPLow.MinimumValue = dt.Rows(i).Item("StartValue").ToString()
        '        RangeValidatorBPLow.MaximumValue = dt.Rows(i).Item("EndValue").ToString()
        '        RangeValidatorBPLow.ErrorMessage = dt.Rows(i).Item("Report_Values").ToString()
        '    End If
        'Next

    End Sub

    Protected Sub SqlDataSourcevitals_Remarks_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourcevitals_Remarks.Inserted
        hf_Remarks_Identity.Value = e.Command.Parameters("@Identity").Value
    End Sub
End Class
