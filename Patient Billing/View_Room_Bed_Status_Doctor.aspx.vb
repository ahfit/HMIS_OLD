Imports System.Data
Imports System.Data.SqlClient
Imports System.Drawing
Partial Class Patient_Billing_View_Room_Bed_Status_Doctor
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

                If Session("emp_id") = "3" Or Session("emp_id") = "1" Or Session("emp_id") = "385" Then
                    btnViewReport.Visible = True
                Else
                    btnViewReport.Visible = False
                End If



                DDL_Department.DataBind()
                DropDownListFloor.DataBind()
                DropDownListFloor.SelectedValue = Session("Subdeptid").ToString()

                If Request.QueryString("dept") <> Nothing And Request.QueryString("floor") <> Nothing Then

                    DDL_Department.SelectedValue = Request.QueryString("dept").ToString()
                    DropDownListFloor.SelectedValue = Request.QueryString("floor").ToString()

                    DDL_Department.Enabled = False
                    DropDownListFloor.Enabled = False

                End If


                get_BedSummary()
                get_BedDetail()

                fillform()
            End If

        Catch ex As Exception
            'Response.Write(ex.Message + "Load")
        End Try
    End Sub


    Protected Sub fillform()
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try

            con.Open()
            cmd = New SqlCommand("Patient_Basic_Info", con)
            cmd.CommandType = CommandType.StoredProcedure

            cmd.Parameters.AddWithValue("@RegNo", "00-00-01")
            cmd.Parameters.AddWithValue("@PayID", 100001)
            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            FormView2.DataSource = dt
            FormView2.DataBind()
        Catch ex As Exception
            con.Close()
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
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Patient Billing/Room_Bed_Status_Report.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repDs As New ReportDataSource
            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)
        Catch ex As Exception
            con.Close()
        End Try

    End Sub

    Protected Sub btnViewData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewData.Click

        pnlGrid.Visible = True
        pnlReport.Visible = False
        get_BedSummary()
        'LoadBedStatusData()
        get_BedDetail()

    End Sub



    Private Sub get_BedSummary()
        Dim cmd As SqlCommand = New SqlCommand()
        Dim con As SqlConnection = New SqlConnection(constr)
        Try
            con.Open()
            cmd = New SqlCommand("usp_BedStatusWardWiseNew", con)
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

    Protected Sub GridViewTest_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridViewTest.RowDataBound
        'If e.Row.RowType = DataControlRowType.DataRow Then

        '    Dim lnkbtnDischarge As LinkButton = e.Row.FindControl("lnkbtnDischarge")
        '    Dim btnForward As LinkButton = e.Row.FindControl("btnForward")

        '    Dim hfDischarge As HiddenField = e.Row.FindControl("hfDischargeButton")
        '    Dim hfForward As HiddenField = e.Row.FindControl("hfForwardButton")

        '    If hfDischarge.Value = False Then
        '        lnkbtnDischarge.Visible = False

        '    End If
        '    If hfForward.Value = False Then
        '        btnForward.Visible = False

        '    End If


        'End If

    End Sub

    Protected Sub lnk_btn_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer


        Session.Remove("RegistrationNo")
        Session.Remove("YearlyNo")


        Session("RegistrationNo") = lk.CommandArgument
        Session("YearlyNo") = lk.ToolTip

        'Response.Redirect("~/Patient%20Billing/ChangeRoomRequest.aspx?RegNo=" + lk.CommandArgument + "&YearlyNo=" + lk.ToolTip)

        Dim contrl As Control = Page.LoadControl("~/Patient Billing/UserControlls/changeRoomRequest.ascx")

        ' placeHolderForm.Controls.Add(contrl)

        pnlChangeRequest.Visible = True

    End Sub



    Protected Sub lnkbtnDischarge_Click(ByVal sender As Object, ByVal e As System.EventArgs)


        Try
            Dim lk As LinkButton = sender
            Dim Row As GridViewRow = lk.NamingContainer

            Dim reg As HiddenField = Row.FindControl("hf_regno")
            Dim yearl As HiddenField = Row.FindControl("Hf_Yearly")
            Dim ward As HiddenField = Row.FindControl("hf_WardID")
            Dim bed As HiddenField = Row.FindControl("hf_BedID")
            Dim floorid As HiddenField = Row.FindControl("hf_FloorID")
            reg11.Value = reg.Value
            yearlyNo.Value = yearl.Value
            wardID.Value = ward.Value
            bedid.Value = bed.Value
            hf_FloorID.Value = floorid.Value
            Panel2.Visible = True

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
            'If Status = "Discharge" Then


            SqlDataSourceUpdate.UpdateParameters("Reg_No").DefaultValue = reg.Value
            SqlDataSourceUpdate.UpdateParameters("Yearly_No").DefaultValue = yearlyNo.Value
            SqlDataSourceUpdate.UpdateParameters("referdoctor").DefaultValue = DropDownList_Company.SelectedValue
            SqlDataSourceUpdate.UpdateParameters("DisStatus").DefaultValue = DropDownList1.SelectedValue
            SqlDataSourceUpdate.UpdateParameters("Remarks").DefaultValue = txtRemarks.Text



            SqlDataSourceUpdate.Update()
            get_BedSummary()
            get_BedDetail()

            ' Else
            'lblmsg.Visible = True
            'End If
        Catch ex As Exception

        End Try

    End Sub


    Protected Sub GridViewTest_PreRender(sender As Object, e As System.EventArgs) Handles GridViewTest.PreRender

        'If DropDownListFloor.SelectedValue = "96" Then
        '    GridViewTest.Columns(10).Visible = True
        'Else
        '    GridViewTest.Columns(10).Visible = False

        'End If

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
                Dim btnForward As LinkButton = GridViewTest.Rows(i).FindControl("btnForward")
                Dim hf_reg_no As HiddenField = GridViewTest.Rows(i).FindControl("hf_regno")

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
                If hf_reg_no.Value = "" Then
                    btnForward.Visible = False
                Else
                    btnForward.Visible = True
                End If




                Dim hfDischarge As HiddenField = GridViewTest.Rows(i).FindControl("hfDischargeButton")
                Dim hfForward As HiddenField = GridViewTest.Rows(i).FindControl("hfForwardButton")

                If Not String.IsNullOrEmpty(hfDischarge.Value) Then

                    If hfDischarge.Value = False Then
                        lnkbtnDischarge.Visible = False

                    End If

                End If

                If Not String.IsNullOrEmpty(hfForward.Value) Then
                    If hfForward.Value = False Then
                        btnForward.Text = "Forwarded"
                        btnForward.Enabled = False
                    Else
                        btnForward.Text = "Forward for Clearance"
                        btnForward.Enabled = True

                    End If
                End If


            Next
            lblTotalDischargeable.Text = Dischargeable_Patients.ToString()
        End If
        'GridViewTest.FooterRow.BackColor = Color.Green
        ' Dim lblGT As Label = GridViewTest.FooterRow.FindControl("lblGT")
        'Dim TB As Label = GridViewTest.FooterRow.FindControl("Bill")
        'Dim TA As Label = GridViewTest.FooterRow.FindControl("Advance")
        'TB.Text = GrandTotal.ToString()
        'TA.Text = GrandAdvanceTotal.ToString().ToString()


    End Sub
    Protected Sub LinkButton_Patient_Click(sender As Object, e As EventArgs)

        Dim linkbtn As LinkButton = sender
        Dim YearlyNo As String = linkbtn.ToolTip 
        Dim reg As String = linkbtn.CommandArgument

        Session.Add("YearlyNo", YearlyNo)
        Session.Add("registrationNo", reg)

        Dim jmenu As JavaScriptMenu = New JavaScriptMenu()
        Dim templateId As String = jmenu.Template_id()
        Response.Redirect("~/pt_EMR/Pt_Presenting_Complaint.aspx")

        'Dim btntemp As LinkButton = DirectCast(sender, LinkButton)
        'Dim sb As New StringBuilder()
        'Dim URL As String = "/pt_EMR/Pt_Presenting_Complaint.aspx?YearlyNo=" + btntemp.ToolTip + " &RegNo=" + btntemp.CommandArgument 'String.Empty
        ''If Session("emp_id") = "3" Or Session("emp_id") = "1" Or Session("emp_id") = "385" Then
        ''    Session("registrationNo") = btntemp.CommandArgument
        ''    Session("YearlyNo") = btntemp.ToolTip
        ''    URL = "PatientRunningBill.aspx?type=1"
        ''Else
        ''    URL = "PatientAdances_ServicesHistory.aspx?YearlyNo=" + btntemp.ToolTip + " &RegNo=" + btntemp.CommandArgument
        ''End If
        'sb.Append("<script language='javascript'>")
        'sb.Append(" window.open('" + URL + "')")
        'sb.Append("</script>")

        'Dim t As Type = Me.[GetType]()
        'If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
        '    ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
        'End If

    End Sub
    Protected Sub lnk_PacKage_Click(sender As Object, e As System.EventArgs)

        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer


        Dim reg As HiddenField = Row.FindControl("hf_regno")
        Dim yearlyNo As HiddenField = Row.FindControl("Hf_Yearly")
        Dim url As String
        url = "../Patient%20Billing/PatientOutStandingBillsDetailReport.aspx?Reg_No=" + lk.CommandArgument + "&Yearly_No=" + lk.ToolTip
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)
        '  Response.Redirect("~/Patient%20Billing/PatientOutStandingBillsDetailReport.aspx?Reg_No=" + lk.CommandArgument + "&Yearly_No=" + lk.ToolTip)
        'Dim URL As String = "~/Patient Billing/Assign_Patient_Package.aspx?regno=" + reg.Value + "&PayID=" + yearlyNo.Value
        'Response.Redirect(URL)
    End Sub


    Protected Sub Button_Report_Click(sender As Object, e As EventArgs)
        Try






            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Patient_Discharge", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@PayID", yearlyNo.Value)
            command.Parameters.AddWithValue("@RegNo", reg11.Value)
            command.Parameters.Add("@Status", SqlDbType.VarChar, 50)
            command.Parameters("@Status").Direction = ParameterDirection.Output
            command.Parameters.Add("@Dept_ID", SqlDbType.VarChar, 50)
            command.Parameters("@Dept_ID").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()

            Dim Status As String = command.Parameters("@Status").Value
            Dim dept As String = command.Parameters("@Dept_ID").Value
            If Status = "Discharge" Then


                SqlDataSourceUpdate.UpdateParameters("Reg_No").DefaultValue = reg11.Value
                SqlDataSourceUpdate.UpdateParameters("Yearly_No").DefaultValue = yearlyNo.Value
                SqlDataSourceUpdate.UpdateParameters("referdoctor").DefaultValue = DropDownList_Company.SelectedValue
                SqlDataSourceUpdate.UpdateParameters("DisStatus").DefaultValue = DropDownList1.SelectedValue
                SqlDataSourceUpdate.UpdateParameters("Remarks").DefaultValue = txtRemarks.Text



                SqlDataSourceUpdate.Update()
                get_BedSummary()
                get_BedDetail()

            Else
                lblmsg.Visible = True
            End If
            Panel2.Visible = False
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub Button_Close_Click(sender As Object, e As EventArgs)
        Panel2.Visible = False
    End Sub
    Protected Sub btnForward_Click(sender As Object, e As EventArgs)
        Dim btn As LinkButton = sender
        Dim db As DbManager = New DbManager()
        Dim param As SqlParameter() = {
            New SqlParameter("@RegNo", btn.CommandArgument),
            New SqlParameter("@YearlyNo", btn.ToolTip)
            }
        db.ExecuteNonQuery("uspForwardforClearance", "Basic_Data_ConnectionString", param)
    End Sub

    Protected Sub btnServicees_Click(sender As Object, e As EventArgs)

        Dim lk As LinkButton = sender
        Dim Row As GridViewRow = lk.NamingContainer
        Session.Remove("RegistrationNo")
        Session.Remove("YearlyNo")


        Session("RegistrationNo") = lk.CommandArgument
        Session("YearlyNo") = lk.ToolTip

        'Dim reg As HiddenField = Row.FindControl("hf_regno")
        'Dim yearlyNo As HiddenField = Row.FindControl("Hf_Yearly")
        Dim url As String
        url = ("../Pharmacy/OT_Services_Page.aspx?RegNo=" + lk.CommandArgument + "&YearlyNo=" + lk.ToolTip)
        Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)

        'url = "/Pharmacy/OT_Services_Page.aspx?regno=" + reg.Value + "&YearlyNo=" + yearlyNo.Value
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)

    End Sub
End Class
