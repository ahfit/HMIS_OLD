Imports System.Data
Imports System.Data.SqlClient
Partial Class Nursing_Nursing_Notes
    Inherits System.Web.UI.Page

    Dim constr As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            If CheckBox_Status.Checked = True Then
                HiddenField_Critical.Value = True
            Else
                HiddenField_Critical.Value = False
            End If
            HiddenField_DateTime.Value = WebDateChooserRecord_Date.Value
            SqlDataSource_Insert_Notes.Insert()
            TextBox_Treatment.Text = ""
            TextBox_Observation.Text = ""
            GridView1.DataBind()
            GridView_Notes.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
      
	  
	  ' Dim obj_menu As New JavaScriptMenu
'        obj_menu.loginvalidate()
'        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
'        LabelFooter.Text = obj_menu.Footer_String()

Dim obj_menu As New JavaScriptMenu
obj_menu.loginvalidate()
LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
LabelFooter.Text = obj_menu.Footer_String()



	  
	    If Not Page.IsPostBack Then
            WebDateChooserRecord_Date.Value = Date.Now

        End If
    End Sub

    'Sub SelectCritical()
    '    Dim con As SqlConnection = New SqlConnection(constr)
    '    Try
    '        Dim command As SqlCommand = New SqlCommand("", con)
    '        command.CommandType = CommandType.Text
    '        command.Parameters.AddWithValue("", )
    '        command.Parameters.AddWithValue("", )


    '    Catch ex As Exception

    '    End Try
    'End Sub
    Public Function check_already_enter() As Integer
        Dim con As New SqlConnection
        con.ConnectionString = constr
        con.Open()
        Try
            Dim command As SqlCommand = New SqlCommand("Select count(*) from Nurse_Record where regno=@reg_no and YearlyNo=@Yearly_No and Date_Time=Getdate()", con)
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))
            Dim reader As Integer = command.ExecuteScalar()
            Return reader
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Function

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Notes.SelectedIndexChanged
        Try
            Dim HidField_Type As HiddenField = GridView_Notes.Rows(GridView_Notes.SelectedIndex).FindControl("HiddenField_Type")
            Dim HidField_Treatment As HiddenField = GridView_Notes.Rows(GridView_Notes.SelectedIndex).FindControl("HiddenField_Treatment")
            Dim HidField_Date As HiddenField = GridView_Notes.Rows(GridView_Notes.SelectedIndex).FindControl("HiddenField_Date")
            Dim HidField_Status As HiddenField = GridView_Notes.Rows(GridView_Notes.SelectedIndex).FindControl("HiddenField_Status")
            Dim HidField_Clinical_Observation As HiddenField = GridView_Notes.Rows(GridView_Notes.SelectedIndex).FindControl("HiddenField_Clinical_Observation")
            TextBox_Treatment.Text = HidField_Treatment.Value
            DropDownList_Notes_Type.SelectedValue = HidField_Type.Value
            WebDateChooserRecord_Date.Value = HidField_Date.Value
            CheckBox_Status.Checked = HidField_Status.Value
            TextBox_Observation.Text = HidField_Clinical_Observation.Value


        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
End Class
