Imports System.Data
Imports System.Data.SqlClient
Imports System.Collections.Generic
Imports Microsoft.Reporting.WebForms


Partial Class Store_UpdateMedicineData
    Inherits System.Web.UI.Page
    Dim SString As String = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then
            'GetMedicineForConsumption()
        End If

    End Sub
    <System.Web.Script.Services.ScriptMethod, System.Web.Services.WebMethod>
    Public Shared Function SearchItems(prefixText As String, count As Integer) As List(Of String)
        Dim items As New List(Of String)()
        Dim conn As New SqlConnection()
        conn.ConnectionString = ConfigurationManager.ConnectionStrings("STOREConnectionString").ConnectionString
        Dim cmd As New SqlCommand()
        cmd.CommandText = "Select Item_Code,Item_Name From Store_Items Where Item_Name LIKE '%' + @Search + '%'"
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@Search", prefixText)
        cmd.Connection = conn
        conn.Open()
        Dim sdr As SqlDataReader = cmd.ExecuteReader()
        While sdr.Read()
            items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(sdr("Item_Name").ToString(), sdr("Item_Code").ToString()))
        End While
        Return items
    End Function
    Sub GetMedicineForConsumption()
        Dim objDbManager As DbManager = New DbManager


        Dim sqlParams As SqlParameter() =
            {
                New SqlParameter("@mgname", txtItemName.Text),
                New SqlParameter("@med_Code", TextBox_Med_Code.Text)
           }
        GridViewMedicine.DataSource = objDbManager.ExecuteDataTable("Select_Medicine_For_PharmacyBatch_New", "STOREConnectionString", sqlParams)
        GridViewMedicine.DataBind()

    End Sub
   
    Protected Sub btn_Report_Click(sender As Object, e As EventArgs) Handles btn_Report.Click
        GetMedicineForConsumption()
    End Sub

    Protected Sub lnk_Update_Click(sender As Object, e As EventArgs)
        Dim con As SqlConnection = New SqlConnection(SString)

        Try
            Dim btn As Button = TryCast(sender, Button)
            Dim row As GridViewRow = TryCast(btn.NamingContainer, GridViewRow)

            Dim Batch As TextBox = TryCast(row.FindControl("txtBatch"), TextBox)
            Dim Exp As TextBox = TryCast(row.FindControl("txtExpire"), TextBox)
            Dim SP As TextBox = TryCast(row.FindControl("TextBox_RetailPrice"), TextBox)
            'Dim SBID As Label = TryCast(row.FindControl("lblSB"), Label)
            Dim Item_Code As TextBox = TryCast(row.FindControl("txtMedCode"), TextBox)


            Dim query As String = "Update_Medicine_Data"
            Dim cmd As SqlCommand = New SqlCommand(query, con)
            cmd.CommandType = CommandType.StoredProcedure
            cmd.Parameters.AddWithValue("@BatchNo", Batch.Text)
            cmd.Parameters.AddWithValue("@Exp", Exp.Text)
            cmd.Parameters.AddWithValue("@SalePrice", SP.Text)
            cmd.Parameters.AddWithValue("@Item_Code", Item_Code.Text)
            'cmd.Parameters.AddWithValue("@SBID", SBID.Text)
            cmd.Parameters.AddWithValue("@EmpID", Session("emp_id"))

            con.Open()
            cmd.ExecuteNonQuery()
        Catch
        Finally
            con.Close()
        End Try
    End Sub
End Class
