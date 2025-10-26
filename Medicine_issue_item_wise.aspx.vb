Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports System.Globalization
Imports System.DBNull
Imports System


Partial Class Medicine_issue_item_wise
    Inherits System.Web.UI.Page

    Dim total_Stock As Integer = 0
    Dim no As Integer = 0
    Dim unit_amount As Double
    Dim Vou_main_Id As String
    Dim qty_Remain As Integer
    Dim ENC As New Encryption
    Dim constring1 As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim constr As String = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
    Dim constr_Basic As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim constr_Store As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
    Dim constr_Reg As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
    Dim ds As New Store




    Protected Sub DropDownList_Admin_Service_Package_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Admin_Service_Package.SelectedIndexChanged

        Try

            Dim connection As New SqlConnection
            Dim command As New SqlCommand
            Dim reader As SqlDataReader
            connection.ConnectionString = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
            command = connection.CreateCommand
            command.CommandText = " SELECT     Total_Amount FROM         AdminMedicineServicesPackage where AMP_ID= " + DropDownList_Admin_Service_Package.SelectedValue
            connection.Open()
            reader = command.ExecuteReader
            If reader.Read Then
                Label_Amount.Text = (reader.Item(0))
                lblinfo.Visible = True
            End If
            reader.Close()
            connection.Close()
            LoadData()
            'Button1_Click(sender, e)
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub GridViewMedicine_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewMedicine.SelectedIndexChanged
        Try
            lbl_Message.Text = String.Empty

            Dim index As Integer = GridViewMedicine.SelectedIndex
            Using row As GridViewRow = GridViewMedicine.Rows(index)
                Dim hid_med_Code As HiddenField = row.FindControl("HiddenFieldMedCode")
                Dim txt_qty As TextBox = row.FindControl("TextBox_Qty")
                Dim lblBatchQty As Label = row.FindControl("lbl_Batch_Qty")
                Dim lblBatch As Label = row.FindControl("lblBatch")
                Dim lblExpire As Label = row.FindControl("lblExpire")

                If CDbl(txt_qty.Text) <= CDbl(lblBatchQty.Text) Then
                    Dim txtboxDiscount As TextBox = row.FindControl("txtboxDiscount")
                    Dim txt_RPrice As TextBox = row.FindControl("TextBox_RetailPrice")
                    Dim hf_RetailPrice As HiddenField = row.FindControl("HiddenField_RetailPrice")
                    Dim HiddenField_MedName As HiddenField = row.FindControl("HiddenField_MedName")
                    Dim HfIsNarcotic As HiddenField = row.FindControl("HfIsNarcotic")
                    Dim Hf_Sub_ID As HiddenField = row.FindControl("hf_Sub_ID")

                    Dim medName As String = HiddenField_MedName.Value
                    Dim TextBox_RetailPrice As New TextBox

                    TextBox_RetailPrice.Text = txt_RPrice.Text ' hf_RetailPrice.Value
                    HiddenField_MedCode.Value = hid_med_Code.Value
                    If String.IsNullOrEmpty(txt_qty.Text) Then
                        HiddenField_Qty.Value = "-1"
                    Else
                        HiddenField_Qty.Value = txt_qty.Text
                    End If
                    Dim ItemCode = hid_med_Code.Value
                    Label1.Text = ""
                    If (GetNorcoticsMedicines(ItemCode) = True) And txtDoctorName.Text = "" Then
                        Label1.Text = "Please Select Doctor first for Nacotics Medicine"
                    Else
                        If HiddenField_Qty.Value > 0 Then
                            Dim EDate As New Date
                            If Not String.IsNullOrEmpty(lblExpire.Text) Then
                                EDate = CDate(lblExpire.Text)
                            End If
                            Dim date_time As String = DateTime.Now
                            Populate_Temp_Grid(HiddenField_MedCode.Value, medName, lblBatch.Text, HiddenField_Qty.Value, TextBox_RetailPrice.Text, date_time, txtboxDiscount.Text, lblBatchQty.Text, HfIsNarcotic.Value, "", EDate, Hf_Sub_ID.Value)
                            row.BackColor = Drawing.Color.GreenYellow
                            Button_Consumption.Focus()
                            If (GridView_TemP_Test.Rows.Count > 0) Then
                                pnladditions.Visible = True
                            End If

                        Else
                            Dim sb As StringBuilder = New StringBuilder
                            sb.Append("<Script language='javascript' type='text/javascript'>alert('Please Select Medicine Qty');</Script>")
                            Dim t As Type = Me.GetType
                            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                            End If
                            txt_qty.Focus()
                            row.BackColor = Drawing.Color.Coral

                        End If
                    End If

                Else

                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<Script language='javascript' type='text/javascript'>alert(' Medicine Qty Exceed stock..');</Script>")
                    Dim t As Type = Me.GetType
                    If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                        ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                    End If
                    txt_qty.Focus()
                    txt_qty.BackColor = Drawing.Color.Coral
                End If


                TextBox_specificMedicine.Text = String.Empty
                'TextBox_specificMedicine.Focus()
                Button1_Click(sender, e)
            End Using
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub SqlDataSourceInsertMain_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSourceInsertMain.Inserted

    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        If Not String.IsNullOrEmpty(TextBox_Med_Code.Text.Trim()) Then

            Try
                Hf_Med_Of.Value = "i"

                GetMedicineForConsumption()

            Catch ex As Exception
                ' Response.Write(ex.Message)
            End Try

        Else
            Try
                Hf_Med_Of.Value = RadioButtonList_Medicine_OF.SelectedValue

                GetMedicineForConsumption()
                If GridViewMedicine.Rows.Count > 0 And TextBox_specificMedicine.Text <> "" Then
                    Dim txtQty As TextBox = GridViewMedicine.Rows(0).FindControl("TextBox_Qty")
                    txtQty.Focus()
                Else
                    TextBox_specificMedicine.Focus()
                End If

            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
        End If



    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If String.IsNullOrEmpty(Session("dept_Id")) Then
            Response.Redirect("~/Login.aspx")
        End If
        'If Not String.IsNullOrEmpty(Request.QueryString("yearlyno")) Then

        '    isPatient.Style.Remove("display")


        'Else

        '    LoadWIPaient()


        'End If
        If Not IsPostBack Then
            Label1.Text = ""
            GetPatientName()
            If TextBox_PAtient_name.Text = "Walk In Patient  " Then
                TextBox_PAtient_name.Text = String.Empty

                TextBox_PAtient_name.Focus()
            Else

            End If
            'If Request.QueryString("RegNo") = "AKRH-074956-20" Then
            '    TextBox_PAtient_name.Enabled = True
            'Else
            '    TextBox_PAtient_name.Enabled = False
            'End If

            If TextBox_PAtient_name.Text.Trim() = "" Then
                TextBox_PAtient_name.Enabled = True
                'Else
                '    TextBox_PAtient_name.Enabled = False
            End If

            If Not Request.QueryString("IBID") Is Nothing Then
                HfIBID.Value = Request.QueryString("IBID").ToString()
                RadioButtonList_Medicine_OF.SelectedValue = "RQ"
                Hf_Med_Of.Value = "RQ"
                GetMedicineForConsumption()
            End If
            buttonVisibility()
            'getPatientType()
            TextBox_CODNo.Text = Request.QueryString("yearlyno")
            Hf_deptid.Value = Session("dept_id")
            Hf_Subdeptid.Value = Session("subdeptid")
            'DataList_Patient_Consumption.DataBind()

            'Select_Department()
            'If Session("dept_id") = 18 Then
            '    RadioButtonList_Medicine_OF.SelectedValue = "D"
            '    RadioButtonList_Medicine_OF.Enabled = False
            '    DataList_Patient_Consumption.Visible = False
            '    HYLK_Print.Visible = False
            '    'DataList1.Visible = True
            '    'DataList1.DataBind()
            '    ds.Tables("TempMedicine").Clear()
            '    GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
            '    GridView_TemP_Test.DataBind()



            'End If
            GetMedicineForConsumption()
            If Request.QueryString("patienttypeid") = "43" Then
                getInfoAmount()
                divEmployeeLimit.Style.Add(HtmlTextWriterStyle.Display, "block")
            End If

            DropDownList_Admin_Service_Package.DataBind()

        End If

        '  TextBox_specificMedicine.Focus()
    End Sub
    Public Sub getInfoAmount()
        Try

            LblTAmount.Text = "0"
            LblCAmount.Text = "0"
            hdf_LimitId.Value = "0"

            Dim con As SqlConnection = New SqlConnection()
            con.ConnectionString = ConfigurationManager.ConnectionStrings("Pharmacy_ConnectionString").ConnectionString
            con.Open()
            Dim command As SqlCommand = New SqlCommand("usp_GetPharmacyconsumableAmount", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@MRNo", Request.QueryString("RegNo"))
            Dim reader As SqlDataReader = command.ExecuteReader
            If reader.Read Then
                LblTAmount.Text = reader(0).ToString
                LblCAmount.Text = reader(1).ToString
                hdf_LimitId.Value = reader(2).ToString
                LblRAmount.Text = reader(3).ToString
            End If
            con.Close()
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub showreport()
        If RadioButtonList_Medicine_OF.SelectedValue = "P" And GridViewMedicine.Rows.Count > 0 Then
            lnkReport.Visible = True
        Else
            lnkReport.Visible = False
        End If
    End Sub
    <System.Web.Script.Services.ScriptMethod, System.Web.Services.WebMethod>
    Public Shared Function SearchItems(prefixText As String, count As Integer) As List(Of String)
        Dim items As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select top 10 Item_Name,Item_Code From Store_Items I  Where   Item_Name LIKE @Search+'%'   order by Item_Name "
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("Item_Name").ToString(), sdr("Item_Name").ToString()))
        End While
        Return items
    End Function


    Protected Sub GridView_TemP_Test_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.SelectedIndexChanged
        Grid_Delete()
    End Sub

    Protected Sub GridView_TemP_Test_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_TemP_Test.PreRender
        If GridView_TemP_Test.Rows.Count <> 0 Then
            Dim total As Double = 0
            Dim totalQty As Double = 0
            Dim GrosAmount As Double = 0
            Dim discountAMount As Double = 0
            For i As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
                Dim retailPrice As Label = GridView_TemP_Test.Rows(i).FindControl("lbl_total")
                Dim lbl_total As Label = GridView_TemP_Test.Rows(i).FindControl("lbl_Rate")
                Dim lbl_R_total As Label = GridView_TemP_Test.Rows(i).FindControl("lbl_Gross")
                Dim lbl_DiscountAmount As Label = GridView_TemP_Test.Rows(i).FindControl("lbl_DiscountAmount")
                Dim discountPer As Label = GridView_TemP_Test.Rows(i).FindControl("lbl_Discount")
                Dim qty As TextBox = GridView_TemP_Test.Rows(i).FindControl("lbl_Qty")
                lbl_R_total.Text = (Convert.ToDouble(qty.Text) * Convert.ToDouble(retailPrice.Text)).ToString()
                lbl_DiscountAmount.Text = (Convert.ToDouble(lbl_R_total.Text) * Convert.ToDouble(discountPer.Text) / 100).ToString()


                GrosAmount = GrosAmount + Convert.ToDouble(lbl_R_total.Text)
                discountAMount = discountAMount + Convert.ToDouble(lbl_DiscountAmount.Text)
                lbl_total.Text = (Convert.ToDouble(lbl_R_total.Text) - Convert.ToDouble(lbl_DiscountAmount.Text)).ToString()
                total = total + Convert.ToDouble(lbl_total.Text)
                totalQty = totalQty + Convert.ToDouble(qty.Text)
            Next
            Dim qtyTotal As Label = GridView_TemP_Test.FooterRow.FindControl("lblTotalQty")
            qtyTotal.Text = totalQty.ToString("#,##")
            Dim grossTotal As Label = GridView_TemP_Test.FooterRow.FindControl("lblTotalGrossAmount")
            grossTotal.Text = GrosAmount.ToString("#,##")

            Dim totalDiscount As Label = GridView_TemP_Test.FooterRow.FindControl("lbl_TotalDiscountAmount")
            totalDiscount.Text = discountAMount.ToString("#,##")
            Dim netTotal As Label = GridView_TemP_Test.FooterRow.FindControl("lbl_totalSum")
            netTotal.Text = total.ToString("#,##")

            If String.IsNullOrEmpty(txtAddition.Text.Trim()) Then
                txtAddition.Text = "0"
            End If
            If String.IsNullOrEmpty(txtCashReceived.Text.Trim()) Then
                txtCashReceived.Text = "0"
            End If
            If String.IsNullOrEmpty(txtSubtract.Text.Trim()) Then
                txtSubtract.Text = "0"
            End If
            Try
                lblBillTotalAmount.Text = (((Math.Round(total, 0) + Math.Round(Convert.ToDouble(txtAddition.Text), 0))) - Math.Round(Convert.ToDouble(txtSubtract.Text), 0)).ToString()

            Catch ex As Exception

            End Try

            If txtCashReceived.Text = "0" Then
                lblGreatGrandTotal.Text = "0"
            Else
                lblGreatGrandTotal.Text = Math.Round((Convert.ToDouble(txtCashReceived.Text) - Convert.ToDouble(lblBillTotalAmount.Text)), 0).ToString()
            End If
        End If


    End Sub

    Protected Sub Button_Consumption_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Consumption.Click
        'Dim isnarcotics As Label
        'For Each row As GridViewRow In GridView_TemP_Test.Rows

        '    isnarcotics = row.FindControl("lblIsNarcotics")

        '    If (isnarcotics.Text = "True") Then
        '        pnlNarcotics.Visible = True
        '        Return
        '    End If
        'Next
        IssuseItems()

    End Sub

    Private Sub IssuseItems()


        Insert_medicine_complete()

        If no = 0 Then


            If HiddenField_MainId.Value = "0" Then
                lbl_Message.Text = "Some error occured while processing..."
                lbl_Message.Visible = True
            Else
                lbl_Message.Visible = False
                GetMedicineForConsumption()

                GridView_TemP_Test.DataSource = Nothing
                GridView_TemP_Test.DataBind()

                'DataList_Patient_Consumption.DataBind()
                txtSubtract.Text = String.Empty
                txtAddition.Text = String.Empty
                lblBillTotalAmount.Text = String.Empty
                txtCashReceived.Text = String.Empty
                lblGreatGrandTotal.Text = String.Empty

                Dim sb As New StringBuilder()
                sb.Append("<script type = 'text/javascript'>")
                sb.Append("window.open('")
                sb.Append("Pharmacy/Consumed_Medicine_Report.aspx?C_ID=" + HiddenField_MainId.Value)
                sb.Append("');")
                sb.Append("</script>")



                ClientScript.RegisterStartupScript(Me.[GetType](), "script", sb.ToString())
            End If
        End If

    End Sub


    Protected Sub RadioButtonList_Medicine_OF_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Medicine_OF.SelectedIndexChanged
        If RadioButtonList_Medicine_OF.SelectedValue = "D" Then

            pkg.Visible = False
            med.Visible = True
            medc.Visible = True
            Hf_Med_Of.Value = "d"
            HYLK_Print.Visible = False
            Clear_Tem_Grid()
        ElseIf RadioButtonList_Medicine_OF.SelectedValue = "P" Then


            pkg.Visible = False
            med.Visible = True
            medc.Visible = True

            Hf_Med_Of.Value = "p"

            HYLK_Print.Visible = True
            GetMedicineForConsumption()
            showreport()
        ElseIf RadioButtonList_Medicine_OF.SelectedValue = "PK" Then

            pkg.Visible = True
            med.Visible = False
            medc.Visible = False
            Hf_Med_Of.Value = "PK"
            GetMedicineForConsumption()
            LoadPackages()
        ElseIf RadioButtonList_Medicine_OF.SelectedValue = "RQ" Then

            pkg.Visible = False
            med.Visible = True
            medc.Visible = True
            Hf_Med_Of.Value = "RQ"

            GetMedicineForConsumption()

        End If


    End Sub

    Protected Sub Button_Print_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Print.Click
        Dim sb As StringBuilder = New StringBuilder
        sb.Append("<Script language='javascript' type='text/javascript'>window.open('Consumed_Medicine_Rpt.aspx');</Script>")
        Dim t As Type = Me.GetType
        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
        End If
    End Sub

    Function Alread_Inserted(ByVal MedCode As String, ByVal MedName As String, ByVal BatchNO As String, ByVal Qty As String, ByVal Rate As String, ByVal Date_Time As String, ByVal discnt As Double, ByVal Sub_ID As Int64) As Boolean
        Dim f As Boolean = False
        Dim Mcode As Label = New Label
        Dim Mqty As TextBox = New TextBox
        Dim Mbatch As Label = New Label
        Dim Mrate As Label = New Label
        Dim discount As Label = New Label
        Dim hfsub_id As HiddenField = New HiddenField
        Dim subid As Int64
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            Mcode = GridView_TemP_Test.Rows(x).FindControl("lbl_CODE")
            Mqty = GridView_TemP_Test.Rows(x).FindControl("lbl_Qty")
            Mbatch = GridView_TemP_Test.Rows(x).FindControl("lbl_Batch")
            Mrate = GridView_TemP_Test.Rows(x).FindControl("lbl_total")
            discount = GridView_TemP_Test.Rows(x).FindControl("lbl_Discount")
            hfsub_id = GridView_TemP_Test.Rows(x).FindControl("hf_sub_id")

            subid = Convert.ToInt64(hfsub_id.Value)
            If (Mcode.Text = MedCode) And (BatchNO = Mbatch.Text) And (subid = Sub_ID) Then
                f = True
                Exit For
            End If
        Next

        Return f
    End Function

    Sub Select_Department()
        Dim con As SqlConnection = New SqlConnection(constr_Store)
        Dim command As SqlCommand = New SqlCommand("SELECT TOP (1) Issue_To_Dept_Id FROM Store_Item_Issue_Main WHERE (YearlyNo = @YearlyNo) order by Store_Item_Issue_Id desc", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@YearlyNo", TextBox_CODNo.Text)
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
        End If
        con.Close()
    End Sub
    Sub Populate_Temp_Grid(ByVal MedCode As String, ByVal MedName As String, ByVal BatchNO As String, ByVal Qty As String, ByVal Rate As String, ByVal Date_Time As String, ByVal dicount As String, ByVal Stock As String, ByVal IsNarcotics As String, ByVal NarcoticDetails As String, ByVal Exp_Date As DateTime, ByVal Sub_ID As Int64)

        Dim total As Label = New Label
        Dim Mcode As Label = New Label
        Dim MName As Label = New Label
        Dim MBatch As Label = New Label
        Dim MQty As TextBox = New TextBox
        Dim Dscnt As Label = New Label
        Dim MRate As Label = New Label
        Dim datetime As HiddenField = New HiddenField
        Dim GrossAmount As Label = New Label
        Dim DiscountAmount As Label = New Label
        Dim hdfStock As Label = New Label
        Dim lblIsNarcotics As Label = New Label
        Dim lblNarcoticsDetails As Label = New Label
        Dim lblEDate As Label = New Label
        Dim hf_sub_id As HiddenField = New HiddenField


        Dim row As DataRow

        ds.Tables("TempMedicine").Clear()
        ds.Tables("TempMedicine").Columns.Add("Discount")
        ds.Tables("TempMedicine").Columns.Add("GrossAmount")
        ds.Tables("TempMedicine").Columns.Add("DiscountAmount")
        ds.Tables("TempMedicine").Columns.Add("NetAmount")
        ds.Tables("TempMedicine").Columns.Add("IsNarcotics")
        ds.Tables("TempMedicine").Columns.Add("NarcoticsDetails")
        ds.Tables("TempMedicine").Columns.Add("ExpiryDate")
        ds.Tables("TempMedicine").Columns.Add("Sub_ID")
        ds.Tables("TempMedicine").Columns.Add("Stock")

        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1

            row = ds.Tables("TempMedicine").NewRow
            Mcode = GridView_TemP_Test.Rows(x).FindControl("lbl_CODE")
            row.Item("MedCode") = Mcode.Text

            MName = GridView_TemP_Test.Rows(x).FindControl("lbl_med")
            row.Item("MedName") = MName.Text.Replace("&quot;", """")

            MBatch = GridView_TemP_Test.Rows(x).FindControl("lbl_Batch")
            row.Item("BatchNO") = MBatch.Text ' GridView_TemP_Test.Rows(x).Cells(3).Text

            MQty = GridView_TemP_Test.Rows(x).FindControl("lbl_Qty")
            row.Item("Qty") = CInt(MQty.Text)

            Dscnt = GridView_TemP_Test.Rows(x).FindControl("lbl_Discount")
            row.Item("Discount") = Convert.ToDouble(Dscnt.Text)

            GrossAmount = GridView_TemP_Test.Rows(x).FindControl("lbl_Gross")
            row.Item("GrossAmount") = Convert.ToDouble(GrossAmount.Text)


            DiscountAmount = GridView_TemP_Test.Rows(x).FindControl("lbl_DiscountAmount")
            row.Item("DiscountAmount") = Convert.ToDouble(DiscountAmount.Text)

            Dim netamount As Label = GridView_TemP_Test.Rows(x).FindControl("lbl_Rate")
            row.Item("NetAmount") = Convert.ToDouble(netamount.Text)

            hf_sub_id = GridView_TemP_Test.Rows(x).FindControl("hf_sub_id")
            row.Item("Sub_ID") = Convert.ToDouble(hf_sub_id.Value)

            MRate = GridView_TemP_Test.Rows(x).FindControl("lbl_Rate")

            'Dim totalprice As Double = Convert.ToDouble(Dscnt.Text / 100) * Convert.ToDouble(MRate.Text)



            'row.Item("Rate") = totalprice.ToString() * Convert.ToDouble(Rate) 'GridView_TemP_Test.Rows(x).Cells(5).Text

            row.Item("Rate") = MRate.Text



            total = GridView_TemP_Test.Rows(x).FindControl("lbl_total")
            row.Item("Total") = total.Text

            datetime = GridView_TemP_Test.Rows(x).FindControl("hf_datetime")
            row.Item("Date_Time") = datetime.Value

            lblEDate = GridView_TemP_Test.Rows(x).FindControl("lbl_ExpDate")
            row.Item("ExpiryDate") = lblEDate.Text

            hdfStock = GridView_TemP_Test.Rows(x).FindControl("lbl_Stock")
            row.Item("Stock") = hdfStock.Text

            lblIsNarcotics = GridView_TemP_Test.Rows(x).FindControl("lblIsNarcotics")
            row.Item("IsNarcotics") = lblIsNarcotics.Text

            lblNarcoticsDetails = GridView_TemP_Test.Rows(x).FindControl("lblNarcoticsDetails")
            row.Item("NarcoticsDetails") = lblNarcoticsDetails.Text

            ds.Tables("TempMedicine").Rows.Add(row)
            'ds.Tables("TempMedicine").Columns.Add("Discount")
        Next
        If Not Alread_Inserted(MedCode, MedName, BatchNO, Qty, Rate, Date_Time, Convert.ToDouble(dicount), Sub_ID) Then

            row = ds.Tables("TempMedicine").NewRow
            row.Item("MedCode") = MedCode
            row.Item("MedName") = MedName.Trim
            row.Item("BatchNO") = BatchNO
            row.Item("Qty") = Qty

            Dim discountAmnt As Double = ((Convert.ToDouble((dicount * Rate) / 100) * Qty))
            row.Item("DiscountAmount") = discountAmnt
            row.Item("Rate") = (discountAmnt * Qty)
            row.Item("Discount") = dicount
            row.Item("Total") = Rate
            row.Item("Date_Time") = Date_Time
            row.Item("GrossAmount") = Rate * Qty
            row.Item("NetAmount") = (Rate * Qty) - discountAmnt
            row.Item("ExpiryDate") = Exp_Date


            row.Item("IsNarcotics") = IsNarcotics
            row.Item("NarcoticsDetails") = NarcoticDetails


            row.Item("Sub_ID") = Sub_ID
            row.Item("Stock") = Stock

            ds.Tables("TempMedicine").Rows.Add(row)
        Else
            'Print already inserted
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<Script language='javascript' type='text/javascript'>alert('Already inserted');</Script>")
            Dim t As Type = Me.GetType
            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            End If
        End If
        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
        GridView_TemP_Test.DataBind()

        Dim dv As DataView = ds.Tables("TempMedicine").DefaultView
        dv.RowFilter = "IsNarcotics = True"


        grdNarcotics.DataSource = dv.ToTable()
        grdNarcotics.DataBind()
        Try

        Catch ex As Exception

        End Try

    End Sub



    Sub GetMedicineForConsumption()
        Dim objDbManager As DbManager = New DbManager


        Dim sqlParams As SqlParameter() =
            {
                New SqlParameter("@amsp_id", DropDownList_Admin_Service_Package.SelectedValue),
                New SqlParameter("@mgname", TextBox_specificMedicine.Text),
                New SqlParameter("@medkind", RadioButtonList_medkind.SelectedValue),
                New SqlParameter("@Dept_Id", Session("dept_id")),
                New SqlParameter("@SubDept_Id", Session("SubDeptID")),
                New SqlParameter("@Medicine_OF", Hf_Med_Of.Value),
                New SqlParameter("@yearly_No", Request.QueryString("yearlyno")),
                New SqlParameter("@Reg_No", Request.QueryString("RegNo")),
                New SqlParameter("@med_Code", TextBox_Med_Code.Text),
                New SqlParameter("@Patient_Type_Id", Request.QueryString("patienttypeid")),
                New SqlParameter("@IBID", HfIBID.Value)
           }
        GridViewMedicine.DataSource = objDbManager.ExecuteDataTable("Select_Medicine_For_PharmacyBatch", "STOREConnectionString", sqlParams)
        GridViewMedicine.DataBind()
    End Sub


    Protected Sub insert_Bill(ByVal Amount As Integer)

        Dim con As SqlConnection = New SqlConnection(constr_Basic)
        Dim qry As String = "Insert_Patient_Bill"
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.CommandType = CommandType.StoredProcedure
        command.Parameters.AddWithValue("@RegNo", Convert.ToString(Session("registrationNo")))
        command.Parameters.AddWithValue("@YearlyNo", Convert.ToInt32(Session("YearlyNo")))
        command.Parameters.AddWithValue("@empid", Session("Emp_ID"))
        command.Parameters.AddWithValue("@Amount", Amount)
        command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))
        command.Parameters.AddWithValue("@SubDept_ID", Session("SubDeptID"))
        command.Parameters.AddWithValue("@S_ID", 1387)
        command.Parameters.Add("@PS_ID", SqlDbType.Int)
        command.Parameters("@PS_ID").Direction = ParameterDirection.Output

        con.Open()
        command.ExecuteNonQuery()
        HF_PS_ID.Value = command.Parameters("@PS_ID").Value
        con.Close()

    End Sub





    Public Function IsIPD() As Boolean
        Dim Result As Boolean = False
        Try
            Dim Statment As String = "Select convert(bit,Case When Patient_Type like '%IPD%' THEN 1 ELSE 0 END) as IsIPD FROM Payment where RegNo = @regNo AND PayID = @PayID"
            Dim con As SqlConnection = New SqlConnection(constr_Store)
            Dim command As SqlCommand = New SqlCommand(Statment, con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@regNo", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@PayID", Session("YearlyNo"))
            con.Open()
            Result = command.ExecuteScalar
            con.Close()

        Catch ex As Exception

        End Try
        Return Result

    End Function
    Sub Grid_Delete()
        Dim ds As New Store
        ds.Tables("TempMedicine").Columns.Add("Discount")
        ds.Tables("TempMedicine").Columns.Add("GrossAmount")
        ds.Tables("TempMedicine").Columns.Add("DiscountAmount")
        ds.Tables("TempMedicine").Columns.Add("NetAmount")
        ds.Tables("TempMedicine").Columns.Add("IsNarcotics")
        ds.Tables("TempMedicine").Columns.Add("NarcoticsDetails")
        ds.Tables("TempMedicine").Columns.Add("Sub_ID")
        ds.Tables("TempMedicine").Columns.Add("ExpiryDate")
        ds.Tables("TempMedicine").Columns.Add("Stock")
        Dim row As DataRow
        Dim total As Label = New Label
        Dim Mcode As Label = New Label
        Dim MName As Label = New Label
        Dim MBatch As Label = New Label
        Dim MQty As TextBox = New TextBox
        Dim MRate As Label = New Label
        Dim discountAmount As Label = New Label
        Dim grssamount As Label = New Label
        Dim netamount As Label = New Label
        Dim datetime As HiddenField = New HiddenField
        Dim lblIsNarcotics As Label = New Label
        Dim lblNarcoticsDetails As Label = New Label
        Dim Sub_ID As HiddenField = New HiddenField
        Dim lblExpiryDate As Label = New Label
        Dim lbl_Stock As Label = New Label

        ds.Tables("TempMedicine").Clear()
        For x As Integer = 0 To GridView_TemP_Test.Rows.Count - 1
            If GridView_TemP_Test.SelectedIndex = x Then
                Continue For
            End If
            row = ds.Tables("TempMedicine").NewRow
            Mcode = GridView_TemP_Test.Rows(x).FindControl("lbl_CODE")
            row.Item("MedCode") = Mcode.Text

            MName = GridView_TemP_Test.Rows(x).FindControl("lbl_med")
            row.Item("MedName") = MName.Text.Replace("&quot;", """")

            MBatch = GridView_TemP_Test.Rows(x).FindControl("lbl_Batch")
            row.Item("BatchNO") = MBatch.Text ' GridView_TemP_Test.Rows(x).Cells(3).Text

            MQty = GridView_TemP_Test.Rows(x).FindControl("lbl_Qty")
            row.Item("Qty") = CInt(MQty.Text)



            grssamount = GridView_TemP_Test.Rows(x).FindControl("lbl_Gross")
            row.Item("GrossAmount") = CInt(grssamount.Text)




            discountAmount = GridView_TemP_Test.Rows(x).FindControl("lbl_DiscountAmount")
            row.Item("DiscountAmount") = CInt(discountAmount.Text)


            'discountAmount = GridView_TemP_Test.Rows(x).FindControl("lbl_Qty")
            'row.Item("DiscountAmount") = CInt(discountAmount.Text)

            netamount = GridView_TemP_Test.Rows(x).FindControl("lbl_Rate")
            row.Item("NetAmount") = netamount.Text 'GridView_TemP_Test.Rows(x).Cells(5).Text

            total = GridView_TemP_Test.Rows(x).FindControl("lbl_total")
            row.Item("Total") = total.Text

            Dim discount As Label = GridView_TemP_Test.Rows(x).FindControl("lbl_Discount")
            row.Item("Discount") = discount.Text

            datetime = GridView_TemP_Test.Rows(x).FindControl("hf_datetime")
            row.Item("Date_Time") = datetime.Value

            Sub_ID = GridView_TemP_Test.Rows(x).FindControl("hf_sub_id")
            row.Item("Sub_ID") = Sub_ID.Value

            lblIsNarcotics = GridView_TemP_Test.Rows(x).FindControl("lblIsNarcotics")
            row.Item("IsNarcotics") = lblIsNarcotics.Text

            lblNarcoticsDetails = GridView_TemP_Test.Rows(x).FindControl("lblNarcoticsDetails")
            row.Item("NarcoticsDetails") = lblNarcoticsDetails.Text

            lblExpiryDate = GridView_TemP_Test.Rows(x).FindControl("lbl_ExpDate")
            row.Item("ExpiryDate") = lblExpiryDate.Text
            lbl_Stock = GridView_TemP_Test.Rows(x).FindControl("lbl_Stock")
            row.Item("Stock") = lbl_Stock.Text

            ds.Tables("TempMedicine").Rows.Add(row)
        Next
        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
        GridView_TemP_Test.DataBind()
    End Sub

    Protected Sub Btn_Bill_Click(sender As Object, e As System.EventArgs) Handles Btn_Bill.Click
        If GridView_TemP_Test.Rows.Count > 0 Then
            Dim total As String = GridView_TemP_Test.FooterRow.Cells(6).Text
            If Not String.IsNullOrEmpty(total) Or total <> "0" Then
                lbl_Message.Text = String.Empty
                'Insert_Consumption()
                ' insert_Bill(total  
                Insert_ADDToBillConsumption()
                Clear_Tem_Grid()
                lbl_Message.Text = "Added to Bill ..."
                DataList_Patient_Consumption.DataBind()
                Dim sb As New StringBuilder()
                sb.Append("<script type = 'text/javascript'>")
                sb.Append("window.open('")
                sb.Append("Pharmacy/Consumed_Medicine_Report.aspx?C_ID=" + HiddenField_MainId.Value)
                sb.Append("');")
                sb.Append("</script>")

                ClientScript.RegisterStartupScript(Me.[GetType](), "script", sb.ToString())
            Else
                lbl_Message.Text = "Please Select The medicine.."
            End If

        End If


    End Sub

    Protected Sub Insert_Consumption()
        Try
            Dim count As Integer = 0
            Dim flag As Int32 = 0
            Dim main_ID As Int64
            Dim Consumed As New Store_Consumed

            If GridView_TemP_Test.Rows.Count > 0 Then
                main_ID = Consumed.Insert_Main_WIPatient(Convert.ToInt32(Session("Emp_ID")), Convert.ToInt32(Hf_deptid.Value), Convert.ToInt32(Hf_Subdeptid.Value), Convert.ToInt32(Session("ShiftID")), Convert.ToInt32(Session("YearlyNo")), Convert.ToString(Session("RegistrationNo")), TextBox_PAtient_name.Text.Trim())
            End If


            For Each row As GridViewRow In GridView_TemP_Test.Rows
                Dim code As Label = row.FindControl("lbl_CODE")
                Dim qty As Label = row.FindControl("lbl_Qty")
                Dim batch As Label = row.FindControl("lbl_Batch")
                Dim rate As Label = row.FindControl("lbl_Rate")
                Dim total As Label = row.FindControl("lbl_total")

                Dim TextBox_Consumed As String = qty.Text
                Dim HiddenField_Item_Code As String = code.Text
                Dim BatchNo As String = batch.Text
                Dim Pt_Charge_Consumption As String = total.Text
                If TextBox_Consumed <> "0" Then
                    Try
                        'unit_amount = Consumed.item_Amount(HiddenField_Item_Code, Convert.ToInt32(Hf_deptid.Value), Convert.ToInt32(Hf_Subdeptid.Value))
                        unit_amount = rate.Text
                        HiddenFieldBatchNo.Value = BatchNo
                        Consumed.Insert_Sub_Patient(main_ID, Convert.ToString(HiddenField_Item_Code), Convert.ToString(HiddenFieldBatchNo.Value), Convert.ToDouble(TextBox_Consumed), unit_amount * Convert.ToDouble(TextBox_Consumed), Pt_Charge_Consumption)
                        insert_Bill(total.Text)
                    Catch ex As Exception
                        unit_amount = 0
                    End Try

                End If

            Next


            HiddenField_MainId.Value = main_ID

        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Btn_Medication_Click(sender As Object, e As System.EventArgs) Handles Btn_Medication.Click
        Pnl_Medication.Visible = True
        DataList_ConfirmedPrescriptions.DataBind()

    End Sub

    Protected Sub Btn_Close_Click(sender As Object, e As System.EventArgs) Handles Btn_Close.Click
        Pnl_Medication.Visible = False
    End Sub
    Protected Sub Clear_Tem_Grid()
        ds.Tables("TempMedicine").Clear()
        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
        GridView_TemP_Test.DataBind()
        GetMedicineForConsumption()
    End Sub





    Protected Sub Btn_loadWI_Click(sender As Object, e As System.EventArgs) Handles Btn_loadWI.Click
        LoadWIPaient()
        Response.Redirect("Medicine_issue_item_wise.aspx?RegNo=MH-000673-20&yearlyno=100694&patienttypeid=1")
    End Sub

    Protected Sub Insert_medicine_complete()
        Dim Total_amount As Label = GridView_TemP_Test.FooterRow.FindControl("lbl_totalSum")

        Dim Med_Record As String = "<table>"
        For Each row As GridViewRow In GridView_TemP_Test.Rows
            Dim stok As Label = row.FindControl("lbl_Stock")
            Dim qty As TextBox = row.FindControl("lbl_Qty")

            If CDbl(qty.Text) <= CDbl(stok.Text) Then
              
            Dim code As Label = row.FindControl("lbl_CODE")
            Dim batch As Label = row.FindControl("lbl_Batch")
            Dim rate As Label = row.FindControl("lbl_total")
            Dim total As Label = row.FindControl("lbl_Rate")
            Dim DISPER As Label = row.FindControl("lbl_Discount")
            Dim DISAMOUNT As Label = row.FindControl("lbl_DiscountAmount")
            Dim NarcoticsDetails As Label = row.FindControl("lblNarcoticsDetails")
            Dim ExpDate As Label = row.FindControl("lbl_ExpDate")
            Dim SubID As HiddenField = row.FindControl("Hf_Sub_ID")
            Dim EDate As String = CDate(ExpDate.Text).ToString("MM/dd/yyyy").Replace("0001", "1900")
            Med_Record = Med_Record + "<row><item_code>" + code.Text + "</item_code><qty>" + qty.Text + "</qty><batch>" + batch.Text + "</batch><EDate>" + EDate + "</EDate><SubID>" + SubID.Value + "</SubID><rate>" + rate.Text + "</rate><Dis_amount>" + DISAMOUNT.Text + "</Dis_amount><Dis_per>" + DISPER.Text + "</Dis_per><total>" + total.Text + "</total><narcoticsDetails>" + NarcoticsDetails.Text + "</narcoticsDetails></row>"
            Else
                no = 1
          
            End If
        Next
        If no = 0 Then


            Med_Record = Med_Record + "</table>"
            Dim subtract As Decimal = 0
            Dim add As Decimal = 0
            Dim TAmount As Decimal = 0
            If Not String.IsNullOrWhiteSpace(txtSubtract.Text.Trim()) Then
                subtract = Convert.ToDecimal(txtSubtract.Text.Trim())
            Else
                subtract = 0
            End If
            If Not String.IsNullOrWhiteSpace(txtAddition.Text.Trim()) Then
                add = Convert.ToDecimal(txtAddition.Text.Trim())
            Else
                add = 0
            End If

            If Not String.IsNullOrWhiteSpace(Total_amount.Text.Trim()) Then
                TAmount = Convert.ToDecimal(Total_amount.Text.Replace(",", "").Trim())
            Else
                TAmount = 0
            End If
            Dim dbm As DbManager = New DbManager()
            Dim sp As SqlParameter() = {
                                      New SqlParameter("@Emp_ID", Session("emp_Id")), New SqlParameter("@deptid", Session("dept_id")),
                                      New SqlParameter("@Subdeptid", Session("subdeptid")), New SqlParameter("@ShiftID", Session("shiftid")),
                                      New SqlParameter("@YearlyNo", Request.QueryString("YearlyNo")), New SqlParameter("@RegNo", Request.QueryString("RegNo")),
                                      New SqlParameter("@XML_Sub", Med_Record), New SqlParameter("@Patient_Type_Id", Request.QueryString("patienttypeid")),
                                      New SqlParameter("@IPD_OPD", "OPD"), New SqlParameter("@Billing_Party_Id", "0"),
                                      New SqlParameter("@Payment_Status", "false"), New SqlParameter("@Doctor_ID", "0"),
                                      New SqlParameter("@Hospital_Id", Session("hospitalid")), New SqlParameter("@S_ID", "1387"),
                                      New SqlParameter("@total_Amount", TAmount),
                                      New SqlParameter("@Patient_name", TextBox_PAtient_name.Text.Trim()),
                                     New SqlParameter("@Consumption_Id", SqlDbType.BigInt, 8, ParameterDirection.Output, False, 0, 0, 0, DataRowVersion.Default, 0),
                                      New SqlParameter("@OverAllDiscount", subtract), New SqlParameter("@OverAllAdition", add), New SqlParameter("@DoctorName", txtDoctorName.Text.Trim())
                                         }


            dbm.ExecuteNonQuery("instMedConsBatchWise", "STOREConnectionString", sp)

            HiddenField_MainId.Value = sp(16).Value.ToString()

            'SDS_RECORD.InsertParameters("XML_Sub").DefaultValue = Med_Record
            'SDS_RECORD.InsertParameters("total_Amount").DefaultValue = Total_amount.Text
            'SDS_RECORD.InsertParameters("Patient_name").DefaultValue = TextBox_PAtient_name.Text
            'SDS_RECORD.Insert()
        Else

            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<Script language='javascript' type='text/javascript'>alert(' Medicine Qty Exceed stock..');</Script>")
            Dim t As Type = Me.GetType
            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            End If
           
        End If
     
    End Sub
    Public Sub LoadWIPaient()
        Session("registrationNo") = "MH-000673-20"
        Session("YearlyNo") = "100694"


        'Btn_Bill.Visible = False


        'Dim con As SqlConnection = New SqlConnection(constr_Basic)
        'Dim qry As String = "LoadWIPatient"
        'Dim command As SqlCommand = New SqlCommand(qry, con)
        'command.CommandType = CommandType.StoredProcedure
        'command.Parameters.Add("@RegNo", Data.SqlDbType.VarChar, 200)
        'command.Parameters("@RegNo").Direction = Data.ParameterDirection.Output
        'command.Parameters.Add("@YearlyNo", Data.SqlDbType.Int)
        'command.Parameters("@YearlyNo").Direction = Data.ParameterDirection.Output

        'con.Open()
        'command.ExecuteNonQuery()
        'con.Close()
    End Sub
    Public Sub LoadWIPaient2()
        Session("registrationNo") = "AKRH-074956-20"
        Session("YearlyNo") = "220559"

        'Btn_Bill.Visible = False


        'Dim con As SqlConnection = New SqlConnection(constr_Basic)
        'Dim qry As String = "LoadWIPatient"
        'Dim command As SqlCommand = New SqlCommand(qry, con)
        'command.CommandType = CommandType.StoredProcedure
        'command.Parameters.Add("@RegNo", Data.SqlDbType.VarChar, 200)
        'command.Parameters("@RegNo").Direction = Data.ParameterDirection.Output
        'command.Parameters.Add("@YearlyNo", Data.SqlDbType.Int)
        'command.Parameters("@YearlyNo").Direction = Data.ParameterDirection.Output

        'con.Open()
        'command.ExecuteNonQuery()
        'con.Close()
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
            ' Response.Write(ex.Message)
        End Try

    End Sub
    Private Sub getPatientType()

        Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("select Patient_Type from payment where RegNo=@regno and PayID=@payid", con)
        mycommand.CommandType = Data.CommandType.Text
        'mycommand.Parameters.AddWithValue("@regno", Session("RegistrationNo"))
        'mycommand.Parameters.AddWithValue("@payid", Session("YearlyNo"))
        mycommand.Parameters.AddWithValue("@regno", Request.QueryString("RegNo"))
        mycommand.Parameters.AddWithValue("@payid", Request.QueryString("yearlyno"))

        Dim da As SqlDataAdapter = New SqlDataAdapter(mycommand)
        Dim dt As DataTable = New DataTable()
        da.Fill(dt)

        If dt.Rows.Count > 0 Then
            Dim dtrow As DataRow = CType(dt.Rows(0), DataRow)
            Dim type As String = dtrow(0)

        End If
    End Sub
    Sub GetPatientName()
        Dim con As SqlConnection = New SqlConnection(constr_Reg)
        Dim command As SqlCommand = New SqlCommand("SELECT    ISNULL(Patient.PFName, '')as PFName, IsNull(PMName,'') as PMName, IsNull(PLName,'') as PLName FROM         Patient Where RegNo=@RegNo ", con)
        command.CommandType = CommandType.Text
        ' command.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
        command.Parameters.AddWithValue("@RegNo", Request.QueryString("RegNo"))
        con.Open()
        Dim reader As SqlDataReader = command.ExecuteReader
        If reader.HasRows Then
            reader.Read()
            Dim PFName As String = reader.Item(0)
            Dim PMName As String = reader.Item(1)
            Dim PLName As String = reader.Item(2)
            Dim PatientFullName As String = PFName + " " + PMName + " " + PLName
            TextBox_PAtient_name.Text = PatientFullName
        End If
        con.Close()
    End Sub
    Protected Sub Insert_ADDToBillConsumption()
        Dim Total_amount As Label = GridView_TemP_Test.FooterRow.FindControl("lbl_totalSum")
        Dim Med_Record As String = "<table>"
        For Each row As GridViewRow In GridView_TemP_Test.Rows
            Dim code As Label = row.FindControl("lbl_CODE")
            Dim qty As TextBox = row.FindControl("lbl_Qty")
            Dim batch As Label = row.FindControl("lbl_Batch")
            Dim rate As Label = row.FindControl("lbl_total")
            Dim total As Label = row.FindControl("lbl_Rate")
            Dim DISPER As Label = row.FindControl("lbl_Discount")
            Dim DISAMOUNT As Label = row.FindControl("lbl_DiscountAmount")
            Dim NarcoticsDetails As Label = row.FindControl("lblNarcoticsDetails")
            Med_Record = Med_Record + "<row><item_code>" + code.Text + "</item_code><qty>" + qty.Text + "</qty><batch>" + batch.Text + "</batch><rate>" + rate.Text + "</rate><Dis_amount>" + DISAMOUNT.Text + "</Dis_amount><Dis_per>" + DISPER.Text + "</Dis_per><total>" + total.Text + "</total><narcoticsDetails>" + NarcoticsDetails.Text + "</narcoticsDetails></row>"

        Next
        Med_Record = Med_Record + "</table>"
        Dim subtract As Decimal = 0
        Dim add As Decimal = 0
        If Not String.IsNullOrWhiteSpace(txtSubtract.Text.Trim()) Then
            subtract = Convert.ToDecimal(txtSubtract.Text.Trim())
        Else
            subtract = 0
        End If
        If Not String.IsNullOrWhiteSpace(txtAddition.Text.Trim()) Then
            add = Convert.ToDecimal(txtAddition.Text.Trim())
        Else
            add = 0
        End If
        Dim dbMgr As DbManager = New DbManager()
        Dim sqlParm As SqlParameter() = {New SqlParameter("@Emp_ID", Session("emp_Id")),
                                         New SqlParameter("@deptid", Session("dept_Id")),
                                         New SqlParameter("@Subdeptid", Session("subdeptid")),
                                         New SqlParameter("@ShiftID", Session("shiftid")),
                                         New SqlParameter("@YearlyNo", Request.QueryString("yearlyno")),
                                         New SqlParameter("@RegNo", Request.QueryString("RegNo")),
                                         New SqlParameter("@XML_Sub", Med_Record),
                                         New SqlParameter("@total_Amount", ValidateAmount(Total_amount.Text)),
                                         New SqlParameter("@Patient_name", TextBox_PAtient_name.Text.Trim()),
                                         New SqlParameter("@Consumption_Id", SqlDbType.Int),
                                         New SqlParameter("@IBID", HfIBID.Value),
                                         New SqlParameter("@S_ID", 1387),
                                         New SqlParameter("@OverAllDiscount", subtract),
                                         New SqlParameter("@OverAllAdition", add)}
        sqlParm(9).Direction = ParameterDirection.Output
        dbMgr.ExecuteNonQuery("Insert_medicine_consp_billing_IPD", "STOREConnectionString", sqlParm)
        HiddenField_MainId.Value = sqlParm(9).Value.ToString()
        'insert_Bill(Total_amount.Text)


    End Sub
    Protected Sub TextBoxGridDiscount_TextChanged(sender As Object, e As EventArgs)

        If String.IsNullOrEmpty(TextBoxGridDiscount.Text) Then

            TextBoxGridDiscount.Text = "0"


        End If




        For Each row As GridViewRow In GridView_TemP_Test.Rows

            Dim DISPER As Label = row.FindControl("lbl_Discount")
            DISPER.Text = TextBoxGridDiscount.Text

        Next

        If Page.IsPostBack Then
            TextBoxGridDiscount.Text = "0"
        End If


    End Sub

    Protected Sub GridViewMedicine_PreRender(ByVal sender As Object, ByVal e As EventArgs) Handles GridViewMedicine.PreRender
        Dim dayexp As Integer
       
        For i = 0 To GridViewMedicine.Rows.Count - 1
            Dim exp As Label = CType(GridViewMedicine.Rows(i).FindControl("lblExpire"), Label)
            
            If Not String.IsNullOrEmpty(exp.Text) Then
                Dim iString As String = exp.Text
                Dim now As Date = DateTime.Now.ToString("yyyy-MM-dd")


                Dim format() = {"yyyy-MM-dd"}
                Dim expenddt As Date
                Date.TryParseExact(iString, format,
                    System.Globalization.DateTimeFormatInfo.InvariantInfo,
                  Globalization.DateTimeStyles.None, expenddt)
                dayexp = DateDiff("d", now, expenddt)


                If dayexp > 0 And dayexp <= 30 Then

                    GridViewMedicine.Rows(i).Cells(6).BackColor = System.Drawing.Color.RosyBrown
                ElseIf dayexp < 0 Then

                    GridViewMedicine.Rows(i).Cells(6).BackColor = System.Drawing.Color.Red

                End If
            End If
        Next
    End Sub
    Protected Sub LoadData()


        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select_Medicine_For_PharmacyBatch"
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@amsp_id", DropDownList_Admin_Service_Package.SelectedValue)
        cmd.Parameters.AddWithValue("@mgname", TextBox_specificMedicine.Text)
        cmd.Parameters.AddWithValue("@medkind", RadioButtonList_medkind.SelectedValue)
        cmd.Parameters.AddWithValue("@Dept_Id", Session("dept_id"))
        cmd.Parameters.AddWithValue("@SubDept_Id", Session("SubDeptID"))
        cmd.Parameters.AddWithValue("@Medicine_OF", Hf_Med_Of.Value)
        cmd.Parameters.AddWithValue("@yearly_No", Request.QueryString("yearlyno"))
        cmd.Parameters.AddWithValue("@Reg_No", Request.QueryString("RegNo"))
        cmd.Parameters.AddWithValue("@med_Code", TextBox_Med_Code.Text)
        cmd.Connection = conn
        conn.Open()
        Dim adot As New SqlDataAdapter
        adot.SelectCommand = cmd
        Dim ds As New DataSet
        adot.Fill(ds)


        GridViewMedicine.DataSource = ds.Tables(0)
        GridViewMedicine.DataBind()


    End Sub
    Protected Sub lbl_Amount_Click(sender As Object, e As EventArgs)

        Try
            Dim i As Integer = 0
            For Each Rows As GridViewRow In GridViewMedicine.Rows

                lbl_Message.Text = String.Empty
                Dim hid_med_Code As HiddenField = Rows.FindControl("HiddenFieldMedCode")
                Dim txt_qty As TextBox = Rows.FindControl("TextBox_Qty")
                Dim lblBatchQty As Label = Rows.FindControl("lbl_Batch_Qty")
                If CDbl(txt_qty.Text) <= CDbl(lblBatchQty.Text) Then
                    Dim txtboxDiscount As TextBox = Rows.FindControl("txtboxDiscount")
                    Dim txt_RPrice As TextBox = Rows.FindControl("TextBox_RetailPrice")
                    Dim hf_RetailPrice As HiddenField = Rows.FindControl("HiddenField_RetailPrice")
                    Dim HiddenField_MedName As HiddenField = Rows.FindControl("HiddenField_MedName")
                    Dim Hf_Sub_ID As HiddenField = Rows.FindControl("hf_Sub_ID")

                    Dim medName As String = HiddenField_MedName.Value
                    Dim TextBox_RetailPrice As New TextBox

                    Dim lblIsNarcotics As Label = Rows.FindControl("lblIsNarcotics")
                    Dim lblNarcoticsDetails As Label = Rows.FindControl("lblNarcoticsDetails")

                    TextBox_RetailPrice.Text = txt_RPrice.Text ' hf_RetailPrice.Value
                    HiddenField_MedCode.Value = hid_med_Code.Value
                    If String.IsNullOrEmpty(txt_qty.Text) Then
                        HiddenField_Qty.Value = "-1"
                    Else
                        HiddenField_Qty.Value = txt_qty.Text
                    End If
                    If HiddenField_Qty.Value > 0 Then 'And Check_For_Stock(hid_med_Code.Value) >= 1 

                        Dim date_time As String = DateTime.Now
                        If i = 0 Then


                            ds.Tables("TempMedicine").Clear()
                            ds.Tables("TempMedicine").Columns.Add("Discount")
                            ds.Tables("TempMedicine").Columns.Add("GrossAmount")
                            ds.Tables("TempMedicine").Columns.Add("DiscountAmount")
                            ds.Tables("TempMedicine").Columns.Add("NetAmount")
                            ds.Tables("TempMedicine").Columns.Add("IsNarcotics")
                            ds.Tables("TempMedicine").Columns.Add("NarcoticsDetails")
                            ds.Tables("TempMedicine").Columns.Add("Sub_ID")
                            TextBox_specificMedicine.Text = ""
                            i = i + 1
                        End If
                        Populate_Temp_GridNew(HiddenField_MedCode.Value, medName, HiddenFieldBatchNo.Value, HiddenField_Qty.Value, TextBox_RetailPrice.Text, date_time, txtboxDiscount.Text, Hf_Sub_ID.Value)
                        txt_qty.BackColor = Drawing.Color.GreenYellow
                        Button_Consumption.Focus()


                    Else
                        Dim sb As StringBuilder = New StringBuilder
                        sb.Append("<Script language='javascript' type='text/javascript'>alert('Please Select Medicine Qty');</Script>")
                        Dim t As Type = Me.GetType
                        If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                            ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                        End If
                        txt_qty.Focus()
                        txt_qty.BackColor = Drawing.Color.Coral

                    End If
                Else
                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<Script language='javascript' type='text/javascript'>alert(' Medicine Qty Exceed stock..');</Script>")
                    Dim t As Type = Me.GetType
                    If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                        ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
                    End If
                    txt_qty.Focus()
                    txt_qty.BackColor = Drawing.Color.Coral
                End If



                TextBox_specificMedicine.Focus()
            Next


        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try


    End Sub

    Sub Populate_Temp_GridNew(ByVal MedCode As String, ByVal MedName As String, ByVal BatchNO As String, ByVal Qty As String, ByVal Rate As String, ByVal Date_Time As String, ByVal dicount As String, ByVal Sub_ID As Int64)

        Dim total As Label = New Label
        Dim Mcode As Label = New Label
        Dim MName As Label = New Label
        Dim MBatch As Label = New Label
        Dim MQty As Label = New Label
        Dim Dscnt As Label = New Label
        Dim MRate As Label = New Label
        Dim datetime As HiddenField = New HiddenField
        Dim GrossAmount As Label = New Label
        Dim DiscountAmount As Label = New Label
        Dim hf_sub_id As HiddenField = New HiddenField

        Dim row As DataRow


        If Not Alread_Inserted(MedCode, MedName, BatchNO, Qty, Rate, Date_Time, Convert.ToDouble(dicount), Sub_ID) Then

            row = ds.Tables("TempMedicine").NewRow
            row.Item("MedCode") = MedCode
            row.Item("MedName") = MedName.Trim
            row.Item("BatchNO") = BatchNO
            row.Item("Qty") = Qty
            row.Item("Sub_ID") = Sub_ID

            Dim discountAmnt As Double = ((Convert.ToDouble((dicount * Rate) / 100) * Qty))
            row.Item("DiscountAmount") = discountAmnt
            row.Item("Rate") = (discountAmnt * Qty)
            row.Item("Discount") = dicount
            row.Item("Total") = Rate
            row.Item("Date_Time") = Date_Time
            row.Item("GrossAmount") = Rate * Qty
            row.Item("NetAmount") = (Rate * Qty) - discountAmnt

            ds.Tables("TempMedicine").Rows.Add(row)
        Else
            'Print already inserted
            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<Script language='javascript' type='text/javascript'>alert('Already inserted');</Script>")
            Dim t As Type = Me.GetType
            If Not ClientScript.IsClientScriptBlockRegistered(t, "Popup") Then
                ClientScript.RegisterClientScriptBlock(t, "Popup", sb.ToString())
            End If
        End If
        GridView_TemP_Test.DataSource = ds.Tables("TempMedicine")
        GridView_TemP_Test.DataBind()

        Try


        Catch ex As Exception

        End Try

    End Sub

    Public Sub checkPatientSession()
        Dim val As Boolean = False
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString)
        con.Open()
        Dim query As String = ""
        Dim command As SqlCommand

        If Not txtboxMr.Text.Trim() = "" Then
            query = "select RegNo, PayID,Patient_Type_ID from payment where payment.RegNo='" + txtboxMr.Text + "' and payment.DischargeStatus=0"


            command = New SqlCommand(query, con)
            command.Parameters.AddWithValue("@Regno", txtboxMr.Text.Trim())

        ElseIf Not txtVisitNo.Text.Trim() = "" Then
            query = "select RegNo,PayID,Patient_Type_ID from payment where payment.PayID=" + txtVisitNo.Text + " and payment.DischargeStatus=0"


            command = New SqlCommand(query, con)
            command.Parameters.AddWithValue("@PayID", txtVisitNo.Text.Trim())

        End If



        Dim da As SqlDataAdapter = New SqlDataAdapter(command)
        Dim dt As DataTable = New DataTable()
        If Not txtboxMr.Text.Trim() = "" Or Not txtVisitNo.Text.Trim() = "" Then
            da.Fill(dt)
        End If

        con.Close()

        If dt.Rows.Count > 0 Then
            Session.Add("registrationNo", dt.Rows(0)("RegNo"))
            Session.Add("YearlyNo", dt.Rows(0)("PayID"))
            Session.Add("PayID", dt.Rows(0)("PayID"))

            txtboxMr.Text = dt.Rows(0)("RegNo")
            txtVisitNo.Text = dt.Rows(0)("PayID")
            Response.Redirect("~/Pharmacy/Medicine_issue_item_wise.aspx?RegNo=" + dt.Rows(0)("RegNo").ToString() + "&yearlyno=" + dt.Rows(0)("PayID").ToString() + "&patienttypeid=" + dt.Rows(0)("Patient_Type_ID").ToString())
        End If

    End Sub
    Protected Sub btnSearch_Click(sender As Object, e As EventArgs) Handles btnSearch.Click
        Session.Remove("RegistrationNo")
        Session.Remove("YearlyNo")
        If Not txtboxMr.Text.Trim() = "" Or Not txtVisitNo.Text.Trim() = "" Then
            TextBox_CODNo.Text = ""
            TextBox_PAtient_name.Text = ""
        End If

        checkPatientSession()

    End Sub

    Protected Sub RadioButtonList_medkind_SelectedIndexChanged(sender As Object, e As EventArgs)
        LoadPackages()
    End Sub

    Private Sub LoadPackages()

        Dim con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString)
        con.Open()

        Try
            Dim cmd As New SqlCommand()
            cmd = New SqlCommand("SELECT 0 AS AMP_ID, '' AS MP_Name UNION select AMP_ID,MP_Name from Pharmacy.dbo.AdminMedicineServicesPackage", con)

            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            DropDownList_Admin_Service_Package.DataSource = dt
            DropDownList_Admin_Service_Package.DataTextField = "MP_Name"
            DropDownList_Admin_Service_Package.DataValueField = "AMP_ID"
            DropDownList_Admin_Service_Package.DataSource = dt
            DropDownList_Admin_Service_Package.DataBind()
            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub
    Protected Sub buttonVisibility()
        Try
            Dim dbm As DbManager = New DbManager()
            Dim sp As SqlParameter() = {New SqlParameter("@Patient_type_Id", Request.QueryString("PType"))}
            Dim dt As DataTable = dbm.ExecuteDataTable("uspGetButtonVisibilityByType", "STOREConnectionString", sp)
            If dt.Rows.Count > 0 Then
                'Button_Consumption.Visible = Convert.ToBoolean(dt.Rows(0)("IsIssueVisible").ToString())
                'Btn_Bill.Visible = Convert.ToBoolean(dt.Rows(0)("IsAddVisible").ToString())
                Button_Consumption.Visible = True
                Btn_Bill.Visible = False
            Else
                Button_Consumption.Visible = True
                Btn_Bill.Visible = False
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub btn_CreditPayment_Click(sender As Object, e As EventArgs) Handles btn_CreditPayment.Click
        If GridView_TemP_Test.Rows.Count > 0 Then
            Dim total As String = GridView_TemP_Test.FooterRow.Cells(6).Text
            If Not String.IsNullOrEmpty(total) Or total <> "0" Then
                lbl_Message.Text = String.Empty
                Session.Add("RegistrationNo", Request.QueryString("RegNo"))
                Session.Add("YearlyNo", Request.QueryString("Yearlyno"))
                Session.Add("Patient_Type_ID", Request.QueryString("PatientTypeID"))

                'Insert_Consumption()
                ' insert_Bill(total  
                Insert_ADDToBillConsumption()
                Clear_Tem_Grid()
                lbl_Message.Text = "Forword for Credit Card Payment ..."
                DataList_Patient_Consumption.DataBind()
                Dim sb As New StringBuilder()
                sb.Append("<script type = 'text/javascript'>")
                sb.Append("window.open('")
                sb.Append("Patient Billing/Patient_Payment.aspx?RegNo=" + Request.QueryString("RegNo") + "&Yearlyno=" + Request.QueryString("Yearlyno") + "&PatientTypeID=" + Request.QueryString("PatientTypeID"))
                sb.Append("');")
                sb.Append("</script>")

                ClientScript.RegisterStartupScript(Me.[GetType](), "script", sb.ToString())
            Else
                lbl_Message.Text = "Please Select The medicine.."
            End If

        End If
    End Sub

    Protected Sub btnSaveNarcotics_Click(sender As Object, e As EventArgs)
        Dim lbl_CODE As Label = New Label
        Dim txtDetails As TextBox = New TextBox
        Dim Med_CODE As Label = New Label
        Dim EmptyDetailsCount As Integer = 0
        For Each dgr As GridViewRow In grdNarcotics.Rows
            lbl_CODE = dgr.FindControl("lbl_CODE")
            txtDetails = dgr.FindControl("txtDetails")
            If (txtDetails.Text.Trim() = "") Then
                EmptyDetailsCount = EmptyDetailsCount + 1
            End If

            For Each row As GridViewRow In GridView_TemP_Test.Rows
                Med_CODE = row.FindControl("lbl_CODE")
                Dim lblNarcoticsDetails As Label = TryCast(row.FindControl("lblNarcoticsDetails"), Label)
                If lbl_CODE.Text = Med_CODE.Text Then
                    lblNarcoticsDetails.Text = txtDetails.Text.Trim()
                    Exit For
                End If
            Next
        Next
        If EmptyDetailsCount = 0 Then
            IssuseItems()
            pnlNarcotics.Visible = False
        End If

    End Sub

    Public Function GetNorcoticsMedicines(ByVal ItemCode As String) As Boolean
        Dim constring As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim con As SqlConnection = New Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "usp_GetNorcoticsMedicine"
        Dim mycommand = New Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.CommandText = Procedurename
        mycommand.Parameters.AddWithValue("@ItemCode", ItemCode)
        mycommand.Parameters.Add("@Result", Data.SqlDbType.Int)
        mycommand.Parameters("@Result").Direction = Data.ParameterDirection.Output
        con.Open()
        mycommand.ExecuteNonQuery()
        Dim Result As Integer = Convert.ToInt32(mycommand.Parameters("@Result").Value.ToString())
        mycommand.Connection.Close()

        If Result > 0 Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Function ValidateAmount(amt As String) As String
        Dim Ramount As String = "0"

        If Not String.IsNullOrEmpty(amt) Then
            Ramount = amt.Replace(",", "")
        End If
        Return Ramount
    End Function

    
End Class



