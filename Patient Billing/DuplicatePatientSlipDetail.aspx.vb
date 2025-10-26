Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_DuplicatePatientSlipDetail

    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
    Protected Sub gv_bill_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles gv_bill.PreRender
        If gv_bill.Rows.Count > 0 Then
            For Each row As GridViewRow In gv_bill.Rows
                Dim reg_no As HiddenField = row.FindControl("hf_reg")
                Dim regno As LinkButton = row.FindControl("lbl_reg")

                Dim P_Name As Label = row.FindControl("lbl_name")
                Dim P_Prefix As HiddenField = row.FindControl("hf_Prefix")
                Dim P_PFName As HiddenField = row.FindControl("hf_PFName")
                Dim P_PMName As HiddenField = row.FindControl("hf_PMName")
                Dim hf_PLName As HiddenField = row.FindControl("hf_PLName")

                regno.Text = (reg_no.Value)
                P_Name.Text = (P_Prefix.Value) + " " + (P_PFName.Value) + " " + (P_PMName.Value) + " " + (hf_PLName.Value)


            Next
        End If
    End Sub
    Protected Sub FillHospital()
        Dim conststr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

        Using con As SqlConnection = New SqlConnection(conststr)
            Dim command As SqlCommand = New SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            ddl_Hospital.DataValueField = "Hospital_ID"
            ddl_Hospital.DataTextField = "Hospital_Name"
            ddl_Hospital.DataSource = dt
            ddl_Hospital.DataBind()
        End Using
    End Sub
    Protected Sub lbl_reg_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Dim lnk As LinkButton = sender
        'Dim row As GridViewRow = lnk.NamingContainer
        'Dim reg_no As HiddenField = row.FindControl("hf_reg")
        'Dim Yearly_no As HiddenField = row.FindControl("hf_yearlyNo")
        'Dim SMP_ID As HiddenField = row.FindControl("hf_smp_id")
        'Session("YearlyNo") = Yearly_no.Value
        'Session("RegistrationNo") = reg_no.Value
        'Dim url As String = "./PatientServices.aspx?SPMID=" + SMP_ID.Value + "&AP_ID=1"


        'Response.Redirect(url)
    End Sub

    Protected Sub Page_Load(sender As Object, e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            FillHospital()
            startDateChooser.Value = DateTime.Now.AddMonths(-1)
            HiddenField_StartDate.Value = startDateChooser.Value
            endDateChooser.Value = DateTime.Now
            HiddenField_EndDate.Value = endDateChooser.Value

        End If
    End Sub

    Protected Sub gv_bill_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gv_bill.RowDataBound
        'Dim wdc As Infragistics.WebUI
    End Sub


    Protected Sub Btn_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Search.Click

        If Not IsDBNull(startDateChooser.Value) Then
            HiddenField_StartDate.Value = startDateChooser.Value
        End If

        If Not IsDBNull(startDateChooser.Value) Then
            HiddenField_EndDate.Value = endDateChooser.Value
        End If

        gv_bill.DataBind()
    End Sub
End Class
