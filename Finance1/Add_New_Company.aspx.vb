Imports System.Data
Imports System.Data.SqlClient
Partial Class Administrator_Add_New_Company
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ToString()
    Dim connection As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ToString()
    Protected Sub Button_Save_Name_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save_Name.Click
        Try
            HiddenField_CNIC.Value = TextBox_CNIC1.Text + TextBox_CNIC2.Text + TextBox_CNIC3.Text
            SqlDataSource_Save_Comp_Info.Insert()
            GridView1.DataBind()
            HiddenField_AID.Value = "0"
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Button_Save_Name.Attributes.Add("OnClick", "return CheckRequirment()")
        GridView1.DataBind()
    End Sub
    Protected Sub LoadControls(ByVal AN As Integer)
        Dim qry As String = "SELECT ISNULL(Parties.Party_Name, '') AS Party_Name, ISNULL(Parties.City,'') AS City, ISNULL( LEFT(Parties.CNIC, 5),'') AS CNIC1, ISNULL( LEFT(RIGHT(Parties.CNIC, 8), 7),'') AS CNIC2, ISNULL( RIGHT(Parties.CNIC, 1),'')  AS CNIC3,ISNULL(Parties.TAX_Payer_Status, '') AS TAX_Payer_Status, ISNULL(Parties.Party_Phone, '') AS Party_Phone, ISNULL(Parties.Party_Fax, '') AS Party_Fax, ISNULL(Parties.Website, '') AS Website, ISNULL(Parties.Email, '') AS Email, ISNULL(Parties.Address, '') AS Address, ISNULL(Parties.Contact_Person_Name, '') AS Contact_Person_Name, ISNULL(Parties.Account_No, '') AS Account_No FROM Parties INNER JOIN Account_Titles ON Parties.Party_Id = Account_Titles.Account_No WHERE (Account_Titles.Account_No = @Account_No)"
        Dim con As SqlConnection = New SqlConnection(constr)
        con.Open()
        Dim command As SqlCommand = New SqlCommand(qry, con)
        command.Parameters.AddWithValue("@Account_No", AN)
        Dim reader As SqlDataReader = command.ExecuteReader
        While reader.Read
            TextBox_Comp_Name.Text = reader.Item("Party_Name").ToString()
            TextBox_Phone.Text = reader.Item("Party_Phone").ToString()
            TextBox_Fax.Text = reader.Item("Party_Fax").ToString()
            TextBox_WebSite.Text = reader.Item("Website").ToString()
            TextBox_Email.Text = reader.Item("Email").ToString()
            TextBox_Address.Text = reader.Item("Address").ToString()
            TextBox_Contact_Person.Text = reader.Item("Contact_Person_Name").ToString()
            TextBox_ACNo.Text = reader.Item("Account_No").ToString()
            TextBox_City.Text = reader.Item("City").ToString()
            DropDownList_Status.SelectedValue = reader.Item("TAX_Payer_Status").ToString()
            TextBox_CNIC1.Text = reader.Item("CNIC1").ToString()
            TextBox_CNIC2.Text = reader.Item("CNIC2").ToString()
            TextBox_CNIC3.Text = reader.Item("CNIC3").ToString()
        End While
    End Sub
    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.SelectedIndexChanged
        LoadControls(GridView1.SelectedValue)
        HiddenField_AID.Value = GridView1.SelectedValue
        Button_Update.Visible = True
		 Button_Back.Visible = True
        Button_Save_Name.Visible = False
    End Sub

    Protected Sub Button_Update_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Update.Click
        HiddenField_CNIC.Value = TextBox_CNIC1.Text & TextBox_CNIC2.Text & TextBox_CNIC3.Text
        Button_Update.Visible = False
        Button_Save_Name.Visible = True
		 Button_Back.Visible = False
        SqlDataSource_Save_Comp_Info.Insert()
        HiddenField_AID.Value = "0"
        GridView1.DataBind()
        TextBox_Comp_Name.Text = ""
        TextBox_Phone.Text = ""
        TextBox_Fax.Text = ""
        TextBox_WebSite.Text = ""
        TextBox_Email.Text = ""
        TextBox_Address.Text = ""
        TextBox_Contact_Person.Text = ""
        TextBox_ACNo.Text = ""
        TextBox_CNIC1.Text = ""
        TextBox_CNIC2.Text = ""
        TextBox_CNIC3.Text = ""
        TextBox_NTN_No.Text = ""
        TextBox_City.Text = ""

    End Sub

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        GridView1.DataBind()
    End Sub
	 Protected Sub Button_Back_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Back.Click
        Response.Redirect(Request.RawUrl)
    End Sub



    Protected Sub Mark_Billing_Party_Click(sender As Object, e As EventArgs)
        Dim lbtn As LinkButton = CType(sender, LinkButton)
        Dim row As GridViewRow = CType(lbtn.NamingContainer, GridViewRow)
        Dim lblId As Label = CType(row.FindControl("lblPartyId"), Label)
        Dim id As Integer = Convert.ToInt32(lblId.Text)

        Dim conn As SqlConnection = New SqlConnection(connection)
        Dim sc As SqlCommand
        Try
            conn.Open()
            sc = New SqlCommand("MarkBillingParty", conn)
            sc.CommandType = CommandType.StoredProcedure
            sc.Parameters.AddWithValue("@id", id)
            sc.Parameters.AddWithValue("@HospitalId", Session("HospitalId"))
            sc.ExecuteNonQuery()
        Catch ex As Exception

        Finally
            conn.Close()
        End Try

    End Sub
End Class
