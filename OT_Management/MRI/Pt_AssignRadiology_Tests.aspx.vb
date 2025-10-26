Imports Microsoft.VisualBasic
Imports System.Data
Imports System.Data.SqlClient
Partial Class Pt_AssignRadiology_Tests
    Inherits System.Web.UI.Page


    
    Dim count As Integer = 0
    Dim AgeDate As String = ""
    Dim areq As String = "LGH/251120060019"
    Dim breq As String = "196985"
    Dim flag As Integer = 0
    Dim a As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
    Dim statuscmo As String


    '=====================********======================================'
    ' Developer Name            Imran Ahmed Awan, Muhammad Aun Abbas
    ' Design Approved  by       Muhammad Tariq
    ' Web Designed By           Imran Sharif
    ' Date Started              October 20 ,2006
    ' Description               This Is for the Test Select Module for the patient that a doctor
    '                           recommend for the patient if tests are already assigned 
    '                           its tests are shown and vitals of patients are displayed on left 
    '                           side of the page.
    ' This form is used for patient Test in Emergency.
    ' Completed date          October 30 , 2006
    '====================*********======================================


    'This function which test are already recommended to the patient and dispalyed The Checked item of the checkboxlist

    Sub checkTests(ByVal checkbox As CheckBoxList)
        Try
            ' Response.Write(Session("YearlyNo") + "ASDF ")
            ' Response.Write(Session("registrationNo") + "ASDFADSF")
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con1 As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand1 As New System.Data.SqlClient.SqlCommand("SELECT [RID] FROM [Pt_Radiology_LabTest] Where ((PayID = @PayID) and (RegNo = @RegNo) and (Status = 'Not Done'))", con1)
            mycommand1.CommandType = Data.CommandType.Text
            mycommand1.Parameters.AddWithValue("@PayID", Session("YearlyNo"))  ' 200069) '
            mycommand1.Parameters.AddWithValue("@RegNo", Session("registrationNo"))
            mycommand1.Connection.Open()
            Dim b As Integer
            Dim sqlreader As SqlDataReader = mycommand1.ExecuteReader
            checkbox.DataBind()

            While (sqlreader.Read())
                For b = 0 To checkbox.Items.Count - 1
                    If (sqlreader.Item(0) = checkbox.Items(b).Value) Then
                        checkbox.Items(b).Selected = True
                    End If
                Next
            End While

            mycommand1.Connection.Close()



        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub
    'this function check alll the items of the selected list one by one 
    'Which items are checked the Function Insert the Values in the database 
    'Which Items of the selected checkboxlist are Unchecked That are Delete From the Database 
    Sub Checkboxlistcheck(ByVal checkboxlist As CheckBoxList)
        Try
            Dim b As Integer
            Dim abc As String
            Dim array(checkboxlist.Items.Count - 1) As String
            For b = 0 To checkboxlist.Items.Count - 1
                If checkboxlist.Items(b).Selected = True Then
                    ' if condition use to Inser t the Values in the  db
                    array(b) = checkboxlist.Items(b).Value
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("[Pt_Radiology_insert]", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure

                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@RID", checkboxlist.Items(b).Value)
                    param = mycommand.Parameters.AddWithValue("@DateTime", Date.Now)
                    param = mycommand.Parameters.AddWithValue("@DoctorID", Session("emp_id"))
                    param = mycommand.Parameters.AddWithValue("@EMPID", Session("emp_id"))
                    param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    param = mycommand.Parameters.AddWithValue("@RSGID", DataListRadiology.SelectedValue)
                    Try
                        mycommand.Connection.Open()
                        'abc = CType(mycommand.ExecuteScalar, Integer)
                        mycommand.ExecuteNonQuery()
                        mycommand.Connection.Close()
                    Catch ex As Exception
                        Label1.Text = ex.Message
                    End Try
                Else
                    ' Else Condition is used to delete the Values  that are Unchecked 
                    Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(a)
                    Dim mycommand As New System.Data.SqlClient.SqlCommand("Pt_Radiology_delete", con)
                    mycommand.CommandType = Data.CommandType.StoredProcedure
                    Dim param As System.Data.SqlClient.SqlParameter
                    param = mycommand.Parameters.AddWithValue("@PayID", Session("YearlyNo")) 'Session("BMIPayID")
                    param = mycommand.Parameters.AddWithValue("@RID", checkboxlist.Items(b).Value)
                    param = mycommand.Parameters.AddWithValue("@RegNo", Session("registrationNo")) 'Session("EMORegNo")
                    Try
                        mycommand.Connection.Open()
                        abc = CType(mycommand.ExecuteScalar, Integer)
                        mycommand.Connection.Close()

                    Catch ex As Exception
                        Label1.Text = ex.Message
                    End Try
                End If

            Next
        Catch ex As Exception
            '    Label1.Text = ex.Message
        End Try
    End Sub

    Protected Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        'inserts tests for patients in database
        ' check that which checboxlist is active and send the value to checkboxlistcheck function.
       
        Checkboxlistcheck(CheckBoxListForRadiologySG)



    End Sub

    Protected Sub BTNcheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BTNcheckAll.Click

        CheckAll(CheckBoxListForRadiologySG)
      

    End Sub
    Protected Sub BtnUncheckAll_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnUncheckAll.Click
        
        UncheckAll(CheckBoxListForRadiologySG)

    End Sub
    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)

        If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
            Response.Redirect("PatientTreatment.aspx")
        End If
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim Object_View_Page As New Employee_View_Pages
        Object_View_Page.viewPage(Session("emp_id"), Request.ServerVariables("Remote_Addr"), Page.Request.PhysicalPath.ToString, Page.Request.PhysicalPath.Length, Page.Request.PhysicalApplicationPath.Length)
        loginvalidate(Session("emp_id"), Session("dept_id"))
        ' datafields()
        Session.Add("TestStatus", Session("Teststatus"))
        statuscmo = Session("TestStatus")
        Session.Timeout = 60
    End Sub

    ' This function check all the items of the selected chechboxlist.

    Sub CheckAll(ByVal CheckBoxAll As CheckBoxList)
        Dim b As Integer
        Dim array(CheckBoxAll.Items.Count - 1) As String
        For b = 0 To CheckBoxAll.Items.Count - 1
            CheckBoxAll.Items(b).Selected = True
        Next
    End Sub
    ' This function Uncheck all the items of the selected chechboxlist.

    Sub UncheckAll(ByVal UncheckboxAll As CheckBoxList)
        Dim b As Integer
        Dim array(UncheckboxAll.Items.Count - 1) As String
        For b = 0 To UncheckboxAll.Items.Count - 1
            UncheckboxAll.Items(b).Selected = False
        Next
    End Sub



    Protected Sub ImageButtonback_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonback.Click
        Try

            'Response.Redirect("EMOPatientInfo.aspx?a=a&b=b&c=c")
            If (statuscmo <> "") Then
                Session.Add("TestStatus", statuscmo)
            End If
            Response.Redirect("EMOPatientInfo.aspx")
        Catch ex As Exception

        End Try
        Response.Redirect("EMOPatientInfo.aspx")
    End Sub

    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Response.Redirect(Session("mainpage"))
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButton1.Click
        Session.RemoveAll()
        Response.Redirect("Login.aspx")
    End Sub


    Protected Sub DataListRadiology_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListRadiology.SelectedIndexChanged
        BTNcheckAll.Visible = True
        btnAdd.Visible = True
        BtnUncheckAll.Visible = True
        checkTests(CheckBoxListForRadiologySG)
        Session.Timeout = 30
    End Sub
End Class
