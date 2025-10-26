Imports System.Data
Imports System.Data.SqlClient
Partial Class addalert
    Inherits System.Web.UI.Page
    Dim user_authen As New User_page_Authentication
    
   
    Dim constr As String = ConfigurationManager.ConnectionStrings("TreatmentConnectionString").ConnectionString

    

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.load
        lblMessage.Text = ""
    End Sub

     

    Protected Sub Button_Alert_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Alert.Click
        SqlDataSource_Alert.Insert()
        GridView_Alert.DataBind()
        DataList_Alert.DataBind()
        TextBox_Alert.Text = ""
    End Sub

      

    Protected Sub GridView_Alert_RowDeleted(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeletedEventArgs) Handles GridView_Alert.RowDeleted
        DataList_Alert.DataBind()
    End Sub


    Protected Sub GridView_Alert_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView_Alert.SelectedIndexChanged

    End Sub

    
    Protected Sub lbtnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim lbtn As LinkButton = sender

        Dim gvr As GridViewRow = lbtn.NamingContainer
        Dim lbl As Label = gvr.FindControl("lbl_Alert_ID")
        hf_Alert_ID.Value = lbl.Text
        pnl_AlertReason.Visible = True

    End Sub

    Protected Sub btnOK_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnOK.Click
        If txtReason.Text.Length >= 10 Then
            If hf_Alert_ID.Value <> "" Then
                SqlDataSource_Alert.Update()
                pnl_AlertReason.Visible = False
                GridView_Alert.DataBind()
            End If
        Else
            lblMessage.Text = "Reason is must be greater then 10 Characters"
        End If
    End Sub

    Protected Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        pnl_AlertReason.Visible = False
    End Sub
End Class
