
Partial Class Patient_Billing_Advance_payment
    Inherits System.Web.UI.Page
    Dim voucher As New voucher_insertion
    Dim constring As String = ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString
    Dim Procedurename As String = "Temp_insert_Reciept_Voucher_payment"
    Dim co As New Coma

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click


        If Basic_Checks._Textbox_Not_Empty(TextBox_Payment, Label1, "*") Then


            Try

                HiddenField_cheque_Date.Value = WebDateChooser1.Value
                SqlDataSource_Payment.InsertParameters("Amount").DefaultValue = TextBox_Payment.Text.Trim().Replace(",", "")
                SqlDataSource_Payment.Insert()
                'If DropDownList_Payment_Type.SelectedValue = "Cash" Then
                '    SqlDataSourceCounterClose.Insert()
                'End If


                GridView1.DataBind()
                If HiddenFieldMainId.Value = String.Empty Then
                    Label2.Text = "Kindly wait 1 mint to enter advance of same patient..."
                Else
                    TextBox_approval_no.Text = ""
                    TextBox_Bank_Name.Text = ""
                    TextBox_Branch_Name.Text = ""
                    TextBox_Card_Service.Text = ""
                    TextBox_Cheque_no.Text = ""
                    TextBox_Cradit_Card_No.Text = ""
                    TextBox_description.Text = ""
                    TextBox_Payment.Text = ""

                    Session.Add("Description", TextBox_description.Text)
                    Dim sb As StringBuilder = New StringBuilder
                    sb.Append("<script language='javascript' type='text/javascript'>window.open('PatientAdvancesReport.aspx?Payment_No=" + HiddenFieldMainId.Value + "&YearlyNo=" + Session("YearlyNo") + "&RegNo=" + Session("RegistrationNo") + "&Type=Advance" + "')</script>")
                    'sb.Append(" window.open('patientServices.aspx')</script>")
                    Dim t As Type = Me.GetType
                    If (Not ClientScript.IsClientScriptBlockRegistered(t, "PopupScript")) Then
                        ClientScript.RegisterClientScriptBlock(t, "PopUpScript", sb.ToString())
                    End If

                    ' Response.Write()


                    'Response.Redirect("PatientAdvancesReport.aspx?Payment_No=" + HiddenFieldMainId.Value + "&PayID=" + Session("YearlyNo") + "&RegNo=" + Session("RegistrationNo") + "&Type=Advance")
                    'Response.Write("<script language='javascript' type='text/javascript'>window.open('../MainPage.aspx', '_top')</script>")
                    'Response.Redirect("Add_patient_SERVICE_Payment.aspx")
                End If
            Catch ex As Exception

            End Try


        End If



    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'this function use to chck that it is a  valid user or not ' 
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'Try
        '    If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
        '        Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
        '        'Response.Redirect("login.aspx")
        '    End If
        'Catch ex As Exception
        '    Response.Write(ex.Message)
        'End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        loginvalidate(Session("emp_id"), Session("Dept_Id"))
        Button_Save.Attributes.Add("OnClick", "return check()")
        If Not Page.IsPostBack Then
            WebDateChooser1.Value = Date.Now

        End If
    End Sub


    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        Session.Add("Description", "")
        If GridView1.Rows.Count <> 0 Then
            GridView1.HeaderRow.Cells(8).Visible = False
            GridView1.HeaderRow.Cells(9).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(8).Visible = False
                If GridView1.Rows(i).Cells(9).Text = "True" Then
                    GridView1.Rows(i).Cells(0).Enabled = False
                End If
                GridView1.Rows(i).Cells(9).Visible = False
            Next
        End If
        For count As Integer = 0 To GridView1.Rows.Count - 1
            GridView1.Rows(count).Cells(4).Text = co.place_Coma(GridView1.Rows(count).Cells(4).Text)
        Next

    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        If e.CommandName = "Delete" Then
            HiddenFieldPaymentID.Value = GridView1.Rows(e.CommandArgument).Cells(8).Text
            SqlDataSource_For_Grid.Delete()
            SqlDataSourceCounterClose.Delete()
        End If
    End Sub

    Protected Sub SqlDataSource_Payment_Inserted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Payment.Inserted
        'Response.Write("sdfdF")
        If Not IsDBNull(e.Command.Parameters("@PaymentNo").Value) Then
            Dim pay_id As String = e.Command.Parameters("@PaymentNo").Value
            HiddenFieldMainId.Value = pay_id
        Else
            HiddenFieldMainId.Value = String.Empty

        End If
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


    Protected Sub ddlDepartment_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlDepartment.SelectedIndexChanged
        DropDownList_Admin_Service_Package.DataBind()
    End Sub
End Class
