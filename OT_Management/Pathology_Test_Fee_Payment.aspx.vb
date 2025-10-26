Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Test_Fee_Payment
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim b As String = ""
    Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            If GridView1.Rows.Count <> 0 Then
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    Dim hid_fee As HiddenField = GridView1.Rows(i).FindControl("HiddenFieldPrice")
                    Dim hid_RID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_RID")
                    HiddenField_Radiology_ID.Value = hid_RID.Value
                    HiddenField_Total_Fee.Value = hid_fee.Value
                    HiddenField_Fee_Paid.Value = hid_fee.Value
                    HiddenField_Discount.Value = 0
                    SqlDataSourceForGrid.Insert()
                Next
                HiddenFieldTotalAmount.Value = CInt(TextBox_Total_Price.Text)
                HiddenFieldTotalPaid.Value = CInt(TextBox_Grand_total.Text)
                HiddenFieldTotal_Discount.Value = TotalDiscount()
                SqlDataSourceInsertSub.Insert()
                Update_Status()
                'Printreport()
                'Response.Redirect("Patient_Search.aspx?def=1.1")
                Response.Redirect("main_services.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Function TotalDiscount() As Integer
        Dim count As Integer = 0
        Dim total_Discount As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    count = count + CInt(GridView1.Rows(i).Cells(6).Text)
                Next
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                    Else
                        total_Discount = CInt(TextBox_Grand_discount.Text)
                        'total_Discount = CInt(TextBox_Total_Price.Text) - CInt(TextBox_Grand_discount.Text)

                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        total_Discount = CInt(per_discount)
                    End If
                End If
            End If
        Catch ex As Exception
        End Try
        Return total_Discount
    End Function

    Sub Insert_Values()
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_Select_ID", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo")) 'Request.QueryString("YearlyNo"))
        mycommand.Parameters.AddWithValue("@Reg_No", Session("registrationNo")) 'Request.QueryString("RegNo"))
        mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim user_authen As New User_page_Authentication
            Session("Module_id") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Insert_Values()
            If Page.IsPostBack = False Then
                GridView1.DataBind()
                Dim Grand_total As Integer = 0
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    Grand_total = Grand_total + CInt(GridView1.Rows(i).Cells(6).Text)
                Next
                TextBox_Grand_total.Text = Grand_total
                TextBox_Total_Price.Text = Grand_total
                HiddenFieldTotalAmount.Value = Grand_total
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        ButtonSave.Attributes.Add("onClick", "NewWindow()")
    End Sub
    Sub Printreport()
        Try
            'Dim b As String
            ' checkpayid()
            ' Below Six LInes Are The Code OF The Genereate Crystal Report ANd Print WithOut Preivieew The Report .
            Dim report As New ReportDocument()
            'b = (Session("BMIPayID"))
            'report.Load(Server.MapPath("patient.rpt"))
            'strPath = Server.MapPath("patient.rpt")
            report.Load("G:\Pathalogy Software\Pathology_Package_Fees_Report.rpt")  ' Location Of TH e Report. 
            report.SetDatabaseLogon("sa", "123456", "DBA", "Pathology2")
            report.SetParameterValue("@reg_No", Session("registrationNo"))
            report.SetParameterValue("@Yearly_No", Session("YearlyNo"))
            report.SetParameterValue("@YearlyNO", Session("YearlyNo"))
            report.SetParameterValue("@RegNo", Session("registrationNo"))
            report.SetParameterValue("PatientName", Session("PatientName"))
            report.SetParameterValue("@Yearly_No_Discount", Session("YearlyNo"))
            report.SetParameterValue("@Reg_No_Discount", Session("registrationNo"))
            report.SetParameterValue("@YearlyNo", Session("YearlyNo"), "Package_Tests_Payment.rpt")
            report.SetParameterValue("@RegNo", Session("registrationNo"), "Package_Tests_Payment.rpt")
            report.SetParameterValue("@YearlyNo", Session("YearlyNo"), "Test_Payment.rpt")
            report.SetParameterValue("@RegNo", Session("registrationNo"), "Test_Payment.rpt")
            'Response.Write(report.Name + report.ParameterFields(0).ToString)
            report.PrintOptions.PrinterName = "EPSONLX-PathologyReception"
            report.PrintToPrinter(1, True, 0, 0)
            report.Close()
            Session("PDT") = Date.Now
            'printinfosave.Insert()
        Catch ex As Exception
            Response.Write("  " & ex.Message)
        End Try
    End Sub
    Protected Sub TextBox_Grand_discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Grand_discount.TextChanged
        Dim count As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    count = count + CInt(GridView1.Rows(i).Cells(6).Text)
                Next
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        TextBox_Grand_total.Text = CInt(TextBox_Total_Price.Text) - CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        TextBox_Grand_total.Text = CInt(TextBox_Total_Price.Text) - per_discount
                    End If
                End If
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
            Exit Sub
        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        For i As Integer = 0 To GridView1.Rows.Count - 1
            GridView1.Rows(i).Cells(0).Text = ENC.Encrypt_Main(GridView1.Rows(i).Cells(0).Text, False)
        Next
    End Sub

    Protected Sub GridView1_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView1.RowDeleted
        GridView1.DataBind()
        Dim Grand_total As Integer = 0
        For i As Integer = 0 To GridView1.Rows.Count - 1
            Grand_total = Grand_total + CInt(GridView1.Rows(i).Cells(6).Text)
        Next
        TextBox_Grand_total.Text = Grand_total
    End Sub
    Protected Sub GridView1_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView1.RowDataBound
        Try
            If e.Row.RowType = DataControlRowType.DataRow Then
                If (b = "") Then
                    b = e.Row.Cells.Item(4).Text
                    e.Row.Cells.Item(4).Text = b
                ElseIf b = e.Row.Cells.Item(4).Text Then
                    e.Row.Cells.Item(4).Text = ""
                    e.Row.Cells.Item(4).Text = ""
                Else
                    b = e.Row.Cells.Item(4).Text
                    e.Row.Cells.Item(4).Text = b
                End If
            End If
        Catch ex As Exception
        End Try
    End Sub

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update MRI_Save_Patient_Next_App set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
        End Try
    End Sub

    'Sub Printreport1()
    '    Try
    '        Dim report As New ReportDocument()
    '        'Dim RegNo As String = Request.QueryString("RegNo").ToString
    '        'Dim YearlyNo As String = Request.QueryString("YearlyNo").ToString
    '        Dim str As String = Server.MapPath("")
    '        str = str + "\Pathology_Package_Fees_Report.rpt"
    '        report.Load(str) '"D:\Pathalogy Software\Pathology_Package_Fees_Report.rpt")  ' Location Of The Report. 
    '        report.SetDatabaseLogon("sa", "123", "Server1", "Pathology2")
    '        report.SetParameterValue(0, Session("registrationNo"))
    '        report.SetParameterValue(1, YearlyNo)
    '        report.SetParameterValue(2, YearlyNo)
    '        report.SetParameterValue(3, RegNo)
    '        report.SetParameterValue(4, RegNo) ' "@RegNo", "Package_Tests_Payment.rpt")
    '        report.SetParameterValue(5, YearlyNo) ', "@YearlyNo", "Package_Tests_Payment.rpt")
    '        report.SetParameterValue(6, RegNo) ', "@RegNo", "Test_Payment.rpt")
    '        report.SetParameterValue(7, YearlyNo) ', "@YearlyNo", "Test_Payment.rpt")
    '        'report.PrintToPrinter(1, True, 0, 0)
    '        'Response.Write(report.Name + report.ParameterFields(0).ToString + report.ParameterFields(1).ToString) ' + report.ParameterFields(2).ToString + report.ParameterFields(3).ToString)
    '        report.Close()
    '        'Session("PDT") = Date.Now
    '    Catch ex As Exception
    '        Response.Write("Crystal Report ok" & ex.Message)
    '    End Try
    'End Sub

    Protected Sub DropDownList_Discount_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Discount_Type.SelectedIndexChanged
        Dim count As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    count = count + CInt(GridView1.Rows(i).Cells(6).Text)
                Next
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        TextBox_Grand_total.Text = CInt(TextBox_Total_Price.Text) - CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        TextBox_Grand_total.Text = CInt(TextBox_Total_Price.Text) - per_discount
                    End If
                End If
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
            Exit Sub
        End Try
    End Sub
End Class
