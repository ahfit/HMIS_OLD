Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Partial Class Patient_Billing_Nursing_Room_Bed_Status
    Inherits System.Web.UI.Page
    Dim enc As New Encryption
    Dim floor As String = ""
    Dim userAuthen As New User_page_Authentication
    Dim FillBed As Integer
    Dim EmptyBed As Integer
    Dim TotalBill As Double = 0
    Dim TotalAdvance As Double = 0
    Dim GrandTotal As Double = 0
    Dim GrandAdvanceTotal As Double = 0
    Dim gridRow As GridViewRow
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

    Protected Sub DropDownListFloor_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListFloor.PreRender
        'Try
        '    If Not Page.IsPostBack Then
        '        DropDownListFloor.Items.Insert(0, New ListItem("All", "0"))
        '    End If
        '    Dim ds3 As New DataSet
        '    If DropDownListFloor.SelectedItem.Text = "All" Then
        '        ds3 = Fill_Grid_All()
        '        GridView2.DataSource = ds3.Tables("EmptyBeds").DefaultView
        '        GridView2.DataBind()
        '    Else
        '        ds3 = Fill_Grid(DropDownListFloor.SelectedValue)
        '        GridView2.DataSource = ds3.Tables("EmptyBeds").DefaultView
        '        GridView2.DataBind()
        '    End If
        '    Fill_Room_Bed()
        'Catch ex As Exception

        'End Try
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListFloor.SelectedIndexChanged
        Try
            ' LoadBedStatusData()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.AppendHeader("Refresh", "60")
        Try
            If Not Page.IsPostBack Then
                ReportViewer1.LocalReport.SetBasePermissionsForSandboxAppDomain(AppDomain.CurrentDomain.PermissionSet)

                'If Session("emp_id") = "38" Or Session("emp_id") = "1" Or Session("emp_id") = "385" Then
                '    btnViewReport.Visible = True
                'Else
                '    btnViewReport.Visible = False
                'End If



                DDL_Department.DataBind()
                DropDownListFloor.DataBind()

                If Request.QueryString("dept") <> Nothing And Request.QueryString("floor") <> Nothing Then

                    DDL_Department.SelectedValue = Request.QueryString("dept").ToString()
                    DropDownListFloor.SelectedValue = Request.QueryString("floor").ToString()

                    DDL_Department.Enabled = False
                    DropDownListFloor.Enabled = False

                End If


                get_BedSummary()
                get_BedDetail()


            End If

        Catch ex As Exception
            'Response.Write(ex.Message + "Load")
        End Try
    End Sub



    Protected Sub btnViewReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewReport.Click
        pnlGrid.Visible = False
        pnlReport.Visible = True
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try

            con.Open()
            cmd = New SqlCommand("usp_getRoomBedStatus", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DeptId", DDL_Department.SelectedValue)
            cmd.Parameters.AddWithValue("@Ward_id", DropDownListFloor.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            con.Close()
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Patient Billing/Nursing_Room_Bed_StatusReport.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repDs As New ReportDataSource
            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)
            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
        Catch ex As Exception
            con.Close()
        End Try
    End Sub
    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub


    Protected Sub btnViewData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewData.Click

        pnlGrid.Visible = True
        pnlReport.Visible = False
        get_BedSummary()
        'LoadBedStatusData()
        get_BedDetail()

    End Sub

    Protected Sub lnk_btnMedicine_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer
        Dim URL As String = String.Empty, Yearly_AB As String = String.Empty

        If lk.Text = "Medicine" Then
            URL = "~\Pharmacy\Medicine_Consumption_To_WIPatient.aspx?RegistrationNo="
            Yearly_AB = "&yearlyNo="
        Else
            URL = "~\Nursing\/NurseServices_Page.aspx?regno="
            Yearly_AB = "&PayID="
        End If

        Dim RegNo As String = String.Empty, YearlyNo As String = String.Empty
        Dim reg As HiddenField = Row.FindControl("hf_regno")
        Dim Yearly As HiddenField = Row.FindControl("Hf_Yearly")

        RegNo = enc.Encrypt_Main(reg.Value, True)
        YearlyNo = Yearly.Value
        Try
            URL = URL + RegNo + Yearly_AB
            If Not String.IsNullOrEmpty(YearlyNo) Then
                URL = URL + YearlyNo
            End If


            Session("RegistrationNo") = RegNo
            Session("YearlyNo") = YearlyNo

            Response.Redirect(URL)
        Catch ex As Exception
            Response.Write(URL)
        End Try
    End Sub

    Private Sub get_BedSummary()
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            cmd = New SqlCommand("usp_BedStatusWardWiseNew", con)
            cmd.Parameters.AddWithValue("@SubDeptId", DropDownListFloor.SelectedValue)
            cmd.CommandType = CommandType.StoredProcedure
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            'CbList.DataSource = dt
            'CbList.DataBind()
            dlFloors.DataSource = dt
            dlFloors.DataBind()
            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    Private Sub get_BedDetail()
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            cmd = New SqlCommand("usp_getRoomBedStatus", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@DeptId", DDL_Department.SelectedValue)
            cmd.Parameters.AddWithValue("@Ward_id", DropDownListFloor.SelectedValue)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)



            'Adding blank rows after each Floor
            Dim dt2 As DataTable = New DataTable()
            dt2 = dt.Copy()
            Dim previous As Integer = 0
            Dim nRow As DataRow
            Dim c As Integer = 0
            For Each dr As DataRow In dt.Rows
                If c = 0 Then
                    previous = Convert.ToInt32(dr("ward_id").ToString())
                End If

                If previous <> Convert.ToInt32(dr("ward_id").ToString()) Then
                    nRow = dt2.NewRow()
                    previous = Convert.ToInt32(dr("ward_id").ToString())
                    dt2.Rows.InsertAt(nRow, c)
                    c = c + 1
                End If
                c = c + 1

            Next

            GridViewTest.DataSource = dt2
            GridViewTest.DataBind()
            con.Close()
        Catch ex As Exception
            con.Close()
        End Try
    End Sub

    'Protected Sub GridViewTest_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridViewTest.RowDataBound
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '        If DropDownListFloor.SelectedValue = "96" Then
    '            e.Row.Cells(11).Visible = True
    '        End If

    '    End If

    'End Sub

    Protected Sub lnk_btn_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer
        Dim URL As String = String.Empty, Yearly_AB As String = String.Empty

        If lk.Text = "Panel Bill" Then

            Response.Redirect("~/Patient%20Billing/PanelCompany_BillAdjustment.aspx?RegNo=" + lk.CommandArgument + "&YearlyNo=" + lk.ToolTip)

        ElseIf lk.Text = "Add Limit" Then

            Response.Redirect("~/Patient%20Billing/PanelCompanyCashLimit.aspx?RegNo=" + lk.CommandArgument)

        ElseIf lk.Text = "Take Advance" Then

            Session.Remove("RegistrationNo")
            Session.Remove("YearlyNo")
            Session.Remove("PayID")
            Session.Remove("RegNo")

            Dim reg1 As HiddenField = Row.FindControl("hf_regno")
            Dim Yearly1 As HiddenField = Row.FindControl("Hf_Yearly")
            Session.Add("RegistrationNo", reg1.Value)
            Session.Add("YearlyNo", Yearly1.Value)
            Session.Add("PayID", Yearly1.Value)
            Session.Add("RegNo", reg1.Value)
            URL = "~\Patient Billing\Advance_payment.aspx?regno=" + reg1.Value + "&payid=" + Yearly1.Value
            Response.Redirect(URL)

        Else

            'URL = "~\Nursing\NurseServices_Page.aspx?regno="
            'Yearly_AB = "&PayID="

            URL = "~\Patient Billing\Services_Page.aspx?regno="
            Yearly_AB = "&Payid="
        End If

        Dim RegNo As String = String.Empty, YearlyNo As String = String.Empty
        Dim reg As HiddenField = Row.FindControl("hf_regno")
        Dim Yearly As HiddenField = Row.FindControl("Hf_Yearly")

        RegNo = enc.Encrypt_Main(reg.Value, True)
        YearlyNo = Yearly.Value
        Try
            URL = URL + RegNo + Yearly_AB
            If Not String.IsNullOrEmpty(YearlyNo) Then
                URL = URL + YearlyNo
            End If


            Session("RegistrationNo") = RegNo
            Session("YearlyNo") = YearlyNo

            Response.Redirect(URL)
        Catch ex As Exception
            Response.Write(URL)
        End Try
    End Sub



    Protected Sub lnkbtnDischarge_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lk As LinkButton = sender
        Dim row As GridViewRow = lk.NamingContainer
        HfRowIndex.Value = row.RowIndex
        lblPaitent.Text = lk.CommandName
        panel.Visible = True
        lblSave.Visible = False
        lblmsg.Visible = False
        txtRemarks.Text = ""
        ddlDischargeStatus.SelectedIndex = 0
    End Sub


    Protected Sub GridViewTest_PreRender(sender As Object, e As System.EventArgs) Handles GridViewTest.PreRender

        If GridViewTest.Rows.Count > 0 Then


            Dim colors As Color() = New Color() {Color.Honeydew}
            Dim firstward As Label = GridViewTest.Rows(0).FindControl("lblWardName")
            Dim pWard As String = firstward.Text
            Dim colorIndex As Integer = 0
            Dim serial As Integer = 1
            Dim Dischargeable_Patients As Integer = 0
            For i = 0 To GridViewTest.Rows.Count - 1
                Dim link As LinkButton = GridViewTest.Rows(i).FindControl("LinkButton_Patient")
                Dim Slnk_btn As LinkButton = GridViewTest.Rows(i).FindControl("Slnk_btn")
                Dim wardName As Label = GridViewTest.Rows(i).FindControl("lblWardName")
                Dim lblSerial As Label = GridViewTest.Rows(i).FindControl("lblSerial")
                Dim bill As Label = GridViewTest.Rows(i).FindControl("glblBill")
                Dim Advance As Label = GridViewTest.Rows(i).FindControl("glblAdvance")
                Dim lnkbtnDischarge As LinkButton = GridViewTest.Rows(i).FindControl("lnkbtnDischarge")

                Dim lblTotalBill As Label = GridViewTest.Rows(i).FindControl("lblTotalBill")
                Dim lblTotalAdvance As Label = GridViewTest.Rows(i).FindControl("lblTotalAdvance")
                Dim lblT As Label = GridViewTest.Rows(i).FindControl("lblT")
                'Footer Label
                Dim b As Label = GridViewTest.Rows(i).FindControl("Bill")
                Dim A As Label = GridViewTest.Rows(i).FindControl("Advance")
                Dim Package As LinkButton = GridViewTest.Rows(i).FindControl("lnk_PacKage")
                If Convert.ToInt32(Session("emp_id").ToString()) = 385 Or Convert.ToInt32(Session("emp_id").ToString()) = 3 Or Convert.ToInt32(Session("emp_id").ToString()) = 386 Then
                    'lnkbtnDischarge.Visible = False
                    'Slnk_btn.Visible = False
                    GridViewTest.Columns(11).Visible = False
                    GridViewTest.Columns(12).Visible = False
                    lblTotalDischargeable.Visible = False
                    lblDischargePati.Visible = False
                End If

                If lnkbtnDischarge.ToolTip = "0" Then
                    'lnkbtnDischarge.Visible = False
                ElseIf lnkbtnDischarge.ToolTip <> "" And lnkbtnDischarge.ToolTip <> "0" Then
                    Dischargeable_Patients = Dischargeable_Patients + 1
                End If



                If wardName.Text = "" Then
                    GridViewTest.Rows(i).BackColor = Color.CadetBlue
                    lblT.Visible = True
                    lblTotalBill.Text = TotalBill.ToString()
                    lblTotalBill.Visible = True
                    lblTotalAdvance.Text = TotalAdvance.ToString
                    LabelTotal.Text = GrandTotal.ToString()
                    LabelAdvanceT.Text = GrandAdvanceTotal.ToString()

                    lblTotalAdvance.Visible = True
                    lnkbtnDischarge.Visible = False
                    serial = 0
                    TotalBill = 0
                    TotalAdvance = 0
                    'ElseIf (pWard = wardName.Text Or i = 0) Then
                    '    GridViewTest.Rows(i).BackColor = colors(colorIndex)
                ElseIf wardName.Text <> "" And link.ToolTip = "" Then
                    GridViewTest.Rows(i).BackColor = Color.White
                    lblSerial.Text = serial.ToString()

                ElseIf wardName.Text <> "" Then
                    GridViewTest.Rows(i).BackColor = colors(colorIndex)

                    lblSerial.Text = serial.ToString()
                    'Else
                    '    pWard = wardName.Text
                    '    'colorIndex = colorIndex + 1
                    '    'If colorIndex = colors.Length Then
                    '    '    colorIndex = 0
                    '    'End If
                    '    GridViewTest.Rows(i).BackColor = colors(colorIndex)


                End If

                serial = serial + 1
                If bill.Text = "" Then
                Else
                    TotalBill += Convert.ToDouble(bill.Text)
                    GrandTotal += Convert.ToDouble(bill.Text)
                End If
                If Advance.Text = "" Then
                Else
                    TotalAdvance += Convert.ToDouble(Advance.Text)
                    GrandAdvanceTotal += Convert.ToDouble(Advance.Text)
                End If

                If link.ToolTip = "" Then
                    Slnk_btn.Visible = False
                    Package.Visible = False
                End If

                'If bill.Text <> "" Then
                '    If Convert.ToInt32(bill.Text) >= 100000 Then
                '        GridViewTest.Rows(i).BackColor = Drawing.Color.Coral

                '    End If
                'End If

            Next
            lblTotalDischargeable.Text = Dischargeable_Patients.ToString()

            GridViewTest.FooterRow.BackColor = Color.Green
            Dim lblGT As Label = GridViewTest.FooterRow.FindControl("lblGT")
            Dim TB As Label = GridViewTest.FooterRow.FindControl("Bill")
            Dim TA As Label = GridViewTest.FooterRow.FindControl("Advance")
            TB.Text = GrandTotal.ToString()
            TA.Text = GrandAdvanceTotal.ToString().ToString()

        End If
       

    End Sub
    Protected Sub LinkButton_Patient_Click(sender As Object, e As EventArgs)

        Dim btntemp As LinkButton = DirectCast(sender, LinkButton)
        Dim sb As New StringBuilder()
        Dim URL As String = "PatientRunningBill_New_Latest.aspx?YearlyNo=" + btntemp.ToolTip + " &RegNo=" + btntemp.CommandArgument 'String.Empty
        'If Session("emp_id") = "3" Or Session("emp_id") = "1" Or Session("emp_id") = "385" Then
        '    Session("registrationNo") = btntemp.CommandArgument
        '    Session("YearlyNo") = btntemp.ToolTip
        '    URL = "PatientRunningBill.aspx?type=1"
        'Else
        '    URL = "PatientAdances_ServicesHistory.aspx?YearlyNo=" + btntemp.ToolTip + " &RegNo=" + btntemp.CommandArgument
        'End If
        sb.Append("<script language='javascript'>")
        sb.Append(" window.open('" + URL + "')")
        sb.Append("</script>")

        Dim t As Type = Me.[GetType]()
        If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
            ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        End If

    End Sub
    Protected Sub lnk_PacKage_Click(sender As Object, e As System.EventArgs)

        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer


        Dim reg As HiddenField = Row.FindControl("hf_regno")
        Dim yearlyNo As HiddenField = Row.FindControl("Hf_Yearly")

        Dim URL As String = "~/Nursing/Nursing_Notes.aspx?regno=" + reg.Value + "&PayID=" + yearlyNo.Value
        Response.Redirect(URL)
    End Sub

    Protected Sub savebtnPanel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            'Dim lk As LinkButton = sender
            'Dim Row As GridViewRow = lk.NamingContainer

            Dim reg As HiddenField = GridViewTest.Rows(HfRowIndex.Value).FindControl("hf_regno")
            Dim yearlyNo As HiddenField = GridViewTest.Rows(HfRowIndex.Value).FindControl("Hf_Yearly")
            Dim wardID As HiddenField = GridViewTest.Rows(HfRowIndex.Value).FindControl("hf_WardID")
            Dim bedid As HiddenField = GridViewTest.Rows(HfRowIndex.Value).FindControl("hf_BedID")
            Dim hf_FloorID As HiddenField = GridViewTest.Rows(HfRowIndex.Value).FindControl("hf_FloorID")


            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Patient_Discharge", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@PayID", yearlyNo.Value)
            command.Parameters.AddWithValue("@RegNo", reg.Value)
            command.Parameters.Add("@Status", SqlDbType.VarChar, 50)
            command.Parameters("@Status").Direction = ParameterDirection.Output
            command.Parameters.Add("@Dept_ID", SqlDbType.VarChar, 50)
            command.Parameters("@Dept_ID").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()

            Dim Status As String = command.Parameters("@Status").Value
            Dim dept As String = command.Parameters("@Dept_ID").Value
            If Status = "Discharge" Then


                SqlDataSourceUpdate.UpdateParameters("Reg_No").DefaultValue = reg.Value
                SqlDataSourceUpdate.UpdateParameters("Yearly_No").DefaultValue = yearlyNo.Value

                SqlDataSourceUpdate.Update()
                lblSave.Visible = True
                get_BedSummary()
                get_BedDetail()


            Else
                lblmsg.Visible = True
            End If
        Catch ex As Exception

        End Try
    End Sub

    Protected Sub closebtnPanel_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        panel.Visible = False
        lblSave.Visible = False
        lblmsg.Visible = False
    End Sub



End Class
