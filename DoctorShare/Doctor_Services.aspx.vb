Imports System.Data
Imports System.Data.SqlClient
Imports System.Text
Imports System.Linq
Imports System.Collections
Imports System.Collections.Generic

Partial Class Administrator_Doctor_Services
    Inherits System.Web.UI.Page

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Save_Values()
        GridView1.DataBind()
    End Sub
    Protected Sub FillHospital()
        Dim conststr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString

        Using con As SqlConnection = New SqlConnection(conststr)
            Dim command As SqlCommand = New SqlCommand("SELECT    Hospital_ID, Hospital_Name FROM  Hospital ", con)
            Dim sda As SqlDataAdapter = New SqlDataAdapter(command)
            Dim dt As DataTable = New DataTable()
            sda.Fill(dt)
            ddl_Hospital.DataValueField = "Hospital_ID"
            ddl_Hospital.DataTextField = "Hospital_Name"
            ddl_Hospital.DataSource = dt
            ddl_Hospital.DataBind()

            ddl_Hospital.SelectedValue = Session("HospitalId")
        End Using
    End Sub
    Protected Sub GetSubDept()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
          New SqlParameter("@HospitalId", ddl_Hospital.SelectedValue),
          New SqlParameter("@Type", "1")
           }
        Dim dt As DataTable = objManager.ExecuteDataTable("GetSubDepartments_BYHospital", "Basic_Data_ConnectionString", sqlParams)
        DropDownList1.DataSource = dt
        DropDownList1.DataBind()


    End Sub
    Protected Sub GetConsultantBySubDept()
        Dim objManager As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
          New SqlParameter("@SubDeptId", DropDownList1.SelectedValue)
           }
        Dim dt As DataTable = objManager.ExecuteDataTable("GetConsultantBySubDept", "Basic_Data_ConnectionString", sqlParams)
        DropDownList_Doctor.DataSource = dt
        DropDownList_Doctor.DataBind()


        DropDownList2.DataSource = dt
        DropDownList2.DataBind()


    End Sub
    Function Check_Fee(ByVal fee As Integer, ByVal SID As Integer) As Boolean
        Dim Amount As Integer = 0
        Try

            Dim Flag As Boolean = False
            Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("SELECT @Amount =S_Amount FROM Admin_Services where S_ID = @S_ID", con)
            mycommand.CommandType = CommandType.Text
            mycommand.Parameters.AddWithValue("@S_ID", SID)
            mycommand.Parameters.Add("@Amount", SqlDbType.Int)
            mycommand.Parameters("@Amount").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            mycommand.Connection.Close()
            Amount = mycommand.Parameters("@Amount").Value
            If Amount >= fee Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False

        End Try
    End Function

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


        If Session("Emp_Id") Is Nothing Or Session("Dept_id") Is Nothing Then
            ''Response.Redirect("../loginnew.aspx")
            Response.Write("<script language='javascript' type='text/javascript'>window.open('../login.aspx', '_top')</script>")
        End If
        If Not Page.IsPostBack Then
            FillHospital()
            GetSubDept()
            GetConsultantBySubDept()
            RadioButtonList_Cat.DataBind()
            RadioButtonList_Cat.SelectedIndex = 0
            
            GridView_Category.DataBind()
            GridView1.DataBind()
        End If

        Label_Message.Text = ""
    End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Save_Values()
    '    GridView1.DataBind()
    'End Sub
    Sub Save_Values()
        Try
            Dim flag As Boolean = False
            'For i As Integer = 0 To GridView_Category.Rows.Count - 1
            '    Dim chk As CheckBox = GridView_Category.Rows(i).FindControl("CheckBox1")
            '    Dim txt_fee As TextBox = GridView_Category.Rows(i).FindControl("TextBox_Charges")
            '    Dim txt_pay_via_bank As TextBox = GridView_Category.Rows(i).FindControl("TextBox_pay_via_bank")
            '    Dim hid_SID As HiddenField = GridView_Category.Rows(i).FindControl("HiddenField1")
            '    Dim RBL_mode As RadioButtonList = GridView_Category.Rows(i).FindControl("RadioButtonList1")

            '    If chk.Checked = True Then
            '        If Check_Fee(CInt(txt_fee.Text), hid_SID.Value) = True Then
            '            'HiddenField_S_ID.Value = hid_SID.Value
            '            'HiddenField_Charges.Value = txt_fee.Text
            '            'SqlDataSource_Save_Info.Insert()
            '            'Label_Message.Text = "Information Saved"
            '            'Label_Message.Font.Bold = True
            '            'Label_Message.ForeColor = Drawing.Color.Blue

            '        Else
            '            Label_Message.Text = "Some Charges of The Services Are Greater Then Service Fee <br />Information Not Save"
            '            Label_Message.ForeColor = Drawing.Color.Red
            '            Exit Sub
            '        End If
            '    End If
            'Next
            Dim chk As New CheckBox
            Dim txt_fee As New TextBox
            Dim txt_pay_via_bank As TextBox
            Dim hid_SID As New HiddenField
            Dim RBL_mode As New RadioButtonList

            For i As Integer = 0 To GridView_Category.Rows.Count - 1
                chk = GridView_Category.Rows(i).FindControl("CheckBox1")
                txt_fee = GridView_Category.Rows(i).FindControl("TextBox_Charges")
                txt_pay_via_bank = GridView_Category.Rows(i).FindControl("TextBox_pay_via_bank")
                hid_SID = GridView_Category.Rows(i).FindControl("HiddenField1")
                RBL_mode = GridView_Category.Rows(i).FindControl("RadioButtonList1")

                If chk.Checked = True Then
                    If Check_Fee(CInt(txt_fee.Text), hid_SID.Value) = True Then
                        HiddenField_S_ID.Value = hid_SID.Value
                        HiddenField_Charges.Value = txt_fee.Text
                        HiddenField_pay_via_bank.Value = txt_pay_via_bank.Text
                        SqlDataSource_Save_Info.InsertParameters("mode").DefaultValue = RBL_mode.SelectedValue
                        SqlDataSource_Save_Info.Insert()
                    Else
                        Label_Message.Text = "Charges Must Less Then Service Fee"
                        Label_Message.ForeColor = Drawing.Color.Red
                    End If
                End If
            Next

            ''SqlDataSource_Save_Info.Insert()
            Label_Message.Text = "Information Saved"
            Label_Message.Font.Bold = True
            Label_Message.ForeColor = Drawing.Color.Blue

        Catch ex As Exception
            Label_Message.Text = "Information Not Saved"
            Label_Message.ForeColor = Drawing.Color.Red
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Response.Redirect("~/Patient%20Billing/Update_Admin_Services.aspx")
    End Sub


    Private Sub data()

    End Sub

    Protected Sub btnForward_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnForward.Click

        If DropDownList_Doctor.SelectedValue <> DropDownList2.SelectedValue Then

            SqlDataSource_Grid_View.SelectParameters("Doctor_ID").DefaultValue = DropDownList_Doctor.SelectedValue
            Dim dv As DataView = CType(SqlDataSource_Grid_View.Select(DataSourceSelectArguments.Empty), DataView)

            Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim Data As StringBuilder = New StringBuilder()

            Dim dt As DataTable = New DataTable()

            dt = dv.ToTable()

            'Dim  text As String = string.Join(",", dt.AsEnumerable().Select(x=>x["EMAIL"].ToString()).ToArray());


            For Each item As DataRow In dt.Rows
                item("Doctor_ID") = DropDownList2.SelectedValue.ToString()
            Next

            ' Dim sid As String = String.Join(", ", dt.Rows.OfType(Of DataRow)().SelectMany(Function(r) r("S_ID").ToString()))

            Dim sid As String = String.Join(",", dt.AsEnumerable().[Select](Function(x) x("S_ID").ToString()).ToArray())

            con.Open()
            Dim command As SqlCommand = New SqlCommand("uspDeleteDoctorServices", con)
            command.Parameters.AddWithValue("@doctorID", DropDownList2.SelectedValue)
            command.Parameters.AddWithValue("@serviceID", sid)
            command.CommandType = CommandType.StoredProcedure

            command.ExecuteNonQuery()

            For Each item As DataRow In dt.Rows

                Dim query As String = "INSERT INTO Doctor_Service ([Doctor_ID],[Service_ID]  ,[Charges],[Bank_Payment])        VALUES(" + item("Doctor_ID").ToString() + "," + item("S_ID").ToString() + "," + item("Charges").ToString() + "," + item("Bank Charges").ToString() + " );"

                Data.Append(query)
            Next

            Dim mycommand As New System.Data.SqlClient.SqlCommand(Data.ToString(), con)
            mycommand.CommandType = CommandType.Text

            mycommand.ExecuteNonQuery()
            con.Close()

            Label_Message.Text = "Services are Successfully Forward to " + DropDownList2.SelectedItem.ToString() + ""
        End If
    End Sub

    Protected Sub DropDownList_Doctor_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList_Doctor.SelectedIndexChanged
        GridView1.DataBind()
    End Sub

    Protected Sub DropDownList2_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList2.SelectedIndexChanged
        GridView1.DataBind()
    End Sub
    <System.Web.Script.Services.ScriptMethod(), _
    System.Web.Services.WebMethod()> _
    Public Shared Function SearchItems(ByVal prefixText As String, ByVal count As Integer) As List(Of String)
        Dim items As List(Of String) = New List(Of String)
        Dim conn As SqlConnection = New SqlConnection
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim cmd As SqlCommand = New SqlCommand
        cmd.CommandText = "SELECT S_ID, S_Name S_Name FROM Admin_Services WHERE S_Name Like '%' + @Search + '%' Or S_ID like '%' + @Search + '%'"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader

        While sdr.Read
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("S_Name").ToString, sdr("S_ID").ToString))

        End While

        Return items
    End Function

    Protected Sub Button1_Search_Click(ByVal sender As Object, ByVal e As EventArgs)
        GridView_Category.DataBind()
    End Sub


    Protected Sub ddl_Hospital_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddl_Hospital.SelectedIndexChanged
        ddl_Hospital.DataBind()
        DropDownList1.DataBind()
    End Sub

    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs)
        GetConsultantBySubDept()
    End Sub
End Class
