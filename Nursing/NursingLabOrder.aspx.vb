'Author                  Muhammad Aun Abbas
'Creation Date      
'Modification Date       24-11-2006
'Purpose                 Move CMO to CMOPatientForward
'                        and BasicMedicalInfo
'Store Procedure used    SearchEmgDeptPatient          
Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Partial Class NursingLabOrder
    Inherits System.Web.UI.Page

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("../login.aspx")
            End If
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try

    End Sub

   ' Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
'        Try
'            loginvalidate(Session("emp_id"), Session("dept_id"))
'            HiddenFieldSubDept.Value = Session("SubDeptID")
'            Session.Timeout = 60
'        Catch ex As Exception
'            'Response.Write(ex.Message)
'        End Try
'
'    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Dim obj_menu As New JavaScriptMenu
'            LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))))
            HiddenFieldRegistrationNo.Value = Session("registrationNo") 'Request.QueryString("RegNo")
            HiddenField_Yearly_no.Value = Session("YearlyNo") 'Request.QueryString("YearlyNo")
            'Response.Write(Session("registrationNo1") & "    " & Session("YearlyNo1"))
            HiddenFieldSubDept.Value = Session("SubDeptID")
			'LabelFooter.Text = obj_menu.Footer_String()
            'form1.DefaultButton = "Search"
            'search1(0)
			Dim obj_menu As New JavaScriptMenu
obj_menu.loginvalidate()
LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
LabelFooter.Text = obj_menu.Footer_String()

            'GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    'Protected Sub DetailsView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DetailsView1.PreRender
    'Try
    '    Dim labelTestName As Label = DetailsView1.FindControl("LabelTestName")
    '    Dim testname As String = ""
    '    Dim constring As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString
    '    Dim con As SqlConnection = New SqlConnection(constring)
    '    Dim command As SqlCommand = New SqlCommand("Select_Test_For_Nursing_Lab_Order", con)
    '    command.CommandType = CommandType.StoredProcedure
    '    command.Parameters.AddWithValue("@TGID", HiddenField_TGID.Value)
    '    command.Parameters.AddWithValue("@RegNo", HiddenFieldRegistrationNo.Value)
    '    command.Parameters.AddWithValue("@YearlyNo", HiddenField_Yearly_no.Value)
    '    con.Open()
    '    Dim reader As SqlDataReader = command.ExecuteReader
    '    While reader.Read
    '        If testname = "" Then
    '            testname = testname + reader.Item(0).ToString
    '        Else
    '            testname = testname + ", " + reader.Item(0).ToString
    '        End If
    '    End While
    '    labelTestName.Text = testname
    '    'Response.Write(testname)
    'Catch ex As Exception
    '    Response.Write(ex.Message)
    'End Try
    'End Sub

    Protected Sub ButtonDone_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonDone.Click
        Try
            For count As Integer = 0 To GridView1.Rows.Count - 1
                Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox1")
                Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField1")
                If chk.Checked = True Then
                    HiddenField_TGID.Value = hid.Value
                    SqlDataSourceForDetailView.Update()
                    SqlDataSourceUpdateStatus.Update()
                End If
            Next

            GridView1.DataBind()

            Panel1.Visible = False
            'Response.Redirect("Nurse_Reception_main.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub CheckBox1_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            For count As Integer = 0 To GridView1.Rows.Count - 1
                Dim chk As CheckBox = GridView1.Rows(count).FindControl("CheckBox1")
                Dim hid As HiddenField = GridView1.Rows(count).FindControl("HiddenField1")
                If chk.Checked = True Then
                    HiddenField_TGID.Value = hid.Value
                    SqlDataSourceForDetailView.Update()
                    SqlDataSourceUpdateStatus.Update()
                End If
            Next



            Panel1.Visible = False
            'Response.Redirect("Nurse_Reception_main.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
