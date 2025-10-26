Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Cash_Book_S_report
    Inherits System.Web.UI.Page
    Dim Enc As New Encryption
    Dim crdoc As New ReportDocument
    '' Dim conn As String = ConfigurationManager.ConnectionStrings("").ConnectionString

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            DDL_Employee.DataBind()

            DDL_Employee.SelectedValue = Request.QueryString("EID")
            DDL_Employee.Enabled = False
        End If
        cash_report()

    End Sub

    Protected Sub cash_report()
        Try




        
            Dim ds_payment_Detail As New Patient_Basic_Info
            Dim ds As New CashBook
            If Not String.IsNullOrEmpty(Request.QueryString("Edate")) Then
                SDS_report.SelectParameters("Edate").DefaultValue = Request.QueryString("Edate")
            End If
            Dim DAtaV As DataView = SDS_report.Select(DataSourceSelectArguments.Empty)

            Dim dt_record As DataTable = DAtaV.ToTable()

            Dim da1 As New CashBookTableAdapters.Room_AssignedTableAdapter
            Dim payment_detail As New Patient_Basic_InfoTableAdapters.Payment_DetailTableAdapter
            payment_detail.Fillall(ds_payment_Detail.Tables("payment_detail"))


            'da.Fill(ds.Tables("Cash_Book"), Dept_id, Subdept_id, emp_id)
            da1.Fill(ds.Tables("Room_Assigned"))
            For k As Integer = 0 To dt_record.Rows.Count - 1


                dt_record.Rows(k).Item("Prefix") = dt_record.Rows(k).Item("Prefix") + " " + Enc.Encrypt_Main(dt_record.Rows(k).Item("PFName"), False) + " " + Enc.Encrypt_Main(dt_record.Rows(k).Item("PMName"), False) + " " + Enc.Encrypt_Main(dt_record.Rows(k).Item("PLName"), False)

                If Not IsDBNull(dt_record.Rows(k).Item("Reg_No")) Then

                    dt_record.Rows(k).Item("Reg_No") = Enc.Encrypt_Main(dt_record.Rows(k).Item("Reg_No"), False)
                End If

                If IsDBNull(dt_record.Rows(k).Item("SPM_id")) Then
                    If dt_record.Rows(k).Item("Amount_Type") = "Advance" Then
                        dt_record.Rows(k).Item("SPM_id") = "Adv-" + Right("00000" + dt_record.Rows(k).Item("Adv_payment_ID"), 5)
                    ElseIf dt_record.Rows(k).Item("Amount_Type") = "Refund" Then
                        dt_record.Rows(k).Item("SPM_id") = "Ref-" + Right("00000" + dt_record.Rows(k).Item("return_payment_id"), 5)
                    End If
                End If
                ' ds.Tables("Cash_Book").Rows(k).Item("Room") = "OPD"
            Next
            For i As Integer = 0 To ds.Tables("Room_Assigned").Rows.Count - 1
                For j As Integer = 0 To dt_record.Rows.Count - 1
                    'If ds.Tables("Room_Assigned").Rows(i).Item("Yearly_No") = ds.Tables("Cash_Book").Rows(j).Item("YearlyNo") Then
                    '    ds.Tables("Cash_Book").Rows(j).Item("Room") = ds.Tables("Room_Assigned").Rows(i).Item("Room")


                    'End If
                Next
            Next

            da1.Fill(ds.Tables("Room_Assigned"))
            'da2.Fill(ds.Tables("Cardiac_Cash_Book"))
            'For k As Integer = 0 To ds.Tables("Cash_Book").Rows.Count - 1
            '    ds.Tables("Cash_Book").Rows(k).Item("Room") = "OPD"
            'Next

            Dim path As String = String.Empty
            If String.IsNullOrEmpty(Request.QueryString("AR")) Then
                path = Server.MapPath("Indoor_Cash_Book.rpt")
            Else
                path = Server.MapPath("Indoor_Cash_BookALL.rpt")
            End If

            'Dim path As String = Server.MapPath("Indoor_Cash_Book.rpt")
            crdoc.FileName = path
            Dim dt1 As DataTable = dt_record

            Dim dt2 As DataTable = ds_payment_Detail.Tables("Payment_Detail")
            crdoc.Database.Tables("Hospital_Header").SetDataSource(Session("Rpt_Header_DT"))
            crdoc.Database.Tables(0).SetDataSource(dt1)
            crdoc.Database.Tables(1).SetDataSource(dt2)
            crdoc.SetParameterValue("StartDate", Request.QueryString("dt"))
            crdoc.SetParameterValue("EndDate", Request.QueryString("EDate"))

            ' crdoc.Database.Tables("Cash_Book").SetDataSource(ds.Tables("Cash_Book"))

            CrystalReportViewer1.ReportSource = crdoc
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


    Protected Sub DDL_Employee_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles DDL_Employee.SelectedIndexChanged
        cash_report()
    End Sub
    Protected Sub getSubdept(ByVal emp_id As Integer, ByRef dept_id As Integer, ByRef subdept_id As Integer)
        Dim constring As String = ConfigurationManager.ConnectionStrings("Basic_Data_ConnectionString").ConnectionString
        Dim con As SqlConnection = New System.Data.SqlClient.SqlConnection(constring)
        Dim Procedurename As String = "select SubDeptId,DeptId from Employee where empid =" + emp_id.ToString()
        Dim mycommand As New System.Data.SqlClient.SqlCommand(Procedurename, con)
        mycommand.CommandType = Data.CommandType.Text
        mycommand.CommandText = Procedurename

        con.Open()
        Dim read As SqlDataReader = mycommand.ExecuteReader()

        While read.Read()
            dept_id = read("DeptId").ToString()
            subdept_id = read("SubDeptId").ToString()

        End While

        con.Close()

    End Sub

    Protected Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Unload
        Try

        
            crdoc.Close()
            crdoc.Dispose()
        Catch ex As Exception

        End Try
    End Sub
End Class
