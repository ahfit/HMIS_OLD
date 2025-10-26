Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Partial Class Test_Results_Reception
    Inherits System.Web.UI.Page
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("../login.aspx")
            End If
        Catch ex As Exception
            Response.write(ex.message)
        End Try

    End Sub
    Protected Sub Refresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Refresh.Click
        Try
            ' Response.Write(Session("emp_id"))

            Response.Redirect("reception.aspx?" & Page.ClientQueryString.ToString)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
        Try
            loginvalidate(Session("emp_id"), Session("dept_id"))
            'Session.Add("UserID", Session("emp_id"))
            'Session.Add("DeptID", Session("dept_id")))
            'Session.Add("SubDeptID", Session("SubDeptID"))
            HiddenFieldSubDept.Value = Session("SubDeptID")
            Session.Timeout = 60
        Catch ex As Exception
            Response.write(ex.message)
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim ba As Integer
        If ba = 1 Then

        End If
        '  Session.Add("Procedure_Path", Request.QueryString(0))
        HiddenFieldSubDept.Value = Session("SubDeptID")
        form1.DefaultButton = "Search"
        If Page.IsPostBack = False Then
            abc(0)
        End If
        search1(0)
    End Sub
    Sub search1(ByVal a As Integer)
        Try
            If TextBox1.Text.Trim = "" Then
                HiddenFieldYearlyNo.Value = 0
            Else
                HiddenFieldYearlyNo.Value = TextBox1.Text.Trim
            End If



            If TextBoxPFname.Text.Trim = "" Then
                HiddenFieldpfname.Value = "%"
            Else
                HiddenFieldpfname.Value = TextBoxPFname.Text.Trim
            End If


            If TextBoxPMName.Text.Trim = "" Then
                HiddenFieldPMName.Value = "%"
            Else
                HiddenFieldPMName.Value = TextBoxPMName.Text.Trim
            End If


            If TextBoxRelation.Text.Trim = "" Then
                HiddenFieldRelation.Value = "%"
            Else
                HiddenFieldRelation.Value = TextBoxRelation.Text.Trim
            End If


            If TextBoxRFName.Text.Trim = "" Then
                HiddenFieldRelationFirstName.Value = "%"
            Else
                HiddenFieldRelationFirstName.Value = TextBoxRFName.Text.Trim
            End If


            If TextBoxRMName.Text.Trim = "" Then
                HiddenFieldRMName.Value = "%"
            Else
                HiddenFieldRMName.Value = TextBoxRMName.Text.Trim
            End If


            If TextBoxAge.Text.Trim = "" Then
                HiddenFieldAge.Value = 0
            Else
                HiddenFieldAge.Value = TextBoxAge.Text.Trim
            End If


            If TextBoxRegNo.Text.Trim = "" Then
                HiddenFieldRegNo.Value = "%"
            Else
                HiddenFieldRegNo.Value = TextBoxRegNo.Text.Trim
            End If

            Dim Procedure_Name As String = ""
            ' If Session("Procedure_Path") = 0 Then
            Procedure_Name = "Search_Emg_Dept_Patient_Pathalogy"
            ' ElseIf Session("Procedure_Path") = 1 Then
            ' Procedure_Name = "Search_Emg_Dept_Patient_For_Revist"
            ' End If
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedure_Name, con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@SubDeptNo", HiddenFieldSubDept.Value)
            param = mycommand.Parameters.AddWithValue("@Status", "false") 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@YearlyNo", HiddenFieldYearlyNo.Value)
            param = mycommand.Parameters.AddWithValue("@Request_type_ID", 1)
            param = mycommand.Parameters.AddWithValue("@PFName", HiddenFieldpfname.Value)
            param = mycommand.Parameters.AddWithValue("@PMName", HiddenFieldPMName.Value)
            param = mycommand.Parameters.AddWithValue("@RFName", HiddenFieldRelationFirstName.Value)
            param = mycommand.Parameters.AddWithValue("@RMName", HiddenFieldRMName.Value)
            param = mycommand.Parameters.AddWithValue("@Relation", HiddenFieldRelation.Value)
            param = mycommand.Parameters.AddWithValue("@age", HiddenFieldAge.Value)
            param = mycommand.Parameters.AddWithValue("@RegNo", HiddenFieldRegNo.Value)
            param = mycommand.Parameters.AddWithValue("@emp_id", Session("Emp_ID"))
            mycommand.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "ABC")
            mycommand.ExecuteNonQuery()
            GridView2.DataSource = ds.Tables(0)
            GridView2.AutoGenerateColumns = True
            GridView2.AllowPaging = False
            GridView2.PageSize = 10
            GridView2.PageIndex = a
            GridView2.DataBind()
            mycommand.Connection.Close()
            'GridView2.HeaderRow.Cells(2).Text = "Yearly No."
            'GridView2.HeaderRow.Cells(3).Text = "Registration No."
            'GridView2.HeaderRow.Cells(4).Text = "Patient Name"
            'GridView2.HeaderRow.Cells(5).Text = "Relative Name"
            'GridView2.HeaderRow.Cells(6).Text = "Age"
        Catch ex As Exception
            'Response.Write(ex.Message + " jhf ghj ")
        End Try

    End Sub

    Protected Sub GridView2_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.Load
        'GridView2.dat()
    End Sub
    Protected Sub GridView2_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView2.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    'Sub abc(ByVal a As String)

    '    Dim abcd As New HyperLinkField

    '    Dim s() As String = {"Record ID", "PIN No"}
    '    abcd.DataNavigateUrlFields = s
    '    If (a = "0") Then
    '        abcd.DataNavigateUrlFormatString = "historyexamination.aspx?PayId={0}&?RegNo={1}&cmo=cmo"
    '    Else
    '        abcd.DataNavigateUrlFormatString = "historyexamination_revisit.aspx?PayId={0}&?RegNo={1}&cmo=cmo"
    '    End If

    '    abcd.Text = "View Patient"
    '    GridView2.Columns.Add(abcd)




    'End Sub
    Sub abc(ByVal a As String)
        Dim abcd As New ButtonField

        abcd.CommandName = "Select"
        abcd.DataTextField = "Record_ID"
        abcd.ButtonType = ButtonType.Link
        GridView2.Columns.Add(abcd)

    End Sub

    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        GridView2.HeaderRow.Cells(2).Visible = False
        For i As Integer = 0 To GridView2.Rows.Count - 1
            GridView2.Rows(i).Cells(2).Visible = False
        Next
        GridView2.HeaderRow.Cells(1).Text = "Yearly No."
        GridView2.HeaderRow.Cells(3).Text = "Registration No."
        GridView2.HeaderRow.Cells(4).Text = "Patient Name"
        GridView2.HeaderRow.Cells(5).Text = "Relative Name"
        GridView2.HeaderRow.Cells(6).Text = "Age"
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.SelectedIndexChanged
        Try
            Dim Record_ID As String = GridView2.Rows(GridView2.SelectedIndex).Cells(2).Text
            Dim PIN_No As String = GridView2.Rows(GridView2.SelectedIndex).Cells(3).Text
            HiddenFieldEMpID.Value = Session("emp_ID")
            HiddenFieldYearlyNo.Value = ""
            HiddenFieldRegNo.Value = ""
            HiddenFieldYearlyNo.Value = Record_ID
            HiddenFieldRegNo.Value = PIN_No
            ' SqlDataSourceUpdate.Update()
            ' If Session("Procedure_Path") = 0 Then
            Response.Redirect("PatientTestReportMain.aspx?YearlyNo=" & Record_ID & "&RegNo=" & PIN_No & "&cmo=cmo")
            'ElseIf Session("Procedure_Path") = 1 Then
            'Response.Redirect("historyexamination_revisit.aspx?PayId=" & Record_ID & "&?RegNo=" & PIN_No & "&cmo=cmo")
            'End If
        Catch ex As Exception

        End Try
        HiddenFieldYearlyNo.Value = ""
        HiddenFieldRegNo.Value = ""
    End Sub
End Class


