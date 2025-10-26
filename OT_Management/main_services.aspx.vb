

'=====================********======================================'
' Developer Name          Imran Ahmed Awan,Muhammad Aun Abbas
' Design Aproved  by       Muhammad Tariq
' Web Design By           Imran Sharif
' Date Started            October 2006,27 November 2006
' Description             This page redirect the user to PatientRegistration when imagebuttonpatientregistration 
'                         is clicked, to PatientSearch when ImageButtonPatientSearch is clicked,to main2 when ImageButtonBasicDatamgmt_Click
'                         is clicked, AdmissionCard is redirected when ImageButtonAdmissioncard is clicked
' Completed date          October 28 , 2006, 27 November 2006
'
'====================*********======================================'
Partial Class main_services
    Inherits System.Web.UI.Page
    Dim value, value1 As String
    Dim user_authen As New User_page_Authentication

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Server.Transfer("login.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Module_id") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        Dim forno, employeeid, deptid, a, b As String
        loginvalidate(Session("emp_id"), Session("dept_id"))
        'Session.Add("UserID", Session("emp_id"))
        'Session.Add("DeptID", Session("dept_id")))
        'Session.Add("SubDeptID", Session("SubDeptID"))
        Session.Timeout = 60
        employeeid = Session("emp_id")
        a = employeeid
        Session.Add("UserID", a)
        deptid = Session("dept_id")
        b = deptid
        Session.Add("DeptID", b)
        forno = "main_services.aspx"
        Session("PageForNo") = forno
        'Response.Write(Session("MODULE_ID"))
    End Sub


    Protected Sub ImageButtonPatientRegistration_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonPatientRegistration.Click
        Response.Redirect("PatientRegistration.aspx")
    End Sub

    Protected Sub ImageButtonPatientSearch_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonPatientSearch.Click
        Response.Redirect("Patient_Search.aspx?def=1.0")
    End Sub

    Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonLogOut.Click
        Session.RemoveAll()
        Response.Redirect("Login.aspx")
    End Sub

    Protected Sub ImageButton1_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Response.Redirect("HospitalPatientSearch.aspx")
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton2.Click
        Response.Redirect(".\Pathology Reports\MainReportsPage.aspx")
    End Sub

    Protected Sub ImageButton3_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton3.Click
        Response.Redirect("Patient_Search.aspx?def=1.4")
    End Sub

    Protected Sub ImageButton4_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton4.Click
        Response.Redirect("Patient_Search.aspx?def=1.3")
    End Sub

    Protected Sub ImageButton5_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton5.Click
        Response.Redirect("Patient_Search.aspx?def=1.2")
    End Sub

    Protected Sub ImageButton6_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton6.Click
        Response.Redirect("Patient_Search.aspx?def=1.5")
    End Sub

    Protected Sub ImageButton7_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton7.Click
        Response.Redirect("Patient_Search.aspx?def=1.6")
    End Sub
End Class
