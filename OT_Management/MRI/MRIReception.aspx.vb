Imports System.Data
Imports System.Data.SqlClient
Partial Class MRIReception
    Inherits System.Web.UI.Page
    Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
        'loginvalidate(Session("emp_id"), Session("dept_id")))
        'Session.Add("UserID", Session("emp_id"))
        'Session.Add("DeptID", Session("dept_id")))
        'Session.Add("SubDeptID", Session("SubDeptID"))
        HiddenFieldSubDept.Value = 29
        Session.Timeout = 30
        ' GridView2.DataSourceID = SqlDataSource_Patients.ID
        ' GridView2.DataBind()
        ' GridView2.AutoGenerateColumns = True
        If Page.IsPostBack = False Then
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

            '=========================
            If (RadioButtonList_Relation.SelectedValue Is Nothing) Then
                HiddenFieldRelation.Value = "%"
            Else
                HiddenFieldRelation.Value = RadioButtonList_Relation.SelectedValue
            End If
            '=============================
            'If TextBoxRelation.Text.Trim = "" Then
            '    HiddenFieldRelation.Value = "%"
            'Else
            '    HiddenFieldRelation.Value = TextBoxRelation.Text.Trim
            'End If
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


            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Search_Emg_Dept_Patient", con)
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
            mycommand.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds, "ABC")
            mycommand.ExecuteNonQuery()
            ' Response.Write(ds.Tables(0).Rows.Count)
            GridView2.DataSource = ds.Tables(0)
            GridView2.AutoGenerateColumns = True
            GridView2.AllowPaging = True
            GridView2.PageSize = 25
            ' GridView2.HeaderRow.Cells(0).Text = "PayID"
            ' GridView2.HeaderRow.Cells(1).Text = "RegNo"
            'GridView2.HeaderRow.Cells(2).Text = "Patient Name"
            'GridView2.HeaderRow.Cells(3).Text = "Relation"
            'GridView2.HeaderRow.Cells(4).Text = "Relative Name"
            GridView2.PageIndex = a
            GridView2.DataBind()
            mycommand.Connection.Close()
            GridView2.HeaderRow.Cells(1).Text = "Yearly No."
            GridView2.HeaderRow.Cells(2).Text = "Registration No."
            GridView2.HeaderRow.Cells(3).Text = "Patient Name"
            GridView2.HeaderRow.Cells(4).Text = "Relative Name"
            GridView2.HeaderRow.Cells(5).Text = "Age"
        Catch ex As Exception
            Response.Write(ex.Message + " jhf ghj ")
        End Try

    End Sub


    Protected Sub GridView2_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView2.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    'Protected Sub ImageButtonLogOut_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
    '    Response.Redirect("../login.aspx")
    'End Sub

    Protected Sub Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Search.Click
        search1(0)
    End Sub

    Protected Sub Refresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Refresh.Click
        Response.Redirect("MRIReception.aspx")
    End Sub
End Class
