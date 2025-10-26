Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_Pt_PatientEpisodes
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Dim constr1 As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ToString()
    Dim flag As Integer = 0
    Dim ENC As New Encryption

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        Session("MEDCode") = HiddenField_MedCode.Value
        obj_menu.loginvalidate()
        'LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        'LabelFooter.Text = obj_menu.Footer_String()
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        'GridData()
    End Sub

    Protected Sub lnkBtnPrint_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim lb As LinkButton = CType(sender, LinkButton)
            Dim gvRow As GridViewRow = CType(lb.NamingContainer, GridViewRow)
            Response.Redirect("PatientChart.aspx?RegNo=" + lb.CommandName & "&YearlyNo=" & lb.CommandArgument)

        Catch ex As Exception

            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub lnkBtnView_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            Dim lb As LinkButton = CType(sender, LinkButton)
            Dim gvRow As GridViewRow = CType(lb.NamingContainer, GridViewRow)

            Dim linkbtn As LinkButton = sender
            Dim YearlyNo As String = linkbtn.CommandArgument
            Dim reg As String = linkbtn.CommandName

            Session.Add("YearlyNo", YearlyNo)
            Session.Add("registrationNo", reg)

            Response.Redirect("~/pt_EMR/pt_History_Main_Heading.aspx?ID=His146&Type=Personal%20History")

        Catch ex As Exception

            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub GridData()
        Dim conn As SqlConnection = New SqlConnection(constr1)
        Dim dt As DataTable = New DataTable()
        Try
            Dim sc As SqlCommand = New SqlCommand("rpt_AllPatient_Checkup", conn)
            sc.CommandType = CommandType.StoredProcedure
            sc.Parameters.AddWithValue("@RegNo", Session("registrationno"))
            Dim sda As SqlDataAdapter = New SqlDataAdapter(sc)
            sda.Fill(dt)

            GridView1.DataSource = dt
            GridView1.DataBind()
        Catch ex As Exception

        End Try
    End Sub


End Class
