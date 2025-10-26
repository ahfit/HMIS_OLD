Imports System.Data.SqlClient
Imports System.Data

Partial Class PayRoll_Emplooyee_Monthly_Salary
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not String.IsNullOrEmpty(Request.QueryString("employee")) Then
                LBL_Name.Text = CStr(Request.QueryString("employee"))
            End If
            If Not String.IsNullOrEmpty(Request.QueryString("month")) Then
                LBL_Month.Text = CStr(Request.QueryString("month"))
            End If
            If Not String.IsNullOrEmpty(Request.QueryString("year")) Then
                LBL_Year.Text = CStr(Request.QueryString("year"))
            End If
            CheckSalMade()
            GetSalaryDays()
            GVD_Allowance.DataBind()
            GVD_Deduction.DataBind()


        End If
    End Sub

    Protected Sub GetSalaryDays()
        Dim manager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpId", Request.QueryString("emp_ID")),
        New SqlParameter("@Month", Request.QueryString("month")),
        New SqlParameter("@Year", Request.QueryString("year"))
        }

        Dim dt As DataTable = manager.ExecuteDataTableWithQuery("select SalaryDays,MonthDays from EmployeeSalaryCalculation  where SalaryMonth = @Month and SalaryYear = @Year and EmpId = @EmpId", "PayRoll_ConnectionString", sqlParams)

        If dt.Rows.Count > 0 Then
            lblSalaryDays.Text = dt.Rows(0)("SalaryDays").ToString()
            lblMonthDays.Text = dt.Rows(0)("MonthDays").ToString()
        End If

    End Sub

    Protected Sub CheckSalMade()
        Dim manager As DbManager = New DbManager()

        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpId", Request.QueryString("emp_ID")),
        New SqlParameter("@Month", Request.QueryString("month")),
        New SqlParameter("@Year", Request.QueryString("year"))
        }

        Dim dt As DataTable = manager.ExecuteDataTable("CheckSalaryMade", "PayRoll_ConnectionString", sqlParams)

        If dt.Rows.Count > 0 Then
            HfSalMade.Value = "True"
            If dt.Rows(0)("Is_Approve") = True Then
                HfSalMade.Value = "False"
                HfSalApproved.Value = "Approved"
            Else
                bntUpdate.Visible = True
            End If
        End If



    End Sub
    'Protected Sub BTN_save_Click(sender As Object, e As EventArgs) Handles BTN_save.Click
    '    Dim Data As String = "<data>"
    '    Dim Salary_ID As String = Request.QueryString("emp_id") + "-" + Right("00" + Request.QueryString("month"), 2) + "-" + Request.QueryString("year")
    '    Data = Data + getdata(GVD_Allowance, 2)
    '    Data = Data + getdata(GVD_Deduction, 1)
    '    Data = Data + "</data>"

    '    If Data <> "<data></data>" Then
    '        SDS_Save.InsertParameters("Salary_id").DefaultValue = Salary_ID
    '        SDS_Save.InsertParameters("data").DefaultValue = Data
    '        SDS_Save.Insert()
    '        lbl_Message.Text = "Salary Saved ..."
    '    Else
    '        lbl_Message.Text = "Please select atleast one Allowance or Deduction ..."
    '    End If


    'End Sub
    Protected Function getdata(ByVal gv As GridView, ByVal cr_dr As String) As String
        Dim record As String = ""
        Dim txt_amount As New TextBox()
        Dim hfd_e_id As New HiddenField()
        For Each row As GridViewRow In gv.Rows

            txt_amount = row.FindControl("TXT_Amount")
            If txt_amount.Enabled = True Then

                hfd_e_id = row.FindControl("HFD_E_ID")
                record = record + "<row><E_ID>" + hfd_e_id.Value + "</E_ID><Amount>" + txt_amount.Text.Trim() + "</Amount><Cr_Dr>" + cr_dr + "</Cr_Dr></row>"

            End If


        Next

        Return record
    End Function
    Dim TotalAllowance As Decimal = 0
    Dim TotalDeduction As Decimal = 0
    Dim OTotalAllowance As Decimal = 0
    Dim OTotalDeduction As Decimal = 0
    Protected Sub GVD_Allowance_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then

            Dim lblAmount As TextBox = DirectCast(e.Row.FindControl("TXT_Amount"), TextBox)
            If Not IsDBNull(lblAmount.Text) And lblAmount.Text <> "" And lblAmount.Text.Trim() <> "0" Then

                TotalAllowance = TotalAllowance + Convert.ToDecimal(lblAmount.Text.Trim())

            End If
            Dim lblOAmount As TextBox = DirectCast(e.Row.FindControl("TXT_OAmount"), TextBox)
            If Not IsDBNull(lblOAmount.Text) And lblOAmount.Text <> "" And lblOAmount.Text.Trim() <> "0" Then

                OTotalAllowance = OTotalAllowance + Convert.ToDecimal(lblOAmount.Text.Trim())

            End If


            If lblAmount.Text <> "" And lblAmount.Text.Trim() <> "0" And HfSalMade.Value = "True" And HfSalApproved.Value = "False" Then
                lblAmount.Enabled = False
            End If

        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            Dim lblTotal As Label = DirectCast(e.Row.FindControl("lblTotalAllowances"), Label)
            lblTotal.Text = TotalAllowance.ToString()
            Dim lblTotalOAmount As Label = DirectCast(e.Row.FindControl("lblTotalOAmount"), Label)
            lblTotalOAmount.Text = OTotalAllowance.ToString()
        End If

    End Sub
    Protected Sub GVD_Deduction_RowDataBound(sender As Object, e As GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblAmount As TextBox = DirectCast(e.Row.FindControl("txt_Amount"), TextBox)
            If Not IsDBNull(lblAmount.Text) And lblAmount.Text <> "" And lblAmount.Text.Trim() <> "0" Then
                TotalDeduction = TotalDeduction + Convert.ToDecimal(lblAmount.Text.Trim())

            End If
            

            If lblAmount.Text <> "" And lblAmount.Text.Trim() <> "0" And HfSalMade.Value = "True" And HfSalApproved.Value = "False" Then
                lblAmount.Enabled = False
            End If

            If Not IsDBNull(lblAmount.Text) And lblAmount.Text <> "" And lblAmount.Text.Trim() <> "0" And HfSalMade.Value = "True" And HfSalApproved.Value = "False" Then
                lblAmount.Enabled = False
            End If
            Dim lblOAmount As TextBox = DirectCast(e.Row.FindControl("TXT_OAmount"), TextBox)
            If Not IsDBNull(lblOAmount.Text) And lblOAmount.Text <> "" And lblOAmount.Text.Trim() <> "0" Then

                OTotalDeduction = OTotalDeduction + Convert.ToDecimal(lblOAmount.Text.Trim())

            End If

        End If

        If e.Row.RowType = DataControlRowType.Footer Then
            Dim lblTotal As Label = DirectCast(e.Row.FindControl("lblTotalDeduction"), Label)
            lblTotal.Text = TotalDeduction.ToString()
            Dim lblTotalOAmount As Label = DirectCast(e.Row.FindControl("lblTotalOAmount"), Label)
            lblTotalOAmount.Text = OTotalDeduction.ToString()
        End If
    End Sub

    Protected Sub bntUpdate_Click(sender As Object, e As EventArgs)
        Try

            Dim Data As String = "<data>"
            Data = Data + getdata(GVD_Allowance, 2)
            Data = Data + getdata(GVD_Deduction, 1)
            Data = Data + "</data>"

            sqlUpdate.UpdateParameters("data").DefaultValue = Data
            sqlUpdate.Update()
            lbl_Message.Text = "Updated Successfully!"

        Catch ex As Exception
            lbl_Message.Text = "Some error occurred!"
        End Try




    End Sub
    Protected Sub lnkRevertAllowance_Click(sender As Object, e As EventArgs)
        Dim lnk As LinkButton = DirectCast(sender, LinkButton)
        Dim db As DbManager = New DbManager()
        Dim sqlParams As SqlParameter() = {
        New SqlParameter("@EmpId", Request.QueryString("emp_ID")),
        New SqlParameter("@E_Id", Convert.ToInt32(lnk.CommandArgument)),
        New SqlParameter("@Month", Request.QueryString("month")),
        New SqlParameter("@Year", Request.QueryString("year")),
        New SqlParameter("@RevertBy", Session("emp_id")),
        New SqlParameter("@Type", lnk.CommandName),
        New SqlParameter("@SalaryMade", HfSalMade.Value)
        }

        db.ExecuteNonQuery("usp_RevertHeadAmount", "PayRoll_ConnectionString", sqlParams)

        GVD_Allowance.DataBind()
        GVD_Deduction.DataBind()

    End Sub
End Class
