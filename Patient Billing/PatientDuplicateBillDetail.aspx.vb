Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_PatientDuplicateBillDetail

    Inherits System.Web.UI.Page

    Dim ENC As New Encryption
   
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
