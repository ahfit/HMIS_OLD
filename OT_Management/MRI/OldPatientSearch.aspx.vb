Imports System.Data
Imports System.Data.SqlClient
Partial Class OldPatientSearch
    Inherits System.Web.UI.Page
    Dim pgindex As Integer = 0

    Sub loginvalidate(ByVal UserId As String, ByVal dept As String)
        Try
            If ((Session("emp_id") Is Nothing) And (Session("dept_id") Is Nothing)) Then
                Response.Redirect("login.aspx")
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub

    Protected Sub BtnSearch_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnSearch.Click
        Try
            search(0)
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub
    Sub search(ByVal a As Integer)

        Dim str, str1 As String
        str = ""
        Try

            If TextBoxYearlyNo.Text = "" Then
                TextBoxYearlyNo.Text = -1
            End If
            If (TextBoxYearlyNo.Text = -1) Then
            Else

                str = " and payment.payid like '%" + TextBoxYearlyNo.Text + "%'"
            End If
            If (TextBoxFName.Text <> "") Then
                str = str + " and patient.pfname like '" + TextBoxFName.Text + "%'"
            End If
            If (TextBoxMName.Text <> "") Then
                str = str + "and patient.pmname like '" + TextBoxMName.Text + "%'"
            End If

            'If (TextBoxLName.Text <> "") Then
            '    str = str + " and patient.plname like '" + TextBoxLName.Text + "%'"
            'End If


            If (TextBoxRegNO.Text <> "") Then
                str = str + " and patient.regno like '%" + TextBoxRegNO.Text + "%'"
            End If
            If (TextBoxRFName.Text <> "") Then
                str = str + " and patient.RFName like '%" + TextBoxRFName.Text + "%'"
            End If
            If (TextBoxRLName.Text <> "") Then
                str = str + " and patient.RMName like '%" + TextBoxRLName.Text + "%'"
            End If
            '=========================================
            If Not (RadioButtonList_Relation.SelectedValue Is Nothing) Then
                str = str + " and patient.relation like '%" + RadioButtonList_Relation.SelectedValue + "%'"
            End If
            '===================================================
            If WebDateChooserDOB.Value Is Nothing Or WebDateChooserDOB.Text = "Null" Then

            Else
                Dim dates As String = WebDateChooserDOB.Value
                ' str = str + " and Convert(varchar,patient.DateOfBirth,101)='" + dates + "'" 'convert(varchar," + dates + ",101)" '+  '+ "%'"
                str = str + " and datepart(dd,patient.DateOfBirth)=datepart(dd,'" + WebDateChooserDOB.Value + "') and  datepart(mm,patient.DateOfBirth)=datepart(mm,'" + WebDateChooserDOB.Value + "') and datepart(yyyy,patient.DateOfBirth)=datepart(yyyy,'" + WebDateChooserDOB.Value + "')"
            End If
            If WebdatechooserByDate.Value Is Nothing Or WebdatechooserByDate.Text = "Null" Then

            Else
                Dim dates As String = WebdatechooserByDate.Value
                ' str = str + " and Convert(varchar,patient.DateOfBirth,101)='" + dates + "'" 'convert(varchar," + dates + ",101)" '+  '+ "%'"
                str = str + " and datepart(dd,payment.DateTime)=datepart(dd,'" + WebdatechooserByDate.Value + "') and  datepart(mm,payment.DateTime)=datepart(mm,'" + WebdatechooserByDate.Value + "') and datepart(yyyy,payment.DateTime)=datepart(yyyy,'" + WebdatechooserByDate.Value + "')"
            End If

            If (TextBox_HomePhone.Text <> "") Then
                str = str + " and patient.HomePhone like '%" + TextBox_HomePhone.Text + "%'"
            End If

            'If (CheckBoxDiagnosis.Checked = True) Then
            '    If (DropDownListDiagnosis.Enabled) Then
            '        If (DropDownListDiagnosis.SelectedValue <> "") Then
            '            str = str + " and payment.diagonosis = '" + DropDownListDiagnosis.SelectedValue + "'"
            '        End If

            '    End If
            'End If
            Dim str2 As DateTime

            If (TextBoxDaysbefore.Text <> "") Then
                str2 = DateAdd(DateInterval.DayOfYear, -CType(TextBoxDaysbefore.Text, Integer), Date.Now.Date)

                str = str + " and payment.datetime >=  '" + str2 + "'"
            Else

            End If

            ' str1 = "SELECT Payment.PayID as [Record ID], Patient.RegNo as [PIN No.], ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') AS [Patient Name],isnull(Patient.Relation,' ')+ ' ' + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS [Father's Name], Patient.Age,payment.Diagonosis as Diagnosis  FROM Payment INNER JOIN Patient ON Payment.RegNo = Patient.RegNo INNER JOIN PatientSex ON Patient.SexID = PatientSex.SexID  where patient.pfname like " + "'%'"
            str1 = "SELECT Patient.RegNo AS [Registration  No.], ISNULL(Patient.Prefix, ' ') + ' ' + ISNULL(Patient.PFName, ' ') + ' ' + ISNULL(Patient.PMName, ' ') + ' ' + ISNULL(Patient.PLName, ' ') AS [Patient Name], ISNULL(Patient.Relation, '') + ' ' + ISNULL(Patient.RFName, ' ') + ' ' + ISNULL(Patient.RMName, ' ') + ' ' + ISNULL(Patient.RLName, ' ') AS [Raletive Name], CONVERT(varchar, Patient.Age) + ' ' + Patient.AgeType AS Age FROM PatientSex INNER JOIN Patient ON PatientSex.SexID = Patient.SexID where patient.pfname Like " + "'%'" ',payment.Diagonosis as Diagnosis
            Dim strcount As String = "SELECT count (Patient.RegNo) FROM Patient INNER JOIN PatientSex ON Patient.SexID = PatientSex.SexID where patient.pfname like " + "'%'"
            strcount += str
            str1 = str1 + str
            str1 += "order by patient.regdatetime desc"
            'Response.Write(str1)
            Dim ds As New DataSet()
            Dim da As New SqlDataAdapter(strcount, SqlDataSourceSearch.ConnectionString)
            da.Fill(ds, "searchresult")

            Label1.Text = ds.Tables(0).Rows(0).Item(0).ToString + " records found"
            SqlDataSourceSearch.SelectCommand = str1
            GridViewSearch.DataSource = SqlDataSourceSearch


            GridViewSearch.AutoGenerateColumns = True

            GridViewSearch.ShowFooter = True
            GridViewSearch.AllowPaging = True
            GridViewSearch.PageSize = 25
            GridViewSearch.PageIndex = a

            GridViewSearch.DataBind()
            GridViewSearch.PagerSettings.Mode = PagerButtons.NumericFirstLast
            GridViewSearch.PagerSettings.FirstPageText = "First"
            GridViewSearch.PagerSettings.LastPageText = "Last"


            'GridViewSearch.PagerSettings.PreviousPageText = "&lt;"
            GridViewSearch.PagerSettings.Visible = True





            ' 
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        TextBoxYearlyNo.Text = ""


    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            Session.Timeout = 60
            loginvalidate(Session("emp_id"), Session("dept_id"))
            form1.DefaultButton = "BtnSearch"
            'CheckBoxDiagnosis.Attributes.Add("onclick", "enablelist(this)")

            'If (Page.IsPostBack) Then
            '    DropDownListDiagnosis.Enabled = True
            'Else
            '    DropDownListDiagnosis.Enabled = False
            'End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub




    Protected Sub GridViewSearch_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles GridViewSearch.PageIndexChanging
        Try
            Dim b As Integer = e.NewPageIndex
            search(b)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try


    End Sub


    Protected Sub ImageButtonrefresh_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonrefresh.Click
        Try
            Response.Redirect("PatientSearch.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub ImageButtonhome_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonhome.Click
        Try
            Response.Redirect(Session("mainpage"))
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub ImageButtonlogin_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles ImageButtonlogin.Click
        Try
            Session.RemoveAll()
            Response.Redirect("Login.aspx")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    'Protected Sub GridViewSearch_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles GridViewSearch.RowCommand
    '    If (e.CommandName = "Forward") Then
    '        Try
    '            HiddenFieldregno.Value = GridViewSearch.Rows(GridViewSearch.SelectedIndex).Cells(3).Text

    '            Response.Write(HiddenFieldregno.Value)
    '            'SqlDataSourcePatient.Insert()

    '            'Response.Redirect("dmcBasicMedicalInfoStages.aspx?regno=" + Session("YearlyNo")) ' Request.querystring(0))


    '        Catch ex As Exception
    '            'Label1.Text = ex.Message
    '            Response.Write(ex.Message)
    '        End Try
    '    End If
    'End Sub

    Protected Sub GridViewSearch_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridViewSearch.SelectedIndexChanged
        'Dim YearlyNo As Integer = CInt(GridViewSearch.Rows(GridViewSearch.SelectedIndex).Cells(2).Text)
        Dim Reg As String = GridViewSearch.Rows(GridViewSearch.SelectedIndex).Cells(2).Text
        'Session.Add("YearlyNo", YearlyNo)
        Session.Add("RegistrationNo", Reg)
        SqlDataSourcePatient.Insert()
        New_Visit()
        'Response.Write(Session("YearlyNo") & "" & Session("RegistrationNo"))
        Response.Redirect("PT_ASSIGN_RADIOLOGY_TESTS.aspx")
    End Sub
    Sub New_Visit()
        Try
            Dim constring As String = ConfigurationManager.ConnectionStrings("LGHConnectionString").ConnectionString
            Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
            Dim mycommand As New System.Data.SqlClient.SqlCommand("Select @Yearly = max(Payid) from payment where regNo = @RegNo)", con)
            mycommand.CommandType = Data.CommandType.Text
            ' Dim param As System.Data.SqlClient.SqlParameter
            mycommand.Parameters.AddWithValue("@RegNo", Session("RegistrationNo"))
            mycommand.Parameters.Add("@Yearly", SqlDbType.Int)
            mycommand.Parameters("@Yearly").Direction = ParameterDirection.Output
            mycommand.Connection.Open()
            mycommand.ExecuteNonQuery()
            Session.Add("YearlyNo", mycommand.Parameters("@Yearly").Value)
            mycommand.Connection.Close()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

    End Sub

    Protected Sub RadioButtonList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles RadioButtonList_Relation.SelectedIndexChanged

    End Sub
End Class




