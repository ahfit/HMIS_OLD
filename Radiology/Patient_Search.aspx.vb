Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Search
    Inherits System.Web.UI.Page
    Dim userAuthen As New User_page_Authentication
    Dim searchpanel1 As New Search_Panel_New
    Dim store_procedure As String
    Dim Next_Page As String
    Dim Page_Index As Integer
    Dim ENC As New Encryption
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            Label_message.Text = "Sorry you have No rights to access, Please contact to your database administrator"
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load



        TextBoxPFName.Focus()

        Try

            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            ' If Not Page.IsPostBack Then

            'Dim Table_Element_Name() As String = {"First Name :", "Middle Name :", "Last Name :", "Relation Name :", "Middle Name :", "Last Name :", "Registration No. :", "Yearly No. :", "Age :", "Registration Date :", "Status :", "Department :", "Test Group :"}
            'Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "DropDownList_Status", "DropDownList_Department", "DropDownList_Test_Group_radiology"}
            'Dim Table_Element_ID() As String = {"TextBoxPFName", "TextBoxPMName", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxLName", "TextBoxRegNo", "TextBoxYearlyNo", "TextBoxAge", "WebDateChooser1", "DropDownList_Status", "DropDownList_Department", "DropDownList_Test_Group"}
            'Dim Table_Columns As Integer = 3

            'searchpanel1.search_Panel_New(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)

            
            If Not IsPostBack Then

                
                Session.Remove("yearlyNo")
                Session.Remove("registrationNo")

                WebDateChooser_FromDate.Value = Date.Now.AddDays(-12).ToString("yyyy-MM-dd")
                WebDateChooser_Todate.Value = Date.Now.ToString("yyyy-MM-dd")
                HiddenField_FromDate.Value = WebDateChooser_FromDate.Text
                HiddenField_ToDate.Value = WebDateChooser_Todate.Text
                Draw_Status_DropdownList()
                Draw_DropDownList_Test_Group()
                DropDownList_Test_Group.SelectedValue = "29"
                DropDownList_Test_Group.Enabled = False
                Draw_DropDownList_Test_Name()
                'WebDateChooser1.Value = Date.Now
                DropDownList_Status.SelectedValue = Convert.ToInt32(Request.QueryString("def").ToString)
                DropDownList_Status.Enabled = False
                Get_Departments()
                ' LabelDisplname.Text = DropDownList_Status.SelectedItem.Text
                Label_Header.Text = DropDownList_Status.SelectedItem.Text
            End If

            If Request.QueryString("Def") = "12" Then
                lblHeading.Text = "Appointment"
            ElseIf Request.QueryString("Def") = "1" Then
                lblHeading.Text = "Reporting"
            ElseIf Request.QueryString("Def") = "6" Then
                lblHeading.Text = "Ready For Approval"
            ElseIf Request.QueryString("Def") = "10" Then
                lblHeading.Text = "Un Delivered Reports"
            ElseIf Request.QueryString("Def") = "8" Then
                lblHeading.Text = "Deliver Reports"

            End If
            If Page.IsPostBack = False Then
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            'Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Public Sub Get_Departments()

        Dim constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("Select 0 as Subdept_Id,' All' as SubDept_Name union Select SubDept_Id,SubDept_Name from SubDepartment order by SubDept_Name", con)

        mycommand.CommandType = Data.CommandType.Text

        mycommand.Connection.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds)
        mycommand.Connection.Close()
        DropDownList_Department.DataSource = ds.Tables(0)
        DropDownList_Department.DataTextField = "SubDept_Name"
        DropDownList_Department.DataValueField = "SubDept_Id"

        DropDownList_Department.DataBind()

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            search1(0)
        Catch ex As Exception
            Response.Write(ex.Message & " Search Button ")
        End Try
    End Sub
    Sub search1(ByVal indx As Integer)
        Try
            If WebDateChooser_Todate.Value < WebDateChooser_FromDate.Value Then
                Datelbl.Visible = True
                Datelbl.Text = "To Date Must be Greater Than From Date"
                GridView2.Visible = False
            Else
                Datelbl.Visible = False
                GridView2.Visible = True
                Dim constring As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
                store_procedure = "Search_hospital_Pt_group_wise"
                Dim ab As Collection
                ab = search_Patient_New_new(Panel2, store_procedure, constring, CInt(Session("SubDeptID")))

                Dim dtaset1 As DataSet = ab.Item("Dataset")
                'Label_Header.Text = ab.Item("Header")
                'Next_Page = ab.Item("Next_Page")
                GridView2.DataSource = dtaset1.Tables(0)

                ViewState("dt") = dtaset1.Tables(0)

                GridView2.AutoGenerateColumns = False
                GridView2.AllowPaging = True
                GridView2.PageSize = 50
                GridView2.PageIndex = indx
                GridView2.DataBind()
                ' Grid_Col(ab.Item("Grid_Col"), "Select", Next_Page)
            End If


        Catch ex As Exception
            Response.Write(ex.Message & "Search 0")
        End Try
    End Sub
    Protected Sub GridViewSearch_Sorting(sender As Object, e As GridViewSortEventArgs)
        Dim dtGridData As DataTable = TryCast(ViewState("dt"), DataTable)
        Dim dvGridDataView As DataView = dtGridData.DefaultView
        Dim strSortOrder As String = ""
        If ViewState("SortOrder") Is Nothing Then
            ViewState("SortOrder") = "asc"
        End If
        If ViewState("SortOrder").ToString() = "asc" Then
            ViewState("SortOrder") = "desc"
            strSortOrder = "desc"
        ElseIf ViewState("SortOrder").ToString() = "desc" Then
            ViewState("SortOrder") = "asc"
            strSortOrder = "asc"
        End If
        dvGridDataView.Sort = Convert.ToString(e.SortExpression + " ") & strSortOrder
        dtGridData = dvGridDataView.ToTable()

        GridView2.DataSource = dtGridData
        GridView2.DataBind()



        Session("SortGrid") = dtGridData
    End Sub





    Sub Grid_Col(ByVal BTN_TXT As String, ByVal CMD As String, ByVal NextPage As String)
        For i As Integer = 0 To GridView2.Rows.Count - 1
            Dim lnk_btn As LinkButton = GridView2.Rows(i).FindControl("LinkButton1")
            Dim lnk_b2 As LinkButton = GridView2.Rows(i).FindControl("LinkButton2")
            Dim hfCstatus As HiddenField = GridView2.Rows(i).FindControl("hfCStatus")

            Dim lblRegNo As Label = GridView2.Rows(i).FindControl("lblRegNo")
            Dim lblYearlyNo As HiddenField = GridView2.Rows(i).FindControl("hfYearlyNo")
            Dim lblRegMain As HiddenField = GridView2.Rows(i).FindControl("HfMainID")
            Dim hftbid As HiddenField = GridView2.Rows(i).FindControl("hfTB_ID")
            lnk_btn.Text = BTN_TXT
            lnk_btn.CommandName = CMD


            'Dim lnk_btn1 As LinkButton = GridView2.Rows(i).FindControl("LinkButton2")
            'lnk_btn1.Text = "Edit"
            'lnk_btn1.PostBackUrl = "Test_Booking.aspx" + "?Reg_No=" + GridView2.Rows(i).Cells(2).Text + "&YearlyNo=" + GridView2.Rows(i).Cells(1).Text
        Next
    End Sub

    Protected Sub GridView2_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView2.PageIndexChanging
        Try

            'GridView2.PageIndex = e.NewPageIndex
            'If Not IsNothing(Session("SortGrid")) Then
            '    GridView2.DataSource = Session("SortGrid")
            '    GridView2.DataBind()
            'Else
            '    search1()
            'End If

            Dim b As Integer = e.NewPageIndex

            If Not IsNothing(Session("SortGrid")) Then
                GridView2.DataSource = Session("SortGrid")
                GridView2.DataBind()
            Else
                search1(0)
            End If


        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        Try

            For Each row As GridViewRow In GridView2.Rows
                Dim hfCstatus As HiddenField = row.FindControl("hfStatus")
                Dim lnk_btn As LinkButton = row.FindControl("LinkButton1")
                Dim lnk_b2 As LinkButton = row.FindControl("LinkButton2")
                If Session("SubDeptId") = 9 And Request.QueryString("def") = 10 Then
                    lnk_b2.Visible = True
                    lnk_btn.Visible = False
                End If

            Next


            'If GridView2.Rows.Count > 0 Then

            '    GridView2.HeaderRow.Cells(4).Visible = False
            '    GridView2.HeaderRow.Cells(5).Visible = False
            '    GridView2.HeaderRow.Cells(6).Visible = False
            '    GridView2.HeaderRow.Cells(13).Visible = False
            '    GridView2.HeaderRow.Cells(14).Visible = False
            '    GridView2.HeaderRow.Cells(15).Visible = False
            '    GridView2.HeaderRow.Cells(3).Text = "Patient"
            '    GridView2.HeaderRow.Cells(1).Text = "Sample No"
            '    GridView2.HeaderRow.Cells(1).Visible = False
            '    For i As Integer = 0 To GridView2.Rows.Count - 1
            '        '=============================================
            '        'Dim hp As HyperLink = New HyperLink()
            '        'hp.NavigateUrl = "patientregistration.aspx"
            '        'hp.Text = GridView2.Rows(i).Cells(4).Text
            '        'GridView2.Controls.Add(hp)
            '        '=============================================
            '        GridView2.Rows(i).Cells(2).Text = ENC.Encrypt_Main(GridView2.Rows(i).Cells(2).Text, False)
            '        GridView2.Rows(i).Cells(3).Text = GridView2.Rows(i).Cells(3).Text + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(4).Text, False) + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(5).Text, False)
            '        GridView2.Rows(i).Cells(4).Visible = False
            '        GridView2.Rows(i).Cells(5).Visible = False
            '        GridView2.Rows(i).Cells(6).Visible = False
            '        GridView2.Rows(i).Cells(15).Visible = False
            '        GridView2.Rows(i).Cells(1).Visible = False

            '        If GridView2.Rows(i).Cells(13).Text = 1 Then
            '            GridView2.Rows(i).BackColor = Drawing.Color.LightGreen
            '        ElseIf GridView2.Rows(i).Cells(13).Text = 2 Then
            '            GridView2.Rows(i).BackColor = Drawing.Color.LightPink
            '        ElseIf GridView2.Rows(i).Cells(13).Text = 3 Then
            '            GridView2.Rows(i).BackColor = Drawing.Color.Red
            '            GridView2.Rows(i).ForeColor = Drawing.Color.White
            '        End If
            '        GridView2.Rows(i).Cells(13).Visible = False
            '        GridView2.Rows(i).Cells(14).Visible = False
            '    Next
            'End If
        Catch ex As Exception
            Response.Write(ex.Message & " Grid Preender ")
        End Try
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.SelectedIndexChanged

    End Sub
    Protected Sub DropDownList_Test_Group_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        HiddenField_ID.Value = DropDownList_Test_Group.SelectedValue
        Draw_DropDownList_Test_Name()
    End Sub

    Sub Draw_DropDownList_Test_Name()
        DropDownList_Test_Name.Items.Clear()
        DropDownList_Test_Name.Items.Insert(0, New ListItem("All", "0"))
        DropDownList_Test_Name.AppendDataBoundItems = True
        Dim constr_dept As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con_dept As SqlConnection = New SqlConnection(constr_dept)

        'Dim tg As DropDownList
        'tg = P.FindControl("DropDownList_Test_Group")
        Dim commnad_dept As SqlCommand
        If HiddenField_ID.Value = "0" Or HiddenField_ID.Value = "" Then
            commnad_dept = New SqlCommand("SELECT TB_ID TID, TB_Name TestName FROM Test_Booking order by TestName", con_dept)
        Else
            ' commnad_dept = New SqlCommand("SELECT TB_ID TID, TB_Name TestName FROM Test_Booking where TGID=" + HiddenField_ID.Value + " order by TestName", con_dept)
            commnad_dept = New SqlCommand("SELECT TB_ID TID, TB_Name TestName FROM Test_Booking where MG_ID=" + HiddenField_ID.Value + " order by TestName", con_dept)
        End If
        commnad_dept.CommandType = CommandType.Text
        con_dept.Open()
        Dim ds_dept As New DataSet
        Dim da_dept As New SqlDataAdapter
        da_dept.SelectCommand = commnad_dept
        da_dept.Fill(ds_dept, "Dept")
        DropDownList_Test_Name.DataSource = ds_dept.Tables(0)
        DropDownList_Test_Name.DataTextField = "TestName"
        DropDownList_Test_Name.DataValueField = "TID"

        DropDownList_Test_Name.DataBind()
    End Sub
    Sub Draw_DropDownList_Test_Group()

        DropDownList_Test_Group.Items.Insert(0, New ListItem("All", "0"))
        DropDownList_Test_Group.AppendDataBoundItems = True
        Dim constr_dept As String = ConfigurationManager.ConnectionStrings("Radiology_ConnectionString").ConnectionString
        Dim con_dept As SqlConnection = New SqlConnection(constr_dept)

        Dim commnad_dept As SqlCommand = New SqlCommand("SELECT Asc_id TGID,Asc_Name TGName  from Admin_Service_Category", con_dept)
        commnad_dept.CommandType = CommandType.Text
        con_dept.Open()
        Dim ds_dept As New DataSet
        Dim da_dept As New SqlDataAdapter
        da_dept.SelectCommand = commnad_dept
        da_dept.Fill(ds_dept, "Dept")
        DropDownList_Test_Group.DataSource = ds_dept.Tables(0)
        DropDownList_Test_Group.DataTextField = "TGName"
        DropDownList_Test_Group.DataValueField = "TGID"
        DropDownList_Test_Group.AutoPostBack = True

        DropDownList_Test_Group.DataBind()
    End Sub
    Sub Draw_Status_DropdownList()
        Try

            DropDownList_Status.Items.Insert(0, New ListItem("All", "0"))
            Dim constring As String


            Dim UMconstring As String = ConfigurationManager.ConnectionStrings("UsersConnectionString").ConnectionString

            Dim UM_Con As SqlConnection = New SqlConnection(UMconstring)
            Dim qry As String = "SELECT DeptID FROM Employee WHERE (EmpID = @EmpID)"
            Dim UmCommand As New SqlCommand(qry, UM_Con)
            UmCommand.CommandType = CommandType.Text
            UM_Con.Open()
            UmCommand.Parameters.AddWithValue("@EmpID", HttpContext.Current.Session("emp_id"))
            Dim reader As SqlDataReader = UmCommand.ExecuteReader()
            While reader.Read()


                If reader.Item("DeptID").ToString = 10 Then
                    constring = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
                Else
                    constring = ConfigurationManager.ConnectionStrings("RadiologyConnectionString").ConnectionString
                End If
            End While




            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select * from Test_Status where act_status=1", con)
            mycommand.CommandType = Data.CommandType.Text
            mycommand.Connection.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = mycommand
            da.Fill(ds)
            mycommand.Connection.Close()
            DropDownList_Status.DataSource = ds.Tables(0)
            DropDownList_Status.DataTextField = "Status"
            DropDownList_Status.DataValueField = "Status_ID"

            DropDownList_Status.DataBind()
            DropDownList_Status.SelectedValue = Request.QueryString("def").ToString().Replace(".", "")
        Catch ex As Exception

        End Try
    End Sub
    Function search_Patient_New_new(ByVal pnl As Panel, ByVal procedure As String, ByVal constr As String, ByVal subdeptid As Integer) As Collection

        Dim TextBoxPFName1 As String = ""
        Dim TextBoxRegNo1 As String = ""
        Dim txtCNIC1 As String = ""
        Dim txtMobileNo1 As String = ""
        Dim TextBoxAge1 As Integer = 0
        Dim TextBoxRelation1 As String = "" '= "%"
        Dim TextBoxFName1 As String = ""
        Dim TextBoxFMName1 As String = ""
        Dim TextBoxPhone1 As String = ""
        Dim WebDate1 As String = ""
        Dim Status_Id1 As Integer = 0
        Dim Subdept_Id1 As Integer = 0
        Dim Test_Group1 As Integer = 0
        Dim dte1 As Integer
        Dim mon1 As Integer
        Dim year1 As Integer
        Dim YearlyNo1 As Int64

        If TextBoxYearlyNo.Text.Trim = "" Then
            YearlyNo1 = 0
        Else
            YearlyNo1 = TextBoxYearlyNo.Text.Trim
        End If

        If TextBoxRegNo.Text.Trim = "" Then
            TextBoxRegNo1 = "%"
        Else
            TextBoxRegNo1 = ENC.Encrypt_Main(TextBoxRegNo.Text.Trim, True)

        End If



        If txtCNIC.Text.Trim = "" Then
            txtCNIC1 = "%"
        Else
            txtCNIC1 = txtCNIC.Text
        End If


        If TextBoxAge.Text.Trim = "" Then
            TextBoxAge1 = 0
        Else
            TextBoxAge1 = TextBoxAge.Text.Trim
        End If


        TextBoxRelation1 = "%"



        TextBoxFName1 = "%"



        TextBoxFMName1 = "%"



        TextBoxPhone1 = "%"


        If WebDateChooser1.Text = "Null" Then
            dte1 = 0
            mon1 = 0
            year1 = 0
        Else
            WebDate1 = WebDateChooser1.Value
            Dim aw As DateTime = CDate(WebDate1)
            dte1 = aw.Day
            mon1 = aw.Month
            year1 = aw.Year

        End If

        If TextBoxPFName.Text.Trim = "" Then
            TextBoxPFName1 = "%"
        Else
            TextBoxPFName1 = ENC.Encrypt_Main(ENC.TitleCase(TextBoxPFName.Text.ToLower), True)
            'TextBoxPFName = txtbox.Text
        End If

        If txtCNIC.Text.Trim = "" Then
            txtCNIC1 = "%"
        Else
            txtCNIC1 = ENC.Encrypt_Main(ENC.TitleCase(txtCNIC.Text.ToLower), True)
            'TextBoxPFName = txtbox.Text
        End If

        If txtMobileNo.Text.Trim = "" Then
            txtMobileNo1 = "%"
        Else
            txtMobileNo1 = ENC.Encrypt_Main(ENC.TitleCase(txtMobileNo.Text.ToLower), True)
            'TextBoxPFName = txtbox.Text
        End If

        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constr)
        Dim mycommand As New System.Data.SqlClient.SqlCommand(procedure, con)
        mycommand.CommandType = Data.CommandType.StoredProcedure
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.AddWithValue("@subdept", DropDownList_Department.SelectedValue)
        'param = mycommand.Parameters.AddWithValue("@Status", 0)
        param = mycommand.Parameters.AddWithValue("@EmpId", Session("Emp_Id"))
        param = mycommand.Parameters.AddWithValue("@YearlyNo", YearlyNo1)
        param = mycommand.Parameters.AddWithValue("@Request_type_ID", 2)
        param = mycommand.Parameters.AddWithValue("@PFName", TextBoxPFName1)
        param = mycommand.Parameters.AddWithValue("@CNIC", txtCNIC1)
        param = mycommand.Parameters.AddWithValue("@MobileNo", txtMobileNo1)
        param = mycommand.Parameters.AddWithValue("@RFName", "%")
        param = mycommand.Parameters.AddWithValue("@RMName", "%")

        param = mycommand.Parameters.AddWithValue("@Relation", "%")
        param = mycommand.Parameters.AddWithValue("@age", TextBoxAge1)
        param = mycommand.Parameters.AddWithValue("@RegNo", TextBoxRegNo1)
        'param = mycommand.Parameters.AddWithValue("@PhoneNo", TextBoxPhone)
        param = mycommand.Parameters.AddWithValue("@Status_ID", DropDownList_Status.SelectedValue)
        param = mycommand.Parameters.AddWithValue("@Day", dte1)
        param = mycommand.Parameters.AddWithValue("@month", mon1)
        param = mycommand.Parameters.AddWithValue("@year", year1)

        param = mycommand.Parameters.AddWithValue("@to_dept", Session("dept_id"))

        If procedure = "Search_hospital_Pt_group_wise" Then
            'HiddenField_FromDate.Value = WebDateChooser_FromDate.Text
            'HiddenField_ToDate.Value = WebDateChooser_Todate.Text
            HiddenField_FromDate.Value = Convert.ToDateTime(WebDateChooser_FromDate.Value)
            HiddenField_ToDate.Value = Convert.ToDateTime(WebDateChooser_Todate.Value)
            param = mycommand.Parameters.AddWithValue("@group_ID", DropDownList_Test_Group.SelectedValue)
            param = mycommand.Parameters.AddWithValue("@Test_ID", DropDownList_Test_Name.SelectedValue)
            param = mycommand.Parameters.AddWithValue("@FromDate", Convert.ToDateTime(HiddenField_FromDate.Value.ToString()))
            param = mycommand.Parameters.AddWithValue("@ToDate", Convert.ToDateTime(HiddenField_ToDate.Value.ToString()))

        ElseIf procedure = "Search_hospital_Pt" Then

            param = mycommand.Parameters.AddWithValue("@group_ID", DropDownList_Test_Group.SelectedValue)
        End If
        mycommand.Parameters.Add("@Header", SqlDbType.VarChar, 200)
        mycommand.Parameters("@Header").Direction = ParameterDirection.Output
        mycommand.Parameters.Add("@Grid_Col", SqlDbType.VarChar, 200)
        mycommand.Parameters("@Grid_Col").Direction = ParameterDirection.Output
        mycommand.Parameters.Add("@Next_Page", SqlDbType.VarChar, 200)
        mycommand.Parameters("@Next_Page").Direction = ParameterDirection.Output
        mycommand.Connection.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = mycommand
        da.Fill(ds, "ABC")
        mycommand.ExecuteNonQuery()
        Dim Header As String = mycommand.Parameters("@Header").Value
        Dim Grid_Col As String = mycommand.Parameters("@Grid_Col").Value
        Dim Next_Page As String = mycommand.Parameters("@Next_Page").Value
        Dim COLL As New Collection
        COLL.Add(ds, "dataset")
        COLL.Add(Header, "Header")
        COLL.Add(Grid_Col, "Grid_Col")
        COLL.Add(Next_Page, "Next_Page")
        Return COLL

    End Function

    Protected Sub LinkButton2_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        Dim gvRow As GridViewRow = lnk.NamingContainer

        Dim lnk_btn As LinkButton = gvRow.FindControl("LinkButton1")
        Dim lnk_b2 As LinkButton = gvRow.FindControl("LinkButton2")
        Dim hfCstatus As HiddenField = gvRow.FindControl("hfCStatus")

        Dim lblRegNo As Label = gvRow.FindControl("lblRegNo")
        Dim lblYearlyNo As Label = gvRow.FindControl("lblYearlyNo")
        Dim lblRegMain As HiddenField = gvRow.FindControl("HfMain_ID")
        Dim hftbid As HiddenField = gvRow.FindControl("hfTB_ID")

        Dim dbm As DbManager = New DbManager()
        Dim sp As SqlParameter() =
            {
            New SqlParameter("@Status", 6),
            New SqlParameter("@RegNo", lblRegNo.Text),
            New SqlParameter("@YearlyNo", lblYearlyNo.Text),
            New SqlParameter("@TB_ID", hftbid.Value),
            New SqlParameter("@Main_ID", lblRegMain.Value)
            }
        dbm.ExecuteNonQuery("Update_Patient_Test_Status_Report", "RadiologyCOnnectionString", sp)
        search1(0)


    End Sub


    Protected Sub lnk_images_Click(sender As Object, e As EventArgs)
        'Dim lnk As LinkButton = sender
        'Session("yearlyNo") = lnk.CommandArgument
        'Session("registrationNo") = lnk.ToolTip
        'pnl_images.Visible = True


        'Dim template2 As Control = CType(LoadControl("~/Pt_EMR/Controls/InveestigationChartControlForRadialogy.ascx"), Control)

        'pnl_images.Controls.Add(template2)
    End Sub
End Class

