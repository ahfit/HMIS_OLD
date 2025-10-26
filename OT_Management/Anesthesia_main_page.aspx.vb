Imports System.Data
Imports System.Data.SqlClient

Partial Class Anesthesia_main_page
    Inherits System.Web.UI.Page

    'Dim obj1 As New GenerateXML
    Dim ENC As New Encryption
    Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString

    Dim Pt_Reg_No As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load


    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Fill_DataList(0)
    End Sub
    Sub Fill_DataList(ByVal subDept As Integer)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
            Dim con As SqlConnection = New SqlConnection(constr)
            Dim command As SqlCommand = New SqlCommand("Select_Patient_For_Main_Page_OT", con)
            command.CommandType = CommandType.StoredProcedure
            command.Parameters.AddWithValue("@DoctorID", Session("Emp_Id"))
            If TextBoxPFName.Text = "" Then
                command.Parameters.AddWithValue("@PFName", "%")
            Else
                command.Parameters.AddWithValue("@PFName", ENC.Encrypt_Main(ENC.TitleCase(TextBoxPFName.Text), True))
            End If

            If TextBoxRegNo.Text = "" Then
                command.Parameters.AddWithValue("@RegNo", "%")
            Else
                command.Parameters.AddWithValue("@RegNo", ENC.Encrypt_Main(TextBoxRegNo.Text, True))
            End If

            If TextBoxYearlyNo.Text = "" Then
                command.Parameters.AddWithValue("@yearlyNo", 0)
            Else
                command.Parameters.AddWithValue("@yearlyNo", TextBoxYearlyNo.Text)
            End If
            command.Parameters.AddWithValue("@Deptid", DropDownListDept.SelectedValue)
            command.Parameters.AddWithValue("@request_type_id", 1)
            command.Parameters.AddWithValue("@SubDept_id", subDept)
            command.Parameters.AddWithValue("@Hospital_Id", Session("HospitalID"))

            con.Open()
            Dim da As New SqlDataAdapter
            Dim ds As New DataSet
            da.SelectCommand = command
            da.Fill(ds, "PatientDataList")
            DataList1.DataSource = ds.Tables(0)
            DataList1.DataBind()
        Catch ex As Exception

        End Try
    End Sub
    Protected Sub DropDownListDept_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.PreRender
        If Not Page.IsPostBack Then
            DropDownListDept.Items.Insert(0, New ListItem("All", 0))
            DropDownListDept.SelectedValue = Session("dept_id")
            DataList1.DataBind()
            DataListSubDepartment.DataBind()
        End If
    End Sub

    Protected Sub DataList1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.PreRender
        For i As Integer = 0 To DataList1.Items.Count - 1
            Dim lnkName As LinkButton = DataList1.Items(i).FindControl("LinkButtonName")
            Dim lblprfix As Label = DataList1.Items(i).FindControl("PrefixLabel")
            Dim lblPFName As Label = DataList1.Items(i).FindControl("PFNameLabel")
            Dim lblPMName As Label = DataList1.Items(i).FindControl("PMNameLabel")
            Dim lblPLName As Label = DataList1.Items(i).FindControl("PLNameLabel")
            Dim lblRegNo As Label = DataList1.Items(i).FindControl("LabelRegNo")
            lnkName.Text = lblprfix.Text + " " + ENC.Encrypt_Main(lblPFName.Text, False) + " " + ENC.Encrypt_Main(lblPMName.Text, False) + " " + ENC.Encrypt_Main(lblPLName.Text, False)
            lblRegNo.Text = ENC.Encrypt_Main(lblRegNo.Text, False)
        Next
    End Sub

    Protected Sub DataList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataList1.SelectedIndexChanged
        Label3.Text = "select"
        Dim lblregno As HiddenField = DataList1.Items(DataList1.SelectedIndex).FindControl("HiddenField_reg_no")
        Dim lblpayid As HiddenField = DataList1.Items(DataList1.SelectedIndex).FindControl("HiddenField_pay_ID")




        Session.Add("PayId", lblpayid.Value) 'change 1/2..session keep the payid to pdate the status of payment table..
        Session.Add("registrationno", lblregno.Value)
        'Dim a As String
        'a = visit(lblregno.Value)
        Session.Add("yearlyno", lblpayid.Value)
        '  Response.Write(Session("PatientComplaint") + "dsfbsdbs")
        'Session.Add("PatientComplaint", "1")
    
        Response.Redirect("pt_AssignRadiology_tests.aspx?RegNo=" + lblregno.Value)
        ' Me.Parent.ref()
        ' Response.Redirect("PatientBasicInfo_Iframe.aspx")
        'Page.ClientScript.RegisterStartupScript(Me.GetType(), "refresh", "var url = window.opener.location.href; window.opener.location.href = url;", True)

    End Sub

    Protected Sub DataListSubDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DataListSubDepartment.SelectedIndexChanged
        Fill_DataList(DataListSubDepartment.SelectedValue)
        DataList1.Visible = True
        Panel_App.Visible = False
    End Sub



    Protected Sub DropDownListDept_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownListDept.SelectedIndexChanged
        Fill_DataList(0)
    End Sub

    Protected Sub LinkButton_Private_Patient_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles LinkButton_Private_Patient.Click
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("SELECT ISNULL(Patient.Prefix, '') AS Prefix, ISNULL(Patient.PFName, '') AS PFName, ISNULL(Patient.PMName, '') AS PMName, ISNULL(Patient.PLName, '') AS PLName, Patient.Age, Patient.AgeType, CONVERT(varchar, Patient.DateOfBirth, 107) AS DateOfBirth, Gender.Gender, Payment.Diagonosis, Payment.RegNo, Payment.PayID, dbo.Function_Bed_No(Payment.RegNo, Payment.PayID) AS BedNo FROM         Patient INNER JOIN Payment ON Patient.RegNo = Payment.RegNo INNER JOIN Gender ON Patient.SexID = Gender.Gender_ID where Payment.DoctorID=@DoctorID  AND Payment.DeptID=69", con)
        command.Parameters.AddWithValue("@DoctorID", Session("emp_id"))
        con.Open()
        Dim da As New SqlDataAdapter
        Dim ds As New DataSet
        da.SelectCommand = command
        da.Fill(ds, "PatientDataList")
        DataList1.DataSource = ds.Tables(0)
        DataList1.DataBind()
        DataList1.Visible = True
        Panel_App.Visible = False

    End Sub






    Function visit(ByVal regno As String) As String
        Dim constr As String = ConfigurationManager.ConnectionStrings("Reg_ConnectionString").ConnectionString
        Dim con As SqlConnection = New SqlConnection(constr)
        Dim command As SqlCommand = New SqlCommand("select Max(Payment.PayID) from Payment where Payment.RegNo =@Reg_no", con)
        command.Parameters.AddWithValue("@Reg_no", regno)
        con.Open()
        Return command.ExecuteScalar
        con.Close()
    End Function



End Class

