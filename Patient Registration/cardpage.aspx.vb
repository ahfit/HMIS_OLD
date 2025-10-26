
Imports System.Data.SqlClient

Partial Class Patient_Registration_cardpage
    Inherits System.Web.UI.Page
    Dim Encry As New Encryption
    Dim Bill As New Insert_patient_Billing
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            GetCardInfo()
        End If

    End Sub
    Protected Sub GetCardInfo()
        Dim RegNo As String = Request.QueryString("RegNo")
        Dim db As DbManager = New DbManager()
        Dim param As SqlParameter() = {
            New SqlParameter("RegNo", RegNo.ToString())
            }
        dlcard.DataSource = db.ExecuteDataTable("usp_GetPatientCardInformation", "Basic_Data_ConnectionString", param)
        dlcard.DataBind()

    End Sub
End Class
