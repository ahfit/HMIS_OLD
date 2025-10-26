' Author             Imran Ahmed Awan 
' Created on         November 2006
' Description        This page save the information of the new the employee 
'                    The information saved in the employee table 
Imports System.Data.SqlClient

Partial Class Employee
    Inherits System.Web.UI.Page
    ' this function insert the information of the employee in the database by sqldatasourcesaveinfo

    Protected Sub save_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles ButtonSave.Click
        Dim a As String
        a = txtmonth.Text & "-" & txtday.Text & "-" & txtyear.Text
        Try

            Dim joindate As Date = CDate(a)
            'Response.Write(joindate)
        Catch ex As Exception
            LblInvalidDate.Text = "Enter Valid Date"
            Exit Sub
        End Try
        Dim abc As Date
        abc = CType(a, Date)
        Session("EJDate") = a
        HiddenFieldCNIC.Value = txtnic1.Text & txtnic2.Text & txtnic3.Text
        HiddenFieldHomePhone.Value = txthp1.Text & txthp2.Text & txthp3.Text
        HiddenFieldOfficePhone.Value = txtop1.Text & txtop2.Text & txtop3.Text
        Try
            SqlDataSourceSaveInfo.Insert()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    ' this function checked the payscale of the employee according to its designation 

    Protected Sub designation_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListdesignation.SelectedIndexChanged
        Dim def As String
        def = DropDownListdesignation.SelectedItem.Text
        Dim abc As Integer
        abc = 0
        Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
        Dim mycommand As New System.Data.SqlClient.SqlCommand("select Min_PayScale from Designation where (Designation_Name = @name )", con)
        mycommand.CommandType = Data.CommandType.Text
        Dim param As System.Data.SqlClient.SqlParameter
        param = mycommand.Parameters.Add("@name", Data.SqlDbType.VarChar)
        param.Value = def
        Try
            mycommand.Connection.Open()
            abc = CType(mycommand.ExecuteScalar, Integer)
            mycommand.Connection.Close()

        Catch ex As Exception
            Label1.Text = ex.Message

        End Try
        If abc <> 0 Then
            Dropdownlistpayscale.SelectedIndex = abc - 1
        End If
    End Sub


    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                'Response.Redirect("loginnew.aspx")

            End If
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    ' this function check if the page is not postback then fill the jion date field 
    ' with server current date if the form is posted back then can not insert the value in the 
    ' join date field
    Sub ValidateMainPage()
        Try
            Dim validate As New Validate_Pages_for_admin
            Dim i As Integer = validate.Validate_Main_pages(Session("Emp_ID"), "Employee.aspx")
            If i = 0 Then
                Session.RemoveAll()
                'Response.Redirect("loginnew.aspx")
            Else

            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            'ValidateMainPage()
            'loginvalidate(Session("emp_id"), Session("dept_id"))
            If (Page.IsPostBack = False) Then


                Dim a As Integer = Date.Now.Day
                txtday.Text = a
                Dim b As Integer = Date.Now.Month
                txtmonth.Text = b
                Dim c As Integer = Date.Now.Year
                txtyear.Text = c


            End If
            form1.DefaultButton = "ButtonSave"
            RangeValidatorYear.MaximumValue = Date.Now.Year
        Catch ex As Exception
            response.write(ex.message)
        End Try
       
    End Sub
    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Try
            Response.Redirect("../Loginnew.aspx")
        Catch ex As Exception
            response.write(ex.message)
        End Try

    End Sub
    Protected Sub ImageButtonlogout_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogout.Click
        Try
            Session.RemoveAll()
            Response.Redirect("../Loginnew.aspx")
        Catch ex As Exception
            response.write(ex.message)
        End Try
    End Sub
End Class

