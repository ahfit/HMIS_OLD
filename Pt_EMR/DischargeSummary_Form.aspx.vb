Imports System.Data
Imports System.Data.SqlClient
Imports System.Linq
Imports System.Collections
Imports System.Web.Services
Imports System.Collections.Generic

Partial Class DischargeSummary_Form
    Inherits System.Web.UI.Page

    Dim _DischargeSummaryTests As DataTable
    Dim _dtDischargeSummary As DataTable

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("YearlyNo") = Nothing Then
            Response.Redirect("~/login.aspx")
        End If
        txtFollowup.Text = DateTime.UtcNow.ToString("yyyy-MM-dd")
        GetDischargeSummaryDetail()

        GetCheifComplaintHeading()
        GetPathalogyTestResults()
        GetRadiologyTests()
        GetRadiologyResults()
        GetMedications()
        GetHospitalDischargeMedication()
        GetDiagnosis()



        If _dtDischargeSummary.Rows.Count > 0 Then
            GetAllergies()
            GetAdverseReaction()
            GetCheifComplaints()
            GetHistory()
            GetProcedures()
            GetConsultation()
            GetDischargeSummaryDiagnosis()
            GetInstructions()
        End If


        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        txtHistoryRemarks.Text = objDischargeSummary.GetHistoryRemarks(ddlHistory.SelectedValue, Session("YearlyNo"))

        Dim dtDischargeSummary As DataTable = objDischargeSummary.GetPatientDischargeSummaryByVisitNo(Session("YearlyNo"))
        If dtDischargeSummary.Rows.Count > 0 Then
            btnFinal.Disabled = True
            btnFinal.Attributes.Add("class", "btn_hacims_disabled")
        Else

            btnFinal.Attributes.Add("class", "btn_hacims")
        End If




    End Sub

    Private Sub GetDischargeSummaryDetail()
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

        _dtDischargeSummary = objDischargeSummary.GetDischargeSummaryDetails(Session("YearlyNo"))
    End Sub


#Region "Allergies And AdverseReaction"
    Private Sub GetAllergies()
       
        Try
            Dim dtAllergy As DataTable = _dtDischargeSummary.Select("MainHeading='Allergy'").CopyToDataTable()

            If dtAllergy.Rows.Count > 0 Then
                Dim allergy As String() = dtAllergy.Rows(0)("ParameterValue").ToString().Split(",")
                For Each result In allergy
                    Dim chkAllergy As CheckBox = PanelAllergy.FindControl("chk" + result.Replace("-", "").Replace(" ", "").Trim())

                    chkAllergy.Checked = True

                Next
                divAllergies.InnerText = dtAllergy.Rows(0)("ParameterValue").ToString()
            End If
        Catch
        End Try

    End Sub

    Private Sub GetAdverseReaction()
        Try

            Dim dtAdverseReaction As DataTable = _dtDischargeSummary.Select("MainHeading='Adverse Reaction'").CopyToDataTable()

            If dtAdverseReaction.Rows.Count > 0 Then

                divAdverseReaction.InnerText = dtAdverseReaction.Rows(0)("ParameterValue").ToString()
                txtAdverseReaction.Text = dtAdverseReaction.Rows(0)("ParameterValue").ToString()
            End If
        Catch
        End Try
    End Sub
#End Region


#Region "Compliant"

    Private Sub GetCheifComplaintHeading()
        Try
            Dim objDBManager As DbManager = New DbManager()
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

            Dim db As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("YearlyNo", Session("YearlyNo"))
             }


            Dim dtComplaint As DataTable = objDBManager.ExecuteDataTable("Presenting_Complaint_GetByVisitNo", "TreatmentConnectionString", sqlParams)
            ddlCheifComplaint.DataSource = dtComplaint
            ddlCheifComplaint.DataTextField = "heading"
            ddlCheifComplaint.DataValueField = "Complaint_ID"
            ddlCheifComplaint.DataBind()

            If dtComplaint.Rows.Count > 0 Then
                txtCheifComplaintRemarks.Text = objDischargeSummary.GetCheifComplaintRemarks(ddlCheifComplaint.SelectedValue, Session("YearlyNo"))
            End If

        Catch
        End Try
    End Sub
    Private Sub GetCheifComplaints()
        Try
            Dim dtComplaints As DataTable = _dtDischargeSummary.Select("MainHeading='Complaints' AND MainCategory='Cheif Complaint'").CopyToDataTable()
            rptComplaintRemarks.DataSource = dtComplaints
            rptComplaintRemarks.DataBind()
        Catch
        End Try
    End Sub

#End Region

#Region "ComplHistory"
    Private Sub GetHistory()
        Try
            Dim dtHistory As DataTable = _dtDischargeSummary.Select("MainHeading='History'").CopyToDataTable()
            rptHistory.DataSource = dtHistory
            rptHistory.DataBind()
        Catch
        End Try
    End Sub
#End Region

#Region "Hospital Course"
    Private Sub GetPathalogyTests()
        Try
            Dim objDBManager As DbManager = New DbManager()

            Dim db As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("@YearlyNo", Session("YearlyNo"))
             }


            rptPathologyTests.DataSource = objDBManager.ExecuteDataTable("Pathology_GetAllTestsByVisitNo", "Path_ConnectionString", sqlParams)
            rptPathologyTests.DataBind()

        Catch
            Throw
        End Try
    End Sub

    Protected Sub GetPathalogyTestResults()
        Try
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            Dim ds As DataSet = objDischargeSummary.GetPathalogyTestResultDischargeSummary(Session("YearlyNo"))

            rptTestResultsOuter.DataSource = ds.Tables(0)
            rptTestResultsOuter.DataBind()


            _DischargeSummaryTests = ds.Tables(0)


            GetPathalogyTests()
        Catch
        End Try
    End Sub


    Protected Sub rptPathologyTests_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptPathologyTests.ItemDataBound
        Try
            Dim chkTest As CheckBox = e.Item.FindControl("chkTest")

            Dim testId As String = DirectCast(e.Item.DataItem, DataRowView)("TestId").ToString()

            For Each test In _DischargeSummaryTests.Rows

                If test("TestId").ToString() = testId Then
                    chkTest.Checked = True
                End If

            Next
        Catch
        End Try
    End Sub

    Protected Sub GetRadiologyResults()
        Try
            Dim dtRadiologyFindings As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Radiology Findings'").CopyToDataTable()

            rptRadiologyFindings.DataSource = dtRadiologyFindings
            rptRadiologyFindings.DataBind()
        Catch
        End Try
    End Sub
    Private Sub GetRadiologyTests()
        Try
            Dim objDBManager As DbManager = New DbManager()

            Dim db As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("@YearlyNo", Session("YearlyNo"))
             }


            rptRadiologyTests.DataSource = objDBManager.ExecuteDataTable("Radiology_GetAllTestsByVisitNo", "RadiologyConnectionString", sqlParams)
            rptRadiologyTests.DataBind()

        Catch
        End Try
    End Sub
    Private Sub GetMedications()
        Try
            Dim objDBManager As DbManager = New DbManager()

            Dim db As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("@YearlyNo", Session("YearlyNo"))
             }


            rptMedications.DataSource = objDBManager.ExecuteDataTable("Medicine_GetPatientMedicationByVisitNo ", "TreatmentConnectionString", sqlParams)
            rptMedications.DataBind()
        Catch
        End Try
    End Sub
    Private Sub GetHospitalDischargeMedication()
        Try

            Dim objDBManager As DbManager = New DbManager()
            Dim sqlParams As SqlParameter() = {
                New SqlParameter("YearlyNo", Session("YearlyNo"))
            }
            Dim dtMedications As DataTable = objDBManager.ExecuteDataTable("DischargeSummary_GetHospitalDischargeMedication", "TreatmentConnectionString", sqlParams)

            DataList_ConfirmedPrescriptions.DataSource = dtMedications
            DataList_ConfirmedPrescriptions.DataBind()
        Catch
        End Try
    End Sub


    Protected Sub rptMedications_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles rptMedications.ItemDataBound
        Try
            Dim chkPriscription As CheckBox = e.Item.FindControl("chkPriscription")

            Dim priscriptionid As String = DirectCast(e.Item.DataItem, DataRowView)("Priscriptionid").ToString()
            If _dtDischargeSummary.Rows.Count > 0 Then

                Dim dtMedication As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Medication'").CopyToDataTable()

                If dtMedication.Rows.Count > 0 Then
                    Dim priscription As String() = dtMedication.Rows(0)("ParameterValue").ToString().Split(",")

                    For Each pres In priscription

                        If pres.Trim() = priscriptionid.Trim() Then
                            chkPriscription.Checked = True
                        End If

                    Next
                End If
            End If
        Catch
        End Try
    End Sub


    Private Sub GetProcedures()
        Try

            Dim dtProcedure As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Procedure'").CopyToDataTable()
            rptProcedure.DataSource = dtProcedure
            rptProcedure.DataBind()

        Catch
        End Try
    End Sub

    Private Sub GetConsultation()
        Try
            Dim dtConsultation As DataTable = _dtDischargeSummary.Select("MainHeading='Hospital Course' AND MainCategory='Summary of Consultation'").CopyToDataTable()

            If dtConsultation.Rows.Count > 0 Then
                txtSummaryofConsultation.Text = dtConsultation.Rows(0)("ParameterValue")
            End If
        Catch
        End Try
    End Sub
#End Region

#Region "Diagnosis"


    Private Sub GetDiagnosis()
        Try
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            rptDiagnosis.DataSource = objDischargeSummary.GetDiagnosis(Session("YearlyNo"), Session("registrationNo"), Session("emp_id"))
            rptDiagnosis.DataBind()
        Catch
        End Try
    End Sub
    Private Sub GetDischargeSummaryDiagnosis()
        Try
            Dim dtDiagnosis As DataTable = _dtDischargeSummary.Select("MainHeading='Diagnosis'").CopyToDataTable()
            rptDischargeSummaryDiagnosis.DataSource = dtDiagnosis
            rptDischargeSummaryDiagnosis.DataBind()
        Catch
        End Try
    End Sub



#End Region

#Region "Instructions"

    Private Sub GetInstructions()
        Try
            Dim dtInstruction As DataTable = _dtDischargeSummary.Select("MainHeading='Plan of Care' AND MainCategory='Instruction'").CopyToDataTable()
            rptDischargeInstruction.DataSource = dtInstruction
            rptDischargeInstruction.DataBind()
        Catch
        End Try
    End Sub

#End Region



End Class
