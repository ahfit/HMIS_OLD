Imports System
Imports System.Data
Imports System.Web
Imports System.Data.SqlClient
Imports System.Web.Services
Imports System.Web.Script.Serialization
Imports System.Linq
Imports System.Collections
Imports System.Collections.Generic

Partial Class Controls_DischargeSummarySegments
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Session("YearlyNo") = Nothing Then
            Throw New Exception("SessionOut")
        End If

        Dim Serializer As JavaScriptSerializer = New JavaScriptSerializer

        Dim action As String = Request.Form("Action")

      
        If action = "Save Allergy" Then

            Dim allergy As String = Request.Form("allergy")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Allergy", "", "", allergy.TrimEnd(","), "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")
            GetAllergies()

        ElseIf action = "Save Reaction" Then

            Dim reaction As String = Request.Form("Reaction")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Adverse Reaction", "", "", reaction.TrimEnd(","), "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")
            GetAdverseReaction()

        ElseIf action = "Get CheifComplaintRemarks" Then
            GetCheifComplaintRemarks()

        ElseIf action = "Save CheifComplaint" Then

            Dim cheifComplaintRemarks As String = Request.Form("CheifComplaintRemarks")
            Dim CheifComplaint As String = Request.Form("CheifComplaint")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Complaints", "Cheif Complaint", CheifComplaint, cheifComplaintRemarks, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, CheifComplaint)
            GetCheifComplaints()

        ElseIf action = "Get HistoryRemarks" Then
            GetHistoryRemarks()

        ElseIf action = "Save History" Then

            Dim historyRemarks As String = Request.Form("HistoryRemarks")
            Dim history As String = Request.Form("History")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("History", "", history, historyRemarks, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, history)
            GetHistory()

        ElseIf action = "Get Pathalogy Results" Then

            Dim TestId As String = Request.Form("TestId")
            Dim OrderId As String = Request.Form("OrderId")

            GetPathalogyTestResults(TestId, OrderId)

        ElseIf action = "Save Pathalogy Results" Then

            Dim TestId As String = Request.Form("TestId")
            Dim OrderId As String = Request.Form("OrderId")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Hospital Course", "Laboratory Findings", TestId, OrderId, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")

        ElseIf action = "Get Radiology Results" Then

            Dim TestId As String = Request.Form("TestId")
            Dim OrderId As String = Request.Form("OrderId")

            GetRadiologyTestResults(TestId, OrderId)

        ElseIf action = "Save Radiology Results" Then
            SaveRadiologyResults()

        ElseIf action = "Save Medications" Then

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            Dim medications As String = Request.Form("Medications")
            objDischargeSummary.SaveDischargeSummayDetails("Hospital Course", "Medication", "", medications.TrimEnd(","), "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")

        ElseIf action = "Save SummaryofConsultation" Then

            Dim SummaryofConsultation As String = Request.Form("SummaryofConsultation")

            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Hospital Course", "Summary of Consultation", "", SummaryofConsultation, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")

        ElseIf action = "Save Procedures" Then


            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            Dim proceduresArray As List(Of DischargeSummarySegment) = Serializer.Deserialize(Of List(Of DischargeSummarySegment))(Request.Form("ProceduresArray"))
            SaveProcedure(proceduresArray)

        ElseIf action = "Save Diagnosis" Then

            SaveDiagnosis()

        ElseIf action = "Save HospitalInstructions" Then
            Dim EnglishIns As String = Request.Form("EnglishIns")
            Dim UrduIns As String = Request.Form("UrduIns")
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

            objDischargeSummary.saveHospitalInstructions(UrduIns, EnglishIns, Session("HospitalId").ToString())
            GetHospitalInstructions()
        ElseIf action = "Save Instructions" Then
            saveInstructions()

        ElseIf action = "Get CategoryAndRoute" Then

            Dim DrugCategory As String = Request.Form("DrugCategory")
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            Dim dtCategory As DataTable = objDischargeSummary.GetCategory(DrugCategory)

            If dtCategory.Rows.Count > 0 Then
                ltrRoute.Text = dtCategory.Rows(0)("Category")
            End If

            Dim ItemCode As String = Request.Form("ItemCode")

            Dim route As DataTable = objDischargeSummary.GetRoute(ItemCode)
            DropDownList_route.DataSource = route
            DropDownList_route.DataTextField = "Description"
            DropDownList_route.DataValueField = "Id"

            DropDownList_route.DataBind()

        ElseIf action = "Get FrequenciesDetails" Then
            Dim frequencyId As String = Request.Form("FrequencyId")
            GetFrequenciesDetails(frequencyId)

        ElseIf action = "Save DischargeMedication" Then
         
            saveDischargeMedication()

        ElseIf action = "Add Diagnosis" Then

            AddDiagnosis()


        ElseIf action = "Get HospitalInstructions" Then          
            GetHospitalInstructions()

        ElseIf action = "Delete Instructions" Then
            Dim InstId As String = Request.Form("InstId")
            Dim objDBManager As DbManager = New DbManager()


            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("@InstId", InstId)
             }
            objDBManager.ExecuteNonQuery("DischargeSummary_Instructions_ChangeStatus", "TreatmentConnectionString", sqlParams)

        ElseIf action = "Final" Then            
            Dim objDBManager As DbManager = New DbManager()

            Dim sqlParams As SqlParameter() = {
                     New SqlParameter("@Reg_No", Session("RegistrationNo")),
                     New SqlParameter("@Yearly_No", Session("YearlyNo")),
                     New SqlParameter("@Ward_Bed_Id", 0),
                     New SqlParameter("@Admitting_Consultant_Id", 0),
                     New SqlParameter("@Discharge_By_Doctor", Session("emp_id")),
                     New SqlParameter("@Discharge_Datetime", DateTime.Now),
                     New SqlParameter("@Next_Visit_Date", ""),
                     New SqlParameter("@NextVisit_Sub_DeptId", 0),
                     New SqlParameter("@Refer_To_Hospital", ""),
                     New SqlParameter("@Patient_OutCome", ""),
                     New SqlParameter("@Followup_Instructions", ""),
                     New SqlParameter("@Discharge_From_SubDeptId", 0),
                     New SqlParameter("@Discharge_Type", "")
             }

            objDBManager.ExecuteNonQuery("Patient_DischargeSummary_Insert", "TreatmentConnectionString", sqlParams)


        End If



    End Sub
  
    
    Protected Sub GetAllergies()
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim dtAllergy As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Allergy", "")

        If dtAllergy.Rows.Count > 0 Then
            ltrAllergy.Text = dtAllergy.Rows(0)("ParameterValue").ToString()

        End If        

    End Sub
    Private Sub GetAdverseReaction()        
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim dtAdverseReaction As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Adverse Reaction", "")

        If dtAdverseReaction.Rows.Count > 0 Then

            ltrReaction.Text = dtAdverseReaction.Rows(0)("ParameterValue").ToString()
        End If

    End Sub

    Private Sub GetCheifComplaints()
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim dtComplaints As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Complaints", "Cheif Complaint")
        rptComplaintRemarks.DataSource = dtComplaints
        rptComplaintRemarks.DataBind()
    End Sub
    Public Sub GetCheifComplaintRemarks()

        Dim CheifComplaintId As String = Request.Form("CheifComplaintId")

        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

        ltrComplaint.Text = objDischargeSummary.GetCheifComplaintRemarks(CheifComplaintId, Session("YearlyNo"))


    End Sub
    Private Sub GetHistory()
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim dtHistory As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "History", "")
        rptHistory.DataSource = dtHistory
        rptHistory.DataBind()
    End Sub

    Public Sub GetHistoryRemarks()

        Dim MgCode As String = Request.Form("MgCode")

        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        ltrHistoryRemarks.Text = objDischargeSummary.GetHistoryRemarks(MgCode, Session("YearlyNo"))

    End Sub

    Protected Sub GetPathalogyTestResults(ByVal TestId As String, ByVal OrderId As String)
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim ds As DataSet = objDischargeSummary.GetPathalogyTestResults(TestId, OrderId)
        rptTestResultsOuter.DataSource = ds.Tables(0)
        rptTestResultsOuter.DataBind()
    End Sub

    Protected Sub GetRadiologyTestResults(ByVal TestId As String, ByVal OrderId As String)
        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("@TestId", TestId),
                New SqlParameter("@OrderId", OrderId),
                 New SqlParameter("@YearlyNo", Session("YearlyNo"))
         }


        Dim dtResults As DataTable = objDBManager.ExecuteDataTable("Radiology_GetTestResultByTestId", "RadiologyConnectionString", sqlParams)

        ltrRadiologyTestResults.Text = dtResults.Rows(0)("Report")

    End Sub

    Protected Sub SaveRadiologyResults()
        Dim Serializer As JavaScriptSerializer = New JavaScriptSerializer
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim RadiologyResults As List(Of DischargeSummarySegment) = Serializer.Deserialize(Of List(Of DischargeSummarySegment))(Request.Form("RadiologyResults"))

        For Each result In RadiologyResults

            objDischargeSummary.SaveDischargeSummayDetails("Hospital Course", "Radiology Findings", result.TestName, result.TestResult, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, result.TestName)
        Next

        Dim dt As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Hospital Course", "Radiology Findings")

        rptRadiologyFindings.DataSource = dt
        rptRadiologyFindings.DataBind()

    End Sub
   
    Protected Sub SaveDiagnosis()
        Dim Serializer As JavaScriptSerializer = New JavaScriptSerializer
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

        Dim diagnosisList As List(Of DischargeSummarySegment) = Serializer.Deserialize(Of List(Of DischargeSummarySegment))(Request.Form("DiagnosisArr"))

        For Each result In diagnosisList

            objDischargeSummary.SaveDischargeSummayDetails("Diagnosis", result.DiagnoseType, result.DiagnoseName, "", "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, result.DiagnoseName)

        Next

        Dim dt As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Diagnosis", "")


        rptDischargeSummaryDiagnosis.DataSource = dt
        rptDischargeSummaryDiagnosis.DataBind()
    End Sub

    Protected Sub SaveProcedure(ByVal procedureList As List(Of DischargeSummarySegment))
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        For Each result In procedureList

            objDischargeSummary.SaveDischargeSummayDetails("Hospital Course", "Procedure", result.ProceduresName, result.ProceduresRemarks, "", Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")

        Next
    End Sub

    Protected Sub GetHospitalInstructions()
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim dtInstructions As DataTable = objDischargeSummary.GetInstructions(Session("HospitalId").ToString())
        rptInstructions.DataSource = dtInstructions
        rptInstructions.DataBind()
    End Sub

    Protected Sub saveDischargeMedication()     
        Dim medCode As String = Request.Form("medCode")
        Dim dosage As String = Request.Form("dosage")
        Dim routeId As String = Request.Form("routeId")
        Dim dilution As String = Request.Form("dilution")
        Dim meal As String = Request.Form("meal")
        Dim frequencyId As String = Request.Form("frequencyId")
        Dim instruction As String = Request.Form("instruction")
        Dim days As String = Request.Form("days")
        Dim startDate As String = Request.Form("startDate")
        Dim dose As String = Request.Form("dose")
        Dim ct As String = Request.Form("ct")
        Dim duration As String = Request.Form("duration")
        Dim medicineAdviceCategoryID As String = Request.Form("MedicineAdviceCategoryID")
        Dim medicationStatus As String = Request.Form("medicationStatus")

        Dim newDate As Date = Date.ParseExact(startDate, "dd/MM/yyyy", System.Globalization.DateTimeFormatInfo.InvariantInfo)
        Dim endDate As Date = newDate.AddDays(days - 1)


        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                New SqlParameter("Yearly_NO", Session("YearlyNo")),
                New SqlParameter("Med_Code", medCode),
                New SqlParameter("Registration_NO", Session("registrationNo")),
                New SqlParameter("Dosage", dosage),
                New SqlParameter("Route_ID", routeId),
                New SqlParameter("Dilution", dilution),
                New SqlParameter("Meal", meal),
                New SqlParameter("Frequency_ID", frequencyId),
                New SqlParameter("days", days),
                New SqlParameter("emp_ID", Session("emp_id")),
                New SqlParameter("Instruction", instruction),
                New SqlParameter("StartDate", newDate),
                New SqlParameter("EndDate", endDate),
                New SqlParameter("Dose", dose),
                New SqlParameter("CT", ct),               
                New SqlParameter("Duration", duration),
                New SqlParameter("Medicine_Advice_Category_ID", medicineAdviceCategoryID),
                New SqlParameter("Medication_Status", medicationStatus)
           }

        objDBManager.ExecuteNonQuery("Insert_Patient_Prescription_Detail", "TreatmentConnectionString", sqlParams)
        Dim priscriptionId As String = sqlParams(0).Value

        saveFrequencyDetails(priscriptionId)

        If Boolean.Parse(Request.Form("chkMedicineStatus")) Then
            saveDischargeSummaryMedicaion(priscriptionId)
        End If

        If Not (Request.Form("CallFrom") = "Medication") Then
            Dim sqlParamsMed As SqlParameter() = {
            New SqlParameter("YearlyNo", Session("YearlyNo"))
        }
            Dim dtMedications As DataTable = objDBManager.ExecuteDataTable("DischargeSummary_GetHospitalDischargeMedication", "TreatmentConnectionString", sqlParamsMed)

            DataList_ConfirmedPrescriptions.DataSource = dtMedications
            DataList_ConfirmedPrescriptions.DataBind()
        End If



    End Sub

    Protected Sub saveFrequencyDetails(ByVal priscriptionId As String)
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        Dim Serialize As JavaScriptSerializer = New JavaScriptSerializer

        Dim frequencyArr As List(Of DischargeSummarySegment) = Serialize.Deserialize(Of List(Of DischargeSummarySegment))(Request.Form("FrequencyArr"))

        Dim objDBManager As DbManager = New DbManager()
        For Each result In frequencyArr
            Dim sqlParams As SqlParameter() = {
                    New SqlParameter("Dosage", result.Dosage),
                    New SqlParameter("Prescription_Id", priscriptionId),
                    New SqlParameter("Frequency_Sub_Id", result.FrequencySubId)
               }

            objDBManager.ExecuteNonQuery("Insert_Patient_Frequency_Detail", "TreatmentConnectionString", sqlParams)

        Next
    End Sub
    Private Sub saveDischargeSummaryMedicaion(ByVal PrescriptionId As String)
        Dim objDBManager As DbManager = New DbManager()


        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("@PrescriptionId", PrescriptionId)
         }


        Dim dtMed As DataTable = objDBManager.ExecuteDataTable("GetMedicine_ByPrescription_Id", "TreatmentConnectionString", sqlParams)
        If dtMed.Rows.Count > 0 Then
            Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
            objDischargeSummary.SaveDischargeSummayDetails("Plan of Care", "Discharge Medication", "", dtMed.Rows(0)("MedicineName").ToString() + " " + dtMed.Rows(0)("Para").ToString(), dtMed.Rows(0)("ParaUrdu").ToString(), Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")

        End If


    End Sub

    Protected Sub GetFrequenciesDetails(ByVal frequencyId As String)
        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                New SqlParameter("id", frequencyId)
           }

        Dim dt As DataTable = objDBManager.ExecuteDataTable("Frequency_GetMedicineFrequencyDetail", "STOREConnectionString", sqlParams)
        DataList_Frequency.DataSource = dt
        DataList_Frequency.DataKeyField = "Frequency_Sub_Id"

        DataList_Frequency.DataBind()
    End Sub
    Protected Sub AddDiagnosis()

        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                New SqlParameter("emp_id", Session("emp_id")),
                New SqlParameter("YearlyNo", Session("YearlyNo")),
                New SqlParameter("RegNo", Session("registrationNo")),
                New SqlParameter("Past", False),
                New SqlParameter("Provisional", True),
                New SqlParameter("DiseaseName", Request.Form("DiseaseName"))
           }

        objDBManager.ExecuteNonQuery("PT_Diagnosis_Add", "TreatmentConnectionString", sqlParams)
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()
        rptDiagnosis.DataSource = objDischargeSummary.GetDiagnosis(Session("YearlyNo"), Session("registrationNo"), Session("emp_id"))
        rptDiagnosis.DataBind()

    End Sub

    Protected Sub saveInstructions()
        Dim Serializer As JavaScriptSerializer = New JavaScriptSerializer
        Dim objDischargeSummary As DischargeSummary = New DischargeSummary()

        Dim instructionsArray As List(Of DischargeSummarySegment) = Serializer.Deserialize(Of List(Of DischargeSummarySegment))(Request.Form("InstructionsArray"))
        For Each result In instructionsArray
            objDischargeSummary.SaveDischargeSummayDetails("Plan of Care", "Instruction", "", result.EngInstruction, result.UrduInstruction, Session("YearlyNo"), Session("RegistrationNo"), Session("emp_id"), DateTime.Now, "")
        Next

        Dim dt As DataTable = objDischargeSummary.GetDischargeSummaryDetailBySegment(Session("YearlyNo"), "Plan of Care", "Instruction")
        rptDischargeInstruction.DataSource = dt
        rptDischargeInstruction.DataBind()

    End Sub

    <WebMethod()>
    Public Shared Function GetPatientMed(ByVal ItemCode As String) As String

        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("ItemCode", ItemCode),
                 New SqlParameter("VisitNo", HttpContext.Current.Session("YearlyNo"))
         }


        Dim dtpatientMedicine As DataTable = objDBManager.ExecuteDataTable("GetPatientMedByItemCode", "TreatmentConnectionString", sqlParams)

        Dim patientMedicine As New PatientMedicine()

        If dtpatientMedicine.Rows.Count > 0 Then
            patientMedicine.MedName = dtpatientMedicine.Rows(0)("Item_Full_Name")
            patientMedicine.Dosage = dtpatientMedicine.Rows(0)("Dosage")
            patientMedicine.RouteId = dtpatientMedicine.Rows(0)("Route_ID")
            patientMedicine.FrequencyId = dtpatientMedicine.Rows(0)("Frequency_ID")
            patientMedicine.Days = dtpatientMedicine.Rows(0)("days")
            patientMedicine.DrugCategory = dtpatientMedicine.Rows(0)("Drug_Category")
            patientMedicine.Instruction = dtpatientMedicine.Rows(0)("Instruction")

        End If

        Dim jSearializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Return jSearializer.Serialize(patientMedicine)

    End Function

    <WebMethod()>
    Public Shared Function AlreadySaveMed(ByVal MedCode As String, ByVal Days As String, ByVal StartDate As String) As String
        Dim newDate As Date = Date.ParseExact(StartDate, "dd/MM/yyyy", System.Globalization.DateTimeFormatInfo.InvariantInfo)
        Dim objDBManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("medCode", MedCode),
                 New SqlParameter("Reg", HttpContext.Current.Session("RegistrationNo")),
                 New SqlParameter("days", Days),
                 New SqlParameter("StartDate", newDate)
         }


        Dim dtpatientMedicine As DataTable = objDBManager.ExecuteDataTable("AlreadySaveMed", "TreatmentConnectionString", sqlParams)

        Dim patientMedicine As New Alreadysave()

        If dtpatientMedicine.Rows.Count > 0 Then
            patientMedicine.Datetime = dtpatientMedicine.Rows(0)("date")
            patientMedicine.day = dtpatientMedicine.Rows(0)("days")

        End If

        Dim jSearializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Return jSearializer.Serialize(patientMedicine)

    End Function

    Public Class Alreadysave
        Private _date As String
        Private _day As String
        Public Property Datetime As String
            Get
                Return _date
            End Get
            Set(value As String)
                _date = value
            End Set
        End Property

        Public Property day As String
            Get
                Return _day
            End Get
            Set(value As String)
                _day = value
            End Set
        End Property
    End Class

End Class
Public Class PatientMedicine
    Private _MedName As String
    Private _Dosage As String
    Private _RouteId As String
    Private _FrequencyId As String
    Private _Days As String
    Private _DrugCategory As String
    Private _Instruction As String

    Public Property MedName As String
        Get
            Return _MedName
        End Get
        Set(value As String)
            _MedName = value
        End Set
    End Property
    Public Property Dosage As String
        Get
            Return _Dosage
        End Get
        Set(value As String)
            _Dosage = value
        End Set
    End Property
    Public Property RouteId As String
        Get
            Return _RouteId
        End Get
        Set(value As String)
            _RouteId = value
        End Set
    End Property
    Public Property FrequencyId As String
        Get
            Return _FrequencyId
        End Get
        Set(value As String)
            _FrequencyId = value
        End Set
    End Property
    Public Property Days As String
        Get
            Return _Days
        End Get
        Set(value As String)
            _Days = value
        End Set
    End Property
    Public Property DrugCategory As String
        Get
            Return _DrugCategory
        End Get
        Set(value As String)
            _DrugCategory = value
        End Set
    End Property
    Public Property Instruction As String
        Get
            Return _Instruction
        End Get
        Set(value As String)
            _Instruction = value
        End Set
    End Property

End Class

Public Class DischargeSummarySegment


    Private _TestName As String
    Private _TestResult As String

    Private _DiagnoseName As String
    Private _DiagnoseType As String
    Private _DiagnoseCode As String

    Private _ProceduresName As String
    Private _ProceduresRemarks As String

    Private _PrescriptionId As String

    Private _Dosage As String
    Private _FrequencySubId As String

    Private _EngInstruction As String
    Private _UrduInstruction As String


    Public Property TestName As String
        Get
            Return _TestName
        End Get
        Set(value As String)
            _TestName = value
        End Set
    End Property

    Public Property TestResult As String
        Get
            Return _TestResult
        End Get
        Set(value As String)
            _TestResult = value
        End Set
    End Property

    Public Property DiagnoseName As String
        Get
            Return _DiagnoseName
        End Get
        Set(value As String)
            _DiagnoseName = value
        End Set
    End Property

    Public Property DiagnoseType As String
        Get
            Return _DiagnoseType
        End Get
        Set(value As String)
            _DiagnoseType = value
        End Set
    End Property
    Public Property DiagnoseCode As String
        Get
            Return _DiagnoseCode
        End Get
        Set(value As String)
            _DiagnoseCode = value
        End Set
    End Property
    Public Property ProceduresName As String
        Get
            Return _ProceduresName
        End Get
        Set(value As String)
            _ProceduresName = value
        End Set
    End Property

    Public Property ProceduresRemarks As String
        Get
            Return _ProceduresRemarks
        End Get
        Set(value As String)
            _ProceduresRemarks = value
        End Set
    End Property

    Public Property PrescriptionId As String
        Get
            Return _PrescriptionId
        End Get
        Set(value As String)
            _PrescriptionId = value
        End Set
    End Property

    Public Property Dosage As String
        Get
            Return _Dosage
        End Get
        Set(value As String)
            _Dosage = value
        End Set
    End Property

    Public Property FrequencySubId As String
        Get
            Return _FrequencySubId
        End Get
        Set(value As String)
            _FrequencySubId = value
        End Set
    End Property


    Public Property EngInstruction As String
        Get
            Return _EngInstruction
        End Get
        Set(value As String)
            _EngInstruction = value
        End Set
    End Property

    Public Property UrduInstruction As String
        Get
            Return _UrduInstruction
        End Get
        Set(value As String)
            _UrduInstruction = value
        End Set
    End Property
End Class