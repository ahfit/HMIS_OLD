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
            'SqlDataSource_Insert_Notes.Insert()
            Dim constr As New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString)
            Dim cmd As New SqlCommand("Nursing_Record_Insert", constr)
            cmd.CommandType = CommandType.StoredProcedure

            constr.Open()
            cmd.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            cmd.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            cmd.Parameters.AddWithValue("@Date_Time", Convert.ToDateTime(WebDateChooserRecord_Date.Text) + " " + Convert.ToDateTime(DateTime.Now).ToString("hh:mm"))
            cmd.Parameters.AddWithValue("@Type", DropDownList_Notes_Type.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@Oriented", If(radoriented.SelectedValue = 1, 1, 0))
            cmd.Parameters.AddWithValue("@CannulaRTHand", If(RadioRTHand.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@CannulaRTFoot", If(RadioRTFoot.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@CannulaLTHand", If(RadioLTHand.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@CannulaLTFoot", If(RadioLTFoot.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@Foley", radioFoley.SelectedValue)
            cmd.Parameters.AddWithValue("@Drain", radiodrain.SelectedValue)
            cmd.Parameters.AddWithValue("@DL_Sile", txtdlsile.Text)

            cmd.Parameters.AddWithValue("@Intact", If(chkIntact.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@Bruises", If(chkBruises.Checked = True, 1, 0))
            cmd.Parameters.AddWithValue("@BedSove", If(chkBedSove.Checked = True, 1, 0))

            cmd.Parameters.AddWithValue("@DL_Sile_Condition", txtdlcondition.Text)
            cmd.Parameters.AddWithValue("@IV_Fluid", txtivfluid.Text)
            cmd.Parameters.AddWithValue("@Treatment", TextBox_Treatment.Text)
            cmd.Parameters.AddWithValue("@Clinical_Observation", TextBox_Observation.Text)
            cmd.Parameters.AddWithValue("@Critical_Reading", If(CheckBox_Status.Checked = 0, 1, 0))

            cmd.Parameters.AddWithValue("@EmpId", Session("emp_id"))
            cmd.ExecuteNonQuery()
            constr.Close()


            txtdlsile.Text = ""
            txtdlcondition.Text = ""
            txtivfluid.Text = ""
            TextBox_Treatment.Text = ""
            TextBox_Observation.Text = ""
            GetNursingNotes()        
            lblMsg.Text = "Saved Successfully!."
            lblMsg.ForeColor = Drawing.Color.Green


        Catch ex As Exception
            'Response.Write(ex.Message)
            lblMsg.Text = "Some error occurred!"
            lblMsg.ForeColor = Drawing.Color.Red

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
            GetNursingNotes()
        End If
    End Sub

    Public Sub GetNursingNotes()        
        Try
            
            Dim sqlParams As SqlParameter() = {
       New SqlParameter("@YearlyNo", Session("YearlyNo"))
        }
            Dim objManager As DbManager = New DbManager()
            Dim dt As DataTable = objManager.ExecuteDataTable("Get_Nursing_Notes", "NurseConnectionString", sqlParams)

            GridView_Notes.DataSource = dt
            GridView_Notes.DataBind()

            GridView1.DataSource = dt
            GridView1.DataBind()


        Catch ex As Exception

        End Try
    End Sub
    Public Function check_already_enter() As Integer
        Dim con As New SqlConnection
        con.ConnectionString = constr
        con.Open()
        Try
            Dim command As SqlCommand = New SqlCommand("Select count(*) from Nurse_Record where regno=@reg_no and YearlyNo=@YearlyNo and Date_Time=Getdate()", con)
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
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
