Imports System.Data
Imports System.Data.SqlClient

Partial Class DoctorShare_Indoor_UnAdjusted_Payment
    Inherits System.Web.UI.Page
    ''/////////////  Declare Globle Variables //////////////
    Dim ENC As New Encryption
    Dim ds As New Doctor_Payment
    Dim _dtConsultant As DataTable
    ''//////////////////////////////////////////////////////
    Dim _SqlAdapter As SqlDataAdapter = New SqlDataAdapter()
    Dim _SqlCon As SqlConnection
    Dim _SqlCommand As SqlCommand = New SqlCommand()
    Dim _TotalDoctorShare As Double = 0
    Dim _TotalDoctorDiscount As Double = 0
    Dim _TotalShare As Double = 0
    Dim _TotalBankAmount As Double = 0
    Dim _TotalCashAmount As Double = 0
    Dim _TotalAmount As Double = 0
    Dim _TotalHospitalShare As Double = 0
    Dim _TotalHospitalDiscount As Double = 0

    Sub FillGrid()
        Try

            Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Doc_ID", DDL_Consultant.SelectedValue),
            New SqlParameter("@S_Date", Wdc_start.Value.ToString()),
            New SqlParameter("@E_Date", wdc_End_date.Value.ToString()),
            New SqlParameter("@DeptID", ddlDepartment.SelectedValue),
            New SqlParameter("@Category", DropDownListCategory.SelectedValue),
            New SqlParameter("@S_ID", DropDownListServices.SelectedValue),
            New SqlParameter("@Ptype", DropDownListP_type.SelectedValue)
             }
            GridView_General_Services.DataSource = ExecuteDataTable("GetDoctorServiceCharges", "Basic_Data_ConnectionString", sqlParams)
            GridView_General_Services.DataBind()
            If GridView_General_Services.Rows.Count > 0 Then
                Dim ckH As CheckBox = GridView_General_Services.HeaderRow.FindControl("Ck_Head")
                ckH.Checked = True
                AllRowCk(ckH.Checked)
                CalAmount()
                If GridView_General_Services.Rows.Count > 0 Then
                    btnTransfer.Visible = True
                Else
                    btnTransfer.Visible = False
                End If
            End If
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Try
            If Not Page.IsPostBack Then
                Wdc_start.Value = Date.Today
                wdc_End_date.Value = Date.Today
                PostVoucher_date.Value = Date.Today
                loadCategory()
                loadServices()
                loadDepartment()
                loadConsultantDropdown()
                GetConsultants()
                'FillGrid()
            End If

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Try
    '        For i As Integer = 0 To GridView_General_Services.Rows.Count - 1
    '            Dim textbox_amount As TextBox = GridView_General_Services.Rows(i).FindControl("TextBox_Amount_Grid")
    '            Dim hid_SH_Id As HiddenField = GridView_General_Services.Rows(i).FindControl("HiddenField_SID")
    '            Dim hid_YearlyNo As HiddenField = GridView_General_Services.Rows(i).FindControl("HiddenField_YearlyNo")
    '            Dim hid_RegNo As HiddenField = GridView_General_Services.Rows(i).FindControl("HiddenField_RegNo")
    '            Dim hid_Doctor_Id As HiddenField = GridView_General_Services.Rows(i).FindControl("HiddenField_Doctor_ID")
    '            Dim lbl_amount As Label = GridView_General_Services.Rows(i).FindControl("Label3")
    '            Dim drop_Account_head As DropDownList = GridView_General_Services.Rows(i).FindControl("ddlDoctorAcountHead")
    '            Dim drop_Consultant As DropDownList = GridView_General_Services.Rows(i).FindControl("ddlConsultant")
    '            HiddenField_Doctor_Share.Value = CInt(textbox_amount.Text)
    '            HiddenFieldRegNo.Value = hid_RegNo.Value
    '            HiddenFieldYearlyNo.Value = hid_YearlyNo.Value
    '            HiddenField_SH_Id.Value = hid_SH_Id.Value
    '            HiddenField_Doctor_ID.Value = hid_Doctor_Id.Value
    '            HiddenFieldNew_Doctor_ID.Value = drop_Consultant.SelectedValue
    '            HiddenFieldAccountHeadID.Value = drop_Account_head.SelectedValue
    '            SqlDataSourceUpdate.Update()
    '            SqlDataSourceUpdatePatientServices.Update()
    '        Next
    '        FillGrid()
    '    Catch ex As Exception
    '        'Response.Write(ex.Message)
    '    End Try
    'End Sub

    'Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
    '    Dim sb As New StringBuilder
    '    sb.Append("<script language='javascript' type='text/javascript'>window.open('Doctor_Share_Report.aspx?Dept_Id=Indoor');</script>")
    '    Dim t As Type = Me.GetType
    '    If Not ClientScript.IsClientScriptBlockRegistered(t, "popup") Then
    '        ClientScript.RegisterClientScriptBlock(t, "popup", sb.ToString())
    '    End If
    'End Sub
    Protected Sub ddlDepartment_SelectedIndexChanged(ByVal sender As Object, ByVal e As EventArgs)
        loadServices()
        loadConsultantDropdown()


    End Sub
    Private Sub loadDepartment()
        Dim sqlParams As SqlParameter() = {
        }

        ddlDepartment.DataSource = ExecuteDataTable("GetDepartments", "Basic_Data_ConnectionString", sqlParams)
        ddlDepartment.DataTextField = "Dept_Name"
        ddlDepartment.DataValueField = "Dept_ID"
        ddlDepartment.DataBind()

    End Sub
    Private Sub loadCategory()
        Dim sqlParams As SqlParameter() = {
        }

        DropDownListCategory.DataSource = ExecuteDataTable("GetCategoryForDoctorShare", "Basic_Data_ConnectionString", sqlParams)
        DropDownListCategory.DataTextField = "Asc_Name"
        DropDownListCategory.DataValueField = "Asc_id"
        DropDownListCategory.DataBind()

    End Sub
    Private Sub loadServices()
        Dim sqlParams As SqlParameter() = {
            New SqlParameter("@Cat_ID", Convert.ToString(DropDownListCategory.SelectedValue))
        }

        DropDownListServices.DataSource = ExecuteDataTable("GetServicesForDoctorShare", "Basic_Data_ConnectionString", sqlParams)
        DropDownListServices.DataTextField = "S_Name"
        DropDownListServices.DataValueField = "S_ID"
        DropDownListServices.DataBind()

    End Sub
    Protected Sub btnTransfer_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnTransfer.Click
        Try
            Dim chkSelected As New CheckBox
            Dim TransferID As Integer = DoctorShareTransfer()
            For i As Integer = 0 To GridView_General_Services.Rows.Count - 1
                chkSelected = GridView_General_Services.Rows(i).FindControl("chkSelected")
                Dim sId As New HiddenField
                Dim PsId As New HiddenField
                Dim yearlyNo As New HiddenField
                Dim regNo As New HiddenField
                Dim doctorId As New DropDownList
                Dim cashAmount As New TextBox
                Dim bankAmount As New TextBox
                Dim drop_Account_head As New DropDownList
                Dim DocDiscount As New Label
                Dim hosDiscount As New Label
                Dim hosShare As New Label
                Dim Docshare As Label
                If chkSelected.Checked Then

                    sId = GridView_General_Services.Rows(i).FindControl("HiddenField_SID")
                    PsId = GridView_General_Services.Rows(i).FindControl("HiddenField_PSID")
                    yearlyNo = GridView_General_Services.Rows(i).FindControl("HiddenField_YearlyNo")
                    regNo = GridView_General_Services.Rows(i).FindControl("HiddenField_RegNo")
                    doctorId = GridView_General_Services.Rows(i).FindControl("ddlConsultant")
                    cashAmount = GridView_General_Services.Rows(i).FindControl("txtCashAmount")
                    bankAmount = GridView_General_Services.Rows(i).FindControl("txtBankAmount")
                    drop_Account_head = GridView_General_Services.Rows(i).FindControl("ddlDoctorAcountHead")
                    hosShare = GridView_General_Services.Rows(i).FindControl("lblHospitalShare")
                    hosDiscount = GridView_General_Services.Rows(i).FindControl("lblHDiscount")
                    DocDiscount = GridView_General_Services.Rows(i).FindControl("lblDoctorDiscount")
                    Docshare = GridView_General_Services.Rows(i).FindControl("lblDoctorCharges")

                    AddDoctorShare(regNo.Value, yearlyNo.Value, doctorId.SelectedValue, PsId.Value, sId.Value, cashAmount.Text, bankAmount.Text, Session("emp_id").ToString(), hosShare.Text, hosDiscount.Text, DocDiscount.Text, Docshare.Text, TransferID)

                End If

            Next

            AddDoctorShareFinancial()
            GetConsultants()

            FillGrid()
            Dim tid As String = TransferID.ToString()
            Dim url As String
            'url = "DoctorSharePaid.aspx?CID=" + DropDownListCategory.SelectedValue + "&S=" + DropDownListServices.SelectedValue + "&PT=" + DropDownListP_type.SelectedValue + "&D=" + ddlDepartment.SelectedValue + "&CN=" + DDL_Consultant.SelectedValue + "&TD=" + PostVoucher_date.Value

            'Page.ClientScript.RegisterStartupScript(Me.GetType(), "OpenWindow", "window.open('" + url + "','_newtab');", True)

            Response.Redirect("DoctorSharePaid.aspx?CID=" + DropDownListCategory.SelectedValue + "&S=" + DropDownListServices.SelectedValue + "&PT=" + DropDownListP_type.SelectedValue + "&D=" + ddlDepartment.SelectedValue + "&CN=" + DDL_Consultant.SelectedValue + "&TD=" + PostVoucher_date.Value + "&tid=" + tid)
            ' GridView_General_Services.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
    Sub AddDoctorShare(ByVal regNo As String, ByVal yearlyNo As String, ByVal doctId As String, ByVal pSid As String, ByVal sId As String, ByVal cashAmount As String, ByVal bankAmount As String, ByVal empid As Integer, ByVal HShare As String, ByVal HDShare As String, ByVal DDShare As String, ByVal Docshare As String, ByVal TransferID As Integer)
        'Dim objDbManager As DbManager = New DbManager()
        cashAmount = If(cashAmount = "", 0, cashAmount)
        bankAmount = If(bankAmount = "", 0, bankAmount)

        If (String.IsNullOrEmpty(PostVoucher_date.Value)) Then
            PostVoucher_date.Value = DateTime.Now
        End If

        ' Dim db As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                 New SqlParameter("@RegNo", regNo),
                New SqlParameter("@YearlyNo", yearlyNo),
                 New SqlParameter("@DoctorId", doctId),
                 New SqlParameter("@PSId", pSid),
                 New SqlParameter("@SId", sId),
                 New SqlParameter("@CashAmount", cashAmount),
                 New SqlParameter("@BankAmount", bankAmount),
                 New SqlParameter("@TotalShare", Docshare),
                 New SqlParameter("DoctorDiscount", DDShare),
                 New SqlParameter("@HospitalDiscount", HDShare),
                 New SqlParameter("@HospitallShare", HShare),
                 New SqlParameter("@emp_id", empid),
                 New SqlParameter("@PostVoucher_date", PostVoucher_date.Value),
              New SqlParameter("@TransferID", TransferID)}


        ExecuteNonQuery("AddDoctorShare", "Finance_ConnectionString", sqlParams)


    End Sub
    Sub GetConsultants()
        Dim sqlParams As SqlParameter() = {
             New SqlParameter("@DeptID", ddlDepartment.SelectedValue)
         }

        _dtConsultant = ExecuteDataTable("GetConsultant", "Basic_Data_ConnectionString", sqlParams)

    End Sub
    Protected Sub GridView_General_Services_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles GridView_General_Services.RowDataBound
        If e.Row.RowType = ListItemType.Item Then


            Dim lblDoctorCharges As Label = e.Row.FindControl("lblDoctorCharges")

            Dim lblDoctorDiscount As Label = e.Row.FindControl("lblDoctorDiscount")

            Dim txtCashAmount As TextBox = e.Row.FindControl("txtCashAmount")
            Dim txtBankAmount As TextBox = e.Row.FindControl("txtBankAmount")
            Dim lblHospitalDiscount As Label = e.Row.FindControl("lblHDiscount")
            Dim lblHospitalShare As Label = e.Row.FindControl("lblHospitalShare")


            Dim lblPatName As Label = e.Row.FindControl("lblPatientName")
            Dim dr As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
            lblPatName.Text = (dr("PFName")) + " " + (dr("PMName")) + " " + (dr("PLName"))

            Dim doctorSharePercentage As String = dr("DoctorShare")
            Dim totalAmount As String = dr("amount")
            Dim bankAmountPercentage As String = dr("bankAmount")
            Dim shareMode As String = dr("mode")

            Dim doctorShareAmount As Double
            Dim doctorDiscount As Double = 0
            Dim HospitalDiscount As Double = 0
            Dim bankAmount As Double
            Dim cashAmount As Double

            If Not String.IsNullOrEmpty(lblDoctorDiscount.Text) Then
                doctorDiscount = (Double.Parse(lblDoctorDiscount.Text))
            End If

            If shareMode.ToUpper() = "P" Then
                doctorShareAmount = ((doctorSharePercentage * totalAmount) / 100)
                lblDoctorCharges.Text = doctorShareAmount.ToString("#,##")
                _TotalShare += doctorShareAmount
                If doctorDiscount > doctorShareAmount Then
                    HospitalDiscount = doctorDiscount - doctorShareAmount
                    lblDoctorDiscount.Text = doctorDiscount
                End If
                doctorShareAmount = doctorShareAmount - doctorDiscount - HospitalDiscount
                bankAmount = ((bankAmountPercentage * doctorShareAmount) / 100)


            Else
                doctorShareAmount = ((doctorSharePercentage))
                lblDoctorCharges.Text = doctorShareAmount.ToString("#,##")
                _TotalShare += doctorShareAmount
                If doctorDiscount > doctorShareAmount Then
                    HospitalDiscount = doctorDiscount - doctorShareAmount
                    doctorDiscount = doctorShareAmount
                    lblDoctorDiscount.Text = doctorDiscount
                End If
                doctorShareAmount = doctorShareAmount - doctorDiscount
                bankAmount = ((bankAmountPercentage * doctorShareAmount) / 100)
            End If

            cashAmount = doctorShareAmount - bankAmount

            Dim hospitalShare As Double = Double.Parse(totalAmount) - (doctorShareAmount + doctorDiscount + HospitalDiscount)



            txtCashAmount.Text = cashAmount.ToString("#,##")

            txtBankAmount.Text = bankAmount.ToString("#,##")
            txtBankAmount.Attributes.Add("max", bankAmount)
            txtBankAmount.Attributes.Add("tooltip", "Max value can be :" + bankAmount.ToString())

            If hospitalShare = 0 Then
                lblHospitalShare.Text = hospitalShare.ToString()
            Else
                lblHospitalShare.Text = hospitalShare.ToString("#,##")
            End If

            lblHospitalDiscount.Text = HospitalDiscount.ToString()

            Dim lblAmount As Label = e.Row.FindControl("lblDoctorCharges")

            _TotalDoctorShare += doctorShareAmount
            _TotalBankAmount += bankAmount
            _TotalCashAmount += cashAmount
            _TotalAmount += totalAmount
            _TotalHospitalShare += hospitalShare
            _TotalDoctorDiscount += doctorDiscount
            _TotalHospitalDiscount += HospitalDiscount

            Dim ddl As DropDownList = e.Row.FindControl("ddlConsultant")
            ddl.DataSource = _dtConsultant
            ddl.DataTextField = "Name"
            ddl.DataValueField = "EmpID"
            ddl.DataBind()

            ddl.SelectedValue = dr("Doctor_ID")

        End If


        If e.Row.RowType = ListItemType.Footer Then
            Dim lblTotalDoctorCharges As Label = e.Row.FindControl("lblTotalDoctorCharges")
            Dim lblTotalCashAmount As Label = e.Row.FindControl("lblTotalCashAmount")
            Dim lblTotalBankAmount As Label = e.Row.FindControl("lblTotalBankAmount")
            Dim lblTotalAmount As Label = e.Row.FindControl("lblTotalAmount")
            Dim lblTotalHospitalShare As Label = e.Row.FindControl("lblTotalHospitalShare")
            Dim lblTotalDoctorDiscount As Label = e.Row.FindControl("lblTotalDD")
            Dim lblTotalHospitalDiscount As Label = e.Row.FindControl("lblTotalHD")


            lblTotalDoctorCharges.Text = _TotalShare.ToString("#,##")
            lblTotalCashAmount.Text = _TotalCashAmount.ToString("#,##")
            lblTotalBankAmount.Text = _TotalBankAmount.ToString("#,##")
            lblTotalAmount.Text = _TotalAmount.ToString("#,##")
            lblTotalHospitalShare.Text = _TotalHospitalShare.ToString("#,##")
            lblTotalDoctorDiscount.Text = _TotalDoctorDiscount.ToString("#,##")
            lblTotalHospitalDiscount.Text = _TotalHospitalDiscount.ToString("#,##")

        End If
    End Sub
    Public Sub Openconn(ByVal connStr As String)
        Try
            Dim constr As String = ConfigurationManager.ConnectionStrings(connStr).ConnectionString
            _SqlCon = New SqlConnection(constr)
            _SqlCon.Open()
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
    Public Function ExecuteDataTable(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter()) As DataTable
        Dim _dataTable As DataTable = New DataTable()
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next


            _SqlAdapter.SelectCommand = _SqlCommand
            _SqlAdapter.Fill(_dataTable)

            _SqlCon.Close()
            _SqlCommand.Dispose()

        Catch ex As Exception
            Throw ex
        End Try

        Return _dataTable
    End Function
    Public Sub ExecuteNonQuery(ByVal ProcedureName As String, ByVal connStr As String, ByVal prms As SqlParameter())
        Try


            Openconn(connStr)

            _SqlCommand = New SqlCommand(ProcedureName, _SqlCon)
            _SqlCommand.CommandType = CommandType.StoredProcedure
            _SqlCommand.CommandText = ProcedureName
            For Each sqlParam As SqlParameter In prms
                _SqlCommand.Parameters.Add(sqlParam)
            Next

            _SqlCommand.ExecuteNonQuery()

            _SqlCon.Close()
            _SqlCommand.Dispose()



        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Sub loadConsultantDropdown()
        Dim sqlParams As SqlParameter() = {
             New SqlParameter("@DeptID", ddlDepartment.SelectedValue)
         }

        _dtConsultant = ExecuteDataTable("GetConsultantFromDutyDepartment", "Basic_Data_ConnectionString", sqlParams)

        DDL_Consultant.DataSource = _dtConsultant
        DDL_Consultant.DataTextField = "Name"
        DDL_Consultant.DataValueField = "EmpID"
        DDL_Consultant.DataBind()
        DDL_Consultant.Items.Insert(0, New ListItem("All", "0"))
    End Sub

    Protected Sub Btn_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Btn_Search.Click
        GetConsultants()
        FillGrid()

    End Sub

    Protected Sub Ck_Head_CheckedChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim CK_H As CheckBox = sender
        AllRowCk(CK_H.Checked)
        CalAmount()
    End Sub
    Sub AddDoctorShareFinancial()
        'Dim objDbManager As DbManager = New DbManager()


        ' Dim db As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
                    New SqlParameter("@By_Emp_Id", Convert.ToString(Session("emp_id"))),
                    New SqlParameter("@SubDept_Id", Convert.ToInt16(Session("subdeptid"))),
                    New SqlParameter("@Dept_Id", Convert.ToInt16(Session("dept_id"))),
                    New SqlParameter("@PDate", Convert.ToDateTime(PostVoucher_date.Value))
}

        ExecuteNonQuery("JV_Doctor_Share", "Finance_ConnectionString", sqlParams)

    End Sub



    Private Function DoctorShareTransfer() As Integer
        Dim con As SqlConnection = New SqlConnection(ConfigurationManager.ConnectionStrings("Finance_ConnectionString").ConnectionString)
        con.Open()

        Dim cmd As SqlCommand = New SqlCommand("Usp_AddDoctorShareTransfer", con)
        cmd.CommandType = CommandType.StoredProcedure
        cmd.Parameters.AddWithValue("@Empid", (Session("emp_id")))
        cmd.Parameters.AddWithValue("@Amount", lbl_Tamount.Text.Replace(",", String.Empty))
        cmd.Parameters.Add("@status", SqlDbType.Int)
        cmd.Parameters("@status").Direction = ParameterDirection.Output
        cmd.ExecuteNonQuery()
        Dim value As Integer = cmd.Parameters("@status").Value
        con.Close()
        Return value
    End Function



    Private Sub AllRowCk(C As Boolean)
        Dim ck As New CheckBox
        For Each row As GridViewRow In GridView_General_Services.Rows
            ck = row.FindControl("chkSelected")
            ck.Checked = C
        Next
    End Sub
    Private Sub CalAmount()
        Dim amount As Double = 0
        If GridView_General_Services.Rows.Count > 0 Then
            Dim ck As New CheckBox
            Dim txt_amount As New TextBox

            For Each row As GridViewRow In GridView_General_Services.Rows
                ck = row.FindControl("chkSelected")
                If ck.Checked Then
                    txt_amount = row.FindControl("txtBankAmount")
                    If Not String.IsNullOrEmpty(txt_amount.Text.Trim()) Then
                        amount += CDbl(txt_amount.Text.Trim())
                    End If
                End If
            Next
            If amount = 0 Then
                lbl_Tamount.Text = amount.ToString()
            Else
                lbl_Tamount.Text = amount.ToString("#,##")
            End If

        End If
    End Sub

    Protected Sub chkSelected_CheckedChanged(sender As Object, e As EventArgs)
        CalAmount()
    End Sub

   

End Class


