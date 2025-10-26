Imports System.Data
Imports System.Data.SqlClient
Partial Class Administrator_Admin_Services
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Insert_Admin_Service_Head", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@SH_Name", TextBox_Name.Text)
            command.Parameters.AddWithValue("@Category", DropDownList2.SelectedItem.Text)
            command.Parameters.Add("@SH_ID", SqlDbType.Int)
            command.Parameters("@SH_ID").Direction = ParameterDirection.Output
            con.Open()
            command.ExecuteNonQuery()
            HiddenFieldSH_ID.Value = command.Parameters("@SH_ID").Value
            'Response.Write(HiddenFieldSH_ID.Value)
            'Response.End()
            SqlDataSource_Save_Info.Insert()
            GridView1.DataBind()
            CheckBoxList_Services.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Button_Save_Dept_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save_Dept.Click
        Try
            For i As Integer = 0 To CheckBoxList_Services.Items.Count - 1
                If CheckBoxList_Services.Items(i).Selected = True Then
                    HiddenField_SID.Value = CheckBoxList_Services.Items(i).Value
                    SqlDataSource_Services.Insert()
                Else
                    If Already_Save(CheckBoxList_Services.Items(i).Value) > 0 Then
                        'Label1.Text = CheckBoxList_Services.Items(i).Value
                        HiddenField_SID.Value = CheckBoxList_Services.Items(i).Value
                        SqlDataSource_Services.Delete()
                    End If
                End If
            Next
            LabelSave.Visible = True
            LabelSave.ForeColor = Drawing.Color.Green : LabelSave.Font.Bold = True
            LabelSave.Text = "Services has been Save"
            'Response.Write("<script language ='javascript' type ='text/javascript'>window.open('../AdminMain.aspx','_top');</script>")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListCategory.SelectedIndexChanged
        HiddenField_SNAME.Value = "%" + TextBox_ServiceName.Text + "%"
        CheckBoxList_Services.DataBind()
        Check_Already_Save()
    End Sub

    Protected Sub CheckBoxList_Services_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles CheckBoxList_Services.PreRender
        Try
            Check_Already_Save()
        Catch ex As Exception

        End Try
    End Sub
    Sub Check_Already_Save()
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("SELECT S_ID FROM Admin_Dept_Services where Dept_ID=@Dept_ID", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@Dept_ID", DropDownList1.SelectedValue)
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            While (reader.Read)
                For i As Integer = 0 To CheckBoxList_Services.Items.Count - 1
                    If reader.Item(0).ToString = CheckBoxList_Services.Items(i).Value Then
                        CheckBoxList_Services.Items(i).Selected = True
                    End If
                Next
            End While
            con.Close()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then

            DropDownList2.DataBind()
            HiddenField_Service.Value = TextBox_Name.Text ' "%" '+ TextBox_Name.Text + "%"
            GridView1.DataBind()

        End If
        Try



            LabelSave.Visible = False
            Button_Save.Attributes.Add("OnClick", "return CheckRequirement(this)")
            'Check_Already_Save()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Function Already_Save(ByVal S_ID As Integer) As Integer
        Dim count As Integer = 0
        Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT count(S_ID) FROM Admin_Dept_Services where Dept_ID=@Dept_ID and S_ID=@S_ID", con)
        command.CommandType = CommandType.Text
        command.Parameters.AddWithValue("@Dept_ID", DropDownList1.SelectedValue)
        command.Parameters.AddWithValue("@S_ID", S_ID)
        con.Open()
        count = command.ExecuteScalar
        Return count
        con.Close()
    End Function

    Protected Sub DropDownList2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList2.SelectedIndexChanged
        HiddenField_Service.Value = "%" + TextBox_Name.Text + "%"
        GridView1.DataBind()
    End Sub

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim drp As DropDownList = GridView1.Rows(e.RowIndex).FindControl("DropDownList3")
        Dim txtname As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox1")
        Dim txtamount As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox3")
        Dim ddl As DropDownList = GridView1.Rows(e.RowIndex).FindControl("ddlchange")
        HiddenFieldCategory.Value = drp.SelectedValue
        HiddenFieldName.Value = txtname.Text
        HiddenFieldAmount.Value = txtamount.Text
        HiddenFieldEditStatus.Value = ddl.SelectedValue

    End Sub

    Protected Sub ButtonAll_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        For i As Integer = 0 To CheckBoxList_Services.Items.Count - 1
            If CheckBoxList_Services.Items(i).Selected = False Then
                CheckBoxList_Services.Items(i).Selected = True
            End If
        Next
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        HiddenField_Service.Value = "%" + TextBox_Name.Text + "%"
        GridView1.DataBind()
    End Sub

    Protected Sub btnViewGridData_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnViewGridData.Click
        pnlGrid.Visible = True
        pnlReport.Visible = False
        GridView1.DataBind()
    End Sub
    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub

    Protected Sub btnReport_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnReport.Click
        pnlGrid.Visible = False
        pnlReport.Visible = True

        Dim dsReports As New Reports
        Dim dad As New ReportsTableAdapters.usp_AdminServicesRatesTableAdapter

        dad.Fill(dsReports.usp_AdminServicesRates, DropDownList2.SelectedValue)

        ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/Administrator/Admin_Services_Report.rdlc")
        ReportViewer1.LocalReport.DataSources.Clear()
        Dim repDs As New ReportDataSource
        repDs.Name = "DataSet1"
        repDs.Value = dsReports.Tables("usp_AdminServicesRates")
        ReportViewer1.LocalReport.DataSources.Add(repDs)
        AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports


    End Sub
    Protected Sub lnkbtn_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = sender
        If Convert.ToInt32(lnk.CommandName) = 1 Then
            lnk.CommandName = 0
        Else
            lnk.CommandName = 1
        End If
        Dim conn As SqlConnection = New SqlConnection(constr)
        Try
            Dim sc As SqlCommand = New SqlCommand("UPDATE [dbo].[Admin_Services] SET [Active] = @Active WHERE s_id=@s_id", conn)
            sc.CommandType = CommandType.Text
            sc.Parameters.AddWithValue("@s_id", lnk.CommandArgument)
            sc.Parameters.AddWithValue("@Active", lnk.CommandName)
            conn.Open()
            sc.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message + "From Link button click")
        Finally
            conn.Close()
        End Try
        GridView1.DataBind()
    End Sub
End Class
