Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Patient_Registration_pt_DischargeBill
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim basicConStr As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
    Dim regConStr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)

            loadReport()
        End If
    End Sub
    Protected Sub loadReport()
        Try
            Dim dsPatient As New DataSet
            Dim dsBed As New DataSet
            Dim dsAdvance As New DataSet
            Dim dsPatientInfo As New DataSet
            Dim reportPath As String = Server.MapPath("~/Patient Billing/PatientServicesNew.rdlc")

            dsPatient = loadPatientBioData("usp_PatientBioData", CInt(Session("YearlyNo")))
            If Request.QueryString("status") = "discharge" Then
                dsBed = loadPatientBedStatus("usp_PatientAssignBedS", CInt(Session("YearlyNo")))
            Else
                dsBed = loadPatientBedStatus("usp_PatientAssignBed", CInt(Session("YearlyNo")))
            End If
            
            For i As Integer = 0 To dsBed.Tables(0).Rows.Count - 1
                For j As Integer = 0 To dsPatient.Tables(0).Rows.Count - 1
                    If dsBed.Tables(0).Rows(i).Item("Yearly_No") = dsPatient.Tables(0).Rows(j).Item("PayID") Then
                        dsPatient.Tables(0).Rows(j).Item("SubDept_Name") = dsBed.Tables(0).Rows(i).Item("SubDept_Name")
                        dsPatient.Tables(0).Rows(j).Item("Bed_No") = dsBed.Tables(0).Rows(i).Item("Bed_No")
                        'dsPatient.Tables(0).Rows(j).Item("datetime") = dsBed.Tables(0).Rows(i).Item("datetime")
                        'dsPatient.Tables(0).Rows(j).Item("leave_datetime") = dsBed.Tables(0).Rows(i).Item("leave_datetime")
                    End If
                Next
            Next
            dsPatientInfo = basic_info()
            dsAdvance = loadAdvance("usp_PatientAdvancePayment", CInt(Session("YearlyNo")), Session("registrationNo"))
            ReportViewer1.LocalReport.ReportPath = reportPath
            ReportViewer1.LocalReport.DataSources.Clear()
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet1", dsPatient.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet2", dsPatientInfo.Tables(0)))
            ReportViewer1.LocalReport.DataSources.Add(New Microsoft.Reporting.WebForms.ReportDataSource("DataSet4", dsAdvance.Tables(0)))
            ReportViewer1.LocalReport.Refresh()
            If (Request.Browser.Browser = "Chrome") Then
                Dim bytes() As Byte = ReportViewer1.LocalReport.Render("PDF")
                Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
                Response.ContentType = "application/pdf"
                Response.BinaryWrite(bytes)
                Response.End()
            Else
                ReportViewer1.Visible = True
            End If

        Catch ex As Exception

        End Try
    End Sub
    Function basic_info() As DataSet
        Dim dsPatient As DataSet = New DataSet()
        Dim dsAdvance As DataSet = New DataSet()
        dsPatient = loadBasicInfo("usp_PT_DischargeBill", CInt(Session("YearlyNo")), Session("registrationNo"))
        dsAdvance = loadAdvanceTotal("usp_GetPatientTotalAdvance", CInt(Session("YearlyNo")), Session("registrationNo"))
        Dim total As Integer = 0
        Dim obj As New AmountInWords
        For i As Integer = 0 To dsPatient.Tables(0).Rows.Count - 1
            If dsPatient.Tables(0).Rows(i).Item("Asc_Name").ToString = "Laboratory" Then
                dsPatient.Tables(0).Rows(i).Item("Asc_Name") = "Lab Charges"
                dsPatient.Tables(0).Rows(i).Item("Priority") = 3

            ElseIf dsPatient.Tables(0).Rows(i).Item("Employee").ToString.Length = 3 Then
                dsPatient.Tables(0).Rows(i).Item("Asc_Name") = "Hospital Charges"
                dsPatient.Tables(0).Rows(i).Item("Priority") = 1
            Else
                dsPatient.Tables(0).Rows(i).Item("Asc_Name") = "Doctor Charges"
                dsPatient.Tables(0).Rows(i).Item("S_Name") = dsPatient.Tables(0).Rows(i).Item("Employee") + " (" + dsPatient.Tables(0).Rows(i).Item("S_Name") + ")"
                dsPatient.Tables(0).Rows(i).Item("Priority") = 2
            End If
            total = total + dsPatient.Tables(0).Rows(i).Item("Amount")
        Next
        'If dsPatient.Tables(0).Rows.Count <> 0 Then
        '    total = total - dsAdvance.Tables(0).Rows(0).Item("Advance") - dsPatient.Tables(0).Rows(0).Item("already Paid") - dsPatient.Tables(0).Rows(0).Item("discount")

        '    If total < 0 Then
        '        total = -1 * total
        '    End If

        '    'dsPatient.Tables(0).Rows(dsPatient.Tables(0).Rows.Count - 1).Item("BalanceAmtInWords") = obj.In_Words(total)
        'End If


        ' crdoc1.SetDataSource(
        Return dsPatient

    End Function
    Function loadPatientBioData(ByVal pro As String, ByVal yearlyNo As Integer) As DataSet
        Dim ds As DataSet = New DataSet
        Dim con As SqlConnection = New SqlConnection(basicConStr)
        Dim cmd As SqlCommand = New SqlCommand(pro, con)
        Dim dr As SqlDataAdapter
        Try
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Yearly_No", yearlyNo)
            dr = New SqlDataAdapter(cmd)
            dr.Fill(ds)
        Catch ex As Exception

        Finally
            con.Close()
            cmd.Dispose()
        End Try
        Return ds

    End Function
    Function loadPatientBedStatus(ByVal pro As String, ByVal yearlyNo As Integer) As DataSet
        Dim ds As DataSet = New DataSet
        Dim con As SqlConnection = New SqlConnection(basicConStr)
        Dim cmd As SqlCommand = New SqlCommand(pro, con)
        Dim dr As SqlDataAdapter
        Try
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@Yearly_No", yearlyNo)
            dr = New SqlDataAdapter(cmd)
            dr.Fill(ds)
        Catch ex As Exception

        Finally
            con.Close()
            cmd.Dispose()
        End Try
        Return ds

    End Function
    Function loadBasicInfo(ByVal pro As String, ByVal yaerlyNo As Integer, ByVal RegNo As String) As DataSet
        Dim ds As DataSet = New DataSet
        Dim con As SqlConnection = New SqlConnection(basicConStr)
        Dim cmd As SqlCommand = New SqlCommand(pro, con)
        Dim dr As SqlDataAdapter
        Try
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@YearlyNo", yaerlyNo)
            cmd.Parameters.AddWithValue("@RegNo", RegNo)
            dr = New SqlDataAdapter(cmd)
            dr.Fill(ds)
        Catch ex As Exception

        Finally
            con.Close()
            cmd.Dispose()
        End Try
        Return ds
    End Function
    Function loadAdvance(ByVal pro As String, ByVal yaerlyNo As Integer, ByVal RegNo As String) As DataSet
        Dim ds As DataSet = New DataSet
        Dim con As SqlConnection = New SqlConnection(basicConStr)
        Dim cmd As SqlCommand = New SqlCommand(pro, con)
        Dim dr As SqlDataAdapter
        Try
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            cmd.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            dr = New SqlDataAdapter(cmd)
            dr.Fill(ds)
        Catch ex As Exception

        Finally
            con.Close()
            cmd.Dispose()
        End Try
        Return ds
    End Function
    Function loadAdvanceTotal(ByVal pro As String, ByVal yaerlyNo As Integer, ByVal RegNo As String) As DataSet
        Dim ds As DataSet = New DataSet
        Dim con As SqlConnection = New SqlConnection(basicConStr)
        Dim cmd As SqlCommand = New SqlCommand(pro, con)
        Dim dr As SqlDataAdapter
        Try
            con.Open()
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@YearlyNo", yaerlyNo)
            cmd.Parameters.AddWithValue("@RegNo", RegNo)
            dr = New SqlDataAdapter(cmd)
            dr.Fill(ds)
        Catch ex As Exception

        Finally
            con.Close()
            cmd.Dispose()
        End Try
        Return ds
    End Function
End Class
