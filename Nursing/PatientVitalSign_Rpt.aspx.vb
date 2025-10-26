Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration


Partial Class Patient_Registration_PatientFaceSheet
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            load_hospitalData()

        End If
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()


        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")

        Dim regNo As String = Session("RegistrationNo")
        Dim obj As New PatientFaceSheet()
        'Dim tbl As DataTable = obj.GetData("281030204029036043036043050036043043036036036043")
        Dim tbl As DataTable = obj.GetData(regNo, CInt(Session("YearlyNo")))

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

        Fill_Grid()

    End Sub

    Sub Fill_Grid()
        Dim ds As New PatientVital
        Dim da As New PatientVitalTableAdapters.Patient_VitalsTableAdapter
        Dim da1 As New PatientVitalTableAdapters.VitalGridTableAdapter
        da.Fill(ds.Tables("Patient_Vitals"), Session("registrationNo"), Session("YearlyNo"))
        da1.Fill(ds.Tables("vitalGrid"), Session("registrationNo"), Session("YearlyNo"))
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
        GridViewVitals.DataBind()
    End Sub

    Private Sub load_hospitalData()
        Dim conect As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
        Dim con As New SqlConnection(conect)
        Dim command As New SqlCommand("usp_ReportHeaderinfo", con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@Hospital_ID", Session("HospitalID"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader()
        While reader.Read()

            Try
                Label2.Text = reader("Hospital_Name").ToString()
            Catch ex As Exception
            End Try

            Try
                Label3.Text = reader("Hospital_Address").ToString()
            Catch ex As Exception
            End Try

            Try
                lbl2.Text = reader("Hospital_Phone").ToString()
            Catch ex As Exception
            End Try

        End While

        con.Close()
        con.Dispose()

    End Sub


    Private Sub showReport()

        Dim ds As New PatientVital
        Dim da As New PatientVitalTableAdapters.Patient_VitalsTableAdapter
        Dim da1 As New PatientVitalTableAdapters.VitalGridTableAdapter
        da.Fill(ds.Tables("Patient_Vitals"), Session("registrationNo"), Session("YearlyNo"))
        da1.Fill(ds.Tables("vitalGrid"), Session("registrationNo"), Session("YearlyNo"))
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

                    'If Not String.IsNullOrEmpty(ds.Tables("VitalGrid").Rows(i).Item("Name")) Then
                    '    ds.Tables("VitalGrid").Rows(j).Item("Name") = ENC.Encrypt_Main(ds.Tables("VitalGrid").Rows(i).Item("Name"), False)
                    'End If

                End If
            Next
        Next
        ds.Tables("VitalGrid").Rows(0).Item("Name1") = ENC.Encrypt_Main(ds.Tables("VitalGrid").Rows(0).Item("Name").ToString(), False)
        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Nursing/PatientVitalSign_Rpt.rdlc")
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim repDs As ReportDataSource = New ReportDataSource
        repDs.Name = "DataSet1"
        repDs.Value = ds.Tables("vitalGrid")
        ReportViewer1.LocalReport.DataSources.Add(repDs)
    End Sub

    Protected Sub btnShowRpt_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnShowRpt.Click
        showReport()
    End Sub
End Class
