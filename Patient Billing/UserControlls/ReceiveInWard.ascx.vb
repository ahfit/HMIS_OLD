Imports System.Data
Imports System.Data.SqlClient
Partial Class Patient_Billing_UserControlls_ReceiveInWard
    Inherits System.Web.UI.UserControl

    Dim constr As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
    Dim floor As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Page.IsPostBack Then
            DropDownList_Consultant.DataBind()
            DropDownList_Consultant.SelectedValue = Session("ByDoctor")
            DropDownListFloor.DataBind()
            DropDownListFloor.SelectedValue = Session("WardId")
            Load_bed()
        End If
      
    End Sub
    Protected Sub DropDownListFloor_SelectedIndexChanged1(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListFloor.SelectedIndexChanged
        Load_bed()
        ''  Allocate()
    End Sub
    Protected Sub Load_bed()
        Try
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("SELECT distinct Category FROM admin_Hospital_Wards where ward_Id=@ward_Id", con)
            command.CommandType = CommandType.Text
            command.Parameters.AddWithValue("@ward_Id", DropDownListFloor.SelectedValue)
            con.Open()
            Dim reader As SqlDataReader = command.ExecuteReader
            While reader.Read
                Label1.Text = reader.Item(0).ToString
            End While
            floor = Label1.Text + " :"

            con.Close()
            If Label1.Text = "Room" Then
                RadioButtonListBed.Visible = False
                CheckBoxListRoom.Visible = True
                CheckBoxListRoom.DataSource = GetBeds()
                CheckBoxListRoom.DataBind()
            ElseIf Label1.Text = "Bed" Then
                '    CheckBoxListRoom.Visible = False
                '    RadioButtonListBed.Visible = True
                '    RadioButtonListBed.DataBind()
                Label1.Text = "Room"
                RadioButtonListBed.Visible = False
                CheckBoxListRoom.Visible = True
                CheckBoxListRoom.DataSource = GetBeds()
                CheckBoxListRoom.DataBind()
            End If


        Catch ex As Exception
            'Response.Write(ex.Message)
        End Try
    End Sub
    Protected Function GetBeds() As DataTable
        Dim manager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {New SqlParameter("@Ward_Id", DropDownListFloor.SelectedValue)}

        Dim dt As DataTable = manager.ExecuteDataTable("GetWardBeds", "Basic_Data_ConnectionString", sqlParams)

        Return dt
    End Function
    Protected Sub btnReceive_Click(sender As Object, e As EventArgs)
        Try

            Dim manager As DbManager = New DbManager()

            AssignBed()

            Dim sqlParams As SqlParameter() = {New SqlParameter("@RequestID", Session("RequestID"))}

            manager.ExecuteNonQuery("PatientWard_BedChanged", "Basic_Data_ConnectionString", sqlParams)
            Dim ct As Control = Me.Parent.FindControl("pnlReceive")

            ct.Visible = False

            Me.Page.GetType.InvokeMember("GetWardChangeRequests", System.Reflection.BindingFlags.InvokeMethod, Nothing, Me.Page, Nothing)
        Catch ex As Exception

        End Try
      

    End Sub
    Protected Sub AssignBed()


        Try
            If Label1.Text = "Room" Then

                For i As Integer = 0 To CheckBoxListRoom.Items.Count - 1
                    If CheckBoxListRoom.Items(i).Selected = True Then
                        Dim manager As DbManager = New DbManager()

                        Dim sqlParams As SqlParameter() = {
                            New SqlParameter("@ward_Id", DropDownListFloor.SelectedValue),
                             New SqlParameter("@Bed_ID", CheckBoxListRoom.Items(i).Value),
                             New SqlParameter("@Reg_No", DropDownListFloor.SelectedValue),
                             New SqlParameter("@Yearly_No", DropDownListFloor.SelectedValue),
                             New SqlParameter("@admission_By", DropDownListFloor.SelectedValue),
                             New SqlParameter("@FloorID", DropDownListFloor.SelectedValue),
                             New SqlParameter("@Patient_Type", DropDownListFloor.SelectedValue),
                            New SqlParameter("@status", DropDownListFloor.SelectedValue)
                        }

                        manager.ExecuteNonQuery("GetWardBeds", "Basic_Data_ConnectionString", sqlParams)

                    End If
                Next

            ElseIf Label1.Text = "Bed" Then


            End If
           

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub DropDownListFloor_SelectedIndexChanged(sender As Object, e As EventArgs)
        Load_bed()
    End Sub

    Protected Sub btnClose_Click(sender As Object, e As EventArgs)
        Dim ct As Control = Me.Parent.FindControl("pnlReceive")

        ct.Visible = False
    End Sub
End Class
