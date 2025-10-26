Imports System.Data
Imports System.Data.SqlClient
Partial Class login
    Inherits System.Web.UI.Page
    Dim departmentid As Integer
    Dim value, value1 As String
    Dim user_authen As New User_page_Authentication
    Dim ENC As New Encryption
    '=====================********======================================'
    ' Developer Name          Imran Ahmed Awan,Muhammad Aun Abbas
    ' Design Aproved  by       Muhammad Tariq
    ' Web Design By           Imran Sharif
    ' Date Started            October 2006,27 November 2006
    ' Description             This Is Login page for the user the Hospital no one user can access the  
    '                         software without Login , This form get the Employee Id , Employee Department 
    '                         and check the category of the Employee.
    ' Use                     This form is used overall in the Hospital.
    '                        This page uses UserLogin stored procedure which takes input parameter
    '                       userlogin and password as input parameter
    '                        return empid, deptid, main page 
    '                       as ouput parameter ,
    '                       if user is not validated message is return Enter login information
    '                       else user is redirected to page which is return as output parameter.
    ' Completed date          October 28 , 2006, 27 November 2006
    'Version                2.0
    'Changed by             Muhammad Aun Abbas
    'Chaged description     Uses stroed procedure "UserLogin" for user authentication and redirect the user
    '                       to its access level page.
    '====================*********======================================'




    'This function check the username and password of the employee 

    Protected Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

        Try

            If Not Page.IsValid Then
                Return
            End If

            'Use connectionstring
            Dim xml As New GenerateXML
            Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim empid As Integer
            Dim deptid As Integer
            Dim mainpage As String
            Dim subdeptid As Integer
            Dim ShiftID As Integer
            Dim dept_Introduction As String
            'Enter procedure name
            Dim Procedurename As String = "UserLogin"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Username", txtusername.Text)
            mycommand.Parameters.AddWithValue("@Password", ENC.Encrypt_Main(txtPassword.Text, True))
            'declare output parameter
            'Response.Write(ENC.Encrypt_Main(txtPassword.Text, True))
            mycommand.Parameters.Add("@EmpId", Data.SqlDbType.Int)
            mycommand.Parameters("@EmpId").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@DeptId", Data.SqlDbType.Int)
            mycommand.Parameters("@DeptId").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@Designation", Data.SqlDbType.Int)
            mycommand.Parameters("@Designation").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@HospitalID", SqlDbType.Int)
            mycommand.Parameters("@HospitalID").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@AttachHospitalID", SqlDbType.Int)
            mycommand.Parameters("@AttachHospitalID").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@Emp_Type", Data.SqlDbType.VarChar, 30)
            mycommand.Parameters("@Emp_Type").Direction = ParameterDirection.Output
            '@Designation
            mycommand.Parameters.Add("@MainPage", Data.SqlDbType.VarChar, 400)
            mycommand.Parameters("@MainPage").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@SubDeptId", Data.SqlDbType.Int)
            mycommand.Parameters("@SubDeptId").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@ShiftID", Data.SqlDbType.Int)
            mycommand.Parameters("@ShiftID").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@dept_Introduction", Data.SqlDbType.VarChar, 4000)
            mycommand.Parameters("@dept_Introduction").Direction = ParameterDirection.Output
            mycommand.Parameters.Add("@deptName", Data.SqlDbType.VarChar, 100)
            mycommand.Parameters("@deptName").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@SubDeptName", Data.SqlDbType.VarChar, 100)
            mycommand.Parameters("@SubDeptName").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@Branch_Access", Data.SqlDbType.VarChar, 100)
            mycommand.Parameters("@Branch_Access").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@Company_Branch_Id", Data.SqlDbType.Int, 100)
            mycommand.Parameters("@Company_Branch_Id").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@Financial_Company_Id", Data.SqlDbType.Int, 100)
            mycommand.Parameters("@Financial_Company_Id").Direction = Data.ParameterDirection.Output
            mycommand.Parameters.Add("@Is_Valid_Login", System.Data.SqlDbType.Bit)
            mycommand.Parameters("@Is_Valid_Login").Direction = Data.ParameterDirection.Output
            con.Open()
            mycommand.ExecuteNonQuery()

            If Not Boolean.Parse(mycommand.Parameters("@Is_Valid_Login").Value.ToString()) Then
                EnterUserLoginLog(False)
                SetInvalidLoginAttempCount()
                'If GetInvalidLoginAttempCount() >= 3 Then
                '    SetAccountInActive(txtusername.Text.Trim())
                '    lblMessage.Visible = True
                '    lblMessage.Text = "Account is blocked for Invalid attempts."
                '    SendUserBlockEmail(txtusername.Text)
                '    Return
                'End If
                lblMessage.Visible = True
                lblMessage.Text = "Enter Correct UserName &amp; Password"
                Return
            Else
                EnterUserLoginLog(True)
            End If

            Session("HospitalID") = mycommand.Parameters("@HospitalID").Value.ToString()
            Session("AttachHospitalID") = mycommand.Parameters("@AttachHospitalID").Value.ToString()

            Dim DS_HospitalHeader As New AdminReports()
            Dim DA_HospitalHeader As New AdminReportsTableAdapters.Hospital_HeaderTableAdapter()
            Dim DA_Hospital_Master As New AdminReportsTableAdapters.HospitalTableAdapter()
            DA_HospitalHeader.Fill(DS_HospitalHeader.Hospital_Header, Convert.ToInt32(mycommand.Parameters("@HospitalID").Value.ToString()))
            DA_Hospital_Master.Fill(DS_HospitalHeader.Hospital, Convert.ToInt32(mycommand.Parameters("@HospitalID").Value.ToString()))
            Session.Add("Header_DT", DS_HospitalHeader.Tables("Hospital"))
            Session.Add("Rpt_Header_DT", DS_HospitalHeader.Tables("Hospital_Header"))

            empid = mycommand.Parameters("@EmpId").Value.ToString
            Session.Add("emp_id", empid)


            Try
                Dim constringBasic As String = ConfigurationManager.ConnectionStrings("BasicDataInfoConnectionString").ConnectionString
                Dim conBasicdata As SqlConnection = New System.Data.SqlClient.SqlConnection(constringBasic)
                'Enter procedure name
                Dim commandText As String = "select isnull(p.status,0)  from PatientEditRights p where p.empid=" + Session("emp_id").ToString() + ""
                Dim command As New System.Data.SqlClient.SqlCommand(Procedurename, conBasicdata)
                command.CommandType = Data.CommandType.Text
                command.CommandText = commandText

                conBasicdata.Open()
                Dim rdr As SqlDataReader = command.ExecuteReader()
                If rdr.HasRows Then
                    While rdr.Read()

                        If rdr(0).ToString() = "True" Then
                            Session("status") = rdr(0).ToString()
                        End If
                    End While
                End If
            Catch ex As Exception

            End Try





















            deptid = mycommand.Parameters("@DeptId").Value.ToString
            Session.Add("dept_id", deptid)
            mainpage = mycommand.Parameters("@MainPage").Value.ToString.Trim
            Session.Add("MainPage", mainpage)
            'Response.Write("Mainpage.aspx")
            subdeptid = mycommand.Parameters("@SubDeptId").Value.ToString
            Session.Add("SubDeptID", subdeptid)
            ShiftID = mycommand.Parameters("@ShiftID").Value.ToString
            Session.Add("ShiftID", ShiftID)
            dept_Introduction = mycommand.Parameters("@dept_Introduction").Value.ToString
            Session.Add("dept_Introduction", dept_Introduction)
            Session.Add("DesignationID", mycommand.Parameters("@Designation").Value.ToString)

            Session.Add("Emp_Type", mycommand.Parameters("@Emp_Type").Value.ToString)
            Session.Add("UserName", txtusername.Text)
            Session.Add("deptName", mycommand.Parameters("@deptName").Value.ToString.Trim)
            Session.Add("SubDeptName", mycommand.Parameters("@SubDeptName").Value.ToString.Trim)
            Session.Add("Branch_Access", mycommand.Parameters("@Branch_Access").Value.ToString.Trim)
            Session.Add("Company_Branch_Id", mycommand.Parameters("@Company_Branch_Id").Value.ToString.Trim)
            Session.Add("Financial_Company_Id", mycommand.Parameters("@Financial_Company_Id").Value.ToString.Trim)
            Session.Timeout = 320
            Session.Add("Emp_Log_time", DateAndTime.Now)
            getHeader()

            Try
                xml.ConStr = "Reg_ConnectionString"
                xml.ProcedureName = "doc_Appointment"
                xml.FileName = "doc_appointment.xml"
                xml.doc_Appointment(empid)
            Catch ex As Exception

            End Try
            If (mainpage Is Nothing) Then
                lblMessage.Visible = True
                lblMessage.Text = "Invalid Login Information"
            Else

                Session("Module_ID") = user_authen.Tabs_selection1(mainpage, empid)
                Response.Redirect(mainpage)
            End If

            'Close connection
            con.Close()

        Catch ex As Exception
            lblMessage.Visible = True
            Response.Write(ex.Message)
            lblMessage.Text = "Enter Correct UserName &amp; Password" '& ex.Message
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            'Response.Write(ex.Message)
        End Try
    End Sub

    Private Sub SendUserBlockEmail(ByVal userName As String)
        Dim From As String = "mpsoftware@megaplus.com.pk"
        Dim ToEmail As String = "syed.aamir@megaplus.my;muhammad.awais@megaplus.com.pk;tariq@megaplus.com.pk" '""

        Try

            Dim mail As New System.Net.Mail.MailMessage()

            Dim toEmailAddresses As String() = ToEmail.Split(New Char() {";"c}, StringSplitOptions.RemoveEmptyEntries)

            For Each t As String In toEmailAddresses
                mail.[To].Add(t)
            Next

            'mail.To.Add(ToEmail);

            'mail.CC.Add(GetAppSetting("FinanceEmail"))
            mail.From = New Net.Mail.MailAddress(From, "User Account Blocked", System.Text.Encoding.UTF8)
            mail.Subject = "User Account Blocked"
            mail.SubjectEncoding = System.Text.Encoding.UTF8
            mail.Body = "Dear Admin, <br /><br /><br />" & String.Format("User Account for User <b>{0}</b> is blocked due to invalid attempts. <br /><br /> Best Regards, <br /> Technical Support Team.", userName)

            mail.BodyEncoding = System.Text.Encoding.UTF8
            mail.IsBodyHtml = True
            'mail.Priority = MailPriority.High

            Dim client As New Net.Mail.SmtpClient()

            client.Credentials = New System.Net.NetworkCredential(From, "dellsoft")
            client.Port = 587
            client.Host = "mail.megaplus.com.pk"
            client.EnableSsl = False
            Try
                client.Send(mail)
                'WriteEmailLog(From, ToEmail)
            Catch ex As Exception
                If ex.InnerException Is Nothing Then
                    'WriteErrorLog(ex.Message + "::" + ex.StackTrace)
                Else
                    'WriteErrorLog((ex.Message + "::" + ex.StackTrace & "::") + ex.InnerException.Message)
                End If

            End Try
        Catch ex As Exception
            If ex.InnerException Is Nothing Then
                'WriteErrorLog(ex.Message + "::" + ex.StackTrace)
            Else
                'WriteErrorLog((ex.Message + "::" + ex.StackTrace & "::") + ex.InnerException.Message)
            End If
        End Try

    End Sub


    Private Sub EnterUserLoginLog(ByVal success As Boolean)
        Try

            Dim userData As New UserAccessLog.UsageLogDTO
            Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
            If success Then
                userData.RH_ID = 1
            Else
                userData.RH_ID = 0
            End If
            userData.Useage_DateTime = DateTime.Now
            userData.UserIP = HttpContext.Current.Request.UserHostAddress
            userData.UserName = txtusername.Text.Trim()
            Dim userDataManager As New UserAccessLog.UserAccessLogDBManager(constring)
            userDataManager.LogUserAccessLog(userData)

        Catch ex As Exception

        End Try
    End Sub

    Private Sub SetAccountInActive(ByVal userName As String)
        Try
            'Use connectionstring
            Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            'Enter procedure name
            Dim Procedurename As String = "SetUserAccountInactive"
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            mycommand.CommandText = Procedurename
            mycommand.Parameters.AddWithValue("@Username", userName)
            con.Open()
            mycommand.ExecuteNonQuery()

            con.Close()
        Catch ex As Exception
            lblMessage.Visible = True
            Response.Write(ex.Message)
            'lblMessage.Text = "Enter Correct UserName &amp; Password" '& ex.Message
            'Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            'Response.Write(ex.Message)
        End Try
    End Sub
    Private Sub SetInvalidLoginAttempCount()
        Try
            If Session("INVALID_LOGIN_ATTEMP") Is Nothing Then
                Session("INVALID_LOGIN_ATTEMP") = 1
            Else
                Dim invalidLoginCount As Integer = 0
                invalidLoginCount = Integer.Parse(Session("INVALID_LOGIN_ATTEMP").ToString())
                invalidLoginCount += 1
                Session("INVALID_LOGIN_ATTEMP") = invalidLoginCount
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Function GetInvalidLoginAttempCount() As Integer
        Try
            Return Integer.Parse(Session("INVALID_LOGIN_ATTEMP").ToString())
        Catch ex As Exception
            Return 0
        End Try
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        LabelDate.Text = FormatDateTime(Date.Now, DateFormat.LongDate) + " " + FormatDateTime(Date.Now, DateFormat.LongTime)
        lblMessage.Visible = False

        If Not Page.IsPostBack Then
            Session.RemoveAll()

        End If

        txtusername.Focus()

        btnLogin.Attributes.Add("OnClick", "return checkValue(this)")
    End Sub
    Private Sub getHeader()

        Try
            Dim dbMgr As DbManager = New DbManager()
            Dim para As SqlParameter() = {New SqlParameter("@HospitalID", Session("HospitalId"))}
            Dim dt As DataTable = dbMgr.ExecuteDataTable("usp_ReportHeaderData_forSession", "Basic_Data_ConnectionString", para)
            Session("DynamicHeader") = dt
        Catch generatedExceptionName As Exception
        Finally

        End Try
    End Sub
 
End Class
