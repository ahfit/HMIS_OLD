Imports System.Data
Imports System.Data.SqlClient

Partial Class hacims_masterpage_main
    Inherits System.Web.UI.MasterPage

    Dim obj As New Draw_Panel
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
    Dim ENC As New Encryption



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Page.Header.DataBind()

        If Request.UserAgent.IndexOf("WebKit") > 0 Then
            Request.Browser.Adapters.Clear()
        End If


        Dim Obj_Menu As New JavaScriptMenu
        Obj_Menu.loginvalidate()

        Session.Add("Page_Name", Request.QueryString("Page_Name"))
        Session.Add("Page", Request.QueryString("Page"))
        Employee_Info()


        If Not Page.IsPostBack Then
            LogUserPageAccess()
            GenerateDemoLink()
        End If

        '''''''''''''''''''
        '''''''''''''''

        'If Session("HospitalID").ToString() = "10" Then

        '  hospital.Text  = 10
        '  ElseIf Session("HospitalID").ToString() = "4" Then
        '           hospital.Text = 11
        ' ElseIf Session("HospitalID").ToString() = "12" Then
        '  hospital.Text = 12
        '       End If
        'response.write(Session("HospitalID").ToString())



        Dim reg_no As String
        Try

            Try
                If Not Request.QueryString("RegNo") Is Nothing Then
                    reg_no = Request.QueryString("RegNo")
                Else

                End If
            Catch ex As Exception
                reg_no = Request.QueryString("Reg_No")
            End Try


            If Not reg_no Is Nothing And Not Request.QueryString("PayId") Is Nothing Then
                Try
                    Session.Add("RegistrationNo", reg_no)
                Catch ex As Exception

                End Try


                Session.Add("YearlyNo", Request.QueryString("PayId"))

            End If




        Catch ex As Exception



        End Try
        Dim dt As DataTable = Session("Header_DT")
        'hospital.Text = dt.Rows(0)("Hospital_Name").ToString() + "<br>" + dt.Rows(0)("Hospital_Address").ToString() + "<br>" + dt.Rows(0)("TehsilName").ToString() + "<br>" + dt.Rows(0)("Hospital_Phone").ToString() + "    " + dt.Rows(0)("Hospital_FaxNo").ToString()
        hospital.Text = dt.Rows(0)("Hospital_Name").ToString() + "<br>" + dt.Rows(0)("TehsilName").ToString()
        Image1.ImageUrl = "~/ShowHeaderImage.ashx?RegNO=" + dt.Rows(0)("Hospital_ID").ToString()

    End Sub

    Private Sub LogUserPageAccess()
        Try
            'Dim temp As New HttpSessionState
            Dim userPageData As New UserAccessLog.UserPageAccessLogsDTO
            Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
            userPageData.Session_ID = Session.SessionID
            userPageData.Access_DateTime = DateTime.Now
            userPageData.Page_Name = Request.RawUrl
            userPageData.UserName = Session("UserName")
            userPageData.User_IP = HttpContext.Current.Request.UserHostAddress
            userPageData.Emp_ID = GetSessionToInt("emp_id")
            userPageData.Dept_ID = GetSessionToInt("dept_id")
            userPageData.SubDept_ID = GetSessionToInt("SubDeptID")
            userPageData.Yearly_No = GetSessionToLong("YearlyNo")
            Dim userDataManager As New UserAccessLog.UserAccessLogDBManager(constring)
            userDataManager.LogUserPageAccessLogs(userPageData)

        Catch ex As Exception

        End Try
    End Sub

    Private Function GetSessionToInt(ByVal sessionKey As String) As Integer
        Dim retVal As Integer
        Try
            retVal = Integer.Parse(Session(sessionKey).ToString())
        Catch ex As Exception
            retVal = 0
        End Try
        Return retVal
    End Function


    Private Function GetSessionToLong(ByVal sessionKey As String) As Long
        Dim retVal As Long
        Try
            retVal = Long.Parse(Session(sessionKey).ToString())
        Catch ex As Exception
            retVal = 0
        End Try
        Return retVal
    End Function

    Private Sub GenerateDemoLink()
        Try
            If Session("UserName").ToString().ToUpper().Contains("ADMIN") Then

                Dim stringBui As StringBuilder = New System.Text.StringBuilder()

                Using hyperLink = New System.Web.UI.WebControls.HyperLink()
                    hyperLink.Text = "Demo"
                    hyperLink.NavigateUrl = "~/DemoHome.aspx"
                    hyperLink.ToolTip = "Demo"
                    hyperLink.CssClass = "cpass"
                    Using stringWriter = New System.IO.StringWriter(stringBui)
                        Using htmlTextWriter = New System.Web.UI.HtmlTextWriter(stringWriter)
                            hyperLink.RenderControl(htmlTextWriter)
                        End Using
                    End Using

                End Using

                ltrDemo.Text = "<span class=""spltr"">|&nbsp;</span>" + stringBui.ToString()

            Else
                ltrDemo.Text = String.Empty
            End If
        Catch ex As Exception

        End Try
    End Sub

    Sub Employee_Info()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As System.Data.SqlClient.SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT ISNULL(Employee.Prefix, '') + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Expr1, Department.Dept_Name + ' (' + SubDepartment.SubDept_Name + ')' AS Expr2, Designation.Designation_Name FROM Employee INNER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN Designation ON Employee.DesignationID = Designation.Designation_ID WHERE (Employee.EmpID = @Emp_ID)", con)
            mycommand.CommandType = Data.CommandType.Text
            Dim param As System.Data.SqlClient.SqlParameter
            'If Request.QueryString("empid") Is Nothing Then
            '    param = mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            'Else
            '    param = mycommand.Parameters.AddWithValue("@Emp_ID", Request.QueryString("empid"))
            'End If

            param = mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            Dim reader As System.Data.SqlClient.SqlDataReader = mycommand.ExecuteReader()
            If reader.Read = True Then
                LabelDoctorName.Text = reader.Item(0).ToString
                Label_SubDepartment.Text = reader.Item(1).ToString
                Label_Designation.Text = reader.Item(2).ToString
            End If
            'LabelDate.Text = FormatDateTime(Date.Now, DateFormat.LongDate)
            If String.IsNullOrEmpty(Session("Emp_Log_time")) Then
                LabelDate.Text = FormatDateTime(Date.Now, DateFormat.LongDate) + " " + FormatDateTime(Date.Now, DateFormat.LongTime)
            Else
                LabelDate.Text = FormatDateTime(CDate(Session("Emp_Log_time")), DateFormat.LongDate) + " " + FormatDateTime(CDate(Session("Emp_Log_time")), DateFormat.LongTime)

            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub loginvalidate()
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("~/login.aspx")
            End If
        Catch ex As Exception
        End Try
    End Sub






    Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreRender
        PopulateMenu()
    End Sub
    Sub PopulateMenu()
        Dim ds As DataSet = GetDataSetForMenu()
        Dim menu As New Menu
        Try


            For Each parentItem As DataRow In ds.Tables("Categories").Rows
                Dim categoryItem As MenuItem = New MenuItem()
                categoryItem.Text = parentItem("Module_Name")
                Dim Str As Int32 = parentItem("Module_ID")
                Dim ds_sub As DataSet = GetDataSetForSubMenu(Str)

                menu.Items.Add(categoryItem)



                Try


                    For Each childItem As DataRow In ds_sub.Tables("child").Rows

                        Dim childrenItem As New MenuItem

                        childrenItem.Text = childItem("Page_Name")
                        childrenItem.NavigateUrl = childItem("Page_URL")
                        categoryItem.ChildItems.Add(childrenItem)

                    Next
                Catch ex As Exception
                    Response.Write(categoryItem.Text)
                End Try
            Next
            menu.Orientation = Orientation.Horizontal

            menu.CssClass = "DynamicMenuStyle"
            menu.DynamicMenuItemStyle.CssClass = "DynamicMenuItemStyle"


            Panel1.Controls.Add(menu)
            Panel1.DataBind()
        Catch ex As Exception
            Response.Write("Error main Main Load")
        End Try
    End Sub

    Function GetDataSetForMenu() As DataSet
        Dim myConnection As New SqlConnection(constr)
        'Dim adCat As New SqlDataAdapter("SELECT DISTINCT Admin_User_Module.Module_ID, Admin_User_Module.Module_Name, Admin_User_Module.Priority AS val FROM         Admin_User_Module RIGHT OUTER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " ) AND (Admin_User_Module.For_Main_Page = 0) order by Admin_User_Module.Priority", myConnection)
        Dim adCat As New SqlDataAdapter("SELECT DISTINCT Admin_User_Module.Module_ID, Admin_User_Module.Module_Name,Admin_User_Module.Priority as val FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " And Admin_Employee_Module_Pages.Emp_ID <> 1144 ) AND (Admin_User_Module.For_Main_Page = 0) order by Admin_User_Module.Priority", myConnection)                                ' and (Admin_User_Module.Module_Type = 0) order by Admin_User_Module.Priority", myConnection)

        Dim ds As New DataSet
        adCat.Fill(ds, "Categories")

        Return ds
    End Function

    Function GetDataSetForSubMenu(ByVal str As Int32) As DataSet
        Dim myConnection As New SqlConnection(constr)
        Dim adCat As New SqlDataAdapter("SELECT DISTINCT Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL,Admin_User_Module_Pages.Priority,Admin_Employee_Module_Pages.Page_ID FROM Admin_Employee_Module_Pages INNER JOIN Admin_User_Module_Pages ON Admin_Employee_Module_Pages.Page_ID = Admin_User_Module_Pages.Page_ID WHERE  (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & ") AND (Admin_User_Module_Pages.Module_ID =" & str & ")ORDER BY Admin_User_Module_Pages.Priority", myConnection)
        Dim ds As New DataSet
        adCat.Fill(ds, "child")
        Return ds
    End Function
    Function Decrypt_String(ByVal Txt As String, ByVal Key As Integer, ByVal Default_Space As Boolean) As String
        Dim First_Space As Boolean = Default_Space
        Dim st As String = ""
        For i As Integer = 0 To Txt.Length - 1
            If Txt(i) = " " Then
                st = st & Convert.ToChar(Asc(Txt(i))).ToString
                First_Space = True
            ElseIf First_Space = False Then
                st = st & Convert.ToChar(Asc(Txt(i))).ToString
            Else
                st = st & Convert.ToChar(Asc(Txt(i)) - Key).ToString
            End If
        Next
        Return st
    End Function



End Class

