Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Web.CrystalReportSource
Imports System.Data
Imports System.Data.SqlClient

Partial Class Pathalogy_test_Price
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim b As String
    Dim a As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim Grand_total As Integer = 0
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Grand_total = Grand_total + CInt(GridView1.Rows(i).Cells(6).Text)
            Next
            TextBox_Grand_total.Text = Grand_total
            Label_Total.Text = Grand_total
            Check_Discount()
            Try
                Label_Message.Text = ""
                If TextBox_Grand_discount.Text <> 0 Then
                    Dim count As Integer = 0
                    For i As Integer = 0 To GridView1.Rows.Count - 1
                        count = count + CInt(GridView1.Rows(i).Cells(6).Text)
                    Next
                    If CInt(TextBox_Grand_discount.Text) > count Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    End If
                    TextBox_Grand_total.Text = count - CInt(TextBox_Grand_discount.Text)
                End If
            Catch ex As Exception
                Label_Message.Text = "Enter Integer in Discount "
                Exit Sub
            End Try
            For i As Integer = 0 To GridView1.Rows.Count - 1
                Dim hid_fee As HiddenField = GridView1.Rows(i).FindControl("HiddenFieldPrice")
                Dim hid_RID As HiddenField = GridView1.Rows(i).FindControl("HiddenField_RID")
                'Response.Write("<br />" & hid_RID.Value & "<br />" & Session("registrationNo") & "  " & Session("yearlyNo"))
                Dim txt_fee As TextBox = GridView1.Rows(i).FindControl("TextBox_Discount")

                If (hid_fee.Value = "") Then
                    hid_fee.Value = 0
                End If
                If (txt_fee.Text = "") Then
                    txt_fee.Text = 0
                End If
                If CType(hid_fee.Value, Double) < CType(txt_fee.Text, Double) Then
                    Label_Message.Text = "Discount Amount  Is greater Then The Original Fee "
                    Exit Sub
                Else
                    HiddenField_Radiology_ID.Value = hid_RID.Value
                    HiddenField_Total_Fee.Value = hid_fee.Value
                    HiddenField_Discount.Value = HiddenField3.Value 'txt_fee.Text
                    HiddenField_Fee_Paid.Value = CType(hid_fee.Value, Double) - CType(txt_fee.Text, Double)
                    Try
                        If CInt(TextBox_Grand_discount.Text = 0) Or (TextBox_Grand_discount.Text.Trim = "") Then
                        Else
                            HiddenField_Discount.Value = 0
                            HiddenField_Fee_Paid.Value = HiddenField_Total_Fee.Value
                        End If
                        HiddenField2.Value = HiddenField1.Value - HiddenField3.Value
                        SqlDataSourceForGrid.Insert()
                    Catch ex As Exception
                        Response.Write(ex.Message & "one")
                    End Try
                End If
                SqlDataSource1.Insert()
            Next

            Update_Status()
            'Printreport1()
            Response.Redirect("Patient_Search.aspx?def=1.1")
        Catch ex As Exception
            Response.Write(ex.Message & "TWO")
        End Try
    End Sub

    Function Check() As Boolean
        Try
            If TextBox_Grand_discount.Text <> 0 Then
                Dim i As Integer = CInt(TextBox_Grand_discount.Text)
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
        End Try
    End Function

    Sub Insert_Values()
        ''''''''''========================================='''''''''''''''''''
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Patient_Select_ID", con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        mycommand.Parameters.AddWithValue("@Yearly_No", Request.QueryString("YearlyNo"))
        mycommand.Parameters.AddWithValue("@Reg_No", Request.QueryString("RegNo"))
        mycommand.Parameters.Add("@identity1", SqlDbType.Int)
        mycommand.Parameters("@identity1").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        mycommand.ExecuteNonQuery()
        'Response.Write(mycommand.Parameters("@identity1").Value & "Value ")
        HiddenFieldMain_ID.Value = mycommand.Parameters("@identity1").Value
        mycommand.Connection.Close()
        '''''''''''=========================================''''''''''''''''''
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'Response.Write(Session("PatientName"))
            Insert_Values()
            If Page.IsPostBack = False Then
                GridView1.DataBind()
                Dim Grand_total As Integer = 0
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    Grand_total = Grand_total + CInt(GridView1.Rows(i).Cells(6).Text)
                Next
                TextBox_Grand_total.Text = Grand_total
                TextBox_Total_Price.Text = Grand_total
                HiddenField1.Value = Grand_total
                WebDateTimeEdit1.Value = Date.Now
                WebDateChooser_Select_Date.Value = Date.Now
                WebDateChooser_Select_Date.MinDate = Date.Now
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        ButtonSave.Attributes.Add("onClick", "NewWindow()")
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
                        HiddenField3.Value = TextBox_Grand_total.Text
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then 'CInt(TextBox_Grand_total.Text) Then
                        Label_Message.Text = "Discount is Must Less Then Grand Total  "
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        TextBox_Grand_total.Text = CInt(TextBox_Total_Price.Text) - per_discount
                        HiddenField3.Value = TextBox_Grand_total.Text
                    End If
                End If
            End If
        Catch ex As Exception
            Label_Message.Text = "Enter Integer in Discount "
            Exit Sub
        End Try
    End Sub

    Sub Check_Discount()
        Try
            'If TextBox_Grand_discount.Text = "" Then
            If CInt(TextBox_Grand_discount.Text) <> 0 Then
                TextBox_Grand_total.Text = CInt(TextBox_Grand_total.Text) - CInt(TextBox_Grand_discount.Text)
                'HiddenField3.Value = TextBox_Grand_total.Text
            ElseIf TextBox_Grand_discount.Text = "" Or CInt(TextBox_Grand_discount.Text) = 0 Then
                Dim discount As Double = 0
                For i As Integer = 0 To GridView1.Rows.Count - 1
                    Dim txt_fee As TextBox = GridView1.Rows(i).FindControl("TextBox_Discount")
                    discount = discount + CType(txt_fee.Text, Double)
                Next
                TextBox_Grand_total.Text = CType(TextBox_Grand_total.Text, Double) - discount
                HiddenField3.Value = TextBox_Grand_total.Text
            End If
            'End If
        Catch ex As Exception
            Response.Write(ex.Message)
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
                    'Response.Write(e.Row.Cells.Item(4).Text)
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

    Sub Printreport1()
        Try
            Dim report As New ReportDocument()
            Dim RegNo As String = Request.QueryString("RegNo").ToString
            Dim YearlyNo As String = Request.QueryString("YearlyNo").ToString
            Dim str As String = Server.MapPath("")
            str = str + "\Pathology_Package_Fees_Report.rpt"
            report.Load(str) '"D:\Pathalogy Software\Pathology_Package_Fees_Report.rpt")  ' Location Of The Report. 
            report.SetDatabaseLogon("sa", "123", "Server1", "Pathology2")
            report.SetParameterValue(0, RegNo)
            report.SetParameterValue(1, YearlyNo)
            report.SetParameterValue(2, YearlyNo)
            report.SetParameterValue(3, RegNo)
            report.SetParameterValue(4, RegNo) ' "@RegNo", "Package_Tests_Payment.rpt")
            report.SetParameterValue(5, YearlyNo) ', "@YearlyNo", "Package_Tests_Payment.rpt")
            report.SetParameterValue(6, RegNo) ', "@RegNo", "Test_Payment.rpt")
            report.SetParameterValue(7, YearlyNo) ', "@YearlyNo", "Test_Payment.rpt")
            'report.PrintToPrinter(1, True, 0, 0)
            'Response.Write(report.Name + report.ParameterFields(0).ToString + report.ParameterFields(1).ToString) ' + report.ParameterFields(2).ToString + report.ParameterFields(3).ToString)
            report.Close()
            'Session("PDT") = Date.Now
        Catch ex As Exception
            Response.Write("Crystal Report ok" & ex.Message)
        End Try
    End Sub

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
