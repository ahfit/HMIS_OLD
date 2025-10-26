Imports System.Data

Partial Class WardIntakeOutputSheetRpt
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LoadHospitalHeader()

        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()


        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")

        Dim regNo As String = Session("RegistrationNo")
        Dim yearly_No As Integer = Session("YearlyNo")
        'Response.Write(regNo & " Reg " & yearly_No.ToString() & " TYer ")

        Dim obj As New PatientFaceSheet()
        'Dim tbl As DataTable = obj.GetData("281030204029036043036043050036043043036036036043")
        Dim tbl As DataTable = obj.GetData(regNo, yearly_No)

        If tbl.Rows.Count > 0 Then
            Dim row As DataRow = tbl.Rows(0)

            lblPatientName.Text = row("Prefix").ToString() + "" + ENC.Encrypt_Main(row("PFName").ToString(), False) + " " + ENC.Encrypt_Main(row("PMName").ToString(), False) + " " + ENC.Encrypt_Main(row("PLName").ToString(), False)
            lblRelationName.Text = row("Prefix").ToString() + "" + row("RFName").ToString() + " " + row("RMName").ToString() + " " + row("RLName").ToString()
            lblMedicalRecord.Text = row("Yearly_No").ToString()
            lblRoomNo.Text = row("Bed_No").ToString()
            lblSex.Text = row("Gender").ToString()
            lblCNIC.Text = row("CNIC").ToString()
            lblRelation.Text = row("Relation").ToString()
            lblDateAdmission.Text = row("RegDateTime").ToString()
            lblNoOfDays.Text = Math.Floor(Convert.ToDecimal((DateTime.Now - Convert.ToDateTime(row("RegDateTime"))).TotalDays))

            lblAge.Text = row("Age").ToString()
            lblPhone.Text = row("HomePhone").ToString() + ", " + row("MobilePhone").ToString()
            lblAddress.Text = row("House_No").ToString() + " " + row("StreetAddress").ToString() + " " + row("TehsilName").ToString() + " , " + row("ProvinceName").ToString() + " " + row("CountryName").ToString()
            lblConsultantName.Text = row("Employee").ToString()


        End If


    End Sub
    Protected Sub GridView_Intake_PreRender(ByVal sender As Object, ByVal e As EventArgs)
        Dim Oral_Total As Int32 = 0
        Dim CVPLine_Total As Int32 = 0
        Dim Parenteral_Total As Int32 = 0
        Dim NG_Total As Int32 = 0
        Dim InOther_Total As Int32 = 0
        Dim In_total As Int32 = 0

        ' output
        Dim Out_Total As Int32 = 0
        Dim Drainage_Total As Int32 = 0
        Dim NG_Aspiration_Total As Int32 = 0
        Dim Vomit_Total As Int32 = 0
        Dim Stool_Total As Int32 = 0
        Dim Urine_Total As Int32 = 0
        Dim OutOther_Total As Int32 = 0

        Dim PH As Int32 = 0
        Dim Bld As Int32 = 0
        Dim Sug As Int32 = 0
        Dim Ket As Int32 = 0
        Dim ALB As Int32 = 0

        Dim G_Oral_Total As Int32 = 0
        Dim G_CVPLine_Total As Int32 = 0
        Dim G_Parenteral_Total As Int32 = 0
        Dim G_NG_Total As Int32 = 0
        Dim G_InOther_Total As Int32 = 0
        Dim G_In_total As Int32 = 0

        ' output
        Dim G_Out_Total As Int32 = 0
        Dim G_Drainage_Total As Int32 = 0
        Dim G_NG_Aspiration_Total As Int32 = 0
        Dim G_Vomit_Total As Int32 = 0
        Dim G_Stool_Total As Int32 = 0
        Dim G_Urine_Total As Int32 = 0
        Dim G_OutOther_Total As Int32 = 0

        Dim G_PH As Int32 = 0
        Dim G_Bld As Int32 = 0
        Dim G_Sug As Int32 = 0
        Dim G_Ket As Int32 = 0
        Dim G_ALB As Int32 = 0




        If GridView_Intake.Rows.Count <> 0 Then
            For i As Int32 = 0 To GridView_Intake.Rows.Count - 1
                If GridView_Intake.Rows(i).Cells(0).Text <> "Total" Then
                    Dim Label_O_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_O_Qty"), Label)
                    Oral_Total = Oral_Total + Convert.ToInt32(Label_O_Qty.Text)

                    Dim Label_CVPLine__1 As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_CVPLine"), Label)
                    CVPLine_Total = CVPLine_Total + Convert.ToInt32(Label_CVPLine__1.Text)

                    Dim Label_Parenteral_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Parenteral_Qty"), Label)
                    Parenteral_Total = Parenteral_Total + Convert.ToInt32(Label_Parenteral_Qty.Text)

                    Dim Label_N_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_N_Qty"), Label)
                    NG_Total = NG_Total + Convert.ToInt32(Label_N_Qty.Text)

                    Dim Label_InOther As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_InOther"), Label)
                    InOther_Total = InOther_Total + Convert.ToInt32(Label_InOther.Text)

                    Dim Label_IN_Total As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_IN_Total"), Label)
                    Label_IN_Total.Text = Convert.ToString(Convert.ToInt32(Label_O_Qty.Text) + Convert.ToInt32(Label_CVPLine__1.Text) + Convert.ToInt32(Label_Parenteral_Qty.Text) + Convert.ToInt32(Label_N_Qty.Text) + Convert.ToInt32(Label_InOther.Text))

                    In_total += Convert.ToInt32(Label_IN_Total.Text)


                    '       Label_Out_Total                

                    Dim Label_Drainage As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Drainage"), Label)
                    Drainage_Total += Convert.ToInt32(Label_Drainage.Text)

                    Dim Label_NG_Aspiration As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_NG_Aspiration"), Label)
                    NG_Aspiration_Total += Convert.ToInt32(Label_NG_Aspiration.Text)

                    Dim Label_Vomit As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Vomit"), Label)
                    Vomit_Total += Convert.ToInt32(Label_Vomit.Text)

                    Dim Label_Stool As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Stool"), Label)
                    Stool_Total += Convert.ToInt32(Label_Stool.Text)

                    Dim Label_Urine As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Urine"), Label)
                    Urine_Total += Convert.ToInt32(Label_Urine.Text)

                    Dim Label_Out_Other As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Out_Other"), Label)
                    OutOther_Total += Convert.ToInt32(Label_Out_Other.Text)

                    Dim Label_Out_Total As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Out_Total"), Label)
                    Label_Out_Total.Text = Convert.ToString(Convert.ToInt32(Label_Drainage.Text) + Convert.ToInt32(Label_NG_Aspiration.Text) + Convert.ToInt32(Label_Vomit.Text) + Convert.ToInt32(Label_Stool.Text) + Convert.ToInt32(Label_Urine.Text) + Convert.ToInt32(Label_Out_Other.Text))

                    Out_Total += Convert.ToInt32(Label_Out_Total.Text)



                    Dim Label_PH As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_PH"), Label)

                    If Label_PH.Text <> "" Then
                        PH += Convert.ToInt32(Label_PH.Text)
                    End If



                    Dim Label_Bld As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Bld"), Label)
                    If Label_Bld.Text <> "" Then
                        Bld += Convert.ToInt32(Label_Bld.Text)
                    End If


                    Dim Label_Sug As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Sug"), Label)
                    If Label_Sug.Text <> "" Then
                        Sug += Convert.ToInt32(Label_Sug.Text)
                    End If

                    Dim Label_Ket As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Ket"), Label)
                    If Label_Ket.Text <> "" Then
                        Ket += Convert.ToInt32(Label_Ket.Text)
                    End If


                    Dim Label_ALB As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_ALB"), Label)
                    If Label_ALB.Text <> "" Then
                        ALB += Convert.ToInt32(Label_ALB.Text)


                    End If
                Else

                    Dim Label_O_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_O_Qty"), Label)
                    Label_O_Qty.Text = Convert.ToString(Oral_Total)

                    Dim Label_CVPLine__1 As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_CVPLine"), Label)
                    Label_CVPLine__1.Text = Convert.ToString(CVPLine_Total)

                    Dim Label_Parenteral_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Parenteral_Qty"), Label)
                    Label_Parenteral_Qty.Text = Convert.ToString(Parenteral_Total)

                    Dim Label_N_Qty As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_N_Qty"), Label)
                    Label_N_Qty.Text = Convert.ToString(NG_Total)

                    Dim Label_InOther As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_InOther"), Label)
                    Label_InOther.Text = Convert.ToString(InOther_Total)

                    Dim Label_IN_Total As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_IN_Total"), Label)
                    '    Label_IN_Total.Text = Convert.ToString(Convert.ToInt32(Label_O_Qty.Text) + Convert.ToInt32(Label_CVPLine.Text) + Convert.ToInt32(Label_Parenteral_Qty.Text) + Convert.ToInt32(Label_N_Qty.Text) + Convert.ToInt32(Label_InOther.Text));

                    Label_IN_Total.Text = Convert.ToString(In_total)


                    '       Label_Out_Total                

                    Dim Label_Drainage As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Drainage"), Label)
                    Label_Drainage.Text = Convert.ToString(Drainage_Total)

                    Dim Label_NG_Aspiration As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_NG_Aspiration"), Label)
                    Label_NG_Aspiration.Text = Convert.ToString(NG_Aspiration_Total)

                    Dim Label_Vomit As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Vomit"), Label)
                    Label_Vomit.Text = Convert.ToString(Vomit_Total)

                    Dim Label_Stool As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Stool"), Label)
                    Label_Stool.Text = Convert.ToString(Stool_Total)

                    Dim Label_Urine As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Urine"), Label)
                    Label_Urine.Text = Convert.ToString(Urine_Total)

                    Dim Label_Out_Other As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Out_Other"), Label)
                    Label_Out_Other.Text = Convert.ToString(OutOther_Total)

                    Dim Label_Out_Total As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Out_Total"), Label)
                    'Label_Out_Total.Text = Convert.ToString(Convert.ToInt32(Label_Drainage.Text) + Convert.ToInt32(Label_NG_Aspiration.Text) + Convert.ToInt32(Label_Vomit.Text) + Convert.ToInt32(Label_Stool.Text) + Convert.ToInt32(Label_Urine.Text) + Convert.ToInt32(Label_Out_Other.Text));

                    Label_Out_Total.Text = Convert.ToString(Out_Total)

                    Dim Label_PH As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_PH"), Label)
                    Label_PH.Text = Convert.ToString(PH)

                    Dim Label_Bld As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Bld"), Label)
                    Label_Bld.Text = Convert.ToString(Bld)

                    Dim Label_Sug As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Sug"), Label)
                    Label_Sug.Text = Convert.ToString(Sug)

                    Dim Label_Ket As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_Ket"), Label)
                    Label_Ket.Text = Convert.ToString(Ket)

                    Dim Label_ALB As Label = DirectCast(GridView_Intake.Rows(i).FindControl("Label_ALB"), Label)
                    Label_ALB.Text = Convert.ToString(ALB)




                    G_Oral_Total += Oral_Total
                    G_CVPLine_Total += CVPLine_Total
                    G_Parenteral_Total += Parenteral_Total
                    G_NG_Total += NG_Total
                    G_InOther_Total += InOther_Total
                    G_In_total += In_total

                    ' output
                    G_Out_Total += Out_Total
                    G_Drainage_Total += Drainage_Total
                    G_NG_Aspiration_Total += NG_Aspiration_Total
                    G_Vomit_Total += Vomit_Total
                    G_Stool_Total += Stool_Total
                    G_Urine_Total += Urine_Total
                    G_OutOther_Total += OutOther_Total

                    G_PH += PH
                    G_Bld += Bld
                    G_Sug += Sug
                    G_Ket += Ket
                    G_ALB += ALB

                    Oral_Total = 0
                    CVPLine_Total = 0
                    Parenteral_Total = 0
                    NG_Total = 0
                    InOther_Total = 0
                    In_total = 0

                    ' output
                    Out_Total = 0
                    Drainage_Total = 0
                    NG_Aspiration_Total = 0
                    Vomit_Total = 0
                    Stool_Total = 0
                    Urine_Total = 0
                    OutOther_Total = 0

                    PH = 0
                    Bld = 0
                    Sug = 0
                    Ket = 0
                    ALB = 0


                    GridView_Intake.Rows(i).CssClass = "totalrow"


                End If
            Next

            Dim Label_Total_Oral As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Total_Oral"), Label)
            Label_Total_Oral.Text = G_Oral_Total.ToString()


            Dim Label_CvpLine__2 As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_CvpLine"), Label)
            Label_CvpLine__2.Text = G_CVPLine_Total.ToString()

            Dim Label_Total_IV As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Total_IV"), Label)
            Label_Total_IV.Text = G_Parenteral_Total.ToString()

            Dim Label_Total_NG As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Total_NG"), Label)
            Label_Total_NG.Text = G_NG_Total.ToString()

            Dim Label_Other As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Other"), Label)
            Label_Other.Text = G_InOther_Total.ToString()

            Dim Label_G_Total As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_G_Total"), Label)
            Label_G_Total.Text = G_In_total.ToString()
            Label_G_Total.Font.Bold = True
            ' Output

            Dim Label_Tot_Drainage As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Drainage"), Label)
            Label_Tot_Drainage.Text = G_Drainage_Total.ToString()

            Dim Label_Tot_NGAspiration As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_NGAspiration"), Label)
            Label_Tot_NGAspiration.Text = G_NG_Aspiration_Total.ToString()

            Dim Label_Tot_Vomit As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Vomit"), Label)
            Label_Tot_Vomit.Text = G_Vomit_Total.ToString()


            Dim Label_Tot_Stool As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Stool"), Label)
            Label_Tot_Stool.Text = G_Stool_Total.ToString()

            Dim Label_Tot_Urine As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Urine"), Label)
            Label_Tot_Urine.Text = G_Urine_Total.ToString()

            Dim Label_Tot_Out_Other As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Out_Other"), Label)
            Label_Tot_Out_Other.Text = G_OutOther_Total.ToString()

            Dim Label_G_Out_Total As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_G_Out_Total"), Label)
            Label_G_Out_Total.Text = G_Out_Total.ToString()
            Label_G_Out_Total.Font.Bold = True

            Dim Label_Tot_PH As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_PH"), Label)
            Label_Tot_PH.Text = G_PH.ToString()

            Dim Label_Tot_Bld As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Bld"), Label)
            Label_Tot_Bld.Text = G_Bld.ToString()

            Dim Label_Tot_Sug As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Sug"), Label)
            Label_Tot_Sug.Text = G_Sug.ToString()

            Dim Label_Tot_Ket As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_Ket"), Label)
            Label_Tot_Ket.Text = G_Ket.ToString()

            Dim Label_Tot_ALB As Label = DirectCast(GridView_Intake.FooterRow.FindControl("Label_Tot_ALB"), Label)

            Label_Tot_ALB.Text = G_ALB.ToString()
        End If
        Load_Sub_IN_OUT()

    End Sub
    Protected Sub Load_Sub_IN_OUT()

        Dim ds As New Nursing()
        Dim da As New NursingTableAdapters.Select_Patient_Intake_Output_ReportTableAdapter()

        da.Fill(ds.Tables("Select_Patient_Intake_Output_Report"), Convert.ToDecimal(Session("YearlyNo")), Session("RegistrationNo"), Request.QueryString("dt"))
        Dim pos As Int32 = 0
        Dim isaddrow As [Boolean] = False
        If ds.Select_Patient_Intake_Output_Report.Rows.Count <> 0 Then
            Dim time As Int32
            For i As Int32 = 0 To 23
                If i > 16 Then
                    time = i - 17
                Else
                    time = 7 + i
                End If

                For j As Int32 = 0 To ds.Select_Patient_Intake_Output_Report.Rows.Count - 1
                    If Convert.ToString(time) + ":00" = ds.Select_Patient_Intake_Output_Report(j)("Time").ToString() Then
                        isaddrow = True
                        '  Response.Write(Convert.ToString(time) + ":00 ");
                        pos = pos + 1

                    End If
                Next

                If (Convert.ToString(time) + ":00" = "14:00") OrElse (Convert.ToString(time) + ":00" = "22:00") OrElse (Convert.ToString(time) + ":00" = "6:00") Then
                    If isaddrow = True Then
                        Dim dr As DataRow = ds.Tables("Select_Patient_Intake_Output_Report").NewRow()
                        'dr[""] = 
                        dr("date") = "Total"
                        dr("Time") = ""
                        dr("Oral") = 0
                        dr("PARENTERAL") = 0
                        dr("N/G") = 0
                        dr("Urine") = 0
                        dr("Drainage") = 0
                        dr("NG_Aspiration") = 0
                        dr("Vomitus") = 0
                        dr("Stool") = 0
                        dr("PH") = 0
                        dr("Bld") = 0
                        dr("Sug") = 0
                        dr("Ket") = 0
                        dr("ALB") = 0
                        dr("VomitColor") = ""
                        dr("Cvp_Line") = 0
                        dr("In_Other") = 0
                        dr("Out_Other") = 0
                        'dr[""] = 
                        'dr[""] = 
                        'dr[""] = 

                        ' dr[""] =

                        ds.Select_Patient_Intake_Output_Report.Rows.InsertAt(dr, pos)
                        pos = pos + 1
                        isaddrow = False
                    End If



                End If
                '}

                '}
            Next
        End If
        GridView_Intake.DataSource = ds.Select_Patient_Intake_Output_Report
        GridView_Intake.DataBind()
    End Sub
    Private Sub LoadHospitalHeader()
        Dim DS_HospitalHeader As New AdminReports()
        Dim DA_Hospital_Master As New AdminReportsTableAdapters.HospitalTableAdapter()
        DA_Hospital_Master.Fill(DS_HospitalHeader.Hospital, Convert.ToInt32(Session("HospitalID").ToString()))
        If DS_HospitalHeader.Tables("Hospital").Rows.Count > 0 Then
            Dim dr As DataRow = DS_HospitalHeader.Tables("Hospital").Rows(0)
            Label_Hospital.Text = dr("Hospital_Name").ToString().ToUpper()
            Label_Hosp_Ph.Text = dr("Hospital_Phone").ToString
            Label_Address.Text = dr("Hospital_Address").ToString
        End If
    End Sub
End Class
