Imports CrystalDecisions.Shared
Imports CrystalDecisions.CrystalReports.Engine


Partial Class PayRoll_Attendance_report
    Inherits System.Web.UI.Page
    Dim report As New ReportDocument()

    Protected Sub Button_Search_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_Search.Click
        ShowRpt()
    End Sub
    Protected Sub ShowRpt()





        'Dim ds As New EmployeeSalaries()
        'Dim da As New EmployeeSalariesTableAdapters.Search_Attendence_DetailTableAdapter()
        Dim i As Integer = 0
        Try
            i = Convert.ToInt16(Dropdownlistdepartment.SelectedValue)
        Catch ex As Exception
            i = 0
        End Try
        SDS_Report.SelectParameters("Department").DefaultValue = i

        If ck_my_emp.Checked Then
            SDS_Report.SelectParameters("admin_id").DefaultValue = Session("emp_id")
        Else
            SDS_Report.SelectParameters("admin_id").DefaultValue = 0
        End If

        Dim ds As System.Data.DataView = SDS_Report.Select(DataSourceSelectArguments.Empty)

        'da.Fill_All(ds.Search_Attendence_Detail, Convert.ToInt16(DropDownList_Month.SelectedValue), Convert.ToInt16(DropDownList_year.SelectedValue), i, txt_employee.Text.Trim())

        Dim path As String = Server.MapPath("Attendance_report.rpt")
        report.FileName = path
        report.Database.Tables("Search_Attendence_Detail").SetDataSource(ds.Table)
        report.SetParameterValue("Hospital_Name", dropdownlist_Hospital.SelectedItem.Text.ToString() + "( " + DropDownList_Month.SelectedItem.Text.ToString() + "-" + DropDownList_year.SelectedItem.Text.ToString() + ")")

        CrystalReportViewer1.ReportSource = report
        CrystalReportViewer1.DataBind()

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub
    Protected Sub Page_PreLoad(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.PreLoad
        If Not IsPostBack Then
            dropdownlist_Hospital.DataBind()
            DropDownList_year.Items.Clear()
            DropDownList_Month.SelectedValue = Date.Today.Month


            Dim count As Integer = 0
            For count = 0 To ((Date.Today.Year + 5) - 2011)
                DropDownList_year.Items.Insert(count, 2011 + count)
            Next
            DropDownList_year.SelectedValue = Date.Today.Year
        End If
        ShowRpt()
    End Sub

    Protected Sub Dropdownlistdepartment_DataBound(ByVal sender As Object, ByVal e As System.EventArgs) Handles Dropdownlistdepartment.DataBound
        Dropdownlistdepartment.Items.Insert(0, "All")
        Dropdownlistdepartment.Items(0).Value = "0"
    End Sub

End Class
