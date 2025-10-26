'Author                  Muhammad Aun Abbas
'Creation Date      
'Modification Date       24-11-2006
'Purpose                 Move CMO to CMOPatientForward
'                        and BasicMedicalInfo
'Store Procedure used    SearchEmgDeptPatient          
Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine
Partial Class NursingOrderReception
    Inherits System.Web.UI.Page

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Try
            Session.RemoveAll()
            Response.Redirect("Login.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Refresh_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Refresh.Click
        Try
            ' Response.Write(Session("emp_id"))

            Response.Redirect("NursingOrderReception.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

   ' Protected Sub form1_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles form1.Load
'        Try
'            loginvalidate(Session("emp_id"), Session("dept_id"))
'            'Session.Add("UserID", Session("emp_id"))
'            'Session.Add("DeptID", Session("dept_id")))
'            'Session.Add("SubDeptID", Session("SubDeptID"))
'            HiddenFieldSubDept.Value = Session("SubDeptID")
'            Session.Timeout = 60
'        Catch ex As Exception
'            Response.Write(ex.Message)
'        End Try

   ' End Sub

    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Try
            Response.Redirect(Session("mainpage"))
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub ImageButtonback_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonback.Click
        Try
            Response.Redirect("CMOMainArea.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
      '  Dim obj_menu As New JavaScriptMenu
'        obj_menu.loginvalidate()
'        LabelSideMenu.Text = Convert.ToString(obj_menu.SideMenu_nurse(Request.PhysicalPath.Substring((Request.PhysicalApplicationPath.Length - 1), Convert.ToInt32((Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))))

Dim obj_menu As New JavaScriptMenu
obj_menu.loginvalidate()
LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
 LabelFooter.Text = obj_menu.Footer_String()

        HiddenFieldSubDept.Value = Session("SubDeptID")
      '  form1.DefaultButton = "Search"
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
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Search_Emg_Dept_Patient_NursingOrder", con)
            mycommand.CommandType = Data.CommandType.StoredProcedure
            Dim param As System.Data.SqlClient.SqlParameter
            param = mycommand.Parameters.AddWithValue("@to_sub_Dept", HiddenFieldSubDept.Value)
            ' param = mycommand.Parameters.AddWithValue("@Status", "false") 'Session("BMIPayID")
            param = mycommand.Parameters.AddWithValue("@YearlyNo", HiddenFieldYearlyNo.Value)
            ' param = mycommand.Parameters.AddWithValue("@Request_type_ID", 10)
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
            GridView2.DataSource = ds.Tables(0)
            GridView2.AutoGenerateColumns = True
            GridView2.AllowPaging = True
            GridView2.PageSize = 10
            GridView2.PageIndex = a
            GridView2.DataBind()
            'mycommand.Connection.Close()
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

    Protected Sub GridView2_RowUpdated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdatedEventArgs) Handles GridView2.RowUpdated
        gridview2.databind()
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.SelectedIndexChanged
        Try
            hiddenfield_yearlyno.value = gridview2.rows(Gridview2.selectedindex).cells(4).text
            hiddenfield_regno.value = gridview2.rows(Gridview2.selectedindex).cells(3).text
            HiddenFieldrequestid.value = gridview2.rows(Gridview2.selectedindex).cells(10).text
            ' response.write(HiddenFieldrequestid.value)
            sqldatasourcepatients.update()
            gridview2.databind()
        Catch ex As Exception
            ' Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub btn_backpage_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_backpage.Click
        Response.Redirect("~/Pt_EMR/Pt_plan.aspx")
    End Sub
End Class
