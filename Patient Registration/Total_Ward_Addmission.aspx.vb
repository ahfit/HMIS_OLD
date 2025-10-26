Imports System.IO

Partial Class Omer_Reports_TotalWardAddmission
    Inherits System.Web.UI.Page
    Dim enc As New Encryption
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button1.Click
        Try
            Dim strMonth_start As String = ""
            Dim strMonth_end As String = ""
            If Month(WebDateChooserStart.Value) < 10 Then
                strMonth_start = "0" & Month(WebDateChooserStart.Value).ToString
            Else
                strMonth_start = Month(WebDateChooserStart.Value).ToString
            End If

            If Month(WebDateChooserEnd.Value) < 10 Then
                strMonth_end = "0" & Month(WebDateChooserEnd.Value).ToString
            Else
                strMonth_end = Month(WebDateChooserEnd.Value).ToString
            End If

            HiddenFieldStartDate.Value = Year(WebDateChooserStart.Value).ToString & "-" & strMonth_start & "-" & Day(WebDateChooserStart.Value).ToString & " 00:00:00.000"
            HiddenFieldEndDate.Value = Year(WebDateChooserEnd.Value).ToString & "-" & strMonth_end & "-" & Day(WebDateChooserEnd.Value).ToString & " 00:00:00.000"
            Dim da As New Patient_Bed_AssignedTableAdapters.WardAddmissionNewTableAdapter

            Dim ds As New Patient_Bed_Assigned
            da.Fill(ds.Tables("WardAddmissionNew"), HiddenFieldStartDate.Value, HiddenFieldEndDate.Value)
            For i As Integer = 0 To ds.Tables("WardAddmissionNew").Rows.Count - 1
                ds.Tables("WardAddmissionNew").Rows(i).Item(3) = enc.Encrypt_Main(ds.Tables("WardAddmissionNew").Rows(i).Item(3), False)
                ds.Tables("WardAddmissionNew").Rows(i).Item(4) = enc.Encrypt_Main(ds.Tables("WardAddmissionNew").Rows(i).Item(4), False)
                ds.Tables("WardAddmissionNew").Rows(i).Item(5) = enc.Encrypt_Main(ds.Tables("WardAddmissionNew").Rows(i).Item(5), False)
                ds.Tables("WardAddmissionNew").Rows(i).Item("RegNo") = enc.Encrypt_Main(ds.Tables("WardAddmissionNew").Rows(i).Item("RegNo"), False)
                ds.Tables("WardAddmissionNew").Rows(i).Item("Sr.No.") = i + 1
            Next
            GridView1.DataSource = ds.Tables("WardAddmissionNew")
            GridView1.DataBind()
            lblTotalRecords.Text = "Total Admissions : " + GridView1.Rows.Count.ToString()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    Protected Sub GridView1_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.PreRender
        If GridView1.Rows.Count <> 0 Then
            'GridView1.HeaderRow.Cells(2).Text = "Patient Name"
            'GridView1.HeaderRow.Cells(3).Text = "File No."
            'GridView1.HeaderRow.Cells(4).Visible = False
            GridView1.HeaderRow.Cells(2).Visible = False
            GridView1.HeaderRow.Cells(3).Visible = False
            GridView1.HeaderRow.Cells(4).Visible = False
            For i As Integer = 0 To GridView1.Rows.Count - 1
                GridView1.Rows(i).Cells(5).Text = GridView1.Rows(i).Cells(2).Text + " " + GridView1.Rows(i).Cells(3).Text + " " + GridView1.Rows(i).Cells(4).Text + " " + GridView1.Rows(i).Cells(5).Text
                GridView1.Rows(i).Cells(2).Visible = False
                GridView1.Rows(i).Cells(3).Visible = False
                GridView1.Rows(i).Cells(4).Visible = False
                'GridView1.Rows(i).Cells(11).Visible = False
            Next
        End If
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            WebDateChooserStart.Value = Date.Now
            WebDateChooserEnd.Value = Date.Now 'DateAdd(DateInterval.Day, 1, Date.Now)
        End If
    End Sub

    Protected Sub Button_export_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles Button_export.Click
        ShowAllComplaints()
    End Sub
    Private Sub ShowAllComplaints()
        Dim fileName As String = "Admitted Patient" & ".xls"
        Response.ClearContent()
        Response.AddHeader("content-disposition", "attachment;filename=" & fileName)
        Response.ContentType = "application/excel"
        Dim sw As New StringWriter()
        Dim htm As New HtmlTextWriter(sw)
        Dim repAllCustomers As GridView = Me.GridView1
        repAllCustomers.AllowPaging = False
        'repAllCustomers.DataBind()
        repAllCustomers.CssClass = "grid_dash"
        'repAllCustomers.Columns(0).Visible = false;
        'repAllCustomers.Columns(1).Visible = false;
        repAllCustomers.RenderControl(htm)
        Response.Write(sw.ToString())
        Response.[End]()
        'HF_is_Report.Value = "0";
    End Sub
    Public Overrides Sub VerifyRenderingInServerForm(ByVal control As Control)
        'base.VerifyRenderingInServerForm(control);
    End Sub

End Class
