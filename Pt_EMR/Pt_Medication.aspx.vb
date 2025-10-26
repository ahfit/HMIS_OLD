Imports System.Data
Imports System.Data.SqlClient
Imports Infragistics.WebUI.WebSchedule

Partial Class Pt_EMR_Pt_Medicationwe
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Dim constr1 As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ToString()
    Dim flag As Integer = 0
    Dim ENC As New Encryption

    Protected Sub ButtonSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearch.Click
        Label1.Text = ""
    End Sub

    Sub search(ByVal a As Integer, ByVal MedSearch As String)
        Try
            Dim Med_name As String
            Dim spec As String
            Dim item_code As String
            Dim cat As String
            Dim Hospital_Id As Integer = 0

            If RadioButtonList_HospitalMed.SelectedValue = 1 Then
                Hospital_Id = Session("HospitalId")
            End If
            Label_Stock.Text = ""
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim reader As SqlDataReader
            Dim command As SqlCommand = New SqlCommand("Medicine_outside_select", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@mgname", MedSearch)


            con.Open()
            reader = command.ExecuteReader()
            If reader.Read Then
                Med_name = reader.Item("Item_Name")
                Label_Stock.Text = reader.Item("Stock")
                spec = reader.Item(1)
                item_code = reader.Item(2)
                cat = reader.Item(3)

            Else
                Med_name = ""
                spec = ""
                item_code = ""
                cat = ""
                Label_Stock.Text = ""
            End If

            Medicine_Route(cat.Trim)
            'Medicine_Frequency(item_code.Trim)
            Label1.Text = ""

            Dim medicineName As String = Med_name.Trim
            Dim medicineCode As String = item_code.Trim
            HiddenField_MedCode.Value = medicineCode

            '---------------------------------------------------------------    

            'If cat.Trim = "INJ" Then
            '    TextBox_dilution.Visible = True
            '    'DropDownList_diution.Visible = True
            '    'Label_Dilution.Visible = True
            'Else
            '    TextBox_dilution.Visible = False
            '    'DropDownList_diution.Visible = False
            '    'Label_Dilution.Visible = False
            'End If

            '----------------------------------------------------------------

            Label1.Text = medicineName
            TextBox_Medicine.Text = medicineCode

            HiddenField_MedCode.Value = TextBox_Medicine.Text
            LabelMessage.Text = HiddenField_MedCode.Value

            con.Close()
        Catch ex As Exception

        End Try
    End Sub

    Sub Medicine_Route(ByVal Category As String)
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT DISTINCT isnull( Category,'') FROM Assign_Medicine_Route", con)
        command.CommandType = CommandType.Text
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read()
            If Category.Contains(reader.Item(0).ToString.Trim) Then
                HiddenField_Medicine_Category.Value = reader.Item(0).ToString
                Exit While
            Else
                HiddenField_Medicine_Category.Value = ""
            End If
        End While
    End Sub

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            LabelMessage.Text = ""




            HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))

            Dim start_Date As Date
            Dim end_date As Date

            start_Date = Convert.ToDateTime(WebDateChooserStartDate.Value)
            end_date = Convert.ToDateTime(WebDateChooserEndDate.Value)


            HiddenFieldStartDate.Value = Convert.ToString(start_Date.Month) + "/" + Convert.ToString(start_Date.Day) + "/" + Convert.ToString(start_Date.Year) + " 00:00"
            HiddenFieldEndDate.Value = Convert.ToString(end_date.Month) + "/" + Convert.ToString(end_date.Day) + "/" + Convert.ToString(end_date.Year) + " 00:00"

            HiddenField_dosage.Value = TextBox_dosage.Text + DropDownList_dosage.SelectedValue
            If TextBox_dilution.Text = "" Then
                HiddenField_Dilution.Value = "XX"
            Else
                HiddenField_Dilution.Value = TextBox_dilution.Text
            End If

            If CheckBox_CT.Checked = True Then
                HiddenField_CT.Value = "Continue Treatment"
            Else
                HiddenField_CT.Value = ""
            End If


            If HiddenField_priscription_id.Value = "" Then
                HiddenField_priscription_id.Value = 0
            End If

            HiddenField_MedCode.Value = Session("MEDCode")
            If ddlDepartmentMedicines.SelectedValue <> "0" Then
                HiddenField_MedCode.Value = ddlDepartmentMedicines.SelectedValue
            End If

            Session.Remove("MEDCode")
            Try


                Dim objManager As DbManager = New DbManager()
                Dim sqlParams As SqlParameter() = {
                        New SqlParameter("@Prescription_Id", SqlDbType.BigInt, 8, ParameterDirection.Output, False, 0, 0, 0, DataRowVersion.Default, 0),
                        New SqlParameter("@Yearly_NO", Session("YearlyNo")),
                        New SqlParameter("@Med_Code", HiddenField_MedCode.Value),
                        New SqlParameter("@Registration_NO", Session("registrationNo")),
                        New SqlParameter("@Dosage", HiddenField_dosage.Value),
                        New SqlParameter("@Route_ID", DropDownList_route.SelectedValue),
                        New SqlParameter("@Dilution", HiddenField_Dilution.Value),
                        New SqlParameter("@Meal", DropDownList_Meal.SelectedValue),
                        New SqlParameter("@Frequency_ID", DropDownList_frequencyName.SelectedValue),
                        New SqlParameter("@days", TextBox_days.Text),
                        New SqlParameter("@emp_ID", Session("emp_id")),
                        New SqlParameter("@Instruction", TextBoxInstruction.Text),
                        New SqlParameter("@StartDate", HiddenFieldStartDate.Value),
                        New SqlParameter("@EndDate", HiddenFieldEndDate.Value),
                        New SqlParameter("@Dose", HiddenFieldDose.Value),
                        New SqlParameter("@CT", HiddenField_CT.Value),
                        New SqlParameter("@Duration", DropDownList_diution.SelectedValue),
                        New SqlParameter("@Medicine_Advice_Category_ID", DropDownList_Medicine_Advice_Category.SelectedValue),
                        New SqlParameter("@BeforeMeal", txtboxBeforeMeal.Text),
                        New SqlParameter("@AfterMeal", txtboxAfterMeal.Text),
                        New SqlParameter("@MedicineType", ddlMedicineType.SelectedValue)
                        }

                objManager.ExecuteNonQuery("Insert_Patient_Prescription_Detail", "TreatmentConnectionString", sqlParams)
                HiddenField_priscription_id.Value = sqlParams(0).Value

                Update_Confirmation(HiddenField_priscription_id.Value)
                'For Insert Allergic Medicine  --- In case of 1 Medicine
                If rd_DrugAllergic.SelectedValue = 1 Then
                    If Not HiddenField_MedCodeAllergic.Value = "" Then
                        Dim query = "insert into Pt_Allergic_Medicine values(@RegNo, @YearlyNo, @DiagnosedCode, @AllergicCode, @Other,@percerptionID)"
                        Dim conn As SqlConnection = New SqlConnection(constr1)
                        Using conn
                            conn.Open()
                            Dim cmd As SqlCommand = New SqlCommand(query, conn)
                            cmd.Parameters.Add(New SqlParameter("@RegNo", Session("registrationNo")))
                            cmd.Parameters.Add(New SqlParameter("@YearlyNo", Session("YearlyNo")))
                            cmd.Parameters.Add(New SqlParameter("@DiagnosedCode", HiddenField_MedCode.Value))
                            cmd.Parameters.Add(New SqlParameter("@AllergicCode", HiddenField_MedCodeAllergic.Value))
                            cmd.Parameters.Add(New SqlParameter("@Other", txt_Other.Text.Trim()))
                            cmd.Parameters.Add(New SqlParameter("@percerptionID", HiddenField_priscription_id.Value))

                            Using cmd
                                cmd.ExecuteNonQuery()
                            End Using
                            conn.Close()
                        End Using
                    End If
                End If
                For i As Integer = 0 To DataList_Frequency.Items.Count - 1

                    Dim HF_F_S_Id As HiddenField = DataList_Frequency.Items(i).FindControl("HF_F_S_Id")
                    HiddenField_Frequency_Sub_Id.Value = HF_F_S_Id.Value
                    Dim TextBox_dosage1 As TextBox = DataList_Frequency.Items(i).FindControl("TextBox_dosage2")
                    HiddenField_DL_Dosage.Value = TextBox_dosage1.Text

                    Try
                        SqlDataSource_Frequency_detail.Insert()

                    Catch ex As Exception
                        Response.Write(ex.Message)

                    End Try

                Next
                ButtonSave.Text = "Save"
                HiddenField_priscription_id.Value = "0"
                DataList_new.DataBind()
                DataList_ConfirmedPrescriptions.DataBind()
                HiddenField_flag.Value = 0

                Clear()
                'Else

                '    LabelMessage.ForeColor = System.Drawing.Color.Red : LabelMessage.Text = "Select Drug Allergic Or Not"
                '    LabelMessage.Visible = True

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        Catch ex As Exception

        End Try
    End Sub


    Sub search_med_Code()
        Dim connection As New SqlConnection
        Dim command As SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        command = connection.CreateCommand
        command.CommandText = "SELECT     ISNULL(Drug_Category, '') + ' ' + ISNULL(Item_Name, '') + ' ' + ISNULL(Potency, '') + ISNULL(Unit, '') AS [Medicine Name], Item_Code FROM         Store_Items where ISNULL(Drug_Category, '') + ' ' + ISNULL(Item_Name, '') + ' ' + ISNULL(Potency, '') + ISNULL(Unit, '')='" + TextBox_specificMedicine.Text + "'"
        connection.Open()
        reader = command.ExecuteReader
        If reader.Read Then
            HiddenField_MedCode.Value = reader.Item(1)
        End If
        reader.Close()
        connection.Close()


    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu


        If Session("MEDCode") = Nothing Then
            Session("MEDCode") = HiddenField_MedCode.Value
        End If


        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
        Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))


        LabelMessage.Visible = False

        If RadioButtonList_HospitalMed.SelectedValue = 1 Then
            TextBox_specificMedicine_hs.Visible = True
            TextBox_specificMedicine.Visible = False
            TextBox_specificMedicine.Text = ""
        Else
            TextBox_specificMedicine.Visible = True
            TextBox_specificMedicine_hs.Visible = False
            TextBox_specificMedicine_hs.Text = ""
        End If


        WebDateChooserStartDate.MinDate = Date.Now
        If Not IsPostBack Then
            getPatientPreviousMedicine()
            getMedinceDepartmentWise()
            WebDateChooserStartDate.Value = Date.Now
            WebDateChooserEndDate.Value = Date.Now
            DropDownList_frequencyName.DataBind()
            Dim str As String = Convert.ToString(Date.Today.Date.Day) + Convert.ToString("/") + Convert.ToString(Date.Today.Date.Month) + Convert.ToString("/") + Convert.ToString(Date.Today.Date.Year)
            GetFrequency()
            DataList_Frequency.Visible = False
            BindGrid()
        End If

    End Sub
    Protected Sub GetFrequency()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
              }
        Dim dt As DataTable = objManager.ExecuteDataTable("GetFrequency", "STOREConnectionString", sqlParams)
        DropDownList_frequencyName.DataSource = dt
        DropDownList_frequencyName.DataBind()

    End Sub


    Protected Sub TextBox_days_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_days.TextChanged
        Dim date_d As Date = WebDateChooserStartDate.Value
        Dim date_e As Date = DateAdd(DateInterval.Day, CInt(TextBox_days.Text), date_d)
        WebDateChooserEndDate.Value = CDate(date_e)
        If rdbtnMedicines.SelectedValue = "Dept" Then
            hfForAutoPostBack.Value = "0"
        Else
            hfForAutoPostBack.Value = ""
        End If
        'rdbtnMedicines.SelectedValue = "All"

    End Sub


    Protected Sub WebDateChooserEndDate_ValueChanged(ByVal sender As Object, ByVal e As Infragistics.WebUI.WebSchedule.WebDateChooser.WebDateChooserEventArgs) Handles WebDateChooserEndDate.ValueChanged

        Dim diff As Int64 = DateDiff(DateInterval.Day, WebDateChooserStartDate.Value, WebDateChooserEndDate.Value, Microsoft.VisualBasic.FirstDayOfWeek.Monday, FirstWeekOfYear.System)
        TextBox_days.Text = diff + 1

    End Sub




    Protected Sub GridViewMedcationAssign_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Template_Medicine.SelectedIndexChanged

    End Sub

    'Protected Sub DropDownList_frequencyName_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_frequencyName.SelectedIndexChanged
    '    HiddenField_frequency.Value = DropDownList_frequencyName.SelectedValue
    '    'frequency_ID()
    '    TextBox_Frequency.Text = "1"
    '    DataList_Frequency.DataBind()
    '    If rdbtnMedicines.SelectedValue = "Dept" Then
    '        hfForAutoPostBack.Value = "0"
    '    Else
    '        hfForAutoPostBack.Value = ""
    '    End If

    'End Sub

    Protected Sub TextBox_specificMedicine_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_specificMedicine.TextChanged
        HiddenField_flag.Value = 0
        search(0, TextBox_specificMedicine.Text)
    End Sub

    Protected Sub DataList_new_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_new.SelectedIndexChanged
        Dim connection As New SqlConnection
        Dim command As SqlCommand
        Dim reader As SqlDataReader
        connection.ConnectionString = constr1
        command = connection.CreateCommand
        HiddenField_priscription_id.Value = Convert.ToDouble(DataList_new.SelectedValue).ToString
        command.CommandText = "SELECT  Pt_Prescription_Detail.Dose, Convert(datetime,Pt_Prescription_Detail.StartDate) StartDate, Convert(datetime,Pt_Prescription_Detail.EndDate,103) EndDate, ISNULL(Pt_Prescription_Detail.CT, '') AS CT, Pt_Prescription_Detail.Meal, Medicine_Frequency.Name, Pt_Prescription_Detail.Dilution, ISNULL(Pt_Prescription_Detail.Duration, '') AS Duration, ISNULL(Pt_Prescription_Detail.Instruction, '') AS Instruction, Medicine_Frequency.id, ISNULL(Pt_Prescription_Detail.Route_ID, '') AS Route_ID, DATEDIFF(dd, Pt_Prescription_Detail.StartDate, Pt_Prescription_Detail.EndDate) AS days, Pt_Prescription_Detail.Medicine_Advice_Category_ID, Pt_Prescription_Detail.Med_Code, Medicine.[Medicine Name], priscription_id FROM  Pt_Prescription_Detail INNER JOIN (SELECT DISTINCT  ISNULL(Drug_Category, '') + ' ' + ISNULL(Item_Name, '') AS [Medicine Name], ISNULL(Potency, '') + ISNULL(Unit, '') AS Specfication, Item_Code FROM          STORE.dbo.Store_Items) AS Medicine ON Pt_Prescription_Detail.Med_Code = Medicine.Item_Code LEFT OUTER JOIN Medicine_Frequency ON Pt_Prescription_Detail.Frequency_ID = Medicine_Frequency.id  WHERE     Pt_Prescription_Detail.priscription_id =" + Convert.ToDouble(DataList_new.SelectedValue).ToString
        connection.Open()
        reader = command.ExecuteReader

        If reader.Read Then
            Try

                Try
                    Label1.Text = reader.Item("Medicine Name")
                    TextBox_specificMedicine.Text = reader.Item("Medicine Name")
                Catch ex As Exception

                End Try
                Try
                    ' TextBox_Medicine.Text = reader.Item("Item_Code")
                    HiddenField_MedCode.Value = reader.Item("Med_Code")
                Catch ex As Exception

                End Try

                'HiddenField_MedCode.Value = TextBox_Medicine.Text
                LabelMessage.Text = HiddenField_MedCode.Value


                Try

                    DropDownList_frequencyName.SelectedValue = reader.Item(9)
                Catch ex As Exception

                End Try
                Try
                    ' DropDownList_frequencyName.DataBind()

                    'frequency_ID()
                Catch ex As Exception

                End Try


                'WebMaskEdit1.Text = reader.Item(0)
                DropDownList_route.DataBind()
                Try
                    DropDownList_route.SelectedValue = reader.Item(10)
                Catch ex As Exception

                End Try
                Try
                    WebDateChooserStartDate.Value = reader.Item("StartDate") + " 12:00:00 AM"
                Catch ex As Exception
                    Response.Write(ex.Message.ToString)
                End Try

                Try
                    WebDateChooserEndDate.Value = reader.Item("EndDate")
                Catch ex As Exception

                End Try

                Try
                    TextBox_dilution.Text = reader.Item(6)
                Catch ex As Exception

                End Try
                Try
                    'DropDownList_diution.SelectedValue = reader.Item(7)
                Catch ex As Exception

                End Try
                Try
                    DropDownList_Meal.SelectedValue = reader.Item(4)
                Catch ex As Exception

                End Try
                Try
                    TextBoxInstruction.Text = reader.Item(8)
                Catch ex As Exception

                End Try
                Try
                    TextBox_days.Text = reader.Item("days")
                Catch ex As Exception

                End Try
                'HiddenField_priscription_id.Value = reader.Item("priscription_id")

                If reader.Item(3) = "Continue Treatment" Then
                    CheckBox_CT.Checked = True
                Else
                    CheckBox_CT.Checked = False
                End If

                Try
                    DropDownList_Medicine_Advice_Category.SelectedValue = reader.Item(12)
                Catch ex As Exception

                End Try
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            DataList_Frequency.DataBind()
            For i As Integer = 0 To DataList_Frequency.Items.Count - 1
                Dim HF_F_S_Id As HiddenField = DataList_Frequency.Items(i).FindControl("HF_F_S_Id")
                Dim TextBox_dosage2 As TextBox = DataList_Frequency.Items(i).FindControl("TextBox_dosage2")
                TextBox_dosage2.Text = Get_Dosage(HF_F_S_Id.Value)
            Next

            'Button_Update.Visible = True
            'ButtonSave.Visible = False
            ButtonSave.Text = "Update"
        End If
        reader.Close()
        connection.Close()

        HiddenField_flag.Value = 1
    End Sub


    Protected Sub Clear()
        Label1.Text = ""
        TextBox_specificMedicine.Text = ""
        HiddenField_MedCode.Value = ""
        LabelMessage.Text = ""
        DropDownList_frequencyName.SelectedIndex = 0
        DropDownList_route.DataBind()
        'DropDownList_route.SelectedIndex = 0
        WebDateChooserStartDate.Value = Date.Now
        WebDateChooserEndDate.Value = Date.Now
        TextBox_dilution.Text = ""
        'DropDownList_diution.SelectedIndex = 0
        'DropDownList_Meal.SelectedIndex = 0
        TextBoxInstruction.Text = ""
        txtboxBeforeMeal.Text = ""

        txtboxAfterMeal.Text = ""

        TextBox_days.Text = 1
        DataList_Frequency.Visible = False
        HiddenField_MedCodeAllergic.Value = ""
        rd_DrugAllergic.SelectedValue = 0
        txt_Other.Enabled = False
        TextBox_specificMedicineAllergic.Enabled = False
        TextBox_specificMedicineAllergic.Text = ""
        txt_Other.Text = ""
        LabelMessage.Visible = False
        'If reader.Item(3) = "Continue Treatment" Then
        '    CheckBox_CT.Checked = True
        'Else
        '    CheckBox_CT.Checked = False
        'End If
        'DropDownList_Medicine_Advice_Category.SelectedIndex = 0

    End Sub



    Protected Sub TextBox_Frequency_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Frequency.TextChanged
        For i As Integer = 0 To DataList_Frequency.Items.Count - 1
            Dim TextBox_dosage2 As TextBox = DataList_Frequency.Items(i).FindControl("TextBox_dosage2")
            TextBox_dosage2.Text = TextBox_Frequency.Text


            'rdbtnMedicines.SelectedValue = "All"
        Next
        If rdbtnMedicines.SelectedValue = "Dept" Then
            hfForAutoPostBack.Value = "0"
        Else
            hfForAutoPostBack.Value = ""
        End If
    End Sub

    Protected Sub ImageButton_Frequency_ShowHide_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Frequency_ShowHide.Click

        If DataList_Frequency.Visible = True Then
            DataList_Frequency.Visible = False
        Else
            DataList_Frequency.Visible = True
        End If
    End Sub

    Protected Sub btn_delete_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim Ibtn As ImageButton = sender
        HiddenField_Prescription_Id.Value = Ibtn.CommandArgument()

        SqlDataSource_Confirmed_Prescriptions.Delete()
        'LabelMessageMedicine.Text = "Medicine deleted successfully ..."
        DataList_ConfirmedPrescriptions.DataBind()
    End Sub

    Protected Sub DataList_new_DeleteCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataListCommandEventArgs) Handles DataList_new.DeleteCommand

        Try
            Dim hidd_pres_ID As HiddenField = DataList_new.Items(e.Item.ItemIndex).FindControl("HiddenField_PrescriptionID")
            HiddenField_priscription_id.Value = hidd_pres_ID.Value
            'Response.Write(HiddenField_priscription_id.Value)
            'SqlDataSource1.Delete()
            Dim qry As String = "DELETE FROM Pt_Prescription_Detail WHERE (priscription_id = @priscription_id)"
            Dim con As SqlConnection = New SqlConnection(constr1)
            con.Open()
            Dim command As SqlCommand = New SqlCommand(qry, con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@priscription_id", HiddenField_priscription_id.Value)
            command.ExecuteNonQuery()
            con.Close()
            DataList_new.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message.ToString())

        End Try

        'e.Item.ItemIndex
        'sqldata()
    End Sub

    Protected Sub Button_Confirm_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Confirm.Click
        Dim dt As New DataTable
        dt = New DataTable("Confirmed_Item")

        Dim id As DataColumn = New DataColumn("priscription_id")
        id.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(id)

        Dim Medicine_Name As DataColumn = New DataColumn("Medicine Name")
        Medicine_Name.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(Medicine_Name)

        Dim Doze As DataColumn = New DataColumn("Doze")
        Doze.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(Doze)

        Dim Dosage As DataColumn = New DataColumn("Dosage")
        Dosage.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(Dosage)

        Dim Start_Date As DataColumn = New DataColumn("Start Date")
        Start_Date.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(Start_Date)

        Dim End_Date As DataColumn = New DataColumn("End Date")
        End_Date.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(End_Date)

        Dim CT As DataColumn = New DataColumn("CT")
        CT.DataType = System.Type.GetType("System.String")
        dt.Columns.Add(CT)

        If DataList_new.Items.Count <> 0 Then
            For i As Integer = 0 To DataList_new.Items.Count - 1
                Dim CheckBox_Confirm As CheckBox = DataList_new.Items(i).FindControl("CheckBox_Confirm")
                If CheckBox_Confirm.Checked Then
                    Dim dr As DataRow
                    dr = dt.NewRow()
                    Dim HiddenField_PrescriptionID As HiddenField = DataList_new.Items(i).FindControl("HiddenField_PrescriptionID")
                    Dim HiddenField_CT As HiddenField = DataList_new.Items(i).FindControl("HiddenField_CT")
                    Dim HiddenField_EndDate As HiddenField = DataList_new.Items(i).FindControl("HiddenField_EndDate")
                    Dim HiddenField_Start_Date As HiddenField = DataList_new.Items(i).FindControl("HiddenField_Start_Date")

                    Dim HiddenField_Dosage As HiddenField = DataList_new.Items(i).FindControl("HiddenField_Dosage")
                    Dim HiddenField_Doze As HiddenField = DataList_new.Items(i).FindControl("HiddenField_Doze")
                    Dim HiddenField_MedicineName As HiddenField = DataList_new.Items(i).FindControl("HiddenField_MedicineName")

                    dr.Item("priscription_id") = HiddenField_PrescriptionID.Value
                    dr.Item("Medicine Name") = HiddenField_MedicineName.Value
                    dr.Item("Doze") = HiddenField_Doze.Value
                    dr.Item("Dosage") = HiddenField_Dosage.Value
                    dr.Item("Start Date") = HiddenField_Start_Date.Value
                    dr.Item("End Date") = HiddenField_EndDate.Value
                    dr.Item("CT") = HiddenField_CT.Value
                    dt.Rows.Add(dr)
                End If
            Next

            DataList_Items.DataSource = dt
            DataList_Items.DataBind()
            DataList_Items.Visible = False
            Button_OK.Visible = True
            TextBox_Prescription_Code.Visible = True
            Label_Lbl.Visible = True
            Panel_Confirm.Visible = True
            Button_Confirm.Visible = False
        End If

    End Sub
    Protected Sub Update_Confirmation(ByVal Prescription_ID As Integer)
        Dim qry As String = "UPDATE Pt_Prescription_Detail SET ConfirmedBy = @ConfirmedBy, ConfirmedDate = GETDATE() WHERE (priscription_id = @priscription_id)"
        Dim con As SqlConnection = New SqlConnection(constr1)
        con.Open()
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@ConfirmedBy", Session("emp_id"))
        command.Parameters.AddWithValue("@priscription_id", Prescription_ID)
        command.ExecuteNonQuery()
        con.Close()


    End Sub

    Protected Sub Button_OK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_OK.Click
        'If IS_Code_Matched(Session("emp_id"), TextBox_Prescription_Code.Text.Trim) Then
        '    DataList_Items.Visible = True
        '    Label_MSG.Text = ""
        '    Button_OK.Visible = False
        '    TextBox_Prescription_Code.Visible = False
        '    Label_Lbl.Visible = False
        If DataList_Items.Items.Count <> 0 Then
            For i As Integer = 0 To DataList_Items.Items.Count - 1
                Dim HiddenField_PrescriptionID As HiddenField = DataList_Items.Items(i).FindControl("HiddenField_PrescriptionID")
                Update_Confirmation(HiddenField_PrescriptionID.Value)
            Next
        End If
        DataList_new.DataBind()
        DataList_ConfirmedPrescriptions.DataBind()

        'Else
        '    Label_MSG.Text = "Pass Code Not Matched Try Again"
        'End If
    End Sub
    Protected Function IS_Code_Matched(ByVal emp_ID As Integer, ByVal p_code As String) As Boolean

        Dim constring As String = ConfigurationManager.ConnectionStrings("Users_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim is_Matched As Boolean = False
        Dim qry As String = "SELECT Password FROM Login WHERE (EmpID = @EmpID)"
        con.Open()
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@EmpID", emp_ID)
        Dim reader As SqlDataReader = cmd.ExecuteReader
        While reader.Read
            If ENC.Encrypt_Main(reader.Item("Password").ToString(), False) = p_code Then
                is_Matched = True
            End If
        End While
        Return is_Matched
    End Function

    Protected Sub ImageButton_Close_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton_Close.Click
        Button_Confirm.Visible = True
        Panel_Confirm.Visible = False
    End Sub

    Protected Sub DataList_new_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList_new.PreRender
        If DataList_new.Items.Count <> 0 Then
            Button_Confirm.Visible = True
        Else
            Button_Confirm.Visible = False
        End If
        For i As Integer = 0 To DataList_new.Items.Count - 1
            Dim hd_presc_id As HiddenField = DataList_new.Items(i).FindControl("HiddenField_PrescriptionID")
            Dim Lbl_Frequency As Label = DataList_new.Items(i).FindControl("Label_Frequency")
            ' Lbl_Frequency.Text = Basic_Checks.Frequency(hd_presc_id.Value)
        Next

    End Sub

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click
        Button_Update.Visible = False
    End Sub

    Protected Function Get_Dosage(ByVal FSID As String) As String
        Dim dose As String = ""
        Dim qry As String = "SELECT isnull(Dosage,1) FROM PT_Prescription_Frequency_Detail WHERE (Prescription_Id = @Prescription_Id) AND (Frequency_Sub_Id = @Frequency_Sub_Id)"
        Dim con As SqlConnection = New SqlConnection(constr1)
        Dim reader As SqlDataReader
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.Text
        con.Open()
        command.Parameters.AddWithValue("@Prescription_Id", HiddenField_priscription_id.Value)
        command.Parameters.AddWithValue("@Frequency_Sub_Id", FSID)
        reader = command.ExecuteReader
        If reader.Read Then
            dose = reader.Item(0)
        Else
            dose = 1
        End If
        con.Close()
        Return dose
    End Function




    Protected Sub btn_MedicationSheet_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_MedicationSheet.Click
        Response.Redirect("../Patient%20Billing/MedicationSheet.aspx")
    End Sub

    Protected Sub TextBox_specificMedicine_hs_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_specificMedicine_hs.TextChanged
        search(0, TextBox_specificMedicine_hs.Text)
    End Sub

    Public Sub getMedinceDepartmentWise()
        Dim subDeptID As String
        If Session("SubDeptID") Is Nothing Then
            subDeptID = "0"
        Else
            subDeptID = Session("SubDeptID")
        End If
        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("usp_GetDepartmentWisePatietnMedicines", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("subdeptID", subDeptID)})
        ddlDepartmentMedicines.DataSource = dt
        ddlDepartmentMedicines.DataValueField = "Item_Code"
        ddlDepartmentMedicines.DataTextField = "Item_Name"
        ddlDepartmentMedicines.DataBind()
        ddlDepartmentMedicines.Items.Insert(0, New ListItem("Select", "0"))



    End Sub


    Protected Sub btnSavePreviousMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            For index = 0 To datalistForPreviousMedicine.Items.Count - 1

                Dim CheckboxForSelection As CheckBox = datalistForPreviousMedicine.Items(index).FindControl("assign")
                If CheckboxForSelection.Checked = True Then
                    Dim MedicineName As HiddenField = datalistForPreviousMedicine.Items(index).FindControl("hfMedicine_Name")
                    Dim MedicineCode As HiddenField = datalistForPreviousMedicine.Items(index).FindControl("hfMedicine_Code")
                    Dim ddlRoute As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_routeForPreviousMedicine")
                    Dim ddlFrequency As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_frequencyNameForPreviousMedicine")
                    Dim txtboxFrequency As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBox_FrequencyForPreviousMedicine")
                    Dim datalistFrequency As DataList = datalistForPreviousMedicine.Items(index).FindControl("DataList_FrequencyForPreviousMedicine")
                    Dim ddlMeal As DropDownList = datalistForPreviousMedicine.Items(index).FindControl("DropDownList_MealForPreviousMedicine")
                    Dim txtboxDays As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBox_daysForPreviousMedicine")
                    Dim StartDate As WebDateChooser = datalistForPreviousMedicine.Items(index).FindControl("WebDateChooserPreviousStartDate")


                    Dim txtboxInstruction As TextBox = datalistForPreviousMedicine.Items(index).FindControl("TextBoxInstructionForPreviousMedicine")


                    HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))
                    HiddenField_MedCode.Value = MedicineCode.Value


                    Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    Dim con As SqlConnection = New SqlConnection(a)
                    Dim mycommand As New SqlCommand("Insert_Patient_Prescription_Detail", con)
                    mycommand.CommandType = CommandType.StoredProcedure
                    mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@Med_Code", MedicineCode.Value)
                    mycommand.Parameters.AddWithValue("@Registration_NO", Session("registrationNo"))
                    mycommand.Parameters.AddWithValue("@Route_ID", ddlRoute.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Dilution", "")
                    mycommand.Parameters.AddWithValue("@Meal", ddlMeal.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Frequency_ID", ddlFrequency.SelectedValue)
                    mycommand.Parameters.AddWithValue("@days", txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@Instruction", txtboxInstruction.Text.ToString())
                    mycommand.Parameters.AddWithValue("@StartDate", StartDate.Value)

                    Dim d As String = Convert.ToDateTime(StartDate.Value).Date.AddDays(txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@EndDate", d)
                    mycommand.Parameters.AddWithValue("@Dose", "")
                    mycommand.Parameters.AddWithValue("@Dosage", "")
                    mycommand.Parameters.AddWithValue("@CT", "")
                    mycommand.Parameters.AddWithValue("@Duration", "")
                    mycommand.Parameters.AddWithValue("@Medicine_Advice_Category_ID", "")
                    mycommand.Parameters.AddWithValue("@BeforeMeal", "")
                    mycommand.Parameters.AddWithValue("@AfterMeal", "")
                    mycommand.Parameters.AddWithValue("@MedicineType", "")

                    mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_id"))
                    mycommand.Parameters.Add("@Prescription_Id", SqlDbType.Int)
                    mycommand.Parameters("@Prescription_Id").Direction = ParameterDirection.Output

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    HiddenField_Prescription_Id.Value = mycommand.Parameters("@Prescription_Id").Value
                    con.Close()

                    Update_Confirmation(HiddenField_Prescription_Id.Value)
                    DataList_ConfirmedPrescriptions.DataBind()
                    'LabelMessageMedicine.Text = Label1.Text + " " + " added sussessfully..."

                    GridView_Template_Medicine.DataBind()
                    GridView2.DataBind()
                    'gen_xml(Date.Now)
                    TextBox_dilution.Text = ""
                    TextBox_dosage.Text = "1"
                    Label1.Text = ""
                    DataList_new.DataBind()
                    'DataList_old.DataBind()

                    For i As Integer = 0 To datalistFrequency.Items.Count - 1
                        Dim HF_F_S_Id As HiddenField = datalistFrequency.Items(i).FindControl("HF_F_S_IdForPreviousMedicine")
                        HiddenField_Frequency_Sub_Id.Value = HF_F_S_Id.Value
                        Dim TextBox_dosage1 As TextBox = datalistFrequency.Items(i).FindControl("TextBox_dosage2ForPreviousMedicine")
                        HiddenField_DL_Dosage.Value = TextBox_dosage1.Text
                        HiddenField_priscription_id.Value = HiddenField_Prescription_Id.Value
                        Try
                            SqlDataSource_Frequency_detail.Insert()
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        End Try
                    Next
                End If
            Next

            DataList_ConfirmedPrescriptions.DataBind()
            getPatientPreviousMedicine()
            lblMsg.Visible = True
        Catch ex As Exception
            Response.Write(ex.Message)
            lblMsg.Visible = False
            lblMsg.Text = "Some thing Went Wrong"
        End Try

    End Sub

    Protected Sub datalistForPreviousMedicine_ItemDataBound(sender As Object, e As DataListItemEventArgs)
        Dim datee As WebDateChooser = e.Item.FindControl("WebDateChooserPreviousStartDate")
        datee.Value = DateTime.Now.Date

    End Sub
    Protected Sub DropDownList_frequencyNameForPreviousMedicine_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = sender
        Dim datalist As DataListItem = DirectCast(ddl.NamingContainer, DataListItem)
        Dim frequencyDropDown As DropDownList = DirectCast(datalist.FindControl("DropDownList_frequencyNameForPreviousMedicine"), DropDownList)
        Dim frequencyDatalist As DataList = DirectCast(datalist.FindControl("DataList_FrequencyForPreviousMedicine"), DataList)

        Dim db As DbManager = New DbManager()
        Dim dt As DataTable = db.ExecuteDataTable("uspGetFrequencyList", "TreatmentConnectionString", New SqlParameter() {New SqlParameter("id", frequencyDropDown.SelectedValue)})
        frequencyDatalist.DataSource = dt
        frequencyDatalist.DataBind()

    End Sub

    Protected Sub DropDownList_frequencyName_SelectedIndexChanged(sender As Object, e As EventArgs)
        DataList_Frequency.Visible = True
    End Sub

    Public Sub getPatientPreviousMedicine()

        Dim dbManager As DbManager = New DbManager()
        Dim dt As DataTable = dbManager.ExecuteDataTable("Select_Med_Presc_Urdu_PreviousMedication", "TreatmentConnectionString",
                                                         New SqlParameter() {New SqlParameter("@RegNo", Session("registrationNo"))})
        datalistForPreviousMedicine.DataSource = dt
        datalistForPreviousMedicine.DataBind()



    End Sub

    Protected Sub gvdFavouriteMedicine_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvdFavouriteMedicine.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim hfRouteValue As HiddenField = e.Row.FindControl("hfDDlRuteValue")
            Dim hfFrequencyIDs As HiddenField = e.Row.FindControl("hfFrequencyID")
            Dim hfMeals As HiddenField = e.Row.FindControl("hfMeals")
            Dim hfDeptMedID As HiddenField = e.Row.FindControl("hfDeptMedID")

            Dim MedicineName As TextBox = e.Row.FindControl("txtboxMedicineName")
            Dim DDLRoutes As DropDownList = e.Row.FindControl("ddlRoute")
            Dim DDlFrequecny As DropDownList = e.Row.FindControl("ddlFrequency")
            Dim DDlMeal As DropDownList = e.Row.FindControl("ddlMeals")
            Dim PhysicanNotes As TextBox = e.Row.FindControl("physicanNotes")
            Dim Days As TextBox = e.Row.FindControl("txtDays")

            'DDLRoutes.DataBind()
            DDLRoutes.SelectedValue = hfRouteValue.Value


            Dim Dbmanager As DbManager = New DbManager()
            Dim param() As SqlParameter = {}
            DDlFrequecny.DataSource = Dbmanager.ExecuteDataSet("GetFrequency", "STOREConnectionString", param)
            DDlFrequecny.DataBind()
            DDlFrequecny.SelectedValue = hfFrequencyIDs.Value
            DDlMeal.DataBind()
            DDlMeal.SelectedValue = hfMeals.Value


            Dim datalistDosage As DataList = e.Row.FindControl("ddlFrequencyList")
            Dim Manager As DbManager = New DbManager()

            datalistDosage.DataSource = Manager.ExecuteDataTable("upsGetFrequencyDetailForDatalist", "TreatmentConnectionString",
                                                                 New SqlParameter() {New SqlParameter("@MedicinrFrequency", hfFrequencyIDs.Value)})
            datalistDosage.DataBind()

            For i As Integer = 0 To datalistDosage.Items.Count - 1

                Dim mnger As DbManager = New DbManager()
                Dim dt As DataTable = mnger.ExecuteDataTable("uspFrquencyList", "TreatmentConnectionString", New SqlParameter() {New SqlParameter("@frequncylistID", hfFrequencyIDs.Value),
                   New SqlParameter("@DeptMedID", hfDeptMedID.Value)})
                If (dt.Rows.Count > 0) Then

                    For j As Integer = 0 To dt.Rows.Count - 1

                        Dim txtbox As TextBox = datalistDosage.Items(j).FindControl("TextBox_dosage2")
                        txtbox.Text = dt.Rows(j)("Dosage").ToString()
                    Next
                End If
                Exit For
            Next
        End If
    End Sub








    Private Sub BindGrid()

        Dim dbManager As DbManager = New DbManager()
        gvdFavouriteMedicine.DataSource = dbManager.ExecuteDataTable("FavouriteMedicineList", "TreatmentConnectionString", New SqlParameter() {})
        gvdFavouriteMedicine.DataBind()
    End Sub


    Protected Sub ddlFrequency_SelectedIndexChanged(sender As Object, e As EventArgs)
        Dim ddl As DropDownList = sender
        Dim row As GridViewRow = ddl.NamingContainer
        Dim DeptMedID As HiddenField = row.FindControl("hfDeptMedID")
        Dim datalistDosage As DataList = row.FindControl("ddlFrequencyList")
        Dim ddlFrequency As DropDownList = row.FindControl("ddlFrequency")

        DeptMedID.Value = "0"


        Dim mnger As DbManager = New DbManager()
        Dim dt As DataTable = mnger.ExecuteDataTable("uspFrquencyList", "TreatmentConnectionString", New SqlParameter() {New SqlParameter("@frequncylistID", ddlFrequency.SelectedValue),
        New SqlParameter("@DeptMedID", "0")})

        datalistDosage.DataSource = dt
        datalistDosage.DataBind()
    End Sub

    Protected Sub btnSaveFavoriteMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim b As String = rd_DrugAllergic.SelectedValue
        Try
            For index = 0 To gvdFavouriteMedicine.Rows.Count - 1

                Dim CheckboxForSelection As CheckBox = gvdFavouriteMedicine.Rows(index).FindControl("chkboxSelect")
                If CheckboxForSelection.Checked = True Then


                    Dim MedicineName As TextBox = gvdFavouriteMedicine.Rows(index).FindControl("txtboxMedicineName")
                    Dim MedicineCode As HiddenField = gvdFavouriteMedicine.Rows(index).FindControl("hfMedCode")
                    Dim ddlRoute As DropDownList = gvdFavouriteMedicine.Rows(index).FindControl("ddlRoute")
                    Dim ddlFrequency As DropDownList = gvdFavouriteMedicine.Rows(index).FindControl("ddlFrequency")
                    'Dim txtboxFrequency As TextBox = gvdFavouriteMedicine.Rows(index).FindControl("TextBox_FrequencyForPreviousMedicine")
                    Dim datalistFrequency As DataList = gvdFavouriteMedicine.Rows(index).FindControl("ddlFrequencyList")
                    Dim ddlMeal As DropDownList = gvdFavouriteMedicine.Rows(index).FindControl("ddlMeals")
                    Dim txtboxDays As TextBox = gvdFavouriteMedicine.Rows(index).FindControl("txtDays")
                    Dim txtPhysicianNotes As TextBox = gvdFavouriteMedicine.Rows(index).FindControl("physicanNotes")



                    'Dim txtboxInstruction As TextBox = gvdFavouriteMedicine.Rows(index).FindControl("TextBoxInstructionForPreviousMedicine")


                    HiddenField_yearly_no.Value = Convert.ToInt32(Session("YearlyNo"))
                    HiddenField_MedCode.Value = MedicineCode.Value


                    Dim a As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
                    Dim con As SqlConnection = New SqlConnection(a)
                    Dim mycommand As New SqlCommand("Insert_Patient_Prescription_Detail", con)
                    mycommand.CommandType = CommandType.StoredProcedure
                    mycommand.Parameters.AddWithValue("@Yearly_NO", Session("YearlyNo"))
                    mycommand.Parameters.AddWithValue("@Med_Code", MedicineCode.Value)
                    mycommand.Parameters.AddWithValue("@Registration_NO", Session("registrationNo"))
                    mycommand.Parameters.AddWithValue("@Route_ID", ddlRoute.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Dilution", "")
                    mycommand.Parameters.AddWithValue("@Meal", ddlMeal.SelectedValue)
                    mycommand.Parameters.AddWithValue("@Frequency_ID", ddlFrequency.SelectedValue)
                    mycommand.Parameters.AddWithValue("@days", txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@Instruction", txtPhysicianNotes.Text.ToString())
                    mycommand.Parameters.AddWithValue("@StartDate", DateTime.Now)

                    Dim d As String = DateTime.Now.Date.AddDays(txtboxDays.Text)
                    mycommand.Parameters.AddWithValue("@EndDate", d)
                    mycommand.Parameters.AddWithValue("@Dose", "")
                    mycommand.Parameters.AddWithValue("@Dosage", "")
                    mycommand.Parameters.AddWithValue("@CT", "")
                    mycommand.Parameters.AddWithValue("@Duration", "")
                    mycommand.Parameters.AddWithValue("@Medicine_Advice_Category_ID", "")
                    mycommand.Parameters.AddWithValue("@BeforeMeal", "")
                    mycommand.Parameters.AddWithValue("@AfterMeal", "")
                    mycommand.Parameters.AddWithValue("@MedicineType", "")

                    mycommand.Parameters.AddWithValue("@emp_ID", Session("emp_id"))
                    mycommand.Parameters.Add("@Prescription_Id", SqlDbType.Int)
                    mycommand.Parameters("@Prescription_Id").Direction = ParameterDirection.Output

                    con.Open()
                    mycommand.ExecuteNonQuery()
                    HiddenField_Prescription_Id.Value = mycommand.Parameters("@Prescription_Id").Value
                    con.Close()

                    Update_Confirmation(HiddenField_Prescription_Id.Value)
                    DataList_ConfirmedPrescriptions.DataBind()
                    'LabelMessageMedicine.Text = Label1.Text + " " + " added sussessfully..."

                    GridView_Template_Medicine.DataBind()
                    GridView2.DataBind()
                    'gen_xml(Date.Now)
                    TextBox_dilution.Text = ""
                    TextBox_dosage.Text = "1"
                    Label1.Text = ""
                    DataList_new.DataBind()
                    'DataList_old.DataBind()

                    For i As Integer = 0 To datalistFrequency.Items.Count - 1
                        Dim HF_F_S_Id As HiddenField = datalistFrequency.Items(i).FindControl("Frequency_Sub_ID")
                        HiddenField_Frequency_Sub_Id.Value = HF_F_S_Id.Value
                        Dim TextBox_dosage1 As TextBox = datalistFrequency.Items(i).FindControl("TextBox_dosage2")
                        HiddenField_DL_Dosage.Value = TextBox_dosage1.Text
                        HiddenField_priscription_id.Value = HiddenField_Prescription_Id.Value
                        Try
                            SqlDataSource_Frequency_detail.Insert()
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        End Try
                    Next
                End If
            Next

            DataList_ConfirmedPrescriptions.DataBind()
            getPatientPreviousMedicine()
            lblFavouriteMessage.Visible = True
        Catch ex As Exception
            Response.Write(ex.Message)
            lblMsg.Visible = False
            lblFavouriteMessage.Text = "Some thing Went Wrong"
        End Try
    End Sub

    Protected Sub rd_DrugAllergic_SelectedIndexChanged(sender As Object, e As EventArgs)

        If rd_DrugAllergic.SelectedValue = "1" Then
            TextBox_specificMedicineAllergic.Enabled = True
            txt_Other.Enabled = True

        Else
            TextBox_specificMedicineAllergic.Enabled = False
            txt_Other.Enabled = False

        End If
    End Sub

End Class
