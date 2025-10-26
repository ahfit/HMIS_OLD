Imports System.Data.SqlClient
Imports System.Data

Partial Class Patient_Billing_UserControlls_changeRoomRequest
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
       
    End Sub
    Protected Sub btnRequest_Click(sender As Object, e As EventArgs)
        Lbl_Mg.Text = ""
        Try
            Dim manager As DbManager = New DbManager()

            Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Reg_No", Session("RegistrationNo")),
            New SqlParameter("@yearly_no", Session("YearlyNo")),
            New SqlParameter("@DoctorId", ddlConsultant.SelectedValue),
            New SqlParameter("@WardID", ddlWard.SelectedValue),
            New SqlParameter("@by_sub_dept_id", ddlWard.SelectedValue),
            New SqlParameter("@request_type_id", "20"),
            New SqlParameter("@Description", txtRemarks.Text.Trim())
            }

            manager.ExecuteNonQuery("WardChangeRequest", "Reg_ConnectionString", sqlParams)

            Dim ct As Control = Me.Parent.FindControl("pnlChangeRequest")

            ct.Visible = False

            Session.Remove("RegistrationNo")
            Session.Remove("YearlyNo")
            txtRemarks.Text = ""

        Catch ex As Exception
            Dim s As String = ex.ToString()
            Lbl_Mg.Text = "Some error occurred!"
        End Try

    End Sub


    Protected Sub btnClose_Click(sender As Object, e As EventArgs)
        Dim ct As Control = Me.Parent.FindControl("pnlChangeRequest")

        ct.Visible = False

    End Sub
End Class
