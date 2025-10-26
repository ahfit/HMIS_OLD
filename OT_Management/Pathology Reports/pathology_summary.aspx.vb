Imports System.Data
Imports System.Data.SqlClient
Imports CrystalDecisions.CrystalReports.Engine
Imports CrystalDecisions.Shared
Partial Class Pathology_Pathology_Reports_pathology_summary
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'HiddenField_to.Value = WebDateChooser_todate.Value
        'HiddenField_from.Value = WebDateChooser_fromdate.Value
      

    End Sub

    Protected Sub Buttonshow_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Buttonshow.Click
        Test_Booking_Fill_Dataset()
    End Sub
    Sub Test_Booking_Fill_Dataset()
        Dim crdoc As New ReportDocument
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.Patient_Ot_Test_BookingTableAdapter
        Dim path As String = Server.MapPath("Test_bookingsummary_line.rpt")
        crdoc.FileName = path
        If DropDownList_Department.Text = "" Then
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_Betweendate(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value)
            Else
                da.Fill_Betweendate_GroupBy(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_TestGroup.SelectedValue)

            End If
        Else
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_BetweenDate_Dept(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue)
            Else
                da.Fill_BetweenDate_Dept_TestGroup(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue, DropDownList_TestGroup.SelectedValue)

            End If
        End If


        crdoc.Database.Tables("Patient_Ot_Test_Booking").SetDataSource(ds.Tables("Patient_Ot_Test_Booking"))
        CrystalReportViewer1.ReportSource = crdoc
        CrystalReportViewer1.DataBind()
        'Response.Write(WebDateChooser_todate.Value)
    End Sub

    Protected Sub DropDownList_TestGroup_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_TestGroup.PreRender
        If Not Page.IsPostBack Then
            DropDownList_TestGroup.Items.Insert(0, New ListItem("", ""))
        End If

    End Sub

    Protected Sub DropDownList_Department_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles DropDownList_Department.PreRender
        If Not Page.IsPostBack Then
            DropDownList_Department.Items.Insert(0, New ListItem("", ""))
        End If
    End Sub

  
    'Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
    '    Dim crdoc As New ReportDocument
    '    Dim ds As New Pt_Radiology_Test
    '    Dim da As New Pt_Radiology_TestTableAdapters.Patient_Test_BookingTableAdapter
    '    Dim path As String = Server.MapPath("Test_bookingsummary.rpt")
    '    crdoc.FileName = path
    '    If DropDownList_Department.Text = "" Then
    '        If DropDownList_TestGroup.Text = "" Then
    '            da.Fill_Betweendate(ds.Tables("Patient_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value)
    '        Else
    '            da.Fill_Betweendate_GroupBy(ds.Tables("Patient_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_TestGroup.SelectedValue)

    '        End If
    '    Else
    '        If DropDownList_TestGroup.Text = "" Then
    '            da.Fill_BetweenDate_Dept(ds.Tables("Patient_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue)
    '        Else
    '            da.Fill_BetweenDate_Dept_TestGroup(ds.Tables("Patient_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue, DropDownList_TestGroup.SelectedValue)

    '        End If
    '    End If


    '    crdoc.Database.Tables("Patient_Test_Booking").SetDataSource(ds.Tables("Patient_Test_Booking"))
    '    CrystalReportViewer1.ReportSource = crdoc
    '    CrystalReportViewer1.DataBind()
    'End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim crdoc As New ReportDocument
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.Patient_Ot_Test_BookingTableAdapter
        Dim path As String = Server.MapPath("Test_bookingsummary.rpt")
        crdoc.FileName = path
        If DropDownList_Department.Text = "" Then
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_Betweendate(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value)
            Else
                da.Fill_Betweendate_GroupBy(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_TestGroup.SelectedValue)

            End If
        Else
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_BetweenDate_Dept(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue)
            Else
                da.Fill_BetweenDate_Dept_TestGroup(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue, DropDownList_TestGroup.SelectedValue)
            End If
        End If


        crdoc.Database.Tables("Patient_Ot_Test_Booking").SetDataSource(ds.Tables("Patient_Ot_Test_Booking"))
        CrystalReportViewer1.ReportSource = crdoc
        CrystalReportViewer1.DataBind()
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim crdoc As New ReportDocument
        Dim ds As New Pt_Radiology_Test
        Dim da As New Pt_Radiology_TestTableAdapters.Patient_Ot_Test_BookingTableAdapter
        Dim path As String = Server.MapPath("Test_bookingsummary_bar.rpt")
        crdoc.FileName = path
        If DropDownList_Department.Text = "" Then
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_Betweendate(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value)
            Else
                da.Fill_Betweendate_GroupBy(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_TestGroup.SelectedValue)

            End If
        Else
            If DropDownList_TestGroup.Text = "" Then
                da.Fill_BetweenDate_Dept(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue)
            Else
                da.Fill_BetweenDate_Dept_TestGroup(ds.Tables("Patient_Ot_Test_Booking"), WebDateChooser_fromdate.Value, WebDateChooser_todate.Value, DropDownList_Department.SelectedValue, DropDownList_TestGroup.SelectedValue)

            End If
        End If


        crdoc.Database.Tables("Patient_Ot_Test_Booking").SetDataSource(ds.Tables("Patient_Ot_Test_Booking"))
        CrystalReportViewer1.ReportSource = crdoc
        CrystalReportViewer1.DataBind()
    End Sub
End Class
