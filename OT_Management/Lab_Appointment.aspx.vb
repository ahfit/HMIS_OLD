Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Imports Infragistics.WebUI.WebSchedule
Partial Class Lab_Appointment
    Inherits System.Web.UI.Page
    Dim PAtient_Type As String = ""
    Dim Total_Amount As Integer = 0
    Dim count As Integer = 0
    Dim ENC As New Encryption
    Dim Test_Counter As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = ""
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim statuscmo As String
    Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
    Dim b As String = ""

    '=====================********======================================'
    ' Developer Name            Imran Ahmed Awan, Muhammad Aun Abbas
    ' Design Approved  by       Muhammad Tariq
    ' Web Designed By           Imran Sharif
    ' Date Started              October 20 ,2006
    ' Description               This Is for the Test Select Module for the patient that a doctor
    '                           recommend for the patient if tests are already assigned 
    '                           its tests are shown and vitals of patients are displayed on left 
    '                           side of the page.
    ' This form is used for patient Test in Emergency.
    ' Completed date          October 30 , 2006
    '====================*********======================================


    ' this function check alll the items of the selected list one by one 
    ' Which items are checked the Function Insert the Values in the database 
    ' Which Items of the selected checkboxlist are Unchecked That are Delete From the Database 


    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("login.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try


            If Not (Request.QueryString("Reg_No") Is Nothing) Then
                Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
                Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
                Session.Add("Main_ID", Request.QueryString("Main_ID"))
            End If
        Catch ex As Exception

        End Try
        Try
            Dim obj_menu As New JavaScriptMenu


            LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
            LabelFooter.Text = obj_menu.Footer_String()

        Catch ex As Exception

        End Try
        'Response.Write(Session("RegistrationNo") & "        " & Session("YearlyNo"))
        Dim user_authen As New User_page_Authentication
        Session("Module_id") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
        loginvalidate(Session("emp_id"), Session("dept_id"))


        If Page.IsPostBack = False Then
            'Select_Sample_No()
            ' HiddenFieldTestSubGroup.Value = DropDownList2.SelectedValue

        End If
        Try
            If Session("YearlyNo").ToString Is Nothing Or Session("RegistrationNo").ToString Is Nothing Then

            Else
                'Session.Add("YearlyNo", Request.QueryString("YearlyNo").ToString)
                'Session.Add("RegistrationNo", Request.QueryString("Reg_No").ToString)
                HiddenFieldRegNo.Value = Session("registrationNo")
                HiddenFieldYearlyNo.Value = Session("YearlyNo")
            End If
        Catch ex As Exception

        End Try

        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
        'Main_Group()
        ' Button6.Attributes.Add("onclick", "return OpenNewPage()")
    End Sub
    Sub CheckAll(ByVal CheckBoxAll As CheckBoxList)
        Dim b As Integer
        Dim array(CheckBoxAll.Items.Count - 1) As String
        For b = 0 To CheckBoxAll.Items.Count - 1
            CheckBoxAll.Items(b).Selected = True
        Next
    End Sub
    ' This function Uncheck all the items of the selected chechboxlist.

    Sub UncheckAll(ByVal UncheckboxAll As CheckBoxList)
        Dim b As Integer
        Dim array(UncheckboxAll.Items.Count - 1) As String
        For b = 0 To UncheckboxAll.Items.Count - 1
            UncheckboxAll.Items(b).Selected = False
        Next
    End Sub



    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo & " AND (fee_paid = 0)", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Public Sub insertValues(ByVal ID As Integer, ByVal Appointment_Date As Date, ByVal Report_Date As Date, ByVal Instruction As String, ByVal radio As String, ByVal TGID As Integer, ByVal S_Id As Integer, Doctor_id As Integer, Anesthesia_Id As Integer, OT_Dept_ID As Integer)

        SqlDataSource_Booking_Service.Update()
        Dim qry As String
        Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constring)

        Dim cmd As SqlCommand = New SqlCommand("Test_Booking_Services_Update", con)
        cmd.CommandType = CommandType.StoredProcedure
        con.Open()


        Dim before_after As Boolean
        Dim Fit As Boolean
        Dim Status As Integer

        If radio = "Fit" Then
            Fit = True
            If TGID = 26 Or TGID = 11 Then
                If HiddenField_status.Value = "14" Then
                    'Commented by Waqas
                    'qry = "UPDATE Test_Booking_Services SET Appointment_Date = @Appointment_Date, Report_Date = @Report_Date, Instruction = @Instruction, Status = 6 , befor_after=1 WHERE (ID = @ID)"
                    before_after = True
                    Status = 6
                Else
                    'qry = "UPDATE Test_Booking_Services SET Appointment_Date = @Appointment_Date, Report_Date = @Report_Date, Instruction = @Instruction, Status = 6,befor_after=0 WHERE (ID = @ID)"
                    before_after = False
                    Status = 6
                End If
            Else
                If HiddenField_status.Value = "14" Then
                    'qry = "UPDATE Test_Booking_Services SET Appointment_Date = @Appointment_Date, Report_Date = @Report_Date, Instruction = @Instruction, Status = 1 , befor_after=1 WHERE (ID = @ID)"
                    before_after = True
                    Status = 1
                Else
                    'qry = "UPDATE Test_Booking_Services SET Appointment_Date = @Appointment_Date, Report_Date = @Report_Date, Instruction = @Instruction, Status = 1,befor_after=0 WHERE (ID = @ID)"                    
                    before_after = False
                    Status = 1
                End If
            End If



        ElseIf radio = "Unfit" Then

            ' qry = "UPDATE Test_Booking_Services SET  Status =@status  WHERE (ID = @ID)"
            'Dim cmd As SqlCommand = New SqlCommand(qry, con)
            'cmd.CommandType = CommandType.Text
            'con.Open()
            'cmd.Parameters.AddWithValue("@ID", ID)
            'cmd.Parameters.AddWithValue("@status", 15)
            'cmd.ExecuteNonQuery()
            'con.Close()

            Fit = False
            Status = 15
        End If

        If radio = "Fit" Or radio = "Unfit" Then
            cmd.Parameters.AddWithValue("@ID", ID)
            cmd.Parameters.AddWithValue("@Appointment_Date", Appointment_Date)
            cmd.Parameters.AddWithValue("@Report_Date", Report_Date)
            cmd.Parameters.AddWithValue("@Instruction", Instruction)
            cmd.Parameters.AddWithValue("@SId", S_Id)
            cmd.Parameters.AddWithValue("@Status", Status)
            cmd.Parameters.AddWithValue("@befor_after", before_after)
            cmd.Parameters.AddWithValue("@Fit", Fit)

            cmd.Parameters.AddWithValue("@Doctor_id", Doctor_id)
            cmd.Parameters.AddWithValue("@Anesthesia_Id", Anesthesia_Id)
            cmd.Parameters.AddWithValue("@OT_Dept_ID", OT_Dept_ID)

            cmd.ExecuteNonQuery()
            con.Close()
        End If

    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click

        For i As Integer = 0 To DataList1.Items.Count - 1

            Dim Appointment_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_AppointmentDate")
            Dim Report_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_ReportDate")
            Dim Instruction As TextBox = DataList1.Items(i).FindControl("TextBox_Instructions")
            Dim Appointment_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Appointment_time")
            Dim Report_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Report_time")
            Dim Id As HiddenField = DataList1.Items(i).FindControl("HiddenField_ID")
            Dim radio As RadioButtonList = DataList1.Items(i).FindControl("RadioButtonList1")
            Dim TGID As HiddenField = DataList1.Items(i).FindControl("HiddenField_TGID")
            Dim S_Id As HiddenField = DataList1.Items(i).FindControl("HiddenField_S_Id")


            Dim Doctor_id As DropDownList = DataList1.Items(i).FindControl("ddlDoctor")
            Dim Anesthesia_Id As DropDownList = DataList1.Items(i).FindControl("ddlAnesthesia")
            Dim OT_Dept_ID As DropDownList = DataList1.Items(i).FindControl("ddlOTDept")


            Dim iDoctor_id As Integer
            Dim iAnesthesia_Id As Integer
            Dim iOT_Dept_ID As Integer


            If Doctor_id.SelectedValue = "" Then
                iDoctor_id = -1

            else  
                iDoctor_id = Doctor_id.SelectedValue
            End If

            If Anesthesia_Id.SelectedValue = "" Then
                iAnesthesia_Id = -1

            Else
                iAnesthesia_Id = Anesthesia_Id.SelectedValue
            End If

            If OT_Dept_ID.SelectedValue = "" Then

                iOT_Dept_ID = -1
            Else
                iOT_Dept_ID = OT_Dept_ID.SelectedValue
            End If


            
            Dim app As Date
            Dim rpt As Date
            Dim app_time As Date
            Dim rpt_time As Date

            app_time = Appointment_Time.Value
            rpt_time = Report_Time.Value
            app = Appointment_Date.Value
            app = app.AddHours(Convert.ToDouble(app_time.Hour))
            app = app.AddMinutes(Convert.ToDouble(app_time.Minute))

            rpt = Report_Date.Value
            rpt = rpt.AddHours(Convert.ToDouble(rpt_time.Hour))
            rpt = rpt.AddMinutes(Convert.ToDouble(rpt_time.Minute))

            Try
                insertValues(Convert.ToInt32(Id.Value), app, rpt, Instruction.Text, radio.SelectedValue, CInt(TGID.Value), S_Id.Value, iDoctor_id, iAnesthesia_Id, iOT_Dept_ID)
            Catch ex As Exception
                'Response.Write(ex.Message)
            End Try

            '========================================== Insert External Lab Record ===========================
            Try
                Dim dli As DataListItem = DataList1.Items(i)
                Dim rbl_Fit As RadioButtonList = dli.FindControl("RadioButtonList1")
                Dim rbl_Lab_Type As RadioButtonList = dli.FindControl("rblLab_Type")

                If rbl_Lab_Type.SelectedValue = "1" And rbl_Fit.SelectedValue.ToUpper() = "FIT" Then
                    Dim ddl As DropDownList = dli.FindControl("ddlExternalLab")
                    Dim hf_TB_ID As HiddenField = dli.FindControl("HiddenField_TB_ID")
                    Dim hf_Main_ID As HiddenField = dli.FindControl("HiddenField_Main_ID")

                    HiddenField_Ext_lab_ID.Value = ddl.SelectedValue
                    HiddenField_Main_ID.Value = hf_Main_ID.Value
                    HiddenField_TB_ID.Value = hf_TB_ID.Value

                    SqlDataSource_Booking_Service.Insert()
                End If
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            '========================================== Insert External Lab Record End ===========================
        Next
        Response.Redirect("Sample_slip.aspx?Main_ID=" + Request.QueryString("Main_Id"))
        DataList1.DataBind()
        load_data()
    End Sub

    Protected Sub SqlDataSource_Booking_Service_Updated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Booking_Service.Updated
        HiddenField_status.Value = e.Command.Parameters("@Status").Value
        HiddenField_befor_after.Value = e.Command.Parameters("@befor_after").Value
    End Sub

    Protected Sub DataList1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.PreRender
        If Not IsPostBack Then


            For i As Integer = 0 To DataList1.Items.Count - 1
                Dim Appointment_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_AppointmentDate")
                Dim Report_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_ReportDate")
                Dim Appointment_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Appointment_time")
                Dim Report_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Report_time")

                Appointment_Date.Value = Date.Now.Date
                Report_Date.Value = Date.Now.Date
                Appointment_Time.Value = Date.Now

                Report_Time.Value = Date.Now
            Next
        End If
    End Sub
    Sub load_data()
        For i As Integer = 0 To DataList1.Items.Count - 1
            Dim Appointment_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_AppointmentDate")
            Dim Report_Date As WebDateChooser = DataList1.Items(i).FindControl("WebDateChooser_ReportDate")
            Dim Appointment_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Appointment_time")
            Dim Report_Time As Infragistics.WebUI.WebDataInput.WebDateTimeEdit = DataList1.Items(i).FindControl("WebDateTimeEdit_Report_time")

            Appointment_Date.Value = Date.Now.Date
            Report_Date.Value = Date.Now.Date
            Appointment_Time.Value = Date.Now

            Report_Time.Value = Date.Now
        Next
    End Sub

    Protected Sub WebDateChooser_AppointmentDate_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs)
        Dim c As DataListItem = CType(sender, Control).Parent
        Dim WebDateChooser_AppointmentDate As WebDateChooser = c.FindControl("WebDateChooser_AppointmentDate")

        HiddenField_Date.Value = WebDateChooser_AppointmentDate.Value
        'Response.Write(HiddenField_Date.Value)
        DataList_Final_List.DataBind()
    End Sub


    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl As RadioButtonList = sender
        Dim dli As DataListItem = rbl.NamingContainer
        Dim rbl_Lab_Type As RadioButtonList = dli.FindControl("rblLab_Type")
        Dim ddl As DropDownList = dli.FindControl("ddlExternalLab")
        Dim hl_AddLab As HyperLink = dli.FindControl("hl_AddLab")
        If rbl.SelectedValue.ToUpper = "FIT" Then
            rbl_Lab_Type.Visible = True
        Else
            rbl_Lab_Type.SelectedValue = "0"
            rbl_Lab_Type.Visible = False
            ddl.Visible = False
            hl_AddLab.Visible = False
        End If
    End Sub

    Protected Sub rblLab_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim rbl_Lab_Type As RadioButtonList = sender
        Dim dli As DataListItem = rbl_Lab_Type.NamingContainer
        Dim ddl As DropDownList = dli.FindControl("ddlExternalLab")
        Dim SQL As SqlDataSource = dli.FindControl("SQL_ExternalType")
        Dim hl_AddLab As HyperLink = dli.FindControl("hl_AddLab")

        If rbl_Lab_Type.SelectedValue = "1" Then
            ddl.Visible = True
            hl_AddLab.Visible = True
            ddl.DataSource = SQL
            ddl.DataBind()
        Else
            ddl.Visible = False
            hl_AddLab.Visible = False
            ddl.DataSource = Nothing
            ddl.DataBind()
        End If

    End Sub
End Class