Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Imports System.Collections
Imports System.IO

Partial Class employee
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    ' this function insert the information of the employee in the database by sqldatasourcesaveinfo
    Dim user_authen As New User_page_Authentication
    Dim File_Path As String = Server.MapPath("~/HR/images/")
    Dim fileName As String
    Dim name As String
    Protected Sub save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click

        If (Page.IsValid) Then

            If ButtonSave.Text = "Save" Then


                HiddenField_Current_Designation_JoinDate.Value = WebDateChooser_CurretDesigJoinDate.Value
                Dim dob As String = TextBox_DOB_Month.Text & "/" & TextBox_DOB_day.Text & "/" & TextBox_DOB_Year.Text

                HiddenField_DOB.Value = dob
                'HiddenFieldStartDate.Value = TextBox_Service_Start_Date_month.Text & "-" & TextBox_service_satart_Date_day.Text & "-" & TextBox_service_Start_Date_Year.Text


                If String.IsNullOrEmpty(WebDateChooser_NICExpiry.Value) Then
                    HiddenField_NICExpiry.Value = DBNull.Value.ToString()
                Else
                    HiddenField_NICExpiry.Value = WebDateChooser_NICExpiry.Value
                End If



                'If Not IsDBNull(ContractSdate.Value) Then
                '    If ContractSdate.Value <> "" Then


                '        HiddenField_ContractSdate.Value = ContractSdate.Value

                '        HiddenField_ContractEdate.Value = ContractEdate.Value
                '    Else


                '        HiddenField_ContractSdate.Value = ""

                '        HiddenField_ContractEdate.Value = ""
                '    End If


                'End If

                'Dim a As String

                'a = txtmonth.Text & "-" & txtday.Text & "-" & txtyear.Text


                'Session("EJDate") = a
                HiddenFieldCNIC.Value = TextBox_CNIC.Text

                If HiddenFieldCNIC.Value = "     -       - " Then
                    HiddenFieldCNIC.Value = ""
                End If
                HiddenFieldHomePhone.Value = txthp1.Text & txthp2.Text & txthp3.Text
                HiddenFieldOfficePhone.Value = txtop1.Text & txtop2.Text & txtop3.Text
                'DropDownList_Type.SelectedValue = 1



                Try
                    SqlDataSourceSaveInfo.Insert()
                    Label_message.ForeColor = Drawing.Color.Green : Label_message.Text = "Your Information has been saved"

                    If HiddenField_ImageAttached.Value = "1" Then
                        Try
                            Dim fs1 As FileStream = New FileStream(Session("File_Path") + Session("fileName"), FileMode.Open)

                            If HiddenField_Employee_ID.Value = "" Then
                                Dim connection As New SqlConnection
                                Dim conCommand As SqlCommand
                                Dim reader As SqlDataReader
                                connection.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                                connection.Open()
                                conCommand = connection.CreateCommand()
                                conCommand.CommandText = " Select max(EmpID) From Employee"
                                reader = conCommand.ExecuteReader
                                If reader.Read Then
                                    HiddenField_Employee_ID.Value = reader.Item(0)
                                End If
                                reader.Close()
                                connection.Close()
                            End If




                            Dim conn As New SqlConnection
                            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                            Dim SQL As String = "update [Employee] set [picture]= @picture where EmpID=" + HiddenField_Employee_ID.Value
                            Dim myCommand As New SqlCommand(SQL, conn)
                            Dim b(fs1.Length) As Byte
                            fs1.Read(b, 0, fs1.Length)
                            myCommand.Parameters.AddWithValue("@picture", b)
                            conn.Open()
                            myCommand.ExecuteNonQuery()
                            conn.Close()
                        Catch ex As Exception

                        End Try

                    End If



                    hlnkAdditionalInfo.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo.Visible = True
                    hlnkEmployeeCertifications.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications.Visible = True
                    'hlnkEmployeeDocuments.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments.Visible = True
                    hlnkEmployeeEducation.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation.Visible = True
                    hlnkEmployeeRelationship.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship.Visible = False

                    hlnkEmployeeSkills.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills.Visible = True
                    hlnkEmployeeExperience.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience.Visible = True



                    hlnkAdditionalInfo1.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo1.Visible = True
                    hlnkEmployeeCertifications1.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications1.Visible = True

                    'hlnkEmployeeDocuments1.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments1.Visible = True

                    hlnkEmployeeEducation1.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation1.Visible = True

                    hlnkEmployeeRelationship1.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship1.Visible = False

                    hlnkEmployeeSkills1.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills1.Visible = True
                    hlnkEmployeeExperience1.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience1.Visible = True


                    HiddenField_ImageAttached.Value = "0"
                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<script language='javascript'>")
                    sb.Append("alert(' Information Saved Successfuly ')</script>")
                    Dim t As Type = Me.GetType
                    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                    End If
                    ImageButton1.ImageUrl = "~/images/PictureFrame.png"
                    clearText()

                Catch ex As Exception
                    Response.Write(ex.Message + "Insertion")
                End Try

            Else

                HiddenField_Current_Designation_JoinDate.Value = Convert.ToDateTime(WebDateChooser_CurretDesigJoinDate.Value).ToString("yyyy-MM-dd")

                HiddenField_Employee_ID.Value = (Request.QueryString("Emp_ID"))




                'If TextBox_DOB_Month.Text.Trim() = "" And TextBox_DOB_day.Text.Trim() = "" And TextBox_DOB_Month.Text.Trim() = "" Then
                '    HiddenField_DOB.Value = Convert.ToDateTime(dob).ToString("1900-MM-dd")
                'Else
                Dim dob As String = TextBox_DOB_Year.Text & "/" & TextBox_DOB_Month.Text & "/" & TextBox_DOB_day.Text
                HiddenField_DOB.Value = Convert.ToDateTime(dob).ToString("yyyy-MM-dd")
                'End If



                HiddenFieldStartDate.Value = TextBox_Service_Start_Date_month.Text & "-" & TextBox_service_satart_Date_day.Text & "-" & TextBox_service_Start_Date_Year.Text
                If Not WebDateChooser_NICExpiry.Value Is Nothing Then


                    HiddenField_NICExpiry.Value = Convert.ToDateTime(WebDateChooser_NICExpiry.Value).ToString("yyyy-MM-dd")
                Else
                    HiddenField_NICExpiry.Value = "1900-01-01"
                End If

                HiddenFieldCNIC.Value = TextBox_CNIC.Text

                If HiddenFieldCNIC.Value = "     -       - " Then
                    HiddenFieldCNIC.Value = "1900-01-01"
                End If
                HiddenFieldHomePhone.Value = txthp1.Text & txthp2.Text & txthp3.Text
                    HiddenFieldOfficePhone.Value = txtop1.Text & txtop2.Text & txtop3.Text


                Try
                    SqlDataSourceSaveInfo.Update()
                    ' CheckImageAttached()

                    If HiddenField_ImageAttached.Value = "1" Then
                        Try
                            Dim fs1 As FileStream = New FileStream(Session("File_Path") + Session("fileName"), FileMode.Open)

                            Dim conn As New SqlConnection
                            conn.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
                            Dim SQL As String = "update [Employee] set [picture]= @picture where EmpID=" + HiddenField_Employee_ID.Value
                            Dim myCommand As New SqlCommand(SQL, conn)
                            Dim b(fs1.Length) As Byte
                            fs1.Read(b, 0, fs1.Length)
                            myCommand.Parameters.AddWithValue("@picture", b)
                            conn.Open()
                            myCommand.ExecuteNonQuery()
                            conn.Close()
                        Catch ex As Exception

                        End Try

                    End If


                    hlnkAdditionalInfo.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkAdditionalInfo.Visible = True
                    hlnkEmployeeCertifications.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeCertifications.Visible = True

                    'hlnkEmployeeDocuments.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    'hlnkEmployeeDocuments.Visible = True

                    hlnkEmployeeEducation.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeEducation.Visible = True
                    hlnkEmployeeRelationship.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeRelationship.Visible = False

                    hlnkEmployeeSkills.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeSkills.Visible = True
                    hlnkEmployeeExperience.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeExperience.Visible = True



                    hlnkAdditionalInfo1.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkAdditionalInfo1.Visible = True
                    hlnkEmployeeCertifications1.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeCertifications1.Visible = True

                    'hlnkEmployeeDocuments1.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    'hlnkEmployeeDocuments1.Visible = True

                    hlnkEmployeeEducation1.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeEducation1.Visible = True
                    hlnkEmployeeRelationship1.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeRelationship1.Visible = False

                    hlnkEmployeeSkills1.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeSkills1.Visible = True
                    hlnkEmployeeExperience1.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenField_Employee_ID.Value
                    hlnkEmployeeExperience1.Visible = True


                    HiddenField_ImageAttached.Value = "0"
                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<script language='javascript'>")
                    sb.Append("alert(' Information Saved Successfuly ')</script>")
                    Dim t As Type = Me.GetType
                    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                    End If
                    ImageButton1.ImageUrl = "~/images/PictureFrame.png"
                    '  clearText()
                    HiddenFieldEmp_id.Value = Request.QueryString("Emp_Id")

                Catch ex As Exception
                    'Response.Write(HiddenFieldCNIC.Value)
                    Response.Write(ex.Message + "Insertion")
                End Try

                Label_message.ForeColor = Drawing.Color.Green : Label_message.Text = "Your Information has been saved"




            End If
        End If
    End Sub

    Protected Sub DropDownListdesignation_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListdesignation.DataBound
        ' DropDownListdesignation.Items.Insert(0, New ListItem(""))
    End Sub
    ' this function checked the payscale of the employee according to its designation 

    Protected Sub designation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListdesignation.SelectedIndexChanged
        'Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

        'Dim def As String
        'def = DropDownListdesignation.SelectedItem.Text
        'Dim abc As String
        'abc = 0
        'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr)
        'Dim mycommand As New System.Data.SqlClient.SqlCommand("select isnull(Min_PayScale,'') from Designation where (Designation_Name = @name )", con)
        'mycommand.CommandType = Data.CommandType.Text
        'Dim param As System.Data.SqlClient.SqlParameter
        'param = mycommand.Parameters.Add("@name", Data.SqlDbType.VarChar)
        'param.Value = def
        'Try
        '    mycommand.Connection.Open()
        '    abc = CType(mycommand.ExecuteScalar, String)
        '    mycommand.Connection.Close()

        'Catch ex As Exception
        '    Label1.Text = ex.Message

        'End Try
        'If abc <> 0 Then
        '    Dropdownlistpayscale.SelectedIndex = abc - 1
        'End If

        'Dim qry As String = "SELECT     Designation_Main_Id FROM Designation WHERE     (Designation_ID = @Designation_ID)"
        'Dim con1 As New SqlConnection(constr)
        'Dim cmd As New SqlCommand(qry, con1)
        'cmd.Parameters.AddWithValue("@Designation_ID", DropDownListdesignation.SelectedValue)
        'con1.Open()
        'HiddenField_DesignationMainId.Value = cmd.ExecuteScalar()
        'con1.Close()





    End Sub


    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try

        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try

    End Sub

    Sub ValidateMainPage()
        Try
            Dim validate As New Validate_Pages_for_admin
            Dim i As Integer = validate.Validate_Main_pages(Session("Emp_ID"), "Employee.aspx")
            If i = 0 Then
                Session.RemoveAll()
                Response.Redirect("Loginnew.aspx")
            Else

            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

       
        If Not IsPostBack Then

            ContractSdate.Value = ""
            ContractEdate.Value = ""

            WebDateChooser_CurretDesigJoinDate.Value = DateTime.Now
            'ContractSdate.Value = DateTime.Now
            'ContractEdate.Value = DateTime.Now
            DropdownlistHospital.DataBind()
            'DropdownlistHospital.SelectedValue = 4
            Dropdownlistdepartment.DataBind()
            DropDownList_SalaryType.DataBind()


            Try
                If Request.QueryString("Emp_Id") Is Nothing Then

                    'ValidateMainPage()
                    Label_message.Text = ""
                    Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
                    loginvalidate(Session("emp_id"), Session("dept_id"))
                    If (Page.IsPostBack = False) Then
                        Dim a As Integer = Date.Now.Day
                        txtday.Text = a
                        TextBox_service_satart_Date_day.Text = a
                        TextBox_DOB_day.Text = a
                        Dim b As Integer = Date.Now.Month
                        txtmonth.Text = b
                        TextBox_Service_Start_Date_month.Text = b
                        TextBox_DOB_Month.Text = b
                        Dim c As Integer = Date.Now.Year
                        txtyear.Text = c
                        TextBox_service_Start_Date_Year.Text = c
                        TextBox_DOB_Year.Text = c

                    End If
                   
                    '   Response.Redirect("Search_Employee.aspx?PName=Edit Employee&MName=Employee Info")
                ElseIf Not Request.QueryString("Rejoin") Is Nothing Then
                    lblheading.Text = "Rejoin Employee"

                    HiddenFieldEmp_id.Value = Request.QueryString("Emp_Id")
                    hlnkAdditionalInfo.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo.Visible = True
                    hlnkEmployeeCertifications.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications.Visible = True

                    'hlnkEmployeeDocuments.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments.Visible = True

                    hlnkEmployeeEducation.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation.Visible = True
                    hlnkEmployeeRelationship.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship.Visible = False
                    hlnkEmployeeSkills.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills.Visible = True
                    hlnkEmployeeExperience.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience.Visible = True
                    hlnkAdditionalInfo1.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo1.Visible = True
                    hlnkEmployeeCertifications1.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications1.Visible = True

                    'hlnkEmployeeDocuments1.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments1.Visible = True

                    hlnkEmployeeEducation1.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation1.Visible = True
                    hlnkEmployeeRelationship1.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship1.Visible = False
                    hlnkEmployeeSkills1.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills1.Visible = True
                    hlnkEmployeeExperience1.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience1.Visible = True
                    '  form1.DefaultButton = "ButtonSave"
                    SelectEmployeeData()
                    ' RangeValidatorYear.MaximumValue = Date.Now.Year
                    ButtonSave.Attributes.Add("onClick", "return checkrequiredfield(this)")
                    ButtonSave.Text = "Save"
                Else
                    lblheading.Text = "Update Employee"

                    HiddenFieldEmp_id.Value = Request.QueryString("Emp_Id")
                    hlnkAdditionalInfo.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo.Visible = True
                    hlnkEmployeeCertifications.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications.Visible = True

                    'hlnkEmployeeDocuments.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments.Visible = True

                    hlnkEmployeeEducation.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation.Visible = True
                    hlnkEmployeeRelationship.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship.Visible = False
                    hlnkEmployeeSkills.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills.Visible = True
                    hlnkEmployeeExperience.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience.Visible = True
                    hlnkAdditionalInfo1.NavigateUrl = "~/hr/Additional_Info.aspx?PName=Additional Info&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkAdditionalInfo1.Visible = True
                    hlnkEmployeeCertifications1.NavigateUrl = "~/hr/Certification.aspx?PName=Certifications&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeCertifications1.Visible = True

                    'hlnkEmployeeDocuments1.NavigateUrl = "~/hr/attach_Documents_Server.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    'hlnkEmployeeDocuments1.Visible = True

                    hlnkEmployeeEducation1.NavigateUrl = "~/hr/Education.aspx?PName=Education&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeEducation1.Visible = True
                    hlnkEmployeeRelationship1.NavigateUrl = "~/hr/ADD_relationship.aspx?PName=Relationship&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeRelationship1.Visible = False
                    hlnkEmployeeSkills1.NavigateUrl = "~/hr/skills.aspx?PName=Skills&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeSkills1.Visible = True
                    hlnkEmployeeExperience1.NavigateUrl = "~/hr/Experience.aspx?PName=Documents&MName=Edit Employee&Emp_Id=" + HiddenFieldEmp_id.Value
                    hlnkEmployeeExperience1.Visible = True
                    '  form1.DefaultButton = "ButtonSave"
                    SelectEmployeeData()
                    ' RangeValidatorYear.MaximumValue = Date.Now.Year
                    ButtonSave.Attributes.Add("onClick", "return checkrequiredfield(this)")
                    ButtonSave.Text = "Update"
                End If
            Catch ex As Exception
                Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
            End Try

        End If

        'DropDownListProfession.Items.Insert(0, "")
    End Sub


    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function checkCNIC(cnicNo As String) As String
        Dim result As String = String.Empty
        If cnicNo = String.Empty Then
            result = "ok"
        Else

            'Get your connection string here
            Dim conString As String = System.Configuration.ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            'Change your query here
            Dim qry As String = "select * from Employee Where CNIC =@CNIC"
            Dim da As New SqlDataAdapter(qry, conString)
            'Pass the value to paramter
            da.SelectCommand.Parameters.AddWithValue("@CNIC", cnicNo)
            Dim ds As New DataSet()
            da.Fill(ds, "CNICTable")
            'Check if dataset is having any value
            If ds.Tables("CNICTable").Rows.Count > 0 Then
                ' User Name Not Available
                result = "This CNIC is already registered with Emp # : " + ds.Tables("CNICTable").Rows(0)(1).ToString() + " with Name : " + ds.Tables("CNICTable").Rows(0)(2).ToString() + "."
            Else
                'User_Name is available
                result = "ok"
            End If
        End If
        'Return the result
        Return result
    End Function


    <System.Web.Services.WebMethod(EnableSession:=True)>
    Public Shared Function checkMobileNo(mobileNo As String) As String
        Dim result As String = String.Empty
        'Get your connection string here
        Dim conString As String = System.Configuration.ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        'Change your query here
        Dim qry As String = "select * from Employee Where Mobile_Number =@MobilePhone"
        Dim da As New SqlDataAdapter(qry, conString)
        'Pass the value to paramter
        da.SelectCommand.Parameters.AddWithValue("@MobilePhone", mobileNo.Trim())
        Dim ds As New DataSet()
        da.Fill(ds, "MobileTable")
        'Check if dataset is having any value
        If ds.Tables("MobileTable").Rows.Count > 0 Then
            ' User Name Not Available
            result = "This Phone is already registered with MR# : " + ds.Tables("MobileTable").Rows(0)(2).ToString() + " with Name : " + ds.Tables("MobileTable").Rows(0)(1).ToString() + "."
        Else
            'User_Name is available
            result = "ok"
        End If
        'Return the result
        Return result
    End Function

    '=======================================================
    'Service provided by Telerik (www.telerik.com)
    'Conversion powered by NRefactory.
    'Twitter: @telerik
    'Facebook: facebook.com/telerik
    '=======================================================



    Protected Sub SelectEmployeeData()
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select_Employee_For_Update", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@EmpID", Request.QueryString("Emp_ID"))
            con.Open()
            'con.Close()
            Dim reader As SqlDataReader = command.ExecuteReader()
            While reader.Read()
                If Not IsDBNull(reader("Prefix")) Then
                    prefix.SelectedValue = reader.Item("Prefix").ToString()
                End If
                If Not IsDBNull(reader("Emp_No")) Then
                    TextBox_Emp_Number.Text = reader.Item("Emp_No").ToString()
                End If
                If Not IsDBNull(reader("EFName")) Then
                    txtEFName.Text = reader.Item("EFName").ToString()
                End If
                If Not IsDBNull(reader("EMName")) Then
                    txtEMName.Text = reader.Item("EMName").ToString()
                End If
                If Not IsDBNull(reader("ELName")) Then
                    TxtELName.Text = reader.Item("ELName").ToString()
                End If
                If Not IsDBNull(reader("Picture")) Then
                    ImageButton1.ImageUrl = "data:image;base64," + Convert.ToBase64String(reader.Item("Picture"))
                End If
                If Not IsDBNull(reader("SexID")) Then
                    Dropdownlistsex.DataBind()
                    Dropdownlistsex.SelectedValue = reader.Item("SexID").ToString()
                End If
                If Not IsDBNull(reader("Relation")) Then
                    RadioButtonList1.SelectedValue = reader.Item("Relation").ToString()
                End If
                If Not IsDBNull(reader("RFName")) Then
                    TextBoxRFName.Text = reader.Item("RFName").ToString()
                End If
                If Not IsDBNull(reader("RMName")) Then
                    TextBoxRMName.Text = reader.Item("RMName").ToString()
                End If
                If Not IsDBNull(reader("RLName")) Then
                    TextBoxRLName.Text = reader.Item("RLName").ToString()
                End If
                If Not IsDBNull(reader("Employee_Type_ID")) Then
                    DropDownList_Type.SelectedValue = reader.Item("Employee_Type_ID").ToString()
                End If
                If Not IsDBNull(reader("Birth day")) Then
                    TextBox_DOB_day.Text = reader.Item("Birth day").ToString()
                End If
                If Not IsDBNull(reader("Birth day")) Then
                    TextBox_DOB_day.Text = reader.Item("Birth day").ToString()
                End If
                If Not IsDBNull(reader("Birth Month")) Then
                    TextBox_DOB_Month.Text = reader.Item("Birth Month").ToString()
                End If
                If Not IsDBNull(reader("Birth Year")) Then
                    TextBox_DOB_Year.Text = reader.Item("Birth Year").ToString()
                End If
                If Not IsDBNull(reader("Age")) Then
                    lblAge.Text = reader.Item("Age").ToString()
                End If
                If Not IsDBNull(reader("Nationality")) Then
                    DropDownList_nationality.SelectedValue = reader.Item("Nationality").ToString()
                End If
                If Not IsDBNull(reader("Place_of_birth")) Then
                    DropDownList_place_of_birth.SelectedValue = reader.Item("Place_of_birth").ToString()
                End If
                If Not IsDBNull(reader("OtherNationality")) Then
                    DropDownList_nationality_other.SelectedValue = reader.Item("OtherNationality").ToString()
                End If
                If Not IsDBNull(reader("Marital_Status")) Then
                    RadioButtonList_marital_status.SelectedValue = reader.Item("Marital_Status").ToString()
                End If
                If Not IsDBNull(reader("Religion")) Then
                    DropDownList_religion.SelectedValue = reader.Item("Religion").ToString()
                End If
                If Not IsDBNull(reader("CNIC")) Then
                    TextBox_CNIC.Text = reader.Item("CNIC").ToString()
                End If
                If Not IsDBNull(reader("Domicile")) Then
                    DropDownList_Domicile.SelectedValue = reader.Item("Domicile").ToString()
                End If
                If Not IsDBNull(reader("CNICExpiry")) Then
                    WebDateChooser_NICExpiry.Value = reader.Item("CNICExpiry").ToString()
                End If
                If Not IsDBNull(reader("Passport_No")) Then
                    TextBox_Passport_no.Text = reader.Item("Passport_No").ToString()
                End If
                If Not IsDBNull(reader("BloodGroup")) Then
                    ddlBloodGroup.SelectedValue = reader.Item("BloodGroup").ToString()
                End If
                If Not IsDBNull(reader("Language_Known")) Then
                    TextBox_language.Text = reader.Item("Language_Known").ToString()
                End If
                If Not IsDBNull(reader("HPhoneNo")) Then
                    If reader.Item("HPhoneNo").ToString().Length > 6 Then
                        txthp1.Text = reader.Item("HPhoneNo").ToString().Substring(0, 4)
                    End If

                End If
                If Not IsDBNull(reader("HPhoneNo")) Then
                    If reader.Item("HPhoneNo").ToString().Length > 6 Then
                        txthp2.Text = reader.Item("HPhoneNo").ToString().Substring(4, 2)
                    End If

                End If
                If Not IsDBNull(reader("HPhoneNo")) Then
                    If reader.Item("HPhoneNo").ToString().Length > 6 Then
                        txthp3.Text = reader.Item("HPhoneNo").ToString().Substring(6, 7)
                    End If

                End If
                If Not IsDBNull(reader("dist_ID")) Then
                    DropDownList_dist_ID.SelectedValue = reader.Item("dist_ID").ToString()
                End If
                If Not IsDBNull(reader("Mobile_Number")) Then
                    If reader.Item("Mobile_Number").ToString().Length > 10 Then
                        TextBox_mobile_No.Text = reader.Item("Mobile_Number").ToString()
                    End If

                End If
                If Not IsDBNull(reader("tech_ID")) Then
                    DropDownList_teh_ID.SelectedValue = reader.Item("tech_ID").ToString()
                End If
                If Not IsDBNull(reader("OphoneNo")) Then
                    If reader.Item("OphoneNo").ToString().Length > 6 Then
                        txtop1.Text = reader.Item("OphoneNo").ToString().Substring(0, 4)
                    End If

                End If
                If Not IsDBNull(reader("OphoneNo")) Then
                    If reader.Item("OphoneNo").ToString().Length > 6 Then
                        txtop2.Text = reader.Item("OphoneNo").ToString().Substring(4, 2)
                    End If

                End If
                If Not IsDBNull(reader("OphoneNo")) Then
                    If reader.Item("OphoneNo").ToString().Length > 6 Then
                        txtop3.Text = reader.Item("OphoneNo").ToString().Substring(6, 7)
                    End If

                End If
                If Not IsDBNull(reader("HomeAdd")) Then
                    homeadd.Text = reader.Item("HomeAdd").ToString()
                End If
                If Not IsDBNull(reader("email_address")) Then
                    TextBox_email.Text = reader.Item("email_address").ToString()
                End If
                If Not IsDBNull(reader("Present_address")) Then
                    TextBox_present_address.Text = reader.Item("Present_address").ToString()
                End If
                If Not IsDBNull(reader("EmgMobileNo")) Then
                    txtEmgMobile.Text = reader.Item("EmgMobileNo").ToString()
                End If
                If Not IsDBNull(reader("OfficeAdd")) Then
                    officeadd.Text = reader.Item("OfficeAdd").ToString()
                End If
                If Not IsDBNull(reader("EmgContactPerson")) Then
                    txtEmgName.Text = reader.Item("EmgContactPerson").ToString()
                End If
                If Not IsDBNull(reader("DesignationID")) Then
                    DropDownListdesignation.SelectedValue = reader.Item("DesignationID").ToString()
                End If
                If Not IsDBNull(reader("PayScale")) Then
                    Dropdownlistpayscale.SelectedValue = reader.Item("PayScale").ToString()
                End If
                If Not IsDBNull(reader("JoinDate")) Then
                    WebDateChooser_CurretDesigJoinDate.Value = reader.Item("JoinDate").ToString()
                End If
                If Not IsDBNull(reader("DeptID")) Then
                    Dropdownlistdepartment.SelectedValue = reader.Item("DeptID").ToString()
                End If
                If Not IsDBNull(reader("NTN")) Then
                    txtNTNNo.Text = reader.Item("NTN").ToString()
                End If
                If Not IsDBNull(reader("SubDeptId")) Then
                    DropDownListSubDepartment.SelectedValue = reader.Item("SubDeptId").ToString()
                End If
                If Not IsDBNull(reader("Shift_Id")) Then
                    DropDownList1.SelectedValue = reader.Item("Shift_Id").ToString()
                End If
                If Not IsDBNull(reader("GP_Fund_No")) Then
                    txtGPFund.Text = reader.Item("GP_Fund_No").ToString()
                End If
                If Not IsDBNull(reader("SalaryType")) Then
                    DropDownList_SalaryType.SelectedValue = reader.Item("SalaryType").ToString()
                End If
                If Not IsDBNull(reader("Prov_Fund_No")) Then
                    txtProvFundNo.Text = reader.Item("Prov_Fund_No").ToString()
                End If
                If Not IsDBNull(reader("Is_Consultant")) Then
                    If reader.Item("Is_Consultant").ToString() = True Then
                        checkBoxIsConsultant.Checked = True
                    End If
                End If
                If Not IsDBNull(reader("EOBI_No")) Then
                    txtEOBINo.Text = reader.Item("EOBI_No").ToString()
                End If

                If Not IsDBNull(reader("RotationType")) Then
                    RotationType.SelectedValue = reader.Item("RotationType").ToString()
                Else
                    RotationType.Items.Insert(0, "N/A")
                End If




            End While
            con.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub SqlDataSourceSaveInfo_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourceSaveInfo.Inserted
        HiddenFieldEmp_id.Value = e.Command.Parameters("@EmpID").Value


        'Dim sCID As String = e.Command.Parameters("@status").Value.ToString()
        'If (sCID = 0) Then
        '    Label_message.Visible = True
        '    Label_message.ForeColor = Drawing.Color.Red : Label_message.Text = "CNIC Already Exist... "
        'ElseIf (sCID = 1) Then
        '    Label_message.Visible = True
        '    Label_message.ForeColor = Drawing.Color.Green
        '    Label_message.Text = "Saved Successfully... "

        'End If



    End Sub

    Protected Sub CheckImageAttached()
        If FileUpload_image.HasFile = True Then
            Dim F_Path As String = Server.MapPath("") + "\images\"

            fileName = FileUpload_image.FileName
            Dim emp_name As String = txtEFName.Text + " " + txtEMName.Text + " " + TxtELName.Text
            If System.IO.File.Exists(fileName) Then
                System.IO.File.Delete(fileName)
            End If
            'Basic_Checks.OratierImageFrame(FileUpload_image, F_Path, fileName, emp_name)

            Session("File_Path") = File_Path
            Session("fileName") = fileName
            'fs.Close()
            HiddenField_ImageAttached.Value = "1"
        End If
        ImageButton1.ImageUrl = "~/HR/images/" + fileName

    End Sub

    Protected Sub Button_attach_pic_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_attach_pic.Click
        If FileUpload_image.HasFile = True Then
            Dim F_Path As String = Server.MapPath("") + "\images\"

            fileName = FileUpload_image.FileName
            Dim emp_name As String = txtEFName.Text + " " + txtEMName.Text + " " + TxtELName.Text
            If System.IO.File.Exists(fileName) Then
                System.IO.File.Delete(fileName)
            End If
            '  Basic_Checks.OratierImageFrame(FileUpload_image, F_Path, fileName, emp_name)


            Dim fs As FileStream = New FileStream(File_Path + fileName, FileMode.Create)
            fs.Write(FileUpload_image.FileBytes, 0, FileUpload_image.FileBytes.Length)
            Session("File_Path") = File_Path
            Session("fileName") = fileName
            fs.Close()
            HiddenField_ImageAttached.Value = "1"
        End If
        ImageButton1.ImageUrl = "~/HR/images/" + fileName



    End Sub

    Protected Sub DropDownList_place_of_birth_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_place_of_birth.SelectedIndexChanged
        'DropDownList_Domicile.SelectedValue = DropDownList_place_of_birth.SelectedValue
        DropDownList_dist_ID.SelectedValue = DropDownList_place_of_birth.SelectedValue
    End Sub



    Protected Sub DropDownListSubDepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs)
        '  DropDownListSubDepartment.Items.Insert(0, New ListItem(""))
    End Sub



    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        TextBox_present_address.Text = homeadd.Text
    End Sub


    Protected Sub btnRefresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnRefresh.Click
        clearText()
    End Sub
    Protected Sub clearText()
        TextBox_Emp_Number.Text = ""
        TextBox_CNIC.Text = ""
        TextBox_email.Text = ""
        TextBox_language.Text = ""
        TextBox_mobile_No.Text = ""
        TextBox_Passport_no.Text = ""
        TextBox_present_address.Text = ""
        TextBoxRFName.Text = ""
        TextBoxRLName.Text = ""
        TextBoxRMName.Text = ""
        txtday.Text = ""
        txtEFName.Text = ""
        TxtELName.Text = ""
        txtEMName.Text = ""
        txthp1.Text = ""
        txthp2.Text = ""
        txthp3.Text = ""
        txtmonth.Text = ""
        txtop1.Text = ""
        txtop2.Text = ""
        txtop3.Text = ""
        txtyear.Text = ""
        ddlProfession.SelectedIndex = -1
        txtNTNNo.Text = String.Empty
        txtEOBINo.Text = ""
        DropDownList_dist_ID.SelectedIndex = -1
        DropDownList_teh_ID.SelectedIndex = -1
        txtEmgMobile.Text = ""
        txtEmgName.Text = ""
        ddlBloodGroup.SelectedIndex = -1
        TextBox_DOB_day.Text = ""
        TextBox_DOB_Month.Text = ""
        TextBox_DOB_Year.Text = ""
        TextBox_Designation_Detail.Text = ""
        DropDownListdesignation.SelectedIndex = -1
        prefix.ClearSelection()
        homeadd.Text = ""
        officeadd.Text = ""
        WebDateChooser_NICExpiry.Value = DateTime.Now
        lblAge.Text = "0"


    End Sub

    Protected Sub TextBox_Emp_Number_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Emp_Number.TextChanged
        If IS_Registered(TextBox_Emp_Number.Text.Trim) Then
            Label5.Text = "Already Registered.."
            Dim sb As New System.Text.StringBuilder()

            sb.Append("<script language='javascript' type='text/javascript'>alert('Already Registered..');</script>")
            Dim t As Type = Me.GetType()
            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            End If
            TextBox_Emp_Number.Focus()
        Else
            Label5.Text = String.Empty
            txtEFName.Focus()

        End If

    End Sub
    Protected Function IS_Registered(ByVal emp_id As String) As Boolean
        Dim flag As Boolean = False
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

        Dim Statement As String = "Select Count(EmpID) from Employee  where EmpID = " + emp_id
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Statement, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.Connection.Open()
        flag = CBool(mycommand.ExecuteScalar)
        mycommand.Connection.Close()
        Return flag
    End Function

    Protected Sub prefix_SelectedIndexChanged(sender As Object, e As EventArgs)
        If prefix.SelectedValue = "Mr" Then
            Dropdownlistsex.SelectedValue = 1
        ElseIf prefix.SelectedValue = "Miss" Or prefix.SelectedValue = "Mrs" Then

            Dropdownlistsex.SelectedValue = 2
        End If

    End Sub

    Protected Sub SqlDataSourceSaveInfo_Updated(sender As Object, e As SqlDataSourceStatusEventArgs) Handles SqlDataSourceSaveInfo.Updated

    End Sub
    Protected Sub DropDownList_Type_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim value As String = DropDownList_Type.SelectedValue
        If (value = "2") Then
            ContractSdate.Value = DateTime.Now
            ContractEdate.Value = DateTime.Now


            trContractStartDate.Style.Add(HtmlTextWriterStyle.Display, "contents")
            trContractEndDate.Style.Add(HtmlTextWriterStyle.Display, "contents")
        Else
            trContractStartDate.Style.Add(HtmlTextWriterStyle.Display, "none")
            trContractEndDate.Style.Add(HtmlTextWriterStyle.Display, "none")
            ContractSdate.Value = ""
            ContractEdate.Value = ""


        End If

        ' Dim value As String = DropDownList_Type.SelectedValue
        'If (value = "2") Then
        '    panel1.Visible = True
        'Else
        '    panel1.Visible = False

        'End If


    End Sub
    Protected Sub checkBoxIsConsultant_CheckedChanged(sender As Object, e As EventArgs)
        'If (checkBoxIsConsultant.Checked) Then
        '    panel1.Visible = True


        'End If

    End Sub
End Class


