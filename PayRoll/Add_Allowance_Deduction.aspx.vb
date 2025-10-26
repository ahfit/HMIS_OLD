Imports System.Data
Imports System.Collections.Generic
Imports System.Data.SqlClient

Partial Class PayRoll_Add_Allowance_Deduction
    Inherits System.Web.UI.Page

    Dim connection As [String] = ConfigurationManager.ConnectionStrings("PayRoll_ConnectionString").ToString()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            GetDropdownList()
            GVD_Allowance.DataBind()
        End If

    End Sub
    <Services.WebMethod()> _
    Public Shared Function SearchFinacial_Head(ByVal prefixText As String, ByVal count As Integer) As String()
        If (count = 0) Then
            count = 10
        End If


        Dim items As New List(Of String)
        Try
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            Dim ENC As New Encryption
            Dim constr As String = ConfigurationManager.ConnectionStrings("FinanceConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            con.Open()
            Dim command As SqlCommand = New SqlCommand("Select isnull(E_Code,'') +' '+ ISnull(E_Name,'') as Name,E_Code from Expenditure where isnull(E_Code,'') + isnull(E_Name,'') like '%" + prefixText.Trim() + "%'", con)
            command.CommandType = CommandType.Text
            da.SelectCommand = command
            da.Fill(ds)
            con.Close()
            For i As Integer = 0 To ds.Tables(0).Rows.Count - 1
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(ds.Tables(0).Rows(i).Item(0), ds.Tables(0).Rows(i).Item(1)))
            Next
        Catch ex As Exception
            HttpContext.Current.Response.Write(ex.Message)
        End Try
        Return items.ToArray()
    End Function


    Protected Sub BTN_Save_Click(sender As Object, e As EventArgs) Handles BTN_Save.Click
        SDS_Save.Insert()
        GVD_Allowance.DataBind()
        GVD_Deduction.DataBind()
    End Sub


    Private Sub GetDropdownList()
        Dim cmd As SqlCommand
        Dim con As New SqlConnection()

        Try
            con = New SqlConnection(connection)
            con.Open()
            cmd = New SqlCommand("select ID,Allow_Dedu_Name_Setup from AllowanceDeduction_Types ", con)
            DropDownList1.DataTextField = "Allow_Dedu_Name_Setup"
            DropDownList1.DataValueField = "ID"
            cmd.Parameters.AddWithValue("Allow_Dedu_Name_Setup", DropDownList1.SelectedValue)


            Dim da As New SqlDataAdapter(cmd)
            Dim dt As New DataTable()
            da.Fill(dt)
            DropDownList1.DataSource = dt
            DropDownList1.DataBind()
        Catch ex As Exception

            con.Close()
        End Try
    End Sub

    '=======================================================
    'Service provided by Telerik (www.telerik.com)
    'Conversion powered by NRefactory.
    'Twitter: @telerik
    'Facebook: facebook.com/telerik
    '=======================================================



    'Protected Sub chkApprovedAll_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
    '    Dim HeaderChk As CheckBox = sender

    '    If HeaderChk.Checked Then
    '        For index = 0 To GVD_Allowance.Rows.Count - 1
    '            Dim chk As CheckBox = GVD_Allowance.Rows(index).FindControl("chkApprove")
    '            chk.Checked = True
    '        Next
    '    Else
    '        For index = 0 To GVD_Allowance.Rows.Count - 1
    '            Dim chk As CheckBox = GVD_Allowance.Rows(index).FindControl("chkApprove")
    '            chk.Checked = False
    '        Next
    '    End If
    'End Sub



    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        GVD_Allowance.DataBind()
        GVD_Deduction.DataBind()
    End Sub

    Protected Sub chkApprove_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim constr As String = ConfigurationManager.ConnectionStrings("PayRoll_ConnectionString").ConnectionString
        Dim HeaderChk As CheckBox = sender
        Dim Row As GridViewRow = HeaderChk.NamingContainer


        Dim e_id As HiddenField = Row.FindControl("hfE_ID")

        If HeaderChk.Checked Then
            Dim sqlconn As SqlConnection = New SqlConnection(constr)
            Dim sqlCommand As SqlCommand = New SqlCommand("update Salary_Allowance_Deduction_Setup set ExclusivnessOfAmount='true' where E_ID=" + e_id.Value + "", sqlconn)



            sqlconn.Open()
            sqlCommand.ExecuteNonQuery()
            sqlconn.Close()
        Else
            Dim sqlconn As SqlConnection = New SqlConnection(constr)
            Dim sqlCommand As SqlCommand = New SqlCommand("update Salary_Allowance_Deduction_Setup set ExclusivnessOfAmount='False' where E_ID=" + e_id.Value + "", sqlconn)



            sqlconn.Open()
            sqlCommand.ExecuteNonQuery()
        End If


    End Sub




    Protected Sub GVD_Allowance_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GVD_Allowance.RowDataBound

        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim Check As CheckBox = e.Row.FindControl("chkApprove")
            Dim hfValue As HiddenField = e.Row.FindControl("hfExclusive")


            If hfValue.Value = "True" Then
                Check.Checked = True
            End If



        End If



    End Sub
End Class
