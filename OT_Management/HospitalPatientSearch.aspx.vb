Imports System.Data
Imports System.Data.SqlClient
Partial Class HospitalPatientSearch
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
            Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try

            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Dim Table_Element_Name() As String = {"First Name", "Middle Name", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration No.", "Yearly No.", "Age", "Registration Date", "Status", "Department"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "WebDateChooser", "DropDownList_Status", "DropDownList_Department"}
            Dim Table_Element_ID() As String = {"TextBoxPFName", "TextBoxPMName", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxLName", "TextBoxRegNo", "TextBoxYearlyNo", "TextBoxAge", "WebDateChooser1", "DropDownList_Status", "DropDownList_Department"}
            Dim Table_Columns As Integer = 3
            searchpanel1.search_Panel_New(Panel2, Table_Columns, Table_Element_Name, Table_Element_Type, Table_Element_ID)
            If Page.IsPostBack = False Then
                search1(0)
            End If
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            'Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
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
            Dim constring As String = ConfigurationManager.ConnectionStrings("OT_ManagementConnectionString").ConnectionString
            store_procedure = "Search_hospital_Patient"
            Dim ab As Collection
            ab = searchpanel1.search_Patient_New_dept(Panel2, store_procedure, constring, CInt(Session("SubDeptID")))
            Dim dtaset1 As DataSet = ab.Item("Dataset")
            Label_Header.Text = ab.Item("Header")
            Next_Page = ab.Item("Next_Page")
            GridView2.DataSource = dtaset1.Tables(0)
            GridView2.AutoGenerateColumns = True
            GridView2.AllowPaging = True
            GridView2.PageSize = 50
            GridView2.PageIndex = indx
            GridView2.DataBind()
            Grid_Col(ab.Item("Grid_Col"), "Select", Next_Page)
        Catch ex As Exception
            Response.Write(ex.Message & "Search 0")
        End Try
    End Sub

    Sub Grid_Col(ByVal BTN_TXT As String, ByVal CMD As String, ByVal NextPage As String)
        For i As Integer = 0 To GridView2.Rows.Count - 1
            Dim lnk_btn As LinkButton = GridView2.Rows(i).FindControl("LinkButton1")
            lnk_btn.Text = BTN_TXT
            'lnk_btn.CommandName = CMD
            lnk_btn.PostBackUrl = NextPage + "?Reg_No=" + GridView2.Rows(i).Cells(2).Text + "&YearlyNo=" + GridView2.Rows(i).Cells(1).Text + "&Order_Id=" + GridView2.Rows(i).Cells(12).Text + "&FromDept_Id=" + GridView2.Rows(i).Cells(12).Text + "&FromSubDept_ID=" + GridView2.Rows(i).Cells(13).Text
        Next
    End Sub

    Protected Sub GridView2_PageIndexChanging1(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridView2.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            Page_Index = b
            search1(b)
        Catch ex As Exception
            Label_message.ForeColor = Drawing.Color.Red
            Label_message.Text = "Sorry You Have No Rights To Access, Please Contact To Your Database Administrator"
        End Try
    End Sub

    Protected Sub GridView2_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.PreRender
        Try
            If GridView2.Rows.Count > 0 Then
                GridView2.HeaderRow.Cells(4).Visible = False
                GridView2.HeaderRow.Cells(5).Visible = False
                GridView2.HeaderRow.Cells(6).Visible = False
                GridView2.HeaderRow.Cells(12).Visible = False
                GridView2.HeaderRow.Cells(13).Visible = False
                GridView2.HeaderRow.Cells(14).Visible = False
                GridView2.HeaderRow.Cells(16).Visible = False
                GridView2.HeaderRow.Cells(3).Text = "Patient"
                For i As Integer = 0 To GridView2.Rows.Count - 1
                    GridView2.Rows(i).Cells(2).Text = ENC.Encrypt_Main(GridView2.Rows(i).Cells(2).Text, False)
                    GridView2.Rows(i).Cells(3).Text = GridView2.Rows(i).Cells(3).Text + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(4).Text, False) + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(5).Text, False)
                    GridView2.Rows(i).Cells(4).Visible = False
                    GridView2.Rows(i).Cells(5).Visible = False
                    GridView2.Rows(i).Cells(6).Visible = False
                    GridView2.Rows(i).Cells(12).Visible = False
                    GridView2.Rows(i).Cells(13).Visible = False
                    GridView2.Rows(i).Cells(14).Visible = False
                    GridView2.Rows(i).Cells(16).Visible = False
                Next
            End If
        Catch ex As Exception
            Response.Write(ex.Message & " Grid Preender ")
        End Try
    End Sub

    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView2.SelectedIndexChanged

    End Sub
End Class
