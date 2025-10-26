Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Partial Class Pt_EMR_PT_AdmissionForm
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Dim en As New Encryption
    

    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        If Page.IsPostBack = False Then
            'DropDownListConsultant.SelectedValue = Session("emp_Id")
            'WebDateChooser_Date_Of_admission.Value = Date.Now()


            Dim obj_menu As New JavaScriptMenu
            LabelFooter.Text = obj_menu.Footer_String()
            LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

            '' Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Button_Save.Attributes.Add("onclick", "return Validation()")
            'WebDateChooser_Date_Of_admission.Value = Now()


        End If

    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try

            Dim constr As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Insert_Surgical_order_intermedcn_assessment", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@SOA_Assement_ID", DropDownList_Anesthesia_Type.SelectedValue)
            command.Parameters.AddWithValue("@Remarks", TextBox_patientadvice.Text.Trim())
            command.Parameters.AddWithValue("@Order_Id", Request.QueryString("Order_Id"))
            con.Open()
            command.ExecuteNonQuery()
            con.Close()
            GridView1.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message + "Main Insert  ")
        End Try
        Label_Message.Text = "Information has been saved"
        Button_Save.Visible = False
    End Sub
End Class
