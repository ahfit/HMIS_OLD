Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration


Partial Class Patient_RegistrationPreOperativeCheckList
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            fillgrid()
        End If

    End Sub
    Protected Sub fillgrid()
        Try


            Dim Dt As DataTable = New DataTable()

            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd As SqlCommand = New SqlCommand("USP_SlectPreOperativeCheckList", con)
            cmd.CommandType = CommandType.StoredProcedure

            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            sda.Fill(Dt)
            GridView1.DataSource = Dt
            GridView1.DataBind()


            Dim Dt1 As DataTable = New DataTable()
            Dim con1 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd1 As SqlCommand = New SqlCommand("Select top 1 [Result] From [Treatment].[dbo].[Patient_Vitals] Where RegNo =@regno and YearlyNo =@rYearlyNo and VitalID =8", con1)
            cmd.CommandType = CommandType.Text
            cmd.Parameters.AddWithValue("@regno", Session("RegistrationNo"))
            cmd.Parameters.AddWithValue("@rYearlyNo", Session("YearlyNo"))
            Dim sda1 As SqlDataAdapter = New SqlDataAdapter(cmd1)
            sda.Fill(Dt1)
            If Dt1.Rows.Count > 0 Then
                txtPulse.Text = Convert.ToString(Dt1.Rows(0)(0))
            End If



            Dim Dt2 As DataTable = New DataTable()
            Dim con2 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd2 As SqlCommand = New SqlCommand("Select top 1 [Result] From [Treatment].[dbo].[Patient_Vitals] Where RegNo =@regno and YearlyNo =@rYearlyNo and VitalID =6", con2)
            cmd2.CommandType = CommandType.Text
            cmd2.Parameters.AddWithValue("@regno", Session("RegistrationNo"))
            cmd2.Parameters.AddWithValue("@rYearlyNo", Session("YearlyNo"))
            Dim sda2 As SqlDataAdapter = New SqlDataAdapter(cmd2)
            sda.Fill(Dt2)
            If Dt2.Rows.Count > 0 Then
                txtBP.Text = Convert.ToString(Dt2.Rows(0)(0))
            End If


            Dim Dt3 As DataTable = New DataTable()
            Dim con3 As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd3 As SqlCommand = New SqlCommand("Select top 1 [Result] From [Treatment].[dbo].[Patient_Vitals] Where RegNo =@regno and YearlyNo =@rYearlyNo and VitalID =4", con3)
            cmd3.CommandType = CommandType.Text
            cmd3.Parameters.AddWithValue("@regno", Session("RegistrationNo"))
            cmd3.Parameters.AddWithValue("@rYearlyNo", Session("YearlyNo"))
            Dim sda3 As SqlDataAdapter = New SqlDataAdapter(cmd3)
            sda.Fill(Dt3)
            If Dt3.Rows.Count > 0 Then
                txtTemp.Text = Convert.ToString(Dt3.Rows(0)(0))
            End If
        Catch ex As Exception

        End Try


    End Sub




    Protected Sub Button1_Click(sender As Object, e As EventArgs)
        For Each row As GridViewRow In GridView1.Rows

            Dim _str As String = TryCast(row.FindControl("HiddenField1"), HiddenField).Value
            Dim rdl As RadioButtonList = row.FindControl("RadioButtonList1")
            Dim QAns As String = rdl.SelectedItem.Text
            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd As SqlCommand = New SqlCommand("InsetPreOperativecheckboxlist", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@qid", _str)
            cmd.Parameters.AddWithValue("@Qanswer", QAns)
            cmd.Parameters.AddWithValue("@regn", Session("RegistrationNo"))
            cmd.Parameters.AddWithValue("@rYearlyNo", Session("YearlyNo"))
            cmd.Parameters.AddWithValue("@empno", Session("Emp_ID"))
            con.Open()
            cmd.ExecuteNonQuery()
            con.Close()
        Next


    End Sub
    Protected Sub GridView1_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim _str As String = TryCast(e.Row.FindControl("HiddenField1"), HiddenField).Value

            Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("NurseConnectionString").ToString())
            Dim cmd As SqlCommand = New SqlCommand("CheckOperativecheckboxlist", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@qid", _str)
            cmd.Parameters.AddWithValue("@regn", Session("RegistrationNo"))
            cmd.Parameters.AddWithValue("@rYearlyNo", Session("YearlyNo"))
            Dim sda As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            Dim rdl As RadioButtonList = e.Row.FindControl("RadioButtonList1")
            sda.Fill(dt)
            If dt.Rows.Count > 0 Then
                If Convert.ToString(dt.Rows(0)(0)) = "N/A" Then

                    rdl.SelectedValue = 0
                ElseIf Convert.ToString(dt.Rows(0)(0)) = "Yes" Then

                    rdl.SelectedValue = 1
                ElseIf Convert.ToString(dt.Rows(0)(0)) = "No" Then
                    rdl.SelectedValue = 2

                End If
            End If
        End If
    End Sub
    Protected Sub Button2_Click(sender As Object, e As EventArgs)
        Response.Redirect("~/Nursing/PreOperativeCheckListRpt.aspx")
    End Sub
End Class
