Imports System.IO

Partial Class Department
    Inherits System.Web.UI.Page

    Protected Sub save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles save.Click
        Try
            'Dim a, b As String
            HiddenFieldPhoneNo.Value = TextBox_PhoneNo.Text
            'Session("DeptPN") = a
            HiddenFieldFaxNo.Value = Textbox_FaxNo.Text
            'Session("DeptFN") = b
            'Session("DeptEmpID") = HODept.SelectedItem.Value
            'Response.Write("" + HODept.SelectedItem.Value + "")
            If save.Text = "Save" Then
                SqlDataSourceGridView.InsertParameters("Type").DefaultValue = DropDownList_Type.SelectedItem.Text
                SqlDataSourceGridView.Insert()
                GridView1.DataBind()
            Else

                SqlDataSourceGridView.Update()
                GridView1.DataBind()
            End If
            TextBoxDepartmentName.Text = ""
            Textbox_FaxNo.Text = ""
            TextBox_PhoneNo.Text = ""
            TextBoxLocation.Text = ""
            'DropDownList_Hospital.SelectedIndex = 0
            save.Text = "Save"

            Label1.ForeColor = Drawing.Color.Blue
            Label1.Text = "Your given Information has been Saved"
            GridView1.DataBind()
        Catch ex As Exception
            'Response.Write(ex.Message)
            ''  Label1.Text = "Your Given Information is Already Exist"
        End Try

    End Sub

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        'Try
        '    If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
        '        Response.Redirect("../login.aspx")
        '    End If
        'Catch ex As Exception
        '    response.write(ex.message)
        'End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' \\\\\\\\\\\\\\\\\\\\\\\\Code for Page Title & Style sheets---------Page_Title() Parameter is depth from root
        'Dim obj As New DrawMenu
        'Page.ClientScript.RegisterStartupScript([GetType], "onload", obj.Page_Title(1))
        ''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

        If Not IsPostBack Then
            HiddenField_Dept.Value = "%" + TextBoxDepartmentName.Text + "%"
            GridView1.DataBind()
        End If
        Try
            ' loginvalidate(Session("emp_id"), Session("dept_id"))
            save.Attributes.Add("OnClick", "return CheckRequired()")
            'Dim obj_menu As New DrawMenu
            'obj_menu.draw_menu(PanelMenu)
            '' \\\\\\\\\\\\\\\\\\\\\\\\Code for Page Title & Style sheets---------Page_Title() Parameter is depth from root
            'Dim obj1 As New DrawMenu
            'Page.ClientScript.RegisterStartupScript([GetType], "onload", obj1.Page_Title(2))
            ''\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        For i As Integer = 0 To GridView1.Rows.Count - 1

            If GridView1.Rows(i).Cells(8).Text = "0" Then
                GridView1.Rows(i).Cells(8).Text = "Administrative"
            ElseIf GridView1.Rows(i).Cells(8).Text = "2" Then
                GridView1.Rows(i).Cells(8).Text = "Clinical"
            End If
        Next
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim drp As DropDownList = GridView1.Rows(e.RowIndex).FindControl("DropDownList1")
        HiddenFieldHead.Value = drp.SelectedValue
        HiddenFieldDepartmentName.Value = GridView1.Rows(e.RowIndex).Cells(1).Text
        HiddenFieldID.Value = GridView1.SelectedValue
        Dim Drp_type As DropDownList = GridView1.Rows(e.RowIndex).FindControl("DropDownList_Edit_Type")
        HiddenField_Type.Value = Drp_type.SelectedValue
    End Sub

    Protected Sub ButtonSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSearch.Click
        HiddenField_Dept.Value = "%" + TextBoxDepartmentName.Text + "%"
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        Load_Control(GridView1.SelectedIndex)
    End Sub
    Protected Sub Load_Control(ByVal indx As Integer)

        Dim Label1 As Label = GridView1.Rows(indx).FindControl("Label1")
        Dim Label4 As Label = GridView1.Rows(indx).FindControl("Label4")
        Dim lblHspitalID As Label = GridView1.Rows(indx).FindControl("lblHOspItalid")


        DropDownList_Hospital.SelectedValue = lblHspitalID.Text

        HODept.SelectedIndex = HODept.Items.IndexOf(HODept.Items.FindByText(Label1.Text))
        TextBoxDepartmentName.Text = GridView1.Rows(indx).Cells(1).Text
        Try
            If GridView1.Rows(indx).Cells(3).Text = "&nbsp;" Then
                GridView1.Rows(indx).Cells(3).Text = ""
            Else
                TextBox_PhoneNo.Text = GridView1.Rows(indx).Cells(3).Text
            End If
            If GridView1.Rows(indx).Cells(4).Text = "&nbsp;" Then
                GridView1.Rows(indx).Cells(4).Text = ""
            Else
                Textbox_FaxNo.Text = GridView1.Rows(indx).Cells(4).Text
            End If

            If GridView1.Rows(indx).Cells(2).Text = "&nbsp;" Then
                GridView1.Rows(indx).Cells(2).Text = ""
            Else
                TextBoxLocation.Text = GridView1.Rows(indx).Cells(2).Text
            End If



        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        DropDownList_Type.SelectedValue = Label4.Text '.Items.IndexOf(DropDownList_Type.Items.FindByText(GridView1.Rows(indx).Cells(4).Text))
        save.Text = "Update"

    End Sub

    Protected Sub DropDownList_Hospital_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Hospital.SelectedIndexChanged
        GridView1.DataBind()
    End Sub

    Protected Sub btn_export_Click(sender As Object, e As EventArgs) Handles btn_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = ("Department Wise List" + ".xls")
        Response.ClearContent()
        Response.AddHeader("content-disposition", ("attachment;filename=" + fileName))
        Response.ContentType = "application/excel"
        Dim sw As StringWriter = New StringWriter
        Dim htm As HtmlTextWriter = New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        repAllCustomers.CssClass = "grid_dash"
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString)
        Response.End()
        ' HF_is_Report.Value = "0";
    End Sub
End Class
