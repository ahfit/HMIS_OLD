Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_patient_bill_detail

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

                regno.Text = ENC.Encrypt_Main(reg_no.Value, False)
                P_Name.Text = ENC.Encrypt_Main(P_Prefix.Value, False) + " " + ENC.Encrypt_Main(P_PFName.Value, False) + " " + ENC.Encrypt_Main(P_PMName.Value, False) + " " + ENC.Encrypt_Main(hf_PLName.Value, False)


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
        Dim lnk As LinkButton = sender
        Dim row As GridViewRow = lnk.NamingContainer
        Dim reg_no As HiddenField = row.FindControl("hf_reg")
        Dim Yearly_no As HiddenField = row.FindControl("hf_yearlyNo")
        Dim SMP_ID As HiddenField = row.FindControl("hf_smp_id")
        Session("YearlyNo") = Yearly_no.Value
        Session("RegistrationNo") = reg_no.Value
        Dim url As String = "./PatientServices.aspx?SPMID=" + SMP_ID.Value + "&AP_ID=1"


        Response.Redirect(url)
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

    Protected Sub lnkEdit_Click(sender As Object, e As System.EventArgs)
        Dim btnEdit As LinkButton = sender
        Dim id As Integer = btnEdit.CommandArgument
        Dim gvRow As GridViewRow = btnEdit.NamingContainer
        Dim wdc As Infragistics.WebUI.WebSchedule.WebDateChooser = gvRow.FindControl("WebDateChooser_DischargeDate")
        If btnEdit.Text = "Edit" Then
            wdc.Enabled = True
            btnEdit.Text = "Update"
        Else
            updateDate(wdc.Value.ToString(), id)
            wdc.Enabled = False
            gv_bill.DataBind()
            btnEdit.Text = "Edit"
        End If
    End Sub
    Protected Sub updateDate(ByVal dt As String, ByVal id As Integer)
        Dim conStr As String = ConfigurationManager.ConnectionStrings("PatientBillingConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(conStr)
        Dim query As String = "UPDATE    Payment SET   DischargeDateTime = @DischargeDateTime FROM Payment INNER JOIN Patient_final_Bill ON Payment.RegNo = Patient_final_Bill.Reg_no WHERE     (Patient_final_Bill.Patient_final_bill_id = @FinalID)"
        Dim cmd As SqlCommand = New SqlCommand(query, con)
        con.Open()
        cmd.Parameters.AddWithValue("@DischargeDateTime", dt)
        cmd.Parameters.AddWithValue("@FinalID", id)
        cmd.ExecuteNonQuery()
        con.Close()
        SqlTrackDischargeBill.Insert()
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
