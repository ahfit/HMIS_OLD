Imports System.Data
Imports System.Data.SqlClient
Imports System.Linq
Imports System.Collections
Partial Class Pt_EMR_DischargeSummary
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Dim _dtDischargeSummary As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'If Session("HospitalID") = Nothing Then
        '    Response.Redirect("~/login.aspx")
        'End If
        'LoadHospitalHeader()

        'If Not Request.QueryString("RegNo") Is Nothing Then
        '    Session.Add("RegistrationNo", Request.QueryString("RegNo"))
        '    Session.Add("YearlyNo", Request.QueryString("YearlyNo"))

        'End If
        'Dim yearlyNo As Integer = Session("YearlyNo")
        'Dim regNo As String = Session("RegistrationNo")


        'GetPatientInfo(regNo, yearlyNo)
        'GetDischargeSummaryDetail(yearlyNo)
    End Sub

    'Private Sub LoadHospitalHeader()
    '    Dim objDBManager As DbManager = New DbManager()

    '    Dim db As DbManager = New DbManager()
    '    Dim sqlParams As SqlParameter() = {
    '             New SqlParameter("HospitalID", Session("HospitalID").ToString())
    '     }


    '    Dim dtHospitalInfo As DataTable = objDBManager.ExecuteStoreProcedure("GetHospitalInformation", "Basic_Data_ConnectionString", sqlParams)

    '    If dtHospitalInfo.Rows.Count > 0 Then
    '        Dim dr As DataRow = dtHospitalInfo.Rows(0)
    '        lblHospitalName.Text = dr("HospitalName").ToString().ToUpper()
    '        lblHospitalPhone.Text = "Phone No: " + dr("HospitalPhone").ToString()
    '        lblHospitalAddress.Text = dr("HospitalAddress").ToString
    '    End If
    'End Sub
    'Private Sub GetPatientInfo(ByVal regNo As String, ByVal yearlyNo As String)
    '    Dim objDBManager As DbManager = New DbManager()

    '    Dim db As DbManager = New DbManager()
    '    Dim sqlParams As SqlParameter() = {
    '             New SqlParameter("RegNo", regNo),
    '             New SqlParameter("payID", yearlyNo)
    '     }


    '    Dim dtPatientInfo As DataTable = objDBManager.ExecuteStoreProcedure("PatientFaceSheetReport", "Reg_ConnectionString", sqlParams)

    '    If dtPatientInfo.Rows.Count > 0 Then

    '        lblMRNo.Text = ENC.Encrypt_Main(dtPatientInfo.Rows(0)("RegNo").ToString(), False)
    '        lblDateAdmission.Text = dtPatientInfo.Rows(0)("RegDateTime").ToString()

    '        lblFileNo.Text = yearlyNo           

    '        lblPatientName.Text = dtPatientInfo.Rows(0)("Prefix").ToString().Replace(".", "").Trim() + ". " + ENC.Encrypt_Main(dtPatientInfo.Rows(0)("PFName").ToString(), False) + " " + ENC.Encrypt_Main(dtPatientInfo.Rows(0)("PMName").ToString(), False) + " " + ENC.Encrypt_Main(dtPatientInfo.Rows(0)("PLName").ToString(), False)
    '        lblDataDischarge.Text = dtPatientInfo.Rows(0)("DischargeDate").ToString()
    '        lblAge.Text = dtPatientInfo.Rows(0)("Age").ToString()

    '        If Not dtPatientInfo.Rows(0)("Ward_Name").ToString() = Nothing Then
    '            lblWardRoomNo.Text = dtPatientInfo.Rows(0)("Ward_Name").ToString() + " / " + dtPatientInfo.Rows(0)("Bed_No").ToString()
    '        End If

    '        lblGender.Text = dtPatientInfo.Rows(0)("Gender").ToString()

    '        lblAdmitingDoctor.Text = dtPatientInfo.Rows(0)("Employee").ToString()

    '        lblAddress.Text = dtPatientInfo.Rows(0)("House_No").ToString() + " " + dtPatientInfo.Rows(0)("StreetAddress").ToString() + " " + dtPatientInfo.Rows(0)("TehsilName").ToString() + " , " + dtPatientInfo.Rows(0)("ProvinceName").ToString() + " " + dtPatientInfo.Rows(0)("CountryName").ToString()


    '        If dtPatientInfo.Rows(0)("HomePhone").ToString() = Nothing Then
    '            lblContactNo.Text = dtPatientInfo.Rows(0)("MobilePhone").ToString()
    '        Else
    '            If dtPatientInfo.Rows(0)("MobilePhone").ToString() = Nothing Then
    '                lblContactNo.Text = dtPatientInfo.Rows(0)("HomePhone").ToString()
    '            Else
    '                lblContactNo.Text = dtPatientInfo.Rows(0)("HomePhone").ToString() + ", " + dtPatientInfo.Rows(0)("MobilePhone").ToString()
    '            End If

    '        End If

    '        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")
    '        lblEmail.Text = dtPatientInfo.Rows(0)("email_address").ToString()

    '    End If

    'End Sub


    'Private Sub GetDischargeSummaryDetail(ByVal yearlyNo As String)

    '    Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

    '    _dtDischargeSummary = objDischargeSummary.GetDischargeSummaryDetails(yearlyNo)

    '    If _dtDischargeSummary.Rows.Count > 0 Then

    '        GetAllergies()
    '        GetAdverseReaction()
    '        BindComplaint()
    '        BindHistory()
    '        BindDiagnosis()
    '        BindLaboratoryFindings()
    '        BindRadiologyFindings()
    '        BindMedication()
    '        BindConsultation()
    '        BindProcedure()
    '        BindDischargeMedication()
    '        BindInstruction()

    '        Dim dtDischargeSummary As DataTable = objDischargeSummary.GetPatientDischargeSummaryByVisitNo(yearlyNo)
    '        If dtDischargeSummary.Rows.Count > 0 Then
    '            lblPhysicianId.Text = dtDischargeSummary.Rows(0)("DoctorName") + "(" + dtDischargeSummary.Rows(0)("DeptName") + " - " + dtDischargeSummary.Rows(0)("DesignationName") + ")"
    '        End If


    '    End If

    'End Sub

    'Private Sub GetAllergies()
    '    Try
    '        Dim dtAllergies As DataTable = _dtDischargeSummary.Select("MainHeading='Allergy'").CopyToDataTable()

    '        If dtAllergies.Rows.Count > 0 Then
    '            divAllergies.InnerText = dtAllergies.Rows(0)("ParameterValue").ToString()
    '        End If
    '    Catch
    '    End Try
    'End Sub
    'Private Sub GetAdverseReaction()
    '    Try
    '        Dim dtAdverseReaction As DataTable = _dtDischargeSummary.Select("MainHeading='Adverse Reaction'").CopyToDataTable()


    '        If dtAdverseReaction.Rows.Count > 0 Then

    '            divAdverseReaction.InnerText = dtAdverseReaction.Rows(0)("ParameterValue").ToString()
    '        End If
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindComplaint()
    '    Try
    '        Dim dtComplaint As DataTable = _dtDischargeSummary.Select("MainHeading='Complaints' AND MainCategory='Cheif Complaint'").CopyToDataTable()

    '        rptComplaint.DataSource = dtComplaint
    '        rptComplaint.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindHistory()
    '    Try
    '        Dim dtHistory As DataTable = _dtDischargeSummary.Select("MainHeading='History'").CopyToDataTable()

    '        rptHistory.DataSource = dtHistory
    '        rptHistory.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindDiagnosis()
    '    Try
    '        Dim dtAdmitedDiagnosis As DataTable = _dtDischargeSummary.Select("MainHeading='Diagnosis' AND MainCategory='Admission Diagnosis'").CopyToDataTable()

    '        rptAdmitedDiagnosis.DataSource = dtAdmitedDiagnosis
    '        rptAdmitedDiagnosis.DataBind()

    '        Dim dtDischargeDiagnosis As DataTable = _dtDischargeSummary.Select("MainHeading='Diagnosis' AND MainCategory='Discharge Diagnosis'").CopyToDataTable()

    '        rptDischargeDiagnosis.DataSource = dtDischargeDiagnosis
    '        rptDischargeDiagnosis.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindLaboratoryFindings()
    '    Try

    '        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
    '        Dim ds As DataSet = objDischargeSummary.GetPathalogyTestResultDischargeSummary(Session("YearlyNo"))

    '        rptTestResultsOuter.DataSource = ds.Tables(0)
    '        rptTestResultsOuter.DataBind()

    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindRadiologyFindings()
    '    Try
    '        Dim dtRadiologyFindings As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Radiology Findings'").CopyToDataTable()

    '        rptRadiologyFindings.DataSource = dtRadiologyFindings
    '        rptRadiologyFindings.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindMedication()
    '    Try

    '        Dim objDBManager As DbManager = New DbManager()
    '        Dim sqlParams As SqlParameter() = {
    '            New SqlParameter("YearlyNo", Session("YearlyNo"))
    '        }
    '        Dim dtMedications As DataTable = objDBManager.ExecuteStoreProcedure("DischargeSummary_GetPatientMedications", "TreatmentConnectionString", sqlParams)

    '        rptMedication.DataSource = dtMedications
    '        rptMedication.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindConsultation()
    '    Try
    '        Dim dtConsultation As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Summary of Consultation'").CopyToDataTable()

    '        rptConsultation.DataSource = dtConsultation
    '        rptConsultation.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindProcedure()
    '    Try
    '        Dim dtProcedure As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Procedure'").CopyToDataTable()

    '        rptProcedure.DataSource = dtProcedure
    '        rptProcedure.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindDischargeMedication()
    '    Try
    '        Dim dtDischargeMedication As DataTable = _dtDischargeSummary.Select("MainHeading='Plan of Care' AND MainCategory='Discharge Medication'").CopyToDataTable()

    '        rptDischargeMedication.DataSource = dtDischargeMedication
    '        rptDischargeMedication.DataBind()
    '    Catch
    '    End Try
    'End Sub
    'Private Sub BindInstruction()
    '    Try
    '        Dim dtInstruction As DataTable = _dtDischargeSummary.Select("MainHeading='Plan of Care' AND MainCategory='Instruction'").CopyToDataTable()

    '        rptInstruction.DataSource = dtInstruction
    '        rptInstruction.DataBind()
    '    Catch
    '    End Try
    'End Sub



End Class
