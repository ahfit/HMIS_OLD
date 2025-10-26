Imports System.Data
Imports System.Data.SqlClient

Partial Class hacims_masterpage
    Inherits System.Web.UI.MasterPage

    Dim obj As New Draw_Panel
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString
    Dim reg_Constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString

    Dim ENC As New Encryption
    

  '  Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton1.Click
'        Response.Redirect("~/administrator/feedback.aspx")
'    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'hospital.Text = Session("HospitalID").ToString()

        If Session("emp_ID") Is Nothing Then
            Response.Redirect("~/login.aspx")
        End If

        Page.Header.DataBind()

		If Request.UserAgent.IndexOf("WebKit") > 0 Then
                Request.Browser.Adapters.Clear()
            End If
		
        If Session("HospitalID").ToString() = "10" Then

            hospital.Text = 10
        ElseIf Session("HospitalID").ToString() = "4" Then
            hospital.Text = 11
        ElseIf Session("HospitalID").ToString() = "12" Then
            hospital.Text = 12
        End If




        Dim Obj_Menu As New JavaScriptMenu
        Obj_Menu.loginvalidate()
        Try
            Session.Add("Page_Name", Request.QueryString("Page_Name"))
            Session.Add("Page", Request.QueryString("Page"))
        Catch ex As Exception

        End Try
        

        Employee_Info()

        If Not Page.IsPostBack Then
            LogUserPageAccess()
            GenerateDemoLink()
            GetDepartmentTemplates()

        End If
        '''''''''''''''''''
        '''''''''''''''

        Dim reg_no As String
        Try

            Try
                If Session("RegistrationNo") Is Nothing Then

                    If Not Request.QueryString("RegNo") Is Nothing Then

                        reg_no = Request.QueryString("RegNo")

                    Else

                    End If
                Else
                    reg_no = Session("RegistrationNo")
                End If

            Catch ex As Exception
                '  reg_no = Request.QueryString("RegNo")
            End Try


            If Not reg_no Is Nothing And Not Request.QueryString("PayId") Is Nothing Then
                Try
                    Session.Add("RegistrationNo", reg_no)
                Catch ex As Exception

                End Try

                Session.Add("YearlyNo", Request.QueryString("PayId"))

            End If

            If Session("RegistrationNo") Is Nothing Then
                patient_info.Visible = False
                HyperLink1.Visible = False                
                hlk_D_P1.Visible = True
            Else
                hlk_D_P1.Text = "Doctor Prescription Report"
                hlk_D_P1.NavigateUrl = "~/Pt_EMR/Doctor_PrescriptionFinal.aspx?RegNo=" + Convert.ToString(Session("RegistrationNo")) + "&YearlyNo=" + Convert.ToString(Session("YearlyNo"))
            End If

            HiddenField_regNo.Value = Session("RegistrationNo")
            HiddenField_Payis.Value = Session("YearlyNo")
            '==================================================================
            PatientOtherInfo(HiddenField_regNo.Value, HiddenField_Payis.Value)
            '===============================================================
            Dim ds As New XMLGeneratation
            Dim daPatient_Basic_Info As New XMLGeneratationTableAdapters.Patient_Basic_InfoTableAdapter
            Dim daVitals As New XMLGeneratationTableAdapters.VitalsTableAdapter
            Dim daAlert As New XMLGeneratationTableAdapters.OPD_AlertTableAdapter

            ds.Tables("Patient_Basic_Info").Clear()
            ds.Tables("Vitals").Clear()
            ds.Tables("OPD_Alert").Clear()

            daPatient_Basic_Info.FillBy(ds.Tables("Patient_Basic_Info"), HiddenField_regNo.Value, Convert.ToInt32(HiddenField_Payis.Value))
            'Convert.ToInt32(HiddenField_Payis.Value),
            daVitals.Fill(ds.Tables("Vitals"), HiddenField_regNo.Value, Convert.ToInt32(HiddenField_Payis.Value))
            daAlert.Fill(ds.Tables("OPD_Alert"), HiddenField_regNo.Value, Convert.ToInt32(HiddenField_Payis.Value))


            If ds.Tables("Patient_Basic_Info").Rows.Count <> 0 Then
                'Session.Add("PatientTemplateId", ds.Tables("Patient_Basic_Info").Rows(0).Item("Temp"))
                Try
                    If ds.Tables("Vitals").Rows.Count <> 0 Then
                        For i As Integer = 0 To ds.Tables("Vitals").Rows.Count - 1
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "Temp(F)" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Temp") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "BP High" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("BP") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "BP Low" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("BP") = ds.Tables("Vitals").Rows(i).Item("Result").ToString + " / " + ds.Tables("Patient_Basic_Info").Rows(0).Item("BP").ToString
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "Pulse" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Pulse") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "RR" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("RR") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "Weight" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Weight") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "Height" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Height") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "CVP" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("CVP") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                            If ds.Tables("Vitals").Rows(i).Item("VitalName") = "COH" Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("COH") = ds.Tables("Vitals").Rows(i).Item("Result")
                            End If
                        Next

                    Else

                        ds.Tables("Patient_Basic_Info").Rows(0).Item("Temp") = ""
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("BP") = ""
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("Pulse") = ""
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("RR") = ""

                    End If

                Catch ex As Exception

                End Try

                Try


                    If (ds.Tables("OPD_Alert").Rows.Count <> 0) Then

                        For i As Integer = 0 To ds.Tables("OPD_Alert").Rows.Count - 1
                            If i = 0 Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert1") = ds.Tables("OPD_Alert").Rows(i).Item("Alert")
                            End If
                            If i = 1 Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert2") = ds.Tables("OPD_Alert").Rows(i).Item("Alert")
                            End If
                            If i = 2 Then
                                ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert3") = ds.Tables("OPD_Alert").Rows(i).Item("Alert")
                            End If


                        Next

                    Else
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert1") = ""
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert2") = ""
                        ds.Tables("Patient_Basic_Info").Rows(0).Item("Alert3") = ""

                    End If
                Catch ex As Exception

                End Try

            End If



            FormView2.DataSource = ds.Tables("Patient_Basic_Info")
            FormView2.DataBind()


        Catch ex As Exception

        End Try

    End Sub
    Sub GetDepartmentTemplates()
        Dim objDbManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@HospitalId", Session("HospitalID")),
        New SqlParameter("@DeptId", Session("dept_id"))
         }
        Dim dt As DataTable = objDbManager.ExecuteDataTable("GetTemplatesByDept", "Treatment_AdminConnectionString", sqlParams)
        dLTemplates.DataSource = dt
        dLTemplates.DataBind()


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
            GetMenuData()
            GetNewMenuData()
            GetListMenuData()
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
            If Session("UserName").ToString().ToUpper().Contains("DEMO") Then

                Dim stringBui As StringBuilder = New System.Text.StringBuilder()

                Using hyperLink = New System.Web.UI.WebControls.HyperLink()
                    hyperLink.Text = "Demo"
                    hyperLink.NavigateUrl = "~/DemoHome.aspx"
                    hyperLink.ToolTip = "Demo"
                    hyperLink.cssClass = "cpass"
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
            param = mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            con.Open()
            Dim reader As System.Data.SqlClient.SqlDataReader = mycommand.ExecuteReader()
            If reader.Read = True Then
                LabelDoctorName.Text = reader.Item(0).ToString
                Label_SubDepartment.Text = reader.Item(1).ToString
                Label_Designation.Text = reader.Item(2).ToString
            End If
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
        Try

        
            Dim ds As DataSet = GetDataSetForMenu()
            Dim menu As New Menu

            For Each parentItem As DataRow In ds.Tables("Categories").Rows
                Dim categoryItem As MenuItem = New MenuItem()
                categoryItem.Text = parentItem("Module_Name")
                Dim Str As Int32 = parentItem("Module_ID")
                Dim ds_sub As DataSet = GetDataSetForSubMenu(Str)

                menu.Items.Add(categoryItem)
                For Each childItem As DataRow In ds_sub.Tables("child").Rows

                    Dim childrenItem As New MenuItem

                    childrenItem.Text = childItem("Page_Name")
                    childrenItem.NavigateUrl = childItem("Page_URL")
                    categoryItem.ChildItems.Add(childrenItem)

                Next

            Next
            menu.Orientation = Orientation.Horizontal

            menu.CssClass = "DynamicMenuStyle"
            menu.DynamicMenuItemStyle.CssClass = "DynamicMenuItemStyle"

        Catch ex As Exception
            Response.Redirect("login.aspx")
        End Try
    End Sub

    Function GetDataSetForMenu() As DataSet
        Dim myConnection As New SqlConnection(constr)

        Dim adCat As New SqlDataAdapter("SELECT DISTINCT Admin_User_Module.Module_ID, Admin_User_Module.Module_Name,Admin_User_Module.Priority as val FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " ) AND  (Admin_User_Module.Module_Type = 0  or (Admin_User_Module.For_Main_Page = 1 and Admin_Employee_Module_Pages.Emp_ID =8)) order by Admin_User_Module.Priority desc", myConnection)

        Dim ds As New DataSet
        Try
            adCat.Fill(ds, "Categories")

        Catch ex As Exception

        End Try

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
    Protected Function IS_Picture_Available() As Boolean
        Dim is_pic As Boolean = False
        Dim con As New SqlConnection(reg_Constr)
        Dim qry As String = "SELECT  case when len(Convert(Varchar,ISNULL(Picture, 0))) = 4 then 0 else 1 end AS Picture FROM Patient WHERE (RegNo = @RegNo)"
        Dim cmd As New SqlCommand(qry, con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@RegNo", Session("RegistrationNo").ToString)
        con.Open()
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            If reader.Item("Picture") = "0" Then
                is_pic = False
            Else
                is_pic = True
            End If
        End While

        Return is_pic

    End Function

    Function GetMenuData()

        Dim table As New DataTable()
        Dim conn As New SqlConnection(constr)
        Dim sql As String = "SELECT DISTINCT top(9) Admin_User_Module.Module_ID, Admin_User_Module.Module_Name,Admin_User_Module.Priority as val FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " ) AND  (Admin_User_Module.type = 1 or Admin_User_Module.For_Main_Page = 1) order by Admin_User_Module.Module_ID asc"
        Dim cmd As New SqlCommand(sql, conn)

        Dim da As New SqlDataAdapter(cmd)
        da.Fill(table)
        Dim view As New DataView(table)
        'view.RowFilter = "Module_ID is NULL"
        For Each row As DataRowView In view
            Dim menuItem As New MenuItem(row("Module_Name").ToString(), row("Module_ID").ToString())
            'menuItem.NavigateUrl = row("menu_url").ToString()
            menuBarr.Items.Add(menuItem)
            AddChildItems(table, menuItem)

        Next


    End Function
    Function GetNewMenuData()

        Dim table2 As New DataTable()
        Dim conn2 As New SqlConnection(constr)
        Dim sql2 As String = "SELECT DISTINCT Admin_User_Module.Module_ID, Admin_User_Module.Module_Name,Admin_User_Module.Priority as val FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " ) AND  (Admin_User_Module.type = 1 or Admin_User_Module.For_Main_Page = 1) and Admin_User_Module.Module_ID not in ( SELECT DISTINCT top(9) Admin_User_Module.Module_ID FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " ) AND  (Admin_User_Module.type = 1 or Admin_User_Module.For_Main_Page = 1) order by Admin_User_Module.Module_ID asc)"
        Dim cmd2 As New SqlCommand(sql2, conn2)
        Dim da2 As New SqlDataAdapter(cmd2)
        da2.Fill(table2)
        Dim view As New DataView(table2)
        'view.RowFilter = "menu_parent_id is NULL"
        For Each row As DataRowView In view
            Dim menuItem As New MenuItem(row("Module_Name").ToString(), row("Module_ID").ToString())
            'menuItem.NavigateUrl = row("menu_url").ToString()
            menuBarr2.Items.Add(menuItem)

            AddChildItems(table2, menuItem)
        Next

    End Function

    Function GetListMenuData()

        Dim table3 As New DataTable()
        Dim conn3 As New SqlConnection(constr)
        Dim sql3 As String = "SELECT DISTINCT Admin_User_Module.Module_ID, Admin_User_Module.Module_Name,Admin_User_Module.Priority as val FROM Admin_User_Module INNER JOIN Admin_Employee_Module_Pages ON Admin_User_Module.Module_ID = Admin_Employee_Module_Pages.Module_ID WHERE (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & " )   AND  (Admin_User_Module.Module_Type = 0  or (Admin_User_Module.For_Main_Page = 1 and Admin_Employee_Module_Pages.Emp_ID =8))    order by Admin_User_Module.Priority desc"
        Dim cmd3 As New SqlCommand(sql3, conn3)
        Dim da3 As New SqlDataAdapter(cmd3)
        da3.Fill(table3)
        Dim view As New DataView(table3)
        'view.RowFilter = "menu_parent_id is NULL"
        For Each row As DataRowView In view
            Dim menuItem As New MenuItem(row("Module_Name").ToString(), row("Module_ID").ToString())
            'menuItem.NavigateUrl = row("menu_url").ToString()
            menuBarr3.Items.Add(menuItem)

            AddChildItems(table3, menuItem)
        Next

    End Function

    Function AddChildItems(ByVal table As DataTable, ByVal menuItem As MenuItem)

        Dim str As String = menuItem.Value
        Dim myConnection As New SqlConnection(constr)
        Dim adCat As New SqlDataAdapter("SELECT DISTINCT Admin_User_Module_Pages.Page_Name, Admin_User_Module_Pages.Page_URL,Admin_User_Module_Pages.Priority,Admin_Employee_Module_Pages.Page_ID FROM Admin_Employee_Module_Pages INNER JOIN Admin_User_Module_Pages ON Admin_Employee_Module_Pages.Page_ID = Admin_User_Module_Pages.Page_ID WHERE  (Admin_Employee_Module_Pages.Emp_ID =" & Session("emp_id") & ") AND (Admin_User_Module_Pages.Module_ID =" & str & ") ORDER BY Admin_User_Module_Pages.Priority", myConnection)
        Dim dt As DataTable = New DataTable()
        adCat.Fill(dt)
        Dim viewItem As New DataView(dt)
        For Each childView As DataRowView In viewItem
            Dim childItem As New MenuItem
            childItem.Text = childView("Page_Name").ToString()
            childItem.NavigateUrl = childView("Page_URL").ToString()
            menuItem.ChildItems.Add(childItem)

            menuBarr.DataBind()
            'Panel1.DataBind()
            'AddChildItems(table, childItem)

        Next
    End Function
    Protected Sub FormView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles FormView2.PreRender
        Try
            If FormView2.Row Is Nothing Then
                Return
            End If
            Dim lbl_Prefix As Label = FormView2.Row.FindControl("PatientNameLabel")
            Dim lbl_RegNo As Label = FormView2.Row.FindControl("RegistrationNo")
            Dim hid_pfname As HiddenField = FormView2.Row.FindControl("HiddenField_pfname")
            Dim hid_pmname As HiddenField = FormView2.Row.FindControl("HiddenField_pmname")
            Dim hid_plname As HiddenField = FormView2.Row.FindControl("HiddenField_plname")
            'Dim Image_Pic As Image = FormView2.Row.FindControl("Image_Pic")

            lbl_RegNo.Text = ENC.Encrypt_Main(lbl_RegNo.Text, False)
            lbl_Prefix.Text = lbl_Prefix.Text & " " & ENC.Encrypt_Main(hid_pfname.Value, False) & " " & ENC.Encrypt_Main(hid_pmname.Value, False) & " " & ENC.Encrypt_Main(hid_plname.Value, False)
            'If IS_Picture_Available() Then
            '    Image_Pic.ImageUrl = "~/ShowImage.ashx?RegNO=" + Session("RegistrationNo").ToString()
            'Else
            '    Image_Pic.ImageUrl = "~/Patient_picture/kih_picframe.png"

            'End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try




  
	 
   
    End Sub


    Sub PatientOtherInfo(ByVal regno As String, ByVal payid As Int32)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT     Payment.DeptID, Department.Hospital_ID, Payment.Patient_Type, isnull(Payment.Patient_Type_ID,0)as Patient_Type_ID, isnull(Party_Designations.Party_ID,0) as Party_ID, isnull(Parties.Party_Name,'') as Party_Name FROM Party_Designations INNER JOIN Parties ON Party_Designations.Party_ID = Parties.Party_Id RIGHT OUTER JOIN Payment INNER JOIN Department ON Payment.DeptID = Department.Dept_ID ON Party_Designations.Party_Desg_ID = Payment.Billing_Group_Id  where payment.regNo = @RegNo and payment.payid = @payid", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", regno)
            mycommand.Parameters.AddWithValue("@payid", payid)
            con.Open()
            Dim reader As SqlDataReader = mycommand.ExecuteReader
            While reader.Read
                Session.Add("PatientDept", reader.Item("DeptID"))
                Session.Add("PatientHospital_ID", reader.Item("Hospital_ID"))
                Session.Add("IPDOPD", reader.Item("Patient_Type"))
                Session.Add("Patient_Type_ID", reader.Item("Patient_Type_ID"))
                Session.Add("PatientBillingParty_Id", reader.Item("Party_ID"))
                Session.Add("Patient_BillingParty_Name", reader.Item("Party_Name"))

            End While
            con.Close()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
End Class

