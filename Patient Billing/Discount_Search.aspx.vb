Imports System.Data
Imports System.Data.SqlClient
Partial Class Discount_Search
    Inherits System.Web.UI.Page
    Dim ENC As New Encryption
    Dim pgindex As Integer = 0
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    'This page is use for searching a patient record, On this page CMO can also view   '
    'Patient Movement Histroy,Patient Detail ,can Edit Record of a Patient                 '
    ' by using QueryString "regno","payid"                                             '
    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''  
    Dim userAuthen As New User_page_Authentication
    Dim searchpanel1 As New SearchPanel
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'this function use to chck that it is a  valid user or not ' 
        ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Sub search1(ByVal indx As Integer)
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim dtaset As DataSet = searchpanel1.search_MOBy_Emp(Panel2, "Search_Patient_for_Discount", constring, Session("SubDeptId"), Session("emp_id"))
            GridViewSearch.DataSource = dtaset.Tables(0)
            GridViewSearch.AutoGenerateColumns = True
            GridViewSearch.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message + "dasfsdfdss")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session("Module_id") = userAuthen.Tabs_selection(Page.Request.PhysicalPath, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length, Session("Emp_ID"))
            searchpanel1.search_Panel(Panel2)

            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))

            If Page.IsPostBack = False Then

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridViewSearch_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridViewSearch.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            search1(b)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        search1(0)
    End Sub

    Protected Sub GridViewSearch_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.PreRender
        Try
            If GridViewSearch.Rows.Count <> 0 Then
                GridViewSearch.HeaderRow.Cells(4).Text = "Patient Name"
                GridViewSearch.HeaderRow.Cells(5).Visible = False
                GridViewSearch.HeaderRow.Cells(6).Visible = False
                GridViewSearch.HeaderRow.Cells(7).Visible = False
                GridViewSearch.HeaderRow.Cells(11).Visible = False
                GridViewSearch.HeaderRow.Cells(12).Visible = False
                GridViewSearch.HeaderRow.Cells(13).Visible = False

                GridViewSearch.HeaderRow.Cells(10).Visible = False
                GridViewSearch.HeaderRow.Cells(19).Visible = False

                For i As Integer = 0 To GridViewSearch.Rows.Count - 1
                    Dim name As String
                    name = GridViewSearch.Rows(i).Cells(4).Text.Trim + " " + GridViewSearch.Rows(i).Cells(5).Text.Trim
                    If GridViewSearch.Rows(i).Cells(6).Text.Trim = "&nbsp;" Then


                    Else
                        name = name + " " + GridViewSearch.Rows(i).Cells(6).Text.Trim


                    End If
                    If GridViewSearch.Rows(i).Cells(7).Text.Trim = "&nbsp;" Then
                    Else
                        name = name + " " + GridViewSearch.Rows(i).Cells(7).Text.Trim
                    End If
                    GridViewSearch.Rows(i).Cells(4).Text = name

                    GridViewSearch.Rows(i).Cells(5).Visible = False
                    GridViewSearch.Rows(i).Cells(6).Visible = False
                    GridViewSearch.Rows(i).Cells(7).Visible = False
                    GridViewSearch.Rows(i).Cells(11).Visible = False
                    GridViewSearch.Rows(i).Cells(12).Visible = False
                    GridViewSearch.Rows(i).Cells(13).Visible = False

                    GridViewSearch.Rows(i).Cells(10).Visible = False
                    GridViewSearch.Rows(i).Cells(19).Visible = False


                Next
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Private Function GetQueryStringData(ByVal regno As String, ByVal yearlyNo As Integer) As DataTable
        Dim path_constring As String = ConfigurationManager.ConnectionStrings("Path_ConnectionString").ConnectionString
        Dim dt As New DataTable
        Dim da As New SqlDataAdapter
        Dim qry As String = "SELECT Investigation_Order_ID, DeptId, SubDept_Id FROM Investigation_Order_Main where (YearlyNo = @YearlyNo) and  (RegNo = @RegNo) order by Investigation_Order_ID desc"
        Dim con As New SqlConnection(path_constring)
        Dim cmd As New SqlCommand(qry, con)
        cmd.Parameters.AddWithValue("@YearlyNo", yearlyNo)
        cmd.Parameters.AddWithValue("@RegNo", regno)
        con.Open()
        da.SelectCommand = cmd
        da.Fill(dt)
        con.Close()
        Return dt
    End Function

    Protected Sub GridViewSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewSearch.RowCommand

        If e.CommandName = "Select" Then
            Session.Add("RegistrationNo", ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(2).Text, True))
            Session.Add("YearlyNo", GridViewSearch.Rows(e.CommandArgument).Cells(1).Text)
            Session.Add("PatientName", GridViewSearch.Rows(e.CommandArgument).Cells(4).Text.ToString.TrimEnd)
            Session.Add("PatientType", GridViewSearch.Rows(e.CommandArgument).Cells(16).Text.ToString.TrimEnd)
            Dim hfdiscount As New HiddenField
            hfdiscount.Value = GridViewSearch.Rows(e.CommandArgument).Cells(19).Text.ToString.TrimEnd

            Response.Redirect("Discount.aspx?regno=" & ENC.Encrypt_Main(GridViewSearch.Rows(e.CommandArgument).Cells(2).Text, True) & "&payid=" & GridViewSearch.Rows(e.CommandArgument).Cells(1).Text & "&requestid=" & hfdiscount.Value)
           
        End If

    End Sub

    Protected Sub lnk_DeleteRecord_Click(sender As Object, e As EventArgs)
        Dim lik As LinkButton = CType(sender, LinkButton)
        Dim _id As String = lik.CommandArgument
        Dim dt As DataTable = DeleteRecord(_id)

    End Sub

    Public Function DeleteRecord(ByVal id As String) As DataTable
        Dim con As SqlConnection = New SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString)
        Dim dt As DataTable = New DataTable()
        Try
            con.Open()
            Dim cmd As SqlCommand = New SqlCommand("Delete_Patient_for_Discount", con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@yearly_no", id)
            cmd.ExecuteNonQuery()
            GridViewSearch.DataBind()
            GridViewSearch.Visible = "true"
        Catch Ex As Exception
            Response.Write(Ex.Message)
        Finally
            con.Close()
        End Try

        Return dt
    End Function

   
End Class
