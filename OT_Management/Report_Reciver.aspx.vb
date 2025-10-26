Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.SqlClient
Partial Class Report_Reciver
    Inherits System.Web.UI.Page
    Dim b As String
    Dim ENC As New Encryption
    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim counter As Integer = 0
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                If check.Checked = True Then
                    Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                    HiddenField_TG_ID.Value = TG_ID.Value
                    Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")
                    Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                    HiddenField_TBID.Value = TB_ID.Value
                    HiddenField_Main_Id.Value = main_ID.Value
                    counter = counter + 1
                End If
            Next
            If counter > 0 Then

                Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
                Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                Dim mycommand As New System.Data.SqlClient.SqlCommand("Insert_Test_Delivery_Reports_main", con)
                mycommand.CommandType = Data.CommandType.StoredProcedure
                Dim param As System.Data.SqlClient.SqlParameter
                param = mycommand.Parameters.AddWithValue("@First_Name", TextBoxRFName.Text)
                param = mycommand.Parameters.AddWithValue("@Last_Name", TextBoxRMName.Text)
                param = mycommand.Parameters.AddWithValue("@R_First_Name", TextBoxRFFName.Text)
                param = mycommand.Parameters.AddWithValue("@R_Last_Name", TextBoxRFMName.Text)
                param = mycommand.Parameters.AddWithValue("@Relation", RBLrelation.SelectedValue)
                param = mycommand.Parameters.AddWithValue("@CNIC", TextBoxRCINIC.Text)
                param = mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
                param = mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
                param = mycommand.Parameters.Add("@identity", SqlDbType.Int)
                mycommand.Parameters("@identity").Direction = ParameterDirection.Output
                mycommand.Connection.Open()
                mycommand.ExecuteNonQuery()
                Dim identity As Integer = mycommand.Parameters("@identity").Value
                Insert_Test(identity)
                mycommand.Connection.Close()
                'GridView1.DataBind()
                'Printreport1()
                'Response.Redirect("Patient_Search.aspx?def=1.3")
                Dim TCID As Integer = 0
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                    Dim Hid_TCID As HiddenField = GridView1.Rows(i).FindControl("HiddenFieldTCID")
                    If check.Checked = True Then
                        TCID = Hid_TCID.Value
                    End If
                Next
                Response.Write("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "');</script>")
                GridView1.DataBind()
                If GridView1.Rows.Count = 0 Then
                    Response.Redirect("Patient_Search.aspx?def=1.3")
                End If
            Else
                Label_Message.Text = "PLease Select The CheckBox First"
            End If
        Catch ex As Exception
            'Response.Write(ex.Message & "sdfs")
        End Try

    End Sub
    Sub Insert_Test(ByVal Main_ID As Integer)
        Try
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                Dim Hid_TCID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                Dim Hid_TID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTID")
                If check.Checked = True Then
                    'Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
                    'Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
                    'Dim mycommand As New System.Data.SqlClient.SqlCommand("INSERT INTO Report_Reciever_Sub (Main_ID, TID) VALUES (" & Main_ID & "," & Hid_TCID.Value & ")", con)
                    'mycommand.CommandType = Data.CommandType.Text
                    'Dim param As System.Data.SqlClient.SqlParameter
                    'mycommand.Connection.Open()
                    'mycommand.ExecuteNonQuery()
                    HiddenField2.Value = Main_ID 'Hid_TCID.Value
                    HiddenField_TID.Value = Hid_TID.Value
                    SqlDataSource1.Insert()
                    SqlDataSource1.Update()
                    'Response.Write(HiddenField_TG_ID.Value)
                    ' mycommand.Connection.Close()
                End If
            Next
        Catch ex As Exception
            Response.Write(ex.Message & "weqweqw")
        End Try

    End Sub
    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If Page.IsPostBack = False Then
            'GridView1.HeaderRow.Cells(2).Text = "Test Booking ID"
            'GridView1.HeaderRow.Cells(3).Text = "Patient Name"
            'GridView1.HeaderRow.Cells(4).Visible = False
            'GridView1.HeaderRow.Cells(5).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(0).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(0).Text, False)
                GridView1.Rows(i).Cells(3).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(3).Text, False) + " " + ENC.Encrypt_Main(GridView1.Rows(i).Cells(4).Text, False)
                GridView1.Rows(i).Cells(4).Visible = False
                GridView1.Rows(i).Cells(5).Visible = False
            Next
        End If
    End Sub
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then

                If (b = "") Then
                    b = e.Row.Cells.Item(2).Text
                    'Response.Write(e.Row.Cells.Item(4).Text)
                    e.Row.Cells.Item(2).Text = b
                ElseIf b = e.Row.Cells.Item(2).Text Then
                    e.Row.Cells.Item(2).Text = ""
                    e.Row.Cells.Item(2).Text = ""
                Else
                    b = e.Row.Cells.Item(2).Text
                    e.Row.Cells.Item(2).Text = b
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub LinkButtonReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButtonReport.Click

        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                HiddenField_TG_ID.Value = TG_ID.Value
                Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")

                Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                HiddenField_TBID.Value = TB_ID.Value

                HiddenField_Main_Id.Value = main_ID.Value
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            ElseIf i = GridView1.Rows.Count - 1 Then
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>alert('First Select The Test');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            End If
        Next


        'For i As Integer = 0 To GridView1.Rows.Count - 1
        '    Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
        '    If chk.Checked = True Then
        '        Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
        '        HiddenField_TG_ID.Value = TG_ID.Value
        '        HiddenField_Main_Id.Value = GridView1.Rows(i).Cells.Item(2).Text
        '        Dim sb As New StringBuilder
        '        Dim t As Type = Me.GetType
        '        sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "');</script>")
        '        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
        '            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        '        End If
        '    Else
        '        Dim sb As New StringBuilder
        '        Dim t As Type = Me.GetType
        '        sb.Append("<script language='javascript' type='text/javascript'>alert('First Select The Test');</script>")
        '        If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
        '            ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
        '        End If
        '    End If
        'Next
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Session.Add("RegistrationNo", Request.QueryString("Reg_No"))
        Session.Add("YearlyNo", Request.QueryString("YearlyNo"))
        ButtonSave.Attributes.Add("onclick", "return Validation()")
        Dim RegNo As String = "RegNo"
        Dim YearlyNo As String = "YearlyNo"
        Label_Message.Text = ""
    End Sub
    Sub Printreport1()
        'Try
        '    Dim report As New ReportDocument()
        '    Dim RegNo As String = Request.QueryString("RegNo").ToString
        '    Dim YearlyNo As String = Request.QueryString("YearlyNo").ToString
        '    report.Load("D:\Pathalogy Software\PathologyFeesReport.rpt")  ' Location Of The Report. 
        '    report.SetDatabaseLogon("sa", "123", "Server1", "Pathology2")
        '    report.SetParameterValue(0, RegNo)
        '    report.SetParameterValue(1, YearlyNo)

        '    report.PrintToPrinter(1, True, 0, 0)
        '    report.Close()
        '    Session("PDT") = Date.Now
        'Catch ex As Exception

        'End Try
    End Sub
    Protected Sub ButtonSavePageReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSavePageReport.Click
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                HiddenField_TG_ID.Value = TG_ID.Value
                Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")

                Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                HiddenField_TBID.Value = TB_ID.Value

                HiddenField_Main_Id.Value = main_ID.Value
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>window.open('Radiology_Para_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            ElseIf i = GridView1.Rows.Count - 1 Then
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>alert('First Select The Test');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            End If
        Next
    End Sub
    Protected Sub ButtonCrystalReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonCrystalReport.Click
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim chk As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                HiddenField_TG_ID.Value = TG_ID.Value
                Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")

                Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                HiddenField_TBID.Value = TB_ID.Value

                HiddenField_Main_Id.Value = main_ID.Value
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>window.open('Patient_Result_Report.aspx?RegNo=" + Session("registrationNo").ToString + "&YearlyNo=" + Session("YearlyNo").ToString + "&TGID=" + HiddenField_TG_ID.Value + "&Main_ID=" + HiddenField_Main_Id.Value + "&TB_ID=" + HiddenField_TBID.Value + "');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            ElseIf i = GridView1.Rows.Count - 1 Then
                Dim sb As New StringBuilder
                Dim t As Type = Me.GetType
                sb.Append("<script language='javascript' type='text/javascript'>alert('First Select The Test');</script>")
                If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
                    ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString)
                End If
            End If
        Next
    End Sub

    Protected Sub LinkButton_PatientConsumption_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_PatientConsumption.Click
        Response.Redirect("../Pharmacy/StoreItem_Consumption_To_Patient.aspx")
    End Sub

    Protected Sub Button_Status_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Status.Click
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
            If check.Checked = True Then
                Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                HiddenField_TG_ID.Value = TG_ID.Value
                Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")
                Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                HiddenField_TBID.Value = TB_ID.Value
                HiddenField_Main_Id.Value = main_ID.Value
                SqlDataSource_Grid.update()

            End If
        Next
    End Sub

    Protected Sub btnUpdate_ToReporting_Status_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnUpdate_ToReporting_Status.Click
        Try
            For i As Integer = 0 To GridView1.Rows.Count - 1

                Dim check As CheckBox = GridView1.Rows(i).FindControl("CheckBox1")
                If check.Checked = True Then
                    Dim TG_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenfieldTCID")
                    HiddenField_TG_ID.Value = TG_ID.Value
                    Dim main_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_Main_ID")
                    Dim TB_ID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_TBID")
                    HiddenField_TBID.Value = TB_ID.Value
                    HiddenField_Main_Id.Value = main_ID.Value
                    SqlDataSource_ReportingStatus.Update()


                    GridView1.DataBind()


                End If

            Next
        Catch
        End Try


    End Sub
End Class
