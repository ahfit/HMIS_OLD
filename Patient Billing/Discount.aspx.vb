Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Billing_Discount
    Inherits System.Web.UI.Page
    Dim co As New Coma
    Dim total As Double = 0
    Dim totalAmount As Double = 0
    Shared done As String
    Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Session.Add("RegistrationNo", Request.QueryString("regno"))
        Session.Add("YearlyNo", Request.QueryString("payid"))

        If Session("PatientType") = "Panel" Then
            Button_Save.Visible = False
        Else
            Button_Save.Visible = False
        End If
        If Not IsPostBack Then
            FillDiscountType()

            done = 1

            'Response.Write(Session("emp_id"))
            DropDownList_Discount_By.SelectedValue = Session("emp_id")

            If (Request.QueryString("after") = "True") Then
                RadioButtonList_Payment_type.SelectedValue = 1
                RadioButtonList_Payment_type.Enabled = False
            ElseIf (Request.QueryString("after") = "False") Then
                RadioButtonList_Payment_type.SelectedValue = 0
                RadioButtonList_Payment_type.Enabled = False
            End If

        End If
        'If Label_Total_Discount.Text <> "0" Then
        '    btn_discount.Visible = True
        'Else
        '    btn_discount.Visible = False
        'End If
    End Sub
    Protected Sub FillDiscountType()
        Dim conststr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Using con As New SqlConnection(conststr)
            Dim command As New SqlCommand("select id , DiscountType from Discount_Type", con)
            Dim sda As New SqlDataAdapter(command)
            Dim dt As New DataTable()
            sda.Fill(dt)
            ddl_Discount_Type.DataTextField = "DiscountType"
            ddl_Discount_Type.DataValueField = "DiscountType"
            ddl_Discount_Type.DataSource = dt
            ddl_Discount_Type.DataBind()
        End Using
    End Sub
    Protected Sub GridView_For_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_For_Services.PreRender
        If Not Page.IsPostBack Then
            For index As Integer = 0 To GridView_For_Services.Rows.Count - 1
                Dim doc_limit As Integer = 0
                Dim Label_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Price")
                Dim TextBox_Discount As TextBox = GridView_For_Services.Rows(index).FindControl("TextBox_Discount")
                Dim DropDownList_Type As DropDownList = GridView_For_Services.Rows(index).FindControl("DropDownList_Type")
                Dim Label_Original_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Original_Price")
                Dim HiddenField_ID As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_ID")
                Dim hf_Doc_MAX_Dis As HiddenField = GridView_For_Services.Rows(index).FindControl("hf_Doc_MAX_Dis")
                Dim HiddenFieldDiscountAmount As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenFieldDiscountAmount")
                Dim TextBox_DocDiscount As TextBox = GridView_For_Services.Rows(index).FindControl("txt_doc_dis")
                Dim CheckBox1 As CheckBox = GridView_For_Services.Rows(index).FindControl("CheckBox1")
                Dim HiddenField_Doctor_ID As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_Doctor_ID")
                Dim CheckBox_Doctor_Discount As CheckBox = GridView_For_Services.Rows(index).FindControl("CheckBox_Doctor_Discount")
                Dim HiddenField_DiscountAmount As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_DiscountAmount")
                If DropDownList_Type.SelectedValue = "%" Then
                    HiddenField_DiscountAmount.Value = Convert.ToString(Convert.ToDouble(Label_Price.Text) / 100 * Convert.ToDouble(TextBox_Discount.Text))
                ElseIf DropDownList_Type.SelectedValue = "Rs." Then
                    HiddenField_DiscountAmount.Value = TextBox_Discount.Text
                End If
                If String.IsNullOrEmpty(HiddenFieldDiscountAmount.Value.Trim()) Then
                    HiddenFieldDiscountAmount.Value = "0"
                End If

                Label_Original_Price.Text = Convert.ToString(Convert.ToDouble(Label_Price.Text) - Convert.ToDouble(HiddenField_DiscountAmount.Value))
                If String.IsNullOrEmpty(TextBox_Discount.Text.Trim()) Then
                    TextBox_Discount.Text = "0"
                End If

                If Not Page.IsPostBack Then
                    doc_limit = CInt(hf_Doc_MAX_Dis.Value) - CInt(HiddenField_DiscountAmount.Value)
                    TextBox_DocDiscount.Attributes.Add("max", doc_limit)

                End If


            Next
        End If
        If GridView_For_Services.Rows.Count <> 0 Then
            Dim totalPrice As Double = 0
            Dim totalDicountedamount As Double = 0
            Dim totalDiscount As Double = 0
            For i As Integer = 0 To GridView_For_Services.Rows.Count - 1
                '        Dim CheckBox1 As CheckBox = GridView_For_Services.Rows(i).FindControl("CheckBox1")
                '        If CheckBox1.Checked Then
                Dim Label_Price As Label = GridView_For_Services.Rows(i).FindControl("Label_Price")
                Dim Label_Original_Price As Label = GridView_For_Services.Rows(i).FindControl("Label_Original_Price")
                Dim hiddfielddiscount As HiddenField = GridView_For_Services.Rows(i).FindControl("HiddenField_DiscountAmount")

                totalDiscount = totalDiscount + hiddfielddiscount.Value
                Try
                    totalDicountedamount = totalDicountedamount + Convert.ToDouble(Label_Original_Price.Text)

                Catch ex As Exception
                    totalDicountedamount = 0
                End Try
                total = total + Label_Price.Text
                '        End If
            Next
            Dim Label_TotalPrice As Label = GridView_For_Services.FooterRow.FindControl("Label_TotalPrice")
            Dim Label_DiscountedPriceTotal As Label = GridView_For_Services.FooterRow.FindControl("Label_DiscountedPriceTotal")
            Label_TotalPrice.Text = total
            Label_Grand_Total.Text = total
            Label_DiscountedPriceTotal.Text = totalDicountedamount
            HiddenField_Total_Discount.Value = totalDicountedamount
            If RadioButtonList1.SelectedValue = 1 Then
                Label_DiscountedTotal.Text = totalDicountedamount
                Label_Total_Discount.Text = totalDiscount
            End If
        End If
    End Sub
    Protected Sub TextBox_Percentage_Discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Percentage_Discount.TextChanged
        init_grid()
        Percentage()
        amount()
        'GridView_For_Services.DataBind()
    End Sub
    Protected Sub TextBox_Other_Discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_Other_Discount.TextChanged
        'Label_Total_Discount.Text = Convert.ToDecimal(Label_Grand_Total.Text) + Convert.ToDecimal(TextBox_Other_Discount.Text)
        init_grid()
        Percentage()
        amount()


    End Sub
    Protected Sub SqlDataSource_Discount_Main_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Discount_Main.Inserted
        Dim discountValue As Object = e.Command.Parameters("@Discount_ID").Value

        If discountValue Is Nothing OrElse IsDBNull(discountValue) Then
            HiddenField_Discount_ID.Value = "0"
        Else
            HiddenField_Discount_ID.Value = discountValue.ToString()
        End If
    End Sub
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click


        'If RadioButtonList1.SelectedValue = 1 Then



        '    If Len(Flag.Value) > Len(done) Or done = "1" Then
        '        HiddenField_Total_Discount.Value = Convert.ToDecimal(co.Remove_Coma(Label_Total_Discount.Text))
        '        done = Flag.Value
        '        If (Convert.ToDecimal(Label_Total_Discount.Text) <> 0) Then
        '            SqlDataSource_Discount_Main.Insert()
        '        End If



        '        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
        '            Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
        '            Dim Discount As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_DiscountAmount")
        '            Dim hid_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_ID")
        '            'Dim chk_Doctor As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox_Doctor_Discount")
        '            Dim hid_Doctor_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_doctor_ID")
        '            ' If chk_Doctor.Checked = True Then
        '            HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
        '            HiddenField_Doctor_Amount.Value = Convert.ToDouble(co.Remove_Coma(Discount.Value))
        '            ' Else
        '            'HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
        '            'HiddenField_Doctor_Amount.Value = 0
        '            ' End If

        '            HiddenField_ID.Value = hid_ID.Value
        '            HiddenField_Amount.Value = Convert.ToDouble(co.Remove_Coma(Discount.Value))

        '            If Convert.ToDouble(co.Remove_Coma(Discount.Value)) <> 0 Then
        '                SqlDataSource_Discount_Sub.Insert()
        '            End If

        '        Next

        '        GridView_For_Services.DataBind()

        '        TextBox_Percentage_Discount.Text = 0
        '        TextBox_Other_Discount.Text = 0

        '        TextBox_Description.Text = ""
        '    End If
        'ElseIf RadioButtonList1.SelectedValue = 2 Then
        '    '
        '    '
        '    'Comulative discount
        '    '
        '    If Len(Flag.Value) > Len(done) Or done = "1" Then
        '        HiddenField_Total_Discount.Value = Convert.ToDecimal(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(Label_DiscountedTotal.Text))
        '        done = Flag.Value
        '        If (Convert.ToDecimal(HiddenField_Total_Discount.Value) <> 0) Then
        '            SqlDataSource_Discount_Main.Insert()
        '        End If


        '        Dim totalamount As Double = Label_Grand_Total.Text
        '        Dim discountedamount As Double = Label_DiscountedTotal.Text
        '        Dim discountamount As Double = totalamount - discountedamount
        '        Dim ratio As Double = discountamount / totalamount

        '        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
        '            Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
        '            ' Dim Discount As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_DiscountAmount")
        '            Dim hid_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_ID")

        '            Dim hid_Doctor_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_doctor_ID")

        '            HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
        '            HiddenField_Doctor_Amount.Value = Convert.ToDouble(Original_Price.Text) * ratio


        '            HiddenField_ID.Value = hid_ID.Value
        '            HiddenField_Amount.Value = Convert.ToDouble(Original_Price.Text) * ratio


        '            SqlDataSource_Discount_Sub.Insert()


        '        Next

        '        GridView_For_Services.DataBind()

        '        TextBox_Percentage_Discount.Text = 0
        '        TextBox_Other_Discount.Text = 0

        '        TextBox_Description.Text = ""
        '    End If

        '    '
        '    '
        '    'Comulative discount
        '    '
        'End If
        '' Response.Redirect("Discount_Search.aspx")
    End Sub
    'Protected Sub GridView_Discount_Main_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)

    '    GridView_Discount_Sub.DataBind()
    'End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("Indoor_Patient_Paymen.aspx?regno=" + Request.QueryString("regno") + "&payid=" + Request.QueryString("payid"))
    End Sub
    Protected Sub GridView_Discount_Main_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Try


            For count As Integer = 0 To GridView_Discount_Main.Rows.Count - 1
                Dim link As LinkButton = GridView_Discount_Main.Rows(count).FindControl("LinkButton1")

                link.Text = co.place_Coma(Convert.ToInt32(link.Text))
            Next
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub GridView_Discount_Sub_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)
        Try
            For count As Integer = 0 To GridView_Discount_Sub.Rows.Count - 1
                GridView_Discount_Sub.Rows(count).Cells(1).Text = co.place_Coma(Convert.ToInt32(GridView_Discount_Sub.Rows(count).Cells(1).Text))
            Next
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub GridView_For_Services_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_For_Services.SelectedIndexChanged

    End Sub
    Protected Sub GridView_Discount_Main_RowEditing1(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs)
        Try
            Dim hid As HiddenField = GridView_Discount_Main.Rows(e.NewEditIndex).FindControl("HiddenField1")


            Dim sb As StringBuilder = New StringBuilder
            sb.Append("<script language='javascript' type='text/javascript'>window.open('Indoor_Payment_Discount.aspx?Payment_No=" + hid.Value + "&PayID=" + Request.QueryString("payid") + "&RegNo=" + Request.QueryString("regno") + "&Type=Discount" + "')</script>")
            'sb.Append(" window.open('patientServices.aspx')</script>")

            Dim t As Type = Me.GetType
            If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
            End If
        Catch ex As Exception

        End Try

    End Sub
    Protected Sub Button_Discount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Discount.Click
        Button_Discount.Visible = False
        Panel_Discount.Visible = True
    End Sub
    Protected Sub Button_ForwardDisReq_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_ForwardDisReq.Click
        Dim ccc As New SqlConnection(constring)

        Dim query As String = "SELECT SubDeptId FROM   Employee WHERE (EmpID = " + DropDownList_Consultant.SelectedValue + ")"
        Dim ccmd As New SqlCommand(query, ccc)
        ccc.Open()
        HiddenField_SubDeptId.Value = Convert.ToString(ccmd.ExecuteScalar())
        'Dim qr As String = "SELECT SubDeptId FROM Employee WHERE (EmpID = " + Session("Emp_Id") + ")"
        'Dim cmd As New SqlCommand(qr, ccc)
        HiddenField_BySubDeptId.Value = Session("SubDeptId") 'Convert.ToString(cmd.ExecuteScalar())
        ccc.Close()
        SqlDataSource3.Insert()
        'Response.Redirect("")
    End Sub
    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)



    End Sub
    Protected Sub DropDownList_Type_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim MyRow As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim index As Integer = MyRow.RowIndex
        CalculatePrice(index)


    End Sub
    Protected Sub TextBox_Discount_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim MyRow As GridViewRow = CType(CType(sender, Control).Parent.Parent, GridViewRow)
        Dim index As Integer = MyRow.RowIndex

        CalculatePrice(index)


    End Sub
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Button_Discount.Visible = True
        Panel_Discount.Visible = False
    End Sub
    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList1.SelectedIndexChanged

        If RadioButtonList1.SelectedValue = "2" Then
            If GridView_For_Services.Rows.Count <> 0 Then
                For index As Integer = 0 To GridView_For_Services.Rows.Count - 1
                    Dim TextBox_Discount As TextBox = GridView_For_Services.Rows(index).FindControl("TextBox_Discount")
                    Dim hiddfielddiscount As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_DiscountAmount")
                    Dim Label_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Price")
                    Dim Label_Original_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Original_Price")
                    hiddfielddiscount.Value = 0
                    TextBox_Discount.Text = "0"
                    Label_Original_Price.Text = Label_Price.Text
                Next
            End If
            GridView_For_Services.Enabled = False
            Label_Total_Discount.Text = "0"
            Label_Total_Discount.Visible = False
            DropDownList1.Visible = True
            TextBox_ComDiscounnt.Visible = True
            TextBox_ComDiscounnt.Text = "0"
            GridView_For_Services.DataBind()
        ElseIf RadioButtonList1.SelectedValue = "3" Then
            GridView_For_Services.Enabled = True
            Label_Total_Discount.Text = "0"
            Label_Total_Discount.Visible = True
            DropDownList1.Visible = False
            TextBox_ComDiscounnt.Visible = False
            GridView_For_Services.DataBind()
        ElseIf RadioButtonList1.SelectedValue = "1" Then
            GridView_For_Services.Enabled = True
            Label_Total_Discount.Text = "0"
            Label_Total_Discount.Visible = True
            DropDownList1.Visible = False
            TextBox_ComDiscounnt.Visible = False
            GridView_For_Services.DataBind()

        End If


    End Sub
    Protected Sub DropDownList1_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList1.SelectedIndexChanged

        If DropDownList1.SelectedValue = "%" Then

            If TextBox_ComDiscounnt.Text < 0 Or TextBox_ComDiscounnt.Text > 100 Then
                TextBox_ComDiscounnt.Text = 0
            End If
            Label_DiscountedTotal.Text = Convert.ToString(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(Label_Grand_Total.Text) / 100 * Convert.ToDouble(TextBox_ComDiscounnt.Text))
        ElseIf DropDownList1.SelectedValue = "Rs." Then

            If TextBox_ComDiscounnt.Text < 0 Or Convert.ToDouble(TextBox_ComDiscounnt.Text) > Convert.ToDouble(Label_Grand_Total.Text) Then
                TextBox_ComDiscounnt.Text = 0
            End If
            Label_DiscountedTotal.Text = Convert.ToDecimal(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(TextBox_ComDiscounnt.Text))

        End If

    End Sub
    Protected Sub TextBox_ComDiscounnt_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles TextBox_ComDiscounnt.TextChanged
        If DropDownList1.SelectedValue = "%" Then

            If TextBox_ComDiscounnt.Text < 0 Or TextBox_ComDiscounnt.Text > 100 Then
                TextBox_ComDiscounnt.Text = 0
            End If
            Label_DiscountedTotal.Text = Convert.ToString(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(Label_Grand_Total.Text) / 100 * Convert.ToDouble(TextBox_ComDiscounnt.Text))
        ElseIf DropDownList1.SelectedValue = "Rs." Then

            If TextBox_ComDiscounnt.Text < 0 Or Convert.ToDouble(TextBox_ComDiscounnt.Text) > Convert.ToDouble(Label_Grand_Total.Text) Then
                TextBox_ComDiscounnt.Text = 0
            End If
            Label_DiscountedTotal.Text = Convert.ToString(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(TextBox_ComDiscounnt.Text))

        End If

    End Sub
    Protected Sub btn_discount_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_discount.Click
        If RadioButtonList1.SelectedValue = 1 Then



            If Len(Flag.Value) > Len(done) Or done = "1" Then
                HiddenField_Total_Discount.Value = Convert.ToInt32(Convert.ToDecimal(co.Remove_Coma(Label_Total_Discount.Text)))
                done = Flag.Value
                If (Convert.ToDecimal(Label_Total_Discount.Text) <> 0) Then
                    SqlDataSource_Discount_Main.Insert()
                End If



                For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
                    Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                    Dim Discount As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_DiscountAmount")
                    Dim hid_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_ID")
                    'Dim chk_Doctor As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox_Doctor_Discount")
                    Dim hid_Doctor_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_doctor_ID")
                    Dim txt_Doctor_Share As TextBox = GridView_For_Services.Rows(count).FindControl("txt_doc_dis")

                    If String.IsNullOrEmpty(Discount.Value.Trim()) Then
                        Discount.Value = "0"
                    End If
                    If String.IsNullOrEmpty(txt_Doctor_Share.Text.Trim()) Then
                        txt_Doctor_Share.Text = "0"
                    End If
                    ' If chk_Doctor.Checked = True Then
                    HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
                    HiddenField_Doctor_Amount.Value = Convert.ToDouble(co.Remove_Coma(txt_Doctor_Share.Text))
                    ' Else
                    'HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
                    'HiddenField_Doctor_Amount.Value = 0
                    ' End If

                    HiddenField_ID.Value = hid_ID.Value
                    HiddenField_Amount.Value = Convert.ToDouble(co.Remove_Coma(Discount.Value))

                    If Convert.ToDouble(co.Remove_Coma(Discount.Value)) <> 0 Then
                        SqlDataSource_Discount_Sub.Insert()
                    End If

                Next

                GridView_For_Services.DataBind()

                TextBox_Percentage_Discount.Text = 0
                TextBox_Other_Discount.Text = 0

                TextBox_Description.Text = ""
            End If
        ElseIf RadioButtonList1.SelectedValue = 2 Then
            '
            '
            'Comulative discount
            '
            If Len(Flag.Value) > Len(done) Or done = "1" Then
                HiddenField_Total_Discount.Value = Convert.ToInt32(Convert.ToDecimal(Convert.ToDouble(Label_Grand_Total.Text) - Convert.ToDouble(Label_DiscountedTotal.Text)))
                done = Flag.Value
                If (Convert.ToDecimal(HiddenField_Total_Discount.Value) <> 0) Then
                    SqlDataSource_Discount_Main.Insert()
                End If


                Dim totalamount As Double = Label_Grand_Total.Text
                Dim discountedamount As Double = Label_DiscountedTotal.Text
                Dim discountamount As Double = totalamount - discountedamount
                Dim ratio As Double = discountamount / totalamount

                For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
                    Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                    ' Dim Discount As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_DiscountAmount")
                    Dim hid_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_ID")

                    Dim hid_Doctor_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_doctor_ID")

                    HiddenField_Doctor_ID.Value = hid_Doctor_ID.Value
                    HiddenField_Doctor_Amount.Value = Convert.ToDouble(Original_Price.Text) * ratio


                    HiddenField_ID.Value = hid_ID.Value
                    HiddenField_Amount.Value = Convert.ToDouble(Original_Price.Text) * ratio


                    SqlDataSource_Discount_Sub.Insert()


                Next

                GridView_For_Services.DataBind()

                TextBox_Percentage_Discount.Text = 0
                TextBox_Other_Discount.Text = 0

                TextBox_Description.Text = ""
            End If

            '
            '
            'Comulative discount
            '
        End If
        Response.Redirect("Discount_Search.aspx")
    End Sub
    Protected Sub GridView_Discount_Main_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Discount_Main.SelectedIndexChanged

        GridView_Discount_Sub.DataBind()

    End Sub
    ' ===============================================================================================================
    '                                                               User Define Function
    ' ===============================================================================================================

    Sub init_grid()
        total = 0
        totalAmount = 0
        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
            Dim chk As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")
            Dim chk_doctor As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox_Doctor_Discount")
            Dim hid_Doctor_ID As HiddenField = GridView_For_Services.Rows(count).FindControl("HiddenField_doctor_ID")
            If hid_Doctor_ID.Value <> "0" Then
                chk_doctor.Enabled = True
            Else
                chk_doctor.Enabled = False
            End If

            If chk.Checked = True Then

                Dim Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                Dim Discount As TextBox = GridView_For_Services.Rows(count).FindControl("TextBox_Discount")
                Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Original_Price")
                If Price.Text.Contains(".") Then
                    If Right(Price.Text, (Price.Text.Length - (Price.Text.IndexOf(".") + 1))).Length >= 2 Then
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf(".")))) + "." + Right(Price.Text, 2)
                    ElseIf Right(Price.Text, (Price.Text.Length - (Price.Text.IndexOf(".") + 1))).Length = 1 Then
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf(".")))) + "." + Right(Price.Text, 1)
                    Else
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf("."))))
                    End If
                Else
                    Price.Text = co.place_Coma(Price.Text)
                End If
                Discount.Text = 0
            End If
        Next


    End Sub
    Sub amount()
        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
            Dim chk As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                Dim Discount As TextBox = GridView_For_Services.Rows(count).FindControl("TextBox_Discount")
                Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Original_Price")

                If Price.Text.Contains(".") Then
                    If Right(Price.Text, (Price.Text.Length - (Price.Text.IndexOf(".") + 1))).Length >= 2 Then
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf(".")))) + "." + Right(Price.Text, 2)
                    ElseIf Right(Price.Text, (Price.Text.Length - (Price.Text.IndexOf(".") + 1))).Length = 1 Then
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf(".")))) + "." + Right(Price.Text, 1)
                    Else
                        Price.Text = co.place_Coma(CInt(Left(Price.Text, Price.Text.IndexOf("."))))
                    End If






                Else
                    Price.Text = co.place_Coma(Price.Text)
                End If






                If TextBox_Other_Discount.Text <> 0 Then
                    Discount.Text = CInt(co.Remove_Coma(Discount.Text)) + Math.Round((((Convert.ToDecimal(co.Remove_Coma(Price.Text)) / Convert.ToDecimal(co.Remove_Coma(CInt(HiddenField_bill_Amount.Value)))) * CInt(co.Remove_Coma(TextBox_Other_Discount.Text)))), 2)

                    If Discount.Text.Contains(".") Then
                        If Right(Discount.Text, (Discount.Text.Length - (Discount.Text.IndexOf(".") + 1))).Length >= 2 Then
                            Discount.Text = co.place_Coma(CInt(Left(Discount.Text, Discount.Text.IndexOf(".")))) + "." + Right(Discount.Text, 2)
                        ElseIf Right(Discount.Text, (Discount.Text.Length - (Discount.Text.IndexOf(".") + 1))).Length = 1 Then
                            Discount.Text = co.place_Coma(CInt(Left(Discount.Text, Discount.Text.IndexOf(".")))) + "." + Right(Discount.Text, 1)
                        Else
                            Discount.Text = co.place_Coma(CInt(Left(Discount.Text, Discount.Text.IndexOf("."))))
                        End If

                    Else
                        Discount.Text = co.place_Coma(Discount.Text)
                    End If

                End If

                If (Convert.ToDecimal(Price.Text) - Convert.ToDecimal(Discount.Text)) >= 0 Then

                    Original_Price.Text = Convert.ToDecimal(Convert.ToDecimal(co.Remove_Coma(Price.Text)) - Convert.ToDecimal(co.Remove_Coma(Discount.Text)))

                    If Original_Price.Text.Contains(".") Then
                        If Right(Original_Price.Text, (Original_Price.Text.Length - (Original_Price.Text.IndexOf(".") + 1))).Length >= 2 Then
                            Original_Price.Text = co.place_Coma(CInt(Left(Original_Price.Text, Original_Price.Text.IndexOf(".")))) + "." + Right(Original_Price.Text, 2)
                        ElseIf Right(Original_Price.Text, (Original_Price.Text.Length - (Original_Price.Text.IndexOf(".") + 1))).Length = 1 Then
                            Original_Price.Text = co.place_Coma(CInt(Left(Original_Price.Text, Original_Price.Text.IndexOf(".")))) + "." + Right(Original_Price.Text, 1)
                        Else
                            Original_Price.Text = co.place_Coma(CInt(Left(Original_Price.Text, Original_Price.Text.IndexOf("."))))
                        End If






                    Else
                        Original_Price.Text = co.place_Coma(Original_Price.Text)
                    End If

                    total = total + Convert.ToDecimal(co.Remove_Coma(Discount.Text))
                    totalAmount = totalAmount + Convert.ToDecimal(co.Remove_Coma(Original_Price.Text))

                Else
                    Discount.Text = 0
                End If
            End If

        Next
        If (total + Convert.ToDecimal(co.Remove_Coma(TextBox_Other_Discount.Text))) <= totalAmount Then
            Label_Grand_Total.Text = co.place_Coma(Math.Round(total))
            Label_Total_Discount.Text = co.place_Coma(Math.Round(total))
            HiddenField_Total_Discount.Value = co.Remove_Coma(Label_Total_Discount.Text)
        End If

    End Sub
    Sub Percentage()
        Dim total As Integer = 0
        Dim totalAmount As Integer = 0
        HiddenField_bill_Amount.Value = 0
        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
            Dim chk As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")
            If chk.Checked = True Then
                Dim Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                Dim Discount As TextBox = GridView_For_Services.Rows(count).FindControl("TextBox_Discount")
                Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Original_Price")
                Price.Text = co.place_Coma(Price.Text)
                HiddenField_bill_Amount.Value = CInt(co.Remove_Coma(HiddenField_bill_Amount.Value)) + CInt(co.Remove_Coma(Price.Text))

                If TextBox_Percentage_Discount.Text <> 0 Then
                    Discount.Text = CInt(co.Remove_Coma(Discount.Text)) + (Math.Round(((Convert.ToDecimal(co.Remove_Coma(Price.Text)) * Convert.ToDecimal(co.Remove_Coma(TextBox_Percentage_Discount.Text))) / 100)))
                    If Discount.Text.Contains(".") Then
                        Discount.Text = co.place_Coma(Left(Discount.Text, (Discount.Text.IndexOf(".")))) + Right(Discount.Text, 2)
                    Else
                        Discount.Text = co.place_Coma(Discount.Text)
                    End If

                End If

                If (Convert.ToDecimal(Price.Text) - Convert.ToDecimal(Discount.Text)) >= 0 Then
                    Original_Price.Text = Convert.ToDecimal(Convert.ToDecimal(co.Remove_Coma(Price.Text)) - Convert.ToDecimal(co.Remove_Coma(Discount.Text)))

                    If Original_Price.Text.Contains(".") Then
                        Original_Price.Text = co.place_Coma(CInt(Left(Original_Price.Text, Original_Price.Text.IndexOf(".")))) + "." + Right(Original_Price.Text, 2)
                    Else
                        Original_Price.Text = co.place_Coma(Original_Price.Text)
                    End If

                    total = total + Convert.ToDecimal(co.Remove_Coma(Discount.Text))
                    totalAmount = totalAmount + Convert.ToDecimal(co.Remove_Coma(Original_Price.Text))
                Else
                    Discount.Text = 0
                End If

            End If
        Next
        If (total + Convert.ToDecimal(co.Remove_Coma(TextBox_Other_Discount.Text))) <= totalAmount Then
            Label_Grand_Total.Text = co.place_Coma(Math.Round(total))
            Label_Total_Discount.Text = co.place_Coma(Math.Round(total))

            HiddenField_Total_Discount.Value = co.Remove_Coma(Label_Total_Discount.Text)
        End If

    End Sub
    Sub getamount()
        Dim valtotal As Int64 = 0
        For count As Integer = 0 To GridView_For_Services.Rows.Count - 1
            Dim chk As CheckBox = GridView_For_Services.Rows(count).FindControl("CheckBox1")
            If chk.Checked = False Then
                Dim Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Price")
                Dim Discount As TextBox = GridView_For_Services.Rows(count).FindControl("TextBox_Discount")
                Dim Original_Price As Label = GridView_For_Services.Rows(count).FindControl("Label_Original_Price")
                Original_Price.Text = co.place_Coma(Convert.ToDouble(co.Remove_Coma(Price.Text)) - Convert.ToDouble(co.Remove_Coma(Discount.Text)))
                valtotal = valtotal + Math.Floor(Convert.ToDouble(co.Remove_Coma(Discount.Text)))
            End If
        Next
        Label_Total_Discount.Text = co.place_Coma(Convert.ToInt64(co.Remove_Coma(Label_Total_Discount.Text)) + valtotal)
    End Sub
    Sub CalculatePrice(ByVal index As Integer)
        Dim Label_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Price")
        Dim TextBox_Discount As TextBox = GridView_For_Services.Rows(index).FindControl("TextBox_Discount")
        Dim TextBox_Doc_Discount As TextBox = GridView_For_Services.Rows(index).FindControl("txt_doc_dis")
        Dim DropDownList_Type As DropDownList = GridView_For_Services.Rows(index).FindControl("DropDownList_Type")
        Dim Label_Original_Price As Label = GridView_For_Services.Rows(index).FindControl("Label_Original_Price")
        Dim HiddenField_ID As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_ID")
        Dim CheckBox1 As CheckBox = GridView_For_Services.Rows(index).FindControl("CheckBox1")
        Dim HiddenField_Doctor_ID As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_Doctor_ID")
        Dim CheckBox_Doctor_Discount As CheckBox = GridView_For_Services.Rows(index).FindControl("CheckBox_Doctor_Discount")
        Dim HiddenField_DiscountAmount As HiddenField = GridView_For_Services.Rows(index).FindControl("HiddenField_DiscountAmount")
        Dim hf_Doc_MAX_Dis As HiddenField = GridView_For_Services.Rows(index).FindControl("hf_Doc_MAX_Dis")
        Dim C_limit As Integer = TextBox_Doc_Discount.Attributes("max")
        If String.IsNullOrEmpty(TextBox_Discount.Text.Trim()) Then
            TextBox_Discount.Text = "0"
        End If
        If String.IsNullOrEmpty(TextBox_Doc_Discount.Text.Trim()) Then
            TextBox_Doc_Discount.Text = "0"
        End If

        If DropDownList_Type.SelectedValue = "%" Then

            If Convert.ToDouble(TextBox_Discount.Text) < 0 Or Convert.ToDouble(TextBox_Discount.Text) > 100 Then
                TextBox_Discount.Text = 0
            End If

            HiddenField_DiscountAmount.Value = Convert.ToString(Convert.ToDouble(Label_Price.Text) / 100 * Convert.ToDouble(TextBox_Discount.Text))

        ElseIf DropDownList_Type.SelectedValue = "Rs." Then
            If Convert.ToDouble(TextBox_Discount.Text) <= 0 Or Convert.ToDouble(TextBox_Discount.Text) > Label_Price.Text Then
                TextBox_Discount.Text = 0

            End If
            HiddenField_DiscountAmount.Value = TextBox_Discount.Text
        End If

        Label_Original_Price.Text = Convert.ToString(Convert.ToDouble(Label_Price.Text) - Convert.ToDouble(HiddenField_DiscountAmount.Value))

        If CDbl(TextBox_Doc_Discount.Text.Trim()) > CDbl(HiddenField_DiscountAmount.Value) Then
            TextBox_Doc_Discount.Text = HiddenField_DiscountAmount.Value
        End If
        If CDbl(HiddenField_DiscountAmount.Value) < CDbl(hf_Doc_MAX_Dis.Value) Or CDbl(HiddenField_DiscountAmount.Value) < C_limit Then

            TextBox_Doc_Discount.Attributes.Remove("max")
            TextBox_Doc_Discount.Attributes.Add("max", HiddenField_DiscountAmount.Value)
        Else
            TextBox_Doc_Discount.Attributes.Add("max", hf_Doc_MAX_Dis.Value)
        End If

        If Label_Original_Price.Text = Label_Price.Text Then
            TextBox_Doc_Discount.Attributes.Add("max", hf_Doc_MAX_Dis.Value)
        End If

    End Sub

    Protected Sub TextBox_ComDiscounnt_TextChanged1(sender As Object, e As EventArgs)
        'If Label_DiscountedTotal.Text > "0" Then
        '    btn_discount.Visible = True
        'Else
        '    btn_discount.Visible = False
        'End If
    End Sub
End Class
