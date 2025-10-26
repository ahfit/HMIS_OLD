Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_EMR_Pt_Plan
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString
    Dim ENC As New Encryption


    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim con As New SqlConnection
        con.ConnectionString = constr
        con.Open()
        Try
            'HF_physician_category_notes.Value = DropDownList1.SelectedItem.Text            
            Dim command As SqlCommand = New SqlCommand("INSERT INTO pt_Treatment_Plan(Reg_No, Yearly_No, Plan_Detail, emp_id, Dept_ID, Type, Phyci_id)VALUES(@Reg_No,@Yearly_No,@Plan_Detail,@emp_id,@Dept_ID,'Phy',@id)", con)
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))
            command.Parameters.AddWithValue("@Plan_Detail", WebHtmlEditor1.Text)
            command.Parameters.AddWithValue("@emp_id", Session("emp_id"))
            command.Parameters.AddWithValue("@Dept_ID", Session("dept_id"))

            command.Parameters.AddWithValue("@id", DropDownList1.SelectedValue)
            command.ExecuteNonQuery()
            GridView1.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        GridView_Employee_info.DataBind()
        GridView_Employee_info.Visible = True
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))

        Dim con As New SqlConnection
        con.ConnectionString = constr
        con.Open()
        Try
            Session("Module_ID") = user_authen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Dim command As SqlCommand = New SqlCommand("Select Plan_Detail from pt_Treatment_Plan where reg_no=@reg_no and Yearly_no=@Yearly_no", con)
            command.Parameters.AddWithValue("@reg_no", Session("RegistrationNo"))
            command.Parameters.AddWithValue("@yearly_no", Session("YearlyNo"))
            Dim reader As SqlDataReader = command.ExecuteReader(CommandBehavior.CloseConnection)
            If Page.IsPostBack = True Then
            Else
                While reader.Read
                    WebHtmlEditor1.Text = reader.Item(0).ToString
                End While
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub

    Protected Sub GridView_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Try
            Dim hid As HiddenField = GridView1.Rows(GridView1.SelectedIndex).FindControl("HiddenField1")
            WebHtmlEditor1.Text = hid.Value

        Catch ex As Exception

        End Try

    End Sub
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Response.Redirect("Pt_Plan_Report.aspx")
    End Sub
    Protected Sub btn_transfer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_transfer.Click
        Panel2.Visible = True
        GridView_Employee_info.DataBind()
        GridView_Employee_info.Visible = True
        
    End Sub

    Protected Sub btn_cancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_cancel.Click
        Panel2.Visible = False
    End Sub

    Protected Sub Button_transfer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_transfer.Click
        Sql_transfer.Insert()
        'DropDownListFloor.DataBind()
        GridView_Employee_info.DataBind()
        Label4.Text = "Patient has been Transfered .."

    End Sub

    Protected Sub GridView_Employee_info_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Employee_info.PreRender

        For Each row As GridViewRow In GridView_Employee_info.Rows
            Dim P_HF As HiddenField = row.FindControl("HF_P_Name")
            Dim P_Prefexname As Label = row.FindControl("lbl_prefix")
            Dim P_Fname As Label = row.FindControl("lbl_FName")
            Dim P_MName As Label = row.FindControl("lbl_MName")
            Dim P_LName As Label = row.FindControl("lbl_LName")
            P_Prefexname.Text += " " + ENC.Encrypt_Main(P_Fname.Text, False)
            P_Prefexname.Text += " " + ENC.Encrypt_Main(P_MName.Text, False)
            P_Prefexname.Text += " " + ENC.Encrypt_Main(P_LName.Text, False)
            P_Fname.Text = String.Empty
            P_MName.Text = String.Empty
            P_LName.Text = String.Empty

        Next
    End Sub

    Protected Sub DropDownListFloor_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListFloor.SelectedIndexChanged
        'DropDownListFloor.DataBind()
    End Sub

    Protected Sub LinkButton1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim i As Integer = 0
        'Dim lb As LinkButton = sender
        'WebHtmlEditor1.Text = lb.CommandArgument.ToString()


    End Sub

    Protected Sub LinkButton1_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim i As Integer = 0
        Dim lb As LinkButton = sender
        WebHtmlEditor1.Text = lb.CommandArgument.ToString()
    End Sub

    Protected Sub GridView1_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView1.RowCommand
        Dim i As Integer = 0
    End Sub
End Class
