Imports System.Data
Imports System.Data.SqlClient
Partial Class Cash_Reception
    Inherits System.Web.UI.Page
    Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
        'loginvalidate(Session("emp_id"), Session("dept_id")))
        'Session.Add("UserID", Session("emp_id"))
        'Session.Add("DeptID", Session("dept_id")))
        'Session.Add("SubDeptID", Session("SubDeptID"))
        HiddenFieldSubDept.Value = 18
        Session.Timeout = 30
        ' GridView2.DataSourceID = SqlDataSource_Patients.ID
        ' GridView2.DataBind()
        ' GridView2.AutoGenerateColumns = True
        If Page.ispostback = False Then
            search1(0)
        End If
        '  Response.Write(Session("SubDeptID"))
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



            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Search_Patients_for_Amount", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure

            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@SubDeptNo", Session("SubDeptID"))
            param = mycommand.Parameters.AddWithValue("@Status", "false") 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@YearlyNo", HiddenFieldYearlyNo.Value)
            param = mycommand.Parameters.AddWithValue("@Request_type_ID", 1)
            param = mycommand.Parameters.AddWithValue("@PFName", HiddenFieldpfname.Value)
            param = mycommand.Parameters.AddWithValue("@PMName", HiddenFieldPMName.Value)
            param = mycommand.Parameters.AddWithValue("@RFName", HiddenFieldRelationFirstName.Value)
            param = mycommand.Parameters.AddWithValue("@RMName", HiddenFieldRMName.Value)
            param = mycommand.Parameters.AddWithValue("@Relation", HiddenFieldRelation.Value)
            param = mycommand.Parameters.AddWithValue("@age", HiddenFieldAge.Value)
            'param = mycommand.Parameters.AddWithValue("@Emp_ID", Session("Emp_ID"))
            param = mycommand.Parameters.AddWithValue("@RegNo", HiddenFieldRegNo.Value)
            mycommand.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "ABC")
            'mycommand.ExecuteNonQuery()
            ' Response.Write(ds.Tables(0).Rows.Count)
            GridView1.DataSource = ds.Tables(0)
            GridView1.AutoGenerateColumns = True
            GridView1.AllowPaging = True
            GridView1.PageSize = 10
            ' GridView2.HeaderRow.Cells(0).Text = "PayID"
            ' GridView2.HeaderRow.Cells(1).Text = "RegNo"
            'GridView2.HeaderRow.Cells(2).Text = "Patient Name"
            'GridView2.HeaderRow.Cells(3).Text = "Relation"
            'GridView2.HeaderRow.Cells(4).Text = "Relative Name"
            GridView1.PageIndex = a
            GridView1.DataBind()
            'GridView1.DataBind()
            mycommand.Connection.Close()

            'GridView1.Columns(4).Visible = False
        Catch ex As Exception
            Response.Write(ex.Message + " jhf ghj ")
        End Try

    End Sub
    Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
        Response.Redirect("../login.aspx")
    End Sub
    Protected Sub GridView1_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView1.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            'Response.Write(e.NewPageIndex & "sdfsfsd")
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        'GridView1.HeaderRow.Cells(3).Visible = False
        'For i As Integer = 0 To GridView1.Rows.Count - 1
        '    GridView1.Rows(i).Cells(3).Visible = False
        'Next
        'GridView1.HeaderRow.Cells(2).Text = "Yearly No."
        'GridView1.HeaderRow.Cells(4).Text = "Registration No."
        'GridView1.HeaderRow.Cells(5).Text = "Patient Name"
        'GridView1.HeaderRow.Cells(6).Text = "Relative Name"
        'GridView1.HeaderRow.Cells(7).Text = "Age"
    End Sub

    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        'Response.Write("YN" & GridView1.Rows(GridView1.SelectedIndex).Cells(3).Text & " RN " & GridView1.Rows(GridView1.SelectedIndex).Cells(4).Text)
        Dim YearlyNo As Integer = CInt(GridView1.Rows(GridView1.SelectedIndex).Cells(3).Text)
        Dim Reg As String = GridView1.Rows(GridView1.SelectedIndex).Cells(4).Text
        Session.Add("YearlyNo", YearlyNo)
        Session.Add("RegistrationNo", Reg)
        'Response.Write(Session("YearlyNo") & "" & Session("RegistrationNo"))
        Response.Redirect("Pathalogy_test_Price.aspx?Reg_No=" & Reg & "&Yearly_No=" & YearlyNo)
    End Sub
    ' '' '' '' ''Sub Update_Status()
    ' '' '' '' ''    Try
    ' '' '' '' ''        Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    ' '' '' '' ''        Dim con As SqlConnection = New SqlConnection(constring)
    ' '' '' '' ''        Dim mycommand As New System.Data.SqlClient.SqlCommand("update MRI_Save_Patient_Next_App set fee_paid = 1 where (yearly_No = " & Session("YearlyNo") & ") and (Reg_no = " & Session("RegistrationNo") & ")", con)
    ' '' '' '' ''        mycommand.CommandType = Data.CommandType.Text
    ' '' '' '' ''        mycommand.Connection.Open()
    ' '' '' '' ''        mycommand.ExecuteNonQuery()
    ' '' '' '' ''        mycommand.Connection.Close()
    ' '' '' '' ''    Catch ex As Exception

    ' '' '' '' ''    End Try
    ' '' '' '' ''End Sub
    Protected Sub Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Search.Click
        search1(0)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Search.Attributes.Add("onclick", "return Validation()")
        If Page.IsPostBack = False Then
            abc()
        End If
    End Sub
    Sub abc()
        Dim a As New ButtonField

        a.CommandName = "Select"
        a.ButtonType = ButtonType.Link
        a.DataTextField = "YearlyNo"
        GridView1.Columns.Add(a)

    End Sub
End Class
