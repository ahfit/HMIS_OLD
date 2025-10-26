Imports System.Data
Imports System.Data.SqlClient
Partial Class Administrator_Admin_Services
    Inherits System.Web.UI.Page
    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        Try
            
            SqlDataSource_Save_Info.Insert()
            GridView1.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

  

   
  
 

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            LabelSave.Visible = False
            Button_Save.Attributes.Add("OnClick", "return CheckRequirement(this)")
            'Check_Already_Save()
        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    
   

    Protected Sub GridView1_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles GridView1.RowUpdating
        Dim drp As DropDownList = GridView1.Rows(e.RowIndex).FindControl("DropDownList3")
        Dim txtname As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox1")
        Dim txtamount As TextBox = GridView1.Rows(e.RowIndex).FindControl("TextBox3")
        'HiddenFieldCategory.Value = drp.SelectedValue
        'HiddenFieldName.Value = txtname.Text
        'HiddenFieldAmount.Value = txtamount.Text
    End Sub

  
    Protected Sub GridView1_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles GridView1.RowDeleting
        HiddenField_Asc_id.Value = (GridView1.Rows(e.RowIndex).Cells(0).Text)
        Response.Write(HiddenField_Asc_id.Value)
    End Sub
End Class
