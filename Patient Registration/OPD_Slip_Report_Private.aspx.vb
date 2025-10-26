Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Registration_OPD_Slip_Report_Private
    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Dim conn As String = Convert.ToString(ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString"))
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Not Page.IsPostBack Then
            Session("YearlyNo") = Session("PayId")
            Dim spmid As String = CommonDBFunctions.GetDBSingleValue(conn, "GetSPMID", Session("RegistrationNo"), Session("PayId"), String.Empty, String.Empty, String.Empty)
            hlnkPrintReceipt.NavigateUrl = "~/Patient Billing/patientServices.aspx?SPMID=" + spmid
            hlnkPrintReceipt.Visible = True
            ShowReport()
            'CreatePDF(Convert.ToString(Session("RegistrationNo")))
        End If

        LoadHospitalHeader()
        lblDate.Text = DateTime.Now.ToString("dd/MMM/yyyy hh:mm:ss")

        Dim regNo As String = Session("RegistrationNo")
        Dim PayId As String = Session("PayId")
        Session("YearlyNo") = Session("PayId")
        'Dim obj As New PatientFaceSheet()
        'Dim tbl As DataTable = obj.GetData("281030204029036043036043050036043043036036036043")
        'Dim tbl As DataTable = obj.GetData(regNo)
        Dim query As String = "SELECT     Payment_No as [Receipt No] FROM         Advance_Payment WHERE     (RegNo = '" + regNo + "') AND (YearlyNo = " + PayId + ")"
        Dim cn As New SqlConnection(conn)
        Dim cmd As New SqlCommand(query, cn)
        cn.Open()
        'Label_CashSlipNo.Text = Convert.ToString(cmd.ExecuteScalar())
        cn.Close()

        Dim SQLAdapter As New SqlDataAdapter()

        Dim qry As String = "SELECT Payment.PayID, Payment.ReferFrom, Payment.RegNo, Payment.PatientType, CONVERT(varchar, Payment.DateTime, 103) AS Dte, CONVERT(varchar, Payment.DateTime, 108) AS Time, Patient.Prefix, Patient.PFName, Patient.PMName, Patient.PLName, Patient.Relation, ISNULL(Patient.RFName, '')  + ' ' + ISNULL(Patient.RMName, '') + ' ' + ISNULL(Patient.RLName, '') AS PR_Name, CONVERT(varchar, Patient.Age) + ' ' + Patient.AgeType AS Age, Gender.Gender, Payment.Refer_Department, Patient.House_No, ISNULL(Department.Dept_Name, '') + ' (' + ISNULL(SubDepartment.SubDept_Name, '') + ')' AS Dept_Name, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Doctor, Department_1.Dept_Name AS Department, SubDepartment.SubDept_Name AS SubDepartment FROM Department AS Department_1 INNER JOIN Payment INNER JOIN  Patient ON Payment.RegNo = Patient.RegNo INNER JOIN  Gender ON Patient.SexID = Gender.Gender_ID ON Department_1.Dept_ID = Payment.DeptID LEFT OUTER JOIN  Employee ON Payment.DoctorID = Employee.EmpID LEFT OUTER JOIN Department INNER JOIN  SubDepartment ON Department.Dept_ID = SubDepartment.Dept_Id ON Payment.SubDept_id = SubDepartment.SubDept_Id WHERE (Payment.RegNo = @RegNo) AND (Payment.PayID = @PayID)"
        Dim SQLCmd As New SqlCommand(qry, New SqlConnection(ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString))
        SQLCmd.CommandType = CommandType.Text
        SQLCmd.Parameters.Add(New SqlParameter("@RegNo", regNo))
        SQLCmd.Parameters.Add(New SqlParameter("@PayID", PayId))
        SQLAdapter.SelectCommand = SQLCmd

        Dim Ds As New DataSet
        SQLAdapter.Fill(Ds)

        '01-000036
        Dim sub_tbl As DataTable = Ds.Tables(0)
        If sub_tbl.Rows.Count > 0 Then
            Dim sub_row As DataRow = sub_tbl.Rows(0)

            lbl_Date.Text = sub_row("Dte").ToString()
            lbl_Time.Text = sub_row("Time").ToString()
            lblPatientName.Text = sub_row("Prefix").ToString() + " " + ENC.Encrypt_Main(sub_row("PFName").ToString(), False) + " " + ENC.Encrypt_Main(sub_row("PMName").ToString(), False) + " " + ENC.Encrypt_Main(sub_row("PLName").ToString(), False)
            lblMedicalRecord.Text = ENC.Encrypt_Main(sub_row("RegNo").ToString(), False)
            lblSex.Text = sub_row("Gender").ToString()
            lblRelationName.Text = sub_row("PR_Name").ToString()
            lblRelation.Text = sub_row("Relation").ToString()
            lblRefer.Text = sub_row("ReferFrom").ToString()
            lblDepartment.Text = sub_row("House_No").ToString()
            lblAge.Text = sub_row("Age").ToString()
            Label_DeptName.Text = sub_row("Dept_name").ToString()
            ', Employee.EFName, Employee.EMName, Employee.ELName
            lblConsultant.Text = sub_row("Doctor").ToString()
            lbl_Department.Text = sub_row("Department").ToString()
            lbl_SubDepartment.Text = sub_row("SubDepartment").ToString()


            'Payment., Patient.House_No
            'Label_ReferBy_Institute.Text = sub_row("Prefix").ToString() + " " + sub_row("PFName").ToString() + " " + sub_row("PMName").ToString() + " " + sub_row("PLName").ToString()
            'Label_Patient_Condition.Text = sub_row("Patient_Condition").ToString()
            'Label_Activity_level.Text = sub_row("Activity_level").ToString()
            'Label_Admitted_Diagnosis.Text = sub_row("Admitted_Diagnosis").ToString()

            'Label_Description.Text = sub_row("Description").ToString()
            'Label_Admission_Type.Text = sub_row("Admission_Type").ToString()

            'Label_ReferByName.Text = sub_row("ReferByName").ToString()
            'Label_Consultant.Text = sub_row("Consultant").ToString()
            'Label_SubDept_Name.Text = sub_row("SubDept_Name").ToString()
            'Label_Arrival_Status_name.Text = sub_row("Arrival_Status_name").ToString()


        End If

        Load_Service_Data(regNo, PayId)


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

    Private Sub ShowReport()
        Try
            Dim ds As New Reports
            Dim da As New ReportsTableAdapters.usp_OPD_SLIP_ReportTableAdapter
            da.Fill(ds.usp_OPD_SLIP_Report, Session("RegistrationNo"), Convert.ToInt32(Session("PayId")))

            If ds.Tables("usp_OPD_SLIP_Report").Rows.Count > 0 Then
                ds.Tables("usp_OPD_SLIP_Report").Rows(0)("RegNo") = ENC.Encrypt_Main(ds.Tables("usp_OPD_SLIP_Report").Rows(0)("RegNo"), False)
                ds.Tables("usp_OPD_SLIP_Report").Rows(0)("Patient_Name") = ds.Tables("usp_OPD_SLIP_Report").Rows(0)("Prefix") + " " + ENC.Encrypt_Main(ds.Tables("usp_OPD_SLIP_Report").Rows(0)("PFName"), False) + " " + ENC.Encrypt_Main(ds.Tables("usp_OPD_SLIP_Report").Rows(0)("PLName"), False)

            End If

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Patient Registration/OPD_Slip_Report_Private.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repDs As New ReportDataSource
            repDs.Name = "DataSet1"
            repDs.Value = ds.Tables("usp_OPD_SLIP_Report")
            ReportViewer1.LocalReport.DataSources.Add(repDs)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports

            If Request.Browser.Browser = "Chrome" Then
                Dim bytes As Byte() = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.[End]()
            Else
                ReportViewer1.Visible = True
            End If


        Catch ex As Exception
            Label1.Text = "Error in loading reports" + ex.Message
        End Try

        'Dim warnings As Warning()
        'Dim streamIds As String()
        'Dim mimeType As String = String.Empty
        'Dim encoding As String = String.Empty
        'Dim extension As String = String.Empty
        'Dim viewer As New ReportViewer()
        'viewer.ProcessingMode = ProcessingMode.Local
        'viewer.LocalReport.ReportPath = Server.MapPath("~\Patient Registration\OPD_Slip_Report_Private.rdlc")

        'Dim bytes = viewer.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamIds, warnings)
        'Response.Buffer = True
        'Response.Clear()
        'Response.ContentType = mimeType
        'Response.AddHeader("content-disposition", "attachment; filename=" & Convert.ToString(Session("RegistrationNo") & "." & extension))
        'Response.OutputStream.Write(bytes, 0, bytes.Length)

        'Response.Flush()

        'ReportViewer1.Dispose()

    End Sub

    Private Sub Load_Service_Data(ByVal regNo As String, ByVal PayId As Integer)
        Dim SQLAdapter As New SqlDataAdapter()

        Dim qry As String = "SELECT CASE WHEN Admin_Services.S_Category <> 4 THEN Admin_Services.S_Name ELSE '' END AS S_Name, Patient_Services.Amount AS S_Amount, CONVERT(varchar,Patient_Services.sdatetime, 107) AS Date, CONVERT(varchar, Patient_Services.sdatetime, 108) AS TIme, Patient_Services.ID, Patient_Services.Payment_Status, Admin_Services.S_ID, Patient_Services.Doctor_ID, CASE WHEN Admin_Services.S_Category = 4 THEN Admin_Services.S_Name ELSE '' END AS S_Name2, ISNULL(Patient_Services.Qty, 1) AS Qty FROM Patient_Services INNER JOIN Admin_Services ON Patient_Services.S_ID = Admin_Services.S_ID  WHERE (Patient_Services.RegNo = @RegNo) And (Patient_Services.YearlyNo = @PayID)"
        Dim SQLCmd As New SqlCommand(qry, New SqlConnection(ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString))
        SQLCmd.CommandType = CommandType.Text
        SQLCmd.Parameters.Add(New SqlParameter("@RegNo", regNo))
        SQLCmd.Parameters.Add(New SqlParameter("@PayID", PayId))
        SQLAdapter.SelectCommand = SQLCmd

        Dim Ds As New DataSet
        SQLAdapter.Fill(Ds)

        '01-000036
        Dim sub_tbl As DataTable = Ds.Tables(0)
        If sub_tbl.Rows.Count > 0 Then
            Dim sub_row As DataRow = sub_tbl.Rows(0)
            'lbl_RS.Text = "Rs. " + sub_row("S_Amount").ToString() + " ( " + sub_row("S_Name").ToString() + " )"
            lbl_RS.Text = " " + sub_row("S_Amount").ToString()
            lblDescText.Text = sub_row("S_Name").ToString()
        End If
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
    Protected Sub CreatePDF(ByVal fileName As String)

        'Dim warnings As Warning()
        'Dim streamIds As String()
        'Dim mimeType As String = String.Empty
        'Dim encoding As String = String.Empty
        'Dim extension As String = String.Empty
        'Dim viewer As New ReportViewer()
        'viewer.ProcessingMode = ProcessingMode.Local
        'viewer.LocalReport.ReportPath = Server.MapPath("~\Patient Registration\OPD_Slip_Report_Private.rdlc")
        'Dim bytes As Byte() = viewer.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamIds, warnings)
        'Response.Buffer = True
        'Response.Clear()
        'Response.ContentType = mimeType
        'Response.AddHeader("content-disposition", "attachment; filename=" & fileName & "." & extension)
        'Response.BinaryWrite(bytes)

        'Response.Flush()
    End Sub
End Class
