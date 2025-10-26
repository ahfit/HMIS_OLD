Imports System.Data
Imports System.Data.SqlClient
Partial Class Pathology_Search_Patient_For_Update
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
        Try

            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            Dim Table_Element_Name() As String = {"First Name", "Middle Name", "Last Name", "Relation Name", "Relation Middle Name", "Relation Last Name", "Registration No.", "Yearly No.", "Age"}
            Dim Table_Element_Type() As String = {"TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox", "TextBox"}
            Dim Table_Element_ID() As String = {"TextBoxPFName", "TextBoxPMName", "TextBoxPLName", "TextBoxFName", "TextBoxFMName", "TextBoxLName", "TextBoxRegNo", "TextBoxYearlyNo", "TextBoxAge"}
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
            store_procedure = "Search_Pathlogy_Patient_For_Update"
            Dim ab As Collection
            ab = searchpanel1.search_Patient_For_Update(Panel2, store_procedure, constring, CInt(Session("SubDeptID")))
            Dim dtaset1 As DataSet = ab.Item("Dataset")
            GridView2.DataSource = dtaset1.Tables(0)
            GridView2.AutoGenerateColumns = True
            GridView2.AllowPaging = True
            GridView2.PageSize = 50
            GridView2.PageIndex = indx
            GridView2.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message & "Search 0")
        End Try
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
                GridView2.HeaderRow.Cells(5).Visible = False
                GridView2.HeaderRow.Cells(6).Visible = False
                GridView2.HeaderRow.Cells(7).Visible = False
                For i As Integer = 0 To GridView2.Rows.Count - 1
                    GridView2.Rows(i).Cells(3).Text = ENC.Encrypt_Main(GridView2.Rows(i).Cells(3).Text, False)
                    GridView2.Rows(i).Cells(4).Text = GridView2.Rows(i).Cells(4).Text + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(5).Text, False) + " " + ENC.Encrypt_Main(GridView2.Rows(i).Cells(6).Text, False)
                    GridView2.Rows(i).Cells(5).Visible = False
                    GridView2.Rows(i).Cells(6).Visible = False
                    GridView2.Rows(i).Cells(7).Visible = False
                Next
            End If
        Catch ex As Exception
            Response.Write(ex.Message & " Grid Preender ")
        End Try
    End Sub

    Protected Sub GridView2_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridView2.RowCommand
        If e.CommandName = "Edit" Then
            Dim Reg_No As String = GridView2.Rows(e.CommandArgument).Cells(3).Text
            Dim YearlyNo As String = GridView2.Rows(e.CommandArgument).Cells(2).Text
            Session.Add("registrationNo", Reg_No)
            Session.Add("YearlyNo", YearlyNo)
            Response.Redirect("../Patient Registration/Update_Patient.aspx?Reg_No=" + ENC.Encrypt_Main(Reg_No, True))
        ElseIf e.CommandName = "Test" Then
            Dim Reg_No As String = GridView2.Rows(e.CommandArgument).Cells(3).Text
            Dim YearlyNo As String = GridView2.Rows(e.CommandArgument).Cells(2).Text
            Session.Add("registrationNo", Reg_No)
            Session.Add("YearlyNo", YearlyNo)
            'Response.Write(Session("YearlyNo"))
            'Response.End()
            Response.Redirect("test_booking.aspx?Reg_No=" + ENC.Encrypt_Main(Reg_No, True) + "&YearlyNo=" + Session("YearlyNo"))
        End If
    End Sub
End Class
