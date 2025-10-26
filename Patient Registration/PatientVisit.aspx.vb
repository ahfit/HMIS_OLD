Imports System.Data
Imports System.Data.SqlClient
Imports System.Data.Sql


Partial Class Patient_Registration_PatientVisit
    Inherits System.Web.UI.Page
    Dim newRegNo As String
    Dim paymentID As Long
    Dim ENC As New Encryption
    Dim daPatientRegistration As New Patient_RegistrationTableAdapters.RegistrationsQueriesTableAdapter
    Dim regConstr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim basicConstr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

    Dim floor As String = ""
    Dim userAuthen As New User_page_Authentication
    
    Dim Indoor_No As Integer = 0
    Dim RegNo As String

    Sub Javascript(ByVal msg As String)
        Label_script.Text = "<script language ='Javascript'>alert('" & msg & "');</script>"
    End Sub



    Protected Sub Save()
        Try
            Dim ddlDesignationValue As String = ""
            Dim DropDownList_PartiesValue As String = ""
            'Dim Consultant_Service_ID As Integer = "1328"
            If ddlDesignation.SelectedValue = "" Then
                ddlDesignationValue = "0"
            Else
                ddlDesignationValue = ddlDesignation.SelectedValue
            End If
            Dim IS_Private As Boolean = False

            If DropDownList_Parties.SelectedValue = "" Then
                DropDownList_PartiesValue = "0"
            Else
                DropDownList_PartiesValue = DropDownList_Parties.SelectedValue
            End If

            Dim party_id As Integer = 0
            If (txtMrNo.Text <> "") Then
                newRegNo = ENC.Encrypt_Main(txtMrNo.Text, True)

                Try
                    Dim deptid As Integer = 0
                    GetDepartment(deptid)

                    'ddlEmployeeName
                    If Request.QueryString("Recomended_Id") Is Nothing Then
                        HiddenField_OPD_IPD.Value = "OPD"

                        If pnlPanelPatient.Visible = True Then

                            insert_record("OPD", 0, Convert.ToInt32(ddlDesignationValue))
                        Else                            
                            insert_record("OPD", 0, 0)
                        End If



                    Else
                        HiddenField_OPD_IPD.Value = "IPD"
                        If pnlPanelPatient.Visible = True Then
                            insert_record("IPD", DDL_Ward.SelectedValue, Convert.ToInt32(ddlDesignationValue))
                        Else                            
                            insert_record("IPD", DDL_Ward.SelectedValue, Convert.ToInt32(ddlDesignationValue))
                        End If



                    End If

                Catch ex As Exception
                    Response.Write(ex.Message & "  Save ")
                End Try
                
                Session("RegistrationNo") = ENC.Encrypt_Main(txtMrNo.Text, True)
                dsPatientVisit.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString
                SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = ENC.Encrypt_Main(txtMrNo.Text, True)
                HF_Flag.Value = 1

                
                Session.Add("PayId", paymentID)
                Session.Add("YearlyNo", paymentID)
                
                GridView_Patient_Visit.DataBind()
                
                fmvPatientInfo.DataBind()

                txtReferedFrom.Text = ""
                DropDownList_Parties.SelectedIndex = 0
                
                'txtMrNo.Text = ""
            Else                
            End If
            SDC_Shift_To_Other.Insert()
        Catch ex As Exception
            Response.Write(ex.Message & " Save   22 2 ")
        End Try


    End Sub

    Protected Sub VisitFor_PatientAppointment(ByVal Appointment_ID As Integer)

        Dim con As New SqlConnection(regConstr)
        Dim command As New SqlCommand("GET_Patient_AppointmentForNewVisit", con)
        command.Parameters.AddWithValue("@Appoinment_ID", Appointment_ID)
        command.CommandType = CommandType.StoredProcedure
        con.Open()
        Dim da As New SqlDataAdapter()
        Dim ds As New DataSet()
        da.SelectCommand = command
        da.Fill(ds)
        con.Close()
        If ds.Tables.Count > 0 Then
            If ds.Tables(0).Rows.Count > 0 Then
                Dim dr As DataRow = ds.Tables(0).Rows(0)
                txtMrNo.Text = dr("Reg_No").ToString()
                DDLDepartment.DataBind()
                DDLDepartment.SelectedValue = dr("Dept_ID").ToString()
                ddlSubDept.DataBind()
                ddlSubDept.SelectedValue = dr("Sub_Dept_ID").ToString()
                'ddlEmployeeName.DataBind()
                ' ddlEmployeeName.SelectedValue = dr("For_Doctor").ToString()
                Dim Service_ID As String = dr("S_ID").ToString()
            End If
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        ddlSubDept.Focus()
        pnlPanelPatient.Visible = False
        
        If Not Page.IsPostBack Then
            Session.Remove("ConsultantId")

            If Request.QueryString("SubDeptID") <> Nothing Then
                ddlSubDept.SelectedValue = Request.QueryString("SubDeptID").ToString()
            End If


            If RadioButtonList_Patient_Type.SelectedValue = "0" Then
                RadioButtonList_Patient_Type.SelectedIndex = 1
            End If
            ddlRate.DataBind()
        End If
        'Dim ds As New AdminReports
        'Dim da As New AdminReportsTableAdapters.Select_Hospital_OPDTableAdapter
        
        DDLDepartment.DataBind()

        Try
            ' To check whether the patient is indoor or outdoor
            If Request.QueryString("Recomended_Id") Is Nothing Then
                panel_admit.Visible = False               
                DDL_Ward.Enabled = False
                DDL_Ward.Visible = False
                Label_Ward.Visible = False
                pnl_ward.Visible = False
                lbl_Referal_Department.Visible = False
                lbl_Referal_subDept.Visible = False
                DDLDepartment.Visible = True                
                Label_Subdept.Visible = True
                Label_Dept.Visible = True

                Button_SaveAndPrint.Visible = True
                Button_SaveAll.Visible = False


                If Session("PatientAppointment_ID") IsNot Nothing Then
                    Dim Appointment_ID As Integer = CInt(Session("PatientAppointment_ID"))
                    VisitFor_PatientAppointment(Appointment_ID)
                End If
            Else

                Button_SaveAndPrint.Visible = False
                Button_SaveAll.Visible = True


                DDL_Ward.Visible = True
                Label_Ward.Visible = True
                pnl_ward.Visible = True
                lbl_Referal_Department.Visible = True
                lbl_Referal_subDept.Visible = True
                DDLDepartment.Visible = True

                Label_Subdept.Visible = False
                Label_Dept.Visible = False
                HiddenField_Dept.Value = 0
                If Not Page.IsPostBack Then


                    'If GridView_Patient_Visit.Rows.Count <> 0 Then
                    '    Button_SaveAll.Visible = True
                    'End If
                    '========================To bind controls regarding Admission ===========================================
                    Dim rid As Integer = Convert.ToInt32(Request.QueryString("Recomended_Id"))
                    Dim con1 As New SqlConnection(regConstr)
                    con1.Open()

                    Dim command1 As New SqlCommand("SELECT Pt_Operation_Recommended.YearlyNo,Pt_Operation_Recommended.Consultant, Pt_Operation_Recommended.OP_Recommended_Id, admin_Hospital_Wards.Ward_Name, ISNULL(admin_Hospital_Wards.Dept_Id, 0) AS Dept_Id, ISNULL(admin_Hospital_Wards.SubDept_Id, 0) AS SubDept_Id, ISNULL(admin_Hospital_Wards.Ward_id, 0) AS Ward_id, Employee.Prefix + ' ' + ISNULL(Employee.EFName, '') + ' ' + ISNULL(Employee.EMName, '') + ' ' + ISNULL(Employee.ELName, '') AS Refered_By, Department.Dept_Name Referal_Dept, SubDepartment.SubDept_Name Referal_SubDept FROM Pt_Operation_Recommended INNER JOIN Employee ON Pt_Operation_Recommended.Order_By_Doctor = Employee.EmpID INNER JOIN Department ON Employee.DeptID = Department.Dept_ID INNER JOIN SubDepartment ON Employee.SubDeptId = SubDepartment.SubDept_Id AND Employee.DeptID = SubDepartment.Dept_Id LEFT OUTER JOIN admin_Hospital_Wards ON Pt_Operation_Recommended.Recommended_Ward_Id = admin_Hospital_Wards.Ward_id WHERE (Pt_Operation_Recommended.OP_Recommended_Id = " & rid & ")", con1)

                    Dim reader1 As SqlDataReader = command1.ExecuteReader()
                    If reader1.Read() Then
                        DDLDepartment.DataBind()
                        Try
                            DDLDepartment.SelectedValue = Convert.ToString(reader1("Dept_Id"))
                        Catch ex As Exception

                        End Try

                        ddlSubDept.DataBind()
                        Try
                            ddlSubDept.SelectedValue = Convert.ToString(reader1("SubDept_Id"))
                        Catch ex As Exception
                            If String.IsNullOrEmpty(Session("OPDSubdeptId")) Then
                                ddlSubDept.SelectedValue = Session("OPDSubdeptId").ToString()
                            End If
                        End Try
                        DDL_Ward.DataBind()
                        Try
                            DDL_Ward.SelectedValue = Convert.ToString(reader1("Ward_id"))
                        Catch ex As Exception

                        End Try
                        Try
                            HiddenField_YearlyNo.Value = Convert.ToInt32(reader1("YearlyNo"))
                        Catch ex As Exception

                        End Try
                        txtReferedFrom.Text = Convert.ToString(reader1("Refered_By"))
                        lbl_Referal_Department.Text = Convert.ToString(reader1("Referal_Dept"))
                        lbl_Referal_subDept.Text = Convert.ToString(reader1("Referal_SubDept"))
                        Try
                        Catch ex As Exception

                        End Try

                    End If
                    reader1.Close()
                    con1.Close()
                End If
            End If            
            fmvPatientInfo.DataBind()            
            If Not IsPostBack Then
                              
                RadioButtonList_Type.DataBind()
                DropDownList_Parties.DataBind()
                DropDownList_Parties.Items.Insert(0, "")
                If Session("RegistrationNo") Is Nothing Then
                    txtMrNo.Text = ""
                Else
                    HF_Flag.Value = 1
                    txtMrNo.Text = ENC.Encrypt_Main(Session("RegistrationNo").ToString, False)
                    SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = (Session("RegistrationNo").ToString)
                    GridView_Patient_Visit.DataBind()

                End If

            End If
            Get_PateintType_PartyInfo()
        Catch ex As Exception
            Response.Write(ex.Message & "page Loaf()")
        End Try

    End Sub


    Protected Sub fmvPatientInfo_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles fmvPatientInfo.PreRender
        Try
            Dim lbl_Prefix As Label = fmvPatientInfo.Row.FindControl("PatientNameLabel")
            Dim lbl_RegNo As Label = fmvPatientInfo.Row.FindControl("RegistrationNo")
            Dim hid_pfname As HiddenField = fmvPatientInfo.Row.FindControl("HiddenField_pfname")
            Dim hid_pmname As HiddenField = fmvPatientInfo.Row.FindControl("HiddenField_pmname")
            Dim hid_plname As HiddenField = fmvPatientInfo.Row.FindControl("HiddenField_plname")
            Dim HF_Pt_Type As HiddenField = fmvPatientInfo.Row.FindControl("HF_Pt_Type")
            Dim Image_Pic As Image = fmvPatientInfo.Row.FindControl("Image_Pic")
            lbl_RegNo.Text = ENC.Encrypt_Main(lbl_RegNo.Text, False)
            lbl_Prefix.Text = lbl_Prefix.Text & " " & ENC.Encrypt_Main(hid_pfname.Value, False) & " " & ENC.Encrypt_Main(hid_pmname.Value, False) & " " & ENC.Encrypt_Main(hid_plname.Value, False)
            Session.Add("Pt_Type", HF_Pt_Type.Value)            
            
        Catch ex As Exception

        End Try



    End Sub

    Protected Sub btnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSearch.Click
        Try
            If txtMrNo.Text = "" Then
                txtMrNo.Text = ENC.Encrypt_Main(ThumbFunctionality.getRegNo(Convert.ToInt32(Session("Emp_Id"))), False)

                If txtMrNo.Text <> "" Then
                    Session.Add("registrationNo", ENC.Encrypt_Main(txtMrNo.Text, True))
                    Response.Redirect("patientvisit.aspx")
                End If
            End If
            HF_Flag.Value = 1
            If (txtMrNo.Text <> "") Then
                Session("RegistrationNo") = ENC.Encrypt_Main(txtMrNo.Text, True)
                SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = ENC.Encrypt_Main(txtMrNo.Text, True)                
                GridView_Patient_Visit.DataBind()                
                fmvPatientInfo.DataBind()
            Else
                SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString
                GridView_Patient_Visit.DataBind()                
                fmvPatientInfo.DataBind()

            End If

            LoadPatientSavedValueForParty()
        Catch ex As Exception
            'Response.Write(txtMrNo.Text)
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub RadioButtonList_Patient_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Patient_Type.SelectedIndexChanged

        Dim sql_arg As New DataSourceSelectArguments
        Dim dv As DataView = SQL_Patient_Type_Sub.Select(sql_arg)
        If dv.Table.Rows.Count > 0 Then
            Dim drr() As DataRow = dv.Table.Select("Patient_Type_ID=" & RadioButtonList_Patient_Type.SelectedValue)
            If drr.Length > 0 Then
                If CBool(drr(0)("Panel_Company")) = True Then
                    DropDownList_Parties.DataBind()
                    DropDownList_Parties.Items.Insert(0, New ListItem("Select Party", "0"))
                    DropDownList_Parties.SelectedIndex = 0
                    ddlDesignation.DataBind()

                    td_Insurer.Visible = True
                    td_Employee_Designation.Visible = True
                Else
                    td_Insurer.Visible = False
                    td_Employee_Designation.Visible = False
                End If
            End If
            RadioButtonList_Patient_Type.Focus()
        End If

       
    End Sub

    Protected Sub Button_SaveAndPrint_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_SaveAndPrint.Click        
        If ddlEmployeeName.SelectedValue <> Session("ConsultantId") Then
            'If Not GetPatientActiveVisit() Then
            Save()
            If Session("SPM_ID") > 0 Then
                Dim url As String = "../Patient%20Registration/OPD_Slip_Report_Private.aspx?SPMID=" + Session("SPM_ID").ToString() + "&PS=1"
                Dim sb As StringBuilder = New StringBuilder
                sb.Append("<script language='javascript'>")
                sb.Append(" window.open('")
                sb.Append(url)
                sb.Append("', '_Blank')</script>")
                Dim t As Type = Me.GetType
                If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                End If
                'Else
                '    Label3.Text = "This Patient Already Registered"
                'End If
            End If
            'Response.Redirect("~/Patient%20Registration/PatientSearch.aspx")

        End If
    End Sub


    Protected Sub GridView_Patient_Visit_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Patient_Visit.PreRender
        If GridView_Patient_Visit.Rows.Count <> 0 Then
            If HF_Flag.Value = 1 Then
                For i As Integer = 0 To GridView_Patient_Visit.Rows.Count - 1
                    Dim RegNoLabel As Label = GridView_Patient_Visit.Rows(i).FindControl("RegNoLabel")
                    Dim PrefixLabel As Label = GridView_Patient_Visit.Rows(i).FindControl("PrefixLabel")
                    Dim PFNameLabel As Label = GridView_Patient_Visit.Rows(i).FindControl("PFNameLabel")
                    Dim PMNameLabel As Label = GridView_Patient_Visit.Rows(i).FindControl("PMNameLabel")
                    Dim PLNameLabel As Label = GridView_Patient_Visit.Rows(i).FindControl("PLNameLabel")
                    Dim Label_Ref_Letter As Label = GridView_Patient_Visit.Rows(i).FindControl("Label_Ref_Letter")
                    Dim Label_Reference_Letter As Label = GridView_Patient_Visit.Rows(i).FindControl("Label_Reference_Letter")
                    Dim Label_Patient_Type As Label = GridView_Patient_Visit.Rows(i).FindControl("Label_Patient_Type")
                    RegNoLabel.Text = ENC.Encrypt_Main(RegNoLabel.Text, False)
                    PFNameLabel.Text = ENC.Encrypt_Main(PFNameLabel.Text, False)
                    PMNameLabel.Text = ENC.Encrypt_Main(PMNameLabel.Text, False)
                    PLNameLabel.Text = ENC.Encrypt_Main(PLNameLabel.Text, False)
                    PrefixLabel.Text = PrefixLabel.Text + " " + PFNameLabel.Text + " " + PMNameLabel.Text + " " + PLNameLabel.Text
                    If Label_Patient_Type.Text = "Private" Then
                        Label_Ref_Letter.Visible = False
                        Label_Reference_Letter.Visible = False
                    Else
                        Label_Ref_Letter.Visible = True
                        Label_Reference_Letter.Visible = True
                    End If
                    'Label_Ref_Letter     Label_Reference_Letter
                Next
                HF_Flag.Value = 0
            End If
        End If
    End Sub

    Protected Sub GridView_Patient_Visit_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Patient_Visit.SelectedIndexChanged
        Session.Add("PayId", GridView_Patient_Visit.SelectedValue)        
        Dim Label_Patient_Type As Label = GridView_Patient_Visit.Rows(GridView_Patient_Visit.SelectedRow.RowIndex).FindControl("Label_Patient_Type")
        
        If Label_Patient_Type.Text = "OPD" Then
            Response.Redirect("~/Patient Billing/OPD_Slip_Report_Private.aspx")
        ElseIf Label_Patient_Type.Text = "IPD" Then
            Response.Redirect("IPD_Regisration_Report.aspx")
        End If
    End Sub

    Function Check_Bed_Assigned() As Integer
        Dim count As Integer = 0
        Dim con As SqlConnection = New SqlConnection(basicConstr)
        Dim Command As SqlCommand = New SqlCommand("select Count(*) from Pt_Assign_Bed where FloorID in(SELECT  distinct SubDepartment.SubDept_Id FROM SubDepartment INNER JOIN admin_Hospital_Wards ON SubDepartment.SubDept_Id = admin_Hospital_Wards.SubDept_Id where admin_Hospital_Wards.Category='Bed' and SubDepartment.SubDept_Id not in (85,87)) and Reg_No=@Reg_No and Yearly_No=@Yearly_No and PT_Status=0", con)
        Command.CommandType = CommandType.Text
        Command.Parameters.AddWithValue("@Reg_No", Session("registrationNo"))
        Command.Parameters.AddWithValue("@Yearly_No", CInt(Session("YearlyNo")))
        con.Open()
        Dim reader As SqlDataReader = Command.ExecuteReader
        While reader.Read
            count = reader.Item(0)
        End While
        Return count
    End Function

    Sub get_subdept_id()
        Try
            Dim basicConstr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(basicConstr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand("SELECT TOP (1) to_sub_Dept FROM  Forward_To_Sub_Dept WHERE (Reg_No = @reg_no) AND (yearly_no = @Yearly_no) order by forward_date desc", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@Yearly_no", Session("YearlyNo"))
            Dim reader As SqlDataReader = command.ExecuteReader
            If reader.Read Then
                HiddenFieldSubDepartment.Value = reader.Item(0).ToString
            End If
            con.Close()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub DropDownList_Payment_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Payment_Type.SelectedIndexChanged
        If DropDownList_Payment_Type.SelectedValue = "Cheque" Then
            Panel_Card.Visible = False
            Panel_cheque.Visible = True
            Panel_Bank.Visible = True
        ElseIf DropDownList_Payment_Type.SelectedValue = "Credit Card" Then
            Panel_Card.Visible = True
            Panel_Bank.Visible = True
            Panel_cheque.Visible = False

        Else
            Panel_Card.Visible = False
            Panel_cheque.Visible = False
            Panel_Bank.Visible = False

        End If
    End Sub

    Protected Sub SqlDataSource_Adv_Payment_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Adv_Payment.Inserted
        Try
            HiddenFieldMainId.Value = e.Command.Parameters("@paymentNo").Value

        Catch ex As Exception

        End Try
    End Sub

    Protected Sub insert_record(ByVal ipd_opd As String, ByVal ward_id As Integer, ByVal Billing_Group_Id As Integer)

        Dim recomended_id As Integer

        If Request.QueryString("Recomended_Id") Is Nothing Then
            recomended_id = 0
        Else
            recomended_id = Request.QueryString("Recomended_Id")
        End If
        Dim cmd As SqlCommand
        Try
            Dim conn As SqlConnection
            conn = New SqlConnection(regConstr)
            cmd = New SqlCommand()
            conn.Open()
            cmd.Connection = conn
            cmd.CommandText = "PatientVisitRegistration"
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@NewRegNo", newRegNo)
            'cmd.Parameters.AddWithValue("@RegNo", ENC.Encrypt_Main(txtMrNo.Text, True))
            cmd.Parameters.AddWithValue("@RegNo", Session("registrationNo").ToString())
            cmd.Parameters.AddWithValue("@DateTime", Date.Now)
            cmd.Parameters.AddWithValue("@DeptID", DDLDepartment.SelectedValue)
            cmd.Parameters.AddWithValue("@Status", "")
            cmd.Parameters.AddWithValue("@EmpID", Convert.ToInt32(Session("Emp_ID")))
            cmd.Parameters.AddWithValue("@Diagonosis", ddlDiagnosis.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@PatientType", RadioButtonList_Patient_Type.SelectedItem.Text)
            cmd.Parameters.AddWithValue("ReferFrom", txtReferedFrom.Text)
            cmd.Parameters.AddWithValue("to_sub_Dept", ddlSubDept.SelectedValue)
            cmd.Parameters.AddWithValue("Patient_Type", RadioButtonList_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@Patient_Type_ID ", RadioButtonList_Patient_Type.SelectedValue)
            cmd.Parameters.Add("@paymentid", Data.SqlDbType.Int, 100)
            cmd.Parameters("@paymentid").Direction = Data.ParameterDirection.Output

            cmd.Parameters.AddWithValue("Payment_Status", "")
            cmd.Parameters.AddWithValue("Party_ID", DropDownList_Parties.SelectedValue)
            cmd.Parameters.AddWithValue("@Reference_Letter", TextBox_Ins_Detail.Text)
            cmd.Parameters.AddWithValue("@DoctorID", ddlEmployeeName.SelectedValue)
            cmd.Parameters.AddWithValue("@IPD_OPD", ipd_opd)
            cmd.Parameters.AddWithValue("@Ward_Id", ward_id)
            cmd.Parameters.AddWithValue("@Recomended_Id", recomended_id)
            cmd.Parameters.AddWithValue("@Billing_Group_Id", Billing_Group_Id)
            cmd.Parameters.AddWithValue("@RoomNo", txtRoomNo.Text)


            cmd.Parameters.AddWithValue("@S_ID", ddlRate.SelectedValue)
            Try
                cmd.Parameters.AddWithValue("@Amount", ddlRate.SelectedItem.Text)
            Catch ex As Exception
                cmd.Parameters.AddWithValue("@Amount", "0")
            End Try
            ' cmd.Parameters.AddWithValue("@Amount", ddlRate.SelectedItem.Text)
            cmd.Parameters.AddWithValue("@Hospital_Id", Session("HospitalId"))
            cmd.Parameters.Add("@SPM_ID", Data.SqlDbType.Int, 100)
            cmd.Parameters("@SPM_ID").Direction = Data.ParameterDirection.Output
            cmd.Parameters.AddWithValue("@Emp_DeptId", Session("dept_id"))
            cmd.Parameters.AddWithValue("@Emp_SubDeptId", Session("subdeptid"))

            cmd.Parameters.AddWithValue("@AdvanceAmount", TextBox_Payment.Text)
            cmd.Parameters.AddWithValue("@Check_No", TextBox_Cheque_no.Text)
            cmd.Parameters.AddWithValue("@Bank_Name", TextBox_Bank_Name.Text)
            cmd.Parameters.AddWithValue("@Branch_Name", TextBox_Branch_Name.Text)

            cmd.Parameters.Add("@PaymentNo", Data.SqlDbType.Int, 100)
            cmd.Parameters("@PaymentNo").Direction = Data.ParameterDirection.Output

            cmd.Parameters.AddWithValue("@Payment_Type", DropDownList_Payment_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@ASP_ID", DropDownList_Admin_Service_Package.SelectedValue)
            cmd.Parameters.AddWithValue("@Cheque_Date", TextBox_ChequeDate.Text)
            cmd.Parameters.AddWithValue("@Card_No", TextBox_Cradit_Card_No.Text)
            cmd.Parameters.AddWithValue("@Card_Type", DropDownList_Card_Type.SelectedValue)
            cmd.Parameters.AddWithValue("@Card_Service", TextBox_Card_Service.Text)
            cmd.Parameters.AddWithValue("@Approval_No", TextBox_approval_no.Text)
            cmd.Parameters.AddWithValue("@Discription", TextBox_description.Text)


            cmd.ExecuteNonQuery()

            paymentID = cmd.Parameters("@paymentid").Value.ToString()
            Session.Add("SPM_ID", cmd.Parameters("@SPM_ID").Value)
            Session.Add("ConsultantId", ddlEmployeeName.SelectedValue)
            conn.Close()


        Catch ex As Exception
            Console.WriteLine(ex)
        End Try


    End Sub

    Protected Sub LoadPatientSavedValueForParty()
        Try
            pnlPanelPatient.Visible = True
            Dim con As New SqlConnection(regConstr)
            Dim command As New SqlCommand("GET_Patient_Type_PartyInfo", con)
            command.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            command.CommandType = CommandType.StoredProcedure
            con.Open()
            Dim da As New SqlDataAdapter()
            Dim ds As New DataSet()
            da.SelectCommand = command
            da.Fill(ds)
            con.Close()
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Dim dr As DataRow = ds.Tables(0).Rows(0)
                    rblPatientTypeCategory.DataBind()
                    rblPatientTypeCategory.SelectedValue = dr("Patient_type_Cat").ToString()
                    RadioButtonList_Patient_Type.DataBind()
                    RadioButtonList_Patient_Type.SelectedValue = dr("ID").ToString()
                    Dim sql_arg As New DataSourceSelectArguments
                    pnlPanelPatient.Visible = True

                    Dim dv As DataView = SQL_Patient_Type_Sub.Select(sql_arg)
                    If dv.Table.Rows.Count > 0 Then
                        Dim drr() As DataRow = dv.Table.Select("Patient_Type_ID=" & RadioButtonList_Patient_Type.SelectedValue)
                        If drr.Length > 0 Then

                            If CBool(drr(0)("Panel_Company")) = True Then
                                DropDownList_Parties.DataBind()
                                DropDownList_Parties.SelectedValue = Session("PartyID")
                                DropDownList_Parties.Items.Insert(0, New ListItem("Select Party", "0"))
                                ddlDesignation.DataBind()
                                td_Insurer.Visible = True
                                td_Employee_Designation.Visible = True

                                'If dr("Billing_Party_Id").ToString() <> 0 Or dr("Billing_Party_Id").ToString() <> "" Then
                                '    DropDownList_Parties.SelectedValue = dr("Billing_Party_Id").ToString()
                                'End If
                                'If dr("Category_Id").ToString() <> 0 Or dr("Category_Id").ToString() <> "" Then
                                '    ddlDesignation.DataBind()
                                '    ddlDesignation.SelectedValue = dr("Category_Id").ToString()
                                'End If


                            Else
                                td_Insurer.Visible = False
                                td_Employee_Designation.Visible = False
                            End If
                        End If
                    End If


                End If
            End If
            If ds.Tables.Count > 1 Then
                If ds.Tables(1).Rows.Count > 0 Then
                    pnlPanelPatient.Visible = True
                    Dim dr1 As DataRow = ds.Tables(1).Rows(0)
                    lblParentName.Text = dr1("Prefix").ToString() + " " + ENC.Encrypt_Main(dr1("PFName").ToString(), False) + " " + ENC.Encrypt_Main(dr1("PMName").ToString(), False) + " " + ENC.Encrypt_Main(dr1("PLName").ToString(), False)
                    lblRegistrationDate.Text = dr1("Panel_Reg_Date").ToString()
                End If
            Else
                pnlPanelPatient.Visible = False
            End If
        Catch ex As Exception
            pnlPanelPatient.Visible = False
        End Try
    End Sub
    Protected Sub Get_PateintType_PartyInfo()
        If Not Page.IsPostBack Then
            LoadPatientSavedValueForParty()        
        End If
    End Sub

    Protected Sub LoadPatientPanel()
        Dim sql_arg As New DataSourceSelectArguments
        pnlPanelPatient.Visible = True
        Dim dv As DataView = SQL_Patient_Type_Sub.Select(sql_arg)
        If dv.Table.Rows.Count > 0 Then
            Dim drr() As DataRow = dv.Table.Select("Patient_Type_ID=" & RadioButtonList_Patient_Type.SelectedValue)
            If drr.Length > 0 Then
                If CBool(drr(0)("Panel_Company")) = True Then
                    DropDownList_Parties.DataBind()
                    DropDownList_Parties.Items.Insert(0, New ListItem("Select Party", "0"))
                    DropDownList_Parties.SelectedIndex = 0
                    ddlDesignation.DataBind()
                    DropDownList_Parties.Visible = True
                    ddlDesignation.Visible = True
                    td_Insurer.Visible = True
                    td_Employee_Designation.Visible = True
                Else
                    td_Insurer.Visible = False
                    td_Employee_Designation.Visible = False
                End If
            End If
        End If
    End Sub

    Protected Sub lbt_edit_Emp_info_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbt_edit_Emp_info.Click
        Dim reg_no As String = Session("registrationNo").ToString()
        Response.Redirect("~/Patient Registration/Update_Patient.aspx?regno=" + reg_no)
    End Sub
    Protected Sub ddl_Doctor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddl_Doctor.SelectedIndexChanged
        txtReferedFrom.Text = ddl_Doctor.SelectedItem.ToString()        
    End Sub

    Protected Sub GetDepartment(ByRef deptid As Integer)
        Dim a As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim Statement As String = "Select S.Dept_Id from SubDepartment S where (S.SubDept_Id =  " + ddlSubDept.SelectedValue + ")"
        Dim command As SqlCommand = New SqlCommand(Statement, con)
        Dim result As String = String.Empty
        command.CommandType = CommandType.Text
        con.Open()
        result = command.ExecuteScalar()
        deptid = result
        con.Close()
        If Not String.IsNullOrEmpty(result) Then
            DDLDepartment.SelectedValue = result
        End If


    End Sub
    
    Protected Sub txt_Consultant_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txt_Consultant.TextChanged
        If String.IsNullOrEmpty(txt_Consultant.Text.Trim) Then
            hf_consultant.Value = "%"
        Else
            hf_consultant.Value = "%" + txt_Consultant.Text.Trim + "%"
        End If
        ddl_Doctor.DataBind()
        ddl_Doctor.Focus()
    End Sub

    Protected Sub SqlDataSource_Doctor_Services_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Doctor_Services.Inserted
        Dim Smp_ID As String = e.Command.Parameters("@Main_ID_Out").Value
        dsPatient_Duplicate_Print.UpdateParameters("SMP_ID").DefaultValue = Smp_ID
        dsPatient_Duplicate_Print.Update()
    End Sub

    Protected Sub ddlSubDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlSubDept.SelectedIndexChanged
        ddlEmployeeName.DataBind()
        ddlRate.DataBind()
    End Sub
    Function GetPatientActiveVisit() As Boolean
        Label3.Text = ""

        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "usp_VerifyActiveVisitNo"
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = Procedurename
        mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))

        mycommand.Parameters.Add("@PerTime", Data.SqlDbType.Int)
        mycommand.Parameters("@PerTime").Direction = Data.ParameterDirection.Output
        con.Open()
        mycommand.ExecuteNonQuery()
        If Integer.Parse(mycommand.Parameters("@PerTime").Value.ToString()) < 2 Then
            Return True
        Else
            Return False

        End If
    End Function

    Protected Sub Button_SaveAll_Click(sender As Object, e As System.EventArgs) Handles Button_SaveAll.Click
        If TextBox_Payment.Text <> "" Then
            'If Not GetPatientActiveVisit() Then

            Save()
            'To insert advance against visit
            Step2()
            ' Response.Redirect("IPD_Slip_Report_Private.aspx")
            Session.Add("Ward", DDL_Ward.SelectedValue)

            Button_SaveAll.Focus()

            Response.Redirect("~/Pt_EMR/Pt_WardAdmission.aspx?Refer_id=" + ddl_Doctor.SelectedValue + "&regno=" + Session("RegistrationNo").ToString + "&payid=" + Session("YearlyNo").ToString + "&PType=" + RadioButtonList_Patient_Type.SelectedValue)
            'Else
            '    Label3.Text = "This Patient Already Registered"
            'End If
        End If
    End Sub
    Protected Sub save1()
        Dim DropDownList_PartiesValue As String = ""
        If DropDownList_Parties.SelectedValue = "" Then
            DropDownList_PartiesValue = "0"
        Else
            DropDownList_PartiesValue = DropDownList_Parties.SelectedValue
        End If
        Dim ddlDesignationValue As String = ""
        If ddlDesignation.SelectedValue = "" Then
            ddlDesignationValue = "0"
        Else
            ddlDesignationValue = ddlDesignation.SelectedValue
        End If
        Try

            If (txtMrNo.Text <> "") Then
                newRegNo = ENC.Encrypt_Main(txtMrNo.Text, True)
                Try
                    
                        If pnlPanelPatient.Visible = True Then
                            daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedItem.Text, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "IPD", DDL_Ward.SelectedValue, Request.QueryString("Recomended_Id"), ddlDesignationValue)
                        Else
                            daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedItem.Text, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "IPD", DDL_Ward.SelectedValue, Request.QueryString("Recomended_Id"), 0)
                    End If


                        Session.Add("YearlyNo", paymentID)
                Catch ex As Exception
                    Response.Write(ex.Message & "Save1()")
                End Try                
                Session("RegistrationNo") = ENC.Encrypt_Main(txtMrNo.Text, True)
                dsPatientVisit.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString
                SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = ENC.Encrypt_Main(txtMrNo.Text, True)
                HF_Flag.Value = 1


                GridView_Patient_Visit.DataBind()
                
                fmvPatientInfo.DataBind()

                txtReferedFrom.Text = ""

                Session.Add("PayId", paymentID)
                'SqlDataSource_Doctor_Services.Insert()
                '============================= To discharge the patient from OPD Visit which generated the Admission Request 
                If HiddenField_YearlyNo.Value Is Nothing Then
                Else
                    SqlDataSource_PatientVisit.Update()
                End If


                txtMrNo.Text = ""
            Else
                If Request.QueryString("Recomended_Id") Is Nothing Then

                    If pnlPanelPatient.Visible = True Then
                        daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedValue, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "OPD", 0, 0, ddlDesignation.SelectedValue())
                    Else
                        daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedValue, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "OPD", 0, 0, 0)
                    End If

                Else

                    If pnlPanelPatient.Visible = True Then
                        daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedValue, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "IPD", DDL_Ward.SelectedValue, Request.QueryString("Recomended_Id"), ddlDesignation.SelectedValue())
                    Else
                        daPatientRegistration.PatientVisitRegistration(newRegNo, ENC.Encrypt_Main(txtMrNo.Text, True), Date.Now, DDLDepartment.SelectedValue, "", Convert.ToInt32(Session("Emp_ID")), ddlDiagnosis.SelectedItem.Text, "Routine", txtReferedFrom.Text, ddlSubDept.SelectedValue, RadioButtonList_Type.SelectedValue, RadioButtonList_Patient_Type.SelectedValue, paymentID, "", DropDownList_PartiesValue, TextBox_Ins_Detail.Text, ddlEmployeeName.SelectedValue, "IPD", DDL_Ward.SelectedValue, Request.QueryString("Recomended_Id"), 0)
                    End If


                End If

                dsPatientVisit.SelectParameters("RegNo").DefaultValue = Session("RegistrationNo").ToString
                grdPatientVisit.DataBind()
                fmvPatientInfo.DataBind()
                SqlDataSource_PatientVisit.SelectParameters("RegNo").DefaultValue = ENC.Encrypt_Main(txtMrNo.Text, True)
                HF_Flag.Value = 1


                GridView_Patient_Visit.DataBind()
                '====================== New visit Number is added into the session variable PayId

            End If

        Catch ex As Exception
            Response.Write(ex.Message + "Save1()2")
        End Try
    End Sub
    Protected Sub Step2()
        '  To insert advance charges against the visit generated.
        Try

            SqlDataSource_Adv_Payment.Insert()
            Try
                ' If DropDownList_Payment_Type.SelectedValue = "Cash" Then
                '  SqlDataSourceCounterClose.Insert()
                ' End If

            Catch ex As Exception
                Response.Write(ex.Message & "Step2()")
            End Try

            TextBox_approval_no.Text = ""
            TextBox_Bank_Name.Text = ""
            TextBox_Branch_Name.Text = ""
            TextBox_Card_Service.Text = ""
            TextBox_Cheque_no.Text = ""
            TextBox_Cradit_Card_No.Text = ""
            TextBox_description.Text = ""
            TextBox_Payment.Text = ""
            ' Advance gridview is databind according to new visit No.
            GridView_Advance.DataBind()
            Session.Add("Description", TextBox_description.Text)
            Dim sb As StringBuilder = New StringBuilder
            ' sb.Append("<script language='javascript' type='text/javascript'>window.open('Indoor_Payment_receipt.aspx?Payment_No=" + HiddenFieldMainId.Value + "&PayID=" + Session("YearlyNo") + "&RegNo=" + Session("RegistrationNo") + "&Type=Advance" + "')</script>")
            'sb.Append(" window.open('patientServices.aspx')</script>")
            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If

        Catch ex As Exception
            Response.Write(ex.Message & "Step2()1")
        End Try


    End Sub

    Protected Sub ddlEmployeeName_SelectedIndexChanged(sender As Object, e As EventArgs)
        ddlRate.DataBind()
    End Sub

    Protected Sub btn_Return_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/Patient%20Registration/PatientSearch.aspx")
        Session.Remove("ConsultantId")
        Session.Remove("RegistrationNo")
    End Sub
End Class
