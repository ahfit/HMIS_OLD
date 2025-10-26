Imports System.Data
Imports System.Data.SqlClient
Partial Class PAthology_Payment
    Inherits System.Web.UI.Page

    Dim PAtient_Type As String = ""
    Dim ENC As New Encryption
    Dim Total_Amount As Integer = 0
    Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Dim RegNo As String = Session("registrationNo")
            Dim YearlyNo As Integer = Session("YearlyNo")
            Dim Count As Integer = 0
            If Pt_Type(RegNo, YearlyNo) = "OPD" Then
                Panel_Payment.Visible = True
                Dim da_Private As New Pt_Radiology_TestTableAdapters.Pt_PaymentTableAdapter
                Dim ds_Private As New Pt_Radiology_Test
                da_Private.Fill_Private(ds_Private.Tables("Pt_Payment"), RegNo, YearlyNo)
                For i As Integer = 0 To ds_Private.Tables("Pt_Payment").Rows.Count - 1
                    ds_Private.Tables("Pt_Payment").Rows(i).Item("Reg_No") = ENC.Encrypt_Main(ds_Private.Tables("Pt_Payment").Rows(i).Item("Reg_No"), False)
                    Total_Amount = Total_Amount + CInt(ds_Private.Tables("Pt_Payment").Rows(i).Item("Fee"))
                Next
                GridView2.DataSource = ds_Private.Tables("Pt_Payment")
                GridView2.DataBind()
            Else
                Panel_Payment.Visible = False
                Dim da_Public As New Pt_Radiology_TestTableAdapters.Pt_PaymentTableAdapter
                Dim ds_Public As New Pt_Radiology_Test
                da_Public.Fill_Public(ds_Public.Tables("Pt_Payment"), RegNo, YearlyNo)
                'Response.Write("<br />" & ds_Public.Tables("Pt_Payment").Rows.Count)
                For i As Integer = 0 To ds_Public.Tables("Pt_Payment").Rows.Count - 1
                    ds_Public.Tables("Pt_Payment").Rows(i).Item("Reg_No") = ENC.Encrypt_Main(ds_Public.Tables("Pt_Payment").Rows(i).Item("Reg_No"), False)
                    ds_Public.Tables("Pt_Payment").Rows(i).Item("Fee") = 0
                    Total_Amount = 0
                Next
                GridView2.DataSource = ds_Public.Tables("Pt_Payment")
                GridView2.DataBind()
            End If
            'TotalDiscount()

            TextBox_Grand_total.Text = Total_Amount
            TextBox_Total_Price.Text = Total_Amount - TextBox_Grand_discount.Text
            ButtonSave.Attributes.Add("onClick", "NewWindow()")
        Catch ex As Exception
            Response.Write("CHECK" & ex.Message)
        End Try
    End Sub
    Function Pt_Type(ByVal RegNo As String, ByVal yearlyno As Integer) As String
        Dim da_Basic As New Pt_Radiology_TestTableAdapters.Pt_Basic_DataTableAdapter
        Dim ds_Basic As New Pt_Radiology_Test
        da_Basic.Fill(ds_Basic.Tables("Pt_Basic_Data"), RegNo, yearlyno)
        PAtient_Type = ds_Basic.Tables("Pt_Basic_Data").Rows(0).Item("Patient_Type")
        Return PAtient_Type
    End Function

    Protected Sub ButtonSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Try
            Dim RegNo As String = Session("registrationNo")
            Dim YearlyNo As Integer = Session("YearlyNo")
            HiddenFieldTotalAmount.Value = CInt(TextBox_Grand_total.Text)
            HiddenFieldTotalPaid.Value = CInt(TextBox_Total_Price.Text) 'CInt(TextBox_Grand_total.Text)
            HiddenFieldTotal_Discount.Value = TotalDiscount()
            HiddenFieldMain_ID.Value = Select_Main_ID(RegNo, YearlyNo)
            Insert_Test_Info()
            SqlDataSourceInsertSub.Insert()
            Update_Status()
            'Response.Redirect("main_services.aspx")
        Catch ex As Exception
            Response.Write(ex.Message & " Save Button")
        End Try
    End Sub


    Function TotalDiscount() As Integer
        Dim count As Integer = 0
        Dim total_Discount As Integer = 0
        Try
            Label_Message.Text = ""
            If TextBox_Grand_discount.Text <> 0 Then
                For i As Integer = 0 To GridView2.Rows.Count - 1
                    count = count + CInt(GridView2.Rows(i).Cells(6).Text)
                Next
                'Response.Write(count)
                TextBox_Grand_total.Text = count
                If DropDownList_Discount_Type.SelectedValue = "Rs." Then
                    If CInt(TextBox_Grand_discount.Text) > count Then
                    Else
                        total_Discount = CInt(TextBox_Grand_discount.Text)
                    End If
                ElseIf DropDownList_Discount_Type.SelectedValue = "%age" Then
                    If CInt(TextBox_Grand_discount.Text) > 100 Then
                    Else
                        Dim per_discount As Integer = (CInt(TextBox_Grand_discount.Text) * count) / 100
                        total_Discount = CInt(per_discount)
                    End If
                End If
            End If
            TextBox_Total_Price.Text = count - total_Discount
        Catch ex As Exception
            Response.Write("ONE" & ex.Message)
        End Try
        Return total_Discount
    End Function

    Sub Update_Status()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("update Path_Result_Delivery set fee_paid = 1 where (Main_ID= " & HiddenFieldMain_ID.Value & ")", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & "update_status")
        End Try
    End Sub

    Function Select_Main_ID(ByVal RegNo As String, ByVal YearlyNo As Integer) As Integer
        Dim Main_Id As Integer = 0
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select Main_ID From Path_Result_Delivery where Reg_No= '" & RegNo & "' AND Yearly_No = " & YearlyNo, con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Main_Id = mycommand.ExecuteScalar
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message & " Select Main Id")
        End Try
        Return Main_Id
    End Function

    Sub Insert_Test_Info()
        Try
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT  Test_Booking_Services.TB_ID FROM Test_Booking_Services INNER JOIN Path_Result_Delivery ON Test_Booking_Services.Main_ID = Path_Result_Delivery.Main_ID WHERE (Path_Result_Delivery.Reg_no = @RegNo) AND (Path_Result_Delivery.Yearly_No = @YearlyNo) ", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand.Parameters.AddWithValue("@YearlyNo", Session("YearlyNo"))
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            con.Open()
            mycommand.ExecuteNonQuery()
            da.SelectCommand = mycommand
            da.Fill(ds)
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                Dim mycommand1 As New System.Data.SqlClient.SqlCommand("Select Test_ID from Test_Services Where TB_ID =" & ds.Tables(0).Rows(i).Item(0), con)
                mycommand1.CommandType = Data.CommandType.Text
                Dim da1 As New SqlDataAdapter
                Dim ds1 As New DataSet
                mycommand1.ExecuteNonQuery()
                da1.SelectCommand = mycommand1
                da1.Fill(ds1)
                For j As Integer = 0 To ds1.Tables(0).Rows.Count - 1
                    Dim mycommand2 As New System.Data.SqlClient.SqlCommand("Insert_Pt_Pathology_Test_Amount", con)
                    mycommand2.CommandType = Data.CommandType.StoredProcedure
                    mycommand2.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo")) 'Session("BMIPayID")
                    mycommand2.Parameters.AddWithValue("@RID", ds1.Tables(0).Rows(j).Item(0))
                    mycommand2.Parameters.AddWithValue("@Reg_No", Session("registrationNo")) 'Session("EMORegNo")
                    mycommand2.Parameters.AddWithValue("@main_id", Select_Main_ID(Session("registrationNo"), Session("YearlyNo")))
                    mycommand2.ExecuteNonQuery()
                Next
            Next
            con.Close()
        Catch ex As Exception
            Response.Write("tOW" & ex.Message)
        End Try
    End Sub

    Protected Sub TextBox_Grand_discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Grand_discount.TextChanged
        TotalDiscount()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        TotalDiscount()
        ButtonSave.Visible = True
    End Sub

    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        TotalDiscount()
    End Sub
End Class
