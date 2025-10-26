
Partial Class Investigation_Results
    Inherits System.Web.UI.Page

    Protected Sub Button_Search_Test_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        GridView1.DataBind()
        'GridView_For_Results.DataBind()
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        ' GridView_For_Results.DataBind()
        HiddenField_Main_ID.Value = GridView1.SelectedValue
        GridView_For_Results.DataBind()
        ' Label1.Text = Session("registrationno") & "  regno  " & Session("YearlyNo") & "  yearlyno  " & HiddenField_Main_ID.Value & " main_id "
        Label1.Text = "sdfgfg"
        Label1.Visible = False
    End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("login.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loginvalidate(Session("emp_id"), Session("dept_id"))
        HiddenField_YearlyNo.Value = Session("YearlyNo")
        HiddenField_RegNo.Value = Session("RegistrationNo")
        Session.Add("YearlyNo", Request.QueryString("Yearly_No"))
        Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
        ' Response.w()
        'If Session("YearlyNo").ToString Is Nothing Then
        '    Response.Redirect("Login.aspx")
        'End If
        Dim ClassObj As New PatientBacisInfo
        ClassObj.PatientInfo(Session("YearlyNo"), Session("registrationNo"), labelPName, LabelPAge, LabelPSex, LabelCNIC, LabelRegNo, LabelDOB)
        ClassObj.PatientInfo_Ward_Refferal(Session("YearlyNo"), Session("registrationNo"), labelWardReferal)
    End Sub
End Class
