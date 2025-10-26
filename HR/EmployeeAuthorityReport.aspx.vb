Imports System.Data
Imports System.Data.SqlClient
Imports iTextSharp.text.pd
Imports iTextSharp.text
Imports System.IO
Imports System.Text
Imports System.Drawing.Printing
Imports System.Drawing.Imaging

Partial Class HR_EmployeeAuthorityReport
    Inherits System.Web.UI.Page

    Dim conString As String = ConfigurationManager.ConnectionStrings("HRConnectionString").ConnectionString
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not Page.IsPostBack Then

            'DDLMonth.SelectedValue = DateTime.Now.Month

            'DDLYear.SelectedValue = DateTime.Now.Year

            'DDL_Company.DataBind()
            'DDL_Company.SelectedValue = Session("Hospital_Id")
            'DDL_Branch.DataBind()
            'DDL_Branch.SelectedValue = Session("Dept_Id")
            'DDL_Sold_By.DataBind()
            'DDL_Sold_By.SelectedValue = Session("emp_id")

            'DDL_Company.Enabled = False
            'DDL_Branch.Enabled = False
            'DDL_Sold_By.Enabled = False
            'ShowReport()
        End If

    End Sub


    Private Sub ShowReport()
        Dim cmd As SqlCommand
        Dim con As SqlConnection = New SqlConnection(conString)
        Try
            con.Open()
            cmd = New SqlCommand("usp_GetEmployeeApprovalAuthoritiesReport", con)
            cmd.CommandType = CommandType.StoredProcedure

            'Dim dateFrom As String = Convert.ToDateTime(WebDateChooser_Start_Date.Value).ToString("yyyy/MM/dd")
            'Dim dateTo As String = Convert.ToDateTime(WebDateChooser_end_Date.Value).ToString("yyyy/MM/dd")
            cmd.Parameters.AddWithValue("@SubDeptId", DDL_Branch.SelectedValue)
            cmd.Parameters.AddWithValue("@ApprovalId", DDLReportingAuthortiy.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpDeptId", DDL_EmpDept.SelectedValue)
            cmd.Parameters.AddWithValue("@EmpID", DDL_Sold_By.SelectedValue)
            cmd.Parameters.AddWithValue("@LevelId", ddlLevels.SelectedValue)
            cmd.Parameters.AddWithValue("@CategoryId", ddlCategory.SelectedValue)

            Dim da As SqlDataAdapter = New SqlDataAdapter(cmd)
            Dim dt As DataTable = New DataTable()
            da.Fill(dt)
            ReportViewer1.LocalReport.ReportPath = Server.MapPath("EmployeeAuthorityReport.rdlc")
            ReportViewer1.LocalReport.DataSources.Clear()
            Dim repParams As ReportParameter() = New ReportParameter(0) {}
            repParams(0) = New ReportParameter("Level", ddlLevels.SelectedItem.Text)
            'repParams(1) = New ReportParameter("DeptName", DDL_Branch.SelectedItem.ToString())
            'repParams(2) = New ReportParameter("FromDate", HiddenField_Start_Date.Value.ToString())
            'repParams(3) = New ReportParameter("ToDate", HiddenField_end_Date.Value.ToString())
            Dim repDs As ReportDataSource = New ReportDataSource()

            repDs.Name = "DataSet1"
            repDs.Value = dt
            ReportViewer1.LocalReport.DataSources.Add(repDs)

            AddHandler Me.ReportViewer1.LocalReport.SubreportProcessing, AddressOf subReports
            ReportViewer1.LocalReport.SetParameters(repParams)
            'If Request.Browser.Browser = "Chrome" Then
            'Dim bytes As [Byte]() = ReportViewer1.LocalReport.Render("PDF")
            'Response.AddHeader("Content-Disposition", "inline; filename=MyReport.pdf")
            'Response.ContentType = "application/pdf"
            'Response.BinaryWrite(bytes)
            'Response.[End]()
            'Else

            ReportViewer1.Visible = True
            'End If
            con.Close()
        Catch ex As Exception
            con.Close()
            Response.Write(ex.Message)
        End Try


    End Sub



    Public Sub subReports(sender As Object, e As SubreportProcessingEventArgs)
        Try
            e.DataSources.Clear()
            Dim dt As DataTable = DirectCast(Session("DynamicHeader"), DataTable)
            e.DataSources.Add(New ReportDataSource("DataSet1", dt))
            e.DataSources.Add(New ReportDataSource("DataSetFooter", dt))

        Catch generatedExceptionName As Exception
        End Try


    End Sub


    Protected Sub btn_Report_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btn_Report.Click
        'HiddenField_Start_Date.Value = WebDateChooser_Start_Date.Value
        'HiddenField_end_Date.Value = WebDateChooser_end_Date.Value
        'If String.IsNullOrEmpty(TextBox_Emp.Text.Trim()) Then
        '    HiddenField_empNo.Value = "%"
        'Else
        '    HiddenField_empNo.Value = TextBox_Emp.Text.Trim()

        'End If
        ShowReport()
        ''btnPrint_Click(sender, e)
    End Sub

    Private Sub ReportParameter()
        Throw New NotImplementedException
    End Sub

    Private Sub repParams()
        Throw New NotImplementedException
    End Sub
    Protected Sub btnPrint_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Dim warnings() As Warning
        'Dim streamids() As String
        'Dim mimeType As String
        'Dim encoding As String
        'Dim extension As String
        'Dim bytes() As Byte = ReportViewer1.LocalReport.Render("PDF", Nothing, mimeType, encoding, extension, streamids, warnings)
        'Dim fileName As String = ("PersonalLateLate_output_" + (Session("emp_id").ToString + ".pdf"))
        'Dim fileName2 As String = ("PersonalLateLate_Print_" + (Session("emp_id").ToString + ".pdf"))
        'deleteFile(fileName)
        'deleteFile(fileName2)
        'Dim fs As FileStream = New FileStream(HttpContext.Current.Server.MapPath(fileName), FileMode.Create)
        'fs.Write(bytes, 0, bytes.Length)
        'fs.Close()
        ''Open existing PDF
        'Dim document As Document = New Document(iTextSharp.text.PageSize.A4)
        ''document.SetPageSize(iTextSharp.text.PageSize.LETTER.Rotate());
        'Dim reader As PdfReader = New PdfReader(HttpContext.Current.Server.MapPath(fileName))
        ''Getting a instance of new PDF writer
        'Dim writer As PdfWriter = PdfWriter.GetInstance(document, New FileStream(HttpContext.Current.Server.MapPath(fileName2), FileMode.Create))
        'document.Open()
        'Dim cb As PdfContentByte = writer.DirectContent
        'Dim i As Integer = 0
        'Dim p As Integer = 0
        'Dim n As Integer = reader.NumberOfPages
        'Dim psize As Rectangle = reader.GetPageSize(1)
        'Dim width As Single = psize.Width
        'Dim height As Single = psize.Height
        ''Add Page to new document

        'While (i < n)
        '    document.NewPage()
        '    p = (p + 1)
        '    i = (i + 1)
        '    Dim page1 As PdfImportedPage = writer.GetImportedPage(reader, i)
        '    cb.AddTemplate(page1, 0, 0)

        'End While

        ''Attach javascript to the document
        'Dim jAction As PdfAction = PdfAction.JavaScript("this.print(true);" & vbCr, writer)
        'writer.AddJavaScript(jAction)
        'document.Dispose()
        'document.Close()
        ''Attach pdf to the iframe
        'frmPrint.Attributes("src") = fileName2
    End Sub

    Private Sub deleteFile(ByVal fileName As String)
        If System.IO.Directory.Exists(fileName) Then
            Try
                System.IO.Directory.Delete(fileName, True)
                'Response.Write("file deleted");
            Catch ex As System.IO.IOException
                Response.Write(ex.Message)
            End Try

        End If

    End Sub

End Class
