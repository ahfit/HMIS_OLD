Imports System.Data.SqlClient
Partial Class Pathology_Reports_MainReportsPage
    Inherits System.Web.UI.Page

    Protected Sub ButtonFor_Test_data_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonFor_Test_data.Click
        'Response.Redirect("Annual_tests_Data.aspx")
        'ButtonFor_Test_data.Attributes.Add("onclientclick", "return viewReport()")
    End Sub

    Protected Sub ButtonFor_Cash_List_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonFor_Cash_List.Click
        Response.Redirect("AnnualCashList.aspx")
    End Sub

    Protected Sub ButtonCash_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonCash.Click
        Response.Redirect("Comparative_Cash1.aspx")
    End Sub

    Protected Sub ButtonTests_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonTests.Click
        Response.Redirect("CompartiveTests.aspx")
    End Sub

    Protected Sub ButtonPatients_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonPatients.Click
        Response.Redirect("Comparative_Patients.aspx")
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Comparative_all.aspx")
    End Sub

    Protected Sub Button_PathalogyTests_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_PathalogyTests.Click
        Response.Redirect("PathalogyTests.aspx")
    End Sub

    Protected Sub ButtonPt_PreffralData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonPt_PreffralData.Click
        Response.Redirect("Pt_PrefferalData.aspx")
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
        Catch ex As Exception
            Response.Redirect("..\login.aspx")
        End Try
    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("..\login.aspx")
            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub

    Protected Sub ButtonAnnual_PtData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonAnnual_PtData.Click
        Response.Redirect("Annual_Pt_Free_Paid.aspx")
    End Sub


End Class
