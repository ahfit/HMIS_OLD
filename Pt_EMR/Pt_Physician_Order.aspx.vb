Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_Pt_Physician_Order
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))        
        Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        HiddenField_Registration_No.Value = Session("registrationNo")
        HiddenField_Emp_Id.Value = Session("emp_id")
        HiddenField_Yearly_No.Value = Session("YearlyNo")
        HiddenField_Dept_Id.Value = Session("dept_id")
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        ' SqlDataSourceSave_New_Order.Insert()
        'For i As Integer = 0 To GridView_Order.Rows.Count - 1
        'Dim period As TextBox = GridView_Order.Rows(i).FindControl("TextBox_Priod")
        'Dim period_Type As DropDownList = GridView_Order.Rows(i).FindControl("DropDownList_period")
        'Dim stop_Text As TextBox = GridView_Order.Rows(i).FindControl("TextBox_stop")
        'Dim stop_Type As DropDownList = GridView_Order.Rows(i).FindControl("DropDownList_stop")
        'Dim id As HiddenField = GridView_Order.Rows(i).FindControl("HiddenField_vital_id")
        'Dim Description As TextBox = GridView_Order.Rows(i).FindControl("TextBoxDescription")
        'HiddenFieldDescription.Value = Description.Text
        'Dim period_Total As Integer = -1
        'If period.Text <> "" Or Description.Text <> "" Then
        '    Dim End_Date As DateTime
        '    If period.Text <> "" Then
        '        Try
        '            period_Total = CInt(period.Text) * CInt(period_Type.SelectedValue)
        '            HiddenFieldForEvery.Value = period.Text + period_Type.SelectedItem.Text
        '        Catch ex As Exception
        '            'Response.Write(ex.Message)
        '        End Try
        '    End If
        '    Try
        '        If stop_Text.Text <> "" Then
        '            If stop_Type.SelectedValue = "1" Then
        '                End_Date = Date.Now
        '                HiddenField_vital_when_Stope.Value = End_Date.AddMinutes(CDbl(stop_Text.Text))
        '            End If
        '            If (stop_Type.SelectedValue = "60") Then
        '                End_Date = Date.Now
        '                HiddenField_vital_when_Stope.Value = End_Date.AddHours(CDbl(stop_Text.Text))
        '            End If
        '            If (stop_Type.SelectedValue = "3600") Then
        '                End_Date = Date.Now
        '                HiddenField_vital_when_Stope.Value = End_Date.AddDays(CDbl(stop_Text.Text))
        '            End If
        '            HiddenFieldEnd.Value = stop_Text.Text + stop_Type.SelectedItem.Text
        '        Else
        '            HiddenField_vital_when_Stope.Value = 0
        '            HiddenFieldEnd.Value = 0
        '            HiddenField_vital_when_Stope.Value = Date.Now
        '        End If
        '        HiddenField_vital_id.Value = id.Value
        '        HiddenField_vital_Period.Value = period_Total.ToString()
        '    Catch ex As Exception
        '        'Response.Write(ex.Message + "Hello")
        '    End Try

        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Insert_Patient_Physician_Order", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@Phy_Ord_id", 0)
            command.Parameters.AddWithValue("@Period", System.DBNull.Value)
            command.Parameters.AddWithValue("@Registration_No", Session("registrationNo"))
            command.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
            command.Parameters.AddWithValue("@Emp_Id", Session("emp_id"))
            command.Parameters.AddWithValue("@End_Date_Time", HiddenField_vital_when_Stope.Value)
            command.Parameters.AddWithValue("@For_Every", "")
            command.Parameters.AddWithValue("@End_Time", System.DBNull.Value)
            '            command.Parameters.AddWithValue("@Instruction ", HiddenFieldDescription.Value)
            command.Parameters.AddWithValue("@Instruction", TextBox_New_Order.Text)
            command.Parameters.AddWithValue("@dept_id", Session("dept_id"))
            command.Parameters.AddWithValue("@subdept_id", Session("subdeptid"))

            con.Open()
            command.ExecuteNonQuery()
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message + "Main Insert  ")
        End Try
        'End If
        'Next
        GridView2.DataBind()
    End Sub

   
    Protected Sub Button1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        For i As Integer = 0 To GridView_Order.Rows.Count - 1
            Dim chkbox_Ord As CheckBox = GridView_Order.Rows(i).FindControl("CheckBox_Select_Order")
            If chkbox_Ord.Checked = True Then
                Dim hiddenField_Ord_Id As HiddenField = GridView_Order.Rows(i).FindControl("HiddenField_Order_id")
                Dim txtbox_instr As TextBox = GridView_Order.Rows(i).FindControl("TextBox_Instr")
                Dim period As TextBox = GridView_Order.Rows(i).FindControl("TextBox_Period")
                Dim stop_Text As TextBox = GridView_Order.Rows(i).FindControl("TextBox_stop")
                Dim stop_Type As DropDownList = GridView_Order.Rows(i).FindControl("DropDownList_stop")
                Try
                    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    Dim con As SqlConnection = New SqlConnection(constr)
                    Dim command As SqlCommand = New SqlCommand("Insert_Select_Order", con)
                    command.CommandType = CommandType.StoredProcedure
                    command.Parameters.AddWithValue("@Phy_Ord_id", hiddenField_Ord_Id.Value)
                    command.Parameters.AddWithValue("@Period", period.Text)
                    command.Parameters.AddWithValue("@Registration_No", Session("registrationNo"))
                    command.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))
                    command.Parameters.AddWithValue("@Emp_Id", Session("emp_id"))
                    command.Parameters.AddWithValue("@End_Date_Time", DateTime.Now)
                    command.Parameters.AddWithValue("@For_Every", period.Text)
                    command.Parameters.AddWithValue("@End_Time", stop_Text.Text)
                    command.Parameters.AddWithValue("@Instruction ", txtbox_instr.Text)
                    command.Parameters.AddWithValue("@Dept_Id ", Session("Dept_Id"))
                    command.Parameters.AddWithValue("@subdept_id ", Session("SubDeptid"))

                    con.Open()
                    command.ExecuteNonQuery()
                    con.Close()
                    GridView2.DataBind()
                Catch ex As Exception
                    Response.Write(ex.Message + "Main Insert  ")
                End Try
            End If
        Next
    End Sub
End Class
