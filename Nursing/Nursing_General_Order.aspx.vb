Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient
Partial Class Nursing_General_Order
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim obj_menu As New JavaScriptMenu
        obj_menu.loginvalidate()
        LabelSideMenu.Text = obj_menu.SideMenu(Right(Request.PhysicalPath, (Request.PhysicalPath.Length - Request.PhysicalApplicationPath.Length)))
        LabelFooter.Text = obj_menu.Footer_String()
        DataList_Ord_Per.DataBind()

    End Sub

    Protected Sub Button_Save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Save.Click
        DataList_Ord_Per.DataBind()


        For i As Integer = 0 To GridView_Order.Rows.Count - 1
            Dim chkbox_Ord As CheckBox = GridView_Order.Rows(i).FindControl("CheckBox_Order")


            If chkbox_Ord.Checked Then
                Dim hiddenField_Ord_Id As HiddenField = GridView_Order.Rows(i).FindControl("HiddenField_Order_id")
                Dim Chkbox_Imp As RadioButtonList = GridView_Order.Rows(i).FindControl("RadioButtonList_Ord_Imp")
                Dim txtbox_Remarks As TextBox = GridView_Order.Rows(i).FindControl("TextBox_Remarks")
                Try
                    Dim constr As String = ConfigurationManager.ConnectionStrings("NurseConnectionString").ConnectionString
                    Dim con As SqlConnection = New SqlConnection(constr)
                    Dim command As SqlCommand = New SqlCommand("Insert_Ord_Imp", con)
                    command.CommandType = CommandType.StoredProcedure


                    '@Imp_Status varchar(20),
                    '@Remarks varchar(200),
                    '@By_Emp int,
                    '@Phy_Ord_Id int,
                    '@Reg_No varchar(50),
                    '@Yearly_No int
                    command.Parameters.AddWithValue("@Ord_Date_Time", Convert.ToDateTime(DateTime.Now))
                    command.Parameters.AddWithValue("@Imp_Status", Chkbox_Imp.SelectedValue)
                    command.Parameters.AddWithValue("@Remarks", txtbox_Remarks.Text)
                    command.Parameters.AddWithValue("@By_Emp", Convert.ToInt32(Session("emp_id")))

                    command.Parameters.AddWithValue("@Phy_Ord_Id", hiddenField_Ord_Id.Value)


                    command.Parameters.AddWithValue("@Reg_No", Session("registrationNo"))
                    command.Parameters.AddWithValue("@Yearly_No", Session("YearlyNo"))

                    con.Open()
                    command.ExecuteNonQuery()
                    con.Close()
                Catch ex As Exception
                    Response.Write(ex.Message)
                    'Response.Write(ex.Message + "Main Insert  ")
                End Try
            End If
        Next
        GridView_Order.DataBind()
        DataList_Ord_Per.DataBind()

        'Response.Write(Session("YearlyNo") & "<--->")
        'Response.Write(Session("RegistrationNo"))
    End Sub
End Class
