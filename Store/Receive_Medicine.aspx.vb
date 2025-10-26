Imports System.Data
Imports System.Data.SqlClient
Partial Class Store_Receive_Medicine

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            WebDateChooser_date_from.Value = Date.Now.AddMonths(-6).ToString("dd/MM/yyyy")
            WebDateChooser_date_To.Value = Date.Now.ToString("dd/MM/yyyy")
        End If

        Load_date()

    End Sub

    Protected Sub Button_Seach_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Seach.Click
        Load_date()

        GridView1.DataBind()
        GridView1.PageSize = 60

        '        Label2.Text = (GridView1.Rows.Count).ToString + " {Rows} "

    End Sub


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click

        Dim url As String = String.Format("Receive_Purchase_medicine.aspx?dept_ID={0}&Sub_Dept_ID={1} &Company_ID={2}&DD_Order={3}&from_Date={4}&To_Date={5}", DD_Department.SelectedValue, DD_Sub_Department.SelectedValue, DDL_Company.SelectedValue, DropDownList_Order.SelectedValue, HiddenField_from_date.Value, HiddenField_to_date.Value)
        Response.Redirect(url)
        'Show_Report()


    End Sub



    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbl As Button = sender
        'Label3.Text = lbl.CommandArgument + " " + DD_Department.SelectedValue + " " + DD_Sub_Department.SelectedValue + " " + DDL_Company.SelectedValue + " " + DropDownList_Order.SelectedValue + " " + HiddenField_from_date.Value + " " + HiddenField_to_date.Value
        
    End Sub

    Protected Sub Load_date()
        
        If WebDateChooser_date_from.Text = "Null" Then

            HiddenField_from_date.Value = 0
        Else
            Dim date_from() As String
            date_from = WebDateChooser_date_from.Text.ToString.Split("/")
            HiddenField_from_date.Value = date_from(2) + date_from(1) + date_from(0) 'date_from(1) + "/" + date_from(0) + "/" + date_from(2)
        End If


        If WebDateChooser_date_To.Text = "Null" Then
            HiddenField_to_date.Value = 0
        Else
            Dim date_to() As String
            date_to = WebDateChooser_date_To.Text.ToString.Split("/")
            HiddenField_to_date.Value = date_to(2) + date_to(1) + date_to(0) 'date_to(1) + "/" + date_to(0) + "/" + date_to(2)
        End If

    End Sub

    Protected Sub SqlDataSource_Select_Requisition_Selected(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.SqlDataSourceStatusEventArgs) Handles SqlDataSource_Select_Requisition.Selected
        Dim Rows As String = "0"
        If Not String.IsNullOrEmpty(e.AffectedRows) Then
            Rows = e.AffectedRows
        End If
        Label2.Text = Rows + " Record(s) Found "
    End Sub
End Class
